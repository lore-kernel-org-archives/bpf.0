Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F843900D
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957174; cv=none; b=A1OpgaLxmwD5qNFkOqSbexgByQ2AziGdDzU1HAHhW86QW/GEgcwJDcliZmsY7K6WAvL96bAIXsRknPjV+J7nNNrN7SCX/erDVJJGZphsqvrBP8KrSKUbtjrjpSTvpgD/ia14vBjwSNL+tpzFbXXda5/qNtzlqTkv+9hUKL/Kcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957174; c=relaxed/simple;
	bh=tPNXFlZx7DuHOWSrDfr2yUibJ1fkZ9R1UlTLxsvOCss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFVBX6Os2i/02wH81fpgpmFuJVrYGpLB6jXc8n05NWVyyp+czxMqgFr12Y+cgUHI/L4s3labuG0L8pZ0bsB3JUDigbq+000p2PhdwBtX9h0vkkSxllMHavMweLqfAXaFKmdze87Ngb3E5OJE9ZrU4XF1ZjujyYN4gCfur6zAW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApEde3O2; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApEde3O2"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso931039f8f.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957170; x=1784561970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2hHLFrSnsSwINmFPnX9BjYC5iuYQwAT+fig0dfNQgc=;
        b=ApEde3O2PWYPFMphLkHqShb3088yLxSiDpQ0TaIpwzRFdZBXi7NTpmykRztjrPu0Vb
         CRKrQ/NtnSiPoH4qyZHpaX+7hQ64uRVrTwvXpwQeojvBo8ue0rJQf6WgCT4OOrJUpRuj
         cO+MmGp3du3Hr0E1yZF1fgc3rjPgE5pIVqOO3PTecaeDklaS14A1TAN4/y5mEPG5j22Z
         X7M4KhNIvqXN6YOPdVyigjphIqfm7tyNfEiQ5GgyBa7UI1O70oG1Jt1gMHyTx+sA/B1d
         bISgM3jynp6J6Ndz6JBZwWVzfDLIpJzkGwwbvlVA9Prfju4jnXD2HqSV/ndjjbMaLfY1
         RaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957170; x=1784561970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2hHLFrSnsSwINmFPnX9BjYC5iuYQwAT+fig0dfNQgc=;
        b=WZEPxyLahhKJFsNv2KBc2AALKVaIIBKm2bGCC/HsTdJhGGiVO1T92UxMMBL234pgoF
         0S6/dS/iTg5gRD+2OC6vePW7+htyZ0jAUkP96i7dl7CmGwIGH80CddFI0ZXtWNau1CTa
         Cd3IwjCr3ud3WS243F2xyPv9c1U2Ngzd8lotq785c/mG/XJ44rp9lKA7hcW8ZqekTNnx
         inkJ8em4YcQIQpeFDC/tpX5mhrBguc7cVABmy5pm02vWPWPGCiYjjpmpwc1YIv6znE09
         t6sJAxJ4yIiw0w9GmmsjqCJzS5Zb705NX028ctmVFloGaW/Rgho7nduYPjujI585hwjH
         nVRA==
X-Gm-Message-State: AOJu0Yy4yCuRQn5i3Nugi4ZWpZnSzIJP7FzPUQhEV6rfnAzsVJX8ZT+w
	Flzc4VEKNlMa73OGmlQElKOoPuma4BMZy2bBf7fuEYI+wUKHhoTv6x2nKfpoxtpq
X-Gm-Gg: AfdE7cnVHp7Jkvz4TFeQaXs9yKzxRjWC9J8zpJSkvtWR1LrIHg1S50McTsye5IyW4s0
	T5N7iPogULVx8kFL/elWGRxgqoUC9evcPx4SschhH58EcJ60qffguYr6A2HpBcxhmfWatWFIjmV
	D74fsP5hfHBTmOc90UgQSYds97k7iSTIEhfCh1DapspQ7Hprx2VGwGNOv/pt0PmMwN1eBxWIOw+
	yEDGa5w5wGpf05D8HGqmzJYmat3qcKWuSJopTm9YvAVvjKRKxxgF2X+MNsvoQVF7r6aJ2flwvi+
	Ml705FhCnEJChrhICDSbdU8RJC5Bij57qDICYHxzmAtmN/Ug6mDQNRL6wBmn97zh1YrOJMMXzuu
	U2JHI+46M9Iau+DwiQPEyWMzOdOMYOL8HqbrH81wcZnGNJoGYrQZKr4cYOsr9bNnMEV3TeyM/AP
	SS1RzVmGSBQcUL3KZV1yjKyfrfzjwt/NmyJjjXJhq0Fm2qfVoRBxOlg9T+6OEjcTT1Hhl8QoCvJ
	sfIuuhSARboawbDKgnqNTNWFRg1R5Z1SZ1K96U+ySMx7R88CPqgUza5hMht1JG3yg==
X-Received: by 2002:a5d:588b:0:b0:475:f0f0:9ec8 with SMTP id ffacd0b85a97d-47f2dcec514mr11402284f8f.51.1783957169808;
        Mon, 13 Jul 2026 08:39:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96cfsm160314f8f.20.2026.07.13.08.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 14/17] bpf: Report Policy helper and kfunc errors
