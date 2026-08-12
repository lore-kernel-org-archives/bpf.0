Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4B41CB26
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577623; cv=none; b=Ji5OfeTZVj5uKQMDyD++Br42DxfX/MpyanTjmnOWfvolWI8jhwgtr3URp+VY0Uu9tHtMY+8i55J24BsApFO46Jl3VfoU7jMmCJClO1MgI7cSTDUVG748dIPlpveosNiFgqJ91+QK5KiR1vCiY/OxSdtkR/bI+TBjjSkMJGIpZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577623; c=relaxed/simple;
	bh=v/0w/pUo9MKphJ0xx3GlpkR97qpAeH7Hj8wdwJkkNC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgwcTUc31ypQACBf61+hPKUd0naadyaEJ+GrteKfwKP/bVrc+TjjPkPoOoiTDascni8HhGHom8evvXI6wMl9jIUYa0rG7LSNx5sv5jCEcp88eNWzAJGpfmNkQrtsABd+rBeNs3Zb+5UCOzaYKcqARy6iFuhARLGw/uh1VCHMIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbpMaKja; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbpMaKja"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fd1b2021fso17055f8f.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577619; x=1787182419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WOg7/8gNKH1UEFkbWWNVKM2p9d1jc3c7dY6hR4GZGJA=;
        b=VbpMaKja7VxigV2XY3iMY2DZ+aMSmLhIO2ZW56SqJS82AxH1DlWKAX6INglt2weTZF
         5iGkY/Xf4S0e7LREiRML9Cr8Rzxo/URu8VdFcEIu/7aUzhck5UxcIh/nW2LqCiDZisfi
         Dto9trxFYlJNgHz2OcwHsS3IDIGPES2TvGZNoMxP5KZBZeIQqmz3ooVZNRXfv+k2oqwS
         VTDvyN6+8Y1p+mBVaFQtTMoMGMpBRNZfAH2CbwVFnwcp5Wq93Un3b7v7FDRSwgwyRNVp
         +pxsGgiMY/Z94ePR7nBmhccAiJ5ohYkR3M7wyCieR+iiiNNPAIir/F+o1kVVQfAPOdTd
         WGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577619; x=1787182419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WOg7/8gNKH1UEFkbWWNVKM2p9d1jc3c7dY6hR4GZGJA=;
        b=DsGTdhCFfD4bM31+gqLrD5+ncU7wEwuY7Hn82LDSe0s54a97TQYAPdV9FLiFs9+7xw
         gD4W6fy5bL+SVDZ8qZk+w19bpGWkXMLFmjYlyajMUn84WRqHEWB4V12zUvsxKS7XgVtW
         1oI07hoKiuEtvc10UtlSMBVU1zH8saJ9OsvUH9+UugY5ihn4CSqrywJpM0mR7qYeXzUm
         rDdblk/MxmSgJrDEgVl3jsag75XYsadr2F81n3h02zpfFO4LylC7olfg4OFH8CLacS4U
         Dyiko1lllxiqiFDLRyOsbKqodTuTQaspUOmk1nuQ7l6dPlIYpiJcaCeBm+t+bPj7f4s+
         Z5XQ==
X-Gm-Message-State: AOJu0YxdJDpZSnnEL3VSy0S5DLkJCjQpsWnptyZUkapZz4rJCQ+tuyNC
	U/vzsODcgyy8/H3GoDXhlhUBIjLv8hFIepkQdzV+J6ayiPIFbPlSLq87F/PCVb91
X-Gm-Gg: AR+sD11EacfIx9KAZ89GLArXTg0/9c2JZkIDzQ+RK2GmoGKKmkYXag1lIOQvwpmZm0L
	QP9ild+PuacBz1z8wMwSt0n7I6rd+DxbA6DRWmzlvzbUbN0gPyRfeAVcvt+x/lL6aFcxYD6+uXQ
	00NG1AB+QaJAZ1kg0qW4Nb5agHcN70w6K1vzTd6HyYab3DFPXMC4ytrJJpXUjsvFEWJHjJhsUrG
	ygpHAR5A/rvC59NLXvFcNGCTkc6nrFY5hx9RUanyifn2ypCd5GJtmTyEYRN1V59qLwP4Qm4uuiY
	sDw8O/Q23na1V9JOljJPWlASWd453sGYY5aVIOptD1ZjBeYyNxWYIcqu/BP1lOoP1IG9T5B5rL1
	IAWFKEFZ/f93YC5urxrP2aFLQzjgfugWR6kj0q2pKc0Jgjz1IHJDoAiEKq8tArLBtt24KiBzBxH
	53ZujeMi0PBD9QJXwbBpx0egalEA83szqVF5YBoAjnddvUGszZIu+u5fnVFKN0vndse4+8FgvPP
	HwzHAqMB+vurWqknLFm1EETJ9f1OkksNbwzcZjl4064dVY97cU6QJojDy7eA5kA09q+UmC4Bcup
	eA/WGxcu0Cs0VujzRqGSuUaCXHc=
