Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749304;
	b=vQwbCJjweJIVAU3LZb3UgQooGzhDrLQtJ+T36x4ps4+HwxRNsv7lKQVPLD5bWAl2W3aj
	 aWAFNADtRWaUq6qgzR5j+8GM06LYC5WSdw4xHzBAn7OURl2LyuborBctUSCbs7fU0ZseF
	 rzWAwTEedSPqHLzosSAcakpsWfrtXpz2941JDuTvpRX7z9nCGNX3xICgz5QvxlqtKUi10
	 Tdoe2ntgL8HeKKOhbkZLWcP32OcsEGZPsdRMrghxGRgrJUvnfmKuD/KbZuzVOwG5NG16t
	 EVfqNdOMKQkl5BDDcPN3GUGvdZADueFn2q8e/8m+sq789U4qkABkz5cNLp43TL0mFjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jrUTfIeSPKK20RKqrzsccNasrXp4AIx6ku5sVQKdH3U=;
	b=RZktX7mhAxLaeW2tRsm8+uUaVJ/O9/7Zix/H2sfXOWvr5+rFK8XubGvGsoCxC7wQX86S
	 Bz5tIuggzaQG8sp0LPMNdtn8BluPNyhklcbWaAR5Pybzo/ki/tkr2OqCtWFeHYIszH3S7
	 2ll51D3Ps5Lu7s2vhIhaIqIab9ZEDazeLnEHpl+7AsI7OnGQev3DaBSbHKKLuq2dfnsWX
	 4kmokfUUlnQv/HkbgzaZL2VKUDzALzH7FcnbCwiaY8bb/Nu0Pf/QJV0UDXhUjzJVQyqeh
	 nVVhDBJyFFR7DsITDt8DH0HKZ6opOD60AhmmACWgUG5oUQ5ewz+7Sv8DW454hhpkn9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jhzdAiTc;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A830606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A830606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jhzdAiTc
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso112898a91.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749303; x=1794354103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrUTfIeSPKK20RKqrzsccNasrXp4AIx6ku5sVQKdH3U=;
        b=jhzdAiTcVhY+hVUNQ1hOHazuk0gdZcZHT5NI8kCfQlw3W1Zfvi1WOjjt4QrPZR6J9Z
         1/1WAgZLsPIgj3KoMam+ZWTLbojDLNmUa0RHKwy2xX3wopzzUNiyCUSiS/NqKVYQlQbM
         MyWJyGyA38OpewGmoIyfUMDjSlWnU75OVeIE5zvNKquN89SmmtenruANCkwGfS/BrH1H
         7MGbgRVFI2b9E6LaAFyxCtx8J3U1rHJtTHogYO/H+lokj6sjfTB50nPO6uxSqw95Geqz
         caUBe07lTOOH8p8Qu0WReG0kATsgvwkj5+931N6A+Gwe1qM8gDDJUy6R1VtmvdGE0koE
         QcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749303; x=1794354103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrUTfIeSPKK20RKqrzsccNasrXp4AIx6ku5sVQKdH3U=;
        b=DkS8CflHUVDTK+nbyRAYX0uRyYutDIxNKOOW8IeZuD6q1a2iIB5ClfFlY80X/YGYIG
         scj0ZzEr/HG9G/ptcjY5EAWBFT6SyWXsQKimSgBJDXbgOvN51STl/p8wDmYtCA0cUWKE
         1cn7qX/fdx6qpRmsR5hhRqcIq9ncAZ4K9tHxtyDQXAL6BOCnSGPepHU4PTAsxXyCJuRx
         ixVQ1r/YRBKpfvNl5lUXbd6JSchS3y37xD8JsYYfKSvrWlTtPz+5c4gyPV3U8gbYN9JT
         GpjjQGpurz9hoehMaKODiG+uLe62QLxaM2F4N4L+Nn1B4QGRCAlFnKJFz1p3ctYvfBH8
         7FsA==
X-Gm-Message-State: APuU4Z+brymhcPeWpcYvyyEe9YV0Pi/rmrXRLVkY28FkHDqx+AMcS4Mq
	JEYKnYdCZrP9+8MeKC7Zse1DNewELH/LE1s54kCDP/DufrpgYajfN322qREjvw==
