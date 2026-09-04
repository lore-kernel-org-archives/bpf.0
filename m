Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2B3D2FE1
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512197; cv=none; b=nLOjBKXm5q4fJi9RGJ2xRPPgj8qsqGVNlvcW8KthA8qZxTgO8EX+745TKwlIPRRUzdw8ALXIkmIbHop43a6kkWgxJomHrUh9ytq1cEFuHr3JtXTP7UjrW0Te9eMKYzJxjIUV2LQJ7/kcIiteph6tpHOqhLz6iOcWAk8cugi02kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512197; c=relaxed/simple;
	bh=7YL8WAtA8t7srcKsXyBvvjI1OY7KxSfcWSIeyH13LrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vC0Jz72HnG+ml7GzP50TX+UOmr6lcZCIGuW9fpU4GwOj34BMW88dU7cscUzn2c0UpnwFDGQmUnvbYv6wzFFJT10ibFqhCLyF8pouQTLNnaj8KbGS/mBkEltOzOm6gLNrPgd71jFDwPSAiN7erG61Y7IiPyfRzM5UoepPJcApOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyFxEBOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyFxEBOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6EE1F00A3D;
	Fri,  4 Sep 2026 08:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788512196;
	bh=9cDyaABT2QpLTQkkDMMm9ZyazrTjF/8ZRNuGIlVMmLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PyFxEBOPhESGDtRjC0pB7fPFFJ5r04F543fODDQN46dH3nW8DHy4eNE6mjqetQosx
	 /wN/wK6KhjDUcE+aqJWs1Sbcd/CFp+vRG14jRxpw3b9Q9tEQNShdIAur4MvbHFp+MJ
	 FU99OYx25MczzqAEDY/zqSM6487POgXl10n90z6LUbmXaiyFMOWTUkVt+5i/0mwFIN
	 8d0Zr0kWC68HXEoRLjHlCxWSVrw9qPNTOvPIBK6GJY0x1AVnwSUA2fNOMLbQ7usNFo
	 eNZgaggjbRwtHaNQCFyOjYVnKGj9RF4e/E7Ba5ozYX5n6JzRADtCpYa1+m5kAavnWp
	 CuwQEvDd4oKPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next V3 14/15] selftests: net: gro: Add PSP
 encapsulation and encryption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tariq Toukan" <tariqt@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903085215.3691657-15-tariqt@nvidia.com>
References: <20260903085215.3691657-1-tariqt@nvidia.com>
 <20260903085215.3691657-15-tariqt@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:56:35 +0000
Message-Id: <20260904085635.DC6EE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `__packed` macro is undefined in the userspace selftest cont=
ext, failing to pack `struct psphdr` and instead declaring an unintended gl=
obal variable.
- [Medium] Casting a byte array to protocol structures violates strict C al=
iasing rules and causes unaligned accesses.
--

commit 0e562eb8479f9e8d1291e2bc6a8bcff58fc5a732
Author: Cosmin Ratiu <cratiu@nvidia.com>

selftests: net: gro: Add PSP encapsulation and encryption

This commit adds a PSP mode to the GRO selftest, wrapping transmitted frames
in PSP transport mode and encrypting them using OpenSSL. It also introduces
new test cases for PSP-specific coalescing scenarios.

> diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selfte=
sts/net/lib/gro.c
> index 7a333155de1ab..25f54eed601f5 100644
> --- a/tools/testing/selftests/net/lib/gro.c
> +++ b/tools/testing/selftests/net/lib/gro.c
[ ... ]
> @@ -110,6 +119,38 @@
> =20
>  #define EXIT_OVER_COALESCE	42
> =20
> +/* PSP transport mode encapsulation, as built by the sender:
> + *
> + *	[eth][IP][UDP dport=3D1000][PSP hdr][encrypted L4][ICV]
> + *
> + * Can't use the kernel-only include/net/psp/types.h header, so copy the
> + * encoding here.
> + */
> +struct psphdr {
> +	uint8_t		nexthdr;
> +	uint8_t		hdrlen;
> +	uint8_t		crypt_offset;
> +	uint8_t		verfl;
> +	uint32_t	spi;		/* big endian */
> +	uint64_t	iv;		/* big endian */
> +} __packed;

[Severity: Medium]
Since this is a userspace selftest, is __packed defined in this context?

Without including the appropriate compiler attribute macro (like
__attribute__((packed))), this might just declare an unintended global
variable named __packed instead of packing the struct.

If the struct remains unpacked, it will assume an 8-byte natural alignment
due to the uint64_t iv field. When the struct is placed at an unaligned
offset in the packet buffer during psp_encapsulate(), writes to spi and iv
might trigger alignment traps on strict-alignment architectures.

[ ... ]
> +/* Encapsulates & encrypts @pkt with PSP transport mode into psp_scratch.
> + * Returns the scratch buffer and updates *@lenp.
> + */
> +static char *psp_encapsulate(const char *pkt, int *lenp)
> +{
> +	struct psp_assoc *assoc =3D &psp_assocs[psp_idx];
> +	int ip_hlen, l4_off, l4_len, aad_len;
> +	struct psphdr *psph;
> +	struct udphdr *udph;
> +	__be16 sport, dport;
> +	uint8_t *data, *icv;
> +	int len =3D *lenp;
> +	uint8_t nexthdr;
> +
> +	if (len + PSP_ENCAP_LEN > (int)sizeof(psp_scratch))
> +		error(1, 0, "psp: %d byte frame does not fit", len);
> +
> +	memcpy(psp_scratch, pkt, len);
> +
> +	if (proto =3D=3D PF_INET) {
> +		struct iphdr *iph =3D (struct iphdr *)(psp_scratch + ETH_HLEN);

[Severity: Medium]
Can casting this byte array to a struct iphdr pointer cause unaligned
access traps?

The static char psp_scratch[] buffer only guarantees 1-byte alignment.
Adding ETH_HLEN (14 bytes) places the pointer at a 2-byte boundary.
Dereferencing 4-byte fields from this struct, or performing similar casts
such as sport =3D *(__be16 *)(psp_scratch + l4_off) later in the function,
might violate strict aliasing rules and cause unaligned memory accesses.
This will trap on architectures without hardware unaligned access support.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903085215.3691=
657-1-tariqt@nvidia.com?part=3D14
