Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608723890F8
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711808; cv=none; b=Qm0mFYrRpdG+7TqEs4fODjTr9WJY32Z5Vj3bTCIeW/B3EhEArzCy6OFZTVhCR2YVncqEXpneJicYNJoUywY3FJ2f9reFxWFVV47BvYsjNNwrkdAEvm4rG5l7dx2cJdtCQ6TLpegjfJXwtKAbIACDCSjXwZrIuoIhcudvl6Gz2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711808; c=relaxed/simple;
	bh=aFp3Qm47qzBSI7/FYvy7AZ3rlgQK+UyDZ0N1YlekIM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tJHfxp8iPfDgSEnMdrR8JfDygu+X0PjFTc7qYaRBsTgP/+dvmUiIQnqD8tFT8YVjdx1fv+jnCaVPuGR1sc8uxoM0NAWgkMUzsC3WWcw43lnFTzDjXCfR8vPLstGG1VCWlEvtaIUzyN71djaCp7Qm4hcv4RMilj6MMKrHX0/wHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWLgd5zv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWLgd5zv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9BA1F000E9;
	Fri, 10 Jul 2026 19:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783711804;
	bh=hMiCoZo/ETkMvDnbvKwVfHiKz/KyU65Kb/bjC38LysY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fWLgd5zvdMI169ByTFPWJZx2WcAhnr+89qE39t5pjOqwE2rdKDiRNMCKCLAIKBnpR
	 7OENtdzOJ74NBKTP/birizVhBl4oxilNgeYDhF5jbFo81YS+fK7Y8bT9gWKMwaAQ3l
	 tTrlRDKRuqC+UfAkCoY28OG5rMNM5ULCXROChaYlnOrLizwgcjf9pbIrZGyrBXTpQk
	 BeszlSyoXXI10t+YW90fQ3Xen2et3pI5q30GJzGTgOpVnrcZxFR2zJkWaMlzl2Ou2N
	 1+d2KvjdwMw+fyqC5MgC+Crf1FfTe02oF0Yn6+HUatjK93dut5B+qmemHbmp2x4y0x
	 rb0H67WiRjTXg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 1/1] bpf: Enable JIT hardening by
 default when x86_64 CFI is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jennifer Miller" <jmill@asu.edu>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260710191932.120911-2-jmill@asu.edu>
References: <20260710191932.120911-1-jmill@asu.edu>
 <20260710191932.120911-2-jmill@asu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 19:30:03 +0000
Message-Id: <20260710193004.1E9BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Initializing `bpf_jit_harden` to `1` by default provides incomplet=
e CFI protection (exempting CAP_BPF users) while unconditionally breaking B=
PF observability for all users.
- [High] `bpf_jit_harden` is not enabled by default for `CONFIG_X86_KERNEL_=
IBT` without `CONFIG_CFI`, leaving Endbr64 instructions unprotected against=
 crafted constants.
- [Low] The newly added multi-line comment violates BPF subsystem style gui=
delines.
--

--- Patch [1]: [RFC PATCH bpf-next v1 1/1] bpf: Enable JIT hardening by def=
ault when x86_64 CFI is enabled ---
commit 977257fbaf53ef7b4278e0a06c6f26b8addb7fac
Author: Jennifer Miller <jmill@asu.edu>

bpf: Enable JIT hardening by default when x86_64 CFI is enabled

This commit initializes bpf_jit_harden to 1 by default when x86_64 CFI is
enabled. It aims to prevent unprivileged users from crafting CFI signatures
or Endbr64 instructions by enabling constant blinding for JITted BPF code.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -548,7 +548,11 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
>  /* All BPF JIT sysctl knobs here. */
>  int bpf_jit_enable   __read_mostly =3D IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT=
_ON);
>  int bpf_jit_kallsyms __read_mostly =3D IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT=
_ON);
> -int bpf_jit_harden   __read_mostly;
> +/* Enable hardening by default when x86_64 CFI is enabled to prevent CFI
> + * hashes and endbr64 instructions from being crafted.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF subsystem
formatting rules? The guidelines require the opening slash and asterisk to
be on a line by themselves for multi-line comments.

> +int bpf_jit_harden   __read_mostly =3D IS_ENABLED(CONFIG_X86_64) &&
> +					IS_ENABLED(CONFIG_CFI);

[Severity: High]
Does initializing bpf_jit_harden to 1 using boolean evaluation create an
issue with observability for privileged users?

Looking at include/linux/filter.h in bpf_jit_kallsyms_enabled(), any
non-zero value for bpf_jit_harden disables kallsyms:

if (bpf_jit_harden)
        return false;

However, looking at bpf_jit_blinding_enabled() in the same file, a value
of 1 explicitly bypasses blinding for users with CAP_BPF:

if (bpf_jit_harden =3D=3D 1 && bpf_token_capable(prog->aux->token, CAP_BPF))
        return false;

Will this result in breaking BPF observability like profiling and stack
traces for all users, while simultaneously failing to provide the security
benefit of constant blinding for privileged users? Should this be set to 2
instead?

[Severity: High]
Also, does gating this mitigation exclusively on CONFIG_CFI leave Endbr64
instructions unprotected?

The commit message mentions preventing endbr64 instructions from being
crafted, but endbr64 is tied to hardware Indirect Branch Tracking (IBT)
which uses CONFIG_X86_KERNEL_IBT.

If a kernel is compiled with IBT enabled but CONFIG_CFI disabled, the
boolean logic will evaluate to 0, leaving the JIT vulnerable to 32-bit
constants corresponding to endbr64 gadgets.

Should CONFIG_X86_KERNEL_IBT be included in this evaluation to fully cover
the protections mentioned in the commit message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710191932.1209=
11-2-jmill@asu.edu?part=3D1
