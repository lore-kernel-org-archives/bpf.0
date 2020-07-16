Return-Path: <SRS0=dSfD=A3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B864C433E0
	for <bpf@archiver.kernel.org>; Thu, 16 Jul 2020 02:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CEB20775
	for <bpf@archiver.kernel.org>; Thu, 16 Jul 2020 02:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXe4Ex1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGPCNm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGPCNl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jul 2020 22:13:41 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7397EC061755;
        Wed, 15 Jul 2020 19:13:41 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j80so4129967qke.0;
        Wed, 15 Jul 2020 19:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7E9BVMX3xbajDKW8TkzON6bpuLq1w2FgoL2inn/V9dU=;
        b=DXe4Ex1q0x0bWrktr+uWtNgh+8pRvGvrgvHdpFt68WrdJUs5Dps41xSc7q3CZpNb0w
         kxo58EUgLADrgphNqPaiPj8hsI7BCrO7HXAU+MSpImNveVwmoO3dHfKGTG4/Y25sQOfq
         IiITwKlzPx4FHu2G7IRFzUncWDMmkjV/tgbOSq0XV/zr0oTuEddes9gLV/WWy+cYauP5
         lthf/Au4aM8iyVyDLZD8/qMT5/or9Lz9dV0+4zqiA6TA79JVHDl0/1dvBk8rkwvWOEdN
         1+rNGvgMMno1CMqTCqHIMt+2Bf/58SOX9Tr3thvFI+nWJk0x9MY3/HQcDlatM8w/IjFX
         pHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7E9BVMX3xbajDKW8TkzON6bpuLq1w2FgoL2inn/V9dU=;
        b=nr8iH0ZQXvTe7OuCTh+LfwQZbYy5fm+gmN7m6EENFfAV7k6/+hc8NBVL2UlyxzGX89
         YAJip5cxYPsq7PjuRKR70alWXZ2COJG9p7EGC7dNnfWhbLN4kOPKHms5LeiK0ZvPx/WY
         j6TQ41Eh17ZSf8jlw9O6btx6JTSdhXX96gTXbab6o9Ry3QIKC7Iu2zqjcZrWv4GUUWR4
         lkzb/PzYlNhPNy/MEyrZ7qpjRusW049YXcHT+eDFeddHr3W2mOX+LOZ08mN6s4a1x1xA
         ljGgJAI1xSMX2Mm+vdDalAUGVxdPeydQi36ArNuaOaSJJYcEajMnqIEffSGc+R8N9cxk
         4wsg==
X-Gm-Message-State: AOAM532wWJc6DDU8q+HdbCgXYU4mkLIAiiE4gH46s1atAyvZrkSWzTB8
        eyR5y8brcI5BwJuwTVNbgH5hSSYfZe7iXAQEXB8=
X-Google-Smtp-Source: ABdhPJzI36myxb64lOG91jGFwO1yx6VQ4i4ii39aR188oxAsMkYIKn3BcGI7rbOdeNyzkt7tBUX3vWKG8lmb2aRD8io=
X-Received: by 2002:a05:620a:2409:: with SMTP id d9mr2013211qkn.36.1594865620585;
 Wed, 15 Jul 2020 19:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200713174654.642628-1-jakub@cloudflare.com> <20200713174654.642628-15-jakub@cloudflare.com>
In-Reply-To: <20200713174654.642628-15-jakub@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 15 Jul 2020 19:13:29 -0700
Message-ID: <CAEf4Bzamw5ENe8dL1w0uLY9ggdu0cB7B9HDgxcQiFfyYf4ErMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 14/16] selftests/bpf: Add verifier tests for
 bpf_sk_lookup context access
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 13, 2020 at 10:48 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> Exercise verifier access checks for bpf_sk_lookup context fields.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

> Notes:
>     v4:
>     - Bring back tests for narrow loads.
>
>     v3:
>     - Consolidate ACCEPT tests into one.
>     - Deduplicate REJECT tests and arrange them into logical groups.
>     - Add tests for out-of-bounds and unaligned access.
>     - Cover access to newly introduced 'sk' field.
>
>     v2:
>      - Adjust for fields renames in struct bpf_sk_lookup.
>
>  .../selftests/bpf/verifier/ctx_sk_lookup.c    | 471 ++++++++++++++++++
>  1 file changed, 471 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/verifier/ctx_sk_lookup.c
>

[...]

> +               /* 1-byte read from local_port field */
> +               BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
> +                           offsetof(struct bpf_sk_lookup, local_port)),
> +               BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
> +                           offsetof(struct bpf_sk_lookup, local_port) + 1),
> +               BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
> +                           offsetof(struct bpf_sk_lookup, local_port) + 2),
> +               BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_1,
> +                           offsetof(struct bpf_sk_lookup, local_port) + 3),
> +               /* 2-byte read from local_port field */
> +               BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
> +                           offsetof(struct bpf_sk_lookup, local_port)),
> +               BPF_LDX_MEM(BPF_H, BPF_REG_0, BPF_REG_1,
> +                           offsetof(struct bpf_sk_lookup, local_port) + 2),
> +               /* 4-byte read from local_port field */
> +               BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1,
> +                           offsetof(struct bpf_sk_lookup, local_port)),
> +
> +               /* 8-byte read from sk field */
> +               BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
> +                           offsetof(struct bpf_sk_lookup, sk)),
> +               BPF_EXIT_INSN(),
> +       },
> +       .result = ACCEPT,
> +       .prog_type = BPF_PROG_TYPE_SK_LOOKUP,
> +       .expected_attach_type = BPF_SK_LOOKUP,
> +},

This looks like a common class of tests which can be auto-generated
just from the list of fields and their sizes. Something for someone's
wishlist, though.

> +/* invalid 8-byte reads from a 4-byte fields in bpf_sk_lookup */
> +{
> +       "invalid 8-byte read from bpf_sk_lookup family field",
> +       .insns = {
> +               BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1,
> +                           offsetof(struct bpf_sk_lookup, family)),
> +               BPF_EXIT_INSN(),
> +       },
> +       .errstr = "invalid bpf_context access",
> +       .result = REJECT,
> +       .prog_type = BPF_PROG_TYPE_SK_LOOKUP,
> +       .expected_attach_type = BPF_SK_LOOKUP,
> +},

[...]
