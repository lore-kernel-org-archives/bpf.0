Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43172FFF81
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184966; cv=none; b=JCSaDmDuO6auDiZbB7jXjJX1eXQzsgGoegUiZViHWZs2WoHxafZXyOr4FdRlb2Sb/lzAVtxw1h9gMb6ZA7pgjLkNx8sBVh/ecLb9tuZAGDm84Jn9QzP3TO6BNzovsy8lLQlw8CKfDwTsVx4+167IJj6wz65EVydOMAMogLhrwb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184966; c=relaxed/simple;
	bh=PIVtEwkTUT7v39g94wNLwoDflODzI3o1Vl3oPGh/Wk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cYZ1PJaUdh3znQSPkgBTZAPBxIT5qt5O/qONyRfz9nuaA+TZBAyMXGZBrCvtY59oRmmz1xxb0fdcS8dDhXf+VJMP92SGe3pSipsQJXOWWstZEVNJuMufKsAB7LAgFOzm6AcRVdrWStqyN4+H9KvMNz4SyhyZsJbDMJv7UiRC+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBM1OmNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBM1OmNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F391F000E9;
	Tue, 23 Jun 2026 03:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782184965;
	bh=6vNFTXp//mtnAWKUdw4YO1Ij4s2/jIMJFapa3ZxSF88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MBM1OmNJPnAqjhsksq84VR7KKPm48+Iv+CcY1+aKKjGktSQws0qv2vwA55g4FTRZJ
	 MnxZsyj1qWLDMQp68YIyapGWkrvCkoABjpJlj2kwTE2rKngxxHcdvDJRk2NP0YFh/I
	 vBBsSPpM603G1SLhUtSklyDAf6GZe2EWfNATGHsUymHWzwOhY1CnnY+2lFGoWUctdG
	 dRWr/WkrcNQdWJTnq61c9XawblIo66kSSzToPTt1O9VuR/pR1iOd8pXI3LZqxsPTKA
	 qcjF0bNQZJbMqCVz2vfnfHVxC3DpjKEuAcs+LNnY15acxgerbEi7z0/HlsUbpLXvD4
	 cQiOzEjNdPJZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/5] bpf: add bpf_memcmp kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623030803.44798-2-lange_tang@163.com>
References: <20260623030803.44798-1-lange_tang@163.com>
 <20260623030803.44798-2-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:22:44 +0000
Message-Id: <20260623032245.56F391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] bpf_memcmp uses signed `char` for memory comparison, violating sta=
ndard memcmp behavior and causing incorrect sorting for bytes >=3D 0x80.
- [High] Unbounded O(N^2) loop in bpf_strpbrk and bpf_strcspn can cause a k=
ernel soft lockup.
- [High] Arbitrary kernel memory read oracle via unverified `__ign` argumen=
ts in bpf_memcmp.
- [Medium] bpf_memcmp returns -1 to indicate `ptr1 < ptr2`, which collides =
with the standard error code -EPERM.
--

commit 0b32f895c504b5a659411b32505ad2719b89eec0
Author: Longjun Tang <tanglongjun@kylinos.cn>

bpf: add bpf_memcmp kfunc
   =20
Add bpf_memcmp() for binary memory comparison. Unlike bpf_strcmp,
null bytes do not terminate the comparison. Returns 0, -1, or 1.
Registered in common_btf_ids.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 8e196c9b7c50f..e444c58cad9e9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4070,6 +4070,48 @@ __bpf_kfunc int bpf_strcspn(const char *s__ign, co=
nst char *reject__ign)

[Severity: High]
Can the nested loops in bpf_strcspn() and bpf_strpbrk() cause a kernel soft
lockup?

If a BPF program passes two distinct 65,535-character strings that do not
share any characters, the inner loop executes 65,535 times and cleanly
breaks at the null byte. Because the inner loop breaks early, the outer
loop continues, resulting in up to 4.29 billion calls to
__get_kernel_nofault(). Can this stall the CPU and trigger a watchdog
timeout?

>  	return -EFAULT;
>  }
> =20
> +/**
> + * bpf_memcmp - Compare two memory regions byte by byte
[ ... ]
> + */
> +__bpf_kfunc int bpf_memcmp(const void *ptr1__ign, const void *ptr2__ign,
> +			   size_t size)

[Severity: High]
Does using the __ign suffix for these pointers bypass the BPF verifier's
pointer safety checks?

Since bpf_memcmp() takes an explicit size parameter, using __ign instead
of standard bounds-checked arguments might allow a program to pass an
unverified scalar as a kernel address, potentially creating an oracle to
read arbitrary kernel memory.

> +{
> +	const char *p1 =3D ptr1__ign, *p2 =3D ptr2__ign;
> +	char c1, c2;
> +	size_t i;
> +
> +	if (size > XATTR_SIZE_MAX)
> +		return -E2BIG;
> +	if (!copy_from_kernel_nofault_allowed(p1, size) ||
> +	    !copy_from_kernel_nofault_allowed(p2, size))
> +		return -ERANGE;
> +
> +	guard(pagefault)();
> +	for (i =3D 0; i < size; i++) {
> +		__get_kernel_nofault(&c1, p1 + i, char, err_out);
> +		__get_kernel_nofault(&c2, p2 + i, char, err_out);
> +		if (c1 !=3D c2)
> +			return c1 < c2 ? -1 : 1;

[Severity: High]
Will using signed char variables for the memory comparison result in
incorrect sorting for bytes with values of 0x80 or higher?

On architectures where char is signed, a byte with the most significant bit
set (like 0xFF) evaluates as a negative number. When compared against 0x00,
-1 < 0 evaluates to true, causing the function to incorrectly return -1.

[Severity: Medium]
Does returning -1 for a valid comparison result collide with the standard
-EPERM error code?

Since this function also returns standard negative error codes (like
-EFAULT or -E2BIG), standard BPF error checking patterns like if (ret < 0)
might mistakenly interpret a valid ptr1 < ptr2 result as an operation
failure.

> +	}
> +	return 0;
> +err_out:
> +	return -EFAULT;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623030803.4479=
8-1-lange_tang@163.com?part=3D1
