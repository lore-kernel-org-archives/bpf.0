Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401884;
	b=T8M4Ia/wmHawRSKg0fh+YcPiJofsVa4jvEyNsLGL8qNpxyJaNpOueFyKI5LIR2qrqTyZ
	 wXJ362jGcwK3Se7oUiyZ8FwPy+tSgRkTQQBbZc6l71SwIY6nJCkfnEauoCtF66YRo752o
	 OrXOSZRNd/5LouY/Gb/MDgF0sJRaNxgZjORxTS8cjTVA+vKokf2gsmcrBdvH1d/2MmUyC
	 Js9aAY5UZVCXHpmmjL6SKPbshvcjx18rLZHTXJYJGHppUGG+CbKMsoymaDluTNuMRODAQ
	 bX6Cww7USjFjDYqpGr3wZPJeY0a5j+3oY4GC8bHA1obCnTtN7A0pZ2zcNpec03dxZrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=VD//wdl80ZreiFRGL/ywagr0iKKaa+qqmd2JhN96wQY=;
	b=Mt7scstk1NAHdfYDjl3o7ZeRLln7Lez6BLwHcVd61+oQ9vOFBiubY91o33DfmhCcF7/k
	 7qz7HuYoJ98+F/QsDwYKO0LoqPHc3SZB1fNPMWIgMq23Q7Xu2/HupDgp5ZM8HbUZDO7oS
	 R/n2KYOkvI7emjxMSttPDhoZdv6biW0kXoTPXln+KjBu9i1a95y45ba3xRF52SkZSRLhP
	 nFWIlA6qUCPgzUnoSpOXJCOv2/L7uj6158qGCAf2pERPayYm1fX0NXxyYayryrKGr6g/2
	 awHo7ViDBH11zylPG6mi6dFGVypMvaEqy/rFgTXE9YyI1h5MEFiDnNSstTtwoPsM8ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=swK7OjcW;
	arc=none smtp.remote-ip=74.125.225.73
Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8ED606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A8ED606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=swK7OjcW
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-48fbf6c2d2eso225401f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401883; x=1795006683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VD//wdl80ZreiFRGL/ywagr0iKKaa+qqmd2JhN96wQY=;
        b=swK7OjcWd0MRjPN5TsfTm6tgWFYBdkTutgvg+qA3kE8lKR2LxXUcioD2fbXmSlAjev
         OKchZGvhhvw+9J3NOVXB4ExPgnbRpG6CFtC0tzI+43Ck9PXIK7288AP3x5qqBH6Z9I0P
         OaytoW/Foq75dk/0i8zuXHiBWnXgdpWVcvKX95jYUosA29tOxDAaPrusY6zoA2q2NWqA
         Uvc/qjuDMuOby6aEWKts3l+3RdEWC1c/cot1IIYloSXUPoP4dRMhERBYOo3BPJCgNRKa
         PPgOp3iIckKscu86rs1ePIfXkKzkAmRfgfjABXGd/pD1j55/EEr0MRzOIscPHQcBmlrF
         EmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401883; x=1795006683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VD//wdl80ZreiFRGL/ywagr0iKKaa+qqmd2JhN96wQY=;
        b=FKvu5YOGXww1CEvhL9TmfG9RQRrlnZp0QxDJbG957rNqlzeebSOc0fcF7paFN8DHsg
         qVg64Rsch8ubG9g5YY3TY78H62MDba2iVGAdN2DkE82au3Wx5WZiE8p3zeOYU4lETq1Y
         VGgA7MyhhNZsLcqDf67g/D5LhSA3JTu8/0Ghf2yT31VVG5scsz59Nm8i6LBT5J+s68/g
         9Xc9uz3OF8txMTlOWn/2R7LGv96l/y6W0covYEerXkGOutn3zLoBlnDY+d20BkpOiDVT
         kBjfUSUwDR3NN1My2JhV1CuNVNM+egJD1R5bq2mxzrNBtvnwGMVSYH3PSUN7IJ38mpPG
         kCDw==
X-Gm-Message-State: APuU4Z8q5NGHuKlORt21qGoJCpAz1ni1CuakzjDqaTc2N1J5pnWONFa4
	S8xTS3s1OEvOzJe8PMjmaQVOYFn19OG3+n4j93CoJ6ZNHUX8pWZ0pubZ88tv9DDMp/I=
