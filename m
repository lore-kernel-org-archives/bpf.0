Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331BC34F46F
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184280; cv=none; b=ER9m33DBSRNwLsZzZqo+/cuDobFwnqLln2EoHgDJf3zpzpl/MRXP3Y1X1fMNSNc7xLjsGStk6WTqnsUs/vSa357x7HjTLZ2axxRqzTDkENvnjBXxUJnpv3PlEbegCIDkx6444HJlFzTD4CggUEoIt4G7+mu1Qd77agbyOKrB7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184280; c=relaxed/simple;
	bh=A1pzBcNUBsyVhIQcpSF+E3cgRka9tg+0ORvz18YlW3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZvCBBEcKeEkcYPCNCagxLWRvPkxv/A8wtT2gsnQTBeBaNdgfqu02/d2nR8eVkHFIQH1GIKQc4wRLlTV5V5bwVPIHoPa8KiRLecNkmsfbl1W/DpnpkLzVOeWFRAIp2i+V2FEaj6XW4hpoCUHEZ/T5ZBdhFl9R0j4nIpTZaObutc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqR+N2Ql; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqR+N2Ql"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cf976ecacso640675b3a.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775184278; x=1775789078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8AuFxnhIhrRFVqVKQRjQfYaOSkQ2RIG91gBylScVq8=;
        b=OqR+N2QlvMmmYhYfnljQfYacdJ7MonyfTECvMM+AJa9dToeLWFqHGVgwG/QOK9By/5
         x5pLRZ3k6Yb7k45nMQRtuBx4JneHS+m3N0qsrvGreXwi1pJu23DBZiTsAyNZ+oKpyVuq
         CbwJbp64uFNdGDLxA8JciLr6mCtzr3d5hZZwsX64GR9lZxuWIU3dwyM7GvMnF054HicC
         +FgknZ99Vad3P9nb6syEj2wAzIldWyxE/yHJf9tkA/9cvmAQjI+o5oCnPJy5KtTSbGmQ
         5ZDwC6eNrm9GiOMf5SEwbw+tnSPqcn2mZo6mXMfB7G/OzocmU1BurIL2jx1on1+MNLuV
         oreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775184278; x=1775789078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b8AuFxnhIhrRFVqVKQRjQfYaOSkQ2RIG91gBylScVq8=;
        b=YY7D/0C8dH1DROXgL5I6HQ4A2+pMnPyOWtXz0aOj4KSfrhPKPY2Z5gIUUMLtnuO+U9
         XD47NmDaOhvLLioP8tEl0Mc/v5rWQj4FtGZ6T0z4zeQBQGqr1nman6FtGNLH6N0+sS6w
         U84OWNiEL9Mz3ZnXl+AVY4jflQyjqE1V0jgfzRMzZiDQEPcZPDal2fNbH8Sx1VHbTTyW
         1qZw/JFvpDFYkDLVBYWBfHbU6eF069sU6chs4gqZ+0LxxY2mXtH5Dq+EjNflp9Jbx+ko
         JzSgCcM7MpVlrw/lNDRRfoMoT+6gTB1uOnXZWHgvtUkqXN1zwcADkRjs/KklQ7Lo2Pd+
         KFXg==
X-Gm-Message-State: AOJu0YwA7w+2Q3Q0KtGbo/OZG6TNgh/CEDHmKsig0yxRdwHiRXkcFDnS
	UXU1TkySRQYFJl7X6x+r10pU9H8cp0OoEmCGZzomJ6IymDkyAywf4pr8SOEIyg==
