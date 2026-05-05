Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A309D47A0B7
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997185; cv=none; b=m/KoSP6SpIa0oMbb/i/C+iO10+LNYLZRpzQllXggcXrNDTkSAkEEVwoAVT/3/5CUJp7JhkxOCJxwrmA2zm9wT8Uv/d/Tdi1O73iEwgurM9HUIvGPg25H9tjp7+ggVYQUBd8qNi0h3OcGblHusr6TSWub0jegKoQk7/K6/EykaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997185; c=relaxed/simple;
	bh=1jSbhbnlPPqTZQXOTCJhWgKJuBTjM8t4+Lr2QRB8rto=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sgdaudk/x3jdGBq9LSGujFc/1MLkN+yT/DouehqQxe3uLasUd9CweBuYPWm3y94WrdJ/VIIA3nVt4CjfcpS/K1ONDf5Q3+/2aY61OoctkFEusSD+avr+X6s2+FOYIXF8AzYrwruNMhjDgDFJOXyKkrVKysmrRZ+9sQTwVHX/0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQO0bM2p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQO0bM2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD26DC2BCB4;
	Tue,  5 May 2026 16:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777997185;
	bh=1jSbhbnlPPqTZQXOTCJhWgKJuBTjM8t4+Lr2QRB8rto=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rQO0bM2pbATZS4GnGuND9SBZCMyG2Lw+8fO/yt8Ldy2osKyOcpbY2inQ6QOsqy0ll
	 iNWqZ/lMq7oUSz37XFrDUGZVUuEbbtCu5F50xMVKP+zzngbPFergVGOED6S6bSEH/w
	 +MEQCREUNVB9ljkgSEEaWBM5xigRWfKkhfVr3QpvK9DUz5v06iNGUxGKcWAVvoCQvQ
	 0SGOo2NcmeRbcXol46SBOTPfCB64xo+LuMP8geJqyMpzV98LauqhMMworGJrR6aWgQ
	 rz2t1mpNmPP/p7Xw14qbAn0/BZ00YOKb19x1gkzamHVYtnRUruRoEvcdbgQ5nVKsjf
	 4ggfE6AmSUOow==
Content-Type: multipart/mixed; boundary="===============0207227395593299497=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c2bc74937f3da0174c896daa2d129c9572a5c6434f8d71da26283fe7f011c4af@mail.kernel.org>
In-Reply-To: <20260505150851.3090688-2-utilityemal77@gmail.com>
References: <20260505150851.3090688-2-utilityemal77@gmail.com>
Subject: Re: [bpf-next v2 1/2] bpf: Offload kptr destructors that run from NMI
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,mic@digikod.net,utilityemal77@gmail.com,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  5 May 2026 16:06:23 +0000 (UTC)

--===============0207227395593299497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 3b1f0ba02f61..162bfd4796ea 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -65,6 +68,131 @@ static DEFINE_SPINLOCK(map_idr_lock);
>  static DEFINE_IDR(link_idr);
>  static DEFINE_SPINLOCK(link_idr_lock);
>
> +struct bpf_dtor_kptr_work {
> +	struct llist_node node;
> +	void *obj;
> +	btf_dtor_kfunc_t dtor;
> +};
> +
> +/* Queue pending dtors per CPU; the idle pool stays global. */
> +static DEFINE_PER_CPU(struct llist_head, bpf_dtor_kptr_jobs);
> +static LLIST_HEAD(bpf_dtor_kptr_idle);
> +/* Keep total >= refs + active so NMI frees never need to allocate. */
> +static atomic_long_t bpf_dtor_kptr_refs = ATOMIC_LONG_INIT(0);
> +static atomic_long_t bpf_dtor_kptr_active = ATOMIC_LONG_INIT(0);
> +static atomic_long_t bpf_dtor_kptr_total = ATOMIC_LONG_INIT(0);
> +
> +/* Bound reserve overshoot so the pool tracks demand instead of growing on itself. */
> +#define BPF_DTOR_KPTR_RESERVE_HEADROOM 64L
> +
> +static void bpf_dtor_kptr_worker(struct irq_work *work);
> +static DEFINE_PER_CPU(struct irq_work, bpf_dtor_kptr_irq_work) =
> +	IRQ_WORK_INIT_HARD(bpf_dtor_kptr_worker);
> +
> +static void bpf_dtor_kptr_push_idle(struct bpf_dtor_kptr_work *job)
> +{
> +	llist_add(&job->node, &bpf_dtor_kptr_idle);
> +}
> +
> +static struct bpf_dtor_kptr_work *bpf_dtor_kptr_pop_idle(void)
> +{
> +	struct llist_node *node;
> +
> +	node = llist_del_first(&bpf_dtor_kptr_idle);
> +	if (!node)
> +		return NULL;
> +
> +	return llist_entry(node, struct bpf_dtor_kptr_work, node);
> +}

Does bpf_dtor_kptr_pop_idle() handle multiple concurrent consumers
safely?

The documentation for llist_del_first() in lib/llist.c explicitly
states:

  Only one llist_del_first user can be used simultaneously with multiple
  llist_add users without lock. Because otherwise llist_del_first,
  llist_add, llist_add (or llist_del_all, llist_add, llist_add)
  sequence in another user may change @head->first->next, but keep
  @head->first.

This is the classic ABA race that llist_del_first cannot defend against.

In this patch, bpf_dtor_kptr_pop_idle() has multiple concurrent
consumers:

  1. bpf_dtor_kptr_offload() called from NMI context on any CPU
     (the function installed below, called from bpf_obj_free_fields
     when in_nmi()).

  2. bpf_dtor_kptr_trim() called from the per-CPU irq_work worker on
     any CPU (called from bpf_dtor_kptr_worker below).

