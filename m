Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEAB3750C4
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991199; cv=none; b=g3YprcyEVTlza4rnm/3myJ9gj/Ff8nI08k2XfiELV6Jks9B3iS/QZSq3NC5bnRgs9ZfBcDiy1/OBjmfdngtUZ+oZnty5hsaJSyAABaX9MAKlT0FB5fhcGe8i7Eq623pesl9WuFKiHxFS3ysww0bg6oDSVCMe/F9yvstQhP0b7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991199; c=relaxed/simple;
	bh=brj42HcIPVNDClQnLstiAcLBkBXKKA3y6FK+v7qC4Y0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ray83j1ElG/Xr4ZonE9yyqqCT6GLIeVsW6wlvczxiHsXUiu69UQAarWZQ6hltvBVawYW5gqhgrQ+uHjkmAq/jMJ87kXZAzpNVnKWzUzsB5OaozQSzozXxWrqQsWdMU6OOe2S0kbTIM3UMGrjqbWxr6n7Sr/fWzRe+zjlUbFFdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUaPVGwR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUaPVGwR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64461F0089C;
	Sat,  3 Oct 2026 01:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991197;
	bh=MORvDFs/Po9TUdSxA5B2cBOOoMQp4mdbpd8H84lPQ5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eUaPVGwRup+2kB2sOqPPwIgMT0Rf7qOHDB3YE/y6wvOr8JMHfFrwwI10/yvJ09dci
	 Kalfhd8set50mF093nbYC1LkgytGAEwUxmX+XsrNvBeYSs2lXj1tI+Jl0agpclgF7P
	 dFBb6+jIR9AeQj0/40v+DmLgGeb+rh0775l+0EMFe1PTuzbid4AcDZq0BaejznFfjt
	 yRj9Tt4H+yomar3vRRTC7h2bvbjw/UncIcoItsdH9Lu6I76MyT7YJOFtkTaQQQhDOb
	 kZ68VgZngJMLLl4kZH587ZYNitHHZSOvJHuMWGqu1C9UvXMv4isYo/FaS1apF58fGf
	 wRx6eLNy+vtOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v8 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
Reply-To: sashiko-reviews@lists.linux.dev
To: "T.J. Mercier" <tjmercier@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261002161738.621133-3-tjmercier@google.com>
References: <20261002161738.621133-1-tjmercier@google.com>
 <20261002161738.621133-3-tjmercier@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:17 +0000
Message-Id: <20261003013317.A64461F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: htab: lockless reader incorrectly matches recycled element fo=
r small keys
- [Medium] bpf: htab: missing memory barriers in lockless key publication
--

commit 835130c656673de5df7faec10778663616293463
Author: T.J. Mercier <tjmercier@google.com>

bpf: htab: Reduce elem_size by 8 bytes for small key sizes

This commit removes the cached 32-bit hash value from struct htab_elem for
hash maps with small key sizes, reducing the element size. It relies on a
single atomic compare for the key instead of the hash, and updates allocati=
on
and lookup paths to accommodate the omitted hash.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 4df6ae1fa722a..610e9051e373d 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -739,35 +789,60 @@ static inline struct hlist_nulls_head *select_bucke=
t(struct bpf_htab *htab, u32
>  	return &__select_bucket(htab, hash)->head;
>  }
> =20
> -/* this lookup function can only be called with bucket lock taken */
> -static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, =
u32 hash,
> -					 void *key, u32 key_size)
> +static __always_inline struct htab_elem *
> +__lookup_elem_raw(struct bpf_htab *htab, struct hlist_nulls_head *head,
> +		  u32 hash, void *key, u32 key_size,
> +		  struct hlist_nulls_node **out_n)
>  {
>  	struct hlist_nulls_node *n;
>  	struct htab_elem *l;
> =20
> -	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> -		if (l->hash =3D=3D hash && !memcmp(&l->key, key, key_size))
> -			return l;
> +	if (htab_has_hash(htab)) {
> +		hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> +			if (htab_elem_hash(l) =3D=3D hash &&
> +			    !memcmp(&l->key, key, key_size))
> +				return l;
> +	} else {
> +		/*
> +		 * When hash is omitted, key comparisons must be atomic. Zero extend
> +		 * the caller's key to the word size to support an atomic compare.
> +		 */
> +		unsigned long k =3D 0;
> +
> +		memcpy(&k, key, key_size);
> +		hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> +			if (READ_ONCE(*(unsigned long *)l->key) =3D=3D k)

[Severity: Medium]
Does this lockless key read require smp_load_acquire()?

On weakly ordered architectures, reading the key with READ_ONCE() could all=
ow
speculative execution to load the element's value before the key check is
fully resolved, potentially leading to reading a stale or uninitialized val=
ue.

[Severity: High]
Could a lockless RCU reader incorrectly match a recycled element here?

When an element is recycled in alloc_htab_elem() and it has a small key,
the old key remains visible until after the new value is initialized. A rea=
der
searching for the deleted old key could see it match here and incorrectly r=
ead
the newly inserted value (or a partially written value) instead of failing
the lookup.

> +				return l;
> +	}

[ ... ]

> @@ -1194,7 +1269,9 @@ static struct htab_elem *alloc_htab_elem(struct bpf=
_htab *htab, void *key,
>  		l_new =3D container + htab->elem_offset;
>  	}
> =20
> -	memcpy(l_new->key, key, key_size);
> +	if (htab_has_hash(htab))
> +		memcpy(l_new->key, key, key_size);
> +

[Severity: High]
Is there a race condition with lockless readers by not updating the key ear=
ly?

For maps with small keys, the element's key field retains its previous value
when recycled. As noted above, this leaves a window where a concurrent
lookup for the old key can falsely succeed while the new value is being set
up.

>  	if (percpu) {
>  		if (prealloc) {
>  			pptr =3D htab_elem_get_ptr(l_new, key_size);

[ ... ]

> @@ -1226,7 +1303,18 @@ static struct htab_elem *alloc_htab_elem(struct bp=
f_htab *htab, void *key,
>  		copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);
>  	}
> =20
> -	l_new->hash =3D hash;
> +	if (htab_has_hash(htab)) {
> +		htab_elem_set_hash(l_new, hash);
> +	} else {
> +		/*
> +		 * Zero-extend key into k for an atomic write to support
> +		 * lockless RCU readers.
> +		 */
> +		unsigned long k =3D 0;
> +
> +		memcpy(&k, key, key_size);
> +		WRITE_ONCE(*(unsigned long *)l_new->key, k);

[Severity: Medium]
Should this use smp_store_release() instead of WRITE_ONCE()?

Writing the key locklessly without smp_store_release() might allow the CPU
to reorder this write before the element's value is fully updated. A lockle=
ss
reader could then observe the new key but read an uninitialized or stale
value.

> +	}
>  	return l_new;
>  dec_count:
>  	dec_elem_count(htab);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002161738.6211=
33-1-tjmercier@google.com?part=3D2
