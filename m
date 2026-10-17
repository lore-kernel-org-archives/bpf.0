Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF683A0B38
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792261611; cv=none; b=VYO9a1NEMb/QPFtiuJNQNHeVYdhxWh1KnMnnuBBBnKe6BsWmXl8P7FZOGIqtgiEwhoR63tyHvFnNvilsfNG3s80scAgtDWhTjgtlnCiBu+aVf8FxmFXxTCNBZUOIzLhdhF7VzjBCQj9Z6QYlpKQ1E6ACYBxAOsu2gYVEEwhqe2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792261611; c=relaxed/simple;
	bh=ia/0x2l8n3vOFJ15lEzRcTMyBk7pq3CSpIfLdIN8vrQ=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=AiNyTv0Mj/THkE60sADagxJP6QAR95HpYyWK2JSfuqi9zx6FIigWtLBuMkCO4C7UNfkDW4C4nabwMvwixIQViiDmA8vW90vwY1UdNS60Es1GoIhy7F/JSYzEIaASABlpG11lSyfaC7ndbsH8d+J3Lb05NrxCKcgE/xjnHYv/s2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmjO8KLf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmjO8KLf"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ace9e6e1a5so671621a91.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792261608; x=1792866408; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSD7O15NUI+Vm5PatNNE1ezCgFEloQv/pJBZPVHY2L4=;
        b=pmjO8KLfODITTu3enqrjD/suSLOs8EYsMyoU2REWTnw/hVeQEsGL4VMV3Ub2eKTGAp
         naAL2evMXyB7zsqOR/4hrqdjGIwTQddX2q+VQOjRGuhLQW9JZgx8kfzuHZDQjxgwC7In
         XYC5UMSsw8pMEgRkft3mfbZE4mKATboGtNJcSsYINHVlFjhLtBFXWl8YFFHqZunMahHz
         tISo3rn+9K5rf+w+iWewQEux9QWgjAvj1RG+W0AVZmbwi+TnJxtWQu5s74xTzME1yA5t
         FhqIGitbzf+dz5b8odSYqEGznLbiiiy8Qj5NjmO4so5kK68IXOYfj7VQSWOZJukLqNZy
         +BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792261608; x=1792866408;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lSD7O15NUI+Vm5PatNNE1ezCgFEloQv/pJBZPVHY2L4=;
        b=VgBG5lodbAo1C1zhZwnyxxM/OcB9WmOZRAZ+fJ33zxg/DGQp2YWR9GSwjZnlVyNwtL
         6DJ7l9l2XfohR2PwR4xBNrQKlL8BuXQAKHwW8Hiv3rjgZg637/gSZfw5hzy3+F4fn3/f
         sTp5hX3LYwbbWVNVr7tqBa48+JW4XxomhjMCikEoP6ievncEzAhHFgGxPfTf7kq0m/Pj
         dJj3e1Ps0PX47UxLW/6YFsmUC6euLyzqvYoP2HXVCWotLtJVPjyQ8CLGnB/2S4d6ZwhG
         lmyM6zHIewVs8LH7AvRqhxni7HsDBS6zk5UCbpb/7uJBUY1Vu02OfjWTmfIms/Bh5uZQ
         DT0Q==
X-Forwarded-Encrypted: i=1; AKwUvBw3QgWsEz0wfhmJfH65qY8SeaGBhJ2Zv433/eFR/1Erib0uyt0MFAgxmOFA1wAfrP8XO2o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbioKLxA2KOr02s8ITV85L8QonwjDQpj/v8FghlFVh828xhmUE
	VLr/vM1IpH2jm2oF/l9gVsUWn9qCmUzfXY/XNZ+18Lq2tYxRvOoNfXCN
