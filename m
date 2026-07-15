Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383FE42BC2D
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079638; cv=none; b=oQrNhugf4dYErx8fgwrfp7sWtSlH5YhWNEE9/ruHZSil+f6UtRHIKWVC7pJWSDAEYUwu2YjzyjcnlDf0x8J649nUoa2dk99Zqojb24BNuCAutTLSIHmEoBY6e3+5GKdUPOyegk1UEVtdjArKXEMxdDdPdLvcLgcBy+8/dhztG+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079638; c=relaxed/simple;
	bh=tFlgfgup/umEW9I8LMFEujhd3gpVsLyx4sygYHQLOlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yt077uUCvp+srQuZzWd0eDkpKcTxf8hcA6SMKMYrs19+g+csZBpeA2Yl/No9vWGHVKcFpSMKpurwqlFjrlzcoRaxgi5R+Zt8CqwnhZmoNFixlWwjhJjBGF+cHkR25Q+PqI8PCidd5jHNQ6DRajFlEOYWpuQIFGCH5y42xr259i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbaHopaS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbaHopaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00561F000E9;
	Wed, 15 Jul 2026 01:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784079636;
	bh=63P/R4dQC93pn1YyD1fPSYAbeDgJQdFr70QcPh1/ogE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IbaHopaSDvqXGgJ0idiksQZGXL2N26wAzBTdrFL5098qeqUrdgYMU0bDhd9dmaugS
	 AUwSEVTc/HJb6iZ7Wxb1wPjh1K+t7UEfeSz6jJ/A9FSWAEKjz/Gu3RWdhkAhliFoyc
	 WDzuCJVDoHomiFZxcVfrgLCm/Y4WiZmmHDe1R9DZqtPR5Y/4sPfKY25xC0D9kgBNeB
	 wqEqiY0yquYN9Bu0jpl3t7NlPKHQX2UZMI4Q6LmKCTd7zTjevi7ofQM2Z7DggNw0d/
	 96yyJIaOw6fLJS1rHuUnGa2zEBxpQuxMwbqLhlMrIjHGCmfxOocYl+c+XKfZkN4r/X
	 ccV3NmtZEmpQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Tao" <rtoax@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_9EC04DC824CBF5124305E73564341511C405@qq.com>
References: <cover.1784078494.git.rtoax@foxmail.com>
 <tencent_9EC04DC824CBF5124305E73564341511C405@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 01:40:36 +0000
Message-Id: <20260715014036.B00561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] bpf_strncat unconditionally reads one byte beyond the caller-speci=
fied source limit (len) after the copy loop, causing a spurious -EFAULT if =
the source buffer ends at a page boundary.
- [Medium] The destination string is left completely non-null-terminated if=
 a memory fault occurs during the copy loop.
- [Medium] Integer overflow in the `space` calculation causes spurious `-E2=
BIG` failures for destination buffers larger than 2GB.
--

--- Patch [1]: [PATCH bpf-next v2 1/2] bpf: add bpf_strcat,bpf_strncat kfun=
c ---
commit 638de7ac547b3d0857f680c3e68dbfcae6e2543c
Author: Rong Tao <rongtao@cestc.cn>

bpf: add bpf_strcat,bpf_strncat kfunc

This patch adds string concatenation kfuncs bpf_strcat and bpf_strncat to
the BPF subsystem. These functions allow appending non-null bytes from a
source string to a destination string with size limits.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c18f1e16edee4..401f94efd687c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> @@ -4195,6 +4195,96 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ig=
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
> +	dlen =3D bpf_strnlen(dst, dsz);
> +	if (dlen < 0)
> +		return dlen;
> +	slen =3D bpf_strnlen(src, sz);
> +	if (slen < 0)
> +		return slen;
> +
> +	if (dlen >=3D dsz || sz =3D=3D 0 || dsz =3D=3D 0)
> +		return -EINVAL;
> +
> +	space =3D dsz - dlen;
> +	if (space <=3D 1 || space < min(slen, sz) + 1)
> +		return -E2BIG;

[Severity: Medium]
Will this calculation overflow if dsz is greater than or equal to 2GB?

Since space is a signed int and dsz is a u32, dsz - dlen can result
in a negative number for large destination buffers, such as those from a
BPF arena. A negative value satisfies the space <=3D 1 check, causing the
function to incorrectly abort and return -E2BIG.

> +
> +	guard(pagefault)();
> +	for (copied =3D 0; copied < space - 1 && copied < slen; copied++) {
> +		__get_kernel_nofault(&cs, src, char, err_out);
> +		if (cs =3D=3D '\0')
> +			break;
> +
> +		__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);

[Severity: Medium]
Does this leave the destination string non-null-terminated if a memory fault
occurs during the copy?

If the loop copies at least one character (overwriting the destination's
original null terminator) and then a subsequent read or write triggers a
page fault, the code jumps directly to err_out without restoring a null
terminator.

While it returns an error, BPF programs that do not check the return value
might operate on corrupted state.

> +
> +		src++;
> +	}
> +	cs =3D '\0';
> +	__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
> +
> +	__get_kernel_nofault(&cs, src, char, err_out);
> +	if (cs !=3D '\0' && sz > copied)
> +		return -E2BIG;

[Severity: High]
Can this unconditionally read one byte beyond the caller-specified limit sz?

When the copy loop finishes, copied may equal sz. The pointer src will
have been incremented sz times. If the original src buffer is exactly
sz bytes and ends at a page boundary, this read will trigger a page fault,
causing a spurious -EFAULT return.

Additionally, if copied =3D=3D sz, the subsequent sz > copied check evaluat=
es
to false anyway, making the read unnecessary in that case.

> +
> +	return dlen + copied;
> +err_out:
> +	return -EFAULT;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784078494.gi=
t.rtoax@foxmail.com?part=3D1
