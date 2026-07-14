Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7417A300
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025720; cv=none; b=hWkAA4/coWidF3BOrcHlZolAa4IsVHtDsHzMHWgRu7SPukOrR/gvC52OyITm/bx4+cYLNwZ6HGM+dgMY7EwSKu+qrvDNia3KnnweShssnI88OlULH+SARTZ77uWqmR8tUJWjC2Lc1aLqha0aF4TC01E1TZyWVZA13rQGay11tS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025720; c=relaxed/simple;
	bh=5A7gkjxxqVt3PUjopZf+P8ojYfIWpwI1E0v+QZvZFR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UsjbQjXd+JzQD2ew4MBtiKyeDU0CvXYHlHoIKQ7N6etaux5WdqbBoSPKlj6X1kMZ5ZD9plRSS78zBdz02C6cLsiG52x5wtPsXeKDQyXJBwECBk16lMtcFLTf5XDsP0p+rE1R739a8imQBKDc7Ro6i3BY0gX/xkxwW8U0wXMi11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omECVR0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omECVR0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC8B1F000E9;
	Tue, 14 Jul 2026 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784025718;
	bh=pOzWR9Cm1ZQa1hsYIqSABGfKH3OnyF0J82LiaEXOCJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=omECVR0moGW4ofZLnuIboNxvAqhdRzH3igcz/BgtS7wSONI9jVNrZqL9ZDrO+1h9P
	 Q1I3+0LD+AocCgpQn+tcYxnU66ScA5HRy8MdfDwAhAtoY39UG7peKDtGqx64O7eE9w
	 agvWDG5WsTlOBAVfXj7jHqq4etLVmMmCk1GkVSUigAQXxcGtc8eWQ5jxacIWncLFbo
	 a24aY+g3Z0iG9Zw+oOGLUhtJrL4SdtFfkdE8oBcmBpa1iH5kMhli5lLryPb4GUKXZE
	 1R2BRqiwM8xIq0dpVGVvEtuap1+yqECQJoyNw7S6xvkH5YaqsLghvtE/DZmiVi9Dnu
	 7E8uTidFol79w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_strcat,bpf_strncat
 kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Tao" <rtoax@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_FB0E71C06045E8278BE9B254A5E7756D7405@qq.com>
References: <cover.1784021302.git.rongtao@cestc.cn>
 <tencent_FB0E71C06045E8278BE9B254A5E7756D7405@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:41:58 +0000
Message-Id: <20260714104158.BBC8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The `bpf_strcat` and `bpf_strncat` kfuncs use the `__ign` suff=
ix for their destination pointer arguments, bypassing the BPF verifier's sa=
fety checks and creating an arbitrary kernel memory write vulnerability.
- [Medium] `__bpf_strncat` performs out-of-bounds reads on the source strin=
g by ignoring the user-provided limit during length calculation and uncondi=
tionally fetching an extra byte after the copy loop.
- [Low] The API documentation for `bpf_strcat` and `bpf_strncat` incorrectl=
y states they return the total length of the concatenated string.
--

--- Patch [2]: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_strcat,bpf_strn=
cat kfuncs ---
commit a7b2e5fa67dde4d93faf939b8283a2aa59b8ca2d
Author: Rong Tao <rongtao@cestc.cn>

bpf: add bpf_strcat,bpf_strncat kfunc

