Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACE44606A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242197; cv=none; b=XKcdInNb3If/tX1fJ5q5LDBWg4J1OBXNwoZqarzTYohgy5oCIo2QsqOV7E6v32Bd7ZWb/c95xW+a7tj+0wjDjzrbq1uiU49ffQ2eASpGRdgW06tZamNpH/cTnDNUz+4Br4OJ/1mN3agSg6MpTDrtY2ogIY99uKNnKIg5xcfuPzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242197; c=relaxed/simple;
	bh=cY64sr+jwv7nphFWrpRz4P6JLPZ5rJfGsWhAmmwtIF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W62TQEUFlBpu/aJ1TjR2hFcf7ewkrVHh3MuD8vPhmKQs0EJK7u/XKWgIvqpgrK6JmJPJkq3Kv7fUIKevv5XcmPDGSO5Znb+AtkWDXtQn2/T/LspfewrIK+bdD/QolK4KmM7XjoRmwtiMrI+0ZE9FpDzFEAUpMWHTeI7d0ZnN0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeu1Gj9G; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeu1Gj9G"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bbf77e8so2903315e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242194; x=1790846994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l7eFf1VSjkH8gqUlsCWR+WDZDMsz+ylZyTt7t8avmQ4=;
        b=oeu1Gj9GdNv+vtxKRvlwPnRAXChJtdkZUidehH0PyeMAv1yR8SIeycYoyTjCMGFJuT
         xaYZp/NdPTUwK4uIQof0b40NbrwTaSRYc4Xp5SVjnq2Peaj9thMTBvLmpioqEIJ7BbsU
         tHG6VjpOGcaSac+VgTQeFRmgDDRHg6KZ/adwC6UUs5pS3hX59dX4u+8KOOaI0UYCXqKl
         rEUTsl/XFajkv1piw2HuBZVJb+oDjXFamynZv2s48EW1AUTuT7fccqq3oEBUAmMDylPZ
         O/Q0p2mFpcruC7i57oJlnilC2CtlBosHB1E0Qr5tU0lU8YIpi2eP3Qx3yjPrhi5W6aOp
         MgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242194; x=1790846994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l7eFf1VSjkH8gqUlsCWR+WDZDMsz+ylZyTt7t8avmQ4=;
        b=CKbE8o9wmklpEj2UAs2fsUyp0LYRwxmqf1HfGtJ7gAUuu1i/ZplQ88XULrOD1JZ+Km
         OukB4vsxRYLq1Ja9/1/TqLxFvMXVGtUG7+jszZv9KqNlcnSopyrQs3pvCMkPEDoeZtsI
         UOJSjxKG94d8Q1fJK53JQNw9LdSf15Fnjb19KmKPNAFB++X3OmFMo7rHUlFek7jg9Ofe
         r8LyMkOWYnHayR17zLSZQWD7Wr0VxF+YC9d/I2ziz8/DfK088MjYPnJQdzJQHthCqT9T
         ChkM/4LMJdc7D4HRqOjnA4iVwOjgbqvQ5prl+s2L7XPwj6gp9gwFm+xlmhsQRzI/TxvF
         zcWA==
X-Gm-Message-State: AFuF++kXGNQFcPmm5cFiCJdYLhJNznAN0yQ8SJiTdHPoQfvZSjI4jV2x
	Q/oteEsxOCraUZuoFNhNn9bR/ETIO/IDWLIrCSsn8kxX/Q/QbLWxDoQaAU10GOdS
X-Gm-Gg: AYBFou2n4PaPSCUgQBYV67OmV6LPvFp3uP2XNHu2EEYU4tTLIDMuTqeDcc0bSrrNjIh
	Nch7WFNiYfJTU9nrrjrezMbCxGc6wwLL/leIAxpMq8wHdHRW09n5LRBT4+kZOF+nBl5K259Grvs
	sdaEV2Mfr4+PkFXLF3YXA9kWXHrNpYGiXyggYSzxnNPD+wHrYsSPDjtd8tHLbz+4mVVJL5wAEe+
	o3rgc9zXt00W1Pff7IeYVZEnp0Kpr6tFA0zVslc5NSgLCk3T1TUz9XJ96nr3GLvYxzchXgh0GEd
	wx1au+sn/0CEEI6GTcEumdDs1vyftVBYb/k+FNM5+evBxvDR9q1WXOkwOO9nzwvzZBZcRLO3HGd
	9IQcjLheL62e5wlrtNLFJvVWrJG7hBTk4VPUKLPXYSIAprN1Cm+EPAIxfqRD0trey9USolJgnBk
	p6jQ7qwDx9ARYkOl75QIpZiaFy1GO//9m0g/9xwrPAsw0MZLte+WpLzsBinooD6zgNc0lgYkQMu
	qqHfSf0FbiuB0qXUyGusGI+6BoWUxkfOxx3pa8x+HAbFwl/xFg2d/8gi64vofEVywQpyldeF+fy
	kAo8yZhXSCteVYDzwBGnPTgMWoiwU9Lim+Ap3w==
