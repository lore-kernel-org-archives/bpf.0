Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C08C43334
	for <bpf@archiver.kernel.org>; Tue, 21 Jun 2022 21:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354879AbiFUVWr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Jun 2022 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355681AbiFUVWZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 17:22:25 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A043191D
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 14:11:06 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 47E0D240029
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 23:11:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1655845864; bh=GHqAhGWr0Bi+fuGg+xivKajdJDNkJa3exZ5tjPlFkCA=;
        h=Date:From:To:Cc:Subject:From;
        b=MHcaD7PmAq3YOBJltO74A0YeghC+0yQvtG8MHNg7bZKPyL47TD7xWWxHZoXU1Pv46
         lEpTHCtaVGrrlYJhFJiZ4uiMEScPXfweyC85FFn/0etN9a/5lJ3P1bCtV6Gja1A2sc
         3ll/tAzE/LRQgIQVbeD3poSmYm4d9igDoWS15q+hSeId5BbzKppLX8Mbc7o/AkQF0l
         0OoqA8f0zEwc8xNWITHugwEvkoDQYQVCM1t2p/kC4YNb4EdEQoP6xYz32jAZ7bpbjv
         fj0tZ2yj5Jka/iy61YR/21AO1NeTWYT/H8mXb978WzqIBzozv5gzq/W7LurcWuk9cI
         lCRZbOxKFxZKw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LSK1d3gWcz6tmX;
        Tue, 21 Jun 2022 23:11:01 +0200 (CEST)
Date:   Tue, 21 Jun 2022 21:10:58 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 4/7] libbpf: Add type match support
Message-ID: <20220621211058.urhntwkf64yn546a@muellerd-fedora-MJ0AC3F3>
References: <20220620231713.2143355-1-deso@posteo.net>
 <20220620231713.2143355-5-deso@posteo.net>
 <20220620235919.q4xsy7xqxw2rrjv3@macbook-pro-3.dhcp.thefacebook.com>
 <20220621164556.4zh5yajzlvf6mglo@muellerd-fedora-MJ0AC3F3>
 <CAADnVQJKiiFafS5R3-3RmKCRNxWzLuqhqyahRN=eyM4dsg07-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJKiiFafS5R3-3RmKCRNxWzLuqhqyahRN=eyM4dsg07-A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 11:44:17AM -0700, Alexei Starovoitov wrote:
> On Tue, Jun 21, 2022 at 9:46 AM Daniel Müller <deso@posteo.net> wrote:
> >
> > On Mon, Jun 20, 2022 at 04:59:19PM -0700, Alexei Starovoitov wrote:
> > > On Mon, Jun 20, 2022 at 11:17:10PM +0000, Daniel Müller wrote:
> > > > +int bpf_core_types_match(const struct btf *local_btf, __u32 local_id,
> > > > +                    const struct btf *targ_btf, __u32 targ_id)
> > > > +{
> > >
> > > The libbpf and kernel support for types_match looks nearly identical.
> > > Maybe put in tools/lib/bpf/relo_core.c so it's one copy for both?
> >
> > Thanks for the suggestion. Yes, at least for parts we should probably do it.
> >
> > Would you happen to know why that has not been done for
> > bpf_core_types_are_compat equally? Is it because of the recursion level
> > tracking that is only present in the kernel? I'd think that similar reasoning
> > applies here.
> 
> Historical. Probably should be combined.
> Code duplication is the source of all kinds of maintenance issues
> and subtle bugs.

Certainly. I noticed that btf.c's bpf_core_types_are_compat uses direct equality
check of the local and target kind while libbpf.c's version utilizes
btf_kind_core_compat, which treats enum and enum64 as compatible. I suspect that
may be a bug in the former.

Will move the implementation then. Thanks!

Cc: Yonghong Song <yhs@fb.com>
