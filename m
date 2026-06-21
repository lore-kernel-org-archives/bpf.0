Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892234D4EA
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063096; cv=none; b=HU84iukvL/CnkjuqJAq20lJh82Oj/fGdSbWhtA5UeGshROYT3tFMdDH1WM+s7zDS8L39/D7PLGdVH4EVX1wJ49QmqlCTKE+C42P4/9Gz0LRpMtRBSbjkJZvgH2qrUIA/9/Qv0ZjkLS0AjJxL24eIVRf3dp0mZl/gpRKq5xYPAT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063096; c=relaxed/simple;
	bh=DdqpZe2tSPhKlUWZXpoFliiZeRCcGXi0sMxGuXCjlhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qatbway/1tScbZCuCllXKgz8YxK7Zd/bo+32piRIyzSI7akTG6u2hwha9hVZhIZ1q+AKtN4eYlt6KqdJCqbxb9HSgdDpZCECklEYyiGRTvghP3fDruqoRI1z3AzU2oPICO/OMPH4Ms+qEnIYvKLG63v63ADQQoQ+KsSKjAZuUWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H70CDBGh; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H70CDBGh"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1397e093f90so9524745c88.1
        for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782063091; x=1782667891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sxRdFSOEGhrit8IdsHEipKuXuw/zyeYumrcZ33JxDs=;
        b=H70CDBGh/kjsgYRV9TyZDg92UJ1ZDYb72cLzqEMw27O0DlmGimyuZuUDTIZCVxKDSr
         eaRz/ue19dWVF9JrBmWMVQNS5uSclF/nUQd5diZlcCghotK3ZX1dAGes1T971/l9PkNI
         ivOPzSF5SMMdJ/7pl7bxeF0Jcw7mUZmpbVYYJBysbwanJVO43vFtefcgbVLM1FhH8Dbm
         F1d6y51K1CNNRyKGa4ikVjNJI1iXgK5pnsTDHGvh+gpn+HmLAoLqLS9WGroIkWiehL6Y
         bElscVXHJtVKvsefMNXOLwDJJ5rkwbeyUFjATNViFrFFS9mLddHb8Q/0ij+59r7a2O04
         JsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782063091; x=1782667891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sxRdFSOEGhrit8IdsHEipKuXuw/zyeYumrcZ33JxDs=;
        b=EN+gbdgWRJu4OJazNDnoRNehYGKNAdq4z5d6C3s8mdy4qbTSdmhaqzh8kT7UrNCZUT
         KLw1caWK6zbjPR1MunDI01n9fTpr9B/Y+NDwy7c3se4cGXzO1Ep1AlcWbsDCc7l5+gYU
         sCeAHnpFmpCSH7BCkW9H5NUt/qVYtDWTWHv3vqRAlghjHuEH3yO26aOl7tFeqdFHpUzN
         PCqumdnYd/4AZM/OBW8cIxmBDNuXXbUTh4vgJyX7362JMZIbpB4G/6ZpUq0ONFHuI79H
         QVKVBAd/zIO7hTBXOChojXzZviTu7kfw9HR84bJmeF6g1OoS3f4qC8pL/Hbkgzng3gNb
         pXMQ==
X-Gm-Message-State: AOJu0Yyp96pEFAlsEuKc6D24b0dLsXnRhSWhOQlYyrcSZQnmhcbzDPub
	DcIc8Q5usmlxHuJekZEW8ucfKO98WsBOL4vOyJc+nRbgjUunMj/w0hcFT2mbwvU/oUg=
