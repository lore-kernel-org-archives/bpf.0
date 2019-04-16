Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80264C10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 07:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420542073F
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 07:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ+WU9gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfDPHpi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:45:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35218 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfDPHph (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 03:45:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id h39so22273475qte.2;
        Tue, 16 Apr 2019 00:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HWJKJ6x6R/PbWZR0/6fWGuxu4fg8iT5hNpTlKB5t7JU=;
        b=LJ+WU9gnTPy0kD1UcDx+1zScUunlt1+rgn7s8fE90v93pBcmqFmi6dkqKaJIcssXf1
         MdMKRdSr7NOV6rL/ZGd2KLzJk41NLy/GwSewyt/3+j4Pcg1D4gcdZXa78/4A0BN5hRas
         erYgX+MNuMyvPNrH3ThBo+TyoaMsfkjJZHlWvuzckTNq61SJOQMDEgMwJEII2dOYL0wW
         EDcyUbRRz+TS2/xnN133X9g66wlOp1bVBUlKhmS475wYAcQksyl5EmAcZkj/xTDFWnGM
         okwpUXTFZs6WOE33xVuMJXXgstmyvUrFrkXrZ3tx5kg+43UhaYRso+2mQVDLj5cULfna
         otZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HWJKJ6x6R/PbWZR0/6fWGuxu4fg8iT5hNpTlKB5t7JU=;
        b=KTpBYcwZJvzdhTrmIsrhqx8Wygm7o92C2IwCor9wDR9zhWk3UsjNE6AF1NAia+y7Y3
         +d0mKZynaJFJR2cl71FmwsIFWElTCMmhAWx/Qy0FshygtuZ/tXW+/C8l9/K1qKbfet3j
         5T/ubQhPyLiBb4NLyLReSNjKzWzzCoPurpkhxFADhuoR+F6MM6Xz1gfeXzyxbrwonlVh
         knjD12LjNFh4yJLDcA4ViTxL1ua3zzHy5ocrrUJFkvpY72eEkNg6ovGxy+3sToOAh6CH
         IN7V+BHBDBqgxk4unqHD2/ncThZGHS0U58UbCCQs/1LDG0s1cNH4wXFUxtkR45Ni/BM7
         Rjkg==
X-Gm-Message-State: APjAAAXXaP0HI7QIHYb6+bd9Wep2iVy3JoY+3/sXdj96nJtD2UrnYsit
        EfjltFl6fTJXP27kSNSa9TRC49HyCOL2N/rqXbs=
X-Google-Smtp-Source: APXvYqzXdisqjoOTawMishMX3L57vkoJF1fdbSyLFFVl3ZNWRUUMeRn7/2CtlajSPdjDaBMtdL8GtL41BXLa1z7lCpc=
X-Received: by 2002:ac8:807:: with SMTP id u7mr64835105qth.78.1555400736336;
 Tue, 16 Apr 2019 00:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190405131745.24727-1-bjorn.topel@gmail.com> <20190405131745.24727-2-bjorn.topel@gmail.com>
 <64259723-f0d8-8ade-467e-ad865add4908@intel.com> <20190415183258.36dcee9a@carbon>
 <20190415154932.79bc3b57@cakuba.netronome.com>
In-Reply-To: <20190415154932.79bc3b57@cakuba.netronome.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 16 Apr 2019 09:45:24 +0200
Message-ID: <CAJ+HfNiBcR4yOBXFM3h9RG_bpu25YGcJtT=dqV1WwNaFmCf77A@mail.gmail.com>
Subject: Re: Per-queue XDP programs, thoughts
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        maciej.fijalkowski@intel.com, Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>,
        Thomas Monjalon <thomas@monjalon.net>,
        Jonathan Lemon <bsd@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Apr 2019 at 00:49, Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Mon, 15 Apr 2019 18:32:58 +0200, Jesper Dangaard Brouer wrote:
> > On Mon, 15 Apr 2019 13:59:03 +0200 Bj=C3=B6rn T=C3=B6pel <bjorn.topel@i=
ntel.com> wrote:
> > > Hi,
> > >
> > > As you probably can derive from the amount of time this is taking, I'=
m
> > > not really satisfied with the design of per-queue XDP program. (That,
> > > plus I'm a terribly slow hacker... ;-)) I'll try to expand my thinkin=
g
> > > in this mail!
>
> Jesper was advocating per-queue progs since very early days of XDP.
> If it was easy to implement cleanly we would've already gotten it ;)
>

I don't think it's a matter of implementing cleanly (again I know very
little about the XDP HW offloads, so that aside! :-D), it's a matter a
"what's the use-case". Mine is "Are queues something we'd like to
expose to the users?".

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
> > > The first acts on sockets, the second on netdevs. Then there's ethtoo=
l
> > > to configure RSS, and the RSS-on-steriods rxhash/ntuple that can stee=
r
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
>

Exactly. There *would* be an underlying queue (if the socket is backed
by a HW queue). Copy-mode is really just a software mechanism, but we
rely on queue-id for performance and conformance with zc mode.

For a user that "just want to toss packets to userspace", they care
about *sockets*. Maybe this is where my argument breaks down. :-) I'd
prefer if a user would just need to care about netdevs and sockets
(including INET sockets). And if the hardware can back the socket
implementation by a hardware queue and get better performance, that's
great, but does the user really need to care?

> Currently the term "queue" refers mostly to the queues that stack uses.
> Which leaves e.g. the XDP TX queues in a strange grey zone (from
> ethtool channel ABI perspective, RPS, XPS etc.)  So it would be nice to
> have the HW queue ID somewhat detached from stack queue ID.  Or at least
> it'd be nice to introduce queue types?  I've been pondering this for a
> while, I don't see any silver bullet here..
>

Yup! And for AF_XDP we'd like to create a *new* hw queue (ideally) for
Rx and Tx, which would also land in the XDP Tx queue gray zone (from a
configuration perspective).

> > Let me just remind everybody that the AF_XDP performance gains comes
> > from binding the resource, which allow for lock-free semantics, as
> > explained here[3].
> >
> > [3] https://github.com/xdp-project/xdp-tutorial/tree/master/advanced03-=
AF_XDP#where-does-af_xdp-performance-come-from
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
> > netdev-global XDP program is our way to register/program these transpor=
t
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
>

Hmm... right.

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
> why involve XDP at all?  As stated above we already have too many ways
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

I really like the subdevice-think, but let's have the drivers in the
kernel. I don't see how the XDP view (including AF_XDP) changes with
subdevices. My view on AF_XDP is that it's a socket that can
receive/send data efficiently from/to the kernel. What subdevice
*might* change is the requirement for a per-queue XDP program.

> In my view we have different "levels" of slicing:
>
>  (1) full HW device;
>  (2) software device (mdev?);
>  (3) separate netdev;
>  (4) separate "RSS instance";
>  (5) dedicated application queues.
>
> 1 - is SR-IOV VFs
> 2 - is software device slicing with mdev (Mellanox)
> 3 - is (I think) Intel's VSI debugfs... "thing"..

:-) The VMDq netdevice?

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
>

