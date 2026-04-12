Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC530F806
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002849; cv=none; b=K4osX5LBe6oAfgCWe3gc1CLoYzWMc+x7JIjAhnTcfChZsvp7AGe+nOAcKbRFnYQzwDyRth7Bp6fm57cuoyum/GaalTfAYMlkKB+eHh0r5dKd2Uual6q1LRUh4HSW70ZtjGRKREBkYjOTJN7n+h72Xwifn+NKoIMmpau897s5zAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002849; c=relaxed/simple;
	bh=BDSPdGmTjVaIM6SlwLm7zsw4KryRJW3kAteyFMc+G0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV3AaRg8Lvy9dSmhzWEHOTdJepIDCTDkj+QTkAMr0JAj/+lTzzkHpGjUeCPu3fP51QaUQPs22t5zF2GOeVfjsgsOddlm4Q/dLJDq808wUt6C7ppQQCxlLkQ7AqaMEG2/S15EBs4I+auzcpEAg4gQYh48MacvlEL7jNsYIZUpVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3Pg1IFR; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3Pg1IFR"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76eea1672aso1201337a12.1
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776002841; x=1776607641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmZO8qj3moPVbFjPpkkI5+NShwjI97HR8hrWDJjggBU=;
        b=G3Pg1IFRWnk+fJM9IAJ9KWcDYv6CpFWizQ/U57bQX0zUoM8D8BQBh6Vegadqn3ggIw
         t4cgeJ/jkDFHfXygc9fdcT+3z+nQPQlWIx/8p0RZvlORhasouZfmKht+itfP6morW5bZ
         bJNQHNEBFfOpjwkYtcc3v+8+m2MbJopT1YzdEExlZn+CdJcfPCOgQ9/dSyCaiZ7mgNoI
         p7+IzHUz23Ma+1LT1pvMDVfLTwiPogORjm/5llMtp/DDVPZBsoHvM5Qz+v8wtEMcaLyP
         Fmp7BvQTad8WmezhpwE4hYiujnyWuP2tr9d2Rk/5GRSQ1KYBzBUps6JGNWSQMWBicStA
         1i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776002841; x=1776607641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CmZO8qj3moPVbFjPpkkI5+NShwjI97HR8hrWDJjggBU=;
        b=mN6g1ugwV+q8Q+CotZuX81Qs9Lam7deFAaAdwvq9x+mEFGZH98WgqNeCI/bsRIY0QC
         bG1ikb1bQVXmq7k0KUO8WcYjrh4AIy8nMoqAIJH6YUf8xj7QHNmX/xdukvjJ+OmLwF1Z
         ec+LNXSK3WPrXlYikR/P/01dk2TWRPYn6MoRL4niDmMmp47ZNTytpR4JKrjBC1Ddav2F
         njpo7vEoiSClzT/I8/mWIRi17FBaaT7bSTOiLnSEWYGfbpE/bTsdV0UG1qnq8qA3WxOD
         Wd2X6tNnNqCtQNCJoQZaH0OT/Lh4zeRT2IPVJQnSJ4AgEw0pFi5BCTuG1bojh0h6f5S0
         RRRw==
X-Gm-Message-State: AOJu0YyZ1lcgmQLMAcaKelisY+0fXaDPbvVkKmtJRf1a8cu27+1HLbFW
	4nEx28blPdzLbpeAI0/OzqNvundbkBnG53/uTNPuOoxHIlyG7PTB0HEmI9WidQ==
X-Gm-Gg: AeBDievUmBI5W8tKicNXvLRR4Pk4nm5HVCJS0pvTfGlnUMMWv9grYkEq7WV9SmIiLCI
	4qFfJbfwrqox53vWCEOeUKjBMs4IaxR6oYZ99l+wgSqJnzrqtc02x/5KFQ9L15vdonmSPZsYPXO
	PUclOk3r2LCp8NbO/ptQaAHIvG1dnD0Dl1Tp4c3TdJOzHE/PoK6952FF2Ud8pfWMO017EC0dbX0
	QCSTuB0f0HN5+hheR1A3S2Z/8U/HC+UILGixwdJWnz667RI+Zz6xJveMBxgg5E/ThAqV6zt4tbK
	Z6CUbXAaxlEEnPMORgSMrbs/X3dYSTRrXkB8vBzJXLTOzTP1Rmhrn0mbTpIGHmKqdPe1ElJncdU
	/KBkVcNNh259p3goX4dmCBLKv4AAJlYWqrn8XD37Bq9dWwZGnsKaMfUvoymqjIe1WicFckqweTD
	xlWEClZWZHudheVw7wa9KslT9C9xE9JEyOdTaI9MnO7Yj9svnp9tgU/HeoPkO9HdHDlw16k15KW
	cPFr5dRaD3jZ552L5L+UetHOiobFqnhhGIOYvbBSmJwyCfjY341OxuGCbp3C/Sqb0IZGNF9
X-Received: by 2002:a17:90a:3882:b0:35f:9ab2:a5a6 with SMTP id 98e67ed59e1d1-35f9ab2a792mr1168688a91.2.1776002840278;
        Sun, 12 Apr 2026 07:07:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e35155829sm12874778a91.13.2026.04.12.07.07.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Apr 2026 07:07:19 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v3 bpf-next 1/6] bpf: Split fixup/post-processing logic from verifier.c into fixups.c
Date: Sun, 12 Apr 2026 07:07:09 -0700
Message-ID: <20260412140715.30423-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260412140715.30423-1-alexei.starovoitov@gmail.com>
References: <20260412140715.30423-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

verifier.c is huge. Split fixup/post-processing logic that runs after
the verifier accepted the program into fixups.c.

Mechanical move. No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   78 +
 kernel/bpf/Makefile          |    1 +
 kernel/bpf/fixups.c          | 2457 ++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 2955 +++-------------------------------
 4 files changed, 2766 insertions(+), 2725 deletions(-)
 create mode 100644 kernel/bpf/fixups.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 05b9fe98b8f8..4380ecad485b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1205,4 +1205,82 @@ void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
 
