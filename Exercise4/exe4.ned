
import inet.common.misc.NetAnimTrace;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;


network ClientServer
{
    parameters:
        double per = default(0);
        double ber=1e-7;
    types:
        channel C extends DatarateChannel
        {
            datarate = 10Mbps;
            delay = 0.1us;
            per = per;
            ber = ber;
        }
    submodules:
        client1: StandardHost {
            parameters:
                @display("p=250,150;i=device/pc3");
        }
        server: StandardHost {
            parameters:
                @display("p=400,150;i=device/pc2");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=100,100;is=s");
        }
        netAnimTrace: NetAnimTrace {
            @display("p=100,200;is=s");
        }
    connections:
        client1.pppg++ <--> C <--> server.pppg++;
}