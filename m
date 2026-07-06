Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E33DC4A8
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362479; cv=none; b=uyGZAKyqys1jtbzLJ+oz3lUal3V0HX00R6jfvIIGMkBFL7s12wWjktRTLpmnQGojHhkh94ADx1DDqWQJYNHxMNMzc+ygC1DHYKawD8D6+4R+QTJO2P6cNXeE1V7FM+3s06bsKp5vXdzYxnQud9MeeLAbg/yXo/WqdROvFmAe8EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362479; c=relaxed/simple;
	bh=gicYkG5+m02gy5ZAJpOMpt06huLFqfyrCiKXRgNAe/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K/umlNmRBnr1dFEfTea/eOQYLCt0F1nCVYbgBQbQkp9A+4h0ALwAaqMYtOnW5QiMTSj+fkCqFAvp92snb7maSzjHUUyeDTGIGT6SDSMNh91doF9bt6rKYiMa/2hod3gnLlvSg7tEGdUsfMkDE30zDKYl6eUsDxAJco88dUisU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FimSr39i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FimSr39i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B901F000E9;
	Mon,  6 Jul 2026 18:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783362478;
	bh=ekhIolm5/qIAJahgc5gODgjTiLxqX09sv/fY33XmLUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FimSr39i6RrjuIBY0Sw9gUzYsNT6myy6pWGvOEK+JilexfXz0dK1JZtugo+5Ana60
	 cR9NRZVEcnlwcUiE4eZeWKwk6iAvhJxVZRMZHM4Tc2FAvYCNDyQ1JjZXv4rr65mtEW
	 v3bylthpB4n1E8RDuIHqOyPf6Ld+KRDieZSinh3d+M0AVhXmB4mhRo2x04B9ZPbarr
	 mgIf2NOiix3DbTk4OABsBrITlyhEcd6XBIgqzpeDHqOD0tKJW6r09id4tHusIqmj23
	 3ohtT6C8AAETdo6sbIZMFfrJH5h5l6qE1KurZ9WqfxzRnbeaV8m6xp2f5KNLNff6QR
	 jIf632cYxMEPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND bpf-next v3 4/6] selftests/bpf: Add arena-based
 bitmap data structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706181730.21731-5-emil@etsalapatis.com>
References: <20260706181730.21731-1-emil@etsalapatis.com>
 <20260706181730.21731-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:27:57 +0000
Message-Id: <20260706182758.21B901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Silent failures and falsely reported lock acquisition in bounded a=
tomic bit operations on loop abort.
- [High] `bmp_empty` and `bmp_subset` return `true` on an aborted loop, def=
aulting to an unsafe affirmative state.
- [Medium] Bulk operations unconditionally apply a bitmask to the last word=
 even if the processing loop aborts early.
- [Medium] Missing `READ_ONCE()` or `volatile` cast in `bmp_test_bit` expos=
es lockless polling loops to compiler hoisting.
--

commit 634ac04142cf736158c99f577c0f903470937bfc
Author: Emil Tsalapatis <emil@etsalapatis.com>
selftests/bpf: Add arena-based bitmap data structure

This patch adds an arena-based word-aligned bitmap data structure. The
structure is useful as a building block for components like sched-ext
to represent cpumask structures.

> diff --git a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/bitmap.bpf.c
> index 0000000000000..80e814401fb9e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
[ ... ]
> +__weak
> +bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp)
> +{
> +	return bmp->bits[BIT_WORD(bit)] & BIT_MASK(bit);
> +}

[Severity: Medium]
Does this memory access need a READ_ONCE() or a volatile pointer cast?

If this function is used in a lockless concurrent polling loop, could the
compiler hoist the plain memory read out of the loop and cause an infinite
spin that misses updates from other CPUs?

[ ... ]
> +__weak
> +bool bmp_test_and_set_bit(u32 bit, struct bitmap __arena *bmp)
> +{
> +	u64 val =3D BIT_MASK(bit);
> +	u32 idx =3D BIT_WORD(bit);
> +	u64 old, new, actual;
> +
> +	do {
> +		old =3D bmp->bits[idx];
> +
> +		if ((old & val))
> +			return true;
> +
> +		new =3D old | val;
> +		actual =3D cmpxchg(&bmp->bits[idx], old, new);
> +
> +		if (actual =3D=3D old)
> +			return false;
> +
> +	} while (can_loop);
> +
> +	return false;
> +}

