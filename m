Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0335F5EA
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 04:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791002528; cv=none; b=qasJPkj1SGkztgHGKHn3NUFcSvI/WPFn+u4kAn/K6Zq8OXvPpU2B7Iw/QxuPcKi9LdVlvoingChSBssVSZOEE/ZoUruqWha69saoJxjM1TNWn8MhJgNuHrUlyiot0fPgyZ45Xz8rctgrheJVf1EiNT4BGB2iONo4oAsGrySGEwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791002528; c=relaxed/simple;
	bh=VN0z7zyU5YEyfJAc0HSBS22SsHbRN2xjA8vCc0iyCYU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tM/R65cYpiy+DOdTBCV1DlqytwJ3uikPHFWStHF8ASkUwglHkI1NTJHBUJAeU6x0s6OOYX+dGNJ+7oMXDnxtdfXzggxnq0c7ANy9yxTdu7YGlWqfd4aUjYWVJwPXi55Jhzy+brQmTvymggPwiJNAJLZ4dAtC9xtEqIiEVLxAjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG/ZIo+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG/ZIo+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3CB1F000FF;
	Sat,  3 Oct 2026 04:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791002526;
	bh=W3hu0er2q5I8pWJGq/mTqjrCrnwgEnkscOwcVYC83Rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aG/ZIo+IDNN7uByCw/o5YT0ObMJ5tWIxUVRIYSV0QCnXxWnmxf0fVqigFLoYsH/ag
	 nmTmX/we6ufdkss+iUDC/gBEaQz5cf2TvqQNBxhW4AUAYv3yKXlzJyB0f+EaQlnuLL
	 hagqJs/aeYF8hsWVmKwOCLKFVbpioD2kN/PXyqVg1jX2F6POFLP6SVAdPr/ZmoUu3n
	 zZqE33fWKnA/KxdlytFuFxcs5L8mAif5ZaKvHQ30BHfh0diVDfo3PKBQAssJYmyLYg
	 mOoErPQ7Ws3QaPuYN9HggE85401nZ+AW8aB+t6RoW/Kju46ibx3M8/VMCrmpIq/GaN
	 HhFYR7sIWYk0w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v3 3/3] tools/ufq_iosched: add PFQ eBPF I/O scheduler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261003042748.33795-4-kaitao.cheng@linux.dev>
References: <20261003042748.33795-1-kaitao.cheng@linux.dev>
 <20261003042748.33795-4-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 04:42:06 +0000
Message-Id: <20261003044206.9A3CB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] bpf: load failure due to unsupported special BTF fields in PER=
CPU_ARRAY
- [Critical] bpf: verifier rejection due to direct BTF field writes and PTR=
_UNTRUSTED usage
- [High] bpf: RB-tree corruption via in-place sorting key modification
- [High] block: permanent I/O stall when waiting for SPECIAL+READ queues
- [High] bpf: lock inversion and PREEMPT_RT violation in insert error path
--

commit b7bd634a597878034765fedd606831b034490328
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

tools/ufq_iosched: add PFQ eBPF I/O scheduler

Add a Priority Fair Queue (PFQ) eBPF I/O scheduler to the UFQ framework.
It supports weighted fair scheduling, request merging, and preferential
service for configured interactive threads.

> diff --git a/tools/ufq_iosched/pfq.bpf.c b/tools/ufq_iosched/pfq.bpf.c
> new file mode 100644
> index 0000000000000..c1aa8650138e9
> --- /dev/null
> +++ b/tools/ufq_iosched/pfq.bpf.c

[ ... ]

> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, u32);
> +	__type(value, struct pfq_disk_data);
> +} pfq_disk_scratch SEC(".maps");

[Severity: Critical]
Can the verifier load this program?

The pfq_disk_scratch map is a BPF_MAP_TYPE_PERCPU_ARRAY, but its value type
struct pfq_disk_data contains a bpf_spin_lock, bpf_list_head, and bpf_rb_ro=
ot.

The verifier natively rejects special BTF fields in per-CPU arrays via
map_check_btf(), returning -EOPNOTSUPP.

[ ... ]

