Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2B24E4C4
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898271; cv=none; b=liSmsFDOnzrcbvv5MI0oHC4W7EmHR5WZ8BaKOduGieXL/uu3FSVXB+rN7ohACBGAqHaorhykd33hxHOjYlPr3CVjAiPUPvY1+ADGcLCTnpwsYcN8AhVh96zpiaWCHGdrUsNvyOXQCf7jEHu5DC3BZfqc55/W1qbDBmSnfjwsIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898271; c=relaxed/simple;
	bh=OaIubOai/RQV3UjQynebaMvdaReifZvTBYzQiL8/4pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cv4dIrqVPlsykxiHtUYXV+YwcnuWIzUQ6azkybeARRLknaW+klmHRXcSt75xCyEMJUZ+ftJHNiLXW0m6B3IJ3pI5GJY3rM+O03nYb3FiW3urY7JGH3TVY8tg2V7X/v/M+z5yTh95/HIUElYYUs1+YBtf43DOx4AYtQA0v4yhRgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9EsOtNa; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9EsOtNa"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso3623095e9.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778898268; x=1779503068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr0BzYAGlu9f0KbFd/c/AfoTJ+c+oKAZ0id5yuR/YpA=;
        b=Z9EsOtNazJWl6e6zg2dzk+PR2rr7VAGM+73pXOm8RXIyEq57TKhSW4P43WcfFubf+m
         rS2A/gsAVNGV3N8qwadSvKmBQIAnbjWktT9cRPoN0RTJzXSRgrFqm4Ad/KDvnrF8/QqJ
         HHH7iNzu5Uj+13b7dqs7DRSbcH2c9zJn+GcbomO039KqOAEE49RM16Cc0SL5Je8OnCvB
         e7WGU0iZNf+jwweuNaTDpPA4K8ESPXDmD9gDGSdVuo7c5OKNZ6BTWGr22YfEFhU9CYoO
         ZN+lhqUOUru68Vokb4WjLDlt+y9BMKlBE79ctc1onDfwTZEzM9R4/xjwzgdvmUsfbp+w
         6EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778898268; x=1779503068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gr0BzYAGlu9f0KbFd/c/AfoTJ+c+oKAZ0id5yuR/YpA=;
        b=oopZYwbMkqfmZK0NxcxFvY4k9o8I3rNgNiDRYiOCAwA0oxBBvR3psV4A7SxxTv7iAj
         CIusba3jM2c+ZaSaB4mVKZhxbZq3khrbZ1O8a2s92EWg+hpoobJFbGA5wHqRj+ZGol3o
         9ex7CpxWDPXNPBDDgtpzLSM+i8rqFt7jucNABWqhnmaV+lyd8Xd+7sgT1dOSGPr+X3I0
         O1gqQB8gv5H4NX56uf6K8SbW+SEVzVJx+X6gCGAIuT2r2BW6YraqYcBP0lE4bPuGFemO
         +IidCVDnqf3L2Xnb7nBzly0SKKIZhswjmFPz3Whnwyn8luDU4H7cgvKyUZF9cegXLk0E
         g3vA==
X-Gm-Message-State: AOJu0YyGeT77piXYSxBzZjlPrhx0QEGK/mNRDPw0vtP4leRG3j4vsASn
	EyGk6ZfeL30kSLDlcmaJVfWnC9clayn3D5kA1uxuExRQSMDoFgU8uSC29nnHUOwd
X-Gm-Gg: Acq92OH9Sa0YMJfNNGMJ92XTbVEsGW1X6uvLeMabiol9Lk2zTlSly9ZhBd6mBgYyJt6
	fN3SgWSFzyIDS7ayTapsIIXKP9ZIAwVKs+IGiPDDAqWkDvPQJjVKCPR12laFkvG3KHKHr2D9Y31
	H0xfcDGd9Xc9mU8FLsV1syggKRuZIwQNr+Ja2zjscuTB+46Aj9ANuyjz6Wie1gIhVR6FWOEasZP
	jQDHjmT3djcAAswY99jgiLGq4K+K70U1plSsJDqkGLAPCWul4gKCRmVPe7BA4foVr1EjjesIdEL
	1clQ+viSb7vEvVSIu3UV1Gdd90HyPSV0z8D+RBAR3vlI1ohlL8HsgOBOv1Sz2zsLD54HElhSDog
	jwzvxBFGOvlf4mmc/vcteBOH+XSYh8+d7W0YIBXmnereqdgniXAEkMmKh5IneIFDRKqphPgRDMn
	qOiJSWLe9vyR6adn5FuTqScOpD3FK6gNeO79AU1OEYKgma/JVrMLZKt+MpNV1d6P68ViBnf697c
	IHwRX087dnd22EBXIY01O1Aje7ZeSGw3rJy/bWgrqi+TwlPUZcetOihCm7mavuAgA==
X-Received: by 2002:a05:6000:22c5:b0:43d:7d24:b510 with SMTP id ffacd0b85a97d-45e5c5fd8demr9026150f8f.22.1778898268248;
        Fri, 15 May 2026 19:24:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm18745009f8f.5.2026.05.15.19.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 19:24:27 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/2] bpf: Check global subprog exception paths
