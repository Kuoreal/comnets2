#include <stdio.h>
#include <string.h>
#include <omnetpp.h>
#include <math.h>

using namespace omnetpp;

class Sender: public cSimpleModule {
private:
    cMessage *event;
    long lastRandomNumber = 1;
    long maximumPeriod = pow(2, 31) - 1;

protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual void sendMessage();
    virtual LONG64 LCG();
    virtual double uniform(int lowerBound, int upperBound);
};

Define_Module(Sender);

void Sender::initialize() {
    event = new cMessage("event");
    sendMessage();
}

void Sender::handleMessage(cMessage *msg) {
    if (msg->isSelfMessage()) {
        sendMessage();
    }
}

void Sender::sendMessage() {
    cMessage *msg = new cMessage("testmessage"); // Message number: " + std::to_string(counter)
    send(msg, "out");

    simtime_t delay = uniform(0, 2);

    EV << "Message sent, waiting " << delay << " secs...\n";
    scheduleAt(simTime() + delay, event);
}

LONG64 Sender::LCG() {
    LONG64 a = 16807;
    LONG64 newRandomNumber = (a * lastRandomNumber) % maximumPeriod;
    lastRandomNumber = newRandomNumber;
    return newRandomNumber;
}

double Sender::uniform(int lowerBound, int upperBound) {
    LONG64 randomInt = LCG();
    return lowerBound
            + (1.0 * randomInt / maximumPeriod) * (upperBound - lowerBound);
}
