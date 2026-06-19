Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F03CB2EA
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902806; cv=none; b=ml76OMKA4GyXyaG4qtEHfLA+/na+z5LqomBa32NUx3uqtf7Ln7c/blsnGnz5ezRlIO2MaQvVg8uP37H5V7y3WzRYybXKGfZ+b589a9HHsZR36fPO7RmcB663g+PIq/QKOpux/5EKZ8msE6f53Z7jE7SsJ+U07hCLvjbljvz5Q4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902806; c=relaxed/simple;
	bh=NJQ/AEwWWbxteKaLyaWYg/j5vEDjKao2F8DFA1OM7UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUFPpabN9NpaEO6HA0YtTeaj01dp5bawbOvlWzgKl+f2IWxTWP1z6Yyzem/9ac/cup9CEmEDaFjsKKkz368Ue9QevETkewd5NxFoKwn/ozQIqiZygmV7/1RO0LL9WOJX8UM2AeIqz17U0QDqNDpmABxFjYdtwCQaiFuQUv+9qUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojmqtXIu; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojmqtXIu"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490c1915793so19849945e9.2
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902789; x=1782507589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Sf2aDAtf1i4YeolTAMMGu38LI3wwKsPT4JhqAGqegI=;
        b=ojmqtXIuOawa6Jm/CnYVOqGPp6k7mqTMPbMxieEUXy0gKlX7kRXt2XdBJ0ixdEnmDK
         /FVz6Q/c8Omf+utNwEUTIm6k/seKw7Qa8vXBLMAytD5LPpg53TMOHSUorXfg/EhDmWzJ
         ttFMc2HRVoOLjIL6wqE62fwVYYrWENnQea/7KBjMpgWpXqa9Ymz47infD4tjDRvukY2O
         Iz4SIH2lf66z8OhzYyjESFWELZgIQoYWDxEyWRCk8pn6PoZHKMyrtUFiFaC5CoZmZMMP
         704phuJqyjS4LsbWkHNr5xsFAnTjFNsWBcil35w95cNR4dSCLiD6Fy4+Nh4Zb1i3oaIb
         r7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902789; x=1782507589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Sf2aDAtf1i4YeolTAMMGu38LI3wwKsPT4JhqAGqegI=;
        b=XhqZrZevr/eWaza3sOE5ZqvhwNLFFESu0gSQvySKzwH1flPESniWr4JRwbmvxXXcdi
         6qkGSLLtLhLs1xOXMw+JIhRRccQne1zm/YT14UcbQlyf5Xo/f409PEVESBsnJtkRHzSm
         0BZOVeRwBcxO/McuKfoyI5foumFilLtRry16PBxSCLeXvIxM6zKIIz4MfBrWbAB7B7+C
         BrP+6dV+sXcEIt0mVdC7Pb40PuZKBtR/CtSAK/r8dGUqhxjXlnE1KV+uAZ2WluuaMC9u
         vhiah0XKZGCTvpeB2IX1z5O9MF9F7hYv+IyPU5Yo75gg8C9792eiB1enZcGtSuGNCYdg
         QAaw==
X-Gm-Message-State: AOJu0YyhP8ENgpqpofvV4pZwz1d5bPcrtQSWaMpwm1VKX2sv+ir1v4di
	/XI/cgQguHsgn9I5+/6IXGsAS3WcxWffugAthMXW4+Y9zorlRehIvTFhDaGTi8Fo
X-Gm-Gg: AfdE7cljjhsWMDtUJ6EfIOd40rUv6F+PPqnE2wvto/iRHAFOT177mT/ZgEKkQOsudvX
	xVBIwxWoQYPegY6EC/miC6oIyQcC8mQnu7xSzKEYk1wViSi/xN01A3baoPKzul/dpfvK0DvzbKU
	gInxcwowqCFmsE1ypIXcNIYYjn7lGPch3H9qZxW6chFy9lJHReT5kzu3sVGzp83PdOOI/Scz9OU
	x+OEWUaDIfKovAFzxMD8LkZqVBdbnt9g7UtPLX9WX5oxig6aagI1jL6YC6XbPbM5TFJiDgPWI5K
	7GIzayT25L9rNCwWC5o/kTO4aXXRv7EuC3KgKrnwiFfj0oc/S3tldeO12oCuticPMjQaUB/SO2F
	fK4FWOcuJLsVPFB6fqCEH3iRsSUSdqdUL3yjRbGQL+7839MBirLt5XttWLSUazNs8hpGf+hqjwN
	7GBztZcBsmOJ4Vv/QirEgplwuKdymsBaTz8+BwWMuN7xBn4/zs2jk8Ldc1gaZR1wr1eKf6FTxxR
	UuZiY5cYu0IVIahNiSYRLc7/6jNId6jw4904SMIEAjyGgFYAaUDphQ=
X-Received: by 2002:a05:600c:3e83:b0:492:3fb5:4697 with SMTP id 5b1f17b1804b1-492423140e0mr86413735e9.5.1781902789507;
        Fri, 19 Jun 2026 13:59:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7ba08sm94619835e9.11.2026.06.19.13.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:49 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 14/17] bpf: Report Policy helper and kfunc errors