X-Gm-Gg: AYBFou3MSm5JexWMYoqqQlYGLZcZY1DheD0DC664OVVd6VfpaJX+GydIxulTVNIpef/
	MvnWd5mrp0+2Ure68XKkVno54s7lXQv6n/ObbnPScjYaXftW4g3UhflvIuubdgHSEIyn/POH97G
	eEvZapvU3B1IDy44mac2McbQv1QJ9djIvsyN6wFgP5ACugDOk75RaV0a010+ee6jPMT+0RwN47Q
	g2mdztr5V/RuUxRnM/p/lib41Z04hyop4EDoJlZbLdjoLxqiXCodbzFkX/s07NCSp/FYLabNVq6
	oTUUSClTWsjeSDp61nsExO7A6qJfgpAmP0a27tkU8QXsKZsr7uoFsSZ4jVqf4mkNHn8trJo5sPq
	twiLIK0T1holX/eYv4cm2vYkQLiuMcs4yfQz5/3oHjA7IDw41HkiWCuLczkdmngOlbw6wwJC8sx
	NXSdhQrj40pqN/ywKBtwuj7yLmErtJRIVB0PxkUWedlElQb2fg1F682vR+1tusRYnf3R3h8XeFa
	eMFJGkXRTsNmeHTqyqUoaD2GX1sFQUtx8xhWtdmivTIhz4vQzsWbfzoOxaktNx1CllH1FlikMr5
	l67d7FNX19LOeQ==
X-Received: by 2002:a17:90b:5146:b0:3a4:b509:88bd with SMTP id 98e67ed59e1d1-3acee275a9fmr1977681a91.2.1792261608238;
        Sat, 17 Oct 2026 11:26:48 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4991b8asm8964714a91.16.2026.10.17.11.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 11:26:47 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 18:26:46 +0000
Message-Id: <DM7BPRPOCAFO.ECFSC142CD8Y@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v12 00/25] bpf: Run exception cleanup landing
 pads when bpf_unwind() unwinds
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <DM7A976G9OGW.ZR7PNBUP083C@gmail.com>
References: <20261017025129.1914859-1-yonghong.song@linux.dev> <DM7A976G9OGW.ZR7PNBUP083C@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 05:18 PM Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> uapi in patch 1, kfuncs in patch 2 and libbpf patches 17-21 stay as-is.

On a 2nd thought...
The table exists to keep the normal path free of unwind code.
Once we pay for the branch the kernel only uses the table to generate
insns that llvm could have generated.
BPFAsmPrinter emits one record per invoke: arg setup plus one call.
So the table doesn't say more than 'this call -> that pad'.

If llvm emits:
  invoke foo              call foo; if r3 != 0 goto pad
  ret                     r3 = 0; exit
  call _Unwind_Resume     r0 = 0; r3 = 1; exit
  invoke bpf_unwind       r0 = 0; goto pad
then .bpf_cleanup, uapi, both kfuncs, libbpf, light skeleton,
static linker changes go away. Other loaders have nothing to do either.
No patching before the main pass, so insn numbers in the log don't shift.
Functions end with exit, so no need for patch 12.
_Unwind_Resume and bpf_unwind don't reach the object file,
so no rename in libbpf and no BTF anchor for them in rust.
llvm knows what is nounwind, so no conservative closure for callx.
That's close to what Eduard was proposing in v4, but without new insn.

The kernel needs to know which subprogs say something in r3.
In the sketch llvm adds BTF decl_tag "unwind" to such FUNCs.
The insns come from user space now, so the verifier checks that r3
is a scalar and that a callback exits with r3 == 0.
r3 becomes an ABI between llvm and the kernel.

