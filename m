Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B004AA599
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211128; cv=none; b=GgZjk3D1PIuWUHh8SqBTn6ugALluc8RHiIOnDrSk1ixIHpRmHYvNH7/2Wo0fKLpMjTF7yevYlDku1TIvXer23cqsJ3i3yzF2OCb+ckSDuhf6pqlaOjzpWSCSjKpH8tr8rVlGN7kw2hoh/N2N2KEnTrNj2o1ur9txm/N7hiXHW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211128; c=relaxed/simple;
	bh=tVIabQOvl08bTTM/u4NHCTmAp459R6CgjAzVtzunjOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gAP4PL+7VARHQxM2hkGJke4iLv1PI3vHCvRAQNh8TXcY2XV0G3nV/pJrSP3oWsO5MrbmRhrZqaaXyk1ok4eXr/pn6Buy7dezq1FAmn+mnAE08j9KoV0YlktXxBXy/3nnIh634PwXN5/azQLTG2aU1FIIW7BDbFO/CSMo7Xcgg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA822Oei; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA822Oei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8D91F000FF;
	Mon,  5 Oct 2026 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791211115;
	bh=ThD3OP6jODBw57+bGpVZ2ez9vy7i3ZztEtMEj/mxyE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KA822OeilaY9OaUCqz0axH0vAQyWV9EAMDC9KEw+AJNgx6pir8IimcG0s2UCr9LR2
	 1S4lyyduNUzCNWTfk1I9NW4RdCAHYlOnzUnsJjKkFowFVOS4lOGo3gyXtqkXtYB4n+
	 DdSn2VTK9x8LgYrCao9D2bsajCZWITgV0ohl5gBiHpFHNBGTvnRJe6WPr0lcr0U4+F
	 MJLGQDbZCtsEEX/UpBZPsDtS3+BjSdgIN2bz4ioS2L6fy9iTM4KRbEuDqm8Z008IXA
	 KNaHMKDnTpqLdJKjeiNEouYs71TyCkBWhP/goEdlyqW1ZT3kdipUyUgOsmm3UGbgyS
	 F6TieZog9KHGA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 1/7] bpf: Let kfunc sets give kfuncs a BPF
 body
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yusheng Zheng" <yunwei356@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261005142219.33451-2-yunwei356@gmail.com>
References: <20261005142219.33451-1-yunwei356@gmail.com>
 <20261005142219.33451-2-yunwei356@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 14:38:35 +0000
Message-Id: <20261005143835.8D8D91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: integer conversion bypasses kfunc body length check
- [Medium] bpf: type confusion when checking size of pointer arguments
--

commit ab41a09d317c7611ac2e010f734c868245e66554
Author: Yusheng Zheng <yunwei356@gmail.com>

bpf: Let kfunc sets give kfuncs a BPF body

This commit allows a kfunc set to provide a BPF instruction body for its
kfuncs, enabling the verifier to analyze the instructions inline. These
small kfuncs can then be used like instructions while the verifier knows
exactly what they compute.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> +static bool btf_check_kfunc_body(const struct btf *btf, const struct btf=
_type *func,
> +				 const struct bpf_kfunc_body *b)
> +{
> +	const struct btf_type *proto =3D btf_type_by_id(btf, func->type);
> +	const struct btf_param *args =3D btf_params(proto);
> +	int i, n =3D btf_type_vlen(proto), len =3D b->len;
> +	const struct bpf_insn *insn;
> +	u8 op;
> +
> +	if (n > MAX_BPF_FUNC_REG_ARGS || !b->insns || !len || len > BPF_KFUNC_B=
ODY_MAX_INSNS ||
> +	    (proto->type && !btf_kfunc_reg_type(btf, proto->type)))
> +		return false;

[Severity: Medium]
Does this code inadvertently bypass the bounds check and instruction
validation loop if b->len is very large?=20

b->len is an unsigned 32-bit integer. Assigning it to int len
implicitly casts it to a signed integer. If a module registers a kfunc with
b->len >=3D 0x80000000, len becomes negative. The check
len > BPF_KFUNC_BODY_MAX_INSNS evaluates as false, and the subsequent
for (i =3D 0; i < len; i++) loop is skipped entirely because
0 < negative_value is false. This could allow invalid or excessively large
BPF instruction sequences to be registered.

> +	for (i =3D 0; i < n; i++)
> +		if (!btf_kfunc_reg_type(btf, args[i].type) ||
> +		    (btf_param_match_suffix(btf, &args[i], "__k") &&
> +		     btf_type_skip_modifiers(btf, args[i].type, NULL)->size > sizeof(s=
32)))
> +			return false;

[Severity: Medium]
Does this code check the correct union field for pointer arguments?

When evaluating pointer arguments ending in "__k", this accesses
->size on the returned btf_type. However, for BTF_KIND_PTR, the size
field shares a union with type (the pointee BTF ID). This evaluates the
arbitrary BTF ID of the pointee type instead of its byte size, causing
unpredictable validation results or erroneously rejecting arguments based
on their pointee BTF type ID.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005142219.3345=
1-1-yunwei356@gmail.com?part=3D1
