Return-Path: <SRS0=eni5=ST=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2B4C282DA
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 20:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9513217D7
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 20:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland-com.20150623.gappssmtp.com header.i=@herbertland-com.20150623.gappssmtp.com header.b="mWNyB866"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfDQURY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:17:24 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38238 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQURY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Apr 2019 16:17:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id g1so15174628qki.5
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2019 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4LEd19ThJwDixcXCOVGkeo4de9jeRtfEgDFgvPvmvPM=;
        b=mWNyB866eSr9OKbG1NPG9MWtZmkv8gkSIGHFV6ATNMj7F/MBYW/Qjkmc5rqn1S182v
         kc7fucD77oULQB/NF6FBPYeR0i05KnRn9suj2wMLDryVHqFT8NAZ+7kwzqcOl1rkpbjg
         /+Z2rWysoANn5h5pXAu1L/HfTWL0fOo6JF/255u4qplcG8LB/9VYKZoQanESPbyMGTyH
         EUh1ob0K9+5m3CbEkROz3lp0DDgNyYi2cVhFNKu9s/w9gU0x1/uf4VYc6T72Y0AK6mhs
         9fJvglOZe7Q1ki8Cdx8GQNe2VAep5QXCAcq/dGX/KRRKx5SV3cG1zsCiho8emC1NpPre
         +thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4LEd19ThJwDixcXCOVGkeo4de9jeRtfEgDFgvPvmvPM=;
        b=Oe8hgLhmaKtAu81nZm6mpV290ccfSH/yIkl1XbKqeapC5A2DOhqi9J0Kij7UrkypV3
         JFRI2luPhBxXMgN69aLMETpnMXGM6JTlS7at9Dg6pZU4V7vGK1Jhi3rYVnO4Dx63W30z
         dNrK6FmTJrfBJonRZITaKkEBeAz63Fstl1m2m/BKZuNXzdBkyrolSHarWC0vXK4M/zhQ
         RUj/hC2JAyitqMxHlpge4D1rJt6sigSSJpD0Yvaz4SiyiM+mFd5+IfqSsNZVrNQ1kqkK
         Z/xDruJnvPFMbqOIZ51tgP8R4IPGkx/dDpXESKWGqNPp2cL/cqTXGGSvFZvHMWB11rDT
         WDxg==
X-Gm-Message-State: APjAAAVmRvFLbdwebmL/2plQPnxIuYhWVtzFuzV6XeTLbvKZ6zfxnRgn
        1hOFNxqjSc5Y6/RDGb8sAudtK9QaHgnpQlY00nxwbw==
X-Google-Smtp-Source: APXvYqxvCWp8SviIsScP2fYNUwtihZpscjI4b8ZuA6B4IYRpZndwLGErg4T3FcwNKe21dv6NivOMDFDlzE3SkNSeSc8=
X-Received: by 2002:a05:620a:1529:: with SMTP id n9mr71555303qkk.190.1555532242728;
 Wed, 17 Apr 2019 13:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190405131745.24727-1-bjorn.topel@gmail.com> <20190405131745.24727-2-bjorn.topel@gmail.com>
 <64259723-f0d8-8ade-467e-ad865add4908@intel.com> <20190415183258.36dcee9a@carbon>
 <467AEB5A-DE90-4460-84EF-AFA33A7D6CD1@gmail.com> <20190416164834.2ce7e8ba@carbon>
In-Reply-To: <20190416164834.2ce7e8ba@carbon>
From:   Tom Herbert <tom@herbertland.com>
Date:   Wed, 17 Apr 2019 13:17:11 -0700
Message-ID: <CALx6S37yXuYkQwJK4L9piQgKXtEE0fcq61ZPcX8UQeq0AkcY=w@mail.gmail.com>
Subject: Re: Per-queue XDP programs, thoughts
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Jonathan Lemon <jonathan.lemon@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Thomas Graf <tgraf@suug.ch>,
        Thomas Monjalon <thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 16, 2019 at 7:48 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Mon, 15 Apr 2019 10:58:07 -0700