+#define BPF_MAP_KEY_POISON	(1ULL << 63)
+#define BPF_MAP_KEY_SEEN	(1ULL << 62)
+
+static inline bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
+{
+	return aux->map_ptr_state.poison;
+}
+
+static inline bool bpf_map_ptr_unpriv(const struct bpf_insn_aux_data *aux)
+{
+	return aux->map_ptr_state.unpriv;
+}
+
+static inline bool bpf_map_key_poisoned(const struct bpf_insn_aux_data *aux)
+{
+	return aux->map_key_state & BPF_MAP_KEY_POISON;
+}
+
+static inline bool bpf_map_key_unseen(const struct bpf_insn_aux_data *aux)
+{
+	return !(aux->map_key_state & BPF_MAP_KEY_SEEN);
+}
+
+static inline u64 bpf_map_key_immediate(const struct bpf_insn_aux_data *aux)
+{
+	return aux->map_key_state & ~(BPF_MAP_KEY_SEEN | BPF_MAP_KEY_POISON);
+}
+
+#define MAX_PACKET_OFF 0xffff
+
+enum bpf_reg_arg_type {
+	SRC_OP,		/* register is used as source operand */
+	DST_OP,		/* register is used as destination operand */
+	DST_OP_NO_MARK	/* same as above, check only, don't mark */
+};
+
+#define MAX_KFUNC_DESCS 256
+
+struct bpf_kfunc_desc {
+	struct btf_func_model func_model;
+	u32 func_id;
+	s32 imm;
+	u16 offset;
+	unsigned long addr;
+};
+
+struct bpf_kfunc_desc_tab {
+	/* Sorted by func_id (BTF ID) and offset (fd_array offset) during
+	 * verification. JITs do lookups by bpf_insn, where func_id may not be
+	 * available, therefore at the end of verification do_misc_fixups()
+	 * sorts this by imm and offset.
+	 */
+	struct bpf_kfunc_desc descs[MAX_KFUNC_DESCS];
+	u32 nr_descs;
+};
+
+/* Functions exported from verifier.c, used by fixups.c */
+bool bpf_is_reg64(struct bpf_insn *insn, u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t);
+void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len);
+void bpf_mark_subprog_exc_cb(struct bpf_verifier_env *env, int subprog);
+bool bpf_allow_tail_call_in_subprogs(struct bpf_verifier_env *env);
+bool bpf_verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm);
+int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset);
+int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			 struct bpf_insn *insn_buf, int insn_idx, int *cnt);
+
+/* Functions in fixups.c, called from bpf_check() */
+int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env);
+int bpf_optimize_bpf_loop(struct bpf_verifier_env *env);
+void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env);
+int bpf_opt_remove_dead_code(struct bpf_verifier_env *env);
+int bpf_opt_remove_nops(struct bpf_verifier_env *env);
+int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env, const union bpf_attr *attr);
+int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
+int bpf_jit_subprogs(struct bpf_verifier_env *env);
+int bpf_fixup_call_args(struct bpf_verifier_env *env);
+int bpf_do_misc_fixups(struct bpf_verifier_env *env);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index b8ae7b0988a4..7c1eeee87fda 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
+obj-$(CONFIG_BPF_SYSCALL) += fixups.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o mprog.o
 obj-$(CONFIG_BPF_JIT) += trampoline.o
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
new file mode 100644
index 000000000000..67c9b28767e1
--- /dev/null
+++ b/kernel/bpf/fixups.c
@@ -0,0 +1,2457 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/bpf_verifier.h>
+#include <linux/filter.h>
+#include <linux/vmalloc.h>
+#include <linux/bsearch.h>
+#include <linux/sort.h>
+#include <linux/perf_event.h>
+#include <net/xdp.h>
+#include "disasm.h"
+
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
+
+static bool is_cmpxchg_insn(const struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_STX &&
+	       BPF_MODE(insn->code) == BPF_ATOMIC &&
+	       insn->imm == BPF_CMPXCHG;
+}
+
+/* Return the regno defined by the insn, or -1. */
+static int insn_def_regno(const struct bpf_insn *insn)
+{
+	switch (BPF_CLASS(insn->code)) {
+	case BPF_JMP:
+	case BPF_JMP32:
+	case BPF_ST:
+		return -1;
+	case BPF_STX:
+		if (BPF_MODE(insn->code) == BPF_ATOMIC ||
+		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
+			if (insn->imm == BPF_CMPXCHG)
+				return BPF_REG_0;
+			else if (insn->imm == BPF_LOAD_ACQ)
+				return insn->dst_reg;
+			else if (insn->imm & BPF_FETCH)
+				return insn->src_reg;
+		}
+		return -1;
+	default:
+		return insn->dst_reg;
+	}
+}
+
+/* Return TRUE if INSN has defined any 32-bit value explicitly. */
+static bool insn_has_def32(struct bpf_insn *insn)
+{
+	int dst_reg = insn_def_regno(insn);
+
+	if (dst_reg == -1)
+		return false;
+
+	return !bpf_is_reg64(insn, dst_reg, NULL, DST_OP);
+}
+
+static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
+{
+	const struct bpf_kfunc_desc *d0 = a;
+	const struct bpf_kfunc_desc *d1 = b;
+
+	if (d0->imm != d1->imm)
+		return d0->imm < d1->imm ? -1 : 1;
+	if (d0->offset != d1->offset)
+		return d0->offset < d1->offset ? -1 : 1;
+	return 0;
+}
+
+const struct btf_func_model *
+bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
+			 const struct bpf_insn *insn)
+{
+	const struct bpf_kfunc_desc desc = {
+		.imm = insn->imm,
+		.offset = insn->off,
+	};
+	const struct bpf_kfunc_desc *res;
+	struct bpf_kfunc_desc_tab *tab;
+
+	tab = prog->aux->kfunc_tab;
+	res = bsearch(&desc, tab->descs, tab->nr_descs,
+		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm_off);
+
+	return res ? &res->func_model : NULL;
+}
+
+static int set_kfunc_desc_imm(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
+{
+	unsigned long call_imm;
+
+	if (bpf_jit_supports_far_kfunc_call()) {
+		call_imm = desc->func_id;
+	} else {
+		call_imm = BPF_CALL_IMM(desc->addr);
+		/* Check whether the relative offset overflows desc->imm */
+		if ((unsigned long)(s32)call_imm != call_imm) {
+			verbose(env, "address of kernel func_id %u is out of range\n",
+				desc->func_id);
+			return -EINVAL;
+		}
+	}
+	desc->imm = call_imm;
+	return 0;
+}
+
+static int sort_kfunc_descs_by_imm_off(struct bpf_verifier_env *env)
+{
+	struct bpf_kfunc_desc_tab *tab;
+	int i, err;
+
+	tab = env->prog->aux->kfunc_tab;
+	if (!tab)
+		return 0;
+
+	for (i = 0; i < tab->nr_descs; i++) {
+		err = set_kfunc_desc_imm(env, &tab->descs[i]);
+		if (err)
+			return err;
+	}
+
+	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
+	     kfunc_desc_cmp_by_imm_off, NULL);
+	return 0;
+}
+
+static int add_kfunc_in_insns(struct bpf_verifier_env *env,
+			      struct bpf_insn *insn, int cnt)
+{
+	int i, ret;
+
+	for (i = 0; i < cnt; i++, insn++) {
+		if (bpf_pseudo_kfunc_call(insn)) {
+			ret = bpf_add_kfunc_call(env, insn->imm, insn->off);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return 0;
+}
+
+#ifndef CONFIG_BPF_JIT_ALWAYS_ON
+static int get_callee_stack_depth(struct bpf_verifier_env *env,
+				  const struct bpf_insn *insn, int idx)
+{
+	int start = idx + insn->imm + 1, subprog;
+
+	subprog = bpf_find_subprog(env, start);
+	if (verifier_bug_if(subprog < 0, env, "get stack depth: no program at insn %d", start))
+		return -EFAULT;
+	return env->subprog_info[subprog].stack_depth;
+}
+#endif
+
+/* single env->prog->insni[off] instruction was replaced with the range
+ * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
+ * [0, off) and [off, end) to new locations, so the patched range stays zero
+ */
+static void adjust_insn_aux_data(struct bpf_verifier_env *env,
+				 struct bpf_prog *new_prog, u32 off, u32 cnt)
+{
+	struct bpf_insn_aux_data *data = env->insn_aux_data;
+	struct bpf_insn *insn = new_prog->insnsi;
+	u32 old_seen = data[off].seen;
+	u32 prog_len;
+	int i;
+
+	/* aux info at OFF always needs adjustment, no matter fast path
+	 * (cnt == 1) is taken or not. There is no guarantee INSN at OFF is the
+	 * original insn at old prog.
+	 */
+	data[off].zext_dst = insn_has_def32(insn + off + cnt - 1);
+
+	if (cnt == 1)
+		return;
+	prog_len = new_prog->len;
+
+	memmove(data + off + cnt - 1, data + off,
+		sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
+	memset(data + off, 0, sizeof(struct bpf_insn_aux_data) * (cnt - 1));
+	for (i = off; i < off + cnt - 1; i++) {
+		/* Expand insni[off]'s seen count to the patched range. */
+		data[i].seen = old_seen;
+		data[i].zext_dst = insn_has_def32(insn + i);
+	}
+}
+
+static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len)
+{
+	int i;
+
+	if (len == 1)
+		return;
+	/* NOTE: fake 'exit' subprog should be updated as well. */
+	for (i = 0; i <= env->subprog_cnt; i++) {
+		if (env->subprog_info[i].start <= off)
+			continue;
+		env->subprog_info[i].start += len - 1;
+	}
+}
+
+static void adjust_insn_arrays(struct bpf_verifier_env *env, u32 off, u32 len)
+{
+	int i;
+
+	if (len == 1)
+		return;
+
+	for (i = 0; i < env->insn_array_map_cnt; i++)
+		bpf_insn_array_adjust(env->insn_array_maps[i], off, len);
+}
+
+static void adjust_insn_arrays_after_remove(struct bpf_verifier_env *env, u32 off, u32 len)
+{
+	int i;
+
+	for (i = 0; i < env->insn_array_map_cnt; i++)
+		bpf_insn_array_adjust_after_remove(env->insn_array_maps[i], off, len);
+}
+
+static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
+{
+	struct bpf_jit_poke_descriptor *tab = prog->aux->poke_tab;
+	int i, sz = prog->aux->size_poke_tab;
+	struct bpf_jit_poke_descriptor *desc;
+
+	for (i = 0; i < sz; i++) {
+		desc = &tab[i];
+		if (desc->insn_idx <= off)
+			continue;
+		desc->insn_idx += len - 1;
+	}
+}
+
+static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
+					    const struct bpf_insn *patch, u32 len)
+{
+	struct bpf_prog *new_prog;
+	struct bpf_insn_aux_data *new_data = NULL;
+
+	if (len > 1) {
+		new_data = vrealloc(env->insn_aux_data,
+				    array_size(env->prog->len + len - 1,
+					       sizeof(struct bpf_insn_aux_data)),
+				    GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+		if (!new_data)
+			return NULL;
+
+		env->insn_aux_data = new_data;
+	}
+
+	new_prog = bpf_patch_insn_single(env->prog, off, patch, len);
+	if (IS_ERR(new_prog)) {
+		if (PTR_ERR(new_prog) == -ERANGE)
+			verbose(env,
+				"insn %d cannot be patched due to 16-bit range\n",
+				env->insn_aux_data[off].orig_idx);
+		return NULL;
+	}
+	adjust_insn_aux_data(env, new_prog, off, len);
+	adjust_subprog_starts(env, off, len);
+	adjust_insn_arrays(env, off, len);
+	adjust_poke_descs(new_prog, off, len);
+	return new_prog;
+}
+
+/*
+ * For all jmp insns in a given 'prog' that point to 'tgt_idx' insn adjust the
+ * jump offset by 'delta'.
+ */
+static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
+{
+	struct bpf_insn *insn = prog->insnsi;
+	u32 insn_cnt = prog->len, i;
+	s32 imm;
+	s16 off;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		u8 code = insn->code;
+
+		if (tgt_idx <= i && i < tgt_idx + delta)
+			continue;
+
+		if ((BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32) ||
+		    BPF_OP(code) == BPF_CALL || BPF_OP(code) == BPF_EXIT)
+			continue;
+
+		if (insn->code == (BPF_JMP32 | BPF_JA)) {
+			if (i + 1 + insn->imm != tgt_idx)
+				continue;
+			if (check_add_overflow(insn->imm, delta, &imm))
+				return -ERANGE;
+			insn->imm = imm;
+		} else {
+			if (i + 1 + insn->off != tgt_idx)
+				continue;
+			if (check_add_overflow(insn->off, delta, &off))
+				return -ERANGE;
+			insn->off = off;
+		}
+	}
+	return 0;
+}
+
+static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
+					      u32 off, u32 cnt)
+{
+	int i, j;
+
+	/* find first prog starting at or after off (first to remove) */
+	for (i = 0; i < env->subprog_cnt; i++)
+		if (env->subprog_info[i].start >= off)
+			break;
+	/* find first prog starting at or after off + cnt (first to stay) */
+	for (j = i; j < env->subprog_cnt; j++)
+		if (env->subprog_info[j].start >= off + cnt)
+			break;
+	/* if j doesn't start exactly at off + cnt, we are just removing
+	 * the front of previous prog
+	 */
+	if (env->subprog_info[j].start != off + cnt)
+		j--;
+
+	if (j > i) {
+		struct bpf_prog_aux *aux = env->prog->aux;
+		int move;
+
+		/* move fake 'exit' subprog as well */
+		move = env->subprog_cnt + 1 - j;
+
+		memmove(env->subprog_info + i,
+			env->subprog_info + j,
+			sizeof(*env->subprog_info) * move);
+		env->subprog_cnt -= j - i;
+
+		/* remove func_info */
+		if (aux->func_info) {
+			move = aux->func_info_cnt - j;
+
+			memmove(aux->func_info + i,
+				aux->func_info + j,
+				sizeof(*aux->func_info) * move);
+			aux->func_info_cnt -= j - i;
+			/* func_info->insn_off is set after all code rewrites,
+			 * in adjust_btf_func() - no need to adjust
+			 */
+		}
+	} else {
+		/* convert i from "first prog to remove" to "first to adjust" */
+		if (env->subprog_info[i].start == off)
+			i++;
+	}
+
+	/* update fake 'exit' subprog as well */
+	for (; i <= env->subprog_cnt; i++)
+		env->subprog_info[i].start -= cnt;
+
+	return 0;
+}
+
+static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
+				      u32 cnt)
+{
+	struct bpf_prog *prog = env->prog;
+	u32 i, l_off, l_cnt, nr_linfo;
+	struct bpf_line_info *linfo;
+
+	nr_linfo = prog->aux->nr_linfo;
+	if (!nr_linfo)
+		return 0;
+
+	linfo = prog->aux->linfo;
+
+	/* find first line info to remove, count lines to be removed */
+	for (i = 0; i < nr_linfo; i++)
+		if (linfo[i].insn_off >= off)
+			break;
+
+	l_off = i;
+	l_cnt = 0;
+	for (; i < nr_linfo; i++)
+		if (linfo[i].insn_off < off + cnt)
+			l_cnt++;
+		else
+			break;
+
+	/* First live insn doesn't match first live linfo, it needs to "inherit"
+	 * last removed linfo.  prog is already modified, so prog->len == off
+	 * means no live instructions after (tail of the program was removed).
+	 */
+	if (prog->len != off && l_cnt &&
+	    (i == nr_linfo || linfo[i].insn_off != off + cnt)) {
+		l_cnt--;
+		linfo[--i].insn_off = off + cnt;
+	}
+
+	/* remove the line info which refer to the removed instructions */
+	if (l_cnt) {
+		memmove(linfo + l_off, linfo + i,
+			sizeof(*linfo) * (nr_linfo - i));
+
+		prog->aux->nr_linfo -= l_cnt;
+		nr_linfo = prog->aux->nr_linfo;
+	}
+
+	/* pull all linfo[i].insn_off >= off + cnt in by cnt */
+	for (i = l_off; i < nr_linfo; i++)
+		linfo[i].insn_off -= cnt;
+
+	/* fix up all subprogs (incl. 'exit') which start >= off */
+	for (i = 0; i <= env->subprog_cnt; i++)
+		if (env->subprog_info[i].linfo_idx > l_off) {
+			/* program may have started in the removed region but
+			 * may not be fully removed
+			 */
+			if (env->subprog_info[i].linfo_idx >= l_off + l_cnt)
+				env->subprog_info[i].linfo_idx -= l_cnt;
+			else
+				env->subprog_info[i].linfo_idx = l_off;
+		}
+
+	return 0;
+}
+
+/*
+ * Clean up dynamically allocated fields of aux data for instructions [start, ...]
+ */
+void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
+{
+	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	int end = start + len;
+	int i;
+
+	for (i = start; i < end; i++) {
+		if (aux_data[i].jt) {
+			kvfree(aux_data[i].jt);
+			aux_data[i].jt = NULL;
+		}
+
+		if (bpf_is_ldimm64(&insns[i]))
+			i++;
+	}
+}
+
+static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
+{
+	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
+	unsigned int orig_prog_len = env->prog->len;
+	int err;
+
+	if (bpf_prog_is_offloaded(env->prog->aux))
+		bpf_prog_offload_remove_insns(env, off, cnt);
+
+	/* Should be called before bpf_remove_insns, as it uses prog->insnsi */
+	bpf_clear_insn_aux_data(env, off, cnt);
+
+	err = bpf_remove_insns(env->prog, off, cnt);
+	if (err)
+		return err;
+
+	err = adjust_subprog_starts_after_remove(env, off, cnt);
+	if (err)
+		return err;
+
+	err = bpf_adj_linfo_after_remove(env, off, cnt);
+	if (err)
+		return err;
+
+	adjust_insn_arrays_after_remove(env, off, cnt);
+
+	memmove(aux_data + off,	aux_data + off + cnt,
+		sizeof(*aux_data) * (orig_prog_len - off - cnt));
+
+	return 0;
+}
+
+static const struct bpf_insn NOP = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+static const struct bpf_insn MAY_GOTO_0 = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0, 0);
+
+bool bpf_insn_is_cond_jump(u8 code)
+{
+	u8 op;
+
+	op = BPF_OP(code);
+	if (BPF_CLASS(code) == BPF_JMP32)
+		return op != BPF_JA;
+
+	if (BPF_CLASS(code) != BPF_JMP)
+		return false;
+
+	return op != BPF_JA && op != BPF_EXIT && op != BPF_CALL;
+}
+
+void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
+	struct bpf_insn ja = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
+	struct bpf_insn *insn = env->prog->insnsi;
+	const int insn_cnt = env->prog->len;
+	int i;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (!bpf_insn_is_cond_jump(insn->code))
+			continue;
+
+		if (!aux_data[i + 1].seen)
+			ja.off = insn->off;
+		else if (!aux_data[i + 1 + insn->off].seen)
+			ja.off = 0;
+		else
+			continue;
+
+		if (bpf_prog_is_offloaded(env->prog->aux))
+			bpf_prog_offload_replace_insn(env, i, &ja);
+
+		memcpy(insn, &ja, sizeof(ja));
+	}
+}
+
+int bpf_opt_remove_dead_code(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
+	int insn_cnt = env->prog->len;
+	int i, err;
+
+	for (i = 0; i < insn_cnt; i++) {
+		int j;
+
+		j = 0;
+		while (i + j < insn_cnt && !aux_data[i + j].seen)
+			j++;
+		if (!j)
+			continue;
+
+		err = verifier_remove_insns(env, i, j);
+		if (err)
+			return err;
+		insn_cnt = env->prog->len;
+	}
+
+	return 0;
+}
+
+int bpf_opt_remove_nops(struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insn = env->prog->insnsi;
+	int insn_cnt = env->prog->len;
+	bool is_may_goto_0, is_ja;
+	int i, err;
+
+	for (i = 0; i < insn_cnt; i++) {
+		is_may_goto_0 = !memcmp(&insn[i], &MAY_GOTO_0, sizeof(MAY_GOTO_0));
+		is_ja = !memcmp(&insn[i], &NOP, sizeof(NOP));
+
+		if (!is_may_goto_0 && !is_ja)
+			continue;
+
+		err = verifier_remove_insns(env, i, 1);
+		if (err)
+			return err;
+		insn_cnt--;
+		/* Go back one insn to catch may_goto +1; may_goto +0 sequence */
+		i -= (is_may_goto_0 && i > 0) ? 2 : 1;
+	}
+
+	return 0;
+}
+
+int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
+					 const union bpf_attr *attr)
+{
+	struct bpf_insn *patch;
+	/* use env->insn_buf as two independent buffers */
+	struct bpf_insn *zext_patch = env->insn_buf;
+	struct bpf_insn *rnd_hi32_patch = &env->insn_buf[2];
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int i, patch_len, delta = 0, len = env->prog->len;
+	struct bpf_insn *insns = env->prog->insnsi;
+	struct bpf_prog *new_prog;
+	bool rnd_hi32;
+
+	rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
+	zext_patch[1] = BPF_ZEXT_REG(0);
+	rnd_hi32_patch[1] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, 0);
+	rnd_hi32_patch[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
+	rnd_hi32_patch[3] = BPF_ALU64_REG(BPF_OR, 0, BPF_REG_AX);
+	for (i = 0; i < len; i++) {
+		int adj_idx = i + delta;
+		struct bpf_insn insn;
+		int load_reg;
+
+		insn = insns[adj_idx];
+		load_reg = insn_def_regno(&insn);
+		if (!aux[adj_idx].zext_dst) {
+			u8 code, class;
+			u32 imm_rnd;
+
+			if (!rnd_hi32)
+				continue;
+
+			code = insn.code;
+			class = BPF_CLASS(code);
+			if (load_reg == -1)
+				continue;
+
+			/* NOTE: arg "reg" (the fourth one) is only used for
+			 *       BPF_STX + SRC_OP, so it is safe to pass NULL
+			 *       here.
+			 */
+			if (bpf_is_reg64(&insn, load_reg, NULL, DST_OP)) {
+				if (class == BPF_LD &&
+				    BPF_MODE(code) == BPF_IMM)
+					i++;
+				continue;
+			}
+
+			/* ctx load could be transformed into wider load. */
+			if (class == BPF_LDX &&
+			    aux[adj_idx].ptr_type == PTR_TO_CTX)
+				continue;
+
+			imm_rnd = get_random_u32();
+			rnd_hi32_patch[0] = insn;
+			rnd_hi32_patch[1].imm = imm_rnd;
+			rnd_hi32_patch[3].dst_reg = load_reg;
+			patch = rnd_hi32_patch;
+			patch_len = 4;
+			goto apply_patch_buffer;
+		}
+
+		/* Add in an zero-extend instruction if a) the JIT has requested
+		 * it or b) it's a CMPXCHG.
+		 *
+		 * The latter is because: BPF_CMPXCHG always loads a value into
+		 * R0, therefore always zero-extends. However some archs'
+		 * equivalent instruction only does this load when the
+		 * comparison is successful. This detail of CMPXCHG is
+		 * orthogonal to the general zero-extension behaviour of the
+		 * CPU, so it's treated independently of bpf_jit_needs_zext.
+		 */
+		if (!bpf_jit_needs_zext() && !is_cmpxchg_insn(&insn))
+			continue;
+
+		/* Zero-extension is done by the caller. */
+		if (bpf_pseudo_kfunc_call(&insn))
+			continue;
+
+		if (verifier_bug_if(load_reg == -1, env,
+				    "zext_dst is set, but no reg is defined"))
+			return -EFAULT;
+
+		zext_patch[0] = insn;
+		zext_patch[1].dst_reg = load_reg;
+		zext_patch[1].src_reg = load_reg;
+		patch = zext_patch;
+		patch_len = 2;
+apply_patch_buffer:
+		new_prog = bpf_patch_insn_data(env, adj_idx, patch, patch_len);
+		if (!new_prog)
+			return -ENOMEM;
+		env->prog = new_prog;
+		insns = new_prog->insnsi;
+		aux = env->insn_aux_data;
+		delta += patch_len - 1;
+	}
+
+	return 0;
+}
+
+/* convert load instructions that access fields of a context type into a
+ * sequence of instructions that access fields of the underlying structure:
+ *     struct __sk_buff    -> struct sk_buff
+ *     struct bpf_sock_ops -> struct sock
+ */
+int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *subprogs = env->subprog_info;
+	const struct bpf_verifier_ops *ops = env->ops;
+	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
+	const int insn_cnt = env->prog->len;
+	struct bpf_insn *epilogue_buf = env->epilogue_buf;
+	struct bpf_insn *insn_buf = env->insn_buf;
+	struct bpf_insn *insn;
+	u32 target_size, size_default, off;
+	struct bpf_prog *new_prog;
+	enum bpf_access_type type;
+	bool is_narrower_load;
+	int epilogue_idx = 0;
+
+	if (ops->gen_epilogue) {
+		epilogue_cnt = ops->gen_epilogue(epilogue_buf, env->prog,
+						 -(subprogs[0].stack_depth + 8));
+		if (epilogue_cnt >= INSN_BUF_SIZE) {
+			verifier_bug(env, "epilogue is too long");
+			return -EFAULT;
+		} else if (epilogue_cnt) {
+			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
+			cnt = 0;
+			subprogs[0].stack_depth += 8;
+			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
+						      -subprogs[0].stack_depth);
+			insn_buf[cnt++] = env->prog->insnsi[0];
+			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+			env->prog = new_prog;
+			delta += cnt - 1;
+
+			ret = add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	if (ops->gen_prologue || env->seen_direct_write) {
+		if (!ops->gen_prologue) {
+			verifier_bug(env, "gen_prologue is null");
+			return -EFAULT;
+		}
+		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
+					env->prog);
+		if (cnt >= INSN_BUF_SIZE) {
+			verifier_bug(env, "prologue is too long");
+			return -EFAULT;
+		} else if (cnt) {
+			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			env->prog = new_prog;
+			delta += cnt - 1;
+
+			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	if (delta)
+		WARN_ON(adjust_jmp_off(env->prog, 0, delta));
+
+	if (bpf_prog_is_offloaded(env->prog->aux))
+		return 0;
+
+	insn = env->prog->insnsi + delta;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		bpf_convert_ctx_access_t convert_ctx_access;
+		u8 mode;
+
+		if (env->insn_aux_data[i + delta].nospec) {
+			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
+			struct bpf_insn *patch = insn_buf;
+
+			*patch++ = BPF_ST_NOSPEC();
+			*patch++ = *insn;
+			cnt = patch - insn_buf;
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			/* This can not be easily merged with the
+			 * nospec_result-case, because an insn may require a
+			 * nospec before and after itself. Therefore also do not
+			 * 'continue' here but potentially apply further
+			 * patching to insn. *insn should equal patch[1] now.
+			 */
+		}
+
+		if (insn->code == (BPF_LDX | BPF_MEM | BPF_B) ||
+		    insn->code == (BPF_LDX | BPF_MEM | BPF_H) ||
+		    insn->code == (BPF_LDX | BPF_MEM | BPF_W) ||
+		    insn->code == (BPF_LDX | BPF_MEM | BPF_DW) ||
+		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_B) ||
+		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_H) ||
+		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_W)) {
+			type = BPF_READ;
+		} else if (insn->code == (BPF_STX | BPF_MEM | BPF_B) ||
+			   insn->code == (BPF_STX | BPF_MEM | BPF_H) ||
+			   insn->code == (BPF_STX | BPF_MEM | BPF_W) ||
+			   insn->code == (BPF_STX | BPF_MEM | BPF_DW) ||
+			   insn->code == (BPF_ST | BPF_MEM | BPF_B) ||
+			   insn->code == (BPF_ST | BPF_MEM | BPF_H) ||
+			   insn->code == (BPF_ST | BPF_MEM | BPF_W) ||
+			   insn->code == (BPF_ST | BPF_MEM | BPF_DW)) {
+			type = BPF_WRITE;
+		} else if ((insn->code == (BPF_STX | BPF_ATOMIC | BPF_B) ||
+			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_H) ||
+			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_W) ||
+			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_DW)) &&
+			   env->insn_aux_data[i + delta].ptr_type == PTR_TO_ARENA) {
+			insn->code = BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
+			env->prog->aux->num_exentries++;
+			continue;
+		} else if (insn->code == (BPF_JMP | BPF_EXIT) &&
+			   epilogue_cnt &&
+			   i + delta < subprogs[1].start) {
+			/* Generate epilogue for the main prog */
+			if (epilogue_idx) {
+				/* jump back to the earlier generated epilogue */
+				insn_buf[0] = BPF_JMP32_A(epilogue_idx - i - delta - 1);
+				cnt = 1;
+			} else {
+				memcpy(insn_buf, epilogue_buf,
+				       epilogue_cnt * sizeof(*epilogue_buf));
+				cnt = epilogue_cnt;
+				/* epilogue_idx cannot be 0. It must have at
+				 * least one ctx ptr saving insn before the
+				 * epilogue.
+				 */
+				epilogue_idx = i + delta;
+			}
+			goto patch_insn_buf;
+		} else {
+			continue;
+		}
+
+		if (type == BPF_WRITE &&
+		    env->insn_aux_data[i + delta].nospec_result) {
+			/* nospec_result is only used to mitigate Spectre v4 and
+			 * to limit verification-time for Spectre v1.
+			 */
+			struct bpf_insn *patch = insn_buf;
+
+			*patch++ = *insn;
+			*patch++ = BPF_ST_NOSPEC();
+			cnt = patch - insn_buf;
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			continue;
+		}
+
+		switch ((int)env->insn_aux_data[i + delta].ptr_type) {
+		case PTR_TO_CTX:
+			if (!ops->convert_ctx_access)
+				continue;
+			convert_ctx_access = ops->convert_ctx_access;
+			break;
+		case PTR_TO_SOCKET:
+		case PTR_TO_SOCK_COMMON:
+			convert_ctx_access = bpf_sock_convert_ctx_access;
+			break;
+		case PTR_TO_TCP_SOCK:
+			convert_ctx_access = bpf_tcp_sock_convert_ctx_access;
+			break;
+		case PTR_TO_XDP_SOCK:
+			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
+			break;
+		case PTR_TO_BTF_ID:
+		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
+		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
+		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
+		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
+		 * any faults for loads into such types. BPF_WRITE is disallowed
+		 * for this case.
+		 */
+		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
+		case PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED:
+			if (type == BPF_READ) {
+				if (BPF_MODE(insn->code) == BPF_MEM)
+					insn->code = BPF_LDX | BPF_PROBE_MEM |
+						     BPF_SIZE((insn)->code);
+				else
+					insn->code = BPF_LDX | BPF_PROBE_MEMSX |
+						     BPF_SIZE((insn)->code);
+				env->prog->aux->num_exentries++;
+			}
+			continue;
+		case PTR_TO_ARENA:
+			if (BPF_MODE(insn->code) == BPF_MEMSX) {
+				if (!bpf_jit_supports_insn(insn, true)) {
+					verbose(env, "sign extending loads from arena are not supported yet\n");
+					return -EOPNOTSUPP;
+				}
+				insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32SX | BPF_SIZE(insn->code);
+			} else {
+				insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32 | BPF_SIZE(insn->code);
+			}
+			env->prog->aux->num_exentries++;
+			continue;
+		default:
+			continue;
+		}
+
+		ctx_field_size = env->insn_aux_data[i + delta].ctx_field_size;
+		size = BPF_LDST_BYTES(insn);
+		mode = BPF_MODE(insn->code);
+
+		/* If the read access is a narrower load of the field,
+		 * convert to a 4/8-byte load, to minimum program type specific
+		 * convert_ctx_access changes. If conversion is successful,
+		 * we will apply proper mask to the result.
+		 */
+		is_narrower_load = size < ctx_field_size;
+		size_default = bpf_ctx_off_adjust_machine(ctx_field_size);
+		off = insn->off;
+		if (is_narrower_load) {
+			u8 size_code;
+
+			if (type == BPF_WRITE) {
+				verifier_bug(env, "narrow ctx access misconfigured");
+				return -EFAULT;
+			}
+
+			size_code = BPF_H;
+			if (ctx_field_size == 4)
+				size_code = BPF_W;
+			else if (ctx_field_size == 8)
+				size_code = BPF_DW;
+
+			insn->off = off & ~(size_default - 1);
+			insn->code = BPF_LDX | BPF_MEM | size_code;
+		}
+
+		target_size = 0;
+		cnt = convert_ctx_access(type, insn, insn_buf, env->prog,
+					 &target_size);
+		if (cnt == 0 || cnt >= INSN_BUF_SIZE ||
+		    (ctx_field_size && !target_size)) {
+			verifier_bug(env, "error during ctx access conversion (%d)", cnt);
+			return -EFAULT;
+		}
+
+		if (is_narrower_load && size < target_size) {
+			u8 shift = bpf_ctx_narrow_access_offset(
+				off, size, size_default) * 8;
+			if (shift && cnt + 1 >= INSN_BUF_SIZE) {
+				verifier_bug(env, "narrow ctx load misconfigured");
+				return -EFAULT;
+			}
+			if (ctx_field_size <= 4) {
+				if (shift)
+					insn_buf[cnt++] = BPF_ALU32_IMM(BPF_RSH,
+									insn->dst_reg,
+									shift);
+				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
+								(1 << size * 8) - 1);
+			} else {
+				if (shift)
+					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
+									insn->dst_reg,
+									shift);
+				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
+								(1ULL << size * 8) - 1);
+			}
+		}
+		if (mode == BPF_MEMSX)
+			insn_buf[cnt++] = BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X,
+						       insn->dst_reg, insn->dst_reg,
+						       size * 8, 0);
+
+patch_insn_buf:
+		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+		if (!new_prog)
+			return -ENOMEM;
+
+		delta += cnt - 1;
+
+		/* keep walking new program and skip insns we just inserted */
+		env->prog = new_prog;
+		insn      = new_prog->insnsi + i + delta;
+	}
+
+	return 0;
+}
+
+int bpf_jit_subprogs(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog, **func, *tmp;
+	int i, j, subprog_start, subprog_end = 0, len, subprog;
+	struct bpf_map *map_ptr;
+	struct bpf_insn *insn;
+	void *old_bpf_func;
+	int err, num_exentries;
+	int old_len, subprog_start_adjustment = 0;
+
+	if (env->subprog_cnt <= 1)
+		return 0;
+
+	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
+		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
+			continue;
+
+		/* Upon error here we cannot fall back to interpreter but
+		 * need a hard reject of the program. Thus -EFAULT is
+		 * propagated in any case.
+		 */
+		subprog = bpf_find_subprog(env, i + insn->imm + 1);
+		if (verifier_bug_if(subprog < 0, env, "No program to jit at insn %d",
+				    i + insn->imm + 1))
+			return -EFAULT;
+		/* temporarily remember subprog id inside insn instead of
+		 * aux_data, since next loop will split up all insns into funcs
+		 */
+		insn->off = subprog;
+		/* remember original imm in case JIT fails and fallback
+		 * to interpreter will be needed
+		 */
+		env->insn_aux_data[i].call_imm = insn->imm;
+		/* point imm to __bpf_call_base+1 from JITs point of view */
+		insn->imm = 1;
+		if (bpf_pseudo_func(insn)) {
+#if defined(MODULES_VADDR)
+			u64 addr = MODULES_VADDR;
+#else
+			u64 addr = VMALLOC_START;
+#endif
+			/* jit (e.g. x86_64) may emit fewer instructions
+			 * if it learns a u32 imm is the same as a u64 imm.
+			 * Set close enough to possible prog address.
+			 */
+			insn[0].imm = (u32)addr;
+			insn[1].imm = addr >> 32;
+		}
+	}
+
+	err = bpf_prog_alloc_jited_linfo(prog);
+	if (err)
+		goto out_undo_insn;
+
+	err = -ENOMEM;
+	func = kzalloc_objs(prog, env->subprog_cnt);
+	if (!func)
+		goto out_undo_insn;
+
+	for (i = 0; i < env->subprog_cnt; i++) {
+		subprog_start = subprog_end;
+		subprog_end = env->subprog_info[i + 1].start;
+
+		len = subprog_end - subprog_start;
+		/* bpf_prog_run() doesn't call subprogs directly,
+		 * hence main prog stats include the runtime of subprogs.
+		 * subprogs don't have IDs and not reachable via prog_get_next_id
+		 * func[i]->stats will never be accessed and stays NULL
+		 */
+		func[i] = bpf_prog_alloc_no_stats(bpf_prog_size(len), GFP_USER);
+		if (!func[i])
+			goto out_free;
+		memcpy(func[i]->insnsi, &prog->insnsi[subprog_start],
+		       len * sizeof(struct bpf_insn));
+		func[i]->type = prog->type;
+		func[i]->len = len;
+		if (bpf_prog_calc_tag(func[i]))
+			goto out_free;
+		func[i]->is_func = 1;
+		func[i]->sleepable = prog->sleepable;
+		func[i]->aux->func_idx = i;
+		/* Below members will be freed only at prog->aux */
+		func[i]->aux->btf = prog->aux->btf;
+		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
+		func[i]->aux->func_info = prog->aux->func_info;
+		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
+		func[i]->aux->poke_tab = prog->aux->poke_tab;
+		func[i]->aux->size_poke_tab = prog->aux->size_poke_tab;
+		func[i]->aux->main_prog_aux = prog->aux;
+
+		for (j = 0; j < prog->aux->size_poke_tab; j++) {
+			struct bpf_jit_poke_descriptor *poke;
+
+			poke = &prog->aux->poke_tab[j];
+			if (poke->insn_idx < subprog_end &&
+			    poke->insn_idx >= subprog_start)
+				poke->aux = func[i]->aux;
+		}
+
+		func[i]->aux->name[0] = 'F';
+		func[i]->aux->stack_depth = env->subprog_info[i].stack_depth;
+		if (env->subprog_info[i].priv_stack_mode == PRIV_STACK_ADAPTIVE)
+			func[i]->aux->jits_use_priv_stack = true;
+
+		func[i]->jit_requested = 1;
+		func[i]->blinding_requested = prog->blinding_requested;
+		func[i]->aux->kfunc_tab = prog->aux->kfunc_tab;
+		func[i]->aux->kfunc_btf_tab = prog->aux->kfunc_btf_tab;
+		func[i]->aux->linfo = prog->aux->linfo;
+		func[i]->aux->nr_linfo = prog->aux->nr_linfo;
+		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
+		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
+		func[i]->aux->arena = prog->aux->arena;
+		func[i]->aux->used_maps = env->used_maps;
+		func[i]->aux->used_map_cnt = env->used_map_cnt;
+		num_exentries = 0;
+		insn = func[i]->insnsi;
+		for (j = 0; j < func[i]->len; j++, insn++) {
+			if (BPF_CLASS(insn->code) == BPF_LDX &&
+			    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+			     BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
+			     BPF_MODE(insn->code) == BPF_PROBE_MEM32SX ||
+			     BPF_MODE(insn->code) == BPF_PROBE_MEMSX))
+				num_exentries++;
+			if ((BPF_CLASS(insn->code) == BPF_STX ||
+			     BPF_CLASS(insn->code) == BPF_ST) &&
+			     BPF_MODE(insn->code) == BPF_PROBE_MEM32)
+				num_exentries++;
+			if (BPF_CLASS(insn->code) == BPF_STX &&
+			     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC)
+				num_exentries++;
+		}
+		func[i]->aux->num_exentries = num_exentries;
+		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
+		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
+		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
+		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
+		if (!i)
+			func[i]->aux->exception_boundary = env->seen_exception;
+
+		/*
+		 * To properly pass the absolute subprog start to jit
+		 * all instruction adjustments should be accumulated
+		 */
+		old_len = func[i]->len;
+		func[i] = bpf_int_jit_compile(func[i]);
+		subprog_start_adjustment += func[i]->len - old_len;
+
+		if (!func[i]->jited) {
+			err = -ENOTSUPP;
+			goto out_free;
+		}
+		cond_resched();
+	}
+
+	/* at this point all bpf functions were successfully JITed
+	 * now populate all bpf_calls with correct addresses and
+	 * run last pass of JIT
+	 */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		insn = func[i]->insnsi;
+		for (j = 0; j < func[i]->len; j++, insn++) {
+			if (bpf_pseudo_func(insn)) {
+				subprog = insn->off;
+				insn[0].imm = (u32)(long)func[subprog]->bpf_func;
+				insn[1].imm = ((u64)(long)func[subprog]->bpf_func) >> 32;
+				continue;
+			}
+			if (!bpf_pseudo_call(insn))
+				continue;
+			subprog = insn->off;
+			insn->imm = BPF_CALL_IMM(func[subprog]->bpf_func);
+		}
+
+		/* we use the aux data to keep a list of the start addresses
+		 * of the JITed images for each function in the program
+		 *
+		 * for some architectures, such as powerpc64, the imm field
+		 * might not be large enough to hold the offset of the start
+		 * address of the callee's JITed image from __bpf_call_base
+		 *
+		 * in such cases, we can lookup the start address of a callee
+		 * by using its subprog id, available from the off field of
+		 * the call instruction, as an index for this list
+		 */
+		func[i]->aux->func = func;
+		func[i]->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
+		func[i]->aux->real_func_cnt = env->subprog_cnt;
+	}
+	for (i = 0; i < env->subprog_cnt; i++) {
+		old_bpf_func = func[i]->bpf_func;
+		tmp = bpf_int_jit_compile(func[i]);
+		if (tmp != func[i] || func[i]->bpf_func != old_bpf_func) {
+			verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
+			err = -ENOTSUPP;
+			goto out_free;
+		}
+		cond_resched();
+	}
+
+	/*
+	 * Cleanup func[i]->aux fields which aren't required
+	 * or can become invalid in future
+	 */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		func[i]->aux->used_maps = NULL;
+		func[i]->aux->used_map_cnt = 0;
+	}
+
+	/* finally lock prog and jit images for all functions and
+	 * populate kallsysm. Begin at the first subprogram, since
+	 * bpf_prog_load will add the kallsyms for the main program.
+	 */
+	for (i = 1; i < env->subprog_cnt; i++) {
+		err = bpf_prog_lock_ro(func[i]);
+		if (err)
+			goto out_free;
+	}
+
+	for (i = 1; i < env->subprog_cnt; i++)
+		bpf_prog_kallsyms_add(func[i]);
+
+	/* Last step: make now unused interpreter insns from main
+	 * prog consistent for later dump requests, so they can
+	 * later look the same as if they were interpreted only.
+	 */
+	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
+		if (bpf_pseudo_func(insn)) {
+			insn[0].imm = env->insn_aux_data[i].call_imm;
+			insn[1].imm = insn->off;
+			insn->off = 0;
+			continue;
+		}
+		if (!bpf_pseudo_call(insn))
+			continue;
+		insn->off = env->insn_aux_data[i].call_imm;
+		subprog = bpf_find_subprog(env, i + insn->off + 1);
+		insn->imm = subprog;
+	}
+
+	prog->jited = 1;
+	prog->bpf_func = func[0]->bpf_func;
+	prog->jited_len = func[0]->jited_len;
+	prog->aux->extable = func[0]->aux->extable;
+	prog->aux->num_exentries = func[0]->aux->num_exentries;
+	prog->aux->func = func;
+	prog->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
+	prog->aux->real_func_cnt = env->subprog_cnt;
+	prog->aux->bpf_exception_cb = (void *)func[env->exception_callback_subprog]->bpf_func;
+	prog->aux->exception_boundary = func[0]->aux->exception_boundary;
+	bpf_prog_jit_attempt_done(prog);
+	return 0;
+out_free:
+	/* We failed JIT'ing, so at this point we need to unregister poke
+	 * descriptors from subprogs, so that kernel is not attempting to
+	 * patch it anymore as we're freeing the subprog JIT memory.
+	 */
+	for (i = 0; i < prog->aux->size_poke_tab; i++) {
+		map_ptr = prog->aux->poke_tab[i].tail_call.map;
+		map_ptr->ops->map_poke_untrack(map_ptr, prog->aux);
+	}
+	/* At this point we're guaranteed that poke descriptors are not
+	 * live anymore. We can just unlink its descriptor table as it's
+	 * released with the main prog.
+	 */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		if (!func[i])
+			continue;
+		func[i]->aux->poke_tab = NULL;
+		bpf_jit_free(func[i]);
+	}
+	kfree(func);
+out_undo_insn:
+	/* cleanup main prog to be interpreted */
+	prog->jit_requested = 0;
+	prog->blinding_requested = 0;
+	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
+		if (!bpf_pseudo_call(insn))
+			continue;
+		insn->off = 0;
+		insn->imm = env->insn_aux_data[i].call_imm;
+	}
+	bpf_prog_jit_attempt_done(prog);
+	return err;
+}
+
+int bpf_fixup_call_args(struct bpf_verifier_env *env)
+{
+#ifndef CONFIG_BPF_JIT_ALWAYS_ON
+	struct bpf_prog *prog = env->prog;
+	struct bpf_insn *insn = prog->insnsi;
+	bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
+	int i, depth;
+#endif
+	int err = 0;
+
+	if (env->prog->jit_requested &&
+	    !bpf_prog_is_offloaded(env->prog->aux)) {
+		err = bpf_jit_subprogs(env);
+		if (err == 0)
+			return 0;
+		if (err == -EFAULT)
+			return err;
+	}
+#ifndef CONFIG_BPF_JIT_ALWAYS_ON
+	if (has_kfunc_call) {
+		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
+		return -EINVAL;
+	}
+	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
+		/* When JIT fails the progs with bpf2bpf calls and tail_calls
+		 * have to be rejected, since interpreter doesn't support them yet.
+		 */
+		verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < prog->len; i++, insn++) {
+		if (bpf_pseudo_func(insn)) {
+			/* When JIT fails the progs with callback calls
+			 * have to be rejected, since interpreter doesn't support them yet.
+			 */
+			verbose(env, "callbacks are not allowed in non-JITed programs\n");
+			return -EINVAL;
+		}
+
+		if (!bpf_pseudo_call(insn))
+			continue;
+		depth = get_callee_stack_depth(env, insn, i);
+		if (depth < 0)
+			return depth;
+		bpf_patch_call_args(insn, depth);
+	}
+	err = 0;
+#endif
+	return err;
+}
+
+
+/* The function requires that first instruction in 'patch' is insnsi[prog->len - 1] */
+static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
+{
+	struct bpf_subprog_info *info = env->subprog_info;
+	int cnt = env->subprog_cnt;
+	struct bpf_prog *prog;
+
+	/* We only reserve one slot for hidden subprogs in subprog_info. */
+	if (env->hidden_subprog_cnt) {
+		verifier_bug(env, "only one hidden subprog supported");
+		return -EFAULT;
+	}
+	/* We're not patching any existing instruction, just appending the new
+	 * ones for the hidden subprog. Hence all of the adjustment operations
+	 * in bpf_patch_insn_data are no-ops.
+	 */
+	prog = bpf_patch_insn_data(env, env->prog->len - 1, patch, len);
+	if (!prog)
+		return -ENOMEM;
+	env->prog = prog;
+	info[cnt + 1].start = info[cnt].start;
+	info[cnt].start = prog->len - len + 1;
+	env->subprog_cnt++;
+	env->hidden_subprog_cnt++;
+	return 0;
+}
+
+/* Do various post-verification rewrites in a single program pass.
+ * These rewrites simplify JIT and interpreter implementations.
+ */
+int bpf_do_misc_fixups(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *prog = env->prog;
+	enum bpf_attach_type eatype = prog->expected_attach_type;
+	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+	struct bpf_insn *insn = prog->insnsi;
+	const struct bpf_func_proto *fn;
+	const int insn_cnt = prog->len;
+	const struct bpf_map_ops *ops;
+	struct bpf_insn_aux_data *aux;
+	struct bpf_insn *insn_buf = env->insn_buf;
+	struct bpf_prog *new_prog;
+	struct bpf_map *map_ptr;
+	int i, ret, cnt, delta = 0, cur_subprog = 0;
+	struct bpf_subprog_info *subprogs = env->subprog_info;
+	u16 stack_depth = subprogs[cur_subprog].stack_depth;
+	u16 stack_depth_extra = 0;
+
+	if (env->seen_exception && !env->exception_callback_subprog) {
+		struct bpf_insn *patch = insn_buf;
+
+		*patch++ = env->prog->insnsi[insn_cnt - 1];
+		*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
+		*patch++ = BPF_EXIT_INSN();
+		ret = add_hidden_subprog(env, insn_buf, patch - insn_buf);
+		if (ret < 0)
+			return ret;
+		prog = env->prog;
+		insn = prog->insnsi;
+
+		env->exception_callback_subprog = env->subprog_cnt - 1;
+		/* Don't update insn_cnt, as add_hidden_subprog always appends insns */
+		bpf_mark_subprog_exc_cb(env, env->exception_callback_subprog);
+	}
+
+	for (i = 0; i < insn_cnt;) {
+		if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->imm) {
+			if ((insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1) ||
+			    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV)) {
+				/* convert to 32-bit mov that clears upper 32-bit */
+				insn->code = BPF_ALU | BPF_MOV | BPF_X;
+				/* clear off and imm, so it's a normal 'wX = wY' from JIT pov */
+				insn->off = 0;
+				insn->imm = 0;
+			} /* cast from as(0) to as(1) should be handled by JIT */
+			goto next_insn;
+		}
+
+		if (env->insn_aux_data[i + delta].needs_zext)
+			/* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
+			insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
+
+		/* Make sdiv/smod divide-by-minus-one exceptions impossible. */
+		if ((insn->code == (BPF_ALU64 | BPF_MOD | BPF_K) ||
+		     insn->code == (BPF_ALU64 | BPF_DIV | BPF_K) ||
+		     insn->code == (BPF_ALU | BPF_MOD | BPF_K) ||
+		     insn->code == (BPF_ALU | BPF_DIV | BPF_K)) &&
+		    insn->off == 1 && insn->imm == -1) {
+			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
+			bool isdiv = BPF_OP(insn->code) == BPF_DIV;
+			struct bpf_insn *patch = insn_buf;
+
+			if (isdiv)
+				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+							BPF_NEG | BPF_K, insn->dst_reg,
+							0, 0, 0);
+			else
+				*patch++ = BPF_MOV32_IMM(insn->dst_reg, 0);
+
+			cnt = patch - insn_buf;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Make divide-by-zero and divide-by-minus-one exceptions impossible. */
+		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
+		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
+		    insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
+		    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
+			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
+			bool isdiv = BPF_OP(insn->code) == BPF_DIV;
+			bool is_sdiv = isdiv && insn->off == 1;
+			bool is_smod = !isdiv && insn->off == 1;
+			struct bpf_insn *patch = insn_buf;
+
+			if (is_sdiv) {
+				/* [R,W]x sdiv 0 -> 0
+				 * LLONG_MIN sdiv -1 -> LLONG_MIN
+				 * INT_MIN sdiv -1 -> INT_MIN
+				 */
+				*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
+				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+							BPF_ADD | BPF_K, BPF_REG_AX,
+							0, 0, 1);
+				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+							BPF_JGT | BPF_K, BPF_REG_AX,
+							0, 4, 1);
+				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+							BPF_JEQ | BPF_K, BPF_REG_AX,
+							0, 1, 0);
+				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+							BPF_MOV | BPF_K, insn->dst_reg,
+							0, 0, 0);
+				/* BPF_NEG(LLONG_MIN) == -LLONG_MIN == LLONG_MIN */
+				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+							BPF_NEG | BPF_K, insn->dst_reg,
+							0, 0, 0);
+				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+				*patch++ = *insn;
+				cnt = patch - insn_buf;
+			} else if (is_smod) {
+				/* [R,W]x mod 0 -> [R,W]x */
+				/* [R,W]x mod -1 -> 0 */
+				*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
+				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+							BPF_ADD | BPF_K, BPF_REG_AX,
+							0, 0, 1);
+				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+							BPF_JGT | BPF_K, BPF_REG_AX,
+							0, 3, 1);
+				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+							BPF_JEQ | BPF_K, BPF_REG_AX,
+							0, 3 + (is64 ? 0 : 1), 1);
+				*patch++ = BPF_MOV32_IMM(insn->dst_reg, 0);
+				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+				*patch++ = *insn;
+
+				if (!is64) {
+					*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+					*patch++ = BPF_MOV32_REG(insn->dst_reg, insn->dst_reg);
+				}
+				cnt = patch - insn_buf;
+			} else if (isdiv) {
+				/* [R,W]x div 0 -> 0 */
+				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+							BPF_JNE | BPF_K, insn->src_reg,
+							0, 2, 0);
+				*patch++ = BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg);
+				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+				*patch++ = *insn;
+				cnt = patch - insn_buf;
+			} else {
+				/* [R,W]x mod 0 -> [R,W]x */
+				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+							BPF_JEQ | BPF_K, insn->src_reg,
+							0, 1 + (is64 ? 0 : 1), 0);
+				*patch++ = *insn;
+
+				if (!is64) {
+					*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+					*patch++ = BPF_MOV32_REG(insn->dst_reg, insn->dst_reg);
+				}
+				cnt = patch - insn_buf;
+			}
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Make it impossible to de-reference a userspace address */
+		if (BPF_CLASS(insn->code) == BPF_LDX &&
+		    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+		     BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
+			struct bpf_insn *patch = insn_buf;
+			u64 uaddress_limit = bpf_arch_uaddress_limit();
+
+			if (!uaddress_limit)
+				goto next_insn;
+
+			*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
+			if (insn->off)
+				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, insn->off);
+			*patch++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_AX, 32);
+			*patch++ = BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, uaddress_limit >> 32, 2);
+			*patch++ = *insn;
+			*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+			*patch++ = BPF_MOV64_IMM(insn->dst_reg, 0);
+
+			cnt = patch - insn_buf;
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Implement LD_ABS and LD_IND with a rewrite, if supported by the program type. */
+		if (BPF_CLASS(insn->code) == BPF_LD &&
+		    (BPF_MODE(insn->code) == BPF_ABS ||
+		     BPF_MODE(insn->code) == BPF_IND)) {
+			cnt = env->ops->gen_ld_abs(insn, insn_buf);
+			if (cnt == 0 || cnt >= INSN_BUF_SIZE) {
+				verifier_bug(env, "%d insns generated for ld_abs", cnt);
+				return -EFAULT;
+			}
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Rewrite pointer arithmetic to mitigate speculation attacks. */
+		if (insn->code == (BPF_ALU64 | BPF_ADD | BPF_X) ||
+		    insn->code == (BPF_ALU64 | BPF_SUB | BPF_X)) {
+			const u8 code_add = BPF_ALU64 | BPF_ADD | BPF_X;
+			const u8 code_sub = BPF_ALU64 | BPF_SUB | BPF_X;
+			struct bpf_insn *patch = insn_buf;
+			bool issrc, isneg, isimm;
+			u32 off_reg;
+
+			aux = &env->insn_aux_data[i + delta];
+			if (!aux->alu_state ||
+			    aux->alu_state == BPF_ALU_NON_POINTER)
+				goto next_insn;
+
+			isneg = aux->alu_state & BPF_ALU_NEG_VALUE;
+			issrc = (aux->alu_state & BPF_ALU_SANITIZE) ==
+				BPF_ALU_SANITIZE_SRC;
+			isimm = aux->alu_state & BPF_ALU_IMMEDIATE;
+
+			off_reg = issrc ? insn->src_reg : insn->dst_reg;
+			if (isimm) {
+				*patch++ = BPF_MOV32_IMM(BPF_REG_AX, aux->alu_limit);
+			} else {
+				if (isneg)
+					*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
+				*patch++ = BPF_MOV32_IMM(BPF_REG_AX, aux->alu_limit);
+				*patch++ = BPF_ALU64_REG(BPF_SUB, BPF_REG_AX, off_reg);
+				*patch++ = BPF_ALU64_REG(BPF_OR, BPF_REG_AX, off_reg);
+				*patch++ = BPF_ALU64_IMM(BPF_NEG, BPF_REG_AX, 0);
+				*patch++ = BPF_ALU64_IMM(BPF_ARSH, BPF_REG_AX, 63);
+				*patch++ = BPF_ALU64_REG(BPF_AND, BPF_REG_AX, off_reg);
+			}
+			if (!issrc)
+				*patch++ = BPF_MOV64_REG(insn->dst_reg, insn->src_reg);
+			insn->src_reg = BPF_REG_AX;
+			if (isneg)
+				insn->code = insn->code == code_add ?
+					     code_sub : code_add;
+			*patch++ = *insn;
+			if (issrc && isneg && !isimm)
+				*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
+			cnt = patch - insn_buf;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		if (bpf_is_may_goto_insn(insn) && bpf_jit_supports_timed_may_goto()) {
+			int stack_off_cnt = -stack_depth - 16;
+
+			/*
+			 * Two 8 byte slots, depth-16 stores the count, and
+			 * depth-8 stores the start timestamp of the loop.
+			 *
+			 * The starting value of count is BPF_MAX_TIMED_LOOPS
+			 * (0xffff).  Every iteration loads it and subs it by 1,
+			 * until the value becomes 0 in AX (thus, 1 in stack),
+			 * after which we call arch_bpf_timed_may_goto, which
+			 * either sets AX to 0xffff to keep looping, or to 0
+			 * upon timeout. AX is then stored into the stack. In
+			 * the next iteration, we either see 0 and break out, or
+			 * continue iterating until the next time value is 0
+			 * after subtraction, rinse and repeat.
+			 */
+			stack_depth_extra = 16;
+			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off_cnt);
+			if (insn->off >= 0)
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 5);
+			else
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
+			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
+			insn_buf[3] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
+			/*
+			 * AX is used as an argument to pass in stack_off_cnt
+			 * (to add to r10/fp), and also as the return value of
+			 * the call to arch_bpf_timed_may_goto.
+			 */
+			insn_buf[4] = BPF_MOV64_IMM(BPF_REG_AX, stack_off_cnt);
+			insn_buf[5] = BPF_EMIT_CALL(arch_bpf_timed_may_goto);
+			insn_buf[6] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt);
+			cnt = 7;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta += cnt - 1;
+			env->prog = prog = new_prog;
+			insn = new_prog->insnsi + i + delta;
+			goto next_insn;
+		} else if (bpf_is_may_goto_insn(insn)) {
+			int stack_off = -stack_depth - 8;
+
+			stack_depth_extra = 8;
+			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
+			if (insn->off >= 0)
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 2);
+			else
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
+			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
+			insn_buf[3] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
+			cnt = 4;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta += cnt - 1;
+			env->prog = prog = new_prog;
+			insn = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		if (insn->code != (BPF_JMP | BPF_CALL))
+			goto next_insn;
+		if (insn->src_reg == BPF_PSEUDO_CALL)
+			goto next_insn;
+		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
+			ret = bpf_fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
+			if (ret)
+				return ret;
+			if (cnt == 0)
+				goto next_insn;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta	 += cnt - 1;
+			env->prog = prog = new_prog;
+			insn	  = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Skip inlining the helper call if the JIT does it. */
+		if (bpf_jit_inlines_helper_call(insn->imm))
+			goto next_insn;
+
+		if (insn->imm == BPF_FUNC_get_route_realm)
+			prog->dst_needed = 1;
+		if (insn->imm == BPF_FUNC_get_prandom_u32)
+			bpf_user_rnd_init_once();
+		if (insn->imm == BPF_FUNC_override_return)
+			prog->kprobe_override = 1;
+		if (insn->imm == BPF_FUNC_tail_call) {
+			/* If we tail call into other programs, we
+			 * cannot make any assumptions since they can
+			 * be replaced dynamically during runtime in
+			 * the program array.
+			 */
+			prog->cb_access = 1;
+			if (!bpf_allow_tail_call_in_subprogs(env))
+				prog->aux->stack_depth = MAX_BPF_STACK;
+			prog->aux->max_pkt_offset = MAX_PACKET_OFF;
+
+			/* mark bpf_tail_call as different opcode to avoid
+			 * conditional branch in the interpreter for every normal
+			 * call and to prevent accidental JITing by JIT compiler
+			 * that doesn't support bpf_tail_call yet
+			 */
+			insn->imm = 0;
+			insn->code = BPF_JMP | BPF_TAIL_CALL;
+
+			aux = &env->insn_aux_data[i + delta];
+			if (env->bpf_capable && !prog->blinding_requested &&
+			    prog->jit_requested &&
+			    !bpf_map_key_poisoned(aux) &&
+			    !bpf_map_ptr_poisoned(aux) &&
+			    !bpf_map_ptr_unpriv(aux)) {
+				struct bpf_jit_poke_descriptor desc = {
+					.reason = BPF_POKE_REASON_TAIL_CALL,
+					.tail_call.map = aux->map_ptr_state.map_ptr,
+					.tail_call.key = bpf_map_key_immediate(aux),
+					.insn_idx = i + delta,
+				};
+
+				ret = bpf_jit_add_poke_descriptor(prog, &desc);
+				if (ret < 0) {
+					verbose(env, "adding tail call poke descriptor failed\n");
+					return ret;
+				}
+
+				insn->imm = ret + 1;
+				goto next_insn;
+			}
+
+			if (!bpf_map_ptr_unpriv(aux))
+				goto next_insn;
+
+			/* instead of changing every JIT dealing with tail_call
+			 * emit two extra insns:
+			 * if (index >= max_entries) goto out;
+			 * index &= array->index_mask;
+			 * to avoid out-of-bounds cpu speculation
+			 */
+			if (bpf_map_ptr_poisoned(aux)) {
+				verbose(env, "tail_call abusing map_ptr\n");
+				return -EINVAL;
+			}
+
+			map_ptr = aux->map_ptr_state.map_ptr;
+			insn_buf[0] = BPF_JMP_IMM(BPF_JGE, BPF_REG_3,
+						  map_ptr->max_entries, 2);
+			insn_buf[1] = BPF_ALU32_IMM(BPF_AND, BPF_REG_3,
+						    container_of(map_ptr,
+								 struct bpf_array,
+								 map)->index_mask);
+			insn_buf[2] = *insn;
+			cnt = 3;
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		if (insn->imm == BPF_FUNC_timer_set_callback) {
+			/* The verifier will process callback_fn as many times as necessary
+			 * with different maps and the register states prepared by
+			 * set_timer_callback_state will be accurate.
+			 *
+			 * The following use case is valid:
+			 *   map1 is shared by prog1, prog2, prog3.
+			 *   prog1 calls bpf_timer_init for some map1 elements
+			 *   prog2 calls bpf_timer_set_callback for some map1 elements.
+			 *     Those that were not bpf_timer_init-ed will return -EINVAL.
+			 *   prog3 calls bpf_timer_start for some map1 elements.
+			 *     Those that were not both bpf_timer_init-ed and
+			 *     bpf_timer_set_callback-ed will return -EINVAL.
+			 */
+			struct bpf_insn ld_addrs[2] = {
+				BPF_LD_IMM64(BPF_REG_3, (long)prog->aux),
+			};
+
+			insn_buf[0] = ld_addrs[0];
+			insn_buf[1] = ld_addrs[1];
+			insn_buf[2] = *insn;
+			cnt = 3;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto patch_call_imm;
+		}
+
+		/* bpf_per_cpu_ptr() and bpf_this_cpu_ptr() */
+		if (env->insn_aux_data[i + delta].call_with_percpu_alloc_ptr) {
+			/* patch with 'r1 = *(u64 *)(r1 + 0)' since for percpu data,
+			 * bpf_mem_alloc() returns a ptr to the percpu data ptr.
+			 */
+			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
+			insn_buf[1] = *insn;
+			cnt = 2;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta += cnt - 1;
+			env->prog = prog = new_prog;
+			insn = new_prog->insnsi + i + delta;
+			goto patch_call_imm;
+		}
+
+		/* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
+		 * and other inlining handlers are currently limited to 64 bit
+		 * only.
+		 */
+		if (prog->jit_requested && BITS_PER_LONG == 64 &&
+		    (insn->imm == BPF_FUNC_map_lookup_elem ||
+		     insn->imm == BPF_FUNC_map_update_elem ||
+		     insn->imm == BPF_FUNC_map_delete_elem ||
+		     insn->imm == BPF_FUNC_map_push_elem   ||
+		     insn->imm == BPF_FUNC_map_pop_elem    ||
+		     insn->imm == BPF_FUNC_map_peek_elem   ||
+		     insn->imm == BPF_FUNC_redirect_map    ||
+		     insn->imm == BPF_FUNC_for_each_map_elem ||
+		     insn->imm == BPF_FUNC_map_lookup_percpu_elem)) {
+			aux = &env->insn_aux_data[i + delta];
+			if (bpf_map_ptr_poisoned(aux))
+				goto patch_call_imm;
+
+			map_ptr = aux->map_ptr_state.map_ptr;
+			ops = map_ptr->ops;
+			if (insn->imm == BPF_FUNC_map_lookup_elem &&
+			    ops->map_gen_lookup) {
+				cnt = ops->map_gen_lookup(map_ptr, insn_buf);
+				if (cnt == -EOPNOTSUPP)
+					goto patch_map_ops_generic;
+				if (cnt <= 0 || cnt >= INSN_BUF_SIZE) {
+					verifier_bug(env, "%d insns generated for map lookup", cnt);
+					return -EFAULT;
+				}
+
+				new_prog = bpf_patch_insn_data(env, i + delta,
+							       insn_buf, cnt);
+				if (!new_prog)
+					return -ENOMEM;
+
+				delta    += cnt - 1;
+				env->prog = prog = new_prog;
+				insn      = new_prog->insnsi + i + delta;
+				goto next_insn;
+			}
+
+			BUILD_BUG_ON(!__same_type(ops->map_lookup_elem,
+				     (void *(*)(struct bpf_map *map, void *key))NULL));
+			BUILD_BUG_ON(!__same_type(ops->map_delete_elem,
+				     (long (*)(struct bpf_map *map, void *key))NULL));
+			BUILD_BUG_ON(!__same_type(ops->map_update_elem,
+				     (long (*)(struct bpf_map *map, void *key, void *value,
+					      u64 flags))NULL));
+			BUILD_BUG_ON(!__same_type(ops->map_push_elem,
+				     (long (*)(struct bpf_map *map, void *value,
+					      u64 flags))NULL));
+			BUILD_BUG_ON(!__same_type(ops->map_pop_elem,
+				     (long (*)(struct bpf_map *map, void *value))NULL));
+			BUILD_BUG_ON(!__same_type(ops->map_peek_elem,
+				     (long (*)(struct bpf_map *map, void *value))NULL));
+			BUILD_BUG_ON(!__same_type(ops->map_redirect,
+				     (long (*)(struct bpf_map *map, u64 index, u64 flags))NULL));
+			BUILD_BUG_ON(!__same_type(ops->map_for_each_callback,
+				     (long (*)(struct bpf_map *map,
+					      bpf_callback_t callback_fn,
+					      void *callback_ctx,
+					      u64 flags))NULL));
+			BUILD_BUG_ON(!__same_type(ops->map_lookup_percpu_elem,
+				     (void *(*)(struct bpf_map *map, void *key, u32 cpu))NULL));
+
+patch_map_ops_generic:
+			switch (insn->imm) {
+			case BPF_FUNC_map_lookup_elem:
+				insn->imm = BPF_CALL_IMM(ops->map_lookup_elem);
+				goto next_insn;
+			case BPF_FUNC_map_update_elem:
+				insn->imm = BPF_CALL_IMM(ops->map_update_elem);
+				goto next_insn;
+			case BPF_FUNC_map_delete_elem:
+				insn->imm = BPF_CALL_IMM(ops->map_delete_elem);
+				goto next_insn;
+			case BPF_FUNC_map_push_elem:
+				insn->imm = BPF_CALL_IMM(ops->map_push_elem);
+				goto next_insn;
+			case BPF_FUNC_map_pop_elem:
+				insn->imm = BPF_CALL_IMM(ops->map_pop_elem);
+				goto next_insn;
+			case BPF_FUNC_map_peek_elem:
+				insn->imm = BPF_CALL_IMM(ops->map_peek_elem);
+				goto next_insn;
+			case BPF_FUNC_redirect_map:
+				insn->imm = BPF_CALL_IMM(ops->map_redirect);
+				goto next_insn;
+			case BPF_FUNC_for_each_map_elem:
+				insn->imm = BPF_CALL_IMM(ops->map_for_each_callback);
+				goto next_insn;
+			case BPF_FUNC_map_lookup_percpu_elem:
+				insn->imm = BPF_CALL_IMM(ops->map_lookup_percpu_elem);
+				goto next_insn;
+			}
+
+			goto patch_call_imm;
+		}
+
+		/* Implement bpf_jiffies64 inline. */
+		if (prog->jit_requested && BITS_PER_LONG == 64 &&
+		    insn->imm == BPF_FUNC_jiffies64) {
+			struct bpf_insn ld_jiffies_addr[2] = {
+				BPF_LD_IMM64(BPF_REG_0,
+					     (unsigned long)&jiffies),
+			};
+
+			insn_buf[0] = ld_jiffies_addr[0];
+			insn_buf[1] = ld_jiffies_addr[1];
+			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0,
+						  BPF_REG_0, 0);
+			cnt = 3;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
+						       cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
+		/* Implement bpf_get_smp_processor_id() inline. */
+		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
+		    bpf_verifier_inlines_helper_call(env, insn->imm)) {
+			/* BPF_FUNC_get_smp_processor_id inlining is an
+			 * optimization, so if cpu_number is ever
+			 * changed in some incompatible and hard to support
+			 * way, it's fine to back out this inlining logic
+			 */
+#ifdef CONFIG_SMP
+			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&cpu_number);
+			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
+			cnt = 3;
+#else
+			insn_buf[0] = BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0);
+			cnt = 1;
+#endif
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Implement bpf_get_current_task() and bpf_get_current_task_btf() inline. */
+		if ((insn->imm == BPF_FUNC_get_current_task || insn->imm == BPF_FUNC_get_current_task_btf) &&
+		    bpf_verifier_inlines_helper_call(env, insn->imm)) {
+			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&current_task);
+			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
+			cnt = 3;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+#endif
+		/* Implement bpf_get_func_arg inline. */
+		if (prog_type == BPF_PROG_TYPE_TRACING &&
+		    insn->imm == BPF_FUNC_get_func_arg) {
+			if (eatype == BPF_TRACE_RAW_TP) {
+				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
+
+				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
+				cnt = 1;
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+				cnt = 2;
+			}
+			insn_buf[cnt++] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
+			insn_buf[cnt++] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
+			insn_buf[cnt++] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
+			insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
+			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
+			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+			insn_buf[cnt++] = BPF_JMP_A(1);
+			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Implement bpf_get_func_ret inline. */
+		if (prog_type == BPF_PROG_TYPE_TRACING &&
+		    insn->imm == BPF_FUNC_get_func_ret) {
+			if (eatype == BPF_TRACE_FEXIT ||
+			    eatype == BPF_TRACE_FSESSION ||
+			    eatype == BPF_MODIFY_RETURN) {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+				insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
+				insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
+				insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
+				insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
+				cnt = 7;
+			} else {
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
+				cnt = 1;
+			}
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Implement get_func_arg_cnt inline. */
+		if (prog_type == BPF_PROG_TYPE_TRACING &&
+		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
+			if (eatype == BPF_TRACE_RAW_TP) {
+				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
+
+				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
+				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
+				cnt = 1;
+			} else {
+				/* Load nr_args from ctx - 8 */
+				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+				cnt = 2;
+			}
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Implement bpf_get_func_ip inline. */
+		if (prog_type == BPF_PROG_TYPE_TRACING &&
+		    insn->imm == BPF_FUNC_get_func_ip) {
+			/* Load IP address from ctx - 16 */
+			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -16);
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
+			if (!new_prog)
+				return -ENOMEM;
+
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Implement bpf_get_branch_snapshot inline. */
+		if (IS_ENABLED(CONFIG_PERF_EVENTS) &&
+		    prog->jit_requested && BITS_PER_LONG == 64 &&
+		    insn->imm == BPF_FUNC_get_branch_snapshot) {
+			/* We are dealing with the following func protos:
+			 * u64 bpf_get_branch_snapshot(void *buf, u32 size, u64 flags);
+			 * int perf_snapshot_branch_stack(struct perf_branch_entry *entries, u32 cnt);
+			 */
+			const u32 br_entry_size = sizeof(struct perf_branch_entry);
+
+			/* struct perf_branch_entry is part of UAPI and is
+			 * used as an array element, so extremely unlikely to
+			 * ever grow or shrink
+			 */
+			BUILD_BUG_ON(br_entry_size != 24);
+
+			/* if (unlikely(flags)) return -EINVAL */
+			insn_buf[0] = BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 0, 7);
+
+			/* Transform size (bytes) into number of entries (cnt = size / 24).
+			 * But to avoid expensive division instruction, we implement
+			 * divide-by-3 through multiplication, followed by further
+			 * division by 8 through 3-bit right shift.
+			 * Refer to book "Hacker's Delight, 2nd ed." by Henry S. Warren, Jr.,
+			 * p. 227, chapter "Unsigned Division by 3" for details and proofs.
+			 *
+			 * N / 3 <=> M * N / 2^33, where M = (2^33 + 1) / 3 = 0xaaaaaaab.
+			 */
+			insn_buf[1] = BPF_MOV32_IMM(BPF_REG_0, 0xaaaaaaab);
+			insn_buf[2] = BPF_ALU64_REG(BPF_MUL, BPF_REG_2, BPF_REG_0);
+			insn_buf[3] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_2, 36);
+
+			/* call perf_snapshot_branch_stack implementation */
+			insn_buf[4] = BPF_EMIT_CALL(static_call_query(perf_snapshot_branch_stack));
+			/* if (entry_cnt == 0) return -ENOENT */
+			insn_buf[5] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4);
+			/* return entry_cnt * sizeof(struct perf_branch_entry) */
+			insn_buf[6] = BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, br_entry_size);
+			insn_buf[7] = BPF_JMP_A(3);
+			/* return -EINVAL; */
+			insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
+			insn_buf[9] = BPF_JMP_A(1);
+			/* return -ENOENT; */
+			insn_buf[10] = BPF_MOV64_IMM(BPF_REG_0, -ENOENT);
+			cnt = 11;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Implement bpf_kptr_xchg inline */
+		if (prog->jit_requested && BITS_PER_LONG == 64 &&
+		    insn->imm == BPF_FUNC_kptr_xchg &&
+		    bpf_jit_supports_ptr_xchg()) {
+			insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
+			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
+			cnt = 2;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+patch_call_imm:
+		fn = env->ops->get_func_proto(insn->imm, env->prog);
+		/* all functions that have prototype and verifier allowed
+		 * programs to call them, must be real in-kernel functions
+		 */
+		if (!fn->func) {
+			verifier_bug(env,
+				     "not inlined functions %s#%d is missing func",
+				     func_id_name(insn->imm), insn->imm);
+			return -EFAULT;
+		}
+		insn->imm = fn->func - __bpf_call_base;
+next_insn:
+		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
+			subprogs[cur_subprog].stack_depth += stack_depth_extra;
+			subprogs[cur_subprog].stack_extra = stack_depth_extra;
+
+			stack_depth = subprogs[cur_subprog].stack_depth;
+			if (stack_depth > MAX_BPF_STACK && !prog->jit_requested) {
+				verbose(env, "stack size %d(extra %d) is too large\n",
+					stack_depth, stack_depth_extra);
+				return -EINVAL;
+			}
+			cur_subprog++;
+			stack_depth = subprogs[cur_subprog].stack_depth;
+			stack_depth_extra = 0;
+		}
+		i++;
+		insn++;
+	}
+
+	env->prog->aux->stack_depth = subprogs[0].stack_depth;
+	for (i = 0; i < env->subprog_cnt; i++) {
+		int delta = bpf_jit_supports_timed_may_goto() ? 2 : 1;
+		int subprog_start = subprogs[i].start;
+		int stack_slots = subprogs[i].stack_extra / 8;
+		int slots = delta, cnt = 0;
+
+		if (!stack_slots)
+			continue;
+		/* We need two slots in case timed may_goto is supported. */
+		if (stack_slots > slots) {
+			verifier_bug(env, "stack_slots supports may_goto only");
+			return -EFAULT;
+		}
+
+		stack_depth = subprogs[i].stack_depth;
+		if (bpf_jit_supports_timed_may_goto()) {
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
+						     BPF_MAX_TIMED_LOOPS);
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth + 8, 0);
+		} else {
+			/* Add ST insn to subprog prologue to init extra stack */
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
+						     BPF_MAX_LOOPS);
+		}
+		/* Copy first actual insn to preserve it */
+		insn_buf[cnt++] = env->prog->insnsi[subprog_start];
+
+		new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, cnt);
+		if (!new_prog)
+			return -ENOMEM;
+		env->prog = prog = new_prog;
+		/*
+		 * If may_goto is a first insn of a prog there could be a jmp
+		 * insn that points to it, hence adjust all such jmps to point
+		 * to insn after BPF_ST that inits may_goto count.
+		 * Adjustment will succeed because bpf_patch_insn_data() didn't fail.
+		 */
+		WARN_ON(adjust_jmp_off(env->prog, subprog_start, delta));
+	}
+
+	/* Since poke tab is now finalized, publish aux to tracker. */
+	for (i = 0; i < prog->aux->size_poke_tab; i++) {
+		map_ptr = prog->aux->poke_tab[i].tail_call.map;
+		if (!map_ptr->ops->map_poke_track ||
+		    !map_ptr->ops->map_poke_untrack ||
+		    !map_ptr->ops->map_poke_run) {
+			verifier_bug(env, "poke tab is misconfigured");
+			return -EFAULT;
+		}
+
+		ret = map_ptr->ops->map_poke_track(map_ptr, prog->aux);
+		if (ret < 0) {
+			verbose(env, "tracking tail call prog failed\n");
+			return ret;
+		}
+	}
+
+	ret = sort_kfunc_descs_by_imm_off(env);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
+					int position,
+					s32 stack_base,
+					u32 callback_subprogno,
+					u32 *total_cnt)
+{
+	s32 r6_offset = stack_base + 0 * BPF_REG_SIZE;
+	s32 r7_offset = stack_base + 1 * BPF_REG_SIZE;
+	s32 r8_offset = stack_base + 2 * BPF_REG_SIZE;
+	int reg_loop_max = BPF_REG_6;
+	int reg_loop_cnt = BPF_REG_7;
+	int reg_loop_ctx = BPF_REG_8;
+
+	struct bpf_insn *insn_buf = env->insn_buf;
+	struct bpf_prog *new_prog;
+	u32 callback_start;
+	u32 call_insn_offset;
+	s32 callback_offset;
+	u32 cnt = 0;
+
+	/* This represents an inlined version of bpf_iter.c:bpf_loop,
+	 * be careful to modify this code in sync.
+	 */
+
+	/* Return error and jump to the end of the patch if
+	 * expected number of iterations is too big.
+	 */
+	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);
+	insn_buf[cnt++] = BPF_MOV32_IMM(BPF_REG_0, -E2BIG);
+	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JA, 0, 0, 16);
+	/* spill R6, R7, R8 to use these as loop vars */
+	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset);
+	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset);
+	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset);
+	/* initialize loop vars */
+	insn_buf[cnt++] = BPF_MOV64_REG(reg_loop_max, BPF_REG_1);
+	insn_buf[cnt++] = BPF_MOV32_IMM(reg_loop_cnt, 0);
+	insn_buf[cnt++] = BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3);
+	/* loop header,
+	 * if reg_loop_cnt >= reg_loop_max skip the loop body
+	 */
+	insn_buf[cnt++] = BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5);
+	/* callback call,
+	 * correct callback offset would be set after patching
+	 */
+	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt);
+	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx);
+	insn_buf[cnt++] = BPF_CALL_REL(0);
+	/* increment loop counter */
+	insn_buf[cnt++] = BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1);
+	/* jump to loop header if callback returned 0 */
+	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -6);
+	/* return value of bpf_loop,
+	 * set R0 to the number of iterations
+	 */
+	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_0, reg_loop_cnt);
+	/* restore original values of R6, R7, R8 */
+	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset);
+	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset);
+	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
+
+	*total_cnt = cnt;
+	new_prog = bpf_patch_insn_data(env, position, insn_buf, cnt);
+	if (!new_prog)
+		return new_prog;
+
+	/* callback start is known only after patching */
+	callback_start = env->subprog_info[callback_subprogno].start;
+	/* Note: insn_buf[12] is an offset of BPF_CALL_REL instruction */
+	call_insn_offset = position + 12;
+	callback_offset = callback_start - call_insn_offset - 1;
+	new_prog->insnsi[call_insn_offset].imm = callback_offset;
+
+	return new_prog;
+}
+
+static bool is_bpf_loop_call(struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL) &&
+		insn->src_reg == 0 &&
+		insn->imm == BPF_FUNC_loop;
+}
+
+/* For all sub-programs in the program (including main) check
+ * insn_aux_data to see if there are bpf_loop calls that require
+ * inlining. If such calls are found the calls are replaced with a
+ * sequence of instructions produced by `inline_bpf_loop` function and
+ * subprog stack_depth is increased by the size of 3 registers.
+ * This stack space is used to spill values of the R6, R7, R8.  These
+ * registers are used to store the loop bound, counter and context
+ * variables.
+ */
+int bpf_optimize_bpf_loop(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *subprogs = env->subprog_info;
+	int i, cur_subprog = 0, cnt, delta = 0;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int insn_cnt = env->prog->len;
+	u16 stack_depth = subprogs[cur_subprog].stack_depth;
+	u16 stack_depth_roundup = round_up(stack_depth, 8) - stack_depth;
+	u16 stack_depth_extra = 0;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		struct bpf_loop_inline_state *inline_state =
+			&env->insn_aux_data[i + delta].loop_inline_state;
+
+		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) {
+			struct bpf_prog *new_prog;
+
+			stack_depth_extra = BPF_REG_SIZE * 3 + stack_depth_roundup;
+			new_prog = inline_bpf_loop(env,
+						   i + delta,
+						   -(stack_depth + stack_depth_extra),
+						   inline_state->callback_subprogno,
+						   &cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta     += cnt - 1;
+			env->prog  = new_prog;
+			insn       = new_prog->insnsi + i + delta;
+		}
+
+		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
+			subprogs[cur_subprog].stack_depth += stack_depth_extra;
+			cur_subprog++;
+			stack_depth = subprogs[cur_subprog].stack_depth;
+			stack_depth_roundup = round_up(stack_depth, 8) - stack_depth;
+			stack_depth_extra = 0;
+		}
+	}
+
+	env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
+
+	return 0;
+}
+
+/* Remove unnecessary spill/fill pairs, members of fastcall pattern,
+ * adjust subprograms stack depth when possible.
+ */
+int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *subprog = env->subprog_info;
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int insn_cnt = env->prog->len;
+	u32 spills_num;
+	bool modified = false;
+	int i, j;
+
+	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (aux[i].fastcall_spills_num > 0) {
+			spills_num = aux[i].fastcall_spills_num;
+			/* NOPs would be removed by opt_remove_nops() */
+			for (j = 1; j <= spills_num; ++j) {
+				*(insn - j) = NOP;
+				*(insn + j) = NOP;
+			}
+			modified = true;
+		}
+		if ((subprog + 1)->start == i + 1) {
+			if (modified && !subprog->keep_fastcall_stack)
+				subprog->stack_depth = -subprog->fastcall_stack_off;
+			subprog++;
+			modified = false;
+		}
+	}
+
+	return 0;
+}
+
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 967e132f2662..31e03aa6b070 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -195,9 +195,6 @@ struct bpf_verifier_stack_elem {
 #define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
 #define BPF_COMPLEXITY_LIMIT_STATES	64
 
-#define BPF_MAP_KEY_POISON	(1ULL << 63)
-#define BPF_MAP_KEY_SEEN	(1ULL << 62)
-
 #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
 
 #define BPF_PRIV_STACK_MIN_SIZE		64
@@ -215,16 +212,6 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
 static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg);
 
