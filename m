Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795268463;
	b=sx9Z2p46DZpBPFVcNeFnFmnI/1XHMuCbfNKrrQwFt3jEAT5sqNOk9u4Nrl+mvAxUvxEJ
	 OKH1w9FS36xnHeL2gtB0VOfhiAAnsqFggCWkvIKulqhgDn1bh8cl2bcdX7TTlhFNOv3jR
	 VhFP3gNq3Gw5aXWMTxTq9S4up0Iqx7kAwbkx9OqAAAg9/VQzArEYCsU5ZY19jVx518fWt
	 kcTM2aCqhWj1erp/vb16mE4+W/GBOMOeq83dGYj9EWnO1wdA2soPuRAmszc3+drPrgR6V
	 B3dnZKdVajgRztuoEYrvUoY+EYxEa3uPYs2sKmA+xCAmY4iF+7K+j12vofvwFNQqGDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795268463;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ze1XfukPlqWhXxeWdokIWjjT48DYgRLaaIcyK/o1tvY=;
	b=m0SLpUZa4DhdUnkSIbsC3FEJc6FrwKoVvoqaebRK+MNegbfMSl1JueM4NDG0B1pQBLsq
	 3mKYLlHB9YAxABrlLuE+R7hFPW3oIURw4KIgQVMESqrzcXe3xLtg82/MeYuYWZwgmbQD3
	 b+wztvyt8T1lAz2aous6WUZ7/fdwj2ofWk68Vi2M9LQYAuEsCThZBUI5Xwaxti7xiV2kr
	 30hyUWgE6QjM1j1fqFUViT6yoQ3Z7z2KMkhw/SGQ5ThaCVzrROyV7WAfHlaarciKN3s4r
	 pOn16rm3ducumCVO/JyRjmIwPRT/YEnlac6E+OZ/uIz8/X6IBZufeavhi9gautOFQig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZSqX/PyV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209D606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZSqX/PyV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442B71F000C4;
	Sat, 21 Nov 2026 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795268463;
	bh=ze1XfukPlqWhXxeWdokIWjjT48DYgRLaaIcyK/o1tvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZSqX/PyVpC6CU3SbqRR0szuxDgrLoipoK/D/Ig/FHo35MdiG+Ydp5+aj9HmGVa3Gp
	 H2yER/nX/UTD6DVV5O103kQGVpQuzF4nMslta1M7zMkk5xcWKlsSf/ga/tCH7aQKcb
	 3VnjmmgwbvqEsvYj+pKAjA+hAIT+RKjbW99SbaShivw6OEIQyyiXSpbcYRip3QaPgH
	 s+jVOEs76rgL24ZMdObAW0nAsidspJsJtaiDkFWrENsJQGQs4gGUwpk+fPvOTgYa1+
	 0cVKhp972pjgRkR708MODoEolIhsxwlseMaonESYnR3c7K/00fR3uU58VgCn5J318p
	 BtUS7JnPLP4wg==
Date: Sat, 21 Nov 2026 13:40:54 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, "Liam R. Howlett" <liam@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	Chris Mason <mason@kernel.org>
Subject: Re: [PATCH bpf v6 2/3] bpf: switch task_vma iterator from mmap_lock
 to per-VMA locks
Message-ID: <awGZWsCp6v63H_py@gremlin>
References: <20260408154539.3832150-1-puranjay@kernel.org>
 <20260408154539.3832150-3-puranjay@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408154539.3832150-3-puranjay@kernel.org>

+cc VMA team, Chris [whose AI fix this relates to]

On Wed, Apr 08, 2026 at 08:45:36AM -0700, Puranjay Mohan wrote:
> The open-coded task_vma iterator holds mmap_lock for the entire duration
> of iteration, increasing contention on this highly contended lock.
>
> Switch to per-VMA locking. Find the next VMA via an RCU-protected maple
> tree walk and lock it with lock_vma_under_rcu(). lock_next_vma() is not
> used because its fallback takes mmap_read_lock(), and the iterator must
> work in non-sleepable contexts.

