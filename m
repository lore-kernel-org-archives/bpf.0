Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983775;
	b=j2BRGUiOJPfLcJwBzs7HM8gXMByP3o3vDhrdA4BJiFQT4psFq/ZJq8JSIDjnahXZxRfs
	 sTNIaQv9zH2ICY/eIetFzhOOZxYwa407u4gqiVk/EHYRBWfOOBsu/+fiv1LW/zCn3swyt
	 wc2JADW2+sKucupwmAcCCikdaFK1qsr4krht+VxHKIxcHdIoDpHfbpDgJq1SPhYG57jXw
	 Qxhe1HloqkqsYWKugihoBq+/RkkwBjBHIPFbzPGzxrq0hdXoyqu2Ns31Oy3MkSnnTobpD
	 ZIMutjMTMWl5kI7eND14QwLU9Za9w3y2bPAYg2nVcUAPmGgUICH9ldSHCdhk7dZlS1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983775;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IkxxzTGUBEJW5NIhWW7j7FFkwNUt6tZeHXqSn1mZ5+A=;
	b=onWCVhvrNSvrmdDJpKyHNz7Sg1OjbnT+jAhF3N0CES1ewuyYjsRMNAcOf+J3K+fg7Amn
	 kxThaqjGnYJbVnGbP4vqa6lAFhJZRetbUskNQBJIGJa3E/oMPyHyXe4+D9u+cOHVsXphe
	 sfaHekx51nnDSJ150jiJx06fiE43YfXN47nLTSyWGELFBFRmYgYdOabl0Wv3boigU08x8
	 sdUjayJZqrPHyWIwp0qF44xqswHd+5IHFKd0k64zYc4vCT3KIqz8T1U+gXhOZi2KU/vOW
	 mXhiFg0ulrM3rk0h6hXvhy5BwKYkblJpQl7GsP44EhPPLbtCnnVAX8M2Geez7KsePlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d7OQvYvP;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CD6606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23CD6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d7OQvYvP
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso897284a12.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983774; x=1793588574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IkxxzTGUBEJW5NIhWW7j7FFkwNUt6tZeHXqSn1mZ5+A=;
        b=d7OQvYvPWh+fDXy6Qz1by4RfR7uIkyGkLTuRnLwBb/1vWiHwj990zoeSX1w08fi6MG
         mnGJixK9ol2mkxPQF67Ce7Cd1fSLv2r/jxjMQtYEiKAw5HPS/6uhMY+jyamrzZ+8Krby
         /DmHRspzHr046HogucmsTa0bWsZDWtY7zrx0w6W2x3lkAAlKOgZu9jGiRk9lQS2fXl4x
         hd2pjnanIXRK/KDXdwbsFf4j5U2aeKRG8NmqQVYEDz8/Pj1N3XGac5O/fWXoQw/EPFHa
         t3Z1W3y2XtRreTqjlMXUFBZ474z1QtSUOgGwSUTRtYoZQEKlRP8i0XrAATsk0ZoD9M2T
         HbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983774; x=1793588574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IkxxzTGUBEJW5NIhWW7j7FFkwNUt6tZeHXqSn1mZ5+A=;
        b=ZmqgOscwP7UeS90a9SE5hMgoGln6ouT/73/4RhMaVBTtygmxR1E77DssvWJ2PAtIa+
         xEXp4t+/7t+VB6f8tcj2NpqMYOvVjfrLygcLoPTzvuN+J2inIMT33Va12amICsmM1hbb
         mh5kXtB5ae/5I+slNS21iFEB8yQ8QUQCA5gDf0Ou1Y6mvvdJzc23hvfdGkNquwzsi1x2
         q89YueiwapobIgeFQgkpAtIu43ODH0d9URtMxkwkcB2XI3ak1NQxosz5D5UQIUC/vUOc
         GjRs979+FOykZvzlrzRkenv57PHqWedYlyxf9BSyDtWkUyn5UYstSzuSE7Sin/tx7KzH
         6qmw==