X-Received: by 2002:a5d:5e10:0:b0:481:5276:e4e3 with SMTP id ffacd0b85a97d-48159ff1154mr1471036f8f.19.1786577619252;
        Wed, 12 Aug 2026 16:33:39 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a4fa54asm1605706f8f.0.2026.08.12.16.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:38 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 06/16] bpf: Track verifier reference diagnostic events
Date: Thu, 13 Aug 2026 01:33:09 +0200
Message-ID: <20260812233326.3575958-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6263; i=memxor@gmail.com; h=from:subject; bh=v/0w/pUo9MKphJ0xx3GlpkR97qpAeH7Hj8wdwJkkNC8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQfvySSNDgZ0Hpt38aPrz4WFFzQ1xCvkTxFrPRPjuc 90T0M3TUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIl8PcPw36PXwf+84ALLtKPJ X/NE/9zO+pqrtS3i4kLNpV/btV/8jWJkmLGCbfFip7Rj3XKvhJLvm/bzfNW77VHvX2Bi8+3wOdm LnAA=
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
index 460bb83ae33d..0143ffe6fa03 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -47,6 +47,8 @@ struct bpf_diag_reg_snapshot {
 enum bpf_diag_history_kind {
 	BPF_DIAG_HISTORY_BRANCH,
 	BPF_DIAG_HISTORY_MOD,
+	BPF_DIAG_HISTORY_REF_ACQUIRE,
+	BPF_DIAG_HISTORY_REF_RELEASE,
 };
 
 struct bpf_diag_history_event {
@@ -64,6 +66,9 @@ struct bpf_diag_history_event {
 			u8 reason;
 			bool origin_valid;
 		} mod;
+		struct {
+			u32 ref_id;
+		} ref;
 	};
 };
 
@@ -939,3 +944,26 @@ void bpf_diag_record_scrub_stack(struct bpf_verifier_env *env, u32 frameno, s16
 			    bpf_diag_stack_range_target(frameno, min_off, max_off), reason,
 			    NULL, NULL, NULL);
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
index 8785f8d9a9ca..40fe161525b9 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -103,5 +103,7 @@ void bpf_diag_record_scrub(struct bpf_verifier_env *env, const struct bpf_reg_st
 			   enum bpf_diag_mod_reason reason);
 void bpf_diag_record_scrub_stack(struct bpf_verifier_env *env, u32 frameno, s16 min_off,
 				 s16 max_off, enum bpf_diag_mod_reason reason);
+void bpf_diag_record_ref_acquire(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
+void bpf_diag_record_ref_release(struct bpf_verifier_env *env, u32 insn_idx, u32 ref_id);
 
 #endif /* __BPF_DIAGNOSTICS_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ed8a239a964d..4f3416700ad7 100644
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
@@ -1419,6 +1420,7 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 	s->type = REF_TYPE_PTR;
 	s->id = ++env->id_gen;
 	s->parent_id = parent_id;
+	bpf_diag_record_ref_acquire(env, insn_idx, s->id);
 	return s->id;
 }
 
@@ -8976,7 +8978,7 @@ static void mark_pkt_end(struct bpf_verifier_state *vstate, int regn, bool range
 		reg->range = AT_PKT_END;
 }
 
-static int release_reference_nomark(struct bpf_verifier_state *state, int id)
+static int __release_reference_nomark(struct bpf_verifier_state *state, int id)
 {
 	int i;
 
@@ -8991,6 +8993,16 @@ static int release_reference_nomark(struct bpf_verifier_state *state, int id)
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
@@ -9033,8 +9045,10 @@ static int release_reference(struct bpf_verifier_env *env, int id)
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
@@ -9126,7 +9140,9 @@ static int ref_convert_alloc_rcu_protected(struct bpf_verifier_env *env, u32 id)
 	struct bpf_reg_state *reg;
 	int err;
 
-	err = release_reference_nomark(env->cur_state, id);
+	err = release_reference_nomark(env, id);
+	if (err)
+		return err;
 
 	bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 		if (reg->id != id)
@@ -11670,8 +11686,10 @@ static void ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 id)
 {
 	struct bpf_func_state *unused;
 	struct bpf_reg_state *reg;
+	int err;
 
-	WARN_ON_ONCE(release_reference_nomark(env->cur_state, id));
+	err = release_reference_nomark(env, id);
+	WARN_ON_ONCE(err);
 
 	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
 		if (reg->id == id) {
@@ -15803,7 +15821,7 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 * No one could have freed the reference state before
 		 * doing the NULL check.
 		 */
-		WARN_ON_ONCE(release_reference_nomark(vstate, id));
+		WARN_ON_ONCE(__release_reference_nomark(vstate, id));
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
 		mark_ptr_or_null_reg(state, reg, id, is_null);
-- 
2.53.0

