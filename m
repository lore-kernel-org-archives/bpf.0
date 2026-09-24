Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD5468C04
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267515; cv=none; b=WN31ZLI8WTLDAiY0yLa779T9f84A9Z0TqQhJeDK1iLmy+31ydCY97OaSsGb6qIc2Zeyky9pDbkrkGjjrIdxV6UOc7/x0Bd34uJt4g5g05xSXmRMkFt1huEiNowxVSBRX3YPmo7ICfSjOJ4vh27Ko9nv2Ab2yE8ZBtjGegB9Mqhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267515; c=relaxed/simple;
	bh=uODx1xxpUCZhsJbAQSPH9hH3lC3HyQkO179s+1/9pc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAqHVWekWmns5FJNNDV8WO+e8RjvGYnxQAxe64wEFkQeLy2SU9BXSBzvg6KaXLdV+AGit3UxXtWTq+MfWJn/FvUcIPL9KGo9vCNpVnKHIqnAr3s5AApCSsUpKcjvSvhH7/qWNjg/vzct6DiZ3AYcUH6RG9o8b5Lt1MD5GAY/Xhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ox5WIT0I; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ox5WIT0I"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so71675e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267511; x=1790872311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hf0yqvtJmsuf9QWpM0UXfeqgYwXURgNv8P9CiLtttsk=;
        b=ox5WIT0IH3O6hjIL3nD2+SwPOolo4SZrEYHWNM6BiCHX4i8TvNh4LfSKg+n631kI3+
         XpNTrYodYThDjXk3USF2bbgkVZKAcmUjau1rQC223N16vh4ncZ4yn8pdDqpq9R4ZDlFJ
         glOktGsuCmx4O4881yhEQV0L1yrxFdcuHmdwGjYYZA+t8EeRyp1rIdHvCv7NvKLjfRZr
         B+bENZ8GI9thRpez+n2wi3Vsxq2d3Orvflcu/70O/fRKTEJvutw2aGysmlOA2/CdCPE0
         iaE7NXT+tKB6hIArs65JU+/7Oh4KOnK6IDyv96185zRd4DCA577qqgO7dNGOdH40beWm
         K9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267511; x=1790872311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hf0yqvtJmsuf9QWpM0UXfeqgYwXURgNv8P9CiLtttsk=;
        b=bJ0phBHj+uW7Wz5X1f9bLGbfftspNXKW5rIkpRABSTK4rWqPjHuSakVP4KPr3RMV1X
         4NLNuDKWMEdHdhzCOZhErMw533tL+CAxrqSqLjvgT9H8+aSuERi8FgnysE1xWtNTWHQI
         XLm+cztu88aLZWEd0FUS3nPztDhzHVSESgLwQ0rGkt/Lm48VxiYRaTID8BSzy62bHgJl
         bbRjzvB3uLLC+mSxyD/3S/E/8v8Ql6ApC5xybhw7KrLchatQHPxne1hW0vPnOevHPao+
         Uj9+KD9F/f9qzav2BxxVm2TYd/hn+pFxfY+buKaklhAXmp0yRfBCos4q/ypnf2BMoAMM
         Sxeg==
X-Gm-Message-State: AFuF++nzhj5VpIerS4ExJpd8fvWgLpv9ohkXxgGBCtrY+2SWPBWdCB8n
	aFk/B7exSWizqMO35Rr9BGiQZxExkP3kNlS2QSeFJ55Ckr5y+t3AydylUlqJqk/v
