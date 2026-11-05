Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911611;
	b=c+ax1vuK/Uc/BLfKtatJ7kvRLTkE+vh4UzdhzD/B62zyHpbiiwgJFM/wHXTW/uMSSIpd
	 OJLPKYvDkLIx7IyK33n/KiXt/QsrE0l9LrBtOtbTbHHsDQODSNeX02jpjKPH22Oa++2C/
	 wBanuB+vd1vqAgoDz3QvGfRdT63+xUQo6cUHv7WtDHyCX8+ClaJy85/FONcd85sKJHmaF
	 HENipT5W7SVzW1i2wY5+zQtscYHHUw9apNvtp5vKwo2O6g8R/Gf3VSctKocIsbhyuh6Ah
	 DeCfuqEK37CBE7ZJNFcE4befGh9Et2HYb/N9+0Wa3qx4Ax4ulkIqmAYt+5VZKiHL/sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V/8f8N3KNhaaC8tIZo88ohe2pmRX1JlJZhTGbFqZRJg=;
	b=tVcBzBVUfVdykZcW+D40ucbILfl/fnhLM7UMYLrmIingbfvoUgZ6b+9vPz8QSuwiw+kr
	 huYphhGycLr/IfzzYYz0nclc9VQvhFye+b4CYxwpBF/WoeCBCDqKIi2zpgvfkJUnkP9p6
	 7jcrWwhCL981e7jXlrE7hqVvARYFwuLNK7rO655Sfp99eLsz2E4Z0Kldnbr1jacFS5ond
	 b/tvFImNlnhvhfWCxLDmi0+8AJoDBuXRpjN+uqsXC83ZeHKFlW1PQUX6bvWBcNGEW9DYy
	 X5uZdZcDFlUNQcbhS+ysA+ROhbiEzOlo7hHtK/5/b+Dn1pPpeziCGvHn16iJU8sXp8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="0faeW/I3";
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F2606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A0F2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0faeW/I3
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so1762944b3a.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911611; x=1794516411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/8f8N3KNhaaC8tIZo88ohe2pmRX1JlJZhTGbFqZRJg=;
        b=0faeW/I3xlUVXrSS8j/FpreoHwTgopi8UcGU6fVnwhlbrJQWgovo7I5rIsECg8e8hb
         wcNOEP95ApWiCTrzdCbQrIwy1WJle1vcrkKztgFDQgLPUZ5vO0JOxRUK1OGGLP2bRYXM
         dSJJDLNUU1pB6sBMTIudpwplEDbwbng/DVMUijZjhU1nJizOsuIPN8M33oJOO1ZqFo41
         C9yyY+Nbopiqby89hWsrYHlZhUMXDxsUFpLwiAJ+lCKfQGp8vjt5qodsYK6WF15NmEay
         OReS/QnKZsiruNZCW4K7hms0Gb81fN+5m8pPl3/5zNP5EhHP6BErnYg1hLwUIE3ETDRO
         Aq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911611; x=1794516411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V/8f8N3KNhaaC8tIZo88ohe2pmRX1JlJZhTGbFqZRJg=;
        b=BW5gDLeFVtPxhmgyWO7UFOs4yOwbGHHbl/oyYzVoSFYw6X3k5uQRXa9yvDfXfmGH6d
         PNJ7qOdJx6etsZqee63LTzrXuKcYETx6sMDc90GpOznOUTDTaIrCIyqRRZj/vDMeCWcs
         QOuCXmmf/YDGE5ydjrIPqQvMN87MdJ2Gs2Yhf2ZtBMUUspQVfMssA47GTa9a5Kyk+ONr
         joSsf6WlObQWafunH3ge6/GQyTBz2xvzennqgLq7iMH4kR2x4C2RMc1Imj+2cYzIgCY8
         +LcwYuWTYfu0OXCwqTpm6TFq0Ve+1xcrg1fBfwc6g28tJc7jyHItjZr65DBvFGxF9WYO
         FTDg==
X-Gm-Message-State: APuU4Z+1ETCvXlNf3OY3IRgTJNJZeHDRiJ5bnDJqc+YJmSlYXGViyMyt
	jfBdLbF4z+qVHAEYIOeulpsMRPVUuB2Ce6+rxjND48cVdO4Cdm/NLkFzYDT68w==
