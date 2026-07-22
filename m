Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6E2AD2C
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726677; cv=none; b=i1Lb5uTwwID0zCwFNiMc7u0pzIqG01UDLjOr9HUJn+oAVYuMZ4Ejm1i30NoM8unZTdv/pZGNIcAfsB9r5zM4QKs3zmBdrZZLZQoAno2+E/hZ0tZVM9LDjnYjsm9ftrytHkl/8hBT6B9i9CM868diR5NuPm/irZVhQ3E3FnJxPJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726677; c=relaxed/simple;
	bh=WO1fKJhUbRewhUqeH7dS4k5r268sjQJupV+aFBoplKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfSCBmaF5hdQLpgDOoYCIcr/vcskcrfUX7Y3xbXkiUeex2SgVGyFXSfPdOIFZrSMnwIAPHZpnneWXW8MGc5ucUHxNFCIH9ez15xDynoZqToTpAcv1XeIbgC9TDzou+nupw5dInN4E587kfQBdrAyFeUpxBwUHx4d0Gp2/gFgv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY2xkev6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY2xkev6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A7F1F000E9;
	Wed, 22 Jul 2026 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726676;
	bh=RPia87OnhW+vt9+0MBnBYuCz/KcNgoX+I2HstrmBDEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nY2xkev6GeGCICtmJxQgztUS1TH4Fvu/zxPsl0aZxfaVF4wu9Im6c4H/nnnCY5D4U
	 SDd0jbMS8DR1Db0TL5FWrkSRy0jdjnrfGtjsqgDuXpqx2SweVjdrGBqV6bw5LJhnPr
	 EH3Ki/87hE3nyqUkKYJrqldbxEMP7i1fkesq8rWXhSQ2Cyx/hQuo2ncTEcWiyNtO4t
	 AMq+Y1SAzUHkIv1kE0GdgnI5YwsoMxSKPOE08TIFHVbHlpg1OO3+e/TRqjz5OVFvLW
	 VstxwGU5ekkU1B+rhOb9ZrD92t3Wf7PWcoHg8Ikjjak4T+b0grVaICu2v8xVsF8rbi
	 kcAfmeipBkCIw==
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
Subject: [PATCH bpf-next v3 1/6] bpf: Inline bpf_iter_num_new() kfunc
Date: Wed, 22 Jul 2026 06:24:16 -0700
Message-ID: <20260722132424.450230-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722132424.450230-1-puranjay@kernel.org>
References: <20260722132424.450230-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The numeric iterator kfuncs bpf_iter_num_{new,next,destroy}() back the
open-coded iterator macro bpf_for() and are emitted as regular kfunc
calls by the verifier. bpf_iter_num_new() is small and only touches the
on-stack iterator state, so the verifier can open-code it and avoid the
call overhead of setting up an iterator.

Inline it in bpf_fixup_kfunc_call() by replacing the call with an
equivalent instruction sequence. R1 holds the pointer to the on-stack
bpf_iter_num, while R2 and R3 hold the start and end arguments. The
arithmetic and the error paths mirror the kfunc exactly, so a program
that inspects the return value keeps observing the same -EINVAL /
-E2BIG / 0 results.

The kfunc guards against overflow with a (s64)end - (s64)start range
check. The start > end case is rejected first, so start <= end at that
point and the range end - start fits in a u32. The inlined code computes
it with a 32-bit subtraction that zero-extends into a 64-bit register
and compares the result against BPF_MAX_LOOPS. Sign-extending the
operands with movsx instead would emit a cpuv4 instruction after
verification; JITs that do not implement movsx (e.g. x86-32, mips32,
sparc64) decode it as a plain move and would miscompile the check.

The emitted instructions are plain BPF and are handled by the
interpreter, so interpreter fallback stays correct and no jit_required
marking is needed.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52be0a118cce0..ff76a1ed04556 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19770,6 +19770,43 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 	*cnt = 4;
 }
 
+/*
+ * Inline bpf_iter_num_new(). R1 holds the pointer to the iterator, R2 and R3 hold the (int)
+ * start and end arguments. Keep in sync with the kfunc in kernel/bpf/bpf_iter.c.
+ */
+static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf)
+{
+	int i = 0;
+
+	/* if (start > end) goto einval; */
+	insn_buf[i++] = BPF_JMP32_REG(BPF_JSGT, BPF_REG_2, BPF_REG_3, 8);
+	/*
+	 * start <= end here, so the range end - start fits in a u32; compute it as a 32-bit
+	 * subtraction that zero-extends into r0.
+	 */
+	insn_buf[i++] = BPF_MOV32_REG(BPF_REG_0, BPF_REG_3);
+	insn_buf[i++] = BPF_ALU32_REG(BPF_SUB, BPF_REG_0, BPF_REG_2);
+	/* if (r0 > BPF_MAX_LOOPS) goto e2big; */
+	insn_buf[i++] = BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, BPF_MAX_LOOPS, 8);
+	/* s->cur = start - 1; */
+	insn_buf[i++] = BPF_ALU32_IMM(BPF_ADD, BPF_REG_2, -1);
+	insn_buf[i++] = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_2, 0);
+	/* s->end = end; */
+	insn_buf[i++] = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3, 4);
+	/* return 0; */
+	insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insn_buf[i++] = BPF_JMP_A(5);
+	/* einval: s->cur = s->end = 0; return -EINVAL; */
+	insn_buf[i++] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+	insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
+	insn_buf[i++] = BPF_JMP_A(2);
+	/* e2big: s->cur = s->end = 0; return -E2BIG; */
+	insn_buf[i++] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+	insn_buf[i++] = BPF_MOV64_IMM(BPF_REG_0, -E2BIG);
+
+	return i;
+}
+
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
@@ -19899,6 +19936,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
 		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
 		*cnt = 6;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_new]) {
+		*cnt = inline_bpf_iter_num_new(insn_buf);
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

