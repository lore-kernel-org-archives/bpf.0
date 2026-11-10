Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270472;
	b=PQ+wV5Y7ce1vNW1ymBz2z230n0+26U4IOu0Qot9dSGu/w4WCToEtEzhPfJjNJPn/2zx3
	 vFd2dsWeOlaG+oY3QIL6Bd6NbbI574a7Q5J+KS2Q4r28GsyCCD1p0v1/Qschgc1/vQzHf
	 vTtSCb30HMJ3ppr2SL4JZJIj3Nyiy8KdocUXs9R47Zss1YOPoc0Xll1QICZ9ib7iJ/y+p
	 +pVUI+NhDxYZOU/WzpxOaYW0Y1iMX7olvZi7B9TPweADBQIwRauirOxjEy+Ssy9w9OZVo
	 Cj+bUc5mtIaGZmyUKQ3Y2pbASaMI4ljWq+mAIdQPk5AGEDBUtCx5J0W48YLgC6hr0AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=jVH95qnGG3MbLgLBbbehZ/2MDmDQXwPdlXtnNIx2msc=;
	b=t/LyJLLtQBiPy9VlMJpZcfAhwll6e4Pv6L/qwzxzwrFDamJwpwnkRJ+xaLb1zOBr6PAr
	 p8UZ9/lLGrEUs8rAINVeAlpjTcAsse0Yp07hDnSi+ourSQhtgo6CUmGGwaseQU7YE3/OZ
	 wPAX9GQzO5nG7IIDaZiifWMA56MU0HpCSIk+JHJmTY3E+jWA2OVv6urde2XcpkU2LtmGp
	 DD/GHuHJ3PKjAdN+FWex3WuyToO5ujespnCQx4V87NDBETaoCQ5YdMXB9ttiMq2NPcDj1
	 ey7UJAvcYlwuIRnKuRNIGVEudDXu9XEqL7oqLe3sImA0/FYhC0oPXpe7nQmP1CpiIvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LiFXZHfx;
	arc=none smtp.remote-ip=74.125.225.132
Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B95606A332
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4B95606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LiFXZHfx
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-4a20fcb3e9aso1648665e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270470; x=1794875270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jVH95qnGG3MbLgLBbbehZ/2MDmDQXwPdlXtnNIx2msc=;
        b=LiFXZHfxWKDHyhM0lBP/apxUD3ppUYLQHE7xDPBEYljIw8M4tczXnjdiaEp8OQ1ndt
         Ba+DOY3hzw+OQY64aoF5cDODTBoiXSICzkOnc1xjoWw8ueT3j8Mp3lItvFcN3GJKYhwB
         Hbsfy8Vu2p0eToRoeaRKXmWqYL7VHAVvGfvbpnFofE1K7pbWmUSCEKp+JwcDUdbYV3lv
         GFFhQo9akFdUbfkousUx0zx8Tcpsb3SKQlr02QQnH1SaDEhHAi405zJCJYYDeitYim/q
         9asUnp0V3w1XyyE0gFDogPdc0wtvkF+0tihgPZdvGejfvUaRFEMeN/70/zi0+gxTIMqF
         1Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270470; x=1794875270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jVH95qnGG3MbLgLBbbehZ/2MDmDQXwPdlXtnNIx2msc=;
        b=x/3vWnedPi34GFlxu2278GN//cFzWvraL748REnF7qf/BFFczMUwNDmodO1IDnvWes
         OcQdwUI2Lfxncc1LqFfq9R3A301ZBP9MIVO+LB/lw0cVvyuFXODTeDC4UawBPUduUC7Q
         10QT78CT6gOwi0yYNmKCfRB2VS3zjdYbc4YrMSSFH1YLswHMaXIy2fVfmb3mUJ1KX1wg
         PI8KVpM8qVX7Q7K9AoeNcczBDNMQucDn2veRz0M97mt4J2f0xJVQF6XqNbSdK+/xJ9js
         I14MZOT1NtWITDbobNZh8/B3l6ePWsq8vR4ahmsYb2BVngHqCCTOdrDMEFCIkjTLU6ZP
         t2GA==
X-Gm-Message-State: APuU4Z8vaQSoOKoByAu/VeHnB55NkOW5jFBKr3mJdAcK0Rmk41Rx4LWX
	O7OlxUBfYswE25b0W6w9chIIU1RHUInqOSWzYihih5fIkaIac2iMkaWTgtjy99EW
