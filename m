Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09325B0AF
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184861; cv=none; b=sAY+nTH4qzFTPgDOjkGq2yf/2pzD49yzTiS49u/KL89PO+mSJU4EEP7zHdh2bsTDUJosb8axr+ooNNTnpwLRXYSFF7L/WzaL3XCNm4Rd+nP/bsVM1oiED6uWOnbMgDzvsSoaRueMImTu51eD/Oor94ukYjycwCyQ+EC+oMfn5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184861; c=relaxed/simple;
	bh=KQsISFNxKuiGdhvr/o/oRiIyhV5jeoYjmFMw4uARJ5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WIuRh7OBCIRnUa9LlUAl1dbIwrUdnUxo5sfEgRxrlfSsnrjiHB5qYu9VhsPoTq2iicFfcDIYgM6rJLuyEuRTzyK/My2kf1XaluqiI3wFNG2ftUUpl9hxQNdHL58Pttg9qgF6G8+YKP1C8a0Tr41UVcNHfQpsHWQKpt0xXdvMtQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHMgfqkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHMgfqkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC431F000E9;
	Tue, 23 Jun 2026 03:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782184859;
	bh=p8HudXteWp7NEbst5HIXqYsCfsQUREkn2l7/wrEcjio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cHMgfqkKIe3wuTxC+nZElAW8XzpQl7TL/qDaIx7bm2GsnOD4ipKadl/srY9rNWGTY
	 5N1zEmb4/AZQWrl7RhUKxX+J1CdzRS3lwel2B/Wa06omuwE/9mA3V/JxKaXlGP3yZ6
	 vh3nG5DpEBq6TwtIJDKv4JZ+WLiqfQBaCjp2rQL01DX8XrhqUUBUxq9dG2q853ZPZd
	 QMhjfnwDm4DMGufMUFh6EYBOzWd9li+6v8Tbql2iat9/LGC/UwhKnXAq1pCKdVnzdV
	 Pkbtb7qWJAog8DBtLul2GjaMWJI7gbOEHM3b01rKjTAmWhjffpG9rpfoX7evuGUzQv
	 W2/vWtmTqwf0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/5] bpf: add bpf_strpbrk kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623030803.44798-5-lange_tang@163.com>
References: <20260623030803.44798-1-lange_tang@163.com>
 <20260623030803.44798-5-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:20:58 +0000
Message-Id: <20260623032059.5EC431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] O(N*M) worst-case time complexity in `bpf_strpbrk` allows for unpr=
ivileged CPU soft lockup, bypassing BPF verifier limits.
- [High] The validation of `s__ign` and `accept__ign` only checks the first=
 byte, allowing pointers to wrap around the address space boundary.
- [Low] Duplicate `bpf_memcmp` kernel-doc block mistakenly included before =
`bpf_strpbrk`.

Pre-existing issues:
- [High] O(N^2) worst-case time complexity in `bpf_strcspn` allows for unpr=
ivileged CPU soft lockup.
--

commit 6710699312c85ee398aba5d00ff7694b56ae2a3c
Author: Longjun Tang <tanglongjun@kylinos.cn>

bpf: add bpf_strpbrk kfunc

Add bpf_strpbrk() that returns the index of the first character in a
string matching any character from the accept set, or -ENOENT.
Complements the existing strspn/strcspn kfuncs for string tokenization.
Registered in common_btf_ids.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e444c58cad9e9..34b7a9993c0c9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4070,6 +4070,67 @@ __bpf_kfunc int bpf_strcspn(const char *s__ign, co=
nst char *reject__ign)

[Severity: High]
This is a pre-existing issue, but does bpf_strcspn() have a similar
time complexity issue?

Looking at the existing bpf_strcspn() in kernel/bpf/helpers.c:

__bpf_kfunc int bpf_strcspn(const char *s__ign, const char *reject__ign)
{
	...
	guard(pagefault)();
	for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
		__get_kernel_nofault(&cs, s__ign, char, err_out);
		...
		for (j =3D 0; j < XATTR_SIZE_MAX; j++) {
			__get_kernel_nofault(&cr, reject__ign + j, char, err_out);
			...
		}
		...
	}
	...
}

