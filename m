Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD0E33B6C4
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289757; cv=none; b=GP0ULG0Z2Lxl7NOWJUhqMLe4mZBLMNn7OU86RiwT7reNrNQEw5B5UVQR1wmgSw1WDo9iwzgUHxPt9D7YmQMnHAa2zGm+Qo8ZFnt4xgg9pkFJ5+0PGiZ4qZtfB/l5qT0qmWFCxreDmXJYmbTtS1tiWku3KShjyulcSnQ/bpeW/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289757; c=relaxed/simple;
	bh=Ozi9IsrHJgPIXjGxCaeJ8R06lnMEwmR+htIV9n2sVXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjNmHTWpN6psmyjWb2qdTUecmjVITSSArs4rvhzoJQ4D43NfLyoiPyxkrRmuDHD8Bsz+SehKLwGK8+TO5IRocK/LrHKtRG35BzbXEmiLuVBleQaRu2wAf+SlhaQwnQCh3AqhbPxbrwl3FYavxgkP9Q2efreMT4Me+hNnGfU4n0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2IxgYYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2IxgYYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA111F000E9;
	Fri, 17 Jul 2026 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784289755;
	bh=8iRXkHNUEzwsTwCZOOY91Y8KleG4VNud4RBWa8mGJ9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H2IxgYYgCjBpouq+a+Kq1cq0mvR5uH1dc4rQfzHJpBg5Z65Sx16dpln/ODeLeLtBh
	 cLHERUSHpHI/GdUeTggjDFwlIddBP/oeUu4BtvaXSpZWvrZpZ0dzDmLzcmwbE8irzL
	 ZtqHfP5kQthWqvQUZfZlM4KY07AreF0WdmX2DnNO93X3ubZ8jMvJ12veiaGpfz+GIA
	 5iQnxjzmmHNKBi6xCL6Hcv3sWlDXZ2yqyDNED3s40vWQvB9Lxo/nqgEFH1RoFZO9di
	 Ej1W2xW92uINU6H0e6GnkmUDwYmdjROpp+kjWWMAoormk3UXalNIfCHsc36VD25Fhg
	 xKKv70e1UdFVg==
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
Subject: [PATCH bpf-next v2 1/4] bpf: Inline bpf_iter_num_new() kfunc
Date: Fri, 17 Jul 2026 05:02:09 -0700
Message-ID: <20260717120215.2171057-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717120215.2171057-1-puranjay@kernel.org>
References: <20260717120215.2171057-1-puranjay@kernel.org>
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
 kernel/bpf/verifier.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a78cdabf85607..9b9748b2a7cf5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19721,6 +19721,42 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 	*cnt = 4;
 }
 
+/*
+ * Inline bpf_iter_num_new(). R1 holds the pointer to the iterator, R2 and R3
+ * hold the (int) start and end arguments. Keep in sync with the kfunc in
+ * kernel/bpf/bpf_iter.c.
+ */
+static int inline_bpf_iter_num_new(struct bpf_insn *insn_buf)
+{
+	/* if (start > end) goto einval; */
+	insn_buf[0] = BPF_JMP32_REG(BPF_JSGT, BPF_REG_2, BPF_REG_3, 8);
+	/*
+	 * start <= end here, so the range end - start fits in a u32; compute it
+	 * as a 32-bit subtraction that zero-extends into r0.
+	 */
+	insn_buf[1] = BPF_MOV32_REG(BPF_REG_0, BPF_REG_3);
+	insn_buf[2] = BPF_ALU32_REG(BPF_SUB, BPF_REG_0, BPF_REG_2);
+	/* if (r0 > BPF_MAX_LOOPS) goto e2big; */
+	insn_buf[3] = BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, BPF_MAX_LOOPS, 8);
+	/* s->cur = start - 1; */
+	insn_buf[4] = BPF_ALU32_IMM(BPF_ADD, BPF_REG_2, -1);
+	insn_buf[5] = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_2, 0);
+	/* s->end = end; */
+	insn_buf[6] = BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3, 4);
+	/* return 0; */
+	insn_buf[7] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	insn_buf[8] = BPF_JMP_A(5);
+	/* einval: s->cur = s->end = 0; return -EINVAL; */
+	insn_buf[9] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+	insn_buf[10] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
+	insn_buf[11] = BPF_JMP_A(2);
+	/* e2big: s->cur = s->end = 0; return -E2BIG; */
+	insn_buf[12] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+	insn_buf[13] = BPF_MOV64_IMM(BPF_REG_0, -E2BIG);
+
+	return 14;
+}
+
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
@@ -19850,6 +19886,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
 		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
 		*cnt = 6;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_new]) {
+		*cnt = inline_bpf_iter_num_new(insn_buf);
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

