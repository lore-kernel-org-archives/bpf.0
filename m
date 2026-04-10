Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1513A9D8E
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854583; cv=none; b=eGw2+m0b0Oo4GxTMkhhToXa3dquweJ+hB/2UyVusBD4yUtqd5uFAtuPMu78FVJOOgMS73DWqSlvgOL4fiEMu2OGLGk6St72C9x8Aphxe/nJhX7K3OhiKoMpddk1vNhhrBWGg28wPvBnqW9HglaqZHJxgtpr0k1d6HWQLOTiO+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854583; c=relaxed/simple;
	bh=u6iusf5tuKywVODCINqkCk5uwmMsODFm3KQxI1raOuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtuXly3GXJat5MfNQw83+voEsw/eNI9eC7DQsDsGw/9A5AYQ5tUa9n+1F2cIlQPSouwj0bv7xF/3M2ns2zx9IkXe3fRwYlQiM5KVsnzEQClTTsESnMire+akB7J3msqz2O79n8aD8gAQ3xQSa55vlRpoNxAW7YT9ZgYCInWeUjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etB8i2MO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etB8i2MO"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c74f0c3fc16so943979a12.2
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854581; x=1776459381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4ax+7l+KaTUDwjPOmMMjVlIxca5vqLLdC/YwcGecMc=;
        b=etB8i2MOWYa+W934SdOc9gPTggnr7+HJG9qd/ZeSP52gkQecUa6ys6hW2gjVrVyob+
         sqXXEDZoibBtGg7tZ0bOddgMlOsb0rsxcchZSqeOFG/BWy3cyIBc0Sw1vEYEDrO7H9NE
         PsUqDj1nHumUoRBA2OhNr96DaaDOTsMQHzOIvCrupVYx7t715E1iEh8meUnxM8O+pRkB
         GfSc00xNueTwDit/3WVmBrhGcC15HxEbSaQm327TVp5TAcdRW5AZ8GqoG2jxvMcBMUx+
         bcDr2JWh5FUhYwh5TafR+NheMkeJe1QWbc8huRqd9A/NYTExwhrLYHsI9Vt4wY0O/b2j
         a7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854581; x=1776459381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n4ax+7l+KaTUDwjPOmMMjVlIxca5vqLLdC/YwcGecMc=;
        b=VCoFpHpadIBAL8PefxWqzmfMYHRpm5McVxdznox7mpMTrHofQKSLoGaViGuukY3Y6Q
         b92uO8kf6yPDKKApkJkgut8NNydst7d6/8XloEtRCO7AjU+LSdKADtuVbGDWwU+CJcKs
         WqLZ7pXBhiAeLRb6jrHt66PbEgfI5RnaKcXLFC5SaAIn7dix4HXYkZFI6lffp6A1n01Q
         N8u8R0PrvcYgS+AJban57JyZtrnZTtvKYUJzySBGtM6uDNAZopNfhxJcj7/KT9FYJaZX
         /I93tXWXnA0/pSVYZPL7MLF3FzCG4D4JFceHtHJEFr1nV5AtmT2P7/mdMJdbaVkHLrIm
         1EHw==
X-Gm-Message-State: AOJu0YzW4rVPVqyPka3RzytXbH6ti1RE7+oMd6oOpMbDmufAh+mlXH1v
	jyogBm+VASp38y/4xZa+Zbpzg8WsRcZwwxNQLzywdQMVOGnoLTB960/YrgRMdHPq
X-Gm-Gg: AeBDievHOwOtokRjRbCTzF+t2SXJbMu+22JGKXYOrgymfupLsgklQjc/aUwjMIYjL/z
	6QU8zbB2su3oHCr9nt0EqD0k8QWkc+Jr859tg5VhkOAZkleLmtTFgP16zTwpLDOHBK5KOCKU9Dm
	2/HRsuOplg/VYRjM7HjTSmDWBPhB8R5XlNx7bWwur26kPVnT0YfI/njZr7ue8POAzBDNIwCmc6C
	Sr5V6eOBLcfHz5cTJNp8gl0BpudYOXeYGb8nqGZu8BsVM4qrAxJ3VZLOCCpxCz6ThxQjt++sKgE
	39Li7Ee2sn6Xio1qp7MPlggRXRk18Ci61Mn/MmoHGhkqiCOGWt2BMR7py+tlj6UalDRPlwuMRzy
	6h3Fuovibu9/QUxpOHGAljx5tQKpFG/ySeLdubCesTWltVuOiL+jTrEfnNLe5D+BKYJCkkdLIL6
	ngkzvAi1wuzA8WUcKXf0e8hQGfIW3YIXPTLKF+C6KuyGW3Zd5ehBTXeYSZFSpmnHcDkY8=
