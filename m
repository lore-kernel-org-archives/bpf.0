Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9748167D;
	Tue,  1 Sep 2026 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283079; cv=none; b=vCCe2jKPxmzxFp73hafkxYCr0z/DHTCL+ByBSFEDvcgxPoVGHk5Qb9o3uP3ee8GIkzwLkOsbEokumZ9KCxGcDPVLC8/ogRErg5WqStBMWmn2+T6aSmqhNBtIjmUWy4y6L1UmO1T7Wz53bWKwcak1FA2+G72TbokK7tMYqMcYnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283079; c=relaxed/simple;
	bh=25dzEcM6sfYpNQ+q3BM2c6h07Nms9iINY1mR2LtHhuE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A20WSszCjCe4EHobgwIwBHPatL3dT9m6XjuJfUbdIFxJk7OTvAvc2xH7jTAnqpIs4jmfaurGfW583PZv9Rm3TbqFyCOWaBrt0ghC6AZoNdtFsWVIqeUpJ6vAd9sI4DfpG2JlQx6MG+JBr7kmmBCcJcBhMNoaug/oNRguYVhCO7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOMEuHnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOMEuHnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A506A1F000E9;
	Tue,  1 Sep 2026 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283077;
	bh=ml2n993/fmOiP2U6C107RSAMi+O/vowBfqBODL+bvGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dOMEuHnqIMxERl1y3BhBJ+h1MA/SxbcyyV9bmlq0Et+1C4QboZkJhkRhAq7ckMvHW
	 j0d3a72xtOBAIV8pT87YahqrLkwGDSovT3/Ob8TQJNS6vllxgxYMaki1W8F/LYvH/C
	 ICxBZf4/QZemLjkX0KkIqF0dF1fMDQod91GP8UWmEKjF6mi+B7aTm+dB/FmoYH/X9z
	 uGgH2A+g1FYD3BIw8Tmhs9kLmpZ8ZAXkDuc39QUjsANALMklZr9YY5mWLPFEmDEXp1
	 U8tx3e2rlrMfb+6V8RLgUs5CXi60raFLYvuMTYeAHgkSYjNm208pB7B0YXTYMwKuLs
	 TRYMxw9FplcmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 01/18] btf: Extend UAPI to support BTF
 location (inline site) info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260901165757.801449-2-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:17:57 +0000
Message-Id: <20260901171757.A506A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] btf_loc_proto_resolve fails to validate the return type location p=
arameter (t->type).
- [Medium] Missing strict validation of unused fields and flags in check_me=
ta callbacks for new BTF kinds.
--

commit 32008454060b92e68c858ee6b661e8885cb28034
Author: Alan Maguire <alan.maguire@oracle.com>

btf: Extend UAPI to support BTF location (inline site) info

This commit adds BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO, and
BTF_KIND_LOCSEC to help represent location information for functions.
It enables representing fully or partially inlined functions at
potentially multiple inline sites.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9c2cab08bb794..d74c8668aa3f6 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> +static s32 btf_loc_param_check_meta(struct btf_verifier_env *env,
> +				    const struct btf_type *t,
> +				    u32 meta_left)
> +{
> +	const struct btf_loc_param *p =3D btf_loc_param(t);
> +	u32 meta_needed;
> +	u32 size;
> +
> +	meta_needed =3D sizeof(*p) + sizeof(__u32) * btf_vlen(t);

[Severity: Medium]
Should this function strictly validate that p->flags only contains valid
enum bits, and check that btf_type_kflag(t) is 0?=20

The BTF verifier typically rejects non-zero unused fields and unknown flags
to ensure forward compatibility. If malformed BTF objects with arbitrary
garbage in these fields are accepted, they might silently alter behavior
or break if these bits are repurposed in the future.

> +	if (meta_left < meta_needed) {
> +		btf_verifier_log_basic(env, t,
> +				       "meta_left:%u meta_needed:%u",
> +				      meta_left, meta_needed);
> +		return -EINVAL;
> +	}
[ ... ]
> +static int btf_loc_proto_resolve(struct btf_verifier_env *env,
> +				 const struct resolve_vertex *v)
> +{
> +	const __u32 *params =3D btf_loc_params(v->t);
> +	u32 i, nr_params =3D btf_type_vlen(v->t);
> +	struct btf *btf =3D env->btf;
> +
> +	for (i =3D 0; i < nr_params; i++) {

[Severity: High]
Does this function need to validate the return type location parameter
encoded in v->t->type?=20

It appears to validate the vlen parameters (params[i]) but entirely skips
verifying v->t->type. If a malformed BTF object specifies an out-of-bounds
type ID or an incorrect BTF kind in the t->type field, could it result in
type confusion or out-of-bounds memory accesses when subsequent code trusts
this field?

> +		const struct btf_type *param_type;
> +		u32 param_type_id =3D params[i];
> +
> +		if (!param_type_id)
> +			continue;
[ ... ]
> +static s32 btf_locsec_check_meta(struct btf_verifier_env *env,
> +				 const struct btf_type *t,
> +				 u32 meta_left)
> +{
> +	u32 meta_needed;
> +
> +	meta_needed =3D sizeof(struct btf_loc) * btf_type_vlen(t);

[Severity: Medium]
Similar to the location parameter check, should this callback enforce that
the unused t->size/t->type union and the kflag are 0? Without these
checks, the verifier might accept garbage data in these unused fields which
violates the strict validation design pattern.

> +
> +	if (meta_left < meta_needed) {
> +		btf_verifier_log_basic(env, t,
> +				       "meta_left:%u meta_needed:%u",
> +				       meta_left, meta_needed);
> +		return -EINVAL;
> +	}
> +	return meta_needed;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D1
