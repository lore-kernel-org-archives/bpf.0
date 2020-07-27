Return-Path: <SRS0=Ijne=BG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CFAC433E4
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 23:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF6020679
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595894274;
	bh=64Tf54q0Uk02BH0nMofvaNqTN8uJcrlbmqOWvVtow2E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Uqtgmeiihl6pXEJLZtCjPnWfo5nuum55WP5o46GjzlE5FuuYCfYEn6TtcEwxbJRQg
	 TH8ni08pLTJf83nTMPquszjrpsX9JEmp5Jn40SgSMsy+RAfcXaUarHexUUMAcfeKiN
	 g/WyBUNMVxFQvkLJ27Q+sr8qoNPFmWvJJhIy9knU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgG0X5x (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0X5x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jul 2020 19:57:53 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6243920729;
        Mon, 27 Jul 2020 23:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595894272;
        bh=64Tf54q0Uk02BH0nMofvaNqTN8uJcrlbmqOWvVtow2E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pXoMNgSF7CMf+LddKHhsVXTxUuMmkr96dFKcgR9rt8n/h+A2kDUOG9o/otfjcpPq3
         zOgdtBNurRKkZI79+Boo2o8OfiV2K16KrqH17JAIKd6W0mBZH7k2mZriFO6+fPW7J9
         ShR1jmcYvp9//qymmHw2DMAy/4d09sw/1c38qVLg=
Received: by mail-lf1-f54.google.com with SMTP id h8so9964129lfp.9;
        Mon, 27 Jul 2020 16:57:52 -0700 (PDT)
X-Gm-Message-State: AOAM532MKHRMQ1CncgbBg+u5V5JWGUrHi1vZVT09CEIUMteAksh6hmDB
        GX7JFBMrwl1NqWlwC0VgW1FaIMrweqJL8vaXk/M=
X-Google-Smtp-Source: ABdhPJyGR/xZdAITU/xoHU5WfqoJmUVbS0VWXHUARaTHDzVk/CdAOv2HkBEljuEFHMlbnkcaIW6ftZvGIWh2vBK3QAA=
X-Received: by 2002:a19:c501:: with SMTP id w1mr12147381lfe.172.1595894270760;
 Mon, 27 Jul 2020 16:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200727184506.2279656-1-guro@fb.com> <20200727184506.2279656-11-guro@fb.com>
In-Reply-To: <20200727184506.2279656-11-guro@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Jul 2020 16:57:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6kEhrYKkGKrPH5+xT_8CutfFicC3SKFcLDg-rLODVM5A@mail.gmail.com>
Message-ID: <CAPhsuW6kEhrYKkGKrPH5+xT_8CutfFicC3SKFcLDg-rLODVM5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 10/35] bpf: memcg-based memory accounting for
 socket storage maps
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 27, 2020 at 12:28 PM Roman Gushchin <guro@fb.com> wrote:
>
> Account memory used by the socket storage.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  net/core/bpf_sk_storage.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index eafcd15e7dfd..fbcd03cd00d3 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -130,7 +130,8 @@ static struct bpf_sk_storage_elem *selem_alloc(struct bpf_sk_storage_map *smap,
>         if (charge_omem && omem_charge(sk, smap->elem_size))
>                 return NULL;
>
> -       selem = kzalloc(smap->elem_size, GFP_ATOMIC | __GFP_NOWARN);
> +       selem = kzalloc(smap->elem_size,
> +                       GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT);
>         if (selem) {
>                 if (value)
>                         memcpy(SDATA(selem)->data, value, smap->map.value_size);
> @@ -337,7 +338,8 @@ static int sk_storage_alloc(struct sock *sk,
>         if (err)
>                 return err;
>
> -       sk_storage = kzalloc(sizeof(*sk_storage), GFP_ATOMIC | __GFP_NOWARN);
> +       sk_storage = kzalloc(sizeof(*sk_storage),
> +                            GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT);
>         if (!sk_storage) {
>                 err = -ENOMEM;
>                 goto uncharge;
> @@ -677,7 +679,7 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
>         u64 cost;
>         int ret;
>
> -       smap = kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN);
> +       smap = kzalloc(sizeof(*smap), GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT);
>         if (!smap)
>                 return ERR_PTR(-ENOMEM);
>         bpf_map_init_from_attr(&smap->map, attr);
> @@ -695,7 +697,7 @@ static struct bpf_map *bpf_sk_storage_map_alloc(union bpf_attr *attr)
>         }
>
>         smap->buckets = kvcalloc(sizeof(*smap->buckets), nbuckets,
> -                                GFP_USER | __GFP_NOWARN);
> +                                GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT);
>         if (!smap->buckets) {
>                 bpf_map_charge_finish(&smap->map.memory);
>                 kfree(smap);
> @@ -1024,7 +1026,7 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
>         }
>
>         diag = kzalloc(sizeof(*diag) + sizeof(diag->maps[0]) * nr_maps,
> -                      GFP_KERNEL);
> +                      GFP_KERNEL | __GFP_ACCOUNT);
>         if (!diag)
>                 return ERR_PTR(-ENOMEM);
>
> --
> 2.26.2
>
