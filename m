Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D252E7384;
	Wed, 29 Jul 2026 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314495; cv=none; b=MPXH1zDaWFICUOKGzNt3o27kTN9OAPXDUN5WlmO08xCK51Qvcid6YmdPOSXiOwJsDrKHZIcba+eV4lL1A1iXPh4qpBUV5Kn1MOIjMFtBuqCRO1/UW8iY6HWKVbWWw6nw0PqO0kl6PBufqtYJ+X+JvHxGXSIipOUHPhX9TtyhUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314495; c=relaxed/simple;
	bh=u2SOOZvwVMrPZ3k9V5rHN4gsDxjj/rWB1OfN5CEMOTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gANj8XAaAaVF8zjgLFILVvdv1EaJKUKZHP+WA5WGgsJSXqH0SgwPVPral2abXu4HB/6gy5L9sBgx/Tw1Q4nujNV/lQiYrJyGwuaHZclkrmKWYvrZE22XZ0BHiDbCvxMZUy9K6PAz7pkRi7M9jrFlvMSBdTi+EbazGUrzQRZe78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp658xD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp658xD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868411F000E9;
	Wed, 29 Jul 2026 08:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314493;
	bh=fM8KWGCe4ezTPDWrSrEkw6QIV9Ar9my1ZoqpBIbe9Vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kp658xD8jehoI+ZOpKsSFs3mXxr8DKx4RngMSz8w0HzIewyY1b5RsLQWTcWA06L9p
	 OAqjy6hvP9G1Gbevhj2BTW45h8KdT59gZNS7y7LfKC19yVB3woeZVT6Wa4o82saLdT
	 rmNAQgy6pq6CHRo5B0ZRB/CXjhfmOzfwfMOOF2ix8W6vd7m53Nh5qrz4u3Z/+ZhJHz
	 EIdn/eCHmmXj6Obru2SDYt4mzHGAY7h2YHU1z6j5RDi2ZU4AQ/xcqEfxUHof+MRtIn
	 7L1Kh4F56JyUfHkm4t08ADpTj6F8SMayCHSJTxf5pwztRR3/AI58okw9fc6ezlAKxa
	 Ug6zyPdJYkozw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/8] mm/slab: introduce kfree_rcu_nolock()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChPcmFjbGUp?= <harry@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260729-kfree_rcu_nolock-v5-7-a28cdcda9673@kernel.org>
References: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
 <20260729-kfree_rcu_nolock-v5-7-a28cdcda9673@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:41:33 +0000
Message-Id: <20260729084133.868411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `kfree_rcu_nolock()` and `kvfree_call_rcu()` invoke `__kfree_rcu_s=
heaf()`, which acquires a `local_trylock()`. This triggers lockdep 'Invalid=
 wait context' warnings and can cause deadlocks on PREEMPT_RT.
- [Medium] Missing `kasan_record_aux_stack()` in the `fallback` path of `kf=
ree_call_rcu_nolock()` loses the original free stack trace.
- [Low] Missing struct pointer cast in the `kfree_rcu_nolock()` macro cause=
s incompatible pointer type compilation errors when `CONFIG_KVFREE_RCU_BATC=
HED` is enabled.
--

--- Patch [7]: [PATCH v5 7/8] mm/slab: introduce kfree_rcu_nolock() ---
commit 34c7828edcaca9e66aa219ee881130dc05e9102d
Author: Harry Yoo (Oracle) <harry@kernel.org>
Subject: mm/slab: introduce kfree_rcu_nolock()

The commit introduces kfree_rcu_nolock() to handle freeing objects in unkno=
wn
contexts without deferred processing when possible. It relies on
__kfree_rcu_sheaf() for the fast path and falls back to defer_kfree_rcu()
which uses an irq_work.

> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1124,6 +1125,27 @@ do {								\
>  		kvfree_call_rcu(NULL, (void *) (___p));		\
>  } while (0)
> =20
> +/**
> + * kfree_rcu_nolock() - a version of kfree_rcu() that can be called in a=
ny context.
> + * @ptr: pointer to kfree for double-argument invocations.
> + * @kvrhf: the name of the struct kvfree_rcu_head within the type of @pt=
r.
> + *
> + * With KVFREE_RCU_BATCHED, kfree_rcu_nolock() tries hard to free objects
> + * without any deferred processing, but may still defer freeing.
> + * Large kmalloc and vmalloc objects are always deferred.
> + *
> + * kfree_rcu_nolock() supports 2-arg variant only.
> + */
> +#define kfree_rcu_nolock(ptr, kvrhf)						\
> +do {										\
> +	typeof (ptr) ___p =3D (ptr);						\
> +										\
> +	if (___p) {								\
> +		BUILD_BUG_ON(offsetof(typeof(*(ptr)), kvrhf) >=3D 4096);		\
> +		kfree_call_rcu_nolock(&((___p)->kvrhf), (void *) (___p));	\

[Severity: Low]
Is a cast to (struct kvfree_rcu_head *) needed here?=20

Because the caller typically embeds struct rcu_head, passing the member
address directly to kfree_call_rcu_nolock() results in an incompatible poin=
ter
type compilation error when CONFIG_KVFREE_RCU_BATCHED is enabled.

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1296,6 +1296,33 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
>  EXPORT_TRACEPOINT_SYMBOL(kfree);
>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
> =20
> +void kfree_call_rcu_nolock(struct kvfree_rcu_head *head, void *ptr)
> +{
> +	struct slab *slab;
> +
> +	if (!IS_ENABLED(CONFIG_KVFREE_RCU_BATCHED))
> +		goto fallback;
> +
> +	if (unlikely(is_vmalloc_addr(ptr)))
> +		goto fallback;
> +
> +	slab =3D virt_to_slab(ptr);
> +	if (unlikely(!slab))
> +		goto fallback;
> +
> +	if (unlikely(IS_ENABLED(CONFIG_NUMA) && slab_nid(slab) !=3D numa_mem_id=
()))
> +		goto fallback;
> +
> +	if (unlikely(!__kfree_rcu_sheaf(slab->slab_cache, ptr, SLAB_FREE_NOLOCK=
)))

[Severity: High]
Could calling __kfree_rcu_sheaf() here violate the unknown context
requirement?

When kfree_rcu_nolock() or kvfree_call_rcu() are called in a hardirq or NMI
context, the fastpath unconditionally executes local_trylock() inside
__kfree_rcu_sheaf():

mm/slub.c:__kfree_rcu_sheaf() {
    ...
	if (!local_trylock(&s->cpu_sheaves->lock))
		goto fail;
    ...
}

Because a local_lock on PREEMPT_RT is a sleeping lock, acquiring it under
a raw spinlock triggers lockdep "Invalid wait context" warnings, and if
called from NMI context on PREEMPT_RT, it can unconditionally deadlock.

> +		goto fallback;
> +
> +	return;
> +
> +fallback:
> +	defer_kfree_rcu(head);

[Severity: Medium]
Will this lose the original free stack trace if KASAN is enabled?

When the fastpath fails and execution jumps to fallback, the object is defe=
rred
to an irq_work without calling kasan_record_aux_stack(). Later, when
kvfree_call_rcu() is finally invoked in the irq_work context, it will
record the worker's stack trace instead of the original caller that
requested the free, making KASAN Use-After-Free reports harder to debug.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-kfree_rcu_=
nolock-v5-0-a28cdcda9673@kernel.org?part=3D7