X-Gm-Gg: AYBFou2nb0rUchNSG5lNbdXeEzYsxJIaP+/D1eyGSIYI2ssVRYWFV/LPWeJYtI74MoV
	kPFBBB0yyyLGpR1IcczZ1AJ8mWaWDLknVdLZLjd+fa48p2ycU5Wi1x7wcl1krFEBsZq+6Igap9M
	DttL9E2lGQphGXKb5cWUBDRSWLq3JtUvz3b9X0WQon2fPHN73g4inCdbT9vpgw66k0PovjzIYJA
	8yQHdZsXINE+mFF8CUwSvFXeRfAVt2aK1MbL38/Cmm4JTIS5H5GGVoNq/nR/C/A0u9XIWQvwAw7
	Th1zzqjneX15XTa55udalrtM3tTTo7VB2nEwaOysBAfBiP8rww1a7lQVgQskiFrwa/0+ICTjuWX
	hwAz5HckdhCRbN2fBxWkTCsr1y9xUxKKIgOxbT9xIKhr+sT5GobupaMPidR3S4zRpvOxi4gIpFe
	5byc8ZaxdzkTpHLlVgSjBHgI/idSNM/fsyAUZPFHvL0SxFt2yryKs3/5L2x6eNU8tKqVyOTqA8a
	6cTdRyZOwr97gYfXaUAZsAmKSIrIRnuwx7HQdUWRV8voku64EhguluSlQa1cw2F68Fz369E9I1c
	0YrBiqLrEg6OO9T3t/PVmMMH4MLawlqCSXOLJ8mG+TiqsckZY7RFo2NU99RS1Pf1dvZlZOYWpDx
	LWbV6kHgVTcC1287C6d55a9HhHA5SfPQHpSJbyC+GkNMYQjlkowcoMIUXf88hAiNfMUHpQdheRA
	==
X-Received: by 2002:a17:90b:534c:b0:3a0:abc3:afb5 with SMTP id 98e67ed59e1d1-3ae897f5d26mr11419822a91.34.1793749302626;
        Tue, 03 Nov 2026 15:41:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8460acsm6462113a91.7.2026.11.03.15.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:41:42 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 06/37] bpf: Count stack arguments of a static subprog from its code
Date: Tue,  3 Nov 2026 23:40:31 +0000
Message-ID: <20261103234104.208239-7-alexei.starovoitov@gmail.com>
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

The caller stores the 6th and subsequent arguments of a subprog through
r11, and the subprog loads them through r11. The verifier takes the number
of these stack arguments from the BTF prototype of the subprog.

But BTF describes the source. It does not describe what the compiler passes
to a static function. rustc returns Option<i32> through a hidden pointer,
and it passes Option<i32> in two registers:

  fn pick_idle_cpu(p: Task, prev_cpu: i32, this_cpu: Option<i32>,
                   wake_flags: u64) -> Option<i32>

  BTF:  p, prev_cpu, this_cpu, wake_flags                        4
  code: result, p, prev_cpu, this_cpu (2 registers), wake_flags  6

  invalid read from stack arg off 8 depth 0

31 of the 225 progs of the sched-ext schedulers in rust-bpf have such a
function.

For a static subprog use the code: the number of its stack arguments is the
highest slot that it loads through r11 on any path, dead code included. The
verifier verifies a static subprog with the state of its caller, so a load
gives the value that the caller stored. At each call and callx the caller
must have stored all slots up to that number. The error is -EFAULT, as
today with reliable BTF. Two tests of verifier_stack_arg_order.c now fail
at the call: update their messages. Global subprogs do not change: BTF is
their only source.

A trampoline keeps only what BTF has. Thus BTF is unreliable when the code
loads more stack arguments, and then the attach is refused.

BTF alone does not reject a static subprog any more. The JIT is asked at a
store through r11, not when BTF has 6 parameters. More than 12 parameters,
or a slot of BTF that is neither stored nor loaded, make BTF unreliable.

