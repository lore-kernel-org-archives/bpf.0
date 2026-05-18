Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F693AC0F6
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779082284; cv=none; b=bOGBVW/xnEYZ1c+dS8nelG6rZI8Nszdm9rLMGCtTwNtx78vNAhHEBeYd4qwJIQCTlgHZs/YJCCibJPxFqVrr3HwC0pMEcfiQ2Rm+HgHOj8tv64bCkHNE69/5EMdbdzzWoYXQQOipKwpdpQQ2lc6pyhwT4r6PwUPLyHVGGeJBSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779082284; c=relaxed/simple;
	bh=ibCvXq5cqOS9Dpdz4d10BNfs2EZFKjZN8vIYj2HpMnQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M3ivXJ5ebpGie2MGrVVhDig8hgYCmiyvdCFKqqJEUj3RUikPJCFkw0huIrSMWdokZaJsN69lViGiXmnH7Afz6pspzOHbgxXAEt9hnHeo9vFR4QrLzVLduI9I7ypU24a94EFQKhb8tNRP0PcoPrB0OeSy/Ww/bIuXvl3k4Qz7Xno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3DHcbyE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3DHcbyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF28C2BCB7;
	Mon, 18 May 2026 05:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779082284;
	bh=ibCvXq5cqOS9Dpdz4d10BNfs2EZFKjZN8vIYj2HpMnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=M3DHcbyE8VmeyI8Ns6XDm2auEI0oFM6iz5Pd9fpX2oJdJPsGio/+ahQyKdX1OhJk4
	 kf3FTmb3232d7s724ECZvLtrluGlPdADXoltJXLXqQ8PU4RaIXGdadt2nYBgg70AgL
	 4cDLAa4B5ekXbgzBIiyG1L9iOV8WK38hggEMv5KsT9ey3nry3pul22YuE3l5gD3mkp
	 ov9tiikbY39VyWMdarQKVk3VBJqqzvNfGeN2hfmsshiCNKTxaVaMzZIcuY7qw3I36n
	 wJgP2uI6w70KNC/pQzxvCZc8s3womQebchAAQ19nEe0AGDEIQwXcn4+RjsdsgVuSou
	 rm6E2yaceSWYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] libbpf: fix UAF in strset__add_str()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Carlos Llamas" <cmllamas@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260518050550.2600101-1-cmllamas@google.com>
References: <20260518050550.2600101-1-cmllamas@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 05:31:23 +0000
Message-Id: <20260518053124.2EF28C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Use-After-Free in btf__add_* APIs when called with strings from bt=
f__name_by_offset on an unmodifiable BTF.
- [Medium] Undefined Behavior in pointer comparison and arithmetic potentia=
lly re-introducing UAF.
--

commit c0c79bff673db7048c82410ff03ad09f2f25dbab
Author: Carlos Llamas <cmllamas@google.com>

    libbpf: fix UAF in strset__add_str()

    strset_add_str_mem() might reallocate the strset data buffer in order to
    accommodate the provided string 's'. However, if 's' points to a string
    already present in the buffer, it becomes dangling after the realloc.

> diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
> index 2464bcbd04e03..d229961ff2fcd 100644
> --- a/tools/lib/bpf/strset.c
> +++ b/tools/lib/bpf/strset.c

[ ... ]

> @@ -107,6 +107,37 @@ static void *strset_add_str_mem(struct strset *set, =
size_t add_sz)
>  			      set->strs_data_len, set->strs_data_max_len, add_sz);
>  }
> =20
> +static long strset_str_append(struct strset *set, const char *s)
> +{
> +	const char *old_data =3D strset__data(set);
> +	long len =3D strlen(s) + 1;
> +	void *p;
> +
> +	/* Hashmap keys are always offsets within set->strs_data, so to even
> +	 * look up some string from the "outside", we need to first append it
> +	 * at the end, so that it can be addressed with an offset. Luckily,
> +	 * until set->strs_data_len is incremented, that string is just a piece
> +	 * of garbage for the rest of the code, so no harm, no foul. On the
> +	 * other hand, if the string is unique, it's already appended and
> +	 * ready to be used, only a simple set->strs_data_len increment away.
> +	 */
> +	p =3D strset_add_str_mem(set, len);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	/* The set->strs_data might have reallocated and if 's' pointed
> +	 * to an internal string within the old buffer, then it became
> +	 * dangling and needs to be reconstructed before the copy.
> +	 */
> +	if (old_data && old_data !=3D strset__data(set) &&
> +	    s >=3D old_data && s < old_data + set->strs_data_len)

Does this comparison invoke undefined behavior if old_data was freed by
realloc() inside strset_add_str_mem() or if s is an unrelated pointer?

According to the C standard, comparing or subtracting freed or unrelated
pointers using relational operators can invoke undefined behavior. Compilers
tracking pointer provenance might deduce the pointer was freed and optimize
away the bounds check entirely, bypassing the safety check.

Could these pointers be cast to uintptr_t before comparison to safely check
the bounds?

Does a similar use-after-free still exist in the btf__add_* APIs
(e.g. btf__add_str) when called with strings from btf__name_by_offset()
on an unmodifiable BTF?

If a user passes a string retrieved via btf__name_by_offset(), the
string pointer points directly into btf->raw_data.

Inside the btf__add_* APIs, btf_ensure_modifiable(btf) is called first,
which calls btf_invalidate_raw_data() and frees btf->raw_data.

Could this leave the s pointer dangling before it even reaches this
check? The check added here uses old_data which corresponds to
btf->strs_set, not the freed btf->raw_data, so it wouldn't rescue the
pointer.

> +		s =3D strset__data(set) + (s - old_data);
> +
> +	memcpy(p, s, len);
> +
> +	return len;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518050550.2600=
101-1-cmllamas@google.com?part=3D1
