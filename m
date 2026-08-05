Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932C3C7E1D;
	Wed,  5 Aug 2026 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785905804; cv=none; b=uSDRnq7jNp3LrgnxrfB+is9ilWyQQej08YqfvEDmzq/FEGxsBI16n2BhnmSTQjHY9zsADD2bp8tVOLrFEJjTQ9xoisY/C+BcilPfhKZX9JW302wCPF4ovTYNjRzLQRC8uf+dfXD4K9iIT7bYzX9i1VvxkiLHplYm1tBtFedHE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785905804; c=relaxed/simple;
	bh=qi3grhX1txASeg18XwboydI22PyXnjrHs8icI6LkTjo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WwwNoTnll3kPMVSc2leGNNumFWGOzhTNzZCjXlx0XpAbu1hGU+bnpYCaHfYb0pB6+N8K8bQixF4vzeB6kAZJ+AN/KXZRL2UROjidrcuBolw6kMVRHoah2CBC9ajayVJaEeD4GsgjUpzOsOd6xeYE5Jw6WvVpfe7jdlzIQK6mHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0tIDrHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0tIDrHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5201F000E9;
	Wed,  5 Aug 2026 04:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785905802;
	bh=gPdcpCkfjkD/FGzFlVyO9h8LnEnduHfxyjLsrslrlNo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=S0tIDrHOqVznaaCqzRfeHVQSaYmBBTQIE0lQS1/GgBFsSyohjRrg14yTzeR5U4pVr
	 7Cc2+t/vMWlyo5EvzM1toGEspmWD+AvTMAXaxSAQOZ1P0PmStiqdR6JXJQki1m8nNa
	 bnWBBDsto6237qPZt0giPAJRF5081wiEfnN+5G9dHQcv9axfIcZnkKEMV3ciPlyfS5
	 hCNtMVNWBDKMl556IeeP+LRb3quAxc/Ldb9BopqAXE9HWUXsLmN3VB0pUa42MLT6oJ
	 21pU/BoI8bO7nEgJ7WF2mgoqL0NQ6dQ4HOqGNFculqqqvHQGkM+/1EVacRLrHQffUe
	 Gq33PTtVQT03w==
Content-Type: multipart/mixed; boundary="===============9124391864283396738=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5ad3da2f1e214aac34bc15293942ec2f9ab7734cc88d1578cd07e07eb1d30f67@mail.kernel.org>
In-Reply-To: <20260805031425.2157475-2-sanghyun.park.cnu@gmail.com>
References: <20260805031425.2157475-2-sanghyun.park.cnu@gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Fix mmap_lock leak in irq_work path
From: bot+bpf-ci@kernel.org
To: sanghyun.park.cnu@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com
Cc: sanghyun.park.cnu@gmail.com,sun.jian.kdev@gmail.com,puranjay@kernel.org,ihor.solodrai@linux.dev,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,bigeasy@linutronix.de,clrkwllms@kernel.org,rostedt@goodmis.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-rt-devel@lists.linux.dev,syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Aug 2026 04:56:41 +0000 (UTC)

--===============9124391864283396738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.h
> index 5d18d7d85bef9..1834db20b8612 100644
> --- a/kernel/bpf/mmap_unlock_work.h
> +++ b/kernel/bpf/mmap_unlock_work.h
> @@ -4,12 +4,15 @@
>
>  #ifndef __MMAP_UNLOCK_WORK_H__
>  #define __MMAP_UNLOCK_WORK_H__
> +#include <linux/atomic.h>
> +#include <linux/err.h>
>  #include <linux/irq_work.h>
>
>  /* irq_work to run mmap_read_unlock() in irq_work */
>  struct mmap_unlock_irq_work {
>  	struct irq_work irq_work;
>  	struct mm_struct *mm;
> +	atomic_t active;
>  };
>
>  DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
> @@ -18,32 +21,36 @@ DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
>   * We cannot do mmap_read_unlock() when the irq is disabled, because of
>   * risk to deadlock with rq_lock. To look up vma when the irqs are
>   * disabled, we need to run mmap_read_unlock() in irq_work. We use a
> - * percpu variable to do the irq_work. If the irq_work is already used
> - * by another lookup, we fall over.
> + * percpu variable to do the irq_work. The active flag reserves the slot
> + * before mmap_read_trylock() and until the irq_work callback consumes mm.
>   */

The new comment states the reservation lasts "until the irq_work callback
consumes mm," but there are two cases where it ends earlier: when
irqs_disabled() is false the helper returns NULL and no slot is reserved
at all, and when mmap_read_trylock() fails the reservation is released
immediately by bpf_mmap_unlock_guard_put(). Would it read more clearly to
note that the reservation may be released early on trylock failure?

