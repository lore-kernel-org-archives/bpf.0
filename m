Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0AE330B2D
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699401; cv=none; b=fz3ZEqjJ0XNOE0/7g6T4uI/liOsWtczDBiREIz9b1BD/Dq2UIOb6FVPCYp/KdFLGNfaNON9JVtjrWEHeN+phOyMpb/V5MGLPnY72KgPERW8wC3+g/pcC5yeMngydF9Koq3eU3y7X+SOJcvdBU8zy6/ipdOd9pflR/KIhsLkWY+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699401; c=relaxed/simple;
	bh=cyXUIm1fscacF+r/3RwBlsGAeBy9drC6xZZK3OfXakg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+Nj9lnWHuLQIsvUmXihPEMD+z0JStDe8O/HHt0A36oZqeTVH+KCcQW07ta0P1BdN2r7NDrKsTKcRMnV6cMc9TBGs8unyl5Ij4dpInwWCTPLm5qMJttXD+KtUV5vt6O2Rv0ZCxdzShp9I0PsslGq+624iqHBb6vEwKnd5w3lqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvpA/W6V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvpA/W6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50381C19425;
	Mon, 20 Apr 2026 15:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776699401;
	bh=cyXUIm1fscacF+r/3RwBlsGAeBy9drC6xZZK3OfXakg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EvpA/W6VzFmOy+iJQyZuRB7parrYzJPATQpPEQTkBngeE+S8V4XLc3KYEW+VGtjEP
	 4PewB70fRglhhAyPMOcOfNiLSYNHbo5anyOy3sh88FaxlvV9B9HUFbMPGKbaJMNDNg
	 mNef1IHPIgiOcwqJiyP9Bsb8CP5mGdbqA8j373MhuMlaRLzOFpB/3a8XoMMFV7PaaL
	 rtM/tWnCBokqjpY0ev4QMJJWQdsqXtBy2nEB6XeCMbj8mpfRN6RrFpn2OcbFZzgvY5
	 FasaLW6PuJV2WtGzcpjHfUmqrl6Vwh05o7haD9qkb0wuRIrvSwh4pSgDyheBqZ7ZYZ
	 Y3ipL6dMZ8TTQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Xu Kuohai" <xukuohai@huaweicloud.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 1/3] bpf, arm64: Map BPF_REG_0 to x8 instead of x7
Date: Mon, 20 Apr 2026 08:35:59 -0700
Message-ID: <20260420153603.4097618-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420153603.4097618-1-puranjay@kernel.org>
References: <20260420153603.4097618-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the BPF return value register from x7 to x8, freeing x7 for use
as an argument register. AAPCS64 designates x8 as the indirect result
location register; it is caller-saved and not used for argument
passing, making it a suitable home for BPF_REG_0.

