Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017E317145
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775181847; cv=none; b=Ap5M6q0R7BsmkAjAhMbG0hz6BP6SbozDD6bocFc8OGwRItVcPbEP2US5S7yFrgsuOFJALmtZ+a1z9Fin+jbUHS1tokaEUxjTkGEeRnxjgybpiG6lKMr4olkV0EbZaLI73dkFpBdVQAz39cuDZXW0V2o7ayjiUZZrKjHHPWR+wYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775181847; c=relaxed/simple;
	bh=A1pzBcNUBsyVhIQcpSF+E3cgRka9tg+0ORvz18YlW3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4OSv8uvdD0cZixk35M8RtfTGS3dXeOdXbNvx8DgkR2f4otIVZ0hFwLsqz6pvhToS5K/tJZ+vFY35Lyjr2gHZBeyhdOsozrsRBebNmfXAsdlZcaS/bCjsaYAOD1aPs3vOmx5zm0Cz04YjbuRiHFFxCxubzQREXsRX+b6eZ980JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV+ULUmu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV+ULUmu"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so1394828a91.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775181845; x=1775786645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8AuFxnhIhrRFVqVKQRjQfYaOSkQ2RIG91gBylScVq8=;
        b=XV+ULUmuN9foAlAAh7GagZt7dl84SIyA4yz8Ri/8x8gFFcx1KtxecCCdvY4bw6FV7u
         XjJl1d7OYlqReW7r0O5UMrcnnmzw+rviaweVzZOnA5Awb7Zwaa/N8gi8vjgl6MvwOcy2
         DJJBH+yLBFo+7dabzmC9xvKnO6xVQEhhI4hPWgXFGofXQ09eRPtsQPVwxIrRchOiUwsb
         USBJig6OF1W7WIHamfwBovVrSeQzVxtj48XHyjRExMdkYdTAILf8ctcO/he3V9PGyrG7
         zD/xYpMnTsi3nB6fF0wEALUHLYAwnXK+sSVyBdcDp3F0c6wNZpKeOFYUY5opIJUcFwHW
         sMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775181845; x=1775786645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b8AuFxnhIhrRFVqVKQRjQfYaOSkQ2RIG91gBylScVq8=;
        b=OsIanKHwGe44PTOeRAyY21bnw6QVc3SBTG1WQd/tcz0HmLAfX6AmadzgkDDd+GUzmB
         fHFCSLS7hO4Ny97aBzN1ZI2CqRg+R5/oZ6luapMfHqd83GEaT3s87OqnaVwsD4Akof8l
         eqq+UNwwwyF/mwNOTPxGX20I3RhVdCi24x3Lkmt86gi3QGutFsw9EUHBbI5GwYknV5z3
         Et/xme46WOOPuJB+9VH7S1K6XSmOZKbl+iVVvEanZuJsh8e8EVaw64Z85WwhHw3qUvdr
         x2gXnTvM8drK32Sqb1t+P47U9WM/nY1GLFaMQ8PsPmisS7nkF53W6UeVVFll2TxSzIZx
         oZMw==
X-Gm-Message-State: AOJu0YzhM6fr+RWYWDyTqReDH4tr7ULAMnL6fMyKpN33diLlvMycMXmI
	VqUnYX+fR9yQmSpzeGfSRkMXWhtSujNsiJi/UY5kxk+FwRNvPY4E4PRTvvl1Lg==
X-Gm-Gg: AeBDiesA3uqqdc642fw7iFscIz/DYWTqiO99ZSdm+6R+Q4mjfvEOULdrT8OnMsl9LFT
	y77gLYMFoCxdJiLmrZ1SY4hxbzKQ0XhjGxeGH96pfD0UQ21kr/RVmiwHZ8iaej2p68p9uwH69P6
	ZCswHpEwMIKEMqtECUWSlVsw3nWC0mLGVXYzBWZrwPFXRtnLXB0TwysIn+bdDN+0vA/tZDnefAI
	1wm2Jw9k4MrA1NZM2D0f7VF0+eDCHQShCa8tYGXeK6w8twP7ytoazccvfaf9m5+xvTMKZkzvwxM
	bh001QqaMGOiG1BITi5amVij16zZmBdXmytKPRHbuPXVNQ/I9yuHi0MahFJsmU+E7btA8uWEi6P
	7IZ7vxKu0O3zDIpZOzj96oASRUTmbYLOxPm/qUuo7M1g6QdAwWarvF19Ba6hzDzePtKxICs8J+t
	fJhG8eovo5qxra9d/7jed3yEwoL3lyQ73LxtedihYmnvQp/z2NmzPb8nMVs4KWYzaWDmJP24S+l
	Kq6KPunSAWmdK+VOu98u7MRHgVBxkFcLDIoZ4ZSgT0fbvIhsV6S1pc8I00qdCAi1RbIkx9A
X-Received: by 2002:a17:90b:3d91:b0:35d:8f3d:c554 with SMTP id 98e67ed59e1d1-35de684a0a5mr1125994a91.13.1775181845302;
        Thu, 02 Apr 2026 19:04:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35e34f9sm4062872a91.1.2026.04.02.19.04.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:04:04 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v4 bpf-next 5/6] bpf: Move verifier helpers to header
Date: Thu,  2 Apr 2026 19:03:49 -0700
Message-ID: <20260403020350.73823-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403020350.73823-1-alexei.starovoitov@gmail.com>
References: <20260403020350.73823-1-alexei.starovoitov@gmail.com>
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