X-Gm-Message-State: AFq9FYIDOfTtcNBUw56+VeeT5EU0AHMqoYRr4ijGHwxokYh3ALfczszT
	subv7MaeBwPmN6l6H7Wda4JnM5UcmQWZiZBfz/4O2TXuXpVKdjI2dnsj1b087w==
X-Gm-Gg: AYBFou2ZKNB0pbGAqiLrE56OLLb6LZeU1ywMspwIegKOuUcYL3e3U32prC8k03UHizn
	KjYgRLOFG0/r0Gk8WhCl5ihh86+sknf4zbjzuuqGFvM8A776h/59zup4M52V9/Fs7uahIfw4fBC
	hCDXsH8AMsDvt8bPeR6K2n3uZvskED6xV8OM2w8cwt7/petlgXoQaIGCnWCkjcNbFRAodBAps5R
	eIrZ3+zsH2Co8fYrwmRdNBq9dqaJudRjdTXuN/GxNbMNV9/tZnIllCwU3D/jicymn0xAN0Ey7F1
	45AKJ8m37uvk1jUpDjBk696hiR4ZZv0Oon2vcMs/Xu9AMEHWKis2iTkh8EJq/aDGF8lQhCnDQ6u
	p7laDeUONwNLzcjUhnMwbFKs5t8iDM6wcK194KCkqLekca5Zxh9mQ7LDX1aCI+6qvqCYKN/oLio
	t2ftqZQmTAGyNFAzzhgvkmpOWnxMd9cWPXV02VP2NFwU3Ii8xM5uB0KIfsvM/JATdZI2Ac9XcIj
	O/wvoikVfv0JgefEkCxwy64Fi3lXE3ZbtD8/KlpmtDGYX2MJsTctG/xt2NNZucxNdiHiaB3lXMK
	vt0kbw9puuN0gjUn5IY3lDFglAOU0hT2qugUpQfg6RQ3yejgN5ffIL/jcCBaa7xq6xhdVOltQPJ
	cdv7MfFDhXi+5LqXSnUS3QP2oMw==
X-Received: by 2002:a17:90b:52c4:b0:3ac:9176:e82b with SMTP id 98e67ed59e1d1-3adeae778a9mr4432293a91.54.1792983774310;
        Sun, 25 Oct 2026 20:02:54 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebacbf5fsm6549612a91.6.2026.10.25.20.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:02:54 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 32/81] bpf: Count stack arguments of a static subprog from its code
Date: Mon, 26 Oct 2026 02:58:53 +0000
Message-ID: <20261026025943.404450-33-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

A subprog gets its first 5 arguments in r1-r5. The caller stores the 6th
and subsequent arguments through r11, and the subprog loads them through
r11. The verifier takes the number of these stack arguments from the BTF
prototype of the subprog.

But BTF describes the source. It does not describe what the compiler passes
to a static function. rustc returns Option<i32> through a hidden pointer,
and it passes Option<i32> in two registers:

  fn pick_idle_cpu(p: Task, prev_cpu: i32, this_cpu: Option<i32>,
                   wake_flags: u64) -> Option<i32>

                            BTF    code
  pointer to the result       -       1
  p                           1       1
  prev_cpu                    1       1
  this_cpu                    1       2
  wake_flags                  1       1
  total                       4       6

The verifier rejects the load of the 6th argument,
'r3 = *(u64 *)(r11 + 8)':

  invalid read from stack arg off 8 depth 0

For a static subprog use the code. The number of its stack arguments is the
highest slot that it loads through r11.

This is safe, because the verifier verifies a static subprog with the state
of its caller. A load through r11 gives the value that the caller stored,
as r1-r5 give the values that the caller set. At each call and callx the
verifier checks that the caller stored all the slots that the subprog
loads.

Global subprogs do not change. The verifier verifies them without a caller,
thus BTF is the only source.