-static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
-{
-	return aux->map_ptr_state.poison;
-}
-
-static bool bpf_map_ptr_unpriv(const struct bpf_insn_aux_data *aux)
-{
-	return aux->map_ptr_state.unpriv;
-}
-
 static void bpf_map_ptr_store(struct bpf_insn_aux_data *aux,
 			      struct bpf_map *map,
 			      bool unpriv, bool poison)
@@ -235,21 +222,6 @@ static void bpf_map_ptr_store(struct bpf_insn_aux_data *aux,
 	aux->map_ptr_state.map_ptr = map;
 }
 
-static bool bpf_map_key_poisoned(const struct bpf_insn_aux_data *aux)
-{
-	return aux->map_key_state & BPF_MAP_KEY_POISON;
-}
-
-static bool bpf_map_key_unseen(const struct bpf_insn_aux_data *aux)
-{
-	return !(aux->map_key_state & BPF_MAP_KEY_SEEN);
-}
-
-static u64 bpf_map_key_immediate(const struct bpf_insn_aux_data *aux)
-{
-	return aux->map_key_state & ~(BPF_MAP_KEY_SEEN | BPF_MAP_KEY_POISON);
-}
-
 static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 {
 	bool poisoned = bpf_map_key_poisoned(aux);
@@ -464,7 +436,7 @@ static const char *subprog_name(const struct bpf_verifier_env *env, int subprog)
 	return btf_type_name(env->prog->aux->btf, info->type_id);
 }
 
