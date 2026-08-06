Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0D3BB69F
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028335; cv=none; b=B3XgQVYwO3rN8uP2IkEqoGDhNBUjxUGgNvx1vKxiE7w0rE3IgyygEZa2xJU65EtJqHxInL95laooPl8Dwfy26s+rc1/8drcLx5dWN1EZ0YH3eLqadDYCF22+biaN0QAsfp4OQQX9AgM2+8PLTrMyMsHe5RlG3BUuq6qFKTP7hHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028335; c=relaxed/simple;
	bh=GAqrs0T+eZW0B+luHZx5jJHcAe6/FGGLWaq1dYAqIfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T3rmZaDyDS5xGNFjgm1R5h78DRUtUYqP5snohu1AOaoOyxRZHL4y+6mIdltILwfaee4ntdQZAUAPP4wAvE35xOnUx7G28964Yh/ijpBzVYm1KBuSsxSMCqhB5Wyl4iQnjGjlJX+U8ypo+zLy/ui72lbTxRVntPIPfGwLvmKg0yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4NRYj5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4NRYj5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570CC1F00A3A;
	Thu,  6 Aug 2026 14:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786028333;
	bh=P2Tbvna7aEOK0Gl+EzQipGe+acYnHe0CUaJypFqoi60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i4NRYj5xOqqh4sXvJmhoybp5SdJs7DNjecVJeAPll1VycVPcUbPcsAZ9SBIYDFz2Z
	 Q2z3Ao/hLrpEvyNnQkBXODll51sw1yY3jr0BwVmLWf2TJOz9Ed5HkIL880BfzEPXcy
	 52Aqb4wQkhHcKFnRRtgfCBTVmj4QnWVo0+moj89CJj5c+Bmtp3A/PzG+hYtxDoqEjj
	 VsK3BLWc3xU8WSBAcDwYUUioMs5OQAR1EOTy+qieLUNlM0ayHO6/4wuRQkXhJcWJJY
	 KCSZMBXkofBeDl/ENuVi3TvPbJM0yaJeWD+2Ec+0CYJmN6PQ+jFEiMuLVzrn7cneLH
	 JMJZixbQYMh8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/6] bpf, x86: Fix exception table metadata for
 arena load-acquire
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806143924.319238-3-daniel@iogearbox.net>
References: <20260806143924.319238-1-daniel@iogearbox.net>
 <20260806143924.319238-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 14:58:52 +0000
Message-Id: <20260806145853.570CC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: ARM64 load-acquire and all architectures' RMW atom=
ics fail to clear the return register on fault
--

--- Patch [3]: [PATCH bpf-next 3/6] bpf, x86: Fix exception table metadata =
for arena load-acquire ---
commit 9812c186ec8bce0c6112e5b77175a8708cc4c31e
Author: Daniel Borkmann <daniel@iogearbox.net>
Subject: bpf, x86: Fix exception table metadata for arena load-acquire

A load-acquire from an arena pointer gets an exception table entry, but the
entry is filled in as if it were a store. This patch uses
bpf_atomic_is_load_acq() so a load-acquire correctly takes the load path.

Cc: Peilin Ye <yepeilin@google.com>

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

>  				 * BPF_PROBE_ATOMIC) before being used for the memory access. Pass
>  				 * the reg holding the unmodified 32-bit address to
>  				 * ex_handler_bpf().
> +				 *
> +				 * A load-acquire is of BPF_STX class, but reads from src_reg
> +				 * into dst_reg like a BPF_LDX does, hence it must not be
> +				 * treated as a store here.
>  				 */
> -				if (BPF_CLASS(insn->code) =3D=3D BPF_LDX) {
> +				if (BPF_CLASS(insn->code) =3D=3D BPF_LDX ||
> +				    bpf_atomic_is_load_acq(insn)) {
>  					arena_reg =3D reg2pt_regs[src_reg];
>  					fixup_reg =3D reg2pt_regs[dst_reg];
>  				} else {
>  					arena_reg =3D reg2pt_regs[dst_reg];
>  					fixup_reg =3D DONT_CLEAR;
>  				}

[Severity: High]
This isn't a bug introduced by this patch, but could this fix be missing ot=
her
RMW atomics on x86, as well as leaving similar vulnerabilities on ARM64 and
PowerPC?

For x86_64, RMW atomics like BPF_XCHG, BPF_CMPXCHG, and BPF_FETCH ops retur=
n a
value that must be cleared, but they seem to fall into the else branch in
populate_extable() and get fixup_reg =3D DONT_CLEAR. If a fault occurs on an
unmapped arena address, the exception handler skips the instruction without
clearing the return register. Since the verifier treats the result of these
atomic operations as an unconstrained scalar, a BPF program could stash a k=
ernel
pointer in the return register beforehand, then leak it to userspace after =
the
fault.

Additionally, this issue appears to exist on other architectures.

On ARM64, add_exception_handler() in arch/arm64/net/bpf_jit_comp.c assumes =
all
BPF_STX instructions are stores, failing to clear dst_reg for load_acq and =
other
returning atomics:

    if (BPF_CLASS(insn->code) !=3D BPF_LDX)
        dst_reg =3D DONT_CLEAR;

On PowerPC, bpf_add_extable_entry() in arch/powerpc/net/bpf_jit_comp.c emit=
s a
NOP fixup instead of clearing the destination register for any BPF_STX
instruction:

    fixup[0] =3D PPC_RAW_LI(dst_reg, 0);
    if (BPF_CLASS(code) =3D=3D BPF_ST || BPF_CLASS(code) =3D=3D BPF_STX)
        fixup[0] =3D PPC_RAW_NOP();

While load_acq might be unsupported on PowerPC arena pointers, value-return=
ing
atomics like xchg and cmpxchg are supported and vulnerable to the same leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806143924.3192=
38-1-daniel@iogearbox.net?part=3D3
