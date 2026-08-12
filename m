Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C73655E7
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516119; cv=none; b=IeTcyLnNztDbKczLPLsgzifl/nAlTkUQon5/BLSp2xM/cuqoxmuNFjsh9tsTPS97uA8Y7lFQZ22ItiegL7IOzH35H2ZsJoqvoMIphC6GOWI8xQBgsfZpor5yoMdSv5ruHuouvfiQf7CeWGxMf0rb3R5A1eipt5f23r76BbEk+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516119; c=relaxed/simple;
	bh=o8O2WarKtVCPbMow7pn0vtEsCtzs65qc/kjLMtkc120=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qJwwbMGXEqYpmUx3MAYES97kjDl3iTWcqJpqEchQaookEMFfmbugdZc6QdAydNPRe3CoEOFbCdL22ICUIPQB5qbaEwcJVlR/4GMDY0sM8IiAEwuWy27QTtrlH+R5p7DkKuKKXvlZb5GNTISCBKUWLHr5VMLF/3Kl/eukhoUJMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bew2D3fw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bew2D3fw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8AE1F000E9;
	Wed, 12 Aug 2026 06:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786516117;
	bh=JoDWaynUTghTTdMCI7he14BJUroKAA3TcoAG66RY7k8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bew2D3fwWZwOxjoXeN8+K008AfKcHiQJfn0MXSqVupElUnAxqCGvUjWSeYPjsukpy
	 4BiQaDASvEuntZlxX3zc77BUQjKBSASJRLEkHTOL2VthovpQ3JEc3LYkAA6WW1Iz51
	 mUsqztV7ulId9dSV6rHNuZu9Rx1M5/8c2jREsR4omRZhR5PSdTllBnZtOfxaglE5cr
	 Ec2rLf3pWy2mUpVCEGzPFAFJ9qm8hQlybNloh+ZU2elauSPJRcE2su1Uy0oGwG36Tl
	 WiBDi+cG9NHMRkxAnaFKaD23dfd4tQ+DAypRXSB9Xo1btFogzzjgIMIyTK9N9wmbB/
	 QJMf4X50Aidxw==
From: sashiko-bot@kernel.org
Subject: Re: [bpf-next PATCH 1/2] bpf, riscv: Add BPF stack arguments
 support for RV64 JIT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Jiang" <jiangfeng@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812-bpf-riscv-stack-args-v1-1-67b246806e59@kylinos.cn>
References: <20260812-bpf-riscv-stack-args-v1-0-67b246806e59@kylinos.cn>
 <20260812-bpf-riscv-stack-args-v1-1-67b246806e59@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:28:36 +0000
Message-Id: <20260812062837.4A8AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing sign-extension for 32-bit kfunc arguments passed on the st=
ack
--

--- Patch [1]: [bpf-next PATCH 1/2] bpf, riscv: Add BPF stack arguments sup=
port for RV64 JIT ---
commit c291f39756942d05aeab1b370b77119f4235a7f8
Author: Feng Jiang <jiangfeng@kylinos.cn>

bpf, riscv: Add BPF stack arguments support for RV64 JIT

This commit adds support for passing BPF stack arguments to BPF subprograms
and kfuncs in the RV64 JIT. It implements the RISC-V ABI requirement of
putting arguments 6-8 in registers A5-A7 and arguments 9+ on the stack.

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 6b9972b07c1b0..b3f4bf9e1e7f2 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
[ ... ]
> @@ -1815,18 +1815,39 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct rv_jit_context *ctx,
[ ... ]
>  		if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
>  			const struct btf_func_model *fm;
> -			int idx;
> +			int idx, nargs;
> =20
>  			fm =3D bpf_jit_find_kfunc_model(ctx->prog, insn);
>  			if (!fm)
>  				return -EINVAL;
> =20
> -			for (idx =3D 0; idx < fm->nr_args; idx++) {
> +			nargs =3D min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS);
> +			for (idx =3D 0; idx < nargs; idx++) {
>  				u8 reg =3D bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
> =20
>  				if (fm->arg_size[idx] =3D=3D sizeof(int))
>  					emit_sextw(reg, reg, ctx);
>  			}
> +
> +			/* BPF stack args -> RISC-V ABI: args 6-8 in A5-A7, 9+ at SP+0 */
> +			if (fm->nr_args > MAX_BPF_FUNC_REG_ARGS) {
> +				int n_stack =3D fm->nr_args - MAX_BPF_FUNC_REG_ARGS;
> +				int n_reg =3D min_t(int, n_stack,
> +						  RV_MAX_REG_ARGS - MAX_BPF_FUNC_REG_ARGS);
> +
> +				for (idx =3D 0; idx < n_reg; idx++) {
> +					int sz =3D fm->arg_size[MAX_BPF_FUNC_REG_ARGS + idx];
> +
> +					emit_ld(RV_REG_A5 + idx, idx * 8, RV_REG_SP, ctx);
> +					if (sz =3D=3D sizeof(int))
> +						emit_sextw(RV_REG_A5 + idx, RV_REG_A5 + idx, ctx);
> +				}
> +
> +				for (idx =3D 0; idx < n_stack - n_reg; idx++) {
> +					emit_ld(RV_REG_T1, (n_reg + idx) * 8, RV_REG_SP, ctx);
> +					emit_sd(RV_REG_SP, idx * 8, RV_REG_T1, ctx);
> +				}

[Severity: High]
Does this loop need to sign-extend 32-bit integer arguments passed on the
stack?

The RISC-V RV64 C ABI requires scalars narrower than 64 bits to be
sign-extended to 64 bits when passed on the stack. BPF ALU32 operations
zero-extend values, so if a negative 32-bit integer is passed on the stack
(argument 9 or above), its upper 32 bits will be zero instead of ones.

The preceding loops for register arguments (both BPF_REG_1-5 and A5-A7)
check fm->arg_size[idx] =3D=3D sizeof(int) and use emit_sextw(). Is a simil=
ar
check needed here before writing the argument to the stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-bpf-riscv-=
stack-args-v1-0-67b246806e59@kylinos.cn?part=3D1
