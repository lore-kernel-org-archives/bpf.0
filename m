Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A853932C3
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786845482; cv=none; b=qSteng85t6nCIbVsHPHdqVmywFzZY91NT70lhX2ik4g63f+s9sPgb0MxiCWP9j+o+OPZcOqCj55gvR72/aeUiiFeBRWHzs/UksFmK5ojITL7kC3p9bDbHYxArMFZIhUxkTNSeYKMFEwljJqC99CyFdJaC/YoV+L1ib9+25aG/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786845482; c=relaxed/simple;
	bh=PMhkufPlfAXLAXuXuztc7uOys6SyAAJvpBxgdM1XE30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOUO2y7gDlAO3kkmb8nnRqG39ZO3K61I3nfDcW9+Y5u1d29DQ3LbXupkRZa7gP7fNwzf570OiPyoohoNXhX1Xez0UimgXsmuY+ztVQ4O+46MD22GfTztXJQKWk9SQzVxFTnUPxrHs6X7QR/sJe2HB+VmYp9p95WNk4u2HEg0IxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx4KBlos; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx4KBlos"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-47de008b020so1324642f8f.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 18:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786845478; x=1787450278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=55h8Ctds775sB1f/uWwswbajNjVd2y+mCCmAtsHdNM4=;
        b=fx4KBlosoQYdbxHGPGYRTta5jRS4ZHfhOzO6+4902vBWyQ7DFjKdXTHWs3tGwSsdoz
         qqpbIBkC8TsWfthN30ooJY+momGjpZAAoItrIWusTrM8UkuoAWp2tIQK8pXjCyCDqjOM
         5/vi8VJ5htPwpXeqdN1kMGEmvLTMbCON/k3htBvnzLQvKFoZCMbaQCp9RZ57ImoQH4b1
         1leFUYd907C9GfNEZkwKEY1431/xWVpjdCJH3oUkW5oP6H3KObIVD8Nt8WEsr98RhpC5
         6B7mhjax3+rwf08PLcattlFm9uO3YVohkY5eMmhT+ZlE5VR1bX99O0uLom2ARgseJ9Vg
         MSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786845478; x=1787450278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=55h8Ctds775sB1f/uWwswbajNjVd2y+mCCmAtsHdNM4=;
        b=KCgcfah2amqq6gtUTm9m6ZBLiDHkY9qXKH9SEPlMofyelUaqTJ7wWZmw927E5JMhQL
         4xMLhPNy9XQriCFXu7UcKMly8VclQ7cHZsh3U/h8F38JfH6BdiyfAOHXbnVL3gHCROIv
         RcN82hN4z54Sntt1RYA7nUX+2T1r+kX+umNacSHOoA+/aE6oRmcwdxWt30OSsa4ZuxVz
         37NWspM30nkzd+vfNldbvslEP5NCbZYXl5BCpftDScVy6P3MbRInJ4gkke8GQIBUa4ec
         hKU7uGAgEvXXnhhkhWs5oH0o+g8GdEO0hAE49YBn92QY+dS8M6XVi4RvKF7fR/bMJzp0
         v/Nw==
X-Gm-Message-State: AOJu0YyZjZVufTWoPWpp0FbSg/CRaHDHFrj3Qd6g7DIDKMJScnaUJTSs
	aX5tdNvZaRph5LJncmv6AmnJkkavL1S9WKqMO6jX+ntUu7YMy5XY7WENblLVZOiu
X-Gm-Gg: AR+sD12ZDq7sGVCbNakmP+xqPiarIo3a2Sep05UDMwWD9iKTqH2eSteIUaJ2JTOQPrL
	YQj5OtlxxI4ysnucJntcqe0lxeqexAtU2aUI0z1IhQRRvqowLxP0K/bBfPoOIkFS+ParCsEQ+tr
	Dq5qXtpuAV2QcRU0suUoFBvB7K5PC0NrG/q96rHLr6qC3rR8JDGKDA9YWx00M+FsTYBps4y4gZQ
	mkzgw6yaUkhLw/nSfBMU6+ov3k0HJUpAO2AYi4oreWR/o7+iquyOlArno3+Kr2QnS8/zHeKLCvG
	dPwrd011C7IgX1D5KOqDwh4UB7R88H/MRMkLMoIBQiXQLQ2o6rENRfVzHcJQYQemymWO0SxiGUu
	Tzd18xd+2PW4ZS8pBbJB526QoTekaF5mLCCJbJdce2TsLCXp1HXysPFFcLceJOGGHHG7yz48lz9
	2JLu5Pi2C2S0T2iRJ6BFVjtxg/FV/q3fAGrDb8anfjoxQbET8kUte0YEmoMIS16u99EjCG31QPD
	peffA/T+EuCf/lsAWp7og/yxGbhhwmhSCF9u0xNJXTPA12rGf/N+dlcSbgY/7GOZnjCnEZINT2J
	husK+6AN3gCXmqjqc4zo27nYUFM=
X-Received: by 2002:a05:6000:1865:b0:47f:71a0:c060 with SMTP id ffacd0b85a97d-4815a4de806mr36901341f8f.2.1786845478588;
        Sat, 15 Aug 2026 18:57:58 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c6115sm20559801f8f.32.2026.08.15.18.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:57:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 08/14] bpf: Report non-sleepable kfunc programs accurately
