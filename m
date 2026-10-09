Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D24C10E4
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542917; cv=none; b=m7Een3K/4g5W5/BU+e2OM7NCSG8G4hBFvjM19cbQI6WPIpzExeiUFTff8O7+jLrlVrl38JK6ZHTiwxrNtch1XQIPdHN/hlT1MXYItc2dcJEcAjPIF/ITQJ8iM422LyCMyGSXjxkRtImaMAMiJA/gvbY/kyessx9sHtINE3Oqzkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542917; c=relaxed/simple;
	bh=7all3WUvDhs5pe1DqigAForKerColbN/2YOeK+pR5Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojfUESc/Tu66Ee6pppgtYFp7KixlMtoCYN5DszLIDgpOfwBprGGJIFcLeNNfvqfcZrZTF+L2rKKvoE0qKbjpbXxvLhDUnR2/467f8zYwQtZksnX6P5oE+VLslagVhrICUTfLws7C+vf25sUHDNtE+2gn+djNT6lL6DPa2YoatvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NupCmwOp; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NupCmwOp"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so1846686a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542905; x=1792147705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kDLB5T8LZx7BcSl3rXP/G17eICjiFI9jPsyCgleme/0=;
        b=NupCmwOpXAri8fBXultDj3OAQJb359xZAv5ZjfR0dQKjHyYwdsMN9s6UPlciTy4T6S
         F4ADCWVBHy7WaUU4UF7R2EhV6asXLThjdYpiUIMrJY9Z8GAnSIjcWDQxUOHCD1QGAzRV
         SBmBN/G/sA4cYOQrO39BydJVQFE8y1doL3LE3sPczc7SHonP7D+/FASHSLbtT2V9fXK+
         AyiOdST1hXzXhMKYoypAT0unEE8s6puUlV+YLWSv0Vk78v1ir48MYGds+BMX8gKvD9ix
         ifKiBEaX3HsMm/bstO4+BXKMZ9XOk3B4B+d9Ln0xQodqHj0rL+6mbnhpCUZjFj7iYif7
         rXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542905; x=1792147705;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDLB5T8LZx7BcSl3rXP/G17eICjiFI9jPsyCgleme/0=;
        b=sfNQ/X1tZf8Ans9PTlWgVUiLI4awgKCy4cPwwHTtLW4KsHpPNXUB6hxHVnHK3ncE5i
         aZblOPBalJvyZotFrFUMmHLuJoH5L+KzgIHOwuKwc5nbynbcSPfp2S8tMLjjtul75B2v
         oxIRp5rVPCtCSZ8kv8pg4K3wl/KsW3quR/xV4E8TJnpoCt74EvElQhsosSkl+gMWN6li
         YY4n+luJQz4DEO7hwivmOFg9fkDuz5JxT3XByEBcVGB8UQzilRGa7OMkd4IZSKZNzWhj
         pHcIcLoMfNJN80AFg1iLXv2rQX/lmEGGP4/ZCXIIkbwxizHAQD4aKALFkJg7aAqsjVHv
         oKtg==
X-Gm-Message-State: AFq9FYJSGJLdRB6t1sQLEE0vnDtOItKoFyQPG+qK8ChupFsmIAPI0JBW
	Fl9D28B/sEy/ipOXuGaHXIXPivcDA4sOXeD64QVLUncOC4F8wgbudT6sHLaGEyXh
X-Gm-Gg: AYBFou3rYVrH8lCk4QOkZPl+kJNAC/4nEsGVnKzUJP2CnsbBQ3p0IOjTkSebSo/FHid
	5bhD7MDA45nB4SaL0JMhkB1W+ApIOpkdL+5rMq8Ytt7At+kj9BPDJ9TnlhEHRWP3xkgA8WUA9HT
	RXK+dvo5/P6hWPNRKt2SYocGVMBLYYr1O+A3akuUiRY6T6wK/ebs6I1W2EKhrjNh+6DnvWGxHtu
	aJaQP50KnuEr3Xbj0XgGuOzVIPNISVxoULkRoIFVd8enkWm1hsz/WFYKXcLbKYyYUnnMn78Gw39
	xP5GodrX+VEGe9fCq+ukr72mtYGdAZh5Om9P79m/OSpJVq0Rmv6WSsviXkgQcNoJixv9478rTL+
	Frua5hV4fFUqK22HtFDhP6xzneg6LZowWtYPeEPVw8qBWcSFpcylnDK7+iX6riCbhPQ58iGp0Ju
	873HDn/pNjLGXOLGGdhBF35gO1R+Mzx62yyYPrYY6ZsRQNpF7z7CmMIzGkQMhpBs5Fz1Axf+Uyx
	FGDI/7CZqy64RU=
X-Received: by 2002:a17:90b:1d52:b0:3a6:e8fb:76b5 with SMTP id 98e67ed59e1d1-3ab3a79001bmr1480683a91.37.1791542904978;
        Fri, 09 Oct 2026 03:48:24 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:24 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 10/51] bpf: derive global subprog stack liveness from BTF signatures
Date: Fri,  9 Oct 2026 03:47:28 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-10-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Stack liveness currently analyzes global callees in the context of their
callers. The resulting read/write marks describe only the current body,
but freplace can replace it after the caller has been verified.

A no-op callee taking a stack pointer can be replaced with one writing
through that pointer, leaving the call's may_write marks incomplete.
SCEV could then preserve a stack counter recurrence across a call that
resets it, invalidating a loop termination proof.