X-Gm-Gg: AYBFou1+S9iORg9f5uhSETgkP1cuUHh7yKY7J9fh6IHkQNKKnugUFcA/8R/2xg8AwIX
	rKNVFm9LiXlJq2i8hepsd0Y9m4oXDSjmRmtl7RZ/zHuaM6UdjW3ZD+3Z5F+1T9f4pEr8FjagBSp
	qm9hGJ11JS9M9FNPrrEiqQFO5QhEVtaSIig9pLG/Ns0ZRtAApnDAjPae1Xeluk4AIYT0k/o6Iy0
	SEn7MFkdKnCtVShvv/vbmq/SWLU/tQjvc2V0ps8Wwtf4HGR3HMu87M01Fy+5tsSaE0wqNgmVo/t
	m1UsKLHZTsRlHtT8RZy9fAVAGSq/dcNuQnNuWnX95D+nSlptT28udHNA7LD3Vp1xgtzxvzbmOxB
	p5b7AS5UkANFMR5Qiu8QIPUbLkxtiGCKMq/7DigXBWE/llazqnxHizvXjOOni4uPLU97TZL66lG
	dTQp23MJeyoRMOk+JmG5s1yHx0h3w/4H0NMIuhhJsWyW/XAEFeXHF7qk+n8cdjf1HzeF8tZuRJV
	G6Bq57+REtXaFKCltz0v8doKi+wnNPInSvBXbyCuKcgm+ao8AZfmvtsqN0xS5Ks3bSPQhNxO41Q
	+imFRoLUodOmah8ceKyawZXQYFcmrp88ce6KpHZZpZAdsyMXR7WWlVJ0mWo09FzTe82u8xJbe8b
	HAv6LAXZh8thv2Po/JrW/Fy3Czruzb8MkZC86Hky78TUlHy1eKS4yT+qmOJtCZhVpa1oiRgwVlg
	==
X-Received: by 2002:a05:6a00:2388:b0:882:fafe:9874 with SMTP id d2e1a72fcca58-8b37b578168mr174555b3a.31.1793911610373;
        Thu, 05 Nov 2026 12:46:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597f0539sm78497b3a.31.2026.11.05.12.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:46:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 16/35] bpf: Make the state after a call from the caller's state and an exit state
Date: Thu,  5 Nov 2026 20:44:53 +0000
Message-ID: <20261105204513.2230344-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
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

