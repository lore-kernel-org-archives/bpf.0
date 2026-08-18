Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4693A75A8;
	Tue, 18 Aug 2026 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045199; cv=none; b=pAk5Cn05X/3V9c60wIWRUuwGe8Ru/JF34EcIo9hheIAjxEB3ten99kB4VqxQdgIMtsfTxhenhGPeLXuwqrDuQK2cPTJb+V2vteI6RrwVeJpSJEmp+OjBv8+ZBev5i6DaaaMrVnWD9jejp9BkeTnb4r8rhFK+xZOpJ0uL+0AFGg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045199; c=relaxed/simple;
	bh=ijYeov9+phLHOK+Zfxq0MWwb14HYPg3R6Saxq8SSvVk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EKTsLMttoHjOMQWZaz1s9hGL80p4GKSsE16YHH6LSiS2PaorZxLeTqkUUQ7YrJ7siRn3bhNFbZFRbDWEhCeuqeEuqzmpo8g8YserJjlvqtSq6IiF14IsateMkqtCXu0F+Y+OfinBeBHnTTA/MHXwy9NjAtzoh7Y7Dk3Jk8DXkPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWdtEYnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWdtEYnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC171F00A3A;
	Tue, 18 Aug 2026 09:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787045198;
	bh=fWecLJvO/FetFb4ebnNXlE1tjrKht5ApopqY9KDaHKs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jWdtEYnOyj7sUuIkKU4Y4954kyhF1FeeJceoNHWdmBIB/8VEeMnxkT7vzIDwS1OsU
	 9uuoEcZiK9L8rK8iJ1rlLP+y3AOkLaJfzzCchwEqV8jWUUDZH75v1GQDf6IghnezK3
	 QjPRoZdLSKAAJSuMhVKLJvHhWOldNVM6cPorc2tq4U9XWWwc5SA1WzQcT8xiLjqhb4
	 i6Ck99zOY/+fHlVOv5rFDE6ZLECCpf//L50xdNahxHb0XMO7cNHjOx6cu15t0IJ/15
	 7QKr2KT/hDMp79WnlpEhTj+YMhGI/osyrTLJip54uhtD0oBmDB7OBuyvB6ovjviAWr
	 UK05w0AAkfHjw==
Content-Type: multipart/mixed; boundary="===============9099388685773276073=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <30f7c22f4a1db2da698d46d0834b7b6de07d0eb121f9e5a76cd7b1c892c388f9@mail.kernel.org>
In-Reply-To: <ea02caf3118cfc34cb9845f75ac655abf04b7b9f.1787040082.git.zhuhui@kylinos.cn>
References: <ea02caf3118cfc34cb9845f75ac655abf04b7b9f.1787040082.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 1/2] mm/bpf: Add bpf_proactive_reclaim kfuncs
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,baohua@kernel.org,geliang@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Aug 2026 09:26:37 +0000 (UTC)

--===============9099388685773276073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..92272f9a5825 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> @@ -159,6 +160,97 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  	mem_cgroup_flush_stats(memcg);
>  }
>
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
> + * Return:
> + *   The number of pages actually reclaimed, or 0 if @size is smaller
> + *   than a page or the calling task is already in a reclaim/freeing
> + *   context (PF_MEMALLOC).
> + */
> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> +						unsigned long size)
> +{
> +	unsigned long nr_pages = size / PAGE_SIZE;
> +
> +	if (!nr_pages || unlikely(bpf_in_reclaim_context()))
> +		return 0;
> +
> +	return try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
> +					    MEMCG_RECLAIM_MAY_SWAP |
> +					    MEMCG_RECLAIM_PROACTIVE, NULL);
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
> + *   The number of pages actually reclaimed, or 0 if @size is smaller
> + *   than a page, @swappiness is out of range, or the calling task is
> + *   already in a reclaim/freeing context (PF_MEMALLOC).
> + */
> +__bpf_kfunc unsigned long
> +bpf_proactive_reclaim_swappiness(struct mem_cgroup *memcg, unsigned long size,
> +				 int swappiness)
> +{
> +	unsigned long nr_pages = size / PAGE_SIZE;
> +
> +	if (!nr_pages || swappiness < MIN_SWAPPINESS ||
> +	    swappiness > SWAPPINESS_ANON_ONLY ||
> +	    unlikely(bpf_in_reclaim_context()))
> +		return 0;
> +
> +	return try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
> +					    MEMCG_RECLAIM_MAY_SWAP |
> +					    MEMCG_RECLAIM_PROACTIVE,
> +					    &swappiness);
> +}

This isn't a bug, but these two kfuncs are nearly identical apart from the
swappiness range check and passing '&swappiness' vs 'NULL' to
try_to_free_mem_cgroup_pages(). Both compute 'nr_pages = size /
PAGE_SIZE', both apply the same '!nr_pages ||
unlikely(bpf_in_reclaim_context())' guard, and both use identical
'GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE' arguments.

Would a shared static helper taking an 'int *swappiness' parameter (the
shape try_to_free_mem_cgroup_pages() already accepts) keep the guard logic
and reclaim flags in one place?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32118218829
--===============9099388685773276073==--