-static void mark_subprog_exc_cb(struct bpf_verifier_env *env, int subprog)
+void bpf_mark_subprog_exc_cb(struct bpf_verifier_env *env, int subprog)
 {
 	struct bpf_subprog_info *info = subprog_info(env, subprog);
 
@@ -604,13 +576,6 @@ static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
 	return ref_obj_uses > 1;
 }
 
-static bool is_cmpxchg_insn(const struct bpf_insn *insn)
-{
-	return BPF_CLASS(insn->code) == BPF_STX &&
-	       BPF_MODE(insn->code) == BPF_ATOMIC &&
-	       insn->imm == BPF_CMPXCHG;
-}
-
 static bool is_atomic_load_insn(const struct bpf_insn *insn)
 {
 	return BPF_CLASS(insn->code) == BPF_STX &&
@@ -3062,12 +3027,6 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 }
 
 
-enum reg_arg_type {
-	SRC_OP,		/* register is used as source operand */
-	DST_OP,		/* register is used as destination operand */
-	DST_OP_NO_MARK	/* same as above, check only, don't mark */
-};
-
 static int cmp_subprogs(const void *a, const void *b)
 {
 	return ((struct bpf_subprog_info *)a)->start -
@@ -3191,41 +3150,19 @@ static int bpf_find_exception_callback_insn_off(struct bpf_verifier_env *env)
 	return ret;
 }
 
-#define MAX_KFUNC_DESCS 256
 #define MAX_KFUNC_BTFS	256
 
-struct bpf_kfunc_desc {
-	struct btf_func_model func_model;
-	u32 func_id;
-	s32 imm;
-	u16 offset;
-	unsigned long addr;
-};
-
 struct bpf_kfunc_btf {
 	struct btf *btf;
 	struct module *module;
 	u16 offset;
 };
 
-struct bpf_kfunc_desc_tab {
-	/* Sorted by func_id (BTF ID) and offset (fd_array offset) during
-	 * verification. JITs do lookups by bpf_insn, where func_id may not be
-	 * available, therefore at the end of verification do_misc_fixups()
-	 * sorts this by imm and offset.
-	 */
-	struct bpf_kfunc_desc descs[MAX_KFUNC_DESCS];
-	u32 nr_descs;
-};
-
 struct bpf_kfunc_btf_tab {
 	struct bpf_kfunc_btf descs[MAX_KFUNC_BTFS];
 	u32 nr_descs;
 };
 
-static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc,
-			    int insn_idx);
-
 static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
 {
 	const struct bpf_kfunc_desc *d0 = a;
@@ -3453,7 +3390,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
+int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 {
 	struct bpf_kfunc_btf_tab *btf_tab;
 	struct btf_func_model func_model;
@@ -3548,95 +3485,11 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 	return 0;
 }
 
-static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
-{
-	const struct bpf_kfunc_desc *d0 = a;
-	const struct bpf_kfunc_desc *d1 = b;
-
-	if (d0->imm != d1->imm)
-		return d0->imm < d1->imm ? -1 : 1;
-	if (d0->offset != d1->offset)
-		return d0->offset < d1->offset ? -1 : 1;
-	return 0;
-}
-
-static int set_kfunc_desc_imm(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
-{
-	unsigned long call_imm;
-
-	if (bpf_jit_supports_far_kfunc_call()) {
-		call_imm = desc->func_id;
-	} else {
-		call_imm = BPF_CALL_IMM(desc->addr);
-		/* Check whether the relative offset overflows desc->imm */
-		if ((unsigned long)(s32)call_imm != call_imm) {
-			verbose(env, "address of kernel func_id %u is out of range\n",
-				desc->func_id);
-			return -EINVAL;
-		}
-	}
-	desc->imm = call_imm;
-	return 0;
-}
-
-static int sort_kfunc_descs_by_imm_off(struct bpf_verifier_env *env)
-{
-	struct bpf_kfunc_desc_tab *tab;
-	int i, err;
-
-	tab = env->prog->aux->kfunc_tab;
-	if (!tab)
-		return 0;
-
-	for (i = 0; i < tab->nr_descs; i++) {
-		err = set_kfunc_desc_imm(env, &tab->descs[i]);
-		if (err)
-			return err;
-	}
-
-	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
-	     kfunc_desc_cmp_by_imm_off, NULL);
-	return 0;
-}
-
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
 {
 	return !!prog->aux->kfunc_tab;
 }
 
-const struct btf_func_model *
-bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
-			 const struct bpf_insn *insn)
-{
-	const struct bpf_kfunc_desc desc = {
-		.imm = insn->imm,
-		.offset = insn->off,
-	};
-	const struct bpf_kfunc_desc *res;
-	struct bpf_kfunc_desc_tab *tab;
-
-	tab = prog->aux->kfunc_tab;
-	res = bsearch(&desc, tab->descs, tab->nr_descs,
-		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm_off);
-
-	return res ? &res->func_model : NULL;
-}
-
-static int add_kfunc_in_insns(struct bpf_verifier_env *env,
-			      struct bpf_insn *insn, int cnt)
-{
-	int i, ret;
-
-	for (i = 0; i < cnt; i++, insn++) {
-		if (bpf_pseudo_kfunc_call(insn)) {
-			ret = add_kfunc_call(env, insn->imm, insn->off);
-			if (ret < 0)
-				return ret;
-		}
-	}
-	return 0;
-}
-
 static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
@@ -3661,7 +3514,7 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 		if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn))
 			ret = add_subprog(env, i + insn->imm + 1);
 		else
-			ret = add_kfunc_call(env, insn->imm, insn->off);
+			ret = bpf_add_kfunc_call(env, insn->imm, insn->off);
 
 		if (ret < 0)
 			return ret;
@@ -3683,7 +3536,7 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 			if (env->subprog_info[i].start != ex_cb_insn)
 				continue;
 			env->exception_callback_subprog = i;
-			mark_subprog_exc_cb(env, i);
+			bpf_mark_subprog_exc_cb(env, i);
 			break;
 		}
 	}
@@ -3894,8 +3747,8 @@ static int mark_irq_flag_read(struct bpf_verifier_env *env, struct bpf_reg_state
  * code only. It returns TRUE if the source or destination register operates
  * on 64-bit, otherwise return FALSE.
  */
-static bool is_reg64(struct bpf_insn *insn,
-		     u32 regno, struct bpf_reg_state *reg, enum reg_arg_type t)
+bool bpf_is_reg64(struct bpf_insn *insn,
+	      u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t)
 {
 	u8 code, class, op;
 
@@ -3980,41 +3833,6 @@ static bool is_reg64(struct bpf_insn *insn,
 	return true;
 }
 
-/* Return the regno defined by the insn, or -1. */
-static int insn_def_regno(const struct bpf_insn *insn)
-{
-	switch (BPF_CLASS(insn->code)) {
-	case BPF_JMP:
-	case BPF_JMP32:
-	case BPF_ST:
-		return -1;
-	case BPF_STX:
-		if (BPF_MODE(insn->code) == BPF_ATOMIC ||
-		    BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
-			if (insn->imm == BPF_CMPXCHG)
-				return BPF_REG_0;
-			else if (insn->imm == BPF_LOAD_ACQ)
-				return insn->dst_reg;
-			else if (insn->imm & BPF_FETCH)
-				return insn->src_reg;
-		}
-		return -1;
-	default:
-		return insn->dst_reg;
-	}
-}
-
-/* Return TRUE if INSN has defined any 32-bit value explicitly. */
-static bool insn_has_def32(struct bpf_insn *insn)
-{
-	int dst_reg = insn_def_regno(insn);
-
-	if (dst_reg == -1)
-		return false;
-
-	return !is_reg64(insn, dst_reg, NULL, DST_OP);
-}
-
 static void mark_insn_zext(struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg)
 {
@@ -4029,7 +3847,7 @@ static void mark_insn_zext(struct bpf_verifier_env *env,
 }
 
 static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *regs, u32 regno,
-			   enum reg_arg_type t)
+			   enum bpf_reg_arg_type t)
 {
 	struct bpf_insn *insn = env->prog->insnsi + env->insn_idx;
 	struct bpf_reg_state *reg;
@@ -4038,7 +3856,7 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 	mark_reg_scratched(env, regno);
 
 	reg = &regs[regno];
-	rw64 = is_reg64(insn, regno, reg, t);
+	rw64 = bpf_is_reg64(insn, regno, reg, t);
 	if (t == SRC_OP) {
 		/* check whether register used as source operand can be read */
 		if (reg->type == NOT_INIT) {
@@ -4067,7 +3885,7 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 }
 
 static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
-			 enum reg_arg_type t)
+			 enum bpf_reg_arg_type t)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
@@ -6407,11 +6225,9 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 	return 0;
 }
 
