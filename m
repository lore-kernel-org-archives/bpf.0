Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673040;
	b=0JM2sfnJihhZKu3jQbiznBCsacEp7KbPGu2w/BPNJfZ+C2ZPx+ZveKZK2VR02jNvkWhE
	 pvyfYg+hvFTWTGotDjoUI0/us2aLFfDZEd0PjkLTcpCuYqa9RyJbn3JmDFsdJdqTji+2v
	 HUHFHNK0INPfh/dojNjYHt2wTyCJ6gJLjEos7AeW2Hqktl+TXdr9+l66jBuvHLVUYfy6U
	 iJ2YdwjhsJxiOiUglZWdKHQXQvpJe491rhvbJWCP7r4yLC1epDxo+CxFXO1oNkinoCxFh
	 cTvs9V1ud2Uhl0s8Bg13RmzOoqsQPg4zF70WrdM61V68/Qf+H/iwwBRjw2dmn5TIGew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673040;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A9hHUdEOg8W9aE5/sh1JKZXo65TRNknsiP6xFE68Wmg=;
	b=dsWJ9XgeVdoafVZhOx2Rtk5qL6nVdBLlB3dd/YsL4qlUjJfPqPEW5MUWLTCCE3xoxzV2
	 EM+3mL3JC87wdw6Tem3fYp3jrH6jkjjs8QzpQtg4NihLy8KT5mr1ePoQAjQvE+RR6Nq9t
	 Bwdwipl5/3CauzWrDCG2k10rTJJvmV+UF1BCCy5lmIZBure8uYP2iMCXYZGUWkVIT4dQG
	 qnYbNHkIgANGqykYhjnO3nnXi6XNvPTkqgZannvZ9yA3PuG0yTX2aqZlQ4EwkrmvyU02A
	 N+A0UmSiAOFmNKf8TeiMEqplYv9qLc5RSTRf7LTkTBxT8E+wTZFBLftZVbSvLcLBTqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOZhGmhN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F2606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOZhGmhN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24401F000C0;
	Thu, 26 Nov 2026 06:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795673039;
	bh=A9hHUdEOg8W9aE5/sh1JKZXo65TRNknsiP6xFE68Wmg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fOZhGmhN/cTOEnCJFjRC2/tN1JNZNtSsDqMICAPoLg+lCqB9w8Edsj+RzTHJ8Pj44
	 JWFcGpWHWxceHVGHOqlrKhk3gqYpcoOJZmUv1qq2heSxgLh5qhFkox11PMLVE6V69Z
	 wzCRw+o678L2a/lNyiJI9ydhX0wGukWRMyRh8ZdAZ60QBsG1xdqNy3um9d/Oh8LO35
	 D7iuLrhBQ2Nt7xT82v3ELvcM1QeT9oii5UCqXvQCpRBXv49M0fXlBdM0V8bf9vGA0+
	 mSC898Ug15t2Mfscb2BGJ5f+uNDg6jhLMvVYKLDMAfkgBgsU/V4ytOVqTI2441yKjH
	 kX6vgJ3TLnhoA==
Message-ID: <sashiko-outbox-234818@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 4/5] selftests/bpf: Enable arena LDSX tests
 for LoongArch
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261126055355.9967-5-dongtai.guo@linux.dev>
References: <20261126055355.9967-1-dongtai.guo@linux.dev>
 <20261126055355.9967-5-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:03:58 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests/bpf: arena LDSX tests enabled on LoongArch without
  JIT support
--

commit b68bf732b641a949e70ea34125906397162f4821
Author: George Guo <guodongtai@kylinos.cn>

selftests/bpf: Enable arena LDSX tests for LoongArch

This commit enables the arena signed-load tests in verifier_ldsx on
LoongArch and adds the expected LoongArch JIT disassembly for
arena_ldsx_disasm.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/te=
sting/selftests/bpf/progs/verifier_ldsx.c
> index 232082428cb96..ad7ae015b39d9 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> @@ -299,6 +299,19 @@ __jited("add	t2, a0, s7")
>  __jited("lh	s4, 0x18(t2)")
>  __jited("add	t2, a0, s7")
>  __jited("lb	s4, 0x20(t2)")
> +__arch_loongarch
> +__jited("add.d	$t2, $a5, $s6")
> +__jited("ld.w	$s2, $t2, 16")
> +__jited("add.d	$t2, $a5, $s6")
> +__jited("ld.h	$s2, $t2, 24")
> +__jited("add.d	$t2, $a5, $s6")
> +__jited("ld.b	$s2, $t2, 32")
> +__jited("add.d	$t2, $a0, $s6")
> +__jited("ld.w	$s3, $t2, 16")
> +__jited("add.d	$t2, $a0, $s6")
> +__jited("ld.h	$s3, $t2, 24")
> +__jited("add.d	$t2, $a0, $s6")
> +__jited("ld.b	$s3, $t2, 32")
>  __naked void arena_ldsx_disasm(void *ctx)
>  {
>  	asm volatile (
> @@ -331,6 +344,7 @@ __success __retval(0)
>  __arch_x86_64
>  __arch_arm64
>  __arch_riscv64
> +__arch_loongarch
>  __naked void arena_ldsx_exception(void *ctx)
>  {
>  	asm volatile (
> @@ -353,6 +367,7 @@ __success __retval(-1)
>  __arch_x86_64
>  __arch_arm64
>  __arch_riscv64
> +__arch_loongarch
>  __naked void arena_ldsx_s8(void *ctx)
>  {
>  	asm volatile (
> @@ -385,6 +400,7 @@ __success __retval(-1)
>  __arch_x86_64
>  __arch_arm64
>  __arch_riscv64
> +__arch_loongarch
>  __naked void arena_ldsx_s16(void *ctx)
>  {
>  	asm volatile (
> @@ -417,6 +433,7 @@ __success __retval(-1)
>  __arch_x86_64
>  __arch_arm64
>  __arch_riscv64
> +__arch_loongarch
>  __naked void arena_ldsx_s32(void *ctx)
>  {
>  	asm volatile (

[Severity: Medium]
Does enabling these five arena signed-load tests depend on a missing
LoongArch JIT patch?

In convert_ctx_accesses(), BPF_MEMSX loads on PTR_TO_ARENA require
bpf_jit_supports_insn(insn, true) to return true before rewriting the
instruction to BPF_PROBE_MEM32SX:

kernel/bpf/fixups.c:convert_ctx_accesses() {
    ...
		case PTR_TO_ARENA:
			if (BPF_MODE(insn->code) =3D=3D BPF_MEMSX) {
				if (!bpf_jit_supports_insn(insn, true)) {
					verbose(env, "sign extending loads from arena are not supported yet\n"=
);
					return -EOPNOTSUPP;
				}
				insn->code =3D BPF_CLASS(insn->code) | BPF_PROBE_MEM32SX | BPF_SIZE(ins=
n->code);
    ...
}

arch/loongarch/net/bpf_jit.c does not implement bpf_jit_supports_insn()
or handle BPF_PROBE_MEM32SX in build_insn() and add_exception_handler(),
so LoongArch falls back to the weak default bpf_jit_supports_insn() in
kernel/bpf/core.c that returns false.  As a result, the verifier rejects
all five programs with -EOPNOTSUPP and verifier_ldsx fails on LoongArch
instead of skipping them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126055355.9967=
-1-dongtai.guo@linux.dev?part=3D4
