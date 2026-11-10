Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270478;
	b=KsToInlnCD71Ti0LIFJQg5feD7h8ix+F6n23dzHLxNLTcJKfNqJ14zBfhZqEmcuha3OJ
	 8LXtBFQIsoODlU9TsJF26JOydQ9eMc+pZN+Ihkram8nUc0UtRrK7dVIrMSK5Tp8OmyS38
	 YawYEF9rASGvx4esokYhiKjciUbJRkMvpHRDU23DNeNV82wenVdjymNM0aHJIz7nYb9ff
	 GC/5rhY3/fk/b7WbrR4pY7wld9E4I1zrEOPRYi1jZnStSDELy0XdhyB4ESKyITI3npG6G
	 mRbEi3YXlq+KGxJKF3iT5Vs6ghDv4CQeJENYuMDIBLTTpNHcNFGLceb7T8jIz/Rhwhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=wjFYq8Z2SLVpBfxAH/TUtSiilAAHjbV9+NKwd4o6ZK8=;
	b=JKDfy/ypc7cVTk1JlSkEhbKjujrFq2RRJ1HdZ7S3kMGYaA2zx1zhZiy7SkwB6RgnP6ng
	 ftCw4mNKYHOQ6aykJzH0QkkLVtpJfaO/7bRU//5iWurJnbqWUgGvBAQgBDw3Qi0gAWdGc
	 hL3Yda8aEeCguEKtha7RqU6r0NUo43iWYg7/OGUMN+bnWAB/MddaKWwUdO5wvqPRQICa/
	 C18hJWZOLe7EHYIAuSqxBtlwejGUBsMhdShzC2Pv8NGEv7l7FW9AqP90c1a/AT9dMOZ9p
	 gYwlZmivxG0zcKqVKjhxCcZ4pyp4rjAEtwncs5NVsQVHE4ZKxeUL7TTKPtk2unyyxcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m2xWgeeJ;
	arc=none smtp.remote-ip=74.125.225.132
Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942F606A32A
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C942F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m2xWgeeJ
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-4a1efc90eb9so1269005e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270476; x=1794875276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wjFYq8Z2SLVpBfxAH/TUtSiilAAHjbV9+NKwd4o6ZK8=;
        b=m2xWgeeJ3FqizonadziCWHJWQSXt3c8e7gs3B6uOMeVqNhXSnuD3yNcBmthN5RWNan
         LR0Lu1eFKPPEg6FMjAdY56jICwKQTKdQOj9lzC0m+TvEFPVLASyUduOMlzN4WdiAng4Q
         0a979zNCRP+eMmtqW8+Hfyvty6xiMHOSR4aJzSdHQQVtgNkpv9HRjTEDd7WX306++O1S
         IF5F6IqjTGxBKqAZvlQh8ccTR8FuwTRYIhMJt2KvQ8xfyuzoaMS3fOrzxUTtO1cqIj4V
         +5Ben03N0j+pq9uXoLNnzhnmNrlCampfkCOmUjHyT6pFy9HuKB9D3S07CDFKIBHxSHjU
         I/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270476; x=1794875276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wjFYq8Z2SLVpBfxAH/TUtSiilAAHjbV9+NKwd4o6ZK8=;
        b=Dgcu6NB4a9I6adULonMVtrzsSw8gjOSU70zb42swmx9l3s4EufkiK9RxWvOxUONKJn
         /9St0wclDQaAPUqX02RVCYvZyGek2EHa+6fLSGFjLha/jyjR+mNNnXb5lWdgMFoHNwy4
         F6+sSmLKfmetBgTnu5tLFHebJ6CcVN8UsBm+Dal+Mgn61Yydmi+5oGdo5zbgXMMoYvZk
         bURDVq4BSJG71WWiAeO2xaPEgB6/+b3bOORBw4vCKWdpVWvsuVqhH1pb6/gD9GXut1RH
         x4kzMP9ZKAwUtQsT09/xj2H8IGkhiOQI80zxwplYi6qtIMaZCXJp4sVarTNqQH+pqVzM
         wYeA==
X-Gm-Message-State: APuU4Z9lDkW5M3GoC87A/vr9Re5QzEEWElihlCn/HCloF4ualUce14l/
	KwmlzUxgkmkrrPFNlo4n4ugJhJldqZ5sIrly9TDT79awax1d8Dk9oWdBXEQSOPb9
