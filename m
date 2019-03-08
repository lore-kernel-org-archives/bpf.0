Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DC4C43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 10:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444312085A
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552042557;
	bh=QHzLFsJC7X6et+GL+ex79F/SZSbuNU9kxfn7HJs6Dxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VUt+vU6l/6pKrizfRdC9DXv4A0Sr2mil0txnxulog3rhcAicc11UZkOPpczrS+dX6
	 CWTt5PqvH1pNSFviakRHDQOTnjwxdasEzGlsQh9KJnKUcNSbyw/RWmvKpNAV4AUcOT
	 ZR9veB1hj7Vc2bEvsyB3GYGclQaTYasRF6LqYkXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCHKz4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:55:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:35106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbfCHKz4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 05:55:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B00D7AFEF;
        Fri,  8 Mar 2019 10:55:54 +0000 (UTC)
Date:   Fri, 8 Mar 2019 11:55:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org,
        ast@kernel.org
Subject: Re: [PATCH] bpf: Try harder when allocating memory for maps
Message-ID: <20190308105553.GD5232@dhcp22.suse.cz>
References: <20190308080857.12005-1-m@lambda.lt>
 <20190308084413.GB5232@dhcp22.suse.cz>
 <295a56f7-6028-3c45-63d4-b6394cc787f1@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <295a56f7-6028-3c45-63d4-b6394cc787f1@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri 08-03-19 11:33:00, Daniel Borkmann wrote:
> On 03/08/2019 09:44 AM, Michal Hocko wrote:
> > On Fri 08-03-19 09:08:57, Martynas Pumputis wrote:
> 
> Martynas, for the patch, please also Cc netdev in the submission so
> that it lands properly in patchwork. Setup where patches only Cc'ed
> to bpf@vger.kernel.org would land in our delegate is not yet completed
> by ozlabs folks, just fyi.
> 
> >> It has been observed that sometimes memory allocation for BPF maps
> >> fails when there is no obvious memory pressure in a system.
> >>
> >> E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
> >> could not be created due to due to vmalloc unable to allocate 75497472B,
> >> when the system's memory consumption (in MB) was the following:
> >>
> >>     Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727
> > 
> > Hmm 75MB is quite large and much larger than the slab/page allocator
> > cann provide so this is not really a fragmentation issue. Vmalloc does
> 
> Agree.
> 
> > respect noretry but considering that there shouldn't be a large memory
> > pressure I wonder how NORETRY managed to fail the allocation. Do you
> > happen to have the allocation failure report?
> 
> I'll defer to Martynas here.
> 
> > Btw. is there any real reason to opencode and duplicate kvmalloc logic
> > here? In other words why not simply make bpf_map_area_alloc use
> > kvmalloc_node with GFP_KERNEL?
> 
> Mostly historical reasons from d407bd25a204 ("bpf: don't trigger OOM killer
> under pressure with map alloc"). I remember back then we had a discussion
> that __GFP_NORETRY is not fully supported and should only be seen as a hint
> in our case (since it's not propagated all the way through in vmalloc, if
> I recall correctly).

Yes, that is still the case and there is no way to really have nooom
semantic for vmalloc. Even with your opencoded version btw.

> And looking at kvmalloc_node(), __GFP_NORETRY is only
> really set in case of kmalloc attempts. Given these alloc requests for maps
> can often be large in size, what we really want is something that ideally under
> *no* circumstances oom killer would trigger as that is way too disruptive.

That is not really possible. Even if you do not trigger the OOM killer
directly, som concurrent allocation might do that because your
particular one has eaten the remaining memory.

> So
> instead, allocation should just fail and bpf loader or whatnot can deal with
> it. Looks like __GFP_RETRY_MAYFAIL would be better suited wrt OOM for both
> allocators and would allow to reuse kvmalloc though it would try much harder
> than __GFP_NORETRY.

Yes.

> Ideally something like GFP_KERNEL | __GFP_NOWARN |
> __GFP_NOOOM | __GFP_ZERO would be nice to have, semantics of __GFP_RETRY_MAYFAIL
> kind of gets closer to it from looking at dcda9b0471.

NOOOM semantic is simply impossible to make it sensible as explained
above.

> >> Considering dcda9b0471 ("mm, tree wide: replace __GFP_REPEAT by
> >> __GFP_RETRY_MAYFAIL with more useful semantic") we can replace
> >> __GFP_NORETRY with __GFP_RETRY_MAYFAIL, as it won't invoke OOM killer
> >> and will try harder to fulfil allocation requests.
> >>
> >> The change has been tested with the workloads mentioned above and by
> >> observing oom_kill value from /proc/vmstat.
> >>
> >> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> >> ---
> >>  kernel/bpf/syscall.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index 62f6bced3a3c..eb5cefe44af3 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -136,11 +136,11 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
> >>  
> >>  void *bpf_map_area_alloc(size_t size, int numa_node)
> >>  {
> >> -	/* We definitely need __GFP_NORETRY, so OOM killer doesn't
> >> -	 * trigger under memory pressure as we really just want to
> >> -	 * fail instead.
> >> +	/* We definitely need __GFP_NORETRY or __GFP_RETRY_MAYFAIL, so
> >> +	 * OOM killer doesn't trigger under memory pressure as we really
> >> +	 * just want to fail instead.
> >>  	 */
> >> -	const gfp_t flags = __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO;
> >> +	const gfp_t flags = __GFP_NOWARN | __GFP_RETRY_MAYFAIL | __GFP_ZERO;
> >>  	void *area;
> >>  
> >>  	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
> >> -- 
> >> 2.21.0
> >>
> > 

-- 
Michal Hocko
SUSE Labs
