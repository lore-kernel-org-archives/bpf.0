Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBA9407CC5
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641274; cv=none; b=ciIE6fNtNJge63QLi9nyPTIfal/uaZHQMndofTXx4CfMFxIY7uWbIF8YqttQ6NWAL0TdX8VUxYnIJbjzP6BKLrK4usY7HXiB8tNUVb7MPeXa4QD4C4KDRp8Xn25q7Za1XxDO4AAMT462PxzrZmK9Dh0hia1P+b4KWCTBmcjzJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641274; c=relaxed/simple;
	bh=gjKwJ9LsWYHCDK/dlaMVaFcRl/Zbj5AA21GldaRO8No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwoRMGgSUO2+BSkMYndpbgHhMFfxJvZsUWIziXeP7kvDtGJOe6mQp8snmx70y2mqh8oTUUADQiislH1ytds9pE9e/X6AZoU2HtPF3jHbIVqHXXyDMSKrxbJEXBsBzT9TiSCoIli8GRH4fE4eisU3OwhxCSgipKPDOmYG8vCFPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVIpsePc; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVIpsePc"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490a765d410so15902315e9.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641272; x=1781246072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK3oiF5m7fm06WiZ+LDz043MKEhkRhqmixBohH+1yIU=;
        b=oVIpsePcm2gn3S5sqtQ9IlHHkLiBgW0Sv4FwhoTmNQCCwdxJQVBEu9tDzfjSWQ/G56
         ifKRr6No2hz0iAPrFA/ODwOCgS4XQoI6HxIKXsBk/lfcU7Y48KdorzYzM9fatcEyP76T
         mNc+NbXBgeYR2zWTeWECVR+d2T4Rjyu9ZlclW+LhInWhLlntP2/Uoy4+fuXXaE0Q51xO
         eulgBVhDc09IX95iymZ4cunJiAsprkBDxI5sLC6VbeHwITYaqrD3Ab+sGJjgAyhs64//
         ptEHAooVDqT/TaN7Cp8VOWLDDkYwSQCzL7lRfG4qxCN4dU5r7cxTBWbFSslzJTSHy1o5
         iGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641272; x=1781246072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cK3oiF5m7fm06WiZ+LDz043MKEhkRhqmixBohH+1yIU=;
        b=mQfRDDh9j8fP41sOkxyKdTvhb1oNCalAEsJhkBE70ldxTzeF+GKYldKCnjxw1ac9wW
         b5z9ZQeR7Ha1/OGDKcPd1z/Kq7/c69ftfPPS7jFG9x+YYEBNcCQrrkZL+KmnwD5Y5/90
         zEsPo+zdGlxXHngztI9KUjiOzVFas8xTPhnt87GJu7EW6kwNrr9Suzw8YYa19xjeLSKA
         9DMuLdMwg1v0z0jkquyOZsRrtnoHBxXlQA+8+mPy+41wMWjJEG9ulkY52/iGz4RWIIB6
         /MV/H5fz0sXJa+EwhDtYp+HG20hFpBBzTMpF4defCa5rIECOqOMnDSfO4Sjg2+5oRoky
         /FHA==
X-Gm-Message-State: AOJu0YzG6zkdlMvRvXaaSkkrEVikYl0xUyAplKGEcbu5Z3CmXg5k5tfv
	sC6Ws4v4I3qEevJp8Tspe/1FsJKRqFz0nS0Be+DgczHwtWjTmZeNoDE2JbtaWwVR
X-Gm-Gg: Acq92OEtM6eL6NnC1HBnSD4+fzJa3e7mKzHOyLvdHuRXCMOoAxbr9pwXjR8ANcmyp5b
	H7d6X5RKRSKaZn/YedOo1TrS0I017ysTqd1627BodDHDfNPTp6hyiniGUy0uu8qeu0JZVY7iN0U
	dVxR3eeSQF6e8XuFDqPKLQ8t5FPTFgaIENLyVkoV8TbI73AtReG3kAcmtc/Y9+UU7yZZGWJAo1O
	FajXw1Aqfbz1WDob1Y5KskpbHkvknxXwhtBAMG8mHd9fhBaVMHOond9k9e+BMYLKaMbw7AZwjaD
	mHePG1zkBXCkOZH/HyP3wYaqcUMBsaudIAI6wbl7SB1CSBpun/Zwi9BmiiKLLEXH6BZ0RTD4DzO
	ckOUzn3ViswTNxrEx5gE87i4FlfKc4kZR1o2FgMPeQincI3pdrztI9Qq26eul4FVLp7Snamfqd3
	jC+qbZPW2ERWnrYazcc53hItXE/rr2tjx5o6UELipT1wrql23Ueuqe1vko5ZpdFopM8uiwQDxef
	36r8tw5f179T9i6YMrATZoab4mi5mdtZybuF4zlh3p/cGavwCVIcENUMQr8piznyOAqYQE5qUbz
