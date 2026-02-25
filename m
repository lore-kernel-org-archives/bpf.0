Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E433B8D6A
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027026; cv=none; b=iciK9JGvn4TWMMKA5drDq+UUU+SFC0WOm8itYkR+bS+K3psL0QdJdeInou+NeAOJw7E82orLHRkT9JqmzIbz/ISZxuhv7j/HKYTjVA/Kq5NIs6NvZYueWAYxfs7TbSqvlxGmKK0NLBDXw5fLBzFNvLb5yTKYM+105gpDo1ftW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027026; c=relaxed/simple;
	bh=wBKev94WNU/mMgqABeTD68xaDxF4LQZShspMIUNbknw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eQC861mvnSVRRtuJ4VjRyq0HFvryTk7RoV8kMAAbvQQrEqrqXpIrvYU3e0Hjomzu3RonSOKxWCT0YA62f4gwMStEMrihqwWeBgqFWWxCmvqLEHI+ROo4r0bZ+thoVA64OZqZEbDhmRL91XoUz+Dx8Et0bftPWfyHrco+QqGLS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpYodwNH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpYodwNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CF7C116D0;
	Wed, 25 Feb 2026 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772027026;
	bh=wBKev94WNU/mMgqABeTD68xaDxF4LQZShspMIUNbknw=;
	h=From:To:Cc:Subject:Date:From;
	b=WpYodwNHAqM3agoLtd3Bd5HxFsLCuOe60IYzmZV5AcqI+f/PCjOnGKkcsbOOmJIk9
	 a6brE3QJPQvBWaU+sxvRx+r+lLRv5G6BPnogLypuQ2mDEIOWnWvEmokjZp2B2LgFba
	 SQ5jzJK/LfuwxNaMYvy9UZt42AuRNsfp/hinX2kBf4SKxfE5vv7w7UM2Jnqeq3zmD+
	 C98A+3Nv8Q11oYrqkg+75D0TfZTy3cn+BHaDeFy4j+PiQOwCIlXM3OgQWc4aWiyogt
	 4t2gae3V09zuCX2jn0yRi3q0QdS2dM5WwtgkpNgWlMQE5JKm75NO1EqfeUeDlL1grT
	 BM6v/L43FaJ6A==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf, arm64: Use ORR-based MOV for general-purpose registers
Date: Wed, 25 Feb 2026 05:43:38 -0800
Message-ID: <20260225134339.2723288-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The A64_MOV macro unconditionally uses ADD Rd, Rn, #0 to implement
register moves. While functionally correct, this is not the canonical
encoding when both operands are general-purpose registers.

On AArch64, MOV has two aliases depending on the operand registers:
  - MOV <Xd|SP>, <Xn|SP>  →  ADD <Xd|SP>, <Xn|SP>, #0
  - MOV <Xd>, <Xn>        →  ORR <Xd>, XZR, <Xn>

The ADD form is required when the stack pointer is involved (as ORR
does not accept SP), while the ORR form is the preferred encoding for
general-purpose registers.

The ORR encoding is also measurably faster on modern microarchitectures.
A microbenchmark [1] comparing dependent chains of MOV (ORR) vs ADD #0
on an ARM Neoverse-V2 (72-core, 3.4 GHz) shows:

  === mov (ORR Xd, XZR, Xn) ===
  run1 cycles/op=0.749859456
  run2 cycles/op=0.749991250
  run3 cycles/op=0.749601847
  avg cycles/op=0.749817518

  === add0 (ADD Xd, Xn, #0) ===
  run1 cycles/op=1.004777689
  run2 cycles/op=1.004558266
  run3 cycles/op=1.004806559
  avg cycles/op=1.004714171

The ORR form completes in ~0.75 cycles/op vs ~1.00 cycles/op for ADD #0,
a ~25% improvement. This is likely because the CPU's register renaming
hardware can eliminate ORR-based moves, while ADD #0 must go through the
ALU pipeline.

Update A64_MOV to select the appropriate encoding at JIT time:
use ADD when either register is A64_SP, and ORR (via
aarch64_insn_gen_move_reg()) otherwise.

Update verifier_private_stack selftests to expect "mov x7, x0" instead
of "add x7, x0, #0x0" in the JITed instruction checks, matching the
new ORR-based encoding.

[1] https://github.com/puranjaymohan/scripts/blob/main/arm64/bench/run_mov_vs_add0.sh

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit.h                                  | 4 +++-
 .../testing/selftests/bpf/progs/verifier_private_stack.c  | 8 ++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index bbea4f36f9f2..d13de4222cfb 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -187,7 +187,9 @@
 /* Rn - imm12; set condition flags */
 #define A64_CMP_I(sf, Rn, imm12) A64_SUBS_I(sf, A64_ZR, Rn, imm12)
 /* Rd = Rn */
-#define A64_MOV(sf, Rd, Rn) A64_ADD_I(sf, Rd, Rn, 0)
+#define A64_MOV(sf, Rd, Rn) \
+	(((Rd) == A64_SP || (Rn) == A64_SP) ? A64_ADD_I(sf, Rd, Rn, 0) : \
+	 aarch64_insn_gen_move_reg(Rd, Rn, A64_VARIANT(sf)))
 
 /* Bitfield move */
 #define A64_BITFIELD(sf, Rd, Rn, immr, imms, type) \
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 1ecd34ebde19..646e8ef82051 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -170,11 +170,11 @@ __jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
 __jited("	add	x27, x27, x10")
 __jited("	add	x25, x27, {{.*}}")
 __jited("	bl	0x{{.*}}")
-__jited("	add	x7, x0, #0x0")
+__jited("	mov	x7, x0")
 __jited("	mov	x0, #0x2a")
 __jited("	str	x0, [x27]")
 __jited("	bl	0x{{.*}}")
-__jited("	add	x7, x0, #0x0")
+__jited("	mov	x7, x0")
 __jited("	mov	x7, #0x0")
 __jited("	ldp	x25, x27, [sp], {{.*}}")
 __naked void private_stack_callback(void)
@@ -220,7 +220,7 @@ __jited("	mov	x0, #0x2a")
 __jited("	str	x0, [x27]")
 __jited("	mov	x0, #0x0")
 __jited("	bl	0x{{.*}}")
-__jited("	add	x7, x0, #0x0")
+__jited("	mov	x7, x0")
 __jited("	ldp	x27, x28, [sp], #0x10")
 int private_stack_exception_main_prog(void)
 {
@@ -258,7 +258,7 @@ __jited("	add	x25, x27, {{.*}}")
 __jited("	mov	x0, #0x2a")
 __jited("	str	x0, [x27]")
 __jited("	bl	0x{{.*}}")
-__jited("	add	x7, x0, #0x0")
+__jited("	mov	x7, x0")
 __jited("	ldp	x27, x28, [sp], #0x10")
 int private_stack_exception_sub_prog(void)
 {

base-commit: f620af11c27b8ec9994a39fe968aa778112d1566
-- 
2.47.3

