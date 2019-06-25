Return-Path: <SRS0=2zuU=UY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4254AC48BD4
	for <bpf@archiver.kernel.org>; Tue, 25 Jun 2019 14:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18523208E3
	for <bpf@archiver.kernel.org>; Tue, 25 Jun 2019 14:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KACe7FWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbfFYORJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:17:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43821 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfFYORJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 10:17:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id j29so12744024lfk.10;
        Tue, 25 Jun 2019 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhEAym9Oy+LRbEZieoHaOWLWzaxNExkJNjRTWjG03Yo=;
        b=KACe7FWGrMuXyXZaC07DAuFUUe/fbR8fY1bc6OdzWDrEUn5JG4dPCqG2pKiH8CGY4o
         uirvdoOh+p/M2qSmlA9jKKtfFE1qzEUI/V+QNc7umwimg7JS0AgIEOxV2N564q7lG5Yo
         PefDWeCaHF0rBDU2TLbKRNocgOFBkxuWjFCSABOVgB81LIayo71lediW83jF9hRQz2Kj
         jlxac/fTaPnuRuNM31NvIrhY7uq2mHSqPhgBlkMqPTDcYr0lOUbqf6twDuqK4V1RA/ji
         IKLaqU27X18QcfRKFJwoMqRv+7eGHVPlIm63qbRUuLzOIncbqMdz4a7UIOkC8L08Pvw+
         yslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhEAym9Oy+LRbEZieoHaOWLWzaxNExkJNjRTWjG03Yo=;
        b=nEeLI+LKS4rW5zaI7RA5QmaZXwpPv9yhFHLObnJNLncXishUX/yeW1P9nJGBQNzyGV
         dznf8f2HY8kppiRWevqq53mbxSb+YzA/i6oF2f0S2+JAbLY+EVfXysEr8ZYfhDJaMrYv
         v96D3b3A432uqcjBEr9WkfrqkJ66dZbOJT6SFD8Kez7frzSKDAL/Cn4shQpbKeB1r7iG
         BlXzUb3zKwOrS0oId+e8jZxDyJDOGsgfbZ/M9EDXeDtYymH2ION80JXIPr+olqiIdLgM
         M9zkWvH6oQUgsRWwCJ8wFzOwrYTfOrbFIkkhUSKxA++lss/bs4zgkznZl0GKEy2Qh3RE
         AyyA==
X-Gm-Message-State: APjAAAV4ShnSJg+0tOvFcpPe6Zk42jfkxXCuJfYxaAtx6DSFF8oCCsSt
        41mWLRsHAD014FyuX3jUodpbJQ2xCvyZAuaC48s=
X-Google-Smtp-Source: APXvYqz/0dW/30cDGsTotvBcFbFN7ErRxCI6FCdqHGGnMLfp8diiPkxAeJeqgMHUZuTICttdWy12glQJpNIBdQZoQ3E=
X-Received: by 2002:ac2:4c29:: with SMTP id u9mr4062682lfq.100.1561472227090;
 Tue, 25 Jun 2019 07:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <a5fb2545a0cf151bc443efa10c16c5a4de6f2670.1561460681.git.baruch@tkos.co.il>
In-Reply-To: <a5fb2545a0cf151bc443efa10c16c5a4de6f2670.1561460681.git.baruch@tkos.co.il>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 25 Jun 2019 07:16:55 -0700
Message-ID: <CAADnVQJ3MPVCL-0x2gDYbUQsrmu8WipnisqXoU8ja4vZ-5nTmA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: fix uapi bpf_prog_info fields alignment
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, "Dmitry V . Levin" <ldv@altlinux.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 25, 2019 at 4:07 AM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Merge commit 1c8c5a9d38f60 ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next") undid the
> fix from commit 36f9814a494 ("bpf: fix uapi hole for 32 bit compat
> applications") by taking the gpl_compatible 1-bit field definition from
> commit b85fab0e67b162 ("bpf: Add gpl_compatible flag to struct
> bpf_prog_info") as is. That breaks architectures with 16-bit alignment
> like m68k. Embed gpl_compatible into an anonymous union with 32-bit pad
> member to restore alignment of following fields.
>
> Thanks to Dmitry V. Levin his analysis of this bug history.
>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2:
> Use anonymous union with pad to make it less likely to break again in
> the future.
> ---
>  include/uapi/linux/bpf.h       | 5 ++++-
>  tools/include/uapi/linux/bpf.h | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a8b823c30b43..766eae02d7ae 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3142,7 +3142,10 @@ struct bpf_prog_info {
>         __aligned_u64 map_ids;
>         char name[BPF_OBJ_NAME_LEN];
>         __u32 ifindex;
> -       __u32 gpl_compatible:1;
> +       union {
> +               __u32 gpl_compatible:1;
> +               __u32 pad;
> +       };

Nack for the reasons explained in the previous thread
on the same subject.
Why cannot you go with earlier suggestion of _u32 :31; ?
