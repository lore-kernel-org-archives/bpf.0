Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420AB33067C
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473136; cv=none; b=TYsbce/tBWspLdsKAqytN1PlT6kBJopK9ESsQ8drW7g5dmS0APJgcMXFJ/TQVuSzIz5IxZM2hJRp8cJmv2Qg6nmgmSBrLqPq2rL6tv21HvN6x15cW/aEmhQ5ixs+gkzSDbgYIKHjCO63g/WmHgnwK4GBoShL4+PX2HhzrMzoVGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473136; c=relaxed/simple;
	bh=NseeNkJq4VP3JY2KYv9pxhwcjvCj4ZlCTiPdABpqdkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YxV3av0wTNDSitP45BhNI9kKun1JuHtMHvv51zsPhUSSwgbXP7k3NKLHQxVnTPUEQXlh/pbNGQjJVNIFn0XVwUmeLQRFZPobk90WD807v/NohTOS+XA7GNiD3bkZKEdtrufpUHN4tziMllk3wpfkqTuyRaFAUcDjnxhKJjP+ZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9t6kffM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9t6kffM"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso3161175e9.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774473134; x=1775077934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzMFv/J8zUW31g8Cu5IpT5cFsqs52DDeUj69v9HYPRc=;
        b=J9t6kffMfGSU269mXwKorUF6Mk0GIng8Q04gl81dRTmDm9YcnhSAoe+XKx0YuhIG+p
         6gR7/m0lmbxPVKLVK//8UZJqDoUNzVPqnhkjWZRbZbzBTmutiT1HED8lPlQHk/nCrp0F
         02GI8goPxz/5GX2UTTbM0VkjYNjtZmXz+ss2mLg61vfCtnC6UfLKNSnL+i/BV+E+DzTo
         x5ed0xfp35iopiz0+vpAPRwMPXo1PdRIpyT/G60hqpFmWX7sb5YQQkLwKyhJA2VXJXBG
         sDKbywl4rTYf84jZnSiPah32fthQPtCtJ4zbEiDRBwTYFl2xprjfL0OGJrTmRd3VWG9z
         CGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473134; x=1775077934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kzMFv/J8zUW31g8Cu5IpT5cFsqs52DDeUj69v9HYPRc=;
        b=XWqXmnGAq47V1WOp5i9SvEGtbcWFBUoBM9QO5Q1O4zIpDVBaTKLqNYsl5fF7fNqZhh
         sPsZnVv3GHqzT9UHeA42pkWKEekasfJaQ2FQxav50Js7svF6HbK9/ijux9G2rosaQGPv
         naCb5xxYRo27q/GUMsXms3Yrp4oyiBqAgE0TafPqV4mLKUKjTvUWyJAnaVq0nxWWGF8P
         /WE/ULSd4RjDK444nXNbHbn070zBoDi1RJ9ii2Omxq8ZgeCmlc5D6/SVn/TjR+CNOpJ+
         SdqOs+9ThFqrDSUveYNnv7WPplV8Y3KWlIZ+TzfOn5Vjw0INVTT89ypm9DpBQryMXc/G
         +ZEA==
X-Gm-Message-State: AOJu0YxejJGpX6VxgYTEygQakWA851R9RsZQx9Jl7KLnN092c19/dpw8
	+8HlLUMc7T1KX6rhASHfizfOjN8zaaQS9wocKJ19+ycJLfd+mjbPnvJM
X-Gm-Gg: ATEYQzzjfpXlK2MwA9hr7JN7HjWA2AHagO3mU+DJK4uUjpsn3rYbZ2lKM/SQAO+/YlW
	CwwDw9Yh+ctblMtnXxuU+NgBHmLoXWsS5TDh/9lCCCePpcFnbzoRzL6WoVfTa6Ef6o2JqOouulb
	SqaDROQrzDEpsLlHNGJ0vEDdKBvjK5KLzZv4ifBMCXStygmfjy587L/unDICCcBrvof5WPZzXTh
	/ajE8tWPP2XN8Izld98rDVzxHo34bO8tjp3F1NiZaB8z7q96+gB72JxMiCOnu+nnp/fvU/F3iL5
	j0QxikpZRZriiRVcEfRzDe5vh8+gayUNwabIuH5Uq6s+vFU675ZPjozv5E1BMgY5Cw9PA9tLtCr
	U24sc3r97cQljVrHYmFJE4jRcgqZGhP1UHWN0cfPPp/1SGV7BRHOQ46htSlWW/PiA1P8BxI1LUl
	WuhOD/F7V3PA==
X-Received: by 2002:a05:600c:4ed0:b0:487:288:1199 with SMTP id 5b1f17b1804b1-487160934dcmr75919895e9.28.1774473133456;
        Wed, 25 Mar 2026 14:12:13 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fbdd555sm3500975e9.2.2026.03.25.14.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:12:13 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 25 Mar 2026 14:11:54 -0700
