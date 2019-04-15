Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D13EC282DA
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C81218DA
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfDORIr convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Mon, 15 Apr 2019 13:08:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45869 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfDORIr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:08:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so16350118ljd.12
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Yri80zieEBjydtXGCoQz97wR2F4miqNvd7mn+QXVZk8=;
        b=LXkEyPA1ppJnNAK3jsdg42+HErXk35CyrkGM6SN3c2XXnuIhd436+VA8oVoHqt/rcj
         +a/2SvCI/IBafkO2ObbSQ4GVFYccA/M4By4hLRXywe2Cq7NUDoK65eQOKct69AwkR99w
         YU3FAnIWDp3ZUSCxu/JXd0SfYG2WNbZkZUnegRdvKGtz5RtY9gyJiCgawV7Zmm45G9aJ
         uuqjzETGpSr1rcBnO6PTxWXuDRLKSrDVVJ0TJKRvZyQJgxXE2+LpBWV3IZ73J8Ul/odH
         qRRbbF4NLrPSqsTtyOFe7pXox6NhDdViPqigemuZ73156Rur0LhXhoddsDm/HCjhmn2a
         YIvA==
X-Gm-Message-State: APjAAAUqbVDrCB/DC4pw33GB1y+7tYcy04AlB2vsIU0SQOy3LBcZJXQV
        yHNmTd0I3D98i0HQ/IJobqjcGg==
X-Google-Smtp-Source: APXvYqxS04hoTKQ3OCCbDOqEI1jZuTtj/EIIQjSamC5M2NvHxdkbjX8hzprURUsqIBMQ3TGl/ue8JA==
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr3418676ljh.80.1555348124163;
        Mon, 15 Apr 2019 10:08:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.vpn.toke.dk. [2a00:7660:6da:10::2])
        by smtp.gmail.com with ESMTPSA id f18sm1835310lfh.39.2019.04.15.10.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 10:08:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CF5791800E8; Mon, 15 Apr 2019 18:08:40 +0100 (+01)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBl?= =?utf-8?B?bA==?= 
        <bjorn.topel@intel.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ilias.apalodimas@linaro.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, brouer@redhat.com,
        Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        David Miller <davem@davemloft.net>,
        Andy Gospodarek <andy@greyhouse.net>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Thomas Graf <tgraf@suug.ch>,
        Thomas Monjalon <thomas@monjalon.net>
Subject: Re: Per-queue XDP programs, thoughts
In-Reply-To: <20190415183258.36dcee9a@carbon>
References: <20190405131745.24727-1-bjorn.topel@gmail.com> <20190405131745.24727-2-bjorn.topel@gmail.com> <64259723-f0d8-8ade-467e-ad865add4908@intel.com> <20190415183258.36dcee9a@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 15 Apr 2019 18:08:40 +0100
Message-ID: <87v9zfurfr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Mon, 15 Apr 2019 13:59:03 +0200 Björn Töpel <bjorn.topel@intel.com> wrote:
>
>> Hi,
>> 
>> As you probably can derive from the amount of time this is taking, I'm
>> not really satisfied with the design of per-queue XDP program. (That,
>> plus I'm a terribly slow hacker... ;-)) I'll try to expand my thinking
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
>> The first acts on sockets, the second on netdevs. Then there's ethtool
>> to configure RSS, and the RSS-on-steriods rxhash/ntuple that can steer
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
> [3] https://github.com/xdp-project/xdp-tutorial/tree/master/advanced03-AF_XDP#where-does-af_xdp-performance-come-from
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
> netdev-global XDP program is our way to register/program these transport
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

I agree with the "per-queue XDP is a building block" sentiment, but I
think we really need to hash out the "control plane" part. Is it good
enough to make this userspace's problem, or should there be some kind of
kernel support? And if it's going to be userspace only, who is going to
write the demuxer that runs as the root program? Should we start a
separate project for this, should it be part of libbpf, or something
entirely different?

-Toke
