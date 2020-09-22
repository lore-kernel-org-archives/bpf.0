Return-Path: <SRS0=pAHC=C7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10862C2D0E2
	for <bpf@archiver.kernel.org>; Tue, 22 Sep 2020 09:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57F820C09
	for <bpf@archiver.kernel.org>; Tue, 22 Sep 2020 09:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="y2EgvZkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIVJRd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 22 Sep 2020 05:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgIVJRd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Sep 2020 05:17:33 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186CAC0613CF
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 02:17:33 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a3so20334368oib.4
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7RXae/aOLNMnxlMYIGKwG05c4UMKJkn0dioq6hp9j5w=;
        b=y2EgvZklRCT4oZaqKxrpjfur/PnS8PmSZ4Qq8XB6E80yo3uPbfWhA/u1I7Nkj8cryx
         zT15fxmn+uS2tkZClaZL/SjDOx7wV9fqywYMylqosUP2XJXjAQTzCNTki4q0e4GChufj
         8UEEAKsOEXhCBhE9AlTzwC6Sj0wRqi5NL7e+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RXae/aOLNMnxlMYIGKwG05c4UMKJkn0dioq6hp9j5w=;
        b=lJ/W0N7KVPp0ASd/P1OTnhbMeX9CLG2NajzbFzVZ7ERkAOmQZxaV4TGtfE8mWfgexT
         4HGWZUM3kKn5POY7qdJn/rS+PmgRkJKRVqPNWTazDSEIzOyuNnMcX4HywM04YU4WK2tw
         f3m7HO++zBStNIvtgV4YyT4T2o22BA0s9WdqI+oGJHbep7hO4TdAeEJfE2mJPbhcnw7b
         p/papBP5i1ZMZhLmyepAADzt+d2bqrzmufJtBJmORIpscKWaQtnytqzNzMsBw41/iOtX
         PsY61GVl8WgsrSEwO/WRV/yL81N+5lrVEsKhRynKuKnYwA6WjwRRGp/IEdEHcBuZvDcE
         xYjQ==
X-Gm-Message-State: AOAM532tf6399nW4wnjlO8qWJqytIVhiXjUaHSu0LkR97Kn0lAWPr6Xa
        mBfNqie4l+AtPE2jkFNjliC76oFFBRFwkl1Vs511ug==
X-Google-Smtp-Source: ABdhPJwxoiCqTJn47bYmsH5M5lqR1JRbxS6BeR3ZxxGjJGLL+fiuuueNz/1UphFA6M3RH0H9W25fqb16NzMqKm5NkO0=
X-Received: by 2002:aca:f0a:: with SMTP id 10mr2116399oip.13.1600766252401;
 Tue, 22 Sep 2020 02:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200922070409.1914988-1-kafai@fb.com> <20200922070434.1919082-1-kafai@fb.com>
In-Reply-To: <20200922070434.1919082-1-kafai@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 22 Sep 2020 10:17:20 +0100
Message-ID: <CACAyw98FbjdmaVQJcuVPSmb40fLG_QnrkMJ2pUaJPdSSTwLp5g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 04/11] bpf: Change bpf_sk_storage_*() to
 accept ARG_PTR_TO_BTF_ID_SOCK_COMMON
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 22 Sep 2020 at 08:04, Martin KaFai Lau <kafai@fb.com> wrote:
>
> This patch changes the bpf_sk_storage_*() to take
> ARG_PTR_TO_BTF_ID_SOCK_COMMON such that they will work with the pointer
> returned by the bpf_skc_to_*() helpers also.
>
> A micro benchmark has been done on a "cgroup_skb/egress" bpf program
> which does a bpf_sk_storage_get().  It was driven by netperf doing
> a 4096 connected UDP_STREAM test with 64bytes packet.
> The stats from "kernel.bpf_stats_enabled" shows no meaningful difference.
>
> The sk_storage_get_btf_proto, sk_storage_delete_btf_proto,
> btf_sk_storage_get_proto, and btf_sk_storage_delete_proto are
> no longer needed, so they are removed.
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

I like that we can get rid of the init code.

Acked-by: Lorenz Bauer <lmb@cloudflare.com>

--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
