Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB6CC43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 12:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272A120684
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552046461;
	bh=ST/wkxAbC0akY5EDU0/+5Pd0bUoZG2xVbt/rjEH699M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uiWxPjaJxgBUQV6gzsJXkMhLALUOFJce2H2/SQW4piNKsK3thPF/sV1lC7XdX+3OI
	 Bc5Gk1iCeW1PVXfPaClFMPEoZjqtA2xhUhPVE5MuFo4q/JMmZllv1uR2hQXK7rAHdT
	 bl/RGOMPghgwtXpMlS8nto94aX2Zv9lLOL3YF6pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfCHMBA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:01:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:47258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfCHMBA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 07:01:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B09DAE07;
        Fri,  8 Mar 2019 12:00:58 +0000 (UTC)
Date:   Fri, 8 Mar 2019 13:00:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org,
        ast@kernel.org
Subject: Re: [PATCH] bpf: Try harder when allocating memory for maps
Message-ID: <20190308120054.GK5232@dhcp22.suse.cz>
References: <20190308080857.12005-1-m@lambda.lt>
 <20190308084413.GB5232@dhcp22.suse.cz>
 <295a56f7-6028-3c45-63d4-b6394cc787f1@iogearbox.net>
 <20190308105553.GD5232@dhcp22.suse.cz>
 <71565608-1478-cbb9-62b6-0292e01a3d09@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71565608-1478-cbb9-62b6-0292e01a3d09@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri 08-03-19 12:30:47, Daniel Borkmann wrote:
> On 03/08/2019 11:55 AM, Michal Hocko wrote:
> > On Fri 08-03-19 11:33:00, Daniel Borkmann wrote:
> >> On 03/08/2019 09:44 AM, Michal Hocko wrote:
> >>> On Fri 08-03-19 09:08:57, Martynas Pumputis wrote:
> >>
> >> Martynas, for the patch, please also Cc netdev in the submission so
> >> that it lands properly in patchwork. Setup where patches only Cc'ed
> >> to bpf@vger.kernel.org would land in our delegate is not yet completed
> >> by ozlabs folks, just fyi.
> >>
> >>>> It has been observed that sometimes memory allocation for BPF maps
> >>>> fails when there is no obvious memory pressure in a system.
> >>>>
> >>>> E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
> >>>> could not be created due to due to vmalloc unable to allocate 75497472B,
> >>>> when the system's memory consumption (in MB) was the following:
> >>>>
> >>>>     Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727
> >>>
> >>> Hmm 75MB is quite large and much larger than the slab/page allocator
> >>> cann provide so this is not really a fragmentation issue. Vmalloc does
> >>
> >> Agree.
> >>
> >>> respect noretry but considering that there shouldn't be a large memory
> >>> pressure I wonder how NORETRY managed to fail the allocation. Do you
> >>> happen to have the allocation failure report?
> >>
> >> I'll defer to Martynas here.
> >>
> >>> Btw. is there any real reason to opencode and duplicate kvmalloc logic
> >>> here? In other words why not simply make bpf_map_area_alloc use
> >>> kvmalloc_node with GFP_KERNEL?
> >>
> >> Mostly historical reasons from d407bd25a204 ("bpf: don't trigger OOM killer
> >> under pressure with map alloc"). I remember back then we had a discussion
> >> that __GFP_NORETRY is not fully supported and should only be seen as a hint
> >> in our case (since it's not propagated all the way through in vmalloc, if
> >> I recall correctly).
> > 
> > Yes, that is still the case and there is no way to really have nooom
> > semantic for vmalloc. Even with your opencoded version btw.
> 
> Okay, so similar situation applies to __GFP_RETRY_MAYFAIL reclaim modifier
> then if I understand you correctly? In dcda9b0471, its mentioned "this
> means that all the reclaim opportunities have been exhausted except the
> most disruptive one (the OOM killer) and a user defined fallback behavior
> is more sensible than keep retrying in the page allocator." In the api
> comment in kvmalloc_node(), it says "__GFP_RETRY_MAYFAIL is supported,
> and it should be used only if kmalloc is preferable to the vmalloc fallback,
> due to visible performance drawbacks". But if you say above that for
> vmalloc, there is no nooom semantic, then presumably __GFP_RETRY_MAYFAIL
> should also be taken as a hint wrt OOM, not a guarantee for the given
> allocation request (if kvmalloc_node selects the vmalloc based allocator),
> is that correct?

Yes, kvmalloc* doesn't have the full MAYFAIL/NORETRY semantic because
this is not possible to implement without reworking the whole page table
allocation code or making both behave like scoped NOFS/NOIO.

But I believe you shouldn't really have to care. Does the same problem
really happen with a plain kvmalloc(GFP_KERNEL)?
-- 
Michal Hocko
SUSE Labs
