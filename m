Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8523CF68C
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902795; cv=none; b=U8T/SX+VeI10289YKSTnf+DGdc3QZ1H8ZMED1SedC2AZNYJBaIWUab0utxuMbOpxCrco3gE+Hya8OmbSiZSB7nCAxzZRnWOJqpe7bA2uHP8u8xf43f92XJgvVTnmdjyvrhw4MBpw3LMkk1lt5kqRdcP6sTQ3wfypFX3KsXkT5wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902795; c=relaxed/simple;
	bh=j/1UVJQ7QZjGfqYGmBd1WiSCTsZRamkxREH11q4VPxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CC3Xki5CelcKz0mDklgI29PWuDw2nkKFsixid19sBeHo4LfJLsHk6PQfeyNd8DTh9MFdYjqvAwR1auUnZLIi85/p8ZD+dF29xuO7da/pLYyfYnwqjQOWTn85FzMo5PfACKDeO/4LOPMYejyWEQMZZnoVzeYp/n7iee3pZUzRRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIoO/G8f; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIoO/G8f"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4924944fe6bso1090305e9.0
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902782; x=1782507582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jySa/Bi7vo6f9i4WegYtCHrqGBCugdKwEW8kHF7s+ig=;
        b=SIoO/G8f/zp8omUIAmrs5utQqgLb0hzXq8r+m6XWJlJMIYnnlIzclCYZpkumTC3cbs
         7SZlULWuMfVRt5BIBv/TvyhkmIlNdw+RpwFZFXhl7OcwDnzEq6WA3ol2WTNRkwX9/6tE
         ClqcqbJWvqQhz87RGq/DeTKOJJnZ2UMnaV0IDJZ2H4fR1m5NShl2gRjxrat4doNQTx5B
         LL8xr2cq+e/wkXkSdEqgNNpsVIeS4T4nuW7qRtPVSZqfDaCc5RGhJInkU3p5WHSoM5KB
         Vh8jCAxqixagZPlUN2KN71DnYEUJnSwmea0+19ZFHhubq6d4gL4J8Qsqr8CAzA6t3zYx
         ScTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902782; x=1782507582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jySa/Bi7vo6f9i4WegYtCHrqGBCugdKwEW8kHF7s+ig=;
        b=bVP8dSBJ92Bn8I/y0/cjThnBlmjPLPszsgWwQ9fR2ollisJ43vMaGxPA0A2afTlBmL
         +Ynl4L8X1VrtmsOqAjUjsxWt8fwYG0OleetvwgHDogV9LyWmC+w9Ew2eT6pqEiZe+UBK
         MYjmsWLW17PtAJVQacSLnk4mVDSwk7S0XppEzDgXk5tPWO0+TV9qwBA3TDIVsWs3fEki
         a9ROdLHI0ZRuzNyQ0r33YZD298rDifF/6Coe/jkUUgPngaDxfjxwPye4ggZut+iTv+bI
         ircqSjDj3/mq3z4qmSt/CtGE+PvDWuxA5l19ZDFnetmB9ayam9QpVm22M1vLBn6QSaY+
         WBYg==
X-Gm-Message-State: AOJu0YxO0/886xOZ3VnncxYIdnSgzieMM9q4dpMZrajrMG9nObGKxdm/
	zbsqgUpJYfoeEkEDj+NFkKbgXVxk7x0AaD2dtva+KZrYuU43X2X09qxpKWUoD4Sy
X-Gm-Gg: AfdE7cnsioeLOcsFzzQcTPEHKLuvfbHucJlfvMIwLjSFV7FEt0lg65GW3IGa2NbYQB4
	n85s7Ox+ntE1XQlHvMQImyexDtVWwE1ggsuWm8ppL2pxRCvzXE2v5vaKsvbonvwT2H91Ew1yqVc
	1Yz4T4ZI07dzHeTHFNCPIsCwJqp3mbM+SdSrxslnAjBK5m+DrO+qTw+PyJ+/4TSLPv1nnW5ZbaC
	WuCK+jIVfXQQ1I3XRsEYoBSECd+yo3XqcJwChjFO3lV2s06DRPqoWRnzRwLf3CM89AOE5h5mCGv
	kj66bS4rHwoKDs6macmvVNm6qV0Zsd3xAngGDPrIncfGpbvRkMxMhWVymciwazk9NcRW1EC4ccF
	mHh+AJB2uq/QC2zdh9A0TWOTwjQ0l8tKKXWqWWFTuv/X7cnhPP2EKcmyP5vI0mUs2cIx1SYh8RJ
	xqjVkRacC8gM/ls/GFLORo1EzBLNNZBcDCkwnhXCWbYV2DnxKmn7BS4oqtp1YczqALFhME807yn
	PIuKlmDfs6JLAWuMhyBYRItZvaxJRKcWi9nZc7FfSnmcOERnTttORE=