X-Gm-Gg: AYBFou0XANTX/D12KUEV0x6euq2ylxKeRHbsCSopy+DoXlJFZ3fn7n7ykFpX5+ET9AV
	xhOVGTyYGwCG3QzDsZJbSyfGmOHlkF6o9gnPbEqmuZM8BBrKKnoul+8pzZfOYBcYSv7BqxdtqOG
	ZBCN+zb316BrxHVg8dARD/NOdJKzCbFml8rv0FdylQurn1YwNsIM37NNeMayrG+6mKAmn7KgGYi
	NR47EHFNAUTIzQBefRqCEn1xstegGMt2EkgNG6oeavVjPHcV4yZoQp+9E2lJI//uPe5sWhovMLS
	ieMgYsQh+KyB6/ElPHQF7jNlEMOQ+iWtRsk5dmQmxf9JYQvZ/SaEaNM2rAyh472hQWEYiHRTqTM
	6S542cDryhHrMftb8I6QHwWRKr/2KEvhEPsi24ho3dHjJItdRpsNy06ve7ILGNtS5NVN3VjCCXw
	KRIKL07WSAxOXpMY/NP+QKflVAOVN/kHm+RiezUfNDuasDXMe/F1+eTQd4z+spDQdhV4cClXNuZ
	QMpvPomXV7591DJI/AgJ96pHx/e1V+cS5PzOSZswZ3VdNj14AU66UTS7UW/XydZHCbRs96V2KCP
	AfMC9eUFcH02Azrejlzffn/YMBQgpGtEoPxLnwQmRELZ3BgVLFbLTdn1foyd7ja7lLb8lpRSftn
	1sZpDG7UrYV15V3TuyUgOBsI82d53mVtD8wxI3vI6CS1W6O6rrbvmqr5WpjBqdc6SPDKF
X-Received: by 2002:a05:600c:5249:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4ba0234d88amr13678245e9.13.1794270476154;
        Mon, 09 Nov 2026 16:27:56 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba022ff5c3sm10068725e9.0.2026.11.09.16.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:27:55 -0800 (PST)
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
Subject: [PATCH bpf-next v1 05/20] bpf: Verify a function that parks in the context of its caller
Date: Tue, 10 Nov 2026 01:27:27 +0100
Message-ID: <6ee2f1d3ec2a6c12e2e368d5612c3c301360811c.1794269506.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7040; i=memxor@gmail.com; h=from:subject:message-id; bh=AVTvf01k1xctKe95cYGSFCNahpsQhG1+eSEqsW2eBYA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTokuU9I8bak77eD2m/W9693Nel+oGY43WdacX3bsRX uCUvKa9o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABP5NZeRoXdTaKFC7Nvby1S6 pnvs7bebMXsWu+SCnVvf+8Xk7jRcKMHw32dVwuLat/MvNzDtuWjMkvzcOklh1gflWR37VsaL/qj OYAMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A static function is verified on its own when what it does depends on
its arguments only: it gets a state with the function as frame 0, and
bpf_flow_return() applies the states at its exits to every call that
waits for it. The frames of its callers are not in that state. The
rules of bpf_task_park() look at frames. The park is refused when a
frame is a callback or holds a live dynptr or iterator, and it
invalidates in every frame what the sleep may free. In a function that
is verified on its own they see the function alone, so its caller keeps
a hash map value across the park, and a callback gets to park by
calling a function that does.

Verify such a function in the context of its caller, the way a function
that changes packet data is. func_is_on_its_own() refuses a function
that has the might_park mark, so its frame is set up on top of the
caller's and the park finds every frame in the state.

The mark is not enough when the program has callx. The CFG pass gives
the mark to the function that loads an address, not to the one that
calls it, so a function that calls an address it got from its caller
has no mark and is verified on its own. For that, record the park in
the state. invalidate_regs_across_park(), which the park and the call
of a global function that parks both run, sets parked in the state of a
function that is verified on its own. bpf_flow_return() finds the flag
in the state at the exit, sets the mark of the function and asks for
the call to be verified in the context of the caller, as it does for
changed_pkt_data. If that caller is verified on its own as well, the
park sets the flag in its state and the same happens at its exit, one
caller at a time.

