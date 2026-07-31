Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7C3B637A
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525997; cv=none; b=R85ysf3hj6C0PK8rcAx34gO+zh/WIr1UGdEG9ZhIAf5FkmezV4jrAxrLLYCC0B5lIOPmdoiWX9Q/cFfEk9XBxaBN+m76R+SOinszkkSfMGg1Zm/6LEUVBj/JhTE+AAL7oZyUMrXp1rYlUM47vI4rdR3TctoFgt2eEOmgrsf85aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525997; c=relaxed/simple;
	bh=4Umsazmsjz5P1aeiTFAbn6V8f+uc+/ZVWTbKPct4BpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hvUmHIgJG+pgX1gq+53ozAr3mc220nSoQ/9V7SYm+zNZeXnCTBrsO/Hgh6G3bPMuYl/bhDi1alTeb1JAtsU1ZuiQv5TXCOz24/v12+QUhHLPvPXNrVgJ0FpBgkdFr3rgZI7G+JlLp9CEamWd6TZ7oCEemopB0oUSBvqFAMjQomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mB1Do2Sz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mB1Do2Sz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8111F00AC4;
	Fri, 31 Jul 2026 19:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785525995;
	bh=GBPRI4bfLA6B5fkfuDezFPhxUT5ubh7uKxvcw8OJ4m0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mB1Do2SzFxGDG3s4iUD0yBfKsGy2JJOQkKTra1Mw7sgxTcLeT1Iy9S6avfEKwCmUt
	 AYOir8NEwR7DoUT2tbTfiBtAGCUv5fTsxNX/ggGNxXo5IMIQ53GLgYX84AJduVRMPy
	 mxl1gT2TufvJMTqx3Q2lZhRP9DOI5DaF5fyi6j1I0Vy4ny/rD6hW36O8nQ590LPE/4
	 m4CUmyPSHY9ZdqVLW/qfDuaDRD9TvzIPs3WoLzh99VRD0nOVj3hUKhgkg2BYriA9bM
	 ndNcD9riSgvCWMvKCTj418vIW+8kX4mF8QoQoNzbmgcNRfVdw/XF5Mo6Z8VEzMmgHD
	 eELpsHjVvmJ2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/5] bpf: infer zext_dst based on static
 register liveness analysis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260731-static-zext-v1-3-98a4dc73e94b@gmail.com>
References: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
 <20260731-static-zext-v1-3-98a4dc73e94b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 19:26:34 +0000
Message-Id: <20260731192635.8B8111F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Incorrect static liveness tracking for 64-bit conditional jump=
s leads to missing zero-extensions (`zext_dst`), resulting in verifier/runt=
ime state divergence and potential privilege escalation.
--

--- Patch [3]: [PATCH bpf-next 3/5] bpf: infer zext_dst based on static reg=
ister liveness analysis ---
commit ab8592d6a434dbfed0cbb0bd067d9032b308db8d
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: infer zext_dst based on static register liveness analysis

This commit replaces the dynamic subreg_def based zero-extension
tracking with static liveness analysis to correctly infer zext_dst
and prevent missing zero-extensions on architectures like s390x.

Link: https://lore.kernel.org/bpf/CAGKGUv=3DsOuqQtA1Ub-5JXfA4FPosJFYKAQE4B7=
9cK+P1erxqtg@mail.gmail.com/

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index c996b8a03e792..ea002550671a8 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -2317,9 +2318,18 @@ int bpf_compute_live_registers(struct bpf_verifier=
_env *env)
>  	}
> =20
>  	for (i =3D 0; i < insn_cnt; ++i) {
> +		int def32 =3D bpf_insn_def32(&insns[i]);
> +		u32 out =3D state[i].out;
>  		u32 in =3D state[i].in;
> =20
>  		insn_aux[i].live_regs_before =3D mask_lo(in) | mask_hi(in);
> +		/*
> +		 * On architectures where 32-bit operations do not reset upper halves
> +		 * of the registers, the verifier needs to zero extend a destination
> +		 * register if an instruction defines a 32-bit subregister and the
> +		 * upper half of that register is alive after the instruction.
> +		 */
> +		insn_aux[i].zext_dst =3D def32 >=3D 0 && (mask_hi(out) & BIT(def32));

[Severity: Critical]
Does this code correctly evaluate liveness for 64-bit conditional jumps?

The new zext_dst logic relies on mask_hi(out) accurately reflecting if the
upper half of a register is alive.

However, looking at compute_insn_live_regs() in kernel/bpf/liveness.c for
conditional jumps:

    const u8 class =3D BPF_CLASS(insn->code);
    const u8 code =3D BPF_OP(insn->code);
    ...
    case BPF_JMP:
    case BPF_JMP32:
        switch (code) {
        ...
        default:
            def =3D 0;
            if (BPF_SRC(insn->code) =3D=3D BPF_K)
                use =3D dst;
            else
                use =3D dst | (code =3D=3D BPF_JMP32 ? src : src32);
        }

Can the code variable ever equal BPF_JMP32?

BPF_OP() extracts the operation code (which is a multiple of 16), while
BPF_JMP32 is a class (0x06). This means the check code =3D=3D BPF_JMP32 eva=
luates
to false, and the source register usage always falls back to src32, even for
64-bit jumps (BPF_JMP).

If a 32-bit operation defines a register, and it is followed by a 64-bit
conditional jump using that register as a source with no other uses of the
upper 32 bits, the upper half won't be marked as alive.

As a result, zext_dst wouldn't be set, which could lead to the JIT skipping
the mandatory zero extension. This would cause the 64-bit jump to compare
against uninitialized garbage in the upper bits, potentially allowing
out-of-bounds access.

Should this check use class =3D=3D BPF_JMP32 instead?

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-static-zex=
t-v1-0-98a4dc73e94b@gmail.com?part=3D3