Hmm :) In future if an API doesn't give you what you need please do ask us
in mm to offer one that does give you what you need, we don't bite :)

>
> lock_vma_under_rcu() is a point lookup (mas_walk) that finds the VMA
> containing a given address but cannot iterate across gaps. An
> RCU-protected vma_next() walk (mas_find) first locates the next VMA's
> vm_start to pass to lock_vma_under_rcu().
>
> Between the RCU walk and the lock, the VMA may be removed, shrunk, or
> write-locked. On failure, advance past it using vm_end from the RCU
> walk. Because the VMA slab is SLAB_TYPESAFE_BY_RCU, vm_end may be
> stale; fall back to PAGE_SIZE advancement when it does not make forward
> progress. Concurrent VMA insertions at addresses already passed by the
> iterator are not detected.
>
> CONFIG_PER_VMA_LOCK is required; return -EOPNOTSUPP without it.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Hi guys,

This is buggy and can result in deadlock. You need to revert it or restrict
which contexts it can be called in.

I'm a little surprised you didn't cc- or even ping mm or the VMA team here, we
are always willing to help and it's clearly sub-optimal to write duplicative,
open-coded VMA traversal in BPF.

Let's be collaborative in future please :)

Anyway, unfortunately it seems that you've rather got yourselves in rather a
pickle here, as vma_start_read() can call mmdrop() and in x86 that can take a
pgd_lock in an invalid context.

Consider:

mmdrop()
  -> __mmdrop()
    -> mm_free_pgd()
      -> pgd_free()
        -> pgd_dtor()

And looking at pgd_dtor():

static void pgd_dtor(pgd_t *pgd)
{
	spin_lock(&pgd_lock);
	pgd_list_del(pgd);
	spin_unlock(&pgd_lock);
}

It's just a plain spin_[un]lock() which is invalid in softirq context, which you
are potentially calling from here.

You can get there from softirq via something like:

pgd_alloc()
  -> spin_lock(&pgd_lock)
    <softirq>
    bpf_iter_task_vma_next()
      -> vma_start_read()
        ... etc...
	< maybe deadlock >

It's not really sensible to alter core mm to accommodate this at this stage, so
probably the best course is to disallow this code path for softirq context, or
you could look into patching the x86 code.

Thanks!

