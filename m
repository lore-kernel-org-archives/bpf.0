Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3128D8D0
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787518381; cv=none; b=f+RfbYGuqnnk6uevel2VPQUBEPOIprVAEWJi8rtcMOTMtljfEfx781bei/dzI27gwapZw7OF7YDtzID8lz/eRcDvA+/JeB0egjiPFrnLJO+S9joYTvlddJdEP5cXh6T7SYNDn8oWWYV6akruieO4F5bVIXrnE9Zzc4Witl2+4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787518381; c=relaxed/simple;
	bh=hGdQCM6B/cYrO0QJo8yQYVlSBv4V2Wkme9U9HMPyjGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZbDYbnsp+TAcglYrVH0ucqKJfmAPpM+2jKBfnU34CmOx9B3aKTl049hsYgPswcm4cS6AOvl4RuP5H3LdzAaNFIpIx2lzT6cEigyeaaSgpS7iTwRWL1r7kncRyPJnYIvWC8Wk32TtRaMUUm3pz5/s7wszfPGrBZbQeW5oQvU/iMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V119w3zC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V119w3zC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF091F00A3A;
	Sun, 23 Aug 2026 20:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787518380;
	bh=StU0SvRF+U7Cjku25QBPz+wQp7zE3sFWSKjPh5+WKsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V119w3zC7CCPZLrG3cJhJggzUUJnRxKJTnfroTXT10D+DOCH75vtk/Qzg1jNWDOXR
	 B1Hjpud+bEr0TvCgvXJOaFSlFI3yOSR0DAs8aAgsMr0lbiyAlnNtkyaja1AcVuiyJC
	 04PEH1oDtdoQVHTV2Pc7qqsXxlpX/sBlH5nG5Mvfx1LGTPBcJWlZTQZa5TkM3Jm5Bq
	 dWw6GTVy3mP3OmwoUxlxpOXT4PnAcmg715tV118mCTOdCs0JMqTT+cjaCv/OpM8cnU
	 rBaN3GGC55NB0irpiZCj87QKD+/mVSGj5K1hfuZtNVH7rkfpOO14ApR0zC6/rPo//R
	 ItwXIuw5H3/Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf, x86: Sign-extend narrow signed kfunc returns
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260823203944.2084994-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260823203944.2084994-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 20:52:59 +0000
Message-Id: <20260823205300.4BF091F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The sign-extension fix for kfunc returns is implemented for x86-64=
 but omitted for other architectures (ARM64, PowerPC64, x86-32) where ident=
ical verifier/runtime divergence exists.
--

--- Patch [1]: [PATCH] bpf, x86: Sign-extend narrow signed kfunc returns ---
commit 9b3fa67779a40b052a3a12d689e1b9cac8ac02a9
Author: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

bpf, x86: Sign-extend narrow signed kfunc returns

This patch fixes an issue on x86-64 where narrow signed kfunc return values
are not properly sign-extended to 64 bits. This divergence between verifier
assumptions and runtime execution can lead to state corruption and unbalanc=
ed
locks. The JIT is updated to use the kfunc's BTF model to sign-extend these
returns into R0 after the native call.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 2853e87797a78..ec8a7694adb62 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -2665,6 +2682,11 @@ st:			insn_off =3D insn->off;
>  			ip +=3D x86_call_depth_emit_accounting(&prog, func, ip);
>  			if (emit_call(&prog, func, ip))
>  				return -EINVAL;
> +			if (src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
> +				err =3D emit_kfunc_return(bpf_prog, insn, &prog);
> +				if (err)
> +					return err;
> +			}

[Severity: High]
This isn't a bug introduced by this patch, but it appears this same issue
is present in other architectures where the native calling convention leaves
the upper 32 bits undefined for 32-bit returns.

For example, in the ARM64 JIT:

arch/arm64/net/bpf_jit_comp.c:build_insn() {
    ...
    if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
        ret =3D emit_kfunc_arena_args(ctx, insn);
        if (ret < 0)
            return ret;
    }
    emit_call(func_addr, ctx);
    ...
}

The ARM64 JIT lacks post-call return value sign-extension, leaving the upper
32 bits of X0 undefined per the AAPCS64.

Similarly, in PowerPC64:

arch/powerpc/net/bpf_jit_comp64.c:bpf_jit_build_body() {
    ...
    ret =3D bpf_jit_emit_func_call_rel(image, fimage, ctx, func_addr);
    if (ret)
        return ret;
    /* move return value from r3 to BPF_REG_0 */
    EMIT(PPC_RAW_MR(bpf_to_ppc(BPF_REG_0), _R3));
    ...
}

And on x86-32, the upper 32 bits of BPF_REG_0 are left uninitialized
on the stack for 32-bit and narrower returns, leaving stale data from
before the call:

arch/x86/net/bpf_jit_comp32.c:emit_kfunc_call() {
    ...
    if (fm->ret_size > sizeof(u32))
        /* mov dword ptr [ebp+off],edx */
        EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EDX),
              STACK_VAR(bpf2ia32[BPF_REG_0][1]));
    ...
}

Since a BPF program calling a kfunc that returns a narrow signed type
(like bpf_res_spin_lock) would also experience the verifier/runtime diverge=
nce
on these architectures, does this sign-extension fix need to be applied
there as well to prevent state corruption?

>  			if (priv_frame_ptr)
>  				pop_r9(&prog);
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823203944.2084=
994-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1
