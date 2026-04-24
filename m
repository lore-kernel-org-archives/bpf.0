Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90236C0CB
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777062539; cv=none; b=pYUcsubmRvfKZzMvJNh1EWelSVR2oTsrwhULmvtHz9f1u93agQwRMv3jtK3n1G2ZaUXbHDc/49eYyY0oN/BeELNM++3z0aJwFBcoquqZAjwtdiy5zldNz27JagB0GBkmNWRS/qUMCbj9qIRpxZcQ1X9NqgPM9hL3DJb78rbb11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777062539; c=relaxed/simple;
	bh=LeWtMza1NEtx8PNhrC2KM83q4wHE+oPHMMdyQ4+WNM4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HUw/sIzdpwoCejk+1ClIamMgsyBXLhIXIVFI/1x/QS0y7GJOiyB8bGey0UR7NBnQBm91uts26vhuc7g+ehJikTUDvDIKsAZoqTtLOhXRv8ubCxc1xaCMoxm9oPD4Nyg2mtRVtSLLzqw6+UmDzM2Xu1AMJxFoo8x/AbHngmgQ70g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+gDFNW8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+gDFNW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD0FC19425;
	Fri, 24 Apr 2026 20:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777062538;
	bh=LeWtMza1NEtx8PNhrC2KM83q4wHE+oPHMMdyQ4+WNM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=t+gDFNW8ZSI8nGRS13rC5NC+AJsFv/yptJYiYxTIbDlMv+H4zPFPV5nOizxEcm8BT
	 SG/sD2GLMhUdWtg+sNrCVEGrCF4UFdRwjPe/vmhuwAxF6Y/f3enrHxbYOJS6gmJNWx
	 OIx7Q8Xnieu9yqVok5Pn/BbV/jojAQaR66Ze7GDvWOvNUEl93VzRqsWzjp2fnwacN5
	 cH9LMdsYG2RSzs2cgBHC2t5guP8TrqBlBOITY6VQbTEfwofLX7h9UIa/XVJNZgZqo8
	 W1y2tlcsD19QztPOOclfCR7GMnppr5bvcuAtmIBiSlANBIdwYafFhcOT1rlzDF8xSY
	 WqD7UbDQojpyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 04/10] bpf: Implement batch ops and
 iterators for resizable hashtab
Reply-To: sashiko@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424-rhash-v3-4-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-4-d0fa0ce4379b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 20:28:57 +0000
Message-Id: <20260424202858.7DD0FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Cursor invalidation in batch and seq_file iterators causes O(N^2) =
complexity and infinite loops.
- [High] Unbounded RCU read lock duration in batch operations allows user-t=
riggered RCU stalls.
- [High] Map iterators and seq_file dumps spuriously abort during normal ba=
ckground resizes.
- [High] Deadlock risk in `bpf_each_rhash_elem` due to acquiring `spin_lock=
` from atomic contexts.
--

commit 9f7ce51619eb27e8a4a65df12f862e12e34bc285
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Implement batch ops and iterators for resizable hashtab

