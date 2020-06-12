Return-Path: <SRS0=5juC=7Z=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4466C433DF
	for <bpf@archiver.kernel.org>; Fri, 12 Jun 2020 22:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AECCE2078E
	for <bpf@archiver.kernel.org>; Fri, 12 Jun 2020 22:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9K+8RbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgFLWgD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLWgC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jun 2020 18:36:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B917C03E96F;
        Fri, 12 Jun 2020 15:36:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x18so12808161lji.1;
        Fri, 12 Jun 2020 15:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fryTqD33zhXlhU0VCShEW5yvvxlaiAEIgEkAK9Mfyxw=;
        b=G9K+8RbCufAaP0dcdaPuPYzZ5WrLepmeK8kU6p2w5bRIV/KpcpFyRSSDd9RLym2geU
         A6CQjKx4zmeUwWpBHqAiUdU1ipmNQ6i5RkkxuqN9ofOs2Z3ohgoqEIFNDNgLaXMtJ1Ps
         Xd4fhf3hb3Y9EYB91KlHSui/wluQUWTAhA2IZyh1O+HUh5EqyTpQYaaDYTOoGHa/NlsG
         MF+jDkS5mz40UGj1TBzXwU8UtWBtkC0sVGoo9GhHBXcc6P5NUMaVP6nmIPPI+ynQY19W
         N9ZDC0oBwAJ3tWfimtTEljahANK+V1JkrlLT0hxTwZdOat6vujMEVxqIgb/Ltm9RMQY1
         G6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fryTqD33zhXlhU0VCShEW5yvvxlaiAEIgEkAK9Mfyxw=;
        b=HA2stdWsAHwZGNwzzFcgEB6lZZeo62itV5QdwzpypoeJVPWMpDXL8wFVGOvYKPZ56H
         pWM3M1FoFIv+bPfnQIjvH0UBu+JdbSCvYQTCbzCHO9x5ThVGH0HTrdPSH30TYvQW5xeY
         1dbglej1hF/LmkcPLfc+kzzNOHRRYtmxHrKBjFFIFQptAf8waqsgT6HIaiqEQA6OGdQa
         /EO2qiDfxnerXWCv6G3kAaqdMcuXHk+jOPchn0DXI6gUcmkOtJQhjFydkOYCKxqUBg5J
         C6kxsyVTS+MbzUVBU4lApYJyZdaAlPcOtCjPSt2xcIjuMJgfzInCwapd6YDcqG/g7T3v
         f07w==
X-Gm-Message-State: AOAM531vpP26zXYApiMJcrOayg2h2f6rIS4BhuzteSK2cN11auo8C4pq
        AKBVJzxfcnAd0znOUZ8iLEfKoUwj5oB1GLfaiwbceg==
X-Google-Smtp-Source: ABdhPJyLqcf4/9DQJIzlsxTVHxCs5qShQXNQyQ5NEHHAYUIPhL0WcEiFdo7Vatdz+V9hFYH0CVkYvXrsYxgSHDpDvt0=
X-Received: by 2002:a2e:98d7:: with SMTP id s23mr8082293ljj.2.1592001360627;
 Fri, 12 Jun 2020 15:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200612160141.188370-1-lmb@cloudflare.com>
In-Reply-To: <20200612160141.188370-1-lmb@cloudflare.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 12 Jun 2020 15:35:49 -0700
Message-ID: <CAADnVQ+owOvkZ03qyodmh+4NkZD=1LpgTN+YJqiKgr0_OKqRtA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] flow_dissector: reject invalid attach_flags
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 12, 2020 at 9:02 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Using BPF_PROG_ATTACH on a flow dissector program supports neither flags
> nor target_fd but accepts any value. Return EINVAL if either are non-zero.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> Fixes: b27f7bb590ba ("flow_dissector: Move out netns_bpf prog callbacks")
> ---
>  kernel/bpf/net_namespace.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
> index 78cf061f8179..56133e78ae4f 100644
> --- a/kernel/bpf/net_namespace.c
> +++ b/kernel/bpf/net_namespace.c
> @@ -192,6 +192,9 @@ int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>         struct net *net;
>         int ret;
>
> +       if (attr->attach_flags || attr->target_fd)
> +               return -EINVAL;
> +

In theory it makes sense, but how did you test it?
test_progs -t flow
fails 5 tests.
