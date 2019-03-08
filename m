Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5678CC43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 08:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA4D20854
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552034656;
	bh=PNjxsMqgaMXLpiDUJlf+Jggrm92WxrDKeKUV6y2dRmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v0OyyZcsN3DDGu6JHygCCoLFsPzJbrLUv8bxCbNzivDs4S5TY+NFHR9+bJQUDtKxs
	 9A7gSX1+1hmxl/kNexfbgbXD8ceN617NDuIERnJ0xPhviNy93X/FL66CDiP0Scx6V+
	 tfwMQtQQwrxFzoesega255fMrubhnm9JVx9DyFSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfCHIoP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:44:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:41284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbfCHIoP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 03:44:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5D676AEA3;
        Fri,  8 Mar 2019 08:44:14 +0000 (UTC)
Date:   Fri, 8 Mar 2019 09:44:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Martynas Pumputis <m@lambda.lt>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH] bpf: Try harder when allocating memory for maps
Message-ID: <20190308084413.GB5232@dhcp22.suse.cz>
References: <20190308080857.12005-1-m@lambda.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308080857.12005-1-m@lambda.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri 08-03-19 09:08:57, Martynas Pumputis wrote:
> It has been observed that sometimes memory allocation for BPF maps
> fails when there is no obvious memory pressure in a system.
> 
> E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
> could not be created due to due to vmalloc unable to allocate 75497472B,
> when the system's memory consumption (in MB) was the following:
> 
>     Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727

Hmm 75MB is quite large and much larger than the slab/page allocator
cann provide so this is not really a fragmentation issue. Vmalloc does
respect noretry but considering that there shouldn't be a large memory
pressure I wonder how NORETRY managed to fail the allocation. Do you
happen to have the allocation failure report?

Btw. is there any real reason to opencode and duplicate kvmalloc logic
here? In other words why not simply make bpf_map_area_alloc use
kvmalloc_node with GFP_KERNEL?

> Considering dcda9b0471 ("mm, tree wide: replace __GFP_REPEAT by
> __GFP_RETRY_MAYFAIL with more useful semantic") we can replace
> __GFP_NORETRY with __GFP_RETRY_MAYFAIL, as it won't invoke OOM killer
> and will try harder to fulfil allocation requests.
> 
> The change has been tested with the workloads mentioned above and by
> observing oom_kill value from /proc/vmstat.
> 
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>  kernel/bpf/syscall.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 62f6bced3a3c..eb5cefe44af3 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -136,11 +136,11 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
>  
>  void *bpf_map_area_alloc(size_t size, int numa_node)
>  {
> -	/* We definitely need __GFP_NORETRY, so OOM killer doesn't
> -	 * trigger under memory pressure as we really just want to
> -	 * fail instead.
> +	/* We definitely need __GFP_NORETRY or __GFP_RETRY_MAYFAIL, so
> +	 * OOM killer doesn't trigger under memory pressure as we really
> +	 * just want to fail instead.
>  	 */
> -	const gfp_t flags = __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO;
> +	const gfp_t flags = __GFP_NOWARN | __GFP_RETRY_MAYFAIL | __GFP_ZERO;
>  	void *area;
>  
>  	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