X-Gm-Gg: AYBFou3NPuCE0LVUsZU58FxFSPEaLY41yNFj+ngN1g359P0YCZnL53WF7E7lmhcMGXK
	nXUWy5pmd36vLJZizcMiTHNE/4HL2FYD4Sh18HHjR2wRhWkuGPf5M16PD0iepgDqC7H7p/vnx3A
	M0wU1Bqg3Y4n+jIoG3278Gt/aV9eNZGggU0L5EcjvzvDieJ3w1T8UPMl/nUDUbRr71w2JC9KWCU
	d6EoHmSXUcMk5ydXe7EHuFQR/wWCIb1n/sLl4rmkw+06lrHvABFp1GKGjp70eICgu2K+8eQfNig
	P4N50KE6OHpfY+ZyjaT4nRphfZJDWpXf9QFN0VuwawIeSLt48ZjQGXaBLeQnCIRIcIZRCW4wsIM
	oqeWNA0nyWIRMX16br8HnTIQFcyfm1g9PdIoEmYZyIf5Dc4GwKzXSuuZInoVe5z9/0v3WhduzXp
	SnZzOixotE6pyGR+YvfwE+w37Q/G4uoPtPWl25+gd24ZTnuoM8mtY5lHHXqiYSX2mqZ3TveIOJS
	2Fpi6FUsk+v1Is9I2eba6WYoj8b21ajM5klc4kF6SJjltlQWSrHW0bn7Ctdh8YHVxSMozbV6XiG
	+P1zuJYwRowYqXvwCQhO/73fGEJsu/LDsV+nWA==
X-Received: by 2002:a05:600c:8b28:b0:49e:7d74:7b7a with SMTP id 5b1f17b1804b1-49fe66c8eb7mr47795155e9.6.1790267510995;
        Thu, 24 Sep 2026 09:31:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9c59dsm73440555e9.1.2026.09.24.09.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:31:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 03/18] bpf: Store linked registers in the jump history as an array
Date: Thu, 24 Sep 2026 18:31:17 +0200
Message-ID: <20260924163144.1945455-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924163144.1945455-1-memxor@gmail.com>
References: <20260924163144.1945455-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11939; i=memxor@gmail.com; h=from:subject; bh=uODx1xxpUCZhsJbAQSPH9hH3lC3HyQkO179s+1/9pc8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur70vfdw+vyL5NeX8yZFmCzPy3L0xL6qf+4/Y86hlay dcXwdPQUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIls1mL4Z37SfuOntefrzJRe 2P94I3n5TuzlM8w5r1xE1j6OvJnY0cXIsOdh1oR36w16nubXbNNUVb6ZebXY6mR/iJ9GmGgZfzI jHwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Linked scalar registers are recorded in the jump history packed into a
u64 as five 11-bit entries, each naming a frame and a register or stack
slot. The 6-bit slot field covers exactly the 64 slots of a 512-byte
frame, so a spilled scalar in a deeper slot could not be linked and
larger frames were ruled out by construction.

Store the linked registers as an array of five u16 entries plus a count
instead, each entry holding the frame number, a register-or-slot bit
and an 11-bit register or slot index, which covers frames of up to
16 KiB. Callers that record no linked registers pass NULL.

The history entry grows from 16 to 20 bytes, and the history is the
one verifier structure whose size follows the number of instructions a
loop iterates over rather than the state count. Measured over the 5075
selftest programs, peak verifier memory is unchanged for all but the
loop-heavy ones, which grow by 8 to 16%: loop1/nested_loops from 17.6 to
19.2 MiB, verifier_loops1/jumps_out_rather_than_in from 4.4 to 5.1 MiB,
strobemeta by 0.3% and pyperf600_nounroll by 0.8%. Verdicts, processed
instructions and state counts stay the same everywhere.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 16 +++++--
 kernel/bpf/backtrack.c       | 18 +++++---
 kernel/bpf/states.c          |  2 +-
 kernel/bpf/verifier.c        | 86 ++++++++++++++++--------------------
 4 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5a1d21455831..1d80f7a4f26d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -428,6 +428,9 @@ enum {
 	INSN_F_STACK_ARG_ACCESS = BIT(3),
 };
 
