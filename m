Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758A407CC5
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641272; cv=none; b=eFYV1npM7jN6ipjEyOq//xhMx8Yf1Nzgme9XICoKyKVbrIojpSMQZ2RTI1pgj8dzGjBSDsZdCmMvif7U1ml8eNkKGRytxkYWfE6D2TPg6tVAoJSwhZGVr7NkC8Vd422k6HTeYxplIfuwjOi/RnlU0/HMbxDqcUe/EuxUv5W5tSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641272; c=relaxed/simple;
	bh=QkK1VQr46/67mXDvZ+UBnQ0OQB9suSwrjjOpLF/Zpkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slq1+qZzQfVn0c/Fg+KobKEpo17hWpgQ6hM2QfezPnveBHToaQ2LugCSDriQ3JvqpgJxhrOmPDleoLyR1zsSZHlKQ8oEjuR+P+pW7sr8TX50Osfq+UYNTcPng2MgCCO4f2S/shPQVES1h3QTm4VerDVHqA50ysxvyIGOBKCrfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDXfz5Mw; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDXfz5Mw"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-45ef1198766so830200f8f.0
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641270; x=1781246070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRKK79D1VuVwle9T/QR+z+pdybmgXMRCxK5J5YGNG8Q=;
        b=sDXfz5MwjLWcBMzEPsnr0vbG69vo6xc4F+l9IhQFSef7IROerRgaGS1A2ivuKmkQgj
         LGiHF9qRQ+xHLC1b8GBB3U2wKreOnvzIlrAAtMww7NOEp1iFgo8A5jeHZXej/wmii39Q
         7Tdz2Mty7GgqduXuGZyw5tUoyyaqTav9NnsTS1xph3fQebyBVHo59JozmV9SINoROLxy
         gScBYA97NggztydN+KzlJla0o6bNsozokQuKBBCZ0k88H+pOJ0bukpjdzP4E0cNW1Vbf
         OrUPsnJktki+sUYR1NgtlXaCmqBgnSax2VQLgkBsjkPlR/NOVyEd7B4OVycAAKF2qHGI
         sq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641270; x=1781246070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SRKK79D1VuVwle9T/QR+z+pdybmgXMRCxK5J5YGNG8Q=;
        b=OqllOMN/dQICvazt0YTpZ99+Ml2v6Um8hIZgKvvh6Dj5lnCgIme7+It8mHqaMfjIX7
         qLtwf69aRBHsYYX9r0ABhTqBZqFQJM9MnTUuPkBQhrhvheKEIVJZGdOvt/5bcloNSGKy
         tK18lahx1Gb4bh8UNf3RT2kz2dfpS2WADS48Hdja9TiyhnYzUfKcjOBb2J0lkhgEDEhn
         AFpmck0ba7jQXab+26ACeU4BRFVmbBrl9ChWJ8TSbIzisVk5vDJMdEaUW+dSHkvY8kcf
         6psfRjgeImJXgIphrF29rFS6DDTZpGaMfs3BnXDSD7oHgkBzVNrOiDRlK6SezcXV0Qbu
         RmgA==
X-Gm-Message-State: AOJu0Yy1VYD5JRQoxpksAQGT9C0LUSQOk1PNNR3IWjbbTweC5gCprw3B
	B1I8C9y7/0ZaltYifK+Mt/kTK9f6Sj5MIsWICG8lgI5cU9cBtdgOO/tSUrbr83LJ
X-Gm-Gg: Acq92OHzngkMotBT1FGJSsdF4pAtcVRBt6u6hOPA/p3UAz/xAEwyg7vrvE0mp7iYyvq
	y768p04JtwrxDQkLMt1OLmDJVRizQuvwU1JYzsfIHfNAwmKl0i8BA8Z2dL3ryDq/fj9RQI+eHli
	pU3F5Qzt3plRImEkoT72h0ggAyn8v7K64vd/HJksp1wgmhvS56tJ+QTNlr6V6VprxisUXzPJ/TT
	BTPjXWgbbRMAfBvy8FnOt1EyjvXIgv5OCA0g2qA/QWJux0xSJ0KUj1GPZjJMwhuDi1cOVOZZSeP
	RAGlBcci1AD6F1PD+GH9htuCiHhXe99K1J4dPcC0dCkTXntNczMHhKV2JemVjQYa0uMOJkybKFh
	6Fi3ORz3GUM+T1fvz9/gXjMw1RVgrCZA3oS7F11tMxkdTZRW1DJTzGkl2IYYRSBlAH5bT4wu2Im
	5IEGt6106DRN7xMASPeQnmxmqjeo2o9QiA6ebpRei90Fkg9oEi4qrO2Qs8O3fqqVRG1mqJ+11Zl
	ut47adXQWmKCdG3ON2MCHr8GCrVtI5kwlrtu8vOfTdSWWGijXpZYs/O+a5KJ7X2k+h175YzG7Sl
	2k2T5kOzluk=
X-Received: by 2002:a05:6000:4a06:b0:43d:7606:5a47 with SMTP id ffacd0b85a97d-46032b615bemr1626823f8f.2.1780641269720;
        Thu, 04 Jun 2026 23:34:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d40sm22714567f8f.26.2026.06.04.23.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 14/17] bpf: Report Policy helper and kfunc errors