> ---
>  kernel/bpf/task_iter.c | 91 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 73 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index c1f5fbe9dc2f..87e87f18913d 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -9,6 +9,7 @@
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/btf_ids.h>
>  #include <linux/mm_types.h>
> +#include <linux/mmap_lock.h>
>  #include <linux/sched/mm.h>
>  #include "mmap_unlock_work.h"
>
> @@ -807,8 +808,8 @@ static inline void bpf_iter_mmput_async(struct mm_struct *mm)
>  struct bpf_iter_task_vma_kern_data {
>  	struct task_struct *task;
>  	struct mm_struct *mm;
> -	struct mmap_unlock_irq_work *work;
> -	struct vma_iterator vmi;
> +	struct vm_area_struct *locked_vma;
> +	u64 next_addr;
>  };
>
>  struct bpf_iter_task_vma {
> @@ -829,21 +830,19 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>  				      struct task_struct *task, u64 addr)
>  {
>  	struct bpf_iter_task_vma_kern *kit = (void *)it;
> -	bool irq_work_busy = false;
>  	int err;
>
>  	BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) != sizeof(struct bpf_iter_task_vma));
>  	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) != __alignof__(struct bpf_iter_task_vma));
>
> -	/* bpf_iter_mmput_async() needs mmput_async() which requires CONFIG_MMU */
> -	if (!IS_ENABLED(CONFIG_MMU)) {
> +	if (!IS_ENABLED(CONFIG_PER_VMA_LOCK)) {
>  		kit->data = NULL;
>  		return -EOPNOTSUPP;
>  	}
>
>  	/*
>  	 * Reject irqs-disabled contexts including NMI. Operations used
> -	 * by _next() and _destroy() (mmap_read_unlock, bpf_iter_mmput_async)
> +	 * by _next() and _destroy() (vma_end_read, bpf_iter_mmput_async)
>  	 * can take spinlocks with IRQs disabled (pi_lock, pool->lock).
>  	 * Running from NMI or from a tracepoint that fires with those
>  	 * locks held could deadlock.
> @@ -886,18 +885,10 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>  		goto err_cleanup_iter;
>  	}
>
> -	/* kit->data->work == NULL is valid after bpf_mmap_unlock_get_irq_work */
> -	irq_work_busy = bpf_mmap_unlock_get_irq_work(&kit->data->work);
> -	if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
> -		err = -EBUSY;
> -		goto err_cleanup_mmget;
> -	}
> -
> -	vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
> +	kit->data->locked_vma = NULL;
> +	kit->data->next_addr = addr;
>  	return 0;
>
> -err_cleanup_mmget:
> -	bpf_iter_mmput_async(kit->data->mm);
>  err_cleanup_iter:
>  	put_task_struct(kit->data->task);
>  	bpf_mem_free(&bpf_global_ma, kit->data);
> @@ -906,13 +897,76 @@ __bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
>  	return err;
>  }
>
> +/*
> + * Find and lock the next VMA at or after data->next_addr.
> + *
> + * lock_vma_under_rcu() is a point lookup (mas_walk): it finds the VMA
> + * containing a given address but cannot iterate. An RCU-protected
> + * maple tree walk with vma_next() (mas_find) is needed first to locate
> + * the next VMA's vm_start across any gap.
> + *
> + * Between the RCU walk and the lock, the VMA may be removed, shrunk,
> + * or write-locked. On failure, advance past it using vm_end from the
> + * RCU walk. SLAB_TYPESAFE_BY_RCU can make vm_end stale, so fall back
> + * to PAGE_SIZE advancement to guarantee forward progress.
> + */
> +static struct vm_area_struct *
> +bpf_iter_task_vma_find_next(struct bpf_iter_task_vma_kern_data *data)
> +{
> +	struct vm_area_struct *vma;
> +	struct vma_iterator vmi;
> +	unsigned long start, end;
> +
> +retry:
> +	rcu_read_lock();
> +	vma_iter_init(&vmi, data->mm, data->next_addr);
> +	vma = vma_next(&vmi);
> +	if (!vma) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
> +	start = vma->vm_start;
> +	end = vma->vm_end;
> +	rcu_read_unlock();
> +
> +	vma = lock_vma_under_rcu(data->mm, start);
> +	if (!vma) {
> +		if (end <= data->next_addr)
> +			data->next_addr += PAGE_SIZE;
> +		else
> +			data->next_addr = end;
> +		goto retry;
> +	}
> +
> +	if (unlikely(vma->vm_end <= data->next_addr)) {
> +		data->next_addr += PAGE_SIZE;
> +		vma_end_read(vma);
> +		goto retry;
> +	}
> +
> +	return vma;
> +}
> +
>  __bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_iter_task_vma *it)
>  {
>  	struct bpf_iter_task_vma_kern *kit = (void *)it;
> +	struct vm_area_struct *vma;
>
>  	if (!kit->data) /* bpf_iter_task_vma_new failed */
>  		return NULL;
> -	return vma_next(&kit->data->vmi);
> +
> +	if (kit->data->locked_vma) {
> +		vma_end_read(kit->data->locked_vma);
> +		kit->data->locked_vma = NULL;
> +	}
> +
> +	vma = bpf_iter_task_vma_find_next(kit->data);
> +	if (!vma)
> +		return NULL;
> +
> +	kit->data->locked_vma = vma;
> +	kit->data->next_addr = vma->vm_end;
> +	return vma;
>  }
>
>  __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
> @@ -920,7 +974,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
>  	struct bpf_iter_task_vma_kern *kit = (void *)it;
>
>  	if (kit->data) {
> -		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
> +		if (kit->data->locked_vma)
> +			vma_end_read(kit->data->locked_vma);
>  		put_task_struct(kit->data->task);
>  		bpf_iter_mmput_async(kit->data->mm);
>  		bpf_mem_free(&bpf_global_ma, kit->data);
> --
> 2.52.0
>
>

--
Cheers, Lorenzo