X-Received: by 2002:a05:600c:4505:b0:49b:9105:cdaf with SMTP id 5b1f17b1804b1-49fe66d069dmr26666065e9.8.1790242194002;
        Thu, 24 Sep 2026 02:29:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9f253sm59225825e9.1.2026.09.24.02.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:29:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 6/7] bpf: Correct Program Structure diagnostic context
Date: Thu, 24 Sep 2026 11:29:35 +0200
Message-ID: <20260924092941.3174809-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924092941.3174809-1-memxor@gmail.com>
References: <20260924092941.3174809-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7553; i=memxor@gmail.com; h=from:subject; bh=cY64sr+jwv7nphFWrpRz4P6JLPZ5rJfGsWhAmmwtIF0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvL21yF2+EqFrEVn54+Ov/Cb8+iS69T52fMt10eoHbzh bgs+/mNHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZhI5RlGhgMJSepnL4Q+buEP y5I8G/Ckm01wwpLNx97ERTaWdl0/+o+RYe2Z5uNdJ2WfBFXu7eaarTrD4VtE19REFYtdBw5UVzx dwwwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Program Structure reports have two attribution gaps. A missing jump
table is reported at the beginning of its subprogram rather than at
the gotox that needs the table, and the early subprogram-layout checks
run before BTF line information is installed.

Pass the failing gotox instruction into the jump-table lookup.

The BTF validator needs the discovered subprogram boundaries together
with the LD_ABS and tail-call properties collected during the layout
scan. Collect those properties, along with the program's callx marker,
with nested subprogram and instruction loops, then validate BTF before
reporting layout errors. This makes validated source information
available to the jump-boundary and fallthrough reports without changing
either check.

Moving BTF validation ahead of normal instruction validation also lets
CO-RE see a truncated final LD_IMM64. Reject a relocation targeting
that instruction before bpf_core_apply() can inspect or patch its
missing second half.

Link: https://lore.kernel.org/bpf/cf2f420c2b21de440a7dc51b1565c0f06d4b539640ee5c03384e5d77bcfb5686@mail.kernel.org/
Fixes: a8f427835394 ("bpf: Report Program Structure CFG errors")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/cfg.c       |  6 ++---
 kernel/bpf/check_btf.c | 15 +++++++++---
 kernel/bpf/verifier.c  | 54 +++++++++++++++++++++++++++++-------------
 3 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 0de2f634ef67..33b98285e802 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -288,7 +288,7 @@ static struct bpf_iarray *jt_from_map(struct bpf_map *map)
  * combined jump table in jt->items (allocated with kvcalloc)
  */
 static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
