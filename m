Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0829FC282DA
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 13:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD21221B26
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 13:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfDPNzp convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 16 Apr 2019 09:55:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729440AbfDPNzo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 09:55:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D35BC3098576;
        Tue, 16 Apr 2019 13:55:38 +0000 (UTC)
Received: from carbon (ovpn-200-23.brq.redhat.com [10.40.200.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC0DD5C1B4;
        Tue, 16 Apr 2019 13:55:24 +0000 (UTC)
Date:   Tue, 16 Apr 2019 15:55:23 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ilias.apalodimas@linaro.org, toke@redhat.com,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Thomas Graf <tgraf@suug.ch>,
        Thomas Monjalon <thomas@monjalon.net>, brouer@redhat.com,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: Per-queue XDP programs, thoughts
Message-ID: <20190416155446.00472ad1@carbon>
In-Reply-To: <20190415154932.79bc3b57@cakuba.netronome.com>
References: <20190405131745.24727-1-bjorn.topel@gmail.com>
        <20190405131745.24727-2-bjorn.topel@gmail.com>
        <64259723-f0d8-8ade-467e-ad865add4908@intel.com>
        <20190415183258.36dcee9a@carbon>
        <20190415154932.79bc3b57@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 16 Apr 2019 13:55:44 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Apr 2019 15:49:32 -0700
Jakub Kicinski <jakub.kicinski@netronome.com> wrote:

> On Mon, 15 Apr 2019 18:32:58 +0200, Jesper Dangaard Brouer wrote:
> > On Mon, 15 Apr 2019 13:59:03 +0200 Björn Töpel <bjorn.topel@intel.com> wrote:  
> > > Hi,
> > > 
> > > As you probably can derive from the amount of time this is taking, I'm
> > > not really satisfied with the design of per-queue XDP program. (That,
> > > plus I'm a terribly slow hacker... ;-)) I'll try to expand my thinking
> > > in this mail!  
> 
> Jesper was advocating per-queue progs since very early days of XDP.
> If it was easy to implement cleanly we would've already gotten it ;)

(I cannot help to feel offended here...  IMHO that statement is BS,
that is not how upstream development work, and sure, I am to blame as
I've simply been to lazy or busy with other stuff to implement it.  It
is not that hard to send down a queue# together with the XDP attach
command.) 

I've been advocating for per-queue progs from day-1, since this is an
obvious performance advantage, given the programmer can specialize the
BPF/XDP-prog to the filtered traffic.  I hope/assume we are on the same
pages here, that per-queue progs is a performance optimization.

I guess the rest of the discussion in this thread is (1) if we can
convince each-other that someone will actually use this optimization,
and (2) if we can abstract this away from the user.


> > > Beware, it's kind of a long post, and it's all over the place.    
> > 
> > Cc'ing all the XDP-maintainers (and netdev).
> >   
> > > There are a number of ways of setting up flows in the kernel, e.g.
> > > 
> > > * Connecting/accepting a TCP socket (in-band)
> > > * Using tc-flower (out-of-band)
> > > * ethtool (out-of-band)
> > > * ...
> > > 
> > > The first acts on sockets, the second on netdevs. Then there's ethtool
> > > to configure RSS, and the RSS-on-steriods rxhash/ntuple that can steer
> > > to queues. Most users care about sockets and netdevices. Queues is
> > > more of an implementation detail of Rx or for QoS on the Tx side.    
> > 
> > Let me first acknowledge that the current Linux tools to administrator
> > HW filters is lacking (well sucks).  We know the hardware is capable,
> > as DPDK have an full API for this called rte_flow[1]. If nothing else
> > you/we can use the DPDK API to create a program to configure the
> > hardware, examples here[2]
> > 
> >  [1] https://doc.dpdk.org/guides/prog_guide/rte_flow.html
> >  [2] https://doc.dpdk.org/guides/howto/rte_flow.html
> >   
> > > XDP is something that we can attach to a netdevice. Again, very
> > > natural from a user perspective. As for XDP sockets, the current
> > > mechanism is that we attach to an existing netdevice queue. Ideally
> > > what we'd like is to *remove* the queue concept. A better approach
> > > would be creating the socket and set it up -- but not binding it to a
> > > queue. Instead just binding it to a netdevice (or crazier just
> > > creating a socket without a netdevice).    
> 
> You can remove the concept of a queue from the AF_XDP ABI (well, extend
> it to not require the queue being explicitly specified..), but you can't
> avoid the user space knowing there is a queue.  Because if you do you
> can no longer track and configure that queue (things like IRQ
> moderation, descriptor count etc.)

Yes exactly.  Bjørn you mentioned leaky abstractions, and by removing
the concept of a queue# from the AF_XDP ABI, then you have basically
created a leaky abstraction, as the sysadm would need to tune/configure
the "hidden" abstracted queue# (IRQ moderation, desc count etc.).

> Currently the term "queue" refers mostly to the queues that stack uses.
> Which leaves e.g. the XDP TX queues in a strange grey zone (from
> ethtool channel ABI perspective, RPS, XPS etc.)  So it would be nice to
> have the HW queue ID somewhat detached from stack queue ID.  Or at least
> it'd be nice to introduce queue types?  I've been pondering this for a
> while, I don't see any silver bullet here..

Yes! - I also worry about the term "queue".  This is very interesting
to discuss.

I do find it very natural that your HW (e.g. Netronome) have several HW
RX-queues that feed/send to a single software NAPI RX-queue.  (I assume
this is how you HW already works, but software/Linux cannot know this
internal HW queue id).  How we expose and use this is interesting.

I do want to be-able to create new RX-queues, semi-dynamically
"setup"/load time.  But still a limited number of RX-queues, for
performance and memory reasons (TX-queue are cheaper).  Memory as we
prealloc memory RX-queue (and give it to HW).  Performance as with too
many queues, there is less chance to have a (RX) bulk of packets in
queue.

For example I would not create an RX-queue per TCP-flow.  But why do I
still want per-queue XDP-progs and HW-filters for this TCP-flow
use-case... let me explain:

  E.g. I want to implement an XDP TCP socket load-balancer (same host
delivery, between XDP and network stack).  And my goal is to avoid
touching packet payload on XDP RX-CPU.  First I configure ethtool
filter to redirect all TCP port 80 to a specific RX-queue (could also
be N-queues), then I don't need to parse TCP-port-80 in my per-queue
BPF-prog, and I have higher chance of bulk-RX.  Next I need HW to
provide some flow-identifier, e.g. RSS-hash, flow-id or internal
HW-queue-id, which I can use to redirect on (e.g. via CPUMAP to
N-CPUs).  This way I don't touch packet payload on RX-CPU (my bench
shows one RX-CPU can handle between 14-20Mpps).

 
> > Let me just remind everybody that the AF_XDP performance gains comes
> > from binding the resource, which allow for lock-free semantics, as
> > explained here[3].
> > 
> > [3] https://github.com/xdp-project/xdp-tutorial/tree/master/advanced03-AF_XDP#where-does-af_xdp-performance-come-from
> > 
> >   
> > > The socket is an endpoint, where I'd like data to end up (or get sent
> > > from). If the kernel can attach the socket to a hardware queue,
> > > there's zerocopy if not, copy-mode. Dito for Tx.    
> > 
> > Well XDP programs per RXQ is just a building block to achieve this.
> > 
> > As Van Jacobson explain[4], sockets or applications "register" a
> > "transport signature", and gets back a "channel".   In our case, the
> > netdev-global XDP program is our way to register/program these transport
> > signatures and redirect (e.g. into the AF_XDP socket).
> > This requires some work in software to parse and match transport
> > signatures to sockets.  The XDP programs per RXQ is a way to get
> > hardware to perform this filtering for us.
> > 
> >  [4] http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf
> > 
> >   
> > > Does a user (control plane) want/need to care about queues? Just
> > > create a flow to a socket (out-of-band or inband) or to a netdevice
> > > (out-of-band).    
> > 
> > A userspace "control-plane" program, could hide the setup and use what
> > the system/hardware can provide of optimizations.  VJ[4] e.g. suggest
> > that the "listen" socket first register the transport signature (with
> > the driver) on "accept()".   If the HW supports DPDK-rte_flow API we
> > can register a 5-tuple (or create TC-HW rules) and load our
> > "transport-signature" XDP prog on the queue number we choose.  If not,
> > when our netdev-global XDP prog need a hash-table with 5-tuple and do
> > 5-tuple parsing.  
> 
> But we do want the ability to configure the queue, and get stats for
> that queue.. so we can't hide the queue completely, right?

Yes, that is yet another example that the queue id "leak".

 
> > Creating netdevices via HW filter into queues is an interesting idea.
> > DPDK have an example here[5], on how to per flow (via ethtool filter
> > setup even!) send packets to queues, that endup in SRIOV devices.
> > 
> >  [5] https://doc.dpdk.org/guides/howto/flow_bifurcation.html  
> 
> I wish I had the courage to nack the ethtool redirect to VF Intel
> added :)
> 
> > > Do we envison any other uses for per-queue XDP other than AF_XDP? If
> > > not, it would make *more* sense to attach the XDP program to the
> > > socket (e.g. if the endpoint would like to use kernel data structures
> > > via XDP).    
> > 
> > As demonstrated in [5] you can use (ethtool) hardware filters to
> > redirect packets into VFs (Virtual Functions).
> > 
> > I also want us to extend XDP to allow for redirect from a PF (Physical
> > Function) into a VF (Virtual Function).  First the netdev-global
> > XDP-prog need to support this (maybe extend xdp_rxq_info with PF + VF
> > info).  Next configure HW filter to queue# and load XDP prog on that
> > queue# that only "redirect" to a single VF.  Now if driver+HW supports
> > it, it can "eliminate" the per-queue XDP-prog and do everything in HW.   
> 
> That sounds slightly contrived.  If the program is not doing anything,
> why involve XDP at all?

