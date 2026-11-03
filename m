Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749465;
	b=uQ702p8SRBQTQ2+cMDoTdSneA3hvqJDC/6JOnv3cj6WrS7R2BNKozLpnSNNJFlncy05d
	 uCY5Y824QpQFZwJ8UuniDdOmfxQfX0o8YohxykT4xMxf3vBKgR/Kr6RKks/SHApkc17IF
	 2J+GH6R4+BO1mIO0k4cE8Jv2rcOcpsAN9aKrru2m3F2CpPSWg8rNw9iK7CVqJ89A5uoBp
	 0JL9S5/An9kFMJUud50CeOwMzIC4IbYCHe3YMsgv8GSDKNOHwyyfkdS/Tqc0PSLmnSto+
	 iybteIqJlF3E4WZUhidT5qRzyr9+dk5ykXnYAEgfHNlT0cNVbExNcJaa4CsjeDUi5xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BZoasUiYnz+7jweIuepyJO3T7la+ZiMRNgoP8xDcrTI=;
	b=u3CGAKSZkqJ8eKAvlSDXyQyn79xGvEWprPwytzGayR7+uq5HuXnQUmDeuJvCR3LezTjO
	 NXJobFArRzyBLvgoj3EXyEzpt+6fxtNzph2nWt3xmox6OkXo4FBbSG8PvPlwoRViB8nH1
	 F9/DLBti7xht+HkqdDsc2vSVbV2jbWnmcFKDZqPDab2vWboUMbMsc83y5FsYQwjAH/B7T
	 JBOtu3sYV8WtIVDQh6lDhRfVk5hkJlMprK/exuitKe29mESOP3eX1PrftLKV22vckk87X
	 ona0Fl30idtWUo3bck2PI0JIQxKMycHxEkVfqLCT7QnH9gvycoblyBASZN5xGF+8aqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EYNpinaq;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76707606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76707606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EYNpinaq
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9d7791b00so796325ad.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749465; x=1794354265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZoasUiYnz+7jweIuepyJO3T7la+ZiMRNgoP8xDcrTI=;
        b=EYNpinaqYczZRxv/STrgDdaELUOn1/lvH63l31owp56lyaEQNEBbAP07+fQg/zewYG
         inRUY2ZyDZN1Gz9nL4h0PGzRYPG/anNau28C8vDUzBL3pT5Y8zocttGgvtqms4bkjQ0M
         n8vTHz1YwYOvFEcoW6u2TW0ltRCoMCT8r0jWRUewT93GA/nLFmooPkwFB1gwkzoRcpKi
         xUySdztKPYz6ytgUt1n72zgAnWYFBLGT70OPcMoqPvO1J4tFnJ4NktYsedbRrNlVZ0i8
         P+ev5HyysnQVkejLSWi/dtA98NvhjvMg5nVJI5T7HpJtDCFL0s9DQzSbP10P662vslho
         uSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749465; x=1794354265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BZoasUiYnz+7jweIuepyJO3T7la+ZiMRNgoP8xDcrTI=;
        b=MKrjGWPs6HxE6w7UgwMYHs/ehF/998mv0YS+hPixbxgm5/e7MkIQFwzlCXwyOo3PVO
         +aLJll9mwSjh5ouXgdGS/16opeOLO3bGvbpLc+003lEmJeGlungF9kGenMasapUhzzb+
         jgsuMGlNGEpE9h/iXWVcyq5LDhWf2GvL5J1JpUrALaBTdJqEA3tuz1xMRuF5PA1nkLB0
         cOfrzmeml9CCO5ePK3ZtgL2AToIH/t9lBj0Ut2H4cOUu4B79V27Keuq2BzeRCUia0idt
         xQFMJBRMsLZ32w87N0YL6aClz9mi0ifBRNvBrQ+Rd8tw/530lG1sHx8JYXE7fJKizk0o
         1inQ==
