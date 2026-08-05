Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45F34FF78
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963873; cv=none; b=ulCzCRtD2N21hosxJEey/YB3CWwA0YnUqwopoaQj/hWNzIa8JJrQ2zMnpKgwlrbcY063BfQuo3ahLwdWzD35SXQ8fvdl0vUhH7rLxUQnZectb+ajHeWOmj9qIpU/MSGO4ffHgxwldmGwAk+BxFTev1KbxkbkVUJo4KR1VmQuH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963873; c=relaxed/simple;
	bh=s8mRmDOcULFp1RgzgT1mUQ3QkPKpHBpvGMN2dGB0Q7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCg+XXHNnjdC7d3P4Q4lZvhrUxklBl61u5j76WA6dXQVr5nhFHCsM8xNfJIa3pWoU8Jeu/a7+5RvjaTrudCTO2OAEMxwOmJbCJLxscYNaqYwkyk+j93cfhGkiNfG03uQj4CXKRbyFF1X7B3RUGbTCS/533CTxVGFUQZe0tguCMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di3puUZ7; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di3puUZ7"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so1527615e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963870; x=1786568670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sy6JK6a4j30oWFxQh4NgBaEKW387mWNWmVAbhw/lhbA=;
        b=di3puUZ7TJiICrBZEiGKSmGMRBWplOZCzw9NbGPZLUzS2gwiBusB/jzC3XKAjvAFli
         c4Q9sBVP+31WyLIZ5nI0+aEbaiNFnfxGX7vMEPuLxYPihF3XrOiObLlvNsfLndwrQ1pw
         qw1q+W28PzO0aeBAn828lzgVFv3x1nnxE6dafSrLDuXvPvlcHarBzttkATLiwR9JxrHS
         4oE+1bzDOO2n0jN43x8d1K1ebphqug0E3iv+gvQs5YfrSwOMeo7L2MMqlioh+abg1Gxr
         4YAs4kSp4MiO5Xa/Q8gMLBUClFw7sZdOle8CTkiaYm0+YLf6/D9MmeOdqNQeEXj09g9Z
         P52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963870; x=1786568670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sy6JK6a4j30oWFxQh4NgBaEKW387mWNWmVAbhw/lhbA=;
        b=q3Sc+pHn4n21rwE/24b2rNIF6iFCfjTMY7HGr0tDxyLqC29Y3OqY8YVi9d3LWOeSKD
         fhQPn6eyT4klZTlfMIBGf7YNyCr6+/HfGK0gBEiy5K95weVhQKlLd4wy63fGnHPyx1xQ
         Btht9fXjIJkBFLT8YTV4HtgsGFMRZGkSjn3kTlCNqF8qkvwPMZjuEARtHYHC58VpTpSI
         fH7ByB7l8m8YUGGqqxqLf5eMFGDdM3ahyNMBpHSAMfIoG1f6mFsE1FFqCDcif4DivwYz
         lef9VRo77Fw1ymKaO8tNueb/ieqVuSvPdC2XbxnzAC9cNMu/sJr+3cSQ+Pb3ucBGoC0A
         Ge9w==
X-Gm-Message-State: AOJu0Yxm22002PtHQq/7aN4Jd5KZL/WaD5II5roEYYVqWNQzO6KbwzWq
	btzJXJ2w7ojD5OlFvXbHxop618QMwD29pdmCNN+dFotob5rvEy3Ussfr5MauZ2yH
X-Gm-Gg: AR+sD13mmdjRtNooYHqkkF0tT48kiKHLFNWwZHy3HoYOO8KGpw7/wVqpJ1p8ij45Yjw
	3Nv2zVGfP5cN6dJWxvQoZpeGqOzZgKJzK2pLQ57HpCq6nRnaQmerUL42VUpdU+63Fx7HCidLpzX
	e/RJfCoQe6XBus4WteA/avPG27XQ55uOja+nlPWioIrQSo7HK0vwCPVmskc4Hld3KXj+8iCJrJo
	sY0LMP7YrpyJ0HgetYt/jBrfR6kLLRX0fl1varOXu5Un8gf0HFpKI1L0NGPzraOIfwep6Go1Ppp
	pJeKl+On7fOQBRqk2sCkGv0XxDJoPjwfrQEnNVIgulvvmDR/f8b767FQW5BH9JnnewzSg9bY1zV
	piu3k22geoOF1uvt8PzPoPrwar7zxG41LFelah8NtAYzpvYYM0nJThgP3YmQt4fPj6K+CDfXeIx
	4YwhrGd+IDG2j51xcCNEp73hBhmTew2vfaekAdAioUTMTxM95pAt/wk/rhhn00VuGlIqTm+mlJK
	DhHeCJTjQuvdX7lio3AjNHH2At+UTJDVUxTRXoTNuHcXDZh6X/dBWH71TfuE5Qjr4JCcTJem2kS
	h9PRN+XzXeJu4BeReK1uhWqDzns=
