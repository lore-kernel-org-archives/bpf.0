Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5140DFD9
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777784239; cv=none; b=VkgpxS8hbkrx/9hlQvi2x5emidJkCxMMxoFaNs0rAAnp03lfFp1gmiB1RLwflwpO0eHMqjPega5AiKor44yvd7zwLE4hU8hDA/VjfIfZSzJKJdU+MecsaXLJng3ddQAIz3qpGWK4kks2pH+R4y2alSYBGPD9TfjI95/LS94VunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777784239; c=relaxed/simple;
	bh=d+ogTXuEzOF5lwRXvws6mbumMTKwUeWjO3feXZdM5Pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CoMpPng8wWDqV6+MbByY/Bpozpjb/1zfkWYYYsjja3+SwdyTOkmAGgjfF0+BbpMxHiExBgVpoMRC8DKYvaCWl4ucuzgbtWZVYmg7RBA2CT02Q0CPZzSB4WSFo+LODekNK1OFLD1RRTqQHGLaeeKEsnPMeOuT1/NUnTO6U7BhuTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etJ7f9Bj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etJ7f9Bj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320E3C2BCB4;
	Sun,  3 May 2026 04:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777784239;
	bh=d+ogTXuEzOF5lwRXvws6mbumMTKwUeWjO3feXZdM5Pw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=etJ7f9Bj7Mn/AHUMX+6jOSe95C/zXGqna/4QIz/XEkA9Iyokq6tf74uPeN0J9WFce
	 aWUOpc+e9cbyxiwwMYCXQ2MAdkRwTcBEc8mu+TAr1qEavULAoVMNXwF5Cq/fRCYz+u
	 s1OiKBCjkb1dl/rFkHd42G5BofGwOmScBrKoeYJIq4N9fAQG+eGZGyDTvCV5Vt6Vqy
	 MH0k1YumtU4nK9VZexHVNBVWdtAx3dNG2QddzczAPW+OG0sLLonU5Dc/aY3vKSQOpI
	 oD2uxz2ZuIa1gWtQfpsSef7vrxf1AjR7+tT60KQmyUy3eaWJVyNdvyWfoZbiyGJ8sk
	 /PMfzTg2722Zw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v2 2/3] block: Introduce the UFQ I/O scheduler
Reply-To: sashiko@lists.linux.dev
To: "Kaitao cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503035623.28771-3-kaitao.cheng@linux.dev>
References: <20260503035623.28771-3-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 04:57:18 +0000
Message-Id: <20260503045719.320E3C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [Critical] Arbitrary kernel stack read/write due to unvalidated PTR_TO_BU=
F context arguments.
- [Critical] `dispatch_req` accepts requests from foreign block queues, cor=
rupting hardware context maps.
- [High] `ufq_bio_merge` incorrectly destroys the request when a bio is suc=
cessfully merged.
- [High] BPF kfuncs and callbacks modify request state without verifying th=
ey are idle, causing DMA corruption.
- [High] Incorrect request handling after successful `merge_req` causes dup=
licate BPF insertions and ghost requests.
- [High] The `bpf_request_try_merge` kfunc permanently leaks the merged req=
uest and hardware tag.
- [High] Exposing the request to the dispatch list before BPF insertion cau=
ses a Write-After-Free.
- [High] Missing memory barrier in `bpf_ufq_disable` allows `ufq_ops` to be=
 destroyed while still in use.
- [High] Annotating blocking kfuncs with `KF_SPIN_LOCK` triggers a PREEMPT_=
RT panic.
- [High] `bpf_request_try_merge` blindly casts elevator private data, causi=
ng memory corruption across I/O schedulers.
- [High] Failed BPF request insertions still receive a `finish_req` callbac=
k, corrupting BPF state.
--

commit 3bcfa14cede6b5991bb234bc371f06d27de520a5
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

block: Introduce the UFQ I/O scheduler

Introduce IOSCHED_UFQ, a blk-mq elevator whose policy is supplied by an eBPF
program via struct_ops. When no program is attached, it uses a simple
per-ctx queueing policy as a fallback mechanism.

> diff --git a/block/ufq-bpfops.c b/block/ufq-bpfops.c
> --- /dev/null
> +++ b/block/ufq-bpfops.c
[ ... ]
> +static bool bpf_ufq_is_valid_access(int off, int size,
> +				    enum bpf_access_type type,
> +				    const struct bpf_prog *prog,
> +				    struct bpf_insn_access_aux *info)
> +{
[ ... ]
> +	if (size =3D=3D sizeof(__u64) && prog->aux->attach_func_name &&
> +	    ((!strcmp(prog->aux->attach_func_name, "merge_req") && off =3D=3D 1=
6) ||
> +	     (!strcmp(prog->aux->attach_func_name, "merge_bio") && off =3D=3D 2=
4))) {
> +		if (!btf_ctx_access(off, size, type, prog, info))
> +			return false;
> +		info->reg_type =3D PTR_TO_BUF;
> +		return true;
> +	}
> +
> +	return btf_ctx_access(off, size, type, prog, info);
> +}

