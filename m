Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270488;
	b=Ikdc0zUbxjRO6voQUdvi6AID0Qo7JP+5wCnidjKlbdgwJb3DjqMRwDjwaAqAUy14KuAc
	 QM1OOLKxb72OWwmaMPxHXgEzYRyCgi4JOIlqy2LuFzPwco4lORivQmrjMj+0RV1KKilM4
	 +f1dInlOYae/3FPjYs4M9LWUJkgnteX2ALl6vp7AtEEe6iLsL6ktZmO1rgjYK4ncKWM5y
	 J4+xSpqVzG/tqplOoG/m7TuJ9uRH33lFqungyR/Icd+ernQtkRvE6HcOqiVDgtlMLaYm6
	 YbrIAGOUmo/hNNFGsCCnwvxfFe1X5D8wCkmfn0yo/PBJDJqlWYfhtvzg6NaoDRHbBZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=56TXhMYJss2Bt9zjAlghtPBQrtW15Xi3G4FlWoRFs+4=;
	b=kIowlliqOno43eiH4xEEgHfhNzjMXlKhLmEIurEhm6k2AeDSnqAPp8FF+2A073iGZUtr
	 20z1ZC6S6nGoY7MLcerKDvYjkiAKJPUrzd3bO72jmX2pT2Gjf/G57bM3NqtEgJ60XdhjX
	 kUIlboG3Iqf/+QX45AFFOM8Hn4/dzLnCcQLtFR6bUyKa6EBk5BtTKbOFxKVboaFs5EDNx
	 ZsJe8cj9mIjuwHPbmVJPnPolU2eOUruWzVBjA8A6ZG8+tyXs4AuONRzmwfEQ05Uhw9tIa
	 BG5o2MUBq8uRUduNPrartevpn7PbbqixSJWbAaXaTa0zzcyarh8QucZLdrhfIHrNmkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fmzsMP5p;
	arc=none smtp.remote-ip=74.125.225.134
Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246E606A330
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6246E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fmzsMP5p
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-4a35d5b19baso3008895e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270487; x=1794875287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56TXhMYJss2Bt9zjAlghtPBQrtW15Xi3G4FlWoRFs+4=;
        b=fmzsMP5pJ+CBD0vTUVUT/cl3/GpKn6T9pfUbaeAvwmprlVoguhgY+zFrQldmtFc+pj
         y3Xm3tiTFa6U6HMw0Cg68LmfC1iqeTcospVwSRmDvOv/TUMYtvkpjDZq7vmhpRsDBAJ7
         0xSLQr1K9OZ40pDnXp9kZGSkt350nipdDLPO9w4qLbK/uP2N1kfzHy1cgzZsPVD0XsiW
         RUInLUAHV8DpUp6RVaUn/zXi0wFkpHNRvPNLsGXZtLMKXlPkhHjMynYkM8hwnCSPd/Hf
         Vf/1GhnsKqZUWMRybuAj9q6ro0iaei3GPsozYSWi858Un8HURxoSgp+/hUn2nsczEB1W
         nijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270487; x=1794875287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=56TXhMYJss2Bt9zjAlghtPBQrtW15Xi3G4FlWoRFs+4=;
        b=ZoQ+BGBJ/nTdDGRyQuSLWSd3E8uNK1WKLHEpuauJttFpwGbogUCA6sGr7089kkEkap
         ig0nN72rrCCTGl9lnUUixymTE8lOwranuVG9hCb6rI/a/+H8r4fDNxNDU16MzFur7gZL
         zOVQBY1UwwoKzXZVQ5YuQ5imKGaFelh4U9BNIxjfdF7lBbwZI+JEmxnmqSc+rOv6Xupz
         jVPABy7o2c59KL1jM1IBZf8KI2fkw9eePRFIS5ZQ229BPncr4dif4ImqnMw4BFec2qCh
         5Y0ayQSFmcU3KV8xrJdht9uAdvepa8rzoSSiivjqcA/4YdK9tRaAnqpzkR9Da0Ud8liQ
         CFvA==
X-Gm-Message-State: APuU4Z+UFPsxV0sSVKO3O0b6Z50is51itQuYvkk1aASPWrhoMpiw6PwA
	1wmniDecQuYCbzhNs71WDuAfPW8CiVRNtqQh09tsHpe8Ew1xHYvDdxiEQALrHYdy
