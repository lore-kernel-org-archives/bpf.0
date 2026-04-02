Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2B273D6D
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110681; cv=none; b=YY3om0RoLlZrFGnuO/Cwq6ULCZcgtd1EVM4wCM4rF+1+TC8OqrTft7r7cwjMlsuLB2wAVe1EUWF1sZB6JYkE7NTnAy3fXMC49/N86QUYcBvacWcqNjEgovww9XMQ3gKrlNpysvfjHk7xJO7eJ26D0pL6ug7Sw3navOk8AUou3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110681; c=relaxed/simple;
	bh=jko+rceQZuOYFgCjYMpUEZ2eA4/+PxMxtYowmoe3IRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joeX3rJuQla6cITagjpS9sbuZ+aYowC0wpPTNcPIvARmTJvnjLE4y76C2/MSF+j20HZ5qnVw3popn34JfpWeq4tK26hlYrYuhTi19KNajqlXyD4qIL3F/TWlbhxdmpQU59/YQhNrmVnrfQE4wD7hM+AA8H8E2c0plzTfI5vChTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqkRRgOC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqkRRgOC"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d8e548a05so461644a91.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 23:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775110679; x=1775715479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ9l1Hrbkkf6p8qD4Hk4qaTKQVZPUgeAIWn9eTauNmo=;
        b=sqkRRgOCkjGlxHK0/qw6mp08VP3b7fF1F+q2RIqf1Fsfad2x2rp5QmklVJZwS+jwA2
         3PqsJydPpCjgMI19XxO5vL7D88Cp7pg9IfvKzsKpzjBAdiy3wiVy7+S7WiPZABROfyr8
         ZZQeOLOdP7PhKwSceVLSx5UiNPxMbqDU1iqE5bKYtEe5ATZg9JMzrVcmolDo3TXJaQHG
         A3Yi6xLRRoUT6oTSv+ZDbVWFcJd2H4hRf6X8e6Fjbi328OXbvElBMt/6p5w0738HPNZ8
         wEgfzi93doYsAIguFXFRhZKmP/pGahyFJIff+ePSNIWhx4k6FRYT5SzbwGNhGPhCZke2
         MLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775110679; x=1775715479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZ9l1Hrbkkf6p8qD4Hk4qaTKQVZPUgeAIWn9eTauNmo=;
        b=HEBykYuPknIwNzOf3Df4ZmjOwlhJAOPqDAINBlS79Ay1hcis2mC1DIpgwIpuDjnsxZ
         rorRbN6Cey4VCQruu2NVE57Uw3C1ZtxwcMue8Xd29FfEUGdZuTuNjRpICyVG0py9KT/I
         3q2D5gVybE/RQbEZDH9e21N0AwV38xBslmkUDuBQpDNzDZFz5c+CPwHSArprFhbQ7EhP
         niiZBzginC3tnOe0OVS6/7Po3UFSmHoLOGGlAWGiZHtFZou9zDfa4G1LVy8Nr6U+Quhl
         /7BA8qUzQ0WPFtd8BK+qbdqN646XZnyeH/DiV3XKFe9L75nIJN863r+5NbegVwxsgW/q
         0MJQ==
X-Gm-Message-State: AOJu0YyroFliI5tO6rmQcDblexy6dRkzXLX0GsBIpLJuSY83yDAKY9/E
	Rb5JGmRZ9IrzbZV1r34O5Lhg5kbfk4ABa/l8uKORRCqUcPnfgaQ74UxaHXUrNw==
X-Gm-Gg: AeBDietN4rkSZHXOMg95U5x2xWfTDqRzHHBalhCfVzLMIfJzvKJxKCt72oFATYkGcYg
	T1+s5ZQ7O7UnkY56UF/P3CdoKcJgKu/bBiB+5k6wKWCz+ca0DHBs7SxCSK5oD/VwQ62RILrp94w
	D1umqtHlWzB+sqT78bqcI9BxZ2aU7g+YlT1w5PAw8ws+mWISZku/QeLMhL+mT47ldke6rET6z+1
	fQYtND9SaC7RjQjz+jaf1C6s5c/XO/1dZFWNFUo2xYFJjGrmlM+LnmlnhQ2XhfPerQeQfWEU8N3
	fbtJpxIkkYUwF+TPNgTmwNCYVhWMnxPqQp/lw9JsyGCmdfXZWHhLOkKnMe4J31qdbzFYG/kwTGG
	9z0RFysZXnfc4qly3OrK15CQl1K7cEezvKOYhkcQr2x0woL+MmDdoiI2rAjXNOk/12RxKLUaHUE
	qEf8dAOwfmTx+YVQXOgDu3GzhDDa2qUnUfpsS1Pts4EIlAU/5FkYxtPzcowmo0/EbCe+E6pREbc
	PD5qX9ba/kNC6hbPOgUiQlWBsYPG4EFVJZP6d9H6QpG+Hz8Nrv5VglzypZ71g==
X-Received: by 2002:a17:903:3b83:b0:2b2:4c58:5ba7 with SMTP id d9443c01a7336-2b269c4443emr63147045ad.30.1775110678956;
        Wed, 01 Apr 2026 23:17:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d1f1sm21956085ad.10.2026.04.01.23.17.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 23:17:58 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v2 bpf-next 5/6] bpf: Move verifier helpers to header
