Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD33ACA48;
	Mon, 15 Jun 2026 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522571; cv=none; b=Sd52zdwYHlvdMKV809wBs0IlBjtfTU7eJE6WIg6ct9xwN8CvztS7LMIA3nEp9+kJRcGKnhZUzWE3gk+1rqgJgkLbGN2ZYkcjkFZha0A+F+LDZGobQyO3Pibf4jRTON4WiEjNto3saR/yLuFytU1f0e6HEGu6n/K3p8Txnk33dIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522571; c=relaxed/simple;
	bh=+NrEq/l2/28IBrjdw+rAX9sdcMr8OMQ43T3M+pK8nAY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oS+lBxPyT2unTizDbeXEgkxPtjGPnPOVpNYFQ9BhlGDn4dUI/VBnRXINMkFiybytDtG7garuz3KIxA3S0bgW4VqhFJMRQNd3MVyAVx5u8TOfBy1D7V3ITjMz9WmYSryLoVz7OvDjWRAvFXD0pUYUFVoPXzBMZv36bW4v1Eo7bVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZdsT0Uc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZdsT0Uc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34C91F000E9;
	Mon, 15 Jun 2026 11:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522569;
	bh=MKjZPpI7jDOJVtAc79LU1XoCkUKFxRdvNUaZMtO5sQI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SZdsT0UcIIjp9WS7/4HSe1PIODPi4kia3SlIXzAvAUZWd3Muj8yUQRbdJkHHwci8+
	 3Co5vSeXg/NNKIoYZmoLnkSi+HQWqZddVxC5lnJFj2GwXTtR7g+2ZpjBOpfpvDxfcr
	 yWwvPiNh7jk7JGSeDVs1o4UtzC26X88pcZhjhA/HiiLXgGtrgdKoGNJBLdrRQEE4nN
	 hzxLxWA/IMuxH19N9/lukz224vGhcn1zalcYRrxgq00D6EaefHPb3koLyw5GDYv5Rh
	 e5eMrit6WQkh41n4tdF15143Bwhb1tuaDHnjakgpV/6oIjIbS9VA/8I/e4Ss9i7WDz
	 xRswqsEpUtQbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for-next v3 7/9] mm/slab: introduce kfree_rcu_nolock()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260615-kfree_rcu_nolock-v3-7-70a54f3775bb@kernel.org>
References: <20260615-kfree_rcu_nolock-v3-7-70a54f3775bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 11:22:49 +0000
Message-Id: <20260615112249.B34C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] kfree_call_rcu_nolock() crashes when freeing large kmalloc obj=
ects or vmalloc addresses due to an unconditional dereference of `slab->sla=
b_cache`.
- [High] Calling `__kfree_rcu_sheaf()` on PREEMPT_RT triggers an 'Invalid w=
ait context' lockdep warning because it attempts a `local_trylock()` under =
a `raw_spinlock_t`.
--

commit 8bccb182210df2707b079473bfa04aa463cafa86
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: introduce kfree_rcu_nolock()

This commit introduces kfree_rcu_nolock(), a variant of kfree_rcu() designed
to be safely called from unknown contexts without falling back to batched
processing. It primarily tries to use the sheaf path and falls back to
defer_kfree_rcu() if that fails.

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 807924a94fb08..5a39e62251609 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1263,6 +1263,23 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
>  EXPORT_TRACEPOINT_SYMBOL(kfree);
>  EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
> =20
> +void kfree_call_rcu_nolock(struct rcu_head *head, void *ptr)
> +{
> +	struct slab *slab;
> +	struct kmem_cache *s;
> +
> +	VM_WARN_ON_ONCE(is_vmalloc_addr(ptr) || !virt_to_slab(ptr));
> +
> +	slab =3D virt_to_slab(ptr);
> +	s =3D slab->slab_cache;

[Severity: Critical]
Does this crash when freeing large kmalloc objects or vmalloc addresses?

If ptr is a large kmalloc object (which bypasses SLUB) or a vmalloc address,
virt_to_slab(ptr) returns NULL. The code issues a VM_WARN_ON_ONCE but
proceeds to blindly dereference slab->slab_cache, causing a deterministic
NULL pointer dereference.

Standard kfree_rcu() and kvfree_rcu() support these types of addresses, so
callers might pass them here expecting them to be handled safely. Should we
return early or handle the fallback path directly if slab is NULL?

> +
> +	if (__kfree_rcu_sheaf(s, ptr, /* allow_spin =3D */ false))
> +		return;

[Severity: High]
Can this trigger an 'Invalid wait context' lockdep warning on PREEMPT_RT?

The purpose of kfree_call_rcu_nolock() is to handle unknown contexts,
including hardirq or raw spinlock contexts. However, this unconditionally
calls __kfree_rcu_sheaf(), which acquires a lock via
local_trylock(&s->cpu_sheaves->lock).

On PREEMPT_RT, local_lock maps to a sleepable spinlock_t (RT mutex).
Acquiring a sleepable lock inside a raw spinlock context causes a lockdep
splat because CONFIG_PROVE_RAW_LOCK_NESTING checks declared wait-types even
for trylocks.

> +
> +	defer_kfree_rcu(head);
> +}
> +EXPORT_SYMBOL_GPL(kfree_call_rcu_nolock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-kfree_rcu_=
nolock-v3-0-70a54f3775bb@kernel.org?part=3D7
