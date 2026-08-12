Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E133D6D6
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516082; cv=none; b=RUhHUwkL2Fz4osMzvZLmEGArsGLFZoV5t4uzi0WPaZJomJne7lOwTpkTtesjLiNjQbJkrqo2oBLX+rVbnMuVfhjMQfszrzGra+0Rbb1m4QFkgS6Q4z40ogKKIbRIQCGMHyLgvOSJlHD6sy6F+s6qaMQBtENm2XM5sWvbNkI46J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516082; c=relaxed/simple;
	bh=CSiJ22FjfNV8I4EJZpybH2+PkhANlpZOxGMNBrkTwdg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y9vQk2RwHFq+jBFIFwzIOOy3dWUOLNl9/IYT0b5UfA+WR6CGi2LisSsGYWF7cdEqr5zNxL2vkKwp22ikBMnMnA1u800J8DEUXyekFrBcwnMId/XNBLYwcB1codygxPv/Ns7uoNBx7PN8imDB+BjS3ONGzYonhoAae4S6Dtwi3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGqcBZ80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGqcBZ80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53ECC1F000E9;
	Wed, 12 Aug 2026 06:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786516081;
	bh=4koIQ5hcwnaye56zFCh8YAKg2XO9johBbPckMgXpkoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fGqcBZ80n/gWrRt5mkKxoJDN2PEBqJcxB1rkLjIWetCbD+RvzyqA2knhivJ3VsF8Y
	 I0ApRFPVvJZFgTjGEq1Q452Dr92r/2SDgKStmYUL1wRSTqkDVaxsRErAq/sfPT/+AK
	 pX4pLV5E+DK50stDFgrmcVzqsubgYZhIuFGvnFNlLxUtM3Kjz+MAf6HNPMhp2C0M95
	 41VVq2TWiAXuV8K1qpwE4RPTPj0rYlp8agK4SK+UIKK7R+Nz8FdwXif5M2ilq8s9Zu
	 GQpxgEUM0aB93wYkow1wSCIPwI3b7JWTIPjREwb96K7wxO5PjiRSBurVUwttNrQJK8
	 13XFDAJ24+DMQ==
From: sashiko-bot@kernel.org
Subject: Re: [bpf-next PATCH 2/2] selftests/bpf: Enable stack argument tests
 for riscv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Jiang" <jiangfeng@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812-bpf-riscv-stack-args-v1-2-67b246806e59@kylinos.cn>
References: <20260812-bpf-riscv-stack-args-v1-0-67b246806e59@kylinos.cn>
 <20260812-bpf-riscv-stack-args-v1-2-67b246806e59@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:28:00 +0000
Message-Id: <20260812062801.53ECC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Stack argument selftests are incorrectly enabled for 32-bit RISC=
-V (RV32) targets, leading to test regressions.
--

--- Patch [2]: [bpf-next PATCH 2/2] selftests/bpf: Enable stack argument te=
sts for riscv ---
commit 4c9f49e3a0c01bc5c673e83a3a3e5b7f61947d45
Author: Feng Jiang <jiangfeng@kylinos.cn>

selftests/bpf: Enable stack argument tests for riscv

This commit adds __TARGET_ARCH_riscv to the architecture guard in all stack
argument selftests so the real test cases are compiled for RISC-V. It keeps
the __BPF_FEATURE_STACK_ARGUMENT gate defined by clang.

Link: https://github.com/llvm/llvm-project/pull/189060

> diff --git a/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c=
 b/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
> index 8d38aafe66a28..c8540d30e293d 100644
> --- a/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
> +++ b/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
> @@ -4,7 +4,7 @@
>  #include <bpf/bpf_helpers.h>
>  #include "../test_kmods/bpf_testmod_kfunc.h"
> =20
> -#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
> +#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defin=
ed(__TARGET_ARCH_riscv)) && \
>  	defined(__BPF_FEATURE_STACK_ARGUMENT)

[Severity: Medium]
Does this incorrectly enable the tests for 32-bit RISC-V (RV32) as well?

The BPF selftests build system defines __TARGET_ARCH_riscv for both RV32
and RV64, but BPF stack arguments are only supported in the RV64 JIT.

If these tests are compiled and run on RV32, the verifier will likely reject
programs with more than 5 arguments (returning -ENOTSUPP or -EINVAL),
causing test regressions on that architecture.

Could this be restricted to RV64 by using
(defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64) across all of the
modified selftest files?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-bpf-riscv-=
stack-args-v1-0-67b246806e59@kylinos.cn?part=3D2
