Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151363164AA
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004537; cv=none; b=Ee1PsFHKfHdvOAnBgXp+JBDomKPzdnJOVOavFmsBCXnaX+QfPh6iiNBLqWh5t6ekxeYRLlV/RMCxiTQ/hF+3BF87JLQ/6uHsd51KjKHlPxJ1/ip9gHy911VlMQPw3C/46xp/IyNsypaRl8LujlzO5nR1e7m/hRLiWs97SlJTAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004537; c=relaxed/simple;
	bh=tMQB2YULMa9Mk+CmIKIDky6EAPoBmmsymh8MSby8nkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcJPPRZRnfmZWMPtDcR/nT77idJFPTMTZ1H2VMRqCL07at33DAqWHmNslYKlyx6EpFQYibdz/PNbekhNDUhbFxuEY+mEb+3qpDf4xZxW7Z6jCf2X/XqcakKbmCC/C27gaiA4sGykM+bTX4tKGOTZkHU3FPrRvAMQcAnUSS3IV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZrI2i4+; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZrI2i4+"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-44a044cb827so783459f8f.0
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779004533; x=1779609333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js1amVqi/xP8AxpT0CpZWPoVrdNbwWPKL4fSR/diUtE=;
        b=FZrI2i4+PjM/VX+jc519tfNUy/ZxvcosIfoyKou2KsMeAt35Zh6ygm8NLfacPhM0N3
         rh5b6eaINo4k4VsDZqQff9dGP8eUypz9fnffAwJiTsmuvmLc/MeWNFoFkF5vilpTv40P
         6lPQoSSad9cdlr20Q1S2L74Y9F/GXbcoKRffncNn8d7ojL16kW8uJU4PHS8m77xFYvKC
         3UVCrCAINbe2y72IY44NlarYVagvGxlIZolwjcoePSvz0FWlcm+XJPPQIVn234PrIRvx
         jjto5DwFU5oKew1656+AdpQF9upcJR3paUyDGaV4bbejQtnVjhBlRn2XyPGh6C0Ooe4D
         caMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779004533; x=1779609333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Js1amVqi/xP8AxpT0CpZWPoVrdNbwWPKL4fSR/diUtE=;
        b=WQUTK1ilh13LrTGLbA0ARYwT8Yb2iLsmNslY8NMzMUi0R6sJXiQl/uGfm7sE2KCd5G
         3u5aSd+KnlUmd+IVFhbnJG/s3m5K9k8FhyeK1Q27eDLLl03++GGWnr9b2DU/ib6eNtQn
         yMXVRRQBNbejdnAfDX4GCWSnLmCqFpqS7lgCmcsm5QioQBEmkIZR/BZetYB4Sgcd0uiX
         dgguPxIpgsEA7Tepc769CaI4umSD+bOa2GojXseauKoB52NA4Uf10EdRmidldHe+WRVF
         5vRlJyv37OKD5HQ6a7X/f3ntiNZhEtaDfHTAnHbTjAAfTCkZRsIJLqX/lKUrWfV6yX5Q
         l2ng==
X-Gm-Message-State: AOJu0Yzoq8PeAGKT+Zc+JNO9bcPfH7digqNcHPA3ox4PFxS6wrMz1Fom
	mO+EmboyFYBkAKa+GYRjtZVeoh2mE6l8SAGMppRCQm+07CNCt5qakGsisjNZJcfz
X-Gm-Gg: Acq92OFhqUvWLoX8D4z7dO7IEHGa774UxyBAMFcLuCs7PYogQB4V7LzJcyWOoxTjCAq
	dVcrkcAq6DZbgbK5sEBHdiJQzQDP0WaBvh3+5GwdCPyCrJxcXZSGR2a/0yffuBruMNk4AVKu3d+
	QucELCDAnFH2ek6RnQaENpjl35EyhC3k93y/7vHwpruaqv6+01e/nolCcpO93xa3Nc+u8+TjrIm
	n5xT5Ay8MocIT4SSEsvRMBluhEfUaeWvOMxhCTXbt8kADFIL3EPOyktBvufg/xxfUfcHtg9K5KX
	G4NvsiZusx0SramhkTlGiAr98X5vpcg8aLHE2MpQVcCVt+3gklc5TrpSOAok29l3ZUBd8BpWvtN
	97iGmHC5o917fpiwucWYOwb38CJnwUnF/BrvURHhp2NIxHmoeaMhgHTV/5VjASedAYHzh2UsR58
	WfhikGb9ARiluWR/CqXzxYDJEkpz6Y5gWB9Nn4A5o17X/AUflK9nVpGUEpDrgfi76I81xWk36W/
	cV6x2CplU9V3QfxutvmSVyeBzZc2cEuMr/kmdJPZEiQMGqQeFHC53PqJ0Arr/Z0Qw==
X-Received: by 2002:a05:6000:2288:b0:45d:4532:5d98 with SMTP id ffacd0b85a97d-45e5c57d2f2mr14438476f8f.8.1779004532549;
        Sun, 17 May 2026 00:55:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39806sm27514972f8f.9.2026.05.17.00.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:55:32 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 1/2] bpf: Check global subprog exception paths
Date: Sun, 17 May 2026 09:55:28 +0200
Message-ID: <20260517075530.3461166-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517075530.3461166-1-memxor@gmail.com>
References: <20260517075530.3461166-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6621; i=memxor@gmail.com; h=from:subject; bh=tMQB2YULMa9Mk+CmIKIDky6EAPoBmmsymh8MSby8nkg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIYuzxOO2cuq0DUXcBxjXq5w8wpd3cWKb13ytcraMtfEbV 2+RzXboKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESYPBj+Srt/SxJ1u2cZyfYl sTd39YRFBu+Oy98+kfTu9OnIuGkrWhkZDrx3qdp4wTFj4TwH/YlSD+oc/SV5rkRslNc9Vv0hVPs WNwA=
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
index b148f816f25b..185b2aa43a42 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -729,6 +729,7 @@ struct bpf_subprog_info {
 	 */
 	s16 fastcall_stack_off;
 	bool has_tail_call: 1;
+	bool might_throw: 1;
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
 	bool is_cb: 1;
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