Add string concatenation kfuncs bpf_strcat and bpf_strncat. This allows
BPF programs to concatenate strings, differing from glibc by requiring
the target string's memory size for safety.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c18f1e16edee4..e99b643136822 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -4195,6 +4195,95 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ig=
n, const char *s2__ign,
>  	return __bpf_strnstr(s1__ign, s2__ign, len, true);
>  }
> =20
> +static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
> +{
> +	int dlen, slen, space, copied;
> +	char cs =3D '?';
> +
> +	if (!copy_from_kernel_nofault_allowed(dst, 1) ||
> +	    !copy_from_kernel_nofault_allowed(src, 1)) {
> +		return -ERANGE;
> +	}
> +
> +	dlen =3D bpf_strnlen(dst, XATTR_SIZE_MAX);
> +	if (dlen < 0)
> +		return dlen;
> +	slen =3D bpf_strnlen(src, XATTR_SIZE_MAX);

[Severity: Medium]
Does this calculate the length of the source string past the user-provided
limit sz?

If src is exactly sz bytes long and not null-terminated, won't this read
out of bounds up to XATTR_SIZE_MAX and potentially return -EFAULT?

> +	if (slen < 0)
> +		return slen;
> +
> +	if (dlen >=3D dsz || sz =3D=3D 0 || dsz =3D=3D 0)
> +		return -EINVAL;
> +
> +	space =3D dsz - dlen;
> +	if (space <=3D 1 || space < min(slen, sz) + 1)
> +		return -E2BIG;
> +
> +	for (copied =3D 0; copied < space - 1 && copied < sz; copied++) {
> +		__get_kernel_nofault(&cs, src, char, err_out);
> +		if (cs =3D=3D '\0')
> +			break;
> +
> +		__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
> +
> +		src++;
> +	}
> +	cs =3D '\0';
> +	__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
> +
> +	__get_kernel_nofault(&cs, src, char, err_out);

[Severity: Medium]
If the copy loop ends because copied =3D=3D sz, does this unconditional read
fetch an extra byte from the advanced src pointer?

Could this cause an out-of-bounds read and a false -EFAULT failure?

> +	if (cs !=3D '\0' && sz > copied)
> +		return -E2BIG;
> +
> +	return copied;
> +err_out:
> +	return -EFAULT;
> +}
> +
> +/**
> + * bpf_strcat - Append non-null bytes from a source string, and null-ter=
minate
> + *              the result
> + * @dst__ign: Destination string.
> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
> + * @src__ign: Source string.
> + *
> + * Return:
> + * * >=3D0      - Length of the concatenated string.

[Severity: Low]
Is this documentation misleading?

It claims to return the length of the concatenated string, but __bpf_strncat
returns copied, which is the number of newly appended characters.

> + *
> + * * %-EINVAL - String @dst__ign is invalid.
> + * * %-EFAULT - Cannot read or write one of the strings.
> + * * %-E2BIG  - String @src__ign is too large or the remaining space in
> + *              @dst__ign is too small.
> + * * %-ERANGE - One of the strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strcat(char *dst__ign, u32 dst__sz, const char *src_=
_ign)

[Severity: Critical]
Does the __ign suffix on dst__ign bypass the BPF verifier's safety checks?

Since is_kfunc_arg_ignore() in kernel/bpf/verifier.c skips validation for
arguments with the __ign suffix, can a BPF program pass an arbitrary kernel
address (like modprobe_path) instead of a validated PTR_TO_MEM, allowing an
arbitrary kernel memory write?

> +{
> +	return __bpf_strncat(dst__ign, dst__sz, src__ign, XATTR_SIZE_MAX);
> +}
> +
> +/**
> + * bpf_strncat - Append non-null bytes from a source string, and null-te=
rminate
> + *               the result
> + * @dst__ign: Destination string.
> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
> + * @src__ign: Source string.
> + * @len: the maximum number of characters to concatenate
> + *
> + * Return:
> + * * >=3D0      - Length of the concatenated string.
> + *
> + * * %-EINVAL - String @dst__ign is invalid.
> + * * %-EFAULT - Cannot read or write one of the strings.
> + * * %-E2BIG  - String @src__ign is too large or the remaining space in
> + *              @dst__ign is too small.
> + * * %-ERANGE - One of the strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strncat(char *dst__ign, u32 dst__sz, const char *src=
__ign,
> +			    u32 len)

[Severity: Critical]
Does the dst__ign parameter here also bypass verifier safety checks for the
same reason, allowing arbitrary memory writes?

> +{
> +	return __bpf_strncat(dst__ign, dst__sz, src__ign, len);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784021302.gi=
t.rongtao@cestc.cn?part=3D2
