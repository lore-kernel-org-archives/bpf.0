Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8E42DFE6
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577636; cv=none; b=eJXdY4SjWxG/fpda3+Oaw1wY70qSwHkZh4YMreIUuHsbGAFhwND3w10q1JSDXVfohguB5Yf29KD/isQ4qQ9wj7HYefZFC1q+hTNu+E8mV+l/aLIdwuBye2YrUEz0Hj8lSolfDUmlJ3ioa9n8Y5HrLewZwe+LfiYqdLbA2TFWrHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577636; c=relaxed/simple;
	bh=vyp87zN5aq1eCnAUe/eC2EWgM8P9gs62pjU8xilOPKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBDGn04/BSP0OD2oML1L/NpvprCg9/7LN1aq5A6/XBjz1nBdBoZLY+oojblICSsQw/kr7MqqbQEJLAUfMA8Mxkq5umw8rFf0nDgrYXKh+P03zvgbRDAjpxXsMaZ38tj8e+Dg6h12Kaq4sOGdUzQbOjpUTZW0v71B2+QeOArp4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFDTC0wX; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFDTC0wX"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-4955f00e593so3473685e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577633; x=1787182433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/LFGvTTl71pNFD3iTx6vRfErWqEnDc4WFlJ8ywAa0GU=;
        b=TFDTC0wXRFgiISzHtwzO7aJ1u0ghgCjrMJXo4Sv4/PvUIod0Y0rngKM59JIQ3h1/+F
         B0IT43EdcoeEfdw9Uug0qr3D77k38A1sYVydEt4D17DYsqq5XOLmM7VYLXsLuLEucdm9
         uey8BuiFx/yesuv8FTHIQ/O36/uPOCjQsSAtpmWkYXCS6p2TQWuG6GG1lDDug6jVVPs5
         Xi6IISod/JBO1QsYgFiUw8PYXLyoclo1j6c9crutT3l52JwukPhdpmBuFaFCBVlvT9Nj
         ces5CTOekbouuc6XFuoNeItY71Z9bvDg2W+POpvBq5HRy8UcRiOqxcWw7DS15JBLDxBa
         6uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577633; x=1787182433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/LFGvTTl71pNFD3iTx6vRfErWqEnDc4WFlJ8ywAa0GU=;
        b=DytOgdcU9PdM2rYVGYEzL6K53zjnrWNVT9NSnWiiLhtKZbT10tViOTGAFYsYaeBheY
         P4DIVdkEd8Nleztm86GeIYyOf7tnvE0PYZQalFvenZaAZ/POIfdJAloagtd4IYgq7WOQ
         4FkEw+fIb2q+JrUmFUcmzIGST5/RRR8HAeC2KkWdiH3PEZqPHR5YF5XhFhF/wQR3V4bY
         jkjaSKYZYsaJiy/MSqs3AtPaHSRv6CvMunchnGA0j5pqjGWCeLNT4gsRff8MDdkOuRGU
         6626nnVNW5PS/s7e8rq/bGuxBt7Unilq8OmLVbmbseryL3bjPAD7XA/2yNlt+gjLflqd
         bguw==
X-Gm-Message-State: AOJu0YzSjff2t2FV9N8EwVyBSBBbuT0ZN/PZKeGQUOGR6n8cbG7LMpT0
	qpyV6c+pQ5PNjx+YQY74unMTnS2DhkP3jtyjKtwyoMiJ72h5xZt3yzsivDZKNkuy
X-Gm-Gg: AR+sD1239eJsBAhdhTNscOnGg2jfN1fI34wcEEtqhL4zGZ+gOav5i1R8c2p/QrJi7vl
	thqcQ3dtDlwQWWwcgznKSYIg0KuCrUXlKki385ztKyr8xBR+4PC3bX/7M1Wwrw/g2Esz1EnA2bG
	eW8x5huTKYG/vtps1tQDVBV6LVpcP8oDr2kyIPhro8j37J7nTYAavhsapB1/e1ZqxRrn6lo+/e/
	vvCJVd5c6okEiQesUdI40lqci/WmmAuTsz2VDFfgoWIOxlZweSiYazrlZ8SWZ9zNxWmGK1my5x3
	dvy0CZ/JKsBM4l3WmOi47RxIf8HINhsK6elu1EiIZeptnNY7xpdmIsvu662jvXWWXpybeJ51e/z
	5E8lpfrnDouCY2BDEK1gLh7LOO120QwmlMuucbqBFhLS53VbAZEL+K3DjtpFb1PCcsmHWFOIksu
	5ep5V52Wy4OsgYr22Rc0FAXCV6SVPs5KSc/DoVEHQFSGtKboQunM3V2gF+kNo0v3DkyxGoxsMjR
	GgnPlLGbg7flezbMS+8ymWfM8SaBmn93NsecLuodXQC76Lt48X9wr+BClZLzFW5DbIqiYo/cRZJ
	lKz5KO765+UtAHIZyZt7y2/R8UqQ/0G8Ors2Hw==
X-Received: by 2002:a05:600c:4513:b0:496:c06b:9fb4 with SMTP id 5b1f17b1804b1-499821fa233mr11337585e9.14.1786577632967;
        Wed, 12 Aug 2026 16:33:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981de6a05sm31583195e9.1.2026.08.12.16.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 14/16] bpf: Report Policy helper and kfunc errors
