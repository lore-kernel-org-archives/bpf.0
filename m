Return-Path: <SRS0=KuSb=6P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C26FC47254
	for <bpf@archiver.kernel.org>; Fri,  1 May 2020 04:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EABB2073E
	for <bpf@archiver.kernel.org>; Fri,  1 May 2020 04:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588306008;
	bh=IccByTwKdJww/kLpArizsMLQUqfEc5eA6Ug4uanX1p4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uPR57sj5ZtNkOizr6oR1lDJqKT/WTJqxgamV3xjlgNPtggGLah7EeXPRT6JCbGnUt
	 hOP9L7aDvTcDq90a6Jjg8Zcv3I7fK4JWrAHna5dyum9fQ3GRgIm9ql/gSNrBIElHMg
	 Mwz2rM4Jj3H8aE2zcUF3OLkQzuAIkGGBp3FOOO+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgEAEGs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 May 2020 00:06:48 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:36933 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgEAEGr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 May 2020 00:06:47 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 04146REx029656;
        Fri, 1 May 2020 13:06:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 04146REx029656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588305988;
        bh=IccByTwKdJww/kLpArizsMLQUqfEc5eA6Ug4uanX1p4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PYBney15bLb0PupuKbtCOdg9mClStoeNgsETlQgDlJi4ATQmQGH/hq56jXvSIMP7k
         Bx2WzY+0ZIBP1hcR87j2d+ZSCugN7b4NhX1MMrKSHNkw7nojeOIuuTFsLwBa4UsAwZ
         M2ukexE3qk6tCQaBrdojgtoPYj2hhdzrKoIQvnH9nOJ9twzJmqu6/eFlzzvOIiG00/
         /unRE4xcwqKrwHtdJhJbp/XRe1qol88q57YfQOJ1hvMptFH0mgKfdsDhCFxk67mtC+
         jwk3GYV/GubgFbYt+IAy287AyY7XxP0/HWmF7INI54VtFl6mdT5xGTbl7qBqKjvy1i
         IdvYc6Ca4QrSQ==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id b6so3368991uak.6;
        Thu, 30 Apr 2020 21:06:28 -0700 (PDT)
X-Gm-Message-State: AGi0PuZAAkfz3Z8RxNOaHiakrvh/CkViIS1/wBibR7uTwg09lxQ+2mn9
        oHfCxzOE7aaa0cMjACOQczq6wpZAhqU+p7BZZlw=
X-Google-Smtp-Source: APiQypKl4RDQfWlnYWP5RnkV1+lrG/0wVs4O0D0X216HZbDMhY1221cdwbTBs4K4HqLl/rX7e1IF5sC2C7nIVEVOGHU=
X-Received: by 2002:a9f:28c5:: with SMTP id d63mr1601849uad.25.1588305986970;
 Thu, 30 Apr 2020 21:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARHd0DXRLONf6vH_ghsYZjzoduzkixqNDpVqqPx0yHbHg@mail.gmail.com>
 <CAADnVQ+RvDq9qvNgSkwaMO8QcDG1gCm-SkGgNHyy1gVC3_0w=A@mail.gmail.com>
In-Reply-To: <CAADnVQ+RvDq9qvNgSkwaMO8QcDG1gCm-SkGgNHyy1gVC3_0w=A@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 May 2020 13:05:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5NMZWrQ_1yk+_-06zrmYMOcKvNnuX=u1sReuy6wg9Gw@mail.gmail.com>
Message-ID: <CAK7LNAQ5NMZWrQ_1yk+_-06zrmYMOcKvNnuX=u1sReuy6wg9Gw@mail.gmail.com>
Subject: Re: BPFilter: bit size mismatch between bpfiter_umh and vmliux
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

On Wed, Apr 29, 2020 at 1:14 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> >
> > At least, the build was successful,
> > but does this work at runtime?
> >
> > If this is a bug, I can fix it cleanly.
> >
> > I think the bit size of the user mode helper
> > should match to the kernel bit size. Is this correct?
>
> yes. they should match.
> In theory we can have -m32 umh running on 64-bit kernel,
> but I wouldn't bother adding support for such thing
> until there is a use case.
> Running 64-bit umh on 32-bit kernel is no go.


Thanks for the comments.


This issue will be fixed by this:
https://patchwork.kernel.org/patch/11515997/

and the Makefile will be cleaned up by this:
https://patchwork.kernel.org/patch/11515995/


They are parts of the big series of Makefile cleanups.
So, I will apply the whole to kbuild tree.

Thanks.

--
Best Regards
Masahiro Yamada
