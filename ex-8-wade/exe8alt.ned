//
// Copyright (C) 2005 Andras Varga
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//


import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.visualizer.contract.IIntegratedVisualizer;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.applications.udpapp.UdpBasicApp;
import inet.node.ethernet.Eth100M;

network exe8alt
{
    parameters:
        //int numHosts = 1;
        //**.mgmt.numChannels = 2;
    submodules:
        visualizer: <default("IntegratedCanvasVisualizer")> like IIntegratedVisualizer if hasVisualizer() {
            parameters:
                @display("p=100,300;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=100,100;is=s");
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            parameters:
                @display("p=100,200;is=s");
        }
        WirelessHost: WirelessHost {
            @display("r=,,#707070;p=224,79");
        }
        ap: AccessPoint {
            @display("p=213,174;r=,,#707070");
        }
        Router: Router {
            @display("p=492,283");
        }
        WiredHost: StandardHost {
            @display("p=492,407");
        }
        Server: StandardHost;
        WebUser1: WirelessHost {
            @display("p=213,300");
        }
        WebUser2: WirelessHost {

            @display("p=417,175");
        }
    connections:
        Router.ethg++ <--> Eth100M <--> ap.ethg++;
        Router.ethg++ <--> Eth100M <--> WiredHost.ethg++;
        Router.ethg++ <--> Eth100M <--> Server.ethg++;
        //WebUser2.ethg++ <--> Eth100M <--> Router.ethg++;
}