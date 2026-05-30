Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8826461F
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780107629; cv=none; b=QU1cvHGhXBTk/6LxUAQzX+d60/O5hY+L+IchsPTX1bbT23UjSSi/EuyeanX5omQsg1U4MdtcePt1/mtwVwDpsusGHm4m1YOMXp2ndqGP5pMnye6EuLT4ho1st0IeyCd6/lN1jzt2AiLi7a502PGJTEnZGRDaU+/lZBO92wnCfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780107629; c=relaxed/simple;
	bh=7f8yTOr4RvgU8nEpQ9deau9JY7rpGUQMpMh/iDk8e7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R1iDsYi0HPN14c6kg8iq4ORzOwoF86CcW5DD+0zg3zMkaW2drY0ICppIvROu9AW6XvanW02nH94K3GXOuMxNEFV6LPbG3qFEkKWarR36vOcfobRKa9cCqurw8EyPJABXCXfDAC6ldDQ6Se0zEaD78DxT9Y0AeOVv0d3INB3Z2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSQDZSZl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSQDZSZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035F51F00893;
	Sat, 30 May 2026 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780107628;
	bh=F1J7lwxXHTU1tnbJ6AeSSBEBD+FvK+Iy8VAsCH/EMpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MSQDZSZlujr21rJuAzGCG4Z9HJqdvDiTv+Kw6dqyHc6NzBqoDnR8W8OMvYSjcbRey
	 VciRsq5590FhiblIShp/JbIL0pD6XvGRpdjspIayQy4xRwlVuv/q/nyVfkDjJe883w
	 kep2YJOagXvIgSBnGobKvnNM+xbfVIFJWebbeeN9z4Pxmq+tzR77cq/Ro5ivDIay7c
	 qfUi14euTheVUjnz1U6qVkFCjvFnKOqFRw+uCVR/kt3vvc3dcR6HbRd+D/8pdythLE
	 gA0nvDeB/Db1bi5m76MNwWO9qYNsfo3+D/JDF1ES49GdZgrZa5HX7SAt0dRuYA9XkR
	 DRsJsvyEKN+wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 1/4] slab: Introduce
 kmem_cache_alloc_arena_nolock and kfree_arena_nolock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260530011345.99342-2-alexei.starovoitov@gmail.com>
References: <20260530011345.99342-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 02:20:26 +0000
Message-Id: <20260530022028.035F51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Kernel pointer leak to BPF/userspace due to conditional freepointe=
r wiping in `kmem_cache_alloc_arena_nolock()`.
--

commit d9990271e84caa61cda831febfd0b2585498ef51
Author: Alexei Starovoitov <ast@kernel.org>

slab: Introduce kmem_cache_alloc_arena_nolock and kfree_arena_nolock

This commit adds nolock slub helpers tailored for SLAB_BPF_ARENA caches.
The helpers skip KASAN slab hooks so that BPF arena misuse is handled
entirely by the BPF kfunc boundary instead of surfacing as KASAN splats.

> diff --git a/mm/slub.c b/mm/slub.c
> --- a/mm/slub.c
> +++ b/mm/slub.c

[ ... ]

> +void *kmem_cache_alloc_arena_nolock(struct kmem_cache *s, int node)
> +{
> +	gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC;
> +	void *ret;
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
> +		return NULL;
> +	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
> +		return NULL;
> +
> +	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
> +		return NULL;
> +
> +	ret =3D alloc_from_pcs(s, alloc_gfp, node);
> +	if (!ret)
> +		ret =3D __slab_alloc_node(s, alloc_gfp, node, _RET_IP_,
> +					s->object_size);
> +	if (!ret)
> +		return NULL;
> +
> +	maybe_wipe_obj_freeptr(s, ret);

[Severity: High]
Does this leave the kernel freepointer intact and leak it to BPF programs or
userspace?

Looking at maybe_wipe_obj_freeptr():

static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
						   void *obj)
{
	if (unlikely(slab_want_init_on_free(s)) && obj &&
	    !freeptr_outside_object(s))
		memset((void *)((char *)kasan_reset_tag(obj) + s->offset),
			0, sizeof(void *));
}

The memset conditionally depends on slab_want_init_on_free(s). In the
default configuration where init_on_free=3D0, the freepointer wipe is
skipped.

Since slab_post_alloc_hook() is also deliberately omitted from this path,
the newly allocated object is returned with the direct-map kernel virtual
address of the next free object fully intact. Because arena memory is
directly accessible, an attacker might be able to read this kernel pointer,
potentially bypassing KASLR.

> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kmem_cache_alloc_arena_nolock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530011345.9934=
2-1-alexei.starovoitov@gmail.com?part=3D1
