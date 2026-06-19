Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58A3D1AA2
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902805; cv=none; b=Q8LIAEu9KrPLnM0cl0WgALMDeASVIKq+NyKQKDeyV/f5QFOJTtF9pQ7/GfkLt0ALBojU6/moKoirACD/aQSy92bMmkBsttuKIetyVoAFV/hAHRxGHpzrojnEf9s3KJAb2kyjJjDtg3TqA9t7x1RepSIQH8gdIRyoFcFi7MTCEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902805; c=relaxed/simple;
	bh=q9ajVw+UbT9R4AfuVqKibwyGBOC515FvlOWhE+ZejB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP4UxlLzIxxcIJpdku+BaX/k/ylWO7tZgdKR0BUcjOhnyFHptTStOxDpPUNh8eU6g9kST2l/2Ur6Ke5TOtm9z5VqoXolUickdu5lw7WQA9oP+ItNHvLLQrOZ8FGdTLYET3Pd0NdREcPnYnOqgFfCInujHEVZDfUXxfZX6xTf5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKdLATFi; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKdLATFi"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4924593f45dso7875395e9.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902792; x=1782507592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMbSA3cwwViSk+VzaaAInqnKM+CKAzeC4churXOcJQo=;
        b=WKdLATFiS/ypV8L9cYKRaZ5sOh4jJv9+Ex/6BZxjpQQEggnJPw0NYefJwOqiXb5E5K
         O7ExydBAIIEgiqsDiYhnzgoSwYrgH1WJQu7fhb5/VgZW/+TtK9Sk/CpK3sdFrKCumU/9
         XSlDeTjrndRWuOi9S9lPw7+b/yiNnNm89nzDVeF2MEvBHJwjNsvqX6lIKm39W/DOpxDE
         bNh0XYnisxE5eHykd+2WwxMWyOBEU5stT11fE0IxHPZyaIy3DAHkbOzchtrdxWARz2//
         0FTodwbAS7BmcMXx6vgtIxQRoCGuxt7vA/F5M+82ioDWsUmrfYaQ4x578yShRTNcqx2m
         oYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902792; x=1782507592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZMbSA3cwwViSk+VzaaAInqnKM+CKAzeC4churXOcJQo=;
        b=IPKRABO6iInC5xshoCnzWt8ATQA8vt8PdJjOnlxpuoPhqDfLzRT62DkvsIXFsqu2lN
         lkB7RsQEhlI0A8wGggmvrlm16xZfH2vlsVOhTbqwZn08VJmc0RY2D/tXCde4Q/xgs5U8
         Pxd0Y576WzNK+dBjuoVT9LuLA0mS7k3pBfTgsfaerr6DAEq6XXDzVfMPoSOrTIeYpU3T
         D5esBnxTkp6hgIwqt7qver57Sor1RK+WRg1dL5IPVAiahG0mGS23tPoUqg6RMh6clVox
         YcoDW6vz9B/ATyixuW4SS2hmY9+iAz6bokZbyahTWehzv57PAjduukneHYbEU1WlrBVT
         bdPw==
X-Gm-Message-State: AOJu0YzyLaLxXPxXEMOqKM8Ht0kcujszp8tZCBMp7CKLagcmBvmW/hWl
	cyNCpUgDEb6QF7dX7PK2y0I7N45aYF5ELy6+ioewJUnSMgFQfT3UE7f3VwcQbfyo
