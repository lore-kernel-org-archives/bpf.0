Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500C48BD57
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339338; cv=none; b=BOMLmuWwH9bred4aph9d2erQDIXj7NhnqN0t4VTV0vD8NcRe3HX6DupNbngmuDh1fu9aPPDmEnJl9GFriL0ntlCaTNPbyj+sPG2SIvTbWbHpk5Q1pWTLcrpHN8r7RvDT6uoi1Hv2WY4tNx7TdWBmw0+zU90dBUCvLmbm1IJyNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339338; c=relaxed/simple;
	bh=rnSkMEK+L7j2wb+/lh4gdkGBjMR2YrUERmSTTFv8S1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GYIOFAHan3Puwl4xLy/wOYwDlNGFXfmtDUJIWVeWQ+unVZJLIrDpHGqkqxaP9t/c+0S/SvJrYQdLqr/RkSVc16YmPxK0DFLMdi9+apCj9keO570MqrPK400sJQs1Yk2YYLujkaVsRupcNGLTdHzegtxq/abJqkGReHKffDk9eSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+ly5BY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+ly5BY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E2E1F000E9;
	Wed, 29 Jul 2026 15:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785339337;
	bh=aZ9/hHqtB2pPKfFGIpoSrZVhEZo8riPnvJ+jxB7pNKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+ly5BY8CLbMU/1PlU3MD2kEvH8PolWL3ws7llN3rXY4+ef8Msjr1OTIy/oGqZhQP
	 23j1BR2GD+ccWHLiBzQaM4kQCu2RQLTQOxu+/fc9sENumfkuV2/1EJdC9g47ajy7g1
	 lIbGBLK8HCzLJAKNjQ5Fuwt87ps0UsCbI6DfwF6QNL/IkiLSIXo5vjc8hVCv9Aw2ek
	 iweXn0Uv8+TlB/gaZ7LhXqkrn/u+H1I6ip5HeL6yfD0rqxXZJWBIab6mpE+kdv3Iw4
	 7XmcKQ6uxnD/XqnAF1weRALwzcC90wu0oxFoPHXlEDQOOl0MTQGswYSNb0A4ERpbRq
	 3NJgqGbtUv1mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 3/4] bpf: Propagate untrusted pointer state in
 commuted arithmetic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260729-c3-035-public-bpf-v4-v4-3-8ee297e2346b@mails.tsinghua.edu.cn>
References: <20260729-c3-035-public-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn>
 <20260729-c3-035-public-bpf-v4-v4-3-8ee297e2346b@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:35:36 +0000
Message-Id: <20260729153536.F3E2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sanitize_err prints the wrong register name for immediate operat=
ions (BPF_K) when R0 contains a pointer.
--

--- Patch [3]: [PATCH bpf v4 3/4] bpf: Propagate untrusted pointer state in=
 commuted arithmetic ---
commit 74ae77e327bede792130d0bf76a485d3ad9ef6b4
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Propagate untrusted pointer state in commuted arithmetic

This patch modifies the BPF verifier's pointer arithmetic logic by moving
the early return for untrusted PTR_TO_MEM accesses. Placing it after the
pointer state is fully propagated ensures that operations like scalar +=3D
untrusted_pointer correctly leave the destination register as a PTR_TO_MEM.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index cdb61fab84351..fdc5fbb1f78ca 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13707,13 +13707,6 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
>  		return -EACCES;
>  	}
> =20
> -	/*
> -	 * Accesses to untrusted PTR_TO_MEM are done through probe
> -	 * instructions, hence no need to track offsets.
> -	 */
> -	if (base_type(ptr_reg->type) =3D=3D PTR_TO_MEM && (ptr_reg->type & PTR_=
UNTRUSTED))
> -		return 0;
> -
>  	switch (base_type(ptr_reg->type)) {
>  	case PTR_TO_CTX:
>  	case PTR_TO_MAP_VALUE:

[ ... ]

> @@ -13750,6 +13743,13 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env,
>  	if (dst_reg !=3D ptr_reg)
>  		*dst_reg =3D *ptr_reg;
> =20
> +	/*
> +	 * Accesses to untrusted PTR_TO_MEM are done through probe
> +	 * instructions, hence no need to track offsets.
> +	 */
> +	if (base_type(ptr_reg->type) =3D=3D PTR_TO_MEM && (ptr_reg->type & PTR_=
UNTRUSTED))
> +		return 0;
> +
>  	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
>  	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
>  		return -EINVAL;

[Severity: Medium]
Does sanitize_err() print the wrong register name for immediate operations
(BPF_K) when R0 contains a pointer?

When an immediate pointer arithmetic operation is rejected, sanitize_err()
is called downstream of this offset checking logic:

kernel/bpf/verifier.c:sanitize_err() {
    ...
    u32 dst =3D insn->dst_reg, src =3D insn->src_reg;
    ...
    case REASON_TYPE:
        verbose(env, "R%d has pointer with unsupported alu operation, %s\n",
                regs[src].type =3D=3D SCALAR_VALUE ? dst : src, err);
}

For BPF_K operations, insn->src_reg is 0. If a pointer was previously placed
in R0, or if R0 is uninitialized, regs[0].type will not be SCALAR_VALUE.
The ternary operation will then incorrectly choose src (R0) instead of the
destination register, emitting a confusing diagnostic message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-c3-035-pub=
lic-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn?part=3D3
