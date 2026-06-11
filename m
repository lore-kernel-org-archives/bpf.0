Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91015175A72
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143669; cv=none; b=CDAqbdK7NppnayPx7hBHg9yuoqiGpV/uwI6EypstGYEWyPEqLhHXrMRATaH4UYpnXk+fVMb+MgB+DzKqoxfJYzfSzXbZrvQt9HY/kmZIa2wBfGYZb4oR5mupgb6t960RcFa+kVvnOtgoSco+hbVxN/sKnSFr+x+fGFYgVbI7G8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143669; c=relaxed/simple;
	bh=+9/YAIl+UmgFlw5JU80MpnYldYbqir96UplENUymAvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MyNUqNkO91FoQdXPrqMOOvpOzhISkK6Et1hsyF+rU1LJrrJ4i1aHOg5BFMvQ1Gq20PSwTELeYSwXtYmVo3eDWaJebcWvet0NJW4n/OEDDa7BaoEd4WG3xq/m/8EuuKomXyGtXJR9ZVQgLSqThNpT6EtItp8PTuhQ/1u6B33ZS70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK4zbY1w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK4zbY1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0A11F00893;
	Thu, 11 Jun 2026 02:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781143668;
	bh=ZQ/qejNXtY9tK4tLwKx3CK6XDTc+gS6rvocnsqIGGVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hK4zbY1wBaVEfyl2bjKmV3jdIS7wQOu+90SagdHy6oVep+BYnnqvX8YNdQoH9BoP+
	 4CXx0i+zWNXRpi/M9PACDK1oGX5ZBrkjj/R0hUuahvXCj+FLti9KSRcM58qsGr+biX
	 yXzts6kcg0DI7a8N2vuBicLJe8zkrwBMrGdBv2b4MtBqcGBuUIEQwtQdWQO76fpO3E
	 ObmQpvESEGrzZRZFMMSosOeD699FdN1K+zpGtNteoStqLYX/eEiUMzd3dY3hbKOjN/
	 N9+Qsb7XIuk6WaBELVBiHVtNvItp2zOTCDoUb1//p2YKTgoMZHZ+uByXqgVWyKE+c+
	 egOt+USQgXe/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] LoongArch: BPF: Inline
 bpf_get_current_task{_btf}() helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611015327.12108-3-yangtiezhu@loongson.cn>
References: <20260611015327.12108-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 02:07:47 +0000
Message-Id: <20260611020748.1F0A11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `!bpf_jit_enable` check is an incomplete, architecture-specifi=
c workaround for a core BPF verifier bug. It fails to handle JIT compilatio=
n failures and leaves ARM64, PowerPC, and RISC-V completely vulnerable to t=
he exact same interpreter kernel panic.
--

commit a76f924522a402d8fb15714c189dca631202c35b
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

LoongArch: BPF: Inline bpf_get_current_task{_btf}() helpers

This commit inlines bpf_get_current_task() and bpf_get_current_task_btf()
helpers into a single move instruction for LoongArch. It also adds a check
for bpf_jit_enable in bpf_jit_inlines_helper_call() to safely fallback to
the BPF interpreter when JIT is disabled.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 24913dc7f4e83..cb379b236d7dd 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c

[ ... ]

> @@ -2367,3 +2374,18 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  {
>  	return true;
>  }
> +
> +bool bpf_jit_inlines_helper_call(s32 imm)
> +{
> +	/* Prevent interpreter panic when JIT is disabled at runtime */
> +	if (!bpf_jit_enable)
> +		return false;

[Severity: High]
This is a pre-existing issue, but does this !bpf_jit_enable check fully
prevent the interpreter panic?

In the BPF verifier, do_misc_fixups() calls bpf_jit_inlines_helper_call(). =
If
the architecture promises to inline the helper, it skips rewriting insn->imm
from its raw enum ID to the required interpreter offset:

kernel/bpf/fixups.c:do_misc_fixups() {
    ...
    /* Skip inlining the helper call if the JIT does it. */
    if (bpf_jit_inlines_helper_call(insn->imm))
        goto next_insn;
    ...
}

If bpf_jit_enable is 1 but JIT compilation later dynamically fails (e.g., v=
ia
bpf_jit_alloc_exec() returning NULL), bpf_prog_select_runtime() falls back =
to
the interpreter:

kernel/bpf/core.c:bpf_prog_select_runtime() {
    ...
    fp =3D bpf_prog_jit_compile(env, fp);
    bpf_prog_jit_attempt_done(fp);
    if (!fp->jited && jit_needed) {
        *err =3D -ENOTSUPP;
    ...
}

The interpreter then blindly executes (__bpf_call_base + insn->imm) using t=
he
unpatched enum ID, which triggers the same fatal Instruction Alignment Fault
(ADEF) kernel panic.

Furthermore, ARM64, PowerPC, and RISC-V unconditionally return true from th=
eir
implementations of bpf_jit_inlines_helper_call(). Are they left completely
vulnerable to the exact same interpreter kernel panic when JIT is disabled =
or
fails?

Could this root cause be addressed in the BPF core instead of being handled=
 as
an architecture-specific workaround?

> +
> +	switch (imm) {
> +	case BPF_FUNC_get_current_task:
> +	case BPF_FUNC_get_current_task_btf:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611015327.1210=
8-1-yangtiezhu@loongson.cn?part=3D2
