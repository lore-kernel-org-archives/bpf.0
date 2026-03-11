Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30733E8662
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253384; cv=none; b=VJTzd1ZM7Wa9cIJkGyEkTPrXHWHVHkVRYL3wFIOUyBOcLrmThtGl7HcXvnvj2/UJk+u116sEsaeRHk667uvEJjN/0dG9sasdioUvvyC5Ho+UTJYMfzykyFX7/dH0DKyvapq67p4724wLQw7midYqY+391NUCNV11uA4vir+deCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253384; c=relaxed/simple;
	bh=LcfVdKxlSEz/UewY4ZhsvsTnkXQih+fD6fw/M/slQrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gy6+jKFqIwa2A4CFXewwLUQXFdX1am16ahhatyojjOzs9AbpTWyYGpPgbc6W41bgHlsWaxCo5U6yPY8mi+Ocv8Cnkuvy6F9BU64rj3mbpRMneZvL2z3+b80fnposyYYZuLcp+gm6M0j96Up8bKHdzxvst1FLIVs8UCpnIXZXXUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0e1QurO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0e1QurO"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso1488345e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773253381; x=1773858181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVEtw3tOQd0EgyAIcRXvULkklIf7eksP22La+p7e2oQ=;
        b=D0e1QurOFaLdXis+31cZ8vy6f0/2DEqRjtWst85PSqxeGejpM6yYw18OnVn4h83gX7
         eJB5DjAnO+WLtkUfmchVZ9we8bRYB5tQtJJiZmN856jMU+OAJT+UW9u8qmaXbXD8iRH/
         4Do5MvLM+7fK1ia0ETGp4httOqkBU5aEzTYe2GgEzCVfA0mQ5/ZYQuVPKcCE3JiwgvNr
         YFP96rwNVe2T3SIVThsFhX19+KiGn6GALdBeJ/RxkVMMDBxByf4cKB+lVAsIWWr8Gvlq
         ijlGhddYABRe/Er7oJPyo0wduVkcVMMU68boOTDYUroMKltmaTBCPL18k7mui1Vl01cH
         ZUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253381; x=1773858181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NVEtw3tOQd0EgyAIcRXvULkklIf7eksP22La+p7e2oQ=;
        b=iTug3ILJhyXPaTbqfD+mwK2HG/HqYx6aGd99j8ldl7kj5Cz3xc8/o9sdyx0xe/1wus
         Egz5pAiy83pS8tmfXBiq9CtNS/hdmLp0hZ3E3bAuCZ3uPbCznjhSKSZVb2CbeNh5JkL+
         lqSnU9tRCQHP1MLQYUTpTH7tFO3mvU8AC1nAtxX9hYT9F82ODiin5eDE6niggKv+11eF
         8iXgntJGt7XUGfVUPliBVldIemizo7+TWyZApxZ0lgtLUfxXHBFgsYXZRednSO8m9lB5
         oQtfuhocjRRAwxUhHLFnJ36q+28XJuJd9xEHyJdkP+iI4Cl/3bRZm6iyyBAc1oe+CK1Q
         dWhQ==
X-Gm-Message-State: AOJu0YxTts8JIPNkjlPly5gqS4eubLgXaoeF6G+qz5UgmVjIUc6jid16
	88JQvAy3FheJyOeQZrDgfVclZt9seJSOgG1SZKx3Wzi2VXk15w3qwe9o
X-Gm-Gg: ATEYQzxjhM0qBz4ftKs9z6eE3y319LxL1uC1vbP1xJKtXCVqDR+E2nzyzmhjzEJEjOn
	OucxFHLsahWPQWrTYlfbhoTrPy3rpcnlvwdT23kg8P64TQmi8GnzsdsVm7XGzlCfWS5sInOL3vi
	M+CJfRrVJkKS3Nt/gJlJniC+xglGMFZVbeFIPLFXm6y/AM9PeuvN3W7kfUGdHsZXEDKUP7klDGY
	oMWcSYNl88X6EJqWr7sCIzfLtqB04fh/U6kid/7M7nzuXbx+FT8a8hVXGBU78MUENy4Zk12NLJE
	4ASawYV/rS9cPsvcsYrOvKS50H8MTq2flfxQ2F/vLhC7O00RiZuVfUl0BwKp3S3WRAiL1FTj1Oa
	kH+re0u9U1lZ47bZKGx5GOBJypQMDgDeUimndZw5odcxWlrRHWfLzNl+hL+8wEHI0IhESReTHse
	/9e11l+yUCsmUbQWRP
X-Received: by 2002:a05:600c:8b02:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-4854b0ac45dmr65734615e9.5.1773253381136;
        Wed, 11 Mar 2026 11:23:01 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe219c41sm950477f8f.29.2026.03.11.11.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:23:00 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 11 Mar 2026 11:22:50 -0700
Subject: [PATCH bpf-next v3 2/4] bpf: Verifier support for sleepable raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773253375; l=1754;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=UuB0LPoSa5mawNb4n4NWso25rbTmBFYG1C7Ed0PQ1iU=;
 b=KA0C8t5HvC+v97n1VsgHC7xnqR7x8hOZDVElya9yuPfWxYHpmDnrvtRd3ceE/uwX70R32L2kS
 bvJcpGKgL3JA6U1+hSBq356WoK6fIdOgY07kc7JlRgx2gByohGlc351
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add BPF_TRACE_RAW_TP to the set of tracing program attach types
that can be loaded as sleepable in can_be_sleepable().

Reject sleepable programs that target non-faultable tracepoints
at load time in bpf_check_attach_target(), providing a clear
verifier error message.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e4f69918693..95b33b85698f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25216,6 +25216,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		btp = bpf_get_raw_tracepoint(tname);
 		if (!btp)
 			return -EINVAL;
+		if (prog->sleepable && !tracepoint_is_faultable(btp->tp)) {
+			bpf_log(log, "Sleepable program cannot attach to non-faultable tracepoint %s\n",
+				tname);
+			bpf_put_raw_tracepoint(btp);
+			return -EINVAL;
+		}
 		fname = kallsyms_lookup((unsigned long)btp->bpf_func, NULL, NULL, NULL,
 					trace_symbol);
 		bpf_put_raw_tracepoint(btp);
@@ -25432,6 +25438,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
 		case BPF_TRACE_FSESSION:
+		case BPF_TRACE_RAW_TP:
 			return true;
 		default:
 			return false;
@@ -25461,7 +25468,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, struct_ops, and raw_tp programs can be sleepable\n");
 		return -EINVAL;
 	}
 

-- 
2.52.0