This is a prerequisite for stack argument support, which needs x5-x7
to pass arguments 6-8 to native kfuncs following the AAPCS64 calling
convention.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c                          |  4 ++--
 arch/arm64/net/bpf_timed_may_goto.S                    |  8 ++++----
 .../testing/selftests/bpf/progs/verifier_jit_inline.c  |  2 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c      |  6 +++---
 .../selftests/bpf/progs/verifier_private_stack.c       | 10 +++++-----
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0816c40fc7af..085e650662e3 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -47,7 +47,7 @@
 /* Map BPF registers to A64 registers */
 static const int bpf2a64[] = {
 	/* return value from in-kernel function, and exit value from eBPF */
-	[BPF_REG_0] = A64_R(7),
+	[BPF_REG_0] = A64_R(8),
 	/* arguments from eBPF program to in-kernel function */
 	[BPF_REG_1] = A64_R(0),
 	[BPF_REG_2] = A64_R(1),
@@ -1048,7 +1048,7 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
 	/* Restore FP/LR registers */
 	emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
 
-	/* Move the return value from bpf:r0 (aka x7) to x0 */
+	/* Move the return value from bpf:r0 (aka x8) to x0 */
 	emit(A64_MOV(1, A64_R(0), r0), ctx);
 
 	/* Authenticate lr */
diff --git a/arch/arm64/net/bpf_timed_may_goto.S b/arch/arm64/net/bpf_timed_may_goto.S
index 894cfcd7b241..a9a802711a7f 100644
--- a/arch/arm64/net/bpf_timed_may_goto.S
+++ b/arch/arm64/net/bpf_timed_may_goto.S
@@ -8,8 +8,8 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	stp     x29, x30, [sp, #-64]!
 	mov     x29, sp
 
-	/* Save BPF registers R0 - R5 (x7, x0-x4)*/
-	stp	x7, x0, [sp, #16]
+	/* Save BPF registers R0 - R5 (x8, x0-x4)*/
+	stp	x8, x0, [sp, #16]
 	stp	x1, x2, [sp, #32]
 	stp	x3, x4, [sp, #48]
 
@@ -28,8 +28,8 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	/* BPF_REG_AX(x9) will be stored into count, so move return value to it. */
 	mov	x9, x0
 
-	/* Restore BPF registers R0 - R5 (x7, x0-x4) */
-	ldp	x7, x0, [sp, #16]
+	/* Restore BPF registers R0 - R5 (x8, x0-x4) */
+	ldp	x8, x0, [sp, #16]
 	ldp	x1, x2, [sp, #32]
 	ldp	x3, x4, [sp, #48]
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
index 4ea254063646..885ff69a3a62 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -9,7 +9,7 @@ __success __retval(0)
 __arch_x86_64
 __jited("	addq	%gs:{{.*}}, %rax")
 __arch_arm64
-__jited("	mrs	x7, SP_EL0")
+__jited("	mrs	x8, SP_EL0")
 int inline_bpf_get_current_task(void)
 {
 	bpf_get_current_task();
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index c8494b682c31..c814e82a7242 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -274,11 +274,11 @@ __jited("movslq	0x10(%rdi,%r12), %r15")
 __jited("movswq	0x18(%rdi,%r12), %r15")
 __jited("movsbq	0x20(%rdi,%r12), %r15")
 __arch_arm64
-__jited("add	x11, x7, x28")
+__jited("add	x11, x8, x28")
 __jited("ldrsw	x21, [x11, #0x10]")
-__jited("add	x11, x7, x28")
+__jited("add	x11, x8, x28")
 __jited("ldrsh	x21, [x11, #0x18]")
-__jited("add	x11, x7, x28")
+__jited("add	x11, x8, x28")
 __jited("ldrsb	x21, [x11, #0x20]")
 __jited("add	x11, x0, x28")
 __jited("ldrsw	x22, [x11, #0x10]")
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 646e8ef82051..c5078face38d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -170,12 +170,12 @@ __jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
 __jited("	add	x27, x27, x10")
 __jited("	add	x25, x27, {{.*}}")
 __jited("	bl	0x{{.*}}")
-__jited("	mov	x7, x0")
+__jited("	mov	x8, x0")
 __jited("	mov	x0, #0x2a")
 __jited("	str	x0, [x27]")
 __jited("	bl	0x{{.*}}")
-__jited("	mov	x7, x0")
-__jited("	mov	x7, #0x0")
+__jited("	mov	x8, x0")
+__jited("	mov	x8, #0x0")
 __jited("	ldp	x25, x27, [sp], {{.*}}")
 __naked void private_stack_callback(void)
 {
@@ -220,7 +220,7 @@ __jited("	mov	x0, #0x2a")
 __jited("	str	x0, [x27]")
 __jited("	mov	x0, #0x0")
 __jited("	bl	0x{{.*}}")
-__jited("	mov	x7, x0")
+__jited("	mov	x8, x0")
 __jited("	ldp	x27, x28, [sp], #0x10")
 int private_stack_exception_main_prog(void)
 {
@@ -258,7 +258,7 @@ __jited("	add	x25, x27, {{.*}}")
 __jited("	mov	x0, #0x2a")
 __jited("	str	x0, [x27]")
 __jited("	bl	0x{{.*}}")
-__jited("	mov	x7, x0")
+__jited("	mov	x8, x0")
 __jited("	ldp	x27, x28, [sp], #0x10")
 int private_stack_exception_sub_prog(void)
 {
-- 
2.52.0

