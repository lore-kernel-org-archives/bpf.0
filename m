Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68182175A69
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783517; cv=none; b=UvfG7MwHERb9McZ/y0YIBsDofhzSg0X85Yrys12VFH7pIKfylUBSrVE0cZYXGCa0UbSUG7zy2b5tcOaBDrc6D8kGbcVFdI+3yX9wqqUckhLcH3CGjgFIU4j0FgDXJIEvid51wm1ViSY6gQNLPuP0lyQv6fFHZcX4LuRuGqD46cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783517; c=relaxed/simple;
	bh=F4GGnIb5seyP18fr5ZRbhJxw2S6r1CKnvwkaXvMuL6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIgTuhq48msgFozhWzo/5hn+An1P/Dics101JB1a50el4CqlN10XkDZrfVAwI9sb+3EfFk1Mc2o1Ycr1zxK1/u1HtQuS/V4Jnsly5S6RbdtCDQnhnAKvRi0wKwwZ5Kii7beHmbSnTVYR8mBE9td+rG8hhuLh24PTZFEMmcyAS58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU6cFFkd; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU6cFFkd"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2d52c7f92b1so862394eec.0
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775783515; x=1776388315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7S+A/Oc3aysTE6kCidfW0ySqc2Qh8vIyIh3LVCzQ34=;
        b=EU6cFFkdKaoMLnkJEeXEUcKeVD47bDKD9FGRaFlBUKoDJGRcZqTrjGTcat34mxY9ZX
         /L4g9G8I4ALScaFsbwjAmyJWpfIe7nTpmXdtXpAuRyIdo/JEMcVqhmSBfHlV7dwMsOIV
         skHv8dw71FCO+rzS6wIid3VzjZAY259Pf6P0LWJACYhrtsMpTax4s6CIDemuikcBkSKc
         BEKUnFrMcE4Ii7sHJVPMfWM2h4tKQhAXRPh/iWJtiOBvR14nudIirUWy6Ha+5x2yXnTm
         C2WpTBdzcQxTRO4s3tsdfsf3PytuewBoDzmB/8g2A6kFTTSn/z+dIquUAg/uP7v29OUe
         eFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783515; x=1776388315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C7S+A/Oc3aysTE6kCidfW0ySqc2Qh8vIyIh3LVCzQ34=;
        b=XqrfuiYwp6w6/+2NxD0VUos9j42g41Llw1kRY8gzgiMiKhUiBunbt5Hm0rKN+GrmP4
         K8+P7KTcEJ5TtrWcYRLq8BP3G6uvFv4p4/bCoyYyK1G3nbLS1fO1HCJa4yBMUW85qxKI
         0WGvcL5Ibcnv5mXneTDOZI3SMN1RZLF4kr+6SV7KhJgliHR2Mm1oGgxTXOC01ykzr1Op
         mE6TdrdLvG0SoI4BvT8Ruds1ZuBW4pSPs8jzJSNyfnDqC8smEzLz1CwFxC/crVb9aEqo
         k3sgkYdqxQiviUUHr5hgB406XmH9lL7/0PsE6jPGMmPwVGaUkbDxzU3Pdqe3vXGbLAZh
         hfnA==
X-Gm-Message-State: AOJu0YzmiKrPJIo7lMmtWAQLeXa8tg6/LsJNRc0RdGqPOoO5x4C9Bv86
	5qRiDspXlxnckshkZicechfGHQKMmdw0DswQPPkwP4JkuTsCpbXyf00PSpkGxlgd
X-Gm-Gg: AeBDievPuB1cZP4V0ddSyY7v68WJEwuU+z2jlbaXE2VphVksZp+Db5bx7WIsH1V7uMD
	55ZghGRrw8RjvfFwlGb16yjGnr+wAmuxxR/bkEZ+NnbiMlVtfBWfhHLle4KFizsYIN0DMs5VtLT
	+a0Eh7yqdB4srLxiQKRUpe1Orj5iHhHgOZ+K67krdJwRvMh4Hpweh4Pmy/8CGTgwZ+qcOTvVaNt
	gLTnfML0IoEm4rrbCvlqgZgl33wNiJml9MqBlNXZ9vbNThJMrqO41lQXCv73Iu+UQAxwJhNqsec
	GNt2+t8iCB9yOZZo3qDdceTfE/FR+CK1KLdEDIR7ittjGe1zrb67Q1JT5KpJtUwlvg0VWNUmVjv
	J8hRsqM/uHheKaQlNUIxcfpRIfZmDLNxUvQBGQvk/V5uq/NwefuopZ5F32TpXsyZ/A8ogfdPBaY
	ahrAcxJ97kHLw8hyKKr6xh/0uYwJVsh8BTtBB7abqBFlT9xAX2A03W75DLMN3uzWuwZvk8SGatF
	8pTNGw=
X-Received: by 2002:a05:7301:6788:b0:2c1:67e1:61c7 with SMTP id 5a478bee46e88-2d587b83f71mr638911eec.11.1775783515172;
        Thu, 09 Apr 2026 18:11:55 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm2174922eec.23.2026.04.09.18.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:11:54 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 06/13] bpf: prepare bpf_liveness api for use by static analysis pass
Date: Thu,  9 Apr 2026 18:11:25 -0700
Message-ID: <20260409-patch-set-v2-6-651804512349@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409-patch-set-v2-0-651804512349@gmail.com>
References: <20260409-patch-set-v2-0-651804512349@gmail.com>
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
