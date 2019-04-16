Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC16C10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 07:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59A82086A
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 07:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTFhTuw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfDPHow (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:44:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41886 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfDPHow (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 03:44:52 -0400
Received: by mail-qt1-f196.google.com with SMTP id w30so22218840qta.8;
        Tue, 16 Apr 2019 00:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=86k4dTrhX4YQjdbrirGQri+XtUO30T7nrC0me+m+IXg=;
        b=qTFhTuw13l8ee6B0AZnOv4ltooPQDcDhonT1ewf6bOLR4YjQ2v7rO0gOWzunrw5Q7V
         hfRFH3sAE3o2xV3QD/q6Dnbg444GO8fjB+jwQ49MIc5IgRKY2FVmtdwdnisg87Rw0Xw5
         lN9ezrfBN4Z7TVebuWYdQNMW/TBZAgeYhgX0UucrlB8IzU5ktIZcDBmDPp2va+UrNVGD
         TgMXSr8tIubdc3L97yG8QV/3QDErHNvwNvhknCrLMwu34L1Yc7Xz5r7E+xQV6hgHQ//F
         MGApBO3tNJ6QMst5W/4h5ZGIVhN8mjY/9knP01efl5PI9Tr5/tlC+ewRMRuGl8yQdw00
         T6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=86k4dTrhX4YQjdbrirGQri+XtUO30T7nrC0me+m+IXg=;
        b=Cwu05g4eY8VOes69D3/viL+j2NcOLIRsCi3HqAUnOAJ7ddLfzFKSPosDNAmpjxtVB7
         +rYysJNx5MYgAczRb9te4qT4P9aOq2N7rtiA3YF9M2Aj3UY+h8ArR9/PLYi2laCc10d6
         uXRdftp1021YcuEVqvpiUCo5wgTwDftMIKWcq34OXvhWu3K9UEOIIu/1ohIOv2HbVyeC
         sMQiDRSyQOwgb4hTy8S8/dRpIUV5wNAqJNBQlhtTDjkrB8p5N8sHkDEHWdsqEqIWhna4
         mzGeKzbUYa5snrUQ9wBA01Ki5f9cy//sPH6gFFjZnM+ogelAPwVG5S8ROCtQAyKaYtwe
         G4PQ==
X-Gm-Message-State: APjAAAX+7jVKREli7LDQ9qrKuCSFf2rUuBAjBknncxPB09tA3MoXFiUI
        up4nPFYAaWZRTTcFHfmk0R7VrGDynz/u70jgEng=
X-Google-Smtp-Source: APXvYqy77fxnNbU0ySEMGYLRSAU/KJTgLR+sbfYYRb2coLWfI/x05YJLeyUDUROvs/2TbdciONwjBNxBfdiQgUkdf64=
X-Received: by 2002:ac8:2dc3:: with SMTP id q3mr63772399qta.19.1555400690724;
 Tue, 16 Apr 2019 00:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190405131745.24727-1-bjorn.topel@gmail.com> <20190405131745.24727-2-bjorn.topel@gmail.com>
 <64259723-f0d8-8ade-467e-ad865add4908@intel.com> <20190415183258.36dcee9a@carbon>
In-Reply-To: <20190415183258.36dcee9a@carbon>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 16 Apr 2019 09:44:38 +0200
Message-ID: <CAJ+HfNj63QcLY8=y1fF93PZd3XcfiGSrbbWdiGByjTzZQydSSg@mail.gmail.com>
Subject: Re: Per-queue XDP programs, thoughts
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        maciej.fijalkowski@intel.com, Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
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

On Mon, 15 Apr 2019 at 18:33, Jesper Dangaard Brouer <brouer@redhat.com> wr=
ote:
>
>
> On Mon, 15 Apr 2019 13:59:03 +0200 Bj=C3=B6rn T=C3=B6pel <bjorn.topel@int=
el.com> wrote:
>
> > Hi,
> >
> > As you probably can derive from the amount of time this is taking, I'm
> > not really satisfied with the design of per-queue XDP program. (That,
> > plus I'm a terribly slow hacker... ;-)) I'll try to expand my thinking
> > in this mail!
> >
> > Beware, it's kind of a long post, and it's all over the place.
>
> Cc'ing all the XDP-maintainers (and netdev).
>
> > There are a number of ways of setting up flows in the kernel, e.g.
> >
> > * Connecting/accepting a TCP socket (in-band)
> > * Using tc-flower (out-of-band)
> > * ethtool (out-of-band)
> > * ...
> >
> > The first acts on sockets, the second on netdevs. Then there's ethtool
> > to configure RSS, and the RSS-on-steriods rxhash/ntuple that can steer
> > to queues. Most users care about sockets and netdevices. Queues is
> > more of an implementation detail of Rx or for QoS on the Tx side.
>
> Let me first acknowledge that the current Linux tools to administrator
> HW filters is lacking (well sucks).  We know the hardware is capable,
> as DPDK have an full API for this called rte_flow[1]. If nothing else
> you/we can use the DPDK API to create a program to configure the
> hardware, examples here[2]
>
>  [1] https://doc.dpdk.org/guides/prog_guide/rte_flow.html
>  [2] https://doc.dpdk.org/guides/howto/rte_flow.html
>
> > XDP is something that we can attach to a netdevice. Again, very
> > natural from a user perspective. As for XDP sockets, the current
> > mechanism is that we attach to an existing netdevice queue. Ideally
> > what we'd like is to *remove* the queue concept. A better approach
> > would be creating the socket and set it up -- but not binding it to a
> > queue. Instead just binding it to a netdevice (or crazier just
> > creating a socket without a netdevice).
>
> Let me just remind everybody that the AF_XDP performance gains comes
> from binding the resource, which allow for lock-free semantics, as
> explained here[3].
>
> [3] https://github.com/xdp-project/xdp-tutorial/tree/master/advanced03-AF=
_XDP#where-does-af_xdp-performance-come-from
>

Yes, but leaving the "binding to queue" to the kernel wouldn't really
change much. It would mostly be that the *user* doesn't need to care
about hardware details. My concern is about "what is a good
abstraction".

>
> > The socket is an endpoint, where I'd like data to end up (or get sent
> > from). If the kernel can attach the socket to a hardware queue,
> > there's zerocopy if not, copy-mode. Dito for Tx.
>
> Well XDP programs per RXQ is just a building block to achieve this.
>
> As Van Jacobson explain[4], sockets or applications "register" a
> "transport signature", and gets back a "channel".   In our case, the
> netdev-global XDP program is our way to register/program these transport
> signatures and redirect (e.g. into the AF_XDP socket).
> This requires some work in software to parse and match transport
> signatures to sockets.  The XDP programs per RXQ is a way to get
> hardware to perform this filtering for us.
>
>  [4] http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf
>

There are a lot of things that are missing to build what you're
describing above. Yes, we need a better way to program the HW from
Linux userland (old topic); What I fail to see is how per-queue XDP is
a way to get hardware to perform filtering. Could you give a
longer/complete example (obviously with non-existing features :-)), so
I get a better view what you're aiming for?


>
> > Does a user (control plane) want/need to care about queues? Just
> > create a flow to a socket (out-of-band or inband) or to a netdevice
> > (out-of-band).
>
> A userspace "control-plane" program, could hide the setup and use what
> the system/hardware can provide of optimizations.  VJ[4] e.g. suggest
> that the "listen" socket first register the transport signature (with
> the driver) on "accept()".   If the HW supports DPDK-rte_flow API we
> can register a 5-tuple (or create TC-HW rules) and load our
> "transport-signature" XDP prog on the queue number we choose.  If not,
> when our netdev-global XDP prog need a hash-table with 5-tuple and do
> 5-tuple parsing.
>
> Creating netdevices via HW filter into queues is an interesting idea.
> DPDK have an example here[5], on how to per flow (via ethtool filter
> setup even!) send packets to queues, that endup in SRIOV devices.
>
>  [5] https://doc.dpdk.org/guides/howto/flow_bifurcation.html
>
>
> > Do we envison any other uses for per-queue XDP other than AF_XDP? If
> > not, it would make *more* sense to attach the XDP program to the
> > socket (e.g. if the endpoint would like to use kernel data structures
> > via XDP).
>
> As demonstrated in [5] you can use (ethtool) hardware filters to
> redirect packets into VFs (Virtual Functions).
>
> I also want us to extend XDP to allow for redirect from a PF (Physical
> Function) into a VF (Virtual Function).  First the netdev-global
> XDP-prog need to support this (maybe extend xdp_rxq_info with PF + VF
> info).  Next configure HW filter to queue# and load XDP prog on that
> queue# that only "redirect" to a single VF.  Now if driver+HW supports
> it, it can "eliminate" the per-queue XDP-prog and do everything in HW.
>

Again, let's try to be more concrete! So, one (non-existing) mechanism
to program filtering to HW queues, and then attaching a per-queue
program to that HW queue, which can in some cases be elided? I'm not
opposing the idea of per-queue, I'm just trying to figure out
*exactly* what we're aiming for.

My concern is, again, mainly that is a queue abstraction something
we'd like to introduce to userland. It's not there (well, no really
:-)) today. And from an AF_XDP userland perspective that's painful.
"Oh, you need to fix your RSS hashing/flow." E.g. if I read what
Jonathan is looking for, it's more of something like what Jiri Pirko
suggested in [1] (slide 9, 10).

