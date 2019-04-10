Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD7C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 17:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C1E2063F
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 17:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbmyiplh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfDJR4q (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:56:46 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52765 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbfDJR4q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 13:56:46 -0400
Received: by mail-it1-f193.google.com with SMTP id x132so4956478itf.2;
        Wed, 10 Apr 2019 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CI++n8e93qOP1o7/g2eCZuXEogyWMwpxtbomw0f6SaM=;
        b=Sbmyiplh0E5tGipusXh5zlErJDEG+TY5QaXJ8NC/HCuTUulTj7uIkVcx1dA8UMhrx8
         zqaaHtWCqmTnQTcrNKLDtdnGmNKpDrHsZay8sbpFXvtyUwCHaUk/iyEXLn6+xqYcy1CA
         iuIeNbVLeVtcPHQfG8pp5Szw5quTnQ7Cdt+p+VF201u9mz3XLEcvENsOqrVgi439FDr3
         fqjKZnmQBlvu+muM87wU35ABuyenVNR3la6QHRogMjMwXF/Od7dmJ6sYDQD/iK7wJy8Q
         VBKgdDqSpEAYlkrLphX8CO4E6dBE2vC/+ClpkBmQhpwT4Ra0M6iALWZtKFeIofV2fuwm
         TI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CI++n8e93qOP1o7/g2eCZuXEogyWMwpxtbomw0f6SaM=;
        b=cC7TKf8bE3iYMQiEU1juP2IrU80PzWAEL/iXSmZzdanJEoO0Q4B1MzgiIBiKha8yla
         ktcWqPATHB4yCZ7qyrKOcuBTSfOQ4BVmyursZleP0j1PtV1iGJztj7VV2W21Gulw7HpX
         ju0ZUNvO5ft79StGB8GKwORlnRWxHZ+kRCh3gAvgUOZHHJzQwNEA4E+J3dAnflR1C/gX
         mzdfUfu6iD8dKd5toTR+hKpY5XvPrMAvuS33ClaeZm6zHRSGZNn4HXONffbgaLCQcRBL
         FmQrFsnTK3S7+uUNMcpLIGdJmFlIf9mU0XjVfiMQsZOi45szamSvpMB74KKaXN/Et771
         VL6w==
X-Gm-Message-State: APjAAAVyvdos6dR+TzIZ3XX7puG9RbvQtsCpZNQNzEO1Fmo2TDODsFh3
        IBFI+w2O2S/vLVgsiH63iBArmfBee5ngALWlU9s=
X-Google-Smtp-Source: APXvYqwgfZUPlZpEr47vN/MH7gPCG3JHqAeS0dOauko/KUzGcUeve/4ud+JWzcw82n1PVn/DRQoJ0IeRyF9TKXQoJGs=
X-Received: by 2002:a24:4702:: with SMTP id t2mr4214969itb.105.1554919005267;
 Wed, 10 Apr 2019 10:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <1554880154-30791-1-git-send-email-magnus.karlsson@intel.com> <1554880154-30791-2-git-send-email-magnus.karlsson@intel.com>
In-Reply-To: <1554880154-30791-2-git-send-email-magnus.karlsson@intel.com>
From:   Y Song <ys114321@gmail.com>
Date:   Wed, 10 Apr 2019 10:56:09 -0700
Message-ID: <CAH3MdRXwK3=8z=CNK-=vvL5dY4nvT1ZCWXDOUWLR8f65zydS2Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] libbpf: remove likely/unlikely in xsk.h
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
> This patch removes the use of likely and unlikely in xsk.h since they
> create a dependency on Linux headers as reported by several
> users. There have also been reports that the use of these decreases
> performance as the compiler puts the code on two different cache lines
> instead of on a single one. All in all, I think we are better off
> without them.

The change looks good to me.
  Acked-by: Yonghong Song <yhs@fb.com>

libbpf repo (https://github.com/libbpf/libbpf/) solved this issue by
providing some customer
implementation just to satisfying compilatioins. I guess users here do
not use libbpf repo and they
directly extract kernel source and try to build?

Just curious. do you have detailed info about which code in two
different cache lines instead
of one cache line and how much performance degradation?

>
> Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/lib/bpf/xsk.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
> index a497f00..3638147 100644
> --- a/tools/lib/bpf/xsk.h
> +++ b/tools/lib/bpf/xsk.h
> @@ -105,7 +105,7 @@ static inline __u32 xsk_cons_nb_avail(struct xsk_ring_cons *r, __u32 nb)
>  static inline size_t xsk_ring_prod__reserve(struct xsk_ring_prod *prod,
>                                             size_t nb, __u32 *idx)
>  {
> -       if (unlikely(xsk_prod_nb_free(prod, nb) < nb))
> +       if (xsk_prod_nb_free(prod, nb) < nb)
>                 return 0;
>
>         *idx = prod->cached_prod;
> @@ -129,7 +129,7 @@ static inline size_t xsk_ring_cons__peek(struct xsk_ring_cons *cons,
>  {
>         size_t entries = xsk_cons_nb_avail(cons, nb);
>
> -       if (likely(entries > 0)) {
> +       if (entries > 0) {
>                 /* Make sure we do not speculatively read the data before
>                  * we have received the packet buffers from the ring.
>                  */
> --
> 2.7.4
>
