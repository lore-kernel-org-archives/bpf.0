Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A73B52EA
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776395; cv=none; b=njn++k/vg+4FtUGIRoNczwTx2jHHnSbUw/Mm5hEwf41Gl/WLwzDZi4l13pQo7yW226FBRNyBsE/mUYV7gUQUEC5RIR9HfdSebn4fTuASbBAymvwP0xAKt4iv0sOef6t6WQnFDzAYh6RsWqwqzZ+PbK0eaBZUSH5uQI5fBvkEpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776395; c=relaxed/simple;
	bh=z5DhXUENBEnULRghgFLjBgB3sewx6zssWjqpqGQXszo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTpjEPA/NugJNdDI3W8gXlUe0ySiumLraBTYdOltzDn5dcQLxYxIcYZLjUEhI4ouehsmO+7yHfopS0u2D7E7yDgRpYxze1WLdd470L+csQSKN6nrzvcflKwhMTWe3E+nJbQ3dvWH3WXeBCdIj5RxdS+8ehu/hiDF6hVvG39GSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnXzUwbx; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnXzUwbx"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so7308585e9.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786776382; x=1787381182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0kyd51+qafVKioEMbvzQagiG/bKdBxe6FFXwyGgRMTE=;
        b=MnXzUwbx3UBwAZHexDKaNn2yNLZy9r48w9xm3/UN7Xyhvt3RIV7PQniXrAuGkFaSD6
         StRXs6dfR5Vvnp85qQARfnnqzOLfdMrV2iOQI4Dmv/lgihH8QFgOBrbvVIhC3749y7iu
         f8mdnronuVVXrUuIPKdIv9AsqoLZakpIiwEwEm1tsQ1ntf5VfmRmjqBPu6wc+Iq52Luw
         csz1GsjPRwSnre7bg+UCj0MWigoGcdcAa0GMcSciUWwhNk05vw5L6JHvf53Du+I3Iv/T
         4QGwj8Q5XJANUfAgYWVswnYVbxFDbI+R6Vwm+CX9213w22mb0TBjfFZQ6tM1ttl6EIDv
         sI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776382; x=1787381182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0kyd51+qafVKioEMbvzQagiG/bKdBxe6FFXwyGgRMTE=;
        b=G8NNURo8QNh7matbTSXyGEmAsWB82khIOlnmkvO1vKNXSEKXlzl4iCfVzLjmJe7/7f
         7oy+q3G89X2qJgK1kJ8kFYpNymzJUZsqNjAqcbqw86B2hwF4jQDG1Que8ssSzqtnbjXe
         wPJuMTHHi+j5VcBGJ7laBsgwr6MhjVhu/NHyf43rltLMnNXSwUtCldr5WUDB2dbGH9Tw
         dwOf87/qscAayBkPRvc+HYK0uPYvbxSLKbRpL7C6H7K+cHvsRvXnFFwufVsHMTxdjFTi
         EtCv4k5cmgJ+mVSDNCuODO3dl4TyroHHITbXh2T6zGq7hdVULyA6lfx96MdgaYg2/cET
         Ve8w==
X-Gm-Message-State: AOJu0YyzgWZTU8CaEqN37Mv2XiDNqxHBuyZZ8zCRv9HizWw6swFdBjYP
	cLiNCHEPnjEAL/RUp3Aw1xPUxjo+gtQsRCp9ROdvnQ77SiOdYVLofdnCj82qryV1
X-Gm-Gg: AR+sD11ZCTrPZ6E3/vK7uAlei3k5ANM2sEYTwUgosPQYUTj7YdIpSdY0Z74wIeSRFkn
	fHMEzZ7hvlD11d2kG7PPIoPO1KCoUPSZw5jZLS0ywS9D0LSMQNyuC6acGyDG7PgUnhPfoUN6KIq
	dOKGKzUyrltr+TW1b2kK5UL0T1N35W9zd3ZR8zG6xwlI8168VgLdKzHzK1/sYWYcf7r3nML6dvf
	/ntchOmwqAcDCCNT3Gn+P6AvmHURHEDmYVJbSv2gPaAjA59RPM/SOLJCEGBE3lbNTkRbD+iO98n
	RNrTaaU/D22tKGEWvYIC0Xvr10xGlDZzjniURkeeMF5nWYkKCe+qqwLxBo09cpHRuNZwDKkENc4
	lv+njWXsdIHsMT87bZ385VVL+qlVbbevSyaWligBjFw9mznnwl/e5hmhx5k33TxnEdUs2YnD4sA
	5dBZYslkj9pL7HdyG6J3QazCnrJ/bMDzPbSh9pm/3myvdUvRBiB7Ce1Hb2oIlAbxyq8r3q/w7Pi
	xlJbzE0dDf14ILxLvxkirGzjk8cdZ78EOzv4jkJ1fqvHBMRDfTZpoOYWU74s7AqbsGz1y9gu07P
	R40+SoSmG7QnEwCKEwxO3Gf4SaM=
