Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D226F36B91D
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264719; cv=none; b=Wel1HjEE3dAr+L45Tz2WR8Oat4RkI0yGUxLAP1zD1Iwq4ljkHHeooYxONc+8Ip+t/d3TGCI48B64GPeWKq49hMe4qxLSrlUvU59QC4WpwJDf/Z1S4WLyWdPh2Oi9Bf3F7r5mhGXzffl/KO31+nuD+zBxKKtcm3XL3W0HKtavMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264719; c=relaxed/simple;
	bh=54lLC0nW7YN4Du79Mp1Pyaz8KB0k/ah/+PNNjIc0dlQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j/1jgVJRObk+ZoYg+jwXT3C5M9enXT6hSibuaDzvdmdvZ+s4Fta53ns4SbRWpY43nvJvYHjW78lwBFdUcBA5z5pcHS48ks5AKzj1fIqrgHHjg624aNPGpzNYJnDZOPbLaXky0jGgGYaZSlf3U/bVryCpWt5bGXOnFCVnuF7Z1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPWIUqjD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPWIUqjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109EA1F000E9;
	Tue,  1 Sep 2026 12:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788264717;
	bh=kLM/sNVO8SMQ4yj7CKLV++8mTmLYGMuXWndhCJP/6lQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fPWIUqjDdiG5NLYvbMLgHOY1NdugSvxNcEYU96/PigUSFToL/RNkoErTIb1Y4kOXa
	 5SrEQ7y01pZY/xSs6Og5mjdblQXCAQo+TTS4NHVEpc+ZK6nU0h/nveCs/2II+4+gZw
	 QWMuPq+peu/4BDuUMxsTEEXh3ZtGAdvM+0SHqPOyzeTy14KMcdN/yIwHNMDUFFdFqR
	 +yDkJWsy/EEciXyGOq/JQIf+P8k0XpdnRJN6434yyJ9hDqSxQdPRNj9kswAseMFXVg
	 H0bGaNIOdVwXlXKJs9+BPcU1fE6Y1g1cuKPAvEV0xxP3J6h1GCeE9yAFnNnQMiG5CX
	 XQQSYSYAHctog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf, riscv: Register extable entries at probe
 insn call sites
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260901120013.16104-1-cp0613@linux.alibaba.com>
References: <20260901120013.16104-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 12:11:56 +0000
Message-Id: <20260901121157.109EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] BPF_PROBE_ATOMIC cmpxchg on RISC-V without ZACAS lacks exception t=
able entries, leading to an unhandled page fault and kernel panic for unmap=
ped arena accesses.
--

commit 77ab37f77b219155ec1dc7c551ef131f6c642039
Author: Chen Pei <cp0613@linux.alibaba.com>
bpf, riscv: Register extable entries at probe insn call sites

This commit removes the mode gate from add_exception_handler() and explicit=
ly
registers exception handlers only at probe instruction call sites. It aims
to prevent collisions between probe mode values and legitimate instruction
encodings.

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index e7378be171a9f..726c0169fc60f 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
[ ... ]
> @@ -2001,7 +2007,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, =
struct rv_jit_context *ctx,
>  			ret =3D emit_atomic_rmw(rd, rs, insn, ctx);
> =20
>  		/* ret can be 1 (skip-zext); extable entry still needs to be added */
> -		if (ret >=3D 0) {
> +		if (ret >=3D 0 && BPF_MODE(insn->code) =3D=3D BPF_PROBE_ATOMIC) {
>  			/*
>  			 * A load-acquire reads into dst_reg, and a read-modify-write
>  			 * carrying BPF_FETCH reads the old value into src_reg, or into
> @@ -2010,7 +2016,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, =
struct rv_jit_context *ctx,
>  			 */
>  			int load_reg =3D bpf_atomic_load_reg(insn);
> =20
> -			ret =3D add_exception_handler(insn, load_reg < 0 ?
> +			ret =3D add_exception_handler(load_reg < 0 ?
>  					REG_DONT_CLEAR_MARKER : regmap[load_reg],
>  					ctx) ?: ret;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but does emit_cmpxchg() correctly
establish an exception handler boundary when ZACAS is not enabled?

If a BPF program uses BPF_PROBE_ATOMIC with BPF_CMPXCHG on an unmapped memo=
ry
address on a RISC-V CPU without the ZACAS extension, emit_cmpxchg() falls
back to a load-reserved/store-conditional loop:

arch/riscv/net/bpf_jit.h:emit_cmpxchg() {
    ...
	if (rv_ext_enabled(ZACAS)) {
		ctx->ex_insn_off =3D ctx->ninsns;
		emit(is64 ? rvzacas_amocas_d(r0, rs, rd, 1, 1) :
		     rvzacas_amocas_w(r0, rs, rd, 1, 1), ctx);
		ctx->ex_jmp_off =3D ctx->ninsns;
        ...
		return;
	}

	if (is64)
		emit_mv(RV_REG_T2, r0, ctx);
	else
		emit_addiw(RV_REG_T2, r0, 0, ctx);
	emit(is64 ? rv_lr_d(r0, 0, rd, 0, 0) :
	     rv_lr_w(r0, 0, rd, 0, 0), ctx);
    ...
}

In the non-ZACAS path, ctx->ex_insn_off and ctx->ex_jmp_off are not updated
before emitting the faulting load-reserved instruction.

When add_exception_handler() is subsequently called here in
bpf_jit_emit_insn(), it will use stale offsets. Can this cause an unhandled
page fault and a kernel panic when accessing unmapped arena memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901120013.1610=
4-1-cp0613@linux.alibaba.com?part=3D1
