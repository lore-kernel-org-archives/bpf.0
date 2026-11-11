Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401869;
	b=odg6bf0tN8UQge4REhbo0UivWMlv1r3yBD30CWh9hr450wS+mO242f4RUdpQyfifwcem
	 1/ZT7S3Qbp3B1H2WXWq5juEsfZ3romeEJ5Kc5t9MLEuuYHlmzsM+M0ETxaMZh4fNBZVZY
	 ZELJ94yznTBEw2LdBzwJsy7Uj9HxRrNdf6iNm9imPN8ZZMo+0JgoUH0cgeFrVPdNXzmPF
	 g44RwqzlzD0ZAwAcHxiH4T46vHXNDA19w8hAaC+6dksTw/P34XFP/VVsgHq6lEkDUIN5o
	 mQX8iI3OolUxMNOfnj6/mD2BY2rPDF4VYFu1Rv7UnWII4DlmSj5SJ4+Jgo4kMAlKYpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=5SWpE+MosN932aitlPUXrTTrgaD/Z0rY06hGCJER2xQ=;
	b=4wQ4X1DvxeDxdoE7mSFSCz9P4D0hpy9ZJg+KDrIgafQsWss3Yy0WVMa1uYo+xj89kBko
	 6SpE7y1rNY3zhqSxzCLWaynWQhu4h0qAhXrANn/fqnVg/WqKtDNIJH1kjXKeCrRne28aW
	 BoIpn2XfzxH1MT8PIo2SWNVGvTnaJh9EEmspsB4ichdt9OR4cqT57zNoDFSJXD0yoIZSq
	 vdnENB9QiSZmp8l6lFF5qblWK/zpAGAqqnQlXu33nCxYYWy+5B7UIfBQ2aZBPUQIpLFq9
	 QnGuKqlvkGsUuGnQzraICn0O38ZK+pAoZIzTxeeR8APv6LcMPGE1qyeCpf6i0RZR5vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JGKDVNS+;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79260606A32A
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79260606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JGKDVNS+
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a5f76661b5so12385565e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401868; x=1795006668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SWpE+MosN932aitlPUXrTTrgaD/Z0rY06hGCJER2xQ=;
        b=JGKDVNS+AFsGDqz6/5froBhhR93JC9i4BikQx7uvMRyKLeZH7dKDHEFnPE6kMUZjVv
         ev6IJ5id65RieLwt/LBWNR7Bwn/0L7qdJqNyWzTERhPc9qkbhc/PJJhnIW7RXw72AZHv
         Cr9C4BSV9EudI/FXIkY51By4QkHT3ImYg7HW4beYmUs6nY8ndWMryiSg75ZCEsJ22rWC
         mnW/kBhAULWN7RTKI1EJw/+YPQRlkPDxpS+oPrE5cs4ruOqqyCNeZq27D5l08QcTOihF
         3TFPDuJulqrtA11Yn6O8BmtUs6boiy7VCII2lC8w5C1n9RLH8YoxVUKoZ4oaa1jENKuc
         lT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401868; x=1795006668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5SWpE+MosN932aitlPUXrTTrgaD/Z0rY06hGCJER2xQ=;
        b=W11w7r7cNSRxNX8P8AJFUaIuCR9OjlAVYSj9QGj5TpVhItP6vEmWhdCy6O1+Oc37r7
         C0L4Pt18ospEeZBS2cQ8SUF7vCVdkLp0+il+HOpajRO4CypeKXJhI/GY1S7m3XlelYuH
         7OtLINilnF915D6GHxyXpb2ihi2QDwFVRK2p8wvyRGnwWMkLOrIVj2jjzoZUrbd+h8dI
         CePUcAjI+Oadrrtq3KZ2oM5SyT22Otyu9tzAhzGnfmKyCBNFKjgdlO5SFLsLO5IHKgg2
         jJ2yPgWfj8w9DBQdVCkvKYk1Dk4kyEYOnx/CkSWBc3d5LRvs6tMkbHXYxUs0igC9cL8V
         ZJiw==
X-Gm-Message-State: APuU4Z+tNoe9tyJ4MtOJAUNMfKoWsOvrwZzuYW3ebJaW+8cu9M8gDu3V
	1EWhyf5yfBHICn9RRdD394RH9fcBxfbRvvBLqIxm/ypk60Lj2rZ5n5f0+i4/3NPuUWw=
