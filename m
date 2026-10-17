Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA5535AC0C;
	Sat, 17 Oct 2026 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202569; cv=none; b=nHEtkw0CGQPGJ99Rgxs+iDyMMqwJTU6Zx/wL6LO1cgg7tMrlp2b8Dbj4a1sHCnGB668XvySua2qf4fvd8hd0PHW7SQsyaZR66nbWnk9/vJGqkpAZcHxARYYuH+BvqTPa/kz6PiVbZEOemvU51+vdHps9wtK+Ln879iozc7V93BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202569; c=relaxed/simple;
	bh=sybnFe4dTdlTV3ojHQOJbxV3NWBCoOzfeAqN5qwqrFI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HwGCDInmq6D2ghOG6CQHqZb8Ld9UQW22I+VwFeU+e3wNo9o9hMAr2UeT3aYbm5EgcZnV/lsU5hMIZIl3yjjt7BAByV06fPMAu9DCtOqvHO0ziNVlUTbTacVVootPZupqp5yBEtRgF2PxiI17Kp5yRR4LIrDeFwQnFdy69wb/1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ1N9EFg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ1N9EFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523721F000C4;
	Sat, 17 Oct 2026 02:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202567;
	bh=22vIGT1gsGhrl96tCEJy/Hhx44CrK2sdH3n02xQ64YM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SZ1N9EFgZY3F0CoLKYzR5A6mTYK2YsinllX+oY5gFQil0qoyhXw4I/pWCPLzaYOaZ
	 D40I3lnyBqCb4BPvhAAiYHnU65+fL7pd89Ph6HtMbyaf/lOEyYn1Kmw2zIqXzXEdOl
	 TaBQpzuJ+VylkoS60XeJXzENxj0M7fC609HzYJ1hsaezs0bawobF/u+MZ9cTflP/Bz
	 JSvr8qLEWIYj8hKUQ2k/AFHqBfdu7hty8pK2le58pSJydW7sQ1yvKJOZkchN5OUbLH
	 pgwTkfLltNnFfXfAaN95U54on04HhnjUtkMyh8lY82VNJij5MX73FVUNlKVQooOIeQ
	 E2AUqT8WIUa4A==
Content-Type: multipart/mixed; boundary="===============6554122423929033199=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d48ced398b4fe0e5a849fccbc303c03f3508ef50c75bf7fbebc2326b2b51bc42@mail.kernel.org>
In-Reply-To: <20261017012451.364800-8-alexei.starovoitov@gmail.com>
References: <20261017012451.364800-8-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 16/38] bpf: Hold the socket in the sk_storage map iterator
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 02:02:46 +0000 (UTC)

--===============6554122423929033199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Hold the socket in the sk_storage map iterator

TL;DR: The sk_storage iterator's new owner check may not hold for a storage
that lost the publish race in bpf_local_storage_alloc(), so it could take a
reference on a freed socket (use-after-free). The window is narrow.

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c

[ ... ]