X-Received: by 2002:a05:600c:458a:b0:490:b2f2:9aac with SMTP id 5b1f17b1804b1-490c24f56d2mr31528945e9.0.1780641271712;
        Thu, 04 Jun 2026 23:34:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda363bsm9858665f8f.31.2026.06.04.23.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 16/17] bpf: Report Verifier Internal errors
Date: Fri,  5 Jun 2026 08:34:06 +0200
Message-ID: <20260605063412.974640-17-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3835; i=memxor@gmail.com; h=from:subject; bh=gjKwJ9LsWYHCDK/dlaMVaFcRl/Zbj5AA21GldaRO8No=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt8wtPGzS8jsWJhOmGXx74hsRyTilKXiRksPElpSrP mbMhYc7SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJFFzxkZbigkpLx9yxivYF/H 2mDl/1rne63NdN7f/VEsft271pgJM/yVyms+6eR/espt29k//tpdnc4/mXNnTKOI/Vy51tXNe2/ yAwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected existing internal-error paths with Verifier Internal Error
reports. These reports avoid suggesting source-level fixes and instead
identify the verifier invariant that failed.

Cover non-overwritten BPF_PTR_POISON helper argument types and inconsistent
kfunc graph-node argument classification.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 16 ++++++++++++++++
 kernel/bpf/diagnostics.h |  3 +++
 kernel/bpf/verifier.c    | 12 +++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 2ca398798b1e..62cfb0fc3ed0 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -952,6 +952,22 @@ void bpf_diag_report_limit(struct bpf_verifier_env *env, u32 insn_idx,
 	bpf_diag_report_suggestion(env, "%s", suggestion);
 }
 
+void bpf_diag_report_internal_error(struct bpf_verifier_env *env,
+				    u32 insn_idx, const char *problem,
+				    const char *reason)
+{
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_VERIFIER_INTERNAL_ERROR,
+			       problem);
+	bpf_diag_report_reason(env, "The verifier hit an internal error: %s",
+			       reason);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!', "%s", problem);
+
+	bpf_diag_report_suggestion(env,
+				   "Report this problem to bpf@vger.kernel.org with the full verifier log and program.");
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
 				   int regno, const char *reg_name,
 				   const char *type_name,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 90a584d5aa0c..b075a0cf5568 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -209,6 +209,9 @@ void bpf_diag_report_policy(struct bpf_verifier_env *env, u32 insn_idx,
 void bpf_diag_report_limit(struct bpf_verifier_env *env, u32 insn_idx,
 			   const char *limit, const char *reason,
 			   const char *suggestion);
+void bpf_diag_report_internal_error(struct bpf_verifier_env *env,
+				    u32 insn_idx, const char *problem,
+				    const char *reason);
 
 void bpf_diag_clear_history(struct bpf_verifier_state *state);
 void bpf_diag_copy_history(struct bpf_verifier_state *dst,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c5a3b6876c68..3446ee9acaa1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8313,6 +8313,9 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 				verbose(env, "verifier internal error:");
 				verbose(env, "%s has non-overwritten BPF_PTR_POISON type\n",
 					reg_arg_name(env, argno));
+				bpf_diag_report_internal_error(env, env->insn_idx,
+							       "poisoned helper argument type",
+							       "helper type checking reached a non-overwritten BPF_PTR_POISON expected type.");
 				return -EACCES;
 			}
 
@@ -12280,12 +12283,19 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 	default:
 		verbose(env, "verifier internal error: unexpected graph node argument type %s\n",
 			btf_field_type_name(node_field_type));
+		bpf_diag_report_internal_error(env, env->insn_idx,
+					       "unexpected graph node argument type",
+					       "the kfunc graph-node checker saw an unsupported graph node field type.");
 		return false;
 	}
 
-	if (!ret)
+	if (!ret) {
 		verbose(env, "verifier internal error: %s node arg for unknown kfunc\n",
 			btf_field_type_name(node_field_type));
+		bpf_diag_report_internal_error(env, env->insn_idx,
+					       "graph node argument for unknown kfunc",
+					       "the kfunc graph-node checker could not map this graph node argument to the called kfunc.");
+	}
 	return ret;
 }
 
-- 
2.53.0