-#define MAX_PACKET_OFF 0xffff
-
 static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
-				       const struct bpf_call_arg_meta *meta,
-				       enum bpf_access_type t)
+			       const struct bpf_call_arg_meta *meta,
+			       enum bpf_access_type t)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 
@@ -7103,19 +6919,6 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 	return 0;
 }
 
-#ifndef CONFIG_BPF_JIT_ALWAYS_ON
-static int get_callee_stack_depth(struct bpf_verifier_env *env,
-				  const struct bpf_insn *insn, int idx)
-{
-	int start = idx + insn->imm + 1, subprog;
-
-	subprog = bpf_find_subprog(env, start);
-	if (verifier_bug_if(subprog < 0, env, "get stack depth: no program at insn %d", start))
-		return -EFAULT;
-	return env->subprog_info[subprog].stack_depth;
-}
-#endif
-
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
@@ -10351,7 +10154,7 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 	return false;
 }
 
-static bool allow_tail_call_in_subprogs(struct bpf_verifier_env *env)
+bool bpf_allow_tail_call_in_subprogs(struct bpf_verifier_env *env)
 {
 	return env->prog->jit_requested &&
 	       bpf_jit_supports_subprog_tailcalls();
@@ -10496,7 +10299,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_FUNC_tail_call:
 		if (map->map_type != BPF_MAP_TYPE_PROG_ARRAY)
 			goto error;
-		if (env->subprog_cnt > 1 && !allow_tail_call_in_subprogs(env)) {
+		if (env->subprog_cnt > 1 && !bpf_allow_tail_call_in_subprogs(env)) {
 			verbose(env, "mixing of tail_calls and bpf-to-bpf calls is not supported\n");
 			return -EINVAL;
 		}
@@ -18733,7 +18536,7 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
  * replacement patch is presumed to follow bpf_fastcall contract
  * (see mark_fastcall_pattern_for_call() below).
  */
-static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
+bool bpf_verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 {
 	switch (imm) {
 #ifdef CONFIG_X86_64
@@ -18765,7 +18568,7 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			/* error would be reported later */
 			return false;
 		cs->fastcall = fn->allow_fastcall &&
-			       (verifier_inlines_helper_call(env, call->imm) ||
+			       (bpf_verifier_inlines_helper_call(env, call->imm) ||
 				bpf_jit_inlines_helper_call(call->imm));
 		cs->is_void = fn->ret_type == RET_VOID;
 		cs->num_params = 0;
@@ -22555,53 +22358,6 @@ static void convert_pseudo_ld_imm64(struct bpf_verifier_env *env)
 	}
 }
 
-/* single env->prog->insni[off] instruction was replaced with the range
- * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
- * [0, off) and [off, end) to new locations, so the patched range stays zero
- */
-static void adjust_insn_aux_data(struct bpf_verifier_env *env,
-				 struct bpf_prog *new_prog, u32 off, u32 cnt)
-{
-	struct bpf_insn_aux_data *data = env->insn_aux_data;
-	struct bpf_insn *insn = new_prog->insnsi;
-	u32 old_seen = data[off].seen;
-	u32 prog_len;
-	int i;
-
-	/* aux info at OFF always needs adjustment, no matter fast path
-	 * (cnt == 1) is taken or not. There is no guarantee INSN at OFF is the
-	 * original insn at old prog.
-	 */
-	data[off].zext_dst = insn_has_def32(insn + off + cnt - 1);
-
-	if (cnt == 1)
-		return;
-	prog_len = new_prog->len;
-
-	memmove(data + off + cnt - 1, data + off,
-		sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
-	memset(data + off, 0, sizeof(struct bpf_insn_aux_data) * (cnt - 1));
-	for (i = off; i < off + cnt - 1; i++) {
-		/* Expand insni[off]'s seen count to the patched range. */
-		data[i].seen = old_seen;
-		data[i].zext_dst = insn_has_def32(insn + i);
-	}
-}
-
-static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len)
-{
-	int i;
-
-	if (len == 1)
-		return;
-	/* NOTE: fake 'exit' subprog should be updated as well. */
-	for (i = 0; i <= env->subprog_cnt; i++) {
-		if (env->subprog_info[i].start <= off)
-			continue;
-		env->subprog_info[i].start += len - 1;
-	}
-}
-
 static void release_insn_arrays(struct bpf_verifier_env *env)
 {
 	int i;
@@ -22610,281 +22366,7 @@ static void release_insn_arrays(struct bpf_verifier_env *env)
 		bpf_insn_array_release(env->insn_array_maps[i]);
 }
 
-static void adjust_insn_arrays(struct bpf_verifier_env *env, u32 off, u32 len)
-{
-	int i;
-
-	if (len == 1)
-		return;
-
-	for (i = 0; i < env->insn_array_map_cnt; i++)
-		bpf_insn_array_adjust(env->insn_array_maps[i], off, len);
-}
-
-static void adjust_insn_arrays_after_remove(struct bpf_verifier_env *env, u32 off, u32 len)
-{
-	int i;
-
-	for (i = 0; i < env->insn_array_map_cnt; i++)
-		bpf_insn_array_adjust_after_remove(env->insn_array_maps[i], off, len);
-}
-
-static void adjust_poke_descs(struct bpf_prog *prog, u32 off, u32 len)
-{
-	struct bpf_jit_poke_descriptor *tab = prog->aux->poke_tab;
-	int i, sz = prog->aux->size_poke_tab;
-	struct bpf_jit_poke_descriptor *desc;
-
-	for (i = 0; i < sz; i++) {
-		desc = &tab[i];
-		if (desc->insn_idx <= off)
-			continue;
-		desc->insn_idx += len - 1;
-	}
-}
-
-static struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
-					    const struct bpf_insn *patch, u32 len)
-{
-	struct bpf_prog *new_prog;
-	struct bpf_insn_aux_data *new_data = NULL;
-
-	if (len > 1) {
-		new_data = vrealloc(env->insn_aux_data,
-				    array_size(env->prog->len + len - 1,
-					       sizeof(struct bpf_insn_aux_data)),
-				    GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-		if (!new_data)
-			return NULL;
-
-		env->insn_aux_data = new_data;
-	}
-
-	new_prog = bpf_patch_insn_single(env->prog, off, patch, len);
-	if (IS_ERR(new_prog)) {
-		if (PTR_ERR(new_prog) == -ERANGE)
-			verbose(env,
-				"insn %d cannot be patched due to 16-bit range\n",
-				env->insn_aux_data[off].orig_idx);
-		return NULL;
-	}
-	adjust_insn_aux_data(env, new_prog, off, len);
-	adjust_subprog_starts(env, off, len);
-	adjust_insn_arrays(env, off, len);
-	adjust_poke_descs(new_prog, off, len);
-	return new_prog;
-}
-
-/*
- * For all jmp insns in a given 'prog' that point to 'tgt_idx' insn adjust the
- * jump offset by 'delta'.
- */
-static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
-{
-	struct bpf_insn *insn = prog->insnsi;
-	u32 insn_cnt = prog->len, i;
-	s32 imm;
-	s16 off;
-
-	for (i = 0; i < insn_cnt; i++, insn++) {
-		u8 code = insn->code;
-
-		if (tgt_idx <= i && i < tgt_idx + delta)
-			continue;
-
-		if ((BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32) ||
-		    BPF_OP(code) == BPF_CALL || BPF_OP(code) == BPF_EXIT)
-			continue;
-
-		if (insn->code == (BPF_JMP32 | BPF_JA)) {
-			if (i + 1 + insn->imm != tgt_idx)
-				continue;
-			if (check_add_overflow(insn->imm, delta, &imm))
-				return -ERANGE;
-			insn->imm = imm;
-		} else {
-			if (i + 1 + insn->off != tgt_idx)
-				continue;
-			if (check_add_overflow(insn->off, delta, &off))
-				return -ERANGE;
-			insn->off = off;
-		}
-	}
-	return 0;
-}
-
-static int adjust_subprog_starts_after_remove(struct bpf_verifier_env *env,
-					      u32 off, u32 cnt)
-{
-	int i, j;
-
-	/* find first prog starting at or after off (first to remove) */
-	for (i = 0; i < env->subprog_cnt; i++)
-		if (env->subprog_info[i].start >= off)
-			break;
-	/* find first prog starting at or after off + cnt (first to stay) */
-	for (j = i; j < env->subprog_cnt; j++)
-		if (env->subprog_info[j].start >= off + cnt)
-			break;
-	/* if j doesn't start exactly at off + cnt, we are just removing
-	 * the front of previous prog
-	 */
-	if (env->subprog_info[j].start != off + cnt)
-		j--;
-
-	if (j > i) {
-		struct bpf_prog_aux *aux = env->prog->aux;
-		int move;
-
-		/* move fake 'exit' subprog as well */
-		move = env->subprog_cnt + 1 - j;
-
-		memmove(env->subprog_info + i,
-			env->subprog_info + j,
-			sizeof(*env->subprog_info) * move);
-		env->subprog_cnt -= j - i;
-
-		/* remove func_info */
-		if (aux->func_info) {
-			move = aux->func_info_cnt - j;
-
-			memmove(aux->func_info + i,
-				aux->func_info + j,
-				sizeof(*aux->func_info) * move);
-			aux->func_info_cnt -= j - i;
-			/* func_info->insn_off is set after all code rewrites,
-			 * in adjust_btf_func() - no need to adjust
-			 */
-		}
-	} else {
-		/* convert i from "first prog to remove" to "first to adjust" */
-		if (env->subprog_info[i].start == off)
-			i++;
-	}
-
-	/* update fake 'exit' subprog as well */
-	for (; i <= env->subprog_cnt; i++)
-		env->subprog_info[i].start -= cnt;
-
-	return 0;
-}
-
-static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
-				      u32 cnt)
-{
-	struct bpf_prog *prog = env->prog;
-	u32 i, l_off, l_cnt, nr_linfo;
-	struct bpf_line_info *linfo;
-
-	nr_linfo = prog->aux->nr_linfo;
-	if (!nr_linfo)
-		return 0;
-
-	linfo = prog->aux->linfo;
-
-	/* find first line info to remove, count lines to be removed */
-	for (i = 0; i < nr_linfo; i++)
-		if (linfo[i].insn_off >= off)
-			break;
-
-	l_off = i;
-	l_cnt = 0;
-	for (; i < nr_linfo; i++)
-		if (linfo[i].insn_off < off + cnt)
-			l_cnt++;
-		else
-			break;
-
-	/* First live insn doesn't match first live linfo, it needs to "inherit"
-	 * last removed linfo.  prog is already modified, so prog->len == off
-	 * means no live instructions after (tail of the program was removed).
-	 */
-	if (prog->len != off && l_cnt &&
-	    (i == nr_linfo || linfo[i].insn_off != off + cnt)) {
-		l_cnt--;
-		linfo[--i].insn_off = off + cnt;
-	}
-
-	/* remove the line info which refer to the removed instructions */
-	if (l_cnt) {
-		memmove(linfo + l_off, linfo + i,
-			sizeof(*linfo) * (nr_linfo - i));
-
-		prog->aux->nr_linfo -= l_cnt;
-		nr_linfo = prog->aux->nr_linfo;
-	}
-
-	/* pull all linfo[i].insn_off >= off + cnt in by cnt */
-	for (i = l_off; i < nr_linfo; i++)
-		linfo[i].insn_off -= cnt;
-
-	/* fix up all subprogs (incl. 'exit') which start >= off */
-	for (i = 0; i <= env->subprog_cnt; i++)
-		if (env->subprog_info[i].linfo_idx > l_off) {
-			/* program may have started in the removed region but
-			 * may not be fully removed
-			 */
-			if (env->subprog_info[i].linfo_idx >= l_off + l_cnt)
-				env->subprog_info[i].linfo_idx -= l_cnt;
-			else
-				env->subprog_info[i].linfo_idx = l_off;
-		}
-
-	return 0;
-}
-
-/*
- * Clean up dynamically allocated fields of aux data for instructions [start, ...]
- */
-static void clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
-{
-	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
-	struct bpf_insn *insns = env->prog->insnsi;
-	int end = start + len;
-	int i;
-
-	for (i = start; i < end; i++) {
-		if (aux_data[i].jt) {
-			kvfree(aux_data[i].jt);
-			aux_data[i].jt = NULL;
-		}
-
-		if (bpf_is_ldimm64(&insns[i]))
-			i++;
-	}
-}
-
-static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
-{
-	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
-	unsigned int orig_prog_len = env->prog->len;
-	int err;
-
-	if (bpf_prog_is_offloaded(env->prog->aux))
-		bpf_prog_offload_remove_insns(env, off, cnt);
-
-	/* Should be called before bpf_remove_insns, as it uses prog->insnsi */
-	clear_insn_aux_data(env, off, cnt);
-
-	err = bpf_remove_insns(env->prog, off, cnt);
-	if (err)
-		return err;
-
-	err = adjust_subprog_starts_after_remove(env, off, cnt);
-	if (err)
-		return err;
-
-	err = bpf_adj_linfo_after_remove(env, off, cnt);
-	if (err)
-		return err;
 
-	adjust_insn_arrays_after_remove(env, off, cnt);
-
-	memmove(aux_data + off,	aux_data + off + cnt,
-		sizeof(*aux_data) * (orig_prog_len - off - cnt));
-
-	return 0;
-}
 
 /* The verifier does more data flow analysis than llvm and will not
  * explore branches that are dead at run time. Malicious programs can
@@ -22913,2189 +22395,7 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 	}
 }
 
-bool bpf_insn_is_cond_jump(u8 code)
-{
-	u8 op;
-
-	op = BPF_OP(code);
-	if (BPF_CLASS(code) == BPF_JMP32)
-		return op != BPF_JA;
 
-	if (BPF_CLASS(code) != BPF_JMP)
-		return false;
-
-	return op != BPF_JA && op != BPF_EXIT && op != BPF_CALL;
-}
-
-static void opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env)
-{
-	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
-	struct bpf_insn ja = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
-	struct bpf_insn *insn = env->prog->insnsi;
-	const int insn_cnt = env->prog->len;
-	int i;
-
-	for (i = 0; i < insn_cnt; i++, insn++) {
-		if (!bpf_insn_is_cond_jump(insn->code))
-			continue;
-
-		if (!aux_data[i + 1].seen)
-			ja.off = insn->off;
-		else if (!aux_data[i + 1 + insn->off].seen)
-			ja.off = 0;
-		else
-			continue;
-
-		if (bpf_prog_is_offloaded(env->prog->aux))
-			bpf_prog_offload_replace_insn(env, i, &ja);
-
-		memcpy(insn, &ja, sizeof(ja));
-	}
-}
-
-static int opt_remove_dead_code(struct bpf_verifier_env *env)
-{
-	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
-	int insn_cnt = env->prog->len;
-	int i, err;
-
-	for (i = 0; i < insn_cnt; i++) {
-		int j;
-
-		j = 0;
-		while (i + j < insn_cnt && !aux_data[i + j].seen)
-			j++;
-		if (!j)
-			continue;
-
-		err = verifier_remove_insns(env, i, j);
-		if (err)
-			return err;
-		insn_cnt = env->prog->len;
-	}
-
-	return 0;
-}
-
-static const struct bpf_insn NOP = BPF_JMP_IMM(BPF_JA, 0, 0, 0);
-static const struct bpf_insn MAY_GOTO_0 = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0, 0);
-
-static int opt_remove_nops(struct bpf_verifier_env *env)
-{
-	struct bpf_insn *insn = env->prog->insnsi;
-	int insn_cnt = env->prog->len;
-	bool is_may_goto_0, is_ja;
-	int i, err;
-
-	for (i = 0; i < insn_cnt; i++) {
-		is_may_goto_0 = !memcmp(&insn[i], &MAY_GOTO_0, sizeof(MAY_GOTO_0));
-		is_ja = !memcmp(&insn[i], &NOP, sizeof(NOP));
-
-		if (!is_may_goto_0 && !is_ja)
-			continue;
-
-		err = verifier_remove_insns(env, i, 1);
-		if (err)
-			return err;
-		insn_cnt--;
-		/* Go back one insn to catch may_goto +1; may_goto +0 sequence */
-		i -= (is_may_goto_0 && i > 0) ? 2 : 1;
-	}
-
-	return 0;
-}
-
-static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
-					 const union bpf_attr *attr)
-{
-	struct bpf_insn *patch;
-	/* use env->insn_buf as two independent buffers */
-	struct bpf_insn *zext_patch = env->insn_buf;
-	struct bpf_insn *rnd_hi32_patch = &env->insn_buf[2];
-	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	int i, patch_len, delta = 0, len = env->prog->len;
-	struct bpf_insn *insns = env->prog->insnsi;
-	struct bpf_prog *new_prog;
-	bool rnd_hi32;
-
-	rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
-	zext_patch[1] = BPF_ZEXT_REG(0);
-	rnd_hi32_patch[1] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, 0);
-	rnd_hi32_patch[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
-	rnd_hi32_patch[3] = BPF_ALU64_REG(BPF_OR, 0, BPF_REG_AX);
-	for (i = 0; i < len; i++) {
-		int adj_idx = i + delta;
-		struct bpf_insn insn;
-		int load_reg;
-
-		insn = insns[adj_idx];
-		load_reg = insn_def_regno(&insn);
-		if (!aux[adj_idx].zext_dst) {
-			u8 code, class;
-			u32 imm_rnd;
-
-			if (!rnd_hi32)
-				continue;
-
-			code = insn.code;
-			class = BPF_CLASS(code);
-			if (load_reg == -1)
-				continue;
-
-			/* NOTE: arg "reg" (the fourth one) is only used for
-			 *       BPF_STX + SRC_OP, so it is safe to pass NULL
-			 *       here.
-			 */
-			if (is_reg64(&insn, load_reg, NULL, DST_OP)) {
-				if (class == BPF_LD &&
-				    BPF_MODE(code) == BPF_IMM)
-					i++;
-				continue;
-			}
-
-			/* ctx load could be transformed into wider load. */
-			if (class == BPF_LDX &&
-			    aux[adj_idx].ptr_type == PTR_TO_CTX)
-				continue;
-
-			imm_rnd = get_random_u32();
-			rnd_hi32_patch[0] = insn;
-			rnd_hi32_patch[1].imm = imm_rnd;
-			rnd_hi32_patch[3].dst_reg = load_reg;
-			patch = rnd_hi32_patch;
-			patch_len = 4;
-			goto apply_patch_buffer;
-		}
-
-		/* Add in an zero-extend instruction if a) the JIT has requested
-		 * it or b) it's a CMPXCHG.
-		 *
-		 * The latter is because: BPF_CMPXCHG always loads a value into
-		 * R0, therefore always zero-extends. However some archs'
-		 * equivalent instruction only does this load when the
-		 * comparison is successful. This detail of CMPXCHG is
-		 * orthogonal to the general zero-extension behaviour of the
-		 * CPU, so it's treated independently of bpf_jit_needs_zext.
-		 */
-		if (!bpf_jit_needs_zext() && !is_cmpxchg_insn(&insn))
-			continue;
-
-		/* Zero-extension is done by the caller. */
-		if (bpf_pseudo_kfunc_call(&insn))
-			continue;
-
-		if (verifier_bug_if(load_reg == -1, env,
-				    "zext_dst is set, but no reg is defined"))
-			return -EFAULT;
-
-		zext_patch[0] = insn;
-		zext_patch[1].dst_reg = load_reg;
-		zext_patch[1].src_reg = load_reg;
-		patch = zext_patch;
-		patch_len = 2;
-apply_patch_buffer:
-		new_prog = bpf_patch_insn_data(env, adj_idx, patch, patch_len);
-		if (!new_prog)
-			return -ENOMEM;
-		env->prog = new_prog;
-		insns = new_prog->insnsi;
-		aux = env->insn_aux_data;
-		delta += patch_len - 1;
-	}
-
-	return 0;
-}
-
-/* convert load instructions that access fields of a context type into a
- * sequence of instructions that access fields of the underlying structure:
- *     struct __sk_buff    -> struct sk_buff
- *     struct bpf_sock_ops -> struct sock
- */
-static int convert_ctx_accesses(struct bpf_verifier_env *env)
-{
-	struct bpf_subprog_info *subprogs = env->subprog_info;
-	const struct bpf_verifier_ops *ops = env->ops;
-	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
-	const int insn_cnt = env->prog->len;
-	struct bpf_insn *epilogue_buf = env->epilogue_buf;
-	struct bpf_insn *insn_buf = env->insn_buf;
-	struct bpf_insn *insn;
-	u32 target_size, size_default, off;
-	struct bpf_prog *new_prog;
-	enum bpf_access_type type;
-	bool is_narrower_load;
-	int epilogue_idx = 0;
-
-	if (ops->gen_epilogue) {
-		epilogue_cnt = ops->gen_epilogue(epilogue_buf, env->prog,
-						 -(subprogs[0].stack_depth + 8));
-		if (epilogue_cnt >= INSN_BUF_SIZE) {
-			verifier_bug(env, "epilogue is too long");
-			return -EFAULT;
-		} else if (epilogue_cnt) {
-			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
-			cnt = 0;
-			subprogs[0].stack_depth += 8;
-			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
-						      -subprogs[0].stack_depth);
-			insn_buf[cnt++] = env->prog->insnsi[0];
-			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-			env->prog = new_prog;
-			delta += cnt - 1;
-
-			ret = add_kfunc_in_insns(env, epilogue_buf, epilogue_cnt - 1);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
-	if (ops->gen_prologue || env->seen_direct_write) {
-		if (!ops->gen_prologue) {
-			verifier_bug(env, "gen_prologue is null");
-			return -EFAULT;
-		}
-		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
-					env->prog);
-		if (cnt >= INSN_BUF_SIZE) {
-			verifier_bug(env, "prologue is too long");
-			return -EFAULT;
-		} else if (cnt) {
-			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			env->prog = new_prog;
-			delta += cnt - 1;
-
-			ret = add_kfunc_in_insns(env, insn_buf, cnt - 1);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
-	if (delta)
-		WARN_ON(adjust_jmp_off(env->prog, 0, delta));
-
-	if (bpf_prog_is_offloaded(env->prog->aux))
-		return 0;
-
-	insn = env->prog->insnsi + delta;
-
-	for (i = 0; i < insn_cnt; i++, insn++) {
-		bpf_convert_ctx_access_t convert_ctx_access;
-		u8 mode;
-
-		if (env->insn_aux_data[i + delta].nospec) {
-			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
-			struct bpf_insn *patch = insn_buf;
-
-			*patch++ = BPF_ST_NOSPEC();
-			*patch++ = *insn;
-			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			/* This can not be easily merged with the
-			 * nospec_result-case, because an insn may require a
-			 * nospec before and after itself. Therefore also do not
-			 * 'continue' here but potentially apply further
-			 * patching to insn. *insn should equal patch[1] now.
-			 */
-		}
-
-		if (insn->code == (BPF_LDX | BPF_MEM | BPF_B) ||
-		    insn->code == (BPF_LDX | BPF_MEM | BPF_H) ||
-		    insn->code == (BPF_LDX | BPF_MEM | BPF_W) ||
-		    insn->code == (BPF_LDX | BPF_MEM | BPF_DW) ||
-		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_B) ||
-		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_H) ||
-		    insn->code == (BPF_LDX | BPF_MEMSX | BPF_W)) {
-			type = BPF_READ;
-		} else if (insn->code == (BPF_STX | BPF_MEM | BPF_B) ||
-			   insn->code == (BPF_STX | BPF_MEM | BPF_H) ||
-			   insn->code == (BPF_STX | BPF_MEM | BPF_W) ||
-			   insn->code == (BPF_STX | BPF_MEM | BPF_DW) ||
-			   insn->code == (BPF_ST | BPF_MEM | BPF_B) ||
-			   insn->code == (BPF_ST | BPF_MEM | BPF_H) ||
-			   insn->code == (BPF_ST | BPF_MEM | BPF_W) ||
-			   insn->code == (BPF_ST | BPF_MEM | BPF_DW)) {
-			type = BPF_WRITE;
-		} else if ((insn->code == (BPF_STX | BPF_ATOMIC | BPF_B) ||
-			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_H) ||
-			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_W) ||
-			    insn->code == (BPF_STX | BPF_ATOMIC | BPF_DW)) &&
-			   env->insn_aux_data[i + delta].ptr_type == PTR_TO_ARENA) {
-			insn->code = BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
-			env->prog->aux->num_exentries++;
-			continue;
-		} else if (insn->code == (BPF_JMP | BPF_EXIT) &&
-			   epilogue_cnt &&
-			   i + delta < subprogs[1].start) {
-			/* Generate epilogue for the main prog */
-			if (epilogue_idx) {
-				/* jump back to the earlier generated epilogue */
-				insn_buf[0] = BPF_JMP32_A(epilogue_idx - i - delta - 1);
-				cnt = 1;
-			} else {
-				memcpy(insn_buf, epilogue_buf,
-				       epilogue_cnt * sizeof(*epilogue_buf));
-				cnt = epilogue_cnt;
-				/* epilogue_idx cannot be 0. It must have at
-				 * least one ctx ptr saving insn before the
-				 * epilogue.
-				 */
-				epilogue_idx = i + delta;
-			}
-			goto patch_insn_buf;
-		} else {
-			continue;
-		}
-
-		if (type == BPF_WRITE &&
-		    env->insn_aux_data[i + delta].nospec_result) {
-			/* nospec_result is only used to mitigate Spectre v4 and
-			 * to limit verification-time for Spectre v1.
-			 */
-			struct bpf_insn *patch = insn_buf;
-
-			*patch++ = *insn;
-			*patch++ = BPF_ST_NOSPEC();
-			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			continue;
-		}
-
-		switch ((int)env->insn_aux_data[i + delta].ptr_type) {
-		case PTR_TO_CTX:
-			if (!ops->convert_ctx_access)
-				continue;
-			convert_ctx_access = ops->convert_ctx_access;
-			break;
-		case PTR_TO_SOCKET:
-		case PTR_TO_SOCK_COMMON:
-			convert_ctx_access = bpf_sock_convert_ctx_access;
-			break;
-		case PTR_TO_TCP_SOCK:
-			convert_ctx_access = bpf_tcp_sock_convert_ctx_access;
-			break;
-		case PTR_TO_XDP_SOCK:
-			convert_ctx_access = bpf_xdp_sock_convert_ctx_access;
-			break;
-		case PTR_TO_BTF_ID:
-		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
-		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
-		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
-		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
-		 * any faults for loads into such types. BPF_WRITE is disallowed
-		 * for this case.
-		 */
-		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
-		case PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED:
-			if (type == BPF_READ) {
-				if (BPF_MODE(insn->code) == BPF_MEM)
-					insn->code = BPF_LDX | BPF_PROBE_MEM |
-						     BPF_SIZE((insn)->code);
-				else
-					insn->code = BPF_LDX | BPF_PROBE_MEMSX |
-						     BPF_SIZE((insn)->code);
-				env->prog->aux->num_exentries++;
-			}
-			continue;
-		case PTR_TO_ARENA:
-			if (BPF_MODE(insn->code) == BPF_MEMSX) {
-				if (!bpf_jit_supports_insn(insn, true)) {
-					verbose(env, "sign extending loads from arena are not supported yet\n");
-					return -EOPNOTSUPP;
-				}
-				insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32SX | BPF_SIZE(insn->code);
-			} else {
-				insn->code = BPF_CLASS(insn->code) | BPF_PROBE_MEM32 | BPF_SIZE(insn->code);
-			}
-			env->prog->aux->num_exentries++;
-			continue;
-		default:
-			continue;
-		}
-
-		ctx_field_size = env->insn_aux_data[i + delta].ctx_field_size;
-		size = BPF_LDST_BYTES(insn);
-		mode = BPF_MODE(insn->code);
-
-		/* If the read access is a narrower load of the field,
-		 * convert to a 4/8-byte load, to minimum program type specific
-		 * convert_ctx_access changes. If conversion is successful,
-		 * we will apply proper mask to the result.
-		 */
-		is_narrower_load = size < ctx_field_size;
-		size_default = bpf_ctx_off_adjust_machine(ctx_field_size);
-		off = insn->off;
-		if (is_narrower_load) {
-			u8 size_code;
-
-			if (type == BPF_WRITE) {
-				verifier_bug(env, "narrow ctx access misconfigured");
-				return -EFAULT;
-			}
-
-			size_code = BPF_H;
-			if (ctx_field_size == 4)
-				size_code = BPF_W;
-			else if (ctx_field_size == 8)
-				size_code = BPF_DW;
-
-			insn->off = off & ~(size_default - 1);
-			insn->code = BPF_LDX | BPF_MEM | size_code;
-		}
-
-		target_size = 0;
-		cnt = convert_ctx_access(type, insn, insn_buf, env->prog,
-					 &target_size);
-		if (cnt == 0 || cnt >= INSN_BUF_SIZE ||
-		    (ctx_field_size && !target_size)) {
-			verifier_bug(env, "error during ctx access conversion (%d)", cnt);
-			return -EFAULT;
-		}
-
-		if (is_narrower_load && size < target_size) {
-			u8 shift = bpf_ctx_narrow_access_offset(
-				off, size, size_default) * 8;
-			if (shift && cnt + 1 >= INSN_BUF_SIZE) {
-				verifier_bug(env, "narrow ctx load misconfigured");
-				return -EFAULT;
-			}
-			if (ctx_field_size <= 4) {
-				if (shift)
-					insn_buf[cnt++] = BPF_ALU32_IMM(BPF_RSH,
-									insn->dst_reg,
-									shift);
-				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
-								(1 << size * 8) - 1);
-			} else {
-				if (shift)
-					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
-									insn->dst_reg,
-									shift);
-				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
-								(1ULL << size * 8) - 1);
-			}
-		}
-		if (mode == BPF_MEMSX)
-			insn_buf[cnt++] = BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X,
-						       insn->dst_reg, insn->dst_reg,
-						       size * 8, 0);
-
-patch_insn_buf:
-		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-		if (!new_prog)
-			return -ENOMEM;
-
-		delta += cnt - 1;
-
-		/* keep walking new program and skip insns we just inserted */
-		env->prog = new_prog;
-		insn      = new_prog->insnsi + i + delta;
-	}
-
-	return 0;
-}
-
-static int jit_subprogs(struct bpf_verifier_env *env)
-{
-	struct bpf_prog *prog = env->prog, **func, *tmp;
-	int i, j, subprog_start, subprog_end = 0, len, subprog;
-	struct bpf_map *map_ptr;
-	struct bpf_insn *insn;
-	void *old_bpf_func;
-	int err, num_exentries;
-	int old_len, subprog_start_adjustment = 0;
-
-	if (env->subprog_cnt <= 1)
-		return 0;
-
-	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
-		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
-			continue;
-
-		/* Upon error here we cannot fall back to interpreter but
-		 * need a hard reject of the program. Thus -EFAULT is
-		 * propagated in any case.
-		 */
-		subprog = bpf_find_subprog(env, i + insn->imm + 1);
-		if (verifier_bug_if(subprog < 0, env, "No program to jit at insn %d",
-				    i + insn->imm + 1))
-			return -EFAULT;
-		/* temporarily remember subprog id inside insn instead of
-		 * aux_data, since next loop will split up all insns into funcs
-		 */
-		insn->off = subprog;
-		/* remember original imm in case JIT fails and fallback
-		 * to interpreter will be needed
-		 */
-		env->insn_aux_data[i].call_imm = insn->imm;
-		/* point imm to __bpf_call_base+1 from JITs point of view */
-		insn->imm = 1;
-		if (bpf_pseudo_func(insn)) {
-#if defined(MODULES_VADDR)
-			u64 addr = MODULES_VADDR;
-#else
-			u64 addr = VMALLOC_START;
-#endif
-			/* jit (e.g. x86_64) may emit fewer instructions
-			 * if it learns a u32 imm is the same as a u64 imm.
-			 * Set close enough to possible prog address.
-			 */
-			insn[0].imm = (u32)addr;
-			insn[1].imm = addr >> 32;
-		}
-	}
-
-	err = bpf_prog_alloc_jited_linfo(prog);
-	if (err)
-		goto out_undo_insn;
-
-	err = -ENOMEM;
-	func = kzalloc_objs(prog, env->subprog_cnt);
-	if (!func)
-		goto out_undo_insn;
-
-	for (i = 0; i < env->subprog_cnt; i++) {
-		subprog_start = subprog_end;
-		subprog_end = env->subprog_info[i + 1].start;
-
-		len = subprog_end - subprog_start;
-		/* bpf_prog_run() doesn't call subprogs directly,
-		 * hence main prog stats include the runtime of subprogs.
-		 * subprogs don't have IDs and not reachable via prog_get_next_id
-		 * func[i]->stats will never be accessed and stays NULL
-		 */
-		func[i] = bpf_prog_alloc_no_stats(bpf_prog_size(len), GFP_USER);
-		if (!func[i])
-			goto out_free;
-		memcpy(func[i]->insnsi, &prog->insnsi[subprog_start],
-		       len * sizeof(struct bpf_insn));
-		func[i]->type = prog->type;
-		func[i]->len = len;
-		if (bpf_prog_calc_tag(func[i]))
-			goto out_free;
-		func[i]->is_func = 1;
-		func[i]->sleepable = prog->sleepable;
-		func[i]->aux->func_idx = i;
-		/* Below members will be freed only at prog->aux */
-		func[i]->aux->btf = prog->aux->btf;
-		func[i]->aux->subprog_start = subprog_start + subprog_start_adjustment;
-		func[i]->aux->func_info = prog->aux->func_info;
-		func[i]->aux->func_info_cnt = prog->aux->func_info_cnt;
-		func[i]->aux->poke_tab = prog->aux->poke_tab;
-		func[i]->aux->size_poke_tab = prog->aux->size_poke_tab;
-		func[i]->aux->main_prog_aux = prog->aux;
-
-		for (j = 0; j < prog->aux->size_poke_tab; j++) {
-			struct bpf_jit_poke_descriptor *poke;
-
-			poke = &prog->aux->poke_tab[j];
-			if (poke->insn_idx < subprog_end &&
-			    poke->insn_idx >= subprog_start)
-				poke->aux = func[i]->aux;
-		}
-
-		func[i]->aux->name[0] = 'F';
-		func[i]->aux->stack_depth = env->subprog_info[i].stack_depth;
-		if (env->subprog_info[i].priv_stack_mode == PRIV_STACK_ADAPTIVE)
-			func[i]->aux->jits_use_priv_stack = true;
-
-		func[i]->jit_requested = 1;
-		func[i]->blinding_requested = prog->blinding_requested;
-		func[i]->aux->kfunc_tab = prog->aux->kfunc_tab;
-		func[i]->aux->kfunc_btf_tab = prog->aux->kfunc_btf_tab;
-		func[i]->aux->linfo = prog->aux->linfo;
-		func[i]->aux->nr_linfo = prog->aux->nr_linfo;
-		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
-		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
-		func[i]->aux->arena = prog->aux->arena;
-		func[i]->aux->used_maps = env->used_maps;
-		func[i]->aux->used_map_cnt = env->used_map_cnt;
-		num_exentries = 0;
-		insn = func[i]->insnsi;
-		for (j = 0; j < func[i]->len; j++, insn++) {
-			if (BPF_CLASS(insn->code) == BPF_LDX &&
-			    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
-			     BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
-			     BPF_MODE(insn->code) == BPF_PROBE_MEM32SX ||
-			     BPF_MODE(insn->code) == BPF_PROBE_MEMSX))
-				num_exentries++;
-			if ((BPF_CLASS(insn->code) == BPF_STX ||
-			     BPF_CLASS(insn->code) == BPF_ST) &&
-			     BPF_MODE(insn->code) == BPF_PROBE_MEM32)
-				num_exentries++;
-			if (BPF_CLASS(insn->code) == BPF_STX &&
-			     BPF_MODE(insn->code) == BPF_PROBE_ATOMIC)
-				num_exentries++;
-		}
-		func[i]->aux->num_exentries = num_exentries;
-		func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
-		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
-		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
-		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
-		if (!i)
-			func[i]->aux->exception_boundary = env->seen_exception;
-
-		/*
-		 * To properly pass the absolute subprog start to jit
-		 * all instruction adjustments should be accumulated
-		 */
-		old_len = func[i]->len;
-		func[i] = bpf_int_jit_compile(func[i]);
-		subprog_start_adjustment += func[i]->len - old_len;
-
-		if (!func[i]->jited) {
-			err = -ENOTSUPP;
-			goto out_free;
-		}
-		cond_resched();
-	}
-
-	/* at this point all bpf functions were successfully JITed
-	 * now populate all bpf_calls with correct addresses and
-	 * run last pass of JIT
-	 */
-	for (i = 0; i < env->subprog_cnt; i++) {
-		insn = func[i]->insnsi;
-		for (j = 0; j < func[i]->len; j++, insn++) {
-			if (bpf_pseudo_func(insn)) {
-				subprog = insn->off;
-				insn[0].imm = (u32)(long)func[subprog]->bpf_func;
-				insn[1].imm = ((u64)(long)func[subprog]->bpf_func) >> 32;
-				continue;
-			}
-			if (!bpf_pseudo_call(insn))
-				continue;
-			subprog = insn->off;
-			insn->imm = BPF_CALL_IMM(func[subprog]->bpf_func);
-		}
-
-		/* we use the aux data to keep a list of the start addresses
-		 * of the JITed images for each function in the program
-		 *
-		 * for some architectures, such as powerpc64, the imm field
-		 * might not be large enough to hold the offset of the start
-		 * address of the callee's JITed image from __bpf_call_base
-		 *
-		 * in such cases, we can lookup the start address of a callee
-		 * by using its subprog id, available from the off field of
-		 * the call instruction, as an index for this list
-		 */
-		func[i]->aux->func = func;
-		func[i]->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
-		func[i]->aux->real_func_cnt = env->subprog_cnt;
-	}
-	for (i = 0; i < env->subprog_cnt; i++) {
-		old_bpf_func = func[i]->bpf_func;
-		tmp = bpf_int_jit_compile(func[i]);
-		if (tmp != func[i] || func[i]->bpf_func != old_bpf_func) {
-			verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
-			err = -ENOTSUPP;
-			goto out_free;
-		}
-		cond_resched();
-	}
-
-	/*
-	 * Cleanup func[i]->aux fields which aren't required
-	 * or can become invalid in future
-	 */
-	for (i = 0; i < env->subprog_cnt; i++) {
-		func[i]->aux->used_maps = NULL;
-		func[i]->aux->used_map_cnt = 0;
-	}
-
-	/* finally lock prog and jit images for all functions and
-	 * populate kallsysm. Begin at the first subprogram, since
-	 * bpf_prog_load will add the kallsyms for the main program.
-	 */
-	for (i = 1; i < env->subprog_cnt; i++) {
-		err = bpf_prog_lock_ro(func[i]);
-		if (err)
-			goto out_free;
-	}
-
-	for (i = 1; i < env->subprog_cnt; i++)
-		bpf_prog_kallsyms_add(func[i]);
-
-	/* Last step: make now unused interpreter insns from main
-	 * prog consistent for later dump requests, so they can
-	 * later look the same as if they were interpreted only.
-	 */
-	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
-		if (bpf_pseudo_func(insn)) {
-			insn[0].imm = env->insn_aux_data[i].call_imm;
-			insn[1].imm = insn->off;
-			insn->off = 0;
-			continue;
-		}
-		if (!bpf_pseudo_call(insn))
-			continue;
-		insn->off = env->insn_aux_data[i].call_imm;
-		subprog = bpf_find_subprog(env, i + insn->off + 1);
-		insn->imm = subprog;
-	}
-
-	prog->jited = 1;
-	prog->bpf_func = func[0]->bpf_func;
-	prog->jited_len = func[0]->jited_len;
-	prog->aux->extable = func[0]->aux->extable;
-	prog->aux->num_exentries = func[0]->aux->num_exentries;
-	prog->aux->func = func;
-	prog->aux->func_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
-	prog->aux->real_func_cnt = env->subprog_cnt;
-	prog->aux->bpf_exception_cb = (void *)func[env->exception_callback_subprog]->bpf_func;
-	prog->aux->exception_boundary = func[0]->aux->exception_boundary;
-	bpf_prog_jit_attempt_done(prog);
-	return 0;
-out_free:
-	/* We failed JIT'ing, so at this point we need to unregister poke
-	 * descriptors from subprogs, so that kernel is not attempting to
-	 * patch it anymore as we're freeing the subprog JIT memory.
-	 */
-	for (i = 0; i < prog->aux->size_poke_tab; i++) {
-		map_ptr = prog->aux->poke_tab[i].tail_call.map;
-		map_ptr->ops->map_poke_untrack(map_ptr, prog->aux);
-	}
-	/* At this point we're guaranteed that poke descriptors are not
-	 * live anymore. We can just unlink its descriptor table as it's
-	 * released with the main prog.
-	 */
-	for (i = 0; i < env->subprog_cnt; i++) {
-		if (!func[i])
-			continue;
-		func[i]->aux->poke_tab = NULL;
-		bpf_jit_free(func[i]);
-	}
-	kfree(func);
-out_undo_insn:
-	/* cleanup main prog to be interpreted */
-	prog->jit_requested = 0;
-	prog->blinding_requested = 0;
-	for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
-		if (!bpf_pseudo_call(insn))
-			continue;
-		insn->off = 0;
-		insn->imm = env->insn_aux_data[i].call_imm;
-	}
-	bpf_prog_jit_attempt_done(prog);
-	return err;
-}
-
-static int fixup_call_args(struct bpf_verifier_env *env)
-{
-#ifndef CONFIG_BPF_JIT_ALWAYS_ON
-	struct bpf_prog *prog = env->prog;
-	struct bpf_insn *insn = prog->insnsi;
-	bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
-	int i, depth;
-#endif
-	int err = 0;
-
-	if (env->prog->jit_requested &&
-	    !bpf_prog_is_offloaded(env->prog->aux)) {
-		err = jit_subprogs(env);
-		if (err == 0)
-			return 0;
-		if (err == -EFAULT)
-			return err;
-	}
-#ifndef CONFIG_BPF_JIT_ALWAYS_ON
-	if (has_kfunc_call) {
-		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
-		return -EINVAL;
-	}
-	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
-		/* When JIT fails the progs with bpf2bpf calls and tail_calls
-		 * have to be rejected, since interpreter doesn't support them yet.
-		 */
-		verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
-		return -EINVAL;
-	}
-	for (i = 0; i < prog->len; i++, insn++) {
-		if (bpf_pseudo_func(insn)) {
-			/* When JIT fails the progs with callback calls
-			 * have to be rejected, since interpreter doesn't support them yet.
-			 */
-			verbose(env, "callbacks are not allowed in non-JITed programs\n");
-			return -EINVAL;
-		}
-
-		if (!bpf_pseudo_call(insn))
-			continue;
-		depth = get_callee_stack_depth(env, insn, i);
-		if (depth < 0)
-			return depth;
-		bpf_patch_call_args(insn, depth);
-	}
-	err = 0;
-#endif
-	return err;
-}
-
-/* replace a generic kfunc with a specialized version if necessary */
-static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc, int insn_idx)
-{
-	struct bpf_prog *prog = env->prog;
-	bool seen_direct_write;
-	void *xdp_kfunc;
-	bool is_rdonly;
-	u32 func_id = desc->func_id;
-	u16 offset = desc->offset;
-	unsigned long addr = desc->addr;
-
-	if (offset) /* return if module BTF is used */
-		return 0;
-
-	if (bpf_dev_bound_kfunc_id(func_id)) {
-		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
-		if (xdp_kfunc)
-			addr = (unsigned long)xdp_kfunc;
-		/* fallback to default kfunc when not supported by netdev */
-	} else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
-		seen_direct_write = env->seen_direct_write;
-		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
-
-		if (is_rdonly)
-			addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
-
-		/* restore env->seen_direct_write to its original value, since
-		 * may_access_direct_pkt_data mutates it
-		 */
-		env->seen_direct_write = seen_direct_write;
-	} else if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr]) {
-		if (bpf_lsm_has_d_inode_locked(prog))
-			addr = (unsigned long)bpf_set_dentry_xattr_locked;
-	} else if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr]) {
-		if (bpf_lsm_has_d_inode_locked(prog))
-			addr = (unsigned long)bpf_remove_dentry_xattr_locked;
-	} else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
-		if (!env->insn_aux_data[insn_idx].non_sleepable)
-			addr = (unsigned long)bpf_dynptr_from_file_sleepable;
-	} else if (func_id == special_kfunc_list[KF_bpf_arena_alloc_pages]) {
-		if (env->insn_aux_data[insn_idx].non_sleepable)
-			addr = (unsigned long)bpf_arena_alloc_pages_non_sleepable;
-	} else if (func_id == special_kfunc_list[KF_bpf_arena_free_pages]) {
-		if (env->insn_aux_data[insn_idx].non_sleepable)
-			addr = (unsigned long)bpf_arena_free_pages_non_sleepable;
-	}
-	desc->addr = addr;
-	return 0;
-}
-
-static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
-					    u16 struct_meta_reg,
-					    u16 node_offset_reg,
-					    struct bpf_insn *insn,
-					    struct bpf_insn *insn_buf,
-					    int *cnt)
-{
-	struct btf_struct_meta *kptr_struct_meta = insn_aux->kptr_struct_meta;
-	struct bpf_insn addr[2] = { BPF_LD_IMM64(struct_meta_reg, (long)kptr_struct_meta) };
-
-	insn_buf[0] = addr[0];
-	insn_buf[1] = addr[1];
-	insn_buf[2] = BPF_MOV64_IMM(node_offset_reg, insn_aux->insert_off);
-	insn_buf[3] = *insn;
-	*cnt = 4;
-}
-
-static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
-{
-	struct bpf_kfunc_desc *desc;
-	int err;
-
-	if (!insn->imm) {
-		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
-		return -EINVAL;
-	}
-
-	*cnt = 0;
-
-	/* insn->imm has the btf func_id. Replace it with an offset relative to
-	 * __bpf_call_base, unless the JIT needs to call functions that are
-	 * further than 32 bits away (bpf_jit_supports_far_kfunc_call()).
-	 */
-	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
-	if (!desc) {
-		verifier_bug(env, "kernel function descriptor not found for func_id %u",
-			     insn->imm);
-		return -EFAULT;
-	}
-
-	err = specialize_kfunc(env, desc, insn_idx);
-	if (err)
-		return err;
-
-	if (!bpf_jit_supports_far_kfunc_call())
-		insn->imm = BPF_CALL_IMM(desc->addr);
-
-	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(desc->func_id)) {
-		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
-		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
-		u64 obj_new_size = env->insn_aux_data[insn_idx].obj_new_size;
-
-		if (is_bpf_percpu_obj_new_kfunc(desc->func_id) && kptr_struct_meta) {
-			verifier_bug(env, "NULL kptr_struct_meta expected at insn_idx %d",
-				     insn_idx);
-			return -EFAULT;
-		}
-
-		insn_buf[0] = BPF_MOV64_IMM(BPF_REG_1, obj_new_size);
-		insn_buf[1] = addr[0];
-		insn_buf[2] = addr[1];
-		insn_buf[3] = *insn;
-		*cnt = 4;
-	} else if (is_bpf_obj_drop_kfunc(desc->func_id) ||
-		   is_bpf_percpu_obj_drop_kfunc(desc->func_id) ||
-		   is_bpf_refcount_acquire_kfunc(desc->func_id)) {
-		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
-		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
-
-		if (is_bpf_percpu_obj_drop_kfunc(desc->func_id) && kptr_struct_meta) {
-			verifier_bug(env, "NULL kptr_struct_meta expected at insn_idx %d",
-				     insn_idx);
-			return -EFAULT;
-		}
-
-		if (is_bpf_refcount_acquire_kfunc(desc->func_id) && !kptr_struct_meta) {
-			verifier_bug(env, "kptr_struct_meta expected at insn_idx %d",
-				     insn_idx);
-			return -EFAULT;
-		}
-
-		insn_buf[0] = addr[0];
-		insn_buf[1] = addr[1];
-		insn_buf[2] = *insn;
-		*cnt = 3;
-	} else if (is_bpf_list_push_kfunc(desc->func_id) ||
-		   is_bpf_rbtree_add_kfunc(desc->func_id)) {
-		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
-		int struct_meta_reg = BPF_REG_3;
-		int node_offset_reg = BPF_REG_4;
-
-		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
-		if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
-			struct_meta_reg = BPF_REG_4;
-			node_offset_reg = BPF_REG_5;
-		}
-
-		if (!kptr_struct_meta) {
-			verifier_bug(env, "kptr_struct_meta expected at insn_idx %d",
-				     insn_idx);
-			return -EFAULT;
-		}
-
-		__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
-						node_offset_reg, insn, insn_buf, cnt);
-	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
-		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
-		*cnt = 1;
-	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
-		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
-		/*
-		 * inline the bpf_session_is_return() for fsession:
-		 *   bool bpf_session_is_return(void *ctx)
-		 *   {
-		 *       return (((u64 *)ctx)[-1] >> BPF_TRAMP_IS_RETURN_SHIFT) & 1;
-		 *   }
-		 */
-		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
-		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_IS_RETURN_SHIFT);
-		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
-		*cnt = 3;
-	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
-		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
-		/*
-		 * inline bpf_session_cookie() for fsession:
-		 *   __u64 *bpf_session_cookie(void *ctx)
-		 *   {
-		 *       u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_COOKIE_INDEX_SHIFT) & 0xFF;
-		 *       return &((u64 *)ctx)[-off];
-		 *   }
-		 */
-		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
-		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_COOKIE_INDEX_SHIFT);
-		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
-		insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
-		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
-		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
-		*cnt = 6;
-	}
-
-	if (env->insn_aux_data[insn_idx].arg_prog) {
-		u32 regno = env->insn_aux_data[insn_idx].arg_prog;
-		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(regno, (long)env->prog->aux) };
-		int idx = *cnt;
-
-		insn_buf[idx++] = ld_addrs[0];
-		insn_buf[idx++] = ld_addrs[1];
-		insn_buf[idx++] = *insn;
-		*cnt = idx;
-	}
-	return 0;
-}
-
-/* The function requires that first instruction in 'patch' is insnsi[prog->len - 1] */
-static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
-{
-	struct bpf_subprog_info *info = env->subprog_info;
-	int cnt = env->subprog_cnt;
-	struct bpf_prog *prog;
-
-	/* We only reserve one slot for hidden subprogs in subprog_info. */
-	if (env->hidden_subprog_cnt) {
-		verifier_bug(env, "only one hidden subprog supported");
-		return -EFAULT;
-	}
-	/* We're not patching any existing instruction, just appending the new
-	 * ones for the hidden subprog. Hence all of the adjustment operations
-	 * in bpf_patch_insn_data are no-ops.
-	 */
-	prog = bpf_patch_insn_data(env, env->prog->len - 1, patch, len);
-	if (!prog)
-		return -ENOMEM;
-	env->prog = prog;
-	info[cnt + 1].start = info[cnt].start;
-	info[cnt].start = prog->len - len + 1;
-	env->subprog_cnt++;
-	env->hidden_subprog_cnt++;
-	return 0;
-}
-
-/* Do various post-verification rewrites in a single program pass.
- * These rewrites simplify JIT and interpreter implementations.
- */
-static int do_misc_fixups(struct bpf_verifier_env *env)
-{
-	struct bpf_prog *prog = env->prog;
-	enum bpf_attach_type eatype = prog->expected_attach_type;
-	enum bpf_prog_type prog_type = resolve_prog_type(prog);
-	struct bpf_insn *insn = prog->insnsi;
-	const struct bpf_func_proto *fn;
-	const int insn_cnt = prog->len;
-	const struct bpf_map_ops *ops;
-	struct bpf_insn_aux_data *aux;
-	struct bpf_insn *insn_buf = env->insn_buf;
-	struct bpf_prog *new_prog;
-	struct bpf_map *map_ptr;
-	int i, ret, cnt, delta = 0, cur_subprog = 0;
-	struct bpf_subprog_info *subprogs = env->subprog_info;
-	u16 stack_depth = subprogs[cur_subprog].stack_depth;
-	u16 stack_depth_extra = 0;
-
-	if (env->seen_exception && !env->exception_callback_subprog) {
-		struct bpf_insn *patch = insn_buf;
-
-		*patch++ = env->prog->insnsi[insn_cnt - 1];
-		*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
-		*patch++ = BPF_EXIT_INSN();
-		ret = add_hidden_subprog(env, insn_buf, patch - insn_buf);
-		if (ret < 0)
-			return ret;
-		prog = env->prog;
-		insn = prog->insnsi;
-
-		env->exception_callback_subprog = env->subprog_cnt - 1;
-		/* Don't update insn_cnt, as add_hidden_subprog always appends insns */
-		mark_subprog_exc_cb(env, env->exception_callback_subprog);
-	}
-
-	for (i = 0; i < insn_cnt;) {
-		if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) && insn->imm) {
-			if ((insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1) ||
-			    (((struct bpf_map *)env->prog->aux->arena)->map_flags & BPF_F_NO_USER_CONV)) {
-				/* convert to 32-bit mov that clears upper 32-bit */
-				insn->code = BPF_ALU | BPF_MOV | BPF_X;
-				/* clear off and imm, so it's a normal 'wX = wY' from JIT pov */
-				insn->off = 0;
-				insn->imm = 0;
-			} /* cast from as(0) to as(1) should be handled by JIT */
-			goto next_insn;
-		}
-
-		if (env->insn_aux_data[i + delta].needs_zext)
-			/* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
-			insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
-
-		/* Make sdiv/smod divide-by-minus-one exceptions impossible. */
-		if ((insn->code == (BPF_ALU64 | BPF_MOD | BPF_K) ||
-		     insn->code == (BPF_ALU64 | BPF_DIV | BPF_K) ||
-		     insn->code == (BPF_ALU | BPF_MOD | BPF_K) ||
-		     insn->code == (BPF_ALU | BPF_DIV | BPF_K)) &&
-		    insn->off == 1 && insn->imm == -1) {
-			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
-			bool isdiv = BPF_OP(insn->code) == BPF_DIV;
-			struct bpf_insn *patch = insn_buf;
-
-			if (isdiv)
-				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-							BPF_NEG | BPF_K, insn->dst_reg,
-							0, 0, 0);
-			else
-				*patch++ = BPF_MOV32_IMM(insn->dst_reg, 0);
-
-			cnt = patch - insn_buf;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		/* Make divide-by-zero and divide-by-minus-one exceptions impossible. */
-		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
-		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
-		    insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
-		    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
-			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
-			bool isdiv = BPF_OP(insn->code) == BPF_DIV;
-			bool is_sdiv = isdiv && insn->off == 1;
-			bool is_smod = !isdiv && insn->off == 1;
-			struct bpf_insn *patch = insn_buf;
-
-			if (is_sdiv) {
-				/* [R,W]x sdiv 0 -> 0
-				 * LLONG_MIN sdiv -1 -> LLONG_MIN
-				 * INT_MIN sdiv -1 -> INT_MIN
-				 */
-				*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
-				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-							BPF_ADD | BPF_K, BPF_REG_AX,
-							0, 0, 1);
-				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
-							BPF_JGT | BPF_K, BPF_REG_AX,
-							0, 4, 1);
-				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
-							BPF_JEQ | BPF_K, BPF_REG_AX,
-							0, 1, 0);
-				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-							BPF_MOV | BPF_K, insn->dst_reg,
-							0, 0, 0);
-				/* BPF_NEG(LLONG_MIN) == -LLONG_MIN == LLONG_MIN */
-				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-							BPF_NEG | BPF_K, insn->dst_reg,
-							0, 0, 0);
-				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
-				*patch++ = *insn;
-				cnt = patch - insn_buf;
-			} else if (is_smod) {
-				/* [R,W]x mod 0 -> [R,W]x */
-				/* [R,W]x mod -1 -> 0 */
-				*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
-				*patch++ = BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
-							BPF_ADD | BPF_K, BPF_REG_AX,
-							0, 0, 1);
-				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
-							BPF_JGT | BPF_K, BPF_REG_AX,
-							0, 3, 1);
-				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
-							BPF_JEQ | BPF_K, BPF_REG_AX,
-							0, 3 + (is64 ? 0 : 1), 1);
-				*patch++ = BPF_MOV32_IMM(insn->dst_reg, 0);
-				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
-				*patch++ = *insn;
-
-				if (!is64) {
-					*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
-					*patch++ = BPF_MOV32_REG(insn->dst_reg, insn->dst_reg);
-				}
-				cnt = patch - insn_buf;
-			} else if (isdiv) {
-				/* [R,W]x div 0 -> 0 */
-				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
-							BPF_JNE | BPF_K, insn->src_reg,
-							0, 2, 0);
-				*patch++ = BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg);
-				*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
-				*patch++ = *insn;
-				cnt = patch - insn_buf;
-			} else {
-				/* [R,W]x mod 0 -> [R,W]x */
-				*patch++ = BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
-							BPF_JEQ | BPF_K, insn->src_reg,
-							0, 1 + (is64 ? 0 : 1), 0);
-				*patch++ = *insn;
-
-				if (!is64) {
-					*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
-					*patch++ = BPF_MOV32_REG(insn->dst_reg, insn->dst_reg);
-				}
-				cnt = patch - insn_buf;
-			}
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		/* Make it impossible to de-reference a userspace address */
-		if (BPF_CLASS(insn->code) == BPF_LDX &&
-		    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
-		     BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
-			struct bpf_insn *patch = insn_buf;
-			u64 uaddress_limit = bpf_arch_uaddress_limit();
-
-			if (!uaddress_limit)
-				goto next_insn;
-
-			*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
-			if (insn->off)
-				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, insn->off);
-			*patch++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_AX, 32);
-			*patch++ = BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, uaddress_limit >> 32, 2);
-			*patch++ = *insn;
-			*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
-			*patch++ = BPF_MOV64_IMM(insn->dst_reg, 0);
-
-			cnt = patch - insn_buf;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		/* Implement LD_ABS and LD_IND with a rewrite, if supported by the program type. */
-		if (BPF_CLASS(insn->code) == BPF_LD &&
-		    (BPF_MODE(insn->code) == BPF_ABS ||
-		     BPF_MODE(insn->code) == BPF_IND)) {
-			cnt = env->ops->gen_ld_abs(insn, insn_buf);
-			if (cnt == 0 || cnt >= INSN_BUF_SIZE) {
-				verifier_bug(env, "%d insns generated for ld_abs", cnt);
-				return -EFAULT;
-			}
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		/* Rewrite pointer arithmetic to mitigate speculation attacks. */
-		if (insn->code == (BPF_ALU64 | BPF_ADD | BPF_X) ||
-		    insn->code == (BPF_ALU64 | BPF_SUB | BPF_X)) {
-			const u8 code_add = BPF_ALU64 | BPF_ADD | BPF_X;
-			const u8 code_sub = BPF_ALU64 | BPF_SUB | BPF_X;
-			struct bpf_insn *patch = insn_buf;
-			bool issrc, isneg, isimm;
-			u32 off_reg;
-
-			aux = &env->insn_aux_data[i + delta];
-			if (!aux->alu_state ||
-			    aux->alu_state == BPF_ALU_NON_POINTER)
-				goto next_insn;
-
-			isneg = aux->alu_state & BPF_ALU_NEG_VALUE;
-			issrc = (aux->alu_state & BPF_ALU_SANITIZE) ==
-				BPF_ALU_SANITIZE_SRC;
-			isimm = aux->alu_state & BPF_ALU_IMMEDIATE;
-
-			off_reg = issrc ? insn->src_reg : insn->dst_reg;
-			if (isimm) {
-				*patch++ = BPF_MOV32_IMM(BPF_REG_AX, aux->alu_limit);
-			} else {
-				if (isneg)
-					*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
-				*patch++ = BPF_MOV32_IMM(BPF_REG_AX, aux->alu_limit);
-				*patch++ = BPF_ALU64_REG(BPF_SUB, BPF_REG_AX, off_reg);
-				*patch++ = BPF_ALU64_REG(BPF_OR, BPF_REG_AX, off_reg);
-				*patch++ = BPF_ALU64_IMM(BPF_NEG, BPF_REG_AX, 0);
-				*patch++ = BPF_ALU64_IMM(BPF_ARSH, BPF_REG_AX, 63);
-				*patch++ = BPF_ALU64_REG(BPF_AND, BPF_REG_AX, off_reg);
-			}
-			if (!issrc)
-				*patch++ = BPF_MOV64_REG(insn->dst_reg, insn->src_reg);
-			insn->src_reg = BPF_REG_AX;
-			if (isneg)
-				insn->code = insn->code == code_add ?
-					     code_sub : code_add;
-			*patch++ = *insn;
-			if (issrc && isneg && !isimm)
-				*patch++ = BPF_ALU64_IMM(BPF_MUL, off_reg, -1);
-			cnt = patch - insn_buf;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		if (bpf_is_may_goto_insn(insn) && bpf_jit_supports_timed_may_goto()) {
-			int stack_off_cnt = -stack_depth - 16;
-
-			/*
-			 * Two 8 byte slots, depth-16 stores the count, and
-			 * depth-8 stores the start timestamp of the loop.
-			 *
-			 * The starting value of count is BPF_MAX_TIMED_LOOPS
-			 * (0xffff).  Every iteration loads it and subs it by 1,
-			 * until the value becomes 0 in AX (thus, 1 in stack),
-			 * after which we call arch_bpf_timed_may_goto, which
-			 * either sets AX to 0xffff to keep looping, or to 0
-			 * upon timeout. AX is then stored into the stack. In
-			 * the next iteration, we either see 0 and break out, or
-			 * continue iterating until the next time value is 0
-			 * after subtraction, rinse and repeat.
-			 */
-			stack_depth_extra = 16;
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off_cnt);
-			if (insn->off >= 0)
-				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 5);
-			else
-				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
-			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
-			insn_buf[3] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
-			/*
-			 * AX is used as an argument to pass in stack_off_cnt
-			 * (to add to r10/fp), and also as the return value of
-			 * the call to arch_bpf_timed_may_goto.
-			 */
-			insn_buf[4] = BPF_MOV64_IMM(BPF_REG_AX, stack_off_cnt);
-			insn_buf[5] = BPF_EMIT_CALL(arch_bpf_timed_may_goto);
-			insn_buf[6] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt);
-			cnt = 7;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta += cnt - 1;
-			env->prog = prog = new_prog;
-			insn = new_prog->insnsi + i + delta;
-			goto next_insn;
-		} else if (bpf_is_may_goto_insn(insn)) {
-			int stack_off = -stack_depth - 8;
-
-			stack_depth_extra = 8;
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
-			if (insn->off >= 0)
-				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 2);
-			else
-				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
-			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
-			insn_buf[3] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
-			cnt = 4;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta += cnt - 1;
-			env->prog = prog = new_prog;
-			insn = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		if (insn->code != (BPF_JMP | BPF_CALL))
-			goto next_insn;
-		if (insn->src_reg == BPF_PSEUDO_CALL)
-			goto next_insn;
-		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-			ret = fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
-			if (ret)
-				return ret;
-			if (cnt == 0)
-				goto next_insn;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta	 += cnt - 1;
-			env->prog = prog = new_prog;
-			insn	  = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		/* Skip inlining the helper call if the JIT does it. */
-		if (bpf_jit_inlines_helper_call(insn->imm))
-			goto next_insn;
-
-		if (insn->imm == BPF_FUNC_get_route_realm)
-			prog->dst_needed = 1;
-		if (insn->imm == BPF_FUNC_get_prandom_u32)
-			bpf_user_rnd_init_once();
-		if (insn->imm == BPF_FUNC_override_return)
-			prog->kprobe_override = 1;
-		if (insn->imm == BPF_FUNC_tail_call) {
-			/* If we tail call into other programs, we
-			 * cannot make any assumptions since they can
-			 * be replaced dynamically during runtime in
-			 * the program array.
-			 */
-			prog->cb_access = 1;
-			if (!allow_tail_call_in_subprogs(env))
-				prog->aux->stack_depth = MAX_BPF_STACK;
-			prog->aux->max_pkt_offset = MAX_PACKET_OFF;
-
-			/* mark bpf_tail_call as different opcode to avoid
-			 * conditional branch in the interpreter for every normal
-			 * call and to prevent accidental JITing by JIT compiler
-			 * that doesn't support bpf_tail_call yet
-			 */
-			insn->imm = 0;
-			insn->code = BPF_JMP | BPF_TAIL_CALL;
-
-			aux = &env->insn_aux_data[i + delta];
-			if (env->bpf_capable && !prog->blinding_requested &&
-			    prog->jit_requested &&
-			    !bpf_map_key_poisoned(aux) &&
-			    !bpf_map_ptr_poisoned(aux) &&
-			    !bpf_map_ptr_unpriv(aux)) {
-				struct bpf_jit_poke_descriptor desc = {
-					.reason = BPF_POKE_REASON_TAIL_CALL,
-					.tail_call.map = aux->map_ptr_state.map_ptr,
-					.tail_call.key = bpf_map_key_immediate(aux),
-					.insn_idx = i + delta,
-				};
-
-				ret = bpf_jit_add_poke_descriptor(prog, &desc);
-				if (ret < 0) {
-					verbose(env, "adding tail call poke descriptor failed\n");
-					return ret;
-				}
-
-				insn->imm = ret + 1;
-				goto next_insn;
-			}
-
-			if (!bpf_map_ptr_unpriv(aux))
-				goto next_insn;
-
-			/* instead of changing every JIT dealing with tail_call
-			 * emit two extra insns:
-			 * if (index >= max_entries) goto out;
-			 * index &= array->index_mask;
-			 * to avoid out-of-bounds cpu speculation
-			 */
-			if (bpf_map_ptr_poisoned(aux)) {
-				verbose(env, "tail_call abusing map_ptr\n");
-				return -EINVAL;
-			}
-
-			map_ptr = aux->map_ptr_state.map_ptr;
-			insn_buf[0] = BPF_JMP_IMM(BPF_JGE, BPF_REG_3,
-						  map_ptr->max_entries, 2);
-			insn_buf[1] = BPF_ALU32_IMM(BPF_AND, BPF_REG_3,
-						    container_of(map_ptr,
-								 struct bpf_array,
-								 map)->index_mask);
-			insn_buf[2] = *insn;
-			cnt = 3;
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		if (insn->imm == BPF_FUNC_timer_set_callback) {
-			/* The verifier will process callback_fn as many times as necessary
-			 * with different maps and the register states prepared by
-			 * set_timer_callback_state will be accurate.
-			 *
-			 * The following use case is valid:
-			 *   map1 is shared by prog1, prog2, prog3.
-			 *   prog1 calls bpf_timer_init for some map1 elements
-			 *   prog2 calls bpf_timer_set_callback for some map1 elements.
-			 *     Those that were not bpf_timer_init-ed will return -EINVAL.
-			 *   prog3 calls bpf_timer_start for some map1 elements.
-			 *     Those that were not both bpf_timer_init-ed and
-			 *     bpf_timer_set_callback-ed will return -EINVAL.
-			 */
-			struct bpf_insn ld_addrs[2] = {
-				BPF_LD_IMM64(BPF_REG_3, (long)prog->aux),
-			};
-
-			insn_buf[0] = ld_addrs[0];
-			insn_buf[1] = ld_addrs[1];
-			insn_buf[2] = *insn;
-			cnt = 3;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto patch_call_imm;
-		}
-
-		/* bpf_per_cpu_ptr() and bpf_this_cpu_ptr() */
-		if (env->insn_aux_data[i + delta].call_with_percpu_alloc_ptr) {
-			/* patch with 'r1 = *(u64 *)(r1 + 0)' since for percpu data,
-			 * bpf_mem_alloc() returns a ptr to the percpu data ptr.
-			 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
-			insn_buf[1] = *insn;
-			cnt = 2;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta += cnt - 1;
-			env->prog = prog = new_prog;
-			insn = new_prog->insnsi + i + delta;
-			goto patch_call_imm;
-		}
-
-		/* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
-		 * and other inlining handlers are currently limited to 64 bit
-		 * only.
-		 */
-		if (prog->jit_requested && BITS_PER_LONG == 64 &&
-		    (insn->imm == BPF_FUNC_map_lookup_elem ||
-		     insn->imm == BPF_FUNC_map_update_elem ||
-		     insn->imm == BPF_FUNC_map_delete_elem ||
-		     insn->imm == BPF_FUNC_map_push_elem   ||
-		     insn->imm == BPF_FUNC_map_pop_elem    ||
-		     insn->imm == BPF_FUNC_map_peek_elem   ||
-		     insn->imm == BPF_FUNC_redirect_map    ||
-		     insn->imm == BPF_FUNC_for_each_map_elem ||
-		     insn->imm == BPF_FUNC_map_lookup_percpu_elem)) {
-			aux = &env->insn_aux_data[i + delta];
-			if (bpf_map_ptr_poisoned(aux))
-				goto patch_call_imm;
-
-			map_ptr = aux->map_ptr_state.map_ptr;
-			ops = map_ptr->ops;
-			if (insn->imm == BPF_FUNC_map_lookup_elem &&
-			    ops->map_gen_lookup) {
-				cnt = ops->map_gen_lookup(map_ptr, insn_buf);
-				if (cnt == -EOPNOTSUPP)
-					goto patch_map_ops_generic;
-				if (cnt <= 0 || cnt >= INSN_BUF_SIZE) {
-					verifier_bug(env, "%d insns generated for map lookup", cnt);
-					return -EFAULT;
-				}
-
-				new_prog = bpf_patch_insn_data(env, i + delta,
-							       insn_buf, cnt);
-				if (!new_prog)
-					return -ENOMEM;
-
-				delta    += cnt - 1;
-				env->prog = prog = new_prog;
-				insn      = new_prog->insnsi + i + delta;
-				goto next_insn;
-			}
-
-			BUILD_BUG_ON(!__same_type(ops->map_lookup_elem,
-				     (void *(*)(struct bpf_map *map, void *key))NULL));
-			BUILD_BUG_ON(!__same_type(ops->map_delete_elem,
-				     (long (*)(struct bpf_map *map, void *key))NULL));
-			BUILD_BUG_ON(!__same_type(ops->map_update_elem,
-				     (long (*)(struct bpf_map *map, void *key, void *value,
-					      u64 flags))NULL));
-			BUILD_BUG_ON(!__same_type(ops->map_push_elem,
-				     (long (*)(struct bpf_map *map, void *value,
-					      u64 flags))NULL));
-			BUILD_BUG_ON(!__same_type(ops->map_pop_elem,
-				     (long (*)(struct bpf_map *map, void *value))NULL));
-			BUILD_BUG_ON(!__same_type(ops->map_peek_elem,
-				     (long (*)(struct bpf_map *map, void *value))NULL));
-			BUILD_BUG_ON(!__same_type(ops->map_redirect,
-				     (long (*)(struct bpf_map *map, u64 index, u64 flags))NULL));
-			BUILD_BUG_ON(!__same_type(ops->map_for_each_callback,
-				     (long (*)(struct bpf_map *map,
-					      bpf_callback_t callback_fn,
-					      void *callback_ctx,
-					      u64 flags))NULL));
-			BUILD_BUG_ON(!__same_type(ops->map_lookup_percpu_elem,
-				     (void *(*)(struct bpf_map *map, void *key, u32 cpu))NULL));
-
-patch_map_ops_generic:
-			switch (insn->imm) {
-			case BPF_FUNC_map_lookup_elem:
-				insn->imm = BPF_CALL_IMM(ops->map_lookup_elem);
-				goto next_insn;
-			case BPF_FUNC_map_update_elem:
-				insn->imm = BPF_CALL_IMM(ops->map_update_elem);
-				goto next_insn;
-			case BPF_FUNC_map_delete_elem:
-				insn->imm = BPF_CALL_IMM(ops->map_delete_elem);
-				goto next_insn;
-			case BPF_FUNC_map_push_elem:
-				insn->imm = BPF_CALL_IMM(ops->map_push_elem);
-				goto next_insn;
-			case BPF_FUNC_map_pop_elem:
-				insn->imm = BPF_CALL_IMM(ops->map_pop_elem);
-				goto next_insn;
-			case BPF_FUNC_map_peek_elem:
-				insn->imm = BPF_CALL_IMM(ops->map_peek_elem);
-				goto next_insn;
-			case BPF_FUNC_redirect_map:
-				insn->imm = BPF_CALL_IMM(ops->map_redirect);
-				goto next_insn;
-			case BPF_FUNC_for_each_map_elem:
-				insn->imm = BPF_CALL_IMM(ops->map_for_each_callback);
-				goto next_insn;
-			case BPF_FUNC_map_lookup_percpu_elem:
-				insn->imm = BPF_CALL_IMM(ops->map_lookup_percpu_elem);
-				goto next_insn;
-			}
-
-			goto patch_call_imm;
-		}
-
-		/* Implement bpf_jiffies64 inline. */
-		if (prog->jit_requested && BITS_PER_LONG == 64 &&
-		    insn->imm == BPF_FUNC_jiffies64) {
-			struct bpf_insn ld_jiffies_addr[2] = {
-				BPF_LD_IMM64(BPF_REG_0,
-					     (unsigned long)&jiffies),
-			};
-
-			insn_buf[0] = ld_jiffies_addr[0];
-			insn_buf[1] = ld_jiffies_addr[1];
-			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0,
-						  BPF_REG_0, 0);
-			cnt = 3;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf,
-						       cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
-		/* Implement bpf_get_smp_processor_id() inline. */
-		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
-		    verifier_inlines_helper_call(env, insn->imm)) {
-			/* BPF_FUNC_get_smp_processor_id inlining is an
-			 * optimization, so if cpu_number is ever
-			 * changed in some incompatible and hard to support
-			 * way, it's fine to back out this inlining logic
-			 */
-#ifdef CONFIG_SMP
-			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&cpu_number);
-			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
-			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
-			cnt = 3;
-#else
-			insn_buf[0] = BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0);
-			cnt = 1;
-#endif
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		/* Implement bpf_get_current_task() and bpf_get_current_task_btf() inline. */
-		if ((insn->imm == BPF_FUNC_get_current_task || insn->imm == BPF_FUNC_get_current_task_btf) &&
-		    verifier_inlines_helper_call(env, insn->imm)) {
-			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&current_task);
-			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
-			insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
-			cnt = 3;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-#endif
-		/* Implement bpf_get_func_arg inline. */
-		if (prog_type == BPF_PROG_TYPE_TRACING &&
-		    insn->imm == BPF_FUNC_get_func_arg) {
-			if (eatype == BPF_TRACE_RAW_TP) {
-				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
-
-				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
-				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
-				cnt = 1;
-			} else {
-				/* Load nr_args from ctx - 8 */
-				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
-				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
-				cnt = 2;
-			}
-			insn_buf[cnt++] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
-			insn_buf[cnt++] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
-			insn_buf[cnt++] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
-			insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
-			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
-			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, 0);
-			insn_buf[cnt++] = BPF_JMP_A(1);
-			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		/* Implement bpf_get_func_ret inline. */
-		if (prog_type == BPF_PROG_TYPE_TRACING &&
-		    insn->imm == BPF_FUNC_get_func_ret) {
-			if (eatype == BPF_TRACE_FEXIT ||
-			    eatype == BPF_TRACE_FSESSION ||
-			    eatype == BPF_MODIFY_RETURN) {
-				/* Load nr_args from ctx - 8 */
-				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
-				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
-				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
-				insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
-				insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
-				insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
-				insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
-				cnt = 7;
-			} else {
-				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
-				cnt = 1;
-			}
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		/* Implement get_func_arg_cnt inline. */
-		if (prog_type == BPF_PROG_TYPE_TRACING &&
-		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
-			if (eatype == BPF_TRACE_RAW_TP) {
-				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
-
-				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
-				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
-				cnt = 1;
-			} else {
-				/* Load nr_args from ctx - 8 */
-				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
-				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
-				cnt = 2;
-			}
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		/* Implement bpf_get_func_ip inline. */
-		if (prog_type == BPF_PROG_TYPE_TRACING &&
-		    insn->imm == BPF_FUNC_get_func_ip) {
-			/* Load IP address from ctx - 16 */
-			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -16);
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
-			if (!new_prog)
-				return -ENOMEM;
-
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		/* Implement bpf_get_branch_snapshot inline. */
-		if (IS_ENABLED(CONFIG_PERF_EVENTS) &&
-		    prog->jit_requested && BITS_PER_LONG == 64 &&
-		    insn->imm == BPF_FUNC_get_branch_snapshot) {
-			/* We are dealing with the following func protos:
-			 * u64 bpf_get_branch_snapshot(void *buf, u32 size, u64 flags);
-			 * int perf_snapshot_branch_stack(struct perf_branch_entry *entries, u32 cnt);
-			 */
-			const u32 br_entry_size = sizeof(struct perf_branch_entry);
-
-			/* struct perf_branch_entry is part of UAPI and is
-			 * used as an array element, so extremely unlikely to
-			 * ever grow or shrink
-			 */
-			BUILD_BUG_ON(br_entry_size != 24);
-
-			/* if (unlikely(flags)) return -EINVAL */
-			insn_buf[0] = BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 0, 7);
-
-			/* Transform size (bytes) into number of entries (cnt = size / 24).
-			 * But to avoid expensive division instruction, we implement
-			 * divide-by-3 through multiplication, followed by further
-			 * division by 8 through 3-bit right shift.
-			 * Refer to book "Hacker's Delight, 2nd ed." by Henry S. Warren, Jr.,
-			 * p. 227, chapter "Unsigned Division by 3" for details and proofs.
-			 *
-			 * N / 3 <=> M * N / 2^33, where M = (2^33 + 1) / 3 = 0xaaaaaaab.
-			 */
-			insn_buf[1] = BPF_MOV32_IMM(BPF_REG_0, 0xaaaaaaab);
-			insn_buf[2] = BPF_ALU64_REG(BPF_MUL, BPF_REG_2, BPF_REG_0);
-			insn_buf[3] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_2, 36);
-
-			/* call perf_snapshot_branch_stack implementation */
-			insn_buf[4] = BPF_EMIT_CALL(static_call_query(perf_snapshot_branch_stack));
-			/* if (entry_cnt == 0) return -ENOENT */
-			insn_buf[5] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4);
-			/* return entry_cnt * sizeof(struct perf_branch_entry) */
-			insn_buf[6] = BPF_ALU32_IMM(BPF_MUL, BPF_REG_0, br_entry_size);
-			insn_buf[7] = BPF_JMP_A(3);
-			/* return -EINVAL; */
-			insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
-			insn_buf[9] = BPF_JMP_A(1);
-			/* return -ENOENT; */
-			insn_buf[10] = BPF_MOV64_IMM(BPF_REG_0, -ENOENT);
-			cnt = 11;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-
-		/* Implement bpf_kptr_xchg inline */
-		if (prog->jit_requested && BITS_PER_LONG == 64 &&
-		    insn->imm == BPF_FUNC_kptr_xchg &&
-		    bpf_jit_supports_ptr_xchg()) {
-			insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
-			insn_buf[1] = BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0, 0);
-			cnt = 2;
-
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta    += cnt - 1;
-			env->prog = prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			goto next_insn;
-		}
-patch_call_imm:
-		fn = env->ops->get_func_proto(insn->imm, env->prog);
-		/* all functions that have prototype and verifier allowed
-		 * programs to call them, must be real in-kernel functions
-		 */
-		if (!fn->func) {
-			verifier_bug(env,
-				     "not inlined functions %s#%d is missing func",
-				     func_id_name(insn->imm), insn->imm);
-			return -EFAULT;
-		}
-		insn->imm = fn->func - __bpf_call_base;
-next_insn:
-		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
-			subprogs[cur_subprog].stack_depth += stack_depth_extra;
-			subprogs[cur_subprog].stack_extra = stack_depth_extra;
-
-			stack_depth = subprogs[cur_subprog].stack_depth;
-			if (stack_depth > MAX_BPF_STACK && !prog->jit_requested) {
-				verbose(env, "stack size %d(extra %d) is too large\n",
-					stack_depth, stack_depth_extra);
-				return -EINVAL;
-			}
-			cur_subprog++;
-			stack_depth = subprogs[cur_subprog].stack_depth;
-			stack_depth_extra = 0;
-		}
-		i++;
-		insn++;
-	}
-
-	env->prog->aux->stack_depth = subprogs[0].stack_depth;
-	for (i = 0; i < env->subprog_cnt; i++) {
-		int delta = bpf_jit_supports_timed_may_goto() ? 2 : 1;
-		int subprog_start = subprogs[i].start;
-		int stack_slots = subprogs[i].stack_extra / 8;
-		int slots = delta, cnt = 0;
-
-		if (!stack_slots)
-			continue;
-		/* We need two slots in case timed may_goto is supported. */
-		if (stack_slots > slots) {
-			verifier_bug(env, "stack_slots supports may_goto only");
-			return -EFAULT;
-		}
-
-		stack_depth = subprogs[i].stack_depth;
-		if (bpf_jit_supports_timed_may_goto()) {
-			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
-						     BPF_MAX_TIMED_LOOPS);
-			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth + 8, 0);
-		} else {
-			/* Add ST insn to subprog prologue to init extra stack */
-			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
-						     BPF_MAX_LOOPS);
-		}
-		/* Copy first actual insn to preserve it */
-		insn_buf[cnt++] = env->prog->insnsi[subprog_start];
-
-		new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, cnt);
-		if (!new_prog)
-			return -ENOMEM;
-		env->prog = prog = new_prog;
-		/*
-		 * If may_goto is a first insn of a prog there could be a jmp
-		 * insn that points to it, hence adjust all such jmps to point
-		 * to insn after BPF_ST that inits may_goto count.
-		 * Adjustment will succeed because bpf_patch_insn_data() didn't fail.
-		 */
-		WARN_ON(adjust_jmp_off(env->prog, subprog_start, delta));
-	}
-
-	/* Since poke tab is now finalized, publish aux to tracker. */
-	for (i = 0; i < prog->aux->size_poke_tab; i++) {
-		map_ptr = prog->aux->poke_tab[i].tail_call.map;
-		if (!map_ptr->ops->map_poke_track ||
-		    !map_ptr->ops->map_poke_untrack ||
-		    !map_ptr->ops->map_poke_run) {
-			verifier_bug(env, "poke tab is misconfigured");
-			return -EFAULT;
-		}
-
-		ret = map_ptr->ops->map_poke_track(map_ptr, prog->aux);
-		if (ret < 0) {
-			verbose(env, "tracking tail call prog failed\n");
-			return ret;
-		}
-	}
-
-	ret = sort_kfunc_descs_by_imm_off(env);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
-					int position,
-					s32 stack_base,
-					u32 callback_subprogno,
-					u32 *total_cnt)
-{
-	s32 r6_offset = stack_base + 0 * BPF_REG_SIZE;
-	s32 r7_offset = stack_base + 1 * BPF_REG_SIZE;
-	s32 r8_offset = stack_base + 2 * BPF_REG_SIZE;
-	int reg_loop_max = BPF_REG_6;
-	int reg_loop_cnt = BPF_REG_7;
-	int reg_loop_ctx = BPF_REG_8;
-
-	struct bpf_insn *insn_buf = env->insn_buf;
-	struct bpf_prog *new_prog;
-	u32 callback_start;
-	u32 call_insn_offset;
-	s32 callback_offset;
-	u32 cnt = 0;
-
-	/* This represents an inlined version of bpf_iter.c:bpf_loop,
-	 * be careful to modify this code in sync.
-	 */
-
-	/* Return error and jump to the end of the patch if
-	 * expected number of iterations is too big.
-	 */
-	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);
-	insn_buf[cnt++] = BPF_MOV32_IMM(BPF_REG_0, -E2BIG);
-	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JA, 0, 0, 16);
-	/* spill R6, R7, R8 to use these as loop vars */
-	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset);
-	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_7, r7_offset);
-	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset);
-	/* initialize loop vars */
-	insn_buf[cnt++] = BPF_MOV64_REG(reg_loop_max, BPF_REG_1);
-	insn_buf[cnt++] = BPF_MOV32_IMM(reg_loop_cnt, 0);
-	insn_buf[cnt++] = BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3);
-	/* loop header,
-	 * if reg_loop_cnt >= reg_loop_max skip the loop body
-	 */
-	insn_buf[cnt++] = BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5);
-	/* callback call,
-	 * correct callback offset would be set after patching
-	 */
-	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_1, reg_loop_cnt);
-	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_2, reg_loop_ctx);
-	insn_buf[cnt++] = BPF_CALL_REL(0);
-	/* increment loop counter */
-	insn_buf[cnt++] = BPF_ALU64_IMM(BPF_ADD, reg_loop_cnt, 1);
-	/* jump to loop header if callback returned 0 */
-	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -6);
-	/* return value of bpf_loop,
-	 * set R0 to the number of iterations
-	 */
-	insn_buf[cnt++] = BPF_MOV64_REG(BPF_REG_0, reg_loop_cnt);
-	/* restore original values of R6, R7, R8 */
-	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_10, r6_offset);
-	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset);
-	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
-
-	*total_cnt = cnt;
-	new_prog = bpf_patch_insn_data(env, position, insn_buf, cnt);
-	if (!new_prog)
-		return new_prog;
-
-	/* callback start is known only after patching */
-	callback_start = env->subprog_info[callback_subprogno].start;
-	/* Note: insn_buf[12] is an offset of BPF_CALL_REL instruction */
-	call_insn_offset = position + 12;
-	callback_offset = callback_start - call_insn_offset - 1;
-	new_prog->insnsi[call_insn_offset].imm = callback_offset;
-
-	return new_prog;
-}
-
-static bool is_bpf_loop_call(struct bpf_insn *insn)
-{
-	return insn->code == (BPF_JMP | BPF_CALL) &&
-		insn->src_reg == 0 &&
-		insn->imm == BPF_FUNC_loop;
-}
-
-/* For all sub-programs in the program (including main) check
- * insn_aux_data to see if there are bpf_loop calls that require
- * inlining. If such calls are found the calls are replaced with a
- * sequence of instructions produced by `inline_bpf_loop` function and
- * subprog stack_depth is increased by the size of 3 registers.
- * This stack space is used to spill values of the R6, R7, R8.  These
- * registers are used to store the loop bound, counter and context
- * variables.
- */
-static int optimize_bpf_loop(struct bpf_verifier_env *env)
-{
-	struct bpf_subprog_info *subprogs = env->subprog_info;
-	int i, cur_subprog = 0, cnt, delta = 0;
-	struct bpf_insn *insn = env->prog->insnsi;
-	int insn_cnt = env->prog->len;
-	u16 stack_depth = subprogs[cur_subprog].stack_depth;
-	u16 stack_depth_roundup = round_up(stack_depth, 8) - stack_depth;
-	u16 stack_depth_extra = 0;
-
-	for (i = 0; i < insn_cnt; i++, insn++) {
-		struct bpf_loop_inline_state *inline_state =
-			&env->insn_aux_data[i + delta].loop_inline_state;
-
-		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline) {
-			struct bpf_prog *new_prog;
-
-			stack_depth_extra = BPF_REG_SIZE * 3 + stack_depth_roundup;
-			new_prog = inline_bpf_loop(env,
-						   i + delta,
-						   -(stack_depth + stack_depth_extra),
-						   inline_state->callback_subprogno,
-						   &cnt);
-			if (!new_prog)
-				return -ENOMEM;
-
-			delta     += cnt - 1;
-			env->prog  = new_prog;
-			insn       = new_prog->insnsi + i + delta;
-		}
-
-		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
-			subprogs[cur_subprog].stack_depth += stack_depth_extra;
-			cur_subprog++;
-			stack_depth = subprogs[cur_subprog].stack_depth;
-			stack_depth_roundup = round_up(stack_depth, 8) - stack_depth;
-			stack_depth_extra = 0;
-		}
-	}
-
-	env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
-
-	return 0;
-}
-
-/* Remove unnecessary spill/fill pairs, members of fastcall pattern,
- * adjust subprograms stack depth when possible.
- */
-static int remove_fastcall_spills_fills(struct bpf_verifier_env *env)
-{
-	struct bpf_subprog_info *subprog = env->subprog_info;
-	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	struct bpf_insn *insn = env->prog->insnsi;
-	int insn_cnt = env->prog->len;
-	u32 spills_num;
-	bool modified = false;
-	int i, j;
-
-	for (i = 0; i < insn_cnt; i++, insn++) {
-		if (aux[i].fastcall_spills_num > 0) {
-			spills_num = aux[i].fastcall_spills_num;
-			/* NOPs would be removed by opt_remove_nops() */
-			for (j = 1; j <= spills_num; ++j) {
-				*(insn - j) = NOP;
-				*(insn + j) = NOP;
-			}
-			modified = true;
-		}
-		if ((subprog + 1)->start == i + 1) {
-			if (modified && !subprog->keep_fastcall_stack)
-				subprog->stack_depth = -subprog->fastcall_stack_off;
-			subprog++;
-			modified = false;
-		}
-	}
-
-	return 0;
-}
 
 static void free_states(struct bpf_verifier_env *env)
 {
@@ -26592,6 +23892,211 @@ static int compute_scc(struct bpf_verifier_env *env)
 	return err;
 }
 