X-Gm-Gg: AYBFou1pKeyVh8NhLU2PnEXjYeyK8TIICkwmeVPyY0ghogp9I8lhppFtGJ4pL2xirad
	CVHzgRy62QHayVmmwBooVhCtko8M7xHXI9jSDBOqiqQsy3O1+cLayfw0x/fSIbVtcLqokBzk/8h
	br3wDJWATzIVsdQ1D75nht6GtosIUg8YNjYE78rsRXyLZFxAcx93jp67kUHP8Tvjr0RZcrpKY+L
	ejE9BeW+Olt4OBSASvSY56cqq5PWFlaZurZOfES52iv6hOGr7txarARSfOPSjxMyJ9GmqlT8nBT
	r9/VKKDcZt9+GrOjeKq7H1Gkcf4EoXZ7Y/bE7Agdz81WXSIQBpb7Q1G11vgU+8JYviJNZ8vlZq8
	9/FWUhmnyvJjIf+dXpjNAudAVs4q9mY2DUcrPnpxvZzfL9C34lBGGrf0rZQVL2R66qSUTjpqd40
	5q2mOM51CRqV6vVeznGuHG3pPfBI3wPdq4Z/rUltOlWpTlSTpzMe66d1d6skNcJ+oweXqls+1k+
	LJK5VyOeIqDCwKYZh5KpUw+IkA+cSPq4q6FJHEwAtQFRpPwqk2fRNVCq3/eXSqpPQzClC98B8rt
	UorFjCKVzdeSPOPWIUUW+NON6EAbbCgbN+Z4LEyyqSvIIkIj9b6zCaaMHaoUAi86yYjj6tW+m3e
	uS9CyWFlVsAAe25yB/xp3DV2tCFjiAvvfXPdninBvq7r/0HsK9fHhllzqzCcD7HI4tR+Nt/VKiy
	ofTwli+SfQsb3RgQ==
X-Received: by 2002:a05:600c:5249:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4ba0234d88amr13676095e9.13.1794270469991;
        Mon, 09 Nov 2026 16:27:49 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02387ad9sm26347705e9.5.2026.11.09.16.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:27:49 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 02/20] bpf: Invalidate what a bpf_task_park() sleep may free
Date: Tue, 10 Nov 2026 01:27:24 +0100
Message-ID: <6751e6b26413cb4ea40aa63fd6bbb211e54cae49.1794269506.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11151; i=memxor@gmail.com; h=from:subject:message-id; bh=/Gibn7SGi56lxtjJhWE7PG6yPHUP1a8xjRaGb/HJMQs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTonOSAndOPPu2RR91r/qfvv1L6gDv5+XflQTWv3o39 6ZLna5lRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZSv5WRYcbRn6+5555/E1Ht +XLP5eYr7OfWPLDkW5mtqsgkMDGlKIrhD0f3nXtTfm83WJ/9Q2Pb1E/GW+s/eDYHHBRZvLbXiXV KJQsA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpf_task_park() drops the Tasks Trace RCU read section and the disabled
migration that a sleepable program runs under, for the length of its
sleep. Anything the program holds whose lifetime rested on either is
not safe to touch afterwards. Teach the verifier which registers and
stack objects those are and treat the call accordingly.

A pointer register, direct or spilled, is kept only when something other
than the dropped protection holds its target:

 - the stack, function and instruction pointers, which describe the
   invocation itself;
 - the context and the maps the program references directly, which the
   runner holds for the whole invocation;
 - the values of the program's own array maps. An array allocates its
   values with the map and frees them only with the map, and the program
   holds the map, so nothing can free such a value during the sleep.
   The program's global variables are values of its .data, .bss and
   .rodata arrays, and the compiler hoists their address out of a loop;
   without this rule no loop around a park could read a global;
 - arena memory, which the arena map holds and whose accesses tolerate
   faults;
 - pointers backed by a verifier-tracked reference, found through their
   own id or through their parent's id, since the reference keeps the
   object alive regardless of grace periods.

Everything else is marked invalid:

 - values of every other map type. A concurrent delete, an LRU eviction
   or the teardown of the owning socket, task or inode frees their
   elements after a grace period the sleeper no longer delays, or hands
   them straight back to a preallocated map's free list;
 - RCU and trusted pointers without a reference, including the task
   pointer from bpf_get_current_task_btf();
 - per-CPU pointers, since the task may resume on another CPU;
 - inner maps found through a map-in-map lookup, together with their
   values, which only the outer element holds. A map or value with
   map_uid set came from such a lookup, so the array and map pointer
   exemptions apply only when map_uid is zero.

