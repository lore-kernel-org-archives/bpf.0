Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB03C1D79
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179431; cv=none; b=gMMHvHLfthAGYkXESLAvzDwYr0sp8MUvEb9Q8FPlJX5qlRsYjVMvUM2vs0eMJ1wT1Z7lZdXEOlYfxBVXMm3EHa9RGVoaSxgmCKihLb0MGICR8G/pMFlqqmduzDSx4vT9uVP/JCJ2s9KUlmyVEps2PJ/ZD5v5foP4FOjj+w/56TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179431; c=relaxed/simple;
	bh=OjgOjwaXkZRV+4g1OmvqzzIw2TLh1imRdGboZmq39WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jT15r+bm/KKNF8ao46KwviGcqPkmiOn8eUL5h1Xt6aK+OixhiObGtJwYoCLUQavGVLba8Wxl6CkGFautldqluUYvD4xRjC4Yzu3wq6i9Vl5k+u7It3xtyAQOo1sM7EZgfe4+XBPJtMxMON6JGx4+QTd+lvki5KI5w6Gy4vcuX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=tbbOx+cK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="tbbOx+cK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso1120045ad.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792179429; x=1792784229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9xJ3qPHsrf+5XbHcqcySZmUP3utogNq658CfKX7PzWQ=;
        b=tbbOx+cKpLIdvofUNs0J+7hXofJO8q4rpMdomyznCt2d1ms8zbi3ZRCTu5ijC4pf3j
         XUvBPiqHwHYm1QfdpV84ZAALXrDPBPDkliTRBX4R8i5AY9QcTxnUBsLgjWfuVrHAsucy
         BrXxLeOd+7Jat9Zw+K6Wrh/IuPmQL0F734Krc+s8IgE9KP5raXjzpWKk1bEiqr0N1PR0
         ru2KLoiQxLR9it3oeeGAGUdJB73kEQmpDa7slmJDNh9s7jTxMx72/mpGyONu19IsvGBg
         wQ6UA9bjNklSbytv5qJ4LDRM2giwmh839P3Ky/gm4dWb/TfhzpHjOv7QqDMqCNrKRKgg
         WRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179429; x=1792784229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9xJ3qPHsrf+5XbHcqcySZmUP3utogNq658CfKX7PzWQ=;
        b=cjk2OMsRQGDudRcX1ta0IlOBHluE7BhHYXvW9UL+0SV7O9DG5oHT1yGqTKFzThlsVm
         0lQzO2xisicvVbFLwfNcw8hgh3DHiqK5J6CuA+7VSJsc0qc0zTFqYbtaDJ+4aen1suLO
         vfwsuPs6YXZWweyemK16Zki3M2hTrm2/5Apszf2XT1grnNRLzalH5YaJFYrf9SJzFfIV
         4qapAS4yoZNs3LGHILPlH4AT121Oyrft95Xs1SmkRFufuRL9noK7mg2GtLQO7spXmoRz
         rgC5D4OY9vRq4BZY0yHQjgLzU81XkwiyEEmkwYuQJ7vjEh7v4ENZwJRecqM+ETLxubc4
         dqHw==
X-Gm-Message-State: AFq9FYIOiI5GSv+NpoFMHRjdpdd6g09l9n+JwIxBPvN7nzevmTpspWUO
	cQDkXF3XX2KGEI04M+4AlXCYJ2cBpJC6N+vOr3bDZ3FxgsMNbzNb/RMRnzuTYzVKmkdPX4PCCRE
	qd1IsPGtiDw==
X-Gm-Gg: AYBFou1Q1rpuUC9QUKx2xrR2T6MkFXf/vQAJ0s7zF5UWznNPNrD6bdrZJhvI2biVzvR
	OJab2lIUebPlPxz855dKc3n58lZbH9qpTK0ebGwKRXPPczd1Zpf+tsGERf6SAi3u85/xsZqbS1n
	0TxhWgSn06E7F9zYdMdPjc3w5vxutYYevwbETAvAIufitJZXgj/ACvsS6Z1ZQFXBm8S+bv2mLWG
	WrR5PbDvStAc3iVyxKA0gNEIX6KtOzojV4XsFqShUXbIO9+BAL1j5mpdJoRMf5/XTMnoSq+nJO5
	tQlF+ekhNJOCIs0FEzTVaQHhD/a2UA9xxd9sm7MLeMf9l6XR+xSGJFfS5p79gn1f0Z5aWW2hrto
	N//r2odE2yuXJYMhz75tOPRN0l839Q3M0ca7u+NKB1zjzXBW/7EpJtWjfLhWj6pzfLP0cxDnOXN
	Uciv3gAF5e0/a3YGgmCZZArpBibkvDqRM/+m95URoliCcmpA7lFE0ZTzdRnwpEmmswAK4hgMdE1
	XzpqG/R/n0gvpnXw8JxdnTaGZYeWcepiIFv
X-Received: by 2002:a17:903:2443:b0:2e5:54b9:6b5c with SMTP id d9443c01a7336-2e9a6c15992mr8091615ad.20.1792179428842;
        Fri, 16 Oct 2026 12:37:08 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1f0asm14970045ad.68.2026.10.16.12.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:37:06 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 1/5] bpf: Stop deferred arena frees before map teardown
Date: Fri, 16 Oct 2026 19:36:59 +0000
Message-ID: <20261016193703.9203-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016193703.9203-1-emil@etsalapatis.com>
References: <20261016193703.9203-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arena_free_worker() requeues itself when acquiring the arena spinlock
fails. arena_map_free() uses flush_work(), which only waits for the
queueing instance being flushed. If the worker requeues itself during
the flush, a later invocation can access the arena after it is freed.

No external callers remain at map teardown. Synchronize the IRQ work
first, then disable and synchronously cancel the worker. This waits for
a running callback to finish and prevents it from queueing another
invocation.

Disabling the work cancels a pending invocation, so free any spans
still queued. Their pages remain mapped in the kernel arena and are
freed by the page-table walk that follows.

Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0ff707707da0..8857e7b47c6f 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -375,6 +375,8 @@ static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
 static void arena_map_free(struct bpf_map *map)
 {
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct llist_node *pos, *next;
+	struct arena_free_span *s;
 
 	/*
 	 * Check that user vma-s are not around when bpf map is freed.
@@ -385,9 +387,18 @@ static void arena_map_free(struct bpf_map *map)
 	if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
 		return;
 
-	/* Ensure no pending deferred frees */
+	/*
+	 * No callers remain. Drain the IRQ callback, then stop the worker,
+	 * including any attempts to requeue itself during teardown.
+	 */
 	irq_work_sync(&arena->free_irq);
-	flush_work(&arena->free_work);
+	disable_work_sync(&arena->free_work);
+
+	/* Remaining mapped pages are reclaimed by the page-table walk below. */
+	llist_for_each_safe(pos, next, llist_del_all(&arena->free_spans)) {
+		s = llist_entry(pos, struct arena_free_span, node);
+		kfree_nolock(s);
+	}
 
 	/*
 	 * free_vm_area() calls remove_vm_area() that calls free_unmap_vmap_area().
-- 
2.52.0

