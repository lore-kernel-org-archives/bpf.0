Return-Path: <SRS0=JidB=RV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF15C43381
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 15:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCAF2087E
	for <bpf@archiver.kernel.org>; Mon, 18 Mar 2019 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552923587;
	bh=WYFm/lIcbWgcnfwIVi5+MM/QMWgOl4XFh5Y8katOEp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UvFIhJIhgbb2kyFGi+mhj7I3H3Oz3p/Hw/RaMz5G9mEL/HjIjTDroRKG0FHTmgYQf
	 iP0Vc7TNYAywHNm0lMYT/GIUnCKpAEszij9bUQf57ZAhlpYHF67Z04UK0DuKxLNuyk
	 hehq2z6RCcAa0nPNdQg/GvMwOlEO/+CQckqABNaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfCRPjr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:39:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbfCRPjr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Mar 2019 11:39:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAC35AED5;
        Mon, 18 Mar 2019 15:39:44 +0000 (UTC)
Date:   Mon, 18 Mar 2019 16:39:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Martynas Pumputis <m@lambda.lt>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v3 bpf] bpf: Try harder when allocating memory for large
 maps
Message-ID: <20190318153940.GL8924@dhcp22.suse.cz>
References: <20190318151026.21539-1-m@lambda.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318151026.21539-1-m@lambda.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon 18-03-19 16:10:26, Martynas Pumputis wrote:
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
> Unfortunately, replacing the body of the BPF map memory allocation
> function with the kvmalloc_node helper function is not an option at this
> point in time, given 1) kmalloc is non-optional for higher order
> allocations, and 2) passing __GFP_RETRY_MAYFAIL to the kmalloc would stress
> the slab allocator too much for large requests.
> 

Thanks for extending the changelog!

> The change has been tested with the workloads mentioned above and by
> observing oom_kill value from /proc/vmstat.
> 
> [1]: https://lore.kernel.org/bpf/20190310071318.GW5232@dhcp22.suse.cz/
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Martynas Pumputis <m@lambda.lt>

The patch looks good to me from the allocator usage POV. I wish there
was a good way to give you a util function to use rather than opencoding
but this is the only place with this semantic I have seen and I am not
sure it is generic enough. Let's see what the future has to tell us.

> ---
>  kernel/bpf/syscall.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 62f6bced3a3c..afca36f53c49 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -136,21 +136,29 @@ static struct bpf_map *find_and_alloc_map(union bpf_attr *attr)
>  
>  void *bpf_map_area_alloc(size_t size, int numa_node)
>  {
> -	/* We definitely need __GFP_NORETRY, so OOM killer doesn't
> -	 * trigger under memory pressure as we really just want to
> -	 * fail instead.
> +	/* We really just want to fail instead of triggering OOM killer
> +	 * under memory pressure, therefore we set __GFP_NORETRY to kmalloc,
> +	 * which is used for lower order allocation requests.
> +	 *
> +	 * It has been observed that higher order allocation requests done by
> +	 * vmalloc with __GFP_NORETRY being set might fail due to not trying
> +	 * to reclaim memory from the page cache, thus we set
> +	 * __GFP_RETRY_MAYFAIL to avoid such situations.
>  	 */
> -	const gfp_t flags = __GFP_NOWARN | __GFP_NORETRY | __GFP_ZERO;
> +
> +	const gfp_t flags = __GFP_NOWARN | __GFP_ZERO;
>  	void *area;
>  
>  	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
> -		area = kmalloc_node(size, GFP_USER | flags, numa_node);
> +		area = kmalloc_node(size, GFP_USER | __GFP_NORETRY | flags,
> +				    numa_node);
>  		if (area != NULL)
>  			return area;
>  	}
>  
> -	return __vmalloc_node_flags_caller(size, numa_node, GFP_KERNEL | flags,
> -					   __builtin_return_address(0));
> +	return __vmalloc_node_flags_caller(size, numa_node,
> +					   GFP_KERNEL | __GFP_RETRY_MAYFAIL |
> +					   flags, __builtin_return_address(0));
>  }
>  
>  void bpf_map_area_free(void *area)
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
