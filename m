Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC73F320A14
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776885030; cv=none; b=C0jKIcuKq20bogs38KwhN6Y/ZDooxia2zLJ9f+ENPeBVYZ8UaJgwCAFBZ5WMKciRvHe9Q2dG8ZAxAy2PlyeMBfaCqtBCjw7blQ4ts1gMxSGu14/hf/6KgLukUkB4GM3EINTYB8R96q5O1+52Tz033F3H5ej/FlJafkoCxCaSzP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776885030; c=relaxed/simple;
	bh=MWvkusOaUOskymu3266ZLCkea/xTBRu7Z2d5LQQVUrc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fRirTj95Hqm6hmzvFczAkgTuhdlaVKAxUjOaKqj0keox9BKZHEmRIShgUEtpw/IC39c7A0F8Xhs2aVO+Tj+p2BcLR93tAalrh+klkAOsKuKC4p1UGSMMo17X4xGKVjdsVZLl6hUEynLdZ4R/u6SWJCs0JOxB0LArZoTP1R+PtAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu9FkGl7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu9FkGl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696BBC2BCB4;
	Wed, 22 Apr 2026 19:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776885029;
	bh=MWvkusOaUOskymu3266ZLCkea/xTBRu7Z2d5LQQVUrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Uu9FkGl72183kg0TDkRNrkV6S8iRyJdCIWBx06/6Dj/EGg5GfCYVEn9Ni1WQzZtER
	 woGZNgCZpF478g5cdg1fP2cw2CvdvncxatmnjAB8txndcmR0rGfLcf5Jpg6+vZPoaF
	 oArPu5/i2GoLaie6CgVLG3hs03wZ5pYnZExSgu6Ye06Hl9LrzJjf9apYDj40JgpgVQ
	 uboSiIvMqRihOvC0Cp7NhXiIDdD9JC2SM4kCFVo149BEMzpmw7Ti8tGo72GCbAbsQl
	 vafSlPkUGLakjnlGidqbMXkCvjVlR1y/JXdVD3oPZrvK8JdNM21a9FxbPHa99XAE0W
	 kkwyPdYB+gFjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] libbpf: Fix type size overflow in
 btf_type_size_unknown
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260422103206.533695-1-alan.maguire@oracle.com>
References: <20260422103206.533695-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 19:10:28 +0000
Message-Id: <20260422191029.696BBC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] This problem wasn't introduced by this patch, but the patch attemp=
ts to fix a pointer wrap-around vulnerability and leaves it completely unfi=
xed for standard BTF kinds.
- [Medium] The bounds check added in btf_type_size_unknown() performs point=
er subtraction between unrelated memory allocations, leading to C Undefined=
 Behavior.
--

commit ac478ac510f0298a2cc2458f409eff3e04fdd3b5
Author: Alan Maguire <alan.maguire@oracle.com>

libbpf: Fix type size overflow in btf_type_size_unknown

This commit attempts to fix a 32-bit pointer arithmetic wrap-around in
btf_parse_type_sec() by adding a bounds check in btf_type_size_unknown().
This aims to prevent a large type_size from wrapping when added to next_typ=
e,
which would bypass the existing bounds checks.

Link: https://lore.kernel.org/bpf/20260417170712.74E77C19425@smtp.kernel.or=
g/

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ceb57b46a8782..d48ac5460d1de 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -420,9 +420,11 @@ static int btf_parse_layout_sec(struct btf *btf)
>  static int btf_type_size_unknown(const struct btf *btf, const struct btf=
_type *t)
>  {
>  	__u32 l_cnt =3D btf->hdr.layout_len / sizeof(struct btf_layout);
> +	const void *end_type =3D btf->types_data + btf->hdr.type_len;
>  	struct btf_layout *l =3D btf->layout;
>  	__u16 vlen =3D btf_vlen(t);
>  	__u32 kind =3D btf_kind(t);
> +	int type_size;
> =20
>  	/* Fall back to base BTF if needed as they share layout information */
>  	if (!l) {

[ ... ]

> @@ -448,7 +450,13 @@ static int btf_type_size_unknown(const struct btf *b=
tf, const struct btf_type *t
>  		return -EINVAL;
>  	}
> =20
> -	return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_=
sz;
> +	type_size =3D sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind=
].elem_sz;
> +	if ((size_t)type_size > (size_t)(end_type - (const void *)t)) {

Is it safe to subtract these pointers? When btf_type_size_unknown() is used
outside of parsing, such as in btf_dedup(), t might point to a newly
allocated new_types buffer while end_type points to the old btf->types_data.

Subtracting pointers from distinct memory allocations is undefined behavior
in C, which can cause crashes if tools linking libbpf are compiled with UBS=
an
using -fsanitize=3Dpointer-subtract. Should this bounds check be relocated
into btf_parse_type_sec() instead?

> +		pr_debug("Overflow in type size %d for kind %u\n",
> +			 type_size, kind);
> +		return -EINVAL;
> +	}
> +	return type_size;
>  }

This patch attempts to fix a pointer wrap-around vulnerability, but does th=
is
approach leave standard BTF kinds vulnerable?

Since the bounds check is only added to btf_type_size_unknown(), standard
kinds like BTF_KIND_STRUCT are evaluated directly in btf_type_size() without
any bounds check.

If a malicious BTF file provides a BTF_KIND_STRUCT with a maximum vlen, it
can yield a type_size up to ~786KB. On a 32-bit system, if the buffer is
allocated near the top of the address space, adding this size could wrap
around to a small value.

The overflow check next_type + type_size > end_type in btf_parse_type_sec()
would then evaluate to false, potentially bypassing validation and leading =
to
an out-of-bounds write in btf_bswap_type_rest().

Would it be safer to fix the vulnerability for all kinds by changing the
check in btf_parse_type_sec() to avoid pointer addition entirely?

For example:
if ((size_t)type_size > (size_t)(end_type - next_type))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422103206.5336=
95-1-alan.maguire@oracle.com?part=3D1
