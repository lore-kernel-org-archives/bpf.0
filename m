Return-Path: <SRS0=pDiR=AM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3A3C433DF
	for <bpf@archiver.kernel.org>; Wed,  1 Jul 2020 17:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55BB20771
	for <bpf@archiver.kernel.org>; Wed,  1 Jul 2020 17:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593625873;
	bh=lvKspDv0PksXckIyqHuNxgvqSVNoOkWiJt1xvehMvhk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VRqbMbYzL5SIw02MUdeoKkIUuzXU7HLv2SxcJ492y3OXKzU4POR/ADhdK0WIx5rBP
	 VSEYoph5Zlo8z0hkxW3TdIeiqR+r6AmQuR/DkQdIjvFCJCgCyBDNpYQIR9AOST71Io
	 WZ1u+8lcIITb3Pocg+6P5DDpr6wpD0WdRwI0qkmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgGARvN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:51:13 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:47812 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgGARvN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 13:51:13 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 061Hocbl001966;
        Thu, 2 Jul 2020 02:50:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 061Hocbl001966
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593625839;
        bh=JpU5KARx4OJMG7ZHwakn74/Uun3mvcDEwylSk8clBtE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yEkJamVdtgzzuBpHttwjO8AXQEcd/n4SyQU76z/aOOL2rCXUp27mTBCZoD/ubj+3T
         2tqn5UvhU2Aq1SpPVOZ+EPQj0JYqKYTzCC1vX+JXa7gSSctFB6G9IorIBbtI2euQet
         8i8vDiItyxiFZrGRKpyP8hiHYtioKwBkLBV7maYP8J04ZRGsi4a+BFfPVA/2y28l3B
         DA+iVOMZqYrdHguMSaCPYHAECWQBpaN7bLRBp6LmuINghuJlIXnPqRDo3hTwBThloL
         PVFLQsPaziWat2Fr8m8OGHlN9R2xJIM8w3UwcWJCzo0dQzDJ2+QGOgjPRo1A5qlMuh
         hlTGocXkNBtZQ==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id k7so12431572vso.2;
        Wed, 01 Jul 2020 10:50:38 -0700 (PDT)
X-Gm-Message-State: AOAM533NDqVv6bIUutRTzmNMHLhCWeAgVV7n5hW7xeUS8Puj324jCdkF
        yyxeAgKEZrIjaiiBgifkcMPVuqoSfFrT09wbPsI=
X-Google-Smtp-Source: ABdhPJzBXClfW2a5I0cFxIawhrBwlxQeFyeEoSyCw4ulXBJ7+oE5JE34Dj49RuMydY1TbssdkS5+PhHwqcsK3KFCfpk=
X-Received: by 2002:a67:694d:: with SMTP id e74mr20855987vsc.155.1593625837341;
 Wed, 01 Jul 2020 10:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200701092644.762234-1-masahiroy@kernel.org> <20200701174609.mw5ovqe7d5o6ptel@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200701174609.mw5ovqe7d5o6ptel@ast-mbp.dhcp.thefacebook.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 2 Jul 2020 02:50:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNARTMt8kgRJqgRonaSHROT80yDNAG0wDiLGL=RSEz3CDig@mail.gmail.com>
Message-ID: <CAK7LNARTMt8kgRJqgRonaSHROT80yDNAG0wDiLGL=RSEz3CDig@mail.gmail.com>
Subject: Re: [PATCH] bpfilter: allow to build bpfilter_umh as a module without
 static library
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Song Liu <songliubraving@fb.com>,
        =?UTF-8?Q?Valdis_Kl_=C4=93_tnieks?= <valdis.kletnieks@vt.edu>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 2, 2020 at 2:46 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jul 01, 2020 at 06:26:44PM +0900, Masahiro Yamada wrote:
> > Originally, bpfilter_umh was linked with -static only when
> > CONFIG_BPFILTER_UMH=y.
> >
> > Commit 8a2cc0505cc4 ("bpfilter: use 'userprogs' syntax to build
> > bpfilter_umh") silently, accidentally dropped the CONFIG_BPFILTER_UMH=y
> > test in the Makefile. Revive it in order to link it dynamically when
> > CONFIG_BPFILTER_UMH=m.
> >
> > Since commit b1183b6dca3e ("bpfilter: check if $(CC) can link static
> > libc in Kconfig"), the compiler must be capable of static linking to
> > enable CONFIG_BPFILTER_UMH, but it requires more than needed.
> >
> > To loosen the compiler requirement, I changed the dependency as follows:
> >
> >     depends on CC_CAN_LINK
> >     depends on m || CC_CAN_LINK_STATIC
> >
> > If CONFIG_CC_CAN_LINK_STATIC in unset, CONFIG_BPFILTER_UMH is restricted
> > to 'm' or 'n'.
> >
> > In theory, CONFIG_CC_CAN_LINK is not required for CONFIG_BPFILTER_UMH=y,
> > but I did not come up with a good way to describe it.
> >
> > Fixes: 8a2cc0505cc4 ("bpfilter: use 'userprogs' syntax to build bpfilter_umh")
> > Reported-by: Michal Kubecek <mkubecek@suse.cz>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> lgtm
> Do you mind I'll take it into bpf-next tree?
> Eric is working on a bunch of patches in this area. I'll take his set
> into bpf-next as well and then can apply this patch.
> Just to make sure there are no conflicts.

Please go ahead.

Thank you.


-- 
Best Regards
Masahiro Yamada
