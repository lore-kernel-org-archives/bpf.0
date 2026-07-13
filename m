Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABD154425
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958009; cv=none; b=NWaE0JmMD5JaB2Z3dTjjde6fcbgw00Ypkrdj6U3Bo+0/xKnReLUnpL129jSHFE0NAodiYiPLaUaTza766YEtwdC72baN7FKO/uFqOcFCBiuYT1TnLjKhk0U1hyynO0SNmsJDgWPt3JinA+6+HUThomY3CYoBXMIpGwyLHmibgYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958009; c=relaxed/simple;
	bh=xTrTulLN8eiqiikIm/XqhCskn7iW2F82EhJx6ao5j1g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H3XkASfjHnOpwpoKWZQ5F0BFAoLwnyBvYcVQi3tUnkPiBJoPQXTo/oTDDsF8RNC/dTdDzYRwxgjv0GfZPheu1grVqZa6ADhL6nkjomLjnxGyHy3/HpvJ/YXiom1yqrvMHWOhGQ4Fms5eOqy6bbOFOVBn8aeg9jeFQI1S//Zgj+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgSwWh2f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgSwWh2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4831F000E9;
	Mon, 13 Jul 2026 15:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783958008;
	bh=M+LhhvK0xU/q1HIfF3Qn4Ik4tXl9fz/0QBE5Bjvl1Js=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hgSwWh2fmaK+rlzy1iVpitU2+Xn6RuIM3pqufuDMQSl8cqVcyrtjEbpI2o9IifRQW
	 C940Flue8o/jgnAG59bnp1lQ4vXguW7Gc+nzxpBgEH9owxHFq6uxcHugRPR34Ho5rc
	 6UcsWKojONkpDjIg+z5+GsqiFRBD6Vnk9OS/dEzf/jWRMbQpG5WyKgpGHD6sfBga/2
	 tZhLLMS4VZE8SXFVcc+g6bC+/2Uom8MiBYQ7MvhAtv1uhvfKUKJmMjGS5uhX0zi1HJ
	 APLtb7rIqxB4+cc7eXO+o19vckahMcycOorGuKwCNqEraEcpLQPtSVTJiF36LNwlbc
	 Jg6p10Eepva1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 12/17] bpf: Report Execution Context Safety
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713153910.2556007-13-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
 <20260713153910.2556007-13-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:53:27 +0000
Message-Id: <20260713155328.2D4831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect diagnostic constraint explanation for global function =
calls under locks
--

--- Patch [12]: [PATCH bpf-next v3 12/17] bpf: Report Execution Context Saf=
ety errors ---
commit 4c2714bc706956dcdd83f54e5db8f96839c37f55
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Execution Context Safety errors

This commit augments selected sleepability and critical-section failures
with Execution Context Safety reports. It adds source context, path history,
and suggestions tied to the active context while keeping existing verifier
messages.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 07e2c1ed8fbe6..e253fbc733a48 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10109,17 +10111,32 @@ static int check_func_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  	if (err =3D=3D -EFAULT)
>  		return err;
>  	if (bpf_subprog_is_global(env, subprog)) {
> +		const char *context;
>  		const char *sub_name =3D bpf_verifier_subprog_name(env, subprog);
> +		const char *operation;
> =20
>  		if (env->cur_state->active_locks) {
>  			verbose(env, "global function calls are not allowed while holding a l=
ock,\n"
>  				     "use static function instead\n");
> +			operation =3D
> +				bpf_diag_scratch_printf(env, 1, "global function %s()", sub_name);
> +			bpf_diag_ctx(env, BPF_DIAG_CTX_FORBIDDEN, *insn_idx, operation,
> +				     BPF_DIAG_CONTEXT_LOCK, "lock region",
> +				     "Release the lock before calling the global function, or use "
> +				     "a static function instead.");

[Severity: Medium]
Will this result in an incorrect diagnostic reason being printed?

Since BPF_DIAG_CTX_FORBIDDEN triggers diag_ctx_forbidden(), which in turn
uses diag_context_constraint() for the constraint explanation:

kernel/bpf/diagnostics.c:diag_context_constraint() {
	...
	case BPF_DIAG_CONTEXT_LOCK:
		return "code holding a BPF spin lock cannot call operations that may slee=
p";
	...
}

Doesn't this incorrectly tell the developer that their global function call
was rejected because it "may sleep"? Global function calls are generally
disallowed under locks due to verifier state limitations rather than just
sleepability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713153910.2556=
007-1-memxor@gmail.com?part=3D12
