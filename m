Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8640BCAB
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957163; cv=none; b=MFFiE7Yvap6PI9sNPjHQ7gOD3uToKEaG/SMN/pKK4gXTKMHEqSuPwTdzkToh76Z2of+KXOIfD3iUHaKg2ltmkeBg0CukcyPzAXFVJ01+FOGPwrVN/gKAGiTUDnXeagBrGiY1fQ1NfYvAnOPd+QLHXyjJNKeZUood3fXuDcuwUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957163; c=relaxed/simple;
	bh=kWyJ2QILcDDmdnEdubjTWv58k+nVTa9Zy+XJ/d+0zho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzRMcj5zTYKdgCwdL85GI1XcuX3SnWGYSqypKwr+zT1Ri9DdNSji9XaObJ2xD4/tJZ5kj9qMk08Yp9PfjLRc4aKXDoGCav6vT/GAXigG2A63kuBU3uLjVEDhHLEth+dxF/A9tlkY3UL4BUBuibId07c3Fee1Suhgvcc4cjdK4vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAeEzbre; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAeEzbre"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-493e61727d9so252375e9.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957160; x=1784561960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JBFBN+5BQkrMhpM40T+gLtYUoOmmCADOcUKYqbamvCw=;
        b=DAeEzbretMzgZa5VJj0L2yas8PSz4cv9vByZPSq8Je548gVBtr2UZipQNwwMFeUs21
         PWCNOcnM5UBWTGANlAJGrF8if7KHIO+RdbB7swklWEcAvT/N4Lp57GEcu4vsRm3Ul4By
         80/zyidCZOXrF8FGJ96jI6mYEaJcKNA3s+uE4tBmI2Iontj1xnfFpdkdd8+6fpGYiJgC
         O30O0ly418bgqrlx/vh476mfY9I+kyBCzhJ5aVU2mYHFRPg+mgniCq4kO484YZq8BqN4
         S7rHSm7Xj9dOlrk0rfpS892uEplrPj86qIrx1n85y8QTxhM+9/CGZ+gUpUKNIAXLCDC9
         kycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957160; x=1784561960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JBFBN+5BQkrMhpM40T+gLtYUoOmmCADOcUKYqbamvCw=;
        b=Bnrm0QOmU2eb2jidyEENNAs3h7HFYICtRDbeIhPQOuttTo1qgt8uT7Xu/XLJ5nPjDD
         cPtVe7DBAuZhaHK9lUB3F0dNcv+xVf1No9pk6r48WqTJlc8KSCoVNpzREDnFBhuY9I0K
         p0ct+WEa2Jz0SvSIz0FgQ2WgeL0+q5q4PatOY54mWG63Fqbg2bIK4KiN1bGAM9zzhVTP
         LyHRlLrdlOa9Whc1e/Aa2utDyLPXZ6unlMko0V1V143y8uV91Ccxug8JHETNmSoHxJ9W
         XmorEGNAzMviq7pvYWI0rnBZoPSuahioT7jTAU68HkY6yjqbCytQbZakDxxfxyZLVmyO
         ZrBA==
X-Gm-Message-State: AOJu0YzmOYarS4sIIwbn5mn5sTznUiRpm8nVe0P6xP+MBzdq9J/j5MHP
	d8jP6e83vlopN50GjLNRONQaZz1o9CalE6F8Hy7xj7XerBkuNI5UmyfQ9JBNKjvC
X-Gm-Gg: AfdE7ck0pxqki01J7mTKSWexbtdJcO19CAd7XaI2AI1ScUdLIwiDwTPU0jqlctBl2z7
	+7ptOIeoPbZbdybLY+2YiTCZM2+AMADEBrAgGPXVyuD+nKvsAOmGCty8ZZG2HyFlZOVNdFQHmpI
	5lUJcpCrStNS57KVV2b/yZnylL762dDHODld5SdOYuYWf4TwCA/XTL0wI43Lhw8/LjhK6G4EO0N
	wMQes4WlfumLH7ByTOPv+PMzfejYtKZaBMjrsDvXeO9/4V/VytXAP74dcvoTbDmKyBBSaxpj0Y4
	y9gsEJhg5M1YLW71JGkmmUscXk59vUX/JAyeVvD/oqPgxz73tlXKl4oyGA/xfNlgYk55V3bj1e9
	0gJyUyTH/aS2pPt5sVF2TkMMDZV8L2PFX30Crp4arZU/wGI7yZ/InSiXXmIkOrkVbllKXcY/1nu
	oIyCvSeIk7XdpJD+zTNo8Ro9zNczctRi1uXP32AKwHud9/h80lFe1NmNY7GzQougeLDmpTa4R2q
	xH0BdcNgmObjAgZAPbvxGsJ23IYN8Im1OQTndXL5KViSiC4acmBoE9lC/XdMZvXPQ==
