Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7836A34D
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998436; cv=none; b=FW1vNPtHGlUL/hEb/ipdJlhH3X0/C3gLGTNSpSa4zDXiFUUOxOusc5r4hCqTgjrkj+lbDWH9L2kAKcFwKU3oS5AOhKsibIyhCOV3R/2LDsUD89QB3d5NGGKGPrRhDpfCv/v7TwFPzt5HNyY4PZhZPeOyPUhpNlPwwt2T3mJQCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998436; c=relaxed/simple;
	bh=YbQCZV6rOc7nM21Fs81Kg2maHH7UzcGmTCpKzJVTdSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NKaPNua/wsj2Y6dJdCrOda0a0rdWikMOCt8THimf/DaZCYqtzHgsXfnGAS48IEHuiIQBPiGmc4W3zLBuY/sOlBv9/22x6iHFXBHYTDUwQl4PEwc6ldqsmg12VViFPrDDkgEpwvN4NIw+KRCWwlYYnwL0skcuSV+X/GVwJ6qxahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvoJKT9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvoJKT9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDED1F000E9;
	Tue, 14 Jul 2026 03:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783998435;
	bh=h8O2eiIfH6RAM0mL2Zjo1uWaChBG2TeQkEREaTxtfR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OvoJKT9H7gwEET8xp08L0rU34w8fEgNgRLkVfQrbLV/CuMvj6XJNkOVrpGDTy6JWv
	 7ebrnX0FNJDXFi5Yrtm0MW/5VJK1r82JdoL2Ndz/h9tzMqo23QLXnUoYvvUcQJRuHs
	 FVf7X2poiDrXr9Npy4DEJ21nnkgOkS7vDTJN6Ck3SL6xYr4NmFLfzF47L2Uf4fRb2O
	 cnuHcmJ/eBwcK6yVzDbj/RLaReyM3DbSS7M9NsMdujXBayaPAnVUPivG+WLN9Xo6lm
	 DiIpdvIYSDj8AbqywJ/bZYgXPZvvxtdG9HExPuL0vES3L6sf+mhADO/fTAYj4LltMh
	 g1vS81Y7NPfjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] bpf, riscv: add support for timed may_goto
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Jiang" <jiangfeng@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714-riscv-bpf-timed-may-goto-v1-1-3988601fe6ac@kylinos.cn>
References: <20260714-riscv-bpf-timed-may-goto-v1-0-3988601fe6ac@kylinos.cn>
 <20260714-riscv-bpf-timed-may-goto-v1-1-3988601fe6ac@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 03:07:14 +0000
Message-Id: <20260714030715.3DDED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The RISC-V BPF JIT unconditionally moves the native return val=
ue (a0) into BPF_REG_0 (a5) after calling arch_bpf_timed_may_goto, silently=
 corrupting BPF_REG_0.
--

--- Patch [1]: [PATCH 1/2] bpf, riscv: add support for timed may_goto ---
commit ed55df1d87b981cbd59d17bd2c3b607f3fa418d9
Author: Feng Jiang <jiangfeng@kylinos.cn>

bpf, riscv: add support for timed may_goto

This patch implements arch_bpf_timed_may_goto() for the RV64 JIT. It also
enables bpf_jit_supports_timed_may_goto() to allow the verifier to use the
timed expansion path. The assembly trampoline is designed to preserve BPF
registers R0-R5 across the call to the generic bpf_check_timed_may_goto().

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index c03c1de16b79a..9832a19200c75 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
[ ... ]
> @@ -2157,3 +2157,8 @@ bool bpf_jit_supports_fsession(void)
>  {
>  	return true;
>  }
> +
> +bool bpf_jit_supports_timed_may_goto(void)
> +{
> +	return true;
> +}

[Severity: Critical]
Will enabling this feature cause the JIT to silently corrupt BPF_REG_0?

When the verifier emits a call to arch_bpf_timed_may_goto with src_reg =3D=
=3D 0,
the RISC-V JIT's BPF_JMP | BPF_CALL case handles it. Because src_reg !=3D
BPF_PSEUDO_CALL, it appears the JIT will unconditionally emit:

arch/riscv/net/bpf_jit_comp64.c:bpf_jit_emit_insn() {
	...
		if (insn->src_reg !=3D BPF_PSEUDO_CALL)
			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
	...
}

Even though the new assembly trampoline properly restores BPF_REG_0 (a5) and
BPF_REG_1 (a0) before returning, won't this newly emitted mv a5, a0
instruction overwrite BPF_REG_0 with BPF_REG_1 immediately after the call
returns?

Since the verifier assumes BPF_REG_0 is untouched by may_goto, could this
allow unverified pointers in BPF_REG_1 to bypass the verifier and lead to
memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-riscv-bpf-=
timed-may-goto-v1-0-3988601fe6ac@kylinos.cn?part=3D1