X-Gm-Gg: AYBFou1rRatIrL/98R6i6/8BwO02aCAF2qzlfxQWbu9nHSpcq22xu0ff/xP947Hpl83
	iaSK2HK0iqYh5qOEheMKmUuwmXPKRO3LlmHgf7dbGU0S6TUM+Yd1rgw1HDXXgXNo//Bk8Q0md/s
	65WemQcq1LK2uVSIYagy+60/Nj8xYLVIhI7qGgOR3+/OMbVg4buSQ8YW+ZtKRd1vOSwuRNLdOYb
	B5RurwZI2LPVwEe5Q/NNWTNvLktf96JSLk83FZrEk4wUWRXSNMm4HFovC3xwMJzMEA8RilSJ/7Q
	hRh6GkAbvT9i7y0byvPq00vfDZ1yIEZY12WJKSh1S+Ira2VovxwWPe44AQtzcutIDPfBsyE2LL2
	coqk9njc3Fd+KreZYqS9d2AG0QJVJ08gBQ6IvB1ylDwI62Uo/39J0rx99auvW+iZR+FtvQQI/zA
	4LJgKls0GAsMI3NaGjYCzBe+SCmfQ0DzERNGFsklk1Gq7e1O62w2P61Rns0JRlG3hEwyNv90WjB
	ulrS3PiW390bKX/6jqUEyLLsso23ntfk+EGDikBeTqCFSzk3xcwpeOOCtmIxagtlgXJSN1z6D32
	mpgWA9e6McRPHnl82Cy9gHVz1DaZOsp65E9ckURxWxC6sq65sXb8zJAvO4VJ7MpvcUP3APnQDG4
	KCRe749JVhm/gIDFdrDwDg+Ae4Goa45ND8I83FZdGypRakzSPjXd1Etjh9eqc4F1qdsw5
X-Received: by 2002:a05:600c:3b9b:b0:4a5:a5ca:de1d with SMTP id 5b1f17b1804b1-4ba023577bfmr15081195e9.30.1794270486753;
        Mon, 09 Nov 2026 16:28:06 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe2c5asm40480845e9.5.2026.11.09.16.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:05 -0800 (PST)
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
Subject: [PATCH bpf-next v1 11/20] bpf: Let a BPF kthread sleep in bpf_task_park()
Date: Tue, 10 Nov 2026 01:27:33 +0100
Message-ID: <7383a660f34ccf6c292d7e6c28e78cf137d09d1c.1794269507.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12862; i=memxor@gmail.com; h=from:subject:message-id; bh=syuPoWqlWdB+S4JdgqQrAVL2bXEJ3PxpixT3tU9HQmM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTovsKxn1ST+5NMv219lLsNT3djc2qtvzrbjvuU3N1W uGonXm9o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPhmc7wh6fV3+3CzMJZ3EvM nz4rd1n5/Pm7mpY3WaIVb9a/9TlwlIXhr6CQ2+k9Ly7mW81n75RTLXM61Vi7+MC5VCHu+0c9Nu3 X5gYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The body of a BPF kthread is an asynchronous callback, and the verifier
refuses bpf_task_park() in every callback frame, so a BPF kthread cannot
sleep. It can only poll in a bounded loop with migration disabled, which
holds off CPU offline and any change of its affinity for as long as it
runs, and stalls every Tasks Trace RCU grace period meanwhile. A thread
that serves a queue or ticks a controller spends most of its life
waiting, and the one primitive the program has for waiting is closed to
it.

The refusal exists because a callback runs from kernel code that keeps
state of its own around the call, an iteration position, a timer or
work item that owns the program only through Tasks Trace RCU, an exiting
task, and none of that code has been audited against a sleep that drops
the program's migration and RCU protection. bpf_kthread_fn() has been:
it is the whole of the thread, brackets the callback the way the runner
of a syscall program brackets the program, keeps nothing across it, and
the program with its maps and code is held until the thread has exited,
since the release of the program's last reference stops its threads and
waits for them before its code and maps are freed. The callback's one
argument is a scalar, so the park has no context pointer to keep alive
either.

Mark the frame the kthread callback runs in and let the walk that
refuses the park skip it. Callbacks nested under the body, a bpf_loop()
body or a timer callback the thread arms, stay refused as anywhere else,
and a global function that may park is admitted from the thread body by
the same walk. The rules on what survives the park are unchanged: the
stack, array map values, arena memory and verifier-tracked references
stay, and everything else is looked up again after the sleep.

At runtime the park nests inside the bracketing of bpf_kthread_fn(): it
enables migration and leaves the Tasks Trace RCU read section for the
sleep and restores both before returning to the callback. A stop request
ends the sleep, since kthread_stop() wakes the thread, and the park
reports it as -ESHUTDOWN, as does every park after it, so a body that
checks bpf_kthread_should_stop() around its park, or the park's return
value, returns as before.

