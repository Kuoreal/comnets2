simple Sender
{
    parameters:
        @display("i=,gold");
        volatile double delayTime @unit(s);   // delay before sending back message
    gates:
        output out;
}

simple Receiver
{
    parameters:
        @display("i=,cyan");
    gates:
        input in;
}

network Exercise2
{
    submodules:
        S: Sender;
        R: Receiver;
    connections:
        S.out --> {  delay = 100ms; } --> R.in;
}