Date: Mon, 13 Jul 2026 17:39:03 +0200
Message-ID: <20260713153910.2556007-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6423; i=memxor@gmail.com; h=from:subject; bh=tPNXFlZx7DuHOWSrDfr2yUibJ1fkZ9R1UlTLxsvOCss=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURclAksFj9yzdK7lLyvpEQz8tr3rNd8LobBd3bsICd 5dTu0Q6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJGaPEaGa9L50hvW5rCcErm0 3GGuzq17PxdNa9aPt1b+XNh+59Kz/4wM97X7yudKOIhOKLIRO6TGK7pqp7WB1PPWa/Nn9bS+EF3 DCQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected helper and kfunc allowability failures with Policy reports.
These reports explain which requested operation is forbidden and why, without
adding path history for non-path-dependent policy checks.

Cover unprivileged bpf2bpf and kfunc use, helper program-type restrictions,
GPL-only helpers, helper-specific allow callbacks, kfunc allowability, and
destructive kfunc capability checks.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 13 +++++++++++++
 kernel/bpf/diagnostics.h |  2 ++
 kernel/bpf/verifier.c    | 37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 5496e7a0235b..8bf5aef0315b 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1296,6 +1296,19 @@ void bpf_diag_report_program_structure(struct bpf_verifier_env *env, u32 insn_id
 
 	diag_report_suggestion(env, "%s", suggestion);
 }
+
+void bpf_diag_report_policy(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+			    const char *reason, const char *suggestion)
+{
+	bpf_diag_report_header(env, CATEGORY_POLICY, "operation is not allowed");
+	diag_report_reason(env, "The operation %s is not allowed: %s.", operation, reason);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "policy check failed for %s", operation);
+
+	diag_report_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				   const char *reg_name, const struct bpf_reg_state *reg,
 				   enum bpf_diag_invalid_deref_kind kind, s64 offset)
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index bb29f4235a68..64ab9de2bbf6 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -171,6 +171,8 @@ void bpf_diag_ctx(struct bpf_verifier_env *env, enum bpf_diag_ctx_report report,
 void bpf_diag_report_program_structure(struct bpf_verifier_env *env, u32 insn_idx,
 				       const char *problem, const char *suggestion,
 				       const char *reason_fmt, ...) __printf(5, 6);
+void bpf_diag_report_policy(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+			    const char *reason, const char *suggestion);
 int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 44e1907ac792..c67646f98134 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2963,6 +2963,12 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 
 		if (!env->bpf_capable) {
 			verbose(env, "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
+			bpf_diag_report_policy(env, i, "bpf-to-bpf or kernel function call",
+					       "loading or calling other BPF or kernel functions "
+					       "requires CAP_BPF or CAP_SYS_ADMIN",
+					       "Load this program with the required capability, or "
+					       "avoid bpf-to-bpf and kernel function calls in "
+					       "unprivileged programs.");
 			return -EPERM;
 		}
 
@@ -11030,17 +11036,35 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (err) {
 		verbose(env, "program of this type cannot use helper %s#%d\n",
 			func_id_name(func_id), func_id);
+		operation = bpf_diag_scratch_printf(env, 1, "helper %s#%d", func_id_name(func_id),
+						    func_id);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "this program type does not allow the helper",
+				       "Use a helper allowed for this program type, or move the "
+				       "logic to a compatible program type.");
 		return err;
 	}
 
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
 	if (!env->prog->gpl_compatible && fn->gpl_only) {
 		verbose(env, "cannot call GPL-restricted function from non-GPL compatible program\n");
+		operation = bpf_diag_scratch_printf(env, 1, "helper %s#%d", func_id_name(func_id),
+						    func_id);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "this helper is restricted to GPL-compatible programs",
+				       "Use a GPL-compatible license, or replace the helper with "
+				       "one that is available to non-GPL programs.");
 		return -EINVAL;
 	}
 
 	if (fn->allowed && !fn->allowed(env->prog)) {
 		verbose(env, "helper call is not allowed in probe\n");
+		operation = bpf_diag_scratch_printf(env, 1, "helper %s#%d", func_id_name(func_id),
+						    func_id);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "the helper-specific policy callback rejected this program",
+				       "Use the helper only from an allowed attach point or "
+				       "program configuration.");
 		return -EINVAL;
 	}
 
@@ -13961,8 +13985,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return 0;
 
 	err = bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
-	if (err == -EACCES && meta.func_name)
+	if (err == -EACCES && meta.func_name) {
 		verbose(env, "calling kernel function %s is not allowed\n", meta.func_name);
+		operation = bpf_diag_scratch_printf(env, 1, "kfunc %s", meta.func_name);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "this program cannot call the kfunc",
+				       "Use a kfunc allowed for this program type and attach "
+				       "point, or change the program context.");
+	}
 	if (err)
 		return err;
 	desc_btf = meta.btf;
@@ -14003,6 +14033,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
 		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
+		operation = bpf_diag_scratch_printf(env, 1, "destructive kfunc %s", meta.func_name);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "destructive kfuncs require CAP_SYS_BOOT",
+				       "Load the program with CAP_SYS_BOOT, or avoid destructive "
+				       "kfuncs.");
 		return -EACCES;
 	}
 
-- 
2.53.0

