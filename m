Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9AE3624DB
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784695861; cv=none; b=VPGnz4qL5MiKUDQvGEBvYDl7Wa/2o4FO8hiMlQjeEIryPIykvL00EwWDPX0DACKny5GFAIJEkeTvH/nwN8i5/ffoF6AS/VpnjHJYUIfLhan+f91lRdmd4k4C2j7nTIVDhGEbwqirg0EhP4FsXpViRTLoQufCOl2bZJ4UMiFJGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784695861; c=relaxed/simple;
	bh=6aKT56qGt9gP6AtMoeUNPQtP21GoQpUid1o8WNM8o24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oz2sMQa/kIU8Z/Norw67AKdwt23py0fsxEsZPDnTRpF7aLHjB/6E+ORnZfND/AcFEhjHY4s8OJRxNx8eXJFSdLO7ilMGxOLWWWbf5+5d41Tj/VhB4gL2pf3pwOxCHxiQc840Kym/ygvt4AnReH4C/0D6+f8b4R+PrKozdtTVnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/TqzAy5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/TqzAy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5831F000E9;
	Wed, 22 Jul 2026 04:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784695859;
	bh=tvUXmdRVnTI4OIrvBJTFvn365mDzHPzreyv+1d4mCvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C/TqzAy5Ad6GjNTyFoIeXbOKB5yizgMMxFRbJz/g6HiJKSKoIvWS+098XSxD6qL3m
	 HfsyNauBpWmql+bu+Y/Re81hjz7A1nYc+fFjXLp25aclUrdkFZxyWr9rhxhyHzWBnT
	 LYFs43b3helnPtI5cxnY80XK3I5tPQC6UyF7XM093T+AOm96k8zL21HGtPj9iEr26r
	 0WLbEkCcp2tLwRMyjB+0asn8QcM2yNyhfFxHVKEtfRF0/P861IFzm1+Vhd6JEiXy1A
	 6jPW8tE7KCFisGRPZvm3lC6qtd8fIKXgHHDra/h0hhi2H26xj+FOJCDHasSFopX156
	 Ew/RZj8NX80oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Tao" <rtoax@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_60882E4BE4F247C5F6D564F41BF1C3004805@qq.com>
References: <cover.1784695085.git.rtoax@foxmail.com>
 <tencent_60882E4BE4F247C5F6D564F41BF1C3004805@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 04:50:58 +0000
Message-Id: <20260722045059.6E5831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Missing negative error check for `bpf_strnlen()` return value =
bypasses bounds checking and allows arbitrary kernel memory overwrite.
- [Critical] A Time-of-Check to Time-of-Use (TOCTOU) vulnerability allows c=
oncurrent modifications of the source string to bypass length checks and ca=
use an out-of-bounds write.
- [High] Using signed `int` for memory offsets and sizes (`dlen` and `space=
`) can lead to integer overflow and out-of-bounds access for large buffers.
- [Medium] The `src` argument lacks the `__ign` suffix, improperly forcing =
the BPF verifier to require writable memory for a read-only string paramete=
r.
--

--- Patch [1]: [PATCH bpf-next v5 1/2] bpf: add bpf_strcat,bpf_strncat kfun=
c ---
commit 81b4bb8f85275c8fe6eaf9df04a79ae2ad9acfc4
Author: Rong Tao <rongtao@cestc.cn>

bpf: add bpf_strcat,bpf_strncat kfunc

This patch adds string concatenation kfuncs bpf_strcat and bpf_strncat.
These functions differ from glibc by requiring the target string's memory
size as a parameter.

> The src parameter cannot directly pass a string constant, such as "XYZ",
> otherwise it will throw an error "write into map forbidden".

[Severity: Medium]
Is this verifier error happening because the src parameter is missing the
__ign suffix? Functions like bpf_strncasestr use the __ign suffix to tell
the verifier that the pointer is only used for safe probe reads and does
not need to point to writable memory.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c18f1e16edee4..85afff60365c8 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4195,6 +4195,79 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ig=
n, const char *s2__ign,
>  	return __bpf_strnstr(s1__ign, s2__ign, len, true);
>  }
> =20
> +static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
> +{
> +	int dlen =3D 0, slen, space, copied;
> +
> +	if (sz =3D=3D 0 || dsz =3D=3D 0)
> +		return -EINVAL;
> +
> +	while (dlen < dsz && dst[dlen] !=3D '\0')
> +		dlen++;

[Severity: High]
What happens if dsz is very large?

Since dsz is a u32 and can represent sizes up to 4GB, but dlen is a signed
32-bit integer, could a large buffer from a BPF arena cause dlen to
overflow and become negative? This would cause dst[dlen] to access memory
at a negative offset from the start of the buffer.

> +
> +	if (dlen >=3D dsz)
> +		return -E2BIG;
> +
> +	space =3D dsz - dlen;
> +
> +	slen =3D bpf_strnlen(src, sz);
> +	if (space <=3D slen)
> +		return -E2BIG;

[Severity: Critical]
What happens if bpf_strnlen returns a negative error code like -E2BIG?

If slen is assigned a negative value and space is a positive integer, won't
the signed comparison space <=3D slen evaluate to false? This appears to
bypass the bounds check entirely when the source string is missing a null
terminator.

> +
> +	copied =3D strncpy_from_kernel_nofault(dst + dlen, src, sz);

[Severity: Critical]
Could this allow an out-of-bounds write if the source string is modified
concurrently?

If the source string is located in a BPF map shared with userspace, could a
userspace thread overwrite the null terminator after bpf_strnlen returns?
If that happens, strncpy_from_kernel_nofault will copy up to sz bytes,
which might be much larger than the remaining space, overflowing the
destination buffer.

Would it be safer to pass the constrained space or slen + 1 instead of sz?

[ ... ]

> +__bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src)
> +{
> +	return __bpf_strncat(dst, dst__sz, src, dst__sz);
> +}

[Severity: Medium]
Should the src parameter be named src__ign here to bypass the writability
checks mentioned in the commit message?

[ ... ]

> +__bpf_kfunc int bpf_strncat(char *dst, u32 dst__sz, const char *src, u32=
 len)
> +{
> +	return __bpf_strncat(dst, dst__sz, src, len);
> +}

[Severity: Medium]
Similarly, does this src parameter also need the __ign suffix to allow
read-only string constants to be passed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784695085.gi=
t.rtoax@foxmail.com?part=3D1
