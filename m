Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3783E40F3
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269623; cv=none; b=WncRuh4h7SH6uce/hmA7s9I6P+Bb4CyLould71JungVSNgNgPYJm72Woi6KrmvpLyh17Ys6DVsLPGP6iZBA48aJnlFOOAo7HxMKEvQSb2aupAVJ5kKbsSveIKH5sSa1tfwXT7Zc3U5EW1co/rOWo1FqdEZkXJGoV5ExoLq2Qngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269623; c=relaxed/simple;
	bh=c8g2yiAgdvG9aKhreDJ4vtDSashzanBK9DGQrcF2E7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCXK7D3kzxCiEdIG2W7ZOkUxV/aaNCfkVgGQ1KPbQwQCEEUoyxWIUYIjSpEltdhCVCWauDqjDQ50o9rV7oqG/G1nIenNfX/nw63I5mHEff3nXcdovTjIEUbuFmNI9ShahUTCEZNGzcvilg7XVH+Gr9+12LNPf2lpltcY4l3hJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/kl9fW+; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/kl9fW+"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49b0dd21eb8so212585e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269619; x=1790874419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/b/mLNH8UXb9ZFS5goIy32X6bUcozzc9vdHyclNDEA=;
        b=H/kl9fW+uDNIBKk1zb7Y+Mcg65gUDDq0EulQbjCMoccalX3Nl4DkmKFUP3ICgTklSN
         BszJaPDJ+HVVYfCgYbtGfUOfUpLLsLfr71wF8x6FbduYTl1X0ccykgG6r1yLw+1PfSF3
         VjkZrF2L8fwdMI9nJKI86kNwh/LxSb3N6fg8p4XLRxGYSW5AP3+79tbWnZ+uYYaYsV1t
         a/nW+bzOnWRpQY5SVMwA+Q0uSTcX10a0rcMFkcDtiQn8fTdxKL3HwUZRJUujtRI12eTN
         ZpFwRS5cR07SJeEd0GlXaeGLWoZa0yzAKS6EM7Wlj66zvkOlhx1UqrBpSQcUKc/Ai3oG
         3v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269619; x=1790874419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1/b/mLNH8UXb9ZFS5goIy32X6bUcozzc9vdHyclNDEA=;
        b=cwn2ooW6nHa5EV+lCyjAs33MZTPmLX6K4M3zgGQQMQv9jKfHZ+2SaeLK07OTpH/qky
         K44szHZWpNrNSUc3JzsTzqSf6tMgeLTtgFJP/aXffk3be6HuAzjvCxwjfp4QhUEAq9ow
         nUa0XH8qWfg0Pytzr+L6pfrNRuA/1cOP36hJzGhf3TA6hv0TnWHt3YWgigNkoa/Hi9a1
         RhTTU/c9YXK4ph1WET71OAxT4FqMGWMQV2tuVPn5oWdyKcWFhqkpIqsJk3+3zomyqlBn
         FO9I+LGRT2DipQAUpDdMNwJ8IAvYIYttIPNHmEwwRYGAwZcB2HNj/mTEuZ4PSdci9VvK
         vrxg==
X-Gm-Message-State: AFuF++mLMRyb2SJp+vLYXFHCOrMWNxfWA94T+qu/igfc80yLOdATVUKU
	QGg4xasnsgjyIsGs8y2WX1yi1ME16ZlqG3UemqbYPWCysTU2JeHNU3QpRwciENj8
X-Gm-Gg: AYBFou3olXSUXHfYvB9rotQN8UVn44dQijoUvkMj7H1Yg+Bq9gwXa4l1bKyPe8esyxb
	+jXXePcDsmqTK7qTwr9VYKYGO7GCD/cpQ7KSGSI+mminyT79oFoNHHc5LPiVKVQJ/+4jAs2Qpsg
	1vuySltC9OSfGo/r/hJmv+kolFXm6Tdt+DyVo0tIkpEEUzLGUsbcTo8qhXJkpdCER9Stg7YvrBL
	k20BD69tOgOz+iJ2CqdQCyHYVuiKHXS5aQ++z+nCX5Mv/DTWqQJvNN3itNm6SxnFbMU5Bkgos0M
	MQwQwKvth1Q4MVoijVESN8JbY/QpTO9Me/6ps1jrciRDQEOs2Cu9tFYi3+KY1lLxexaScpzkiGc
	EWeCsW7SVN4rCZSVOy79wxq4I/FuWLNYV4syhX3gLIrxuO623S+VFXyRxgl2ZYTOcwNiiqDz8Kb
	RVr3JfEq5ljhzmb1EVhuGlic3ejpNEHQttw58n9W9Eq7J9yYLjpBlkqrgqEg2BRxjw/DUzA5+4J
	u5b2zsgnNVfp30U3NlxMAd+94YSGTAZxWsGNOj1lehKH3cyB251zJMMvSZ59HL0CMv9/0h9pTrc
	VPzxkKyyRL/zBtjCrzMljmg/VnrqQ+0f5W1yTg==
X-Received: by 2002:a05:600c:1d19:b0:49c:fc6c:be00 with SMTP id 5b1f17b1804b1-49fe66fbe9cmr58307055e9.23.1790269619380;
        Thu, 24 Sep 2026 10:06:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9c288sm80546695e9.2.2026.09.24.10.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:06:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 6/7] bpf: Correct Program Structure diagnostic context
Date: Thu, 24 Sep 2026 19:06:40 +0200
Message-ID: <20260924170646.2366016-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924170646.2366016-1-memxor@gmail.com>
References: <20260924170646.2366016-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5853; i=memxor@gmail.com; h=from:subject; bh=c8g2yiAgdvG9aKhreDJ4vtDSashzanBK9DGQrcF2E7g=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtrRImtjOymRrdvJa/law/M0jWN2C67SHPaf63Xs24oO iTczP/QUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkITWH4n6H2d/WqVb3OTIu3 Wy+5sLb7zu0LfDGt8kZzj96X64x+u56RYZa2+//ag8z5M8wkIk6q9/VpBuvx2n1ZldciPUHNXa+ ADQA=
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

Link: https://lore.kernel.org/bpf/cf2f420c2b21de440a7dc51b1565c0f06d4b539640ee5c03384e5d77bcfb5686@mail.kernel.org/
Fixes: a8f427835394 ("bpf: Report Program Structure CFG errors")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/cfg.c      |  6 ++---
 kernel/bpf/verifier.c | 54 +++++++++++++++++++++++++++++--------------
 2 files changed, 40 insertions(+), 20 deletions(-)

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
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d5a2ca9a24c2..5337d4905b20 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3100,6 +3100,34 @@ static int add_kfuncs(struct bpf_verifier_env *env)
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
@@ -3113,17 +3141,6 @@ static int check_subprogs(struct bpf_verifier_env *env)
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
@@ -3147,9 +3164,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
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
@@ -22491,17 +22509,19 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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
+	/* Validate BTF before reporting subprogram layout errors. */
+	ret = bpf_check_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
 
-	/* Validate BTF against the complete subprogram layout. */
-	ret = bpf_check_btf_info(env, attr, uattr);
+	ret = check_subprogs(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-- 
2.53.0

