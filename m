Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41B37BE80
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777785514; cv=none; b=lz6rZFQfg3S8pjeqiS7WsGaAMMAkKn2P/0jLkUeeSB/Pnh8RA42KRg5fkTTALlFDFgSd5SX4UprwXvMFiYG8SZck7ZOVT9+KMKddB1N+oeP2y7QRALtPLVlZxqj+ReLLSvLyGAFFFPBWoYvjjefJXhz7NyaYks+R93USSb3W9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777785514; c=relaxed/simple;
	bh=KrgWOi1++IUXfdXoHA26zg0lkROYbc+/DLGNGrxCWt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RgLQRZkjbEy6F7YxifLnjMt8Re2NsXVXkweW8fsAcPWagL6kZ8DUGZcuaE1TEKPSTmfj2t+5z9+r0kisI5xiJZllaJjBoheem5fp5braoj+OSfBU+a3worsW3lE1/7eL0Fyv15Ise1lmjY1N7ifqUF+clLTF8jJgwnLMyvbVS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP+f9t5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP+f9t5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4773C2BCB4;
	Sun,  3 May 2026 05:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777785514;
	bh=KrgWOi1++IUXfdXoHA26zg0lkROYbc+/DLGNGrxCWt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MP+f9t5bCyNBlRHPWEn4WNstRPFpWFnSoPQ5zGVRl0oH36PWaFJ9d2vRRxIPx0yJs
	 uraE0hDoWZKbAZISUO3T7Rh6WyR7FCRdHJA5bDVySmIylSNXH+c/UPw4vzOVQmPOwI
	 1oN1dMSW/QN2rJo6DauXPaRyXDdLTlVYP1Lx7eVaa6b7TMNXFmrjapgCLz9jPVyMnG
	 fgVGJb1z0YOZ4KvI5JQWLLNhqj+owMINkWpzjP8kvIybY5rFjo9YgqmBUN5OGNZdLs
	 u3v6480AEGDwUmYON2fLCuClDzBGuFRRv2cpys7JR9Ca078+dtURGriccPD72F0ESC
	 D5VOSqMd+ZZSw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v2 3/3] tools/ufq_iosched: add BPF example scheduler and
 build scaffolding
Reply-To: sashiko@lists.linux.dev
To: "Kaitao cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503035623.28771-4-kaitao.cheng@linux.dev>
References: <20260503035623.28771-4-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 05:18:33 +0000
Message-Id: <20260503051833.E4773C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Hallucinated BPF rbtree traversal functions
- [High] Wait-context violation and lock inversion via `bpf_request_bio_try=
_merge`
- [High] Verifier rejection due to unreleased acquired request references
- [High] Verifier rejection from accessing non-owning reference after tree =
mutation
- [High] Target request permanently orphaned after a merge operation
- [High] Red-black tree corruption due to mutable traversal keys
- [High] Use-After-Free when accessing `free->__data_len`
- [Medium] Incorrect queue insertion order for `BLK_MQ_INSERT_AT_HEAD`
- [Medium] Non-atomic updates to per-CPU array statistics
--

commit 837eafbebf3f48dff3cc402191f742e1f891291d
Author: Kaitao Cheng <chengkaitao@kylinos.cn>
tools/ufq_iosched: add BPF example scheduler and build scaffolding

Add ufq_iosched as a simple example for the UFQ block I/O scheduler. It
implements the eBPF struct_ops hooks the kernel exposes to exercise the
behavior and stability of the kernel UFQ scheduling framework.

> diff --git a/tools/ufq_iosched/ufq_simple.bpf.c b/tools/ufq_iosched/ufq_s=
imple.bpf.c
> new file mode 100644
> index 000000000000..81954e73068a
> --- /dev/null
> +++ b/tools/ufq_iosched/ufq_simple.bpf.c

[ ... ]

> +static void stat_add(u32 idx, u32 val)
> +{
> +	u64 *cnt_p =3D bpf_map_lookup_elem(&stats, &idx);
> +
> +	if (cnt_p)
> +		(*cnt_p) +=3D val;
> +}

