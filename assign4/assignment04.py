import argparse, socket, sys

MAX_BYTES = 65535

# server
def server(port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    interface = "127.0.0.1"
    sock.bind((interface, port))

    #@ make the socket and assign it to sock
    #@ assign the broadcast IP address to the variable named interface
    #@ bind sock to the pair of interface, port
    print('Listening at', sock.getsockname())
    while True:
        data, address = sock.recvfrom(MAX_BYTES)
        text = data.decode('ascii')
        print('The client at {} says {!r}'.format(address, text))

# client
def client(port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    hostname = "127.0.0.1"

    #@ make the socket and assign it to sock
    #@ assign the broadcast IP address to the variable named hostname
    sock.setsockopt(socket.SOL_SOCKET,socket.SO_BROADCAST,1)
    #@ connect sock to the pair of interface, port
    sock.connect((hostname, port))
    print('Client socket name is {}'.format(sock.getsockname()))

    text = raw_input("What data should we broadcast?")

    # send datagram while more to send
    while len(text):
        data = text.encode('ascii')

        # send datagram
        sock.send(data)

        # get next datagram to send
        text = raw_input("What data should we broadcast?")

# main
if __name__ == '__main__':
    choices = {'client': client, 'server': server}
    parser = argparse.ArgumentParser(description='Send and receive UDP')
    parser.add_argument('role', choices=choices, help='which role to take')
    parser.add_argument('-p', metavar='PORT', type=int, default=1060,
                        help='UDP port (default 1060)')
    args = parser.parse_args()
    function = choices[args.role]
    function(args.p)