Date: Sat, 16 May 2026 04:24:24 +0200
Message-ID: <20260516022426.2109698-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516022426.2109698-1-memxor@gmail.com>
References: <20260516022426.2109698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6634; i=memxor@gmail.com; h=from:subject; bh=OaIubOai/RQV3UjQynebaMvdaReifZvTBYzQiL8/4pw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIYv98iLW341rjaIVIopj/i0/8K515rOTYs5MVax+qxafL Vrz8MnZjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExk0nuG/wEHlJ4csGs4auTC 83A3a0xMXyzj7+fTWiZuLLJZ7DRr/RqGv3JvH3+30WIusPSc2rizY/6fvhzH5jWnbRjubBKPfNI wnwEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Global subprogs are verified independently and are not descended into
when their callers are symbolically executed. This means a caller can
hold references or locks across a global subprog call that may throw,
while the verifier only checks the non-exceptional return path at the
call site.

Record whether a subprog might throw in the CFG summary pass, alongside
the existing might_sleep and packet-data-changing summaries, and
propagate that effect through reachable callees.

When a global subprog is marked as possibly throwing, push the normal
continuation and validate the exceptional path immediately at the call
site, avoiding a synthetic exception state and associated special case
in the pruning checks.

Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/cfg.c             | 13 ++++++++++++-
 kernel/bpf/verifier.c        | 23 +++++++++++++++++------
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b148f816f25b..b2cc337ebe74 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -739,6 +739,7 @@ struct bpf_subprog_info {
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
 	bool might_sleep: 1;
+	bool might_throw: 1;
 	u8 arg_cnt:3;
 
 	enum priv_stack_mode priv_stack_mode;
@@ -1308,6 +1309,7 @@ void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
 
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
+bool bpf_is_throw_kfunc(struct bpf_insn *insn);
 int bpf_compute_const_regs(struct bpf_verifier_env *env);
 int bpf_prune_dead_branches(struct bpf_verifier_env *env);
 int bpf_check_cfg(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 998f42a8189a..26d37066465f 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -64,11 +64,19 @@ static void mark_subprog_might_sleep(struct bpf_verifier_env *env, int off)
 	subprog->might_sleep = true;
 }
 
+static void mark_subprog_might_throw(struct bpf_verifier_env *env, int off)
+{
+	struct bpf_subprog_info *subprog;
+
+	subprog = bpf_find_containing_subprog(env, off);
+	subprog->might_throw = true;
+}
+
 /* 't' is an index of a call-site.
  * 'w' is a callee entry point.
  * Eventually this function would be called when env->cfg.insn_state[w] == EXPLORED.
  * Rely on DFS traversal order and absence of recursive calls to guarantee that
- * callee's change_pkt_data marks would be correct at that moment.
+ * callee's effect marks would be correct at that moment.
  */
 static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
 {
@@ -78,6 +86,7 @@ static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
 	callee = bpf_find_containing_subprog(env, w);
 	caller->changes_pkt_data |= callee->changes_pkt_data;
 	caller->might_sleep |= callee->might_sleep;
+	caller->might_throw |= callee->might_throw;
 }
 
 enum {
@@ -509,6 +518,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 				mark_subprog_might_sleep(env, t);
 			if (ret == 0 && bpf_is_kfunc_pkt_changing(&meta))
 				mark_subprog_changes_pkt_data(env, t);
+			if (ret == 0 && bpf_is_throw_kfunc(insn))
+				mark_subprog_might_throw(env, t);
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 88b40c979b56..7fb88e1cd7c4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -442,7 +442,6 @@ static bool is_dynptr_ref_function(enum bpf_func_id func_id)
 static bool is_sync_callback_calling_kfunc(u32 btf_id);
 static bool is_async_callback_calling_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
-static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
 static bool is_bpf_wq_set_callback_kfunc(u32 btf_id);
 static bool is_task_work_add_kfunc(u32 func_id);
@@ -5405,7 +5404,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 		if (bpf_pseudo_kfunc_call(insn + i) && !insn[i].off) {
 			bool err = false;
 
-			if (!is_bpf_throw_kfunc(insn + i))
+			if (!bpf_is_throw_kfunc(insn + i))
 				continue;
 			for (tmp = idx; tmp >= 0 && !err; tmp = dinfo[tmp].caller) {
 				if (subprog[tmp].is_cb) {
@@ -9499,6 +9498,9 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	return 0;
 }
 
+static int process_bpf_exit_full(struct bpf_verifier_env *env,
+				 bool *do_print_state, bool exception_exit);
+
 static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			   int *insn_idx)
 {
@@ -9552,6 +9554,17 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
 		}
 
+		if (env->subprog_info[subprog].might_throw) {
+			struct bpf_verifier_state *branch;
+
+			branch = push_stack(env, *insn_idx + 1, *insn_idx, false);
+			if (IS_ERR(branch)) {
+				verbose(env, "failed to push state for global subprog exception path\n");
+				return PTR_ERR(branch);
+			}
+			return process_bpf_exit_full(env, NULL, true);
+		}
+
 		/* continue with next insn after call */
 		return 0;
 	}
@@ -11782,7 +11795,7 @@ static bool is_async_callback_calling_kfunc(u32 btf_id)
 	       is_task_work_add_kfunc(btf_id);
 }
 
-static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
+bool bpf_is_throw_kfunc(struct bpf_insn *insn)
 {
 	return bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
 	       insn->imm == special_kfunc_list[KF_bpf_throw];
@@ -12972,8 +12985,6 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 }
 
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name);
-static int process_bpf_exit_full(struct bpf_verifier_env *env,
-				 bool *do_print_state, bool exception_exit);
 
 static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
@@ -13354,7 +13365,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
 		env->prog->call_session_cookie = true;
 
-	if (is_bpf_throw_kfunc(insn))
+	if (bpf_is_throw_kfunc(insn))
 		return process_bpf_exit_full(env, NULL, true);
 
 	return 0;
-- 
2.53.0

