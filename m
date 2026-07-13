Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F383DF001
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957175; cv=none; b=g0N1ZlmytJj3A8cSrFQozIBGV+Go4Rzyw8c3+gDUw6WLAD0XQ7zCFdzcmfZZgl7IlHZ1XgAKGnehlRUwqLpeCg4FOK6YzCz5f+MnOT/pYEkZUvoNaH1/wcRSlVrBbiDwRF+xDw7kpQG3kI3gDKqkkwXE/ep/yDH9kalv6naF4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957175; c=relaxed/simple;
	bh=bcMtLfGWMJQNIqk0MGwvLy/12lR1s81Gi6heGoigo+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joSM/UI7/skjMKtjaonygj9RsAbL/Ist0IJnJVV1Avw9Enj+ygegXUr5V6PdPFeM3VSpPJwK/D4vfekQ7zzlOoS0DK4uWUkH8d9/Sl0ZW8EQ++/aCsSOaFuxMnadNSTXk2pmDv1fhngcLzSAIpafmb5hB2q6pVOeUwjXwZhnPs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2FjKWla; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2FjKWla"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so14127925e9.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957173; x=1784561973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uyXv1jlGNi5gWQHSrHKfaHv4rZ648rwU5hHD0pjWKmI=;
        b=R2FjKWlaNo7TKX3DqBaWyx868+zE1Vg+70H81fg+AMHcUW7cuq0qxnSSEAqyD91j6g
         pKlKLCejUR34edoztZ4JdIhGdUN/1MF0RiMTuuUoWkYd92lFl+N5825gPCTe9QD9ndI6
         WL407+bEOpwfCNOLWPtSxX3fhPye+JI7Gjtz/8TE32rHdU7TXltsFx194NzYrJHetR0U
         nKITowJ6rXN+XvmttgYC9+AFEJ+LT+cnJYLyas9dCpISypf9FLGkXAYlcBNMgj6/14S/
         AjJtBPmqDzaxb55+h2QsdX/iPTuwpmECEWmP78/iR3ah8dwBW2VdIi5n4Vl0GsCe7rGZ
         lYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957173; x=1784561973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uyXv1jlGNi5gWQHSrHKfaHv4rZ648rwU5hHD0pjWKmI=;
        b=hmhKAhZJPzNlYHZykH0TCALmIMvcI2M+N3EhWCNwScapZuvIg5peTZ+Md0BRk7sR0k
         C/6p6wANInUc6l1/HPE/cIqVxF/wcoTyrhbnkASwFvHeD4FfDUqFhQ4xY3lnBvmLWmP4
         gCxqyGTAojJTGL5ubO3wsJIePUHpQcC8Vyuxmgk76n571ajaHwzSrtZV+/qodpaPf2WQ
         vZrUuAZpK14QGMIcuOUevh0ACAVo6KJkyGa5Dnn3w1HD5+am7K9yujTYbRBemHWw1rG9
         0EFB8bubUiyJrKCz5pcuE8pVs56Lfozf2q4yNFyun/PLMhsS5AG8ETPyBMAkli+thHwR
         cgGg==
X-Gm-Message-State: AOJu0Yyq68ZG6aXJ+Z8w0gUs/+wkR7mD9Ay2DTnoekV4ra8FUAabGhIo
	fTv/7ALC4h9s6RzF41xw5bEbDH+m12x4UMDGcjqf6Uz1METaAF8W7pnof+CuCU0R
X-Gm-Gg: AfdE7cldfYWnTHmfNj0yFaFXziVEsAZcbY4c7stxEv9irhR8mZML62hhZPA6QkX8RR6
	0/SJouEkocd7qXpq8VlhNmubl92fARCwBDnAvs8u9mDflgAVJoj2nqFfym+e67MLmIsYN5bsulf
	bc8V/te+pcsqMphakSY8l8xK4kDAV+ZNFYycN2HRKnAPx8m9j7gv/6ndfjlnGTobkxl+AFMXtfo
	cWwTP0w/5TrndUxr8MtchgYOETEUxfBpp9HhZFGQ0WErBPcgDVGFXDBFa4/nBXky7YsNnDx4YX7
	P01eYsp1Q9XfJrHFbZ+M4C+FCi3Zkjmyzje6gnVDiPqHiPFEXQNEEmZBR6H68glBtmc+ub9r5HQ
	XnPjzDZPJHwXvACI3G9SKhF9YEZZ0wzdkgVS3rg1MZSoW1AG/bN+TxEFSPDoIK0/oIat4GDAG6U
	tDFaZFHJRL1QSBAXhsTqkEKu245x7CsaVwCbcGqNGt12PHs/R5Nu6pnAqO0rlWtuEVtX+6iPbLd
	ihkxS12ddkEEPRr4TPYOe8cGAxw150unRFdnvhl7tKO0xqHcaUGHoA=
X-Received: by 2002:a05:600c:4746:b0:493:e034:a3b5 with SMTP id 5b1f17b1804b1-493f8818cb0mr109982975e9.24.1783957172293;
        Mon, 13 Jul 2026 08:39:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508727fc0sm3534735e9.6.2026.07.13.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 16/17] bpf: Report Verifier Internal errors
