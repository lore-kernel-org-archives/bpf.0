Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45977368D41;
	Tue, 12 May 2026 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568079; cv=none; b=iLkoMwvaxvSQG4ZfvTHkj4fmGPbWUb6U6IBkU9SgZJec61u824n36BFMD7UNWWByRsxVrdIh0739/Kq5ViHptTOh4Iqp65yfQGbIM654W2DwbVTNxKrnyENSn7PseYjULgPC2FKAt3FM3mVOY0pr1RBvtvPrFjT87T5Dwa7dblI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568079; c=relaxed/simple;
	bh=ZuDv4r0ie1WZV2Dhw0Lb/+DCLO8tCoNK9DuJRUUG7nk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CMhktLwtOf4iEhMeky37MW2ChUJ4AgikvV2HXKm7145JBUccOFvX/aj7F/i/bT7ugr7Bigt860P3XOahg0MNOru9Dh6fg5bVpx7i7rsnmMuYixolYGpccjlfO6l/gLDELuRdaB2zAyxdlACx+CUQpxq1K1IIhZ5lnPcjNMGg3SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbLlDbjZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbLlDbjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E235C2BCF7;
	Tue, 12 May 2026 06:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778568072;
	bh=ZuDv4r0ie1WZV2Dhw0Lb/+DCLO8tCoNK9DuJRUUG7nk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MbLlDbjZ10ZcHmnXxFTYie/q/LOPN9UGbhIDdcIrqmonHCj/wzQzq6maKuPfdeVO4
	 v0XL5y96bO5tPFjk36t0RQE/XjmwqqFXVbnZQ2AJ2nkwm4+7QR7gvEzELD+oUlgGLR
	 tyj+6fm7GB9pqTWIBN5t7P1cZAS8z82qVlvJEU1Cqxck8QAey2GZpuFAI52JzoksV8
	 5sz1Gnl+y8uIyjmUAXzG3NlVKxH92DKG1RWTQXwpzdyXmdQIyM16BdBWz6Q0fh5dLb
	 S1Yz6Wk7CLtXUGsaRLdno0xkbnZPUQZFrIQ6ktLCEPz1qwgqw5ALwT2K7rXDVrV+D0
	 XddoJLEeBSaRw==
Content-Type: multipart/mixed; boundary="===============7455212074267761916=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da95f45b43d94d17796b19abc4c555e35daafab7d5e1cdca3714fe0f54ab8cce@mail.kernel.org>
In-Reply-To: <20260512055919.95716-3-kaitao.cheng@linux.dev>
References: <20260512055919.95716-3-kaitao.cheng@linux.dev>
Subject: Re: [PATCH RESEND bpf-next v10 2/8] bpf: clear list node owner and unlink before drop
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,ast@kernel.org,corbet@lwn.net,martin.lau@linux.dev,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,skhan@linuxfoundation.org,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-doc@vger.kernel.org,vmalik@redhat.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 12 May 2026 06:41:10 +0000 (UTC)

