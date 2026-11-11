Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401882;
	b=Xn8ZZX5jneY8YrTwKol5qeIF8WeqRksr/TlKLD573g9M8RjTIUIyn1CWlzJCmwvbzcGo
	 vlurhW7aOVXMl7y0eaZWON6pd9/a3gFVQtIil7l0CwQM+zd7XPKZOFCemhpn/0047zzs7
	 62rCR11IzfGI3JbYtB/+P4yR/tWlQg7gwHHfCgZY8h9mnYKCANX3D9ny2Qlwg1STtY6Lt
	 0jYFe50IRC/A8uT7aVANYi6eEJ6SuzwJ3J9wPxVtJ+ag/TzPmuZdY8FmACxtZYPgrvBPU
	 KOG7BJNM89+WGQSK1QSfHyKK38RsKuSBRGXrJA/Xz/mAsMzzdBCiDId4WqvpurwfS5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=F219AnXNjFJUcGQ35OTPpP5OaDaLUNr1OxO72UQdz88=;
	b=CdE9Qcw779w3fH0Yt1UlCEXVYSZ9PMm9XhgpFZ2NoHInM83MYQVoGH3gl7e87VUEYfH8
	 cDNP7939k/40Ok6nYLRDhTL74Y6RNlvBbvjc7/ANgrznw04gqcQNEs5ALmQxdBKQt4JvA
	 t9ZNY1oLoO82mol3YlB1b6jNyMnukdcfmjwAWvCurMDjETWNzOagAUAjOZ+dvLGI+OZN4
	 78i8R08bu3HCGZP69219vyn3U5JEvCfOPnhpFAioz7IKfPdsHgJKv0JqV74rsgh7H0ln0
	 xMgd1IuvbHo0QU762tjp5qkVc10dPiZ1gUI6lFfuESJBy9YhuYLHc3iPuXiBnYlrwVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gpVpAO5O;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79F606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF79F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gpVpAO5O
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b80834ce1aso7466585e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401880; x=1795006680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F219AnXNjFJUcGQ35OTPpP5OaDaLUNr1OxO72UQdz88=;
        b=gpVpAO5Oqlv24oVqol1uo+yDxeD3X7UMK79bDCUdvwJpMd4HF708LZMGEHOqWMu0H0
         JGPZ3flVnjgC5GoXM2PTA9RFOM5il7rY5MEnvGDAbN9VFkuOuZoQO3AEeA3oRHTWVaK5
         WaMLiOatjlpN9vHnDr1Rq48W88q0PiUCozqn6clLFKsybdegTtQqr7z+N7IAGSQIfvS9
         MExl5IlOqlBMJf2viAufc2iEwFLt2c1KXBcrTgydB6YsdOGw2fWN2e74kgEVwo27BR7e
         dmf2ekH9MgAQvZ3IgMlaZR+broPxQtJ9Ywfn43zli/OJKskFVPUj+pDWRxFSPivOQXqy
         05oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401880; x=1795006680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F219AnXNjFJUcGQ35OTPpP5OaDaLUNr1OxO72UQdz88=;
        b=uKj6v4t3TuF81MSHhw1wQq0OQulw8GnRMMaWl1sZ1+0Gbq7lomuAekBXY6y9dTks1C
         8dHquPnromC6KEYP069QnFv1ATLAJHswcoArfmc94OIJGRFFpZIgN+kCCzQ+mWx9dbSI
         M3vejjQ/Wzjox0DsaRzCwYMNoNHppOziahXLrK97e8wPJrsgn3LA5QpJNCHgqy4wu5E0
         7DDxquonjRmUYbjOpi5OsfQRY/Zp0lJsNR8JGVcsNr9qtWoO3l5Pc89TS5chNFDnMuLt
         P0WgfkAlsOw0rF/cxpTLmDXiLhGoor3tB1DDZpVx9gMV2LBqQysW8yzq9t2IF7OR9ulb
         az/w==