Date: Wed,  1 Apr 2026 23:17:43 -0700
Message-ID: <20260402061744.10885-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
References: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Move several helpers to header as preparation for
the subsequent stack liveness patches.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h | 29 ++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 44 ++++++++----------------------------
 2 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1c0b430f92ec..1a7349d3af9c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -877,6 +877,30 @@ static inline struct bpf_subprog_info *subprog_info(struct bpf_verifier_env *env
 	return &env->subprog_info[subprog];
 }
 
+struct bpf_call_summary {
+	u8 num_params;
+	bool is_void;
+	bool fastcall;
+};
+
+static inline bool bpf_helper_call(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL) &&
+	       insn->src_reg == 0;
+}
+
+static inline bool bpf_pseudo_call(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL) &&
+	       insn->src_reg == BPF_PSEUDO_CALL;
+}
+
+static inline bool bpf_pseudo_kfunc_call(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL) &&
+	       insn->src_reg == BPF_PSEUDO_KFUNC_CALL;
+}
+
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
 				      const char *fmt, va_list args);
 __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
@@ -1109,6 +1133,11 @@ int bpf_compute_postorder(struct bpf_verifier_env *env);
 bool bpf_insn_is_cond_jump(u8 code);
 bool bpf_is_may_goto_insn(struct bpf_insn *insn);
 
+int bpf_find_subprog(struct bpf_verifier_env *env, int off);
+void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn);
+bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
+			  struct bpf_call_summary *cs);
+
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_update_live_stack(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6a0d7548daae..2a5d862a82db 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -256,24 +256,6 @@ static void bpf_map_key_store(struct bpf_insn_aux_data *aux, u64 state)
 			     (poisoned ? BPF_MAP_KEY_POISON : 0ULL);
 }
 
-static bool bpf_helper_call(const struct bpf_insn *insn)
-{
-	return insn->code == (BPF_JMP | BPF_CALL) &&
-	       insn->src_reg == 0;
-}
-
-static bool bpf_pseudo_call(const struct bpf_insn *insn)
-{
-	return insn->code == (BPF_JMP | BPF_CALL) &&
-	       insn->src_reg == BPF_PSEUDO_CALL;
-}
-
-static bool bpf_pseudo_kfunc_call(const struct bpf_insn *insn)
-{
-	return insn->code == (BPF_JMP | BPF_CALL) &&
-	       insn->src_reg == BPF_PSEUDO_KFUNC_CALL;
-}
-
 struct bpf_map_desc {
 	struct bpf_map *ptr;
 	int uid;
@@ -4260,7 +4242,7 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 	return btf_name_by_offset(desc_btf, func->name_off);
 }
 
-static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
+void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	const struct bpf_insn_cbs cbs = {
 		.cb_call	= disasm_kfunc_name,
@@ -4484,7 +4466,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
 		verbose(env, "stack=%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
-		verbose_insn(env, insn);
+		bpf_verbose_insn(env, insn);
 	}
 
 	/* If there is a history record that some registers gained range at this insn,
@@ -18532,17 +18514,11 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 	}
 }
 
-struct call_summary {
-	u8 num_params;
-	bool is_void;
-	bool fastcall;
-};
-
 /* If @call is a kfunc or helper call, fills @cs and returns true,
  * otherwise returns false.
  */
-static bool get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
-			     struct call_summary *cs)
+bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
+			  struct bpf_call_summary *cs)
 {
 	struct bpf_kfunc_call_arg_meta meta;
 	const struct bpf_func_proto *fn;
@@ -18663,12 +18639,12 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 	struct bpf_insn *insns = env->prog->insnsi, *stx, *ldx;
 	struct bpf_insn *call = &env->prog->insnsi[insn_idx];
 	u32 clobbered_regs_mask;
-	struct call_summary cs;
+	struct bpf_call_summary cs;
 	u32 expected_regs_mask;
 	s16 off;
 	int i;
 
-	if (!get_call_summary(env, call, &cs))
+	if (!bpf_get_call_summary(env, call, &cs))
 		return;
 
 	/* A bitmask specifying which caller saved registers are clobbered
@@ -21523,7 +21499,7 @@ static int do_check(struct bpf_verifier_env *env)
 			verbose_linfo(env, env->insn_idx, "; ");
 			env->prev_log_pos = env->log.end_pos;
 			verbose(env, "%d: ", env->insn_idx);
-			verbose_insn(env, insn);
+			bpf_verbose_insn(env, insn);
 			env->prev_insn_print_pos = env->log.end_pos - env->prev_log_pos;
 			env->prev_log_pos = env->log.end_pos;
 		}
@@ -25830,7 +25806,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
 				   struct insn_live_regs *info)
 {
-	struct call_summary cs;
+	struct bpf_call_summary cs;
 	u8 class = BPF_CLASS(insn->code);
 	u8 code = BPF_OP(insn->code);
 	u8 mode = BPF_MODE(insn->code);
@@ -25945,7 +25921,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 		case BPF_CALL:
 			def = ALL_CALLER_SAVED_REGS;
 			use = def & ~BIT(BPF_REG_0);
-			if (get_call_summary(env, insn, &cs))
+			if (bpf_get_call_summary(env, insn, &cs))
 				use = GENMASK(cs.num_params, 1);
 			break;
 		default:
@@ -26045,7 +26021,7 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 				else
 					verbose(env, ".");
 			verbose(env, " ");
-			verbose_insn(env, &insns[i]);
+			bpf_verbose_insn(env, &insns[i]);
 			if (bpf_is_ldimm64(&insns[i]))
 				i++;
 		}
-- 
2.52.0