If the HW doesn't support this then the XDP software will do the work.
If the HW supports this, then you can still list the XDP-prog via
bpftool, and see that you have a XDP prog that does this action (and
maybe expose a offloaded-to-HW bit if you like to expose this info).


>  As stated above we already have too many ways
> to do flow config and/or VF redirect.
> 
> > > If we'd like to slice a netdevice into multiple queues. Isn't macvlan
> > > or similar *virtual* netdevices a better path, instead of introducing
> > > yet another abstraction?    
> 
> Yes, the question of use cases is extremely important.  It seems
> Mellanox is working on "spawning devlink ports" IOW slicing a device
> into subdevices.  Which is a great way to run bifurcated DPDK/netdev
> applications :/  If that gets merged I think we have to recalculate
> what purpose AF_XDP is going to serve, if any.
> 
> In my view we have different "levels" of slicing:

I do appreciate this overview of NIC slicing, as HW-filters +
per-queue-XDP can be seen as a way to slice up the NIC.

>  (1) full HW device;
>  (2) software device (mdev?);
>  (3) separate netdev;
>  (4) separate "RSS instance";
>  (5) dedicated application queues.
> 
> 1 - is SR-IOV VFs
> 2 - is software device slicing with mdev (Mellanox)
> 3 - is (I think) Intel's VSI debugfs... "thing"..
> 4 - is just ethtool RSS contexts (Solarflare)
> 5 - is currently AF-XDP (Intel)
> 
> (2) or lower is required to have raw register access allowing vfio/DPDK
> to run "natively".
> 
> (3) or lower allows for full reuse of all networking APIs, with very
> natural RSS configuration, TC/QoS configuration on TX etc.
> 
> (5) is sufficient for zero copy.
> 
> So back to the use case.. seems like AF_XDP is evolving into allowing
> "level 3" to pass all frames directly to the application?  With
> optional XDP filtering?  It's not a trick question - I'm just trying to
> place it somewhere on my mental map :)

 
> > XDP redirect a more generic abstraction that allow us to implement
> > macvlan.  Except macvlan driver is missing ndo_xdp_xmit. Again first I
> > write this as global-netdev XDP-prog, that does a lookup in a BPF-map.
> > Next I configure HW filters that match the MAC-addr into a queue# and
> > attach simpler XDP-prog to queue#, that redirect into macvlan device.
> >   
> > > Further, is queue/socket a good abstraction for all devices? Wifi?   
> 
> Right, queue is no abstraction whatsoever.  Queue is a low level
> primitive.

