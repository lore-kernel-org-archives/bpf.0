Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C65A36D9E0
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165746; cv=none; b=FJxzi/BI/5iRHh15rWfB89R9aKfMJY2BsZIZxrOvtOv57lEFL0xi52rGoD207Qs9PGF5n/TmqUgAyO9ygIgFhRwjFh9OYq9mXI0xbJjpkm7KSLFAToSG3ks6lFR1SWbHzA9PAYMFlI8CJc6PbguVNq9RFFnPGCFV0G70IB4pj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165746; c=relaxed/simple;
	bh=TYEcUJo4vQSWYngckrpOYszLLIorcBlsSP6TOwAss3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sArVxfE4cdAExMKZ/4DVn0xvmRGvneE5osk5ycxb/9lOcnsG8foMz7G03ZRVupnB5sKMq45mKyOSzOjXAQOQGizsAnFPevzcdwIUsr4Ndq5TgYghzi54AAUuj+5zAEDzPLMVlnc2DMUfpO7goBT40aav8NocNUVK6NxhYTncars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ryUl07TV; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryUl07TV"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d63635d80so1662131cf.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165743; x=1775770543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpjJXD58ECPdfY5emk+dA7ebtQdgiJMUBOng/Yn3wls=;
        b=ryUl07TVUWDEVVk5j40p74Ci35FVOi3F95NF2GOeoGCjAyvACsYIypCKrLk5RqW8bC
         nKkw5ya/viuXNQC6kC6j9j9UnU/KF0W9tLZ/KCGzsJmwVEK/UcIYu2yUdlV73W+BtnLq
         THQTfxJk9tHkJzJA/VzUvcYbh0GN4su1o4N1VL3Pi+Iy527U7enq10wm1VjD9pqBU7ux
         D/vNJtn3smVY2cMZYW2v5/D5+xfor56HJp+AKaQz4R7ciLxwS+kCH84aMA0a0xEaPlN5
         PBBoyV5ehGygpalRKjf5CIBSVy5CgjPtKKJ/tAyUolXK4eFal4ByFlqG+r5rlc89uUb9
         KUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165743; x=1775770543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DpjJXD58ECPdfY5emk+dA7ebtQdgiJMUBOng/Yn3wls=;
        b=hF/RjcGCgHH/fluIInV/ON4NBc4vyZvJjyLoWlZQGmWsoRTHdKBPuEC0jDppauzojC
         mibL5R3HXbjoBM4+LTPjudFTh9kexeBHBGSeL/BUfrSJMxMwMOlT0OgWwwfNGo9st6lr
         n76LV0qb5V9whqxMV6wN3Fx7uiPWPojtDOSx9VGfzy2SJOnv/eZOc/tqXpx/Dd51Klsu
         Y79JXW1s3xQl9UVHc7fbnzrG57uIcE6quOazsO5d70kcbFI2elFIe0ssd+R4ij7IL9hA
         wzi68xisHDoVemB4N71lm8wVgjgjZYh5y8VW84oH1GTOU4fdgV4ZoKB1IKe2eY8bFM0z
         E/6A==
X-Gm-Message-State: AOJu0YzJIWkp+wuxIlWYlDnt5LsrMQT4UKsO0LFZBv7ggq5dD/jZ6aXa
	SJIv22YynwNbP7WL7TL6X285yoDH93NGlxRsGvHz8ePlFb3cw6lXp1m6hkQomA==
X-Gm-Gg: ATEYQzyxOu8iNV0kt11Pb+MpBFPQg8r6OAgEDN4NkDFFoqQjOoyPY9ZVo6uamkNQnNb
	DqQpv672LKelaCSFsYSFKddscOqucDCbfYfKB3gWBAoB37ID1ORDs9Tqm+UqZ+gS4bR6MWw7rwt
	3ixILEcTFKNt0uT7PbZhxq5f7mUzlyEG3/td0PIRx4Pf0NcUie9U4mygCdxollOgZVJ2dOHTXcO
	prBQsbypjFZCDxC+4wCzPcclW/F+z38eCqnisVVk2Urz+cWXplosKl22LtSraNjjQwOsc2EZiJa
	9RHAqpAr/d1y7oAewL9lFl90fjARvzS2EgGPOYTaz9Ugdx+tWdSHn81NccyC4WYwfx6MSj/5v/3
	15q3ofn2wvQPl1C2JPGdHB2/4xBens97N4r8qfrK/oSsuhNFnSvnJX89Kt+IcX6qdD4y6vLjlSi
	aL8WZbf8kVFm/8Uz08XJro7dOkA1j9DMql3b8Fm7ZoRyUK6Yg9jJEUOVQvncG7SOYS6I8v0g88Q
	AtaGlLlgpD1tEqW3b3wz0XaheZUQdfmZdmRybefKcrQdmJ/t/REOHhNVQEPDA==
X-Received: by 2002:a17:903:1968:b0:2b2:4fc1:f657 with SMTP id d9443c01a7336-2b2817d8be9mr7872065ad.6.1775165351473;
        Thu, 02 Apr 2026 14:29:11 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a3a1asm38193815ad.62.2026.04.02.14.29.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 14:29:10 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v3 bpf-next 5/6] bpf: Move verifier helpers to header
Date: Thu,  2 Apr 2026 14:28:55 -0700
Message-ID: <20260402212856.86606-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402212856.86606-1-alexei.starovoitov@gmail.com>
References: <20260402212856.86606-1-alexei.starovoitov@gmail.com>
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
index 35fab402f168..55f82fba2f6e 100644
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
@@ -4267,7 +4249,7 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
 	return btf_name_by_offset(desc_btf, func->name_off);
 }
 
-static void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
+void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	const struct bpf_insn_cbs cbs = {
 		.cb_call	= disasm_kfunc_name,
@@ -4491,7 +4473,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 		bpf_fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
 		verbose(env, "stack=%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
-		verbose_insn(env, insn);
+		bpf_verbose_insn(env, insn);
 	}
 
 	/* If there is a history record that some registers gained range at this insn,
@@ -18539,17 +18521,11 @@ static bool verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
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
@@ -18670,12 +18646,12 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
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
@@ -21530,7 +21506,7 @@ static int do_check(struct bpf_verifier_env *env)
 			verbose_linfo(env, env->insn_idx, "; ");
 			env->prev_log_pos = env->log.end_pos;
 			verbose(env, "%d: ", env->insn_idx);
-			verbose_insn(env, insn);
+			bpf_verbose_insn(env, insn);
 			env->prev_insn_print_pos = env->log.end_pos - env->prev_log_pos;
 			env->prev_log_pos = env->log.end_pos;
 		}
@@ -25837,7 +25813,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
 				   struct insn_live_regs *info)
 {
-	struct call_summary cs;
+	struct bpf_call_summary cs;
 	u8 class = BPF_CLASS(insn->code);
 	u8 code = BPF_OP(insn->code);
 	u8 mode = BPF_MODE(insn->code);
@@ -25952,7 +25928,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 		case BPF_CALL:
 			def = ALL_CALLER_SAVED_REGS;
 			use = def & ~BIT(BPF_REG_0);
-			if (get_call_summary(env, insn, &cs))
+			if (bpf_get_call_summary(env, insn, &cs))
 				use = GENMASK(cs.num_params, 1);
 			break;
 		default:
@@ -26052,7 +26028,7 @@ static int compute_live_registers(struct bpf_verifier_env *env)
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

