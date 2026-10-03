Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0038837B
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 04:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791002755; cv=none; b=Q85OVDoINHxSeDFSWNg4f1BFBoBJuWTJWfdaxPZqazw5ulyaUHNnlo18VEJbSjQkqhK8Ih3mhdId10suekNseH56/6MUxGTLkOZ/EcUQHsU0EJKUaURXGIxwV1csLvGCiuU+Fg4783wUiZcBEj0+6nngOh3IoV4552KSf+EDZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791002755; c=relaxed/simple;
	bh=a1mgLygXWCjXz73qBOO8IEYCEKzwH4wKkkrLgm25U2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tzr7MiVXcWAxcTJhO7xqBe8B/lcTZusiXzOaXXqj5RZPamXcU4dythxlGzpPr7WR1MZVPrbodQb1KASlaADSbRWYDahPVgBEa38X2ZxbfUbwX+B/H4gfWdT0h6Nin2wP7NkGDvr5PuI4FD3OZ0kiEAorQd/UuUuqG9flG0yZHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljW8tDPB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljW8tDPB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA211F000FF;
	Sat,  3 Oct 2026 04:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791002753;
	bh=CqcjgeRwFhBqvhjI+gJwO2EopIKh3ZDKqx7KmwG6Nao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ljW8tDPB96XZUNg5GlZ/Ygax8Ox4xncLohBc7oAB5StcwNOdiyhyaiMtqbmJ5JSA1
	 8D8oWTcOtmONekQKfE5NUBIIEvecCBEkgxo3XZVBic4lzNqaQDUPx5/C6XgUE4lMXh
	 yHEn21ctdFzptXMzz35rXAh280iZY0+WQhxICPenapjv8BE9aMlsiNe5DmAcfxeB2Z
	 Doia/Q8p941C82GYQ1i33evF9YlbEz67mx5KCK1lelb4qoCoJxg67a+aEh1RxhCGl6
	 COAqhzsmkPG6OonsjCL1Br19y8MpfOosC3xxMV2358HroBeEvkkU4MUVEz0uihzBRp
	 D5ARAxvqQvUkQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v3 1/3] block: Introduce the UFQ I/O scheduler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261003042748.33795-3-kaitao.cheng@linux.dev>
References: <20261003042748.33795-1-kaitao.cheng@linux.dev>
 <20261003042748.33795-3-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 04:45:53 +0000
Message-Id: <20261003044553.BCA211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [Critical] block: ufq_bio_merge() destroys active target request leading =
to UAF
- [Critical] block: missing state validation in UFQ merges allows corruptio=
n of in-flight requests
- [Critical] bpf: unbounded stack buffer overflow in UFQ struct_ops via PTR=
_TO_BUF
- [High] bpf: bpf_request_try_merge() permanently leaks absorbed requests
- [High] block: ufq_insert_requests() re-inserts requests that absorbed a b=
ack-merge
- [High] bpf: incompatible reference contract in dispatch_req leads to UAF
- [High] block: TOCTOU Use-After-Free in UFQ merge and dispatch paths
- [High] bpf: bpf_request_bio_try_merge() allows double-merging of bios cau=
sing list corruption
- [High] bpf: bpf_request_try_merge() crashes on already-merged requests
- [Medium] bpf: spin_trylock() inside KF_SPINLOCK_SAFE causes Invalid wait =
context on PREEMPT_RT
- [Low] block: modpost failure due to missing EXPORT_SYMBOL_GPL for core fu=
nctions
--

commit 439b7e4704107bb499b42ef24fd4ef9ddf9e15ea
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

block: Introduce the UFQ I/O scheduler

