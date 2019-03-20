Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51529C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 13:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285D32184D
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 13:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfCTN6A (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:58:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41135 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfCTN6A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 09:58:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id a25so2060219edc.8
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 06:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KC4FIyLHteWkQoaf8mTr6huUmDoWsoCjQKmD+Ta3S54=;
        b=E67j8D8r7Kri7pRP3+BVg/yc27gmr9PuR1NB7St1+3BwocqXZIeNKmU6IdC+qPl+Nh
         BYRm2dHsTJMj1jE0EQP/X27xvuYk8Om8dT+bu1yPqXMj4mVR7m7yNGJBcY+yHMzoVEne
         5Qr/vPPB5o0PCtMDns2zEz9oJakDBElyJDk4vY5QKfBisumDDU3oYHoDfaJ5MveMCMOy
         xIVv7C0iWCjYcPrE5d4q5gB6HWF8kUZi0wEulm52tRmRvsAPlGAj8paLV2VNDtpuILBN
         N7K2h6rO6gNIJHWHBOsw31CXdTbCXH5Sm8ru5RZ3+FYaeTY7CgBicthFZ8SjDLXc9eFq
         d3sg==
X-Gm-Message-State: APjAAAWvpX79CQaJjz7vZAdZQUofl6wZRfzXtFQCIDPDDg+GCX+snT4q
        E1UCJpZI84Dbe+s6DulMVqQcxw==
X-Google-Smtp-Source: APXvYqw17+msBUETR6Y/C8AU04MVXOx5m5eoK1pOFX8WaJkdAta1ev6hJEp9uteVFk9NhzG+FemP1A==
X-Received: by 2002:a17:906:5595:: with SMTP id y21mr17082918ejp.209.1553090278933;
        Wed, 20 Mar 2019 06:57:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.vpn.toke.dk. [2a00:7660:6da:10::2])
        by smtp.gmail.com with ESMTPSA id i20sm430937ejv.26.2019.03.20.06.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:57:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 40E7C18200F; Wed, 20 Mar 2019 14:57:57 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        "songliubraving\@fb.com" <songliubraving@fb.com>,
        "daniel\@iogearbox.net" <daniel@iogearbox.net>,
        "andrew.gospodarek\@broadcom.com" <andrew.gospodarek@broadcom.com>,
        "jesper.brouer\@gmail.com" <jesper.brouer@gmail.com>,
        "bblanco\@gmail.com" <bblanco@gmail.com>,
        "jakub.kicinski\@netronome.com" <jakub.kicinski@netronome.com>,
        "alexei.starovoitov\@gmail.com" <alexei.starovoitov@gmail.com>,
        "bjorn.topel\@gmail.com" <bjorn.topel@gmail.com>,
        "kafai\@fb.com" <kafai@fb.com>
Cc:     "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "iovisor-dev\@lists.iovisor.org" <iovisor-dev@lists.iovisor.org>
Subject: Re: [RFC][Proposal] BPF Control MAP
In-Reply-To: <df010a2772ae07af29c9aac1c6d329b14203710c.camel@mellanox.com>
References: <df010a2772ae07af29c9aac1c6d329b14203710c.camel@mellanox.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Mar 2019 14:57:57 +0100
Message-ID: <87tvfxr6l6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Saeed Mahameed <saeedm@mellanox.com> writes:

> In this proposal I am going to address the lack of a unified user API
> for accessing and manipulating BPF system attributes, while this
> proposal is generic and will work on any BPF subsystem (eBPF attach
> points), I will mostly focus on XDP use cases.
>
> So lately I started working on three different XDP open issues, namely
> XDP statistic, XDP redirect and XDP meta-data, while the details of
> these issues are not really relevant for the sake of this proposal, all
> of them share one common problem: the lack of unified user interface to
> manipulate and access their attributes.
>
> Examples:
> 1. Query XDP statistics.
> 2. XDP resource management, Setup XDP-redirect TX resources.
> 3. Setup and query XDP-metadata - (BTF data structure).
>
> Jesper Brouer, explains some of these issues in details at:
> https://github.com/xdp-project/xdp-project/blob/master/xdp-project.org
>
> Yes I considered, netlink, devlink, ethtool, sysctrl, etc .. but each
> one of them has it's own drawback, they are networking specific and
> will not serve the BPF general purpose.

The one concern I have with this is that it makes XDP configuration
different from regular networking configuration. One of the compelling
features of XDP is that it is less surprising than kernel offloads,
because that you can interface with it using the regular kernel tooling.
This is less the case if we're doing a BPF-specific thing...

Or to put it another way, in my mind XDP is a networking technology that
happens to use eBPF, more than it is an eBPF usage that happens to
process packets; and I think it would make more sense for the userspace
tooling to reflect this.

That being said, I do agree that there are some cool ideas in your
example, such as using BTF to express the statistics format, and the
automatic enumeration of objects.

-Toke