Subject: [PATCH 1/2] bpf: Migrate bpf_task_work to kmalloc_nolock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-kmalloc_special-v1-1-269666afb1ea@meta.com>
References: <20260325-kmalloc_special-v1-0-269666afb1ea@meta.com>
In-Reply-To: <20260325-kmalloc_special-v1-0-269666afb1ea@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774473129; l=4270;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=rs3z5581qTWdiLfShda/3MLF90vVAE/t3MDfmerq2NU=;
 b=qjAMuF5EHnT0JWJlrzL1C6QHbijqhhjilVitSva2sYop5mHhrRLKTTgqQph5QPtOwWpM7Yy8U
 hk8yBqm4XIkCy69hpzd+eYoQSqsSECtxoAyRGZPzYbIq25gzM5/FBgP
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Replace bpf_mem_alloc/bpf_mem_free with
kmalloc_nolock/kfree_rcu for bpf_task_work_ctx.

Replace guard(rcu_tasks_trace)() with guard(rcu)() in
bpf_task_work_irq(). The function only accesses ctx struct members
(not map values), so tasks trace protection is not needed - regular
RCU is sufficient since ctx is freed via kfree_rcu. The guard in
bpf_task_work_callback() remains as tasks trace since it accesses map
values from process context.

Sleepable BPF programs (e.g. BPF_PROG_TYPE_SYSCALL) hold
rcu_read_lock_trace but not regular rcu_read_lock. Since kfree_rcu
waits for a regular RCU grace period, the ctx memory can be freed
while a sleepable program is still running. Add explicit
rcu_read_lock/unlock around the pointer read and refcount tryget in
bpf_task_work_acquire_ctx to close this race window.

For the lost-cmpxchg path the ctx was never published, so plain kfree
is safe.
---
 kernel/bpf/helpers.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cb6d242bd093..b197b6978f1a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4171,11 +4171,7 @@ static void bpf_task_work_ctx_put(struct bpf_task_work_ctx *ctx)
 		return;
 
 	bpf_task_work_ctx_reset(ctx);
-
-	/* bpf_mem_free expects migration to be disabled */
-	migrate_disable();
-	bpf_mem_free(&bpf_global_ma, ctx);
-	migrate_enable();
+	kfree_rcu(ctx, rcu);
 }
 
 static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
@@ -4229,7 +4225,7 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
 	enum bpf_task_work_state state;
 	int err;
 
-	guard(rcu_tasks_trace)();
+	guard(rcu)();
 
 	if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) != BPF_TW_PENDING) {
 		bpf_task_work_ctx_put(ctx);
@@ -4251,9 +4247,9 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
 	/*
 	 * It's technically possible for just scheduled task_work callback to
 	 * complete running by now, going SCHEDULING -> RUNNING and then
-	 * dropping its ctx refcount. Instead of capturing extra ref just to
-	 * protected below ctx->state access, we rely on RCU protection to
-	 * perform below SCHEDULING -> SCHEDULED attempt.
+	 * dropping its ctx refcount. Instead of capturing an extra ref just
+	 * to protect below ctx->state access, we rely on rcu_read_lock
+	 * above to prevent kfree_rcu from freeing ctx before we return.
 	 */
 	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
 	if (state == BPF_TW_FREED)
@@ -4270,7 +4266,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 	if (ctx)
 		return ctx;
 
-	ctx = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_task_work_ctx));
+	ctx = kmalloc_nolock(sizeof(*ctx), 0, NUMA_NO_NODE);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
@@ -4284,7 +4280,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 		 * tw->ctx is set by concurrent BPF program, release allocated
 		 * memory and try to reuse already set context.
 		 */
-		bpf_mem_free(&bpf_global_ma, ctx);
+		kfree(ctx);
 		return old_ctx;
 	}
 
@@ -4296,13 +4292,27 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 {
 	struct bpf_task_work_ctx *ctx;
 
+	/*
+	 * Sleepable BPF programs hold rcu_read_lock_trace but not
+	 * regular rcu_read_lock. Since kfree_rcu waits for regular
+	 * RCU GP, the ctx can be freed while we're between reading
+	 * the pointer and incrementing the refcount. Take regular
+	 * rcu_read_lock to prevent kfree_rcu from freeing the ctx
+	 * before we can tryget it.
+	 */
+	rcu_read_lock();
 	ctx = bpf_task_work_fetch_ctx(tw, map);
-	if (IS_ERR(ctx))
+	if (IS_ERR(ctx)) {
+		rcu_read_unlock();
 		return ctx;
+	}
 
 	/* try to get ref for task_work callback to hold */
-	if (!bpf_task_work_ctx_tryget(ctx))
+	if (!bpf_task_work_ctx_tryget(ctx)) {
+		rcu_read_unlock();
 		return ERR_PTR(-EBUSY);
+	}
+	rcu_read_unlock();
 
 	if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) != BPF_TW_STANDBY) {
 		/* lost acquiring race or map_release_uref() stole it from us, put ref and bail */

-- 
2.52.0

