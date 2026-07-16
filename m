Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569CA3BAD8B
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188661; cv=none; b=SgnkjHuUG7gldCwABJNtPKS1h1uKIu3/S3G7XquPz64Gc1pJmCDIl464PIsQMfO4SlFU2u6dyI1cK24Q74Cv84ITnYAbtSrQgubxURaCi8S9zxBUBlm1G/gpXXUX6wGarLGCqU0dTbf6NAr5qBAbuyYuS0yQq4XtN/AwXuJReLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188661; c=relaxed/simple;
	bh=mmHtBqnLDhZhxHUt8I5ZH+QXjV4DQBfzjWBADIMlfnc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jmvoA9mN2CCeGJW0aBrSghDsphi7x7/Orq4bIJWxz4fTE7lSL/hB5TVbL24H+thwxUbos3fe+PYNfOxDCnHGHia+sHD/YiyPJmtwF5AQrj9Uz4c4jgaezfSSjNWhlXmkpGAWhh/3sfpU1jc0wmoQOwcgp8MfahPH0URqdrBcEC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsUpMjvg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsUpMjvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FCF1F000E9;
	Thu, 16 Jul 2026 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188659;
	bh=LhMlqvQrH/s78G7lGus8FoEMqO9v0Dl2uONKnbciUXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DsUpMjvgM/fufhwZUx/5+U1gy7i0UEbO7C1DWtlMWV0CuP+9gsSw+M22AE3G1Ecaq
	 73bodRaDtiDTh2xRomUoWElCTjjJpFQ8yqwu8TkbEHXu8hwOllMEg+V8t9nJmZ6CES
	 o/CSlt66yhpvKEdltqWTSwD4osyWMTmVyl+cIR/IQKJSOqbMN/oJ8EYTJbDubCdnUA
	 a5jT9Drz82nQoKa2KTWx49vUEJTP1tQHxwdXJyUNlZqce6CdqyxfyRuOO5oeoW/dOY
	 5xjF/demTSP7skFpyN8R/Z4qf7yS75/qAuZiwJ5VTCfy+oGlO/lLLulrT8veAVCLUD
	 0wR9Pro9XiWww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] bpf, riscv: fix missing extable entry for arena
 load_acquire
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Jiang" <jiangfeng@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260716-bpf-riscv-fix-extable-v2-1-421f75812533@kylinos.cn>
References: <20260716-bpf-riscv-fix-extable-v2-1-421f75812533@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 07:57:39 +0000
Message-Id: <20260716075739.B4FCF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] RISC-V JIT fails to clear the destination register when a `BPF_PRO=
BE_ATOMIC` load (such as `BPF_LOAD_ACQ`) faults, allowing kernel memory lea=
ks.
--

--- Patch [1]: [PATCH v2] bpf, riscv: fix missing extable entry for arena l=
oad_acquire ---
commit 2509cde9a02f8401503f583c4cbef2abd9a13bac
Author: Feng Jiang <jiangfeng@kylinos.cn>

bpf, riscv: fix missing extable entry for arena load_acquire

This commit fixes an issue where the exception table entry is missed for a
sub-word load_acquire in emit_atomic_ld_st(). It modifies the logic to check
if ret >=3D 0 before calling add_exception_handler(), preserving the return
value so build_body() still skips the zero-extension.

Link: https://lore.kernel.org/r/20260716-bpf-riscv-fix-extable-v1-1-af023cc=
17af4@kylinos.cn

> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index f9d5347ba966b..0db89093ff897 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
[ ... ]
> @@ -1986,7 +1986,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  		else
>  			ret =3D emit_atomic_rmw(rd, rs, insn, ctx);
> =20
> -		ret =3D ret ?: add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
> +		/* ret can be 1 (skip-zext); extable entry still needs to be added */
> +		if (ret >=3D 0)
> +			ret =3D add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx) ?: re=
t;

[Severity: High]
This isn't a bug introduced by this patch, but does hardcoding
REG_DONT_CLEAR_MARKER here cause a kernel memory leak if a BPF_PROBE_ATOMIC
load (such as BPF_LOAD_ACQ) faults?

If a BPF program places a kernel pointer into the destination register and
then uses it for a BPF_LOAD_ACQ on an unmapped arena pointer, the instructi=
on
will fault. Since REG_DONT_CLEAR_MARKER is passed to add_exception_handler()
here in bpf_jit_emit_insn(), the exception handler will skip clearing the
destination register.

Because the verifier assumes the register is completely overwritten with a
loaded scalar, it will track the retained kernel pointer as a scalar, which
the program could then extract by writing it to a map.=20

Should this use the appropriate destination register (e.g., rd) instead of
REG_DONT_CLEAR_MARKER for load operations?

> +
>  		if (ret)
>  			return ret;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-bpf-riscv-=
fix-extable-v2-1-421f75812533@kylinos.cn?part=3D1