[Severity: High]
If the can_loop constraint is exhausted under heavy contention, this loop
will fall through and return false.

In test_and_set semantics, returning false usually means the bit was
previously 0 and is now successfully set to 1. Could this act as a false
lock acquisition and allow multiple threads to enter a critical section
simultaneously?

[ ... ]
> +__weak
> +void bmp_set_bit(u32 bit, struct bitmap __arena *bmp)
> +{
> +	u64 val =3D BIT_MASK(bit);
> +	u32 idx =3D BIT_WORD(bit);
> +	u64 old, new, actual;
> +
> +	do {
> +		old =3D bmp->bits[idx];
> +		new =3D old | val;
> +		actual =3D cmpxchg(&bmp->bits[idx], old, new);
> +
> +	} while (actual !=3D old && can_loop);
> +}

[Severity: High]
If the loop aborts early due to can_loop being exhausted, does this fail
silently without successfully setting the bit?

[ ... ]
> +__weak
> +void bmp_and(size_t bits, struct bitmap __arena *dst, struct bitmap __ar=
ena *src1, struct bitmap __arena *src2)
> +{
> +	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
> +	volatile u32 i;
> +
> +	for (i =3D zero; i < nwords && can_loop; i++)
> +		dst->bits[i] =3D src1->bits[i] & src2->bits[i];
> +
> +	if (nwords && bits % BITS_PER_LONG_LONG)
> +		dst->bits[nwords - 1] &=3D bmp_last_word_mask(bits);
> +}

[Severity: Medium]
If the loop is aborted early by the can_loop constraint, will this bitmask
logic unconditionally apply to potentially uninitialized or stale data in t=
he
dst->bits array?

Could this corrupt data structures relying on the array?

> +__weak
> +void bmp_or(size_t bits, struct bitmap __arena *dst, struct bitmap __are=
na *src1, struct bitmap __arena *src2)
> +{
> +	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
> +	volatile u32 i;
> +
> +	for (i =3D zero; i < nwords && can_loop; i++)
> +		dst->bits[i] =3D src1->bits[i] | src2->bits[i];
> +
> +	if (nwords && bits % BITS_PER_LONG_LONG)
> +		dst->bits[nwords - 1] &=3D bmp_last_word_mask(bits);
> +}

[Severity: Medium]
Similar to bmp_and, could this mask uninitialized memory if the loop aborted
early?

> +__weak
> +bool bmp_empty(size_t bits, struct bitmap __arena *bmp)
> +{
> +	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
> +	volatile u32 i;
> +
> +	for (i =3D zero; i < nwords && can_loop; i++) {
> +		u64 mask =3D (i =3D=3D nwords - 1) ? bmp_last_word_mask(bits) : ~0ULL;
> +
> +		if (bmp->bits[i] & mask)
> +			return false;
> +	}
> +
> +	return true;
> +}

[Severity: High]
If the can_loop limit is reached on a large bitmap before a mismatch is fou=
nd,
this will fall through and return true.

Could this partially checked bitmap bypass resource accounting or access
control checks by falsely reporting an empty state?

> +__weak
> +void bmp_copy(size_t bits, struct bitmap __arena *dst, struct bitmap __a=
rena *src)
> +{
> +	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
> +	volatile u32 i;
> +
> +	for (i =3D zero; i < nwords && can_loop; i++)
> +		dst->bits[i] =3D src->bits[i];
> +
> +	if (nwords && bits % BITS_PER_LONG_LONG)
> +		dst->bits[nwords - 1] &=3D bmp_last_word_mask(bits);
> +}

[Severity: Medium]
Could this mask uninitialized memory if the loop aborted early?

> +__weak
> +bool bmp_subset(size_t bits, struct bitmap __arena *big, struct bitmap _=
_arena *small)
> +{
> +	size_t nwords =3D BITS_TO_LONG_LONGS(bits);
> +	volatile u32 i;
> +
> +	for (i =3D zero; i < nwords && can_loop; i++) {
> +		u64 mask =3D (i =3D=3D nwords - 1) ? bmp_last_word_mask(bits) : ~0ULL;
> +
> +		if (~big->bits[i] & small->bits[i] & mask)
> +			return false;
> +	}
> +
> +	return true;
> +}

[Severity: High]
Similar to bmp_empty, if the loop is aborted early, this returns true.
Could this falsely report a strict subset and lead to a fail-open condition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706181730.2173=
1-1-emil@etsalapatis.com?part=3D4