The kernel part, on top of bpf-next instead of the whole series:

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54144372281c..f55a14e6c388 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1882,6 +1882,7 @@ struct bpf_prog_aux {
 	bool priv_stack_requested;
 	bool changes_pkt_data;
 	bool might_sleep;
+	bool ret_unwind;
 	bool kprobe_write_ctx;
 	struct {
 		s32 keyring_serial;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 11cd90d85bad..6501c873f365 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -944,6 +944,7 @@ struct bpf_subprog_info {
 	s16 fastcall_stack_off;
 	bool has_tail_call: 1;
 	bool might_throw: 1;
+	bool ret_unwind: 1; /* says in r3 whether it returns or unwinds */
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
 	bool is_cb: 1;
@@ -1214,6 +1215,8 @@ static inline struct bpf_subprog_info *subprog_info(struct bpf_verifier_env *env
 	return &env->subprog_info[subprog];
 }
 
+#define BPF_REG_UNWIND BPF_REG_3
+
 static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
 {
 	return subprog_info(env, subprog)->ret_reg_pair;
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 43d5740034c0..0f8dbacdf9ca 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -448,6 +448,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				bt_clear_reg(bt, BPF_REG_0);
 				/* and if it does not set R2, main pass would catch it */
 				bt_clear_reg(bt, BPF_REG_2);
+				bt_clear_reg(bt, BPF_REG_UNWIND);
 				/* r1-r5 are invalidated after subprog call,
 				 * so for global func call it shouldn't be set
 				 * anymore
@@ -548,7 +549,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 					return -EFAULT;
 			}
 		} else if (opcode == BPF_EXIT) {
-			bool from_subprog_call, r0_precise, r2_precise;
+			bool from_subprog_call, r0_precise, r2_precise, r3_precise;
 
 			/* BPF_EXIT in subprog or callback always returns
 			 * right after the call instruction, so by checking
@@ -565,6 +566,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 
 			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
 			r2_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);
+			r3_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_UNWIND);
 
 			/* Backtracking to a nested function call, 'idx' is a part of
 			 * the inner frame 'subseq_idx' is a part of the outer frame.
@@ -578,8 +580,10 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 * might be a precise helper argument as well, so leave it set.
 			 */
 			bt_clear_reg(bt, BPF_REG_0);
-			if (from_subprog_call)
+			if (from_subprog_call) {
 				bt_clear_reg(bt, BPF_REG_2);
+				bt_clear_reg(bt, BPF_REG_UNWIND);
+			}
 			if (from_subprog_call && (bt_reg_mask(bt) & BPF_REGMASK_ARGS)) {
 				verifier_bug(env, "backtracking exit unexpected regs %x",
 					     bt_reg_mask(bt));
@@ -593,6 +597,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 				bt_set_reg(bt, BPF_REG_0);
 			if (r2_precise)
 				bt_set_reg(bt, BPF_REG_2);
+			if (r3_precise)
+				bt_set_reg(bt, BPF_REG_UNWIND);
 			/* r6-r9 and stack slots will stay set in caller frame
 			 * bitmasks until we return back from callee(s)
 			 */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 608621d7f225..8580fa2b634f 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1383,6 +1383,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->exception_cb = env->subprog_info[i].is_exception_cb;
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
+		func[i]->aux->ret_unwind = env->subprog_info[i].ret_unwind;
 		func[i]->aux->token = prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e657e6d95408..51ccb8b080a9 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2482,7 +2482,7 @@ static int callee_subprog(struct bpf_verifier_env *env, const struct bpf_insn *i
 static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
 				   struct insn_live_regs *info,
-				   bool ret_reg_pair)
+				   bool ret_reg_pair, bool ret_unwind)
 {
 	struct bpf_call_summary cs;
 	const u8 class = BPF_CLASS(insn->code);
@@ -2616,6 +2616,8 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 		case BPF_EXIT:
 			def = 0;
 			use = ret_reg_pair ? (r0 | r2) : r0;
+			if (ret_unwind)
+				use |= reg64_mask(BPF_REG_UNWIND);
 			break;
 		case BPF_CALL:
 			def = ALL_CALLER_SAVED_REGS;
@@ -2698,7 +2700,8 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 		ret_reg_pair = bpf_ret_reg_pair(env, subprog);
 
 		for (i = start; i < end; ++i)
-			compute_insn_live_regs(env, &insns[i], &state[i], ret_reg_pair);
+			compute_insn_live_regs(env, &insns[i], &state[i], ret_reg_pair,
+					       subprog && env->subprog_info[subprog].ret_unwind);
 	}
 
 	/* Forward pass: resolve stack access through FP-derived pointers */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1facec5485b3..888dabd81d15 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -440,7 +440,7 @@ static const int ret_regs[] = { BPF_REG_0, BPF_REG_2 };
 static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
 {
 	const struct btf *btf = env->prog->aux->btf;
-	const struct btf_type *type;
+	const struct btf_type *type, *func;
 	int subprog;
 	u32 size;
 
@@ -454,8 +454,22 @@ static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
 	 * refuses to replace a function returning more than 8 bytes.
 	 */
 	for (subprog = 1; subprog < env->subprog_cnt; subprog++) {
+		struct bpf_subprog_info *sub = subprog_info(env, subprog);
+
 		type = subprog_ret_type(env, subprog);
-		if (!type || btf_type_is_void(type))
+		if (!type)
+			continue;
+		func = btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id);
+		if (btf_find_next_decl_tag(btf, func, -1, "unwind", 0) > 0) {
+			/* They return to the caller with whatever is in r3. */
+			if (sub->has_tail_call || sub->has_ld_abs) {
+				verbose(env, "tail call or ld_abs in a subprog that can unwind\n");
+				return -EINVAL;
+			}
+			sub->ret_unwind = true;
+			env->prog->jit_required = 1;
+		}
+		if (btf_type_is_void(type))
 			continue;
 		if (verifier_bug_if(IS_ERR(btf_resolve_size(btf, type, &size)), env,
 				    "cannot size return type of subprog %d", subprog))
@@ -11386,6 +11400,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			}
 		}
 
+		if (env->subprog_info[subprog].ret_unwind)
+			mark_reg_unknown(env, caller->regs, BPF_REG_UNWIND);
+
 		if (env->subprog_info[subprog].might_throw) {
 			struct bpf_verifier_state *branch;
 
@@ -11823,13 +11840,14 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	struct bpf_verifier_state *state = env->cur_state, *prev_st;
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
-	bool in_callback_fn;
+	bool in_callback_fn, ret_unwind;
 	u32 i, nregs;
 	int err;
 
 	callee = state->frame[state->curframe];
 	r0 = &callee->regs[BPF_REG_0];
 	nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
+	ret_unwind = subprog_info(env, callee->subprogno)->ret_unwind;
 	for (i = 0; i < nregs; i++) {
 		if (callee->regs[ret_regs[i]].type != PTR_TO_STACK)
 			continue;
@@ -11861,6 +11879,16 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 					       "At callback return", "R0");
 			return -EINVAL;
 		}
+		/* the helper that called it does not look at r3 */
+		if (ret_unwind) {
+			err = mark_chain_precision(env, BPF_REG_UNWIND);
+			if (err)
+				return err;
+			if (!bpf_register_is_null(&callee->regs[BPF_REG_UNWIND])) {
+				verbose(env, "callback cannot unwind\n");
+				return -EINVAL;
+			}
+		}
 		if (!bpf_calls_callback(env, callee->callsite)) {
 			verifier_bug(env, "in callback at %d, callsite %d !calls_callback",
 				     *insn_idx, callee->callsite);
@@ -11879,6 +11907,8 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 			caller->regs[regno] = callee->regs[regno];
 			bpf_diag_mod_end(env);
 		}
+		if (ret_unwind && callee->regs[BPF_REG_UNWIND].type == SCALAR_VALUE)
+			caller->regs[BPF_REG_UNWIND] = callee->regs[BPF_REG_UNWIND];
 	}
 
 	/* Invalidate callee-local dynptrs and their slices before the frame goes away. */
@@ -19222,6 +19252,12 @@ static int check_global_subprog_return_code(struct bpf_verifier_env *env)
 	u32 i, nregs;
 	int err;
 
+	if (subprog_info(env, subprog)->ret_unwind) {
+		err = check_global_ret_scalar_reg(env, BPF_REG_UNWIND);
+		if (err)
+			return err;
+	}
+
 	if (subprog_returns_void(env, subprog))
 		return 0;
 
@@ -22135,6 +22171,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 				prog_extension ? "Extension" : "Tracing");
 			return -EINVAL;
 		}