Dynptrs and iterators need a different treatment. They live in stack
slots, and the program is obliged to release or destroy them later. The
verifier cannot invalidate them the way it invalidates a register, and
neither way of dropping them is sound:

 - Marking the slot's register state invalid would keep the slots typed
   STACK_DYNPTR or STACK_ITER while zeroing the state that describes
   them. That breaks the invariants destroy_if_dynptr_stack_slot()
   relies on: with first_slot cleared, a later store to the slot
   repositions to the slot above and releases whatever reference id it
   finds there, or reads past the end of the stack array when the dynptr
   was the topmost object.
 - Releasing their reference on the program's behalf instead would leave
   the runtime object, a ringbuf reservation or an iterator's kernel
   state, without the destroy the program can no longer issue.

The park is therefore refused while any dynptr or iterator is live in
any frame, naming the frame and stack offset. The one exception is
bpf_iter_num: its state is two integers on the stack and its next and
destroy touch nothing else, so an open-coded bpf_for() loop may contain
a park.

The invalidation runs in check_kfunc_call() after the arguments are
checked and before the caller-saved registers are clobbered and R0 is
set up, so the kfunc's return value is unaffected. Each scrub is
recorded for the diagnostics layer under a new reason, so a later access
through an invalidated pointer explains that the park invalidated it.

The invalidation walks every frame of the current state, which covers
the callers of the function that parks when they are in the state. They
are not when the function is verified without them, as a global function
is, and a static function that is verified on its own; later patches
handle the two.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c |   3 ++
 kernel/bpf/diagnostics.h |   1 +
 kernel/bpf/verifier.c    | 106 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 3de3e1486bbd..33788d6f6155 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -2231,6 +2231,9 @@ static void diag_print_mod(struct bpf_verifier_env *env, const struct bpf_diag_h
 	case BPF_DIAG_MOD_NON_OWN_REF:
 		reason = "leaving the protected region invalidated this borrowed pointer";
 		break;
+	case BPF_DIAG_MOD_TASK_PARK:
+		reason = "the sleep in bpf_task_park() invalidated this pointer";
+		break;
 	case BPF_DIAG_MOD_CALLER_SAVED:
 		reason = target->kind == BPF_DIAG_MOD_TARGET_STACK_ARG ?
 			 "call invalidated this outgoing stack argument" :
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index e155d2588a51..656c0430f013 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -26,6 +26,7 @@ enum bpf_diag_mod_reason {
 	BPF_DIAG_MOD_SLICE_BUF,
 	BPF_DIAG_MOD_NON_OWN_REF,
 	BPF_DIAG_MOD_CALLER_SAVED,
+	BPF_DIAG_MOD_TASK_PARK,
 };
 
 enum bpf_diag_context_kind {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20b1b9ff574c..e90cc127aedb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11222,6 +11222,98 @@ static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 	}));
 }
 
