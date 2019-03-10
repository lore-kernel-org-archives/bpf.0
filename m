Return-Path: <SRS0=ta7F=RN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E40C43381
	for <bpf@archiver.kernel.org>; Sun, 10 Mar 2019 07:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF1E206BA
	for <bpf@archiver.kernel.org>; Sun, 10 Mar 2019 07:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552202002;
	bh=2ew/7LH3ZlyfVCQmSQuDMxZyZMjIBGE2G8i2txrkDuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xgEWXHAZsYqwFLHqjzyeGucAbk8XeEnToHspFcjs9E5v0wdIHZ6QtEDAv8mslpIeU
	 unvEVyRa1EzIc7UuBrq/AiKAgl3Y5c5MXKZBHNNVGLStbJKcPuC8UrLOCH/M/8imDA
	 JvSdOEjwuBYn5dfdOwzrK0qJCC9rFiL7/IEAwgrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfCJHNW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 10 Mar 2019 03:13:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:33872 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbfCJHNW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Mar 2019 03:13:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEB75AF42;
        Sun, 10 Mar 2019 07:13:19 +0000 (UTC)
Date:   Sun, 10 Mar 2019 08:13:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH] bpf: Try harder when allocating memory for maps
Message-ID: <20190310071318.GW5232@dhcp22.suse.cz>
References: <20190308080857.12005-1-m@lambda.lt>
 <20190308084413.GB5232@dhcp22.suse.cz>
 <69fdfb33-057b-b7fe-033e-d82006a779b9@lambda.lt>
 <20190308112000.GG5232@dhcp22.suse.cz>
 <2cbb3fe7-39a9-1b1e-e22f-4dffa20b9414@lambda.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cbb3fe7-39a9-1b1e-e22f-4dffa20b9414@lambda.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri 08-03-19 21:02:41, Martynas Pumputis wrote:
> 
> 
> On 3/8/19 12:20 PM, Michal Hocko wrote:
> > On Fri 08-03-19 12:14:16, Martynas Pumputis wrote:
> > > 
> > > 
> > > On 3/8/19 9:44 AM, Michal Hocko wrote:
> > > > On Fri 08-03-19 09:08:57, Martynas Pumputis wrote:
> > > > > It has been observed that sometimes memory allocation for BPF maps
> > > > > fails when there is no obvious memory pressure in a system.
> > > > > 
> > > > > E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
> > > > > could not be created due to due to vmalloc unable to allocate 75497472B,
> > > > > when the system's memory consumption (in MB) was the following:
> > > > > 
> > > > >       Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727
> > > > 
> > > > Hmm 75MB is quite large and much larger than the slab/page allocator
> > > > cann provide so this is not really a fragmentation issue. Vmalloc does
> > > > respect noretry but considering that there shouldn't be a large memory
> > > > pressure I wonder how NORETRY managed to fail the allocation. Do you
> > > > happen to have the allocation failure report?
> > > 
> > > I got /proc/{meminfo,vmstat,vmallocinfo} just after the allocation has
> > > failed:
> > > https://gist.github.com/brb/62092c1d83daa6527271b88f0352e32d
> > 
> > dmesg with the allocation failure report would be more helpful
> 
> https://gist.github.com/brb/2d7ac323d2e14cb7a38bacba301fe3af

Thanks!

tc: vmalloc: allocation failure, allocated 15609856 of 62918656 bytes, mode:0x6090c0(GFP_KERNEL|__GFP_NORETRY|__GFP_ZERO), nodemask=(null),cpuset=b389e318420d891300ad9658f8e056b59972fda9547dd566245a922c34bb9e42,mems_allowed=0
[...]
Node 0 DMA free:15728kB min:268kB low:332kB high:396kB active_anon:0kB inactive_anon:0kB active_file:44kB inactive_file:12kB unevictable:0kB writepending:0kB present:15992kB managed:15908kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
lowmem_reserve[]: 0 3419 3866 3866 3866
Node 0 DMA32 free:105004kB min:104588kB low:119468kB high:134348kB active_anon:526128kB inactive_anon:612kB active_file:862524kB inactive_file:1552884kB unevictable:0kB writepending:0kB present:3653568kB managed:3563596kB mlocked:0kB kernel_stack:7592kB pagetables:6636kB bounce:0kB free_pcp:916kB local_pcp:736kB free_cma:0kB
lowmem_reserve[]: 0 0 446 446 446
Node 0 Normal free:22844kB min:24160kB low:26104kB high:28048kB active_anon:92340kB inactive_anon:228kB active_file:160072kB inactive_file:82480kB unevictable:0kB writepending:0kB present:524288kB managed:457544kB mlocked:0kB kernel_stack:2224kB pagetables:3776kB bounce:0kB free_pcp:996kB local_pcp:672kB free_cma:0kB
lowmem_reserve[]: 0 0 0 0 0

Except for a srtange cpuset value (which should be checked separately),
the allocation is restricted to node 0 which is pretty much out of
memory (below min watermark - lowmem_reserve). There is still a lot of
page cache to reclaim so a further reclaim is quite likely to make a
further progress. There is still 45MB to go and at least page cache is
1.5G so there is some buffer to allocate from.

That being said __GFP_NORETRY caused a pre-mature failure indeed. Using
kvmalloc(GFP_KERNEL|__GFP_RETRY_MAYFAIL) would likely help here unless
the pagecache is really hard to reclaim. Please note that this will also
imply that requests which can be satisfied from the slab allocator will
retry harder as well. Not sure this is desirable for these requests
though but your original patch does the same so if you wanted to have
__GFP_RETRY_MAYFAIL behavior only for the vmalloc path then you would
need to have an opencoded version which adds the flag just to the
vmalloc fallback path.
-- 
Michal Hocko
SUSE Labs