Date: Fri,  5 Jun 2026 08:34:04 +0200
Message-ID: <20260605063412.974640-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6002; i=memxor@gmail.com; h=from:subject; bh=QkK1VQr46/67mXDvZ+UBnQ0OQB9suSwrjjOpLF/Zpkk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt/Rbvk/K0v5flRIf294JKAUGHXyRm38lQSxTtKxtj uRlt6kdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmIjMR4Y/vGfK/pZNvl8kdahN o9z1mIjerKPfTu5uqgvlmZ//vP5GNiPDnfNqNzJb/89fkp9atePb4mMm63xMXsXbH5j18p2DlZ4 7KwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected helper and kfunc allowability failures with Policy reports.
These reports explain which requested operation is forbidden and why, without
adding path history for non-path-dependent policy checks.

Cover helper program-type restrictions, GPL-only helpers, helper-specific
allow callbacks, kfunc allowability, and destructive kfunc capability checks.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 16 ++++++++++++++++
 kernel/bpf/diagnostics.h |  3 +++
 kernel/bpf/verifier.c    | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 24096bb7ca87..8d639b498ed4 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -920,6 +920,22 @@ void bpf_diag_report_program_structure(struct bpf_verifier_env *env,
 	bpf_diag_report_suggestion(env, "%s", suggestion);
 }
 
+void bpf_diag_report_policy(struct bpf_verifier_env *env, u32 insn_idx,
+			    const char *operation, const char *reason,
+			    const char *suggestion)
+{
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_POLICY,
+			       "operation is not allowed");
+	bpf_diag_report_reason(env, "The operation %s is not allowed: %s.",
+			       operation, reason);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!',
+			       "policy check failed for %s", operation);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
 				   int regno, const char *reg_name,
 				   const char *type_name,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 6648a66d0614..c309778fd2ff 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -203,6 +203,9 @@ void bpf_diag_report_program_structure(struct bpf_verifier_env *env,
 				       u32 insn_idx, const char *problem,
 				       const char *reason,
 				       const char *suggestion);
+void bpf_diag_report_policy(struct bpf_verifier_env *env, u32 insn_idx,
+			    const char *operation, const char *reason,
+			    const char *suggestion);
 
 void bpf_diag_clear_history(struct bpf_verifier_state *state);
 void bpf_diag_copy_history(struct bpf_verifier_state *dst,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 325c162e3df0..f81aad4aeb8e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2829,6 +2829,10 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 
 		if (!env->bpf_capable) {
 			verbose(env, "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
+			bpf_diag_report_policy(env, i,
+					       "bpf-to-bpf or kernel function call",
+					       "loading or calling other BPF or kernel functions requires CAP_BPF or CAP_SYS_ADMIN",
+					       "Load this program with the required capability, or avoid bpf-to-bpf and kernel function calls in unprivileged programs.");
 			return -EPERM;
 		}
 
@@ -10587,17 +10591,32 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (err) {
 		verbose(env, "program of this type cannot use helper %s#%d\n",
 			func_id_name(func_id), func_id);
+		scnprintf(operation, sizeof(operation), "helper %s#%d",
+			  func_id_name(func_id), func_id);
+			bpf_diag_report_policy(env, insn_idx, operation,
+					       "this program type does not allow the helper",
+					       "Use a helper allowed for this program type, or move the logic to a compatible program type.");
 		return err;
 	}
 
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
 	if (!env->prog->gpl_compatible && fn->gpl_only) {
 		verbose(env, "cannot call GPL-restricted function from non-GPL compatible program\n");
+		scnprintf(operation, sizeof(operation), "helper %s#%d",
+			  func_id_name(func_id), func_id);
+			bpf_diag_report_policy(env, insn_idx, operation,
+					       "this helper is restricted to GPL-compatible programs",
+					       "Use a GPL-compatible license, or replace the helper with one that is available to non-GPL programs.");
 		return -EINVAL;
 	}
 
 	if (fn->allowed && !fn->allowed(env->prog)) {
 		verbose(env, "helper call is not allowed in probe\n");
+		scnprintf(operation, sizeof(operation), "helper %s#%d",
+			  func_id_name(func_id), func_id);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "the helper-specific policy callback rejected this program",
+				       "Use the helper only from an allowed attach point or program configuration.");
 		return -EINVAL;
 	}
 
@@ -13519,8 +13538,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return 0;
 
 	err = bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
-	if (err == -EACCES && meta.func_name)
+	if (err == -EACCES && meta.func_name) {
 		verbose(env, "calling kernel function %s is not allowed\n", meta.func_name);
+		scnprintf(operation, sizeof(operation), "kfunc %s",
+			  meta.func_name);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "this program cannot call the kfunc",
+				       "Use a kfunc allowed for this program type and attach point, or change the program context.");
+	}
 	if (err)
 		return err;
 	desc_btf = meta.btf;
@@ -13561,6 +13586,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
 		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
+		scnprintf(operation, sizeof(operation), "destructive kfunc %s",
+			  meta.func_name);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "destructive kfuncs require CAP_SYS_BOOT",
+				       "Load the program with CAP_SYS_BOOT, or avoid destructive kfuncs.");
 		return -EACCES;
 	}
 
-- 
2.53.0

