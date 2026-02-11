Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2AC343D78
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827993; cv=none; b=IQ6/g2SzpvmNijL7CfNUF6djnGmBHyemqWd8tsE7D1vGtagaDrYOyp4YwoaxpCDBF6IaNk7A5a43nnMS9De9EUZdUzkr/IKm4gWI5CGTK8wCC9NbSgGapVS9DkH8WMsHXpdl3IACou8tdcsztiCDXQk7j/Oc5KZgmEJTveIqA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827993; c=relaxed/simple;
	bh=1po+t7eDMnwboo7iG69sklJ9f/25hhWS4V9kjasX0XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkSRsgV67D59nPFUkXeJlLZY7wxr5QlVDG6pI56vqQek2jRK0Jos2RymSrRE6zrdVpnaSMCqHWTVi66M4q0Rl6gcSaWQ+pGUXfC3gT0Fb6pJ28MRALjnesg4m6nDT/Fcr7o5hGwyYW6cPrcE78Q6efhHiO4Zs8dvN5tk2lXgA9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6MxYWJs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6MxYWJs"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so11782485e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 08:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770827991; x=1771432791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytxqL40rXDvA7naCOLUeD39DYv9Jy1gx0/VDQsmkFK8=;
        b=O6MxYWJs9ze2tsWN91wz/OVelFLiKMKUMbi1KrUAunhlCdxPP+GtIqByd9o0aEslVc
         wSGVtNcHbI1PQM34Z2EPaskmnmIaEfMPuLQCrJOSm0fzEJsDDTvv8D/qaKKaV2pjsm3e
         pSF4ZzOWS51a9riQDukyVHebtcOEHZUJvwpmtSBj5KtIIdXmvgjtjc56jas7SvG14OUW
         qnh1PuOXfjW4UWKXd6/NK8Y0eHfpXVPBk2bZIbnKJXCFeZzosPCV7kqc+jt3LJKnAqsZ
         GO4tWR5F7qHYJCNL7+U5IvF7l1Hfy6ROdhyLp9zFhZE8jomXtCATcI+/jMT6SBx79fmR
         DzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770827991; x=1771432791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ytxqL40rXDvA7naCOLUeD39DYv9Jy1gx0/VDQsmkFK8=;
        b=qdhlmS7q/c9wq7tmHTG4g3Q3al0XlN51QZLZi8Ayl+VtaW0ClA7N0mv6J8givkOd80
         8vrlqDzCIp+mWimeK+WnlH1CC640OAK7anTZ/XXSXRHpVMlEu90ebmzGTp9Enk0A+Svk
         agk8Pup1phwQoeM8w7NtTB+DFmeYx5rAtLU+blfknRDmokx/bH74Cv2lygGjZk6uDnwF
         jRTD8GclY56itxASvvEfCRgutVYck7TZWfWW+JHe45EidcS7aqtPaM/DrTfcblKE2fNq
         cKotACWwoAqt75uS+4t6tQNx0b/W20Tm6IedXOd8ddK7tRN8FWr5naGdUWGs5OXVJC7q
         NO8A==
X-Gm-Message-State: AOJu0YzNeiRSCs+j249ztweLoxTFDPOYIkd+rZKDrFrc1KclCyIkqrLx
	yiX4SgwvDkaHCJBUal2Bftcm5uPTMrwlz6oT9bVdcsM9wJbOMl/G53LA9i8RmQ==
