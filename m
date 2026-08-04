Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98D469841
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851190; cv=none; b=TysSnubYBV8chx54BP/INKehOm+Woa4DicsqAEFYLrBgzvnfEMeYc6k0wR9OqtE28llIYJZaf61S8Ij4aWeq2Lo2fPDbW/bsR1JSjDF/KtEP2BmgufnOvc+xwFSlH1YckBC/CohICSgVMdRq3/TPvRAf1fZoMnMlbSra+g9XPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851190; c=relaxed/simple;
	bh=lugBDNE0XXppJPtOqHsLoMonT4l5I6NZ5dQ4qVYiEbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7uZbEO7OUNmJdTACKdPxtd/bQ/YUM6oP2Rfuk4vfRy3Iuy2FD4EVMPUzNAJapSpNmFniu8vNOBlMr6f2ZEIx1WnlWTglUpjpBDYzVJCItsM3crGGHwzjZdeXYRjar4mvNqMBuG8srfpL6d2VMO4QiA5O/frJBX9SaN2oGxYGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/ubS8OF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/ubS8OF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACA41F00A3A;
	Tue,  4 Aug 2026 13:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785851188;
	bh=6zEJQzOgD2qfQ+NXZsdeCZJt+wbhfCOL7o5nJMek3hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g/ubS8OFBoMzqG573ymGE/eh8vYlnllHGRPkyP3gZvPNU9y/PAWEqfkqKQCftrxAq
	 D6gD4jGNGCvJx6/Bmw3SYbkr8g/SfrLl39LXgXnhX+wW4ShUFQHNNECATrnPHwjh90
	 UWAhOLMfu7RGI+W3j5ot5fyI/VShdEdhyQtoXQk16KkVSoMCfKzzr3jWaPL9zHEc+/
	 gVEJdUK3MAPX3hPeOh1Q6z6NOerexghOJ2sOprCA6gTcnyXxoTNhWhwR4IQch/FyPx
	 gbc/tSfDzZ6JerDl+r6JP0GH3NoH0hA77TYEhjch61nklx/c4k7Twe+hcei45SooUP
	 ekO4S2akmhu0g==
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
Subject: [PATCH bpf-next v5 2/6] bpf: Inline bpf_iter_num_new() kfunc
Date: Tue,  4 Aug 2026 06:45:54 -0700
Message-ID: <20260804134601.2305303-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804134601.2305303-1-puranjay@kernel.org>
References: <20260804134601.2305303-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_for() expands to the bpf_iter_num_{new,next,destroy}() kfuncs, which
the verifier emits as regular calls. They are tiny and only touch the
8-byte on-stack iterator state, so open-code them in bpf_fixup_kfunc_call()
like the other special kfuncs there.

Start with bpf_iter_num_new(): R1 points to the iterator, R2/R3 hold
start/end. The inlined sequence mirrors the kfunc and returns the same
-EINVAL / -E2BIG / 0.

start > end is rejected first, so end - start fits in a u32; range-check
it as u32 on both sides ((u32)(end - start) in the kfunc). A movsx-based
check would emit a cpuv4 instruction that some JITs (x86-32, mips32,
sparc64) decode as a plain move and get wrong.

The emitted instructions are plain BPF, so the interpreter path stays
correct and no jit_required marking is needed.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/bpf_iter.c |  4 ++--
 kernel/bpf/verifier.c | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index b235e117e206a..d19f1b2861d22 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -782,8 +782,8 @@ __bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end)
 		return -EINVAL;
 	}
 
-	/* avoid overflows, e.g., if start == INT_MIN and end == INT_MAX */
-	if ((s64)end - (s64)start > BPF_MAX_LOOPS) {
+	/* start <= end here, so end - start fits in a u32 without overflow */
+	if ((u32)(end - start) > BPF_MAX_LOOPS) {
 		s->cur = s->end = 0;
 		return -E2BIG;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7439afdc851a7..e0c91f6412228 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20006,6 +20006,30 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
 		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
 		*cnt = 6;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_new]) {
+		/* inline bpf_iter_num_new(&it, start, end); R1=&it, R2=start, R3=end */
+		int i = 0;
+
+		/* if (start > end) goto einval; */
+		insn_buf[i++] = BPF_JMP32_REG(BPF_JSGT, BPF_REG_2, BPF_REG_3, 8);
+		/* r0 = (u32)end - (u32)start; if (r0 > BPF_MAX_LOOPS) goto e2big; */
+		insn_buf[i++] = BPF_MOV32_REG(BPF_REG_0, BPF_REG_3);
+		insn_buf[i++] = BPF_ALU32_REG(BPF_SUB, BPF_REG_0, BPF_REG_2);
+		insn_buf[i++] = BPF_JMP_IMM(BPF_JGT, BPF_REG_0, BPF_MAX_LOOPS, 8);
+		/* s->cur = start - 1; s->end = end; return 0; */
+		insn_buf[i++] = BPF_ALU32_IMM(BPF_ADD, BPF_REG_2, -1);
+		insn_buf[i++] = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_2, 0);
+		insn_buf[i++] = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3, 4);
+		insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+		insn_buf[i++] = BPF_JMP_A(5);
+		/* einval: s->cur = s->end = 0; return -EINVAL; */
+		insn_buf[i++] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+		insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
+		insn_buf[i++] = BPF_JMP_A(2);
+		/* e2big: s->cur = s->end = 0; return -E2BIG; */
+		insn_buf[i++] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+		insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, -E2BIG);
+		*cnt = i;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