+/*
+ * bpf_task_park() sleeps without the Tasks Trace RCU read section and the
+ * disabled migration that a sleepable program otherwise runs under. A dynptr
+ * or an iterator on the stack cannot simply be invalidated across such a
+ * sleep: the program must still release or destroy it, and an object that
+ * stays usable may point at memory the sleep lets go. Refuse the park while
+ * any is live, except a bpf_iter_num, whose state lives entirely on the stack
+ * and whose next and destroy touch nothing else.
+ */
+static int check_park_stack_objects(struct bpf_verifier_env *env, int insn_idx)
+{
+	struct bpf_verifier_state *vstate = env->cur_state;
+	int i, spi;
+
+	for (i = 0; i <= vstate->curframe; i++) {
+		struct bpf_func_state *frame = vstate->frame[i];
+
+		for (spi = 0; spi < bpf_stack_nr_slots(frame); spi++) {
+			struct bpf_stack_state *slot = bpf_stack_slot(frame, spi);
+			struct bpf_reg_state *st = &slot->spilled_ptr;
+
+			switch (slot->slot_type[BPF_REG_SIZE - 1]) {
+			case STACK_DYNPTR:
+				/* Report the slot the program named, not the second half. */
+				if (!st->dynptr.first_slot)
+					continue;
+				verbose(env, "bpf_task_park() with a live dynptr at frame %d fp%d\n",
+					i, -(spi + 1) * BPF_REG_SIZE);
+				break;
+			case STACK_ITER:
+				if (!st->id)
+					continue;
+				if (st->iter.btf == btf_vmlinux &&
+				    !strcmp(iter_type_str(st->iter.btf, st->iter.btf_id), "num"))
+					continue;
+				verbose(env, "bpf_task_park() with a live %s iterator at frame %d fp%d\n",
+					iter_type_str(st->iter.btf, st->iter.btf_id), i,
+					-(spi + 1) * BPF_REG_SIZE);
+				break;
+			default:
+				continue;
+			}
+			bpf_diag_res(env, insn_idx, "live stack object across bpf_task_park()",
+				     "A dynptr or iterator on the stack may refer to memory that the sleep in bpf_task_park() lets go, and the verifier cannot invalidate it without losing the path that releases its reference.",
+				     "Release or destroy the dynptr or iterator before calling bpf_task_park(), or move the park out of the loop that uses it.");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Invalidate what the sleep in bpf_task_park() may free. Keep only pointers
+ * whose lifetime does not rest on the dropped protection: the stack and
+ * instruction metadata; the context and the maps the program references
+ * directly, which the invocation holds; the values of its array maps, which
+ * the map allocates and frees with itself, and which hold the program's
+ * global variables; arena memory, which the arena map holds and whose
+ * accesses tolerate faults; and pointers backed by an explicit
+ * verifier-tracked reference, found through their own id or the id of their
+ * parent. An inner map found through a map-in-map lookup is not kept, nor
+ * are its values: the outer map's element alone holds it, and its deletion
+ * frees it after a grace period the sleeping program no longer delays.
+ * Everything else, values of maps that free elements on delete or on their
+ * owner's teardown, RCU and trusted pointers without a reference, per-CPU
+ * and local storage pointers, is gone after the call.
+ */
+static void invalidate_regs_across_park(struct bpf_verifier_env *env)
+{
+	struct bpf_stack_state *stack;
+	struct bpf_func_state *state;
+	struct bpf_reg_state *reg;
+
+	bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, stack, 1 << STACK_SPILL, ({
+		enum bpf_reg_type type = base_type(reg->type);
+
+		if (!is_pointer_regtype(reg->type))
+			continue;
+		if ((reg->id && find_reference_state(env->cur_state, reg->id)) ||
+		    (reg->parent_id && find_reference_state(env->cur_state, reg->parent_id)))
+			continue;
+		if ((type == CONST_PTR_TO_MAP || type == PTR_TO_MAP_VALUE) && !reg->map_uid &&
+		    (type == CONST_PTR_TO_MAP || reg->map_ptr->map_type == BPF_MAP_TYPE_ARRAY))
+			continue;
+		if (type == PTR_TO_STACK || type == PTR_TO_FUNC || type == PTR_TO_INSN ||
+		    type == PTR_TO_CTX || type == PTR_TO_ARENA)
+			continue;
+		bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_TASK_PARK);
+		mark_reg_invalid(env, reg);
+	}));
+}
+
 static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
 {
 	struct bpf_stack_state *stack;
@@ -14173,6 +14265,7 @@ enum special_kfunc_type {
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_session_is_return,
+	KF_bpf_task_park,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -14274,6 +14367,7 @@ BTF_ID(func, bpf_session_is_return)
 #else
 BTF_ID_UNUSED
 #endif
+BTF_ID(func, bpf_task_park)
 
 static bool is_bpf_cast_to_kern_ctx_kfunc(const struct bpf_call_arg_meta *meta)
 {
@@ -14297,6 +14391,11 @@ static bool is_bpf_iter_css_task_new_kfunc(const struct bpf_call_arg_meta *meta)
 	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_iter_css_task_new]);
 }
 
+static bool is_bpf_task_park_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_task_park];
+}
+
 static bool is_bpf_obj_new_kfunc(u32 func_id)
 {
 	return func_id == special_kfunc_list[KF_bpf_obj_new] ||
@@ -16266,6 +16365,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_bpf_task_park_kfunc(meta.func_id)) {
+		err = check_park_stack_objects(env, insn_idx);
+		if (err)
+			return err;
+		invalidate_regs_across_park(env);
+	}
+
 	bpf_diag_record_caller_saved(env, regs);
 	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
-- 
2.53.0

