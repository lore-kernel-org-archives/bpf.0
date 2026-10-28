Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148297;
	b=VgAMWoibGRz0VUq4AYzQjTtA9iU5Sjvyj0JqIBS1RfJqbqlGOh7KDdie3+IdYNvfC4xM
	 icGGuDO77J4qnEDXyHligB/5xQg8UeqMWE5m0Uf+igPjU87vh3nYIaf60o9ONw602NnDW
	 qZVmW67j+MkMa4XY0W6EuIGIcgtMsoBUT4LpqIoSluyyxBR6dNPlfgA5bcL1JpUhgPLui
	 R81P9xjnnLW/EfFoeAX1LsxrgZXcGK/3PVrQWrt5tkKrkpmzOLYTOdlkeGPnGrOPl+Fys
	 XcjpK/jL/JqdAe+Ud7aG43EiVglbKoWVgl6rn30YQQjptwRShLWiS65FSE2g39MZT/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=6uJjygIQOj4PfobWyFkdHKo8MEOteUDPA7NrM6GGJ6k=;
	b=dmmLzBPfbgBS8bQVH1HsGS+F9pVyJ9fjkJL3sdgT0UKZ/eDa2ukCGuSGAU0FMJLXdIQz
	 Ofaic23Fnr6MTSNA70W2jRNDhmhwuy2GnkWIILksuhEpO+qNXxIjCqkH53vNUq/pAx0VL
	 okhoFHK/846vdP5mAODjUXg26hTmPFHgGH4os2kmNW3E8oXERZCVDAaHDWDZ2JD0CttKZ
	 lJPc5UF+bYmUrt/f0fiNuOGp75xYb1hm/f2bpOBIM+RozR1FtnRzIEZX8Rp/6uj0C96+D
	 5zwrgUth032gj0HoM7hCsD16euzi3OTRLb6DO+B/Hxq+cyxylW3C3xpWf1YWdpzGcJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DiL1H8xj;
	arc=none smtp.remote-ip=74.125.225.128
Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC1606A321
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30BC1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DiL1H8xj
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-4a2d6cf8c98so864485e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148295; x=1793753095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6uJjygIQOj4PfobWyFkdHKo8MEOteUDPA7NrM6GGJ6k=;
        b=DiL1H8xjN0b/PlDr+pDHp7LTFBpNJmqAZnpKWKo9iU3ahD32aYyD5FqcSEvCw47SKv
         Jzm9BCD/lCp23ifDhWkfsx5oqyuL95VLuAU0iqjVrhF85aBATEC0kYzvHEH7I3SUueoE
         CHvBQPq6USOJoKn0AmfjVOQC4uk1cFxryKWQSY991/D6QUJeFbJtO7mk/X3q02fqSxbF
         ltG1WOycuEKaAV6tKQOcsNNo0lRfdXwmveThHnZv39hFMOB4Wp3NQqF9/ZQ0Aa7JIXIZ
         JvJe0Pu7BsPgeAVBricASIMasDzI7Xug6AKUy4TblstL/e0OyqSKnplKNEl/sVoKQG+M
         4Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148295; x=1793753095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6uJjygIQOj4PfobWyFkdHKo8MEOteUDPA7NrM6GGJ6k=;
        b=gSJbiVx8JSmFoxwUBNZ8+rUp2CfY04P8ygT+dJqAro0xtdMIYDljjOcae6xqxybb9v
         AmDdSO8ri+vKTw8C41DtpN21erQF/QWcv/8UqRS/9yCQGn7UxA2hMaHZutiEMq09dhyy
         NOhDUmTROvWXljUhS2ggkuBOHwjsdgjgSfcza7b9ANni4m0/QBUrqjrSzCRHzGwrFSNp
         AQRBIpr9Fq/ljcUFEjZ35AvzrxunvvQ5SIxIKaGQ50Uv+rLLshiwQtlm7Hx76W0Y8h42
         Y/vNlmB4FRvVNdQem6IWtfste5hNtH/5qquA/EuSyzDkeSHEhZTUu9jbdODsEjUs7xDA
         a8Jw==