Date: Mon, 13 Jul 2026 17:39:05 +0200
Message-ID: <20260713153910.2556007-17-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5322; i=memxor@gmail.com; h=from:subject; bh=bcMtLfGWMJQNIqk0MGwvLy/12lR1s81Gi6heGoigo+c=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISuURcnf02Nj7sn89NDY1oytbk/em2ec+/lU2tFD51s14 1yOD10dpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMjxKIY/HNtX9XIdjVz082jp vUXsqwrenWUpscyOWiEQtdcydmn2dkaGmW7Tuyx3rT72w3+y1k/uink30yL+fWXa9rChfdfSpR/ juQE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected existing internal-error paths with Verifier Internal Error
reports. These reports avoid suggesting source-level fixes and instead identify
the verifier invariant that failed.

Cover non-overwritten BPF_PTR_POISON helper argument types and inconsistent
kfunc graph-node argument classification.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 10 +++++---
 kernel/bpf/diagnostics.c     | 50 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 13 +++++-----
 3 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 625ea3e394a2..a120110aaf3e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1090,6 +1090,8 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 				  u32 insn_off,
 				  const char *prefix_fmt, ...);
 
+__printf(2, 3) void bpf_verifier_log_bug(struct bpf_verifier_env *env, const char *fmt, ...);
+
 #define verifier_bug_if(cond, env, fmt, args...)						\
 	({											\
 		bool __cond = (cond);								\
@@ -1097,10 +1099,10 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 			verifier_bug(env, fmt " (" #cond ")", ##args);				\
 		(__cond);									\
 	})
-#define verifier_bug(env, fmt, args...)								\
-	({											\
-		BPF_WARN_ONCE(1, "verifier bug: " fmt "\n", ##args);				\
-		bpf_log(&env->log, "verifier bug: " fmt "\n", ##args);				\
+#define verifier_bug(env, fmt, args...)                              \
+	({                                                           \
+		BPF_WARN_ONCE(1, "verifier bug: " fmt "\n", ##args); \
+		bpf_verifier_log_bug(env, fmt, ##args);              \
 	})
 
 static inline void mark_prune_point(struct bpf_verifier_env *env, int idx)
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index e2772c1deaff..eb4c2817e0f1 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1346,6 +1346,56 @@ void bpf_diag_report_limit(struct bpf_verifier_env *env, u32 insn_idx, const cha
 	diag_report_suggestion(env, "%s", suggestion);
 }
 
+static void diag_internal_error(struct bpf_verifier_env *env, u32 insn_idx, const char *problem,
+				const char *reason)
+{
+	bpf_diag_report_header(env, CATEGORY_VERIFIER_INTERNAL_ERROR, problem);
+	diag_report_reason(env, "The verifier hit an internal error: %s", reason);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
+
+	diag_report_suggestion(env, "Report this problem to bpf@vger.kernel.org with the full "
+				    "verifier log and program.");
+}
+
+void bpf_verifier_log_bug(struct bpf_verifier_env *env, const char *fmt, ...)
+{
+	const char *fallback = "the verifier could not format details for this invariant violation";
+	va_list args, copy;
+	char *reason;
+	size_t len;
+
+	va_start(args, fmt);
+	if (bpf_verifier_log_needed(&env->log)) {
+		bpf_verifier_log_write(env, "verifier bug: ");
+		va_copy(copy, args);
+		bpf_verifier_vlog(&env->log, fmt, copy);
+		va_end(copy);
+		bpf_verifier_log_write(env, "\n");
+	}
+
+	if (!bpf_diag_enabled(env))
+		goto out;
+
+	va_copy(copy, args);
+	reason = kvasprintf(GFP_KERNEL_ACCOUNT, fmt, copy);
+	va_end(copy);
+	if (!reason) {
+		diag_internal_error(env, env->insn_idx, "verifier invariant violation", fallback);
+		goto out;
+	}
+
+	len = strlen(reason);
+	while (len && reason[len - 1] == '\n')
+		reason[--len] = '\0';
+	diag_internal_error(env, env->insn_idx, "verifier invariant violation",
+			    *reason ? reason : fallback);
+	kfree(reason);
+out:
+	va_end(args);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				   const char *reg_name, const struct bpf_reg_state *reg,
 				   enum bpf_diag_invalid_deref_kind kind, s64 offset)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 552b3d4dd5ae..f7c5beb88217 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8650,9 +8650,8 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 				return -EACCES;
 		} else {
 			if (arg_btf_id == BPF_PTR_POISON) {
-				verbose(env, "verifier internal error:");
-				verbose(env, "%s has non-overwritten BPF_PTR_POISON type\n",
-					reg_arg_name(env, argno));
+				verifier_bug(env, "%s has non-overwritten BPF_PTR_POISON type",
+					     reg_arg_name(env, argno));
 				return -EACCES;
 			}
 
@@ -12748,14 +12747,14 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_right]);
 		break;
 	default:
-		verbose(env, "verifier internal error: unexpected graph node argument type %s\n",
-			btf_field_type_name(node_field_type));
+		verifier_bug(env, "unexpected graph node argument type %s",
+			     btf_field_type_name(node_field_type));
 		return false;
 	}
 
 	if (!ret)
-		verbose(env, "verifier internal error: %s node arg for unknown kfunc\n",
-			btf_field_type_name(node_field_type));
+		verifier_bug(env, "%s node arg for unknown kfunc",
+			     btf_field_type_name(node_field_type));
 	return ret;
 }
 
-- 
2.53.0