X-Received: by 2002:a05:600c:628f:b0:490:bd66:e522 with SMTP id 5b1f17b1804b1-49240e72434mr80436625e9.29.1781902781985;
        Fri, 19 Jun 2026 13:59:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924944fbbdsm11935655e9.12.2026.06.19.13.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:41 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 06/17] bpf: Track verifier reference diagnostic events
Date: Fri, 19 Jun 2026 22:59:19 +0200
Message-ID: <20260619205934.1312876-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6962; i=memxor@gmail.com; h=from:subject; bh=j/1UVJQ7QZjGfqYGmBd1WiSCTsZRamkxREH11q4VPxQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct05T+7VG21RZJpHkLlk4Vzivpb7kl0rWfgapnezbryh 2wIQ1dHKQuDGBeDrJgiS8n/fUzGJyp/B9ou44aZw8oEMoSBi1MAJpJTzcjQ15f8u/XQ6vwzIdJn khfP9tq4/eOxA/enPNXee+2QjvGHR4wMi39O3/1MNSqrYopBSZ/px599OYnXDy9YuOzhyYQph02 FeQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add reference acquire and release events to diagnostic history so Resource
Lifetime Safety reports can show the lifetime of a specific reference id along
the path.

Record acquisitions after the verifier assigns the reference id. Record
releases only after release_reference_nomark() succeeds, including the
kptr_xchg RCU conversion path and owning-to-non-owning conversion path that
consume an owning reference.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 53 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h | 11 +++++++++
 kernel/bpf/verifier.c    | 18 +++++++++++---
 3 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index f51b2860c11d..58cc7c18cf98 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1015,6 +1015,32 @@ void bpf_diag_record_stack_slot(struct bpf_verifier_env *env, u32 insn_idx,
 	bpf_diag_append_history(env, &event);
 }
 
+static void bpf_diag_record_ref(struct bpf_verifier_env *env, u32 insn_idx,
+				u8 kind, u32 ref_id)
+{
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = kind,
+		.ref.ref_id = ref_id,
+	};
+
+	bpf_diag_append_history(env, &event);
+}
+
+void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, u32 insn_idx,
+				 u32 ref_id)
+{
+	bpf_diag_record_ref(env, insn_idx, BPF_DIAG_HISTORY_REF_ACQUIRE,
+			    ref_id);
+}
+
+void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx,
+				 u32 ref_id)
+{
+	bpf_diag_record_ref(env, insn_idx, BPF_DIAG_HISTORY_REF_RELEASE,
+			    ref_id);
+}
+
 struct bpf_diag_history_filter {
 	const struct bpf_diag_history_opts *opts;
 	bool stack_slot_valid;
@@ -1136,6 +1162,10 @@ static int bpf_diag_history_start_idx(const struct bpf_diag_log *log,
 		    event->stack_arg.slot == opts->stack_arg_slot &&
 		    event->stack_arg.frameno == opts->frameno)
 			return i - 1;
+		if (opts->scope == BPF_DIAG_HISTORY_SCOPE_REF &&
+		    event->kind == BPF_DIAG_HISTORY_REF_ACQUIRE &&
+		    event->ref.ref_id == opts->ref_id)
+			return i - 1;
 	}
 
 	return 0;
@@ -1166,6 +1196,10 @@ bpf_diag_history_event_visible(const struct bpf_diag_history_event *event,
 		return filter->stack_slot_valid &&
 		       idx <= filter->stack_until_idx &&
 		       bpf_diag_stack_slot_matches(event, filter);
+	case BPF_DIAG_HISTORY_REF_ACQUIRE:
+	case BPF_DIAG_HISTORY_REF_RELEASE:
+		return opts->scope == BPF_DIAG_HISTORY_SCOPE_REF &&
+		       event->ref.ref_id == opts->ref_id;
 	default:
 		return false;
 	}
@@ -1536,6 +1570,20 @@ static void bpf_diag_print_stack_slot(struct bpf_verifier_env *env,
 			       off, fmt->old_buf, fmt->new_buf);
 }
 