Date: Fri, 19 Jun 2026 22:59:27 +0200
Message-ID: <20260619205934.1312876-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6261; i=memxor@gmail.com; h=from:subject; bh=NJQ/AEwWWbxteKaLyaWYg/j5vEDjKao2F8DFA1OM7UA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct0FaPVdu3ndT6HXyV5iX529Zm46sd+htfyLHv/Zpbx+ Ylqdu7oKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQ8tRj+h1/13SbyTrd5Vtjs 1VaRWt+/Hg2eJWkm2Wg4Z2GN3Lv99Qx/uBYx6rf6uFw4yelnpP5mms1BtYKaUr6JcY8ebv0pWj6 VDQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected helper and kfunc allowability failures with Policy reports.
These reports explain which requested operation is forbidden and why, without
adding path history for non-path-dependent policy checks.

Cover unprivileged bpf2bpf and kfunc use, helper program-type restrictions,
GPL-only helpers, helper-specific allow callbacks, kfunc allowability, and
destructive kfunc capability checks.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 16 +++++++++++++++
 kernel/bpf/diagnostics.h |  3 +++
 kernel/bpf/verifier.c    | 44 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index d6893b2626c4..f199a6eeea54 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1139,6 +1139,22 @@ void bpf_diag_report_program_structure(struct bpf_verifier_env *env,
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
+	bpf_diag_report_source(env, insn_idx, "error",
+			       "policy check failed for %s", operation);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
 				   int regno, const char *reg_name,
 				   const char *type_name,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index b881ccaf6deb..99f82292a740 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -221,6 +221,9 @@ void bpf_diag_report_program_structure(struct bpf_verifier_env *env,
 				       const char *suggestion,
 				       const char *reason_fmt, ...)
 		__printf(5, 6);
+void bpf_diag_report_policy(struct bpf_verifier_env *env, u32 insn_idx,
+			    const char *operation, const char *reason,
+			    const char *suggestion);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 			    bool cond_true);
 void bpf_diag_record_reg_mod(struct bpf_verifier_env *env, u32 insn_idx,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e923366c6fdb..7938c51eb454 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2860,6 +2860,10 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 
 		if (!env->bpf_capable) {
 			verbose(env, "loading/calling other bpf or kernel functions are allowed for CAP_BPF and CAP_SYS_ADMIN\n");
+			bpf_diag_report_policy(env, i,
+					       "bpf-to-bpf or kernel function call",
+					       "loading or calling other BPF or kernel functions requires CAP_BPF or CAP_SYS_ADMIN",
+					       "Load this program with the required capability, or avoid bpf-to-bpf and kernel function calls in unprivileged programs.");
 			return -EPERM;
 		}
 
@@ -10835,17 +10839,41 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	if (err) {
 		verbose(env, "program of this type cannot use helper %s#%d\n",
 			func_id_name(func_id), func_id);
+		operation = bpf_diag_scratch_printf(env,
+						    1,
+						    "helper %s#%d",
+						    func_id_name(func_id),
+						    func_id);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "this program type does not allow the helper",
+				       "Use a helper allowed for this program type, or move the logic to a compatible program type.");
 		return err;
 	}
 
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
 	if (!env->prog->gpl_compatible && fn->gpl_only) {
 		verbose(env, "cannot call GPL-restricted function from non-GPL compatible program\n");
+		operation = bpf_diag_scratch_printf(env,
+						    1,
+						    "helper %s#%d",
+						    func_id_name(func_id),
+						    func_id);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "this helper is restricted to GPL-compatible programs",
+				       "Use a GPL-compatible license, or replace the helper with one that is available to non-GPL programs.");
 		return -EINVAL;
 	}
 
 	if (fn->allowed && !fn->allowed(env->prog)) {
 		verbose(env, "helper call is not allowed in probe\n");
+		operation = bpf_diag_scratch_printf(env,
+						    1,
+						    "helper %s#%d",
+						    func_id_name(func_id),
+						    func_id);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "the helper-specific policy callback rejected this program",
+				       "Use the helper only from an allowed attach point or program configuration.");
 		return -EINVAL;
 	}
 
@@ -13726,8 +13754,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return 0;
 
 	err = bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
-	if (err == -EACCES && meta.func_name)
+	if (err == -EACCES && meta.func_name) {
 		verbose(env, "calling kernel function %s is not allowed\n", meta.func_name);
+		operation = bpf_diag_scratch_printf(env,
+						    1,
+						    "kfunc %s", meta.func_name);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "this program cannot call the kfunc",
+				       "Use a kfunc allowed for this program type and attach point, or change the program context.");
+	}
 	if (err)
 		return err;
 	desc_btf = meta.btf;
@@ -13768,6 +13803,13 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
 		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
+		operation = bpf_diag_scratch_printf(env,
+						    1,
+						    "destructive kfunc %s",
+						    meta.func_name);
+		bpf_diag_report_policy(env, insn_idx, operation,
+				       "destructive kfuncs require CAP_SYS_BOOT",
+				       "Load the program with CAP_SYS_BOOT, or avoid destructive kfuncs.");
 		return -EACCES;
 	}
 
-- 
2.53.0