X-Gm-Gg: AfdE7ckORpcZuOiaFDEBzcEHXInDImG1c4qncWl6x1OBa/eWJulpe3gg61lCYIfUKc0
	P1O6DspcxsMSRYLsLR9RRp9pzw3bazwigJxnSMjGHNaZMZ6psUUJskd+x2tShPPJSTKonPmJUO7
	KkGR8r3mMAznwKxgf0JphxXW0kiNn7zXfC+dQqwEw3IVk0NfuaGQOF9tAbInxE2gMHsfmxf5lxo
	clpcp1iHp8BWXMP7JSuW6kyQQ6+6EE3VrVjc07Ptnkv8+KoJBVzcUS6oZlmn4nwKgqJf0EpekS8
	MkuT67PrGVC8X/U13bUDT3/r+Fgp82Nz1ayhsQsJwIKVzjK9EZofoKj+Lsw+NcjMbVfdFxFZhKz
	hGcsBZKIiagZXnFucpvgdyu1hfWC6R7KLrBuoDF/Ppkf+kkIZiSWW2FKpdI9/uef5cXz6AwsdP3
	Ed5YIZyLGYBpqfRD+kqnyMojM=
X-Received: by 2002:a05:7022:492:b0:138:37a4:fcc1 with SMTP id a92af1059eb24-139a34f4a49mr6765883c88.12.1782063090305;
        Sun, 21 Jun 2026 10:31:30 -0700 (PDT)
Received: from localhost.localdomain ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add6d76dsm5495591c88.12.2026.06.21.10.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 10:31:29 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v4 2/4] bpf: Remove mark_precise_scalar_ids()
Date: Mon, 22 Jun 2026 01:27:33 +0800
Message-ID: <20260621172735.409355-3-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621172735.409355-1-jt26wzz@gmail.com>
References: <20260621172735.409355-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 842edb5507a1038e009d27e69d13b94b6f085763 ]

Function mark_precise_scalar_ids() is superseded by
bt_sync_linked_regs() and equal scalars tracking in jump history.
mark_precise_scalar_ids() propagates precision over registers sharing
same ID on parent/child state boundaries, while jump history records
allow bt_sync_linked_regs() to propagate same information with
instruction level granularity, which is strictly more precise.

This commit removes mark_precise_scalar_ids() and updates test cases
in progs/verifier_scalar_ids to reflect new verifier behavior.

The tests are updated in the following manner:
- mark_precise_scalar_ids() propagated precision regardless of
  presence of conditional jumps, while new jump history based logic
  only kicks in when conditional jumps are present.
  Hence test cases are augmented with conditional jumps to still
  trigger precision propagation.
- As equal scalars tracking no longer relies on parent/child state
  boundaries some test cases are no longer interesting,
  such test cases are removed, namely:
  - precision_same_state and precision_cross_state are superseded by
    linked_regs_bpf_k;
  - precision_same_state_broken_link and equal_scalars_broken_link
    are superseded by linked_regs_broken_link.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240718202357.1746514-3-eddyz87@gmail.com
[ zhenzhong: backport to 6.6.y after adapting the first linked-regs
  history commit to the older scalar-id verifier layout. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 kernel/bpf/verifier.c                         | 115 ------------
 .../selftests/bpf/progs/verifier_scalar_ids.c | 171 ++++++------------
 .../testing/selftests/bpf/verifier/precise.c  |   2 +-
 3 files changed, 56 insertions(+), 232 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2268f095203e..f638b2d3a42f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4265,96 +4265,6 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 	}
 }
 
