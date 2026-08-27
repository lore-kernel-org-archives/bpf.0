Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37DF26F2A0;
	Thu, 27 Aug 2026 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830675; cv=none; b=g0hjTRPidWXk1uQOcs0fM8Wbccvo8cMgRHrrUyaOohIBCtG9mMJKFxk0sagWk0xi8S/QilRpW9y/6UUmRWa4xHJZjD27K3R8F9k/95m8w/udIfbfCVuAeL/JASvGi2WrLdMe6PKbOZHITgF0LtsN8WWLXMuBQ8+eXAcTEnK6/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830675; c=relaxed/simple;
	bh=Td5IBZVcwUuBYt3fxPnH5u0AD3u9vFAbX122SioIAL4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sFZQykjj+q51as3+dOD4nCWBO4PG0lHPg7yYGt/3FqgDuwnqKUvDK2mpoJ0dIxAuiF1VXsbq25rJBMhiADds8NP9Wf/Sx4ChVxpuiDGhpdo0Wn7+ERhWLXFtz0ydsrNw8NNVH6slZDeXT8XM9IZ35pSnRHMvyMI/+iGC4loSIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsvQtx4U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsvQtx4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A031F000E9;
	Thu, 27 Aug 2026 11:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787830674;
	bh=56nzedIl1+mqwm0MbyDV8FH62QOyf8pSMLBlCAE1uY4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TsvQtx4UmwiBwQJyqnqf7vqt0wHEgs9lR0xSuJwmUZcAdcUBfk/uwsHpakk4nXeNg
	 bplu7fVdV2KWEzJrWFRQdfNT+mbfwNP80IXOw+rIpxrJzNpYgal1OnJapZ5kfO/zW6
	 bIN0ovtrC48XGESwLFG4w3KTlO5A70WHeYerd3ybW49Ekpq19PAZS51D3lk4ZaD+EP
	 1OAVjw5S+Th7nAD69efUHzmzuicBNLG1rRBcb5c12uD3cNiVPN/su7jEW6wUpA3mFv
	 AJlPj+8EcgkVwtnyls+mmTaHFutSD/69m95sSFzlRF++bE2GV3NP2IywxTRzh+LfIv
	 0+pRkJhrfVdIg==
Content-Type: multipart/mixed; boundary="===============4363785558182586070=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d9d1848356ba38a47eaf5f8ca43ea8e2ec61baa5fd28ce23c5888babb260374f@mail.kernel.org>
In-Reply-To: <5dfdc7800469eac4e9a240f2422ba65d4ef4c4ba.1787826402.git.zhuhui@kylinos.cn>
References: <5dfdc7800469eac4e9a240f2422ba65d4ef4c4ba.1787826402.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v5 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,baohua@kernel.org,geliang@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 27 Aug 2026 11:37:53 +0000 (UTC)

--===============4363785558182586070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> mm/bpf: Add bpf_proactive_reclaim kfunc
>
> Add bpf_proactive_reclaim(), a sleepable kfunc which performs one
> proactive reclaim pass on a given memory cgroup, similar to a write
> to memory.reclaim but without retrying until the target is reached.
>
> The kfunc refuses to reclaim if the calling task is already in a
> reclaim context, as a nested reclaim would corrupt the outer reclaim
> state.
>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

This isn't a bug, but could the changelog say why this kfunc is needed -
the intended consumer, and why a single non-retrying pass is preferred
over what a write to memory.reclaim does - rather than restating what the
function does?

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d76477..297ff7f050427 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> @@ -159,6 +160,49 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  	mem_cgroup_flush_stats(memcg);
>  }
>
> +/*
> + * Reclaim must not recurse: try_to_free_mem_cgroup_pages() overwrites
> + * current->reclaim_state, so a nested call would corrupt the outer
> + * reclaim state. Reclaim windows are marked with PF_MEMALLOC;
> + * reclaim_state is also checked because it is installed slightly
> + * before PF_MEMALLOC.
> + */
> +static bool bpf_in_reclaim_context(void)
> +{
> +	return (current->flags & PF_MEMALLOC) || current->reclaim_state;
> +}
> +
> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
> + *                         cgroup
> + * @memcg: the target memory cgroup to reclaim from
> + * @size:  the amount of memory to reclaim, in bytes
> + *
> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
> + * memory.reclaim, but without retrying until @size is reached.
> + * Must not be called with a filesystem lock held: the reclaim path
> + * may deadlock on it via filesystem shrinkers.
> + *
> + * Return: The amount of memory reclaimed, in bytes, or 0 if @size is
> + * smaller than a page or the task is already in a reclaim context.
> + */
> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> +						unsigned long size)
> +{
> +	unsigned long nr_reclaimed;
> +
> +	if (size < PAGE_SIZE || unlikely(bpf_in_reclaim_context()))
> +		return 0;
> +
> +	nr_reclaimed = try_to_free_mem_cgroup_pages(memcg, size / PAGE_SIZE,
> +						    GFP_KERNEL,
> +						    MEMCG_RECLAIM_MAY_SWAP |
> +						    MEMCG_RECLAIM_PROACTIVE,
> +						    NULL);
> +
> +	return nr_reclaimed * PAGE_SIZE;
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
> @@ -172,6 +216,8 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
>  BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
>  BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
>
> +BTF_ID_FLAGS(func, bpf_proactive_reclaim, KF_SLEEPABLE)
> +

This isn't a bug, but would it be worth extending
tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c (or adding a small
test) to exercise bpf_proactive_reclaim?  The sibling kfuncs registered in
the same set (bpf_get_mem_cgroup, bpf_mem_cgroup_flush_stats,
bpf_mem_cgroup_page_state, bpf_mem_cgroup_vm_events) are all exercised by
that test, and a test would pin down the byte units and the 'returns 0'
cases.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33064477499
--===============4363785558182586070==--