match_one() of scx_layered runs in three nested bpf_for() loops and calls
a static subprog, get_pid_nr_ns():

  scoped_guard(rcu) { ... nspid = get_pid_nr_ns(p_pid, pid_ns);

It is verified for the states at its first insn, not for each chain of
calls. One exit state is the result for all calls that wait:

  2: call f  --- { r1=scalar } --->  +---------------------+
  7: call f  --- { r1=scalar } --->  | f: verified 1 time  |
  3: ...     <-- { r0=[0,7] } -----  |                     |
  8: ...     <-- { r0=[0,7] } -----  +---------------------+

That works only if calls that differ in ids give the same entry state. Here
the callers hold three iterators, and each bpf_iter_num_new() has a new id.
What is held is a part of the entry state: it decides what the subprog may
do. In the subprog the id of refs[i] of the caller becomes a name,
BPF_INHERITED_ID + i. A name stands for one object of the caller. Thus
check_ids() and the join do not rename it: it is equal only to itself.

If a call with something held keeps the frames of the callers instead,
layered_runnable takes 5219 insns, not 4459, and recursion has no end.
core::fmt of Rust is recursive, and progs format a message while they hold
a reference. 27 progs of the schedulers of rust-bpf fail:
"the call stack of 33 frames is too deep".

bpf_flow_return() makes the state after the call:
 - r0, and r2 of a pair, come from the exit state. r1-r5 and the outgoing
   stack arguments are not set.
 - What is held is what the caller held and what the subprog took. The
   names become the ids of the caller again.
 - All other ids get new values for each call. If not, two calls in
   sequence return the same object.

Selftest test_spin_lock, lock_static_subprog_unlock():

  bpf_spin_lock(&lockA);
  ret = static_subprog_unlock(ctx);

An exit state does not tell what a release does to the caller. Thus the
frame counts what it holds without interruption since its entry. If that is
less than the caller held, the function returns 1, and the call is verified
again with the frames of the caller. Also: rcu_read_lock, preempt_lock. The
same if it changed the packet through a function that is its argument.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  18 +++++
 kernel/bpf/join.c            |   3 +
 kernel/bpf/states.c          |   4 +
 kernel/bpf/verifier.c        | 138 +++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 53507aed9f20..1963a079589d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1092,6 +1092,8 @@ struct bpf_subprog_info {
 	 * a hidden pointer to the result, a pair in two registers, no dead arguments.
 	 */
 	bool stack_args_from_code: 1;
+	/* it releases what its caller holds, so it's verified in the context of such caller */
+	bool releases_inherited: 1;
 	/* it can leave with unwind_exit: it has one, or unwind_goto follows every call of it */
 	bool bail_unwinds: 1;
 	u8 code_stack_args;
@@ -1124,6 +1126,20 @@ struct bpf_id_pair {
 	u32 cur;
 };
 
+/*
+ * A function that is verified on its own, see func_is_on_its_own(), has no ids of its caller.
+ * It has names for the ids of what is held: BPF_INHERITED_ID + i is the id of refs[i] at the call.
+ * - A name depends only on the place. Each id in the state at the entry is replaced with its name.
+ *   The ids of the caller can be names that it got from its own caller: they are replaced too.
+ * - A name stands for the same thing in all states of the function. It is equal only to itself:
+ *   check_ids() and jid_note() do not rename it. So two calls share a state at the entry, and what
+ *   comes out for it, only if the same places have the same names.
+ * - bpf_flow_return() puts the ids of the call that waits back. All other ids get new values.
+ * - env->id_gen stays below BPF_MAX_ID. So no id is a name or has a bit of BPF_ADD_CONST.
+ */
+#define BPF_INHERITED_ID	0x20000000
+#define BPF_MAX_ID		(BPF_INHERITED_ID / 2)
+
 struct bpf_idmap {
 	u32 tmp_id_gen;
 	u32 cnt;
@@ -1605,6 +1621,8 @@ int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst
 		    bool widen);
 void bpf_join_free(struct bpf_verifier_env *env);
 
+int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
+		    const struct bpf_verifier_state *exit, int call_idx);
 int bpf_insert_loop_guards(struct bpf_verifier_env *env);
 u16 bpf_call_const_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn);
 u16 bpf_call_checked_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn);
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 4da051767e1d..0110e5f85003 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -84,6 +84,9 @@ static void jid_note(struct bpf_join_state *js, u32 ida, u32 idb, bool consisten
 
 	if (!a || !b)
 		return;
+	/* a name of what the caller has, see BPF_INHERITED_ID */
+	if (a != b && (a | b) >= BPF_INHERITED_ID)
+		consistent = false;
 	for (i = 0; i < js->npairs; i++) {
 		p = &js->pairs[i];
 		if (p->a == a && p->b == b) {
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 4136a708a78e..9d3a86b5820e 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -350,6 +350,10 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 	if (old_id == 0) /* cur_id == 0 as well */
 		return true;
 
+	/* a name of what the caller has, see BPF_INHERITED_ID */
+	if (((old_id | cur_id) & ~BPF_ADD_CONST) >= BPF_INHERITED_ID)
+		return old_id == cur_id;
+
 	for (i = 0; i < idmap->cnt; i++) {
 		if (map[i].old == old_id)
 			return map[i].cur == cur_id;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 747c739ad9f2..03940b2fc516 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11702,8 +11702,146 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	return 0;
 }
 
+
 static int process_bpf_exit_full(struct bpf_verifier_env *env,
 				 bool *do_print_state, bool exception_exit);
+static void account_current_path(struct bpf_verifier_env *env);
+
+/*
+ * The function can be verified on its own, for the state at its entry, when
+ * what it does depends on its arguments only and it cannot get to what its
+ * callers have: nothing points to their stack.
+ *
+ * What the callers hold, references, locks and so on, is a part of that state:
+ * it matters for what the function may do. Calls that differ in ids only
+ * have to get to the same state, so the ids of what is held are replaced with
+ * BPF_INHERITED_ID + the position for the function, and put back at the return.
+ */
+
+static u32 fresh_id(struct bpf_verifier_env *env, struct bpf_idmap *idmap, u32 id)
+{
+	u32 flags = id & BPF_ADD_CONST, i;
+
+	id &= ~BPF_ADD_CONST;
+	if (!id)
+		return 0;
+	for (i = 0; i < idmap->cnt; i++)
+		if (idmap->map[i].old == id)
+			return idmap->map[i].cur | flags;
+	if (idmap->cnt == BPF_ID_MAP_SIZE)
+		return 0;
+	idmap->map[idmap->cnt].old = id;
+	idmap->map[idmap->cnt].cur = ++env->id_gen;
+	return idmap->map[idmap->cnt++].cur | flags;
+}
+
+/*
+ * @caller waits at the call at @call_idx and @exit is what came out of the
+ * function. Make @caller what it is after the call.
+ * Returns 1 if the call has to be verified in the context of the caller.
+ */
+int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *caller,
+		    const struct bpf_verifier_state *exit, int call_idx)
+{
+	struct bpf_func_state *frame = caller->frame[caller->curframe];
+	const struct bpf_func_state *callee = exit->frame[0];
+	struct bpf_idmap *idmap = &env->idmap_scratch;
+	u32 caller_rcu = caller->active_rcu_locks, caller_preempt = caller->active_preempt_locks;
+	struct bpf_reference_state *held;
+	struct bpf_reg_state *reg;
+	u32 i, j, nregs, nheld, kept = 0, id;
+	int err;
+
+	if (exit->unwound && !bpf_is_unwind_goto(&env->prog->insnsi[call_idx + 1])) {
+		verbose(env, "unwind_exit, but no unwind_goto after the call at insn %d\n",
+			call_idx);
+		return -EINVAL;
+	}
+	caller->unwound = exit->unwound;
+
+	/*
+	 * bpf_check_cfg() takes the subprog that loads the address of a function for the
+	 * one that calls it. This one got the address from its caller. What it means for
+	 * the packet pointers of the caller is found out in the context of the caller.
+	 */
+	if (exit->changed_pkt_data) {
+		env->subprog_info[callee->subprogno].changes_pkt_data = true;
+		return 1;
+	}
+
+	for (i = 0; i < CALLER_SAVED_REGS; i++)
+		bpf_mark_reg_not_init(env, &frame->regs[caller_saved[i]]);
+	for (i = 0; i < frame->out_stack_arg_cnt; i++)
+		bpf_mark_reg_not_init(env, &frame->stack_arg_regs[i]);
+
+	/* what is held now is what was held at the call and what the function took */
+	held = caller->refs;
+	nheld = caller->acquired_refs;
+	caller->refs = NULL;
+	caller->acquired_refs = 0;
+	err = copy_reference_state(caller, exit);
+	if (err) {
+		kfree(held);
+		return err;
+	}
+
+	/*
+	 * The same state comes out for every call. Ids in it have to be new
+	 * every time, or two calls in a row return the same object.
+	 */
+	idmap->cnt = 0;
+	for (i = 0; i < nheld; i++) {
+		idmap->map[idmap->cnt].old = BPF_INHERITED_ID + i;
+		idmap->map[idmap->cnt++].cur = held[i].id;
+	}
+	/*
+	 * What is taken is added at the end. What is released leaves no hole. Only what the
+	 * function held all the time is kept: the state at its exit looks the same when it
+	 * released a lock and took it again, or took another lock that has no id either.
+	 */
+	for (i = 0; i < nheld && i < callee->entry_refs; i++) {
+		/* see inherited_id() */
+		for (j = 0; held[j].id != held[i].id; j++)
+			;
+		id = held[i].id ? BPF_INHERITED_ID + j : 0;
+		if (caller->refs[i].id != id || caller->refs[i].type != held[i].type)
+			break;
+		caller->refs[i] = held[i];
+		kept++;
+	}
+	kfree(held);
+	/* What it means for the caller is found out in the context of the caller. */
+	if (kept != nheld || callee->entry_rcu_locks < caller_rcu ||
+	    callee->entry_preempt_locks < caller_preempt) {
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "func#%d releases what its caller holds at insn %d\n",
+				callee->subprogno, call_idx);
+		env->subprog_info[callee->subprogno].releases_inherited = true;
+		return 1;
+	}
+	nregs = bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
+	for (i = 0; i < nregs; i++) {
+		reg = &frame->regs[ret_regs[i]];
+		*reg = callee->regs[ret_regs[i]];
+		reg->id = fresh_id(env, idmap, reg->id);
+		reg->parent_id = fresh_id(env, idmap, reg->parent_id);
+		reg->map_uid = fresh_id(env, idmap, reg->map_uid);
+	}
+	/* those that were held are the first */
+	for (i = nheld; i < caller->acquired_refs; i++) {
+		caller->refs[i].id = fresh_id(env, idmap, caller->refs[i].id);
+		if (caller->refs[i].type == REF_TYPE_PTR)
+			caller->refs[i].parent_id = fresh_id(env, idmap, caller->refs[i].parent_id);
+	}
+	caller->active_irq_id = fresh_id(env, idmap, caller->active_irq_id);
+	caller->active_lock_id = fresh_id(env, idmap, caller->active_lock_id);
+	/* fresh_id() had no room for an id, or there are no ids left */
+	if (idmap->cnt == BPF_ID_MAP_SIZE || env->id_gen >= BPF_MAX_ID) {
+		verbose(env, "too many ids at the call at insn %d\n", call_idx);
+		return -E2BIG;
+	}
+	return 0;
+}
 
 /*
  * Call of a static subprog. The callee is verified in the context of
-- 
2.55.0