The caller can store the slots that a callee loads, and the slots of the
prototype of a callee that it has stored when the verifier reaches the
call. A store to another slot is an error as before. Thus a callee that
ignores its last stack argument must have it in BTF. LLVM loads all stack
arguments at function entry, and it stores them in front of the call.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_verifier.h                  |   9 ++
 kernel/bpf/btf.c                              |  18 ++-
 kernel/bpf/fixups.c                           |   2 +-
 kernel/bpf/verifier.c                         | 106 ++++++++++--------
 .../bpf/progs/verifier_stack_arg_order.c      |   8 +-
 6 files changed, 81 insertions(+), 64 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ef94a168c902..ca8992702dbd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1765,6 +1765,8 @@ struct bpf_func_info_aux {
 	bool unreliable;
 	/* The function returns in R0:R2 */
 	bool ret_reg_pair;
+	/* The code of a static function loads stack arguments */
+	bool stack_args;
 	bool called[BPF_FUNC_CTX_CNT];
 	bool verified[BPF_FUNC_CTX_CNT];
 	bool called_with_pkt_ptrs;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4a514f27f239..581458927512 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -984,12 +984,21 @@ struct bpf_subprog_info {
 
 	enum priv_stack_mode priv_stack_mode;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
+	/*
+	 * Static subprog: the number of arguments on the stack is the highest slot that
+	 * the code loads. BTF describes the source. The compiler may pass something else:
+	 * a hidden pointer to the result, a pair in two registers, no dead arguments.
+	 */
+	bool stack_args_from_code: 1;
+	u8 code_stack_args:4;
 	u16 stack_arg_cnt; /* incoming + max outgoing */
 	u16 max_out_stack_arg_cnt;
 };
 
 static inline u16 bpf_in_stack_arg_cnt(const struct bpf_subprog_info *sub)
 {
+	if (sub->stack_args_from_code)
+		return sub->code_stack_args;
 	if (sub->arg_slot_cnt > MAX_BPF_FUNC_REG_ARGS)
 		return sub->arg_slot_cnt - MAX_BPF_FUNC_REG_ARGS;
 	return 0;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8bf39098ba97..228b93d4f8c9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8742,8 +8742,7 @@ static int btf_validate_return_type(struct bpf_verifier_env *env, struct btf *bt
 }
 
 static int btf_check_arg_slots(struct bpf_verifier_log *log, const char *tname,
-			       bool is_global, u32 slot_cnt,
-			       struct bpf_subprog_info *sub)
+			       bool is_global, u32 slot_cnt)
 {
 	if (slot_cnt <= MAX_BPF_FUNC_REG_ARGS)
 		return 0;
@@ -8755,12 +8754,7 @@ static int btf_check_arg_slots(struct bpf_verifier_log *log, const char *tname,
 			tname, slot_cnt, MAX_BPF_FUNC_REG_ARGS);
 		return -EINVAL;
 	}
-	if (!bpf_jit_supports_stack_args()) {
-		bpf_log(log, "JIT does not support function %s() with %d argument slots\n",
-			tname, slot_cnt);
-		return -EFAULT;
-	}
-	sub->stack_arg_cnt = slot_cnt - MAX_BPF_FUNC_REG_ARGS;
+	/* The code of a static function tells which stack arguments it takes */
 	return 0;
 }
 
@@ -8827,13 +8821,15 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	}
 	args = (const struct btf_param *)(t + 1);
 	nargs = btf_type_vlen(t);
-	sub->arg_slot_cnt = nargs;
+	sub->arg_slot_cnt = min_t(u32, nargs, MAX_BPF_FUNC_ARGS);
 	if (nargs > MAX_BPF_FUNC_ARGS) {
+		if (!is_global) /* not fatal for static funcs */
+			return -EINVAL;
 		bpf_log(log, "kernel supports at most %d parameters, function %s has %d\n",
 			MAX_BPF_FUNC_ARGS, tname, nargs);
 		return -EFAULT;
 	}
-	err = btf_check_arg_slots(log, tname, is_global, nargs, sub);
+	err = btf_check_arg_slots(log, tname, is_global, nargs);
 	if (err)
 		return err;
 
@@ -9022,7 +9018,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 		return -EINVAL;
 	}
 
