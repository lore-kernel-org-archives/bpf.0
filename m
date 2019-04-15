Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66377C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C97920818
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wsb9tMnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfDOR6L (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:58:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35840 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfDOR6L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:58:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so8957877pgc.3;
        Mon, 15 Apr 2019 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyjBHUGs9nRHhi4YHfsvzYQZuspbT39TbXZjj8zA84c=;
        b=Wsb9tMnE+KjS2UmW8be8JXFjeB14Z12wfq6c45hJxY8s8WaTXpDNrkCcQclOQlcMAe
         /LWQkGibfhMoiDa1E6UBTHz/Gf3I65WhuyMuKMRwZ0nxZ5ZmcisDiANze54TlzeT0vBb
         UKIzfhChV/KBXjBCj6xzv1cgYGO/hDDhcFei2GUUaeElpl+u8soD2cj8nWYdlKhWICZc
         WdIBEQNR0gF8rN244l+HxHnGlODK5E5Q3p+ndGOoLD1gmtRNr9Wu9mQQWdIwCncCZ3Pv
         5JI0HfY2gnmQVHDNfzITGwOvPzS07vmA+zxFPdfM96nxn03rSeliQFvwzReYw8nXr9/j
         dgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyjBHUGs9nRHhi4YHfsvzYQZuspbT39TbXZjj8zA84c=;
        b=Rq2RqoOZ/rApa8SdMz0vhyJyeQAhEqmDg6Vg80IW6X7gXdSyr0BqmAITDKaV63cRX1
         ieu9mFcq/2jZMoXOkRls3iV+Sp/H1TNHSuaTETIuUDIgH++wLYXHxt2DpEJ4rwZxVYy/
         CNxC5L85L6TIU4zcFo5KsYYD3TXOxo9xBLn6x7EXBUTn6pRjWNBhcgVuS7xXsVdoE52G
         60wE8ZXyMqwq+rRfiv9EKODndqkVjNuRs6z8km4dMZZLmH4IaYqdXLuD5j94LYzRcBoW
         94G2ro7dc4LQ13Bl5mZWpXTnR4dFpzA9zbjGIggyYMCHfC7NS4H9EuwZxa4HIsaL793k
         a0jw==
X-Gm-Message-State: APjAAAXrezlqZ9Y3nmyy34Odrc1pLGn4m6ighgW25rpUAnGhmNIU6n5L
        waZ356h7WzS03V1lOs9bKrY=
X-Google-Smtp-Source: APXvYqxi+bsOyxo9QrQOSP+Roz15RsqXgasJCouy8V455NmoS/gxP915zYUa1RzGdFvsz1FLKZIlbA==
X-Received: by 2002:aa7:8453:: with SMTP id r19mr78508448pfn.44.1555351090632;
        Mon, 15 Apr 2019 10:58:10 -0700 (PDT)
Received: from [172.20.164.229] ([2620:10d:c090:180::9deb])
        by smtp.gmail.com with ESMTPSA id m69sm72740105pfi.151.2019.04.15.10.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 10:58:09 -0700 (PDT)
From:   "Jonathan Lemon" <jonathan.lemon@gmail.com>
To:     "Jesper Dangaard Brouer" <brouer@redhat.com>
Cc:     "=?utf-8?b?QmrDtnJuIFTDtnBlbA==?=" <bjorn.topel@intel.com>,
        "=?utf-8?b?QmrDtnJuIFTDtnBlbA==?=" <bjorn.topel@gmail.com>,
        ilias.apalodimas@linaro.org, toke@redhat.com,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        "Jason Wang" <jasowang@redhat.com>,
        "Alexei Starovoitov" <ast@fb.com>,
        "Daniel Borkmann" <borkmann@iogearbox.net>,
        "Jakub Kicinski" <jakub.kicinski@netronome.com>,
        "John Fastabend" <john.fastabend@gmail.com>,
        "David Miller" <davem@davemloft.net>,
        "Andy Gospodarek" <andy@greyhouse.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, "Thomas Graf" <tgraf@suug.ch>,
        "Thomas Monjalon" <thomas@monjalon.net>
Subject: Re: Per-queue XDP programs, thoughts
Date:   Mon, 15 Apr 2019 10:58:07 -0700
X-Mailer: MailMate (1.12.4r5594)
Message-ID: <467AEB5A-DE90-4460-84EF-AFA33A7D6CD1@gmail.com>
In-Reply-To: <20190415183258.36dcee9a@carbon>
References: <20190405131745.24727-1-bjorn.topel@gmail.com>
 <20190405131745.24727-2-bjorn.topel@gmail.com>
 <64259723-f0d8-8ade-467e-ad865add4908@intel.com>
 <20190415183258.36dcee9a@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 15 Apr 2019, at 9:32, Jesper Dangaard Brouer wrote:

> On Mon, 15 Apr 2019 13:59:03 +0200 Bj=C3=B6rn T=C3=B6pel =

> <bjorn.topel@intel.com> wrote:
>
>> Hi,
>>
>> As you probably can derive from the amount of time this is taking, =

>> I'm
>> not really satisfied with the design of per-queue XDP program. (That,
>> plus I'm a terribly slow hacker... ;-)) I'll try to expand my =

>> thinking
>> in this mail!
>>
>> Beware, it's kind of a long post, and it's all over the place.
>
> Cc'ing all the XDP-maintainers (and netdev).
>
>> There are a number of ways of setting up flows in the kernel, e.g.
>>
>> * Connecting/accepting a TCP socket (in-band)
>> * Using tc-flower (out-of-band)
>> * ethtool (out-of-band)
>> * ...
>>
>> The first acts on sockets, the second on netdevs. Then there's =

>> ethtool
>> to configure RSS, and the RSS-on-steriods rxhash/ntuple that can =

>> steer
>> to queues. Most users care about sockets and netdevices. Queues is
>> more of an implementation detail of Rx or for QoS on the Tx side.
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
>> XDP is something that we can attach to a netdevice. Again, very
>> natural from a user perspective. As for XDP sockets, the current
>> mechanism is that we attach to an existing netdevice queue. Ideally
>> what we'd like is to *remove* the queue concept. A better approach
>> would be creating the socket and set it up -- but not binding it to a
>> queue. Instead just binding it to a netdevice (or crazier just
>> creating a socket without a netdevice).
>
> Let me just remind everybody that the AF_XDP performance gains comes
> from binding the resource, which allow for lock-free semantics, as
> explained here[3].
>
> [3] =

> https://github.com/xdp-project/xdp-tutorial/tree/master/advanced03-AF_X=
DP#where-does-af_xdp-performance-come-from
>
>
>> The socket is an endpoint, where I'd like data to end up (or get sent
>> from). If the kernel can attach the socket to a hardware queue,
>> there's zerocopy if not, copy-mode. Dito for Tx.
>
> Well XDP programs per RXQ is just a building block to achieve this.
>
> As Van Jacobson explain[4], sockets or applications "register" a
> "transport signature", and gets back a "channel".   In our case, the
> netdev-global XDP program is our way to register/program these =

> transport
> signatures and redirect (e.g. into the AF_XDP socket).
> This requires some work in software to parse and match transport
> signatures to sockets.  The XDP programs per RXQ is a way to get
> hardware to perform this filtering for us.
>
>  [4] http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf
>
>
>> Does a user (control plane) want/need to care about queues? Just
>> create a flow to a socket (out-of-band or inband) or to a netdevice
>> (out-of-band).
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
>> Do we envison any other uses for per-queue XDP other than AF_XDP? If
>> not, it would make *more* sense to attach the XDP program to the
>> socket (e.g. if the endpoint would like to use kernel data structures
>> via XDP).
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

One thing I'd like to see is have RSS distribute incoming traffic
across a set of queues.  The application would open a set of xsk's which
are bound to those queues.

I'm not seeing how a transport signature would achieve this.  The =

current
tooling seems to treat the queue as the basic building block, which =

seems
generally appropriate.

Whittling things down (receiving packets only for a specific flow) could
be achieved by creating a queue which only contains those packets which
atched via some form of classification (or perhaps steered to a VF =

device),
aka [5] above.   Exposing multiple queues allows load distribution for
those apps which care about it.
-- =

Jonathan
