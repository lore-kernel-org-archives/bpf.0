Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D183A9624
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537481; cv=none; b=Ru04xwP1CeRAnYTEO4nl1elRUrGW8jbW5wWhB2BYRCeV3pGfB8Dk63aiXbhXJqYn3/eUSbVRrK8GlL0bmYvOOk+JYDFF55+pxQxSGOLNyWPCRhqne27tOrZ6b9hS/C/xI3TXdf8+HVuGMM+rHu1zJdtk+t4I/B8Tze7hTe0xHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537481; c=relaxed/simple;
	bh=EmKg8qfATNM8JG/J2jdPIPaY3CYu0jV8UKfUvAkTnTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I7MzEjwrtYid+M1y/OQU2+DrQbsHUBxIvzwMGGI6+AiqYVMmYbMw7DnNie005JLIG20tUEkqjbMm4rSe2gDCDdckgQdeUQKqFDunK/NTwLVQgjM9PH1w4/Yyzg/Mo2Y7+ltTR0bs+2aXsTNos1Jbnf9RR/kxNIFLacwGtS8PmOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ6+CZ/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ6+CZ/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89101F00A3D;
	Mon, 20 Jul 2026 08:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537479;
	bh=xvBRtloxFqyWeH0ZefvF3Aqprene8pekawCYVj5SEyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fZ6+CZ/2Vq4Y/+61aAU8F33swNSKUk41MnZhxsQOzqFytA7KrVfqtxTLmLRyMLnne
	 B2REjcWuYsx+TgLbn0VhZXrNzN4L34sDFN9dZYAcOwjefXnStCSrbMl9xJV8WSuKmZ
	 FcRsrlhHe2pr1XwsQdqZrf05MR3aG1rfFmU5vdym368Wa9AXoVck2a4EXFS1PMuKyr
	 OaFL9l3rcS5PgxV/2+zjy++MGLX1Qf3UwDiOGJDw6qbHTDRuhbhhX89gXFWMQbdYX6
	 jaf0+7GMTDR/gVHuK7MzLEB7C0GqkCnTevV3uwIvPngY38zO7ex3io2LCo3VSEV/l0
	 dcox6gQr06eRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Tao" <rtoax@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_AFC1869057D6C3E59E0AF86BD7A80AA29A06@qq.com>
References: <cover.1784536164.git.rtoax@foxmail.com>
 <tencent_AFC1869057D6C3E59E0AF86BD7A80AA29A06@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 08:51:19 +0000
Message-Id: <20260720085119.A89101F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The while (dst[dlen] !=3D '\0') loop in __bpf_strncat lacks a boun=
ds check against dsz, allowing out-of-bounds reads and potential kernel pan=
ics.
- [High] The src argument in bpf_strcat and bpf_strncat lacks a __str suffi=
x or size parameter, causing the verifier to only guarantee 1 byte of memor=
y safety, allowing strncpy_from_kernel_nofault to leak adjacent kernel memo=
ry.
- [Medium] Silent string truncation occurs without returning -E2BIG as docu=
mented, and the space < 1 check is mathematically unreachable.
- [Low] Incompatible types in strict min() macro trigger compile-time warni=
ngs/errors due to signedness mismatch.
--

--- Patch [1]: [PATCH bpf-next v4 1/2] bpf: add bpf_strcat,bpf_strncat kfun=
c ---
commit e18a916b95792b0a70aea4ebf35e2830d909b3ee
Author: Rong Tao <rongtao@cestc.cn>

bpf: add bpf_strcat,bpf_strncat kfunc

This commit adds string concatenation kfuncs bpf_strcat and bpf_strncat.
These differ from standard glibc functions by requiring the destination size
as a parameter for safety.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c18f1e16edee4..2c09044de3112 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4195,6 +4195,74 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ig=
n, const char *s2__ign,
>  	return __bpf_strnstr(s1__ign, s2__ign, len, true);
>  }
> =20
> +static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
> +{
> +	int dlen =3D 0, space, copied;
> +
> +	while (dst[dlen] !=3D '\0')
> +		dlen++;

[Severity: High]
Does this loop need a bounds check against dsz?  If a BPF program passes a
buffer for dst that does not contain a null terminator, this loop will
increment dlen indefinitely and read past the end of the verified buffer.

> +
> +	if (dlen >=3D dsz || sz =3D=3D 0 || dsz =3D=3D 0)
> +		return -EINVAL;
> +
> +	space =3D dsz - dlen;
> +	if (space < 1)
> +		return -E2BIG;

[Severity: Medium]
Since dlen >=3D dsz is checked right before this, space =3D dsz - dlen is
guaranteed to be >=3D 1. Doesn't that make this space < 1 check dead code?

Also, if the remaining space is too small for the source string, the code
below silently truncates instead of returning -E2BIG as documented. Should =
it
return an error instead?

> +
> +	copied =3D strncpy_from_kernel_nofault(dst + dlen, src, min(sz, space));

[Severity: Low]
Will this trigger a build error? The min() macro requires arguments of
compatible types, but sz is u32 (unsigned) and space is int (signed).

> +	if (copied < 0)
> +		return copied;
> +	else if (copied =3D=3D 0 || copied =3D=3D 1)
> +		return dlen;
> +
> +	/* The copied character count includes '\0'. */
> +	return dlen + copied - 1;
> +}

[ ... ]

> +__bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src)

[Severity: High]
Without a __str or __sz suffix, won't the verifier treat const char *src as=
 a
pointer to a single byte?

A BPF program could pass a pointer to a 1-byte map value, and __bpf_strncat=
()
could then use strncpy_from_kernel_nofault() to read up to dst__sz bytes,
potentially leaking out-of-bounds kernel memory into dst.

> +{
> +	return __bpf_strncat(dst, dst__sz, src, dst__sz);
> +}

[ ... ]

> +__bpf_kfunc int bpf_strncat(char *dst, u32 dst__sz, const char *src, u32=
 len)

[Severity: High]
Does this src parameter also need a __str suffix or a src__sz parameter to
prevent the verifier from treating it as a 1-byte buffer?

> +{
> +	return __bpf_strncat(dst, dst__sz, src, len);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784536164.gi=
t.rtoax@foxmail.com?part=3D1