The frame flag also takes part in state comparison. A static subprog
may be passed both to bpf_kthread_create() and to bpf_wq_set_callback(),
and both roles are verified as frame 0 of a sleepable asynchronous state
over the same instructions, so a state explored in the kthread role,
where the park is admitted, could stand for a state of the workqueue
role, where it must be refused, or the reverse. bpf_state_subsumes() and
join_func() therefore treat frames that differ in the flag as
different: neither state is taken for the other, and the two are not
joined.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  6 ++++++
 kernel/bpf/join.c            |  1 +
 kernel/bpf/kthread.c         | 17 ++++++++++++-----
 kernel/bpf/states.c          |  7 +++++++
 kernel/bpf/task_park.c       | 16 ++++++++--------
 kernel/bpf/verifier.c        | 31 +++++++++++++++++++++----------
 6 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 39ff1359adb9..7097bb7033e8 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -469,6 +469,12 @@ struct bpf_func_state {
 	bool in_callback_fn;
 	bool in_async_callback_fn;
 	bool in_exception_callback_fn;
+	/*
+	 * The body of a BPF kthread: an async callback whose kernel caller,
+	 * bpf_kthread_fn(), keeps nothing across it that the sleep in
+	 * bpf_task_park() could invalidate, so the park is allowed in it.
+	 */
+	bool in_kthread_fn;
 	bool no_stack_arg_load;
 	/*
 	 * The helper invokes this callback under rcu_read_lock(), so the
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 8bd92af087c0..b63f99c66308 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -452,6 +452,7 @@ static bool join_func(struct bpf_join_state *js, struct bpf_func_state *fd,
 			return false;
 		if (fa->in_callback_fn != fb->in_callback_fn ||
 		    fa->in_async_callback_fn != fb->in_async_callback_fn ||
+		    fa->in_kthread_fn != fb->in_kthread_fn ||
 		    fa->in_exception_callback_fn != fb->in_exception_callback_fn ||
 		    fa->in_rcu_callback_fn != fb->in_rcu_callback_fn ||
 		    fa->async_entry_cnt != fb->async_entry_cnt ||
diff --git a/kernel/bpf/kthread.c b/kernel/bpf/kthread.c
index 3055e427fe76..d8f63461d756 100644
--- a/kernel/bpf/kthread.c
+++ b/kernel/bpf/kthread.c
@@ -13,8 +13,8 @@
 /*
  * A BPF kthread is a kernel thread whose thread function is one callback of
  * the program that created it, run once. The callback is the body of the
- * thread: it loops, sleeps and returns on its own, and its return ends the
- * thread. The kernel adds nothing in between.
+ * thread: it loops, sleeps in bpf_task_park() and returns on its own, and its
+ * return ends the thread. The kernel adds nothing in between.
  *
  * The thread is known to the program by its task_struct. bpf_kthread_create()
  * returns it as a referenced pointer, and the control kfuncs take it back, so
@@ -99,9 +99,16 @@ static int bpf_kthread_fn(void *data)
 	/*
 	 * The callback runs as the body of a sleepable program does, with
 	 * migration disabled under a Tasks Trace RCU read section, except
-	 * while it waits in one of the kfuncs the comment at the top names,
-	 * which drop migration disable alone. The verifier checks it as a
-	 * sleepable callback.
+	 * while it sleeps in bpf_task_park(), which drops both for the sleep
+	 * and takes them again before it returns, and while it waits in one
+	 * of the kfuncs the comment at the top names, which drop migration
+	 * disable alone. That is
+	 * safe here for the reason it is safe in a syscall program: this
+	 * function keeps nothing across the callback, and the program, with
+	 * its maps and code, is held until the thread has exited, since the
+	 * release of its last reference stops the thread first. The verifier
+	 * checks the callback as a sleepable callback in which the park is
+	 * allowed.
 	 */
 	/*
 	 * A task work queued for this thread with TWA_SIGNAL sets
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index f75161423377..d0db8074928a 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -759,6 +759,13 @@ bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state
 		insn_idx = bpf_frame_insn_idx(old, i);
 		if (old->frame[i]->callsite != cur->frame[i]->callsite)
 			return false;
+		/*
+		 * The body of a BPF kthread may park where another async
+		 * callback of the same subprog may not, so a state verified
+		 * in one role must not prune the other.
+		 */
+		if (old->frame[i]->in_kthread_fn != cur->frame[i]->in_kthread_fn)
+			return false;
 		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx))
 			return false;
 	}
diff --git a/kernel/bpf/task_park.c b/kernel/bpf/task_park.c
index 9de1b496ead1..b6980c1cc1bf 100644
--- a/kernel/bpf/task_park.c
+++ b/kernel/bpf/task_park.c
@@ -198,14 +198,14 @@ __bpf_kfunc int bpf_task_park(u64 timeout_ns, u64 flags)
 	 * the time slice of may_goto, is refused the call, and one that calls
 	 * it is kept out of prog arrays, where the caller of a tail call holds
 	 * it through this very read section. The verifier confines the call to
