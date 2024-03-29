Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9361C0DC0
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738066; cv=none; b=PFyFEqyXqiwi0/FA+YCyeNPQGbIo6X+FGfTo6lchR3Dse4XTO7xg1Tn/99W8dtxlUSF6msRunFm9QMTHkhYE/rXdt14Ut7pgKp159Wb+o8seGCQdZV+8D+jppaOfb1zWnztHGN1YgWHwyqw6U7MEadNSSbHQHCWCmUVQkI5yBrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738066; c=relaxed/simple;
	bh=sqFVimtWpb/l/+AVDR8nH4xVlwtbkUFCwrJyPNbEutg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDeokqjl7asjyJ+1gPmVWTpEvyKK2EJPTqm03fESdIZyX2xhBMZGX0j0AKJ9VOssC0SKTWHr8WU4jfAyZKqTjX9Zty0hPtYunqKuAn30pcTYovJ98Z9k/FG+MywB/EiKmZw6RyLlXdqJXgH7gYWYz4qXVsyjpeB0r2tkCRhvWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJRBAH40; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJRBAH40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA389C433F1;
	Fri, 29 Mar 2024 18:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711738066;
	bh=sqFVimtWpb/l/+AVDR8nH4xVlwtbkUFCwrJyPNbEutg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJRBAH40xkFzicUmTZTdESCNOp6kQWKRe2HCUvaglY5ysujeECen8eV+UHUQetuhl
	 OL2HXzRU8jPohywG6x8ClOl4zd/CH4ui8Ts26FSUb+KXvLcmp6nrF2z+xJa1ZeQ8jl
	 aB8K9uzyNwyfFoCCHDDP1St6+8VsUlEVeN3ABMdH1Vvzw14XRnglZe5dZE0cKwWRxa
	 PVdULGcnfUF+kUmuu4Z9tlpfQi2pJ5L51Ivwrij7eLlzAY4KrUZ6/io1elC3eRkqxr
	 p/4Lt9GFHo4/3DOtxc7VNZLllUnCqRpQxNOZY/bfOWiF52dKad37+7HdSCmbhQg22Y
	 s9Nq4dfwLuBgw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/4] bpf: add internal-only per-CPU LDX instructions
Date: Fri, 29 Mar 2024 11:47:37 -0700
Message-ID: <20240329184740.4084786-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329184740.4084786-1-andrii@kernel.org>
References: <20240329184740.4084786-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF instructions for working with per-CPU data. These instructions
are internal-only and users are not allowed to use them directly. They
will only be used for internal inlining optimizations for now.

Two different instructions are added. One, with BPF_MEM_PERCPU opcode,
performs memory dereferencing of a per-CPU "address" (which is actually
an offset). This one is useful when inlined logic needs to load data
stored in per-CPU storage (bpf_get_smp_processor_id() is one such
example).

Another, with BPF_ADDR_PERCPU opcode, performs a resolution of a per-CPU
address (offset) stored in a register. This one is useful anywhere where
per-CPU data is not read, but rather is returned to user as just
absolute raw memory pointer (useful in bpf_map_lookup_elem() helper
inlinings, for example).

BPF disassembler is also taught to recognize them to support dumping
final BPF assembly code (non-JIT'ed version).

Add arch-specific way for BPF JITs to mark support for this instructions.

This patch also adds support for these instructions in x86-64 BPF JIT.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 29 +++++++++++++++++++++++++++++
 include/linux/filter.h      | 27 +++++++++++++++++++++++++++
 kernel/bpf/core.c           |  5 +++++
 kernel/bpf/disasm.c         | 33 ++++++++++++++++++++++++++-------
 4 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 3b639d6f2f54..610bbedaae70 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1910,6 +1910,30 @@ st:			if (is_imm8(insn->off))
 			}
 			break;
 
+		/* internal-only per-cpu zero-extending memory load */
+		case BPF_LDX | BPF_MEM_PERCPU | BPF_B:
+		case BPF_LDX | BPF_MEM_PERCPU | BPF_H:
+		case BPF_LDX | BPF_MEM_PERCPU | BPF_W:
+		case BPF_LDX | BPF_MEM_PERCPU | BPF_DW:
+			insn_off = insn->off;
+			EMIT1(0x65); /* gs segment modifier */
+			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
+			break;
+
+		/* internal-only load-effective-address-of per-cpu offset */
+		case BPF_LDX | BPF_ADDR_PERCPU | BPF_DW: {
+			u32 off = (u32)(void *)&this_cpu_off;
+
+			/* mov <dst>, <src> (if necessary) */
+			EMIT_mov(dst_reg, src_reg);
+
+			/* add <dst>, gs:[<off>] */
+			EMIT2(0x65, add_1mod(0x48, dst_reg));
+			EMIT3(0x03, add_1reg(0x04, dst_reg), 0x25);
+			EMIT(off, 4);
+
+			break;
+		}
 		case BPF_STX | BPF_ATOMIC | BPF_W:
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
 			if (insn->imm == (BPF_AND | BPF_FETCH) ||
@@ -3365,6 +3389,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+bool bpf_jit_supports_percpu_insns(void)
+{
+	return true;
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 44934b968b57..85ffaa238bc1 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -75,6 +75,14 @@ struct ctl_table_header;
 /* unused opcode to mark special load instruction. Same as BPF_MSH */
 #define BPF_PROBE_MEM32	0xa0
 
+/* unused opcode to mark special zero-extending per-cpu load instruction. */
+#define BPF_MEM_PERCPU	0xc0
+
+/* unused opcode to mark special load-effective-address-of instruction for
+ * a given per-CPU offset
+ */
+#define BPF_ADDR_PERCPU	0xe0
+
 /* unused opcode to mark call to interpreter with arguments */
 #define BPF_CALL_ARGS	0xe0
 
@@ -318,6 +326,24 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
 		.off   = OFF,					\
 		.imm   = 0 })
 