-					  int subprog_start, int subprog_end)
+					  int insn_idx, int subprog_start, int subprog_end)
 {
 	struct bpf_iarray *jt = NULL;
 	struct bpf_map *map;
@@ -328,7 +328,7 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 	if (!jt) {
 		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
 		bpf_diag_program_structure(
-			env, subprog_start, "missing jump table",
+			env, insn_idx, "missing jump table",
 			"Make sure subprograms containing gotox instructions are accompanied by jump tables referencing these subprograms.",
 			"No jump table was found for the subprogram that starts at instruction %u.",
 			subprog_start);
@@ -350,7 +350,7 @@ create_jt(int t, struct bpf_verifier_env *env)
 	subprog = bpf_find_containing_subprog(env, t);
 	subprog_start = subprog->start;
 	subprog_end = (subprog + 1)->start;
-	jt = jt_from_subprog(env, subprog_start, subprog_end);
+	jt = jt_from_subprog(env, t, subprog_start, subprog_end);
 	if (IS_ERR(jt))
 		return jt;
 
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 0e8b3ccc7a5b..81f4dbfbf146 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -373,6 +373,8 @@ static int check_core_relo(struct bpf_verifier_env *env,
 	 * relocation record one at a time.
 	 */
 	for (i = 0; i < nr_core_relo; i++) {
+		u32 insn_idx;
+
 		/* future proofing when sizeof(bpf_core_relo) changes */
 		err = bpf_check_uarg_tail_zero(u_core_relo, expected_size, rec_size);
 		if (err) {
@@ -391,15 +393,22 @@ static int check_core_relo(struct bpf_verifier_env *env,
 			break;
 		}
 
-		if (core_relo.insn_off % 8 || core_relo.insn_off / 8 >= prog->len) {
+		insn_idx = core_relo.insn_off / 8;
+		if (core_relo.insn_off % 8 || insn_idx >= prog->len) {
 			verbose(env, "Invalid core_relo[%u].insn_off:%u prog->len:%u\n",
 				i, core_relo.insn_off, prog->len);
 			err = -EINVAL;
 			break;
 		}
+		if (insn_idx == prog->len - 1 &&
+		    prog->insnsi[insn_idx].code == (BPF_LD | BPF_IMM | BPF_DW)) {
+			verbose(env, "Invalid core_relo[%u] targets truncated bpf_ld_imm64 insn\n",
+				i);
+			err = -EINVAL;
+			break;
+		}
 
-		err = bpf_core_apply(&ctx, &core_relo, i,
-				     &prog->insnsi[core_relo.insn_off / 8]);
+		err = bpf_core_apply(&ctx, &core_relo, i, &prog->insnsi[insn_idx]);
 		if (err)
 			break;
 		bpfptr_add(&u_core_relo, rec_size);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c52e7bd570d..63b32a39a0f7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3098,6 +3098,34 @@ static int add_kfuncs(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static void find_subprog_properties(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *subprog = env->subprog_info;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int cur_subprog;
+
+	for (cur_subprog = 0; cur_subprog < env->subprog_cnt; cur_subprog++) {
+		int i;
+
+		for (i = subprog[cur_subprog].start;
+		     i < subprog[cur_subprog + 1].start; i++) {
+			u8 code = insn[i].code;
+
+			if (code == (BPF_JMP | BPF_CALL) &&
+			    insn[i].src_reg == 0 &&
+			    insn[i].imm == BPF_FUNC_tail_call) {
+				subprog[cur_subprog].has_tail_call = true;
+				subprog[cur_subprog].tail_call_reachable = true;
+			}
+			if (BPF_CLASS(code) == BPF_LD &&
+			    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
+				subprog[cur_subprog].has_ld_abs = true;
+			if (bpf_is_callx(&insn[i]))
+				env->has_callx = true;
+		}
+	}
+}
+
 static int check_subprogs(struct bpf_verifier_env *env)
 {
 	int i, subprog_start, subprog_end, off, cur_subprog = 0;
@@ -3111,17 +3139,6 @@ static int check_subprogs(struct bpf_verifier_env *env)
 	for (i = 0; i < insn_cnt; i++) {
 		u8 code = insn[i].code;
 
-		if (code == (BPF_JMP | BPF_CALL) &&
-		    insn[i].src_reg == 0 &&
-		    insn[i].imm == BPF_FUNC_tail_call) {
-			subprog[cur_subprog].has_tail_call = true;
-			subprog[cur_subprog].tail_call_reachable = true;
-		}
-		if (BPF_CLASS(code) == BPF_LD &&
-		    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
-			subprog[cur_subprog].has_ld_abs = true;
-		if (bpf_is_callx(&insn[i]))
-			env->has_callx = true;
 		if (BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32)
 			goto next;
 		if (BPF_OP(code) == BPF_CALL)
@@ -3143,9 +3160,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		}
 next:
 		if (i == subprog_end - 1) {
-			/* to avoid fall-through from one subprog into another
+			/*
+			 * To avoid fall-through from one subprog into another,
 			 * the last insn of the subprog should be either exit
-			 * or unconditional jump back or bpf_throw call
+			 * or unconditional jump back or bpf_throw call.
 			 */
 			if (code != (BPF_JMP | BPF_EXIT) &&
 			    code != (BPF_JMP32 | BPF_JA) &&
@@ -22410,17 +22428,19 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	/* Discover all subprograms before validating their layout and BTF. */
+	/* Discover all subprograms and collect the properties needed by BTF validation. */
 	ret = add_subprogs(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = check_subprogs(env);
+	find_subprog_properties(env);
+
+	/* Validate BTF and apply CO-RE before reporting subprogram layout errors. */
+	ret = bpf_check_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
 
-	/* Validate BTF against the complete subprogram layout and apply CO-RE. */
-	ret = bpf_check_btf_info(env, attr, uattr);
+	ret = check_subprogs(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-- 
2.53.0

