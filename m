Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82A35202D
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433894; cv=none; b=kDt/lGSbDj6Zffy7PpWtpQ1X3+/97IS3Bry4gbjchAU85VawAXT4L96jB01rgUmLCF23Nk83BU7QdCQQdTdmmNx5pxiBzjQOx9UeEJOl2Jz1vWesedrleviEakxvF7HGLiILpqEV3TG73+b49vhnTz94ofHhjH+3KNg5umQVWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433894; c=relaxed/simple;
	bh=MoQb5/22q6OjA+n8JO/8BWcr0MKTaYGMiGT0zOgpfTE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qtKVofiEKBICEo+dGETzyFWbcD7UcooLB9MaHVayrR4BxzPD/Ea9Re2jCNK+KDn6rQ2CGQPT5p0l2I0VR0P47ae0JlaPxhn6/MvjeoeqztODoFCgIcBzx251XJiXF77fFnG2O+9R9bGulgoo6PKSAqVwzLeDyWPt5cK4ncB2168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOC4gYV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOC4gYV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C631F00893;
	Tue,  2 Jun 2026 20:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780433892;
	bh=MTbLdJ26gkdzKsddjtNQ5uwXCxspwrwDVlPWAUjIqis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QOC4gYV7QE1SHvW9M/SmBogwa1MolcgKaMhugeNzDgMERPKS2kkrmPwenjNRIjnnY
	 9dq2p4rBzcs8OrumNH909JNEUCWA4ixVAvG7+2kFqxvonfjR50mKxCU7jS3PYSHC2t
	 oiDhflA63tH7aeQq6QgUZr0CQWY5q/3rviR4GGfkiv++ZhXzUXdRyWhU39YvvTHb/X
	 Iwse7ra4mltOuiBs76xPpBqTqIY5lb40HTFT8GceEEPg9YZSQjGMl8/DEr/lc8Rfuq
	 7pAExcLYtSzsBlMmrzgifuUH+oO39DWgUiOgs3GQJiAxylp899n9WxAtg0SqzBhJjz
	 6yAEdJ/ZviCFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 06/11] bpf: Optimize word-sized keys for
 resizable hashtable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602-rhash-v6-6-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-6-1bfd35a4184f@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 20:58:12 +0000
Message-Id: <20260602205812.84C631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Direct pointer casts in the specialized hash and comparison fu=
nctions will cause kernel panics due to unaligned memory accesses on strict=
-alignment architectures.
- [Critical] The specialized XOR-fold hash function `rhtab_hashfn_long` is =
perfectly linear, destroying rhashtable's collision resistance and leading =
to a HashDoS vulnerability via endless rehashing.
- [High] Iterating over the rhash map with `bpf_for_each_map_elem` aborts p=
rematurely if the callback function deletes the current element.
--

commit 4f63f265b25e82f3769f409dbd1d12850cbbefdc
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Optimize word-sized keys for resizable hashtable
   =20
Specialize the lookup/update/delete/get_next_key/for_each callback/
batch paths for keys whose size matches sizeof(long) (4 bytes on
32-bit, 8 bytes on 64-bit).

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 8686918dbc3e8..600128c3e3289 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

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

[Severity: Critical]
Does this direct pointer cast and dereference cause unaligned memory access
panics on strict-alignment architectures like ARM32 or SPARC?

Since BPF map keys can be unaligned, such as when pointing directly into
network packet payloads, shouldn't this use get_unaligned() to safely read
the key?

> +	const struct rhtab_elem *key2 =3D ptr;
> +
> +	return key1 !=3D *(const unsigned long *)key2->data;
> +}
> +
> +static __always_inline u32 rhtab_hashfn_long(const void *data, u32 len, =
u32 seed)
> +{
> +	u64 k =3D *(const unsigned long *)data;
> +
> +	return (u32)(k ^ (k >> 32)) ^ seed;

[Severity: Critical]
Is this linear hash function vulnerable to HashDoS attacks?

Because the key folding is perfectly linear with respect to XOR, the collis=
ion
property is independent of the random seed. For example, all 64-bit keys of
the form k_i =3D ((u64)i << 32) | i will produce an intermediate zero, resu=
lting
in H(k_i, seed) =3D seed.

If these fall into the exact same bucket, it will exceed the elasticity lim=
it
and trigger an rhashtable rehash, but they will still perfectly collide with
the new seed. Could this trap the kernel's rhashtable worker in an infinite
background rehashing loop?

> +}
> +
> +static const struct rhashtable_params rhtab_params_long =3D {

[ ... ]

> @@ -3167,7 +3216,7 @@ static long bpf_each_rhash_elem(struct bpf_map *map=
, bpf_callback_t callback_fn,
>  	 * elements are deleted/inserted, there may be missed or duplicate
>  	 * elements visited.
>  	 */
> -	while ((elem =3D rhashtable_next_key(&rhtab->ht, prev_key, rhtab_params=
))) {
> +	while ((elem =3D rhtab_next_key(rhtab, prev_key))) {
>  		if (IS_ERR(elem))
>  			break;

[Severity: High]
Will this iteration silently abort if the callback function deletes the cur=
rent
element?

Deleting the current element during iteration is a common BPF pattern for
garbage collection. If the callback deletes the current element, rhtab_next=
_key
will try to locate the deleted prev_key in the hash table, fail, and return
ERR_PTR(-ENOENT). The IS_ERR(elem) check would then immediately break the l=
oop.

This behavior appears to have been introduced in patch 4 of this series
(bpf: Implement iteration ops for resizable hashtab) and is preserved here.

>  		num_elems++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-rhash-v6-0=
-1bfd35a4184f@meta.com?part=3D6