+static void bpf_diag_print_ref_event(struct bpf_verifier_env *env,
+				     const struct bpf_diag_history_event *event)
+{
+	if (event->kind == BPF_DIAG_HISTORY_REF_ACQUIRE) {
+		bpf_diag_report_source(env, event->insn_idx, "acquired",
+				       "owned resource (id=%u)",
+				       event->ref.ref_id);
+		return;
+	}
+
+	bpf_diag_report_source(env, event->insn_idx, "released",
+			       "owned resource (id=%u)", event->ref.ref_id);
+}
+
 void bpf_diag_print_history(struct bpf_verifier_env *env,
 			    const struct bpf_diag_history_opts *opts)
 {
@@ -1585,6 +1633,11 @@ void bpf_diag_print_history(struct bpf_verifier_env *env,
 			bpf_diag_print_stack_slot(env, event);
 			printed = true;
 			break;
+		case BPF_DIAG_HISTORY_REF_ACQUIRE:
+		case BPF_DIAG_HISTORY_REF_RELEASE:
+			bpf_diag_print_ref_event(env, event);
+			printed = true;
+			break;
 		default:
 			break;
 		}
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 7af0a694890b..af8b738f7087 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -80,6 +80,9 @@ struct bpf_diag_history_event {
 			u8 reason;
 			struct bpf_diag_reg_snapshot old, new;
 		} stack_slot;
+		struct {
+			u32 ref_id;
+		} ref;
 	};
 };
 
@@ -88,12 +91,15 @@ enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_REG_MOD,
 	BPF_DIAG_HISTORY_STACK_ARG,
 	BPF_DIAG_HISTORY_STACK_SLOT,
+	BPF_DIAG_HISTORY_REF_ACQUIRE,
+	BPF_DIAG_HISTORY_REF_RELEASE,
 };
 
 enum bpf_diag_history_scope {
 	BPF_DIAG_HISTORY_SCOPE_ALL,
 	BPF_DIAG_HISTORY_SCOPE_REG,
 	BPF_DIAG_HISTORY_SCOPE_STACK_ARG,
+	BPF_DIAG_HISTORY_SCOPE_REF,
 };
 
 struct bpf_diag_history_opts {
@@ -101,6 +107,7 @@ struct bpf_diag_history_opts {
 	u32 frameno;
 	int regno;
 	int stack_arg_slot;
+	u32 ref_id;
 };
 
 bool bpf_diag_enabled(const struct bpf_verifier_env *env);
@@ -153,6 +160,10 @@ void bpf_diag_record_stack_slot(struct bpf_verifier_env *env, u32 insn_idx,
 				enum bpf_diag_stack_slot_reason reason,
 				const struct bpf_reg_state *old_reg,
 				const struct bpf_reg_state *new_reg);
+void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, u32 insn_idx,
+				 u32 ref_id);
+void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx,
+				 u32 ref_id);
 void bpf_diag_print_history(struct bpf_verifier_env *env,
 			    const struct bpf_diag_history_opts *opts);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fedabb6bb515..93941deb2cd8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1438,6 +1438,7 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 	s->type = REF_TYPE_PTR;
 	s->id = ++env->id_gen;
 	s->parent_id = parent_id;
+	bpf_diag_record_ref_acquire(env, insn_idx, s->id);
 	return s->id;
 }
 
@@ -9140,8 +9141,12 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	if (err)
 		return err;
 
-	if (find_reference_state(vstate, id))
-		WARN_ON_ONCE(release_reference_nomark(vstate, id));
+	if (find_reference_state(vstate, id)) {
+		err = release_reference_nomark(vstate, id);
+		WARN_ON_ONCE(err);
+		if (!err)
+			bpf_diag_record_ref_release(env, env->insn_idx, id);
+	}
 
 	while ((id = idstack_pop(idstack))) {
 		/*
@@ -9263,6 +9268,9 @@ static int ref_convert_alloc_rcu_protected(struct bpf_verifier_env *env, u32 id)
 	int err;
 
 	err = release_reference_nomark(env->cur_state, id);
+	if (err)
+		return err;
+	bpf_diag_record_ref_release(env, env->insn_idx, id);
 
 	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 		if (reg->id != id)
@@ -11746,8 +11754,12 @@ static void ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 id)
 {
 	struct bpf_func_state *unused;
 	struct bpf_reg_state *reg;
+	int err;
 
-	WARN_ON_ONCE(release_reference_nomark(env->cur_state, id));
+	err = release_reference_nomark(env->cur_state, id);
+	WARN_ON_ONCE(err);
+	if (!err)
+		bpf_diag_record_ref_release(env, env->insn_idx, id);
 
 	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
 		if (reg->id == id) {
-- 
2.53.0