X-Gm-Message-State: AFq9FYJ2hKAGp1Mt7uAdlTbwOUAqVBS0eQ2c25BApXNMIvkeSIqrBqyG
	SU36sbRIu3VBA5XYL7EoFRclFjHUS5h3JTBWCei6kR2cy1DVBY3aOIhejDJoKYw/
X-Gm-Gg: AYBFou1b7E2sF6dsa/xpYocDMBYNFSKTkLUD0J6E1EHBqG2mKvyOzH+0Q9Jdv4TBCI4
	U4xCDjedSg/5Pyd47lIumo5WHPvL8cBT1+Ff6HqvPrGaE/JjWwmIhE5r/U3mzqNXMu3eMLUVMfo
	mFSPjAiBRkvar9M3FbVM3qQK+FelNJbrhJeUaY/PnrAW6REWF+iTs0qQqlx0epM3wYlJYgFhp7e
	lNdkcndmP4nJ3V4Nac7NwHAzmoyPy5zu/oGhJFPt+egtP3zrP7PXuIy2aX91KR5DLRuOYTRQpyc
	/wjkQqP5IBa3umLqBHEGGfbI5MeMyrD6hvAJlG+yo6LKhJI7lKUgMAOcCMwtnTGr/+Bb+/2WIwK
	VZEDzXBEFC00UnVKwTbF8YD0hHhOfve/qClXH9sN90unFkx92+eO3EnTqPEUC2gkxVg2CdY9w84
	/1mEI6CIIZ8VmUTWjMXGNCKu8JAqCw4pi2Cw72i+f506Za5fS3DZP3JE/LBaYsehESvu9DxqDXq
	p6o/v1GQW4RV6cJcGAFhOmmfe0Pd3aeQi3BHoYxEruVwqI0UuK0/9S/+fA+SIC5+YP2BG1gWnXQ
	QhqlbkQOyUAsI085JNOo4J0y3lsRkynMkUFuy/VF7O8cNwhINiKnFxueRZX/G16xsKQnAjOHn1z
	ir7i6Hv3/iNmmj2yU909BoYJizfZJfQ++JxhwWq/dCoCpdxHj5mJCr2nulD6Nsmfa4meY
X-Received: by 2002:a05:600c:34d6:b0:4a2:d:5ccc with SMTP id 5b1f17b1804b1-4a9660b5135mr12451595e9.10.1793148295425;
        Tue, 27 Oct 2026 17:44:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97bf5d5besm8633095e9.5.2026.10.27.17.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:44:54 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v1 03/11] bpf: Let a callback unwind into the pad of its helper
Date: Wed, 28 Oct 2026 01:44:40 +0100
Message-ID: <cc848a0c0e4839fe34514b89561884c082650881.1793147364.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18165; i=memxor@gmail.com; h=from:subject:message-id; bh=G3PCk4uZ0y1GFkeGYuV4l71+2QHzutKwuFHpit5P9zI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuh49P7brl6ftLrtvIk7eXcVRoR1bCq1txjsmLO2r2GT oc5OYU7SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJHS+YwMj9wTSt7s6PuoHXit e9q2XhW7XRO2enzoOnee9eo7nwcdGowMbSJ/Fu4S/Ng7dT/jTMugT1LHfIMcS72Ldr6stuVqiFn IDAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A helper that calls a callback is a C frame between the callback and the
BPF code that called the helper, and with bpf_call_cb() it has a pad: the
unwind_exit of the callback lands there, the helper drops what it holds
and leaves to the pad after its call with the r0 the callback unwound
with. To the verifier the helper is transparent on that path as it is on
the normal one: it models the call of a helper with a callback as the
callback running in a frame of its own, and a callback that unwinds now
leaves that frame the way a subprog does.

