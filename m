Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7A3E3C48
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909708; cv=none; b=bJxXYGUiEieGC4AZDOr+KAsAPZD3zZpQ4wpdia2Oze3NpMRGQbAD5G2XwlM1jhOO1laVDKuSnL0W8BRZXsCYtYtJm163ALgMyOoYz88V7aHYgaL46ooeH9Pa23lv+7b9qKHZeQ2JPt/i83UDcnokdMuLuYogM/CB1zCaCPB7k4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909708; c=relaxed/simple;
	bh=xh1wx5+rTghk89+5REAmmendmJsMjCLQugFPszw1EVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPlJDL2ViJxUM4z49QfjqwoqarUgW3L3nNwJGsumvNsYfSBxtSuKAPkW8XhTA46B5z+t/cDhquqduUFb57Ql6TnVwk1K9ixdY3+kGmFiXfi/YK092x9+DOi9iZG+fiojZTh+UhTq8vrkdSoP5fxy9Y6IPrknVs/iXUFQIpoVfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcgNSm7D; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcgNSm7D"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48541edecf9so61392325e9.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909696; x=1775514496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Be65GfC8oRrWim5X/Kbrbql6QDlOnt0rl58RCRPbRbg=;
        b=NcgNSm7DDDPirCWbg+W7AmENqJn9Qfvs4wXYz0XAid+hms8omunCumuhg2XlRLjpyD
         KW7UL4tN75GlSuzCpO5hW+h/zb2xNxmoU0O+a7nROG98vX29QmjI114SDUrykejUU++Z
         0yqZzIZCVqhlr9NLuf9YejW5flddeaGd6tMfEqIgIjqOPyrn4t3vxF0YIsbAH2Fv+XPU
         a8a/IwK/Nh4JfdmjnBWBaP3r1ngBzdB+ArFr1ttkI0128bBLeA0kEPaqLb/9jylYhBW6
         +w66QF77XAkCVkeR8tObH95jCtVgtmkUjAzbq12eyzycuG2ojn2aX8/815JuiW+Syzzz
         lnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909696; x=1775514496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Be65GfC8oRrWim5X/Kbrbql6QDlOnt0rl58RCRPbRbg=;
        b=U4GrA8kjUvdeWAoa6NFYLTwxUfJfsKHqRDCjBW7qt04ho6oKEfaOcE24jj7JZxJ8O2
         AL43av1XBVG1/G6P+e7Ur5VEET5AHdnGJ8xI7xtQjM5uRfv/4mW9tFRO2ZPvyOo2TMLg
         rOEo13aG0qOtXOGQhf+IqY50lk5DP7PkKpBqgLyqi5sTHPqahEKnxVcrhcfu6IPqDgT4
         IN0CVF6NGRiUKfLkdlAAb9eUsouMi97M01KW+5D5vy20K4B/XRJdGRL2pVLdtV+x7rEE
         CaTTsEWEvBdR9kcHahBWFX5nIqDpAS75I90LIhKPbl8rgKG18EKY6873AZjp9DK6v8fv
         eQEQ==
X-Gm-Message-State: AOJu0YwRNDWyDmrfzvuwMrUGp2/2xaYOGrQW1dI1nFSU3Ucl/vlr4MTO
	bcdhiPCfV8OTmIafUDSK75PVewNWo1BJqtIQOdOtiyObowKfLbzuEVo6
X-Gm-Gg: ATEYQzx6zTUY5KO+7pYFMkXVhUAXl3DWKUlw6AXjjJVADGi0mfCMsAJ2WII+jybANCU
	BVZ5RXEVvt3Ki4kyMbXOf3CzhRXIpxOjW2HY4s4ttBu1uxZvI/AGFwEY2Zz7X1lU3HcHNeQXFdR
	ecO//NQgW+XKfX2WoCQajP9jeUNYQvzFE8hVqHobN05NMyQL6+royrb8d7e1p7U3duGZ0SiMg/z
	O4Ctn19WbKnlTBmhMyn5cxCN/6mETbr2Byo32O3XaDl5XQVxv3F50nrDfPHgbp1+9+GNeAxOD3F
	9RzNMo00NVWlf7Tf1sxlmxW1pe+6QQBXYU0/cXJEeuNVl96bwUyKujNQZtHLWHFrz7Hn4OE1U8X
	ThvMUxYWGk5noeUc50HRcICo+uMPBgVw1FrxojDGqQGP0sW21EyAXVWHZ4SSA0di99DhcIGLt7g
	dFjTRyuno3Izyhkw==
X-Received: by 2002:a05:600c:c493:b0:487:338:b4f3 with SMTP id 5b1f17b1804b1-48727efad7cmr229249095e9.17.1774909696205;
        Mon, 30 Mar 2026 15:28:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:49::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8ee2d3sm270475e9.32.2026.03.30.15.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:28:15 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 30 Mar 2026 15:27:56 -0700
