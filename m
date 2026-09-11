Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC76830C60F;
	Fri, 11 Sep 2026 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789096431; cv=none; b=Mq4aZPAubvntOq7xEXBmYZ3/TiEjXYF/SWKnYz7LHGIK0KUmlfkuzbEbKXggmWcfVabRk38c9iRq6ujG8Km6NqirHxSG5ecaKXp4iznV/J+OZJWmwr+cnJViFOR0dxU9DgRUCQ10BZQmulPfoyqzMsEQemIxyIn0ygr3WzmvvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789096431; c=relaxed/simple;
	bh=+rKZjyjIKKEm5l4dYWFCu78qPcIodZQLyiQd9clSk/g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TH5asNUaQNFfVeo1YITL8+svrzyPV+fFFIzZq1M/QPMGma0elgl1yc4mywiG11A18dK4Kr8DZwWQr6Cni8sorA7dnGtWzh6aK0DJb3LwjHazAUPGBU13i+mIudkeN9fgDMuTrYFQjX7qSaVlKAJEXd1Laca5CI0Mm+JB5tep0Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma3C5FMo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma3C5FMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FF21F000FF;
	Fri, 11 Sep 2026 03:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789096429;
	bh=G1DddBHC5MeyjD1sIZp+I/i8ZYbDbeSOUjgV+XDwDuk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ma3C5FMo+K5F0a0PAr4dYGNGWGzmFcka/UXzgKmG5qFfSFZKfYKL87HYpVug6h7QE
	 5jdRSffCbGskh7CbQp6kqAbPxp8q8hv6WmW040gXe1wX495wKzLyOzDaXIR9RCeIfQ
	 u5S2DUXYhLrOILCYfcWNIHrrF7XxqQYQ4WXwEx84SXTLSIzZkBDYU/xG6ioHHlDLgx
	 aWikRiLrgemgYeF2ELRJ8CIoqMThr416DK/zpJ10EoWxnzPpgWDnrMw7EZN0Zj2ZtC
	 a0lM+lCczoByjz+RAdSTyjkA4ftoHXVUfQ5ifST4Twcp1UB/p0mENP5QjryWRwJMhY
	 Ti81SI3Ni+m7Q==
Content-Type: multipart/mixed; boundary="===============5507926867917437855=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <de930dee4f4a2eba97605a8a651e34398d05dd2340f80a41c1113b2a5f819b0d@mail.kernel.org>
In-Reply-To: <e00910f328c129fea716e9fd031dada328e60313.1789091855.git.zhuhui@kylinos.cn>
References: <e00910f328c129fea716e9fd031dada328e60313.1789091855.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v10 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,baohua@kernel.org,geliang@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 03:13:48 +0000 (UTC)

--===============5507926867917437855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> mm/bpf: Add bpf_proactive_reclaim kfunc
>
> BPF programs can observe memory pressure on a cgroup (e.g. refault
> stats via bpf_mem_cgroup_page_state()), but cannot act on it:
> triggering reclaim on a chosen cgroup requires writing to
> memory.reclaim, which BPF cannot do. Add bpf_proactive_reclaim(),
> a sleepable kfunc which performs one proactive reclaim pass on a
> given memory cgroup, similar to a write to memory.reclaim but
> without retrying until the target is reached, so that when and how
> hard to reclaim is BPF policy rather than hard-coded thresholds.
>
> Since some bpf program types may be invoked while holding fs locks,
> limit the kfunc to BPF_PROG_TYPE_SYSCALL only, to avoid deadlocking
> in filesystem shrinkers on the reclaim path. A SYSCALL program can
> invoke the kfunc directly, or asynchronously from its bpf_wq or
> task_work callbacks, which run in process context and keep the
> SYSCALL program type.
>
> The reclaim target of a single call is capped at MEMCG_CHARGE_BATCH,
> following the precedent of high_work_func(), the memory.high
> workqueue fallback. Note that only the reclaim target is capped: the
> actual scanning work and its duration are not bounded. Reclaiming more
> than one batch is left to the BPF program rather than enforced by the
> kfunc: with one call per bpf_wq callback and the same work item
> requeued for the next batch, the program can also stop submitting
> batches in between, e.g. once the target cgroup is dying.
>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

