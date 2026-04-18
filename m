Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D5223AB88
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776524925; cv=none; b=teXA77e831qEBYcaXeFgx5GmpPCMsFXP7ZdpD8TdK2R6jxcFbboIqDvIcyhrz2Q+bR3Fyj4GD1Zv7hdzU7KpkG5bSH5USn4INnXdW7rX8ZULXtrwiLwyXeTeGFo8iSPRr9Mk3qdqFJQSMG+1WiKEi6uOr+vF4DyD6JXYl2VsYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776524925; c=relaxed/simple;
	bh=sDkquOOW1TO3sNH3hKwvd9RYPiw3Rnt4xo5dUzNE1h8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hGqQ3MZHmD7T498uzs7bAtbRFvZKYaR7mBErZErK7UfexiBahnhd7cwX3GRLXmhNy82AJHveMnPQlgS4zFY8/gA8ViDTAHUb0ULm+4Znv4+jLrNf6ZmUDwBEHLjuX6BaNIs4tovy8ElUndARWjg7M6QIUmme3Jvq8ravOL6D2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz9korxX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz9korxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3780C19424;
	Sat, 18 Apr 2026 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776524924;
	bh=sDkquOOW1TO3sNH3hKwvd9RYPiw3Rnt4xo5dUzNE1h8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Fz9korxXBHYfV43gUFtY2Pckrp/i6wbmHqCFRa3GUVnGPhczdSrY4+DnDaX0hpW13
	 Mqaia0xT2GwHDG6s0B1AM3kG8tAbJwt1RNnc9JCcMjpS/tFHXrePkTtpzrqZFo7VrW
	 BD/SSuRM/l8Y7de7df9O1bnPtWnB3XBSE6jsAHSxpzwuLvgi+IRTW0Cm7oWXncIQIL
	 WjUW7bjeBDMxIgoYOj49KVsBu+iEiRIIoZ9UgTCKOmvKfSWmw9xBpviXtSPQZZOize
	 J6SbPwg6TvI5bESSAcqmQgu/bFA9ooNIU9yTuXOihRedAzFObBRmccEtZ+8pOTwYWP
	 u9IE5eKq4uV4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v13 4/6] selftests/bpf: add selftest to check
 bpf_get_cpu_time_counter jit
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260418131614.1501848-5-puranjay@kernel.org>
References: <20260418131614.1501848-5-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 15:08:44 +0000
Message-Id: <20260418150844.C3780C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The selftests rigidly enforce a broken x86-64 JIT implementation f=
or `bpf_cpu_time_counter_to_ns()`.
- [Medium] Fragile tests dependent on hardware features will cause CI flaki=
ness.
- [Low] Mismatched and inaccurate comments due to copy-pasting.
--

commit 01407c2c12560c811a29d35f221844615da2962d
Author: Vadim Fedorenko <vadim.fedorenko@linux.dev>

selftests/bpf: add selftest to check bpf_get_cpu_time_counter jit

This commit adds selftests for the JIT implementations of
bpf_get_cpu_time_counter() and bpf_cpu_time_counter_to_ns() on x86_64 and
arm64. It verifies the emitted assembly using __jited and __xlated macros.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c b/to=
ols/testing/selftests/bpf/progs/verifier_cpu_cycles.c
> new file mode 100644
> index 0000000000000..26c02010ccf1f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
[ ... ]
> +SEC("syscall")
> +__arch_x86_64
> +/* program entry for bpf_rdtsc_jit_x86_64(), regular function prologue */
> +__jited("	endbr64")
> +__jited("	nopl	(%rax,%rax)")
> +__jited("	nopl	(%rax)")
> +__jited("	pushq	%rbp")
> +__jited("	movq	%rsp, %rbp")
> +__jited("	endbr64")
> +/* save RDX in R11 as it will be overwritten */
> +__jited("	movq	%rdx, %r11")
> +/* lfence may not be executed depending on cpu features */
> +__jited("	{{(lfence|)}}")
> +__jited("	rdtsc")

Will this test deterministically fail in environments where
sched_clock_stable() is false or the CPU lacks the TSC feature?

The test strictly asserts that rdtsc is emitted. However, the underlying
JIT falls back to a standard function call if those hardware conditions are
not met, which might cause test failures in some CI and virtualization
environments.

[ ... ]
> +SEC("syscall")
> +__arch_x86_64
> +/* program entry for bpf_rdtsc_jit_x86_64(), regular function prologue */

This isn't a bug, but does this comment reference the wrong function name
due to a copy-paste error?

> +__jited("	endbr64")
> +__jited("	nopl	(%rax,%rax)")
> +__jited("	nopl	(%rax)")
> +__jited("	pushq	%rbp")
> +__jited("	movq	%rsp, %rbp")
> +__jited("	endbr64")
> +/* save RDX in R11 as it will be overwritten */
> +__jited("	movabsq	$0x2a2a2a2a2a, %rdi")

This isn't a bug, but the comment mentions saving RDX in R11, while the
following instruction does not touch either of those registers.

> +__jited("	imulq	${{.*}}, %rdi, %rax")
> +__jited("	shrq	${{.*}}, %rax")

Does enforcing this specific JIT sequence codify broken math for large cycle
counts?

The x86 imulq instruction computes a 64-bit product, truncating the upper
bits. Since cycle counts are 64-bit and multipliers can be large, their
product often requires 128 bits. The truncation would result in silent
wraparound.

Additionally, using a 32-bit immediate with imulq sign-extends the value to
64 bits. If the multiplier has its most significant bit set, it will be
treated as a large negative number, corrupting the result.

Finally, the emitted sequence does not add the offset. On arm64, the test
expects a no-op since the counter returns absolute nanoseconds, but on
x86-64 without the offset, absolute counter conversions will return
incorrect values. Does this test assert a cross-architecture inconsistency?

> +__jited("	leave")
> +__naked int bpf_cyc2ns_jit_x86(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418131614.1501=
848-1-puranjay@kernel.org?part=3D4
