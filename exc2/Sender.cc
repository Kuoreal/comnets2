#include <stdio.h>
#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;

class Sender: public cSimpleModule {
private:
    cMessage *event;
    int counter;

protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual void sendMessage();
};

Define_Module(Sender);

void Sender::initialize() {
    counter = 0;
    WATCH(counter);
    event = new cMessage("event");
    sendMessage();
}

void Sender::handleMessage(cMessage *msg) {
    if (msg->isSelfMessage()) {
        sendMessage();
    }
}

void Sender::sendMessage() {
    counter++;

    cMessage *msg = new cMessage("testmessage"); // Message number: " + std::to_string(counter)
    send(msg, "out");

    simtime_t delay = par("delayTime");

    EV << "Message sent, waiting " << delay << " secs...\n";
    scheduleAt(simTime() + delay, event);
}
