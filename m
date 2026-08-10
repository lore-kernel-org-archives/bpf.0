Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941733B38BB
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370847; cv=none; b=AhkLzPw+oEIQNZbfQJj3P2omHKKBpHRaEETd4zJxiHzCAv/aQc/KPBnh2LP5d/jcuc10eOngE6N26+5XSobYrl2V/yOeFNvrV4R2bVvTMmjZJR9WOSTmSugks0l47hgTfcEucW4u+saLkQ0Iq1wMCW3gtaBTuYq0ZK0FDA2XVvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370847; c=relaxed/simple;
	bh=PI8GfpVclEvqzKgVD6pCdSnmoZveL4XpfhTcTU460mk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n/Km2zqBgc/XNwc7e2HEqhggyvBSy+JZ06PfIR/zkVS9T9DVfVEMPYR5tPAZnvmJXWjS2Hw/Lod7jIwq3jZQiHFxGqWPu6SbZI5cbDrqyWC2p6Pd0Cfi3KQr2zBKKBNL2VI1KZzYlSCtFNlQG1iLzF8R6Xa37CA2Pr3Ec0T6C8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8LNiRGT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8LNiRGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0BF1F000E9;
	Mon, 10 Aug 2026 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786370846;
	bh=DyHo6Rvsj7IMd2bn8kG7LLjkEUhw3gKCVn5QvtVGNWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E8LNiRGTQ1csy+LGqlGQD7KTitSRFiBRW9wsUstCs6zggqwNKSyK7jODcop+TNob1
	 u1ZHX8A1hV6SFJt5JFh6PI2WZ80DssptMu+Nv+YcEzMWm+ZWaSzyA5npu9/GTBqxYC
	 mRtInVphT+iYifW0BPtAbPRrQsnCl1jNQTtFDkAxgKNvU/IoJfHGqi1UFyAiKLTLGk
	 ltDGWTWIsSbW+ADwsYcUZLResG6vXaCdF36pbxEo0wMgFTPoKW9+SMrhe5YITeXqA/
	 78Ewh361yIjtRmMt+5iSDxxwGd5GlSTRVZfkOwbea9DU4BSnUnwmnGipyaGtaLE9jJ
	 Lj1kFV86Y65fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/6] bpf, x86: Clear fetch destination on
 faulting arena atomic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810134346.466004-3-daniel@iogearbox.net>
References: <20260810134346.466004-1-daniel@iogearbox.net>
 <20260810134346.466004-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:07:26 +0000
Message-Id: <20260810140726.5C0BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The fix for clearing the fetch destination register on a faulting =
arena read-modify-write atomic is incomplete and misses arm64 and s390 arch=
itectures.
--

--- Patch [3]: [PATCH bpf-next 3/6] bpf, x86: Clear fetch destination on fa=
ulting arena atomic ---
commit d051fde5d669db0d464e3f70d0cdcf647b528ab3
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf, x86: Clear fetch destination on faulting arena atomic

This commit fixes an issue on x86 where faulting arena read-modify-write
atomic instructions with a fetch operation failed to clear the destination
register. It introduces a new ARENA_WRITE bit in the exception table
metadata to correctly report the fault direction independently of the
register clearing logic.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8dddb5d7af21b..d920772af7d5f 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[Severity: High]
This is a pre-existing issue, but does this same bug also need to be fixed
in the arm64 and s390 JIT implementations?

On arm64, add_exception_handler() hardcodes DONT_CLEAR for all instructions
except BPF_LDX and BPF_LOAD_ACQ, which seems to leave the fetch register
uncleared for faulting BPF_PROBE_ATOMIC instructions:

arch/arm64/net/bpf_jit_comp.c:add_exception_handler() {
	if (BPF_CLASS(insn->code) !=3D BPF_LDX && !bpf_atomic_is_load_acq(insn))
		dst_reg =3D DONT_CLEAR;

	ex->fixup =3D FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
}

On s390, bpf_jit_probe_atomic_pre() never sets probe->reg, leaving it
initialized to -1. This seems to cause ex_handler_bpf() to skip clearing any
register:

arch/s390/net/bpf_jit_comp.c:bpf_jit_probe_atomic_pre() {
	if (BPF_MODE(insn->code) !=3D BPF_PROBE_ATOMIC)
		return;

	/* lgrl %r1,kern_arena */
	EMIT6_PCREL_RILB(0xc4080000, REG_W1, jit->kern_arena);
	/* agr %r1,%dst */
	EMIT4(0xb9080000, REG_W1, insn->dst_reg);
	probe->arena_reg =3D REG_W1;
	probe->prg =3D jit->prg;
}

Could this result in leaking stale or uninitialized memory to the BPF
program when an arena atomic read-modify-write instruction faults on an
unmapped page on these architectures?

> @@ -2384,15 +2389,29 @@ st:			insn_off =3D insn->off;
>  				    bpf_atomic_is_load_acq(insn)) {
>  					arena_reg =3D reg2pt_regs[src_reg];
>  					fixup_reg =3D reg2pt_regs[dst_reg];
> +					is_write =3D false;
>  				} else {
> +					/*
> +					 * A store has no destination register to clear,
> +					 * except for a read-modify-write with BPF_FETCH,
> +					 * which also reads the old value into src_reg, or
> +					 * into r0 for a BPF_CMPXCHG. Either way the access
> +					 * is still reported as a write.
> +					 */
> +					int load_reg =3D bpf_atomic_load_reg(insn);
> +
>  					arena_reg =3D reg2pt_regs[dst_reg];
> -					fixup_reg =3D DONT_CLEAR;
> +					fixup_reg =3D load_reg < 0 ? DONT_CLEAR :
> +						    reg2pt_regs[load_reg];
> +					is_write =3D true;
>  				}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810134346.4660=
04-1-daniel@iogearbox.net?part=3D3