So the call of a helper or a kfunc with a callback that can unwind is a
call of something that can unwind: unwind_goto may follow it and has to
when the callback has unwind_exit, the same rule as for a subprog. At
unwind_exit of the callback the verifier goes back to the call once more,
as it does after a round of the callback, since the helper has effects of
its own on its way to the pad: bpf_rbtree_add() releases the node
whichever way it leaves. With the state marked unwound there is no further
round of the callback, the next call with a callback in the frame starts
from its first round, and the next insn is the unwind_goto. A callback
that returns on one path to the call and unwinds on another is fine: the
pad is there for whoever takes it.

The pad gets the state of the r0 of the callback, as the pad after a
subprog call does. The return of a callback is a scalar in a range because
the helper acts on it; what the callback unwinds with, the helper passes
on bit for bit and doesn't look at. So a known value stays known, a
pointer stays the pointer it was, with its type and its reference, and
what the pad does with it is checked there and in every pad above that
unwinds on with it, up to the main prog, whose return has to be a number.
A pointer into the stack of the callback is refused as at any return.
What the callback may leave in r0 is what it may store through
callback_ctx already. That includes pointers that don't outlive the helper:
the dynptr of bpf_user_ringbuf_drain() and the key of the array iterator
live in the frame of the helper, the vma of bpf_find_vma() is good under
the lock the pad drops. The verifier lets the store through today, and the
fix for that has to see to r0 too.

The effects of the helper on its way to the pad apply to that r0 like to
any register: on the revisit of the call, check_helper_call() and
check_kfunc_call() keep r0 across the scrub of the caller-saved registers
and skip the return. Two passes see r0 flow through the call. Liveness:
r0 is live before a call with a callback and a pad, since the revisit
passes it on, so that two unwound states at the call with a different r0
aren't one. Precision: the history entry of the revisit is marked
INSN_F_UNWOUND, so backtracking doesn't take r0 for the helper's there,
and unwind_exit of a callback hands the request on to the callback the way
exit of a subprog does.

No helper has a pad yet: "callback cannot unwind" stays until a helper is
opened, which the following patches do one by one, where BPF_HAS_CB_PADS.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |   6 +-
 kernel/bpf/backtrack.c       |  21 +++++-
 kernel/bpf/liveness.c        |   7 ++
 kernel/bpf/verifier.c        | 138 ++++++++++++++++++++++++++++++-----
 4 files changed, 149 insertions(+), 23 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5926f13ff43c..8b4d4d6981f3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -434,6 +434,8 @@ enum {
 	INSN_F_SRC_REG_STACK = BIT(2), /* src_reg is PTR_TO_STACK */
 
 	INSN_F_STACK_ARG_ACCESS = BIT(3),
+
+	INSN_F_UNWOUND = BIT(4), /* the callback of this call unwound: r0 is the callback's */
 };
 
 /* Registers linked to one jump condition that a history entry can record */
@@ -444,8 +446,8 @@ struct bpf_jmp_history_entry {
 	u32 idx : 20;
 	u32 frame : 4;	/* stack access frame number */
 	/* special INSN_F_xxx flags */
-	u32 flags : 4;
-	u32 : 4;
+	u32 flags : 5;
+	u32 : 3;
 	u32 prev_idx : 20;
 	u32 spi : 12;	/* stack slot index */
 	/*
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 43d5740034c0..ce171be5e754 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -530,8 +530,13 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 */
 			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL && insn->imm == 0)
 				return -ENOTSUPP;
-			/* regular helper call sets R0 */
-			bt_clear_reg(bt, BPF_REG_0);
+			/*
+			 * A regular helper call sets R0. When its callback unwound,
+			 * R0 is the callback's, from the unwind_exit of the callback,
+			 * see the BPF_EXIT case.
+			 */
+			if (!hist || !(hist->flags & INSN_F_UNWOUND))
+				bt_clear_reg(bt, BPF_REG_0);
 			/* kfunc might also set R2 */
 			bt_clear_reg(bt, BPF_REG_2);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
