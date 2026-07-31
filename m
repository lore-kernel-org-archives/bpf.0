Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568F489864
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 01:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785463031; cv=none; b=PIRImolKqUed+zXDvhW3CmjhT/jbGoKJjKFAEc4I6I87nfkRLa2Kp8SjsBMM9Nei05kjff4UdlG/eTtRqrqbJlppus8GbAb0Z1MtlvVSkbvHHAh04uZJCYSqegZjfp3d6QRPZ5NHlE8ej762acxQAYjvK9lxJc1UE+xX94U68X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785463031; c=relaxed/simple;
	bh=gZkm1syO+s0i8V+AsbbyroBK479jVF82fNMvsPESfLk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=imoWnbmq6nBGaRb+fXNfkprzeSyzu9Jt+0t6G+SysNxtuXfXoXJvQATfrLKyS8ZJ0DIv27MXxeMC2Fl66Hi8o3pF6YeBslOgAjPUsE8CYJ/qixsy+6cZLs5a+IWT1Cqp39XR/4v6a5XDs1FX/69PxJEPQgPJVyxNQ4kpN7WFZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc99Hg+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc99Hg+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83E01F000E9;
	Fri, 31 Jul 2026 01:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785463029;
	bh=4MyEbIiCe0exnd9LBi6nDW+V07+I5AN/JRO3UPDHItk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lc99Hg+dSovZGuX/9j2i1rYNq4D6WkiFPOpGHoetMfT4JhUPDy9ypVvncGycW4pyy
	 qFMsprz+EiMwH8tvbEyLS9CNRMncg7fjMdiL+RlYAF1Tf+RVIjJhzhDvuNf8sSgaGF
	 VSKKfM8DWON0I88+FzcIRWfF0EijNMH1o8tXXiqVCnu9/7Xq92Qehm4hlkeOwnk32B
	 EFVcyzsq0Fd3mAXgKGFimqfI1yHgJ1cBbRRkhYzsTIggb8HEK2dDy8UeP8ylRXnYkx
	 MKOdr8Nf2NyDwBMSRDKG83iFifs0QjmiCNPWAi+IWJw+YUZaX+NrBlKPGDLPf27UVb
	 B4UGbuV8/ihvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
Reply-To: sashiko-reviews@lists.linux.dev
To: "T.J. Mercier" <tjmercier@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731010645.3965783-3-tjmercier@google.com>
References: <20260731010645.3965783-1-tjmercier@google.com>
 <20260731010645.3965783-3-tjmercier@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 01:57:09 +0000
Message-Id: <20260731015709.A83E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Eliding the 32-bit hash field for small keys causes lockless RCU l=
ookups to suffer from torn reads, leading to false positive matches when el=
ements are concurrently recycled.
--

--- Patch [2]: [PATCH bpf-next v2 2/2] bpf: htab: Reduce elem_size by 8 byt=
es for small key sizes ---
commit 1a9b131810714c16f6fb58fbc067753c917cf3cd
Author: T.J. Mercier <tjmercier@google.com>

bpf: htab: Reduce elem_size by 8 bytes for small key sizes

This commit reduces the element size of standard and PCPU hash maps for sma=
ll
key sizes by removing the 32-bit hash value and padding. It introduces
htab_has_hash() to conditionally bypass hash checking and storage when the =
key
size is less than or equal to the word size.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index f54366da459f5..82b19bd543109 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
[ ... ]
> @@ -618,6 +625,12 @@ static struct bpf_map *htab_map_alloc(union bpf_attr=
 *attr)
> =20
>  	bpf_map_init_from_attr(&htab->map, attr);
> =20
> +	/* Avoid hash memory use and comparisons where unnecessary.
> +	 * u32 hash reads are always atomic. If we elide them, key comparisons =
must also be atomic
> +	 * to avoid false positive key matches due to torn key reads / writes. =
So check key_size.
> +	 */
> +	htab->has_hash =3D htab_is_lru(htab) || htab->map.key_size > sizeof(uns=
igned long);

[Severity: High]
While the comment correctly notes that key comparisons must be atomic when =
the
hash is elided, are runtime memcmp() and memcpy() operations actually atomic
for all key sizes <=3D 8 bytes (such as 3, 5, 6, or 7 bytes)?

[ ... ]
> @@ -761,10 +776,16 @@ static struct htab_elem *lookup_elem_raw(struct bpf=
_htab *htab,
>  	struct hlist_nulls_node *n;
>  	struct htab_elem *l;
> =20
> -	hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
> -		if (htab_elem_hash(htab, l) =3D=3D hash &&
> -		    !memcmp(htab_elem_key(htab, l), key, key_size))
> -			return l;
> +	if (htab_has_hash(htab)) {
> +		hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
> +			if (htab_elem_hash(htab, l) =3D=3D hash &&
> +			    !memcmp(htab_elem_key(htab, l), key, key_size))
> +				return l;
> +	} else {
> +		hlist_nulls_for_each_entry_rcu(l, n, head, node.hash_node)
> +			if (!memcmp(htab_elem_key(htab, l), key, key_size))
> +				return l;
> +	}
> =20
>  	return NULL;
>  }

[Severity: High]
Can this lockless memcmp() result in a torn read and a false positive match?

In preallocated BPF hash maps, deleted elements are immediately pushed to a
lockless freelist without an RCU grace period. If a reader is preempted whi=
le
examining an element, and another thread reallocates and writes to that
element's key using a non-atomic memcpy() (such as in alloc_htab_elem()), t=
he
reader might observe a torn mixture of the old and new key.

Without the 32-bit atomic hash check acting as a filter, could this torn re=
ad
randomly match the reader's target key, causing the lookup to return an
unrelated map element?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731010645.3965=
783-1-tjmercier@google.com?part=3D2
