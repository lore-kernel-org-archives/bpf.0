Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813774A842F
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020891; cv=none; b=F2h79+6yVTr4Bd0UF42/fIUe4siGkw7U3XC1+7XkkqZtNsUm4YE1nXVD5onG6XQPM/xSUl2jXQCkPcZMvySegQt4x7ZuITsHTclmZJ/S/PQEDNmnBwikvZ6f2MJRElA7WZdL1/RmgtyyV2vOk4/9+u7XG4TfJ2TO7cQOCrrwOKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020891; c=relaxed/simple;
	bh=l0G1HovWxm8znUkNRE/EqLtNcv9yiKotcLpjMYiuwR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHkQGycBs0X9SRxT/pNFHR22/S7VM/gM1KfJD2f/SWm82+Whm/IUDE0WBESCLeHBg5P4W+iOK5XGn4xiqkT1VgDb5O+Q43JzTvrYhUTizuYLLQUcQXR9kqoL7D4KzAeBuwOo8bJPDRIhbSWe31iJnUdZCLIu4paPEFUGyq2RVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CK/0bz4H; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CK/0bz4H"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab41538192so3375958a91.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 16:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792020890; x=1792625690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KqdPohgFQIRr5Qqzau9QqaaVC7VWYFa2CaZ6/q4+Qy0=;
        b=CK/0bz4H5yy5hdAqX1HSu2pbNPcyE2yTg+ZXrnkFNtyP0gQ99VDzPpSIghHPlLCuWx
         7q8uAKphOjA+G2n0ko3FS6gh5CckpiBxxD5iDmPb3HTW+1rjJnHvWQpbPWep86NRYrmV
         t6jxAk/qbYoQEcbe/rxkquPPYfVQL3kja/W0Y6ni7Z3Kl4ME8IdKjBltviRMOBRw7/S2
         SGQOjMgRT6zLV9kQDTEZAtPvYpmDU7L0P7GRhtY0so9a31UzI5Z2RSk1YvncLkRyTFIE
         GSGLtWUnk9aVdIFE6bjXHRyUKZLtz46grf8iZCtpy24xbMOpY33mgftVbrobz+GVqF4y
         ir3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020890; x=1792625690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KqdPohgFQIRr5Qqzau9QqaaVC7VWYFa2CaZ6/q4+Qy0=;
        b=t5OcDczLLqerBWzTKI+xjXG/NxTova8AWXDI5V/j3R552OEunpbmePW8lRbUn5aMFy
         LYFJ8Vvi5c8ziuX1RKoFbCuLbyfvI9fbFGolTHIfz+QdVo0tZTM+qmsZoAwm2DhwKIkx
         +e4r7My0wiUyEmJ2tKKHL0+p/jTCUvZxEf9JDw6VyJjLVQDAHsLOF6dXiq7g1xBape8n
         H6RRErtLyXJkDGjaHRcGg1LF8qCrZTkUdfSkhGZrqH2e+ntC8+OcR4W3/xIE0/ztlw7N
         owlwg1sQaslP+ErhZS54Z7mjs2IRft6sTrUOTuobTiTEpqXpqJKtRu9nSn9lyWgfbMgd
         z7Dw==
X-Gm-Message-State: AFq9FYK4DeQ1sTpsoiAoEDQ60Z+j9+FvMOInHl7i78bfh/KS7ZpMvUk0
	TwT7TfmaFUhulgnoByh2Cvpk356K7Wek14aDVpOUfrX0vlKqQaNBBctWvrfAgfy2RV3SR9S4Ozi
	7oKjfD/8=
X-Gm-Gg: AYBFou1donT40hbmwJJV12qXigDOpzX/AtR1i2QlgsBJj3QAkiD99LWn82wd2+WDtPF
	dgZtSdCd6pSx+7BbdPBZq6+Fti8s4T+0cpRXDPiIUV/yJyrpq339EpGdjtVfop/Qjw75LhJ7+6L
	6LMssWetchBSO9h3/DCqPU+2eHmMi/JS8Ye/29QUGx/i7qXp0EQaRzUqMbzYrDshVuCk7TqAYHs
	Ye6FcT7ADFItAErrn14chh8Dy/kqflVe7idtjzkV5mtmI0tFffbHtipFMwB7k3Od36BchubSJsY
	DqboRzXXwILE9w041zeuft/3aTV/9IYP0PD5sVL87kgMdm4170mAKcLEz/ESp+aJH14Ak/h4alE
	CPQbOQ9bKnOp4cawWIS1e81akLgJ0cH6wptcbXzgU+fPAFNlSv5k4gCos/bQB5BPfpFaQ+nC4Nm
	gHQn/8jfo6hf0FztAhBFdsNIf142nW8Zrf2xLeGEKE0uh7y0B8EdUZ44lHRHrT0g9Jg2LvYIlsu
	/ZhoKgEVLN+bGwsNIqXY+GHOsf9rARDQfUa
X-Received: by 2002:a17:90a:d2c6:b0:3ac:9d26:551d with SMTP id 98e67ed59e1d1-3ac9d2657dfmr250964a91.50.1792020889446;
        Wed, 14 Oct 2026 16:34:49 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7a98sm1385177a91.6.2026.10.14.16.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 16:34:48 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 3/8] bpf: arena: Stop deferred frees before map teardown
Date: Wed, 14 Oct 2026 23:34:37 +0000
Message-ID: <20261014233442.8392-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014233442.8392-1-emil@etsalapatis.com>
References: <20261014233442.8392-1-emil@etsalapatis.com>
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

Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 650baa09fcb5..64a9001ecd68 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -409,6 +409,8 @@ static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
 static void arena_map_free(struct bpf_map *map)
 {
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+	struct llist_node *pos, *next;
+	struct arena_free_span *s;
 
 	/*
 	 * Check that user vma-s are not around when bpf map is freed.
@@ -419,9 +421,18 @@ static void arena_map_free(struct bpf_map *map)
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

