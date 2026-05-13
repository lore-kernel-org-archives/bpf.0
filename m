Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4173D3302
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 06:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652142; cv=none; b=G3FC1dU3eF1ldPMfBslG5l70ffv+Kw4RZ7CAa6i+k2zhmsqqSi8KDwe4xjB/eImn7tebhKgp74EVVahKgvhP5dvvJJnlZo4eHEnOGzo/YHNYLHiuIvb2QQl5fPrYaMnvBY3inzAILFkgi9xp5af2qdSQj82E1JyBEX/B4F4/95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652142; c=relaxed/simple;
	bh=UmSmaoKtuz78Ylwf0KeDB+BkGUHZ2eSGbgLBuybcgWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JrZmLyLd3QJIqvsjfhckUekybcRZa/WOWTwSJv5WbP/0f2F9iSwkFYWKz6e1/Wvbk/rwW3rVd7gtZSov3Flm8ZivbabcB6zPB3NRwPHSJeg1/s73eFmLFBtKtZG5scNOqxabLqIgEDLreKORwc0WQRegdIeYDKSuvrXck+sXIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jccSD3Pq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jccSD3Pq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2C7C2BCB7;
	Wed, 13 May 2026 06:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778652142;
	bh=UmSmaoKtuz78Ylwf0KeDB+BkGUHZ2eSGbgLBuybcgWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jccSD3Pq1LuA6hnsY1/axe6ytb3ZN93Ft1sk92mPzugglv998Gr2g8xpiB4DjfRIA
	 n+Ab1ciADoGNugdwQujVLEOpSvn+gy/oB8e/iDgIU0TA3UWel0l5OR2TBDkSB4/HMg
	 KIhDcjhktP0vaVjn/4ArGeQ3dDpOb7FlMYjv7ZHrE1iSxWyPHUgCgEg9My2brYjqAw
	 vObOC9j4AFpCQPJrvnkCYg+bcyR/j3mtCACyEew/o2YiA9Cb0UtldiPJLiPetcfIFx
	 VKZuoDbcU5WbLMdfX2fp2ksf7t2Bg7RMdKa07RJI1GjCLB9VvS+7P2de5RPIK4RZfs
	 Hvgb9alVjQvfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND bpf-next v10 2/8] bpf: clear list node owner and
 unlink before drop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaitao cheng" <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260512055919.95716-3-kaitao.cheng@linux.dev>
References: <20260512055919.95716-3-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 06:02:21 +0000
Message-Id: <20260513060221.DB2C7C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Race condition causing list corruption, infinite loop, and Use=
-After-Free in `bpf_list_head_free`.
- [Critical] Incomplete fix leaving `bpf_rb_root_free` vulnerable to Use-Af=
ter-Free via dangling `owner` pointers.
- [High] Unbounded O(N) latency under IRQ-disabled spinlock in `bpf_list_he=
ad_free`.
--

commit 1bc93a76541e332d30d80430964ef29571e93654
Author: Kaitao Cheng <chengkaitao@kylinos.cn>

bpf: clear list node owner and unlink before drop

This commit updates bpf_list_head_free to clear the owner pointer of each
node and use a local drain list before dropping the objects, aiming to
prevent concurrent readers from seeing an invalid next node.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -2261,20 +2262,23 @@ void bpf_list_head_free(const struct btf_field *f=
ield, void *list_head,
>  	__bpf_spin_lock_irqsave(spin_lock);
>  	if (!head->next || list_empty(head))
>  		goto unlock;
> -	head =3D head->next;
> +	list_for_each_safe(pos, n, head) {
> +		WRITE_ONCE(container_of(pos,
> +			struct bpf_list_node_kern, list_head)->owner, NULL);
> +		list_move_tail(pos, &drain);
> +	}
>  unlock:

Does this introduce an unbounded delay with interrupts disabled?

The original code detached the head in O(1) time. Now there is an O(N)
loop inside __bpf_spin_lock_irqsave(). Since BPF lists can grow quite large,
could this cause soft lockups?=20

This also appears to contradict the comment just above the lock which
explicitly mentions doing the actual list draining outside the lock to not
hold it for too long.

> -	INIT_LIST_HEAD(orig_head);
> +	INIT_LIST_HEAD(head);
>  	__bpf_spin_unlock_irqrestore(spin_lock);
> =20
> -	while (head !=3D orig_head) {
> -		void *obj =3D head;
> -
> -		obj -=3D field->graph_root.node_offset;
> -		head =3D head->next;
> +	while (!list_empty(&drain)) {
> +		pos =3D drain.next;
> +		list_del_init(pos);

Can this lead to list corruption and an infinite loop?

By setting the node's owner to NULL in the previous loop under the lock,
the node appears unlinked to the BPF subsystem. Once the lock is released
at the unlock label, a concurrent BPF program holding a reference to this
node might successfully pass it to bpf_list_push_front() or similar,
since the ownership check will now succeed.

If that happens, list_add() will overwrite the node's next and prev
pointers. However, the local drain list header isn't updated. The
drain.next pointer will still point to this hijacked node, and
list_empty(&drain) will remain false forever, causing an infinite loop
that repeatedly unlinks and drops the exact same node.

[ ... ]

On a related note, does bpf_rb_root_free() suffer from a similar issue
regarding dangling owner pointers?

While not introduced by this patch, if a surviving RB node's original
bpf_rb_root memory is freed and then reallocated as another bpf_rb_root,
the node's owner pointer might falsely match the reallocated root.=20

A concurrent BPF program could then pass this node to bpf_rbtree_remove(),
bypassing the ownership check and accessing freed memory during
rb_erase_cached().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512055919.9571=
6-1-kaitao.cheng@linux.dev?part=3D2