X-Gm-Gg: AYBFou36RcUTbJJAU/+T90unqL3hx+wsIGZRf4fZXMW6L/YHxaVnxfCz3vbd24RuZUD
	20T6xU/6qMV50kfZlD//aDXiaiZAXBbpL+IlXgTtInIM4RZu5Mwf0tqOuViKzqyH+tX5n4LwKDK
	xw1aUQgs9MrQHX1JnmgG2ZWW49a9rI8P42KrVMg2PI0aN7GnIY7OdJgsL6YzZMO7aqYh1guYJk8
	Hrcp3tzaumxGIXo18KebpznbgqdTd34wtQGagqsn8kEkhdivrFnPuyvCIB4i0dXz+3lBdOajP/v
	cNfLaLGkNPxJJJ+bJVGeCcOWmrWYjtkYGhZhX3lDWGTAdtn+IroDOcnnTx1HYx3S3HLVPFGPHmD
	akAtS3bs9aqgcFsXie7hNfc5Xzk90XAji57WVMXaYt8jrYXN4+rCrQFmhIYcRHKERUFWtkwIute
	IUs5GfGHEdBEvLcq2V7kX4Idb8Jn+pmS5hqj84OTYJrb0u7qWFehtO5Uh7e9XTk3NonLWH4VKEh
	/MHTfe3y/wCXp+sHmlOI9AJbzfAfXwLPu8knWpsRnwcqH5iEmYimvY9Regk/gFIHeCwpPuIy3MO
	DBKJrUkIDD1BZPT6yjIgivvfhEvQ2kEPBsvqSAvZhUagsJKS28cxYOViySVyLuSa9eRERXNgwl9
	h0jvjn00oLPb21IcEQUwXfqW1ngeVa/wZPbBkQUoGSD7f3gk2gXrABJDivRI+oINBNmza
X-Received: by 2002:a05:600c:1548:b0:4a7:669c:c988 with SMTP id 5b1f17b1804b1-4ba09383873mr44906595e9.23.1794401867793;
        Wed, 11 Nov 2026 04:57:47 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365ccbccsm11219494f8f.44.2026.11.11.04.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:47 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 11/29] bpf: Give every reference an owner frame
Date: Wed, 11 Nov 2026 13:57:09 +0100
Message-ID: <d69e383da887f124f305006c9c0c2d56b39c7145.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6577; i=memxor@gmail.com; h=from:subject:message-id; bh=Ti0Y4Nbnu1NBxBLsRCmL965V2Yx9mZ28dBYIsFW7k/M=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzPwD/2vmMdnqT9ZqrfqdcFh7hu6uzXqh5/W+86TXX 2y2C5ndUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIm83cfIMP1v9A/Ljw9c3+Qf v/C+TNgm8nS2mI79Z3+2I7ef8his42ZkmCfpJ/tKdtJ+W2dn1t9GjuX3Si0DFMKMpBXfvxYzFVn JAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The unwinder will release the resources of each frame from that frame's
own stack slots. Each reference in the verifier state must therefore
belong to exactly one frame. The verifier has no such notion today: the
state holds the references, and a frame only knows how many of the
references held at its entry are still held.

Record the owner frame in the reference state:

 - The frame that acquires a reference owns it.
 - When a frame returns, the references it still holds pass to its
   caller, which is the only frame left that can release them.
 - A function that is verified on its own inherits the references of its
   callers without their frames, see call_func_on_its_own(). No frame of
   the state owns these inherited references, so their owner is -1.
   References that the function returns with, beyond the inherited ones,
   pass to the caller when the call is resumed in bpf_flow_return().

Callbacks release everything they acquire, so nothing changes owner when
a callback returns, and the transfer in prepare_func_exit() has nothing
to do for them.

