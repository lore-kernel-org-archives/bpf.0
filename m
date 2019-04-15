Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D584FC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 22:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4DC20854
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 22:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="W+e2/Ltn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfDOWtk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:49:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33558 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfDOWtk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 18:49:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id k14so21244969qtb.0
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 15:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=aO5O+cVfv2GrLDbHQ9mLYnJKJFfKlc/+On57EdJCY7g=;
        b=W+e2/LtnjsDjFNvmSbTc8FdHGnmIxJW0sJmUeQTKYAqVgkPfhuCdTBkgDMg8fflEC1
         fCUvjP8RdG8wYzPAb/uLohOtWi717fyfcqLimMbEAw+yL6J2CHW26ymGldNAwkVEDNbf
         bpB8EqEj+zlbkPyxXxXWQBO2dFdn1FJWO5kbgicoklkL8ZIm9ZaBDcuUxOedujWsgSGt
         fOKNvlgvTWWZzjrBPMoBFLaP1XDEvV4GRR47+GXU/abnuSpSeObqyC7AP1FJvy+fu0fY
         rZRXtiH8+3Mk86Lb6KVhyFMqb7ZljnsycJ0LMm1Y2sarTnDTTfANgtDvpphVwoZUU2+q
         L/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=aO5O+cVfv2GrLDbHQ9mLYnJKJFfKlc/+On57EdJCY7g=;
        b=CVj7eytwq2ZZ/n9QERkZyzQt7duiqRczSKj5VrazmZsXcDnK4fX8pj24aD5brCKWa6
         hLmSL1nqQQkcpuznqlf3X1xyI3pMTQtqmfZy94gVB8C3yOk77dSyRGmU8Kja3MSc7jlN
         l5KaSi8mk1kE06ivvMLlxRdq9mm3TWjmUiR7OXazKuzd52UWSebG9q5wO4L88pVS4cri
         2XbuCXvHePB1ES5/a0+fLAP0XMAQBAYPKshNsUjntjAe/EuGg7ccT+eAv4YuldaTIi0G
         v5RWjCWKO4n4psj5LONVqE/7l280cLw1DA7zj3rS67TTPMX5qNxv8jp5W2WoPApKs17I
         Os/w==
X-Gm-Message-State: APjAAAXeShbIxZz0cmTVAaDKNJ5fMqx+fBk4PRpZ0YQ+4YIVdFnU7wsU
        o/utVqEYxXJxUYsJ7+mwAWab0A==
X-Google-Smtp-Source: APXvYqw37a8OZuUOlXeTO6q5GY/YEdgDE3lyF8PUHUycjKHIcTVTWUoOoIjH4CGttz1rThfJZYEBoA==
X-Received: by 2002:a0c:b907:: with SMTP id u7mr63643822qvf.189.1555368578749;
        Mon, 15 Apr 2019 15:49:38 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k140sm28026111qke.9.2019.04.15.15.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 15:49:38 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:49:32 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
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
        Thomas Monjalon <thomas@monjalon.net>
Subject: Re: Per-queue XDP programs, thoughts
Message-ID: <20190415154932.79bc3b57@cakuba.netronome.com>
In-Reply-To: <20190415183258.36dcee9a@carbon>
References: <20190405131745.24727-1-bjorn.topel@gmail.com>
        <20190405131745.24727-2-bjorn.topel@gmail.com>
        <64259723-f0d8-8ade-467e-ad865add4908@intel.com>
        <20190415183258.36dcee9a@carbon>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Apr 2019 18:32:58 +0200, Jesper Dangaard Brouer wrote:
