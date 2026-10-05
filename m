Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030714A3D2D
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210154; cv=none; b=QrnjgUO5tcX4Cry4M1pVwxaVPD5/z7vdWcmpaeY3bYM6keeaykLThdNbakmXQuhzWfrA36xZ+mh20fsCVJ8k4nJ/5EsUgMekexuUVCes4cazSAszL+p4SmtSFNed7fz2ycghk0NqV21QRSN15XAhOT90obj4fy//f4NMhcMKEiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210154; c=relaxed/simple;
	bh=qZS13CR+L1RvbKtViG3egj7ZBI6mDQm+zKiFck9xzY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTfIC6hXhOF1fLRS9rAHomrI8aqpNA/K73GXfCH9vD/idR4AA68HZVHxcabu8UaTTsdhJw8dq13zspiB8JK6kOH6u/8bDU4BOnkeZnIH3mO4S/JA+ft5W6XLbje3dohSGK95RntDzt9xeSE6i5I8N7u7c+i+8Shj7e614QCSH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbfgZc/W; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbfgZc/W"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f635552aso1361158f8f.2
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791210144; x=1791814944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c0A2P3uHeV0Wbx+Y2jeNEQ0NRpILN8oxk3ghUGfef5I=;
        b=mbfgZc/WrTgzsrLaRUOjAPnGttzqC0r95oTjAgnuWegGIYn5YWYGd0frkwekwU+Udo
         xGVIS/LEtWrwg7naIofpGAKrtAjMYlF9RAmYxKk6icby4/5RvJMll5jfNarw2RDz062v
         NvSVNpGi56MlEkQPiY9amZIFbE1M03kSABa7Tx50fY8X15Awd9jl2H5kq4dPsMjak5Cu
         OEEl2lMk7KADDJDmWApZaluDn4Yzs4BOZZzZvSlarjjFpnAQRSMryPlVBZHE1DgSywnQ
         +gyLFew1crc5KxfldRvESycOxy+mLlhFSfWJnawYAa7W35JAMyhG8gt5tDQhkyg2/NiG
         E8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791210144; x=1791814944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c0A2P3uHeV0Wbx+Y2jeNEQ0NRpILN8oxk3ghUGfef5I=;
        b=YqS3nruJIMkxyGm9Yho8tGJTtNnHjEF2Zw1kWUPcBxHB09Zujx5LfklisZ5pz01q++
         SIUqqZ7wEGinlHvDUtlZUySBBR8OmGEnWBL1d48kxv9WGF+WyYXmvFIvgS7mzvnw7VEr
         hXTABMfC5gPQsMNBd8F78AlBM8Tj+SjHpgqiopznPaJbxWnqtOaYZPC0FSGGeSih9REE
         lkUaF3wcy3qv1WdAuTmakHR3rSX1y/Uw2xU3iaD9BSdik5i4oDBZ/MNyjlHMelMo+Kr4
         prN0Qi27W8nQjCUzvZ5SMwttkZZ2EIm4NaPlLT5R3HIr55j7CjiSlI0SbNB8/A17ORMW
         rYTw==
X-Gm-Message-State: AFq9FYIFT1wmbcIpLjAASBtowsG8t/nF/lGagStwcQZRSrw9aqcVyxrG
	rDxqIur5DNpZtxgZ1boemQAKIu3EZEBIDTGy/fYnVOfrxm/25FDv5g3iT+0bFfBIokGn3mtG
X-Gm-Gg: AYBFou2XDBbRKAFD6OFRhoP9vCASePzPrDjcrCY+f64YNnGS9cpeZcq1yw2zbMX9fy/
	erD001RuWWMJpfXOae9tim84MR2soQfFct9gLwWDKPyfnIYyyORr4wzZSKMGBNjp6hTEExEVlvn
	EjKvT76UrBEbWdOACXzMvpN1iP/fb8pE0m1KJaU2+qf6vdQm0RfrDaNqvBSpQB6tRekFoVe4Bez
	ZW+2pCDOWj7fxJyPSwsWYzeOUoPSRcFnLBOsPsIqPWHaCA4YHlauQUlnF6GWnVdu3x0X8p14j1g
	38u11N3AFC2BPhudOQ6jtgjIu44g/Jpti20+IxRBRpZfhyxzkSwmOxrMo8o8N+ssOqWQLX/WaPJ
	E92N6LAV3Cmsu+vJ5mEDML2h6+cHqUHakbo4zJrmRZ+MAyv492vg+GFNDiyfmgzjWB0a2vj0DIO
	IibKH0psLQ9gbdBpPL9HOSldmA4a8nvAyjxPE+9/W5jKnYzT8JCoddXFMa3KeJEsLpHP3QxGCfJ
	tUB3zp+XvgcW+yiy/62E492DfXqrzSVlG1PfjpQ9HMnkphNfMshgE4QDOWLQJKiR+qkVsXCPqov
	Lb7YoCSu6HgtieYvQjCC9VO6jup3OG5o+U9r2g==
