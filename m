Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59E310762
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642016; cv=none; b=uJA6WiK+noFjT6EMLhsVMAIMkCH/X5cuM5LwtRa1SkK8usiqxxfCNl7yZWHhN0eFSW7WaL0lLKWIeam6igd1698mRHRm+V7Hdu9d12na3tVAvOo4ECUR9jb/G7zEynnHQF2447LEiFLz7MIEAGYANDxJ/nUGXsc64IfOs7B/spU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642016; c=relaxed/simple;
	bh=cL1+F9+Auu4Wi8sMhgP6r8vHh5kXAADPK2f8pQ7ablU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DjlnBLwJiBUlZNBIxp+SwslzNMJrKYKsqkY1xqIAEnDQyYv4nwBxEQDcRxKrxYcOuj8TdYZKB7IN44FbKQGFKGvNahstuKbk+avXv6reJzpRTczNwhQCgFzBSdwWfrLp7rNKEtImcqublVSQi+TSaKWRekBt08iS5G8R+dxq0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfiI3vBQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfiI3vBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DE71F00893;
	Fri,  5 Jun 2026 06:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780642015;
	bh=bfWltmin+hl71J/Xc073W+qisjqfQWlgPKQUCEcd3Qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dfiI3vBQC9LkEGlW7PqjIuxqDo1nCNqhGYP5wT64U2hixR4PxAvqVF4JI8h15RF9l
	 qh11NpaNV6vIDMOjEKo35CxAEfj30yxkgaLvqf55rqOvcsrj8oB/hitrba6W14fNRO
	 JcPTO4ISXv51Kwdewkw545WP7L8wHHRZVEncq4xwc7eg1E+vA7UKXTnoaZ+H3IbLAd
	 pWi9H2epeeYo5vuAEtv9aorOQJxUPljc1O5UlRMWJwrj100EBIKAMIgwgzvZo3naUf
	 cUJd4l391YM+76ZpU2nsEhcX1KwDrW+n2vqHTSOQ968MaN+ElowaehAqXLZXZ2X0pp
	 UhaZtAzOOUItw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 12/17] bpf: Report Execution Context Safety
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605063412.974640-13-memxor@gmail.com>
References: <20260605063412.974640-13-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:46:54 +0000
Message-Id: <20260605064655.16DE71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing Execution Context Safety diagnostic report for unmatched=
 bpf_preempt_enable().
--

commit fb6e824861cd1088f8d9a8b3acc089f48a5fb892
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

    bpf: Report Execution Context Safety errors
   =20
    This patch augments selected sleepability and critical-section failures
    with Execution Context Safety reports. It adds source context, path
    history, and context-specific suggestions while maintaining the existing
    verifier messages.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -12929,26 +13606,49 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
[ ... ]
>  	} else if (rcu_unlock) {
>  		if (env->cur_state->active_rcu_locks =3D=3D 0) {
>  			verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func=
_name);
> +			bpf_diag_report_context_underflow(env, insn_idx,
> +							  func_name,
> +							  BPF_DIAG_CONTEXT_RCU,
> +							  "Remove the extra bpf_rcu_read_unlock() call, or ensure this pa=
th first enters an RCU read lock region.");
>  			return -EINVAL;
>  		}
[ ... ]
>  	} else if (preempt_enable) {
>  		if (env->cur_state->active_preempt_locks =3D=3D 0) {
>  			verbose(env, "unmatched attempt to enable preemption (kernel function=
 %s)\n", func_name);

[Severity: Medium]
The commit message states that it augments "unmatched context exits" with
Execution Context Safety reports. While the patch correctly updates the
handling of unmatched bpf_rcu_read_unlock() calls to invoke
bpf_diag_report_context_underflow(), it misses adding the same diagnostic
reporting for bpf_preempt_enable().

Could we also add a call to bpf_diag_report_context_underflow() here
to standardize the execution context diagnostics as intended?

>  			return -EINVAL;
>  		}
>  		env->cur_state->active_preempt_locks--;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605063412.9746=
40-1-memxor@gmail.com?part=3D12
