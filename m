Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA23049EC54
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424725; cv=none; b=hYaEhoxWJhegP/hM+r+Qv+lzT9WTDWtExcSktJnsQLw/5Z5QIIzTvzqrw8W6f+tR71vJ1Ilvz4JOrOEdw16fdFIwdlCPdauXJe8B9fzLdhQhKSOdgx+z3irYfcJGr+SrxLjCGS4U728K9kDF3MYbdYyePvDxwwVCXMsoRLQv97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424725; c=relaxed/simple;
	bh=ID6Y65CwWHga0hnCKzuyxwrWH8xyC9r5Sy1cao8fU14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPPtwRAYczY3c/B0SY/CekwUN3h4RDKwLDF01AIm/bxwDzAPInIdUVgmkRS1bp6n7diCWItXGRK0UiahQekXeqalGtXkiS+923c0fnlxtMpVSz+dgTk4mu8o5ISJ7Yg/oo2Tv9E8Ken9qgy+kVNTd0+jzfEN+pixFCoCladk/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyaAxy9V; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyaAxy9V"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-49ced856e8dso16195785e9.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424722; x=1790029522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=re5addDA1VV6xer0u5y9owcslkAeqlEbuLGhZh6ysp4=;
        b=hyaAxy9VDiIBm5mjg3rXk0R24MYwWgf5KVRv18mda0HjN9MI5LUUv+u50jkZySLkuq
         KMf+K3bGlZbVLKuRBxqm/0cVf29atp2BiQ5g8RfwKCCw0NBf/IqtPtYdM8gglkOadr2g
         X45e9gr6tYwcbMiWhlIrsRjgDzY5A5ieXS0QQuoAdFE3OO9Ne1vU6HIcb8sSZa1crTad
         +MBMhTJpjnkkn6Dnyj8pp9lg1WsjByFPgflEYdddIkUvkzq8tNC2AYFOUE7xHVET31a+
         V3SNF0XcrQxOCyCtNWmm7+awpWdTk+9GVmpwf2gZjLGrvHZbV8BzkOwcUlDsBlAdtq6f
         yxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424722; x=1790029522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=re5addDA1VV6xer0u5y9owcslkAeqlEbuLGhZh6ysp4=;
        b=nxrbD9Yw53hqON9dALEgPqRWUrl7kcs0YaTkBXYlGkDGEQ+Ufv/2ah9pMHlYkmTfPB
         0zh/vJUkDRvbD3/QcE8eXK4zeUhK76ixdiYdvpV5mDqgZpk6j33+J1PMAf330gr40T8b
         Faw6JRSkdkbkdbxAbfWIu3WqwuT7iLF3/7AGGwcz94BFDs5PnshOdJvFYLZ9brwf4fHT
         RaNy2VEWdNNST4Naesuks9pN9dPYml0U9hkDF2IS+EMmW97jGqqTFSOUaDzwKzpm1kBN
         glUBKP1ddpqcLuGFKmX5xnWljQMVm4mtNaxSkbmmKXu354pDYAk/YPpRmCuKSUm5L+zA
         OqBg==
X-Gm-Message-State: AFuF++n16nuhwDpP/aulb34J8BmG52bKC6RSa/pT25fgxGtLA1bWU8eT
	6j4MY0aM/mZXHgd+4HJr5KgK0s/xN55K4Rj59dq90GL16f6cxjTG23CmgzZ8XCfZ4HI=
X-Gm-Gg: AYBFou0hPvU4sJDXlADICOa6ANOKIQafKVTHC+j20GX4LL8ASRBPhdgko7Flsj5YWQQ
	0jzWKKdADx8sXq/LIwIFy5+qWkndpjJROqCPlDmq29X44rg5e7XTwQtxrn2HVnmn2jgPoOwis1q
	HNqi6hi1ZIRu6jCUr2khCemwVepryRhSlvFccswXL6s5zJxTAYrcW9+c45Hc3hX0K6Dmsw8mlLW
	ejOC/df8tAGLgwjRwyVrUsqT+bytj3Wjg4+7FBHBBoJgxn0a44eUIsaVKrb7eBu/cuttKRspB8I
	ucYCmsv3qywr4kddKkV9a/Jb3KDP1II3gg+qbn4AqfJsY08s2qa4rKsIuaHm9Lkc7zy+zHMjgMO
	m0lojY8+Zvz2FgM8UTTcenOWTM+zm109Xk7ThPHBsQPubzF9FdKIOJFkXtN7vyfmzvvkvUh/I8Q
	jJpMLGRMJFbI9f/3VIx09MivRwNm90qjBGTufTaeQTBhOqEC+IdrUyBju3BUB3Q4Rtuc/y82CJM
	r75ffE+eW9x60ZyQMcjWChWq798evtNaJs2Bekpp+XPY92NpBvOzyamyF7cJTaDpi8fTwcnANzB
	XgMY05V1UNd5CnsExMvTdh4PhzfenQuc+p3Ijw==