+		/* Neither a trampoline that calls the subprog nor an extension keeps r3. */
+		if (aux->func && subprog && aux->func[subprog]->aux->ret_unwind &&
+		    prog->expected_attach_type != BPF_TRACE_FENTRY) {
+			bpf_log(log, "Only fentry can attach to %s, which can unwind\n", tname);
+			return -EINVAL;
+		}
 		conservative = aux->func_info_aux[subprog].unreliable;
 		if (prog_extension) {
 			if (conservative) {

The llvm part:

diff -ruN a/llvm/lib/Target/BPF/BPF.h b/llvm/lib/Target/BPF/BPF.h
--- a/llvm/lib/Target/BPF/BPF.h	2026-09-16 22:24:30.000000000 +0000
+++ b/llvm/lib/Target/BPF/BPF.h	2026-10-17 18:08:10.169807195 +0000
@@ -35,6 +35,8 @@
 };
 
 ModulePass *createBPFCheckAndAdjustIRLegacyPass();
+ModulePass *createBPFUnwindPreparePass();
+FunctionPass *createBPFUnwindLowerPass();
 
 class BPFISelDAGToDAGPass : public SelectionDAGISelPass {
 public:
diff -ruN a/llvm/lib/Target/BPF/BPFISelLowering.cpp b/llvm/lib/Target/BPF/BPFISelLowering.cpp
--- a/llvm/lib/Target/BPF/BPFISelLowering.cpp	2026-09-16 22:24:30.000000000 +0000
+++ b/llvm/lib/Target/BPF/BPFISelLowering.cpp	2026-10-17 18:08:10.169807195 +0000
@@ -696,6 +696,14 @@
     RetOps.push_back(DAG.getRegister(VA.getLocReg(), VA.getLocVT()));
   }
 
+  // A function that can unwind says in r3 that it did not.
+  if (!MF.getFunction().doesNotThrow()) {
+    Chain = DAG.getCopyToReg(Chain, DL, BPF::R3,
+                             DAG.getConstant(0, DL, MVT::i64), Glue);
+    Glue = Chain.getValue(1);
+    RetOps.push_back(DAG.getRegister(BPF::R3, MVT::i64));
+  }
+
   RetOps[0] = Chain; // Update chain.
 
   // Add the glue if we have it.
diff -ruN a/llvm/lib/Target/BPF/BPFTargetMachine.cpp b/llvm/lib/Target/BPF/BPFTargetMachine.cpp
--- a/llvm/lib/Target/BPF/BPFTargetMachine.cpp	2026-09-16 22:24:30.000000000 +0000
+++ b/llvm/lib/Target/BPF/BPFTargetMachine.cpp	2026-10-17 18:08:10.169807195 +0000
@@ -117,6 +117,7 @@
   addPass(createBPFCheckAndAdjustIRLegacyPass());
 
   TargetPassConfig::addIRPasses();
+  addPass(createBPFUnwindPreparePass());
 }
 
 TargetTransformInfo