Since operations like insert_req can run in process context while finish_req
might run in softirq on the same CPU, could these non-atomic updates result
in lost statistics? Should this use __sync_fetch_and_add() instead?

[ ... ]

> +int BPF_STRUCT_OPS(ufq_simple_insert_req, struct request_queue *q,
> +		   struct request *rq, blk_insert_t flags,
> +		   struct list_head *freeq)
> +{
[ ... ]
> +	if (flags & BLK_MQ_INSERT_AT_HEAD) {
[ ... ]
> +		/* Add queue_list_node to dispatch list */
> +		bpf_spin_lock(&ufq_sd->lock);
> +		ret =3D bpf_list_push_back(&ufq_sd->dispatch, &qnode->node);
> +		bpf_spin_unlock(&ufq_sd->lock);
> +	} else {

Does using bpf_list_push_back() here place the request at the tail of the
dispatch list rather than the head? Since dispatch_req pops from the front,
this seems to violate the requested BLK_MQ_INSERT_AT_HEAD semantics.

[ ... ]

> +struct request *BPF_STRUCT_OPS(ufq_simple_dispatch_req, struct request_q=
ueue *q)
> +{
[ ... ]
> +		snode =3D container_of(rb_node, struct sort_tree_node, rb_node);
> +
> +		/* Get request from sort_tree_node (this will be returned) */
> +		rq =3D bpf_kptr_xchg(&snode->req, NULL);
> +		bpf_spin_unlock(&ufq_sd->lock);
> +		bpf_obj_drop(snode);
> +	}
> +	if (!rq)
> +		bpf_printk("ufq_simple/dispatch_req: no request to dispatch");
> +
> +out:
> +	if (rq) {
> +		stat_add(UFQ_SIMP_DISPATCH_CNT, 1);
> +		stat_add(UFQ_SIMP_DISPATCH_SIZE, rq->__data_len);
> +	}
> +
> +	return rq;
> +}

Will the verifier reject this program because it returns an acquired refere=
nce
from bpf_kptr_xchg without calling bpf_request_release()? Also, if the
verifier did allow this, would the request reference permanently leak since
the block layer doesn't consume BPF kptr references?

> +bool BPF_STRUCT_OPS(ufq_simple_has_req, struct request_queue *q, int rqs=
_count)
> +{
[ ... ]
> +	bpf_spin_lock(&ufq_sd->lock);
> +	has =3D !bpf_list_empty(&ufq_sd->dispatch) ||
> +	      bpf_rbtree_root(&ufq_sd->sort_tree_read) ||
> +	      bpf_rbtree_root(&ufq_sd->sort_tree_write);

The functions bpf_rbtree_root(), bpf_rbtree_left(), and bpf_rbtree_right()
are used throughout this file, but they do not appear to exist in the BPF
API. The API only exposes bpf_rbtree_add(), bpf_rbtree_remove(), and
bpf_rbtree_first(). Will this code fail to compile and load?

[ ... ]

> +struct request *BPF_STRUCT_OPS(ufq_simple_merge_req, struct request_queu=
e *q,
> +				struct request *rq, int *type)
> +{
[ ... ]
> +		if (mt) {
> +			if (rq->mq_ctx !=3D targ_mq_ctx || rq->mq_hctx !=3D targ_mq_hctx) {
> +				mt =3D ELEVATOR_NO_MERGE;
> +				break;
> +			}
> +
> +			rb_node =3D bpf_rbtree_remove(tree, rb_node);
> +			if (rb_node) {
> +				snode =3D container_of(rb_node,
> +					struct sort_tree_node, rb_node);
> +				targ =3D bpf_kptr_xchg(&snode->req, NULL);
> +				bpf_spin_unlock(&ufq_sd->lock);
> +				if (targ) {
> +					*type =3D mt;
> +					stat_add(UFQ_SIMP_RQMERGE_CNT, 1);
> +					stat_add(UFQ_SIMP_RQMERGE_SIZE, targ->__data_len);
> +					stat_sub(UFQ_SIMP_INSERT_CNT, 1);
> +					stat_sub(UFQ_SIMP_INSERT_SIZE, targ->__data_len);
> +				}
> +
> +				bpf_obj_drop(snode);
> +			} else {
> +				bpf_spin_unlock(&ufq_sd->lock);
> +				*type =3D ELEVATOR_NO_MERGE;
> +			}
> +			return targ;
> +		}
> +	}
> +	bpf_spin_unlock(&ufq_sd->lock);
> +
> +	return NULL;
> +}

If a candidate request is found for merging, it gets permanently removed fr=
om
the scheduler's rbtree and its node is dropped. Since dispatch_req will now
never see it, does this result in a permanent I/O hang for the merged target
request?

> +static struct request *merge_bio_left_unlock(struct ufq_simple_data *ufq=
_sd,
> +					     struct bpf_rb_root *tree,
> +					     struct sort_tree_node *snode,
> +					     struct request *cand)
> +{
[ ... ]
> +	if (left_end =3D=3D cand_start)
> +		free =3D bpf_request_try_merge(left_rq, cand);
> +
> +	if (free =3D=3D cand) {
> +		removed =3D bpf_rbtree_remove(tree, &snode->rb_node);
> +		left_rq =3D bpf_kptr_xchg(&left_node->req, left_rq);

According to BPF safety rules, removing a node from a collection invalidates
all non-owning references to that collection. Will the verifier reject this
program because it accesses left_node right after calling bpf_rbtree_remove=
()?

> +		bpf_spin_unlock(&ufq_sd->lock);
> +		if (removed) {
> +			struct sort_tree_node *drop =3D container_of(removed,
> +					struct sort_tree_node, rb_node);
> +			bpf_obj_drop(drop);
> +		}
> +		stat_add(UFQ_SIMP_RQMERGE_CNT, 1);
> +		stat_add(UFQ_SIMP_RQMERGE_SIZE, free->__data_len);

If bpf_request_try_merge() is successful, it merges and frees the candidate
request. By passing free->__data_len to stat_add, does this cause a
use-after-free read on a request that was just returned to the block layer?

[ ... ]

> +struct request *BPF_STRUCT_OPS(ufq_simple_merge_bio,
> +			       struct request_queue *q, struct bio *bio,
> +			       unsigned int nr_segs, bool *merged)
> +{
[ ... ]
> +	bpf_spin_lock(&ufq_sd->lock);
[ ... ]
> +	while (rb_node && count < UFQ_LOOP_MAX) {
> +		count++;
> +		snode =3D container_of(rb_node, struct sort_tree_node, rb_node);
> +		cand =3D bpf_kptr_xchg(&snode->req, NULL);
> +		if (!cand)
> +			break;
> +
> +		cand_start =3D cand->__sector;
> +		cand_end =3D cand_start + (cand->__data_len >> SECTOR_SHIFT);
> +
> +		if (end < cand_start) {
> +			rb_node =3D bpf_rbtree_left(tree, rb_node);
> +		} else if (start > cand_end) {
> +			rb_node =3D bpf_rbtree_right(tree, rb_node);
> +		} else if (cand_start =3D=3D end) {
> +			if (bpf_request_bio_try_merge(cand, bio, nr_segs)) {

The rbtree traversal here compares against cand->__sector. If a request was
previously front-merged, its __sector would be modified by the block layer.
Since the node isn't re-inserted to update its sorting key, could subsequent
traversals navigate down the wrong tree branches and corrupt the red-black
tree?

Additionally, the code holds a bpf_spin_lock while calling the kfunc
bpf_request_bio_try_merge().

Looking at bpf_request_bio_try_merge() in block/ufq-kfunc.c, it internally
acquires a spin_lock:

block/ufq-kfunc.c:bpf_request_bio_try_merge() {
    ...
	spin_lock(&ctx->lock);
	merged =3D blk_attempt_bio_merge(rq->q, rq, bio, nr_segs, true) =3D=3D BIO=
_MERGE_OK;
	spin_unlock(&ctx->lock);
    ...
}

Since bpf_spin_lock() maps to a raw_spinlock_t, and spin_lock() is sleepable
on PREEMPT_RT kernels, will this create a sleep-in-atomic context that
triggers a lockdep BUG and system panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503035623.2877=
1-1-kaitao.cheng@linux.dev?part=3D3
