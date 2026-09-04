Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794803F54A4
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512244; cv=none; b=d1vmLMh/LNwj60CrHIn32WDOLcedSgobg8ez9kx+Ouq2pgFc3Txpf7W3NQ3FNk/MN++DZygyoT7hlFTPRNURQU+j8xNwWGqwNfbqTidDoyaMbAzekD/9iujXFLsT13+hg/TLrXZkCBOhQA9QJYKONgpVGpEghFSK8m6qTMQtLyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512244; c=relaxed/simple;
	bh=IX5IppXdmdrYDUp+lrUcAaFIj/xY0AtubMwMY5Jty0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oEJDr7Ur86kuRVBNFJcAhHRw4FwvTGwaCAN0uQAxelHNqO/RXS38yjc9Se4avn6Wkr0ts14fI1thmbySO6W+hVJgD2ypkWrVLrms2q7k9+0jEK3qFkwL0R88fCRfnUYK8oNm+Pk01ey8Zzs3rixEBNqJ+E3eELTLmGnroj/InJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/6QO7fZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/6QO7fZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF111F00A3D;
	Fri,  4 Sep 2026 08:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788512242;
	bh=6O8JdNCxGRiG9auHz1fkEPLRe4jmUSr8Q5Ukk+9DdsM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I/6QO7fZkO1yIws3SAbjM6pGnwDUYHnVzczv5QcsrCVHZ/fGDxL6oCE0OAEjrTbd6
	 bYJ/+SeXl50NRDrIAjsGPCAUesPzzhB5XUpisdVLcwZ2geDVEAO6ZikGaujubypeWA
	 UBTYy6QZBREG1ESFxLfewve5GH94nmj9vykssuDVzMgTePWiVLcDtMSS4ouOQCi0ON
	 uB78Ljwix+uNh0CJqqdW30+v5FcoM1xXWK+GzQlkfyRTkOiZck9DUySfyqMgZOPirz
	 6vjQaVp8V0BrvVW2rObIPJS27bX0mPx2kMerU2aJJpVM2+Rm8SZJyIoyDZxhUO2XKe
	 oLcX7Fy5C6dcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 7/8] bpf: mark the zero register precise for a
 register-form NULL check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904083325.2083493-7-eddyz87@gmail.com>
References: <20260904083325.2083493-1-eddyz87@gmail.com>
 <20260904083325.2083493-7-eddyz87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:57:22 +0000
Message-Id: <20260904085722.7BF111F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The verifier fails to mark scalar registers precise when `bpf_=
register_is_null()` is used to satisfy a nullable pointer argument or kptr =
store.
--

commit c721af04f2965a6636b3260c058c2531da5526e0
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: mark the zero register precise for a register-form NULL check

This patch fixes a bug in check_cond_jmp_op() where comparing a nullable
pointer to a scalar known to be zero fails to mark the scalar register
precise. This prevents malicious state pruning where an imprecise scalar
could bypass safety checks and lead to a forged pointer dereference.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 303368460ec10..fde5d046b6e32 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17052,6 +17052,15 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
>  	    type_may_be_null(dst_reg->type) &&
>  	    ((BPF_SRC(insn->code) =3D=3D BPF_K && insn->imm =3D=3D 0) ||
>  	     (BPF_SRC(insn->code) =3D=3D BPF_X && bpf_register_is_null(src_reg)=
))) {
> +		/*
> +		 * For BPF_X the zero is a property of this execution path,
> +		 * hence src_reg has to be precise.
> +		 */
> +		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> +			err =3D mark_chain_precision(env, insn->src_reg);
> +			if (err)
> +				return err;
> +		}

[Severity: Critical]
This is a pre-existing issue and not a bug introduced by this patch, but
since this change addresses missing precision tracking for zero-valued
scalar registers, do we need similar mark_chain_precision() calls in
other places that use bpf_register_is_null() to satisfy pointer checks?

For example, in check_map_kptr_access(), we bypass type checking when the
register is a scalar zero:

kernel/bpf/verifier.c:check_map_kptr_access() {
    ...
    if (!bpf_register_is_null(val_reg) &&
        map_kptr_match_type(env, kptr_field, val_reg, value_regno))
    ...
}

Similar bypasses without precision marking appear in several other argument
checkers:

kernel/bpf/verifier.c:check_func_arg() {
    ...
    if (bpf_register_is_null(reg) && type_may_be_null(arg_type))
        /* A NULL register has a SCALAR_VALUE type, so skip
         * type checking.
         */
        goto skip_type_check;
    ...
    if (type_may_be_null(arg_type) && bpf_register_is_null(reg))
        return 0;
    ...
}

kernel/bpf/verifier.c:check_kfunc_args() {
    ...
    if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))
        continue;
    ...
}

kernel/bpf/verifier.c:check_mem_reg() {
    ...
    if (bpf_register_is_null(reg))
        return 0;
    ...
}

Could an attacker use these paths in a similar way to the vulnerability
described in your commit message?=20

If a branch assigns a scalar 0, passes it to one of these functions
(leaving it imprecise), and another branch merges with an arbitrary kernel
address, wouldn't states_equal() incorrectly prune the malicious branch
because regsafe() returns true for imprecise scalars?

>  		/* Mark all identical registers in each branch as either
>  		 * safe or unknown depending R =3D=3D 0 or R !=3D 0 conditional.
>  		 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904083325.2083=
493-1-eddyz87@gmail.com?part=3D7
