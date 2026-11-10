Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270476;
	b=XexZ6TPGpfdP+vJWTe34CbZKijDQe7LqoGu9BCsQDhbYPb7Df9v7uCTT6OMXA+QkGZk6
	 halEcY89J6gnUNURmAdIvOZwXufJNotX7r/cfw8d/y+OexH7i11FtN4GXhnLSw6QAXHtz
	 GQgB8ayGvZyxvoThSXo6MnDkib1yxSKFpQfpuSe+E9BL3E3lEwM2VQyYcgHa2dcn6STxA
	 6H40XzOglrV/763EYcVYXBekw+ECTIBYj37NsEcDKkkjmJHCEkZ4eg+FMoFKPnR6yfQUF
	 EVcV44QibyQ0aT/5YC2nXi26ARiRoQLxIZEdygejFpZqwL6qtw30Ukx2uCy3haD6YYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=B4tvonK4loxw77JfJOUf+hgJhWhNPwRtgMt3yq05qrI=;
	b=YVxBcznCR7igDMO7HGJgTHjFzhRwTkt12yVT+bLVoazAxYzPQEMVb8v/5U9Q7W9pWwCp
	 /5h2sW3y8ZmTNJqkPJImSstWA1oVeTK/5BePi6mAoQA/Y8qg02YVRhGV9OeqZkIOm968u
	 SeojVatjVy2ppbwHN+wmc689k/IJDQ012vPri99WUxbl2EgfhpKwX2GcwenQClR3o58mU
	 mFJPpnJiqFFMTERy6kc8T4xN8xPBUn6muooPZmK/QqyWhIaeaO6yxDss/319o6ixmEqSC
	 CcTRU+1H8hzeBrnr72HaR1G0zKZHqqem/OFlk40dLtjYBF0YZlFM9OSPeyWAlqhsyEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aZu4SPU8;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14952606A333
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14952606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aZu4SPU8
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b886ebe069so4836295e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270474; x=1794875274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B4tvonK4loxw77JfJOUf+hgJhWhNPwRtgMt3yq05qrI=;
        b=aZu4SPU8wCuN38EsrhmMAGJdXHOMKv1k0eJeYr+81pqowETO9HSWoXReEPbGEfkZun
         x2ut7u13Z0b2wsAJzDeI/5cXL1iDcXeKi711SVNnTJACGTj2tFeTYgwlZ3PGjpyBTGuN
         pZ4A7AzxiJ6UVsF+SJTOmMjiL1oFqHCAGupjaD9wfXBNodAZ3PRCSyOxSXsnrWtkRUFX
         4VEHCy/ph+gmnr2+lDgzaM9GLap6hiWKg/0vX7oAZAIzHxunuMc9n1cINIsWfHibSOlW
         iiuS4PzfbG8eDNZw9er7JcrzmybtO3bv27Vm49tQJKlNNGMWMTxRtNRW+4rJT9e2RYE9
         qhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270474; x=1794875274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B4tvonK4loxw77JfJOUf+hgJhWhNPwRtgMt3yq05qrI=;
        b=UAP+2rDr2F0lqXIcGk/nbgC9nKuHvvc4REp3jSaXpbERMtOsx+2cQIKtHDQ1AKnobO
         i9NvC/LPWuyIbA2MUAhwWLeKYajWRUjryU9FXuNZby1ADr1O39C+a3Y6MOUhXvR8OtKW
         Rup+2h/WCAjyeobPd22YWfQB0ULbYCPlxlo6zcTqWxCIqEBtMrbSyq9QvnHfdFKh3iTf
         yTq7EMjcX2qND/NEzeTjwyv6hx9gUM+BQEkMxs037404QJiiYJMJ/UK8503isDWAUmkx
         N5FXLmMxJWwaLNhhG/ZHlOz/qtQfuhWUBYVlm+MJLvDx4aaF62k2YbknREqAQGZ+P6zw
         C/nw==
X-Gm-Message-State: APuU4Z/3Crw1+Abfb4H0CXdMXLUF+ivCGzawPmAJa6zgjlA+Ivlzhlkm
	yMwMdeRSdJQYtcQE15D5EzImfM8gTNzoan2mZBiNqmZKReAN9zH5sIxgMc+Ap0M7