X-Received: by 2002:a7b:c348:0:b0:499:795a:c60b with SMTP id 5b1f17b1804b1-499879a3c5fmr115219975e9.19.1786776382348;
        Fri, 14 Aug 2026 23:46:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899afa63sm92214965e9.1.2026.08.14.23.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:46:22 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 06/14] bpf: Track verifier reference diagnostic events
Date: Sat, 15 Aug 2026 08:46:01 +0200
Message-ID: <20260815064612.378577-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815064612.378577-1-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6255; i=memxor@gmail.com; h=from:subject; bh=z5DhXUENBEnULRghgFLjBgB3sewx6zssWjqpqGQXszo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauBy3tqyME5ilNU7nh0xXyIa41Wil70IX77Af7Dj9unv G998/91RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZiqsPI8OZUdojcvPW9x1fO l/t2yfTl7lj35J8mswzWplQKcxRWzAeqcJwd9+8jlzKf5on8hxbLDSQMpr9MFwlg/mr8zb1sz31 OAA==
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
 kernel/bpf/diagnostics.c | 28 ++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h |  2 ++
 kernel/bpf/verifier.c    | 32 +++++++++++++++++++++++++-------
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 2e8e75815581..ddeaff1e90b7 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -102,6 +102,8 @@ struct bpf_diag_reg_snapshot {
 enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_BRANCH,
 	BPF_DIAG_HISTORY_MOD,
+	BPF_DIAG_HISTORY_REF_ACQUIRE,
+	BPF_DIAG_HISTORY_REF_RELEASE,
 };
 
 struct bpf_diag_history_event {
@@ -119,6 +121,9 @@ struct bpf_diag_history_event {
 			u8 reason;
 			bool origin_valid;
 		} mod;
+		struct {
+			u32 ref_id;
+		} ref;
 	};
 };
 
@@ -1021,3 +1026,26 @@ void bpf_diag_record_scrub_stack(struct bpf_verifier_env *env,
 			diag_stack_range_target(state->diag_frame_id, state->frameno, min_off, max_off),
 			reason, NULL, NULL, NULL);
 }
+
+static void diag_record_ref(struct bpf_verifier_env *env, u32 insn_idx, u8 kind, u32 ref_id)
+{
+	struct bpf_diag_history_event event = {
+		.insn_idx = insn_idx,
+		.kind = kind,
+		.ref = {
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
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index c4e44b86e89d..d17b498a3f66 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -43,5 +43,7 @@ void bpf_diag_record_scrub(struct bpf_verifier_env *env, const struct bpf_reg_st
 void bpf_diag_record_scrub_stack(struct bpf_verifier_env *env,
 				 const struct bpf_func_state *state, s16 min_off, s16 max_off,
 				 enum bpf_diag_mod_reason reason);
+void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
+void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5929e40f18d..8e32fa5fa30a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -205,7 +205,8 @@ struct bpf_verifier_stack_elem {
 #define BPF_PRIV_STACK_MIN_SIZE		64
 
 static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int parent_id);
-static int release_reference_nomark(struct bpf_verifier_state *state, int id);
+static int __release_reference_nomark(struct bpf_verifier_state *state, int id);
+static int release_reference_nomark(struct bpf_verifier_env *env, int id);
 static int release_reference(struct bpf_verifier_env *env, int id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env);
@@ -1418,6 +1419,7 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 	s->type = REF_TYPE_PTR;
 	s->id = ++env->id_gen;
 	s->parent_id = parent_id;
+	bpf_diag_record_ref_acquire(env, insn_idx, s->id);
 	return s->id;
 }
 
@@ -9017,7 +9019,7 @@ static void mark_pkt_end(struct bpf_verifier_state *vstate, int regn, bool range
 		reg->range = AT_PKT_END;
 }
 
-static int release_reference_nomark(struct bpf_verifier_state *state, int id)
+static int __release_reference_nomark(struct bpf_verifier_state *state, int id)
 {
 	int i;
 
@@ -9032,6 +9034,16 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int id)
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
@@ -9074,8 +9086,10 @@ static int release_reference(struct bpf_verifier_env *env, int id)
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
@@ -9164,7 +9178,9 @@ static int ref_convert_alloc_rcu_protected(struct bpf_verifier_env *env, u32 id)
 	struct bpf_reg_state *reg;
 	int err;
 
-	err = release_reference_nomark(env->cur_state, id);
+	err = release_reference_nomark(env, id);
+	if (err)
+		return err;
 
 	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 		if (reg->id != id)
@@ -11757,8 +11773,10 @@ static void ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 id)
 {
 	struct bpf_func_state *unused;
 	struct bpf_reg_state *reg;
+	int err;
 
-	WARN_ON_ONCE(release_reference_nomark(env->cur_state, id));
+	err = release_reference_nomark(env, id);
+	WARN_ON_ONCE(err);
 
 	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
 		if (reg->id == id) {
@@ -15890,7 +15908,7 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 * No one could have freed the reference state before
 		 * doing the NULL check.
 		 */
-		WARN_ON_ONCE(release_reference_nomark(vstate, id));
+		WARN_ON_ONCE(__release_reference_nomark(vstate, id));
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		mark_ptr_or_null_reg(state, reg, id, is_null);
-- 
2.53.0