X-Gm-Gg: AZuq6aJHeYkn1TKNvdewZZi8WjjJAS4jp3xYVVsU/AHbUbRQ15wjm7GUPkhI+46dFtT
	rvXiErCby/WqAPCDY6bH4OXixzalYVzbr8UEcouZLPJBeT1qpEZw1EcOfxw3ymqsTBJBzq5G3T4
	fY2ljXEHnYor5J97WdssFfZjdsulpnTvGtKtrBu/TmeZ2jaBGfbK1DyRpTRY+LOR2mW5QS+aZYT
	BmvNKPACYK/DQUWks7APpkkAAChvCYvehzqMKTLZKEhYF3fzzLKnBuicKvkcPmv8NNCXkyf6T18
	Sum+cABdDnZYZRrEWALvuAGH1xhSaqIhB+NQvcYgavHWzsXa4BhBcvLCe+yDfE3LgEA1s4m45VX
	fFLyXl/1ZxvoY8Tgo52MX08VfCHtvw9F5GfM/sDHZtVyXihxxFWp06ocx35rRbO388on2XUdnpP
	xXiUzLxDM=
X-Received: by 2002:a05:600c:524e:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-48365057efamr81645e9.16.1770827990603;
        Wed, 11 Feb 2026 08:39:50 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:b8a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835a62baa9sm23580975e9.4.2026.02.11.08.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 08:39:50 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v1 1/2] bpf: Fix use-after-free in bpf_task_work_ctx freeing
Date: Wed, 11 Feb 2026 16:39:26 +0000
Message-ID: <20260211163927.665785-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211163927.665785-1-mykyta.yatsenko5@gmail.com>
References: <20260211163927.665785-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Current code frees the context immediately when the refcount drops to
zero, without waiting for any RCU grace period. This is unsafe: a
concurrent BPF program calling bpf_task_work_schedule() may still
hold the ctx without a reference for a very short period of
time in bpf_task_work_acquire_ctx().

Fix this by deferring the free through two RCU grace periods:
    call_rcu_tasks_trace -> call_rcu -> free
This is similar to bpf_async_cb freeing.

Since bpf_task_work_ctx_put() can be called from IRQ-disabled context
(e.g. NMI from tracing BPF programs), and call_rcu_tasks_trace is not
safe there, use irq_work to defer the initial call_rcu_tasks_trace to
a safe context.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7ac32798eb04..414e5b55cd37 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4160,6 +4160,31 @@ static void bpf_task_work_ctx_reset(struct bpf_task_work_ctx *ctx)
 	}
 }
 
+static void bpf_task_work_ctx_free_rcu(struct rcu_head *rcu)
+{
+	struct bpf_task_work_ctx *ctx = container_of(rcu, struct bpf_task_work_ctx, rcu);
+
+	bpf_task_work_ctx_reset(ctx);
+	/* bpf_mem_free expects migration to be disabled */
+	migrate_disable();
+	bpf_mem_free(&bpf_global_ma, ctx);
+	migrate_enable();
+}
+
+static void bpf_task_work_ctx_free_rcu_tasks_trace(struct rcu_head *rcu)
+{
+	struct bpf_task_work_ctx *ctx = container_of(rcu, struct bpf_task_work_ctx, rcu);
+
+	call_rcu(&ctx->rcu, bpf_task_work_ctx_free_rcu);
+}
+
+static void bpf_task_work_ctx_delete(struct irq_work *irq_work)
+{
+	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
+
+	call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_ctx_free_rcu_tasks_trace);
+}
+
 static bool bpf_task_work_ctx_tryget(struct bpf_task_work_ctx *ctx)
 {
 	return refcount_inc_not_zero(&ctx->refcnt);
@@ -4170,12 +4195,12 @@ static void bpf_task_work_ctx_put(struct bpf_task_work_ctx *ctx)
 	if (!refcount_dec_and_test(&ctx->refcnt))
 		return;
 
-	bpf_task_work_ctx_reset(ctx);
-
-	/* bpf_mem_free expects migration to be disabled */
-	migrate_disable();
-	bpf_mem_free(&bpf_global_ma, ctx);
-	migrate_enable();
+	if (irqs_disabled()) {
+		init_irq_work(&ctx->irq_work, bpf_task_work_ctx_delete);
+		irq_work_queue(&ctx->irq_work);
+	} else {
+		bpf_task_work_ctx_delete(&ctx->irq_work);
+	}
 }
 
 static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
-- 
2.47.3