I agree, queue is a low level primitive.

This the basically interface that the NIC hardware gave us... it is
fairly limited as it can only express a queue id and a IRQ line that we
can try to utilize to scale the system.   Today, we have not really
tapped into the potential of using this... instead we simply RSS-hash
balance across all RX-queues and hope this makes the system scale...


> > > By just viewing sockets as an endpoint, we leave it up to the kernel to
> > > figure out the best way. "Here's an endpoint. Give me data **here**."
> > > 
> > > The OpenFlow protocol does however support the concept of queues per
> > > port, but do we want to introduce that into the kernel?  
> 
> Switch queues != host queues.  Switch/HW queues are for QoS, host queues
> are for RSS.  Those two concepts are similar yet different.  In Linux
> if you offload basic TX TC (mq)prio (the old work John has done for
> Intel) the actual number of HW queues becomes "channel count" x "num TC
> prios".  What would queue ID mean for AF_XDP in that setup, I wonder.

Thanks for explaining that. I must admit I never really understood the
mqprio concept and these "prios" (when reading the code and playing
with it).


> > > So, if per-queue XDP programs is only for AF_XDP, I think it's better
> > > to stick the program to the socket. For me per-queue is sort of a
> > > leaky abstraction...
> > >
> > > More thoughts. If we go the route of per-queue XDP programs. Would it
> > > be better to leave the setup to XDP -- i.e. the XDP program is
> > > controlling the per-queue programs (think tail-calls, but a map with
> > > per-q programs). Instead of the netlink layer. This is part of a
> > > bigger discussion, namely should XDP really implement the control
> > > plane?
> > >
> > > I really like that a software switch/router can be implemented
> > > effectively with XDP, but ideally I'd like it to be offloaded by
> > > hardware -- using the same control/configuration plane. Can we do it
> > > in hardware, do that. If not, emulate via XDP.    
> 
> There is already a number of proposals in the "device application
> slicing", it would be really great if we could make sure we don't
> repeat the mistakes of flow configuration APIs, and try to prevent
> having too many of them..
> 
> Which is very challenging unless we have strong use cases..
> 
> > That is actually the reason I want XDP per-queue, as it is a way to
> > offload the filtering to the hardware.  And if the per-queue XDP-prog
> > becomes simple enough, the hardware can eliminate and do everything in
> > hardware (hopefully).
> >   
> > > The control plane should IMO be outside of the XDP program.  
> 
> ENOCOMPUTE :)  XDP program is the BPF byte code, it's never control
> plane.  Do you mean application should not control the "context/
> channel/subdev" creation?  You're not saying "it's not the XDP program
> which should be making the classification", no?  XDP program
> controlling the classification was _the_ reason why we liked AF_XDP :)


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
