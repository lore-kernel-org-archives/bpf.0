Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11B64248A4
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297866; cv=none; b=mz2otw0UA+DLl0TyyGymHUU0AfQAtO3Yu5I5pz2m8KagxKakMU3INa9UaGOD6qko/jUWhFMzeY9je6IRasb8IfMwfVPTXw5kOkxKmoOUclAITQ7licfVMijhB40CKod3ZtV0zFLT9uXzwC4DGyTTbwkbtK6Y1C6OOcHg2+sGLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297866; c=relaxed/simple;
	bh=GdG7IXfURSquRh2M0XZAZkmYDf5keJTfObke2fzFljc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3a+hVgcHJIsQh0PKv0UJCWwfOHqiv9B0jJpX8VsUOBS/2hZgastSCSNW2rui/q3JRznvei6GNTG3CpyzFNSNTkI7opxMgtL9QKhkv3dZiZtYEpZrznxGTiXAZEMc+90z/NvDcFm4KIS8UCvu57hrYFHy4tqAC0In9QuDFX+AVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMpvwprT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMpvwprT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277561F00A3D;
	Fri, 17 Jul 2026 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784297863;
	bh=m2uf+ooE5qjDytlUPPM5V4KJT5avt6MXn9XLYowcOiM=;
	h=From:To:Cc:Subject:Date;
	b=XMpvwprTalHo7rLZL9UPA1FjWhPvbXyR85gsrObb5Rv0XhpqGSLOluSBX7ZXJ91Ls
	 tx0d14hh2qZaiNnqabDXWaVqVr5eBtSgCsJ1z5A5m//bKgGXrZw5ooMXLtfqv8LMx1
	 NCpnRf+mlFm1UH8V9MC5z7m81WxN2MBUTjXjj+OEiagexu0iubBSc/ux3Rw+SJV9lm
	 d41QWobol+4c/fmRnFLsORKOtRqpin13pdoiaBOrxc4vWSN5U/vrbsOytZd6KwF7Ee
	 nquyoQXnf0A4IQ2bcLCpm1A3/Zq79tQQDeRmUTmgQsbPRurjs5pdaJbkmZCVR8sfeA
	 t162uas4D2Ubg==
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
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next] bpf, arm64: Fix stack-passed arguments for indirect trampolines
Date: Fri, 17 Jul 2026 07:17:36 -0700
Message-ID: <20260717141737.4090962-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

save_args() reads stack-passed arguments relative to FP assuming the
trampoline is entered through the fentry call from a traced function, in
which case both the parent frame (FP/x9) and the traced function frame
(FP/LR) are saved before FP is set, so the arguments start at FP + 32.

An indirect trampoline for a struct_ops callback is entered through a
function pointer (blr), so only the FP/LR frame is pushed and the
arguments start at FP + 16, not FP + 32. Every stack-passed argument of
a struct_ops callback with more than eight argument slots is read two
slots off.

This has gone unnoticed because no in-tree struct_ops member passes
arguments on the stack. Pass is_struct_ops into save_args() and pick the
offset accordingly, mirroring the x86 fix.

Fixes: 9014cf56f13d ("bpf, arm64: Support up to 12 function arguments")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c6756b964c843..4fe235f7ce894 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2506,7 +2506,7 @@ static void clear_garbage(struct jit_ctx *ctx, int reg, int effective_bytes)
 static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
 		      const struct btf_func_model *m,
 		      const struct arg_aux *a,
-		      bool for_call_origin)
+		      bool for_call_origin, bool is_struct_ops)
 {
 	int i;
 	int reg;
@@ -2526,7 +2526,15 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
 		bargs_off += 8;
 	}
 
-	soff = 32; /* on stack arguments start from FP + 32 */
+	/*
+	 * On-stack arguments start above the frame(s) pushed by the
+	 * trampoline prologue. A traced function is entered through the
+	 * fentry call, so both the parent (FP/x9) and the traced function
+	 * (FP/LR) frames are saved and the arguments start at FP + 32. A
+	 * struct_ops callback is called indirectly, so only the FP/LR frame
+	 * is saved and the arguments start at FP + 16.
+	 */
+	soff = is_struct_ops ? 16 : 32;
 	doff = (for_call_origin ? oargs_off : bargs_off);
 
 	/* save on stack arguments */
@@ -2722,7 +2730,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	store_func_meta(ctx, func_meta, func_meta_off);
 
 	/* save args for bpf */
-	save_args(ctx, bargs_off, oargs_off, m, a, false);
+	save_args(ctx, bargs_off, oargs_off, m, a, false, is_struct_ops);
 
 	/* save callee saved registers */
 	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -2771,7 +2779,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* save args for original func */
-		save_args(ctx, bargs_off, oargs_off, m, a, true);
+		save_args(ctx, bargs_off, oargs_off, m, a, true, is_struct_ops);
 		/* call original func */
 		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
 		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);

base-commit: 1d91ea01185656ac3ee63c5f9f6f8bde3c746b3d
-- 
2.53.0-Meta

