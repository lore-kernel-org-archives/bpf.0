Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931D3AFD06
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776412; cv=none; b=amAFMHCiiT0y+OJLfeLIDW8DbYEE6niKK/nKKpR+5WtWm9HSVbu9iKj79MuCzFJ3J/ICQyAbRE9m0cH95yCszkuWEl5grx9aFxjQY43/CMsoRL4kt3n1YAjvuQtVLu2Mh9ZWqMspZg2yoJXNm4ykAUAgnwLws0Y91RdIVFx51yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776412; c=relaxed/simple;
	bh=c4Fu03p5TBU2l0R/5Ofc6ObAnORONtqEc4Nn2xlavo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3s5hhwSM/5X2XB1RDpUCIxxR9+xeUAB6ZSW0yr7ZKKcuaJ/5DOR0sixlMVUhNl900z6N6J0P1Dx0DDvT1dehc/R6tNvmuv/RWEHX5rAdSCVsihtjXJQ+ANoWHf4gQLupiXapoxwYVL7psQGqc9DsMOQTFP4AGhXvioyiBoBwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbCFrS+N; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbCFrS+N"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49987f48039so3489525e9.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786776393; x=1787381193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0jJj0lhASkCf4u03HG3tmAmsPUJF7R0ms35M4fWnx9A=;
        b=hbCFrS+Ne486uGKlTP0MsLC03mGoK1BTUCvpHWYVyIn4i77Tk2TtAUw1Ai8ipM3RD/
         wh6byDJd3HDWv/d0SX+Gk4UD+j5aKWEYd8HGBrucjIIhcFIHa6Js2vCHs0JuIYwxpmuY
         H0I2zT++6W2TIJm3YJ3ZJMyXrSuD4QmFoaX6/qp+KUan10e32q2MJkIIquZRE60Kvee7
         lfYIiQ4e85qi0ucHpsI90il4WzgLhPKl8Iz2gmipOY93HINTY7ayujyb7KidFORvSuEM
         rXDwU11mVygQlq8yfHzHH9XQ71YHMhgDjqQYEwmSlHyVDrhhpxtorVeAFbtIe83D9XfB
         mYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776393; x=1787381193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0jJj0lhASkCf4u03HG3tmAmsPUJF7R0ms35M4fWnx9A=;
        b=SYGr0mLb0mAPMRkWhPldgQcxMMFHxXuFGNrq921aO4vJV/rjH4pLo8C7NHFgmHVyus
         D+Vi8rxp/DgcQUs9xwBUZDyDf5JTecGqgbZJk3iSIy0iWJhmpRgbCVjjalZeCXwYQUPo
         1kczU/KogHdzprlUT/N2/dwfo/Zr6G+nB1c3FJmBVSZjjOIcfQMuQhnkUt5Yh/QPVtgO
         o75tEHc8JyHKQlIN+exX3lF9o1rzfJkX3U5V96XM5uMg28Zu/wYs30SUEW3gSeadHnOb
         sqynOmP/0Pah/7AeD763qgSt4OYyYtduLD0mW617X94XmlLoGRzGqFX37ebwfGPozey7
         XhAg==
X-Gm-Message-State: AOJu0YziN26qeiuW3X2OfyUQdaiWUH2h99bk8aDpAVoXXAsktejTZali
	lgo1DlgjW6qd0YgqaWS4ThWJHeUWUcU6yh4uAzopKVD+cgegEedJ51QHZz+Iav/f
X-Gm-Gg: AR+sD11HVx3oVve+8K2qsL8nxmE2DNx2AkSfxRDzAaOQaLeTf0OIhOj8Uk+yTeF1c+8
	S4jbqTYpoejlqf0RwtaYbzS7PV7aP1RuStLvW6EXvbjGQ5muSXiuguNUhQegaQAapEkSCNjfn6S
	GBJDVthssMhZY39YxR6tuGHuAYSJeqhjn5TXLtjzieCKpuipO6avE7pZndHut1rkDt4FRG8Xq/+
	fckHhia5lRt96d78XEK8liw5qJlBQoa1brQi+HZRaJTlz/undFgPnfOAkYKv7HE/zJE5oT4zcAF
	eejK9AYj9svybnt604YgqleQZ/cspP2ljVG5sGDlUgyOQT5edY1bOen7P9qyvCaDE1LKYWshsFP
	NAr1eRG4V1xlTsqkGmiHXeHW+TWHvtaGWhz6bnMuO+klFaK+EJX0Z0RiOwy6u3U7mQXpe4qQBxG
	dsj2wHMl6IDwHaYFH3jpOPiWQff+hTq9j3c5F2jLg2C3aAyzrFpGNtPQHzL61Lr2SXMwbKJQU/i
	r6YDvj720xBDcB2ZIresR96ZclAifDLNF3+18iXgtsJvdUd1OqWeGFLSvw8sbpPDz2zrHMRIo+D
	QfVyIljXyw5H8VQdol1N4ykur+c=