X-Gm-Gg: ATEYQzxLdlROzCElf4cb0p3NNMuh7SvZ7XSUl0GWhHb7luj7qul9YqqeTsO7s9idafQ
	G+4oUbmLhReJPUgfEhVY3axx/ea3bBq86fHKdIaccGdEhZHJXLVGrr6duRVR3ZjcYa46ndhrGZZ
	xhSEM9hf5CbZKrOdeoqRtVVzVv12VQxot0KS2hpWAFe0Fc1lI/oD0ACYRriWnp4gf86I1XVoJVt
	50FmsDvO0qeQ5bgUqQIgveaHogyTUucNPxAW7rWl6ffWKyK/VCAHrVQFCbwFu3XKvEJuSoIK8Eg
	zA6YLiBdchi/1JelCZCkddhDQwHfwDZW0XgfhFTcdVWsBxfO2cqh3LT+r+LjSUitNRE4uU7l1ur
	1pv+9o9ddeeNSG7x/UQfJgs59PgnYhSk57SCzexNlSD9ThN/BkuTh7qyIGQN+ObMcR2caLHFa2e
	MtLNzvpg/GUNrlSRo6+hgKAPK8M8WIEsFSBG0C5yJFnD9NyD7tn5M7tTD5vNLk5Iv/iEYVGaCX0
	one6p91bph8VT5DnWJuR6CAdFHrOUhwBphhOvtW5vtHFbfvJJrIBpL5V6RbqQ==
X-Received: by 2002:a05:6a00:234a:b0:82d:785:f64f with SMTP id d2e1a72fcca58-82d0db8300bmr1305592b3a.40.1775184278071;
        Thu, 02 Apr 2026 19:44:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82d12218738sm274940b3a.21.2026.04.02.19.44.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:44:37 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v5 bpf-next 5/6] bpf: Move verifier helpers to header
Date: Thu,  2 Apr 2026 19:44:20 -0700
Message-ID: <20260403024422.87231-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
References: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
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
 include/linux/bpf_verifier.h | 28 +++++++++++++++++++++++
 kernel/bpf/verifier.c        | 44 ++++++++----------------------------
 2 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1c0b430f92ec..76f62c8907bf 100644
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
@@ -1109,6 +1133,10 @@ int bpf_compute_postorder(struct bpf_verifier_env *env);
 bool bpf_insn_is_cond_jump(u8 code);
 bool bpf_is_may_goto_insn(struct bpf_insn *insn);
 
+void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn);
+bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
+			  struct bpf_call_summary *cs);
+
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_update_live_stack(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1a037549e77f..7ab1c174287c 100644
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
@@ -4269,7 +4251,7 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 	return btf_name_by_offset(desc_btf, func->name_off);
 }
 
-static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
+void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	const struct bpf_insn_cbs cbs = {
 		.cb_call	= disasm_kfunc_name,
@@ -4493,7 +4475,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
 		verbose(env, "stack=%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
-		verbose_insn(env, insn);
+		bpf_verbose_insn(env, insn);
 	}
 
 	/* If there is a history record that some registers gained range at this insn,
@@ -18541,17 +18523,11 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
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
@@ -18672,12 +18648,12 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
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
@@ -21532,7 +21508,7 @@ static int do_check(struct bpf_verifier_env *env)
 			verbose_linfo(env, env->insn_idx, "; ");
 			env->prev_log_pos = env->log.end_pos;
 			verbose(env, "%d: ", env->insn_idx);
-			verbose_insn(env, insn);
+			bpf_verbose_insn(env, insn);
 			env->prev_insn_print_pos = env->log.end_pos - env->prev_log_pos;
 			env->prev_log_pos = env->log.end_pos;
 		}
@@ -25839,7 +25815,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
 				   struct insn_live_regs *info)
 {
-	struct call_summary cs;
+	struct bpf_call_summary cs;
 	u8 class = BPF_CLASS(insn->code);
 	u8 code = BPF_OP(insn->code);
 	u8 mode = BPF_MODE(insn->code);
@@ -25954,7 +25930,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 		case BPF_CALL:
 			def = ALL_CALLER_SAVED_REGS;
 			use = def & ~BIT(BPF_REG_0);
-			if (get_call_summary(env, insn, &cs))
+			if (bpf_get_call_summary(env, insn, &cs))
 				use = GENMASK(cs.num_params, 1);
 			break;
 		default:
@@ -26054,7 +26030,7 @@ static int compute_live_registers(struct bpf_verifier_env *env)
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

