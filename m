Return-Path: <SRS0=Ijne=BG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7048EC433E5
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 23:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B08B20679
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 23:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595894138;
	bh=pHjiLeoU+cX63+bW1MkEcT8iLXwc+EynwUf5ut3ZYrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tzgu9zknq+XKYNhViz2KdCr0Gutur0zqL0jx/JNg7/eXY+wifQpvRDlXAhepaqBre
	 XSVcIixDOY3TbJ47XTgCZMwOk7dVtwuDHYo281mobq4MxMo9bXYOdKTQeIDL7Jcm5v
	 TcZkM67KSYfdFWP+xHg5TrCVKU6QwRa3A9VL0sWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgG0Xza (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgG0Xz3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jul 2020 19:55:29 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6342B20809;
        Mon, 27 Jul 2020 23:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595894128;
        bh=pHjiLeoU+cX63+bW1MkEcT8iLXwc+EynwUf5ut3ZYrY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U9FV4pir1v6rNVwRzwowB/oJrG0wJnrWZidOTdKkrTJCzAumBp8hLjT1x8r8BMpSd
         +qc+z5YKwo8lkdi9SuoXvrISkSdzkGTil0omZV9KnZWlMFRFKbCEr4ZW1GzwLQ3g2/
         92R7ewWlJ9Kv6riE+UqmiJ97RMjhETH1fdy8dCqg=
Received: by mail-lf1-f41.google.com with SMTP id d2so4353633lfj.1;
        Mon, 27 Jul 2020 16:55:28 -0700 (PDT)
X-Gm-Message-State: AOAM533P5X+U+2/JsJbw2N7Xb6WAQnUcAgeInqNKhMeKKcxuPXl79Da4
        vMpwGbFyurrXTxIMcFbTWalGq7M9n1KfBvtvQaU=
X-Google-Smtp-Source: ABdhPJwCoNjBOotkD3JErxFWrav0c+OdEiHZY2bWXHIRt1gsDevMf2lrjsu0Kj21lv686rLhe+6k0VH6gY72B5qrUhw=
X-Received: by 2002:a05:6512:3a5:: with SMTP id v5mr12643913lfp.138.1595894126814;
 Mon, 27 Jul 2020 16:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200727184506.2279656-1-guro@fb.com> <20200727184506.2279656-9-guro@fb.com>
In-Reply-To: <20200727184506.2279656-9-guro@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Jul 2020 16:55:15 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4jUcPD6KPYiFoSRcVucGqry4FdEXs2re0qR00VWL6vug@mail.gmail.com>
Message-ID: <CAPhsuW4jUcPD6KPYiFoSRcVucGqry4FdEXs2re0qR00VWL6vug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/35] bpf: memcg-based memory accounting for
 lpm_trie maps
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

On Mon, Jul 27, 2020 at 12:22 PM Roman Gushchin <guro@fb.com> wrote:
>
> Include lpm trie and lpm trie node objects into the memcg-based memory
> accounting.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/bpf/lpm_trie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 44474bf3ab7a..d85e0fc2cafc 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -282,7 +282,7 @@ static struct lpm_trie_node *lpm_trie_node_alloc(const struct lpm_trie *trie,
>         if (value)
>                 size += trie->map.value_size;
>
> -       node = kmalloc_node(size, GFP_ATOMIC | __GFP_NOWARN,
> +       node = kmalloc_node(size, GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT,
>                             trie->map.numa_node);
>         if (!node)
>                 return NULL;
> @@ -557,7 +557,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
>             attr->value_size > LPM_VAL_SIZE_MAX)
>                 return ERR_PTR(-EINVAL);
>
> -       trie = kzalloc(sizeof(*trie), GFP_USER | __GFP_NOWARN);
> +       trie = kzalloc(sizeof(*trie), GFP_USER | __GFP_NOWARN | __GFP_ACCOUNT);
>         if (!trie)
>                 return ERR_PTR(-ENOMEM);
>
> --
> 2.26.2
>
