Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F93C2D
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780089622; cv=none; b=S1yzenYBYwYqo/x2pq137noG3vCsp1X2VycRIAaknMkI9KPZa1kw9CpTUshiJmsFRNvxsLN/R3TLs9k8NmParh1WykTmtHt928QLpxVzXTeRx9k4AZ7n9hikq8Qbo6x+rrLOqd0nh+uGd4HRHgwLfeEVdBdoLu0rwY3LXPu7SU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780089622; c=relaxed/simple;
	bh=AxXz5wceC6vw2SVs6+ribR6+QL/65iRE9LGh0YXjOso=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DI+OtYVfSqVqFSQTUfXfM+LE+uq4ldqvhEYPDXE85L2ZUzoGafE4bYF/Pw1Dyic6qyYGA0kZivJzyEC3OmxyGW6giiMY5fMVPkpBuP5cZIL/lRR4vYkx9S7wQT59W86uE7zjlSzvNPO7AeeCCoush3BsLImNQ1lPSJ96oLJEWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTS/WIDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTS/WIDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380AC1F00893;
	Fri, 29 May 2026 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780089621;
	bh=jMA69CsCA/4wLT0nz3m/KEByAQGLjsEm8J/w+KgFti8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTS/WIDY8LFUjB4ywVfr9PaRrdpU34KvZzvfGVU0fCnKF0RizPoA+HO4aW5bzaz+q
	 KER9Y4Qv/fadF46oqQVuQLWNjZnNStCdFrxOLJcjkNCpkq8dwqh28tpYypWUKq9GaU
	 2/eVqRLHdFsCKJZraRg1vO4R15+FP0LpxdaMamDqoO2llrE1+/CwQfXtEwZB7IgSdg
	 JAtDhwrfMOIC/zctABO/p10Q2DqPdo4GLdPVauOhyTciJOdY/k98ZI9e2ADVD4871x
	 48P9p0pDSoTY1E6QiRfocWUPn1i0XRYlRYwhlfxH3MICU4peGTiNWX6qgvp4rGLZC/
	 Lf5sA6Uwmkq9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/4] slab: Introduce kmem_cache_alloc_nolock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529202438.16408-2-alexei.starovoitov@gmail.com>
References: <20260529202438.16408-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 21:20:20 +0000
Message-Id: <20260529212021.380AC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Deadlock in NMI context due to synchronous freeing on memcg ch=
arging failure
--

commit 831b8a379d6dfbde2570286ba8453174bc236695
Author: Alexei Starovoitov <ast@kernel.org>

slab: Introduce kmem_cache_alloc_nolock()

This commit introduces kmem_cache_alloc_nolock_noprof() and its wrapper=20
kmem_cache_alloc_nolock(). It is designed to allocate an object from a
specific cache and aims to be safe to call from any context, including NMI
and IRQ-off environments.

> diff --git a/mm/slub.c b/mm/slub.c
> index a2bf3756ca7d0..601986aaebdfc 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
[ ... ]
> @@ -5402,6 +5402,45 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp=
_flags, int node)
>  }
>  EXPORT_SYMBOL_GPL(kmalloc_nolock_noprof);
> =20
> +/**
> + * kmem_cache_alloc_nolock - Allocate one object from a specific cache,
> + * safe from any context (including NMI/IRQ-off), like kmalloc_nolock().
> + *
> + * Returns NULL on failure (including the trylock paths that may transie=
ntly
> + * fail under contention).
> + */
> +void *kmem_cache_alloc_nolock_noprof(struct kmem_cache *s, gfp_t gfp_fla=
gs,
> +				     int node)
> +{
> +	gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
> +	void *ret;
> +
> +	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
> +				      __GFP_NO_OBJ_EXT));
[ ... ]
> +	maybe_wipe_obj_freeptr(s, ret);
> +	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
> +			     slab_want_init_on_alloc(alloc_gfp, s),
> +			     s->object_size);

[Severity: Critical]
Does this sequence risk a hard deadlock if called from NMI context?

The function permits __GFP_ACCOUNT, but if memory cgroup charging fails
inside memcg_slab_post_alloc_hook(), it synchronously aborts the allocation:

mm/slub.c:memcg_slab_post_alloc_hook() {
    ...
    if (memcg_alloc_charge_slab(s, alloc_gfp, lru, p, size)) {
        for (i =3D 0; i < size; i++)
            memcg_alloc_abort_single(s, p[i]);
    ...
}

This calls memcg_alloc_abort_single(), which immediately attempts to free
the object:

mm/slub.c:memcg_alloc_abort_single() {
    ...
    if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), false)))
        __slab_free(s, slab, object, object, 1, _RET_IP_);
    ...
}

Both slab_free_hook() (via kmemleak and kfence hooks) and __slab_free()
will attempt to acquire non-NMI-safe spinlocks like n->list_lock. If the
interrupted context was holding these locks, wouldn't this synchronous free
cause a deadlock, breaking the "safe from any context" guarantee?

> +	return kasan_kmalloc(s, ret, s->object_size, alloc_gfp);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529202438.1640=
8-1-alexei.starovoitov@gmail.com?part=3D1