@@ -147,6 +148,7 @@
 }
 
 void BPFPassConfig::addPreEmitPass() {
+  addPass(createBPFUnwindLowerPass());
   addPass(createBPFMIPreEmitCheckingLegacyPass());
   if (!DisableMIPeephole) {
     addPass(createBPFMIExpandStackArgPseudosLegacyPass());
diff -ruN a/llvm/lib/Target/BPF/BPFUnwind.cpp b/llvm/lib/Target/BPF/BPFUnwind.cpp
--- a/llvm/lib/Target/BPF/BPFUnwind.cpp	1970-01-01 00:00:00.000000000 +0000
+++ b/llvm/lib/Target/BPF/BPFUnwind.cpp	2026-10-17 18:08:49.629960874 +0000
@@ -0,0 +1,206 @@
+//===-- BPFUnwind.cpp - Lower unwinding to a flag in r3 and a branch ------===//
+//
+// A function that can unwind says in r3 how it returns:
+//   ret                     r3 = 0; exit            (BPFTargetLowering::LowerReturn)
+//   resume                  r0 = 0; r3 = 1; exit
+//   invoke f() unwind pad   call f; if r3 != 0 goto pad
+//   invoke bpf_unwind()     r0 = 0; goto pad
+// There are no tables and nothing for a loader or the kernel to dispatch.
+//
+//===----------------------------------------------------------------------===//
+
+#include "BPF.h"
+#include "BPFInstrInfo.h"
+#include "BPFSubtarget.h"
+#include "llvm/CodeGen/MachineFunctionPass.h"
+#include "llvm/CodeGen/MachineInstrBuilder.h"
+#include "llvm/IR/IRBuilder.h"
+#include "llvm/IR/InstIterator.h"
+#include "llvm/IR/IntrinsicInst.h"
+#include "llvm/IR/Module.h"
+#include "llvm/Transforms/Utils/Local.h"
+
+using namespace llvm;
+
+namespace {
+
+/// Make every call that may unwind an invoke: it ends its block and has a pad.
+struct BPFUnwindPrepare : public ModulePass {
+  static char ID;
+  BPFUnwindPrepare() : ModulePass(ID) {}
+  StringRef getPassName() const override { return "BPF Unwind Prepare"; }
+
+  static bool mayUnwind(const Instruction &I) {
+    const auto *CB = dyn_cast<CallBase>(&I);
+    return CB && !CB->doesNotThrow() && !CB->isInlineAsm() &&
+           !isa<IntrinsicInst>(CB);
+  }
+
+  bool runOnModule(Module &M) override {
+    bool Changed = false, IndirectUnwind = false;
+
+    for (Function &F : M)
+      for (Instruction &I : instructions(F))
+        IndirectUnwind |= mayUnwind(I) && cast<CallBase>(I).isIndirectCall();
+
+    for (Function &F : M) {
+      if (F.isDeclaration())
+        continue;
+      // The caller of a function pointer looks at r3 whatever the callee is.
+      if (IndirectUnwind && F.doesNotThrow() && F.hasAddressTaken()) {
+        F.removeFnAttr(Attribute::NoUnwind);
+        Changed = true;
+      }
+      if (F.doesNotThrow())
+        continue;
+
+      SmallVector<CallInst *, 8> Calls;
+      for (Instruction &I : instructions(F))
+        if (isa<CallInst>(I) && mayUnwind(I))
+          Calls.push_back(cast<CallInst>(&I));
+      if (Calls.empty())
+        continue;
+
+      LLVMContext &C = M.getContext();
+      if (!F.hasPersonalityFn())
+        F.setPersonalityFn(cast<Constant>(
+            M.getOrInsertFunction("__gcc_personality_v0",
+                                  FunctionType::get(Type::getInt32Ty(C), true))
+                .getCallee()));
+      BasicBlock *Pad = BasicBlock::Create(C, "unwind.resume", &F);
+      IRBuilder<> B(Pad);
+      LandingPadInst *LP = B.CreateLandingPad(
+          StructType::get(PointerType::getUnqual(C), Type::getInt32Ty(C)), 0);
+      LP->setCleanup(true);
+      B.CreateResume(LP);
+      for (CallInst *CI : Calls)
+        changeToInvokeAndSplitBasicBlock(CI, Pad);
+      Changed = true;
+    }
+    return Changed;
+  }
+};
+
+/// After register allocation, which took call -> pad for an EH edge and so
+/// keeps only r6-r9 and the stack alive over it, turn the edge into a branch.
+struct BPFUnwindLower : public MachineFunctionPass {
+  static char ID;
+  BPFUnwindLower() : MachineFunctionPass(ID) {}
+  StringRef getPassName() const override { return "BPF Unwind Lower"; }
+
+  static bool callsTo(const MachineInstr &MI, StringRef Name) {
+    const MachineOperand &MO = MI.getOperand(0);
+    return (MO.isGlobal() && MO.getGlobal()->getName() == Name) ||
+           (MO.isSymbol() && Name == MO.getSymbolName());
+  }
+
+  /// Nothing after \p MI in its block runs: \p Succ, if any, is what follows.
+  static void endBlockAfter(MachineInstr &MI, MachineBasicBlock *Succ) {
+    MachineBasicBlock &MBB = *MI.getParent();
+    MBB.erase(std::next(MI.getIterator()), MBB.end());
+    while (!MBB.succ_empty())
+      MBB.removeSuccessor(MBB.succ_begin());
+    if (Succ)
+      MBB.addSuccessor(Succ);
+  }
+
+  bool runOnMachineFunction(MachineFunction &MF) override {
+    const TargetInstrInfo &TII = *MF.getSubtarget().getInstrInfo();
+    DenseMap<MCSymbol *, MachineBasicBlock *> Begin;
+    SmallVector<std::pair<MachineInstr *, MachineBasicBlock *>, 8> Sites;
+    SmallVector<MachineInstr *, 8> Labels, Resumes;
+
+    for (const LandingPadInfo &LP : MF.getLandingPads())
+      for (MCSymbol *Sym : LP.BeginLabels)
+        Begin[Sym] = LP.LandingPadBlock;
+
+    for (MachineBasicBlock &MBB : MF) {
+      MachineBasicBlock *Pad = nullptr;
+      for (MachineInstr &MI : MBB) {
+        if (MI.isEHLabel()) {
+          Pad = Begin.lookup(MI.getOperand(0).getMCSymbol());
+          Labels.push_back(&MI);
+        } else if (MI.isCall() && callsTo(MI, "_Unwind_Resume")) {
+          Resumes.push_back(&MI);
+        } else if (MI.isCall() && Pad) {
+          Sites.push_back({&MI, Pad});
+        }
+      }
+    }
+    if (Labels.empty() && Resumes.empty())
+      return false;
+    for (MachineInstr *MI : Labels)
+      MI->eraseFromParent();
+
+    for (auto [Call, Pad] : Sites) {
+      MachineBasicBlock *MBB = Call->getParent();
+      const DebugLoc &DL = Call->getDebugLoc();
+      const auto *II =
+          dyn_cast_or_null<InvokeInst>(MBB->getBasicBlock()->getTerminator());
+
+      // The pad reads r0, which the callee zeroes when it unwinds.
+      Call->addRegisterDefined(BPF::R0);
+      Call->clearRegisterDeads(BPF::R0);
+
+      if (callsTo(*Call, "bpf_unwind") || (II && II->doesNotReturn())) {
+        if (callsTo(*Call, "bpf_unwind"))
+          Call = BuildMI(*MBB, Call, DL, TII.get(BPF::MOV_ri), BPF::R0).addImm(0);
+        endBlockAfter(*Call, Pad);
+        if (!MBB->isLayoutSuccessor(Pad))
+          BuildMI(MBB, DL, TII.get(BPF::JMP)).addMBB(Pad);
+      } else {
+        MachineBasicBlock *Rest = MBB->splitAt(*Call);
+        if (Rest != MBB) {
+          Rest->removeSuccessor(Pad);
+          MBB->addSuccessor(Pad);
+        }
+        Call->addRegisterDefined(BPF::R3);
+        Call->clearRegisterDeads(BPF::R3);
+        BuildMI(MBB, DL, TII.get(BPF::JNE_ri))
+            .addReg(BPF::R3)
+            .addImm(0)
+            .addMBB(Pad);
+      }
+    }
+
+    for (MachineInstr *Call : Resumes) {
+      MachineBasicBlock *MBB = Call->getParent();
+      const DebugLoc &DL = Call->getDebugLoc();
+
+      BuildMI(*MBB, Call, DL, TII.get(BPF::MOV_ri), BPF::R0).addImm(0);
+      BuildMI(*MBB, Call, DL, TII.get(BPF::MOV_ri), BPF::R3).addImm(1);
+      MachineInstr *Ret = BuildMI(*MBB, Call, DL, TII.get(BPF::RET))
+                              .addReg(BPF::R0, RegState::Implicit)
+                              .addReg(BPF::R3, RegState::Implicit);
+      endBlockAfter(*Ret, nullptr);
+    }
+
+    // The pads are plain blocks now and there is no table to emit.
+    for (MachineBasicBlock &MBB : MF)
+      MBB.setIsEHPad(false);
+    // FIXME: prototype. MachineFunction has no way to drop them.
+    const_cast<std::vector<LandingPadInfo> &>(MF.getLandingPads()).clear();
+
+    // What was behind a call that does not return.
+    for (bool Again = true; Again;) {
+      Again = false;
+      for (MachineBasicBlock &MBB : make_early_inc_range(MF)) {
+        if (&MBB == &MF.front() || !MBB.pred_empty() || MBB.hasAddressTaken())
+          continue;
+        while (!MBB.succ_empty())
+          MBB.removeSuccessor(MBB.succ_begin());
+        MBB.eraseFromParent();
+        Again = true;
+      }
+    }
+    return true;
+  }
+};
+
+} // namespace
+
+char BPFUnwindPrepare::ID = 0;
+char BPFUnwindLower::ID = 0;
+
+ModulePass *llvm::createBPFUnwindPreparePass() { return new BPFUnwindPrepare(); }
+FunctionPass *llvm::createBPFUnwindLowerPass() { return new BPFUnwindLower(); }
diff -ruN a/llvm/lib/Target/BPF/BTFDebug.cpp b/llvm/lib/Target/BPF/BTFDebug.cpp
--- a/llvm/lib/Target/BPF/BTFDebug.cpp	2026-09-16 22:24:30.000000000 +0000
+++ b/llvm/lib/Target/BPF/BTFDebug.cpp	2026-10-17 18:08:10.169807195 +0000
@@ -1645,6 +1645,10 @@
     FuncTypeId = processDISubprogram(SP, ProtoTypeId, Scope);
   }
 
+  // Tell the kernel which functions say in r3 how they return.
+  if (!MF->getFunction().doesNotThrow())
+    addType(std::make_unique<BTFTypeDeclTag>(FuncTypeId, -1, "unwind"));
+
   for (const auto &TypeEntry : TypeEntries)
     TypeEntry->completeType(*this);
 
diff -ruN a/llvm/lib/Target/BPF/CMakeLists.txt b/llvm/lib/Target/BPF/CMakeLists.txt
--- a/llvm/lib/Target/BPF/CMakeLists.txt	2026-09-16 22:24:30.000000000 +0000
+++ b/llvm/lib/Target/BPF/CMakeLists.txt	2026-10-17 18:08:10.169807195 +0000
@@ -41,6 +41,7 @@
   BPFSubtarget.cpp
   BPFTargetLoweringObjectFile.cpp
   BPFTargetMachine.cpp
+  BPFUnwind.cpp
   BPFMIPeephole.cpp
   BPFMIChecking.cpp
   BPFMISimplifyPatchable.cpp

Tested on x86 only, in qemu, with unmodified libbpf.
C with __attribute__((cleanup)) and C++ with try/catch built with -fexceptions:
guards in three frames, global subprog, callx via a table in rodata,
16 byte return, catch, bpf_loop() callback load and run.
A lock without a guard and a callback that unwinds are rejected.
rustc output with panic=unwind (drop, move, a[i], dyn Trait) compiles
to the expected asm.
test_progs and llvm tests were not run.

I'm not sure that decl_tag is the best way to tell the kernel.

Thoughts?

Eduard,
pls chime in as well.