+/* replace a generic kfunc with a specialized version if necessary */
+static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc, int insn_idx)
+{
+	struct bpf_prog *prog = env->prog;
+	bool seen_direct_write;
+	void *xdp_kfunc;
+	bool is_rdonly;
+	u32 func_id = desc->func_id;
+	u16 offset = desc->offset;
+	unsigned long addr = desc->addr;
+
+	if (offset) /* return if module BTF is used */
+		return 0;
+
+	if (bpf_dev_bound_kfunc_id(func_id)) {
+		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
+		if (xdp_kfunc)
+			addr = (unsigned long)xdp_kfunc;
+		/* fallback to default kfunc when not supported by netdev */
+	} else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
+		seen_direct_write = env->seen_direct_write;
+		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
+
+		if (is_rdonly)
+			addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
+
+		/* restore env->seen_direct_write to its original value, since
+		 * may_access_direct_pkt_data mutates it
+		 */
+		env->seen_direct_write = seen_direct_write;
+	} else if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr]) {
+		if (bpf_lsm_has_d_inode_locked(prog))
+			addr = (unsigned long)bpf_set_dentry_xattr_locked;
+	} else if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr]) {
+		if (bpf_lsm_has_d_inode_locked(prog))
+			addr = (unsigned long)bpf_remove_dentry_xattr_locked;
+	} else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
+		if (!env->insn_aux_data[insn_idx].non_sleepable)
+			addr = (unsigned long)bpf_dynptr_from_file_sleepable;
+	} else if (func_id == special_kfunc_list[KF_bpf_arena_alloc_pages]) {
+		if (env->insn_aux_data[insn_idx].non_sleepable)
+			addr = (unsigned long)bpf_arena_alloc_pages_non_sleepable;
+	} else if (func_id == special_kfunc_list[KF_bpf_arena_free_pages]) {
+		if (env->insn_aux_data[insn_idx].non_sleepable)
+			addr = (unsigned long)bpf_arena_free_pages_non_sleepable;
+	}
+	desc->addr = addr;
+	return 0;
+}
+
+static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
+					    u16 struct_meta_reg,
+					    u16 node_offset_reg,
+					    struct bpf_insn *insn,
+					    struct bpf_insn *insn_buf,
+					    int *cnt)
+{
+	struct btf_struct_meta *kptr_struct_meta = insn_aux->kptr_struct_meta;
+	struct bpf_insn addr[2] = { BPF_LD_IMM64(struct_meta_reg, (long)kptr_struct_meta) };
+
+	insn_buf[0] = addr[0];
+	insn_buf[1] = addr[1];
+	insn_buf[2] = BPF_MOV64_IMM(node_offset_reg, insn_aux->insert_off);
+	insn_buf[3] = *insn;
+	*cnt = 4;
+}
+
+int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
+{
+	struct bpf_kfunc_desc *desc;
+	int err;
+
+	if (!insn->imm) {
+		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
+		return -EINVAL;
+	}
+
+	*cnt = 0;
+
+	/* insn->imm has the btf func_id. Replace it with an offset relative to
+	 * __bpf_call_base, unless the JIT needs to call functions that are
+	 * further than 32 bits away (bpf_jit_supports_far_kfunc_call()).
+	 */
+	desc = find_kfunc_desc(env->prog, insn->imm, insn->off);
+	if (!desc) {
+		verifier_bug(env, "kernel function descriptor not found for func_id %u",
+			     insn->imm);
+		return -EFAULT;
+	}
+
+	err = specialize_kfunc(env, desc, insn_idx);
+	if (err)
+		return err;
+
+	if (!bpf_jit_supports_far_kfunc_call())
+		insn->imm = BPF_CALL_IMM(desc->addr);
+
+	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(desc->func_id)) {
+		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
+		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
+		u64 obj_new_size = env->insn_aux_data[insn_idx].obj_new_size;
+
+		if (is_bpf_percpu_obj_new_kfunc(desc->func_id) && kptr_struct_meta) {
+			verifier_bug(env, "NULL kptr_struct_meta expected at insn_idx %d",
+				     insn_idx);
+			return -EFAULT;
+		}
+
+		insn_buf[0] = BPF_MOV64_IMM(BPF_REG_1, obj_new_size);
+		insn_buf[1] = addr[0];
+		insn_buf[2] = addr[1];
+		insn_buf[3] = *insn;
+		*cnt = 4;
+	} else if (is_bpf_obj_drop_kfunc(desc->func_id) ||
+		   is_bpf_percpu_obj_drop_kfunc(desc->func_id) ||
+		   is_bpf_refcount_acquire_kfunc(desc->func_id)) {
+		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
+		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
+
+		if (is_bpf_percpu_obj_drop_kfunc(desc->func_id) && kptr_struct_meta) {
+			verifier_bug(env, "NULL kptr_struct_meta expected at insn_idx %d",
+				     insn_idx);
+			return -EFAULT;
+		}
+
+		if (is_bpf_refcount_acquire_kfunc(desc->func_id) && !kptr_struct_meta) {
+			verifier_bug(env, "kptr_struct_meta expected at insn_idx %d",
+				     insn_idx);
+			return -EFAULT;
+		}
+
+		insn_buf[0] = addr[0];
+		insn_buf[1] = addr[1];
+		insn_buf[2] = *insn;
+		*cnt = 3;
+	} else if (is_bpf_list_push_kfunc(desc->func_id) ||
+		   is_bpf_rbtree_add_kfunc(desc->func_id)) {
+		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
+		int struct_meta_reg = BPF_REG_3;
+		int node_offset_reg = BPF_REG_4;
+
+		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
+		if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
+			struct_meta_reg = BPF_REG_4;
+			node_offset_reg = BPF_REG_5;
+		}
+
+		if (!kptr_struct_meta) {
+			verifier_bug(env, "kptr_struct_meta expected at insn_idx %d",
+				     insn_idx);
+			return -EFAULT;
+		}
+
+		__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
+						node_offset_reg, insn, insn_buf, cnt);
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
+		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
+		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/*
+		 * inline the bpf_session_is_return() for fsession:
+		 *   bool bpf_session_is_return(void *ctx)
+		 *   {
+		 *       return (((u64 *)ctx)[-1] >> BPF_TRAMP_IS_RETURN_SHIFT) & 1;
+		 *   }
+		 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_IS_RETURN_SHIFT);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
+		*cnt = 3;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_cookie] &&
+		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
+		/*
+		 * inline bpf_session_cookie() for fsession:
+		 *   __u64 *bpf_session_cookie(void *ctx)
+		 *   {
+		 *       u64 off = (((u64 *)ctx)[-1] >> BPF_TRAMP_COOKIE_INDEX_SHIFT) & 0xFF;
+		 *       return &((u64 *)ctx)[-off];
+		 *   }
+		 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_COOKIE_INDEX_SHIFT);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+		insn_buf[3] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
+		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
+		*cnt = 6;
+	}
+
+	if (env->insn_aux_data[insn_idx].arg_prog) {
+		u32 regno = env->insn_aux_data[insn_idx].arg_prog;
+		struct bpf_insn ld_addrs[2] = { BPF_LD_IMM64(regno, (long)env->prog->aux) };
+		int idx = *cnt;
+
+		insn_buf[idx++] = ld_addrs[0];
+		insn_buf[idx++] = ld_addrs[1];
+		insn_buf[idx++] = *insn;
+		*cnt = idx;
+	}
+	return 0;
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	u64 start_time = ktime_get_ns();
@@ -26763,22 +24268,22 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	 * allocate additional slots.
 	 */
 	if (ret == 0)
