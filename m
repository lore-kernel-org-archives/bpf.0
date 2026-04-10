Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D234AB14
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813377; cv=none; b=cxrIaLW/Qyl6rwXtvmmymd9dfURL9Ce1yOgo6X7N64GVH/bLOvapqmpEN4zBLoewvh0UlNZK5odFjnD8WmbOxYDRipxAbBwsm1Lqqo3ZyOOt0kw8kVrb/lWmPLp3N/az/7NA9VwkxbRO2Vj3NY5hY5eAKXRqrjFh6BQZFpTD/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813377; c=relaxed/simple;
	bh=F4GGnIb5seyP18fr5ZRbhJxw2S6r1CKnvwkaXvMuL6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fbeql2TiCU3LSI74D2e76QKTp14Yup1VJOUretxo8q3Aw6paxap3cxsQtaFrWjk2Sd/q4U4TyMnaRibQ19l+gBvteSfwFEptEz03IzlFf8iVmb8Fkzao5CyLuNICoz4gSGdbZ5tz+J3MO9Y3wJ+lnj50qH42PEbZNZyvawVr9qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq8a/dny; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq8a/dny"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b23fcf90b2so17845155ad.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775813375; x=1776418175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7S+A/Oc3aysTE6kCidfW0ySqc2Qh8vIyIh3LVCzQ34=;
        b=bq8a/dnyP/lZBXI2DVo1qNuJowopMl2y/6nvFcEpv8D/ByiEJ+0NyyjZrv7xZv1yHA
         TmUWsEH3Bx8WguiysfHdYjiJAH3hlrwhXoWTzO9scMsXDwmtn14UvD4+8NiKgZCfXwZv
         I0KBqtnqCr9jUs7itX0hHMX8frFqnndKQysbGhG4HpWXwzQTn6sa2uKyExJYudKID29H
         bh28n+84Woi5sQ1CrwxMWIJR+WmfLIJDkCGfh6fv5o7cbTxiGZFEKjAJCUT8ak3a+Ukv
         2fUhSpvP334RhPiYvUU2ZQb7fmwBJpkP2n0hk+zsX5NEX30dSeGBuYThzYuKUHoLNtAD
         TeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775813375; x=1776418175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C7S+A/Oc3aysTE6kCidfW0ySqc2Qh8vIyIh3LVCzQ34=;
        b=FoKsJBb8ZETF22RwLT1wx28dT50oO9BHq7QN9Bt74/TilSfY3+YS4xCdpG0D7H6cQr
         fxxIJ8gbsl3ub/w4ulGTzUQ0cmhl/zGXv7omArToGov9nzcHVe/++CP+Qvb2r6UJLyQy
         t0oZ4+HLxIEvfkxdH6vd7TAkzEQ+WSH/rqLUnN88M37YaNsgNipUmHnhKHbK7nOmst8c
         +BNodW/PMoQBkA950dnpsT8YvibbadFxGZ/9gmt5Yeeqldpgm6FxyNv91TjaqKAi5jxd
         55nqt/D2wI/cFpDROWPGWnqmkF3gPUE898CMRJUgna67QGRd06oggnWDXhctXKubfJhd
         vSqg==
X-Gm-Message-State: AOJu0YzFOJ12iJzlaGgDxasXsK2Dc9OYknn2o+U+w27FdlY8hOp4fgJO
	+z0gaXFWLtFSDBAJUFyEft62+HyOceDqu4QIWX2XwTmYaxzFAad0oUzRna4vkwgV
X-Gm-Gg: AeBDieuYWms5VAk6fqu8ETcI/tDZ08kn/SJWGUuhMLnlF7652/L/UKDGgZNW+E2/sCS
	IwGLlJ0puwRxLpTce/rlV1BYVTsB/WYK5IylMOSjmLqZJ3FXXzz6BZzfdtleN8I/m611RZZmtJk
	jMSjh/Z5pDNYmhobgTINs9Ph17gR132eeNekNRtEyr5ApPMlkYS8ZeIWkZzVlWUQ6GWYpqm8WjE
	+/E2akKCdG5fgxYRF75SwwdyaW8MN+EXXqCC5sEANtsA3V7VGPeYcL2y3IxPTykx/JVofS6VUVO
	2pDpHYRR4g5G/Z4MLEJB1glZYWNf7BI+tdJlkFG5h4NVb4hhxUbO3Sf0XfkIvwjyShP4aq1h738
	7pIQ8LQkCM02L17/ws1wY3erOlfvgXo4twhCcz0hTKJXIuJEbXsxn0VB1n1fiapIxXjUYrSJAJr
	s6yvVjaIb0gp5MNAm++/We8Qqudz/JVLlBihsAIKrGI6kLsnofBjVWuA4I18oyCxWkJQc=
X-Received: by 2002:a17:902:f54e:b0:2b0:774b:d89e with SMTP id d9443c01a7336-2b2d5a6332bmr26780085ad.37.1775813375098;
        Fri, 10 Apr 2026 02:29:35 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f08b9esm23015335ad.41.2026.04.10.02.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 02:29:34 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 06/13] bpf: prepare bpf_liveness api for use by static analysis pass
Date: Fri, 10 Apr 2026 02:29:10 -0700
Message-ID: <20260410-patch-set-v3-6-1f5826dc0ef2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
References: <20260410-patch-set-v3-0-1f5826dc0ef2@gmail.com>
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
