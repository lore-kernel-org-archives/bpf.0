Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B8DC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 16:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258012087C
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 16:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfDOQdQ convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 15 Apr 2019 12:33:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOQdP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 12:33:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1A5C81F2F;
        Mon, 15 Apr 2019 16:33:14 +0000 (UTC)
Received: from carbon (ovpn-200-23.brq.redhat.com [10.40.200.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9537160C05;
        Mon, 15 Apr 2019 16:32:59 +0000 (UTC)
Date:   Mon, 15 Apr 2019 18:32:58 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ilias.apalodimas@linaro.org, toke@redhat.com,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        brouer@redhat.com, Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Thomas Graf <tgraf@suug.ch>,
        Thomas Monjalon <thomas@monjalon.net>
Subject: Re: Per-queue XDP programs, thoughts
Message-ID: <20190415183258.36dcee9a@carbon>
In-Reply-To: <64259723-f0d8-8ade-467e-ad865add4908@intel.com>
References: <20190405131745.24727-1-bjorn.topel@gmail.com>
        <20190405131745.24727-2-bjorn.topel@gmail.com>
        <64259723-f0d8-8ade-467e-ad865add4908@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 15 Apr 2019 16:33:14 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Mon, 15 Apr 2019 13:59:03 +0200 Björn Töpel <bjorn.topel@intel.com> wrote:

> Hi,
> 
> As you probably can derive from the amount of time this is taking, I'm
> not really satisfied with the design of per-queue XDP program. (That,
> plus I'm a terribly slow hacker... ;-)) I'll try to expand my thinking
> in this mail!
> 
> Beware, it's kind of a long post, and it's all over the place.

Cc'ing all the XDP-maintainers (and netdev).

> There are a number of ways of setting up flows in the kernel, e.g.
> 
> * Connecting/accepting a TCP socket (in-band)
> * Using tc-flower (out-of-band)
> * ethtool (out-of-band)
> * ...
> 
> The first acts on sockets, the second on netdevs. Then there's ethtool
> to configure RSS, and the RSS-on-steriods rxhash/ntuple that can steer
> to queues. Most users care about sockets and netdevices. Queues is
> more of an implementation detail of Rx or for QoS on the Tx side.

Let me first acknowledge that the current Linux tools to administrator
HW filters is lacking (well sucks).  We know the hardware is capable,
as DPDK have an full API for this called rte_flow[1]. If nothing else
you/we can use the DPDK API to create a program to configure the
hardware, examples here[2]

 [1] https://doc.dpdk.org/guides/prog_guide/rte_flow.html
 [2] https://doc.dpdk.org/guides/howto/rte_flow.html

> XDP is something that we can attach to a netdevice. Again, very
> natural from a user perspective. As for XDP sockets, the current
> mechanism is that we attach to an existing netdevice queue. Ideally
> what we'd like is to *remove* the queue concept. A better approach
> would be creating the socket and set it up -- but not binding it to a
> queue. Instead just binding it to a netdevice (or crazier just
> creating a socket without a netdevice).

Let me just remind everybody that the AF_XDP performance gains comes
from binding the resource, which allow for lock-free semantics, as
explained here[3].

[3] https://github.com/xdp-project/xdp-tutorial/tree/master/advanced03-AF_XDP#where-does-af_xdp-performance-come-from


> The socket is an endpoint, where I'd like data to end up (or get sent
> from). If the kernel can attach the socket to a hardware queue,
> there's zerocopy if not, copy-mode. Dito for Tx.

Well XDP programs per RXQ is just a building block to achieve this.

As Van Jacobson explain[4], sockets or applications "register" a
"transport signature", and gets back a "channel".   In our case, the
netdev-global XDP program is our way to register/program these transport
signatures and redirect (e.g. into the AF_XDP socket).
This requires some work in software to parse and match transport
signatures to sockets.  The XDP programs per RXQ is a way to get
hardware to perform this filtering for us.

 [4] http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf


> Does a user (control plane) want/need to care about queues? Just
> create a flow to a socket (out-of-band or inband) or to a netdevice
> (out-of-band).

A userspace "control-plane" program, could hide the setup and use what
the system/hardware can provide of optimizations.  VJ[4] e.g. suggest
that the "listen" socket first register the transport signature (with
the driver) on "accept()".   If the HW supports DPDK-rte_flow API we
can register a 5-tuple (or create TC-HW rules) and load our
"transport-signature" XDP prog on the queue number we choose.  If not,
when our netdev-global XDP prog need a hash-table with 5-tuple and do
5-tuple parsing.

Creating netdevices via HW filter into queues is an interesting idea.
DPDK have an example here[5], on how to per flow (via ethtool filter
setup even!) send packets to queues, that endup in SRIOV devices.

 [5] https://doc.dpdk.org/guides/howto/flow_bifurcation.html


> Do we envison any other uses for per-queue XDP other than AF_XDP? If
> not, it would make *more* sense to attach the XDP program to the
> socket (e.g. if the endpoint would like to use kernel data structures
> via XDP).

As demonstrated in [5] you can use (ethtool) hardware filters to
redirect packets into VFs (Virtual Functions).

I also want us to extend XDP to allow for redirect from a PF (Physical
Function) into a VF (Virtual Function).  First the netdev-global
XDP-prog need to support this (maybe extend xdp_rxq_info with PF + VF
info).  Next configure HW filter to queue# and load XDP prog on that
queue# that only "redirect" to a single VF.  Now if driver+HW supports
it, it can "eliminate" the per-queue XDP-prog and do everything in HW. 


> If we'd like to slice a netdevice into multiple queues. Isn't macvlan
> or similar *virtual* netdevices a better path, instead of introducing
> yet another abstraction?

XDP redirect a more generic abstraction that allow us to implement
macvlan.  Except macvlan driver is missing ndo_xdp_xmit. Again first I
write this as global-netdev XDP-prog, that does a lookup in a BPF-map.
Next I configure HW filters that match the MAC-addr into a queue# and
attach simpler XDP-prog to queue#, that redirect into macvlan device.

 
> Further, is queue/socket a good abstraction for all devices? Wifi? By
> just viewing sockets as an endpoint, we leave it up to the kernel to
> figure out the best way. "Here's an endpoint. Give me data **here**."
> 
> The OpenFlow protocol does however support the concept of queues per
> port, but do we want to introduce that into the kernel?
> 
> So, if per-queue XDP programs is only for AF_XDP, I think it's better
> to stick the program to the socket. For me per-queue is sort of a
> leaky abstraction...
>
> More thoughts. If we go the route of per-queue XDP programs. Would it
> be better to leave the setup to XDP -- i.e. the XDP program is
> controlling the per-queue programs (think tail-calls, but a map with
> per-q programs). Instead of the netlink layer. This is part of a
> bigger discussion, namely should XDP really implement the control
> plane?
> 
> I really like that a software switch/router can be implemented
> effectively with XDP, but ideally I'd like it to be offloaded by
> hardware -- using the same control/configuration plane. Can we do it
> in hardware, do that. If not, emulate via XDP.

That is actually the reason I want XDP per-queue, as it is a way to
offload the filtering to the hardware.  And if the per-queue XDP-prog
becomes simple enough, the hardware can eliminate and do everything in
hardware (hopefully).


> The control plane should IMO be outside of the XDP program.
> 
> Ok, please convince me! :-D

I tried to above...

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer


More use-cases for per-queue XDP-prog:

XDP for containers
------------------
XDP can redirect into veth, used for containers.  So, I want to
implement container protection/isolation in XDP layer.  E.g. I only
want my container to talk to 1 external src-IP to my container dst-IP
on port 80.  I can implement that check in netdev-global XDP BPF-code.
But I can also hardware "offload" this simple filter (via ethtool or
rte_flow) and simplify the per-queue XDP-prog.  Given the queue now
only receives traffic that match my desc, I have now protected/isolated
the traffic to my container.


DPDK using per-queue AF_XDP
---------------------------
AFAIK an AF_XDP PMD driver have been merged in DPDK (but I've not
looked at the code).

It would be very natural for DPDK to load per-queue XDP-progs for
interfacing with AF_XDP, as they already have rte_flow API (see
[1]+[2]) for configuring HW filters.  And loading per-queue XDP-progs
would also avoid disturbing other users of XDP on same machine (if we
choose the semantics defined in [6]).

[6] https://github.com/xdp-project/xdp-project/blob/master/areas/core/xdp_per_rxq01.org#proposal-rxq-prog-takes-precedence