-		ret = remove_fastcall_spills_fills(env);
+		ret = bpf_remove_fastcall_spills_fills(env);
 
 	if (ret == 0)
 		ret = check_max_stack_depth(env);
 
 	/* instruction rewrites happen after this point */
 	if (ret == 0)
-		ret = optimize_bpf_loop(env);
+		ret = bpf_optimize_bpf_loop(env);
 
 	if (is_priv) {
 		if (ret == 0)
-			opt_hard_wire_dead_code_branches(env);
+			bpf_opt_hard_wire_dead_code_branches(env);
 		if (ret == 0)
-			ret = opt_remove_dead_code(env);
+			ret = bpf_opt_remove_dead_code(env);
 		if (ret == 0)
-			ret = opt_remove_nops(env);
+			ret = bpf_opt_remove_nops(env);
 	} else {
 		if (ret == 0)
 			sanitize_dead_code(env);
@@ -26786,22 +24291,22 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 
 	if (ret == 0)
 		/* program is valid, convert *(u32*)(ctx + off) accesses */
-		ret = convert_ctx_accesses(env);
+		ret = bpf_convert_ctx_accesses(env);
 
 	if (ret == 0)
-		ret = do_misc_fixups(env);
+		ret = bpf_do_misc_fixups(env);
 
 	/* do 32-bit optimization after insn patching has done so those patched
 	 * insns could be handled correctly.
 	 */
 	if (ret == 0 && !bpf_prog_is_offloaded(env->prog->aux)) {
-		ret = opt_subreg_zext_lo32_rnd_hi32(env, attr);
+		ret = bpf_opt_subreg_zext_lo32_rnd_hi32(env, attr);
 		env->prog->aux->verifier_zext = bpf_jit_needs_zext() ? !ret
 								     : false;
 	}
 
 	if (ret == 0)
-		ret = fixup_call_args(env);
+		ret = bpf_fixup_call_args(env);
 
 	env->verification_time = ktime_get_ns() - start_time;
 	print_verification_stats(env);
@@ -26883,7 +24388,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
-	clear_insn_aux_data(env, 0, env->prog->len);
+	bpf_clear_insn_aux_data(env, 0, env->prog->len);
 	vfree(env->insn_aux_data);
 err_free_env:
 	bpf_stack_liveness_free(env);
-- 
2.52.0

