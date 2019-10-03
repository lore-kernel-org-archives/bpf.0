Return-Path: <SRS0=XC6e=X4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97C2C10F14
	for <bpf@archiver.kernel.org>; Thu,  3 Oct 2019 20:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B370A2070B
	for <bpf@archiver.kernel.org>; Thu,  3 Oct 2019 20:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L38GAk63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfJCUf6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:35:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45837 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJCUf6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Oct 2019 16:35:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so5460606qtj.12;
        Thu, 03 Oct 2019 13:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Veyv7fNdzIMwvAYnkMsx/AaWCJBJTKWKvtMnSopS4HM=;
        b=L38GAk63rpaqG55ZWfU3iWmsJIqiqjsPRghSG4FddgYH37xTg5vMBxEJX8o7bCkXWR
         ZqQCc24iOuJaf9zGOmdODU026T1vQT2kq7jHkSYhW09f0O3Kz+oTGji3BqTIa8KRq6TQ
         c5Vdwv4u1ookdTroSSKkgaCx6f4EafeKZ2ZIIfdAbnXCpMIMEgLQ5PJhscI1q8scxA5J
         GcnqvbxA+OOAASKh5A6aRuJL6XLdrrr45vxOv0mThFgP86rrvGbICBI8I2y8/yqqt0Pv
         IwEQqZuITQCbfOHv41BcqhQDga7zESQ9mQeFbMvh2V1/OQsJMSbtP37LlLw+qPuXoHhE
         XEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Veyv7fNdzIMwvAYnkMsx/AaWCJBJTKWKvtMnSopS4HM=;
        b=NTUPfiBcafQ8ruOVLDX7+gPymzlg3fqSGw7+7cQOsxFryl0oGzD1IbncYGYzcLsYPk
         /hg+/MRSP6kCbeBHZ908SgivB16W3zfbtOWJhtZdK5VQcBiIf7o0WaFLqt9E+pi07IxN
         6D212Jiv/XWL6p2IC+rE4DCuRfiETKXdd008CwS23woH+c68txIx5KJBhbvS0jfmZTNO
         s2Ws1WbHp7yGXRyoF4ZcdPNwxyvC5QZIXF9qmYZYBkoCHyXY0CZSDQccBOFEVC8039ol
         e1k24QkVj9OzHTwh754FcN2ea4fnM+MaQhJ7FS+i7FqGgngLU6tzUixpH6WgfNZpufSM
         Qs+A==
X-Gm-Message-State: APjAAAUiXDwMrwlMzJIe89FLZ3IY309jYbaKBtTAH7DhUcqHRmiBcDR5
        3zcd9nfLhRTUumilEhE7yzbUKtzTJxl0wNqDc6I=
X-Google-Smtp-Source: APXvYqzwPX6EtKtW/EgKGreyqoTPPNL4/hWI9QxQoq4EEXkkU4LgvHYfDNegsd5vRcFSf6ahfYhIN2Czq6sUmlia9iI=
X-Received: by 2002:ac8:4704:: with SMTP id f4mr12013031qtp.183.1570134957224;
 Thu, 03 Oct 2019 13:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191002215041.1083058-1-andriin@fb.com> <20191002215041.1083058-7-andriin@fb.com>
In-Reply-To: <20191002215041.1083058-7-andriin@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 3 Oct 2019 13:35:46 -0700
Message-ID: <CAPhsuW4OOx6nDwPpzjXmnKRj6dBaXuF=GVjG6D4YmF_OWwsKcA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/7] libbpf: add BPF_CORE_READ/BPF_CORE_READ_INTO
 helpers
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 2, 2019 at 3:02 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Add few macros simplifying BCC-like multi-level probe reads, while also
> emitting CO-RE relocations for each read.
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/lib/bpf/bpf_helpers.h | 143 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 143 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index cb9d4d2224af..847dfd7125e4 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -19,6 +19,10 @@
>   */
>  #define SEC(NAME) __attribute__((section(NAME), used))
>
> +#ifndef __always_inline
> +#define __always_inline __attribute__((always_inline))
> +#endif
> +
>  /* helper functions called from eBPF programs written in C */
>  static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
>         (void *) BPF_FUNC_map_lookup_elem;
> @@ -312,4 +316,143 @@ struct bpf_map_def {
>         bpf_probe_read(dst, sz,                                             \
>                        (const void *)__builtin_preserve_access_index(src))
>
> +/*

nit: extra /*.

Well, I actually don't have a strong preference with this. Just to highlight
we are mixing two styles, which we already do in current bpf_helpers.h.

There are multiple other instances below.

Besides these.

Acked-by: Song Liu <songliubraving@fb.com>