X-Received: by 2002:a05:600c:4e02:b0:49d:272d:74b4 with SMTP id 5b1f17b1804b1-49e7a6387bcmr142238945e9.2.1789424722127;
        Mon, 14 Sep 2026 15:25:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6a9d1dsm23148745e9.10.2026.09.14.15.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:25:21 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v4 04/11] bpf: Apply CO-RE relocations before subprogram validation
Date: Tue, 15 Sep 2026 00:25:01 +0200
Message-ID: <20260914222514.1635018-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914222514.1635018-1-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3995; i=memxor@gmail.com; h=from:subject; bh=ID6Y65CwWHga0hnCKzuyxwrWH8xyC9r5Sy1cao8fU14=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtFid6eLeVFV544Xlc4EnJmZfzplRPy+DxP/RWap/FR4 YjfG4lXHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZhIwWmG/54J6uwdfyz65/6Z maX05Uvf0/rIRdM3Np09f8/n2UXJZF5GhltdrPnGa7iLuh+fd/rRkhtwobd2um3CfQW1BRGiqU8 V2AE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

check_subprogs() verifies that each subprogram ends in an exit or an
unconditional jump before in-kernel CO-RE relocations are applied. An
unresolved relocation can then replace that terminal instruction with an
invalid helper call. The resulting fall-through into another subprogram
breaks the CFG invariant used by postorder and stack liveness analysis,
which can write past their per-subprogram arrays.

Apply CO-RE relocations immediately after preparing the program BTF, before
subprogram discovery and validation. Keep func_info and line_info validation
after subprogram discovery because those records depend on the complete
subprogram layout.

Include core_relo_cnt when deciding whether to prepare program BTF. A load
that supplied only CO-RE relocation metadata previously skipped both BTF
setup and relocation processing.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/check_btf.c       | 12 ++++--------
 kernel/bpf/verifier.c        |  7 ++++++-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 36b65797877d..bba5a727c651 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1197,6 +1197,8 @@ static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
 
 int bpf_prepare_btf_info(struct bpf_verifier_env *env,
 			 const union bpf_attr *attr, bpfptr_t uattr);
+int bpf_check_core_relo(struct bpf_verifier_env *env,
+			const union bpf_attr *attr, bpfptr_t uattr);
 int bpf_check_btf_info(struct bpf_verifier_env *env,
 		       const union bpf_attr *attr, bpfptr_t uattr);
 
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 0e8b3ccc7a5b..4c1ed842f661 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -338,9 +338,9 @@ static int check_btf_line(struct bpf_verifier_env *env,
 #define MIN_CORE_RELO_SIZE	sizeof(struct bpf_core_relo)
 #define MAX_CORE_RELO_SIZE	MAX_FUNCINFO_REC_SIZE
 
-static int check_core_relo(struct bpf_verifier_env *env,
-			   const union bpf_attr *attr,
-			   bpfptr_t uattr)
+int bpf_check_core_relo(struct bpf_verifier_env *env,
+			const union bpf_attr *attr,
+			bpfptr_t uattr)
 {
 	u32 i, nr_core_relo, ncopy, expected_size, rec_size;
 	struct bpf_core_relo core_relo = {};
@@ -414,7 +414,7 @@ int bpf_prepare_btf_info(struct bpf_verifier_env *env,
 	struct btf *btf;
 	int err;
 
-	if (!attr->func_info_cnt && !attr->line_info_cnt) {
+	if (!attr->func_info_cnt && !attr->line_info_cnt && !attr->core_relo_cnt) {
 		if (check_abnormal_return(env))
 			return -EINVAL;
 		return 0;
@@ -455,9 +455,5 @@ int bpf_check_btf_info(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	err = check_core_relo(env, attr, uattr);
-	if (err)
-		return err;
-
 	return 0;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddba53eaa333..68d1b67b8c1a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21271,6 +21271,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/* Apply CO-RE before validating the program's instruction layout. */
+	ret = bpf_check_core_relo(env, attr, uattr);
+	if (ret < 0)
+		goto skip_full_check;
+
 	/* Discover all subprograms before validating their layout and BTF. */
 	ret = add_subprogs(env);
 	if (ret < 0)
@@ -21280,7 +21285,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	/* Validate BTF against the complete subprogram layout and apply CO-RE. */
+	/* Validate BTF against the complete subprogram layout. */
 	ret = bpf_check_btf_info(env, attr, uattr);
 	if (ret < 0)
 		goto skip_full_check;
-- 
2.53.0

