Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3293B5F59
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759831; cv=none; b=YI6ihrDcLuWE4LsJ2DUittgNtSOTOQTjBHhi/LI+e5AgSA0sU3ETuX5qk3mvcLCtuo41mpV3W/CvV9x/Ki8hSddDaaZiUT95pttMh3l/syR0IJpc5f+Cv04e5YqHhv8jsJmzcQNRnwQE3xukj2+jaZN4zr1Gyp1pcGXg9CptjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759831; c=relaxed/simple;
	bh=8PnSM1ey3VNPGdaQ2G3QZUJgUSF7cWcPKAZsyhmLQfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rlm80+N4jfVFtYc919QGm0AyWPRgrYnwOUrpMmCn8YPdzt6XSvycm+UKCkU+Ooykzso3Csvc8+FMv8ezopxjiS1b1OzpAes+D6IleJmg0BCshfGqPYNcpVAXigLgfN7KLigYHfdsbJwyXvFG/16rspRVBMRm6cqkwB127vTtKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3zd85uB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3zd85uB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133F4C2BCB3;
	Thu, 14 May 2026 11:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778759831;
	bh=8PnSM1ey3VNPGdaQ2G3QZUJgUSF7cWcPKAZsyhmLQfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=A3zd85uBcvzQhXdQ1ygAa+T262MN+wptPFU49CugFgklxWFMh7Gqtbpdh/EGib9KK
	 1eja6ga0TcnUwYC+CqCciUv2RtEMenPbTjc1YBt7n0cMGFxEusA1nSOijaZrD0kLSb
	 U3Uzo6/FwtLQQWI93+Gc7uuJerslcf1wkEeKwhefoPDQpKJPiQbKMgZBZRTVi2gCn3
	 labZ6X8OTjwPUjv4CbiKugut7a/0g5WocCyehNfq6uMTwlH+vg2mP1vdjF8R+ESmpt
	 8QtTOqHVKL366zfcEdI60VW7IzNntSGr3DK893m0BIjZFAWXh3aUiKZLy+5uKOu7iZ
	 /Q9jRfpiFFp4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] libbpf: fix UAF in strset__add_str()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Carlos Llamas" <cmllamas@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513232055.1681859-1-cmllamas@google.com>
References: <20260513232055.1681859-1-cmllamas@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 11:57:10 +0000
Message-Id: <20260514115711.133F4C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unpatched Use-After-Free in strset__find_str()
- [High] Use-After-Free in BTF add APIs due to btf_ensure_modifiable() free=
ing raw_data
- [Medium] Early return in strset__add_str() breaks hash map deduplication =
invariants
--

commit 2a7bfcb093726b849608e340f9bda7c5e3f56ac2
Author: Carlos Llamas <cmllamas@google.com>

libbpf: fix UAF in strset__add_str()

This commit addresses a heap-use-after-free in strset__add_str() that occurs
when the provided string points into the internal strset data buffer.
It adds a boundary check to return the offset directly if the string is
already within the buffer, avoiding a dangling pointer during reallocation.

[ ... ]
>  |     #0 0x55d25155a2a7 in memcpy (tools/bpf/resolve_btfids/resolve_btfi=
ds+0xcf2a7)
>  |     #1 0x55d2515d708e in strset__add_str tools/lib/bpf/strset.c:162:2
>  |     #2 0x55d2515c730b in btf__add_str tools/lib/bpf/btf.c:2109:8
>  |     #3 0x55d2515c9020 in btf__add_func_param tools/lib/bpf/btf.c:3108:=
14
[ ... ]

Does btf__add_str() have another use-after-free when operating on a
non-modifiable BTF object?

If a user calls btf__add_str(btf, s) where s is a pointer returned by
btf__name_by_offset() (which points into btf->raw_data),
btf_ensure_modifiable(btf) is called.

btf_ensure_modifiable() allocates new buffers and calls
btf_invalidate_raw_data(btf), which frees btf->raw_data.

At this point, the argument s becomes a dangling pointer before
strset__add_str() is even called, making the boundary check added by this
patch evaluate against the freed raw_data.

> diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
> index 2464bcbd04e03..7d2b2784172e5 100644
> --- a/tools/lib/bpf/strset.c
> +++ b/tools/lib/bpf/strset.c
> @@ -141,10 +141,15 @@ int strset__find_str(struct strset *set, const char=
 *s)

Does strset__find_str() suffer from the same vulnerability being fixed here?

It follows the exact same pattern as strset__add_str(): it temporarily
appends s by calling strset_add_str_mem(set, len), which may realloc() the
internal buffer.

If s points into the internal buffer, the realloc() frees the old memory,
leaving s dangling before the memcpy() occurs.

>   */
>  int strset__add_str(struct strset *set, const char *s)
>  {
> +	const char *strs =3D strset__data(set);
>  	long old_off, new_off, len;
>  	void *p;
>  	int err;
> =20
> +	/* Check whether 's' is already in the strset data buffer */
> +	if (strs && s >=3D strs && s < strs + set->strs_data_len)
> +		return s - strs;

Can this early return break hash map deduplication invariants if s is a
substring?

If a caller passes a pointer to a substring of an existing string, the
function returns the substring's offset but skips inserting it into
set->strs_hash.

Because the substring is never added to the hash map, subsequent lookups for
it via strset__find_str() will fail, and future additions from an external
pointer will duplicate the string.

Would it be safer to calculate the offset, perform the realloc(), and then
re-calculate the s pointer instead of returning early?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513232055.1681=
859-1-cmllamas@google.com?part=3D1
