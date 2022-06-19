<div id="top"></div>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

<!-- PROJECT LOGO -->
<br />
<div align="center"">
  <a href="https://github.com/KatharaFramework/Kathara">
    <img src="https://github.com/KatharaFramework/Kathara/wiki/logo_kathara_small.png" alt="Logo">
  </a>

  <h3 align="center">Kathara training</h3>

  <p align="center">
    A multi-network simulation realised in Kathara framework
    <br />
    <a href="https://github.com/KatharaFramework/Kathara/wiki"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/n0033/kathara-training/issues">Report Bug</a>
    ·
    <a href="https://github.com/n0033/kathara-training/issues">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
  </ol>
                                  
<!-- ABOUT THE PROJECT -->
## About The Project

![diagram](https://i.postimg.cc/pX5r4hP0/diagram.png)

Network shown above includes:
* two client PCs which are connected to `local cache DNS` and are configured to use `superproxy.it` proxy server
* 3 routers
* 3 DNS servers implemented using `bind9` - roma.it, .it, root DNS server
* usage of OSPF protocol with 4 OSPF zones
* two load balancers realised using `iptables` with random balancing (0.5 probability for each server)
* 4 web servers served by `Apache2`
* `siemanko.it` proxy server

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

* [Docker](https://www.docker.com)
* [Kathara](https://www.kathara.org)
* [Squid](http://www.squid-cache.org)
* [Apache2](https://httpd.apache.org)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started


### Prerequisites

* docker
* kathara

### Installation


1. Clone the repo

   ```sh
   git clone https://github.com/n0033/kathara-training.git
   ```

2. (optional) Clean existing lab data (if you used kathara before)

   ```sh
   sudo kathara lclean
   ```

3. Start the lab

   ```sh
   sudo kathara lstart
   ```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage

After starting the lab you need to wait until OSPF propagates routing tables to all nodes.
You can check current state by `ip route` command on any node.

### Testing OSPF

After running the lab, type `ip route` command. The output of the command should consist of just few records. After waiting ~30 seconds, type `ip route` again. You should see many new records over there.

### Checking connection and DNS
On any node, you can
```sh
ping <ip or domain>
```
Where domains can be:
* siemanko.it
* superproxy.it
* roma.it
* dnsit.it
* dnsu3.roma.it

### Accessing web servers

1. Run `links` web browser (it is preinstalled on linux image used by kathara)
  ```sh
  links
  ```
2. Enter url - type `g` and insert URL - e.g. `roma.it`, 'siemanko.it` or ip address of load balancer

### Testing load balancers

Using links access web server by url `roma.it` or `siemanko.it` multiple times to see that response is served by both web servers (WB1 or WB2 for `roma.it` and WB3 or WB4 for `siemanko.it`)

### Testing proxy

1. On load balancer 2 (lb2) node listen for incoming connections on default http port
  ```sh
  tcpdump -l port 80
  ```
2. On any client node access web server using proxy with links browser: (proxy runs on 3128 port)
  ```sh
  links -http-proxy superproxy.it:3128
  ```
  Type `g` and insert URL - `siemanko.it`

Now, on load balancer terminal you should see packets incoming from ip `153.176.0.2` which is ip address of `superproxy.it`.

<p align="right">(<a href="#top">back to top</a>)</p>