-	err = btf_check_arg_slots(log, tname, is_global, slots_used, sub);
+	err = btf_check_arg_slots(log, tname, is_global, slots_used);
 	if (err)
 		return err;
 	sub->arg_slot_cnt = slots_used;
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6b719a28be68..e8442d39d8a8 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1677,7 +1677,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 	for (i = 0; i < env->subprog_cnt; i++) {
-		if (bpf_in_stack_arg_cnt(&env->subprog_info[i])) {
+		if (env->subprog_info[i].stack_arg_cnt) {
 			verbose(env, "stack args are not supported in non-JITed programs\n");
 			return -EINVAL;
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d95f86b62e99..b480c5c242af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4639,6 +4639,12 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 	struct bpf_reg_state *arg;
 	int err;
 
+	/* BTF is not needed for stack arguments, so ask here. There is no load without a store. */
+	if (!bpf_jit_supports_stack_args()) {
+		verbose(env, "JIT does not support stack arguments\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (spi >= max_stack_arg_regs) {
 		verbose(env, "stack arg write offset %d exceeds max %d stack args\n",
 			off, max_stack_arg_regs);
@@ -11336,6 +11342,8 @@ static u32 code_arg_slots(struct bpf_verifier_env *env, struct bpf_subprog_info
 {
 	u32 live_regs = env->insn_aux_data[sub->start].live_regs_before;
 
+	if (bpf_in_stack_arg_cnt(sub))
+		return MAX_BPF_FUNC_REG_ARGS + bpf_in_stack_arg_cnt(sub);
 	return fls((live_regs & GENMASK(BPF_REG_5, BPF_REG_1)) >> BPF_REG_1);
 }
 
@@ -11346,7 +11354,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
 	const struct btf_type *func, *func_proto;
 	struct bpf_call_arg_meta meta;
 	struct bpf_func_proto *fn;
-	int ret, err;
+	int ret;
 	u32 i;
 
 	memset(&meta, 0, sizeof(meta));
@@ -11355,16 +11363,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
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
 
 	func = btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id);
 	func_proto = btf_type_by_id(btf, func->type);
@@ -11375,7 +11375,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
 	meta.func_proto = func_proto;
 
 	/*
-	 * Check if all register arguments declared in BTF are initialized,
+	 * Check if all arguments declared in BTF are initialized,
 	 * and if the code takes no other arguments: a trampoline keeps only
 	 * what BTF declares. If not, the BTF is unreliable.
 	 */
@@ -11385,6 +11385,10 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
 		for (i = 0; i < min_t(u32, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS); i++)
 			if (caller->regs[BPF_REG_1 + i].type == NOT_INIT)
 				return -EINVAL;
+		/* check_func_args() reports a missing slot that the code loads: it has the name */
+		for (i = max(i, code_arg_slots(env, sub)); i < sub->arg_slot_cnt; i++)
+			if (!bpf_get_spilled_stack_arg(i - MAX_BPF_FUNC_REG_ARGS, caller))
+				return -EINVAL;
 	}
 	return check_func_args(env, &meta, env->insn_idx);
 }
@@ -11525,8 +11529,8 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 				  int *insn_idx)
 {
+	struct bpf_subprog_info *caller_info, *callee_info = &env->subprog_info[subprog];
 	struct bpf_verifier_state *state = env->cur_state;
-	struct bpf_subprog_info *caller_info;
 	u16 callee_incoming, stack_arg_cnt;
 	struct bpf_func_state *caller;
 	int err;
@@ -11537,13 +11541,24 @@ static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 	/*
 	 * Track caller's total stack arg count (incoming + max outgoing).
 	 * This is needed so the JIT knows how much stack arg space to allocate.
+	 * The callee can load less than its prototype has, and the caller can still store
+	 * all of it. Count the slots of the prototype only as far as the caller has stored
+	 * them: compilers store in front of the call. bpf_fixup_call_args() rejects the rest.
 	 */
 	caller_info = &env->subprog_info[caller->subprogno];
-	callee_incoming = bpf_in_stack_arg_cnt(&env->subprog_info[subprog]);
-	stack_arg_cnt = bpf_in_stack_arg_cnt(caller_info) + callee_incoming;
+	callee_incoming = bpf_in_stack_arg_cnt(callee_info);
+	stack_arg_cnt = bpf_in_stack_arg_cnt(caller_info) +
+			max_t(int, callee_incoming,
+			      min_t(int, caller_info->max_out_stack_arg_cnt,
+				    callee_info->arg_slot_cnt - MAX_BPF_FUNC_REG_ARGS));
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
@@ -15213,12 +15228,29 @@ static bool try_btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
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
+		}
+		sub->stack_args_from_code = true;
+		sub->code_stack_args = min(cnt, MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS);
+		/* incoming + max outgoing. Calls add the latter. */
+		sub->stack_arg_cnt = sub->code_stack_args;
+		if (env->prog->aux->func_info_aux)
+			env->prog->aux->func_info_aux[i].stack_args = sub->code_stack_args;
 	}
 }
 