X-Received: by 2002:a05:600c:468c:b0:499:4d4b:3719 with SMTP id 5b1f17b1804b1-49952ef3dfemr21646725e9.4.1785963869913;
        Wed, 05 Aug 2026 14:04:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b25b4asm252064f8f.26.2026.08.05.14.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 01/13] bpf: Rename 'early' BTF checking as a preparation phase
Date: Wed,  5 Aug 2026 23:04:12 +0200
Message-ID: <20260805210427.3218326-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3792; i=memxor@gmail.com; h=from:subject; bh=s8mRmDOcULFp1RgzgT1mUQ3QkPKpHBpvGMN2dGB0Q7k=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40aSIr75BJ6Pf3c5ocTiYcNc/boro3NIyoS11drviz 1Y+Lb/fUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInUMzP8Falf1x+49deTpPU6 60OvxPC0pmjurRcov7uiWOKYoQi/I8P/hCUciz5OrTP58/OL0Wyzf7tv7zHuUTw1M4C1ZXm1Y+J RVgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

BTF processing is split around subprogram discovery. The first phase gets
program BTF and imports func_info because a BTF-tagged exception callback
may not be referenced by any instruction. Subprogram discovery needs this
metadata to find it.

The later phase validates func_info and line_info against the complete
subprogram table and applies CO-RE relocations. This split breaks a real
dependency cycle rather than merely running the same checks early.

Rename bpf_check_btf_info_early() and check_btf_func_early() to preparation
names that reflect this role. Add short call-site comments to make the two
phases and their responsibilities clear.

No functional change is intended.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  4 ++--
 kernel/bpf/check_btf.c       | 14 +++++++-------
 kernel/bpf/verifier.c        |  4 +++-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a2a40caca0a0..a9555d17fd8e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1177,8 +1177,8 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 		*btf_id = key & 0x7FFFFFFF;
 }
 
-int bpf_check_btf_info_early(struct bpf_verifier_env *env,
-			     const union bpf_attr *attr, bpfptr_t uattr);
+int bpf_prepare_btf_info(struct bpf_verifier_env *env,
+			 const union bpf_attr *attr, bpfptr_t uattr);
 int bpf_check_btf_info(struct bpf_verifier_env *env,
 		       const union bpf_attr *attr, bpfptr_t uattr);
 
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 93bebe6fe12e..0e8b3ccc7a5b 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -28,9 +28,9 @@ static int check_abnormal_return(struct bpf_verifier_env *env)
 #define MIN_BPF_FUNCINFO_SIZE	8
 #define MAX_FUNCINFO_REC_SIZE	252
 
-static int check_btf_func_early(struct bpf_verifier_env *env,
-				const union bpf_attr *attr,
-				bpfptr_t uattr)
+static int prepare_btf_func(struct bpf_verifier_env *env,
+			    const union bpf_attr *attr,
+			    bpfptr_t uattr)
 {
 	u32 krec_size = sizeof(struct bpf_func_info);
 	const struct btf_type *type, *func_proto;
@@ -407,9 +407,9 @@ static int check_core_relo(struct bpf_verifier_env *env,
 	return err;
 }
 
-int bpf_check_btf_info_early(struct bpf_verifier_env *env,
-			     const union bpf_attr *attr,
-			     bpfptr_t uattr)
+int bpf_prepare_btf_info(struct bpf_verifier_env *env,
+			 const union bpf_attr *attr,
+			 bpfptr_t uattr)
 {
 	struct btf *btf;
 	int err;
@@ -429,7 +429,7 @@ int bpf_check_btf_info_early(struct bpf_verifier_env *env,
 	}
 	env->prog->aux->btf = btf;
 
-	err = check_btf_func_early(env, attr, uattr);
+	err = prepare_btf_func(env, attr, uattr);
 	if (err)
 		return err;
 	return 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d925197c2e5f..129e50888b90 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20317,7 +20317,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		INIT_LIST_HEAD(&env->explored_states[i]);
 	INIT_LIST_HEAD(&env->free_list);
 
-	ret = bpf_check_btf_info_early(env, attr, uattr);
+	/* Prepare BTF and func_info needed to discover all subprograms. */
+	ret = bpf_prepare_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
 
@@ -20329,6 +20330,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/* Validate BTF against the complete subprogram layout and apply CO-RE. */
 	ret = bpf_check_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.53.0

