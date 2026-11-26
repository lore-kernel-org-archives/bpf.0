Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673162;
	b=4NJoLQT+Uwqo9Vkoa/p894v/Pu38XUvJlJliESHo5q0+lGn2d/NjMMEx4M2dt2xd/jlt
	 4uNQLJzDP8csg0QjrOGpYD4n4EA8Yv51g33O3q5MLDlWyT8XpQzZhvUT88OVPjeop9VIl
	 GqjHsX8BwXT04XFUq3nAN27ZyQFK10ey65dDYd8yig99yISRNB2n6tm3NWod1EcxzOS+g
	 PXAIZkj7QQqOkAbABEM7GRj1xNFfOjOlR8B5+xetJnNXTujZShyTHDz6dy38LwEGcdJ2+
	 fjJQO+AIIzdTcuQdMGQA+jR1u0e8+CimGT9fUq4hRviPx6K/vugF4W+AlwU8WeIaZVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673162;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GYi5tVcrUNo4hD9Xv0yKjtWS0hn4Hp4xO7sP2XMdMFI=;
	b=bhF/4na+r7LuxMdSaQeB/MvEATuZGd9gZeucElm3z/7drrJwb8yAebY7dLiMdElGKIFC
	 pqppDZZGzI3SEhdt1UvdO3ayiqFzK3zqPh/2gTsNpP1K2nflEld3E8UXl2lJzLHYuQX3p
	 Y5VhyELcLuZ+ysQ2mc2G7pA9Nykwnbf3i/clkMeRl0idGErWe3sSXkP2Qb1Xh0uBxvBWH
	 pg19AgQsSse1Wu/jqapABp351p504OnSggRnlVyV+9jx2UYCGSCx+0bBlAZHEWvk4oehM
	 n8YcGViLsg2fcZvWBQEcEtYWgYrwbHrqI16UZ1RAizTWIx5t31ApA4FNWhzWORBMGdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6zVqS8i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958A606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6zVqS8i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8DF1F000C4;
	Thu, 26 Nov 2026 06:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795673161;
	bh=GYi5tVcrUNo4hD9Xv0yKjtWS0hn4Hp4xO7sP2XMdMFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i6zVqS8iCjvzi2ELSqrn0lQGK41dCvVBeoLiSVKhHj248zToS1HQL3QYtJBSkGLn/
	 gMqKGVWeeaufrZC/Q8lnyIVh/WzgwHRtYhs+urf/hxX34cWFscekm3rsPOnFHw8QTl
	 2fpQLYZagdnjBd1Qjdm++iYK/86KMm7TyS96zysRacmYCAUwAg2dUsCvIVntM2a6pU
	 cagzC1oHNKdH0DNwFyFlkXkgVmin62UvGj/JgJM28wHLXu2f79hSXAykHk4XJWgiQV
	 /oJss5h2nHOzwPW10IPXIJGx0U0wTg7/gr3E0kMglbDvbv+yW/RL4y/GUrWTqaa7nY
	 EOIFkGLfX3gVg==
Message-ID: <sashiko-outbox-234823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 5/5] selftests/bpf: Enable arena atomics
 tests for LoongArch
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261126055355.9967-6-dongtai.guo@linux.dev>
References: <20261126055355.9967-1-dongtai.guo@linux.dev>
 <20261126055355.9967-6-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:06:01 +0000
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
- [Medium] selftests/bpf: arena atomics enabled on LoongArch without JIT
  support
--

commit 981cacb8f524da5a2f9e574371d2773a0e55c40e
Author: George Guo <guodongtai@kylinos.cn>

selftests/bpf: Enable arena atomics tests for LoongArch

This commit enables the load-acquire and store-release arena atomics
selftests, as well as the libarena parallel bitmap and spmc selftests, on
LoongArch.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel=
_bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_paralle=
l_bitmap.bpf.c
> index 017add229befe..722971b1eba8f 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap=
.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitmap=
.bpf.c
> @@ -24,6 +24,7 @@ static volatile bool test_abort;
>  	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
>  	 defined(__TARGET_ARCH_s390) || \
>  	 defined(__TARGET_ARCH_powerpc) ||				  \
> +	 defined(__TARGET_ARCH_loongarch) || \
>  	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64))
>  static bool bitmap_tests_enabled(void)
>  {
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_parallel=
_spmc.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_=
spmc.bpf.c
> index 5fa96eb740951..af577e1e50508 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.b=
pf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_spmc.b=
pf.c
> @@ -70,6 +70,7 @@ static volatile u64 round_steals;
>   */
>  #if defined(ENABLE_ATOMICS_TESTS) &&		  \
>  	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
> +	 defined(__TARGET_ARCH_loongarch) || \
>  	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64))
>  static bool spmc_tests_enabled(void)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/arena_atomics.c b/tools/te=
sting/selftests/bpf/progs/arena_atomics.c
> index 2a9664f543993..fcb70b9844346 100644
> --- a/tools/testing/selftests/bpf/progs/arena_atomics.c
> +++ b/tools/testing/selftests/bpf/progs/arena_atomics.c
> @@ -30,6 +30,7 @@ bool skip_all_tests =3D true;
>  	defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
>  	(defined(__TARGET_ARCH_arm64) || \
>  	 defined(__TARGET_ARCH_x86) || \
> +	 defined(__TARGET_ARCH_loongarch) || \
>  	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
>  	 defined(__TARGET_ARCH_s390))
>  bool skip_lacq_srel_tests __attribute((__section__(".data"))) =3D false;
> @@ -454,6 +455,7 @@ int load_acquire(const void *ctx)
>  	defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
>  	(defined(__TARGET_ARCH_arm64) || \
>  	 defined(__TARGET_ARCH_x86) || \
> +	 defined(__TARGET_ARCH_loongarch) || \
>  	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
>  	 defined(__TARGET_ARCH_s390))
> =20
> @@ -508,6 +510,7 @@ int store_release(const void *ctx)
>  	defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
>  	(defined(__TARGET_ARCH_arm64) || \
>  	 defined(__TARGET_ARCH_x86) || \
> +	 defined(__TARGET_ARCH_loongarch) || \
>  	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) || \
>  	 defined(__TARGET_ARCH_s390))

[Severity: Medium]
Does enabling these arena atomics tests on LoongArch fail verification and
program loading because the LoongArch BPF JIT does not yet support arena
atomics?

For atomic instructions targeting PTR_TO_ARENA, atomic_ptr_type_ok() in
kernel/bpf/verifier.c checks bpf_jit_supports_insn(insn, true):

kernel/bpf/verifier.c:atomic_ptr_type_ok() {
    ...
	if (is_arena_reg(env, regno))
		return bpf_jit_supports_insn(insn, true);
    ...
}

arch/loongarch/net/bpf_jit.c does not implement bpf_jit_supports_insn(), so
LoongArch falls back to the weak default in kernel/bpf/core.c that returns
false, causing the verifier to reject any BPF_ATOMIC instruction on an
arena pointer with -EACCES.

In addition, do_misc_fixups() in kernel/bpf/fixups.c rewrites atomic
instructions on PTR_TO_ARENA to BPF_STX | BPF_PROBE_ATOMIC |
BPF_SIZE(insn->code), which build_insn() in arch/loongarch/net/bpf_jit.c
does not handle.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126055355.9967=
-1-dongtai.guo@linux.dev?part=3D5
