Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDBB23ED60
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608714; cv=none; b=cJyFV7Z8F5588gT0aSlok+N+VlsNpJ7K6LkAlJHc7zreDaM6leCaRjEy85OV/9imbTUUSmp73mOIUI6C3xyseukH6y910di+0VudySurVqtRNWQmBYk3acrpNoILjOcjuVLeTUWFmsTjjW8HGFYzKJGs0QmsBoDww5tOfyJ1ZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608714; c=relaxed/simple;
	bh=BHTb0CxAyCLsUh8tVkQo9VvrupxxwEhwE3YPV8w6Rmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XNM6p7QsFSJmCnn/4UjgueYczr8tr/yWF9zjN/a8Wkopff3FK/Dy+6BvI1xrLhlK6LTboNiFwpsARDiBUt3XNls5YHsvk+5xGkgnE2J5H6QmTKPgyz4qGIpL5L0sqfkGdSN2SBkIwIrGjJExyL2RE7+uuw8J3F6gWGX3XC4vULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxB5VmIg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxB5VmIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C8F1F000FF;
	Mon, 28 Sep 2026 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790608713;
	bh=u9TmZJ2LdjC0z5UEXE7/ZSDaQc7QVdzW5b2etpdVLp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WxB5VmIg6gvC5Fl2UcklB8wPZX8X6SQhiGbK/AttICZvEcrRL67TbOgOcR1fcB3Ol
	 Oat5laBLqB1fqLcSaA10XeYPN+YPGuGWaqliOmJjNfdY0tGtqxpU1pDCeZ6xw6p8gh
	 P0YadumjF7hVj7ojP0wqvYckoVUkKKnn8wp+cbrdadolPH4KoFkNY4vXbR7W0liDv7
	 KVY2Fz71TDWt8QADvEtXs8Bo0TYwoQt2cmU/mY90Kpy2hm/jRYL+3UYxJxUxU5KThk
	 HvRzPguG5GTMf5UNP/lbT3K1sTUgeSJQiVfzwlYWTG1XmSnOgaD+7+vDqH4WUN378T
	 HA49TR9PoPoKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
Reply-To: sashiko-reviews@lists.linux.dev
To: "T.J. Mercier" <tjmercier@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928150121.1712559-3-tjmercier@google.com>
References: <20260928150121.1712559-1-tjmercier@google.com>
 <20260928150121.1712559-3-tjmercier@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 15:18:32 +0000
Message-Id: <20260928151833.31C8F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: RCU readers can match recycled elements causing UAF/corruption
--

commit 1b9a82a1c5a80781d8a76b226efc1db28e064ff2
Author: T.J. Mercier <tjmercier@google.com>

bpf: htab: Reduce elem_size by 8 bytes for small key sizes

This commit reduces element size for standard and non-LRU per-CPU hash
maps with small keys by omitting the 32-bit hash value. For these small
keys, it relies on a single atomic instruction for key comparison and moves
the new key assignment to the end of element allocation to avoid exposing
uninitialized values.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 5db11a21ce980..7a8049cc99828 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -734,35 +784,60 @@ static inline struct hlist_nulls_head *select_bucke=
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
> +				return l;
> +	}

[Severity: High]
Can an RCU reader searching for a deleted key incorrectly match a recycled
element here?

Without a hash field to act as an epoch check, it seems a lockless reader
might accept an element that is currently being reallocated if the stale
key hasn't been overwritten yet.

[ ... ]

> @@ -1225,7 +1302,18 @@ static struct htab_elem *alloc_htab_elem(struct bp=
f_htab *htab, void *key,
>  		copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);
>  	}

[Severity: High]
If a lockless reader successfully matched the old key in __lookup_elem_raw(=
),
could it observe the element in an inconsistent state here?

While the value is being copied (or a new per-CPU pointer is being initiali=
zed
earlier in this function), the reader might read corrupted data. In the case
of a non-preallocated per-CPU map, could it dereference the old, freed pptr
leading to a use-after-free?

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
> +	}
>  	return l_new;

[Severity: High]
Does delaying the key update to the end of alloc_htab_elem() inadvertently
leave the old key intact while the new value is initialized?

While this prevents premature matches on the new key, it seems to expose
the element to readers searching for the old key, breaking the RCU safety
of recycled elements.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928150121.1712=
559-1-tjmercier@google.com?part=3D2