Subject: [PATCH bpf-next v2 1/2] bpf: Migrate bpf_task_work to
 kmalloc_nolock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-kmalloc_special-v2-1-c90403f92ff0@meta.com>
References: <20260330-kmalloc_special-v2-0-c90403f92ff0@meta.com>
In-Reply-To: <20260330-kmalloc_special-v2-0-c90403f92ff0@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774909692; l=5092;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=I+D4aIQ45ab8jscAx2zlzXB0p+OYwmcWFLsFu7qeR/E=;
 b=NJSSkVGNjV3v1L1M43vuB7kvSpk6prfPe1AVzkvnc/lapaj4OkMCTyyQWEj8zFey/xcBFtFjA
 zQjMhbcutdTBDSyaiXfMNfEAYHiP+ERyxf5Pu0TmWnVfVZYJ2G7ig6r
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

Sleepable BPF programs hold rcu_read_lock_trace but not
regular rcu_read_lock. Since kfree_rcu
waits for a regular RCU grace period, the ctx memory can be freed
while a sleepable program is still running. Add scoped_guard(rcu)
around the pointer read and refcount tryget in
bpf_task_work_acquire_ctx to close this race window.

Since kfree_rcu uses call_rcu internally which is not safe from
NMI context, defer destruction via irq_work when irqs are disabled.

For the lost-cmpxchg path the ctx was never published, so
kfree_nolock is safe.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 56 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cb6d242bd093..4c3011ef631f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4165,17 +4165,25 @@ static bool bpf_task_work_ctx_tryget(struct bpf_task_work_ctx *ctx)
 	return refcount_inc_not_zero(&ctx->refcnt);
 }
 
+static void bpf_task_work_destroy(struct irq_work *irq_work)
+{
+	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
+
+	bpf_task_work_ctx_reset(ctx);
+	kfree_rcu(ctx, rcu);
+}
+
 static void bpf_task_work_ctx_put(struct bpf_task_work_ctx *ctx)
 {
 	if (!refcount_dec_and_test(&ctx->refcnt))
 		return;
 
-	bpf_task_work_ctx_reset(ctx);
-
-	/* bpf_mem_free expects migration to be disabled */
-	migrate_disable();
-	bpf_mem_free(&bpf_global_ma, ctx);
-	migrate_enable();
+	if (irqs_disabled()) {
+		ctx->irq_work = IRQ_WORK_INIT(bpf_task_work_destroy);
+		irq_work_queue(&ctx->irq_work);
+	} else {
+		bpf_task_work_destroy(&ctx->irq_work);
+	}
 }
 
 static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
@@ -4229,7 +4237,7 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
 	enum bpf_task_work_state state;
 	int err;
 
-	guard(rcu_tasks_trace)();
+	guard(rcu)();
 
 	if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) != BPF_TW_PENDING) {
 		bpf_task_work_ctx_put(ctx);
@@ -4251,9 +4259,9 @@ static void bpf_task_work_irq(struct irq_work *irq_work)
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
@@ -4270,7 +4278,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 	if (ctx)
 		return ctx;
 
-	ctx = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_task_work_ctx));
+	ctx = bpf_map_kmalloc_nolock(map, sizeof(*ctx), 0, NUMA_NO_NODE);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
@@ -4284,7 +4292,7 @@ static struct bpf_task_work_ctx *bpf_task_work_fetch_ctx(struct bpf_task_work *t
 		 * tw->ctx is set by concurrent BPF program, release allocated
 		 * memory and try to reuse already set context.
 		 */
-		bpf_mem_free(&bpf_global_ma, ctx);
+		kfree_nolock(ctx);
 		return old_ctx;
 	}
 
@@ -4296,13 +4304,23 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 {
 	struct bpf_task_work_ctx *ctx;
 
-	ctx = bpf_task_work_fetch_ctx(tw, map);
-	if (IS_ERR(ctx))
-		return ctx;
-
-	/* try to get ref for task_work callback to hold */
-	if (!bpf_task_work_ctx_tryget(ctx))
-		return ERR_PTR(-EBUSY);
+	/*
+	 * Sleepable BPF programs hold rcu_read_lock_trace but not
+	 * regular rcu_read_lock. Since kfree_rcu waits for regular
+	 * RCU GP, the ctx can be freed while we're between reading
+	 * the pointer and incrementing the refcount. Take regular
+	 * rcu_read_lock to prevent kfree_rcu from freeing the ctx
+	 * before we can tryget it.
+	 */
+	scoped_guard(rcu) {
+		ctx = bpf_task_work_fetch_ctx(tw, map);
+		if (IS_ERR(ctx))
+			return ctx;
+
+		/* try to get ref for task_work callback to hold */
+		if (!bpf_task_work_ctx_tryget(ctx))
+			return ERR_PTR(-EBUSY);
+	}
 
 	if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) != BPF_TW_STANDBY) {
 		/* lost acquiring race or map_release_uref() stole it from us, put ref and bail */

-- 
2.52.0