X-Gm-Gg: AYBFou2hCsjzlUUlOh1EOvMX4lXgshG3qNgxun9x0SOnO8fqK9Cg72t+HinZXUqk0Ub
	XyeWSuId4eoHuBZy45oohM9hJl82CQC1BzGX0uqoACK01xiokDTtO8UUXUdJsP5JUsT+KTxF4dA
	Z8Uc2tENiIl8RsAohM8Gs3vPjP7+2pMQcyQFp+4h10gfxJnh27+EoLftg/zNW/lC6I4KJ6H2e4K
	ElCCz9nrI31gfuAAgQXC4DFDlVcxwmu/1KFgmQ+0M45S40eXkqrO/EcjZL49wVgw2xDN1fCEj0A
	MHtlLq/OJToZZZZz/L9Mnjsm138x8zd7pMAFN9Xn+R674PkrS2rI/qelrfm7SMmHm63nwhYAIuZ
	bRhYwc83DKX/CLZFI/32hFMRq862UlKkc031jGBtU2Y75jh5McuViB5peHdDPCLAQtX4JhW3O6A
	5PpvcYSiECyEFZf6TsuEhdqntQBt8XNXu7iejUFHWlAAOSsFxss5/LdEsHJSfZL4UMvR9hkFunH
	XkbF9j18E0Qc22M5ercd6U74/oAOA52EMNiIBhbje/p6/g4/J8wwvKami+GxTnxCL7YDqZ+Owf3
	CkW//x43FwT6SCA1Ai3IC/tWPZwxatUztOoCyWj7gJVQ85XQQh0ISSHwKnNFYpbSeke6EDIJl11
	OO9vozFaR+GA8VCQYHfE6TX8dsPxD67iaRyFXuqpRrQas2KSgf6Z4zhRmWVRY6Hz4H/KJ9GHRPr
	6Dq5pRjy2JAqJORA==
X-Received: by 2002:a5d:5f45:0:b0:491:9332:935a with SMTP id ffacd0b85a97d-499c3c96831mr5066172f8f.1.1794401882379;
        Wed, 11 Nov 2026 04:58:02 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4988f5b1ce3sm9298212f8f.14.2026.11.11.04.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:58:00 -0800 (PST)
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
Subject: [PATCH bpf-next v1 19/29] bpf: Allow a callee to release its caller's resources
Date: Wed, 11 Nov 2026 13:57:17 +0100
Message-ID: <94c4fd13b4c95090e159b905110781973e8e56ad.1794399387.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=17434; i=memxor@gmail.com; h=from:subject:message-id; bh=YuxRT6TiRmMljrUPUOJFvBKR5mXf2ZfCV8AbY0ADaUk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzCJm051/Lq2WXOL6fVPjT7754Vu9Ew64LU6J+FNnU 5JSmuzRUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInsfMLwz/yjovbt47deMB55 uSlxwqovRseClV5wbFuZl80U/H6rWS7D/5KgyIO1K8T0hdK6VBtaxYpb1n/pE0jqzuO5dOXdOwl OLgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently a program that throws is rejected when a callee releases a
resource held by its caller. The handle could be in a hidden slot of the
caller, and the callee does not know where that slot is.

Handle the two cases separately.

If the resource has no hidden slot, nothing needs to be cleared. A site
of the caller describes the resource if every visit finds it held, and
omits it if none does.

If the resource has a hidden slot, the callee cannot clear it, but the
caller can, before the call. This is correct when the slot is not needed
from the call on:

 - the resource is released on every return from the call, and
 - no throw finds the caller holding it at the call. That is, the callee
   does not throw before it releases the resource.

For each call to a subprog and each acquisition of the caller, record
whether a frame above the caller released the resource during the call,
and whether any return from the call found the caller still holding it.
After the pass, a resource with a hidden slot that a callee releases has
the slot cleared before every such call. The program is rejected if one
of these calls does not allow it.

A subprog that releases resources of its callers must be verified in the
context of each caller, so that a throw sees the frames below it as they
are. The verifier normally learns this when the subprog returns, but a
subprog that throws after the release never returns. So mark the
functions between the owner and the releasing frame at the release
itself.

Setting the mark invalidates what the current round of the main pass has
recorded so far: the frames of the callers at the call, still holding
their resources. So the round is run again when a mark is set, see
do_check_all().

