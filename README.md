<h1 align="center">Proxsneak</h1>

<h4 align="center">Create multiple proxy instances with load-balancing for sneakerbots</h4>


## Description

It provides one single endpoint for clients. Supports **[HAProxy](http://www.haproxy.org/)**, **socks** protocol and **http-proxy** servers: **[polipo](https://www.irif.fr/~jch/software/polipo/)**, **[privoxy](https://www.privoxy.org/)** and **[hpts](https://github.com/oyyd/http-proxy-to-socks)**.

In addition, you can **view** previously running **TOR** processes and create a **new identity** for all or selected processes.

## Introduction

`multitor` was created with the aim of initialize many **TOR** processes as quickly as possible. I could use many instances for my daily use programs (web browsers, messangers and other). In addition, I was looking for a tool that would increase anonymity when conducting penetration tests and testing the security of infrastructure.

Before using the `multitor` you need to remember:

- **TOR** does attempt to generate a bunch of streams for you already. From this perspective, it is already load balancing (and it's much smarter at it than **HAproxy**)
- the main goal is masking from where we get by sending requests to multiple streams. It is not so easy to locate where an attacker comes from. If you used http/https servers e.g. proxy servers, you will know what is going on but...
- using multiple **TOR** instances can increase the probability of using a compromised circuit
- `multitor` getting some bandwidth improvements just because it's a different way of connecting to **TOR** network
- in `multitor` configuration mostly **HAProxy** checks the local (syn, syn/ack) socket - not all **TOR** nodes (also exist nodes). If there is a problem with the socket it tries to send traffic to others available without touching what's next - it does not ensure that the data will arrive
- **TOR** network is a separate organism on which the `multitor` has no effect If one of the nodes is damaged and somehow the data can not leave the exit node, it is likely that a connection error will be returned or, at best, the data will be transferred through another local socket
- **HAProxy** load balance network traffic between local **TOR** or **http-proxy** processes - not nodes inside **TOR** network

> **TOR** is a fine security project and an excellent component in a strategy of defence in depth but it isn’t (sadly) a cloak of invisibility. When using the **TOR**, always remember about ssl (e.g. https) wherever it is possible.

Look also at **[Limitations](#limitations)**.

## How To Use

> :heavy_exclamation_mark: For a more detailed understanding of `multitor`, its parameters, functions and how it all works, see the **[Manual](https://github.com/trimstray/multitor/wiki/Manual)**.

It's simple:

```bash

# Install
./setup.sh install

# Run the app
multitor --init 2 --user debian-tor --socks-port 9000 --control-port 9900 --proxy privoxy --haproxy
```

> * symlink to `bin/multitor` is placed in `/usr/local/bin`
> * man page is placed in `/usr/local/man/man8`

## Parameters

Provides the following options:

```bash
  Usage:
    multitor <option|long-option>

  Examples:
    multitor --init 2 --user debian-tor --socks-port 9000 --control-port 9900
    multitor --init 10 --user debian-tor --socks-port 9000 --control-port 9900 --proxy socks
    multitor --show-id --socks-port 9000

  Options:
        --help                        show this message
        --debug                       displays information on the screen (debug mode)
        --verbose                     displays more information about TOR processes
    -i, --init <num>                  init new tor processes
    -k, --kill                        kill all multitor processes
    -s, --show-id                     show specific tor process id
    -n, --new-id                      regenerate tor circuit
    -u, --user <string>               set the user (only with -i|--init)
        --socks-port <port_num|all>   set socks port number
        --control-port <port_num>     set control port number
        --proxy <proxy_type>          set socks or http (polipo, privoxy, hpts) proxy server
        --haproxy                     set HAProxy as a frontend for http proxies (only with --proxy)
```
### Limitations

- each **TOR**, **http-proxy** and **HAProxy** processes needs a certain number of memory. If the number of **TOR** processes is too big, the oldest one will be automatically killed by the system
- **Polipo** is no longer supported but it is still a very good and light proxy. In my opinion the best http-proxy solution is **Privoxy**
