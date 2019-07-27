/*
 * VoIPApp.cc
 *
 *  Created on: May 28, 2019
 *      Author: Yevhenii Shudrenko
 */


#include "VoIPApp.h"
#include "inet/common/TagBase_m.h"
#include "inet/common/TimeTag_m.h"
#include "inet/applications/base/ApplicationPacket_m.h"

Define_Module(VoIPApp);

void VoIPApp::initialize(int stage)
{

    ApplicationBase::initialize(stage);

    if (stage == inet::INITSTAGE_LOCAL) {
        packetDelayedSignal = registerSignal("packetDelayed");
        numSent = 0;
        numReceived = 0;
        numDelayed = 0;

        localPort = par("localPort");
        destPort = par("destPort");
        startTime = par("startTime");
        stopTime = par("stopTime");
        packetName = par("packetName");
        dontFragment = par("dontFragment");
//        if (stopTime >= SIMTIME_ZERO && stopTime < startTime)
//            throw cRuntimeError("Invalid startTime/stopTime parameters");
        selfMsg = new inet::cMessage("sendTimer");
    }
}

void VoIPApp::processPacket(inet::Packet *pk)
{
    auto data = pk->peekData(); // get all data from the packet
    auto packet_regions = data->getAllTags<inet::CreationTimeTag>(); // get all tag regions
    auto creationTime = packet_regions[0].getTag()->getCreationTime();
    auto delay = inet::simTime() - creationTime; // compute delay
    // check if packet's delay is > 200ms(default threshold)
    if (delay.dbl() > par("maxDelay").doubleValue()) {
        numDelayed++;
        emit(packetDelayedSignal, delay);
    }

    emit(inet::packetReceivedSignal, pk);
    delete pk;
    numReceived++;
}







