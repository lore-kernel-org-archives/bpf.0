Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10780C10F06
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 19:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFDD214AE
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 19:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552333594;
	bh=8q7UbUvjtjNXBjid8NyGL8XnA5i9GUwRffaZgz0Klfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BxVUW78MWCRx/TQ2IOteiI3I4q2Ru55yZsf5VlEdGhI68QwgZtqA3uy9DKZCr2jgU
	 dk0ojl4Jr9VjVRFl/Zc3wV1bldskmwSf4AHtzLdLxrNYWaYN/CHRKKG4pMk1/7+HfV
	 Jd3yC+v1AHhjKgyptWbaXnPjKZA/NvZOWJOl2hFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfCKTqc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:46:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:57604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbfCKTqc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 15:46:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC828AF1F;
        Mon, 11 Mar 2019 19:46:29 +0000 (UTC)
Date:   Mon, 11 Mar 2019 20:46:28 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Martynas Pumputis <m@lambda.lt>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [PATCH] bpf: Try harder when allocating memory for large maps
Message-ID: <20190311194628.GD5721@dhcp22.suse.cz>
References: <20190311193112.25527-1-m@lambda.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311193112.25527-1-m@lambda.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon 11-03-19 20:31:12, Martynas Pumputis wrote:
> It has been observed that sometimes a higher order memory allocation
> for BPF maps fails when there is no obvious memory pressure in a system.
> 
> E.g. the map (BPF_MAP_TYPE_LRU_HASH, key=38, value=56, max_elems=524288)
> could not be created due to vmalloc unable to allocate 75497472B,
> when the system's memory consumption (in MB) was the following:
> 
>     Total: 3942 Used: 837 (21.24%) Free: 138 Buffers: 239 Cached: 2727
> 
> Later analysis [1] by Michal Hocko showed that the vmalloc was not trying
> to reclaim memory from the page cache and was failing prematurely due to
> __GFP_NORETRY.
> 
> Considering dcda9b0471 ("mm, tree wide: replace __GFP_REPEAT by
> __GFP_RETRY_MAYFAIL with more useful semantic") and [1], we can replace
> __GFP_NORETRY with __GFP_RETRY_MAYFAIL, as it won't invoke OOM killer
> and will try harder to fulfil allocation requests.
> 
> The change has been tested with the workloads mentioned above and by
> observing oom_kill value from /proc/vmstat.

Please document why kvmalloc_node is not used.

> [1]: https://lore.kernel.org/bpf/20190310071318.GW5232@dhcp22.suse.cz/
> 
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---
>  kernel/bpf/syscall.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 62f6bced3a3c..1b0a057ed6d5 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -136,20 +136,26 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
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
> +	const gfp_t flags = __GFP_NOWARN | __GFP_ZERO;
>  	void *area;
>  
>  	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
> -		area = kmalloc_node(size, GFP_USER | flags, numa_node);
> +		/* To avoid bypassing slab alloc for lower order allocs,
> +		 * __GFP_NORETRY is used instead of __GFP_RETRY_MAYFAIL.
> +		 */
> +		area = kmalloc_node(size, GFP_USER | __GFP_NORETRY | flags,
> +				    numa_node);
>  		if (area != NULL)
>  			return area;
>  	}
>  
> -	return __vmalloc_node_flags_caller(size, numa_node, GFP_KERNEL | flags,
> +	return __vmalloc_node_flags_caller(size, numa_node,
> +					   GFP_KERNEL | __GFP_RETRY_MAYFAIL |
> +					   flags,
>  					   __builtin_return_address(0));
>  }
>  
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
