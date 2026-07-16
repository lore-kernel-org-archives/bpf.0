Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E73F7892
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195228; cv=none; b=SfvAj+Q1rqTvE+Gin3IBmt4n2vU6WBlZki/x3k9Izrr/pZPlwdBjUXzS3AA085AHF8gkOJ5RRAzQXYGoehBxUNKGDl4WGcuGfIHCF6Jr5UqBJ2NHnMJxaFjKEqd1uWRVXrw/T4c4Fi+vnd+gj01IY4F/yAalIr9jAxJ9kXxYwCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195228; c=relaxed/simple;
	bh=vNNybktqxAbBh67LNocLCWTUqvL+R0eyHkqEyYasg+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EoXrMH3h1sGaMATlaWYawnfQkANtXNyUCY9078lCix27YDGQaOPYvxtzrnnQvUIeBs6yFmVxCd9j9gN8hYsvIkJ/LTlbC1+FRLSn2TP6eh4AxyerOkyAzZmKPw4w+tCDjANtWSlbPJ7Cq1gKbNPafAUTori6UCiNK3C3AsFYSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9zSRodm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9zSRodm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE1C1F00A3A;
	Thu, 16 Jul 2026 09:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784195225;
	bh=IT5KH23yKQIvxDJELktcTsYAA+LYw/gcIdFzG6Q3a30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B9zSRodmlSPZVA2XPgNp2R6qeVUhAwzC0RbLbjbRiUY0x0bqWdTyaa9dyI44qGqDz
	 b+zrykGgAQhhVyFLN2LfSgls9C2Sj2WBEw5QbwWgdY8Bk8OmKZ1YXTAe1rlAZtmrcs
	 VNkVS1p2SqH4FIop1WPk+SUPzgEamw+Beaxg2aKU5/4T5RTdaf/lrRseAMOnnNfqjn
	 sHdm0khs5EDozEtPmfUboJqi8iDnh6vbuaJzrZpDPgtaNAEQ3pxM3JNdzer+o+zNrq
	 rUdPBgApJ1BnM/lksGOdnxOdzmefDk7v9qXOGVq+OdMegjenmW0WFD7+CzwQehzg23
	 5ejWpDNAxUHCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Tao" <rtoax@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_7B0E22F21BB4086D66815C86AA5CBC5E8E0A@qq.com>
References: <cover.1784194024.git.rtoax@foxmail.com>
 <tencent_7B0E22F21BB4086D66815C86AA5CBC5E8E0A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:47:04 +0000
Message-Id: <20260716094704.CBE1C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] bpf_strncat performs a 1-byte out-of-bounds read on the source str=
ing when it is not null-terminated within the requested length, causing a s=
purious -EFAULT.
- [High] The bpf_strcat and bpf_strncat kfuncs use the __ign suffix for the=
 src argument, bypassing BPF verifier bounds checks and allowing an out-of-=
bounds kernel memory leak.
- [Medium] An integer overflow in the size calculation causes bpf_strncat t=
o silently fail to concatenate data when len is U32_MAX.
- [Medium] bpf_strncat incorrectly returns -E2BIG when appending an empty s=
tring to a destination buffer that has exactly 1 byte of space left.
--

--- Patch [1]: [PATCH bpf-next v3 1/2] bpf: add bpf_strcat,bpf_strncat kfun=
c ---
commit e639d69440b707ef0e2d79161ec02f7c90946207
Author: Rong Tao <rongtao@cestc.cn>

bpf: add bpf_strcat,bpf_strncat kfunc

This commit introduces string concatenation kfuncs, bpf_strcat and
bpf_strncat, which take the destination buffer size as a parameter for safe=
ty.
It differs from the glibc library functions to ensure bounded string operat=
ions
in BPF programs.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c18f1e16edee4..e4708a4f3470a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> +static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
> +{
> +	int dlen, slen, space, copied;
> +	char cs;
[ ... ]
> +	space =3D dsz - dlen;
> +	if (space <=3D 1 || space < min(slen, sz) + 1)
> +		return -E2BIG;

[Severity: Medium]
Does this incorrectly reject appending an empty string when the destination
buffer is exactly full?

If a BPF program attempts to append an empty string and space =3D=3D 1 (lea=
ving
just enough room for the existing null terminator), the space <=3D 1 condit=
ion
evaluates to true and unconditionally returns -E2BIG instead of successfully
returning the original length.

> +
> +	guard(pagefault)();
> +
> +	copied =3D strncpy_from_kernel_nofault(dst + dlen, src,
> +				      min(space, sz + 1));

[Severity: High]
Can this perform an out-of-bounds read on the source string?

If a BPF program calls bpf_strncat() with a sz parameter that exactly
matches the size of a source buffer lacking a null terminator, the expressi=
on
sz + 1 forces strncpy_from_kernel_nofault() to read one byte past the
requested length. This could trigger a spurious -EFAULT if the buffer ends =
at
a page boundary.

[Severity: Medium]
Also, does the size calculation suffer from an integer overflow?

If a BPF program passes U32_MAX for the sz argument to append up to the
maximum possible string length, the expression sz + 1 overflows to 0 in
32-bit unsigned arithmetic. This results in strncpy_from_kernel_nofault()
being called with a copy count of 0, returning success without actually
appending any data.

> +	if (copied < 0)
> +		return copied;
[ ... ]
> +/**
> + * bpf_strcat - Append non-null bytes from a source string, and null-ter=
minate
> + *              the result
[ ... ]
> + */
> +__bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src__ign)
> +{
> +	return __bpf_strncat(dst, dst__sz, src__ign, XATTR_SIZE_MAX);
> +}

[Severity: High]
Does the __ign suffix on the source string argument bypass BPF verifier
bounds checks?

The __ign suffix tells the verifier to ignore size constraints that normally
apply to memory pointers. A BPF program could pass a pointer to a small
allocated region (like a 4-byte map value) along with a large len parameter,
allowing strncpy_from_kernel_nofault() to read past the buffer into adjacent
kernel memory until a null byte is encountered.

This would leak out-of-bounds kernel memory into the user-accessible dst
buffer.

> +
> +/**
> + * bpf_strncat - Append non-null bytes from a source string, and null-te=
rminate
> + *               the result
[ ... ]
> + */
> +__bpf_kfunc int bpf_strncat(char *dst, u32 dst__sz, const char *src__ign,
> +			    u32 len)
> +{
> +	return __bpf_strncat(dst, dst__sz, src__ign, len);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784194024.gi=
t.rtoax@foxmail.com?part=3D1
