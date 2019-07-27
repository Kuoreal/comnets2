

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.contract.IIntegratedVisualizer;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.applications.udpapp.UdpBasicApp;
import ned.DatarateChannel;

network FinalTaskWireless
{
    types:
        channel C extends DatarateChannel
        {
            datarate = 100Mbps;
            delay = uniform(25ms, 35ms);
        }

    submodules:
        visualizer: <default("IntegratedCanvasVisualizer")> like IIntegratedVisualizer if hasVisualizer() {
            parameters:
                @display("p=62,301;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=62,103;is=s");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            parameters:
                @display("p=61,200;is=s");
        }
        VideoUser0: WirelessHost {
            parameters:
                @display("p=146,131");
        }
        VideoUser1: StandardHost {
            parameters:
                @display("p=514,77");
        }
        WebUser[3]: WirelessHost {
            parameters:
                @display("p=174,253");
        }
        FTPUser: WirelessHost {
            parameters:
                @display("p=246,74");
        }

        ap: AccessPoint {
            parameters:
                @display("p=229,175");
        }
        MainRouter: Router {
            parameters:
                @display("p=514,217");
        }
        RemoteRouter: Router {
            parameters:
                @display("p=350,217");
        }
        Server: StandardHost {
            parameters:
                @display("p=674,217");
        }

    connections:
        RemoteRouter.ethg++ <--> {  datarate = 100Mbps; } <--> ap.ethg++;
        MainRouter.ethg++ <--> {  delay = 5ms; datarate = 100Mbps; } <--> VideoUser1.ethg++;
        MainRouter.pppg++ <--> {  delay = 30ms; datarate = 100Mbps; } <--> Server.pppg++;
        MainRouter.pppg++ <--> {  delay = 10ms; datarate = 10Mbps; ber = 1e-6; } <--> RemoteRouter.pppg++; // wireless BER = 10^(-6)

}