X-Gm-Message-State: APuU4Z/N0wiUZTY421S74RZ0QSlBlHiitIwsF3Z0Qmg4n4qX3T8gyNxF
	xJEJnVqIBW3eRX2skJOckMkYKERZvud5HsRebjuQAxVn4hRl2QoSs7nOjmkFrQ==
X-Gm-Gg: AYBFou0HEG+zPy74z4GG1DeiwRuQ2ER/omfblwSeFXfxfIbTehfu4z181DGOMeGca0e
	2VCeiXMLojp74FP9bqaW7fy+ZnE/rP8CJwKGjgsp18dqQMmCId1xAGQ/uCCReUIsdjwYuipAA51
	RctbBMRoYZ6tTFV9iO6/JAu934qWgo7YNf9u8BkkmVrxa65g5YhBIcViTrkD+7xU83q4Q+lm+uo
	Ro9HC1IKa/PfVvS40O9+cxv/J9z6UTGvd64FBtfu9j2FSeuQjbNEmo2kAtvtMQI715u1fq9oviA
	HrC4R6mF0ixhpn1ufXpA2CA/w0vQe+dTjT8VWzI93+WNr9BnHSqNqwukgpt0rZVr+1WnbiiXmvl
	ntzgAeWnOMNev3OUZzYEk3uQJmoQIUNIyOW2xqWGlcOqGjeReJ2mp8yZs+31/qUCITPUtwIHIPQ
	1Yp1WlxdPO5sLYHV55ZODHWdk3RvNNVL1Hxmr/dD0/CRT4084OadeaLLsUxImpFNSuDk2FK/Nbc
	Pca3d5m9vqBaYTTeSfLsFZJkgq43dXB7CxMrwC8TKpGeRRmDj5HeAn/K+TNxhOdBWehKpQl/QVU
	Zopj3zqqBi/7xrFU/3S6O/S+sdjd9wt+lElu8YctyfANj1zxsIXp/OK0gNoYBAbcmWFaY0eeXQQ
	uj0ZvAba+IkmkwJqEgOkqOBZ6MHcekk/dpTZgEYjo+KhmT28csF3Mljo2L83yyX/mkkWyns8wLT
	s=
X-Received: by 2002:a17:902:d484:b0:2e9:5ed2:c393 with SMTP id d9443c01a7336-2eb364faed2mr117745585ad.60.1793749464593;
        Tue, 03 Nov 2026 15:44:24 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed090a1475sm414965ad.41.2026.11.03.15.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:44:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 33/37] bpf: Keep the frame of analyze_subprog() small
Date: Tue,  3 Nov 2026 23:40:58 +0000
Message-ID: <20261103234104.208239-34-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

analyze_subprog() follows each chain of calls that passes a pointer to the
stack, and calls itself for each frame of the chain. Its own frame has
callee_args[], with one entry for each register and each stack argument.

"bpf: Allow 24 arguments of static subprogs" makes the array larger.

Move the array out of the frame. bpf_compute_subprog_arg_access() allocates
MAX_AT_TRACK_REGS entries for each depth one time, and frees them at its
end.

compute_subprog_args() has two more arrays of this kind, at_out[] and
at_stack_arg_entry[]. It has one caller, thus a compiler can inline it into
analyze_subprog(). Mark it noinline_for_stack. With clang 18 on arm64 and
24 arguments the frame of analyze_subprog() is 256 bytes and not 944 bytes.
The 16 frames of the longest chain take 4K of the 16K of the kernel stack
and not 14.75K.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index f51445ead384..bffa490318ce 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -70,10 +70,14 @@ struct live_stack_query {
 	u32 insn_idx;
 };
 
