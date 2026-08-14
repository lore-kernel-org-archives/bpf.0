Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE85477E
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669689; cv=none; b=SMVR66gB01lyB/Ao4Ct1/uA+gefuAJ6OlQchYJQc/URWbaPK/eQWwoo75ifF5SEIyNLkNB0L9+5XVKqbSVX8hF3IfPCBYGEN3zzKC1UDYI0Qfr4ofxBEYqw5xpGzk1bzYuPrGgDQla6jZ5sGpSG/qFs+pYwBrNQgyYXsY/Gw8fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669689; c=relaxed/simple;
	bh=dRfK6VyPABvX3xHB8obNzTlLMaZVv+Iw+0TUIfu1xnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kWP1P12UJO3ki6Pw3RHd8lYbZdX/mHs8nGb1ICEo1yzjjlbL0C35LWMJ8a+SmqKSO2qrdhIu6qGRH1iZbe3hRAmqhSoxv32gF4JqQsFp2Yg3YhEnh4KS8arbled5hqZbhvHp0hCvb16E745oz4WFVmMuQTniDd9pmeA7oHlnfno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBXPKD9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBXPKD9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6EC1F000E9;
	Fri, 14 Aug 2026 01:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786669687;
	bh=A+6yLc60CAEuTbYq5qBGa2NR4qUQEP4hPkYCekZ8tCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CBXPKD9kvb0HCYCagKMZeZzjaIvrpf3uZxOJLwF4pIYH6VDAj5bZew7G6diEc27gp
	 ujO7SYt7XfbJf3zsto2xfiL3ra1SKYJeZAcaZfwCUAv6JY4xBl8CjMQ8rftN0rOYbd
	 BYN7z7MWaheA/GoLvIfTi5lhJxuxy/59o6SQoaUfzmaBBLI+Bd6i7rSzqbOPjP6hbE
	 FeOe+PIIXLQRzes70xrsVbq0reQmIE8/P/CmhSzWLJywQYOAC4Be+StJfYDMt2eqgL
	 Pc3Mto+OBFC2OVU57egfEQ5VpYh7bgliIojqroqB8QUYLcf+iL25+FUkUIGViDYThj
	 XZqCmZtSbesDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/4] bpf: Merge pointer types also when both
 are PTR_TO_MEM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813204032.644949-2-daniel@iogearbox.net>
References: <20260813204032.644949-1-daniel@iogearbox.net>
 <20260813204032.644949-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:08:01 +0000
Message-Id: <20260814010807.9B6EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes a missing BPF_PROBE_MEM rewrite when an untrusted =
PTR_TO_MEM shares an instruction with a trusted PTR_TO_MEM, but leaves the =
exact same vulnerability open when mixed with PTR_TO_STACK, PTR_TO_MAP_VALU=
E, or other generic pointer types.
--

--- Patch [2]: [PATCH bpf-next 2/4] bpf: Merge pointer types also when both=
 are PTR_TO_MEM ---
commit 7f1a4eb01f4f65011b9dba6050e4321da3dbce61
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Merge pointer types also when both are PTR_TO_MEM

This commit fixes a verifier issue where merging a trusted PTR_TO_MEM and an
untrusted PTR_TO_MEM failed to trigger the BPF_PROBE_MEM rewrite. It updates
save_aux_ptr_type() to correctly merge these types when they intersect.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17096,6 +17096,17 @@ static int save_aux_ptr_type(struct bpf_verifier=
_env *env, enum bpf_reg_type typ
>  		 * save type to validate intersecting paths
>  		 */
>  		*prev_type =3D type;
> +	} else if (*prev_type !=3D type && allow_trust_mismatch &&
> +		   is_ptr_to_mem_or_btf_id(type) &&
> +		   is_ptr_to_mem_or_btf_id(*prev_type)) {
> +		/*
> +		 * Have to support a use case when one path through the
> +		 * program yields a TRUSTED pointer while another is
> +		 * UNTRUSTED. Merge them into a type which keeps the
> +		 * BPF_PROBE_MEM/BPF_PROBE_MEMSX rewrite when either
> +		 * side needs it.
> +		 */
> +		*prev_type =3D merge_ptr_types(type, *prev_type);
>  	} else if (reg_type_mismatch(type, *prev_type)) {

[Severity: High]
This is a pre-existing issue, but does this update still leave a vulnerabil=
ity
open if an untrusted PTR_TO_MEM intersects with PTR_TO_STACK or
PTR_TO_MAP_VALUE?

If a BPF program has a conditional branch where a memory load is reached by
either a PTR_TO_STACK or an untrusted PTR_TO_MEM | PTR_UNTRUSTED (e.g. from
bpf_rdonly_cast()), the verifier might explore the PTR_TO_STACK path first.

When it evaluates the untrusted memory path in save_aux_ptr_type(), it will
skip the new type-merging logic because PTR_TO_STACK fails the
is_ptr_to_mem_or_btf_id() check.

It then falls through to reg_type_mismatch(), which returns false because b=
oth
types satisfy reg_type_mismatch_ok(). The verifier permits the shared
instruction but leaves ptr_type as PTR_TO_STACK.

During JIT compilation, fixup_bpf_calls() would then observe PTR_TO_STACK a=
nd
skip the BPF_PROBE_MEM rewrite. At runtime, when the untrusted branch execu=
tes,
could this result in an unhandled page fault and kernel panic if it performs
a plain memory load on an unverified address?

>  		/* Abuser program is trying to use the same insn
>  		 * dst_reg =3D *(u32*) (src_reg + off)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813204032.6449=
49-1-daniel@iogearbox.net?part=3D2
