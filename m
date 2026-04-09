Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E5261B8D
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698417; cv=none; b=MsNWCfTIZ7sEFl7D2KUKK6EGSsmOJaI94ODshaQBtU9hRWih7URqSLDCtYcEu4BKMHZ2mSrHwcukSYw6u3tFlVviPp8zCoILYiYb538m0b0ohw0TLHTnK/CvuspVdMPdEhOS1C3J4Cgs4hcHCy1xZ70JrKZ5LfEGg61DzLFsj9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698417; c=relaxed/simple;
	bh=t9hBgMjeTjp1KXTDaxFroLco9foaWHWB5VvRbLr9rqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cov/s7YHc9wdCgGzSi8IKu5a1xulcptuVcHdWF3dsL5T68GOgKmAYoxSZpzayiOdRJOSXkcTVDMx4Sbqw1/cxSEhEyVqyYE095yxFrhzrR8tt5sP9K9NnNaIKwH/U1fK6xWKCWUj/aqS98h9rld6TXmoqVktspnzYlzGM55iy/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ob2F4cGZ; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ob2F4cGZ"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1271195d2a7so505141c88.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 18:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775698412; x=1776303212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbAKcVf3ewfS7gcDVxF0UxFCd7HDDNCIrtelgTNhqRM=;
        b=ob2F4cGZZCZdOWge7yGISeJ+OYC55Hj4hnJBKbc7yv+vI0gen4WGS3ONnz4KcpBw3f
         rOp+VVPnblAD56Y/lTA9Ln2MewsSy1PD/1VJeKbgraQAYupsSUTHl1ubqDLsOaXMwzDp
         UUkKpw0klGoOZallFoFsAbKh7n9NUpoU/Q9rUssEzf0jD14H5eE9m4uIGI0I92413glE
         bupfatWzJMM+9m7t7ziZ61lLnv9OVYKND00TZljFZ9SMaA4JtVVV0bv6RILJv6rWr4BV
         roxUZ+jvmYHAxSbI4nHknlVmjAR+TCLfKDMZecZQxOlmCYIE6UAcn9uzWn92LW2rhJOc
         Os1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698412; x=1776303212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbAKcVf3ewfS7gcDVxF0UxFCd7HDDNCIrtelgTNhqRM=;
        b=qiT94o31NvkXvV4PMdkruJ+Y8qy6FbCUDuvkwjNFpoRAV+GfvwXYzbLNcn9z+KUxgY
         DVpJiyOctwYaWPkB+BLKAySvto/fSXfU0oAjmWZi1+S6btIBRBnv+RHt2tY2mU0bJw5W
         fQ4WsnB+SDR8l56nH8D6fkYEQOKG8PDvWNOllU5VmxIMa4MSME4j2jJjurifGtfyaovA
         9JEEVsnNYHKqjYsbxR4BcLaTVm0NFkvo8MGXAAEM8wK9Uvu3RtX43UBU5WE9IOr5to6C
         cIeYN6JiQvVmUSV7rCidzSKGeTHSVo+0fuk+rbXI1YARJXOmCvNdqussip2MtPCMLfnB
         hy8Q==
X-Gm-Message-State: AOJu0Yz8yyLr2bCXNRjSGKhENxAzDo0IRAuppaHGY14S6MklYPYYsrSQ
	PegdH0CGnMwYj1mOdlrM5g52f728aBWb6c8H33DcJtvM22RgVJ6DmUQzVi40U9YV
X-Gm-Gg: AeBDieuwJKw0uPJDxvxNKxnALK+psuOz3fC3LwgYri3SUh2KOoh64gMyrc8f8F1fO0r
	WWZu9B82bNWdIHZ5iYc5i3oItnrjoo+2+lRUWSmyJFaPwAzy3swvANI5kG5XNiIwaDgma3MdOck
	H0iSe7EPYrppewGCoJtsJ6SmC7uL5TZmXhMDjfgt3hQC2jGJfqH8aBN8GHQdpWkdWSdyAxn3WKi
	OFww9QKo/ObfFeGz/UcTduEmDkibrcEccpTYcPecPFgDQnadURBNtw7NGawvMXmd4v6bGUSwY3o
	Fdnyx1lHnAoQS8++bIN2NKPmy4m41tIHRL/tm5kcETi0GCQQQqBU+5uF+J1vD3ewHjsWo+Upt/q
	Nt4jK823KV3+vZVIjkLhoBwd2mB3aJ8Is1qqqSxH4kwWDnjxC0I8aaADDpXiC9BKDTo74ejCcXs
	tanTdQ9zEaPrpz7rDz8cUErVU7jZsfO6iNQxkY+C14MPDNwwyr1oi+CUgk4yB3a8UKR2YbI+K6Z
	ZI=
X-Received: by 2002:a05:7022:e2a:b0:128:d34a:320f with SMTP id a92af1059eb24-12c28bafe84mr1161919c88.12.1775698411877;
        Wed, 08 Apr 2026 18:33:31 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::c05])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c0ce7dfe8sm15943230c88.3.2026.04.08.18.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:33:31 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 06/14] bpf: prepare bpf_liveness api for use by static analysis pass
Date: Wed,  8 Apr 2026 18:33:08 -0700
Message-ID: <20260408-patch-set-v1-6-1a666e860d42@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

bpf: prepare liveness internal API for static analysis pass

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
index e2697cd9ae27f95970a7a495a362c371d27922ed..a3af5972520f3c19d4d5fc003d2ca8088d6b4489 100644
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
