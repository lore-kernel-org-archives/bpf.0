Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C487AC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 00:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854322085A
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 00:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keME/dbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfCAAwu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:52:50 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34098 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfCAAwt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 19:52:49 -0500
Received: by mail-oi1-f196.google.com with SMTP id g16so18179014oib.1;
        Thu, 28 Feb 2019 16:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Chs7EHAbnSFgsRpf8pQcV9Ktl0qBJZ+3oPiZgH2JF2U=;
        b=keME/dbzqPgvGf4nzfc/WPulSj6BsJNt46RiS/MowRArzz0dq6XsqM5WQI8gRrCoqu
         3U3howavSYWuaqvDIxxQfOnXM4BP+K02GEzsR4NfbExgxWOoMQ9IZu/XsRM78jVOryUE
         bZmx99DsIR/1hT7cpoBWgQDC2u21BVGovFlwQFt54pRmuttdBe8p/KsVgWXafnMJ+5eE
         A/lRvIjeQuJ+pnSfRM1F5Mcvp7nGQc7oxmdmztbM2Zw3u57dIw5v+FCl8nrOKCyIq38w
         HJlmWa+3vfBCfzctAI1MC93NyLkWY3v1b4Nb6D/3+BslMIbXfIh9tAuB5jaClx8S3P8C
         m/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Chs7EHAbnSFgsRpf8pQcV9Ktl0qBJZ+3oPiZgH2JF2U=;
        b=oND07pp7TX8eEXFzpGt/skOeSLJTzSDc8Cr9VHaJjpxqY+dUT1hOA8XAyx7/yYTT+G
         0KFkzqVhMidvh0SjeSoe3vvg1wDzOwy44YdnLFMELyCyCKFYiHbXIlVNtXCGB12JpChw
         mi5xWyT/RBHVr0TUCG/t+xtVvivox92+olYDzDdprQwuZ9JpQriQ9RpwMenJ+El87cHK
         p146LiN4ZblMaJiIyjZRbme+eqeylgYKRYD2Eo/+yAeHEfTuhRlNlMVmRkF5j+zOnYIZ
         rlmL4CtZ3/JYd5DZodBrEKSsiy3pr4PNH20WlofU4wpNvEun2ZOeQSMsTyLIkpPPjRKH
         vniQ==
X-Gm-Message-State: AHQUAuYKIIEgX+7OSCp9RjLm6HmUrFmvQauh0sG5gf0Mjh30PsRsnbak
        t5WpSPVoYktKg86fxHjtCXoprCCNaKk3GXDUuLI=
X-Google-Smtp-Source: AHgI3IaMy6qQZdtuZNP5+N6bTrPT35BIVD4l/qC/0fyUmrQ8/sJnn/OnQ2erc4QTxdTJDb3j0NcSh/hZBRxyPcthNG0=
X-Received: by 2002:aca:abcf:: with SMTP id u198mr1549779oie.55.1551401568789;
 Thu, 28 Feb 2019 16:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20190228184512.198075-1-andriin@fb.com> <20190228184512.198075-4-andriin@fb.com>
 <CAPhsuW6tDGhi3ROVsLU4j37_Xp7xbV=jnEQ5ce-fV=vdCaJ-BQ@mail.gmail.com>
 <23253537-2a33-9546-7ed2-0abb6e7de420@iogearbox.net> <831958de-985b-d150-d0d0-296e6c6cbec4@iogearbox.net>
In-Reply-To: <831958de-985b-d150-d0d0-296e6c6cbec4@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Feb 2019 16:52:37 -0800
Message-ID: <CAEf4Bzatwzs7qq9JWftitvNou1mJJpCCcdhAXwTtkJbm8L2FjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: fix formatting, typos, reflow comments
 in syscall.c, verifier.c
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Song Liu <liu.song.a23@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 4:28 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 03/01/2019 01:27 AM, Daniel Borkmann wrote:
> > On 02/28/2019 11:40 PM, Song Liu wrote:
> >> On Thu, Feb 28, 2019 at 10:59 AM Andrii Nakryiko <andriin@fb.com> wrote:
> >>>
> >>> Fix few formatting errors. Fix few typos and reflow long descriptive
> >>> comments for more even text fill.
> >>>
> >>> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> >>
> >> I think we should not change the code for formatting, as these changes make
> >> git-blame more difficult. How about we only make changes to comments?
> >
> > Kind of true, though git blame is imho not too useful (unless I'm missing
> > some git magic :)); git log -p has much more historical context to search
> > through. I think these cleanups below are okay, though my worry is that
> > for someone doing backports changes that are scattered like this mainly
> > cause conflicts which then gets painful to resolve. I think we could make
> > it work if they are split and more isolated, e.g. syscall ones could be
> > one commit, another one only touching the big contiguous verifier comment,
> > and so on.
>
> (Ideally also separate from the doc-only patches which is the rest of your
>  series.)

Yep, sure, I'll split this into two patchsets and this patch into
multiple patches (as part of second patchset).
