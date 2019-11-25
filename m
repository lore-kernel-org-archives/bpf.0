Return-Path: <SRS0=POGc=ZR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6F4C432C3
	for <bpf@archiver.kernel.org>; Mon, 25 Nov 2019 11:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B062F2082F
	for <bpf@archiver.kernel.org>; Mon, 25 Nov 2019 11:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YalESrBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfKYLS2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:18:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36868 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727680AbfKYLS1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Nov 2019 06:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574680706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+QkeoDi6C/s/Wai3VV/W5MpT3HON3m8Sc3jHubbJpA=;
        b=YalESrBtnGRmISZ57aMXjZHg/ZHsp62uQ07o2PqDPUI1lMdQL1t/XfZQlP2z+l5DxUiZau
        N9Ff/eeUnmGHNQDxhSCbrN5S1+WNXwYEp40HdguOH20+AebOQof//0Q8TG0NhXmud0Mcpp
        kgwkA9kmjK87mKWOWh4AzXIguYdHqJQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-4-cBbpUcOyqmY7Rk2cHzAQ-1; Mon, 25 Nov 2019 06:18:23 -0500
Received: by mail-lj1-f198.google.com with SMTP id r5so2845560ljj.7
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2019 03:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9+QkeoDi6C/s/Wai3VV/W5MpT3HON3m8Sc3jHubbJpA=;
        b=KJCCcHjSkpFXzH8uhkvBBN9bGzr/lTrI1D59g1FG3bIWFMJJIU6x/ckzXWfdrzb3lx
         Z56gnEHIUipr6Z94OKRUEMDCsehvyaSrqjnqD/qEXmmpr8a3bR9Ej87TTP1ePN+IkTHj
         CJlW5EWAB3Bz4/4hzgXQS+oQLchmh6adLGHIK+gm/LmdWRsTnEyQjPcnoJj/punYLquH
         8wd/OLY4yt5k+ghi2yAHYNlLPZc5dfKM13qV2kccDDhEbXID7MY4G3Q5ZdV/e98ZdQyv
         sjwqgkTYbd2s83u6vNjty52Vq0yAcqqaiQLHiP3oK48r9hhJLNi+WZzMimHdDVeF+18l
         FASg==
X-Gm-Message-State: APjAAAU5kB/YTJ8xjJ1Td11OTsDZwxHRUq3s1AtYER2fOe2rt2GODyCu
        7qaR0J3zErCxyhdJefuC9MxO0i1MO3ee5MYmyBlWH+3X1eSa5U9LbwwEAyFeTlRSA/AMH6zdp6A
        rQme02mmKu03w
X-Received: by 2002:a05:651c:1109:: with SMTP id d9mr21442560ljo.192.1574680701857;
        Mon, 25 Nov 2019 03:18:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPy6wOmF2LQfj4FWc7dYOJYb1RomfucBYVY3QWXT0HGuhI9i+7oRdd07Y61ojInXNFry/Bxw==
X-Received: by 2002:a05:651c:1109:: with SMTP id d9mr21442543ljo.192.1574680701665;
        Mon, 25 Nov 2019 03:18:21 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z19sm3730033ljk.66.2019.11.25.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 03:18:20 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2DB371818BF; Mon, 25 Nov 2019 12:18:19 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        ecree@solarflare.com, andrii.nakryiko@gmail.com,
        tariqt@mellanox.com, saeedm@mellanox.com, maximmi@mellanox.com
Subject: Re: [PATCH bpf-next v2 2/6] xdp: introduce xdp_call
In-Reply-To: <20191123071226.6501-3-bjorn.topel@gmail.com>
References: <20191123071226.6501-1-bjorn.topel@gmail.com> <20191123071226.6501-3-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 25 Nov 2019 12:18:19 +0100
Message-ID: <875zj82ohw.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 4-cBbpUcOyqmY7Rk2cHzAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> The xdp_call.h header wraps a more user-friendly API around the BPF
> dispatcher. A user adds a trampoline/XDP caller using the
> DEFINE_XDP_CALL macro, and updates the BPF dispatcher via
> xdp_call_update(). The actual dispatch is done via xdp_call().
>
> Note that xdp_call() is only supported for builtin drivers. Module
> builds will fallback to bpf_prog_run_xdp().

I don't like this restriction. Distro kernels are not likely to start
shipping all the network drivers builtin, so they won't benefit from the
performance benefits from this dispatcher.

What is the reason these dispatcher blocks have to reside in the driver?
Couldn't we just allocate one system-wide, and then simply change
bpf_prog_run_xdp() to make use of it transparently (from the driver
PoV)? That would also remove the need to modify every driver...

-Toke