Hey, maybe I just need to see the fuller picture. :-) AF_XDP is too
tricky to use from XDP IMO. Per-queue XDP program would *optimize*
AF_XDP, but not solving the filtering. Maybe starting in the
filtering/metadata offload path end of things, and then see what we're
missing.

>
> > If we'd like to slice a netdevice into multiple queues. Isn't macvlan
> > or similar *virtual* netdevices a better path, instead of introducing
> > yet another abstraction?
>
> XDP redirect a more generic abstraction that allow us to implement
> macvlan.  Except macvlan driver is missing ndo_xdp_xmit. Again first I
> write this as global-netdev XDP-prog, that does a lookup in a BPF-map.
> Next I configure HW filters that match the MAC-addr into a queue# and
> attach simpler XDP-prog to queue#, that redirect into macvlan device.
>

Just for context; I was thinking something like macvlan with
ndo_dfwd_add/del_station functionality. "A virtual interface that is
simply is a view of a physical". A per-queue program would then mean
"create a netdev for that queue".

>
> > Further, is queue/socket a good abstraction for all devices? Wifi? By
> > just viewing sockets as an endpoint, we leave it up to the kernel to
> > figure out the best way. "Here's an endpoint. Give me data **here**."
> >
> > The OpenFlow protocol does however support the concept of queues per
> > port, but do we want to introduce that into the kernel?
> >
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
> > in hardware, do that. If not, emulate via XDP.
>
> That is actually the reason I want XDP per-queue, as it is a way to
> offload the filtering to the hardware.  And if the per-queue XDP-prog
> becomes simple enough, the hardware can eliminate and do everything in
> hardware (hopefully).
>
>
> > The control plane should IMO be outside of the XDP program.
> >
> > Ok, please convince me! :-D
>
> I tried to above...
>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>
>
> More use-cases for per-queue XDP-prog:
>
> XDP for containers
> ------------------
> XDP can redirect into veth, used for containers.  So, I want to
> implement container protection/isolation in XDP layer.  E.g. I only
> want my container to talk to 1 external src-IP to my container dst-IP
> on port 80.  I can implement that check in netdev-global XDP BPF-code.
> But I can also hardware "offload" this simple filter (via ethtool or
> rte_flow) and simplify the per-queue XDP-prog.  Given the queue now
> only receives traffic that match my desc, I have now protected/isolated
> the traffic to my container.
>

And are you sure that you'd like this at a queue granularity, and not
netdevice or socket?

>
> DPDK using per-queue AF_XDP
> ---------------------------
> AFAIK an AF_XDP PMD driver have been merged in DPDK (but I've not
> looked at the code).
>
> It would be very natural for DPDK to load per-queue XDP-progs for
> interfacing with AF_XDP, as they already have rte_flow API (see
> [1]+[2]) for configuring HW filters.  And loading per-queue XDP-progs
> would also avoid disturbing other users of XDP on same machine (if we
> choose the semantics defined in [6]).
>

Yes, here it would definitely help the PMD, but having a socket
without per-queue (bound directly w/o XDP ala the "built-in" path)
would help even more. I guess this part of the "does per-queue XDP
programs make sense for anyone else but AF_XDP".

> [6] https://github.com/xdp-project/xdp-project/blob/master/areas/core/xdp=
_per_rxq01.org#proposal-rxq-prog-takes-precedence


Bj=C3=B6rn

[1] https://www.netdevconf.org/0.1/docs/pirko-ovstc-slides.pdf