This isn't a bug, but the commit message doesn't mention the mm/internal.h
change at all. The patch converts MIN_SWAPPINESS / MAX_SWAPPINESS /
SWAPPINESS_ANON_ONLY from macros into an anonymous enum, which touches a
core mm header with ~16 existing use sites. Should the changelog explain
why this conversion was made? The likely reason is BTF emission so BPF
programs can access these constants from vmlinux.h, but without that
explanation a reader can't tell why an mm/vmscan.c-adjacent header was
modified by a patch titled 'mm/bpf: Add bpf_proactive_reclaim kfunc'.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d7647..d8827bc388ef 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -8,6 +8,8 @@
>  #include <linux/memcontrol.h>
>  #include <linux/bpf.h>
>
> +#include "internal.h"
> +
>  __bpf_kfunc_start_defs();
>
> [ ... ]
>
> +/**
> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
> + *                         cgroup
> + * @memcg: the target memory cgroup to reclaim from
> + * @size:  the amount of memory to reclaim, in bytes, clamped to
> + *         MEMCG_CHARGE_BATCH (64 pages)
> + * @swappiness: the reclaim swappiness, in the range
> + *         [MIN_SWAPPINESS, SWAPPINESS_ANON_ONLY], where
> + *         SWAPPINESS_ANON_ONLY means anon-only reclaim, or -1 to use
> + *         the memcg's own swappiness
> + *
> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
> + * memory.reclaim, but without retrying until @size is reached.
> + *
> + * Only the reclaim target is capped: @size is clamped to
> + * MEMCG_CHARGE_BATCH, following the precedent of high_work_func(),
> + * the memory.high workqueue fallback, which bounds each reclaim
> + * request the same way. The actual scanning work and its duration
> + * are not bounded. To reclaim more, call this kfunc repeatedly
> + * instead of passing a larger @size.
> + *
> + * The kfunc can be called directly from a BPF_PROG_TYPE_SYSCALL
> + * program, synchronously in the context of the thread running the
> + * program, or from the bpf_wq and task_work callbacks of a SYSCALL
> + * program, which run in process context and keep the SYSCALL program
> + * type. It is registered for BPF_PROG_TYPE_SYSCALL only, because
> + * generic sleepable programs may run with filesystem locks held or
> + * in NOFS/NOIO contexts, where the reclaim path could deadlock on
> + * those locks via filesystem shrinkers.
> + *
> + * For asynchronous reclaim of more than one batch, driving the
> + * reclaim from a bpf_wq callback is recommended: call this kfunc
> + * once per callback and requeue the same work item for the next
> + * batch, instead of looping inside the callback and monopolizing a
> + * workqueue worker, and give each target memcg its own work item,
> + * as high_work_func() does with one work item per memcg. Whether
> + * to submit the next batch is up to the BPF program, which can stop
> + * at any point, e.g. once the target cgroup is dying.
> + *
> + * Return: The amount of memory reclaimed, in bytes, or 0 if @size is
> + * smaller than a page, or (unsigned long)-1 if @swappiness is out of
> + * range.
> + */

This isn't a bug, but does the kernel-doc need to be this extensive? It's
43 lines for a 20-line function, while the other kfuncs in this file have
6 to 14 lines of documentation. Three paragraphs here restate the commit
message near-verbatim: the MEMCG_CHARGE_BATCH rationale, the
BPF_PROG_TYPE_SYSCALL restriction justification, and the bpf_wq usage
guidance. Would it be clearer to keep the header focused on what the
arguments mean and what is returned, and leave the design rationale in
the commit message?

> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg,
> +						unsigned long size,
> +						int swappiness)

This isn't a bug, but does this name fit the file's convention? All 8
pre-existing kfuncs in mm/bpf_memcontrol.c that operate on a memcg are
named bpf_<verb>_mem_cgroup* or bpf_mem_cgroup_<noun>:
bpf_get_root_mem_cgroup, bpf_get_mem_cgroup, bpf_put_mem_cgroup,
bpf_mem_cgroup_vm_events, bpf_mem_cgroup_usage,
bpf_mem_cgroup_memory_events, bpf_mem_cgroup_page_state,
bpf_mem_cgroup_flush_stats. This function takes 'struct mem_cgroup *memcg'
as its first argument and reclaims only from that memcg, yet takes an
unqualified name that reads as if it were a global-reclaim kfunc. Would
bpf_mem_cgroup_reclaim() make the scope clearer and match the file
convention?

> +{
> +	unsigned long nr_reclaimed;
> +	unsigned long nr_pages;
> +
> +	if (swappiness < -1 || swappiness > SWAPPINESS_ANON_ONLY)
> +		return (unsigned long)-1;
> +
> +	if (size < PAGE_SIZE)
> +		return 0;
> +
> +	nr_pages = min(size / PAGE_SIZE, (unsigned long)MEMCG_CHARGE_BATCH);
> +
> +	nr_reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages,
> +						    GFP_KERNEL,
> +						    MEMCG_RECLAIM_MAY_SWAP |
> +						    MEMCG_RECLAIM_PROACTIVE,
> +						    swappiness == -1 ? NULL :
> +								       &swappiness);
> +
> +	return nr_reclaimed * PAGE_SIZE;
> +}
> +
> __bpf_kfunc_end_defs();
>
> [ ... ]
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 38b1165212c9..44e95e87e3cd 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -74,11 +74,13 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
>
>  #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
>  #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
> -#define MIN_SWAPPINESS 0
> -#define MAX_SWAPPINESS 200
> +enum {
> +	MIN_SWAPPINESS = 0,
> +	MAX_SWAPPINESS = 200,
>
> -/* Just reclaim from anon folios in proactive memory reclaim */
> -#define SWAPPINESS_ANON_ONLY (MAX_SWAPPINESS + 1)
> +	/* Just reclaim from anon folios in proactive memory reclaim */
> +	SWAPPINESS_ANON_ONLY = MAX_SWAPPINESS + 1,
> +};
>
>  unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  					   unsigned long nr_pages,


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34555349695
--===============5507926867917437855==--