> On Mon, 15 Apr 2019 13:59:03 +0200 Bj=C3=B6rn T=C3=B6pel <bjorn.topel@int=
el.com> wrote:
> > Hi,
> >=20
> > As you probably can derive from the amount of time this is taking, I'm
> > not really satisfied with the design of per-queue XDP program. (That,
> > plus I'm a terribly slow hacker... ;-)) I'll try to expand my thinking
> > in this mail!

Jesper was advocating per-queue progs since very early days of XDP.
If it was easy to implement cleanly we would've already gotten it ;)

> > Beware, it's kind of a long post, and it's all over the place. =20
>=20
> Cc'ing all the XDP-maintainers (and netdev).
>=20
> > There are a number of ways of setting up flows in the kernel, e.g.
> >=20
> > * Connecting/accepting a TCP socket (in-band)
> > * Using tc-flower (out-of-band)
> > * ethtool (out-of-band)
> > * ...
> >=20
> > The first acts on sockets, the second on netdevs. Then there's ethtool
> > to configure RSS, and the RSS-on-steriods rxhash/ntuple that can steer
> > to queues. Most users care about sockets and netdevices. Queues is
> > more of an implementation detail of Rx or for QoS on the Tx side. =20
>=20
> Let me first acknowledge that the current Linux tools to administrator
> HW filters is lacking (well sucks).  We know the hardware is capable,
> as DPDK have an full API for this called rte_flow[1]. If nothing else
> you/we can use the DPDK API to create a program to configure the
> hardware, examples here[2]
>=20
>  [1] https://doc.dpdk.org/guides/prog_guide/rte_flow.html
>  [2] https://doc.dpdk.org/guides/howto/rte_flow.html
>=20
> > XDP is something that we can attach to a netdevice. Again, very
> > natural from a user perspective. As for XDP sockets, the current
> > mechanism is that we attach to an existing netdevice queue. Ideally
> > what we'd like is to *remove* the queue concept. A better approach
> > would be creating the socket and set it up -- but not binding it to a
> > queue. Instead just binding it to a netdevice (or crazier just
> > creating a socket without a netdevice). =20

You can remove the concept of a queue from the AF_XDP ABI (well, extend
it to not require the queue being explicitly specified..), but you can't
avoid the user space knowing there is a queue.  Because if you do you
can no longer track and configure that queue (things like IRQ
moderation, descriptor count etc.)

Currently the term "queue" refers mostly to the queues that stack uses.
Which leaves e.g. the XDP TX queues in a strange grey zone (from
ethtool channel ABI perspective, RPS, XPS etc.)  So it would be nice to
have the HW queue ID somewhat detached from stack queue ID.  Or at least
it'd be nice to introduce queue types?  I've been pondering this for a
while, I don't see any silver bullet here..

> Let me just remind everybody that the AF_XDP performance gains comes
> from binding the resource, which allow for lock-free semantics, as
> explained here[3].
>=20
> [3] https://github.com/xdp-project/xdp-tutorial/tree/master/advanced03-AF=
_XDP#where-does-af_xdp-performance-come-from
>=20
>=20
> > The socket is an endpoint, where I'd like data to end up (or get sent
> > from). If the kernel can attach the socket to a hardware queue,
> > there's zerocopy if not, copy-mode. Dito for Tx. =20
>=20
> Well XDP programs per RXQ is just a building block to achieve this.
>=20
> As Van Jacobson explain[4], sockets or applications "register" a
> "transport signature", and gets back a "channel".   In our case, the
> netdev-global XDP program is our way to register/program these transport
> signatures and redirect (e.g. into the AF_XDP socket).
> This requires some work in software to parse and match transport
> signatures to sockets.  The XDP programs per RXQ is a way to get
> hardware to perform this filtering for us.
>=20
>  [4] http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf
>=20
>=20
> > Does a user (control plane) want/need to care about queues? Just
> > create a flow to a socket (out-of-band or inband) or to a netdevice
> > (out-of-band). =20
>=20
> A userspace "control-plane" program, could hide the setup and use what
> the system/hardware can provide of optimizations.  VJ[4] e.g. suggest
> that the "listen" socket first register the transport signature (with
> the driver) on "accept()".   If the HW supports DPDK-rte_flow API we
> can register a 5-tuple (or create TC-HW rules) and load our
> "transport-signature" XDP prog on the queue number we choose.  If not,
> when our netdev-global XDP prog need a hash-table with 5-tuple and do
> 5-tuple parsing.

But we do want the ability to configure the queue, and get stats for
that queue.. so we can't hide the queue completely, right?

> Creating netdevices via HW filter into queues is an interesting idea.
> DPDK have an example here[5], on how to per flow (via ethtool filter
> setup even!) send packets to queues, that endup in SRIOV devices.
>=20
>  [5] https://doc.dpdk.org/guides/howto/flow_bifurcation.html

I wish I had the courage to nack the ethtool redirect to VF Intel
added :)

> > Do we envison any other uses for per-queue XDP other than AF_XDP? If
> > not, it would make *more* sense to attach the XDP program to the
> > socket (e.g. if the endpoint would like to use kernel data structures
> > via XDP). =20
>=20
> As demonstrated in [5] you can use (ethtool) hardware filters to
> redirect packets into VFs (Virtual Functions).
>=20
> I also want us to extend XDP to allow for redirect from a PF (Physical
> Function) into a VF (Virtual Function).  First the netdev-global
> XDP-prog need to support this (maybe extend xdp_rxq_info with PF + VF
> info).  Next configure HW filter to queue# and load XDP prog on that
> queue# that only "redirect" to a single VF.  Now if driver+HW supports
> it, it can "eliminate" the per-queue XDP-prog and do everything in HW.=20

