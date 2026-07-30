Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDD2375F80
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 05:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391003; cv=none; b=HNF3gKcMS/mcTy9CZBQHz857BHDZeqqB69HNLKiLEuRiix1YekF4Vp9l4cRX55nPCOFK3Wio/++J/r3JuvqBmV7mnPw+hab7ViNDPmhMrce9eTKQpMc6YvorFkdJvZqgdsUuCNC/1YAbMvOMZ2klJCPhiVUjEloncc77MuPSQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391003; c=relaxed/simple;
	bh=A99PIBZFpgJhBoZcuLGMgUAdeqMIc+gag3zGLVJVjBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uOSZ183fVNS4+rjsPiLwa+TWsK7eTexyiTZPOg0U0v6qg+nGHzYtjvQBkjwW+3kvMATz41l92t89I/MPbsRYD44gLqy2HjsD0CVB7qaFxjS3jKhnR2CyXW5Y0MsWb3S8XUimL41wr5nAYZPQVfmP0ePFTKl6fYD0eNYiz2i+kPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meDN7SUd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meDN7SUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ADA1F000E9;
	Thu, 30 Jul 2026 05:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785391001;
	bh=GqTSKaaAc78rai1+mcuIEw66PGkYakYb/PvQNfZ8b9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=meDN7SUdSpVNLUt0nQ4fB55LbIzOZZZ4HXGBShI6c8XYvcnZ/1cnGbxXVvgm/Loze
	 /BEtHQ3YWX6L3sCeP1CaubCAamG+1UhznFEURrFMemfFTZUzgVdPwh6RGV3yOvD49f
	 JSGY5srT2taSklSik9lDrPNFEF9g8uO3rwCp+KoyfTMkcA9APSfFyG7+GOL1BqCU6q
	 1n0MLrqdF009VJgP8erJLQGL/7lB30RewE/7MIyucVncJqK78b6xyc/fx0Tr6z4Jlq
	 nBhHapLTKezWZj8dZ4SqBYsadrUcDX9Sedh4g/6FBBQZhyrjt7Cakqga2LUl5+ddpg
	 t/3t3Ak0yclXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] powerpc64/bpf: Fix build break for
 arch_bpf_timed_may_goto
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <f75e5aa911afb984a94c0e85d58b1be5fb428548.1785387718.git.skb99@linux.ibm.com>
References: <cover.1785387718.git.skb99@linux.ibm.com>
 <f75e5aa911afb984a94c0e85d58b1be5fb428548.1785387718.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 05:56:41 +0000
Message-Id: <20260730055641.85ADA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The assembly trampoline `arch_bpf_timed_may_goto` allocates a fixe=
d 112-byte stack frame and stores caller-saved BPF registers at offsets `32=
(r1)` to `72(r1)`. On PowerPC64 Big Endian (ELFv1 ABI), this writes directl=
y into the caller's TOC save area and the callee's Parameter Save Area (PSA=
), causing silent stack corruption.
--

--- Patch [2]: [PATCH v2 2/2] powerpc64/bpf: Fix build break for arch_bpf_t=
imed_may_goto ---
commit fc9f3132494d759b31f127f67b0e0815b4960f74
Author: Saket Kumar Bhaskar <skb99@linux.ibm.com>

powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto

This commit fixes a link-time failure in the powerpc64 JIT for timed may_go=
to
when CONFIG_PPC_KERNEL_PCREL is enabled. It replaces a direct bl instruction
with the CFUNC() macro to properly annotate the call and avoid TOC restorat=
ion
linker errors.

> diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf=
_timed_may_goto.S
> index 6fd8b1c9f4ac8..84ecf6fa7f5dc 100644
> --- a/arch/powerpc/net/bpf_timed_may_goto.S
> +++ b/arch/powerpc/net/bpf_timed_may_goto.S
> @@ -36,7 +36,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)

[Severity: High]
This isn't a bug introduced by this patch, but does the stack frame allocat=
ion
in arch_bpf_timed_may_goto violate the PowerPC64 Big Endian (ELFv1) ABI?

Before this hunk, the trampoline allocates a fixed 112-byte stack frame and
saves caller-saved BPF registers:

	stdu    r1, -112(r1)

	/* Save BPF registers R0 - R5 (r8, r3-r7) */
	std     r3, 32(r1)
	std     r4, 40(r1)
	std     r5, 48(r1)
	std     r6, 56(r1)
	std     r7, 64(r1)
	std     r8, 72(r1)

Because STACK_FRAME_MIN_SIZE is exactly 112 bytes in ELFv1, writing to
offsets 40 through 72 places the saved registers directly into the TOC
save area (40) and the Parameter Save Area (48-72), which the ABI
reserves for linkage stubs and the callee.

When bpf_check_timed_may_goto executes, the ELFv1 ABI permits the C
compiler to spill its first argument into the PSA slot at 48(r1). Will
this silently overwrite BPF register R3 (stored at 48)? Similarly, could
linkage stubs clobber R2 by writing to the TOC save area at 40(r1)?

Since the BPF verifier assumes these registers are preserved by the
trampoline, this register clobbering could invalidate the verifier's
safety tracking at runtime and lead to out-of-bounds accesses.

>  	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
>  	 */
>  	add     r3, r31, r12
> -	bl      bpf_check_timed_may_goto
> +	bl      CFUNC(bpf_check_timed_may_goto)
> =20
>  	/* Put return value back into AX */
>  	mr      r12, r3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785387718.gi=
t.skb99@linux.ibm.com?part=3D2
