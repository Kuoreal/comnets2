/*
 * VoIPApp.h
 *
 *  Created on: Jun 2, 2019
 *      Author: Yevhenii Shudrenko
 */

#ifndef VOIPAPP_H_
#define VOIPAPP_H_

#include "inet/common/packet/Packet.h"
#include "inet/applications/udpapp/UdpBasicApp.h"

class VoIPApp : public inet::UdpBasicApp {
    private:
        inet::simsignal_t packetDelayedSignal;

    protected:
        virtual void initialize(int stage) override;
        virtual void processPacket(inet::Packet *msg) override;
        int numDelayed;

    public:
        VoIPApp() {};
};






#endif /* VOIPAPP_H_ */