X-Gm-Message-State: APuU4Z/wmXfbQl4yZkvFDAc4eoUAwmmtlmZoNKOvsYGPLV6eSIf8fFer
	FPDon57U/0skk4T7IcDJo0SSki5qZBvCj5JPSGJQqP/V7AIIPmLnskegTi/749U+7Cs=
X-Gm-Gg: AYBFou3XZPsKMKz0AXcRGwdYNEWNvVGb8DF/cJcIvHBmqeus43IVlVToVafD58GInDb
	ec/3m37LILH39iB1u/GG0YG33CFJL4BbaeucQHdUQlqVuJRi7CxOu8oBPfjriTsz8BkiQUTXha7
	0g75D88RsThXCSkUEH809yOrdg6KON8wLY7MXrrLC0idICGwTYH0TkL5fI4oqoNVx/Ccn+sB0y1
	/HUSa/sYmh0C3eXAI56W6N5vgQAraN0yZ0O/KSfInq23L6FNqMhK8oPOZYZZI3ncT4295OY9BkC
	19lgIBHmCdAx1HfvcgZ9hVedgRc4bgFd/ddoFNyACfwhDdNrwFO71dRZnIbk1ei72tqh5gO4E1e
	Yse9vnnC9Ri3bwybBNQf1qOlvU5JmQZbZ1HKqpzof8ZO9qmgQwdy1jXDjAyTtvUe322qqyEsEzA
	j7N7RnGNO8XYqesC+201NGJjxwV5iRPpm6D36gVLeGaErkDwxdufYiLkhv55zAFWF8kGl8TDWuM
	ED0jH807IATa3Oe4XphjM/niYcvvH9r05vG0rJQABBlOd4TBeTy9GDjxNdp8ewH0A19LlJWjfaf
	A2296T1DdL1CEXzD8kenscbRcy9AaDbFSBxgnhwxHMwEsYZ4BRnTFEDpm61D1hlKrW8BUHK+1iv
	DrPqnvCvOADYmLGeq4nA7CGf6N0X+w4aUQ2x5ADytg28fEICDA3RPJ0qHZVGutOx4jL/aIZooYL
	YEyxQmav4IW4z2zQ==
X-Received: by 2002:a05:600c:5489:b0:4a3:5a98:c279 with SMTP id 5b1f17b1804b1-4ba093582abmr42679425e9.8.1794401879712;
        Wed, 11 Nov 2026 04:57:59 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba09517bc7sm39344565e9.3.2026.11.11.04.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:59 -0800 (PST)
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
Subject: [PATCH bpf-next v1 18/29] bpf: Allow a callee to leave resources with its caller
Date: Wed, 11 Nov 2026 13:57:16 +0100
Message-ID: <6d427c6ccc0de0dcfa3e0cb95bd66e9d71c2074b.1794399387.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=19310; i=memxor@gmail.com; h=from:subject:message-id; bh=uEMxdN9TCR9r+1IqmSA7PnQi17iCgz6VxwZaJw1ayI0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzEKOD5P1clgudJx0f9M5wbPh/pceoW5Vl2n1ujkz+ wuXiml2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIvHBkZXvCIxJf+ffo3VSHn 07Entz0Ugn9t5/HrbOF4NvXIw62ySxn+cNRsOc6dn9HcqvKjeZ7vkTsSHdZbDS5v3K927NwWNa8 DfAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A hidden slot belongs to the frame that made the acquiring call.
Currently a program that throws is rejected whenever a resource ends up
held by another frame:

 - a subprog returns holding anything other than a reference in R0, for
   example a lock that it took for its caller;
 - a subprog returns in more or fewer RCU read or preemption disabled
   sections than it was called in;
 - a callee creates an iterator or saves IRQ flags on its caller's stack.

These programs are rejected even if no throw can find the resource held,
although they load today. An example is one subprog that takes a lock and
another that drops it, with an assertion elsewhere in the program.

