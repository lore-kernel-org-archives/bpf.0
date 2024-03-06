Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2BC79DE
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 03:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695186; cv=none; b=V1vcAjEEwYEqjqU7fT8F9y6auGRdSnPaap6/8urOrgcJ7byZyXj2Rm1fEqJMp/nqxmQC/zdQLfTvJIwXcM99eNn5Wp+Jg/mZYsCLjI7aBTzXyjLJddXYHUfzf77eL4hAsm+VMLSkFWM2QYUDGzyKDjU1hdo2o1FOjKXkxe/yLxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695186; c=relaxed/simple;
	bh=6WGvSe7Fem9w3KxKjd4+06v+OFSiQr/JuzcRXnyMfzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qOaLdKij16yvgr9c9wenw55YwVB1YcaD0rL9eEO0EULEcvW5rCHcTnYdU66KToY7hb5rK6KI1YlZZ0KviN4Zhnhf2A3XqFgk6jcKMVojf4wtCtMVWuy1WAsUVU6RYceEPR1MZxg0sCrgLM2grdT45DjwrX1Fu9yZCoTGpY5q83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcD/SqAB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcD/SqAB"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso5375692a12.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 19:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709695184; x=1710299984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYgGy7hKxvqJRIlsT84Qutdq9lW39geXxenSPQnQeJY=;
        b=CcD/SqABvsZyJLUvfN3MTRiwwSe/YJKMcyhz8S1nRBp71EE34DTwgJQAn8OptjZJAp
         muk58krbGf4FkeM000qdK/DfaG7Mv/WH9FAGDanrZBMxLMWExvsUBaMZ037OqXodgA7I
         hR38Dv4YrMVqNv0pccnSzWNVzrbcYJfTuGCezY3fdC4v2YzxUrrk3o8k+IYCFLFx+Lxn
         Os38erRXZN/0rc+fZiEEo3dFaKA0UJrNryGIX/9cNvCRLC0LBBIAEEEjszuE5euQcjiN
         PVCVKKUhDUaKjjCNqI8MgWoPWRP3zgNv2eSIjVDPVkP1LkHrt9URKnIiR0JWJbfkZf4Y
         GCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709695184; x=1710299984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYgGy7hKxvqJRIlsT84Qutdq9lW39geXxenSPQnQeJY=;
        b=uvw73vkKyajgd3gzZN5lPVU7EcokV/xfKS1DNVb1wdduxdmftall4Ky1h1VVVJ1//u
         tPMZqFvIGrkta6sQVOWdzZxHgH7V4ZgK6UNwzcyMCAVAteqxyN38az2Nl/cPQsCfw9ax
         X5whtS+oo0zpKOO+Iyim+qDMQxA/eL6E5+ldt+SxBYsJNrRO6m22FPhYSTVg8kc4rwTY
         J9wtGw8GI6IQB5P2asNHhmVBNd+J+z+vptOHwBmyYFR2iEPtu5r9Acf7hGbeL1fnmGtL
         nyQXVSQRfIdEhUyPsVB0P3dnirKs+FolN5lCZmFS1+KSvB2Qmuh3aamogsDXu7dq8Pzt
         jPhA==
X-Gm-Message-State: AOJu0YxXPnCsUX+rOqz+EUOLtD1O4Z8TDzZwIYdF/O0XhvFw1TYWyjo0
	pPdC3dopd4VGutUPZwEiJYMfHBZxSSghSMm4F7GTHahk4PtRk+DWwBh8K+Gp
X-Google-Smtp-Source: AGHT+IHMfoGIQD1sV1DqZ7msofAEsA2ohlW2F71gWTPlx+btCqKC+sguZI45/Gtu09g2MCKpPrX5xQ==
X-Received: by 2002:a05:6a20:7351:b0:1a0:e707:8c2 with SMTP id v17-20020a056a20735100b001a0e70708c2mr4158793pzc.29.1709695183701;
        Tue, 05 Mar 2024 19:19:43 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:52ad])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b006e5a0abb167sm9046119pfi.1.2024.03.05.19.19.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 Mar 2024 19:19:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v6 bpf-next 2/4] bpf: Recognize that two registers are safe when their ranges match
Date: Tue,  5 Mar 2024 19:19:27 -0800
Message-Id: <20240306031929.42666-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When open code iterators, bpf_loop or may_goto are used the following two
states are equivalent and safe to prune the search:

cur state: fp-8_w=scalar(id=3,smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=11,var_off=(0x0; 0xf))
old state: fp-8_rw=scalar(id=2,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=11,var_off=(0x0; 0xf))

In other words "exact" state match should ignore liveness and precision
marks, since open coded iterator logic didn't complete their propagation,
reg_old->type == NOT_INIT && reg_cur->type != NOT_INIT is also not safe to
prune while looping, but range_within logic that applies to scalars,
ptr_to_mem, map_value, pkt_ptr is safe to rely on.

Avoid doing such comparison when regular infinite loop detection logic is
used, otherwise bounded loop logic will declare such "infinite loop" as
false positive. Such example is in progs/verifier_loops1.c
not_an_inifinite_loop().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 51 +++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8030b50d3b45..ee86e4d7d5fc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16260,8 +16260,8 @@ static int check_btf_info(struct bpf_verifier_env *env,
 }
 
 /* check %cur's range satisfies %old's */