+/* Registers linked to one jump condition that a history entry can record */
+#define BPF_LINKED_REGS_MAX	5
+
 struct bpf_jmp_history_entry {
 	/* insn idx can't be bigger than 1 million */
 	u32 idx : 20;
@@ -438,10 +441,14 @@ struct bpf_jmp_history_entry {
 	u32 prev_idx : 20;
 	u32 spi : 12;	/* stack slot index */
 	/*
-	 * additional registers that need precision tracking when this
-	 * jump is backtracked, vector of five 11-bit records
+	 * Scalar registers and spilled scalars linked to the condition of
+	 * this jump, which need precision tracking together when the jump is
+	 * backtracked. Each is packed as 4 bits of frame number, one bit
+	 * telling a register from a stack slot and 11 bits of register or
+	 * slot index, see linked_regs_pack().
 	 */
-	u64 linked_regs;
+	u16 linked_regs[BPF_LINKED_REGS_MAX];
+	u8 linked_regs_cnt;
 };
 
 static_assert(MAX_CALL_FRAMES <= (1 << 4));
@@ -1288,7 +1295,8 @@ struct list_head *bpf_explored_state(struct bpf_verifier_env *env, int idx);
 void bpf_free_verifier_state(struct bpf_verifier_state *state, bool free_self);
 void bpf_free_backedges(struct bpf_scc_visit *visit);
 int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
-			 int insn_flags, int spi, int frame, u64 linked_regs);
+			 int insn_flags, int spi, int frame, const u16 *linked_regs,
+			 u8 linked_regs_cnt);
 void bpf_bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_history_entry *hist);
 void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg);
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 9cc712f1619b..06630acd0d1f 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -9,7 +9,8 @@
 
 /* for any branch, call, exit record the history of jmps in the given state */
 int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
-			 int insn_flags, int spi, int frame, u64 linked_regs)
+			 int insn_flags, int spi, int frame, const u16 *linked_regs,
+			 u8 linked_regs_cnt)
 {
 	u32 cnt = cur->jmp_history_cnt;
 	struct bpf_jmp_history_entry *p;
@@ -27,10 +28,13 @@ int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state
 		env->cur_hist_ent->flags |= insn_flags;
 		env->cur_hist_ent->spi = spi;
 		env->cur_hist_ent->frame = frame;
-		verifier_bug_if(env->cur_hist_ent->linked_regs != 0, env,
-				"insn history: insn_idx %d linked_regs: %#llx",
-				env->insn_idx, env->cur_hist_ent->linked_regs);
-		env->cur_hist_ent->linked_regs = linked_regs;
+		verifier_bug_if(env->cur_hist_ent->linked_regs_cnt != 0, env,
+				"insn history: insn_idx %d has %u linked regs",
+				env->insn_idx, env->cur_hist_ent->linked_regs_cnt);
+		if (linked_regs_cnt)
+			memcpy(env->cur_hist_ent->linked_regs, linked_regs,
+			       linked_regs_cnt * sizeof(*linked_regs));
+		env->cur_hist_ent->linked_regs_cnt = linked_regs_cnt;
 		return 0;
 	}
 
@@ -47,7 +51,9 @@ int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state
 	p->flags = insn_flags;
 	p->spi = spi;
 	p->frame = frame;
-	p->linked_regs = linked_regs;
+	if (linked_regs_cnt)
+		memcpy(p->linked_regs, linked_regs, linked_regs_cnt * sizeof(*linked_regs));
+	p->linked_regs_cnt = linked_regs_cnt;
 	cur->jmp_history_cnt = cnt;
 	env->cur_hist_ent = p;
 
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 9930d3fa5f99..a7c87a1d8cc8 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1416,7 +1416,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 */
 			err = 0;
 			if (bpf_is_jmp_point(env, env->insn_idx))
-				err = bpf_push_jmp_history(env, cur, 0, 0, 0, 0);
+				err = bpf_push_jmp_history(env, cur, 0, 0, 0, NULL, 0);
 			err = err ? : propagate_precision(env, &sl->state, cur, NULL);
 			if (err)
 				return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 33504528ddda..4ce187002333 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3374,26 +3374,25 @@ static void mark_non_stack_access(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].non_stack_access = true;
 }
 