X-Received: by 2002:a05:6000:38d:b0:486:f856:1975 with SMTP id ffacd0b85a97d-48b12729cc2mr19784943f8f.22.1791210143797;
        Mon, 05 Oct 2026 07:22:23 -0700 (PDT)
Received: from macbook (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622ab5a1sm3881623f8f.36.2026.10.05.07.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:22:23 -0700 (PDT)
From: Yusheng Zheng <yunwei356@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Hao Sun <sunhao.th@gmail.com>,
	Yusheng Zheng <yunwei356@gmail.com>
Subject: [RFC PATCH bpf-next 2/7] bpf: Verify calls of kfuncs with a body through the body
Date: Mon,  5 Oct 2026 07:22:14 -0700
Message-ID: <20261005142219.33451-3-yunwei356@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20261005142219.33451-1-yunwei356@gmail.com>
References: <20261005142219.33451-1-yunwei356@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before the CFG check, replace each call of a kfunc that has a body with
the body, using bpf_patch_insn_data() like the other inlining in the
verifier, so that the verifier analyzes the result in the caller's
context. The entry and exit of the body have the register effects of
the call: only the arguments are readable at the entry, and R1-R5 are
not readable after the exit. Constant folding takes R0-R5 as unknown
after each instruction of the body. Constant (__k) arguments must be
known at the entry; they are marked precise, and their values are kept
for native code. A kfunc that the program may not call keeps its call,
which check_kfunc_call() then rejects as before.

After verification, restore a call if the JIT has native code for it,
from bpf_jit_inline_kfunc(), and the verifier did not rewrite the body
later: no constant blinding, speculation barriers, sanitation or arena
conversion, and memory accesses only to the stack, map values, memory
and packets, and only to the stack when the JIT adds KASAN checks.
When liveness allows, the moves of arguments from R6-R9 right before
the call and the move of the result to R6-R9 right after it are
removed, and the native code uses those registers directly. The removed
instructions become nops for bpf_opt_remove_nops(). Otherwise the body
stays, so the program runs on every JIT.

The new code is in kernel/bpf/kfunc_inline.c; verifier.c only calls it.

Assisted-by: LLM
Signed-off-by: Yusheng Zheng <yunwei356@gmail.com>
---
 include/linux/bpf_verifier.h |  34 +++++
 include/linux/filter.h       |   2 +
 kernel/bpf/Makefile          |   2 +-
 kernel/bpf/const_fold.c      |   4 +
 kernel/bpf/core.c            |   9 ++
 kernel/bpf/kfunc_inline.c    | 273 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  53 +++++--
 7 files changed, 360 insertions(+), 17 deletions(-)
 create mode 100644 kernel/bpf/kfunc_inline.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c51083c761cf2..571c8d4da3271 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -634,6 +634,7 @@ struct bpf_insn_aux_data {
 		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
 		struct bpf_map_ptr_state map_ptr_state;
 		s32 call_imm;			/* saved imm field of call insn */
+		u32 kfunc_inline;		/* 1 + index into env->kfunc_inlines, at a call */
 		u32 alu_limit;			/* limit for add/sub register with pointer */
 		struct {
 			u32 map_index;		/* index into used_maps[] */
@@ -683,6 +684,9 @@ struct bpf_insn_aux_data {
 	 */
 	u8 fastcall_spills_num:3;
 	u8 arg_prog:4;
+	/* insn belongs to the body of a kfunc call, see bpf_inline_kfunc_bodies() */
+	u8 kfunc_body:1;
+	u8 kfunc_body_entry:1;
 
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
@@ -1083,6 +1087,8 @@ struct bpf_verifier_env {
 	u32 scc_cnt;
 	struct bpf_iarray *succ;
 	struct bpf_iarray *gotox_tmp_buf;
+	struct bpf_kfunc_inline *kfunc_inlines;
+	u32 kfunc_inline_cnt;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
@@ -1794,14 +1800,42 @@ enum bpf_reg_arg_type {
 #define MAX_KFUNC_CALL_DESCS (MAX_KFUNC_DESCS * 2)
 static_assert(MAX_KFUNC_CALL_DESCS <= S16_MAX + 1);
 
+/* A call of a kfunc with a body, which the verifier replaced by the body */
+struct bpf_kfunc_inline {
+	struct bpf_insn call;
+	const struct bpf_kfunc_body *body;
+	unsigned long addr;		/* of the compiled kfunc */
+	u8 *image;			/* native code for the JIT */
+	u32 start;
+	/* the BPF registers that R0-R5 are bound to, and the constant arguments */
+	u8 reg[MAX_BPF_FUNC_REG_ARGS + 1];
+	s32 imm[MAX_BPF_FUNC_REG_ARGS + 1];
+	u8 image_len;
+	u8 nargs;
+	u8 imm_mask;	/* R1-R5 that hold constant (__k) arguments */
+	bool entered;	/* the verifier reached the body */
+	bool ret;	/* the kfunc returns a value */
+	bool copy;	/* the native code is a copy of the compiled kfunc */
+};
+
 struct bpf_kfunc_desc {
 	struct btf_func_model func_model;
 	struct bpf_func_proto proto;
+	const struct bpf_kfunc_body *body;
 	u32 func_id;
 	u16 offset;
+	u8 body_imm;	/* R1-R5 that are constant (__k) arguments of the body */
 	unsigned long addr;
 };
 
+struct bpf_kfunc_desc *bpf_find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset);
+int bpf_inline_kfunc_bodies(struct bpf_verifier_env *env);
+int bpf_mark_kfunc_body_regs(struct bpf_verifier_env *env, int prev_insn_idx,
+			     const struct bpf_insn_aux_data *aux);
+void bpf_restore_kfunc_calls(struct bpf_verifier_env *env);
+void bpf_free_kfunc_inlines(struct bpf_verifier_env *env);
+const struct bpf_kfunc_inline *bpf_kfunc_native(const struct bpf_verifier_env *env, int idx);
+
 struct bpf_kfunc_desc_tab {
 	u32 nr_descs;
 	u32 nr_base_descs;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9339c6131f8ff..d93629eb40cd3 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1239,6 +1239,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
+struct bpf_kfunc_inline;
+int bpf_jit_inline_kfunc(const struct bpf_kfunc_inline *in, u8 *buf);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index c1f9b0d3468d3..ae3d04dae2d33 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
-obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o backtrack.o check_btf.o
+obj-$(CONFIG_BPF_SYSCALL) += fixups.o cfg.o states.o backtrack.o check_btf.o kfunc_inline.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index b1528adbeb79d..8fa745e62e7ee 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -268,6 +268,10 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 		memcpy(ci_out, ci, sizeof(ci_out));
 
 		const_reg_xfer(env, ci_out, insn, insns, idx);
+		/* the body of a kfunc call leaves R0-R5 unknown, like the call */
+		if (insn_aux[idx].kfunc_body)
+			for (r = BPF_REG_0; r <= BPF_REG_5; r++)
+				ci_out[r] = unknown;
 
 		succ = bpf_insn_successors(env, idx);
 		for (int s = 0; s < succ->cnt; s++)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 05c89396119ad..68665ea2499e9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3299,6 +3299,15 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
 	return false;
 }
 
+/* Write native code for an inlined kfunc call, see struct bpf_kfunc_inline,
+ * to @buf for the JIT to copy. Return its length, or an error to keep the
+ * body of the kfunc.
+ */
+int __weak bpf_jit_inline_kfunc(const struct bpf_kfunc_inline *in, u8 *buf)
+{
+	return -EOPNOTSUPP;
+}
+
 /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool __weak bpf_jit_supports_subprog_tailcalls(void)
 {
diff --git a/kernel/bpf/kfunc_inline.c b/kernel/bpf/kfunc_inline.c
new file mode 100644
index 0000000000000..daf92c3ad512c
--- /dev/null
+++ b/kernel/bpf/kfunc_inline.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Calls of kfuncs that have a BPF body, see struct bpf_kfunc_body */
+#include <linux/bpf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/filter.h>
+#include <linux/slab.h>
+
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
+
+static struct bpf_kfunc_desc *body_desc(struct bpf_verifier_env *env,
+					const struct bpf_insn *insn)
+{
+	struct bpf_kfunc_desc *desc;
+
+	if (!bpf_pseudo_kfunc_call(insn))
+		return NULL;
+	desc = bpf_find_kfunc_desc(env->prog, insn->imm, insn->off);
+	return desc && desc->body ? desc : NULL;
+}
+
+/*
+ * Replace each call of a kfunc with a body by the body, so that the verifier
+ * analyzes the operation in the caller's context. The entry and exit of the
+ * body get the register effects of the call, see bpf_mark_kfunc_body_regs().
+ * After verification bpf_restore_kfunc_calls() puts the call back if the JIT
+ * has native code for it, and keeps the body otherwise.
+ */
+int bpf_inline_kfunc_bodies(struct bpf_verifier_env *env)
+{
+	struct bpf_kfunc_desc *desc;
+	struct bpf_kfunc_inline *r;
+	struct bpf_prog *prog;
+	u32 i, j, cnt = 0;
+
+	for (i = 0; i < env->prog->len; i++)
+		cnt += !!body_desc(env, &env->prog->insnsi[i]);
+	if (!cnt)
+		return 0;
+	env->kfunc_inlines = kvzalloc_objs(*env->kfunc_inlines, cnt, GFP_KERNEL_ACCOUNT);
+	if (!env->kfunc_inlines)
+		return -ENOMEM;
+
+	for (i = 0; i < env->prog->len; i++) {
+		desc = body_desc(env, &env->prog->insnsi[i]);
+		if (!desc)
+			continue;
+		r = &env->kfunc_inlines[env->kfunc_inline_cnt++];
+		r->call = env->prog->insnsi[i];
+		r->body = desc->body;
+		r->addr = desc->addr;
+		r->start = i;
+		r->nargs = desc->func_model.nr_args;
+		r->imm_mask = desc->body_imm;
+		r->ret = desc->func_model.ret_size;
+		prog = bpf_patch_insn_data(env, i, r->body->insns, r->body->len);
+		if (!prog)
+			return -ENOMEM;
+		env->prog = prog;
+		for (j = i; j < i + r->body->len; j++)
+			env->insn_aux_data[j].kfunc_body = 1;
+		env->insn_aux_data[i].kfunc_body_entry = 1;
+		i += r->body->len - 1;
+	}
+	return 0;
+}
+
+/*
+ * The body of a kfunc gets only the arguments of the call and leaves R1-R5
+ * like it. The constant (__k) arguments must be known, and native code may
+ * use their values.
+ */
+int bpf_mark_kfunc_body_regs(struct bpf_verifier_env *env, int prev_insn_idx,
+			     const struct bpf_insn_aux_data *aux)
+{
+	struct bpf_kfunc_inline *r = env->kfunc_inlines;
+	struct bpf_reg_state *regs = cur_regs(env);
+	u32 clobber = 0;
+	int i, err;
+
+	/* leaving the body */
+	if (prev_insn_idx >= 0 && env->insn_aux_data[prev_insn_idx].kfunc_body &&
+	    (!aux->kfunc_body || aux->kfunc_body_entry))
+		clobber |= GENMASK(BPF_REG_5, BPF_REG_1);
+	if (aux->kfunc_body_entry) {
+		while (r->start != env->insn_idx)
+			r++;
+		for (i = BPF_REG_1; i <= BPF_REG_5 && !env->cur_state->speculative; i++) {
+			if (!(r->imm_mask & BIT(i)))
+				continue;
+			if (regs[i].type != SCALAR_VALUE || !tnum_is_const(regs[i].var_off)) {
+				verbose(env, "R%d must be a known constant\n", i);
+				return -EINVAL;
+			}
+			err = mark_chain_precision(env, i);
+			if (err)
+				return err;
+			/* emitted code needs the same constants on every path */
+			if (r->entered && r->imm[i] != (s32)regs[i].var_off.value)
+				r->copy = true;
+			r->imm[i] = regs[i].var_off.value;
+		}
+		r->entered = true;
+		clobber |= BIT(BPF_REG_0) | (GENMASK(BPF_REG_5, BPF_REG_0) &
+					     ~GENMASK(r->nargs, BPF_REG_0));
+	}
+	for (i = BPF_REG_0; i <= BPF_REG_5; i++) {
+		if (!(clobber & BIT(i)))
+			continue;
+		bpf_mark_reg_not_init(env, &regs[i]);
+		mark_reg_scratched(env, i);
+	}
+	return 0;
+}
+
+/*
+ * Native code can replace the body of a kfunc call that the verifier reached
+ * and does not rewrite later: no speculation barriers, sanitation or arena
+ * conversion, and memory accesses only to memory that the JIT accesses as is.
+ */
+static bool kfunc_native_ok(struct bpf_verifier_env *env, const struct bpf_kfunc_inline *r)
+{
+	u32 i;
+
+	if (env->prog->blinding_requested || (r->imm_mask && !r->entered))
+		return false;
+	for (i = 0; i < r->body->len; i++) {
+		const struct bpf_insn_aux_data *aux = &env->insn_aux_data[r->start + i];
+		u8 class = BPF_CLASS(r->body->insns[i].code);
+
+		if (aux->nospec || aux->nospec_result || aux->alu_state || aux->needs_zext ||
+		    aux->arena_scalar)
+			return false;
+		if (class != BPF_LDX && class != BPF_STX && class != BPF_ST)
+			continue;
+		if (type_flag(aux->ptr_type) & ~MEM_RDONLY)
+			return false;
+		switch (base_type(aux->ptr_type)) {
+		case PTR_TO_STACK:
+			break;
+		case PTR_TO_MAP_VALUE:
+		case PTR_TO_MEM:
+		case PTR_TO_PACKET:
+		case PTR_TO_PACKET_META:
+			/* the JIT checks these accesses with KASAN, native code does not */
+			if (IS_ENABLED(CONFIG_BPF_JIT_KASAN))
+				return false;
+			break;
+		default:
+			return false;
+		}
+	}
+	return true;
+}
+
+/*
+ * Bind the operands of a kfunc call in r->reg and return the moves that this
+ * makes unnecessary in @drop:
+ * - an argument copied from R6-R9 by a 64-bit move right before the call is
+ *   used in place if that register is dead after the call;
+ * - emitted native code has the constant arguments as immediates;
+ * - the result goes straight to its R6-R9 destination.
+ * No jump may land between such a move and the call. Only emitted code may
+ * share the result register with an argument.
+ */
+static int kfunc_bind(struct bpf_verifier_env *env, struct bpf_kfunc_inline *r, u32 *drop)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi, *mov;
+	u32 end = r->start + r->body->len, i;
+	bool emit = !r->copy;
+	u16 used = 0, written = 0;
+	u8 dst, src;
+	int n = 0;
+
+	for (i = 0; i <= MAX_BPF_FUNC_REG_ARGS; i++)
+		r->reg[i] = i;
+
+	/* walk back over moves into R1-R5 that do not read R0-R5 */
+	for (i = r->start; i-- > 0 && !bpf_is_jump_target(env, i + 1);) {
+		mov = &insns[i];
+		dst = mov->dst_reg;
+		src = mov->src_reg;
+		if ((BPF_CLASS(mov->code) != BPF_ALU64 && BPF_CLASS(mov->code) != BPF_ALU) ||
+		    BPF_OP(mov->code) != BPF_MOV || dst < BPF_REG_1 || dst > BPF_REG_5 ||
+		    aux[i].kfunc_body ||
+		    (BPF_SRC(mov->code) == BPF_X && (src < BPF_REG_6 || src > BPF_REG_9)))
+			break;
+		if (dst <= r->nargs && !(written & BIT(dst)) && !mov->off) {
+			if (BPF_SRC(mov->code) == BPF_K && (r->imm_mask & BIT(dst)) && emit) {
+				drop[n++] = i;
+			} else if (mov->code == (BPF_ALU64 | BPF_MOV | BPF_X) &&
+				   !(used & BIT(src)) &&
+				   !(aux[end].live_regs_before & BIT(src))) {
+				r->reg[dst] = src;
+				used |= BIT(src);
+				drop[n++] = i;
+			}
+		}
+		written |= BIT(dst);
+	}
+
+	mov = &insns[end];
+	dst = mov->dst_reg;
+	/* the result register must be live so that the JIT saves it */
+	if (r->ret && !bpf_is_jump_target(env, end) && end + 1 < env->prog->len &&
+	    mov->code == (BPF_ALU64 | BPF_MOV | BPF_X) && !mov->off &&
+	    mov->src_reg == BPF_REG_0 && dst >= BPF_REG_6 && dst <= BPF_REG_9 &&
+	    (emit || !(used & BIT(dst))) &&
+	    (aux[end + 1].live_regs_before & BIT(dst)) &&
+	    !(aux[end + 1].live_regs_before & BIT(BPF_REG_0))) {
+		r->reg[BPF_REG_0] = dst;
+		drop[n++] = end;
+	}
+	return n;
+}
+
+/*
+ * Put back the calls that the JIT has native code for: the code from the
+ * kfunc's emit callback, or else a copy of the compiled kfunc. The rest of
+ * the body and the moves that binding makes unnecessary become nops, which
+ * bpf_opt_remove_nops() removes. Other calls keep their body.
+ */
+void bpf_restore_kfunc_calls(struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insns = env->prog->insnsi;
+	u32 drop[MAX_BPF_FUNC_REG_ARGS + 1];
+	u8 code[BPF_KFUNC_INLINE_MAX];
+	int i, j, n, len;
+
+	for (i = 0; i < env->kfunc_inline_cnt; i++) {
+		struct bpf_kfunc_inline *r = &env->kfunc_inlines[i];
+
+		if (!kfunc_native_ok(env, r))
+			continue;
+		n = kfunc_bind(env, r, drop);
+		len = bpf_jit_inline_kfunc(r, code);
+		if (len <= 0 && !r->copy) {
+			r->copy = true;
+			n = kfunc_bind(env, r, drop);
+			len = bpf_jit_inline_kfunc(r, code);
+		}
+		r->image = len > 0 ? kmemdup(code, len, GFP_KERNEL_ACCOUNT) : NULL;
+		if (!r->image)
+			continue;
+		r->image_len = len;
+		for (j = 0; j < n; j++)
+			insns[drop[j]] = BPF_JMP_A(0);
+		insns[r->start] = r->call;
+		for (j = r->start + 1; j < r->start + r->body->len; j++)
+			insns[j] = BPF_JMP_A(0);
+		env->insn_aux_data[r->start].kfunc_inline = i + 1;
+	}
+}
+
+/* The inlined kfunc call at @idx, if the JIT puts native code there */
+const struct bpf_kfunc_inline *bpf_kfunc_native(const struct bpf_verifier_env *env, int idx)
+{
+	u32 i = env && env->insn_aux_data[idx].kfunc_body_entry ?
+		env->insn_aux_data[idx].kfunc_inline : 0;
+
+	if (!i || i > env->kfunc_inline_cnt || !env->kfunc_inlines[i - 1].image)
+		return NULL;
+	return &env->kfunc_inlines[i - 1];
+}
+
+void bpf_free_kfunc_inlines(struct bpf_verifier_env *env)
+{
+	u32 i;
+
+	for (i = 0; i < env->kfunc_inline_cnt; i++)
+		kfree(env->kfunc_inlines[i].image);
+	kvfree(env->kfunc_inlines);
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fd3c0206bd67d..2f58794784100 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2569,8 +2569,8 @@ static int kfunc_btf_cmp_by_off(const void *a, const void *b)
 	return d0->offset - d1->offset;
 }
 
-static struct bpf_kfunc_desc *
-find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
+struct bpf_kfunc_desc *
+bpf_find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 {
 	struct bpf_kfunc_desc desc = {
 		.func_id = func_id,
@@ -2877,10 +2877,11 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	struct btf_func_model func_model;
 	struct bpf_kfunc_desc_tab *tab;
 	struct bpf_prog_aux *prog_aux;
+	const struct bpf_kfunc_body *body;
 	struct bpf_kfunc_meta kfunc;
 	struct bpf_kfunc_desc *desc;
 	unsigned long addr;
-	int err;
+	int err, i;
 
 	prog_aux = env->prog->aux;
 	tab = prog_aux->kfunc_tab;
@@ -2930,7 +2931,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 		prog_aux->kfunc_btf_tab = btf_tab;
 	}
 
-	if (find_kfunc_desc(env->prog, func_id, offset))
+	if (bpf_find_kfunc_desc(env->prog, func_id, offset))
 		return 0;
 
 	if (tab->nr_base_descs == MAX_KFUNC_DESCS) {
@@ -2990,7 +2991,10 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	desc = &tab->descs[tab->nr_descs];
 	memset(desc, 0, sizeof(*desc));
 
-	err = gen_kfunc_arg_proto(env, &meta, &func_model, &desc->proto);
+	/* the body of a kfunc that the program may call checks its arguments */
+	body = kfunc.flags && btf_kfunc_is_allowed(kfunc.btf, func_id, env->prog) ?
+	       btf_find_kfunc_body(kfunc.btf, func_id) : NULL;
+	err = body ? 0 : gen_kfunc_arg_proto(env, &meta, &func_model, &desc->proto);
 	if (err)
 		return err;
 
@@ -2998,6 +3002,10 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	desc->offset = offset;
 	desc->addr = addr;
 	desc->func_model = func_model;
+	desc->body = body;
+	for (i = 0; body && i < func_model.nr_args; i++)
+		if (btf_param_match_suffix(kfunc.btf, &btf_params(kfunc.proto)[i], "__k"))
+			desc->body_imm |= BIT(BPF_REG_1 + i);
 	tab->nr_descs++;
 	tab->nr_base_descs++;
 	sort(tab->descs, tab->nr_base_descs, sizeof(tab->descs[0]),
@@ -14762,7 +14770,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	func_name = meta.func_name;
 	insn_aux = &env->insn_aux_data[insn_idx];
 
-	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
+	desc = bpf_find_kfunc_desc(env->prog, insn->imm, insn->off);
 	if (!desc) {
 		verifier_bug(env, "kfunc descriptor not found for func_id %u", insn->imm);
 		return -EFAULT;
@@ -19527,6 +19535,9 @@ static int do_check(struct bpf_verifier_env *env)
 
 		state->last_insn_idx = env->prev_insn_idx;
 		state->insn_idx = env->insn_idx;
+		err = bpf_mark_kfunc_body_regs(env, prev_insn_idx, insn_aux);
+		if (err)
+			return err;
 		/*
 		 * Record the incoming edge so active and queued paths use the same
 		 * branch-recording path. A zero-offset conditional has identical
@@ -22180,7 +22191,7 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	 * __bpf_call_base, unless the JIT needs to call functions that are
 	 * further than 32 bits away (bpf_jit_supports_far_kfunc_call()).
 	 */
-	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
+	desc = bpf_find_kfunc_desc(env->prog, insn->imm, insn->off);
 	if (!desc) {
 		verifier_bug(env, "kernel function descriptor not found for func_id %u",
 			     insn->imm);
@@ -22655,15 +22666,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	env->test_reg_invariants = attr->prog_flags & BPF_F_TEST_REG_INVARIANTS;
 	env->arena_scalar = attr->prog_flags & BPF_F_ARENA_SCALAR;
 
-	env->explored_states = kvzalloc_objs(struct list_head,
-					     state_htab_size(env),
-					     GFP_KERNEL_ACCOUNT);
-	ret = -ENOMEM;
-	if (!env->explored_states)
-		goto skip_full_check;
-
-	for (i = 0; i < state_htab_size(env); i++)
-		INIT_LIST_HEAD(&env->explored_states[i]);
 	INIT_LIST_HEAD(&env->free_list);
 
 	/* Prepare BTF and func_info needed to discover all subprograms. */
@@ -22707,6 +22709,21 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = bpf_inline_kfunc_bodies(env);
+	if (ret < 0)
+		goto skip_full_check;
+
+	/* sized by the program length, so after the lowering */
+	env->explored_states = kvzalloc_objs(struct list_head,
+					     state_htab_size(env),
+					     GFP_KERNEL_ACCOUNT);
+	ret = -ENOMEM;
+	if (!env->explored_states)
+		goto skip_full_check;
+
+	for (i = 0; i < state_htab_size(env); i++)
+		INIT_LIST_HEAD(&env->explored_states[i]);
+
 	if (bpf_prog_is_offloaded(env->prog->aux)) {
 		ret = bpf_prog_offload_verifier_prep(env->prog);
 		if (ret)
@@ -22771,6 +22788,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 skip_full_check:
 	kvfree(env->explored_states);
 
+	if (ret == 0)
+		bpf_restore_kfunc_calls(env);
+
 	/* might decrease stack depth, keep it before passes that
 	 * allocate additional slots.
 	 */
@@ -22900,6 +22920,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 err_free_env:
 	bpf_free_subprog_jts(env);
 	vfree(env->insn_aux_data);
+	bpf_free_kfunc_inlines(env);
 	kvfree(env->fd_array);
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
-- 
2.51.1