--===============7455212074267761916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9cd7b028592c..1e8754877dd1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2247,10 +2247,11 @@ EXPORT_SYMBOL_GPL(bpf_base_func_proto);
>  void bpf_list_head_free(const struct btf_field *field, void *list_head,
>  			struct bpf_spin_lock *spin_lock)
>  {
> -	struct list_head *head = list_head, *orig_head = list_head;
> +	struct list_head *head = list_head, drain, *pos, *n;
>
>  	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct bpf_list_head));
>  	BUILD_BUG_ON(__alignof__(struct list_head) > __alignof__(struct bpf_list_head));
> +	INIT_LIST_HEAD(&drain);
>
>  	/* Do the actual list draining outside the lock to not hold the lock for
>  	 * too long, and also prevent deadlocks if tracing programs end up
> @@ -2261,20 +2262,23 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
>  	__bpf_spin_lock_irqsave(spin_lock);
>  	if (!head->next || list_empty(head))
>  		goto unlock;
> -	head = head->next;
> +	list_for_each_safe(pos, n, head) {
> +		WRITE_ONCE(container_of(pos,
> +			struct bpf_list_node_kern, list_head)->owner, NULL);
> +		list_move_tail(pos, &drain);
> +	}
>  unlock:
> -	INIT_LIST_HEAD(orig_head);
> +	INIT_LIST_HEAD(head);
>  	__bpf_spin_unlock_irqrestore(spin_lock);
>
> -	while (head != orig_head) {
> -		void *obj = head;
> -
> -		obj -= field->graph_root.node_offset;
> -		head = head->next;
> +	while (!list_empty(&drain)) {
> +		pos = drain.next;
> +		list_del_init(pos);

Does this create a race condition when a BPF program holds a
refcount-acquired reference to a node being freed?

The patch clears each node's owner to NULL under spin_lock, moves the
node to a local 'drain' list, then drops the lock. After unlock, the
drain loop walks the local list and calls list_del_init(pos) before
__bpf_obj_drop_impl().

Between spin_unlock and list_del_init(pos), each node in 'drain' has
owner == NULL AND is still linked in 'drain'.

When a BPF program holds an owning or refcount-acquired reference to
one of these nodes (node X), which is structurally supported because
__bpf_obj_drop_impl() uses refcount_dec_and_test() and only frees at
refcount 0, a concurrent push to a DIFFERENT bpf_list_head becomes a
corruption:

CPU 0 (bpf_list_head_free, lock released)  CPU 1 (BPF prog, refcount X)
-----------------------------------------   ----------------------------
(owner of X == NULL, X linked in drain)
                                            bpf_list_push_back(other, X)
                                              __bpf_list_add: spin_lock()
                                              cmpxchg(X->owner, NULL,
                                                      POISON) -> OK
                                              list_add_tail(&X->list_head,
                                                            other_head)
                                                -> overwrites X->next,
                                                   X->prev, corrupts
                                                   other_head's chain
                                                   because X is still
                                                   stitched into drain
pos = drain.next;      (may be X or neighbor using X's stale next)
list_del_init(pos);    reads X->next/prev now pointing into other_head,
                       corrupts other_head's list and/or drain

Pre-patch, the owner pointer was left pointing at the old head (never
cleared). Any concurrent push attempt cmpxchg(&node->owner, NULL,
POISON) would fail and return -EINVAL, blocking re-insertion. This
matches what bpf_rb_root_free() still does: it does NOT clear owner, so
concurrent bpf_rbtree_add() cmpxchg fails.

The patch clears owner under the lock but still links the node into the
unprotected local drain list, then drops the lock. The owner==NULL
state now acts as a 'push is allowed' signal even though the node is
still on a list, violating the invariant __bpf_list_add() relies on:

kernel/bpf/helpers.c:__bpf_list_add() {
    /* node->owner != NULL implies !list_empty(n), no need to separately
     * check the latter
     */
    if (cmpxchg(&node->owner, NULL, BPF_PTR_POISON)) {
            __bpf_obj_drop_impl((void *)n - off, rec, false);
            return -EINVAL;
    }

    tail ? list_add_tail(n, h) : list_add(n, h);
    WRITE_ONCE(node->owner, head);
}

Compounding this, 'drain' is a local stack variable: corruption can
redirect list pointers into kernel stack memory of the freeing CPU,
giving an unbounded list_add/list_del_init corruption vector.

Could you do list_del_init(pos) under spin_lock in the same critical
section that clears owner? Swapping the order (list_del_init then
WRITE_ONCE(owner, NULL), like __bpf_list_del() does), or leaving owner
non-NULL like bpf_rb_root_free does so cmpxchg in concurrent push still
fails?

The commit message's stated goal ('preventing subsequent users who hold
a reference count to the node from acquiring an invalid next node') is
only achievable if the delinking is done before unlock, not after.

>  		/* The contained type can also have resources, including a
>  		 * bpf_list_head which needs to be freed.
>  		 */
> -		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
> +		__bpf_obj_drop_impl((char *)pos - field->graph_root.node_offset,
> +				    field->graph_root.value_rec, false);
>  	}
>  }

bot+bpf-ci@kernel.org raised a concern in v9 about whether this patch
should include a Fixes tag. The CI bot suggested:

  Fixes: f0c5941ff5b2 ("bpf: Support bpf_list_head in map values")

since the concurrent reader issue was introduced when bpf_list_head
support was added. The author responded in v10 that the issue only
appears after the later patch 'bpf: Introduce the bpf_list_del kfunc' is
merged, so no Fixes tag was added.

However, the reasoning suggests the Fixes tag should point to the
bpf_list_del introduction rather than f0c5941ff5b2, and a Fixes tag may
still be appropriate. Should this include a Fixes tag pointing to the
commit that introduced bpf_list_del?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25716874656
--===============7455212074267761916==--
