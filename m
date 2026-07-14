Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BA036492A
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024374; cv=none; b=L31aCsbE/B65hBu6MTHIEg+qhH/NiYJQjlpmhNZ4Z2INrTtczzM35Hx+Xtr8fGSTMYrz9RpBWAYG2RCM2s1PD4+9tvB01njI+Z46Wu7IF9LNOaMCY/AOJOFRDtAwv9+jDMbKZaab4OE1aK0bnDjhFIq+tlHk/BFXcDgGceHy9oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024374; c=relaxed/simple;
	bh=u9kcBbIaszkd8/pWZ3oWtJ7KW87Gtk32GB1zoydXttQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jIOy3op1jRd8POaC3/eY0kTkUqtCiNCvdIehWAhymzeVOFCk5PsiXqaIcZUcDAic7cFwNBeeUVUHyDEOkEZdN0p/cEVsLeB2gWR+MWJwihoIDKS8kJ3qUy6vjqMr46eMK2DUNJ5rqD8PDsvtCsxaOVQJu6rBBehmebiTOzMMOe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdU9EGrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdU9EGrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD381F000E9;
	Tue, 14 Jul 2026 10:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784024373;
	bh=pOySnvlciH8zvefst10OFK+Mj6nmoL9r9Rnh9c/PEI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cdU9EGrwKy/1lBcNNBcOSndbgj/EWfPQ4XT5hbBBmGzIkHS8Bjf4FaeWl/rur5oBM
	 TLNq6VMzF/zE+B2ySWmzMH+rPovOolHWZWBtMqOTsfuwmqO/JH0ngXE35rNGTj7R0v
	 eihJEkLfYnN6kjiPTX1hSwGQBu8ajzBiV6NwsYiIO9nE2nHWbGdJhAcx80INc11et8
	 a93RntCTuY+/C4m0XSQ7ZPIyY39CyGiK2mQ5+MT3NylesAkVkZ0qpJreH6IS0pffQj
	 ErR/LaIfkq71uuoGo+6TQWQJpYjodmJAGafn7rpEkGSxRtbASYKqfDFVwqpwuC2sbk
	 Iw1NZvPKplzFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Tao" <rtoax@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_59689407B1C3204B08362BEEF244A5FE5505@qq.com>
References: <cover.1784021302.git.rongtao@cestc.cn>
 <tencent_59689407B1C3204B08362BEEF244A5FE5505@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:19:32 +0000
Message-Id: <20260714101933.4AD381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Arbitrary Kernel Memory Write via Verifier Bypass
- [High] Missing page fault protection leading to sleeping in atomic context
- [High] Time-Of-Check to Time-Of-Use (TOCTOU) race leading to unbounded lo=
op and soft lockup
- [Medium] Unbounded out-of-bounds read on destination buffer
- [Medium] Unbounded out-of-bounds read on source buffer
--

--- Patch [1]: [PATCH bpf-next 1/2] bpf: add bpf_strcat,bpf_strncat kfunc -=
--
commit a7b2e5fa67dde4d93faf939b8283a2aa59b8ca2d
Author: Rong Tao <rongtao@cestc.cn>

bpf: add bpf_strcat,bpf_strncat kfunc

This commit introduces bpf_strcat and bpf_strncat kfuncs to allow string
concatenation in BPF programs. It requires the destination buffer size as a
parameter for safety.

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

[Severity: Medium]
Does this code perform an unbounded read on the destination buffer? The lim=
it
should be bounded by the provided size dsz, rather than statically set to
XATTR_SIZE_MAX.

> +	if (dlen < 0)
> +		return dlen;
> +	slen =3D bpf_strnlen(src, XATTR_SIZE_MAX);

[Severity: Medium]
Does this scan read out-of-bounds on the source buffer? The limit could be
bounded by the requested copy length sz rather than unconditionally reading
up to XATTR_SIZE_MAX.

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

[Severity: High]
Does this code introduce a Time-Of-Check to Time-Of-Use race? The loop boun=
ds
omit checking copied < slen, relying entirely on encountering a null
terminator.

If a concurrent thread modifies the source buffer to remove the null termin=
ator
after bpf_strnlen() executes, could this loop run out of bounds and lead to=
 a
soft lockup?

> +		__get_kernel_nofault(&cs, src, char, err_out);

[Severity: High]
Does this sequence lack page fault protection? Unlike other string helpers,
__bpf_strncat() fails to wrap its memory accesses in guard(pagefault)().

If a BPF program executing in a non-sleepable context calls this on an unma=
pped
address, it seems the generic page fault handler will attempt to take sleep=
able
locks.

> +		if (cs =3D=3D '\0')
> +			break;
> +
> +		__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);

[Severity: Critical]
Can this write to arbitrary kernel memory? The function writes to the unche=
cked
destination pointer.

Because the bpf_strcat() kfunc signature uses the __ign suffix for dst__ign,
verifier safety checks are bypassed. Any user capable of loading BPF progra=
ms
could potentially use this to write user-controlled bytes to arbitrary kern=
el
memory.

> +
> +		src++;
> +	}
[ ... ]
> +__bpf_kfunc int bpf_strcat(char *dst__ign, u32 dst__sz, const char *src_=
_ign)

[Severity: Critical]
Does the dst__ign argument bypass verifier checks? The __ign suffix explici=
tly
instructs the BPF verifier to ignore this argument, which removes all memory
safety and bounds checks for the destination pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784021302.gi=
t.rongtao@cestc.cn?part=3D1