+/* Layout of one packed linked register in the jump history, see linked_regs_pack() */
 #define LR_FRAMENO_BITS	4
-#define LR_SPI_BITS	6
-#define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
-#define LR_SIZE_BITS	4
-#define LR_FRAMENO_MASK	((1ull << LR_FRAMENO_BITS) - 1)
-#define LR_SPI_MASK	((1ull << LR_SPI_BITS)     - 1)
-#define LR_SIZE_MASK	((1ull << LR_SIZE_BITS)    - 1)
-#define LR_SPI_OFF	LR_FRAMENO_BITS
-#define LR_IS_REG_OFF	(LR_SPI_BITS + LR_FRAMENO_BITS)
-#define LINKED_REGS_MAX	5
+#define LR_INDEX_BITS	11
+#define LR_FRAMENO_MASK	((1u << LR_FRAMENO_BITS) - 1)
+#define LR_IS_REG	BIT(LR_FRAMENO_BITS)
+#define LR_INDEX_OFF	(LR_FRAMENO_BITS + 1)
+#define LR_INDEX_MASK	((1u << LR_INDEX_BITS) - 1)
+#define LINKED_REGS_MAX	BPF_LINKED_REGS_MAX
 
 static_assert(MAX_CALL_FRAMES <= (1 << LR_FRAMENO_BITS));
-static_assert(LINKED_REGS_MAX < (1 << LR_SIZE_BITS));
-static_assert(LINKED_REGS_MAX * LR_ENTRY_BITS + LR_SIZE_BITS <= 64);
+static_assert(MAX_BPF_REG <= (1 << LR_INDEX_BITS));
+static_assert(MAX_BPF_STACK_SLOTS <= (1 << LR_INDEX_BITS));
+static_assert(LR_INDEX_OFF + LR_INDEX_BITS <= 16);
 
 struct linked_reg {
 	u8 frameno;
 	union {
-		u8 spi;
-		u8 regno;
+		u16 spi;
+		u16 regno;
 	};
 	bool is_reg;
 };
@@ -3412,48 +3411,34 @@ static struct linked_reg *linked_regs_push(struct linked_regs *s)
 }
 
 /*
- * Use u64 as a vector of 5 11-bit values, use first 4-bits to track
- * number of elements currently in stack.
- * Pack one history entry for linked registers as 11 bits in the following format:
- * - 4-bits frameno
- * - 6-bits spi_or_reg
- * - 1-bit  is_reg
+ * Pack linked registers for a jump history entry, one u16 each:
+ * - 4 bits frameno
+ * - 1 bit  is_reg
+ * - 11 bits register or stack slot index
  */
-static u64 linked_regs_pack(struct linked_regs *s)
+static void linked_regs_pack(const struct linked_regs *s, u16 *packed)
 {
-	u64 val = 0;
 	int i;
 
 	for (i = 0; i < s->cnt; ++i) {
-		struct linked_reg *e = &s->entries[i];
-		u64 tmp = 0;
-
-		tmp |= e->frameno;
-		tmp |= e->spi << LR_SPI_OFF;
-		tmp |= (e->is_reg ? 1 : 0) << LR_IS_REG_OFF;
+		const struct linked_reg *e = &s->entries[i];
 
-		val <<= LR_ENTRY_BITS;
-		val |= tmp;
+		packed[i] = e->frameno | (e->is_reg ? LR_IS_REG : 0) | (e->spi << LR_INDEX_OFF);
 	}
-	val <<= LR_SIZE_BITS;
-	val |= s->cnt;
-	return val;
 }
 