-static bool range_within(struct bpf_reg_state *old,
-			 struct bpf_reg_state *cur)
+static bool range_within(const struct bpf_reg_state *old,
+			 const struct bpf_reg_state *cur)
 {
 	return old->umin_value <= cur->umin_value &&
 	       old->umax_value >= cur->umax_value &&
@@ -16425,21 +16425,28 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 	       check_ids(rold->ref_obj_id, rcur->ref_obj_id, idmap);
 }
 
+enum exact_level {
+	NOT_EXACT,
+	EXACT,
+	RANGE_WITHIN
+};
+
 /* Returns true if (rold safe implies rcur safe) */
 static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
-		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap, bool exact)
+		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap,
+		    enum exact_level exact)
 {
-	if (exact)
+	if (exact == EXACT)
 		return regs_exact(rold, rcur, idmap);
 
-	if (!(rold->live & REG_LIVE_READ))
+	if (!(rold->live & REG_LIVE_READ) && exact == NOT_EXACT)
 		/* explored state didn't use this */
 		return true;
-	if (rold->type == NOT_INIT)
-		/* explored state can't have used this */
-		return true;
-	if (rcur->type == NOT_INIT)
-		return false;
+	if (rold->type == NOT_INIT) {
+		if (exact == NOT_EXACT || rcur->type == NOT_INIT)
+			/* explored state can't have used this */
+			return true;
+	}
 
 	/* Enforce that register types have to match exactly, including their
 	 * modifiers (like PTR_MAYBE_NULL, MEM_RDONLY, etc), as a general
@@ -16474,7 +16481,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 			       check_scalar_ids(rold->id, rcur->id, idmap);
 		}
-		if (!rold->precise)
+		if (!rold->precise && exact == NOT_EXACT)
 			return true;
 		/* Why check_ids() for scalar registers?
 		 *
@@ -16585,7 +16592,8 @@ static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifier_env *env,
 }
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-		      struct bpf_func_state *cur, struct bpf_idmap *idmap, bool exact)
+		      struct bpf_func_state *cur, struct bpf_idmap *idmap,
+		      enum exact_level exact)
 {
 	int i, spi;
 
@@ -16598,12 +16606,13 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 
 		spi = i / BPF_REG_SIZE;
 
-		if (exact &&
+		if (exact != NOT_EXACT &&
 		    old->stack[spi].slot_type[i % BPF_REG_SIZE] !=
 		    cur->stack[spi].slot_type[i % BPF_REG_SIZE])
 			return false;
 
-		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ) && !exact) {
+		if (!(old->stack[spi].spilled_ptr.live & REG_LIVE_READ)
+		    && exact == NOT_EXACT) {
 			i += BPF_REG_SIZE - 1;
 			/* explored state didn't use this */
 			continue;
@@ -16749,7 +16758,7 @@ static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
  * the current state will reach 'bpf_exit' instruction safely
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
-			      struct bpf_func_state *cur, bool exact)
+			      struct bpf_func_state *cur, enum exact_level exact)
 {
 	int i;
 
@@ -16776,7 +16785,7 @@ static void reset_idmap_scratch(struct bpf_verifier_env *env)
 static bool states_equal(struct bpf_verifier_env *env,
 			 struct bpf_verifier_state *old,
 			 struct bpf_verifier_state *cur,
-			 bool exact)
+			 enum exact_level exact)
 {
 	int i;
 
@@ -17150,7 +17159,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * => unsafe memory access at 11 would not be caught.
 			 */
 			if (is_iter_next_insn(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, true)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					struct bpf_func_state *cur_frame;
 					struct bpf_reg_state *iter_state, *iter_reg;
 					int spi;
@@ -17174,20 +17183,20 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				goto skip_inf_loop_check;
 			}
 			if (is_may_goto_insn_at(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, true)) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
 					update_loop_entry(cur, &sl->state);
 					goto hit;
 				}
 				goto skip_inf_loop_check;
 			}
 			if (calls_callback(env, insn_idx)) {
-				if (states_equal(env, &sl->state, cur, true))
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN))
 					goto hit;
 				goto skip_inf_loop_check;
 			}
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
-			    states_equal(env, &sl->state, cur, true) &&
+			    states_equal(env, &sl->state, cur, EXACT) &&
 			    !iter_active_depths_differ(&sl->state, cur) &&
 			    sl->state.may_goto_depth == cur->may_goto_depth &&
 			    sl->state.callback_unroll_depth == cur->callback_unroll_depth) {
@@ -17245,7 +17254,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		 */
 		loop_entry = get_loop_entry(&sl->state);
 		force_exact = loop_entry && loop_entry->branches > 0;
-		if (states_equal(env, &sl->state, cur, force_exact)) {
+		if (states_equal(env, &sl->state, cur, force_exact ? RANGE_WITHIN : NOT_EXACT)) {
 			if (force_exact)
 				update_loop_entry(cur, loop_entry);
 hit:
-- 
2.43.0