+struct arg_track;
+
 struct bpf_liveness {
 	DECLARE_HASHTABLE(func_instances, 8);		/* maps (depth, callsite) to func_instance */
 	struct live_stack_query live_stack_query;	/* cache to avoid repetitive ht lookups */
 	u32 subprog_calls;				/* analyze_subprog() invocations */
+	/* MAX_AT_TRACK_REGS for every depth: analyze_subprog() calls itself, keep its frame small */
+	struct arg_track *callee_args;
 };
 
 /*
@@ -838,7 +842,7 @@ struct spill_snapshot {
 
 /*
  * Combined register + stack arg tracking: R0-R10 at indices 0-10,
- * outgoing stack arg slots at indices MAX_BPF_REG..MAX_BPF_REG+6.
+ * outgoing stack arg slots at indices MAX_BPF_REG..MAX_AT_TRACK_REGS-1.
  */
 #define MAX_AT_TRACK_REGS (MAX_BPF_REG + MAX_STACK_ARG_SLOTS)
 
@@ -1970,12 +1974,14 @@ static void record_stack_ptrs(struct bpf_verifier_env *env, int idx, struct arg_
  * @callee_entry: pre-populated entry state for R1-R5 and stack args
  *                NULL for main (subprog 0).
  * @info:         stores at_in, len for debug printing.
+ *
+ * Not inlined: at_out[] and at_stack_arg_entry[] would be in each frame of analyze_subprog().
  */
-static int compute_subprog_args(struct bpf_verifier_env *env,
-				struct subprog_at_info *info,
-				struct arg_track *callee_entry,
-				struct func_instance *instance,
-				u32 *callsites)
+static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
+						   struct subprog_at_info *info,
+						   struct arg_track *callee_entry,
+						   struct func_instance *instance,
+						   u32 *callsites)
 {
 	int subprog = instance->subprog;
 	struct bpf_insn *insns = env->prog->insnsi;
@@ -2308,7 +2314,8 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 	/* For each reachable call site in the subprog, recurse into callees */
 	for (int p = po_start; p < po_end; p++) {
 		int idx = env->cfg.insn_postorder[p];
-		struct arg_track callee_args[MAX_AT_TRACK_REGS] = {};
+		struct arg_track *callee_args = env->liveness->callee_args +
+						depth * MAX_AT_TRACK_REGS;
 		struct arg_track none = { .frame = ARG_NONE };
 		struct bpf_insn *insn = &insns[idx];
 		struct func_instance *callee_instance;
@@ -2316,6 +2323,7 @@ static int analyze_subprog(struct bpf_verifier_env *env,
 		int caller_reg, cb_callee_reg;
 
 		j = idx - start; /* relative index within this subprog */
+		memset(callee_args, 0, MAX_AT_TRACK_REGS * sizeof(*callee_args));
 
 		if (bpf_pseudo_call(insn)) {
 			target = idx + insn->imm + 1;
@@ -2438,9 +2446,13 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 
 	env->callsite_at_stack = kvzalloc_objs(*env->callsite_at_stack, insn_cnt,
 					       GFP_KERNEL_ACCOUNT);
-	if (!env->callsite_at_stack) {
-		kvfree(info);
-		return -ENOMEM;
+	env->liveness->callee_args = kvcalloc(MAX_CALL_FRAMES * MAX_AT_TRACK_REGS,
+					      sizeof(*env->liveness->callee_args),
+					      GFP_KERNEL_ACCOUNT);
+	if (!env->callsite_at_stack || !env->liveness->callee_args) {
+		err = -ENOMEM;
+		insn_cnt = env->callsite_at_stack ? insn_cnt : 0;
+		goto out;
 	}
 
 	/*
@@ -2478,6 +2490,8 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 		kvfree(env->callsite_at_stack[k]);
 	kvfree(env->callsite_at_stack);
 	env->callsite_at_stack = NULL;
+	kvfree(env->liveness->callee_args);
+	env->liveness->callee_args = NULL;
 	for (k = 0; k < env->subprog_cnt; k++)
 		kvfree(info[k].at_in);
 	kvfree(info);
-- 
2.55.0

