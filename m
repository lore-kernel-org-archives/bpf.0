Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94C3E3159;
	Mon, 15 Jun 2026 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522653; cv=none; b=IzXsJ5pqlruwWppR00I5lHlf2Hunr16C9EqfhTld4jqW/xAj72hKWu9p6K1oMptFuZ5KalLlCzweuHsD/x9+ngNfSFcsVXLHd0OMYLl1s7OTfXsDXLaJ//ftssbZz/OrKWuFaaijdHWiH8hOkvI88p3J52ra5gXBxWnlDMbZZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522653; c=relaxed/simple;
	bh=uuq5o0ZRUS+maiSjFPKkUwLMP+cg8LRgXwKi26Xmf9U=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JGF5PU35tdT9vQsaT9ms5h5as4DGKNPgYQK0o6UgycmCIdHNb8otPOazdUaM7wwoFzcy2UUc78cfFSXa2Yk9Oa1VZEgXfOJ8wC/fh36vDvGbABXACsrVXyvFftGox/nQMuk+T50JkInyMmZlWUdfrQjwuUzlH4msglyjsMno/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSAwXqNt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSAwXqNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540EC1F00A3A;
	Mon, 15 Jun 2026 11:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522652;
	bh=dIrnmt09XC0Fq5tOSFEMlJg7yoIwkpTuL2Tj3+ck/kM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FSAwXqNtXSHgTDPRPZur6uNWRos/4GLkCxYt4y6Vu4hNPVl9sYFehfCMap/gYSVGD
	 HfEh3yrEyY2pUuXTd8I1QzJ1VaACKjPTtDVIt41Hye92M7rlHgYmkdDXNax4zibbS9
	 lBaK6Qsoiiw082uoI9aEoBa5nhxv9O95zeXUV4sSLZ6qfbdFNdhuEcUwEn+HMSFG1g
	 Q03WmdWSWt8ajqI/BOo71kxRhtjrB3opwCpVNPHsvLSIXTa/gcu1OzTB+vUlzWTi0b
	 PqqLa9LhvVsPIvFnELFqhrNfTxgSXsjNy1hEOpVuNZyv9wCtti7BWOl5SQsACv9oyn
	 uHqw43ImwoP5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for-next v3 3/9] mm/slab: handle the !allow_spin case in
 kfree_rcu_sheaf()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260615-kfree_rcu_nolock-v3-3-70a54f3775bb@kernel.org>
References: <20260615-kfree_rcu_nolock-v3-3-70a54f3775bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 11:24:11 +0000
Message-Id: <20260615112412.540EC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Kmemleak tracking symmetry violation for empty sheaves allocated w=
ith !allow_spin.

Pre-existing issues:
- [High] Deadlock under scheduler locks due to GFP_NOWAIT allocation in __k=
free_rcu_sheaf().
--

commit 0ddecba01f906bc55d1c11049f09813fcc05200e
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: handle the !allow_spin case in kfree_rcu_sheaf()

This commit updates kfree_rcu_sheaf() to handle cases where spinning is not
allowed, by allocating and freeing empty sheaves without taking locks. It a=
lso
modifies the allocation flags and fallback paths depending on the allow_spin
context.

> diff --git a/mm/slub.c b/mm/slub.c
> index 87ca154ccd80f..b0d38d5153865 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
[ ... ]
> @@ -2827,11 +2828,20 @@ static void free_empty_sheaf(struct kmem_cache *s=
, struct slab_sheaf *sheaf)
>  		mark_obj_codetag_empty(sheaf);
> =20
>  	VM_WARN_ON_ONCE(sheaf->size > 0);
> -	kfree(sheaf);
> +
> +	if (likely(allow_spin))
> +		kfree(sheaf);
> +	else
> +		kfree_nolock(sheaf);
> =20
>  	stat(s, SHEAF_FREE);
>  }
> =20
> +static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sh=
eaf)
> +{
> +	__free_empty_sheaf(s, sheaf, /* allow_spin =3D */ true);
> +}

[Severity: High]
Does hardcoding allow_spin to true here cause a kmemleak tracking symmetry
violation for sheaves allocated with allow_spin =3D false?

In __kfree_rcu_sheaf(), if allow_spin is false, the empty sheaf is allocated
using SLAB_ALLOC_TRYLOCK and gfp =3D 0. Because __GFP_RECLAIM bits are miss=
ing,
SLUB skips kmemleak registration for the object.

When this sheaf becomes full and is processed by RCU, rcu_free_sheaf() hand=
les
the cleanup and delegates to free_empty_sheaf(), which now unconditionally
calls kfree(sheaf) because allow_spin is hardcoded to true. Calling kfree()
on an object that wasn't registered with kmemleak triggers kmemleak warning=
s.

[ ... ]
> @@ -6112,20 +6122,25 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void=
 *obj)
> =20
>  		local_unlock(&s->cpu_sheaves->lock);
> =20
> -		empty =3D alloc_empty_sheaf(s, GFP_NOWAIT, SLAB_ALLOC_DEFAULT);
> +		if (unlikely(!allow_spin)) {
> +			alloc_flags =3D SLAB_ALLOC_TRYLOCK;
> +			gfp =3D 0;
> +		}
> +
> +		empty =3D alloc_empty_sheaf(s, gfp, alloc_flags);

[Severity: High]
This is a pre-existing issue, but does the use of GFP_NOWAIT when allow_spin
is true risk a deadlock?

Since GFP_NOWAIT contains the __GFP_KSWAPD_RECLAIM flag, the allocation can
trigger wakeup_kswapd(). This enters the scheduler and attempts to acquire
scheduler locks.

If kvfree_call_rcu() is invoked while a scheduler lock is already held,
wouldn't this cause a lock recursion deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-kfree_rcu_=
nolock-v3-0-70a54f3775bb@kernel.org?part=3D3