Both paths call bpf_dtor_kptr_pop_idle() which calls
llist_del_first(&bpf_dtor_kptr_idle) on the global idle list. Two or
more CPUs can be popping simultaneously with no external lock and no
single-consumer guarantee.

Can the following race timeline produce list corruption or
double-ownership?

Initial state: idle list = A -> B -> C -> NULL

CPU0 (NMI): enters bpf_dtor_kptr_pop_idle
  entry = head->first = A
  next  = A->next     = B
  (stalls before cmpxchg)

CPU1 (NMI/worker): runs bpf_dtor_kptr_pop_idle
  entry = A, next = B, cmpxchg(head->first, A, B) succeeds.
  Now idle = B -> C -> NULL. CPU1 uses A (for offload or mem_free).

CPU1: pops again, takes B. idle = C -> NULL.

CPU1 eventually runs worker -> push_idle(A). Now idle = A -> C -> NULL.
   A->next = C (not B anymore).

CPU0 resumes:
  Its cached next variable is still B, cmpxchg(&head->first, A, B)
  finds head->first is currently A, so the cmpxchg succeeds.
  Result: head->first = B, but B has been popped and is in CPU1's
  per-CPU bpf_dtor_kptr_jobs list already (not free).

Node B is now simultaneously:
  (a) considered removed from idle (CPU1 popped it and is using it)
  (b) referenced as idle->first by the head pointer

Another pop_idle() may grab B again as if it were idle, while it is
active in a per-CPU jobs list. Then bpf_dtor_kptr_worker will execute
job->dtor() on already-freed/reused job->obj, or the same job is pushed
into two lists, corrupting llist_node chains.

Concurrency is not hypothetical here. A BPF tp_btf/nmi_handler program
calling bpf_map_delete_elem can fire on multiple CPUs simultaneously.
The irq_work worker also runs on any CPU that queued work. Thus both
bpf_dtor_kptr_offload and bpf_dtor_kptr_trim can run concurrently on
different CPUs, giving at least 2 concurrent llist_del_first consumers.

Typical fixes require either:
  - using a locked list (spinlock + list_head), or
  - using llist_del_all() with batch processing, or
  - a cmpxchg-based stack that properly handles ABA (e.g., using a
    tagged pointer).

> +
> +static void bpf_dtor_kptr_trim(void)
> +{
> +	struct bpf_dtor_kptr_work *job;
> +	long total;
> +	long needed;
> +
> +	for (;;) {
> +		total = atomic_long_read(&bpf_dtor_kptr_total);
> +		needed = atomic_long_read(&bpf_dtor_kptr_refs) +
> +			 atomic_long_read(&bpf_dtor_kptr_active);
> +		if (total <= needed)
> +			return;
> +
> +		job = bpf_dtor_kptr_pop_idle();
> +		if (!job)
> +			return;
> +
> +		if (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_total, &total, total - 1)) {
> +			bpf_dtor_kptr_push_idle(job);
> +			continue;
> +		}
> +
> +		bpf_mem_free(&bpf_global_ma, job);
> +	}
> +}

[ ... ]

> +static void bpf_dtor_kptr_worker(struct irq_work *work)
> +{
> +	struct llist_node *jobs, *node, *next;
> +
> +	jobs = llist_del_all(this_cpu_ptr(&bpf_dtor_kptr_jobs));
> +	llist_for_each_safe(node, next, jobs) {
> +		struct bpf_dtor_kptr_work *job;
> +
> +		job = llist_entry(node, struct bpf_dtor_kptr_work, node);
> +		job->dtor(job->obj);
> +		atomic_long_dec(&bpf_dtor_kptr_active);
> +		bpf_dtor_kptr_push_idle(job);
> +	}
> +
> +	bpf_dtor_kptr_trim();
> +}
> +
> +static void bpf_dtor_kptr_offload(void *obj, btf_dtor_kfunc_t dtor)
> +{
> +	struct bpf_dtor_kptr_work *job;
> +
> +	atomic_long_inc(&bpf_dtor_kptr_active);
> +	job = bpf_dtor_kptr_pop_idle();
> +	if (WARN_ON_ONCE(!job)) {
> +		atomic_long_dec(&bpf_dtor_kptr_active);
> +		/*
> +		 * This should stay unreachable if reserve accounting is correct. If it
> +		 * ever breaks, running the destructor unsafely is still better than
> +		 * leaking the object permanently.
> +		 */
> +		dtor(obj);
> +		return;
> +	}
> +
> +	job->obj = obj;
> +	job->dtor = dtor;
> +	if (llist_add(&job->node, this_cpu_ptr(&bpf_dtor_kptr_jobs)))
> +		irq_work_queue(this_cpu_ptr(&bpf_dtor_kptr_irq_work));
> +}
> +
>  void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  {
>  	const struct btf_field *fields;
> @@ -842,6 +1010,19 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  		xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
>  		if (!xchgd_field)
>  			break;
> +		if (in_nmi() && field->kptr.dtor) {
> +			bpf_dtor_kptr_offload(xchgd_field, field->kptr.dtor);
> +			bpf_kptr_offload_dec();
> +			break;
> +		}
> +		if (field->kptr.dtor)
> +			/*
> +			 * Dtor kptrs reach storage through bpf_ref_kptr_xchg(), which
> +			 * pairs installation with bpf_kptr_offload_inc(). Drop that
> +			 * reservation on non-NMI teardown once no active transition is
> +			 * needed.
> +			 */
> +			bpf_kptr_offload_dec();
>
>  		if (!btf_is_kernel(field->kptr.btf)) {
>  			pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25385531271
--===============0207227395593299497==--