X-Received: by 2002:a05:600c:4e45:b0:499:8fa7:dc52 with SMTP id 5b1f17b1804b1-4998fa7dde2mr33151765e9.16.1786776393089;
        Fri, 14 Aug 2026 23:46:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b24746sm200368455e9.12.2026.08.14.23.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:46:32 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 14/14] bpf: Report Policy helper and kfunc errors
Date: Sat, 15 Aug 2026 08:46:09 +0200
Message-ID: <20260815064612.378577-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815064612.378577-1-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6694; i=memxor@gmail.com; h=from:subject; bh=c4Fu03p5TBU2l0R/5Ofc6ObAnORONtqEc4Nn2xlavo0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauBy8+09e31msbsAxPuVwTv1ZHj3mQloid9JU1vYjDzS 7fnt1d2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCKamxj++ypwrpo/SVh+dnQW q4VRl1/A2rMd2+/xv1PMifDy4JNtZGTYu/cjm4r2NZ/Ni2+tXK3sE5f9zOpZ3Hn778azi56tjT3 BBAA=
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
 kernel/bpf/diagnostics.c | 14 ++++++++++++++
 kernel/bpf/diagnostics.h |  2 ++
 kernel/bpf/verifier.c    | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 9fc1f8cf7312..33b7d9e8e2c3 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -22,6 +22,7 @@
 #define CALL_TYPE_SAFETY "Call Type Safety"
 #define EXECUTION_CONTEXT_SAFETY "Execution Context Safety"
 #define PROGRAM_STRUCTURE "Program Structure"
+#define POLICY "Policy"
 
 #define BPF_DIAG_TEXT_WIDTH 100
 #define BPF_DIAG_TEXT_INDENT "  "
@@ -1211,6 +1212,19 @@ void bpf_diag_program_structure(struct bpf_verifier_env *env, u32 insn_idx,
 
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
index ab082d2d6e37..d1b79945008a 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -92,6 +92,8 @@ void bpf_diag_ctx_underflow(struct bpf_verifier_env *env, u32 insn_idx,
 void bpf_diag_program_structure(struct bpf_verifier_env *env, u32 insn_idx,
 				const char *problem, const char *suggestion,
 				const char *reason_fmt, ...) __printf(5, 6);
+void bpf_diag_policy(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
+		     const char *reason, const char *suggestion);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
 			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 64c5c31ed230..ff028a8c1cca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2924,6 +2924,10 @@ static int add_subprogs(struct bpf_verifier_env *env)
 
 		if (!env->bpf_capable) {
 			verbose(env, "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
+			bpf_diag_policy(
+				env, i, "BPF-to-BPF function call",
+				"loading or calling other BPF functions requires CAP_BPF or CAP_SYS_ADMIN",
+				"Load this program with the required capability, or avoid BPF-to-BPF function calls in unprivileged programs.");
 			return -EPERM;
 		}
 
@@ -2976,6 +2980,10 @@ static int add_kfuncs(struct bpf_verifier_env *env)
 
 		if (!env->bpf_capable) {
 			verbose(env, "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
+			bpf_diag_policy(
+				env, i, "kernel function call",
+				"calling kernel functions requires CAP_BPF or CAP_SYS_ADMIN",
+				"Load this program with the required capability, or avoid kernel function calls in unprivileged programs.");
 			return -EPERM;
 		}
 
@@ -10749,17 +10757,31 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
 
@@ -13644,8 +13666,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -13692,6 +13719,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
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