-static bool idset_contains(struct bpf_idset *s, u32 id)
-{
-	u32 i;
-
-	for (i = 0; i < s->count; ++i)
-		if (s->ids[i] == id)
-			return true;
-
-	return false;
-}
-
-static int idset_push(struct bpf_idset *s, u32 id)
-{
-	if (WARN_ON_ONCE(s->count >= ARRAY_SIZE(s->ids)))
-		return -EFAULT;
-	s->ids[s->count++] = id;
-	return 0;
-}
-
-static void idset_reset(struct bpf_idset *s)
-{
-	s->count = 0;
-}
-
-/* Collect a set of IDs for all registers currently marked as precise in env->bt.
- * Mark all registers with these IDs as precise.
- */
-static int mark_precise_scalar_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
-{
-	struct bpf_idset *precise_ids = &env->idset_scratch;
-	struct backtrack_state *bt = &env->bt;
-	struct bpf_func_state *func;
-	struct bpf_reg_state *reg;
-	DECLARE_BITMAP(mask, 64);
-	int i, fr;
-
-	idset_reset(precise_ids);
-
-	for (fr = bt->frame; fr >= 0; fr--) {
-		func = st->frame[fr];
-
-		bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
-		for_each_set_bit(i, mask, 32) {
-			reg = &func->regs[i];
-			if (!reg->id || reg->type != SCALAR_VALUE)
-				continue;
-			if (idset_push(precise_ids, reg->id))
-				return -EFAULT;
-		}
-
-		bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
-		for_each_set_bit(i, mask, 64) {
-			if (i >= func->allocated_stack / BPF_REG_SIZE)
-				break;
-			if (!is_spilled_scalar_reg(&func->stack[i]))
-				continue;
-			reg = &func->stack[i].spilled_ptr;
-			if (!reg->id)
-				continue;
-			if (idset_push(precise_ids, reg->id))
-				return -EFAULT;
-		}
-	}
-
-	for (fr = 0; fr <= st->curframe; ++fr) {
-		func = st->frame[fr];
-
-		for (i = BPF_REG_0; i < BPF_REG_10; ++i) {
-			reg = &func->regs[i];
-			if (!reg->id)
-				continue;
-			if (!idset_contains(precise_ids, reg->id))
-				continue;
-			bt_set_frame_reg(bt, fr, i);
-		}
-		for (i = 0; i < func->allocated_stack / BPF_REG_SIZE; ++i) {
-			if (!is_spilled_scalar_reg(&func->stack[i]))
-				continue;
-			reg = &func->stack[i].spilled_ptr;
-			if (!reg->id)
-				continue;
-			if (!idset_contains(precise_ids, reg->id))
-				continue;
-			bt_set_frame_slot(bt, fr, i);
-		}
-	}
-
-	return 0;
-}
-
 /*
  * __mark_chain_precision() backtracks BPF program instruction sequence and
  * chain of verifier states making sure that register *regno* (if regno >= 0)
@@ -4487,31 +4397,6 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				bt->frame, last_idx, first_idx, subseq_idx);
 		}
 
-		/* If some register with scalar ID is marked as precise,
-		 * make sure that all registers sharing this ID are also precise.
-		 * This is needed to estimate effect of sync_linked_regs().
-		 * Do this at the last instruction of each state,
-		 * bpf_reg_state::id fields are valid for these instructions.
-		 *
-		 * Allows to track precision in situation like below:
-		 *
-		 *     r2 = unknown value
-		 *     ...
-		 *   --- state #0 ---
-		 *     ...
-		 *     r1 = r2                 // r1 and r2 now share the same ID
-		 *     ...
-		 *   --- state #1 {r1.id = A, r2.id = A} ---
-		 *     ...
-		 *     if (r2 > 10) goto exit; // sync_linked_regs() assigns range to r1
-		 *     ...
-		 *   --- state #2 {r1.id = A, r2.id = A} ---
-		 *     r3 = r10
-		 *     r3 += r1                // need to mark both r1 and r2
-		 */
-		if (mark_precise_scalar_ids(env, st))
-			return -EFAULT;
-
 		if (last_idx < 0) {
 			/* we are at the entry into subprog, which
 			 * is expected for global funcs, but only if
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 22a6cf6e8255..f70392bf696c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -5,54 +5,27 @@
 #include "bpf_misc.h"
 
 /* Check that precision marks propagate through scalar IDs.
- * Registers r{0,1,2} have the same scalar ID at the moment when r0 is
- * marked to be precise, this mark is immediately propagated to r{1,2}.
+ * Registers r{0,1,2} have the same scalar ID.
+ * Range information is propagated for scalars sharing same ID.
+ * Check that precision mark for r0 causes precision marks for r{1,2}
+ * when range information is propagated for 'if <reg> <op> <const>' insn.
  */
 SEC("socket")
 __success __log_level(2)
-__msg("frame0: regs=r0,r1,r2 stack= before 4: (bf) r3 = r10")
-__msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
-__flag(BPF_F_TEST_STATE_FREQ)
-__naked void precision_same_state(void)
-{
-	asm volatile (
-	/* r0 = random number up to 0xff */
-	"call %[bpf_ktime_get_ns];"
-	"r0 &= 0xff;"
-	/* tie r0.id == r1.id == r2.id */
-	"r1 = r0;"
-	"r2 = r0;"
-	/* force r0 to be precise, this immediately marks r1 and r2 as
-	 * precise as well because of shared IDs
-	 */
-	"r3 = r10;"
-	"r3 += r0;"
-	"r0 = 0;"
-	"exit;"
-	:
-	: __imm(bpf_ktime_get_ns)
-	: __clobber_all);
-}
-
-/* Same as precision_same_state, but mark propagates through state /
- * parent state boundary.
- */
-SEC("socket")
-__success __log_level(2)
-__msg("frame0: last_idx 6 first_idx 5 subseq_idx -1")
-__msg("frame0: regs=r0,r1,r2 stack= before 5: (bf) r3 = r10")
+/* first 'if' branch */
+__msg("6: (0f) r3 += r0")
+__msg("frame0: regs=r0 stack= before 4: (25) if r1 > 0x7 goto pc+0")
 __msg("frame0: parent state regs=r0,r1,r2 stack=:")
-__msg("frame0: regs=r0,r1,r2 stack= before 4: (05) goto pc+0")
 __msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__msg("frame0: parent state regs=r0 stack=:")
-__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
+/* second 'if' branch */
+__msg("from 4 to 5: ")
+__msg("6: (0f) r3 += r0")
+__msg("frame0: regs=r0 stack= before 5: (bf) r3 = r10")
+__msg("frame0: regs=r0 stack= before 4: (25) if r1 > 0x7 goto pc+0")
+/* parent state already has r{0,1,2} as precise */
+__msg("frame0: parent state regs= stack=:")
 __flag(BPF_F_TEST_STATE_FREQ)
-__naked void precision_cross_state(void)
+__naked void linked_regs_bpf_k(void)
 {
 	asm volatile (
 	/* r0 = random number up to 0xff */
@@ -61,9 +34,8 @@ __naked void precision_cross_state(void)
 	/* tie r0.id == r1.id == r2.id */
 	"r1 = r0;"
 	"r2 = r0;"
-	/* force checkpoint */
-	"goto +0;"
-	/* force r0 to be precise, this immediately marks r1 and r2 as
+	"if r1 > 7 goto +0;"
+	/* force r0 to be precise, this eventually marks r1 and r2 as
 	 * precise as well because of shared IDs
 	 */
 	"r3 = r10;"
@@ -75,59 +47,18 @@ __naked void precision_cross_state(void)
 	: __clobber_all);
 }
 
-/* Same as precision_same_state, but break one of the
+/* Same as linked_regs_bpf_k, but break one of the
  * links, note that r1 is absent from regs=... in __msg below.
  */
 SEC("socket")
 __success __log_level(2)
-__msg("frame0: regs=r0,r2 stack= before 5: (bf) r3 = r10")
-__msg("frame0: regs=r0,r2 stack= before 4: (b7) r1 = 0")
-__msg("frame0: regs=r0,r2 stack= before 3: (bf) r2 = r0")
-__msg("frame0: regs=r0 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
-__flag(BPF_F_TEST_STATE_FREQ)
-__naked void precision_same_state_broken_link(void)
-{
-	asm volatile (
-	/* r0 = random number up to 0xff */
-	"call %[bpf_ktime_get_ns];"
-	"r0 &= 0xff;"
-	/* tie r0.id == r1.id == r2.id */
-	"r1 = r0;"
-	"r2 = r0;"
-	/* break link for r1, this is the only line that differs
-	 * compared to the previous test
-	 */
-	"r1 = 0;"
-	/* force r0 to be precise, this immediately marks r1 and r2 as
-	 * precise as well because of shared IDs
-	 */
-	"r3 = r10;"
-	"r3 += r0;"
-	"r0 = 0;"
-	"exit;"
-	:
-	: __imm(bpf_ktime_get_ns)
-	: __clobber_all);
-}
-
-/* Same as precision_same_state_broken_link, but with state /
- * parent state boundary.
- */
-SEC("socket")
-__success __log_level(2)
-__msg("frame0: regs=r0,r2 stack= before 6: (bf) r3 = r10")
-__msg("frame0: regs=r0,r2 stack= before 5: (b7) r1 = 0")
-__msg("frame0: parent state regs=r0,r2 stack=:")
-__msg("frame0: regs=r0,r1,r2 stack= before 4: (05) goto pc+0")
-__msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
+__msg("7: (0f) r3 += r0")
+__msg("frame0: regs=r0 stack= before 6: (bf) r3 = r10")
 __msg("frame0: parent state regs=r0 stack=:")
-__msg("frame0: regs=r0 stack= before 0: (85) call bpf_ktime_get_ns")
+__msg("frame0: regs=r0 stack= before 5: (25) if r0 > 0x7 goto pc+0")
+__msg("frame0: parent state regs=r0,r2 stack=:")
 __flag(BPF_F_TEST_STATE_FREQ)
-__naked void precision_cross_state_broken_link(void)
+__naked void linked_regs_broken_link(void)
 {
 	asm volatile (
 	/* r0 = random number up to 0xff */
@@ -136,18 +67,13 @@ __naked void precision_cross_state_broken_link(void)
 	/* tie r0.id == r1.id == r2.id */
 	"r1 = r0;"
 	"r2 = r0;"
-	/* force checkpoint, although link between r1 and r{0,2} is
-	 * broken by the next statement current precision tracking
-	 * algorithm can't react to it and propagates mark for r1 to
-	 * the parent state.
-	 */
-	"goto +0;"
 	/* break link for r1, this is the only line that differs
-	 * compared to precision_cross_state()
+	 * compared to the previous test
 	 */
 	"r1 = 0;"
-	/* force r0 to be precise, this immediately marks r1 and r2 as
-	 * precise as well because of shared IDs
+	"if r0 > 7 goto +0;"
+	/* force r0 to be precise,
+	 * this eventually marks r2 as precise because of shared IDs
 	 */
 	"r3 = r10;"
 	"r3 += r0;"
@@ -164,10 +90,16 @@ __naked void precision_cross_state_broken_link(void)
  */
 SEC("socket")
 __success __log_level(2)
-__msg("11: (0f) r2 += r1")
+__msg("12: (0f) r2 += r1")
 /* Current state */
-__msg("frame2: last_idx 11 first_idx 10 subseq_idx -1")
-__msg("frame2: regs=r1 stack= before 10: (bf) r2 = r10")
+__msg("frame2: last_idx 12 first_idx 11 subseq_idx -1 ")
+__msg("frame2: regs=r1 stack= before 11: (bf) r2 = r10")
+__msg("frame2: parent state regs=r1 stack=")
+__msg("frame1: parent state regs= stack=")
+__msg("frame0: parent state regs= stack=")
+/* Parent state */
+__msg("frame2: last_idx 10 first_idx 10 subseq_idx 11 ")
+__msg("frame2: regs=r1 stack= before 10: (25) if r1 > 0x7 goto pc+0")
 __msg("frame2: parent state regs=r1 stack=")
 /* frame1.r{6,7} are marked because mark_precise_scalar_ids()
  * looks for all registers with frame2.r1.id in the current state
@@ -192,7 +124,7 @@ __msg("frame1: regs=r1 stack= before 4: (85) call pc+1")
 __msg("frame0: parent state regs=r1,r6 stack=")
 /* Parent state */
 __msg("frame0: last_idx 3 first_idx 1 subseq_idx 4")
-__msg("frame0: regs=r0,r1,r6 stack= before 3: (bf) r6 = r0")
+__msg("frame0: regs=r1,r6 stack= before 3: (bf) r6 = r0")
 __msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
 __msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
 __flag(BPF_F_TEST_STATE_FREQ)
@@ -230,7 +162,8 @@ static __naked __noinline __used
 void precision_many_frames__bar(void)
 {
 	asm volatile (
-	/* force r1 to be precise, this immediately marks:
+	"if r1 > 7 goto +0;"
+	/* force r1 to be precise, this eventually marks:
 	 * - bar frame r1
 	 * - foo frame r{1,6,7}
 	 * - main frame r{1,6}
@@ -247,14 +180,16 @@ void precision_many_frames__bar(void)
  */
 SEC("socket")
 __success __log_level(2)
+__msg("11: (0f) r2 += r1")
 /* foo frame */
-__msg("frame1: regs=r1 stack=-8,-16 before 9: (bf) r2 = r10")
+__msg("frame1: regs=r1 stack= before 10: (bf) r2 = r10")
+__msg("frame1: regs=r1 stack= before 9: (25) if r1 > 0x7 goto pc+0")
 __msg("frame1: regs=r1 stack=-8,-16 before 8: (7b) *(u64 *)(r10 -16) = r1")
 __msg("frame1: regs=r1 stack=-8 before 7: (7b) *(u64 *)(r10 -8) = r1")
 __msg("frame1: regs=r1 stack= before 4: (85) call pc+2")
 /* main frame */
-__msg("frame0: regs=r0,r1 stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r1")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
+__msg("frame0: regs=r1 stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r1")
+__msg("frame0: regs=r1 stack= before 2: (bf) r1 = r0")
 __msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void precision_stack(void)
@@ -283,7 +218,8 @@ void precision_stack__foo(void)
 	 */
 	"*(u64*)(r10 - 8) = r1;"
 	"*(u64*)(r10 - 16) = r1;"
-	/* force r1 to be precise, this immediately marks:
+	"if r1 > 7 goto +0;"
+	/* force r1 to be precise, this eventually marks:
 	 * - foo frame r1,fp{-8,-16}
 	 * - main frame r1,fp{-8}
 	 */
@@ -299,15 +235,17 @@ void precision_stack__foo(void)
 SEC("socket")
 __success __log_level(2)
 /* r{6,7} */
-__msg("11: (0f) r3 += r7")
-__msg("frame0: regs=r6,r7 stack= before 10: (bf) r3 = r10")
+__msg("12: (0f) r3 += r7")
+__msg("frame0: regs=r7 stack= before 11: (bf) r3 = r10")
+__msg("frame0: regs=r7 stack= before 9: (25) if r7 > 0x7 goto pc+0")
 /* ... skip some insns ... */
 __msg("frame0: regs=r6,r7 stack= before 3: (bf) r7 = r0")
 __msg("frame0: regs=r0,r6 stack= before 2: (bf) r6 = r0")
 /* r{8,9} */
-__msg("12: (0f) r3 += r9")
-__msg("frame0: regs=r8,r9 stack= before 11: (0f) r3 += r7")
+__msg("13: (0f) r3 += r9")
+__msg("frame0: regs=r9 stack= before 12: (0f) r3 += r7")
 /* ... skip some insns ... */
+__msg("frame0: regs=r9 stack= before 10: (25) if r9 > 0x7 goto pc+0")
 __msg("frame0: regs=r8,r9 stack= before 7: (bf) r9 = r0")
 __msg("frame0: regs=r0,r8 stack= before 6: (bf) r8 = r0")
 __flag(BPF_F_TEST_STATE_FREQ)
@@ -328,8 +266,9 @@ __naked void precision_two_ids(void)
 	"r9 = r0;"
 	/* clear r0 id */
 	"r0 = 0;"
-	/* force checkpoint */
-	"goto +0;"
+	/* propagate equal scalars precision */
+	"if r7 > 7 goto +0;"
+	"if r9 > 7 goto +0;"
 	"r3 = r10;"
 	/* force r7 to be precise, this also marks r6 */
 	"r3 += r7;"
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index b0b1bcc668ad..59a020c35647 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -106,7 +106,7 @@
 	mark_precise: frame0: regs=r2 stack= before 22\
 	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 20 first_idx 20\
-	mark_precise: frame0: regs=r2,r9 stack= before 20\
+	mark_precise: frame0: regs=r2 stack= before 20\
 	mark_precise: frame0: parent state regs=r2,r9 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 17\
 	mark_precise: frame0: regs=r2,r9 stack= before 19\
-- 
2.43.0

