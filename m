Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409970;
	b=g2HlQSLEQi9/U52Na1upy5SYuR49rKh6XlPY0+Ppo7mJk5IGPmLHAYoozMn935lTh83q
	 gPmyeg8Lx4C8R7kmRmqK8NndonDSxQKNfGoDEMkdQghWIcZ/AVWzvICORzfUkGMlKr3l5
	 EZsEAysVyzF+FahyfbF1nW+/lZAVkRr9xgcgap1j25aEzvxBlbDj179s+qdx87GBd7xlW
	 7xsbH/Ypkm0X2IF8WzecZBagbQ7cNoVEPuNCst8P5mZgNkINvBIlc/mTN/clovfaKVnWM
	 Phu8LrXTTU6XeZqmgqypfOA9r5lAVDcRQFTrby7yJZRzVww45hSjgHvugi5d9uH/qIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409970;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z8cwSRx92FD7cY5sm9Q+TUdBS9Vf7k2N5TwccBvatyA=;
	b=APg7zEkP1IWFZGW7eF+VzaKrPd4Sh0xTMDA7CTNftevXYRk93JKxZ3+GqO/XBGz0PzlO
	 NCDBAksM+PqGzi35t+9OwzEPGIJWPbWVIpW5Wj4tt7XpEEbmtOsSvJfaLV4ktE9yHNqrA
	 /AZBBP37J0/7ePV5I+LEl4nXSp0rmtClIWxyhGpxEGJ6dHDTLm3ScghFnrWBn1db5/ymS
	 MPHIAUTqDPDhmxJiVAXjDaonU3LGl1aCX7t0Cy6HxJ+TAFWrRpotrRt8eo2mbLpCJ0Wqq
	 nBNvVRzyK6Cl0xlLaH7fhBgDNQs44P18EeRWxt0Zz760ateFU8kLQ1MMNKgOqX0uEhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFHqSOng;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F034606A32A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFHqSOng
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329C21F000D2;
	Mon, 23 Nov 2026 04:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795409970;
	bh=Z8cwSRx92FD7cY5sm9Q+TUdBS9Vf7k2N5TwccBvatyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IFHqSOngfeaeh3eP97XrMoajqiU1GURSmFjThY/Y9lyt8omslikzmQFesD09d4/A5
	 Po9+0cM2k7LItCdiUY/VTjT3BrheBA6jx4dwdrGtb29y/7pqjTEyZZX4WNDq1/ecM/
	 m0zsyXRVkx85TEWCHOJW5DfxgQ2ahbGcpUSv9s/0DEAZr7BNmkUW09nwrWZ4OcfRUs
	 L0O1GG4OOGDDktpuO4dDuiQOisV/vROYLA+StT7+fG26rQS7IvuT0n+RBh/tyYKJlY
	 NwN8IK9VviB0Qs0mZk6WbrVfG7jawSAj8DPTP/vWs/R0ROICgEUWk3PvI31+syHsr2
	 FkrP3fuWnGy0A==
Message-ID: <sashiko-outbox-228686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Enable callx related
 testcases for LoongArch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261123045008.23691-4-yangtiezhu@loongson.cn>
References: <20261123045008.23691-1-yangtiezhu@loongson.cn>
 <20261123045008.23691-4-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 04:59:29 +0000
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
- [Medium] selftests/bpf: callx tests fail on LoongArch due to missing
  JIT callx support
--

commit 89364474c6ac0435e5e06b0462fca0c350392e2f
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Enable callx related testcases for LoongArch

This commit enables the callx BPF selftests and defines CAN_USE_CALLX for
LoongArch.

> diff --git a/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c =
b/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
> index cc63b84e4d942..c052fa7624e8d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
> +++ b/tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
> @@ -9,7 +9,7 @@
>  #include <bpf/btf.h>
> =20
>  #if defined(__x86_64__) || defined(__aarch64__) || \
> -    (defined(__riscv) && __riscv_xlen =3D=3D 64)
> +    (defined(__riscv) && __riscv_xlen =3D=3D 64) || defined(__loongarch_=
_)
> =20
>  #define CALLEE_INSN	6
>  #define DATA		0x1234
> diff --git a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c =
b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
> index acd821fb568f5..f89bfe3e429d1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
> +++ b/tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
> @@ -4,7 +4,7 @@
>  #include "callx_rodata.lskel.h"
> =20
>  #if defined(__x86_64__) || defined(__aarch64__) || \
> -    (defined(__riscv) && __riscv_xlen =3D=3D 64)
> +    (defined(__riscv) && __riscv_xlen =3D=3D 64) || defined(__loongarch_=
_)
> =20
>  static void run(int prog_fd, int expected, const char *name)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index 6b930cb48f8d2..523e54383d7e2 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -306,7 +306,8 @@
> =20
>  /* clang always emits callx, gcc only when it defines __BPF_FEATURE_CALL=
X */
>  #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
> -     (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64)) &&		\
> +     (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) ||		\
> +     defined(__TARGET_ARCH_loongarch)) &&				\
>  	(defined(__clang__) || defined(__BPF_FEATURE_CALLX))
>  #define CAN_USE_CALLX
>  #endif

[Severity: Medium]
Will these callx selftests fail on LoongArch because the LoongArch BPF JIT
does not yet implement indirect subprog calls?

In this tree, arch/loongarch/net/bpf_jit.c does not override the default
weak bpf_jit_supports_callx() (which returns false) or handle
BPF_JMP | BPF_CALL | BPF_X in build_insn().  As a result,
require_callx_jit() rejects these programs with -EOPNOTSUPP instead of
letting the test suite skip them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123045008.2369=
1-1-yangtiezhu@loongson.cn?part=3D3
