Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488703F825E
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660478; cv=none; b=SPJN69tNrg1cxiT4kbsYKP2650wUipe2YuCBnt60RoCrJu5ifVH8IIUf+czkqqSj052nHXxKVxIVOj0JV0P6sb1KkRJnJuxb7932DcjOKW4wwCKCgkd+J0wRYUK3iTZx73t0gevV63uZDXkKZb9tircY/WjX148nSBT1xLRdJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660478; c=relaxed/simple;
	bh=eQvfB4CcH4euiISE/uB7PECa14XMyZnaKft+xfU/0zM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=utPzakapuBgKmhA2kZJPVQgdUMmopbIACnGtX8jFZ6yvUw21+qGIeI2X36kQLCAAQVPRxF3icz/9vAdfqPNw5FUxVBAsOZbrWIRuH1rvoQEqw8COWrNqRpl3OReCj3YEvmos7FNm8RdDNNhcNvhLbqUTXRiSNWnKeym1tzAEoIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXBa3KVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXBa3KVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55991F00893;
	Fri,  5 Jun 2026 11:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780660476;
	bh=9hKgZlcQzg9vdVLpOfFGnjSjnHpifR1f2GF4aD2tjZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HXBa3KVT+cN+lvF23fzCx2z62tGywwuzoiR2WH2Z7SXLpZbGtBN2veRUbe6xmoSo7
	 0X1ScFqQK/Zp8Tus/9M7vXWQg9lSJmUHHcKCF7Fp+FoLLqIRJRP8JJ3Y88pahK5kUV
	 OmzlooP70qbY/Xvdua7TM2Rq953n4dZHAL/wtTfTXm6Di2Z0bNmswN1plfVSWs4zV9
	 fj0VB4MBsErWaoG6m735Y2V3kB6erV6ZSD34A6nkxaoFL7jF+i2gsxD/5ckQAnNlVi
	 Jhn65SsDngw7ZBGPT23ifdl5XNH40UmL+Rpg3pIWbU/UZmFzzgMxkyoPAErY6dWS8x
	 vsfJY+tcF6xQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 07/12] bpf: Optimize word-sized keys for
 resizable hashtable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605-rhash-v7-7-5b8e05f8630d@meta.com>
References: <20260605-rhash-v7-7-5b8e05f8630d@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 11:54:36 +0000
Message-Id: <20260605115436.C55991F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The custom hash function `rhtab_hashfn_long` is vulnerable to Hash=
 Denial of Service (HashDoS) because it fails to mix the random seed non-li=
nearly.
- [High] Directly dereferencing potentially unaligned BPF map key pointers =
causes unaligned memory access faults.
--

commit 376379c40761f9d44cd7e1638b3ca3a7cb1e989b
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Optimize word-sized keys for resizable hashtable

This commit specializes the lookup, update, and delete paths for BPF resiza=
ble
hashtables when the key size matches sizeof(long). It introduces a custom
inline hash and compare function to avoid indirect jhash dispatch.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 7b9408b8320c9..b4366cad3cfa5 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2763,6 +2763,31 @@ static inline void *rhtab_elem_value(struct rhtab_=
elem *l, u32 key_size)
>  	return l->data + round_up(key_size, 8);
>  }
> =20
> +/* Specialize hash function and objcmp for long sized key */
> +static __always_inline int rhtab_key_cmp_long(struct rhashtable_compare_=
arg *arg,
> +					      const void *ptr)
> +{
> +	const unsigned long key1 =3D *(const unsigned long *)arg->key;

[Severity: High]
Can this direct pointer dereference cause unaligned access faults on
architectures without hardware support for unaligned loads?

The BPF verifier ensures memory bounds checking for map keys, but does not
enforce that the key pointer is naturally aligned (e.g., keys from packed
structs or packet buffers).

Should this use get_unaligned() to safely read arg->key?

> +	const struct rhtab_elem *key2 =3D ptr;
> +
> +	return key1 !=3D *(const unsigned long *)key2->data;
> +}
> +
> +static __always_inline u32 rhtab_hashfn_long(const void *data, u32 len, =
u32 seed)
> +{
> +	u64 k =3D *(const unsigned long *)data;

[Severity: High]
Can this dereference of the data pointer also cause unaligned access faults,
similar to the key comparison function above?

> +
> +	return (u32)(k ^ (k >> 32)) ^ seed;

[Severity: High]
Does this custom hash function bypass the rhashtable HashDoS mitigation?

Because the random seed is applied via a final linear XOR, the collision
condition for two keys reduces to `(H(k1) & (S - 1)) =3D=3D (H(k2) & (S - 1=
))`.
This mathematically makes collisions completely independent of the seed.

If rhashtable's bucket chain length limit is exceeded and it attempts to
rehash with a new random seed, will all colliding keys still map to the exa=
ct
same new bucket, causing an infinite rehash loop?

> +}
> +
> +static const struct rhashtable_params rhtab_params_long =3D {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-rhash-v7-0=
-5b8e05f8630d@meta.com?part=3D7