@@ -548,7 +553,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 					return -EFAULT;
 			}
 		} else if (opcode == BPF_EXIT) {
-			bool from_subprog_call, r0_precise, r2_precise;
+			bool from_subprog_call, cb_unwinds, r0_precise, r2_precise;
 
 			/* BPF_EXIT in subprog or callback always returns
 			 * right after the call instruction, so by checking
@@ -562,8 +567,16 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			from_subprog_call = subseq_idx - 1 >= 0 &&
 					    (bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]) ||
 					     bpf_is_callx(&env->prog->insnsi[subseq_idx - 1]));
+			/*
+			 * unwind_exit of a callback goes back to the call of the
+			 * helper, which passes R0 on to the pad after it: R0 is
+			 * the callback's, as it is the subprog's after a call.
+			 */
+			cb_unwinds = !from_subprog_call && bpf_is_unwind_exit(insn) &&
+				     subseq_idx >= 0 &&
+				     bpf_is_sync_callback_calling_insn(&env->prog->insnsi[subseq_idx]);
 
-			r0_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
+			r0_precise = (from_subprog_call || cb_unwinds) && bt_is_reg_set(bt, BPF_REG_0);
 			r2_precise = from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);
 
 			/* Backtracking to a nested function call, 'idx' is a part of
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e657e6d95408..22225d1a0fe7 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2637,6 +2637,13 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			/* callx reads the address of the callee from dst_reg */
 			if (bpf_is_callx(insn))
 				use |= dst;
+			/*
+			 * When the callback unwinds, the revisit of the call passes
+			 * the r0 of the callback on to the pad after the call, see
+			 * check_helper_call(): live before the call.
+			 */
+			if (bpf_is_sync_callback_calling_insn(insn) && bpf_is_unwind_goto(insn + 1))
+				use |= r0;
 			break;
 		default:
 			def = 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5601d2056218..ac9dbe082181 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/bpf.h>
+#include <linux/bpf_unwind.h>
 #include <linux/btf.h>
 #include <linux/bpf_verifier.h>
 #include <linux/filter.h>
@@ -3435,6 +3436,8 @@ static int next_callx_callee(struct bpf_verifier_env *env, int caller, int from)
  * 'call foo; unwind_goto pad' goes to the pad when foo left with unwind_exit.
  * JITs don't emit a branch for it. unwind_exit finds the pad by its return
  * address. So unwind_goto has to follow the call and nothing may jump to it.
