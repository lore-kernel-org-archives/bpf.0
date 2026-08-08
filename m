Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736CE136351
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786151096; cv=none; b=LKoWRd90o89khPRFxwYUqJafhQu0hEEHG5hn+PB1p9fV2s21FoJGP9+nLaYOEv2phgUqgPia6UpjivMAPm7myi5FFM8RcJNGxMfRBI7CMUrS74ItmmLLFKlJMvRWXtF7T/DOgiQVWw+iGnFSNVi4TFEEFVryk6jvIvjDMbNd8nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786151096; c=relaxed/simple;
	bh=5t9KiGUgpx1XMBQQ8vLeXgPZ0bM0UqNaHo0yGsMq3Lg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jQSEBuTf7+cWrOTe3T2bgFGpFZpbyXyo98TkequaWmcEidhHXjHpLJcHm8YRuk5VmQdNP9gWLzIHVqyHluB4OdEc0bO8em3d4c8hmwyhdrnsQlZst9yN6/Sxk+MRu1m7dmk8ks7KB/wnVQY4XsCKPxBZksj7R8mgIVMoLiQNcv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VI11PE3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI11PE3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBB01F000E9;
	Sat,  8 Aug 2026 01:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786151095;
	bh=7kr+jaPHVvrKHAEGlkqLXP+E0nmnpAIqQ5GKmh3zOUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VI11PE3foVl0hHSbE/hR372GpyFKf7136PVYpc00U3/swuPY61N1UvyK40cVvT14Q
	 RRhRYxQhAQReHsB/h3yTUzHAaa5cQarDDrSD64GzRZbX2fNr50yi68TZtSdnLYkKfM
	 jAZ5vpA1D+4dkMsTptkgln8K9erXQjA2lNLnRlSNcqQB4+RMTfwJsXX+a0t/TxEM+5
	 qBR0A2EdNa3grZgyI04Nuc7fp609IDqSzei1i2EJis3diRvHmHedBRDqXqwIIfmoqS
	 hZprEp7jgECRWTo/jbw3vDoMnaGNt7Ko4TTdv5tzOz4VVLKqjcIZ7XMiOePV5X1FWb
	 Z1OfhGe24Hk3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 11/14] bpf, x86: Fix stack-passed arguments
 for indirect trampolines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260808003938.3486067-12-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
 <20260808003938.3486067-12-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 01:04:53 +0000
Message-Id: <20260808010454.ECBB01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: The off-by-one-slot stack argument read bug for `B=
PF_TRAMP_F_INDIRECT` trampolines was fixed for x86 but identical bugs remai=
n in arm64, riscv, and loongarch JITs.
--

--- Patch [11]: [PATCH bpf-next v5 11/14] bpf, x86: Fix stack-passed argume=
nts for indirect trampolines ---
commit b424d38504eb2136da7da04d1aa98780ba7432d8
Author: Tejun Heo <tj@kernel.org>
bpf, x86: Fix stack-passed arguments for indirect trampolines

This commit fixes the stack offset calculation for stack-passed arguments
in x86 indirect trampolines by accounting for the single return address
on the stack.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 162fbd2ba1df8..8dddb5d7af21b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
[ ... ]
> @@ -3080,6 +3080,7 @@ static void save_args(const struct btf_func_model *=
m, u8 **prog,
>  {
>  	int arg_regs, first_off =3D 0, nr_regs =3D 0, nr_stack_slots =3D 0;
>  	bool use_jmp =3D bpf_trampoline_use_jmp(flags);
> +	int stack_args_off =3D (use_jmp || (flags & BPF_TRAMP_F_INDIRECT)) ? 16=
 : 24;

[Severity: High]
This isn't a bug introduced by this patch, but does this same offset issue
need to be fixed in the trampolines for other architectures as well?

For example, in arm64, save_args() hardcodes an offset of 32:

arch/arm64/net/bpf_jit_comp.c:save_args() {
    ...
    soff =3D 32; /* on stack arguments start from FP + 32 */
    ...
}

This assumes two 16-byte frames are pushed. Since BPF_TRAMP_F_INDIRECT only
pushes one frame, reading from FP + 32 reads from the old SP + 16, skipping
16 bytes of arguments.

Similarly, riscv hardcodes a 16-byte offset relative to FP:

arch/riscv/net/bpf_jit_comp64.c:store_args() {
    ...
    emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
    ...
}

Since FP points directly to the old stack pointer for indirect trampolines,
this skips the first 16 bytes of caller arguments.

Loongarch has the identical pattern:

arch/loongarch/net/bpf_jit.c:store_args() {
    ...
    emit_insn(ctx, ldd, LOONGARCH_GPR_T1, LOONGARCH_GPR_FP,
              16 + (i - LOONGARCH_MAX_REG_ARGS) * 8);
    ...
}

If a struct_ops callback were to receive enough arguments to be passed on t=
he
stack, would these architectures also pass garbage to the BPF program due to
reading past the actual start of the stack arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808003938.3486=
067-1-memxor@gmail.com?part=3D11
