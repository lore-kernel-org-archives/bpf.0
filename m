Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E638886F
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647927; cv=none; b=P32yWM2Yc4ZZiuSu20k7XF1hjQOcEl6KVHXqtrx8YHvFSfT/cEHTWLtplKhSRwcxBYEypeurU94w4PQhndzYjOi/QXFFAhAsgLdWx+vIEt+3Ar1e1j0YylNNFTiaMJUpWfJwALPkqKVeQgC6n6y/oN2jdaR3QjWDJ74tzgSBLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647927; c=relaxed/simple;
	bh=Fg6mmuo4T9J4S+PH2mXsLSLjJo7zsj8wq52dlNLbRJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLhSfKLMlSz1zVxCiJcJYbAnXCE7GKRj4ggOYPD5o6cqvovUZF9RmWNXFkto51uJwP+Y4k1sK+/BvTnj48I+oltI6HfB06mZUp+HrX6b+io6wo+qJNEjgc2KS4HNjNusmh8YIcV+JABI4QLS+RrUs1eloGx0+nxZ+ULWX2NNoDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CBA3EB19824F7; Tue, 12 May 2026 21:51:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v4 23/25] bpf, arm64: Map BPF_REG_0 to x8 instead of x7
Date: Tue, 12 May 2026 21:51:53 -0700
Message-ID: <20260513045153.2402197-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513044949.2382019-1-yonghong.song@linux.dev>
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Puranjay Mohan <puranjay@kernel.org>

Move the BPF return value register from x7 to x8, freeing x7 for use
as an argument register. AAPCS64 designates x8 as the indirect result
location register; it is caller-saved and not used for argument
passing, making it a suitable home for BPF_REG_0.

This is a prerequisite for stack argument support, which needs x5-x7
to pass arguments 6-8 to native kfuncs following the AAPCS64 calling
convention.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c                          |  4 ++--
 arch/arm64/net/bpf_timed_may_goto.S                    |  8 ++++----
 .../testing/selftests/bpf/progs/verifier_jit_inline.c  |  2 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c      |  6 +++---
 .../selftests/bpf/progs/verifier_private_stack.c       | 10 +++++-----
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index 0816c40fc7af..085e650662e3 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -47,7 +47,7 @@
 /* Map BPF registers to A64 registers */
 static const int bpf2a64[] =3D {
 	/* return value from in-kernel function, and exit value from eBPF */
-	[BPF_REG_0] =3D A64_R(7),
+	[BPF_REG_0] =3D A64_R(8),
 	/* arguments from eBPF program to in-kernel function */
 	[BPF_REG_1] =3D A64_R(0),
 	[BPF_REG_2] =3D A64_R(1),
@@ -1048,7 +1048,7 @@ static void build_epilogue(struct jit_ctx *ctx, boo=
l was_classic)
 	/* Restore FP/LR registers */
 	emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
=20
-	/* Move the return value from bpf:r0 (aka x7) to x0 */
+	/* Move the return value from bpf:r0 (aka x8) to x0 */
 	emit(A64_MOV(1, A64_R(0), r0), ctx);
=20
 	/* Authenticate lr */
diff --git a/arch/arm64/net/bpf_timed_may_goto.S b/arch/arm64/net/bpf_tim=
ed_may_goto.S
index 894cfcd7b241..a9a802711a7f 100644
--- a/arch/arm64/net/bpf_timed_may_goto.S
+++ b/arch/arm64/net/bpf_timed_may_goto.S
@@ -8,8 +8,8 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	stp     x29, x30, [sp, #-64]!
 	mov     x29, sp
=20
-	/* Save BPF registers R0 - R5 (x7, x0-x4)*/
-	stp	x7, x0, [sp, #16]
+	/* Save BPF registers R0 - R5 (x8, x0-x4)*/
+	stp	x8, x0, [sp, #16]
 	stp	x1, x2, [sp, #32]
 	stp	x3, x4, [sp, #48]
=20
@@ -28,8 +28,8 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	/* BPF_REG_AX(x9) will be stored into count, so move return value to it=
. */
 	mov	x9, x0
=20
-	/* Restore BPF registers R0 - R5 (x7, x0-x4) */
-	ldp	x7, x0, [sp, #16]
+	/* Restore BPF registers R0 - R5 (x8, x0-x4) */
+	ldp	x8, x0, [sp, #16]
 	ldp	x1, x2, [sp, #32]
 	ldp	x3, x4, [sp, #48]
=20
diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/to=
ols/testing/selftests/bpf/progs/verifier_jit_inline.c
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
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/te=
sting/selftests/bpf/progs/verifier_ldsx.c
index 1026524a1983..41340877dc9d 100644
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
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b=
/tools/testing/selftests/bpf/progs/verifier_private_stack.c
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
--=20
2.53.0-Meta

