Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38E3ADB91
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 06:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784528303; cv=none; b=cdri/MnJ+5+P9WksPI5jIjPAK1a1ah9DvTpmK6EDUI0Mw+XkUbJSl0EJjmXGDfyG4ogP1TbaIK8ABC1DyKmgtixH2HoMYchmy1HhIf++z/r12AOdsYogNjjsv3CujLUGc0uTaoH3ghnz8TaqlPhUiD7fmty7O/CT/O+XlYUB/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784528303; c=relaxed/simple;
	bh=5Hds9PigNrpVP+a7tGVv28sy/OulXD7SeeK2vsthf4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GTss9W4Nga7J7aPn/aQ7XRuIrSbb81TBq23REVHtzdTbqZXe7hlF3GYuNesP3R6CxvsdyyKUDl/NPJRF50ftfFC1HpaHEAjG4Bc3EJDf5soKzO+OEEROeJ0eRho9BDFoWqng9KoxQEB/FFns1j4RvKpL9ga4aZn9hUVRV/s6OJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh0UH+7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh0UH+7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1261F00A3A;
	Mon, 20 Jul 2026 06:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784528296;
	bh=xGdtv5eaPTLsZUehtCofrPMROj2arYpFRL13HYsfweA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bh0UH+7CRvprU09wozCNtV99sMhwmXu/2K2Rh199oviz0oD3acaRLCZNcOQTXnSGK
	 dxymZvg3q68CGChyUK7cihYsj0LDVm+6cP88vCCcfK/D5om47W2kWw8BJZkMQxVjCM
	 ujVJDBDjN3m9ukD0mNC7/U2AHibkexXgT91f5sX/IM5G2I4aXbttBTE6ruElcrlPMZ
	 khEQ5jPhHmzTmR5TZmiUh5JHzLSoOBrTJh1QxNc3hEMCnKTetXcWXbYBCd7BgyQR65
	 gfEKXDc+goc6/SSrVEnnXJNb7grMyCe8BBpn3Fy2r3TqkQU0s/qCsNyl2A1z9RYZ5O
	 5ZAqUs9y4sN3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] bpf, riscv: fix extable handling for arena
 load_acquire
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Jiang" <jiangfeng@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720-bpf-riscv-fix-extable-v3-1-e9a603882309@kylinos.cn>
References: <20260720-bpf-riscv-fix-extable-v3-1-e9a603882309@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 06:18:14 +0000
Message-Id: <20260720061815.CD1261F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When generating a `BPF_CMPXCHG` instruction without the `ZACAS` ex=
tension, `emit_cmpxchg()` emits a standard `lr`/`sc` loop but fails to set =
`ctx->ex_insn_off` and `ctx->ex_jmp_off`. This causes `add_exception_handle=
r()` to silently skip adding an exception table entry, leading to an unhand=
led kernel page fault (Oops) if the atomic operation accesses invalid arena=
 memory.
--

--- Patch [1]: [PATCH v3] bpf, riscv: fix extable handling for arena load_a=
cquire ---
commit fa077ce2664d4c4babfa668d0c19369f9d827836
Author: Feng Jiang <jiangfeng@kylinos.cn>

bpf, riscv: fix extable handling for arena load_acquire

This patch modifies the BPF RISC-V JIT to ensure that an exception table
entry is correctly added for PROBE_ATOMIC load_acquire instructions. It also
ensures the destination register is zeroed on fault instead of being left
stale.

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index f9d5347ba966b..e1519ab4356c1 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1986,7 +1986,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  		else
>  			ret =3D emit_atomic_rmw(rd, rs, insn, ctx);
> =20
> -		ret =3D ret ?: add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
> +		/* ret can be 1 (skip-zext); extable entry still needs to be added */
> +		if (ret >=3D 0)
> +			ret =3D add_exception_handler(insn,
> +				insn->imm =3D=3D BPF_LOAD_ACQ ? rd : REG_DONT_CLEAR_MARKER,
> +				ctx) ?: ret;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does emit_cmpxchg() fail to
set ctx->ex_insn_off and ctx->ex_jmp_off on machines without the ZACAS
extension?

Looking at emit_atomic_rmw(), it calls emit_cmpxchg() for BPF_CMPXCHG.
If emit_cmpxchg() falls back to a standard lr/sc loop:

	emit(is64 ? rv_lr_d(r0, 0, rd, 0, 0) :
	     rv_lr_w(r0, 0, rd, 0, 0), ctx);

Because ctx->ex_insn_off is left at 0, won't add_exception_handler() simply
return early without adding an exception table entry?

This seems like it could cause an unhandled kernel page fault (Oops) if a
PROBE_ATOMIC cmpxchg accesses invalid arena memory.

>  		if (ret)
>  			return ret;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-bpf-riscv-=
fix-extable-v3-1-e9a603882309@kylinos.cn?part=3D1
