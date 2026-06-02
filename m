Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D229237180
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780363239; cv=none; b=IlUv6aHUdlixzQJDKQhxy4i0TCVagxamNrPQiYi6GVFxk9d5tntmVdplCXbXGAcvCple1aKOizFQ2/NFlmeQW04pGfKcb4y8CuvvjDbpk/ExVg7788D3Ag2ZtjIoieDT/0vd189vDerAGftEu2VHBAoKyhja5mfBeyBHCFLkzjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780363239; c=relaxed/simple;
	bh=4SLfNKxkVctUM2Zwnl2DsaaKML14uSD9MyUzb8btr1g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JhfV0gPw6H2LhEPdJO33WQzrtJtBDykZ+arhWdJa5Vt85R/j6FSAObRotJWruvP9qKHG1JrSlZOgWi1N62E/SeTRtSJG99f84L2yKP7rvyNs6dfh8lqI9jHOdUhF4MCkB593r2YynQtAYqKAD7LmBCzWBvriZEIdjtlM6x0GcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0LSBHWL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0LSBHWL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D961F00893;
	Tue,  2 Jun 2026 01:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780363238;
	bh=0t+7sweas+GKzuXHGONSL/1zhl94XcaElgig03e9GCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0LSBHWL2jh29oZKQVf6Y74k4Os6SaJu9FNB7HvzWHPPUvr/rYlTsclLTMldM6tb6
	 GmCApoBDT+LhOWpY6O7LGd/vOZFxW6eeYDR90Qb17ckX9RSkYh+KUReVL+JJXOmWOM
	 fgRl1L06I1+ZrO/+uqVdl9Mt9FGQs/OOp1rZ+I0epPAtMouAagglNVjAwY1IMcBvTN
	 FP6y3c5KLxiojXc0S7a5pYRsqfQiLTd4yGgYwYrggnNmskBqUDFwkRzDmwROJJfAuZ
	 p03TiyM1UUdGOnRquCpvjMLXFXQ/nTNc59wfoAbKpWSutYHFXte5QW3kOL7wWRUDM7
	 8c8737OWC74rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Allow subprogs to return arena
 pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602004120.17087-4-emil@etsalapatis.com>
References: <20260602004120.17087-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 01:20:37 +0000
Message-Id: <20260602012037.E2D961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The verifier incorrectly marks the return value of global subpro=
grams returning arena pointers as `SCALAR_VALUE` in the caller's state, pre=
venting native pointer use.
--

commit 3756bfe1c313ae3bcfb27afcfb3650b07638ef91
Author: Emil Tsalapatis <emil@etsalapatis.com>

bpf: Allow subprogs to return arena pointers

This commit expands the verifier to permit returning an arena pointer to the
caller from a subprogram. It updates btf_validate_return_type and
check_global_subprog_return_code to allow subprograms to return PTR_TO_ARENA
without failing their own verification.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3a270bc485c20..9dac790905b63 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16651,6 +16651,10 @@ static int check_global_subprog_return_code(stru=
ct bpf_verifier_env *env)
>  	if (err)
>  		return err;
> =20
> +	/* Pointers to arena are safe to pass between subprograms. */
> +	if (is_arena_reg(env, BPF_REG_0))
> +		return 0;
> +

[Severity: Medium]
Will this change be sufficient for the caller to actually receive a
PTR_TO_ARENA?

Looking at the caller-side logic in check_func_call(), it appears BPF_REG_0
is still unconditionally marked as a SCALAR_VALUE for all non-void global
subprograms:

kernel/bpf/verifier.c:check_func_call() {
    ...
		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
		if (!subprog_returns_void(env, subprog)) {
			mark_reg_unknown(env, caller->regs, BPF_REG_0);
			caller->regs[BPF_REG_0].subreg_def =3D DEF_NOT_SUBREG;
		}
    ...
}

Could this cause the caller to receive a scalar instead of the intended are=
na
pointer, leading the verifier to reject subsequent dereferences with an
invalid mem access error?

>  	if (is_pointer_value(env, BPF_REG_0)) {
>  		verbose(env, "R%d leaks addr as return value\n", BPF_REG_0);
>  		return -EACCES;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602004120.1708=
7-1-emil@etsalapatis.com?part=3D3