X-Gm-Gg: AYBFou3Yd0mJuDHxzwn5K/YKFk+vg3C3KrdoAN9xyE8izesSijS45BzKyvoRvQiHda5
	pgXFkvJO+q372Y9cFJ3AF4BMIu7kUX7uNiaFOBDPnd1fn8/4nyRlM9NU1hMytGLNX71xyuHBHNC
	mG90cOyTn2AAE1ANyYXEte7JzjxABLObCCJwGCO3wEtHTiAnsjKwa9B5f++//PSASK4wEedP/QO
	yaELMuEcMhhBQGUcHu8lWz3qU3zrPGp7wtottJNdis5fc0qXLsjhELdccB3sblySELbHY5DSqOT
	wkL+6yFl/0PPWoCJbJAxGgZIc+0Rs4kQDSbigEJtgqVBc6TrCbW40h1OhKYNqp4jKhGgk72wpfQ
	8CNNrx756gpWF+a98bcEEWCjJ7DxFjmeQWcSJI/TmfS/ZEMc1BP/PuIu6AtOuVRlPVXmlzIx2c+
	8dvPQrfMnBkh+lrAgV5dWb5s20A73IFi2tt9i3o92hMpx6CVRr7LrLD5UZOR7u4CXw1h22tlKF1
	BysFFzD+6gR7GP0rRap6r6aGrERf3x/N9q5EE5riloYpkohZ0TUKDSC8i5WCaK/aMgkv3BUoq2g
	Wxxy2gdkjesTt9Zo5Yk8Tc8SQGzpZKMrZCGyC9QuqIm9Sx6rU9foQWokr1pbidtmWIja7NHYF07
	uKAXczq3E3/QUEOwJi1e85i48fcSZx7b8z5prG6nS/FV6GsGJDEYT2mnJr69gOTVtorCE
X-Received: by 2002:a05:600c:6089:b0:49f:e8bf:8f9b with SMTP id 5b1f17b1804b1-4ba02302e83mr13391645e9.4.1794270474331;
        Mon, 09 Nov 2026 16:27:54 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0233e5d7sm16658035e9.1.2026.11.09.16.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:27:53 -0800 (PST)
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
Subject: [PATCH bpf-next v1 04/20] bpf: Propagate bpf_task_park() through global functions
Date: Tue, 10 Nov 2026 01:27:26 +0100
Message-ID: <5fd460338bed03de73f4ddf8eeaa4b60f35703bf.1794269506.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8824; i=memxor@gmail.com; h=from:subject:message-id; bh=DHxK1bJvdUYSkKB9oh/UFe+wxRx2jKPMy4Mb4yS5ddY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTossNRXexYM2XzQfPxWe7+71+y14Vwvk643amiBmvq 8uma/IdJSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmIh3CcP3Qmujle/T3q2Lzrv3 5UTFI2mT50xK3QuLHktvCj56V1CW4Q/3oQu7TrR9nL3eiYGVb2tmNX/cuXdc1RdyZ07SSr+jzMg OAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A global function is verified on its own, with no knowledge of its
callers, and a call to it is checked against its declared contract
rather than by walking into it. The two rules the previous patches
added at the park are therefore blind to a park that happens inside a
global function: the caller keeps its map value pointers across the
call, and a callback may call a global function that parks. The first
is a use after free waiting to happen, the second defeats the callback
restriction.

Record the fact per subprogram the way might_sleep and changes_pkt_data
are recorded. The CFG pass marks the subprogram containing a
bpf_task_park() call and merges the mark into every caller through
merge_callee_effects(), so might_park on a subprogram means that some
call reachable from it may park, through static and global callees
alike. Like the other two marks it is computed before dead code
elimination, so an unreachable park still sets it; the consequence is
conservative, a caller that invalidates more than it had to.

At a call to a global function with the mark, apply at the call site
what the park would apply inside: refuse the call from any callback
frame, refuse it while the caller holds a live dynptr or an iterator
other than bpf_iter_num, and after the call invalidate the caller's
registers that would not survive the sleep. The callee's own frame is
covered when the callee is verified, where the park itself runs the
checks; this patch completes them for the frames the callee cannot see.
A global function that parks and is called from a non-sleepable
context needs nothing new: a global function is verified once per
calling context, and the park is registered as a sleepable kfunc.

Extension programs need no further rule. An extension replacing a
global function of a syscall program resolves to the syscall type for
its kfunc set and could name bpf_task_park(), but an extension cannot
be loaded sleepable, so the park is refused there as any sleepable
kfunc is in a non-sleepable program. Behind that, bpf_check_attach_target()
refuses to extend a function that runs without an RCU read lock, which
is every function a syscall program actually calls, since its sleepable
main body marks each callee as called in a sleepable context; only a
global function that nothing calls stays extendable, and nothing would
run it.

The mark does not cross the instruction that only loads a callback's
address, unless the program uses callx. A park in a synchronous callback
is refused at the park, with the caller's frames in view, and an
asynchronous callback is a root of its own, so the function that passes
the callback does not park on its account. With the mark it would be
treated as if it did, refused from callbacks and made to invalidate its
caller's pointers, which matters as soon as some callback may park
legitimately, as the body of a BPF kthread does. A loaded address may
also be called through callx, which is a call like any other, so the mark
follows it when the program has callx.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  3 +++
 kernel/bpf/cfg.c             | 23 +++++++++++++++++++++++
 kernel/bpf/verifier.c        | 27 +++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4771c55d8f41..b304f3ebc983 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1056,6 +1056,8 @@ struct bpf_subprog_info {
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
 	bool might_sleep: 1;
+	/* some call reachable from this subprog may be bpf_task_park() */
+	bool might_park: 1;
 	bool uses_arena_sp: 1;
 	/* a callback that takes a stack in arena, like the main program does */
 	bool arena_stack_entry: 1;
@@ -2033,6 +2035,7 @@ static inline bool bpf_is_kfunc_sleepable(struct bpf_call_arg_meta *meta)
 }
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta);
 bool bpf_is_cast_kfunc(const struct bpf_call_arg_meta *meta);