What else changes:
 - A caller gets space only for the slots that its callees load. Thus the
   verifier can reject a caller that stores an argument that no callee
   loads.
 - Helpers and kfuncs pass arguments to callbacks in registers only. Reject
   a callback that loads through r11.
 - A trampoline knows only the arguments that BTF shows, and it would lose
   the others. Refuse fentry and fexit to a static subprog that has stack
   arguments when its code and its BTF do not agree.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |  2 +
 include/linux/bpf_verifier.h |  9 +++++
 kernel/bpf/btf.c             |  3 +-
 kernel/bpf/verifier.c        | 71 ++++++++++++++++++++++++++----------
 4 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d62dc3f7f148..3e4c317e0c7a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1785,6 +1785,8 @@ struct bpf_func_info_aux {
 	bool called[BPF_FUNC_CTX_CNT];
 	bool verified[BPF_FUNC_CTX_CNT];
 	bool called_with_pkt_ptrs;
+	/* The code of a static function loads stack arguments */
+	bool stack_args;
 };
 
 enum bpf_jit_poke_reason {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2c19c3aea1d5..806282c39c57 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -980,6 +980,13 @@ struct bpf_subprog_info {
 	bool uses_arena_sp: 1;
 	/* a callback that takes a stack in arena, like the main program does */
 	bool arena_stack_entry: 1;
+	/*
+	 * Static subprog: the number of arguments on the stack is what the code
+	 * loads. BTF describes the source. The compiler may pass something else:
+	 * a hidden pointer to the result, a pair in two registers, no dead arguments.
+	 */
+	bool stack_args_from_code: 1;
+	u8 code_stack_args:4;
 	u8 arg_slot_cnt:4;
 
 	enum priv_stack_mode priv_stack_mode;
@@ -990,6 +997,8 @@ struct bpf_subprog_info {
 
 static inline u16 bpf_in_stack_arg_cnt(const struct bpf_subprog_info *sub)
 {
+	if (sub->stack_args_from_code)
+		return sub->code_stack_args;
 	if (sub->arg_slot_cnt > MAX_BPF_FUNC_REG_ARGS)
 		return sub->arg_slot_cnt - MAX_BPF_FUNC_REG_ARGS;
 	return 0;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7ed1ff71a089..274ef78b6e1c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8751,7 +8751,8 @@ static int btf_check_arg_slots(struct bpf_verifier_log *log, const char *tname,
 			tname, slot_cnt);
 		return -EFAULT;
 	}
-	sub->stack_arg_cnt = slot_cnt - MAX_BPF_FUNC_REG_ARGS;
+	if (!sub->stack_args_from_code)
+		sub->stack_arg_cnt = slot_cnt - MAX_BPF_FUNC_REG_ARGS;
 	return 0;
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fb80bc4d2d01..0f2bae1c2305 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11362,7 +11362,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
 	const struct btf_type *func, *func_proto;
 	struct bpf_call_arg_meta meta;
 	struct bpf_func_proto *fn;
-	int ret, err;
+	int ret;
 	u32 i;
 
 	memset(&meta, 0, sizeof(meta));
@@ -11371,16 +11371,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
 	meta.func_name = bpf_subprog_name(env, subprog);
 
 	ret = btf_prepare_func_args(env, subprog);
-	if (ret) {
-		if (bpf_in_stack_arg_cnt(sub) > 0) {
-			err = check_outgoing_stack_args(env, caller, sub->arg_slot_cnt,
-							bpf_subprog_name(env, subprog),
-							NULL, NULL);
-			if (err)
-				return err;
-		}
+	if (ret)
 		return ret;
-	}
+	/* BTF doesn't describe what the code does */
+	if (sub->stack_args_from_code &&
+	    max_t(int, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS) !=
+	    MAX_BPF_FUNC_REG_ARGS + bpf_in_stack_arg_cnt(sub))
+		return -EINVAL;
 
 	func = btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id);
 	func_proto = btf_type_by_id(btf, func->type);
@@ -11446,6 +11443,12 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	int err;
 
 	caller = state->frame[state->curframe];
+	/* helpers and kfuncs pass arguments to callbacks in registers */
+	if (bpf_in_stack_arg_cnt(&env->subprog_info[subprog])) {
+		verbose(env, "callback %s() cannot have stack arguments\n",
+			bpf_subprog_name(env, subprog));
+		return -EINVAL;
+	}
 	err = btf_check_subprog_call(env, subprog);
 	if (err == -EFAULT)
 		return err;
@@ -11546,6 +11549,11 @@ static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 	if (stack_arg_cnt > caller_info->stack_arg_cnt)
 		caller_info->stack_arg_cnt = stack_arg_cnt;
 
+	err = check_outgoing_stack_args(env, caller, MAX_BPF_FUNC_REG_ARGS + callee_incoming,
+					bpf_subprog_name(env, subprog), NULL, NULL);
+	if (err)
+		return err;
+
 	/*
 	 * For regular function entry setup new frame and continue
 	 * from that frame.
@@ -15204,12 +15212,31 @@ static bool try_btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 /* Prepare argument metadata for liveness; the main program is handled separately. */
 static void prepare_subprog_args(struct bpf_verifier_env *env)
 {
-	int i;
+	struct bpf_subprog_info *sub;
+	struct bpf_insn *insn;
+	int i, j, cnt;
 
 	for (i = 1; i < env->subprog_cnt; i++) {
+		sub = &env->subprog_info[i];
 		if (!try_btf_prepare_func_args(env, i) && bpf_subprog_is_global(env, i))
 			/* Keep all argument registers live if the prototype is unavailable. */
-			env->subprog_info[i].arg_slot_cnt = MAX_BPF_FUNC_REG_ARGS;
+			sub->arg_slot_cnt = MAX_BPF_FUNC_REG_ARGS;
+		if (bpf_subprog_is_global(env, i))
+			continue;
+		cnt = 0;
+		for (j = sub->start; j < (sub + 1)->start; j++) {
+			insn = &env->prog->insnsi[j];
+			if (is_stack_arg_ldx(insn))
+				cnt = max(cnt, insn->off / BPF_REG_SIZE);
+			if (bpf_is_ldimm64(insn))
+				j++;
+		}
+		sub->stack_args_from_code = true;
+		sub->code_stack_args = min(cnt, MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS);
+		/* incoming + max outgoing. Calls add the latter. */
+		sub->stack_arg_cnt = sub->code_stack_args;
+		if (env->prog->aux->func_info_aux)
+			env->prog->aux->func_info_aux[i].stack_args = sub->code_stack_args;
 	}
 }
 
@@ -22630,18 +22657,21 @@ static int flatten_bpf_func_model(struct bpf_verifier_log *log, const char *tnam
 }
 
 /*
- * The verifier lets a static function use stack arguments counted from its
- * BTF, even if that BTF turns out unreliable. A trampoline on the function is
- * then given only MAX_BPF_FUNC_REG_ARGS u64 arguments and would lose the
- * stack arguments, so such a function cannot be attached to.
+ * The verifier lets a static function use the stack arguments that its code
+ * loads, whatever its BTF says. When BTF is unreliable a trampoline on
+ * the function is given only MAX_BPF_FUNC_REG_ARGS u64 arguments and would
+ * lose the stack arguments, so such a function cannot be attached to.
  */
 static int check_unreliable_func_args(struct bpf_verifier_log *log, struct btf *btf,
-				      const struct btf_type *func_proto, const char *tname)
+				      const struct btf_type *func_proto, const char *tname,
+				      bool stack_args)
 {
 	struct btf_func_model m;
 	u32 i, nslots = 0;
 
-	if (btf_distill_func_proto(NULL, btf, func_proto, tname, &m)) {
+	if (stack_args) {
+		nslots = MAX_BPF_FUNC_REG_ARGS + 1;
+	} else if (btf_distill_func_proto(NULL, btf, func_proto, tname, &m)) {
 		/* at least a slot for each argument */
 		nslots = btf_type_vlen(func_proto);
 	} else {
@@ -23012,7 +23042,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 
 		if (tgt_prog && conservative) {
 			if (subprog > 0) {
-				ret = check_unreliable_func_args(log, btf, t, tname);
+				struct bpf_func_info_aux *fa = tgt_prog->aux->func_info_aux;
+
+				ret = check_unreliable_func_args(log, btf, t, tname,
+								 fa[subprog].stack_args);
 				if (ret)
 					return ret;
 			}
-- 
2.55.0