X-Received: by 2002:a05:600c:a40c:b0:493:ee4d:5c5d with SMTP id 5b1f17b1804b1-493f882cb8cmr69703015e9.31.1783957159930;
        Mon, 13 Jul 2026 08:39:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2dad65fsm193510165e9.1.2026.07.13.08.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 06/17] bpf: Track verifier reference diagnostic events
Date: Mon, 13 Jul 2026 17:38:55 +0200
Message-ID: <20260713153910.2556007-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8841; i=memxor@gmail.com; h=from:subject; bh=kWyJ2QILcDDmdnEdubjTWv58k+nVTa9Zy+XJ/d+0zho=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURf7Th9iJ/WrCQv8U2M4VzzjpK1/N/VtyuYiD2pdHe 452X8vrKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQ2BjEyPJ92XG5m0lyR97MU 3adnb/te8u3P9G/ywQwqhe8EYp5c+MTI8Cr1Nb/6ii8PPa5vSKl2bk5yET+6/a1hfsWPlsLC+I/ 5DAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add reference acquire and release events to diagnostic history so Resource
Lifetime Safety reports can show the lifetime of a specific reference id along
the path.

Record acquisitions after the verifier assigns the reference id. Record
releases only after release_reference_nomark() succeeds, including the
kptr_xchg RCU conversion path and owning-to-non-owning conversion path that
consume an owning reference.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 63 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  2 ++
 kernel/bpf/verifier.c    | 32 +++++++++++++++-----
 3 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 1a45ec926c71..4c1fbabf98d1 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -50,6 +50,8 @@ struct bpf_diag_reg_snapshot {
 enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_BRANCH,
 	BPF_DIAG_HISTORY_MOD,
+	BPF_DIAG_HISTORY_REF_ACQUIRE,
+	BPF_DIAG_HISTORY_REF_RELEASE,
 };
 
 struct bpf_diag_event_hdr {
@@ -75,6 +77,10 @@ struct bpf_diag_history_event {
 			u8 reason;
 			bool origin_valid;
 		} mod;
+		struct {
+			struct bpf_diag_event_hdr hdr;
+			u32 ref_id;
+		} ref;
 	};
 };
 
@@ -82,6 +88,7 @@ enum bpf_diag_history_scope {
 	BPF_DIAG_HISTORY_SCOPE_ALL,
 	BPF_DIAG_HISTORY_SCOPE_REG,
 	BPF_DIAG_HISTORY_SCOPE_STACK_ARG,
+	BPF_DIAG_HISTORY_SCOPE_REF,
 };
 
 struct bpf_diag_history_opts {
@@ -89,6 +96,7 @@ struct bpf_diag_history_opts {
 	u32 frameno;
 	int regno;
 	int stack_arg_slot;
+	u32 ref_id;
 };
 
 static void diag_print_history(struct bpf_verifier_env *env,
@@ -923,6 +931,31 @@ void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 	diag_append_history(env, &event);
 }
 
+static void diag_record_ref(struct bpf_verifier_env *env, u32 insn_idx, u8 kind, u32 ref_id)
+{
+	struct bpf_diag_history_event event = {
+		.ref = {
+			.hdr = {
+				.insn_idx = insn_idx,
+				.kind = kind,
+			},
+			.ref_id = ref_id,
+		},
+	};
+
+	diag_append_history(env, &event);
+}
+
+void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id)
+{
+	diag_record_ref(env, insn_idx, BPF_DIAG_HISTORY_REF_ACQUIRE, ref_id);
+}
+
+void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id)
+{
+	diag_record_ref(env, insn_idx, BPF_DIAG_HISTORY_REF_RELEASE, ref_id);
+}
+
 struct bpf_diag_history_filter {
 	const struct bpf_diag_history_opts *opts;
 	unsigned long *lineage;
@@ -1074,11 +1107,23 @@ static int diag_history_start_idx(const struct bpf_diag_log *log,
 				  const struct bpf_diag_history_filter *filter)
 {
 	const struct bpf_diag_history_opts *opts = filter->opts;
+	int i;
 
 	if (!opts || opts->scope == BPF_DIAG_HISTORY_SCOPE_ALL)
 		return 0;
 	if (filter->lineage_valid)
 		return filter->lineage_start;
+	if (opts->scope != BPF_DIAG_HISTORY_SCOPE_REF)
+		return 0;
+
+	for (i = log->cnt; i > 0; i--) {
+		const struct bpf_diag_history_event *event;
+
+		event = diag_history_event(log, i - 1);
+		if (event->kind == BPF_DIAG_HISTORY_REF_ACQUIRE &&
+		    event->ref.ref_id == opts->ref_id)
+			return i - 1;
+	}
 
 	return 0;
 }
@@ -1096,6 +1141,10 @@ static bool diag_history_event_visible(const struct bpf_diag_history_event *even
 		return true;
 	case BPF_DIAG_HISTORY_MOD:
 		return filter->lineage_valid && test_bit(idx, filter->lineage);
+	case BPF_DIAG_HISTORY_REF_ACQUIRE:
+	case BPF_DIAG_HISTORY_REF_RELEASE:
+		return opts->scope == BPF_DIAG_HISTORY_SCOPE_REF &&
+		       event->ref.ref_id == opts->ref_id;
 	default:
 		return false;
 	}
@@ -1383,6 +1432,16 @@ static void diag_print_mod(struct bpf_verifier_env *env, const struct bpf_diag_h
 			       fmt->old_buf, fmt->new_buf);
 }
 