This allows a subprog that unlocks a lock of its caller, and one that
releases a resource that the caller's sites describe.

Still rejected, for a resource that the caller keeps in a hidden slot:

 - a callee that may throw before it releases the resource;
 - a callee that releases the resource only on some paths;
 - a callback that releases the resource, since its helper may never
   call it;
 - a callx to a subprog that releases the resource.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  23 +++++
 kernel/bpf/frame_desc.c      | 158 ++++++++++++++++++++++++++++++++---
 kernel/bpf/verifier.c        |   6 +-
 3 files changed, 173 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9a0ea25ab5c2..a98023c239c4 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1278,6 +1278,7 @@ struct bpf_res_acq {
 	s16 off;	/* the slot, relative to R10 */
 	bool held;	/* some frame holds what it acquired at a site */
 	bool slot;	/* and some site cannot say where: the handle is kept in a slot */
+	u32 foreign;	/* an insn of another frame that releases what it acquired, plus one */
 	/*
 	 * An insn, plus one, that leaves what it acquired with another frame
 	 * than the one that ran the acquisition: the call a subprog returns
@@ -1341,6 +1342,20 @@ struct bpf_res_rel {
 /* The call takes the handle in different ways on different paths. */
 #define BPF_RES_REL_DIFFER	3
 
+/*
+ * A call of a subprog during which a frame above the caller releases what an
+ * acquisition of the caller acquired. The caller clears its slot in front of
+ * the call when no throw finds it holding the resource there and no return
+ * from the call does, see frame_desc.c.
+ */
+struct bpf_res_call {
+	u32 insn;	/* the call; U32_MAX when the caller is not in the state */
+	u16 acq;	/* index of the acquisition */
+	bool released;
+	bool held_after; /* some return from the call finds the caller holding it */
+	bool clear;	/* decided once the pass is over */
+};
+
 /* A call that enters or leaves a section, for the count of its frame, see frame_desc.c. */
 struct bpf_section_insn {
 	u32 insn;
@@ -1390,6 +1405,8 @@ struct bpf_verifier_env {
 	u32 res_rel_cnt;
 	struct bpf_section_insn *section_insns;
 	u32 section_insn_cnt;
+	struct bpf_res_call *res_calls;
+	u32 res_call_cnt;
 	struct bpf_res_site *res_sites;
 	u32 res_site_cnt;
 	struct bpf_res_loc *res_locs;
@@ -1402,6 +1419,12 @@ struct bpf_verifier_env {
 	bool describe_frames;			/* frame descriptors are generated: the program may throw */
 	bool describe_regs;			/* and may name registers, see bpf_arch_throw_entry() */
 	u16 frame_desc_regs;			/* the registers that some site names */
+	/*
+	 * The round of the main pass found out that a subprog releases what
+	 * its callers hold: they are recorded differently then, so the round
+	 * is done again, see do_check_all().
+	 */
+	bool frame_desc_redo;
 	int exception_callback_subprog;
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
index 9854be9ab478..d2ad02925f06 100644
--- a/kernel/bpf/frame_desc.c
+++ b/kernel/bpf/frame_desc.c
@@ -34,8 +34,9 @@
  * A slot belongs to one frame and holds one handle, so a program that throws
  * keeps to what that can express:
  *
- *  - A frame releases what it acquired itself. A callee cannot reach the
- *    slot of its caller, so it may not release what its caller holds.
+ *  - A callee cannot reach the slot of its caller. What it releases of its
+ *    caller's has no slot, or one the caller can empty in front of the
+ *    call, see foreign_release().
  *  - A slot goes with its frame. A reference a subprog returns in R0 is
  *    acquired by the call for the caller, like the call of a kfunc that
  *    returns one.
@@ -689,12 +690,76 @@ static int rel_add(struct bpf_verifier_env *env, u32 insn, u16 acq, u8 reg, u8 f
 	return 0;
 }
 
+/*
+ * What the call @insn of a subprog means for what acquisition @acq acquired
+ * is noted in the record of the two, see struct bpf_res_call. NULL when there
+ * is no memory for one.
+ */
+static struct bpf_res_call *call_note(struct bpf_verifier_env *env, u32 insn, u16 acq)
+{
+	u32 i, cnt = env->res_call_cnt;
+	struct bpf_res_call *c;
+
+	for (i = 0; i < cnt; i++)
+		if (env->res_calls[i].insn == insn && env->res_calls[i].acq == acq)
+			return &env->res_calls[i];
+	c = kvrealloc(env->res_calls, array_size(cnt + 1, sizeof(*c)), GFP_KERNEL_ACCOUNT);
+	if (!c)
+		return NULL;
+	c[cnt] = (struct bpf_res_call) { .insn = insn, .acq = acq };
+	env->res_calls = c;
+	env->res_call_cnt = cnt + 1;
+	return &c[cnt];
+}
+
+/*
+ * The current insn releases @ref, which a frame below the current one owns.
+ * Nothing tells a callee where the slot of its caller is, so it cannot clear
+ * one. There are two ways out:
+ *
+ *  - What the caller holds without a slot needs none cleared: its sites say
+ *    where the handle is on the visits that find it held, and say nothing on
+ *    those that find it released.
+ *  - The caller clears its slot in front of the call when the callee releases
+ *    the resource on every path and no throw finds the caller holding it at
+ *    the call, see bpf_frame_desc_resolve().
+ *
+ * The functions between the owner and the current frame are verified in the
+ * context of their callers from now on, so that every throw sees the frames
+ * below it as they are. The round of the main pass that finds one out is done
+ * again, since it recorded the frames of its callers at the call, holding
+ * what they held then.
+ */
+static int foreign_release(struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
+			   const struct bpf_reference_state *ref, struct bpf_res_acq *acq)
+{
+	const struct bpf_func_state *below = st->frame[ref->frameno + 1];
+	struct bpf_subprog_info *sub;
+	struct bpf_res_call *c;
+	int f;
+
+	for (f = ref->frameno + 1; f <= st->curframe; f++) {
+		sub = &env->subprog_info[st->frame[f]->subprogno];
+		if (sub->releases_inherited)
+			continue;
+		sub->releases_inherited = true;
+		env->frame_desc_redo = true;
+	}
+	if (!acq->foreign)
+		acq->foreign = env->insn_idx + 1;
+	c = call_note(env, ref->frameno < 0 ? U32_MAX : below->callsite, ref->acq - 1);
+	if (!c)
+		return -ENOMEM;
+	c->released = true;
+	return 0;
+}
+
 /*
  * Record that the current insn releases the resource refs[@idx], before it
  * is released: its handle, in the argument the call releases, see
  * bpf_verifier_env::release_regno, leaves the slot of its acquisition in
- * front of the call. A frame releases what it acquired itself: nothing tells
- * a callee where the slot of its caller is.
+ * front of the call. That is so for what the frame holds itself: nothing
+ * tells a callee where the slot of its caller is, see foreign_release().
  */
 int bpf_frame_desc_record_release(struct bpf_verifier_env *env, int idx)
 {
@@ -703,7 +768,7 @@ int bpf_frame_desc_record_release(struct bpf_verifier_env *env, int idx)
 	const struct bpf_func_state *frame = st->frame[st->curframe];
 	u32 i, insn = env->insn_idx;
 	int regno = env->release_regno;
-	const struct bpf_res_acq *acq;
+	struct bpf_res_acq *acq;
 	u8 flags = 0, bad = 0;
 	s16 adj = 0;
 
@@ -719,12 +784,9 @@ int bpf_frame_desc_record_release(struct bpf_verifier_env *env, int idx)
 	}
 	if (!ref->res)
 		return 0;
-	if (ref->frameno != st->curframe) {
-		verbose(env, "frame_desc: insn %d releases what another frame holds, which is not supported in a program that throws\n",
-			insn);
-		return -EINVAL;
-	}
 	acq = &env->res_acqs[ref->acq - 1];
+	if (ref->frameno != st->curframe)
+		return foreign_release(env, st, ref, acq);
 	/* what insns could not compare with a slot matters when there is a slot only */
 	if (regno < BPF_REG_1 || regno > BPF_REG_5) {
 		regno = BPF_REG_FP;
@@ -781,6 +843,8 @@ int bpf_frame_desc_record_exit(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state *st = env->cur_state;
 	const struct bpf_func_state *frame = st->frame[st->curframe];
+	struct bpf_res_call *c;
+	int i;
 
 	if (!env->describe_frames || st->speculative)
 		return 0;
@@ -791,6 +855,17 @@ int bpf_frame_desc_record_exit(struct bpf_verifier_env *env)
 								       frame->rcu_released_below,
 					       st->active_preempt_locks != frame->entry_preempt_locks +
 									   frame->preempt_released_below);
+	/* does the caller hold after the call what a callee may release in it? */
+	if (!st->curframe || !env->subprog_info[frame->subprogno].releases_inherited)
+		return 0;
+	for (i = 0; i < st->acquired_refs; i++) {
+		if (st->refs[i].frameno != st->curframe - 1 || !st->refs[i].acq)
+			continue;
+		c = call_note(env, frame->callsite, st->refs[i].acq - 1);
+		if (!c)
+			return -ENOMEM;
+		c->held_after = true;
+	}
 	return 0;
 }
 
@@ -1052,6 +1127,9 @@ void bpf_frame_desc_reset(struct bpf_verifier_env *env)
 	env->section_insn_cnt = 0;
 	env->res_site_cnt = 0;
 	env->res_loc_cnt = 0;
+	env->res_call_cnt = 0;
+	env->frame_desc_redo = false;
+	/* that the subprogs release what their callers hold stays */
 	for (i = 0; i < env->subprog_cnt; i++)
 		env->subprog_info[i].section_delta = 0;
 	for (i = 0; i < env->prog->len; i++) {
@@ -1067,12 +1145,14 @@ void bpf_frame_desc_env_free(struct bpf_verifier_env *env)
 	kvfree(env->section_insns);
 	kvfree(env->res_sites);
 	kvfree(env->res_locs);
+	kvfree(env->res_calls);
 	kvfree(env->resources);
 	env->res_acqs = NULL;
 	env->res_rels = NULL;
 	env->section_insns = NULL;
 	env->res_sites = NULL;
 	env->res_locs = NULL;
+	env->res_calls = NULL;
 	env->resources = NULL;
 }
 
@@ -1150,6 +1230,43 @@ static int emit_acquire_after(struct bpf_insn *buf, const struct bpf_res_acq *a)
 	return cnt;
 }
 
+/*
+ * A frame above the one that holds what acquisition @acq acquired releases it,
+ * and the acquisition has a slot. The holder can clear the slot itself, in
+ * front of the call the release happens in, when the resource is gone after
+ * every such call and no throw finds the holder with it at the call: the slot
+ * is empty then for as long as the callee can throw after the release, and it
+ * was no use before it. The call is one of a subprog: a helper that calls a
+ * callback may not call it at all, and the holder has the resource after it
+ * then.
+ */
+static bool foreign_cleared(struct bpf_verifier_env *env, u16 acq, const u32 *new_of, u32 orig_len)
+{
+	bool any = false;
+	u32 i, j;
+
+	for (i = 0; i < env->res_call_cnt; i++) {
+		const struct bpf_res_call *c = &env->res_calls[i];
+
+		if (c->acq != acq || !c->released)
+			continue;
+		if (c->held_after || c->insn >= orig_len)
+			return false;
+		/* a helper may never call the callback that releases */
+		if (!bpf_pseudo_call(&env->prog->insnsi[new_of[c->insn]]))
+			return false;
+		for (j = 0; j < env->res_loc_cnt; j++)
+			if (env->res_locs[j].acq == acq &&
+			    env->res_sites[env->res_locs[j].site].insn == c->insn)
+				return false;
+		any = true;
+	}
+	for (i = 0; any && i < env->res_call_cnt; i++)
+		if (env->res_calls[i].acq == acq && env->res_calls[i].released)
+			env->res_calls[i].clear = true;
+	return any;
+}
+
 /*
  * Acquisition @acq needs a slot. Can the insns that keep it be emitted? They
  * are emitted once per insn, so the insn has to acquire in one way, with the
@@ -1264,6 +1381,12 @@ int bpf_frame_desc_resolve(struct bpf_verifier_env *env)
 			ret = -EINVAL;
 			break;
 		}
+		if (a->foreign && !foreign_cleared(env, i, new_of, orig_len)) {
+			verbose(env, "frame_desc: insn %d releases what another frame holds in a hidden slot, which is not supported in a program that throws\n",
+				a->foreign - 1);
+			ret = -EINVAL;
+			break;
+		}
 		/* some visit of the insn has nothing a slot can hold where this one has */
 		if (!(a->flags & BPF_RES_F_CTX) && acquires_sometimes(env, new_of[a->insn], a)) {
 			verbose(env, "frame_desc: insn %d acquires a resource on some paths only, or one of a type that cannot be released\n",
@@ -1305,12 +1428,13 @@ int bpf_frame_desc_resolve(struct bpf_verifier_env *env)
 enum {
 	ITEM_SECTION,
 	ITEM_RELEASE,
+	ITEM_CLEAR,
 	ITEM_ACQUIRE,
 };
 
 struct res_item {
 	u32 idx;	/* insn of the current image */
-	u32 rec;	/* which section insn, release or acquisition */
+	u32 rec;	/* which section insn, release, call or acquisition */
 	u8 kind;
 	u8 reg;		/* ITEM_RELEASE: the argument the call releases */
 };
@@ -1391,6 +1515,11 @@ static int emit_items(struct bpf_verifier_env *env, const struct res_item *it, i
 			cnt += emit_release(env, buf + cnt, &it[i], k - i);
 			i = k - 1;
 			break;
+		case ITEM_CLEAR:
+			/* a callee releases what the slot holds, on every path, see foreign_cleared() */
+			off = env->res_acqs[env->res_calls[it[i].rec].acq].off;
+			buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, off, 0);
+			break;
 		case ITEM_ACQUIRE:
 			cnt += emit_acquire_before(buf + cnt, &env->res_acqs[it[i].rec]);
 			break;
@@ -1470,8 +1599,8 @@ int bpf_frame_desc_emit(struct bpf_verifier_env *env)
 	if (!env->res_acq_cnt && !env->section_insn_cnt)
 		return 0;
 	new_of = insns_of_pass(env, &orig_len);
-	items = kvcalloc(env->res_acq_cnt + env->res_rel_cnt + env->section_insn_cnt,
-			 sizeof(*items), GFP_KERNEL_ACCOUNT);
+	items = kvcalloc(env->res_acq_cnt + env->res_rel_cnt + env->res_call_cnt +
+			 env->section_insn_cnt, sizeof(*items), GFP_KERNEL_ACCOUNT);
 	if (!new_of || !items) {
 		ret = -ENOMEM;
 		goto out;
@@ -1487,6 +1616,9 @@ int bpf_frame_desc_emit(struct bpf_verifier_env *env)
 		if (env->res_acqs[env->res_rels[i].acq].slot)
 			items[n++] = (struct res_item) { new_of[env->res_rels[i].insn], i, ITEM_RELEASE,
 							 env->res_rels[i].reg };
+	for (i = 0; i < env->res_call_cnt; i++)
+		if (env->res_calls[i].clear)
+			items[n++] = (struct res_item) { new_of[env->res_calls[i].insn], i, ITEM_CLEAR };
 	for (i = 0; i < env->res_acq_cnt; i++)
 		if (env->res_acqs[i].slot && !(env->res_acqs[i].flags & BPF_RES_F_CTX))
 			items[n++] = (struct res_item) { new_of[env->res_acqs[i].insn], i, ITEM_ACQUIRE };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a710da1a15c6..ec9f77a63197 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11998,6 +11998,9 @@ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *cal
 		if (env->log.level & BPF_LOG_LEVEL2)
 			verbose(env, "func#%d releases what its caller holds at insn %d\n",
 				callee->subprogno, call_idx);
+		/* what the round recorded of the function so far does not hold, see frame_desc.c */
+		if (env->describe_frames && !env->subprog_info[callee->subprogno].releases_inherited)
+			env->frame_desc_redo = true;
 		env->subprog_info[callee->subprogno].releases_inherited = true;
 		return 1;
 	}
@@ -22273,7 +22276,8 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 /* All is done again, whatever came out, see do_check_all() */
 static bool round_is_dropped(struct bpf_verifier_env *env)
 {
-	return (env->restart && bpf_flow_loops_lost_bound(env)) || env->guards_late;
+	return (env->restart && bpf_flow_loops_lost_bound(env)) || env->guards_late ||
+	       env->frame_desc_redo;
 }
 
 static int do_check(struct bpf_verifier_env *env)
-- 
2.53.0