That sounds slightly contrived.  If the program is not doing anything,
why involve XDP at all?  As stated above we already have too many ways
to do flow config and/or VF redirect.

> > If we'd like to slice a netdevice into multiple queues. Isn't macvlan
> > or similar *virtual* netdevices a better path, instead of introducing
> > yet another abstraction? =20

Yes, the question of use cases is extremely important.  It seems
Mellanox is working on "spawning devlink ports" IOW slicing a device
into subdevices.  Which is a great way to run bifurcated DPDK/netdev
applications :/  If that gets merged I think we have to recalculate
what purpose AF_XDP is going to serve, if any.

In my view we have different "levels" of slicing:

 (1) full HW device;
 (2) software device (mdev?);
 (3) separate netdev;
 (4) separate "RSS instance";
 (5) dedicated application queues.

1 - is SR-IOV VFs
2 - is software device slicing with mdev (Mellanox)
3 - is (I think) Intel's VSI debugfs... "thing"..
4 - is just ethtool RSS contexts (Solarflare)
5 - is currently AF-XDP (Intel)

(2) or lower is required to have raw register access allowing vfio/DPDK
to run "natively".

(3) or lower allows for full reuse of all networking APIs, with very
natural RSS configuration, TC/QoS configuration on TX etc.

(5) is sufficient for zero copy.

So back to the use case.. seems like AF_XDP is evolving into allowing
"level 3" to pass all frames directly to the application?  With
optional XDP filtering?  It's not a trick question - I'm just trying to
place it somewhere on my mental map :)

> XDP redirect a more generic abstraction that allow us to implement
> macvlan.  Except macvlan driver is missing ndo_xdp_xmit. Again first I
> write this as global-netdev XDP-prog, that does a lookup in a BPF-map.
> Next I configure HW filters that match the MAC-addr into a queue# and
> attach simpler XDP-prog to queue#, that redirect into macvlan device.
>=20
> > Further, is queue/socket a good abstraction for all devices? Wifi?=20

Right, queue is no abstraction whatsoever.  Queue is a low level
primitive.

> > By just viewing sockets as an endpoint, we leave it up to the kernel to
> > figure out the best way. "Here's an endpoint. Give me data **here**."
> >=20
> > The OpenFlow protocol does however support the concept of queues per
> > port, but do we want to introduce that into the kernel?

Switch queues !=3D host queues.  Switch/HW queues are for QoS, host queues
are for RSS.  Those two concepts are similar yet different.  In Linux
if you offload basic TX TC (mq)prio (the old work John has done for
Intel) the actual number of HW queues becomes "channel count" x "num TC
prios".  What would queue ID mean for AF_XDP in that setup, I wonder.

> > So, if per-queue XDP programs is only for AF_XDP, I think it's better
> > to stick the program to the socket. For me per-queue is sort of a
> > leaky abstraction...
> >
> > More thoughts. If we go the route of per-queue XDP programs. Would it
> > be better to leave the setup to XDP -- i.e. the XDP program is
> > controlling the per-queue programs (think tail-calls, but a map with
> > per-q programs). Instead of the netlink layer. This is part of a
> > bigger discussion, namely should XDP really implement the control
> > plane?
> >
> > I really like that a software switch/router can be implemented
> > effectively with XDP, but ideally I'd like it to be offloaded by
> > hardware -- using the same control/configuration plane. Can we do it
> > in hardware, do that. If not, emulate via XDP. =20

There is already a number of proposals in the "device application
slicing", it would be really great if we could make sure we don't
repeat the mistakes of flow configuration APIs, and try to prevent
having too many of them..

Which is very challenging unless we have strong use cases..

> That is actually the reason I want XDP per-queue, as it is a way to
> offload the filtering to the hardware.  And if the per-queue XDP-prog
> becomes simple enough, the hardware can eliminate and do everything in
> hardware (hopefully).
>=20
> > The control plane should IMO be outside of the XDP program.

ENOCOMPUTE :)  XDP program is the BPF byte code, it's never control
plance.  Do you mean application should not control the "context/
channel/subdev" creation?  You're not saying "it's not the XDP program
which should be making the classification", no?  XDP program
controlling the classification was _the_ reason why we liked AF_XDP :)
