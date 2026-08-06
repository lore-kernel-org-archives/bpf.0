Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CDA48424D
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048233; cv=none; b=jbuussQzia6yQjg3NfRqRzLXqfbqykbilkid+Qk7y8wHMDBRI/mBF9UMPnUtSOHsFLZCGii0jbMkgpTQ9wc8Gaj26lcGBGiCfEm65AzbmqZ4wvsd7dAh/xcu8VUfrjFb7KGI54rh1Ct8PqDagv7AkmO9+KCgQuDuiOEMyT5lEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048233; c=relaxed/simple;
	bh=2L+DJXTp8yzWRLrX/5N/zjcep8oG34sS2y5XyJ+jaDQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bGk2Urq55sjZqvls1r1PLXgme3waHEeIJGwtNE2qkhr6GgEi/2RP9fJ/1zPsIOtWhTIEKgppcUMd6/xYUlkqalYq0HctI9iqGeDK/UC+rjFajO5wD/WF2b06j9yGtuLxxygGe+LtFYWsvziG762aISUBPSZu424PVUA/rpZ9kMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aloagnz2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aloagnz2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BEA1F00A3A;
	Thu,  6 Aug 2026 20:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786048232;
	bh=sWVi3R8RxqI0LzaSFwAKMuOWAq3oPB35XL4TWxrEbOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Aloagnz2bWguNX+1Sg/NoXnGiPe53ODqUBhKC/zX8hCW3951bod8SPsQy9h57tZWI
	 k8+7VcrORlGbUD5Iitvf+GojS7HB1BgRRe/ULycbImcGf/a7ZPpoiUStfcfKDTQ+g7
	 Tzoe8/rBABCpnvABpLs2UnuP0i3TnSEjU7lcaEBwS9MnA+jK9fJQIKuuvpPWFxqV20
	 ZvcoAZdZYZtal8qVYKvlaBO4twJ9L12+mb+cfkcM0MGV+NvTYbjlCEohz4AO1hH1xG
	 1jQGDUB4+xEiIp3h64O9G7gNGbVWxSDG8Du1IUxEPLedonr0Lmux+XvbX67OSD43SQ
	 VFSWYtqN2DuQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/6] bpf, x86: Fix exception table metadata
 for arena load-acquire
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806201047.333389-3-daniel@iogearbox.net>
References: <20260806201047.333389-1-daniel@iogearbox.net>
 <20260806201047.333389-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 20:30:31 +0000
Message-Id: <20260806203032.09BEA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The x86 JIT exception table metadata fix for `BPF_PROBE_ATOMIC` su=
ccessfully addresses `BPF_LOAD_ACQ` but incorrectly handles read-modify-wri=
te (RMW) fetch operations (e.g., `BPF_CMPXCHG`, `BPF_XCHG`, `BPF_ADD | BPF_=
FETCH`), leading to silent lock acquisition successes and potential informa=
tion leaks.
- [High] The ARM64 and s390 BPF JITs fail to properly populate exception ta=
ble metadata for arena atomic instructions, leaving both `BPF_LOAD_ACQ` (on=
 ARM64) and RMW fetch atomics (on both architectures) broken on unmapped pa=
ge faults.
--

--- Patch [3]: [PATCH bpf-next v2 3/6] bpf, x86: Fix exception table metada=
ta for arena load-acquire ---
commit 45e0ae10aa75994903c64f22211117edeb408932
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf, x86: Fix exception table metadata for arena load-acquire

This commit fixes an issue where load-acquire instructions on arena
pointers were incorrectly treated as stores by the exception table
logic on x86. It ensures the destination register is properly cleared
and the correct address register is reported during a fault.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 01e7ce569c1ed..88ed95b2eaa72 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2331,8 +2331,13 @@ st:			insn_off =3D insn->off;
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
This isn't a bug introduced by this patch, but it seems read-modify-write
(RMW) fetch operations like BPF_CMPXCHG, BPF_XCHG, and BPF_ADD | BPF_FETCH
might also be incorrectly handled here.

Since RMW fetch atomics belong to the BPF_STX class and are not LOAD_ACQ,
they incorrectly fall into this else branch in do_jit() where fixup_reg is
set to DONT_CLEAR.

If a BPF program executes a BPF_CMPXCHG on an unmapped arena page, the
exception handler will intercept the fault but leave the destination regist=
er
uncleared.

Could this allow a lock acquisition loop checking if the register matches t=
he
expected value to falsely assume the lock was acquired, potentially bypassi=
ng
BPF concurrency controls?

Does this also risk leaking the uncleared pointer?


[Severity: High]
This is a pre-existing issue, but similar logic appears to be missing for
ARM64 and s390 JIT implementations for arena atomic instructions.

In arch/arm64/net/bpf_jit_comp.c:add_exception_handler():

	if (BPF_CLASS(insn->code) !=3D BPF_LDX)
		dst_reg =3D DONT_CLEAR;

Does ARM64 also fail to identify BPF_LOAD_ACQ and RMW atomics as instructio=
ns
that require clearing a destination register, treating them as DONT_CLEAR?

This could trigger the exact same bug fixed for x86 in this patch.

Additionally, in arch/s390/net/bpf_jit_comp.c:bpf_jit_probe_atomic_pre():

	if (BPF_MODE(insn->code) !=3D BPF_PROBE_ATOMIC)
		return;

For RMW atomics on s390, the function seems to fail to assign a register to=
 be
cleared, meaning the exception handler does not clear any register upon an
unmapped page fault.

Could this also lead to silent lock acquisition bypass on s390?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806201047.3333=
89-1-daniel@iogearbox.net?part=3D3