This commit adds batch operations for resizable hashtab maps, using
rhashtable_walk_enter_from() to resume iteration. It also wires up
seq_file BPF iterators and implements rhtab_map_mem_usage().

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d37f3d548d3658..000caa2c7f4cd9 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -3066,64 +3066,330 @@ static int rhtab_map_get_next_key(struct bpf_map=
 *map, void *key, void *next_key
> +static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t call=
back_fn,
> +				void *callback_ctx, u64 flags)
> +{

[ ... ]

> +	/*
> +	 * The rhashtable walk API uses spin_lock in rhashtable_walk_start/stop,
> +	 * which is not safe in NMI or soft/hard IRQ context.
> +	 */
> +	if (in_nmi() || in_hardirq() || in_softirq())
> +		return -EOPNOTSUPP;
> +
> +	rhashtable_walk_enter(&rhtab->ht, &iter);

Does this adequately protect against deadlocks when called from kprobes or
tracepoints in process context with preemption disabled?

If a thread currently holding ht->lock (e.g., during map insertion) is
interrupted by a kprobe that runs this BPF program, attempting to acquire
the same spin_lock inside rhashtable_walk_enter() might cause a deadlock.

> +	rhashtable_walk_start(&iter);
> +
> +	while ((elem =3D rhashtable_walk_next(&iter))) {
> +		/* rhashtable_walk_next returns -EAGAIN on resize, abort */
> +		if (IS_ERR(elem)) {
> +			num_elems =3D -EBUSY;
> +			break;
> +		}

Is it expected to abort the entire iteration if a background map resize
occurs?=20

rhashtable_walk_next() returns -EAGAIN to indicate the table was resized and
the iterator was rewound. Since resizable hashtabs automatically resize
during normal workloads, returning -EBUSY here could cause
bpf_for_each_map_elem() and bpftool map dumps to randomly fail.

Should this handle -EAGAIN by retrying or continuing the walk instead?

[ ... ]

> +static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
> +					       const union bpf_attr *attr,
> +					       union bpf_attr __user *uattr,
> +					       bool do_delete)
> +{

[ ... ]

> +	/*
> +	 * Use the last key from the previous batch as cursor.
> +	 * enter_from positions at that key's bucket, walk_next
> +	 * returns the successor in O(1).
> +	 * First call (ubatch =3D=3D NULL): starts from bucket 0.
> +	 */
> +	if (ubatch) {
> +		buf =3D kmalloc(key_size, GFP_USER | __GFP_NOWARN);
> +		if (!buf) {
> +			ret =3D -ENOMEM;
> +			goto free;
> +		}
> +		if (copy_from_user(buf, ubatch, key_size)) {
> +			ret =3D -EFAULT;
> +			goto free;
> +		}
> +	}
> +
> +	scoped_guard(rcu) {
> +		rhashtable_walk_enter_from(&rhtab->ht, &iter, buf, rhtab->params);
> +		rhashtable_walk_start(&iter);
> +	}

If the key stored in buf was already deleted, will this iteration restart
from the beginning of the map?

Looking at rhashtable_walk_enter_from(), if it fails to find the key, it
leaves iter->slot at 0. Then rhashtable_walk_start() and walk_next() will
start from bucket 0 instead of where the previous batch left off.

Since lookup_and_delete_batch deletes the elements returned in the previous
batch, the cursor key will always be deleted. Could this cause the iterator
to repeatedly scan over all emptied buckets, resulting in an expensive
traversal?

Similarly, for lookup_batch and seq_file dumps, if the cursor is
concurrently deleted, could this trap userspace in an infinite loop of
duplicate elements?

> +
> +	dst_key =3D keys;
> +	dst_val =3D values;
> +	total =3D 0;
> +
> +	while (total < max_count) {
> +		elem =3D rhtab_iter_next(&iter);
> +		if (!elem)
> +			break;

Can this loop cause RCU stalls or soft lockups if max_count is very large?=
=20

The max_count parameter is controlled by userspace. Since
rhashtable_walk_start() acquires the RCU read-side critical section, this
loop might iterate, copy memory, and process millions of elements without
ever dropping the RCU lock or calling cond_resched().

[ ... ]

> +static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
> +	__acquires(RCU)
> +{

[ ... ]

> +	elem =3D rhashtable_walk_next(&info->iter);
> +	/* rhashtable_walk_next returns -EAGAIN on resize, abort */
> +	if (IS_ERR(elem))
> +		return ERR_PTR(-EBUSY);

Similar to bpf_each_rhash_elem, will returning -EBUSY here on normal hash
table resizes cause userspace map dumps to fail spuriously?

[ ... ]

> +static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_=
t *pos)
> +{

[ ... ]

> +	elem =3D rhashtable_walk_next(&info->iter);
> +	/* rhashtable_walk_next returns -EAGAIN on resize, abort */
> +	if (IS_ERR(elem))
> +		return ERR_PTR(-EBUSY);
> +
> +	return elem;
> +}

Again, aborting on -EAGAIN here might interrupt the map dump when a resize
happens in the background. Is there a way to handle -EAGAIN without failing
the entire sequence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424-rhash-v3-0=
-d0fa0ce4379b@meta.com?part=3D4
