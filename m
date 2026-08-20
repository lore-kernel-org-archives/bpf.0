Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301F3B95F8;
	Thu, 20 Aug 2026 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209524; cv=none; b=dUvOspG/V4ZeDtWen56BO7rDdyQYWGnEPRFCp78Gkwj1o2EfBmgtjF2TVneOpHdnaEuO4M9COZVSpIjvswG5nD7KpXo4up6DBNzR2oSbDYTGMkOyo55hsFEbQ5t8t6j/UvGjoUZcN6q9IG2LWvSHcRglZg3ybbi/FhWErTbQEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209524; c=relaxed/simple;
	bh=cqV/pt+I7GrZDqgxJv/zhHPM2AQzsZ8GUtxgGPoLBM4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=int3rhy/I6jPzt+KXUFCf00qZ8FymWSEdHCWOLeCpDDvqPTrcuMvoHCR+WjNv43K0ItjhINWn6zp3W18eGHoR7Q12Ua8TMsIkmeQcYFQ38yP/ceqjuXhwQs+6aa6jBsCR++8Q9040zxrkrRdnUyrbeX9KsjulTMT6i6O/0e3myM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hn/7B948; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn/7B948"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB9F1F00A3A;
	Thu, 20 Aug 2026 07:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787209523;
	bh=91sdNajum8+aHRdx8jSsE/sNi3ZgWiCvITJ6xT+pUkY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hn/7B9481atS/2m0mGXcx/BMNBtavJOIOI1WMUGEERHgo3PpV5incPH8Adbtl8UhP
	 y39un0XYSFATY8cdJisJqJIs8i18WTNoYRzs7BpwC3Sn+eT7l7c4JpZt9sicUeQ90b
	 WfWv0dhLUne06st/tu4eszRIWk+2Kk79+CLElwnsa5iWyHl0M57fLkRJmNkmbob+fv
	 8Iea5lj34OLvkIj0bK46rqh4I+/ygEXZXc9x3/voreZqM2s4JPbwiy5DCTWsMRZJKt
	 yn+Al6ccbgXE3gc4BX/JQjmS8JbTjsN091NHLimBxBHgnv0lgj4kCVT2LAUxlibg9U
	 /1374apcvbkew==
Content-Type: multipart/mixed; boundary="===============8690568711721681409=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a86acfeb2792a1df00f1eb8d1a42a520e8b0b9fc4276ad4bd68d2154a5c8312c@mail.kernel.org>
In-Reply-To: <e9b2a34418919f5c3ee2b80bcb4f9d80ce6ec422.1787205002.git.zhuhui@kylinos.cn>
References: <e9b2a34418919f5c3ee2b80bcb4f9d80ce6ec422.1787205002.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v4 1/2] mm/bpf: Add bpf_proactive_reclaim kfuncs
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,baohua@kernel.org,geliang@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Aug 2026 07:05:22 +0000 (UTC)

--===============8690568711721681409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..dc51868b3acf 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> @@ -159,6 +160,120 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  	mem_cgroup_flush_stats(memcg);
>  }
>
> +/*
> + * Shared implementation of the proactive reclaim kfuncs: performs one
> + * reclaim pass on @memcg with @nr_pages as the goal, allowing swap, and
> + * @swappiness as the anon/file balance override (NULL to follow the
> + * cgroup's own swappiness setting). Returns the reclaimed amount in
> + * bytes, keeping the byte-based unit of the kfuncs' @size argument.
> + */
> +static unsigned long
> +bpf_proactive_reclaim_pages(struct mem_cgroup *memcg, unsigned long nr_pages,
> +			    int *swappiness)

This isn't a bug, but would it be worth trimming the comment above
bpf_proactive_reclaim_pages() and de-duplicating the identical 'Return:'
paragraph that now appears in both kfunc kernel-docs, so the byte/page
unit conversion is documented in exactly one place?

> +{
> +	unsigned long nr_reclaimed;
> +
> +	if (!nr_pages || unlikely(bpf_in_reclaim_context()))
> +		return 0;
> +
> +	nr_reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
> +						    MEMCG_RECLAIM_MAY_SWAP |
> +						    MEMCG_RECLAIM_PROACTIVE,
> +						    swappiness);
> +
> +	return nr_reclaimed * PAGE_SIZE;
> +}
> +
> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
> + *                         cgroup
> + * @memcg: the target memory cgroup to reclaim from
> + * @size:  the amount of memory to reclaim, in bytes
> + *
> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
> + * the memory.reclaim cgroup file: pages are reclaimed according to the
> + * cgroup's own swappiness setting and swap is allowed. Note that,
> + * unlike memory.reclaim, this does not retry until @size is reached;
> + * callers can invoke it again if needed.
> + *
> + * The reclaim runs with GFP_KERNEL, so this function must not be called
> + * from a context that holds a filesystem lock (e.g. an LSM hook invoked
> + * with inode_lock held): the reclaim path may enter filesystem shrinkers
> + * and deadlock trying to reacquire the lock. Contexts that set
> + * PF_MEMALLOC_NOFS/NOIO are handled by the gfp context inheritance.
> + *
> + * Return:
> + *   The amount of memory actually reclaimed, in bytes (rounded to full
> + *   pages), or 0 if @size is smaller than a page or the calling task is
> + *   already in a reclaim/freeing context (PF_MEMALLOC).
> + */
> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> +						unsigned long size)
> +{
> +	return bpf_proactive_reclaim_pages(memcg, size / PAGE_SIZE, NULL);
> +}
> +
> +/**
> + * bpf_proactive_reclaim_swappiness - proactively reclaim memory from a
> + *                                    memory cgroup with an explicit
> + *                                    swappiness
> + * @memcg:      the target memory cgroup to reclaim from
> + * @size:       the amount of memory to reclaim, in bytes
> + * @swappiness: swappiness override for this reclaim pass
> + *
> + * Same as bpf_proactive_reclaim(), except that the anon/file reclaim
> + * balance is controlled by @swappiness instead of the cgroup's
> + * swappiness setting. Valid values are [MIN_SWAPPINESS, MAX_SWAPPINESS]
> + * and SWAPPINESS_ANON_ONLY, which restricts reclaim to anon folios.
> + *
> + * Return:
> + *   The amount of memory actually reclaimed, in bytes (rounded to full
> + *   pages), (unsigned long)-1 if @swappiness is out of range, or 0 if
> + *   @size is smaller than a page or the calling task is already in a
> + *   reclaim/freeing context (PF_MEMALLOC).
> + */
> +__bpf_kfunc unsigned long
> +bpf_proactive_reclaim_swappiness(struct mem_cgroup *memcg, unsigned long size,
> +				 int swappiness)
> +{
> +	if (swappiness < MIN_SWAPPINESS || swappiness > SWAPPINESS_ANON_ONLY)
> +		return (unsigned long)-1;
> +
> +	return bpf_proactive_reclaim_pages(memcg, size / PAGE_SIZE,
> +					   &swappiness);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32339450346
--===============8690568711721681409==--
