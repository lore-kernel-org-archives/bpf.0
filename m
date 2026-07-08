Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273C9315D40
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 03:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480235; cv=none; b=AQt+KPT76BhoMMcBs1Azc2mophtoeGlB/4KTcvwKqndg3xT8SQFpDdDIL/hQQw3jTTvJpPSHecRBTTk+5f0lIVMoNWXxh3ZKQ5Qul6Iquks960UPLCl+It9ixyuQgbTYeSdiqj6JNQsH3aZmdF93CVXlikWcqi4bSAEdo7Ssfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480235; c=relaxed/simple;
	bh=gqcIiHnMnCmfmcZXD52NFmsB+z7YS8uySNxCnvDrutw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X76JR6J8uzFlIKAQUgCktazQiF0XDPVaoJc2S02j5DdrxE0oYhAU9L09kGJ4XXkYhWO4izQTT+YJo2TbNLN7OP8E5N8PkuXwF/nqvY9NCbqnOd6pUsfm+pBJ3OczzsWS1DLHDhqWXPajn5pt8/vKDPxhONu/YzteR40Jt1Hwc24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RItPutOg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RItPutOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4841F000E9;
	Wed,  8 Jul 2026 03:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783480233;
	bh=eSHTGjm2fYjxSPfeqN90jJ8O1JNFUzBVxEiTnwCT3Zs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RItPutOgprNwWal/52bqY5d6FnF35Mf91rYPSE/XqMtIfW56CiUhQRv4tOP9dBEP5
	 UxUAqdWfxDOSr89Mt9PHTm75MK70sXEC2aN1zMmBP8/83wRVupKTAq7a+0U+Zi2dqI
	 h1YdjCUqC7/iDn5qAgVWMrS7eb/UgAcB1uPR0+OrioM8CpnZKsjjT2uSiJdijLuEWS
	 O8wsku79fNJabjewviL7LOZP9zSzcHixTSjzFtxbJUmrZ4+JtSClhdkMziJ0HVrQXV
	 LuM91Lp6X89m2n5NWhK7KuGZSAPiZvlkXJnLIDclWhNMHc9M6qabcClrTa4zMrEAME
	 pJ44uTslkeb9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: Limit bitfield dump reads to checked bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708025807.702010-1-lgs201920130244@gmail.com>
References: <20260708025807.702010-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:10:33 +0000
Message-Id: <20260708031033.9A4841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces data corruption and undefined behavior when=
 reading unaligned enums on Little Endian architectures by shifting a 64-bi=
t integer by 64 bits.
--

--- Patch [1]: [PATCH] libbpf: Limit bitfield dump reads to checked bytes -=
--
commit 128a41a5de9f0bf022f4b652bb58245609c3162a
Author: Guangshuo Li <lgs201920130244@gmail.com>
libbpf: Limit bitfield dump reads to checked bytes

This commit updates btf_dump_get_bitfield_value() to limit the bitfield
value-building loops to the same checked byte range instead of the full
backing type size. It aims to prevent reading past the checked range for
narrow bitfields.

> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c

[ ... ]

> @@ -1784,13 +1788,13 @@ static int btf_dump_get_bitfield_value(struct btf=
_dump *d,
>  	 * stored in num, then we left/right shift num to eliminate irrelevant =
bits.
>  	 */
>  #if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> -	for (i =3D t->size - 1; i >=3D 0; i--)
> +	for (i =3D nr_bytes - 1; i >=3D 0; i--)
>  		num =3D num * 256 + bytes[i];
> -	nr_copy_bits =3D bit_sz + bits_offset;
> +	nr_copy_bits =3D bit_sz ? bit_sz + bits_offset : nr_bytes * 8;
>  #elif __BYTE_ORDER__ =3D=3D __ORDER_BIG_ENDIAN__
> -	for (i =3D 0; i < t->size; i++)
> +	for (i =3D 0; i < nr_bytes; i++)
>  		num =3D num * 256 + bytes[i];
> -	nr_copy_bits =3D t->size * 8 - bits_offset;
> +	nr_copy_bits =3D nr_bytes * 8 - bits_offset;
>  #else
>  # error "Unrecognized __BYTE_ORDER__"
>  #endif

[Severity: Medium]
Does this change introduce data corruption for unaligned enums on Little
Endian architectures?

When bit_sz is 0 (for unaligned enums), nr_copy_bits now becomes
nr_bytes * 8 (e.g., 32 for a 4-byte enum).

The code immediately following this block in btf_dump_get_bitfield_value()
calculates:

	left_shift_bits =3D 64 - nr_copy_bits;
	right_shift_bits =3D 64 - bit_sz;

This results in left_shift_bits =3D 32, and right_shift_bits =3D 64.
The final shift evaluates to:

	*value =3D (num << 32) >> 64;

Shifting a 64-bit integer by 64 bits is undefined behavior. On architectures
like x86 and ARM64, the shift amount is masked (modulo 64), meaning >> 64
executes as >> 0.

This results in (num << 32) >> 0, returning a corrupted value instead
of the expected unaligned enum value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708025807.7020=
10-1-lgs201920130244@gmail.com?part=3D1