I wouldn't say evolving into. That is one use-case that we'd like to
support efficiently. Being able to toss some packets out to userspace
from an XDP program is also useful. Some applications just want all
packets to userspace. Some applications want to use
kernel-infrastructure via XDP prior tossing it to userland. Some
application want the XDP packet metadata in userland...


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
>

...and do we want to introduce that as a proper kernel object?

> > > By just viewing sockets as an endpoint, we leave it up to the kernel =
to
> > > figure out the best way. "Here's an endpoint. Give me data **here**."
> > >
> > > The OpenFlow protocol does however support the concept of queues per
> > > port, but do we want to introduce that into the kernel?
>
> Switch queues !=3D host queues.  Switch/HW queues are for QoS, host queue=
s
> are for RSS.  Those two concepts are similar yet different.  In Linux
> if you offload basic TX TC (mq)prio (the old work John has done for
> Intel) the actual number of HW queues becomes "channel count" x "num TC
> prios".  What would queue ID mean for AF_XDP in that setup, I wonder.
>
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

Agree!

> > That is actually the reason I want XDP per-queue, as it is a way to
> > offload the filtering to the hardware.  And if the per-queue XDP-prog
> > becomes simple enough, the hardware can eliminate and do everything in
> > hardware (hopefully).
> >
> > > The control plane should IMO be outside of the XDP program.
>
> ENOCOMPUTE :)  XDP program is the BPF byte code, it's never control
> plance.  Do you mean application should not control the "context/
> channel/subdev" creation?

Yes, but I'm not sure. I'd like to hear more opinions.

Let me try to think out loud here. Say that per-queue XDP programs
exist. The main XDP program receives all packets and makes the
decision that a certain flow should end up in say queue X, and that
the hardware supports offloading that. Should the knobs to program the
hardware be in via BPF or by some other mechanism (perf ring to
userland daemon)? Further, setting the XDP program per queue. Should
that be done via XDP (the main XDP program has knowledge of all
programs) or via say netlink (as XDP is today). One could argue that
the per-queue setup should be a map (like tail-calls).

> You're not saying "it's not the XDP program
> which should be making the classification", no?  XDP program
> controlling the classification was _the_ reason why we liked AF_XDP :)

XDP program not doing classification would be weird. But if there's a
scenario where *everything for a certain HW filter* end up in an
AF_XDP queue, should we require an XDP program. I've been going back
and forth here... :-)


Bj=C3=B6rn