> +static void pfq_disk_scratch_reset(struct pfq_disk_data *d)
> +{
> +	u32 i;
> +
> +	d->lock =3D (struct bpf_spin_lock){};

[Severity: Critical]
Is it valid to write directly to opaque special BTF fields?

The verifier strictly forbids direct assignments to bpf_spin_lock and
graph nodes.

[ ... ]

> +static void pfq_finish_front_bio_merge(struct pfq_disk_data *dd,
> +				       struct pfq_queue_data *queue,
> +				       struct pfq_rq_core *rn,
> +				       u64 new_sector)
> +{
> +	rn->sector =3D new_sector;

[Severity: High]
Does this corrupt the fifo_trees RB-tree?

This modifies rn->sector while rn is still linked in the FIFO tree.
The sector field is used as a tie-breaker sorting key in fifo_less().

[ ... ]

> +static __noinline int
> +pfq_insert_core_locked(struct pfq_disk_data *dd,
> +		       struct pfq_queue_data *queue,
> +		       struct pfq_rq_core *core,
> +		       struct request *rq,
> +		       struct pfq_insert_cleanup *cleanup)
> +{
> +	struct pfq_rq_core *list_ref, *list_n, *tree_n, *held =3D NULL;
> +	struct bpf_rb_root *rq_root =3D pfq_rq_tree(dd, queue->qid);
> +	struct bpf_rb_root *fifo_root =3D pfq_fifo_tree(dd, queue->qid);
> +	struct request *old;
> +
> +	list_ref =3D bpf_refcount_acquire(core);
> +	if (!list_ref) {

[ ... ]

> +	if (!rq_root || bpf_rbtree_add(rq_root, &core->rb_node, rq_less)) {

[Severity: High]
Does this error path introduce a lock inversion and panic on PREEMPT_RT
kernels?

If bpf_rbtree_add() fails, the BPF core synchronously drops the consumed no=
de,
triggering the destructor bpf_request_release() for its inner kptr.

Because dd->lock is held (a bpf_spin_lock mapping to a raw spinlock), and
bpf_request_release() calls __blk_mq_free_request() which acquires a sleepa=
ble
spinlock on PREEMPT_RT systems, this violates atomic context rules.

This also applies to pfq_dispatch_push_dn() in pfq_insert_req().

[ ... ]

> +	if (!fifo_root ||
> +	    bpf_rbtree_add(fifo_root, &list_ref->fifo_rb_node, fifo_less)) {

[ ... ]

> +	/*
> +	 * Keep an owning reference for activation rollback or final cleanup.
> +	 * Successful insertion retains both tree references independently.
> +	 */
> +	held =3D bpf_refcount_acquire(core);

[Severity: Critical]
Can core be acquired here after it was passed to bpf_rbtree_add() earlier
in this function?

The tree insertion consumes the owning reference, making this a use-after-c=
onsume
that the verifier will reject.

[ ... ]

> +static void pfq_update_queue_vtime(struct pfq_disk_data *dd,
> +				   struct pfq_queue_data *queue,
> +				   u32 sectors)
> +{
> +	u64 delta;
> +
> +	if (queue->vtime < dd->vtime)
> +		queue->vtime =3D dd->vtime;
> +	delta =3D ((u64)sectors << PFQ_VTIME_SHIFT) / queue->weight;
> +	/* Integer truncation must not give small requests free service. */
> +	if (sectors && !delta)
> +		delta =3D 1;
> +	queue->vtime +=3D delta;

[Severity: High]
Does this corrupt the service_tree RB-tree?

This modifies queue->vtime while queue remains actively linked in the tree,
altering its sorting key in place.

[ ... ]

> +static void pfq_start_idle_hold(struct pfq_disk_data *dd,
> +			       struct pfq_queue_data *queue, u64 now, u32 random,
> +			       struct pfq_stats *stats)
> +{

[ ... ]

> +	WRITE_ONCE(dd->idle_queue_qid, queue->qid);
> +	dd->waiting_idle =3D true;

[Severity: High]
When an empty SPECIAL read queue is selected, pfq_start_idle_hold() sets
dd->waiting_idle =3D true, causing the dispatcher to return NULL below.

Does this permanently stall the block layer queue?

Returning NULL instructs the block layer that no requests are available.
Since the scheduler does not explicitly arm a block layer timer or delayed
workqueue to resume dispatching when the idle deadline passes, the system
will never wake up to check the deadline unless another I/O request is
coincidentally inserted.

[ ... ]

> +static int pfq_init_queue_fields(struct pfq_disk_data *dd, u32 idx)
> +{
> +	struct pfq_queue_data *queue =3D pfq_queue_scalar(dd, idx);
> +
> +	if (!queue)
> +		return -ENOENT;
> +
> +	queue->qid =3D idx;

[Severity: Critical]
Can we write to queue here?

pfq_queue_scalar() returns an unacquired pointer (PTR_UNTRUSTED) from a map
lookup. The verifier forbids writing to untrusted kptrs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003042748.3379=
5-1-kaitao.cheng@linux.dev?part=3D3