+ * The call may be of a helper or a kfunc that calls a callback: it leaves like
+ * the callback did, see check_cb_unwind().
  */
 static int check_unwind_insns(struct bpf_verifier_env *env)
 {
@@ -3450,8 +3453,10 @@ static int check_unwind_insns(struct bpf_verifier_env *env)
 		if (!bpf_is_unwind_goto(insn))
 			continue;
 		seen = true;
-		if (!i || !(bpf_pseudo_call(insn - 1) || bpf_is_callx(insn - 1))) {
-			verbose(env, "unwind_goto at insn %d doesn't follow a call of a subprog\n",
+		if (!i || !(bpf_pseudo_call(insn - 1) || bpf_is_callx(insn - 1) ||
+			    bpf_is_sync_callback_calling_insn(insn - 1))) {
+			verbose(env,
+				"unwind_goto at insn %d doesn't follow a call of a subprog or of a helper with a callback\n",
 				i);
 			return -EINVAL;
 		}
@@ -11397,6 +11402,55 @@ static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog)
 	return err;
 }
 
+/* The helper calls its callback with a pad, see bpf_call_cb(). None yet. */
+static bool helper_has_cb_pad(enum bpf_func_id func_id)
+{
+	return false;
+}
+
+/* The kfunc calls its callback with a pad. None yet. */
+static bool kfunc_has_cb_pad(u32 btf_id)
+{
+	return false;
+}
+
+static bool insn_has_cb_pad(struct bpf_insn *insn)
+{
+	return (bpf_helper_call(insn) && helper_has_cb_pad(insn->imm)) ||
+	       (bpf_pseudo_kfunc_call(insn) && kfunc_has_cb_pad(insn->imm));
+}
+
+/*
+ * A sync callback is called by a helper or a kfunc, a C frame between the
+ * callback and the BPF code that called it. unwind_exit of the callback returns
+ * to the pad of its caller when there is one, and a helper or a kfunc that
+ * calls a callback has one where BPF_HAS_CB_PADS and insn_has_cb_pad(): it
+ * calls the callback with bpf_call_cb(), drops what it holds when the callback
+ * unwinds and leaves to the pad of its own caller with the r0 of the callback.
+ * So a call with such a callback that can unwind is a call of something that
+ * can unwind, and unwind_goto has to follow it.
+ */
+static int check_cb_unwind(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			   int insn_idx, int subprog)
+{
+	if (!env->subprog_info[subprog].can_unwind)
+		return 0;
+	if (!BPF_HAS_CB_PADS || !insn_has_cb_pad(insn)) {
+		verbose(env, "callback cannot unwind\n");
+		return -EINVAL;
+	}
+	if (!bpf_is_unwind_goto(insn + 1)) {
+		if (bpf_helper_call(insn))
+			verbose(env, "no unwind_goto after the call of %s()\n",
+				func_id_name(insn->imm));
+		else
+			verbose(env, "no unwind_goto after the call of the kfunc at insn %d\n",
+				insn_idx);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			      int insn_idx, int subprog,
 			      set_callee_state_fn set_callee_state_cb)
@@ -11406,6 +11460,15 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	int err;
 
 	caller = state->frame[state->curframe];
+	/*
+	 * The callback unwound, and the call is visited once more for the
+	 * effects of the helper, see prepare_func_exit(): no more rounds, and
+	 * the next call with a callback in this frame starts from its first.
+	 */
+	if (state->unwound) {
+		caller->callback_depth = 0;
+		return 0;
+	}
 	err = btf_check_subprog_call(env, subprog);
 	if (err == -EFAULT)
 		return err;
@@ -11459,6 +11522,10 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	if (err)
 		return err;
 
+	err = check_cb_unwind(env, insn, insn_idx, subprog);
+	if (err)
+		return err;
+
 	/* for callback functions enqueue entry to callback and
 	 * proceed with next instruction within current frame.
 	 */
@@ -12090,7 +12157,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	struct bpf_verifier_state *state = env->cur_state, *prev_st;
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
-	bool in_callback_fn;
+	bool in_callback_fn, unwinds;
 	u32 i, nregs;
 	int err;
 
@@ -12111,12 +12178,16 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	}
 
 	caller = state->frame[state->curframe - 1];
-	if (bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx])) {
-		/* the helper or the kfunc that called it doesn't expect that */
-		if (callee->in_callback_fn) {
-			verbose(env, "callback cannot unwind\n");
-			return -EINVAL;
-		}
+	unwinds = bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx]);
+	if (unwinds) {
+		/*
+		 * A callback returns into the helper that called it, and to the
+		 * pad of the helper when the helper has one. check_cb_unwind()
+		 * has seen to that, and to the unwind_goto after the call of
+		 * the helper, where the helper leaves to right away, with the
+		 * r0 of the callback as it is: the pad gets its state, as the
+		 * pad after a subprog call does.
+		 */
 		if (!bpf_is_unwind_goto(&env->prog->insnsi[callee->callsite + 1])) {
 			verbose(env, "unwind_exit, but no unwind_goto after the call at insn %d\n",
 				callee->callsite);
@@ -12124,7 +12195,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		}
 		state->unwound = true;
 	}