Instead, derive global call effects from BTF argument types instead,
same is it done on the main verification pass.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/liveness.c        | 28 ++++++++++++++-----
 kernel/bpf/verifier.c        | 66 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d31c1a500958..05e6f091ad94 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1744,6 +1744,9 @@ bpf_helper_stack_access_bytes(struct bpf_verifier_env *env,
 struct arg_access_info
 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn, int arg, int insn_idx);
+struct arg_access_info
+bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env,
+				      struct bpf_insn *insn, int arg, int insn_idx);
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 52c39bbee6b1..a359e457e6c0 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1715,6 +1715,8 @@ static int record_arg_access(struct bpf_verifier_env *env,
 		info = bpf_helper_stack_access_bytes(env, insn, arg_idx, insn_idx);
 	} else if (bpf_pseudo_kfunc_call(insn)) {
 		info = bpf_kfunc_stack_access_bytes(env, insn, arg_idx, insn_idx);
+	} else if (bpf_pseudo_call(insn)) {
+		info = bpf_global_subprog_stack_access_bytes(env, insn, arg_idx, insn_idx);
 	} else {
 		for (int f = 0; f <= depth; f++) {
 			err = mark_stack_read_all(env, instance, f, insn_idx);
@@ -1736,7 +1738,7 @@ static int record_arg_access(struct bpf_verifier_env *env,
 	return err;
 }
 
-/* Record stack access for a given 'at' state of helper/kfunc 'insn' */
+/* Record stack access for a given 'at' state of helper/kfunc/global subprog 'insn' */
 static int record_call_access(struct bpf_verifier_env *env,
 			      struct func_instance *instance,
 			      struct arg_track *at,
@@ -1744,12 +1746,19 @@ static int record_call_access(struct bpf_verifier_env *env,
 {
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	struct bpf_call_summary cs;
-	int r, err, arg_slot_cnt = 5;
+	int r, err, callee, arg_slot_cnt = 5;
 
-	if (bpf_pseudo_call(insn))
-		return 0;
-
-	if (bpf_is_callx(insn))
+	if (bpf_pseudo_call(insn)) {
+		/*
+		 * analyze_subprog() handles static callees. For global callees,
+		 * derive effects from argument types so may_write marks remain
+		 * conservative under freplace.
+		 */
+		callee = bpf_find_subprog(env, insn_idx + insn->imm + 1);
+		if (callee < 0 || !bpf_subprog_is_global(env, callee))
+			return 0;
+		arg_slot_cnt = MAX_BPF_FUNC_ARGS;
+	} else if (bpf_is_callx(insn))
 		/*
 		 * The callee is not known statically. Assume that all arg
 		 * slots are passed and let record_arg_access() conservatively
@@ -2282,7 +2291,12 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 		if (bpf_pseudo_call(insn)) {
 			target = idx + insn->imm + 1;
 			callee = bpf_find_subprog(env, target);
-			if (callee < 0)
+			/*
+			 * Global subprograms can be freplaced, so conservatively derive
+			 * their stack effects from their BTF signatures instead of
+			 * analyzing them in the context of their callers.
+			 */
+			if (callee < 0 || bpf_subprog_is_global(env, callee))
 				continue;
 
 			/* Build entry args: R1-R5 and stack args from at_in at call site */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8987c9a69d10..a5456a6e2694 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14571,6 +14571,72 @@ bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn
 	return info;
 }
 
+/*
+ * Called before dead code elimination, some subprograms may be genuinely unreachable.
+ * Suppress diagnostics so callers can use a conservative result on error.
+ * The main pass would report errors for reachable subprograms.
+ */
+static bool try_btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
+{
+	struct bpf_prog *prog = env->prog;
+	u32 log_level = env->log.level;
+	int err;
+
+	if (!prog->aux->func_info || !prog->aux->func_info[subprog].type_id)
+		return false;
+
+	env->log.level = 0;
+	err = btf_prepare_func_args(env, subprog);
+	env->log.level = log_level;
+	return !err;
+}
+
+/*
+ * Derive stack effects for a global subprog's argument slot @arg (0-based)
+ * from its declared type, matching the main pass's argument checks.
+ */
+struct arg_access_info
+bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
+				      int arg, int insn_idx)
+{
+	struct arg_access_info info = {
+		.size = U32_MAX,
+		.may_read = true,
+		.may_write = true,
+	};
+	struct bpf_subprog_info *sub;
+	int callee;
+
+	callee = bpf_find_subprog(env, insn_idx + insn->imm + 1);
+	if (callee < 0)
+		return info;
+	sub = subprog_info(env, callee);
+	if (!try_btf_prepare_func_args(env, callee))
+		return info;
+
+	switch (base_type(sub->args[arg].arg_type)) {
+	case ARG_UNUSED:	/* Not an argument slot. */
+	case ARG_ANYTHING:	/* A scalar, the callee can't dereference it. */
+		return (struct arg_access_info) {};
+	case ARG_PTR_TO_BTF_ID:
+		/*
+		 * Trusted arguments cannot be stack pointers.
+		 * Untrusted arguments use ARG_IGNORE:
+		 * probe reads need no caller stack state, writes are prohibited.
+		 */
+		return (struct arg_access_info) {};
+	case ARG_PTR_TO_MEM:
+		/* mem_size is zero for untrusted pointers of unknown size. */
+		if (sub->args[arg].mem_size) {
+			info.size = sub->args[arg].mem_size;
+			info.must_write = true;
+		}
+		return info;
+	default:
+		return info;
+	}
+}
+
 /* check special kfuncs and return:
  *  1  - not fall-through to 'else' branch, continue verification
  *  0  - fall-through to 'else' branch

-- 
2.53.0