Does this allow arbitrary memory access?

The verifier handles PTR_TO_BUF by recording the maximum accessed offset in
env->prog->aux->max_rdwr_access. Since UFQ uses BPF_PROG_TYPE_STRUCT_OPS,
max_rdwr_access is ignored during program load.

Can a BPF program use large offsets to read or write arbitrary kernel stack
memory?

[ ... ]
> +static void bpf_ufq_disable(struct ufq_iosched_ops *ops)
> +{
> +	atomic_set(&ufq_bpfops_enabled, 0);
> +	wait_event(ufq_bpfops_wq, !atomic_read(&ufq_bpfops_users));
> +	memset(&ufq_ops, 0, sizeof(ufq_ops));
> +}

Since atomic_set() is relaxed and the initial check in wait_event() evaluat=
es
locklessly without a full memory barrier, could the read of ufq_bpfops_users
be reordered before the store to ufq_bpfops_enabled?

If a concurrent ufq_bpfops_tryget() reads enabled =3D=3D 1 while the disable
path observes users =3D=3D 0, would it proceed to clear ufq_ops while it is=
 still
in use?

> diff --git a/block/ufq-iosched.c b/block/ufq-iosched.c
> --- /dev/null
> +++ b/block/ufq-iosched.c
[ ... ]
> +static struct request *ufq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct ufq_data *ufq =3D hctx->queue->elevator->elevator_data;
> +	const struct ufq_iosched_ops *ops;
> +	struct blk_mq_ctx *ctx;
> +	struct request *rq =3D NULL;
> +	unsigned short idx;
> +
> +	ops =3D ufq_bpfops_tryget();
> +	if (ops && ops->dispatch_req) {
> +		rq =3D ops->dispatch_req(hctx->queue);

Is there anything preventing the BPF program from returning a request that
belongs to a different block device's queue?

If the BPF program stores a request from Queue A and returns it during the
dispatch cycle of Queue B, would this clear the wrong ctx_map bits below
and dispatch the request to the wrong driver?

[ ... ]
> +static bool ufq_bio_merge(struct request_queue *q, struct bio *bio,
> +			  unsigned int nr_segs)
> +{
[ ... ]
> +	ops =3D ufq_bpfops_tryget();
> +	if (ops) {
> +		if (ops->merge_bio) {
> +			rq =3D ops->merge_bio(q, bio, nr_segs, &ret);
[ ... ]
> +			if (rq) {
> +				ufq_bpfops_put();
> +				spin_lock(&rq->mq_ctx->lock);
> +				if (!list_empty(&rq->queuelist)) {
> +					list_del_init(&rq->queuelist);
> +					atomic_dec(&ufq->rqs_count);
> +				}
> +				spin_unlock(&rq->mq_ctx->lock);
> +				blk_mq_free_request(rq);

When merge_bio() returns a request, doesn't this indicate the bio was
successfully appended to that existing request?

If so, why is blk_mq_free_request() called here? This seems to abort the
pending I/O and destroy the request while it is still waiting to be
dispatched.

[ ... ]
> +static enum elv_merge ufq_try_insert_merge(struct request_queue *q,
> +					   struct request **new)
> +{
[ ... ]
> +	if (type =3D=3D ELEVATOR_NO_MERGE || !target) {
> +		if (ops)
> +			ufq_bpfops_put();
> +		return ELEVATOR_NO_MERGE;
> +	} else if (type =3D=3D ELEVATOR_FRONT_MERGE) {
[ ... ]
> +	} else if (type =3D=3D ELEVATOR_BACK_MERGE) {
> +		spin_lock(&target->mq_ctx->lock);
> +		free =3D bpf_attempt_merge(q, target, rq);
> +		if (!free) {
> +			spin_unlock(&target->mq_ctx->lock);
> +			pr_err("ufq-iosched: back merge failed\n");
> +			goto rollback;
> +		}
> +		*new =3D target;

If ops->merge_req() returns ELEVATOR_BACK_MERGE, *new is set to target.
In ufq_insert_requests(), this request is then passed to ops->insert_req().

Doesn't this cause a duplicate insert_req() call for a request the BPF
program is already tracking?

Also, if ELEVATOR_FRONT_MERGE is returned, the kernel replaces and frees
the target request, but is the BPF program ever notified about the freed
request?

[ ... ]
> +static void ufq_insert_requests(struct blk_mq_hw_ctx *hctx,
> +			       struct list_head *list,
> +			       blk_insert_t flags)
> +{
[ ... ]
> +		type =3D ufq_try_insert_merge(q, &rq);
> +		if (type =3D=3D ELEVATOR_NO_MERGE) {
> +			rq->fifo_time =3D jiffies;
> +			ctx =3D rq->mq_ctx;
> +			rq->elv.priv[0] =3D (void *)((uintptr_t)rq->elv.priv[0]
> +					  | UFQ_PRIV_IN_UFQ);
> +			spin_lock(&ctx->lock);
> +			if (flags & BLK_MQ_INSERT_AT_HEAD)
> +				list_add(&rq->queuelist, &ctx->rq_lists[hctx->type]);
> +			else
> +				list_add_tail(&rq->queuelist,
> +					&ctx->rq_lists[hctx->type]);
> +
> +			bit =3D ctx->index_hw[hctx->type];
> +			if (!sbitmap_test_bit(&hctx->ctx_map, bit))
> +				sbitmap_set_bit(&hctx->ctx_map, bit);
> +			q->last_merge =3D rq;
> +			spin_unlock(&ctx->lock);
> +			atomic_inc(&ufq->rqs_count);
> +		}
> +
> +		if (ops && rq && ops->insert_req) {
> +			rq->elv.priv[0] =3D (void *)((uintptr_t)rq->elv.priv[0]
> +				  | UFQ_PRIV_IN_BPF);

Once ctx->lock is dropped above, the request is globally visible and can be
immediately dispatched and freed by a concurrent hardware queue run.

Could accessing rq->elv.priv[0] and passing rq to ops->insert_req() below
lead to a write-after-free and a dangling pointer being sent to the BPF
program?

> +			ret =3D ops->insert_req(q, rq, flags);
> +			if (ret) {
> +				atomic_inc(&ufq->ops_stats.insert_err_count);
> +				pr_err("ufq-iosched: bpf insert_req error (%d)\n", ret);
> +			} else {

If ops->insert_req() returns an error here, the request remains in the
software queue but the UFQ_PRIV_IN_BPF flag is never cleared.

When the request completes, won't ufq_finish_request() see this flag and
incorrectly call ops->finish_req() for a request the BPF program explicitly
rejected?

> diff --git a/block/ufq-kfunc.c b/block/ufq-kfunc.c
> --- /dev/null
> +++ b/block/ufq-kfunc.c
[ ... ]
> +__bpf_kfunc bool bpf_request_bio_try_merge(struct request *rq, struct bi=
o *bio,
> +					   unsigned int nr_segs)
> +{
[ ... ]
> +	spin_lock(&ctx->lock);
> +	merged =3D blk_attempt_bio_merge(rq->q, rq, bio, nr_segs, true) =3D=3D =
BIO_MERGE_OK;
> +	spin_unlock(&ctx->lock);
> +
> +	return merged;
> +}

Is it safe to merge bios into this request without checking if it is idle?

If the target request has already been dispatched to the hardware
(rq->rq_flags & RQF_STARTED), could modifying the bio lists and segment
counts while the hardware is actively executing the I/O cause DMA corruptio=
n?

[ ... ]
> +__bpf_kfunc struct request *bpf_request_try_merge(struct request *rq, st=
ruct request *next)
> +{
> +	struct blk_mq_ctx *ctx;
> +	struct ufq_data *ufq;
> +	struct request *free;
> +
> +	if (!rq || !next || !rq->q || rq->q !=3D next->q)
> +		return NULL;
> +
> +	ufq =3D rq->q->elevator->elevator_data;

Because this kfunc is also registered for BPF_PROG_TYPE_SYSCALL, a BPF
program could pass a request from a block device running a completely
different I/O scheduler.

Wouldn't assuming rq->q->elevator->elevator_data is a struct ufq_data and
decrementing ufq->rqs_count below corrupt the private data of that other
scheduler?

[ ... ]
> +	spin_lock(&ctx->lock);
> +	free =3D bpf_attempt_merge(rq->q, rq, next);
> +	if (free) {
> +		if (rq->q->last_merge =3D=3D free)
> +			rq->q->last_merge =3D NULL;
> +		list_del_init(&free->queuelist);
> +		atomic_dec(&ufq->rqs_count);
> +	}
> +	spin_unlock(&ctx->lock);
> +
> +	return free;
> +}

When bpf_attempt_merge() successfully merges next into rq, it returns the
hollowed-out next request.

Since this kfunc returns it directly to the BPF program without the
KF_ACQUIRE flag, the verifier treats it as an untracked pointer. Does this
prevent the BPF program from calling bpf_request_release() on it,
permanently leaking the request and its hardware tag?

[ ... ]
> +BTF_KFUNCS_START(ufq_kfunc_set_ops)
> +BTF_ID_FLAGS(func, bpf_request_acquire, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_request_release, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_request_bio_try_merge, KF_SPIN_LOCK)
> +BTF_ID_FLAGS(func, bpf_request_try_merge, KF_SPIN_LOCK)
> +BTF_KFUNCS_END(ufq_kfunc_set_ops)

These kfuncs are registered with KF_SPIN_LOCK, meaning they can be called
inside a bpf_spin_lock critical section where preemption and interrupts are
disabled.

Since they call spin_lock(&ctx->lock) internally, won't this cause a
scheduling while atomic panic on PREEMPT_RT kernels where spinlock_t is a
sleeping rt_mutex?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503035623.2877=
1-1-kaitao.cheng@linux.dev?part=3D2