Reject them only if a hidden slot is needed:

 - A resource that a subprog returns holding belongs to its caller from
   then on, under the acquisition that the subprog made. That acquisition
   cannot have a hidden slot. The program loads if the caller's sites
   describe the resource, or if no throw finds it held.
 - A stack object belongs to the frame whose stack contains it, whichever
   frame created it. Its sites find it there, so it needs no slot unless
   some visits to a site find it held and others do not.
 - A callee that returns in different sections than it was called in
   leaves the difference to its caller, whose sites give the number of
   sections. The caller then cannot count its sections in a hidden slot.
   A function verified on its own reports this to its caller in
   bpf_flow_return().

A lock at a fixed address, an iterator and saved IRQ flags are always
where a site finds them. Subprogs that take and drop these for their
callers therefore load if every visit to a throw finds them held, or
none does.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  15 ++++
 kernel/bpf/frame_desc.c      | 160 +++++++++++++++++++++++------------
 kernel/bpf/join.c            |   2 +-
 kernel/bpf/states.c          |   2 +-
 kernel/bpf/verifier.c        |   4 +
 5 files changed, 125 insertions(+), 58 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index edd6005c32f6..9a0ea25ab5c2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1112,6 +1112,12 @@ struct bpf_subprog_info {
 	bool stack_args_from_code: 1;
 	/* it releases what its caller holds, so it's verified in the context of such caller */
 	bool releases_inherited: 1;
+	/*
+	 * The kinds of sections, a bit each, that a callee returned to it in
+	 * more or fewer of than it called the callee in: a count it keeps in a
+	 * slot does not follow that, see frame_desc.c.
+	 */
+	u8 section_delta;
 	/* it loads the end of the packet from the context */
 	bool loads_pkt_end: 1;
 	/* a call of it was verified on its own: its insns are not in insns_total of the caller */
@@ -1272,6 +1278,13 @@ struct bpf_res_acq {
 	s16 off;	/* the slot, relative to R10 */
 	bool held;	/* some frame holds what it acquired at a site */
 	bool slot;	/* and some site cannot say where: the handle is kept in a slot */
+	/*
+	 * An insn, plus one, that leaves what it acquired with another frame
+	 * than the one that ran the acquisition: the call a subprog returns
+	 * holding it from, or the acquisition itself when it creates a stack
+	 * object in the stack of a caller. A slot cannot follow it there.
+	 */
+	u32 elsewhere;
 	bool multi;	/* a frame held two of what it acquired at once: one slot cannot */
 };
 
@@ -2345,6 +2358,8 @@ int bpf_frame_desc_record_release(struct bpf_verifier_env *env, int idx);
 int bpf_frame_desc_record_ctx_arg(struct bpf_verifier_env *env, int idx, int argno);
 int bpf_frame_desc_record_section(struct bpf_verifier_env *env, u8 kind, s8 delta);
 int bpf_frame_desc_record_exit(struct bpf_verifier_env *env);
+void bpf_frame_desc_record_sections(struct bpf_verifier_env *env, int subprog, bool rcu,
+				    bool preempt);
 bool bpf_frame_desc_keeps(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
 			  int f, const struct bpf_reg_state *reg);
 u16 bpf_frame_desc_kept_regs(const struct bpf_verifier_env *env, const struct bpf_verifier_state *st,
diff --git a/kernel/bpf/frame_desc.c b/kernel/bpf/frame_desc.c
index 0ef7fda410ee..9854be9ab478 100644
--- a/kernel/bpf/frame_desc.c
+++ b/kernel/bpf/frame_desc.c
@@ -36,9 +36,14 @@
  *
  *  - A frame releases what it acquired itself. A callee cannot reach the
  *    slot of its caller, so it may not release what its caller holds.
- *  - A frame that returns holds nothing but a reference it returns in R0,
- *    which the call acquires for the caller like the call of a kfunc that
- *    returns one, and is in the sections it was called in.
+ *  - A slot goes with its frame. A reference a subprog returns in R0 is
+ *    acquired by the call for the caller, like the call of a kfunc that
+ *    returns one.
+ *    Whatever else a frame comes to hold of what another frame acquired can
+ *    have no slot: a lock a subprog returns holding, or a stack object a
+ *    callee creates in the stack of its caller. Likewise a subprog whose
+ *    callee returns in other sections than it was called in cannot count
+ *    its sections in a slot.
  *  - A slot holds one handle, so a frame that holds two resources of one
  *    acquiring call at once can have no slot for them.
  *
@@ -429,12 +434,13 @@ static s16 spi_off(int spi)
  * front of it, the pointer the call takes to a lock or to a stack object. The
  * handle of a dynptr is the record or the reader, the first word of the
  * dynptr at @obj_off, so that a clone releases it as well as the dynptr it was
- * created in. -EOPNOTSUPP for a resource the unwinder cannot release, -EXDEV
- * for a stack object in the stack of another frame.
+ * created in. @owner is the frame that has a stack object in its stack, which
+ * may be a caller of the current one. -EOPNOTSUPP for a resource the unwinder
+ * cannot release.
  */
 static int acquired_class(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			  const struct bpf_reference_state *ref, int regno, bool after, u8 *flags,
-			  s16 *adj, s16 *obj_off)
+			  s16 *adj, s16 *obj_off, int *owner)
 {
 	const struct bpf_func_state *frame = st->frame[st->curframe];
 	/* a handle that is in no register can only be found by the sites */
@@ -446,6 +452,7 @@ static int acquired_class(struct bpf_verifier_env *env, struct bpf_verifier_stat
 
 	*adj = 0;
 	*obj_off = 0;
+	*owner = st->curframe;
 	if (after) {
 		if (!in_reg)
 			return -EOPNOTSUPP;
@@ -461,13 +468,13 @@ static int acquired_class(struct bpf_verifier_env *env, struct bpf_verifier_stat
 		return resource_of_lock(env, ref, in_reg ? &frame->regs[regno] : NULL, adj, flags);
 	if (!stack_object_find(st, ref, &objframe, &spi))
 		return -EOPNOTSUPP;
-	if (objframe != st->curframe)
-		return -EXDEV;
+	*owner = objframe;
 	slot = bpf_stack_slot(st->frame[objframe], spi);
 	switch (slot->slot_type[BPF_REG_SIZE - 1]) {
 	case STACK_DYNPTR:
 		*flags |= BPF_RES_F_DEREF;
-		*obj_off = spi_off(spi);
+		/* a slot is filled from the stack of the frame that runs the insn only */
+		*obj_off = objframe == st->curframe ? spi_off(spi) : 0;
 		return resource_of_kind(env, slot->spilled_ptr.dynptr.type == BPF_DYNPTR_TYPE_FILE ?
 					     BPF_RESOURCE_DYNPTR_FILE : BPF_RESOURCE_RINGBUF);
 	case STACK_IRQ_FLAG:
@@ -547,30 +554,37 @@ int bpf_frame_desc_record_acquire(struct bpf_verifier_env *env, int idx, int reg
 	struct bpf_reference_state *ref = &st->refs[idx];
 	u8 flags = may_fail ? BPF_RES_F_MAY_FAIL : 0;
 	s16 adj, obj_off;
-	int res, acq;
+	int res, acq, owner;
 
 	ref->res = 0;
 	ref->acq = 0;
 	if (!env->describe_frames || st->speculative)
 		return 0;
-	res = acquired_class(env, st, ref, regno, after, &flags, &adj, &obj_off);
+	res = acquired_class(env, st, ref, regno, after, &flags, &adj, &obj_off, &owner);
 	if (res == -EOPNOTSUPP) {
 		/* the insns of another visit must not take this for a resource of theirs */
 		env->insn_aux_data[env->insn_idx].res_none = true;
 		return 0;
 	}
-	if (res == -EXDEV) {
-		verbose(env, "frame_desc: insn %d creates an object in the stack of another frame, which is not supported in a program that throws\n",
-			env->insn_idx);
-		return -EINVAL;
-	}
 	if (res < 0)
 		return res;
 	/* no insns can put it into a slot then: R10 stands for no register */
 	if (regno < BPF_REG_0 || regno > BPF_REG_5)
 		regno = BPF_REG_FP;
 	acq = acq_add(env, env->insn_idx, res, regno, flags, adj, obj_off);
-	return acq < 0 ? acq : ref_set_acq(env, st, idx, acq);
+	if (acq < 0)
+		return acq;
+	/*
+	 * A stack object is held by the frame that has it in its stack, which
+	 * its sites find it in: the slot of a callee that created it there
+	 * would be gone with the callee.
+	 */
+	if (owner != st->curframe) {
+		ref->frameno = owner;
+		if (!env->res_acqs[acq].elsewhere)
+			env->res_acqs[acq].elsewhere = env->insn_idx + 1;
+	}
+	return ref_set_acq(env, st, idx, acq);
 }
 
 /*
@@ -748,71 +762,89 @@ int bpf_frame_desc_record_section(struct bpf_verifier_env *env, u8 kind, s8 delt
 /*
  * The current frame returns to its caller. Its slots and its counts of
  * sections go with the frame, and nothing moves them to the frame it returns
- * to, so it returns holding nothing but a reference in R0, which the call
- * acquires for the caller, see bpf_frame_desc_record_return(), and in as many
- * sections as it was called in. The entry counts of the sections are lowered
- * as the frame leaves its callers' sections, see release_context_state(),
- * which counts those apart.
+ * to. What it returns holding is its caller's from then on:
+ *
+ *  - A reference in R0 the call acquires for the caller, like the call of a
+ *    kfunc that returns one, see bpf_frame_desc_record_return().
+ *  - Anything else, a lock the frame took for its caller, stays what it was
+ *    acquired as, and can have no slot: the sites of the caller have to say
+ *    where it is, or no throw may find it held, see
+ *    bpf_frame_desc_record_return().
+ *
+ * A frame that returns in more or fewer sections than it was called in leaves
+ * the difference to its caller, whose sites say how many it is in then: a
+ * count the caller keeps in a slot would not know. The entry counts of the
+ * sections are lowered as the frame leaves its callers' sections, see
+ * release_context_state(), which counts those apart.
  */
 int bpf_frame_desc_record_exit(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state *st = env->cur_state;
 	const struct bpf_func_state *frame = st->frame[st->curframe];
-	int i, held = 0;
-	s16 adj;
 
 	if (!env->describe_frames || st->speculative)
 		return 0;
-	if (st->active_rcu_locks != frame->entry_rcu_locks || frame->rcu_released_below ||
-	    st->active_preempt_locks != frame->entry_preempt_locks || frame->preempt_released_below) {
-		verbose(env, "frame_desc: a subprog returns in other sections than it was called in at insn %d, which is not supported in a program that throws\n",
-			env->insn_idx);
-		return -EINVAL;
-	}
-	for (i = 0; i < st->acquired_refs; i++) {
-		const struct bpf_reference_state *ref = &st->refs[i];
-
-		if (!ref->res || ref->frameno != st->curframe)
-			continue;
-		if (ref->type == REF_TYPE_PTR && !(env->res_acqs[ref->acq - 1].flags & BPF_RES_F_ARG) &&
-		    reg_ref_off(&frame->regs[BPF_REG_0], ref->id, &adj) && !held++)
-			continue;
-		verbose(env, "frame_desc: a subprog returns holding what R0 does not carry at insn %d, which is not supported in a program that throws\n",
-			env->insn_idx);
-		return -EINVAL;
-	}
+	/* a function verified on its own has its caller told in bpf_flow_return() */
+	if (st->curframe)
+		bpf_frame_desc_record_sections(env, st->frame[st->curframe - 1]->subprogno,
+					       st->active_rcu_locks != frame->entry_rcu_locks +
+								       frame->rcu_released_below,
+					       st->active_preempt_locks != frame->entry_preempt_locks +
+									   frame->preempt_released_below);
 	return 0;
 }
 
 /*
  * A subprog called at insn @callsite returned to the current frame of @st
- * with @r0. The reference refs[@idx] it returned holding is the caller's
- * from here on, acquired by the call like the reference a kfunc returns; with
- * @idx < 0 it returned holding nothing, and what it left in R0 must not be
- * taken for a reference by the insns another visit has follow the call.
+ * with @r0, holding the reference refs[@idx], which is the caller's from here
+ * on, or nothing with @idx < 0.
+ *
+ * A reference that R0 carries is acquired by the call, like the reference a
+ * kfunc returns. Anything else stays what it was acquired as, in the subprog:
+ * the slot of that acquisition is gone with the frame of the subprog, so it
+ * can have none, see bpf_frame_desc_resolve(). And what the subprog left in
+ * R0 then must not be taken for a reference by the insns another visit has
+ * follow the call.
  */
 int bpf_frame_desc_record_return(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 				 int idx, int callsite, const struct bpf_reg_state *r0)
 {
 	struct bpf_reference_state *ref;
+	struct bpf_res_acq *held;
 	s16 adj = 0;
 	int acq;
 
 	if (!env->describe_frames || st->speculative)
 		return 0;
 	ref = idx < 0 ? NULL : &st->refs[idx];
-	if (!ref || !ref->res) {
-		if (r0->type != SCALAR_VALUE || !tnum_equals_const(r0->var_off, 0))
-			env->insn_aux_data[callsite].res_none = true;
-		return 0;
+	if (ref && !ref->res)
+		ref = NULL;
+	if (ref && ref->type == REF_TYPE_PTR && ref->id &&
+	    !(env->res_acqs[ref->acq - 1].flags & BPF_RES_F_ARG) &&
+	    reg_ref_off(r0, ref->id, &adj)) {
+		acq = acq_add(env, callsite, ref->res - 1, BPF_REG_0, 0, adj, 0);
+		return acq < 0 ? acq : ref_set_acq(env, st, idx, acq);
 	}
-	if (!reg_ref_off(r0, ref->id, &adj)) {
-		verbose(env, "frame_desc: the subprog called at insn %d returns holding what R0 does not carry, which is not supported in a program that throws\n",
-			callsite);
-		return -EINVAL;
+	if (r0->type != SCALAR_VALUE || !tnum_equals_const(r0->var_off, 0))
+		env->insn_aux_data[callsite].res_none = true;
+	if (ref) {
+		held = &env->res_acqs[ref->acq - 1];
+		if (!held->elsewhere)
+			held->elsewhere = callsite + 1;
 	}
-	acq = acq_add(env, callsite, ref->res - 1, BPF_REG_0, 0, adj, 0);
-	return acq < 0 ? acq : ref_set_acq(env, st, idx, acq);
+	return 0;
+}
+
+/*
+ * A callee returned to @subprog in more or fewer RCU read or preemption
+ * disabled sections than it was called in, see bpf_frame_desc_record_exit().
+ */
+void bpf_frame_desc_record_sections(struct bpf_verifier_env *env, int subprog, bool rcu,
+				    bool preempt)
+{
+	if (!env->describe_frames)
+		return;
+	env->subprog_info[subprog].section_delta |= (rcu ? BIT(0) : 0) | (preempt ? BIT(1) : 0);
 }
 
 /*
@@ -1020,6 +1052,8 @@ void bpf_frame_desc_reset(struct bpf_verifier_env *env)
 	env->section_insn_cnt = 0;
 	env->res_site_cnt = 0;
 	env->res_loc_cnt = 0;
+	for (i = 0; i < env->subprog_cnt; i++)
+		env->subprog_info[i].section_delta = 0;
 	for (i = 0; i < env->prog->len; i++) {
 		env->insn_aux_data[i].res_none = false;
 		env->insn_aux_data[i].res_none_r0 = false;
@@ -1217,6 +1251,13 @@ int bpf_frame_desc_resolve(struct bpf_verifier_env *env)
 		ret = slot_can_be_kept(env, i);
 		if (ret)
 			break;
+		/* the slot is in the frame that runs the insn, not in the one that holds this */
+		if (a->elsewhere) {
+			verbose(env, "frame_desc: what insn %d acquires is held by another frame from insn %d on, where a throw finds it in no place its paths agree on, which is not supported in a program that throws\n",
+				a->insn, a->elsewhere - 1);
+			ret = -EINVAL;
+			break;
+		}
 		if (a->multi) {
 			verbose(env, "frame_desc: a frame holds two resources of insn %d at once, which is not supported in a program that throws\n",
 				a->insn);
@@ -1245,6 +1286,13 @@ int bpf_frame_desc_resolve(struct bpf_verifier_env *env)
 		for (k = 0; k < ARRAY_SIZE(sub->section_off) && !ret; k++) {
 			if (!site->sections_vary[k] || sub->section_off[k])
 				continue;
+			/* the count would miss what a callee returned in and did not leave */
+			if (sub->section_delta & BIT(k)) {
+				verbose(env, "frame_desc: a subprog returns in other sections than it was called in, to one that counts its sections in a hidden slot for insn %d, which is not supported in a program that throws\n",
+					site->insn);
+				ret = -EINVAL;
+				break;
+			}
 			ret = bpf_reserve_stack_slots(env, sub - env->subprog_info, 1, &sub->section_off[k]);
 			env->frame_desc_slots++;
 		}
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 180b0a96029c..87d87d359312 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -463,7 +463,7 @@ static bool join_func(struct bpf_join_state *js, struct bpf_func_state *fd,
 		    fa->entry_rcu_locks != fb->entry_rcu_locks ||
 		    fa->entry_preempt_locks != fb->entry_preempt_locks)
 			return false;
-		/* a frame that left a section of its callers hands its count over, see frame_desc.c */
+		/* the sections a frame left of those it was entered in matter to a throw, see frame_desc.c */
 		if (env->describe_frames && (fa->rcu_released_below != fb->rcu_released_below ||
 					     fa->preempt_released_below != fb->preempt_released_below))
 			return false;
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 5a773bfb9e84..01eb8d9077ef 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -717,7 +717,7 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	    old->entry_rcu_locks != cur->entry_rcu_locks ||
 	    old->entry_preempt_locks != cur->entry_preempt_locks)
 		return false;
-	/* a frame that left a section of its callers hands its count over, see frame_desc.c */
+	/* the sections a frame left of those it was entered in matter to a throw, see frame_desc.c */
 	if (env->describe_frames && (old->rcu_released_below != cur->rcu_released_below ||
 				     old->preempt_released_below != cur->preempt_released_below))
 		return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b32c5a4f844f..a710da1a15c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12028,6 +12028,10 @@ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_state *cal
 	}
 	caller->active_irq_id = fresh_id(env, idmap, caller->active_irq_id);
 	caller->active_lock_id = fresh_id(env, idmap, caller->active_lock_id);
+	/* the sections the function entered and did not leave are the caller's, see frame_desc.c */
+	bpf_frame_desc_record_sections(env, frame->subprogno,
+				       caller->active_rcu_locks != caller_rcu,
+				       caller->active_preempt_locks != caller_preempt);
 	/* fresh_id() had no room for an id, or there are no ids left */
 	if (idmap->cnt == BPF_ID_MAP_SIZE || env->id_gen >= BPF_MAX_ID) {
 		verbose(env, "too many ids at the call at insn %d\n", call_idx);
-- 
2.53.0