RCU read and preemption disabled sections have no reference state. The
verifier tracks, per frame, how many of the sections held at its entry
are still held, and release_context_state() lowers that count on every
unlock. A frame that left a section of its caller therefore looks like a
frame that was entered with fewer sections. Also count how many sections
each frame released below its entry count, so that the exit of the frame
can tell that it returns with fewer sections than it was called with.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 13 +++++++++++++
 kernel/bpf/verifier.c        | 22 ++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7a2b6507f562..c18efe4bd54a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -327,6 +327,12 @@ struct bpf_reference_state {
 	 * is used purely to inform the user of a reference leak.
 	 */
 	int insn_idx;
+	/*
+	 * The frame that owns the reference: the one that acquired it, or the
+	 * caller a returning frame handed it to. -1 for what the callers of a
+	 * function verified on its own hold, which are not in the state.
+	 */
+	s8 frameno;
 	union {
 		/* For REF_TYPE_PTR */
 		int parent_id;
@@ -503,6 +509,13 @@ struct bpf_func_state {
 	u32 entry_refs;
 	u32 entry_rcu_locks;
 	u32 entry_preempt_locks;
+	/*
+	 * How many of the RCU read and preemption disabled sections held when the
+	 * frame was entered it left, or a callee of it did: a frame that returns
+	 * after that is in fewer sections than it was called in.
+	 */
+	u32 rcu_released_below;
+	u32 preempt_released_below;
 
 	/* The following fields should be last. See copy_func_state() */
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0684ac1f4f22..6c71ceb1dd4c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1545,6 +1545,7 @@ static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_e
 	if (err)
 		return NULL;
 	state->refs[new_ofs].insn_idx = insn_idx;
+	state->refs[new_ofs].frameno = state->curframe;
 
 	return &state->refs[new_ofs];
 }
@@ -1625,7 +1626,11 @@ static void release_reference_state(struct bpf_verifier_state *state, int idx)
 	return;
 }
 
-/* bpf_rcu_read_unlock() or bpf_preempt_enable() is done, see release_reference_state() */
+/*
+ * bpf_rcu_read_unlock() or bpf_preempt_enable() is done, see release_reference_state().
+ * A frame that was entered with more sections than are held now has left one of its
+ * callers', and counts that for its exit to tell.
+ */
 static void release_context_state(struct bpf_verifier_state *state)
 {
 	struct bpf_func_state *frame;
@@ -1633,6 +1638,11 @@ static void release_context_state(struct bpf_verifier_state *state)
 
 	for (fr = 0; fr <= state->curframe; fr++) {
 		frame = state->frame[fr];
+		if (frame->entry_rcu_locks > state->active_rcu_locks)
+			frame->rcu_released_below += frame->entry_rcu_locks - state->active_rcu_locks;
+		if (frame->entry_preempt_locks > state->active_preempt_locks)
+			frame->preempt_released_below += frame->entry_preempt_locks -
+							 state->active_preempt_locks;
 		frame->entry_rcu_locks = min(frame->entry_rcu_locks, state->active_rcu_locks);
 		frame->entry_preempt_locks = min(frame->entry_preempt_locks,
 						 state->active_preempt_locks);
@@ -11709,6 +11719,8 @@ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog, int i
 		entry.refs[i].id = inherited_id(state, entry.refs[i].id);
 		if (entry.refs[i].type == REF_TYPE_PTR)
 			entry.refs[i].parent_id = inherited_id(state, entry.refs[i].parent_id);
+		/* the frames that own what is inherited are not in the state */
+		entry.refs[i].frameno = -1;
 	}
 	entry.active_irq_id = inherited_id(state, entry.active_irq_id);
 	entry.active_lock_id = inherited_id(state, entry.active_lock_id);
@@ -11878,11 +11890,12 @@ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *cal
 		reg->parent_id = fresh_id(env, idmap, reg->parent_id);
 		reg->map_uid = fresh_id(env, idmap, reg->map_uid);
 	}
-	/* those that were held are the first */
+	/* those that were held are the first; what the function took is the caller's now */
 	for (i = nheld; i < caller->acquired_refs; i++) {
 		caller->refs[i].id = fresh_id(env, idmap, caller->refs[i].id);
 		if (caller->refs[i].type == REF_TYPE_PTR)
 			caller->refs[i].parent_id = fresh_id(env, idmap, caller->refs[i].parent_id);
+		caller->refs[i].frameno = caller->curframe;
 	}
 	caller->active_irq_id = fresh_id(env, idmap, caller->active_irq_id);
 	caller->active_lock_id = fresh_id(env, idmap, caller->active_lock_id);
@@ -12688,6 +12701,11 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		return err;
 	invalidate_stack_slices(env, callee->frameno, INT_MIN, 0);
 
+	/* What the frame holds when it returns is the caller's to release. */
+	for (i = 0; i < state->acquired_refs; i++)
+		if (state->refs[i].frameno == callee->frameno)
+			state->refs[i].frameno = caller->frameno;
+
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
 	 * there function call logic would reschedule callback visit.
 	 */
-- 
2.53.0

