Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F7448BA8
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578348; cv=none; b=nIeKwit9VrWaiqvM+E/9ZSQcWLgLvsB6nhn7nVMmA0TDVXJYXAu0IHVRwrIKMCLDnXnVzERaQbG2sSYGzK+zYQTN+g2yf85Y/Wm+80BBe+Tvco0k/t14rPTzRrND6LD5JVA3vn/QdrEY635nlLcJYC3NhLn38fbIBU1DofEs0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578348; c=relaxed/simple;
	bh=JZemNjM+B1efMeCe67hVmul1PjdvnddHDqarRfID9lk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wat42SUtsp6PvZjgM9iz+dgMAnSZ/mDBBfZIXHi1M5P6MGj23OnRsjGreacUzmqosLlEcWN4Scxghk3KDxkZoPsJDzUC/j6o+MuGrWoePRTFuSoYLA24tfGocqvt9p3PdI+BwLWtc3Lj9NYKJTQ96dpNbeZbJK/fsQPAA9bHga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI6lkpx3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI6lkpx3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D309C1F000FF;
	Mon, 28 Sep 2026 06:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790578346;
	bh=GcECai/efd5oejUz1wUTYJPYqYANYGxgiaMlR2mcI4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FI6lkpx3h/iyvJ1G35z0RYwHwgkBNgRt4XZo6t20sNE9eDUmSu4beXqvHIxk8cyAb
	 GS2GsGxo1QAbkQ8KRaVy2MCU5CZTiKgSJRiMe48sQ6jbsDhyET402tKIgq/KOBp/9j
	 pOVDo4OktLuP40E9RUTuqVfpqQGkJHp8SQCTKb8skeGfTjf3NzakX33obxnyc1Xg8x
	 aZyEMs35FjZWsAsfXSAPccWYiY3DNofP48rjnd0KRoMhjjdAGP3qCYZjRx1juS0gzG
	 Bsu0TfXaqhZUnHpU/648o4AhGKuiJmzJFV2yPkTIa0fkZ9AovTDNRPi6TEaqZzZJsk
	 kdPDqZQc70LYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
Reply-To: sashiko-reviews@lists.linux.dev
To: "T.J. Mercier" <tjmercier@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928064021.1433277-3-tjmercier@google.com>
References: <20260928064021.1433277-1-tjmercier@google.com>
 <20260928064021.1433277-3-tjmercier@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 06:52:26 +0000
Message-Id: <20260928065226.D309C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: htab: Data corruption when RCU readers match old key on recyc=
led elements
- [High] bpf: htab: Missing memory barrier allows lockless readers to see u=
ninitialized values
--

commit ce1608196eb78b164c5d54ecf3680200baae12de
Author: T.J. Mercier <tjmercier@google.com>

bpf: htab: Reduce elem_size by 8 bytes for small key sizes
   =20
This commit removes the stored hash value from hash table elements when the
key size is small, falling back to direct atomic key comparisons. It also
updates element recycling by reordering new key assignment to occur after
the value has been copied, attempting to prevent early lockless matches.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -775,9 +777,32 @@ static inline struct hlist_nulls_head *select_bucket=
(struct bpf_htab *htab, u32
[ ... ]
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

[Severity: High]
Does this lockless reader lack an acquire memory barrier?

When evaluating the key using READ_ONCE, an acquire barrier such as
smp_load_acquire or smp_rmb before reading the value seems to be missing.
Without this barrier, a concurrent reader on a weakly ordered architecture
might reorder the value read before the key check, observing uninitialized
or stale values.

> +	}
> =20
> +	if (out_n)
> +		*out_n =3D n;
>  	return NULL;
>  }
[ ... ]
> @@ -1268,7 +1268,18 @@ static struct htab_elem *alloc_htab_elem(struct bp=
f_htab *htab, void *key,
>  		copy_map_value(&htab->map, htab_elem_value(l_new, key_size), value);

[Severity: High]
Can this lead to data corruption when rcu readers match the old key?

When a map element is recycled, the assignment of the new key is delayed to
the end of alloc_htab_elem. This means the old key remains in place while
copy_map_value overwrites the element's value.=20

If a concurrent lockless rcu reader searches for the old, deleted key, it
will successfully match the old key during this window and incorrectly read
the newly written value. Because bpf keys are arbitrary bytes, there is no
safe poison value that can be temporarily written to prevent legitimate
concurrent lookups from matching.

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

[Severity: High]
Are memory barriers required when publishing the new hash or key?

Using WRITE_ONCE or htab_elem_set_hash to publish the new key and hash only
prevents compiler reordering. Without a CPU memory barrier like
smp_store_release or smp_wmb, weakly ordered architectures like arm64 can
reorder the key or hash store to occur before the stores in copy_map_value.

This would allow a concurrent rcu reader to observe the newly written key
early and access the value before it has been completely initialized.

> +	}
>  	return l_new;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928064021.1433=
277-1-tjmercier@google.com?part=3D2
