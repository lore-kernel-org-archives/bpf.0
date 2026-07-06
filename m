Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D2D13DDAA
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783306002; cv=none; b=LjyYP4o0kISU450bplTVHMOfnjvU9yalASylX0nTaaWd4JvacGmmo5aI7wLaJ6gHHE2rUeMAOk3NmO7mGrqtp5XN/hFxnyf4u42rsN7pStRnXoeNK3CKJu1cKGDRW8tHfDFfrXlCIz6w2ZZsLFlTxlul7a8oln5HzwLvrSk6dGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783306002; c=relaxed/simple;
	bh=0Hd0bTYdtvFbwmm2xtnYb/RoGGFVam/EvSVetwT7/To=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rkaO4EfUB/UqqZX/EQe1KZpnGcRtVgf79taXgK9W3j0xy1cIbP2r6vrmHW8A4q6UYgDFta1/NMfC84GvWIZtBT+erwattbrQhsLGvoCHyYcS8nPYN4TgEry548zSDvYC41cQLDG4NlEDb/N2tFh/psgqtk0tMUGVBB6Dv9kTrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SL/qS72X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL/qS72X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C741F000E9;
	Mon,  6 Jul 2026 02:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783306000;
	bh=r3mXDsw/Jo5WwOIyYwXercje4rMIaHYUY5kc9zPlIM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SL/qS72X8y8GwXDP1CHy4XGS46NwYKSt+CvBNpkbUtGXPbNu4DV03WNRZyERhiNuC
	 tL7HNjQps6aKe1mjKFdrIjK7Vzz2a6OcW5kRMdTR3AKaj8ozUxnRaYARmZ0tRAImWR
	 UPSTR0JwlhdWOTwbx0R20FcEVCkRCX25kI09GGP0NILHaDM6f2QWgxshMMIVYtECyV
	 9sk3kY7VU/11ZSB1nzRlEk9g4UZ7Oo88FCKGrNUqpn1YY+l9n3U6L7C8Sj3zYo1M6t
	 DR6UiOGmhvalMBtNe/+n9pQJqy42+d+Zi1Jzl/VgcZBrTC9kN4VYJd5Kr8IwMP4h3v
	 f3d0rIzwkDx8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] libbpf: Limit bitfield dump reads to checked bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706023632.625353-1-lgs201920130244@gmail.com>
References: <20260706023632.625353-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:46:39 +0000
Message-Id: <20260706024640.43C741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch introduces a logic error and Undefined Behavior when e=
xtracting unaligned enum values on little-endian architectures. When `bit_s=
z =3D=3D 0`, `left_shift_bits` is correctly updated to `64 - nr_bytes * 8` =
(e.g., 32 for a 4-byte enum), but `right_shift_bits` is unconditionally set=
 to `64 - bit_sz =3D 64`. This results in `(num << 32) >> 64`. Shifting a 6=
4-bit integer by 64 is Undefined Behavior in C. On architectures like x86_6=
4 and ARM64, the shift amount is masked by 63, executing effectively as `>>=
 0`. Consequently, the extracted enum value remains incorrectly shifted lef=
t (e.g., 1 becomes 4294967296), breaking BTF dumping for unaligned enums.
--

commit 0a4db97a6f3bd1db635b97e6e0efd0932b9505b1
Author: Guangshuo Li <lgs201920130244@gmail.com>

libbpf: Limit bitfield dump reads to checked bytes

This patch restricts the number of bytes read during bitfield value
extraction to the actual size of the bitfield, preventing out-of-bounds
reads. It preserves the full-size read for the non-bitfield path.

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
>  	left_shift_bits =3D 64 - nr_copy_bits;
>  	right_shift_bits =3D 64 - bit_sz;
> =20
>  	*value =3D (num << left_shift_bits) >> right_shift_bits;

[Severity: Medium]
Does this introduce undefined behavior when extracting unaligned enum values
where bit_sz is 0?

When bit_sz is 0 in btf_dump_get_bitfield_value(), right_shift_bits is set
to 64. Shifting a 64-bit integer by 64 is undefined behavior in C.

On architectures like x86_64 and arm64, the shift amount is masked by 63,
effectively executing as a shift by 0.

Because left_shift_bits is correctly updated to 64 - nr_bytes * 8
(for example, 32 for a 4-byte enum), the value is shifted left but not
shifted back right.

Can this corrupt the extracted unaligned enum values by leaving them
incorrectly shifted left?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706023632.6253=
53-1-lgs201920130244@gmail.com?part=3D1