> @@ -796,12 +826,44 @@ DEFINE_BPF_ITER_FUNC(bpf_sk_storage_map, struct bpf_iter_meta *meta,
>  		     struct bpf_map *map, struct sock *sk,
>  		     void *value)
>
> +/*
> + * Take a reference on the socket which owns @selem. RCU keeps the element, not
> + * its owner. As long as the element is linked under the lock of the storage,
> + * the owner has not got past bpf_sk_storage_free(), unless that has given up
> + * on the lock. Then it still waits for owner_refcnt.
> + */
> +static struct sock *
> +bpf_sk_storage_selem_get_sk(struct bpf_local_storage_elem *selem)
> +{
> +	struct bpf_local_storage *sk_storage;
> +	struct sock *sk = NULL;
> +	unsigned long flags;
> +
> +	sk_storage = rcu_dereference(selem->local_storage);
> +	/* reset since ->next() looked: the socket goes away */
> +	if (!sk_storage)
> +		return NULL;
> +
> +	if (raw_res_spin_lock_irqsave(&sk_storage->lock, flags))
> +		return NULL;
> +
> +	if (!hlist_unhashed(&selem->snode) &&
> +	    refcount_inc_not_zero(&sk_storage->owner_refcnt)) {
> +		sk = sk_storage->owner;
                  ^^^^

Does the invariant in the comment above hold for every storage that can be
reached from a bucket list?

"As long as the element is linked under the lock of the storage, the owner
has not got past bpf_sk_storage_free()" is true for the storage published
in sk->sk_bpf_storage, since that is the only storage
bpf_local_storage_destroy() runs on and waits for.

It does not seem to hold for a storage that lost the publish race in
bpf_local_storage_alloc():

kernel/bpf/bpf_local_storage.c:bpf_local_storage_alloc() {
    ...
	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
	if (unlikely(prev_storage)) {
		bpf_selem_unlink_map_nolock(first_selem);
		raw_res_spin_unlock_irqrestore(&b->lock, flags);
		err = -EAGAIN;
		goto uncharge;
	}
    ...
}

bpf_selem_link_map_nolock() has already put first_selem at the head of the
bucket list, so an RCU reader can see it.  On failure the element is
unlinked from the map only.  It stays on storage->list, so snode is still
hashed, first_selem->local_storage still points at the storage,
storage->owner is the socket, and owner_refcnt stays at 1.  Both are then
freed through kfree_rcu().

Consider this sequence.

CPU0 and CPU1 each create the first storage of the same socket at the same
time (bpf_sk_storage_get() with BPF_SK_STORAGE_GET_F_CREATE, or a map
update, for the same map or for two different maps).  CPU0 loses the
cmpxchg.

CPU2 is reading the iterator.  Under rcu_read_lock(),
bpf_sk_storage_map_seq_find_next() reads b->list while CPU0's element E is
linked there, sees E->local_storage != NULL and returns E.  CPU2 is then
delayed before ->show(), for example by preemption under
CONFIG_PREEMPT_RCU.

The socket is closed:

sock_put()
  sk_free()
    __sk_destruct()
      bpf_sk_storage_free()
        /* destroys only the winning storage, never waits on the losing
           storage's owner_refcnt */
    sk_prot_free()
      /* for AF_UNIX or AF_PACKET this is an immediate kmem_cache_free(),
         and the open RCU read section does not delay it */

CPU2 then runs bpf_sk_storage_selem_get_sk(E):

    if (!hlist_unhashed(&selem->snode) &&
        refcount_inc_not_zero(&sk_storage->owner_refcnt)) {
        sk = sk_storage->owner;
        if (!refcount_inc_not_zero(&sk->sk_refcnt))

The losing storage is still RCU-valid, so the lock is taken.
hlist_unhashed(&E->snode) is false, and refcount_inc_not_zero() on
owner_refcnt goes from 1 to 2.  sk is the freed socket, and
refcount_inc_not_zero(&sk->sk_refcnt) operates on freed memory.

If it succeeds, the program runs on the freed socket, and
bpf_sk_storage_map_seq_put_sk() later calls refcount_dec_and_test() on it
and may queue it for sk_free().  For TCP (SLAB_TYPESAFE_BY_RCU), the
iterator can instead take a reference on an unrelated socket that has
reused the object.

This window was already there before the patch, since the old code passed
storage->owner to the program without any check.  It is also narrow, since
E is in the bucket only for a few instructions under b->lock.  But the new
check is meant to make ctx->sk safe, and the iterator now also writes to
the stale owner itself.

Does bpf_local_storage_alloc() need to make the losing storage look dead
before it is freed, for example by dropping its owner_refcnt (or unlinking
first_selem->snode) under storage->lock in the cmpxchg failure path, so that
the iterator's check holds for every storage?

> +		if (!refcount_inc_not_zero(&sk->sk_refcnt))
> +			sk = NULL;
> +		bpf_local_storage_unpin_owner(sk_storage);
> +	}
> +	raw_res_spin_unlock_irqrestore(&sk_storage->lock, flags);
> +
> +	return sk;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38991548713
--===============6554122423929033199==--