+/* Per-CPU zero-extending memory load (internal-only) */
+#define BPF_LDX_MEM_PERCPU(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_LDX | BPF_SIZE(SIZE) | BPF_MEM_PERCPU,\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = 0 })
+
+/* Load effective address of a given per-CPU offset */
+#define BPF_LDX_ADDR_PERCPU(DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_LDX | BPF_DW | BPF_ADDR_PERCPU,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = 0 })
+
 /* Memory store, *(uint *) (dst_reg + off16) = src_reg */
 
 #define BPF_STX_MEM(SIZE, DST, SRC, OFF)			\
@@ -970,6 +996,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_supports_subprog_tailcalls(void);
+bool bpf_jit_supports_percpu_insns(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ab400cdd7d7a..73f7183f3285 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2945,6 +2945,11 @@ bool __weak bpf_jit_supports_subprog_tailcalls(void)
 	return false;
 }
 
+bool __weak bpf_jit_supports_percpu_insns(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_kfunc_call(void)
 {
 	return false;
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index bd2e2dd04740..37732ed4be3f 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -13,6 +13,13 @@ static const char * const func_id_str[] = {
 };
 #undef __BPF_FUNC_STR_FN
 
+#ifndef BPF_MEM_PERCPU
+#define BPF_MEM_PERCPU		0xc0
+#endif
+#ifndef BPF_ADDR_PERCPU
+#define BPF_ADDR_PERCPU		0xe0
+#endif
+
 static const char *__func_get_name(const struct bpf_insn_cbs *cbs,
 				   const struct bpf_insn *insn,
 				   char *buff, size_t len)
@@ -178,6 +185,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 {
 	const bpf_insn_print_t verbose = cbs->cb_print;
 	u8 class = BPF_CLASS(insn->code);
+	u8 mode = BPF_MODE(insn->code);
 
 	if (class == BPF_ALU || class == BPF_ALU64) {
 		if (BPF_OP(insn->code) == BPF_END) {
@@ -269,16 +277,27 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			verbose(cbs->private_data, "BUG_st_%02x\n", insn->code);
 		}
 	} else if (class == BPF_LDX) {
-		if (BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) {
+		switch (BPF_MODE(insn->code)) {
+		case BPF_ADDR_PERCPU:
+			verbose(cbs->private_data, "(%02x) r%d = &(void __percpu *)(r%d %+d)\n",
+				insn->code, insn->dst_reg,
+				insn->src_reg, insn->off);
+			break;
+		case BPF_MEM:
+		case BPF_MEMSX:
+		case BPF_MEM_PERCPU:
+			verbose(cbs->private_data, "(%02x) r%d = *(%s%s *)(r%d %+d)\n",
+				insn->code, insn->dst_reg,
+				mode == BPF_MEM || mode == BPF_MEM_PERCPU ?
+					 bpf_ldst_string[BPF_SIZE(insn->code) >> 3] :
+					 bpf_ldsx_string[BPF_SIZE(insn->code) >> 3],
+				mode == BPF_MEM_PERCPU ? " __percpu" : "",
+				insn->src_reg, insn->off);
+			break;
+		default:
 			verbose(cbs->private_data, "BUG_ldx_%02x\n", insn->code);
 			return;
 		}
-		verbose(cbs->private_data, "(%02x) r%d = *(%s *)(r%d %+d)\n",
-			insn->code, insn->dst_reg,
-			BPF_MODE(insn->code) == BPF_MEM ?
-				 bpf_ldst_string[BPF_SIZE(insn->code) >> 3] :
-				 bpf_ldsx_string[BPF_SIZE(insn->code) >> 3],
-			insn->src_reg, insn->off);
 	} else if (class == BPF_LD) {
 		if (BPF_MODE(insn->code) == BPF_ABS) {
 			verbose(cbs->private_data, "(%02x) r0 = *(%s *)skb[%d]\n",
-- 
2.43.0