The flag is a part of what a state stands for: states that differ in it
are not joined, and neither is taken for the other.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  6 ++++++
 kernel/bpf/flow.c            |  3 ++-
 kernel/bpf/join.c            |  3 ++-
 kernel/bpf/states.c          |  3 ++-
 kernel/bpf/verifier.c        | 16 ++++++++++++++++
 5 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b304f3ebc983..39ff1359adb9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -559,6 +559,12 @@ struct bpf_verifier_state {
 	 * and their packet pointers are not in the state, see bpf_flow_return().
 	 */
 	bool changed_pkt_data;
+	/*
+	 * A function that is verified on its own parked the task. Its callers,
+	 * what the sleep takes from them and whether one of them is a callback,
+	 * are not in the state, see bpf_flow_return().
+	 */
+	bool parked;
 	/*
 	 * Not zero in a function that is verified on its own: the call that the
 	 * state at its entry came from, see bpf_flow_call().
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index c9458b3ad114..47ff2fb5f11a 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -2309,7 +2309,8 @@ static void flow_shape_ctx(const struct bpf_verifier_state *st, struct flow_shap
 
 	ctx = jhash_3words(st->in_sleepable | st->callers_unknown << 1 |
 			   st->unwound << 2 | st->changed_pkt_data << 3 |
-			   (st->active_irq_id != 0) << 4 | (st->active_lock_id != 0) << 5,
+			   (st->active_irq_id != 0) << 4 | (st->active_lock_id != 0) << 5 |
+			   st->parked << 6,
 			   st->acquired_refs, st->active_locks, 0);
 	ctx = jhash_2words(st->active_preempt_locks, st->active_rcu_locks, ctx);
 	ctx = jhash_2words(lower_32_bits((unsigned long)st->active_lock_ptr),
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index cc4494aef187..8bd92af087c0 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -532,7 +532,8 @@ static bool join_check_state(const struct bpf_verifier_state *a,
 		return false;
 	if (a->speculative != b->speculative || a->in_sleepable != b->in_sleepable ||
 	    a->callers_unknown != b->callers_unknown ||
-	    a->unwound != b->unwound || a->changed_pkt_data != b->changed_pkt_data)
+	    a->unwound != b->unwound || a->changed_pkt_data != b->changed_pkt_data ||
+	    a->parked != b->parked)
 		return false;
 	if (a->active_locks != b->active_locks ||
 	    a->active_preempt_locks != b->active_preempt_locks ||
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index efc0870b85c2..f75161423377 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -745,7 +745,8 @@ bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state
 	if (old->in_sleepable != cur->in_sleepable)
 		return false;
 
-	if (old->unwound != cur->unwound || old->changed_pkt_data != cur->changed_pkt_data)
+	if (old->unwound != cur->unwound || old->changed_pkt_data != cur->changed_pkt_data ||
+	    old->parked != cur->parked)
 		return false;
 
 	if (!refsafe(old, cur, &env->idmap_scratch))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d8fbdd6b9658..8edc32153226 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1792,6 +1792,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->callers_unknown = src->callers_unknown;
 	dst_state->unwound = src->unwound;
 	dst_state->changed_pkt_data = src->changed_pkt_data;
+	dst_state->parked = src->parked;
 	dst_state->flow_entry = src->flow_entry;
 	dst_state->insn_idx = src->insn_idx;
 	dst_state->curframe = src->curframe;
@@ -11337,6 +11338,9 @@ static void invalidate_regs_across_park(struct bpf_verifier_env *env)
 		bpf_diag_record_scrub(env, reg, BPF_DIAG_MOD_TASK_PARK);
 		mark_reg_invalid(env, reg);
 	}));
+	/* the frames of the callers are looked at when the function returns to them */
+	if (env->cur_state->flow_entry)
+		env->cur_state->parked = true;
 }
 
 static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env)
@@ -11757,6 +11761,9 @@ static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_verifier
 	if (sub->changes_pkt_data || sub->has_tail_call || sub->has_ld_abs ||
 	    sub->is_cb || sub->is_async_cb || sub->is_exception_cb)
 		return false;
+	/* a park looks at every frame, and takes from each what the sleep may free */
+	if (sub->might_park)
+		return false;
 	if (state->speculative)
 		return false;
 	if (sub->releases_inherited &&
@@ -11936,6 +11943,15 @@ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *cal
 		env->subprog_info[callee->subprogno].changes_pkt_data = true;
 		return 1;
 	}
+	/*
+	 * Likewise for a park behind such an address. It was checked against the frames
+	 * of the function only: which caller is a callback, and what the sleep takes
+	 * from each, is found out in the context of the caller.
+	 */
+	if (exit->parked) {
+		env->subprog_info[callee->subprogno].might_park = true;
+		return 1;
+	}
 
 	for (i = 0; i < CALLER_SAVED_REGS; i++)
 		bpf_mark_reg_not_init(env, &frame->regs[caller_saved[i]]);
-- 
2.53.0