+static void diag_print_ref_event(struct bpf_verifier_env *env,
+				 const struct bpf_diag_history_event *event)
+{
+	const char *label;
+
+	label = event->kind == BPF_DIAG_HISTORY_REF_ACQUIRE ? "acquired" : "released";
+	bpf_diag_report_source(env, event->insn_idx, label, "owned resource (id=%u)",
+			       event->ref.ref_id);
+}
+
 static void diag_print_history(struct bpf_verifier_env *env,
 			       const struct bpf_diag_history_opts *opts)
 {
@@ -1442,6 +1501,10 @@ static void diag_print_history(struct bpf_verifier_env *env,
 		case BPF_DIAG_HISTORY_MOD:
 			diag_print_mod(env, event);
 			break;
+		case BPF_DIAG_HISTORY_REF_ACQUIRE:
+		case BPF_DIAG_HISTORY_REF_RELEASE:
+			diag_print_ref_event(env, event);
+			break;
 		default:
 			break;
 		}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 440142b09e7a..13b6f5c8f8da 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -106,5 +106,7 @@ void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
 			 const struct bpf_reg_state *old_reg, const struct bpf_reg_state *new_reg,
 			 const struct bpf_diag_mod_target *origin);
+void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
+void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4a468299f05e..24bbeee3396e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -208,7 +208,8 @@ struct bpf_verifier_stack_elem {
 #define BPF_PRIV_STACK_MIN_SIZE		64
 
 static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int parent_id);
-static int release_reference_nomark(struct bpf_verifier_state *state, int id);
+static int __release_reference_nomark(struct bpf_verifier_state *state, int id);
+static int release_reference_nomark(struct bpf_verifier_env *env, int id);
 static int release_reference(struct bpf_verifier_env *env, int id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
@@ -1442,6 +1443,7 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 	s->type = REF_TYPE_PTR;
 	s->id = ++env->id_gen;
 	s->parent_id = parent_id;
+	bpf_diag_record_ref_acquire(env, insn_idx, s->id);
 	return s->id;
 }
 
@@ -9232,7 +9234,7 @@ static void mark_pkt_end(struct bpf_verifier_state *vstate, int regn, bool range
 		reg->range = AT_PKT_END;
 }
 
-static int release_reference_nomark(struct bpf_verifier_state *state, int id)
+static int __release_reference_nomark(struct bpf_verifier_state *state, int id)
 {
 	int i;
 
@@ -9247,6 +9249,16 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int id)
 	return -EINVAL;
 }
 
+static int release_reference_nomark(struct bpf_verifier_env *env, int id)
+{
+	int err;
+
+	err = __release_reference_nomark(env->cur_state, id);
+	if (!err)
+		bpf_diag_record_ref_release(env, env->insn_idx, id);
+	return err;
+}
+
 static int idstack_push(struct bpf_idmap *idmap, u32 id)
 {
 	int i;
@@ -9289,8 +9301,10 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	if (err)
 		return err;
 
-	if (find_reference_state(vstate, id))
-		WARN_ON_ONCE(release_reference_nomark(vstate, id));
+	if (find_reference_state(vstate, id)) {
+		err = release_reference_nomark(env, id);
+		WARN_ON_ONCE(err);
+	}
 
 	while ((id = idstack_pop(idstack))) {
 		/*
@@ -9423,7 +9437,9 @@ static int ref_convert_alloc_rcu_protected(struct bpf_verifier_env *env, u32 id)
 	struct bpf_reg_state *reg;
 	int err;
 
-	err = release_reference_nomark(env->cur_state, id);
+	err = release_reference_nomark(env, id);
+	if (err)
+		return err;
 
 	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 		if (reg->id != id)
@@ -11906,8 +11922,10 @@ static void ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 id)
 {
 	struct bpf_func_state *unused;
 	struct bpf_reg_state *reg;
+	int err;
 
-	WARN_ON_ONCE(release_reference_nomark(env->cur_state, id));
+	err = release_reference_nomark(env, id);
+	WARN_ON_ONCE(err);
 
 	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
 		if (reg->id == id) {
@@ -16135,7 +16153,7 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 * No one could have freed the reference state before
 		 * doing the NULL check.
 		 */
-		WARN_ON_ONCE(release_reference_nomark(vstate, id));
+		WARN_ON_ONCE(__release_reference_nomark(vstate, id));
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		mark_ptr_or_null_reg(state, reg, id, is_null);
-- 
2.53.0

