Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31873C433EF
	for <bpf@archiver.kernel.org>; Thu,  7 Jul 2022 03:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiGGDgp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Jul 2022 23:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGGDgn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 23:36:43 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FE51C91F
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 20:36:42 -0700 (PDT)
Date:   Wed, 6 Jul 2022 20:36:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657165000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SAH+dRNUS66esNj71rVITjpSSCB+jDrJZseh+3rbbIc=;
        b=SDvNoR6LfSBUiENEh8s2LC6V5ULxeEs4xRgZXsjw5qQUbkZWd22r8rTY9agJgEU1IBpPpR
        nwCGBUVicQFDzihuz+RodbAuJLi1RUedVJHFCb4ERNlf1hIaoygsEC5O7Rlg9suh5gLRYr
        i1QqdJt9SrOtYa5OgFSRIII5URmbTGc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make non-preallocated allocation
 low priority
Message-ID: <YsZUwf8539ztHHeP@castle>
References: <20220706155848.4939-1-laoar.shao@gmail.com>
 <20220706155848.4939-2-laoar.shao@gmail.com>
 <20220707000721.dtl356trspb23ctp@google.com>
 <YsYn3HoqQ4JtTaO6@castle>
 <CAADnVQKxKMcXcVra-+A8UVEUmp2h8GWotbLRi65-gBfAzJ37Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKxKMcXcVra-+A8UVEUmp2h8GWotbLRi65-gBfAzJ37Ew@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 06, 2022 at 07:09:22PM -0700, Alexei Starovoitov wrote:
> On Wed, Jul 6, 2022 at 5:25 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Thu, Jul 07, 2022 at 12:07:21AM +0000, Shakeel Butt wrote:
> > > On Wed, Jul 06, 2022 at 03:58:47PM +0000, Yafang Shao wrote:
> > > > GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> > > > if we allocate too much GFP_ATOMIC memory. For example, when we set the
> > > > memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> > > > easily break the memcg limit by force charge. So it is very dangerous to
> > > > use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> > > > remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> > > > __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> > > > too much memory.
> > >
> > > Please use GFP_NOWAIT instead of (__GFP_ATOMIC | __GFP_KSWAPD_RECLAIM).
> > > There is already a plan to completely remove __GFP_ATOMIC and mm-tree
> > > already have a patch for that.
> >
> > Oh, I didn't know this, thanks for heads up!
> > I agree that GFP_NOWAIT is the best choice then.
> >
> > Btw, we probably shouldn't even add GFP_NOWAIT if the allocation is performed
> > from the bpf syscall context. Why would we fail to pre-allocate a map if
> > we can easily go into the reclaim? But probably better to leave it for
> > a separate change.
> 
> The places affected by this patch are in atomic context.
> Prealloc path from syscall is using GFP_USER.

Right. Sorry, my bad, for some reason I was under an impression it's a common
path for all allocations.

Thanks!