[ ... ]

> -static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_work **work_ptr)
> +static inline struct mmap_unlock_irq_work *bpf_mmap_unlock_guard_get(void)
>  {
> +	work = this_cpu_ptr(&mmap_unlock_work);
> +	if (irq_work_is_busy(&work->irq_work) ||
> +	    atomic_cmpxchg_acquire(&work->active, 0, 1))
> +		return ERR_PTR(-EBUSY);
>
> -	*work_ptr = work;
> -	return irq_work_busy;
> +	return work;
> +}
> +
> +static inline void
> +bpf_mmap_unlock_guard_put(struct mmap_unlock_irq_work *work)
> +{
> +	if (work)
> +		atomic_set_release(&work->active, 0);
>  }

This isn't a bug, but the rename to bpf_mmap_unlock_guard_get()/_put()
might be confusing here. In current kernel usage 'guard' typically refers
to the include/linux/cleanup.h scoped-guard family where release happens
automatically at scope exit. These helpers do the opposite: the
reservation is released manually, and in the success case ownership is
handed off to the irq_work callback in do_mmap_read_unlock() which is in
a different function. Would bpf_mmap_unlock_reserve()/_unreserve() signal
the manual cross-function lifetime more directly?

[ ... ]

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 463f94ba1cc47..0384b32d88b57 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -426,15 +425,16 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  		return;
>  	}
>
> -	/* If the irq_work is in use, fall back to report ips. Same
> -	 * fallback is used for kernel stack (!user) on a stackmap with
> -	 * build_id.
> -	 */
> -	if (!has_user_ctx || irq_work_busy || !mmap_read_trylock(current->mm)) {
> -		/* cannot access current->mm, fall back to ips */
> -		for (i = 0; i < trace_nr; i++)
> -			stack_map_build_id_set_ip(&id_offs[i]);
> -		return;
> +	if (!has_user_ctx)
> +		goto fallback;
> +
> +	work = bpf_mmap_unlock_guard_get();
> +	if (IS_ERR(work))
> +		goto fallback;
> +
> +	if (!mmap_read_trylock(current->mm)) {
> +		bpf_mmap_unlock_guard_put(work);
> +		goto fallback;
>  	}

[ ... ]

> @@ -465,6 +465,12 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>  						      vma->vm_pgoff);
>  	}
>  	bpf_mmap_unlock_mm(work, current->mm);
> +	return;
> +
> +fallback:
> +	/* cannot access current->mm, fall back to ips */
> +	for (i = 0; i < trace_nr; i++)
> +		stack_map_build_id_set_ip(&id_offs[i]);
>  }

[ ... ]

> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index b256fb9c1214e..13e1aabe6f886 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -792,9 +791,14 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
>  	if (!mm)
>  		return -ENOENT;
>
> -	irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
> +	work = bpf_mmap_unlock_guard_get();
> +	if (IS_ERR(work)) {
> +		ret = PTR_ERR(work);
> +		goto out;
> +	}
>
> -	if (irq_work_busy || !mmap_read_trylock(mm)) {
> +	if (!mmap_read_trylock(mm)) {
> +		bpf_mmap_unlock_guard_put(work);
>  		ret = -EBUSY;
>  		goto out;
>  	}

[ ... ]

> @@ -1191,6 +1195,8 @@ static void do_mmap_read_unlock(struct irq_work *entry)
>
>  	work = container_of(entry, struct mmap_unlock_irq_work, irq_work);
>  	mmap_read_unlock_non_owner(work->mm);
> +	work->mm = NULL;
> +	bpf_mmap_unlock_guard_put(work);
>  }

The commit message states the Fixes tag points to commit eac9153f2b58
which widened the gate from in_nmi() to irqs_disabled(). Looking at the
code history, the unsafe pattern where the slot check happens before the
reservation was introduced by bae77c5eb5b2 in May 2018, but that commit
alone was not enough to trigger the bug. The reproducer depends on two
later additions: the mmap_lock tracepoints that fire inside
mmap_read_trylock(), and raw_tp programs that bypass the global per-CPU
bpf_prog_active counter and rely only on per-prog prog->active (see
kernel/trace/bpf_trace.c:1599 and include/linux/bpf.h:2158). All other
BPF entry points like kprobe, perf_event, and kprobe_multi gate on the
global bpf_prog_active and cannot nest. The commit message describes the
bug mechanism but does not mention that only raw_tp programs can actually
trigger this nesting path. Would adding one sentence about the raw_tp +
mmap_lock-tracepoint precondition make the explanation more complete for
readers trying to understand the reachability?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30972744877
--===============9124391864283396738==--