-static void linked_regs_unpack(u64 val, struct linked_regs *s)
+static void linked_regs_unpack(const struct bpf_jmp_history_entry *hist, struct linked_regs *s)
 {
 	int i;
 
-	s->cnt = val & LR_SIZE_MASK;
-	val >>= LR_SIZE_BITS;
-
+	s->cnt = hist->linked_regs_cnt;
 	for (i = 0; i < s->cnt; ++i) {
 		struct linked_reg *e = &s->entries[i];
+		u16 packed = hist->linked_regs[i];
 
-		e->frameno =  val & LR_FRAMENO_MASK;
-		e->spi     = (val >> LR_SPI_OFF) & LR_SPI_MASK;
-		e->is_reg  = (val >> LR_IS_REG_OFF) & 0x1;
-		val >>= LR_ENTRY_BITS;
+		e->frameno = packed & LR_FRAMENO_MASK;
+		e->is_reg  = packed & LR_IS_REG;
+		e->spi     = (packed >> LR_INDEX_OFF) & LR_INDEX_MASK;
 	}
 }
 
@@ -3495,10 +3480,10 @@ void bpf_bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_history_
 	bool some_precise = false;
 	int i;
 
-	if (!hist || hist->linked_regs == 0)
+	if (!hist || !hist->linked_regs_cnt)
 		return;
 
-	linked_regs_unpack(hist->linked_regs, &linked_regs);
+	linked_regs_unpack(hist, &linked_regs);
 	for (i = 0; i < linked_regs.cnt; ++i) {
 		struct linked_reg *e = &linked_regs.entries[i];
 
@@ -3784,7 +3769,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 
 	if (insn_flags)
 		return bpf_push_jmp_history(env, env->cur_state, insn_flags,
-					    hist_spi, hist_frame, 0);
+					    hist_spi, hist_frame, NULL, 0);
 	return 0;
 }
 
@@ -4162,7 +4147,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 	}
 	if (insn_flags)
 		return bpf_push_jmp_history(env, env->cur_state, insn_flags,
-					    hist_spi, hist_frame, 0);
+					    hist_spi, hist_frame, NULL, 0);
 	return 0;
 }
 
@@ -4352,7 +4337,7 @@ static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf_func_s
 	bpf_diag_mod_end(env);
 	state->no_stack_arg_load = true;
 	return bpf_push_jmp_history(env, env->cur_state,
-				    INSN_F_STACK_ARG_ACCESS, spi, 0, 0);
+				    INSN_F_STACK_ARG_ACCESS, spi, 0, NULL, 0);
 }
 
 /*
@@ -4386,7 +4371,7 @@ static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_st
 	cur->regs[dst_regno] = *arg;
 	bpf_diag_mod_end(env);
 	return bpf_push_jmp_history(env, env->cur_state,
-				    INSN_F_STACK_ARG_ACCESS, spi, 0, 0);
+				    INSN_F_STACK_ARG_ACCESS, spi, 0, NULL, 0);
 }
 
 static int mark_stack_arg_precision(struct bpf_verifier_env *env, int arg_idx)
@@ -17934,7 +17919,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	}
 
 	if (insn_flags) {
-		err = bpf_push_jmp_history(env, this_branch, insn_flags, 0, 0, 0);
+		err = bpf_push_jmp_history(env, this_branch, insn_flags, 0, 0, NULL, 0);
 		if (err)
 			return err;
 	}
@@ -18004,7 +17989,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	 * if parent state is created.
 	 */
 	if (linked_regs.cnt > 1) {
-		err = bpf_push_jmp_history(env, this_branch, 0, 0, 0, linked_regs_pack(&linked_regs));
+		u16 packed[LINKED_REGS_MAX];
+
+		linked_regs_pack(&linked_regs, packed);
+		err = bpf_push_jmp_history(env, this_branch, 0, 0, 0, packed, linked_regs.cnt);
 		if (err)
 			return err;
 	}
@@ -19402,7 +19390,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (bpf_is_jmp_point(env, env->insn_idx)) {
-			err = bpf_push_jmp_history(env, state, 0, 0, 0, 0);
+			err = bpf_push_jmp_history(env, state, 0, 0, 0, NULL, 0);
 			if (err)
 				return err;
 		}
-- 
2.53.0

