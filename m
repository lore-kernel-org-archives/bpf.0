Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB8385507
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487953; cv=none; b=itSNd1MtQWpB49ABSUr0WcmO4WU8mSHMifqJEoWHtHm11ZZUSmnbNhx0sSKccL/02Nro8LxYO7116AnC0ha2v+Xu+nGLYt5VrqlA8Ptw5KmCzTseHmHtLAZLGSaZCYWOUYlPoEJEQoTJKtkapT9bzCppTWma8C5aS7x19LviqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487953; c=relaxed/simple;
	bh=inP8IWyzasTe5yoJH9yJ8hk6uvFkHwT61UW/mw9Qa9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOncrXAj5jpE51CXOT4UJgQp44kK8mQTmtBT5tTD3+1RuxrhE6J561k6uZffYhDYTqiOK+PZVHBF7V4zlSydgGXYXJ2ctX8M099YvgSaoNSwJmZZ38BwQ2TLhccRPUw6RMs4e5zn+bzUlCHDln0EwCfAtKQEBVczXLh7gBfxRyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFd/xOrx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFd/xOrx"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so1541030a91.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775487951; x=1776092751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Me5St7Bfny1Sj+wrsInZ+GKtX/2F6TdAdaII4/oPRnQ=;
        b=TFd/xOrxI0mkDBwTEPYSJfBgPum3ogemvjpx9wXLXeAUGH5ra0Lb1O/WFrl5cBKHnA
         jBfyXgBmiaBY/GFLGnmjTXk5ivDtiBiXbv149/gqkdVOW/Qd4tX6LmnUgiKIvDiIbTyU
         fk9DyTPNa8u+FRjXT/BQm92lAyD2ri975HAjy4vbsf3ID8frUFD7cBEsqWTUpoUZX++a
         eqXXvgYf0wl1NTjur6E2zoRuby0q6OH5XsQGcYWDKdDaqIBOMX/91GuyfqUpLVUsqT/x
         pbFV1r3jcYPTwf1qgvMZFjFVXueTrkO7L3mPTy5dH/tei4tDBQep3kSDvm1QzbScCfVd
         dWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775487951; x=1776092751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Me5St7Bfny1Sj+wrsInZ+GKtX/2F6TdAdaII4/oPRnQ=;
        b=ZBN+yiaL+PH9FD2BXMplQWybl3PjRotaM5hVJuLSB8/Rku59J+VuUmMvt826/gsG1T
         3MIzCTVppR9lepKjQ1qiYMorhu1yURcHEJwoT3jqlhnvRIzXpskt8iXhzduJINXmddu0
         y9nEus0B6eNZqZK9NhJCYJGLCS0onITQiLQZfeXNOlasNscuHjVnrjhjQyIkWOTktriC
         PblfXdgfZgsANOsKbcjI535ueIXbVWRVVsUHBBeo6o+7CVsxCxh7dSBm8rfpL8XIOf++
         jZWSBEpue6MfAFXuKrgpKiUQ5BHUNkXQ6ydbsrpQd4CvExw8Eq4pB2r1/YZTYzR9Oa60
         MAHQ==
X-Gm-Message-State: AOJu0YzbAcMnOLFnBu411vdPmQvv2plg5gOjILpc+3VzRpcr0UC6SMkv
	9eC7vEVP7HEncsFpxwEZ5dSNA0S87vDpzavbPOQIbAdpXDWDEdNc9fMoa2DQuA==
X-Gm-Gg: AeBDiev1/0D5sVna1/nPPEvSFl9S0DPuAXfYYosY3JFRdRPwPUmfoIyEve9FgGZw85y
	jiJTg7H2Mx14Fc6zFH6FDDW6cv7tod4yu0UYNsRODLKADjSycnLm2Qtkl6jtBVqR7R7DZmWc8es
	fzLLKNmQVr4U7/GJMnlhnZ3WQvYwKQs+86K3ryNvqrfH06tYtC7jZLSx0hh1qpo3jsXapzIuRy0
	ClElMTMmLyVicbJCygcZuSRjj628MkdAQYHAdJ+JZq2/7eBIuxsD0HBuQAVYZvs10Gd1e4N0EbL
	O4/65dRTfmDnJO+4MCvZddC3/4MXwW09d3U+S7Sd8h9EAWLviiZXkDfviYzoIyTRbWdN8D3wepE
	/bAK+fELGLl0un/cyR56TngAL5RHsp6aqv0dATWOrAwWyA3ni3LOcqa5O8Dto6XemuDCA326eT2
	A+kM3pYEDe1H57hQ==
X-Received: by 2002:a17:903:1984:b0:2b0:9101:1b77 with SMTP id d9443c01a7336-2b2816dc13cmr147268855ad.17.1775487950900;
        Mon, 06 Apr 2026 08:05:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af19sm138830725ad.50.2026.04.06.08.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 08:05:50 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	martin.lau@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Allow overwriting referenced dynptr when refcnt > 1
Date: Mon,  6 Apr 2026 08:05:47 -0700
Message-ID: <20260406150548.1354271-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260406150548.1354271-1-ameryhung@gmail.com>
References: <20260406150548.1354271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier currently does not allow overwriting a referenced dynptr's
stack slot to prevent resource leak. This is because referenced dynptr
holds additional resources that requires calling specific helpers to
release. This limitation can be relaxed when there are multiple copies
of the same dynptr. Whether it is the orignial dynptr or one of its
clones, as long as there exists at least one other dynptr with the same
ref_obj_id (to be used to release the reference), its stack slot should
be allowed to be overwritten.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9523db3fe90d..147495099a23 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -934,8 +934,27 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 		spi = spi + 1;
 
 	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
-		verbose(env, "cannot overwrite referenced dynptr\n");
-		return -EINVAL;
+		int ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
+		int ref_cnt = 0;
+
+		/*
+		 * A referenced dynptr can be overwritten only if there is at
+		 * least one other dynptr sharing the same ref_obj_id,
+		 * ensuring the reference can still be properly released.
+		 */
+		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
+			if (state->stack[i].slot_type[0] != STACK_DYNPTR)
+				continue;
+			if (!state->stack[i].spilled_ptr.dynptr.first_slot)
+				continue;
+			if (state->stack[i].spilled_ptr.ref_obj_id == ref_obj_id)
+				ref_cnt++;
+		}
+
+		if (ref_cnt <= 1) {
+			verbose(env, "cannot overwrite referenced dynptr\n");
+			return -EINVAL;
+		}
 	}
 
 	mark_stack_slot_scratched(env, spi);
-- 
2.52.0