Introduce IOSCHED_UFQ, a blk-mq elevator ("ufq: User-programmable
Flexible Queueing") whose policy is supplied by an eBPF program via
struct_ops (insert, dispatch, merge, finish, etc.).

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e929f94b25c7f..aa8ae5bd4b6fd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -809,7 +809,7 @@ static void blk_mq_finish_request(struct request *rq)
>  	}
>  }
> =20
> -static void __blk_mq_free_request(struct request *rq)
> +void __blk_mq_free_request(struct request *rq)
>  {

[Severity: Low]
Will this cause a modpost failure?

CONFIG_IOSCHED_UFQ can be compiled as a module, and it calls
__blk_mq_free_request(), bpf_attempt_merge(), and blk_attempt_bio_merge().
Since these core block layer functions are not exported via EXPORT_SYMBOL_G=
PL,
linking the module will fail during modpost.

> diff --git a/block/ufq-bpfops.c b/block/ufq-bpfops.c
> new file mode 100644
> index 0000000000000..5efcfcaa9cb8c
> --- /dev/null
> +++ b/block/ufq-bpfops.c
> [ ... ]
> +static bool bpf_ufq_is_valid_access(int off, int size,
> +				    enum bpf_access_type type,
> +				    const struct bpf_prog *prog,
> +				    struct bpf_insn_access_aux *info)
> +{
> [ ... ]
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

[Severity: Critical]
Does this allow an unbounded stack buffer overflow?

The verifier is told to treat the pointer as a variable-sized buffer
(PTR_TO_BUF) to allow pointer writes, but the subsystem fails to validate t=
he
size against the actual variable size in the check_member callback. A
malicious BPF program can write out of bounds into the stack variables pass=
ed
to merge_req and merge_bio.

> diff --git a/block/ufq-iosched.c b/block/ufq-iosched.c
> new file mode 100644
> index 0000000000000..f7964ccfc1ee3
> --- /dev/null
> +++ b/block/ufq-iosched.c
> [ ... ]
> +static struct request *ufq_dispatch_request(struct blk_mq_hw_ctx *hctx)
> +{
> [ ... ]
> +		/*
> +		 * The BPF insert_req callback bumps the request's reference
> +		 * count; dispatch_req returns that same request with an extra
> +		 * reference held. The kernel must put that reference here,
> +		 * and the request's refcount is always greater than zero at
> +		 * this point.
> +		 */
> +		if (WARN_ON_ONCE(req_ref_put_and_test(rq))) {
> +			__blk_mq_free_request(rq);

[Severity: High]
Is the reference contract here incompatible with the BPF verifier?

ufq_dispatch_request() expects BPF to transfer an acquired reference.
However, BPF struct_ops do not support returning acquired references. To
bypass the verifier, a BPF program must return an unacquired pointer,
which causes the kernel to decrement the core reference count instead of
an extra one, freeing an active request prematurely.

> +			ufq_bpfops_put();
> +			return NULL;
> +		}
> +
> +		ctx =3D rq->mq_ctx;
> +		spin_lock(&ctx->lock);

[Severity: High]
Does this expose a Time-of-Check to Time-of-Use race?

The BPF-owned reference is dropped via req_ref_put_and_test() before
dereferencing rq->mq_ctx and acquiring the lock. If the request completes
concurrently during this window, the reference count drops to zero and it is
freed, resulting in a Use-After-Free.

> [ ... ]
> +static bool ufq_bio_merge(struct request_queue *q, struct bio *bio,
> +			  unsigned int nr_segs)
> +{
> [ ... ]
> +			if (rq) {
> +				spin_lock(&rq->mq_ctx->lock);
> +				if (!list_empty(&rq->queuelist)) {
> +					list_del_init(&rq->queuelist);
> +					atomic_dec(&ufq->rqs_count);
> +				}
> +				spin_unlock(&rq->mq_ctx->lock);
> +				/* merge_bio transfers an extra BPF-owned reference. */
> +				WARN_ON_ONCE(req_ref_put_and_test(rq));
> +				blk_mq_free_request(rq);

[Severity: Critical]
Does this cause a Use-After-Free by destroying the active target request?

If the BPF policy's merge_bio hook successfully merges a bio into a request,
it returns the target rq. The kernel then erroneously calls
blk_mq_free_request(rq), actively destroying the target request that is
still waiting for dispatch instead of just dropping the BPF reference.

> [ ... ]
> +static enum elv_merge ufq_try_insert_merge(struct request_queue *q,
> +					   struct request **new)
> +{
> [ ... ]
> +	ops =3D ufq_bpfops_tryget();
> +	if (ops && ops->merge_req) {
> +		target =3D ops->merge_req(q, rq, &merge_type);

[Severity: Critical]
Can this overflow the merge_type stack variable?

This points to the stack variable merge_type which is passed to the BPF
program via PTR_TO_BUF without proper bounds checking, leading to local
privilege escalation.

> +		type =3D (enum elv_merge)merge_type;
> +	}
> +
> +	if (target && WARN_ON_ONCE(req_ref_put_and_test(target))) {
> +		__blk_mq_free_request(target);

[Severity: High]
Does this introduce a Time-of-Check to Time-of-Use race?

The BPF-owned reference on the target request is dropped via
req_ref_put_and_test() before taking target->mq_ctx->lock and validating
the request. If the request completes concurrently during this window, the
reference count drops to zero and it is freed, resulting in a Use-After-Free
when dereferencing target->mq_ctx later in this function.

> +		ufq_bpfops_put();
> +		return ELEVATOR_NO_MERGE;
> +	}
> +
> +	if (type =3D=3D ELEVATOR_NO_MERGE || !target) {
> +		if (ops)
> +			ufq_bpfops_put();
> +		return ELEVATOR_NO_MERGE;
> +	} else if (type =3D=3D ELEVATOR_FRONT_MERGE) {
> +		if (rq->mq_ctx !=3D target->mq_ctx || rq->mq_hctx !=3D target->mq_hctx)
> +			goto rollback;
> +		spin_lock(&target->mq_ctx->lock);

[Severity: Critical]
Is there a missing state validation here?

The BPF merge_req callback blindly returns an arbitrary target request. The=
re
is no verification that the target request belongs to the correct queue, nor
that its state is MQ_RQ_IDLE. Modifying an in-flight request concurrently
with active DMA transfers corrupts data.

> [ ... ]
> +static void ufq_insert_requests(struct blk_mq_hw_ctx *hctx,
> +			       struct list_head *list,
> +			       blk_insert_t flags)
> +{
> [ ... ]
> +		if (ops && rq && ops->insert_req) {
> +			rq->elv.priv[0] =3D (void *)((uintptr_t)rq->elv.priv[0]
> +				  | UFQ_PRIV_IN_BPF);
> +			ret =3D ops->insert_req(q, rq, flags);

[Severity: High]
Does this cause double-insertion for requests that absorbed a back-merge?

If ufq_try_insert_merge() results in an ELEVATOR_BACK_MERGE, rq is updated
to point to the target request. This function then unconditionally calls
ops->insert_req() on this pre-existing target request, corrupting the BPF
scheduler's internal tracking.

> diff --git a/block/ufq-kfunc.c b/block/ufq-kfunc.c
> new file mode 100644
> index 0000000000000..843aeb0e67cff
> --- /dev/null
> +++ b/block/ufq-kfunc.c
> @@ -0,0 +1,169 @@
> [ ... ]
> +__bpf_kfunc bool bpf_request_bio_try_merge(struct request *rq, struct bi=
o *bio,
> +					   unsigned int nr_segs)
> +{
> [ ... ]
> +	/*
> +	 * KF_SPINLOCK_SAFE callers (BPF merge_bio) often already hold a schedu=
ler
> +	 * lock taken with irqsave (e.g. PFQ dd->lock).  Blocking on ctx->lock
> +	 * nesting that order deadlocks / hard-locks under load.  Trylock: skip
> +	 * the merge if ctx is busy; bio will be issued as a new request.
> +	 */
> +	if (!spin_trylock(&ctx->lock))
> +		goto out;

[Severity: Medium]
Will this cause an Invalid wait context warning on PREEMPT_RT?

This kfunc is annotated with KF_SPINLOCK_SAFE, meaning it can execute with
interrupts disabled or a raw_spinlock_t held. Calling spin_trylock() inside
this context violates strict lock nesting rules, as it maps to an rt_mutex
operation on PREEMPT_RT.

> +
> +	merged =3D blk_attempt_bio_merge(q, rq, bio, nr_segs, true) =3D=3D BIO_=
MERGE_OK;

[Severity: Critical]
Is there missing state validation for the target request here?

The kfunc modifies the target request's internal structures without verifyi=
ng
that its state is MQ_RQ_IDLE, which can corrupt data if the request is alre=
ady
in-flight.

[Severity: High]
Can a BPF program trigger double-merging of bios here?

Because sector proximity checks will still pass and there is no safeguard
against already-merged bios, calling this kfunc multiple times with the
same bio will link it into the biotail of multiple requests, corrupting
the bi_next pointers.

> [ ... ]
> +__bpf_kfunc struct request *bpf_request_try_merge(struct request *rq, st=
ruct request *next)
> +{
> [ ... ]
> +	free =3D bpf_attempt_merge(q, rq, next);

[Severity: High]
Can this code crash by dereferencing a NULL pointer?

If bpf_request_try_merge() successfully absorbs a request, the block layer
sets next->bio =3D NULL. If the BPF program erroneously calls this kfunc
again on the already-absorbed request, attempt_merge() will
unconditionally dereference next->bio->bi_write_hint.

> [ ... ]
> +BTF_KFUNCS_START(ufq_kfunc_set_ops)
> +BTF_ID_FLAGS(func, bpf_request_acquire, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_request_release, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_request_bio_try_merge, KF_SPINLOCK_SAFE)
> +BTF_ID_FLAGS(func, bpf_request_try_merge, KF_SPINLOCK_SAFE)

[Severity: High]
Does this code permanently leak the absorbed request?

bpf_request_try_merge() returns the redundant absorbed request, but without
the KF_ACQUIRE flag, the BPF verifier treats it as an unreferenced pointer.
The BPF program cannot legally free it via bpf_request_release(), and the
kernel omits freeing it, resulting in a permanent leak and eventual
exhaustion of block tags.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003042748.3379=
5-1-kaitao.cheng@linux.dev?part=3D1