Date: Thu, 13 Aug 2026 01:33:17 +0200
Message-ID: <20260812233326.3575958-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6444; i=memxor@gmail.com; h=from:subject; bh=vyp87zN5aq1eCnAUe/eC2EWgM8P9gs62pjU8xilOPKA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQTelIeyK0/3/Z0S3rF1yTM3F/1bVjkdn9gvufrHr5 pPQrEi1jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExEkpHhn3LK5DPV3jNv3//x bLJj5XIr4a/JmxICUjS1DnpHvFq3J4Hhv/fZHdX7xD7xXP/GdcRhyWvX27J7RJ/Ossr4Kh3m6Cw uzAgA
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
 kernel/bpf/verifier.c    | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 539d9b0abae4..74e6f3b576ff 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1157,6 +1157,19 @@ void bpf_diag_program_structure(struct bpf_verifier_env *env, u32 insn_idx,
 
 	diag_suggestion(env, "%s", suggestion);
 }
+
+void bpf_diag_policy(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+		     const char *reason, const char *suggestion)
+{
+	bpf_diag_header(env, POLICY, "operation is not allowed");
+	diag_reason(env, "The %s is not allowed: %s.", operation, reason);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "policy check failed for %s", operation);
+
+	diag_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				   const char *reg_name, const struct bpf_reg_state *reg,
 				   enum bpf_diag_invalid_deref_kind kind, s64 offset)
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 3ae2b9f37741..fc5f2812612c 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -157,6 +157,8 @@ void bpf_diag_ctx_restricted(struct bpf_verifier_env *env, u32 insn_idx, const c
 void bpf_diag_program_structure(struct bpf_verifier_env *env, u32 insn_idx,
 				       const char *problem, const char *suggestion,
 				       const char *reason_fmt, ...) __printf(5, 6);
+void bpf_diag_policy(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+		     const char *reason, const char *suggestion);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
 			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 91693b4232d4..8e5319f47ccb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2904,6 +2904,10 @@ static int add_subprogs(struct bpf_verifier_env *env)
 
 		if (!env->bpf_capable) {
 			verbose(env, "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
+			bpf_diag_policy(
+				env, i, "BPF-to-BPF function call",
+				"loading or calling other BPF functions requires CAP_BPF or CAP_SYS_ADMIN",
+				"Load this program with the required capability, or avoid BPF-to-BPF function calls in unprivileged programs.");
 			return -EPERM;
 		}
 
@@ -2956,6 +2960,10 @@ static int add_kfuncs(struct bpf_verifier_env *env)
 
 		if (!env->bpf_capable) {
 			verbose(env, "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
+			bpf_diag_policy(
+				env, i, "kernel function call",
+				"calling kernel functions requires CAP_BPF or CAP_SYS_ADMIN",
+				"Load this program with the required capability, or avoid kernel function calls in unprivileged programs.");
 			return -EPERM;
 		}
 
@@ -10668,17 +10676,31 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (err) {
 		verbose(env, "program of this type cannot use helper %s#%d\n",
 			func_id_name(func_id), func_id);
+		operation = bpf_diag_fmt(env, "helper %s#%d", func_id_name(func_id), func_id);
+		bpf_diag_policy(
+			env, insn_idx, operation, "this program type does not allow the helper",
+			"Use a helper allowed for this program type, or move the logic to a compatible program type.");
 		return err;
 	}
 
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
 	if (!env->prog->gpl_compatible && fn->gpl_only) {
 		verbose(env, "cannot call GPL-restricted function from non-GPL compatible program\n");
+		operation = bpf_diag_fmt(env, "helper %s#%d", func_id_name(func_id), func_id);
+		bpf_diag_policy(
+			env, insn_idx, operation,
+			"this helper is restricted to GPL-compatible programs",
+			"Use a GPL-compatible license, or replace the helper with one that is available to non-GPL programs.");
 		return -EINVAL;
 	}
 
 	if (fn->allowed && !fn->allowed(env->prog)) {
 		verbose(env, "helper call is not allowed in probe\n");
+		operation = bpf_diag_fmt(env, "helper %s#%d", func_id_name(func_id), func_id);
+		bpf_diag_policy(
+			env, insn_idx, operation,
+			"the helper-specific policy callback rejected this program",
+			"Use the helper only from an allowed attach point or program configuration.");
 		return -EINVAL;
 	}
 
@@ -13539,8 +13561,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return 0;
 
 	err = bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
-	if (err == -EACCES && meta.func_name)
+	if (err == -EACCES && meta.func_name) {
 		verbose(env, "calling kernel function %s is not allowed\n", meta.func_name);
+		operation = bpf_diag_fmt(env, "kfunc %s", meta.func_name);
+		bpf_diag_policy(
+			env, insn_idx, operation, "this program cannot call the kfunc",
+			"Use a kfunc allowed for this program type and attach point, or change the program context.");
+	}
 	if (err)
 		return err;
 	desc_btf = meta.btf;
@@ -13587,6 +13614,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
 		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
+		operation = bpf_diag_fmt(env, "destructive kfunc %s", meta.func_name);
+		bpf_diag_policy(
+			env, insn_idx, operation, "destructive kfuncs require CAP_SYS_BOOT",
+			"Load the program with CAP_SYS_BOOT, or avoid destructive kfuncs.");
 		return -EACCES;
 	}
 
-- 
2.53.0