Date: Sun, 16 Aug 2026 03:57:36 +0200
Message-ID: <20260816015746.2632990-9-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816015746.2632990-1-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5862; i=memxor@gmail.com; h=from:subject; bh=PMhkufPlfAXLAXuXuztc7uOys6SyAAJvpBxgdM1XE30=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatRQvytn1fatJn8J2Xkz3v/X7zKVWnm7KfqAqptqzdOm X6XacaRjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzk00NGhv8u6R3nOKvjkvwe TN36StFBPiNshs5zf2+G5A36KfedXzL8M61v9PKNU77gcm5Xrl/2zoAAD4eFIQ5taR+0H13k2GP EAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A sleepable kfunc call can fail either because the program is not sleepable
or because an otherwise sleepable program has entered a non-sleepable
critical section. check_kfunc_call() checks these conditions separately. The
first check is only gated by in_sleepable(), so the shared diagnostic can
blame an active RCU, preemption-disabled, IRQ-disabled, or locked region even
though leaving that region would not make the program sleepable. Adding a
second diagnostic entry point only to force the program context would
duplicate the API.

Reject the call once based on in_sleepable_context(). Teach the shared
bpf_diag_ctx_forbidden() reporter to prefer the non-sleepable program when the
current verifier state is not sleepable; otherwise preserve the RCU, preempt,
IRQ, and lock priority for active contexts. Select the kfunc message and
suggestion according to that cause, and align the helper and global-function
descriptions with the same priority.

This avoids a diagnostic-only wrapper while retaining context history for
sleepable programs that enter a forbidden region.

Link: https://lore.kernel.org/bpf/2e42a1a2bf45f4d2aba7495bdc9f147558055740e2f3c8b9dae255f6c57fc13c@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c |  4 +++-
 kernel/bpf/verifier.c    | 34 ++++++++++++++++++----------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 2c475174a640..df9259fa0ea7 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1083,7 +1083,9 @@ void bpf_diag_ctx_forbidden(struct bpf_verifier_env *env, u32 insn_idx,
 	const char *constraint, *context;
 	u32 depth;
 
-	if (env->cur_state->active_rcu_locks)
+	if (!env->cur_state->in_sleepable)
+		ctx_kind = BPF_DIAG_CONTEXT_NONE;
+	else if (env->cur_state->active_rcu_locks)
 		ctx_kind = BPF_DIAG_CONTEXT_RCU;
 	else if (env->cur_state->active_preempt_locks)
 		ctx_kind = BPF_DIAG_CONTEXT_PREEMPT;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index da2ec0655b17..3de9e4f617b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9912,7 +9912,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				sub_name, non_sleepable_context_description(env));
 			operation = bpf_diag_fmt(env, "sleepable global function %s()", sub_name);
 			bpf_diag_ctx_forbidden(env, *insn_idx, operation,
-				"Move the call outside the critical section, or use a non-sleepable function.");
+				"Call the function from a sleepable program outside any critical section, or use a non-sleepable function.");
 			return -EINVAL;
 		}
 
@@ -10731,6 +10731,8 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env)
 {
+	if (!in_sleepable(env))
+		return "non-sleepable prog";
 	if (env->cur_state->active_rcu_locks)
 		return "rcu_read_lock region";
 	if (env->cur_state->active_preempt_locks)
@@ -10739,7 +10741,7 @@ static const char *non_sleepable_context_description(struct bpf_verifier_env *en
 		return "IRQ-disabled region";
 	if (env->cur_state->active_locks)
 		return "lock region";
-	return "non-sleepable prog";
+	return "non-sleepable context";
 }
 
 static int release_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
@@ -10835,7 +10837,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		operation = bpf_diag_fmt(env, "sleepable helper %s#%d",
 					 func_id_name(func_id), func_id);
 		bpf_diag_ctx_forbidden(env, insn_idx, operation,
-			"Move the helper call outside the critical section, or use a non-sleepable helper.");
+			"Call the helper from a sleepable program outside any critical section, or use a non-sleepable helper.");
 		return -EINVAL;
 	}
 
@@ -13760,11 +13762,20 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	sleepable = bpf_is_kfunc_sleepable(&meta);
-	if (sleepable && !in_sleepable(env)) {
-		verbose(env, "program must be sleepable to call sleepable kfunc %s\n", func_name);
+	if (sleepable && !in_sleepable_context(env)) {
+		const char *suggestion;
+
+		if (in_sleepable(env)) {
+			verbose(env, "kernel func %s is sleepable within %s\n",
+				func_name, non_sleepable_context_description(env));
+			suggestion = "Move the kfunc call outside the critical section, or use a non-sleepable kfunc.";
+		} else {
+			verbose(env, "program must be sleepable to call sleepable kfunc %s\n",
+				func_name);
+			suggestion = "Mark the program sleepable if the program type allows it, or use a non-sleepable kfunc.";
+		}
 		operation = bpf_diag_fmt(env, "sleepable kfunc %s", func_name);
-		bpf_diag_ctx_forbidden(env, insn_idx, operation,
-			"Mark the program sleepable if the program type allows it, or use a non-sleepable kfunc.");
+		bpf_diag_ctx_forbidden(env, insn_idx, operation, suggestion);
 		return -EACCES;
 	}
 
@@ -13864,15 +13875,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			invalidate_rcu_protected_refs(env);
 	}
 
-	if (sleepable && !in_sleepable_context(env)) {
-		verbose(env, "kernel func %s is sleepable within %s\n",
-			func_name, non_sleepable_context_description(env));
-		operation = bpf_diag_fmt(env, "sleepable kfunc %s", func_name);
-		bpf_diag_ctx_forbidden(env, insn_idx, operation,
-			"Move the kfunc call outside the critical section, or use a non-sleepable kfunc.");
-		return -EACCES;
-	}
-
 	if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
 		verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
 		return -EACCES;
-- 
2.53.0

