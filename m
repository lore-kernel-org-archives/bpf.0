Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D7489880
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785532968; cv=none; b=snfjWF7/rTmGKyRyGk+mYmhP+ngewXN5SS8+FcJvFLck2R7cOcJUsGgYxNsMSjUFFq504pln1k1EZOAh3sUt8OmSe9VCyzif9b584uMoyw7mv55cxve0WTW6DrEgMQlnb0aB8WCifPQWkcETP2CT79LnCYOMasrWo9M/Joen3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785532968; c=relaxed/simple;
	bh=Z4sLP9AU591ouhDWkY0v9KBr+LEDAhnZE6YjMlF309o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qs7m7YjwSYehDVQ/QwcbhCBrq58Q0vs7rFNRKlIeDtfCiJdAuB/6/nyD0UOMtyFJQgSjgejgKEJ4gCXWLxLNM2yh8Kc8puIIotGNXGiue4r4y7AyncQ7gbwnh2KPJA30RsUzpELJDx6USyrvwxPxHgLfyfhhk6hQP5Nr6YpA9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOHaERQ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOHaERQ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C351F00AC4;
	Fri, 31 Jul 2026 21:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785532967;
	bh=W+d6oOTjsAlcnKc+TVoR5TuKYdRqgLHj+iYXT1XVvcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bOHaERQ6BaZeGmJpSutSyQ1fkvm7u2pPJXkTOth6cvR/poU+U055nO49XVZ0lYNuz
	 FGcvI9VIg2nytO+vhVHLxWRAYabiZddt+o4K+x4saLUYH0W9VpaQXc0JtkU1+4E4hE
	 ju4k3Bnq5M8QnTObkHZ8Tr7FacbzWRiYZqcmbXBrwkPbhlLEQJWxg5dbtn+BAv8Eji
	 A/71anDSPUnamGOAYPRgiRb7qRKNxnnwXcYXHygK6ybb9PWJNw74LiXspon3GW8OU0
	 LvqqALOUSXKx0izDay9C6TMO0ZlOeXQMy4KlDjwNIqJtL1afTemXnjGPsKoctJZGt5
	 0IA852j9b7GLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: harden bloom filter allocation sizing on
 32-bit kernels
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731204917.3845309-1-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260731204917.3845309-1-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:22:46 +0000
Message-Id: <20260731212246.D4C351F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch prevents a 0-byte allocation on 32-bit architectures=
, but fails to address a critical out-of-bounds access bug caused by negati=
ve indexing when `bitset_mask =3D=3D U32_MAX`.
--

--- Patch [1]: [PATCH bpf] bpf: harden bloom filter allocation sizing on 32=
-bit kernels ---
commit 02e5a6622a3bf43a5a551fa2588059c5317afd7d
Author: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

bpf: harden bloom filter allocation sizing on 32-bit kernels

This commit addresses an under-allocation issue for bloom filter maps on
32-bit kernels by computing the required bitset size using u64 arithmetic,
preventing an integer overflow during allocation.

> --- a/kernel/bpf/bloom_filter.c
> +++ b/kernel/bpf/bloom_filter.c
> @@ -127,23 +128,21 @@ static struct bpf_map *bloom_map_alloc(union bpf_at=
tr *attr)
>  	if (check_mul_overflow(attr->max_entries, nr_hash_funcs, &nr_bits) ||
>  	    check_mul_overflow(nr_bits / 5, (u32)7, &nr_bits) ||
>  	    nr_bits > (1UL << 31)) {
> -		/* The bit array size is 2^32 bits but to avoid overflowing the
> -		 * u32, we use U32_MAX, which will round up to the equivalent
> -		 * number of bytes
> -		 */
> -		bitset_bytes =3D BITS_TO_BYTES(U32_MAX);
>  		bitset_mask =3D U32_MAX;

[Severity: Critical]
This is a pre-existing issue, but does setting bitset_mask to U32_MAX leave
the map vulnerable to backward out-of-bounds accesses on 32-bit architectur=
es?

When the map is accessed, the generated u32 hash is masked and passed to
test_bit() and set_bit():

kernel/bpf/bloom_filter.c:bloom_map_peek_elem() {
    ...
    if (!test_bit(h, bloom->bitset))
        return -ENOENT;
    ...
}

kernel/bpf/bloom_filter.c:bloom_map_push_elem() {
    ...
    set_bit(h, bloom->bitset);
    ...
}

On 32-bit systems, test_bit() and set_bit() expect a signed long index.
If the u32 hash value is greater than or equal to 0x80000000, it is
implicitly converted to a negative bit offset.

Because some architectures handle this as a signed offset relative to the
memory base, could this result in reading or writing memory before the
allocated bloom->bitset buffer and corrupting the bpf_bloom_filter struct?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731204917.3845=
309-1-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1