Like the new bpf_strpbrk() function, calling bpf_strcspn() with two long
strings that share no characters could also result in roughly 4 billion mem=
ory
reads while page faults are disabled. Could this also cause a multi-second =
CPU
stall per call?

>  	return -EFAULT;
>  }
> =20
> +/**
> + * bpf_memcmp - Compare two memory regions byte by byte
> + * @ptr1__ign: First memory region
> + * @ptr2__ign: Second memory region
> + * @size: Number of bytes to compare
> + *
> + * Compares the first @size bytes of the memory areas @ptr1__ign and
> + * @ptr2__ign. Unlike bpf_strcmp, null bytes do not terminate the compar=
ison.
> + *
> + * Return:
> + * * %0       - The memory regions are equal
> + * * %-1      - @ptr1__ign is less than @ptr2__ign
> + * * %1       - @ptr1__ign is greater than @ptr2__ign
> + * * %-EFAULT - Cannot read one of the memory regions
> + * * %-E2BIG  - @size exceeds the maximum allowed size
> + * * %-ERANGE - One of the memory regions is outside of kernel address s=
pace
> + */

[Severity: Low]
This isn't a bug, but it looks like the kernel-doc block for bpf_memcmp() w=
as
accidentally duplicated here instead of providing documentation for the new
bpf_strpbrk() kfunc.

> +/**
> + * bpf_strpbrk - Find the first occurrence of a set of characters in a s=
tring
> + * @s__ign: The string to be searched
> + * @accept__ign: The string containing the characters to search for
> + *
> + * Return:
> + * * >=3D0      - Index of the first character in @s__ign that matches a=
ny
> + *              character in @accept__ign
> + * * %-ENOENT - No character of @accept__ign found in @s__ign
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of the strings is too large
> + * * %-ERANGE - One of the strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strpbrk(const char *s__ign, const char *accept__ign)
> +{
> +	char cs, ca;
> +	int i, j;
> +
> +	if (!copy_from_kernel_nofault_allowed(s__ign, 1) ||
> +	    !copy_from_kernel_nofault_allowed(accept__ign, 1)) {
> +		return -ERANGE;
> +	}

[Severity: High]
Does this validation prevent pointers from wrapping around the address space
boundary?

Since only 1 byte is checked here by copy_from_kernel_nofault_allowed(), but
the function reads up to XATTR_SIZE_MAX bytes in the loop below, if a caller
passes a pointer near the end of the address space (such as ULONG_MAX - 10),
could the pointer increment and wrap around to 0x0?

This could allow a BPF program to bypass the kernel memory isolation bounda=
ry
and read user-space memory instead of kernel memory.

> +
> +	guard(pagefault)();
> +	for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> +		__get_kernel_nofault(&cs, s__ign, char, err_out);
> +		if (cs =3D=3D '\0')
> +			return -ENOENT;
> +		for (j =3D 0; j < XATTR_SIZE_MAX; j++) {
> +			__get_kernel_nofault(&ca, accept__ign + j, char, err_out);
> +			if (ca =3D=3D '\0')
> +				break;
> +			if (cs =3D=3D ca)
> +				return i;
> +		}
> +		if (j =3D=3D XATTR_SIZE_MAX)
> +			return -E2BIG;
> +		s__ign++;
> +	}

[Severity: High]
Can this nested loop cause a CPU soft lockup?

Because both loops iterate up to XATTR_SIZE_MAX (65536) times, calling this
with two long strings that don't share any characters could result in over
4 billion memory accesses via __get_kernel_nofault().

Since guard(pagefault)() disables page faults and preemption, could this st=
all
the CPU for several seconds and bypass the BPF verifier's execution time
limits?

> +	return -E2BIG;
> +err_out:
> +	return -EFAULT;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623030803.4479=
8-1-lange_tang@163.com?part=3D4