-	if (callee->in_callback_fn) {
+	if (callee->in_callback_fn && !unwinds) {
 		if (r0->type != SCALAR_VALUE) {
 			verbose(env, "R0 not a scalar value\n");
 			return -EACCES;
@@ -12171,6 +12242,14 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	 * there function call logic would reschedule callback visit. If iteration
 	 * converges is_state_visited() would prune that visit eventually.
 	 */
+	/*
+	 * A callback that unwound goes back to the call too: the helper has
+	 * effects of its own to apply, such as releasing what it consumed. With
+	 * the state marked unwound it is the last round, and r0 is still what
+	 * the callback unwound with after the call, with the effects of the
+	 * helper applied to it. See push_callback_call(), check_helper_call()
+	 * and check_kfunc_call().
+	 */
 	in_callback_fn = callee->in_callback_fn;
 	if (in_callback_fn)
 		*insn_idx = callee->callsite;
@@ -12201,7 +12280,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	 * This is similar to what is done in process_iter_next_call() for open
 	 * coded iterators.
 	 */
-	prev_st = in_callback_fn ? find_prev_entry(env, state, *insn_idx) : NULL;
+	prev_st = in_callback_fn && !unwinds ? find_prev_entry(env, state, *insn_idx) : NULL;
 	if (prev_st) {
 		err = widen_imprecise_scalars(env, prev_st, state);
 		if (err)
@@ -12614,7 +12693,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	const struct bpf_func_proto *fn = NULL;
 	enum bpf_return_type ret_type;
 	enum bpf_type_flag ret_flag;
-	struct bpf_reg_state *regs;
+	struct bpf_reg_state *regs, unwound_r0;
 	struct bpf_call_arg_meta meta;
 	const char *operation;
 	int insn_idx = *insn_idx_p;
@@ -12870,12 +12949,25 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 
 	/* reset caller saved regs */
 	bpf_diag_record_caller_saved(env, regs);
-	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
+	/*
+	 * The callback unwound: the helper leaves to the pad after the call
+	 * with the r0 of the callback, which prepare_func_exit() put here and
+	 * which the effects of the helper above apply to like to any register.
+	 * There is no return, and r0 isn't written.
+	 */
+	if (env->cur_state->unwound)
+		unwound_r0 = regs[BPF_REG_0];
+	else
+		bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
 		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
 	}
 	invalidate_outgoing_stack_args(env, cur_func(env));
+	if (env->cur_state->unwound) {
+		regs[BPF_REG_0] = unwound_r0;
+		goto unwound;
+	}
 
 	/* update return register (already marked as written above) */
 	ret_type = fn->ret_type;
@@ -13063,7 +13155,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		return err;
 
 	bpf_diag_mod_end(env);
-
+unwound:
 	err = check_map_func_compatibility(env, meta.map.ptr, func_id);
 	if (err)
 		return err;
@@ -15398,7 +15490,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 {
 	bool sleepable, rcu_lock, rcu_unlock, preempt_disable, preempt_enable;
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
-	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_reg_state *regs = cur_regs(env), unwound_r0;
 	const char *func_name, *ptr_type_name;
 	const struct btf_type *t, *ptr_type;
 	struct bpf_call_arg_meta meta;
@@ -15660,13 +15752,23 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	bpf_diag_record_caller_saved(env, regs);
-	bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
+	/* The callback unwound: r0 is the callback's, see check_helper_call() */
+	if (env->cur_state->unwound) {
+		unwound_r0 = regs[BPF_REG_0];
+		ret_nregs = 0;
+	} else {
+		bpf_diag_mod_begin(env, &regs[BPF_REG_0], NULL, BPF_DIAG_MOD_WRITE);
+	}
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
 		u32 regno = caller_saved[i];
 
 		bpf_mark_reg_not_init(env, &regs[regno]);
 	}
 	invalidate_outgoing_stack_args(env, cur_func(env));
+	if (env->cur_state->unwound) {
+		regs[BPF_REG_0] = unwound_r0;
+		goto unwound;
+	}
 
 	/* Check return type */
 	t = btf_type_skip_modifiers(desc_btf, meta.func_proto->type, NULL);
@@ -15851,6 +15953,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+unwound:
 	if (is_kfunc_dynptr_write(&meta) ?
 	    dynptr_write_changes_pkt_data(meta.dynptr_write_type) :
 	    bpf_is_kfunc_pkt_changing(&meta))
@@ -20589,7 +20692,8 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (bpf_is_jmp_point(env, env->insn_idx)) {
-			err = bpf_push_jmp_history(env, state, 0, 0, 0, NULL, 0);
+			err = bpf_push_jmp_history(env, state, state->unwound ? INSN_F_UNWOUND : 0,
+						   0, 0, NULL, 0);
 			if (err)
 				return err;
 		}
-- 
2.53.0