-	 * such contexts: the main body of a syscall program and the functions it
-	 * calls directly, never a callback, and never a region that pins the
-	 * CPU, a lock, a saved IRQ state or an RCU read section. It also
-	 * invalidates every pointer the program holds across the call except its
-	 * stack, its context, maps it references directly and the values of its
-	 * arrays, arena memory and verifier-tracked references. What remains is
-	 * that the program may resume on another CPU, which is part of the
-	 * contract.
+	 * such contexts: the main body of a syscall program or of a BPF kthread
+	 * and the functions either calls directly, never any other callback,
+	 * and never a region that pins the CPU, a lock, a saved IRQ state or an
+	 * RCU read section. It also invalidates every pointer the program holds
+	 * across the call except its stack, its context, maps it references
+	 * directly and the values of its arrays, arena memory and
+	 * verifier-tracked references. What remains is that the program may
+	 * resume on another CPU, which is part of the contract.
 	 */
 	migrate_enable();
 	rcu_read_unlock_trace();
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0cf0d3a85b35..ee409ac5be77 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11226,14 +11226,22 @@ static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 }
 
 /*
- * bpf_task_park() is confined to the main body of the program and the
- * functions it calls directly. A callback runs from kernel code that holds
- * state of its own around the call, an iteration position, a work item or
- * timer that owns the program only through Tasks Trace RCU, an exiting task,
- * none of it audited against a sleep that drops the program's protection.
- * Refuse the park in any callback frame, synchronous, asynchronous or
- * exception. Asynchronous callbacks are verified as a state of their own
- * with the callback as frame 0, so the walk over the frames sees them too.
+ * bpf_task_park() is confined to the main body of the program, the body of a
+ * BPF kthread, and the functions either calls directly. Any other callback
+ * runs from kernel code that holds state of its own around the call, an
+ * iteration position, a work item or timer that owns the program only through
+ * Tasks Trace RCU, an exiting task, none of it audited against a sleep that
+ * drops the program's protection. Refuse the park in any such callback frame,
+ * synchronous, asynchronous or exception. Asynchronous callbacks are verified
+ * as a state of their own with the callback as frame 0, so the walk over the
+ * frames sees them too.
+ *
+ * The body of a BPF kthread is the exception because its caller,
+ * bpf_kthread_fn(), is the whole of the thread: it brackets the callback the
+ * way the runner of a syscall program brackets the program, keeps no state
+ * across it, and the program's release stops the thread and waits for it
+ * before anything the callback uses is freed. Callbacks nested under the
+ * body are refused as anywhere else.
  */
 static bool in_callback_frames(struct bpf_verifier_env *env)
 {
@@ -11243,6 +11251,8 @@ static bool in_callback_frames(struct bpf_verifier_env *env)
 	for (i = 0; i <= vstate->curframe; i++) {
 		struct bpf_func_state *frame = vstate->frame[i];
 
+		if (frame->in_kthread_fn)
+			continue;
 		if (frame->in_callback_fn || frame->in_async_callback_fn ||
 		    frame->in_exception_callback_fn)
 			return true;
@@ -12159,7 +12169,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				operation = bpf_diag_fmt(env, "global function %s() that may call bpf_task_park()",
 							 sub_name);
 				bpf_diag_policy(env, *insn_idx, operation, "the call is in a callback",
-						"Call the function from the main program or from a function it calls directly, not from a callback.");
+						"Call the function from the main program, from the body of a BPF kthread, or from a function either calls directly, not from any other callback.");
 				return -EINVAL;
 			}
 			err = check_park_stack_objects(env, *insn_idx);
@@ -12661,6 +12671,7 @@ static int set_kthread_callback_state(struct bpf_verifier_env *env,
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
+	callee->in_kthread_fn = true;
 	/*
 	 * The callback returns an int, which comes back in the low 32 bits of
 	 * R0: compare those, as for a global function.
@@ -16511,7 +16522,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		if (in_callback_frames(env)) {
 			verbose(env, "bpf_task_park() is not allowed in a callback\n");
 			bpf_diag_policy(env, insn_idx, "kfunc bpf_task_park", "the call is in a callback",
-					"Call bpf_task_park() from the main program or from a function it calls directly, not from a callback.");
+					"Call bpf_task_park() from the main program, from the body of a BPF kthread, or from a function either calls directly, not from any other callback.");
 			return -EINVAL;
 		}
 		err = check_park_stack_objects(env, insn_idx);
-- 
2.53.0

