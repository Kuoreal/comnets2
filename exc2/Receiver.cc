#include <stdio.h>
#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;

class Receiver : public cSimpleModule
{
  protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
};

Define_Module(Receiver);

void Receiver::initialize()
{
}

void Receiver::handleMessage(cMessage *msg)
{
    EV << "Received message:" << msg;
}