X-Gm-Gg: AfdE7cmixg3tQUkKJrvnRuk/UeO8UKWnMkeWubxGpTI6aga5TWS9ihMwCxIlQfuA0gO
	smIbdjk8SGRPrsXiGxgKr3UqMXCRIhEoWj3irOQ8kk3g/kQ4Mvi1k/tvpMt+aWnU+Qckm+s5VZ4
	Ge5/BV4/UMtfkQ0TOF0L9KANk3vjiFev429Kqrjw2P2foQ/DAfjP2mo+wMdTPMf65LdDMiRARcm
	1jM7rDx4kZ87qpjUDpb/dS0OcLzdRv7uLLR5eat+I5mjbPbrCQH43Sn4vJpUJI04kqYJF1M42Yk
	gvvHoHo7Cfc7IdZxoG1KhTg8mMkQHZ4DFLg9BcpNqiyjJ59XA4j3WByomHpfC8PXJhbyhFhVIvM
	hIs3kF15OfkBZS/OhEmkIKEPkQibuzyPDlXMc77eB0tlfvFzMvAT1KUfThSBr+0jzxWznQgGgLQ
	ioySfMT4Vw/cq9hZrme+MH/IWUZXJaXRF3Hli7QrqV/dg8x60UqS0ec1FWd0hr9MUysu7b4tYKc
	juj2EIFlUNWYhskebEscgntphnmnJcjRrtlIByFfQbCKRISOGc/z5qR9o7uhDjQXA==
X-Received: by 2002:a05:600c:3e14:b0:492:4392:4dbe with SMTP id 5b1f17b1804b1-4924392502dmr59153685e9.34.1781902792432;
        Fri, 19 Jun 2026 13:59:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240084928sm98858315e9.15.2026.06.19.13.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:51 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 16/17] bpf: Report Verifier Internal errors
Date: Fri, 19 Jun 2026 22:59:29 +0200
Message-ID: <20260619205934.1312876-17-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3841; i=memxor@gmail.com; h=from:subject; bh=q9ajVw+UbT9R4AfuVqKibwyGBOC515FvlOWhE+ZejB8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct0FVNVj+O5l6WmT4xanzUKdbfmJsyO5RDoPfvngUv5q Vi2ht6OUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATKS9jpFhqph2/yqmy4X3uaOX zvq32Zz36i/lyu1/7RUfHv+h7FJyhOF/tp5xkHScmsGalzalqtfEvl5f9UScI1i9XrdVcPe9m// 4AQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected existing internal-error paths with Verifier Internal Error
reports. These reports avoid suggesting source-level fixes and instead identify
the verifier invariant that failed.

Cover non-overwritten BPF_PTR_POISON helper argument types and inconsistent
kfunc graph-node argument classification.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 16 ++++++++++++++++
 kernel/bpf/diagnostics.h |  3 +++
 kernel/bpf/verifier.c    | 12 +++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 18217f5f709a..d27bd314d194 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1195,6 +1195,22 @@ void bpf_diag_report_limit(struct bpf_verifier_env *env, u32 insn_idx,
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
+	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
+
+	bpf_diag_report_suggestion(env,
+				   "Report this problem to bpf@vger.kernel.org with the full verifier log and program.");
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
 				   int regno, const char *reg_name,
 				   const char *type_name,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 559c0169062c..97cdaad7b606 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -228,6 +228,9 @@ void bpf_diag_report_limit(struct bpf_verifier_env *env, u32 insn_idx,
 			   const char *limit, const char *suggestion,
 			   const char *reason_fmt, ...)
 		__printf(5, 6);
+void bpf_diag_report_internal_error(struct bpf_verifier_env *env,
+				    u32 insn_idx, const char *problem,
+				    const char *reason);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 			    bool cond_true);
 void bpf_diag_record_reg_mod(struct bpf_verifier_env *env, u32 insn_idx,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec51e0c81053..5c60fe033271 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8481,6 +8481,9 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 				verbose(env, "verifier internal error:");
 				verbose(env, "%s has non-overwritten BPF_PTR_POISON type\n",
 					reg_arg_name(env, argno));
+				bpf_diag_report_internal_error(env, env->insn_idx,
+							       "poisoned helper argument type",
+							       "helper type checking reached a non-overwritten BPF_PTR_POISON expected type.");
 				return -EACCES;
 			}
 
@@ -12560,12 +12563,19 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
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