> "Jonathan Lemon" <jonathan.lemon@gmail.com> wrote:
>
> > On 15 Apr 2019, at 9:32, Jesper Dangaard Brouer wrote:
> >
> > > On Mon, 15 Apr 2019 13:59:03 +0200 Bj=C3=B6rn T=C3=B6pel
> > > <bjorn.topel@intel.com> wrote:
> > >
> > >> Hi,
> > >>
> > >> As you probably can derive from the amount of time this is taking,
> > >> I'm
> > >> not really satisfied with the design of per-queue XDP program. (That=
,
> > >> plus I'm a terribly slow hacker... ;-)) I'll try to expand my
> > >> thinking
> > >> in this mail!
> > >>
> > >> Beware, it's kind of a long post, and it's all over the place.
> > >
> > > Cc'ing all the XDP-maintainers (and netdev).
> > >
> > >> There are a number of ways of setting up flows in the kernel, e.g.
> > >>
> > >> * Connecting/accepting a TCP socket (in-band)
> > >> * Using tc-flower (out-of-band)
> > >> * ethtool (out-of-band)
> > >> * ...
> > >>
> > >> The first acts on sockets, the second on netdevs. Then there's
> > >> ethtool
> > >> to configure RSS, and the RSS-on-steriods rxhash/ntuple that can
> > >> steer
> > >> to queues. Most users care about sockets and netdevices. Queues is
> > >> more of an implementation detail of Rx or for QoS on the Tx side.
> > >
> > > Let me first acknowledge that the current Linux tools to administrato=
r
> > > HW filters is lacking (well sucks).  We know the hardware is capable,
> > > as DPDK have an full API for this called rte_flow[1]. If nothing else
> > > you/we can use the DPDK API to create a program to configure the
> > > hardware, examples here[2]
> > >
> > >  [1] https://doc.dpdk.org/guides/prog_guide/rte_flow.html
> > >  [2] https://doc.dpdk.org/guides/howto/rte_flow.html
> > >
> > >> XDP is something that we can attach to a netdevice. Again, very
> > >> natural from a user perspective. As for XDP sockets, the current
> > >> mechanism is that we attach to an existing netdevice queue. Ideally
> > >> what we'd like is to *remove* the queue concept. A better approach
> > >> would be creating the socket and set it up -- but not binding it to =
a
> > >> queue. Instead just binding it to a netdevice (or crazier just
> > >> creating a socket without a netdevice).
> > >
> > > Let me just remind everybody that the AF_XDP performance gains comes
> > > from binding the resource, which allow for lock-free semantics, as
> > > explained here[3].
> > >
> > > [3]
> > > https://github.com/xdp-project/xdp-tutorial/tree/master/advanced03-AF=
_XDP#where-does-af_xdp-performance-come-from
> > >
> > >
> > >> The socket is an endpoint, where I'd like data to end up (or get sen=
t
> > >> from). If the kernel can attach the socket to a hardware queue,
> > >> there's zerocopy if not, copy-mode. Dito for Tx.
> > >
> > > Well XDP programs per RXQ is just a building block to achieve this.
> > >
> > > As Van Jacobson explain[4], sockets or applications "register" a
> > > "transport signature", and gets back a "channel".   In our case, the
> > > netdev-global XDP program is our way to register/program these
> > > transport
> > > signatures and redirect (e.g. into the AF_XDP socket).
> > > This requires some work in software to parse and match transport
> > > signatures to sockets.  The XDP programs per RXQ is a way to get
> > > hardware to perform this filtering for us.
> > >
> > >  [4] http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf
> > >
> > >
> > >> Does a user (control plane) want/need to care about queues? Just
> > >> create a flow to a socket (out-of-band or inband) or to a netdevice
> > >> (out-of-band).
> > >
> > > A userspace "control-plane" program, could hide the setup and use wha=
t
> > > the system/hardware can provide of optimizations.  VJ[4] e.g. suggest
> > > that the "listen" socket first register the transport signature (with
> > > the driver) on "accept()".   If the HW supports DPDK-rte_flow API we
> > > can register a 5-tuple (or create TC-HW rules) and load our
> > > "transport-signature" XDP prog on the queue number we choose.  If not=
,
> > > when our netdev-global XDP prog need a hash-table with 5-tuple and do
> > > 5-tuple parsing.
> > >
> > > Creating netdevices via HW filter into queues is an interesting idea.
> > > DPDK have an example here[5], on how to per flow (via ethtool filter
> > > setup even!) send packets to queues, that endup in SRIOV devices.
> > >
> > >  [5] https://doc.dpdk.org/guides/howto/flow_bifurcation.html
> > >
> > >
> > >> Do we envison any other uses for per-queue XDP other than AF_XDP? If
> > >> not, it would make *more* sense to attach the XDP program to the
> > >> socket (e.g. if the endpoint would like to use kernel data structure=
s
> > >> via XDP).
> > >
> > > As demonstrated in [5] you can use (ethtool) hardware filters to
> > > redirect packets into VFs (Virtual Functions).
> > >
> > > I also want us to extend XDP to allow for redirect from a PF (Physica=
l
> > > Function) into a VF (Virtual Function).  First the netdev-global
> > > XDP-prog need to support this (maybe extend xdp_rxq_info with PF + VF
> > > info).  Next configure HW filter to queue# and load XDP prog on that
> > > queue# that only "redirect" to a single VF.  Now if driver+HW support=
s
> > > it, it can "eliminate" the per-queue XDP-prog and do everything in HW=
.
> >
> > One thing I'd like to see is have RSS distribute incoming traffic
> > across a set of queues.  The application would open a set of xsk's
> > which are bound to those queues.
>
> Yes. (Some) NIC hardware does support this RSS distribute incoming
> traffic across a set of queues.  As you can see in [5] they have an
> example of this:
>
>  testpmd> flow isolate 0 true
>  testpmd> flow create 0 ingress pattern eth / ipv4 / udp / vxlan vni is 4=
2 / end \
>           actions rss queues 0 1 2 3 end / end
>
>
> > I'm not seeing how a transport signature would achieve this.  The
> > current tooling seems to treat the queue as the basic building block,
> > which seems generally appropriate.
>
> After creating N-queue that your RSS-hash distribute over, I imagine
> that you load your per-queue XDP program on each of these N-queues.  I
> don't necessarily see a need for the kernel API to expose to userspace
> a API/facility to load an XDP-prog on N-queue in-one-go (you can just
> iterate over them).

Accelerated RFS does this. The idea is that hardware packet steering
can be programmed to steer packets to a certain queue based in 5-tuple
(or probably a hash of 4-tuple). Right now the implementation ties
this to canonical RFS which endeavours to steer packets to an
appropriate queue where application process is running, but the
hardware interface should be amenable to arbitrarily programming flows
to steer to certain queues. There is a question of whether the
steering needed to be perfect (exact 5-tuple is matched) or imperfect
(hash indexed into a table is okay), that depends on the isolation
model needed.

Tom

>
>
> > Whittling things down (receiving packets only for a specific flow)
> > could be achieved by creating a queue which only contains those
> > packets which atched via some form of classification (or perhaps
> > steered to a VF device), aka [5] above.   Exposing multiple queues
> > allows load distribution for those apps which care about it.
>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