X-Received: by 2002:a05:6300:210c:b0:39b:e789:7d10 with SMTP id adf61e73a8af0-39fe409f9d0mr5417192637.57.1775854581448;
        Fri, 10 Apr 2026 13:56:21 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50a8f7sm3551648b3a.56.2026.04.10.13.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:56:21 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v4 06/14] bpf: prepare liveness internal API for static analysis pass
Date: Fri, 10 Apr 2026 13:55:57 -0700
Message-ID: <20260410-patch-set-v4-6-5d4eecb343db@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Move the `updated` check and reset from bpf_update_live_stack() into
update_instance() itself, so callers outside the main loop can reuse
it. Similarly, move write_insn_idx assignment out of
reset_stack_write_marks() into its public caller, and thread insn_idx
as a parameter to commit_stack_write_marks() instead of reading it
from liveness->write_insn_idx. Drop the unused `env` parameter from
alloc_frame_masks() and mark_stack_read().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e2697cd9ae27..a3af5972520f 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -259,8 +259,7 @@ static struct per_frame_masks *get_frame_masks(struct func_instance *instance,
 	return &instance->frames[frame][relative_idx(instance, insn_idx)];
 }
 
-static struct per_frame_masks *alloc_frame_masks(struct bpf_verifier_env *env,
-						 struct func_instance *instance,
+static struct per_frame_masks *alloc_frame_masks(struct func_instance *instance,
 						 u32 frame, u32 insn_idx)
 {
 	struct per_frame_masks *arr;
@@ -298,13 +297,12 @@ static int ensure_cur_instance(struct bpf_verifier_env *env)
 }
 
 /* Accumulate may_read masks for @frame at @insn_idx */
-static int mark_stack_read(struct bpf_verifier_env *env,
-			   struct func_instance *instance, u32 frame, u32 insn_idx, spis_t mask)
+static int mark_stack_read(struct func_instance *instance, u32 frame, u32 insn_idx, spis_t mask)
 {
 	struct per_frame_masks *masks;
 	spis_t new_may_read;
 
-	masks = alloc_frame_masks(env, instance, frame, insn_idx);
+	masks = alloc_frame_masks(instance, frame, insn_idx);
 	if (IS_ERR(masks))
 		return PTR_ERR(masks);
 	new_may_read = spis_or(masks->may_read, mask);
@@ -321,17 +319,15 @@ int bpf_mark_stack_read(struct bpf_verifier_env *env, u32 frame, u32 insn_idx, s
 	int err;
 
 	err = ensure_cur_instance(env);
-	err = err ?: mark_stack_read(env, env->liveness->cur_instance, frame, insn_idx, mask);
+	err = err ?: mark_stack_read(env->liveness->cur_instance, frame, insn_idx, mask);
 	return err;
 }
 
-static void reset_stack_write_marks(struct bpf_verifier_env *env,
-				    struct func_instance *instance, u32 insn_idx)
+static void reset_stack_write_marks(struct bpf_verifier_env *env, struct func_instance *instance)
 {
 	struct bpf_liveness *liveness = env->liveness;
 	int i;
 
-	liveness->write_insn_idx = insn_idx;
 	for (i = 0; i <= instance->callchain.curframe; i++)
 		liveness->write_masks_acc[i] = SPIS_ZERO;
 }
@@ -345,7 +341,8 @@ int bpf_reset_stack_write_marks(struct bpf_verifier_env *env, u32 insn_idx)
 	if (err)
 		return err;
 
-	reset_stack_write_marks(env, liveness->cur_instance, insn_idx);
+	liveness->write_insn_idx = insn_idx;
+	reset_stack_write_marks(env, liveness->cur_instance);
 	return 0;
 }
 
@@ -355,7 +352,8 @@ void bpf_mark_stack_write(struct bpf_verifier_env *env, u32 frame, spis_t mask)
 }
 
 static int commit_stack_write_marks(struct bpf_verifier_env *env,
-				    struct func_instance *instance)
+				    struct func_instance *instance,
+				    u32 insn_idx)
 {
 	struct bpf_liveness *liveness = env->liveness;
 	u32 idx, frame, curframe;
@@ -366,13 +364,13 @@ static int commit_stack_write_marks(struct bpf_verifier_env *env,
 		return 0;
 
 	curframe = instance->callchain.curframe;
-	idx = relative_idx(instance, liveness->write_insn_idx);
+	idx = relative_idx(instance, insn_idx);
 	for (frame = 0; frame <= curframe; frame++) {
 		mask = liveness->write_masks_acc[frame];
 		/* avoid allocating frames for zero masks */
 		if (spis_is_zero(mask) && !instance->must_write_set[idx])
 			continue;
-		masks = alloc_frame_masks(env, instance, frame, liveness->write_insn_idx);
+		masks = alloc_frame_masks(instance, frame, insn_idx);
 		if (IS_ERR(masks))
 			return PTR_ERR(masks);
 		old_must_write = masks->must_write;
@@ -402,7 +400,7 @@ static int commit_stack_write_marks(struct bpf_verifier_env *env,
  */
 int bpf_commit_stack_write_marks(struct bpf_verifier_env *env)
 {
-	return commit_stack_write_marks(env, env->liveness->cur_instance);
+	return commit_stack_write_marks(env, env->liveness->cur_instance, env->liveness->write_insn_idx);
 }
 
 static char *fmt_callchain(struct bpf_verifier_env *env, struct callchain *callchain)
@@ -576,18 +574,17 @@ static int propagate_to_outer_instance(struct bpf_verifier_env *env,
 	if (IS_ERR(outer_instance))
 		return PTR_ERR(outer_instance);
 	callsite = callchain->callsites[callchain->curframe - 1];
-
-	reset_stack_write_marks(env, outer_instance, callsite);
+	reset_stack_write_marks(env, outer_instance);
 	for (frame = 0; frame < callchain->curframe; frame++) {
 		insn = get_frame_masks(instance, frame, this_subprog_start);
 		if (!insn)
 			continue;
 		bpf_mark_stack_write(env, frame, insn->must_write_acc);
-		err = mark_stack_read(env, outer_instance, frame, callsite, insn->live_before);
+		err = mark_stack_read(outer_instance, frame, callsite, insn->live_before);
 		if (err)
 			return err;
 	}
-	commit_stack_write_marks(env, outer_instance);
+	commit_stack_write_marks(env, outer_instance, callsite);
 	return 0;
 }
 
@@ -654,6 +651,9 @@ static int update_instance(struct bpf_verifier_env *env, struct func_instance *i
 	bool changed;
 	int err;
 
+	if (!instance->updated)
+		return 0;
+
 	this_subprog_start = callchain_subprog_start(callchain);
 	/*
 	 * If must_write marks were updated must_write_acc needs to be reset
@@ -699,6 +699,8 @@ static int update_instance(struct bpf_verifier_env *env, struct func_instance *i
 			return err;
 	}
 
+	instance->updated = false;
+	instance->must_write_dropped = false;
 	return 0;
 }
 
@@ -721,13 +723,9 @@ int bpf_update_live_stack(struct bpf_verifier_env *env)
 		if (IS_ERR(instance))
 			return PTR_ERR(instance);
 
-		if (instance->updated) {
-			err = update_instance(env, instance);
-			if (err)
-				return err;
-			instance->updated = false;
-			instance->must_write_dropped = false;
-		}
+		err = update_instance(env, instance);
+		if (err)
+			return err;
 	}
 	return 0;
 }

-- 
2.53.0