+bool bpf_is_task_park_kfunc(struct bpf_call_arg_meta *meta);
 struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem);
 int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off);
 bool bpf_insn_is_cond_jump(u8 code);
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index bbcf42eae9d9..0102df246633 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -67,6 +67,14 @@ static void mark_subprog_might_sleep(struct bpf_verifier_env *env, int off)
 	subprog->might_sleep = true;
 }
 
+static void mark_subprog_might_park(struct bpf_verifier_env *env, int off)
+{
+	struct bpf_subprog_info *subprog;
+
+	subprog = bpf_find_containing_subprog(env, off);
+	subprog->might_park = true;
+}
+
 static void mark_subprog_might_throw(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *subprog;
@@ -86,15 +94,28 @@ static void mark_subprog_might_throw(struct bpf_verifier_env *env, int off)
 static bool merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
 {
 	struct bpf_subprog_info *caller, *callee;
+	bool might_park;
 
 	caller = bpf_find_containing_subprog(env, t);
 	callee = bpf_find_containing_subprog(env, w);
+	/*
+	 * A park in a callback does not mark the function that only loads
+	 * the callback's address: a synchronous callback is refused at the
+	 * park with the caller's frames in view, and an asynchronous one is a
+	 * root of its own. The address may also be called through callx,
+	 * which is a call like any other, so the mark follows it when the
+	 * program has callx at all.
+	 */
+	might_park = callee->might_park &&
+		     (bpf_pseudo_call(&env->prog->insnsi[t]) || env->has_callx);
 	if (caller->changes_pkt_data >= callee->changes_pkt_data &&
 	    caller->might_sleep >= callee->might_sleep &&
+	    caller->might_park >= might_park &&
 	    caller->might_throw >= callee->might_throw)
 		return false;
 	caller->changes_pkt_data |= callee->changes_pkt_data;
 	caller->might_sleep |= callee->might_sleep;
+	caller->might_park |= might_park;
 	caller->might_throw |= callee->might_throw;
 	return true;
 }
@@ -618,6 +639,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && bpf_is_kfunc_sleepable(&meta))
 				mark_subprog_might_sleep(env, t);
+			if (ret == 0 && bpf_is_task_park_kfunc(&meta))
+				mark_subprog_might_park(env, t);
 			if (ret == 0 && bpf_is_kfunc_pkt_changing(&meta))
 				mark_subprog_changes_pkt_data(env, t);
 			if (ret == 0 && bpf_is_throw_kfunc(insn))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b42782c7f209..d8fbdd6b9658 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12129,6 +12129,26 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 		}
 
+		/*
+		 * A park inside the callee is checked when the callee is verified,
+		 * but only against the callee's own frame. Apply the rules for the
+		 * frames the callee cannot see here, at the call.
+		 */
+		if (env->subprog_info[subprog].might_park) {
+			if (in_callback_frames(env)) {
+				verbose(env, "global function %s() may call bpf_task_park(), which is not allowed in a callback\n",
+					sub_name);
+				operation = bpf_diag_fmt(env, "global function %s() that may call bpf_task_park()",
+							 sub_name);
+				bpf_diag_policy(env, *insn_idx, operation, "the call is in a callback",
+						"Call the function from the main program or from a function it calls directly, not from a callback.");
+				return -EINVAL;
+			}
+			err = check_park_stack_objects(env, *insn_idx);
+			if (err)
+				return err;
+		}
+
 		if (env->log.level & BPF_LOG_LEVEL)
 			verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
 				subprog, sub_name);
@@ -12141,6 +12161,8 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		returns_void = subprog_returns_void(env, subprog);
 		if (env->subprog_info[subprog].changes_pkt_data)
 			clear_all_pkt_pointers(env);
+		if (env->subprog_info[subprog].might_park)
+			invalidate_regs_across_park(env);
 		if (returns_void)
 			bpf_diag_record_scrub(env, &caller->regs[BPF_REG_0], BPF_DIAG_MOD_CALLER_SAVED);
 		else
@@ -14538,6 +14560,11 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 	       is_kfunc_dynptr_write(meta);
 }
 
+bool bpf_is_task_park_kfunc(struct bpf_call_arg_meta *meta)
+{
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_task_park]);
+}
+
 static u32 kfunc_abi_slots(const struct btf_func_model *fm)
 {
 	const struct bpf_jit_arg_abi *abi = bpf_jit_arg_abi();
-- 
2.53.0

