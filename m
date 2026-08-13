Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F141D620
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647860; cv=none; b=svegNmSOjNHmz8b7crGgXwYfstFSEZt0LSYRDeyZbpFXAwydmtMCMzge2XQ/ZxMfVCvCSnXM0/DBdL97WCZz790RjLMLGSo3zrYn9cSj5BqOjc53otoSxlDGgQKdOvux/F4xfkmT4SNDLwC0yWXsbf0NBs+ZYPWLb6BmtncYoks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647860; c=relaxed/simple;
	bh=AtAnkMeP/BE8ETzUhY79pXFAWcDCrWo6Gb/DHKxkDRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhw4YiLyGK88S2jgmig9DnkvmOv72xApdPcfKM+jlxj/rqmPfgBEqp5tO7PxwPosdXIA06JudlW02T5n6xJx0YiVtVfxrTTL6plOfVL9NXdUZ8uecML/LesSAyutfljILZ/pwtkvFpFWi/56/YxsPMuEopjy4IasUTtDcD09Dy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYZIP33F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYZIP33F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787891F000E9;
	Thu, 13 Aug 2026 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647858;
	bh=yMrKWbxG5yt/pSNhn9VVkpvCaqalDtgiWVMC1+zI5hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VYZIP33F6kTiB+nKhO+WdRhHQhGxyZ8kK+Ig+CiB+GBU4cwA8A6P4k252TrjiYHSe
	 mPJkTR6K1p+MgrZTMrtxZTNgXIDEH/HPojy+Na4HOE4UkBqIzXGiLPMCYOFd8yKxd6
	 /NKx9pWAePoZ1pJrfbCcz/02Do8JLvrNiuXytNiLJm/34XJiKfHoE1cyU/p8K07JTS
	 tQqpNKk1Mo1md6ROUFEFbxyFPyarloORUVLolsOuWgC2Q7mK0pFcU75L7YLAAZTADp
	 i7xm82ptkQxFtirq5a/h/o4CyMyS3EIRREPTf74UxNZE0xQZdl9ZKCOzkj+EDEchtF
	 xeDMvfOBDRtoA==
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
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH bpf-next v2 1/7] bpf, arm64: Fix stack-passed arguments for indirect trampolines
Date: Thu, 13 Aug 2026 12:03:48 -0700
Message-ID: <20260813190356.335181-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813190356.335181-1-puranjay@kernel.org>
References: <20260813190356.335181-1-puranjay@kernel.org>
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

This went unnoticed because no struct_ops member passed arguments on the
stack until bpf_testmod_ops3::test_arena_stack, added by
commit 2d4de9a493a0 ("selftests/bpf: Test stack-passed struct_ops arena arguments").
That member covers this on arm64 once the JIT gains arena argument
support later in this series. Pass is_struct_ops into save_args() and
pick the offset accordingly, mirroring the x86 fix.

Fixes: 9014cf56f13d ("bpf, arm64: Support up to 12 function arguments")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 74b4083791da3..7938b3422d3c4 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2525,9 +2525,8 @@ static void clear_garbage(struct jit_ctx *ctx, int reg, int effective_bytes)
 }
 
 static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
-		      const struct btf_func_model *m,
-		      const struct arg_aux *a,
-		      bool for_call_origin)
+		      const struct btf_func_model *m, const struct arg_aux *a,
+		      bool for_call_origin, bool is_struct_ops)
 {
 	int i;
 	int reg;
@@ -2547,7 +2546,15 @@ static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
 		bargs_off += 8;
 	}
 
-	soff = 32; /* on stack arguments start from FP + 32 */
+	/*
+	 * On-stack arguments start above the frame(s) pushed by the trampoline
+	 * prologue. Entered through the fentry call from a traced function, the
+	 * prologue saves both the parent (FP/x9) and the traced function
+	 * (FP/LR) frames, so the arguments start at FP + 32. A struct_ops
+	 * callback is called indirectly and only the FP/LR frame is saved, so
+	 * they start at FP + 16.
+	 */
+	soff = is_struct_ops ? 16 : 32;
 	doff = (for_call_origin ? oargs_off : bargs_off);
 
 	/* save on stack arguments */
@@ -2737,7 +2744,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	store_func_meta(ctx, func_meta, func_meta_off);
 
 	/* save args for bpf */
-	save_args(ctx, bargs_off, oargs_off, m, a, false);
+	save_args(ctx, bargs_off, oargs_off, m, a, false, is_struct_ops);
 
 	/* save callee saved registers */
 	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -2786,7 +2793,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* save args for original func */
-		save_args(ctx, bargs_off, oargs_off, m, a, true);
+		save_args(ctx, bargs_off, oargs_off, m, a, true, is_struct_ops);
 		/* call original func */
 		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
 		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
-- 
2.53.0-Meta