@@ -22062,7 +22094,6 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog,
 			    sub->args[0].arg_type != ARG_PTR_TO_CTX) {
 				env->prog->aux->func_info_aux[0].unreliable = true;
 				sub->arg_slot_cnt = 1;
-				sub->stack_arg_cnt = 0;
 			}
 		}
 
@@ -22583,33 +22614,6 @@ static int flatten_bpf_func_model(struct bpf_verifier_log *log, const char *tnam
 	return 0;
 }
 
-/*
- * The verifier lets a static function use stack arguments counted from its
- * BTF, even if that BTF turns out unreliable. A trampoline on the function is
- * then given only MAX_BPF_FUNC_REG_ARGS u64 arguments and would lose the
- * stack arguments, so such a function cannot be attached to.
- */
-static int check_unreliable_func_args(struct bpf_verifier_log *log, struct btf *btf,
-				      const struct btf_type *func_proto, const char *tname)
-{
-	struct btf_func_model m;
-	u32 i, nslots = 0;
-
-	if (btf_distill_func_proto(NULL, btf, func_proto, tname, &m)) {
-		/* at least a slot for each argument */
-		nslots = btf_type_vlen(func_proto);
-	} else {
-		for (i = 0; i < m.nr_args; i++)
-			nslots += btf_func_model_arg_slots(&m, i);
-	}
-	if (nslots <= MAX_BPF_FUNC_REG_ARGS)
-		return 0;
-
-	bpf_log(log, "Cannot attach to static function %s: unreliable BTF and stack arguments\n",
-		tname);
-	return -EINVAL;
-}
-
 /* Functions may share a type id. The first of them is attached to. */
 static int find_tgt_subprog(const struct bpf_prog *tgt_prog, u32 btf_id)
 {
@@ -22991,10 +22995,16 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			return -EINVAL;
 
 		if (tgt_prog && conservative) {
-			if (subprog > 0) {
-				ret = check_unreliable_func_args(log, btf, t, tname);
-				if (ret)
-					return ret;
+			/*
+			 * The verifier lets a static function use the stack arguments that
+			 * its code loads, whatever its BTF says. The trampoline is given
+			 * MAX_BPF_FUNC_REG_ARGS u64 arguments and would lose them.
+			 */
+			if (tgt_prog->aux->func_info_aux[subprog].stack_args) {
+				bpf_log(log,
+					"Cannot attach to static function %s: unreliable BTF and stack arguments\n",
+					tname);
+				return -EINVAL;
 			}
 			t = NULL;
 		}
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
index 5bfcd300c7a0..cd5a77dd467b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
@@ -127,8 +127,8 @@ __naked void stack_arg_pruning_load_after_call(void)
 /*
  * "bad_ptr": the first arg is 'long *', which is not a recognized pointer
  * type for static subprogs (not ctx, dynptr, or tagged).  btf_prepare_func_args()
- * sets arg_slot_cnt = 7 / stack_arg_cnt = 2, then fails with -EINVAL.  The
- * subprog is marked unreliable but the call still proceeds for static subprogs.
+ * fails with -EINVAL.  The subprog is marked unreliable but the call still
+ * proceeds for static subprogs.  The two loads through r11 make 2 stack arguments.
  */
 __noinline __used __naked
 static void subprog_bad_ptr_7args(long *a, int b, int c, int d, int e, int f, int g)
@@ -182,7 +182,7 @@ __naked void stack_arg_read_without_write_1(void)
 SEC("tc")
 __description("stack_arg: read with not-initialized caller write")
 __failure
-__msg("invalid read from uninitialized stack arg off 8")
+__msg("callee expects 7 args, stack arg1 is not initialized")
 __btf_func_path("btf__verifier_stack_arg_order.bpf.o")
 __naked void stack_arg_read_without_write_2(void)
 {
@@ -204,7 +204,7 @@ __naked void stack_arg_read_without_write_2(void)
 SEC("tc")
 __description("stack_arg: unreliable callee with too few stack args")
 __failure
-__msg("invalid read from uninitialized stack arg off 16")
+__msg("callee expects 7 args, stack arg2 is not initialized")
 __btf_func_path("btf__verifier_stack_arg_order.bpf.o")
 __naked void stack_arg_read_with_short_bridge_write(void)
 {
-- 
2.55.0

