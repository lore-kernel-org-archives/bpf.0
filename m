Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC43C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 18:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B17F2075B
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 18:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJP65qZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfDJSOS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:14:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37614 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbfDJSOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 14:14:17 -0400
Received: by mail-io1-f66.google.com with SMTP id x7so3013368ioh.4;
        Wed, 10 Apr 2019 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSsnw2vCti/yt6Ow7Xn7ll2uWPjgYf7faKvb+HAVBfY=;
        b=IJP65qZ89dGUPet9t3ulzHVe8TN66abzsiXszdMDlovN3tCZzaTYWvRLIVrrEU0RUt
         F5KLKBy0wONYsGo2nkEGbWLFskZt+5q49B75R87QKTJxktm5ield6iqugGBqcKSIdrXq
         vtF4IGRz6hHZxueqNuMPPTegMi2t8/NxP71+GyI0hlXyVUliZkY4r+CZpPo8hFtIc3/d
         F7ck4AvqvMPGaIuVh96mmw+Oka3DJL6/xQ/McTdm6BlCqwi/0TmkzDXjiYpRJeonTL3V
         IiCVv+thVvyhm/X6LWIiG2LSXmtEI9bU+T9n2ttl85wKyUePhtep/JLH90UpIran2YEe
         TUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSsnw2vCti/yt6Ow7Xn7ll2uWPjgYf7faKvb+HAVBfY=;
        b=soTGzqMe5zylUoNlIAro53YXOoe1VUXuZYBKJyh9mnyS3VuzY/ndC8Hb8idtBybZa/
         pIYAoQf2uOec1dU658y8PkvdTRW0TDfDCS1P8TqBKI23b0R6IPw2uXyIn0tiv/vsPRGp
         U7kdGrdCNuGRLr7POUdKpB+ZarK9rXp86xEAZGXdSEoIyjkjad51L5eHad776gZITBCx
         lo1w2HDLDXEs7jGCFUnS8R5vPkUY4s8jYwC7vRD3ByipfCEe6PewuJtVzP9Tm7ILdFWe
         3LXPcjcvgjgMKcBxw/Ph8HgjgK6ofO0FlMH5lHQIKCVUZM77aRR8WdnFDQ9e26zdZCoK
         A2fw==
X-Gm-Message-State: APjAAAXhFKcv3sqUb5BFRdo635T2VKgOr0b7sFwbF7cPg/rSAEDUQuYJ
        V+HkHEKmiEaMr1K3wWBRhBOsF08tiNnMQdNOTwE=
X-Google-Smtp-Source: APXvYqw4iVRg+57lq/nJMvSvMP7VgkjetZ+AcRzmfhb9CzhLLoZaRS9/KEveyVHRXzUEufFpckv/M0R8rP3jU9J7S2s=
X-Received: by 2002:a5d:9584:: with SMTP id a4mr27645172ioo.17.1554920056688;
 Wed, 10 Apr 2019 11:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <1554880154-30791-1-git-send-email-magnus.karlsson@intel.com> <1554880154-30791-3-git-send-email-magnus.karlsson@intel.com>
In-Reply-To: <1554880154-30791-3-git-send-email-magnus.karlsson@intel.com>
From:   Y Song <ys114321@gmail.com>
Date:   Wed, 10 Apr 2019 11:13:40 -0700
Message-ID: <CAH3MdRX64deNto0avW3XfexMLhNS+r75x3yea6ko+hmHrOE3aw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] libbpf: remove dependency on barrier.h in xsk.h
To:     Magnus Karlsson <magnus.karlsson@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        bruce.richardson@intel.com, ciara.loftus@intel.com,
        ilias.apalodimas@linaro.org, xiaolong.ye@intel.com,
        ferruh.yigit@intel.com, qi.z.zhang@intel.com, georgmueller@gmx.net
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 10, 2019 at 12:21 AM Magnus Karlsson
<magnus.karlsson@intel.com> wrote:
>
> The use of smp_rmb() and smp_wmb() creates a Linux header dependency
> on barrier.h that is uneccessary in most parts. This patch implements
> the two small defines that are needed from barrier.h. As a bonus, the
> new implementations are faster than the default ones as they default
> to sfence and lfence for x86, while we only need a compiler barrier in
> our case. Just as it is when the same ring access code is compiled in
> the kernel.
>
> Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/lib/bpf/xsk.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
> index 3638147..69136d9 100644
> --- a/tools/lib/bpf/xsk.h
> +++ b/tools/lib/bpf/xsk.h
> @@ -39,6 +39,22 @@ DEFINE_XSK_RING(xsk_ring_cons);
>  struct xsk_umem;
>  struct xsk_socket;
>
> +#if !defined bpf_smp_rmb && !defined bpf_smp_wmb

Maybe add some comments to explain the different between bpf_smp_{r,w}mb
and smp_{r,w}mb so later users will have a better idea which to pick?

> +# if defined(__i386__) || defined(__x86_64__)
> +#  define bpf_smp_rmb() asm volatile("" : : : "memory")
> +#  define bpf_smp_wmb() asm volatile("" : : : "memory")
> +# elif defined(__aarch64__)
> +#  define bpf_smp_rmb() asm volatile("dmb ishld" : : : "memory")
> +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
> +# elif defined(__arm__)
> +/* These are only valid for armv7 and above */
> +#  define bpf_smp_rmb() asm volatile("dmb ish" : : : "memory")
> +#  define bpf_smp_wmb() asm volatile("dmb ishst" : : : "memory")
> +# else
> +#  error Architecture not supported by the XDP socket code in libbpf.
> +# endif
> +#endif

Since this is generic enough and could be used by other files as well,
maybe put it into libbpf_util.h?

> +
>  static inline __u64 *xsk_ring_prod__fill_addr(struct xsk_ring_prod *fill,
>                                               __u32 idx)
>  {
> @@ -119,7 +135,7 @@ static inline void xsk_ring_prod__submit(struct xsk_ring_prod *prod, size_t nb)
>         /* Make sure everything has been written to the ring before signalling
>          * this to the kernel.
>          */
> -       smp_wmb();
> +       bpf_smp_wmb();
>
>         *prod->producer += nb;
>  }
> @@ -133,7 +149,7 @@ static inline size_t xsk_ring_cons__peek(struct xsk_ring_cons *cons,
>                 /* Make sure we do not speculatively read the data before
>                  * we have received the packet buffers from the ring.
>                  */
> -               smp_rmb();
> +               bpf_smp_rmb();

Could you explain why a compiler barrier is good enough here on x86? Note that
the load cons->cached_cons could be reordered with earlier
non-overlapping stores
at runtime.

>
>                 *idx = cons->cached_cons;
>                 cons->cached_cons += entries;
> --
> 2.7.4
>
