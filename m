Return-Path: <SRS0=TRWS=3N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824C3C32771
	for <bpf@archiver.kernel.org>; Fri, 24 Jan 2020 09:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C6F2075D
	for <bpf@archiver.kernel.org>; Fri, 24 Jan 2020 09:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SYiA638T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgAXJAP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:00:15 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46244 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgAXJAP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 04:00:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id 13so1151893oij.13
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2020 01:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5EdAX4jkVg2iEO+KKBvYFZ7L2IwmUhmxABZtxwTDV0=;
        b=SYiA638TtjKWHVPo9XbMk9DzdWhGr1CIMjfL5RmNwAC2FuJ6BOftRJALOXEDQiOQgD
         0fjQoQpuqFcsjWawODT6waRgT8tHbtcT5JbVS8ovS/gCJVG1G3aXBRiiXbpoEpsTruoE
         k8771UvRA3plyOhzpLxUGm4QDuiJyGVU7AgoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5EdAX4jkVg2iEO+KKBvYFZ7L2IwmUhmxABZtxwTDV0=;
        b=CSgUt57TVAH7xkcspFgHe8nRkpMDZfK8pMdAOFJI32bWTQF9MM8xgMnmqlv+UnDti8
         xLgsCjaIO72/tGR6y+qlfU6cD800trtuCerQzvcgjnHTMTdcbtW5G5e2p7iqbP1ifAUh
         hU7XASQJXyOrI6xPIAcmc1V0RFns2XPPb3M91Uh9WAIcXjxp6xYDvSHDPtKM6JnzJx5c
         9R+1jf/raaiEcvFizAIAbQUHckgIVJmOU380V5LA7UKj76Omgjt+3Gk0QgsdjWf/Kscr
         IfNHFvwvPaVsiLCdxNg6vdXNAvwtVXGYoBRtgoYLAyXckgxma6K4oZDKg6JB+OUhyvmC
         mUOg==
X-Gm-Message-State: APjAAAUJFFG4ahXTRkqANrQTf5Q1mV9Y9rpLjIURN8b4u4XxFp0K3lLy
        jxyh6UTP/CYWDyP2XGvYnLoczTJAlK3ayNaK6RKzCg==
X-Google-Smtp-Source: APXvYqwCWyvS3/fUmsDI0shGPjRGN1rHYxo1MRumsxADvX5K0fx2R5oslkof/sexUronmyCand4NPkj0N/nR2Fj0XYs=
X-Received: by 2002:aca:2419:: with SMTP id n25mr1382621oic.13.1579856414929;
 Fri, 24 Jan 2020 01:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20200123165934.9584-1-lmb@cloudflare.com> <20200123165934.9584-3-lmb@cloudflare.com>
 <20200123215348.zql3d5xpg2if7v6q@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200123215348.zql3d5xpg2if7v6q@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 24 Jan 2020 09:00:03 +0000
Message-ID: <CACAyw9_OGBbsXepTcp=1frEHB7Q2cD9BVXTbgt7Ci_eFyV2Egg@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] selftests: bpf: ignore RST packets for reuseport tests
To:     Martin Lau <kafai@fb.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 23 Jan 2020 at 21:54, Martin Lau <kafai@fb.com> wrote:
>
> btw, it needs a Fixes tag.
>
> Patch 4 and Patch 1 also need a Fixes tag.

This makes me wonder, should these go via bpf or bpf-next? Do I have
to split the series then?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
