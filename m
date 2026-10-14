Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9874A5C2C
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020889; cv=none; b=YeRmUK1F/Z3tTkM49nweJpGK6aXB+NB/GzoGKCJcuIH2nI8Mt5MxY2Y/GBRV4ad5okBhMY9RSq3ggGeGvftjq0u7kYyDzCRef8hSJ9Cpnftj7Xm8+8XJWo8UVrqbockN3rqGJiHjP51/KnMGa5KaXd8QP6K44LDV4D26ufqaFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020889; c=relaxed/simple;
	bh=d4VA0XdAPXv3vEM2cRJhRpGLF4bTO72NDAjp872150A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QH8KkGxtM47dU2vWTiGpCkx55cs7g/m+miW6nwpFFA83x1QYRoB9f3+ObIEXPcIiyAk8P7s0rGi0q/PjMghdbxAS0JG7tsqXYfgh++j638Mo4iLoC4kAWGwnmKra5vruJsKdYsGY7qIWxXJUCCskgP2hiyzIqakOjLWqfa0vjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=MVa/UTPl; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="MVa/UTPl"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso2567619a91.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 16:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792020888; x=1792625688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wimkQ/VAAEeU4Tsmn7oILTd5BeeQ+oDNrPERy58Pg8I=;
        b=MVa/UTPlbumTbE4CiPkyJ53m9K6MMiO62v8od7qT3I/YRZpSL19KsJ6DA1z8noVOR8
         we4oaLmMy9gF+nh5hMWUwm40KPISqohBq3EUnKvfMnM8YhSLQinjwq4jk1QH0XVTOJbi
         lCJIb8L8ARUIuQo6ivOalSM1YnANxMc1XHMYbzdw/WgF5VQXbeWrYEkwDcKmDDtJzKeZ
         mCFBSAaSyOgScb/KAt8IqmlKZe2iJIo5PajdEk9DFPp73kaLSvCxcC/tiWOzjS3Gbe3P
         WUcEBYQ7LUF1sPnFqF6exRbOMjFUl3XvW989sxA4n8/L3ublN6ARppATDLeHgrs/EDCM
         C9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020888; x=1792625688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wimkQ/VAAEeU4Tsmn7oILTd5BeeQ+oDNrPERy58Pg8I=;
        b=zyRrLQyvRZbvSeb23mnwEA6jIaNdwbdrYAtdr4LihUM4xnH90OKXHA06P7pHAn09CW
         Y2QA0XWaXEqvs1OqCPRcXnZC63eFaWjhk91Dz7j65IPTHTxyLJyqF3D+xwnMciTbzkRb
         LHtbreS1FnDaEstA/c/R8t26djeYVN18XFN/7LgbHdEV6sLyXydN2l4xJDyDHoi2Aw/w
         7NDJhr5NDP/uT0rSNBgkyobu25uPowAbzUcKyp2ToUpalmYKm1rnugOdzoJ4JlhxVCxv
         62gOe34zxYJyXtB05cDKnXU/hm72GVYfS3dAaFQPBMDOin4htIQ+GbXYMAM4zyoBULEg
         HI+w==
X-Gm-Message-State: AFq9FYIU03+F7SZNbd9yRg2Gyqjvj9rCJpugWH6WgXgi56I5F8vchZR9
	J08p1nUVcsDrBJd58pigCJd+Ny4vUCILWnLIPdSF7JLZ+ylLax4Al9HjG5vnLGgOaQ/6EkeXo9O
	dgfDa8BM=
X-Gm-Gg: AYBFou34nLKGxbZodmQCMRZ6tMJX9w5Q9o1f5ZVhgoDfSQ4IXt4qKaMIZ25NhKEB0BH
	gVMA39em0RBvrKyF8e8sXHT68jW29nK/FcEo4Uzx0A1M9+shuO67liLOVH3J/PTHDOpETOWjj2c
	/tC9piB6XZh/JYRyunSWJdOyHgl30RfRdD35jLKq58boc1L5mZ1AGEoEgP6C74ih+/KOFkzWAUD
	8QWw+KMUTS8tNeYMs4pICqjUQkNivPh5xKXx3kvv4Ma6IvdlI1ehW3k/lYfR8YRzawLJZ6VspZV
	2TMXTePF0uUE7BvvpfIb9BjKURSJ1RPeMmbPSLXfIBI6NeHnpiJGosdyDbhnqJdt82AeGKk8s/n
	laKo8+VilLOcXezp9yS2WUDK3+9K2PLzPXg+FDhymXOi8sKK80s78dFwYplKvKABOIbCMSttkHq
	60VUHb//Vxmsc+dcuREQIKtE0J4eOeDI9J+kyL6iTh9+cUj0IVUBNbxkHs3L/B9EG8mKGedPQmj
	TPAuuCqoqwAKxXhLT6aI2G2g8yPDhHrTrPR
X-Received: by 2002:a17:90a:2cc2:b0:3ab:752f:5f9c with SMTP id 98e67ed59e1d1-3ab752f626dmr6644841a91.31.1792020887927;
        Wed, 14 Oct 2026 16:34:47 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7a98sm1385177a91.6.2026.10.14.16.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 16:34:47 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 2/8] bpf: Associate arena pages with their mapping
Date: Wed, 14 Oct 2026 23:34:36 +0000
Message-ID: <20261014233442.8392-3-emil@etsalapatis.com>
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

Associate arena backing pages with the arena's private mapping and set
their page offsets. This allows the fault handler to delegate user PTE
installation to generic MM code, which is itself useful for avoiding
races with kfunc-related arena operations.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index b95ffdb14417..650baa09fcb5 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -202,6 +202,9 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 		return -EBUSY;
 	set_pte_at(&init_mm, addr, pte, pteval);
 #endif
+	page_folio(page)->index = compute_pgoff(d->arena,
+						addr - bpf_arena_get_kern_vm_start(d->arena));
+	page->mapping = d->arena->file->f_mapping;
 	WARN_ON_ONCE(llist_del_first(d->pages) != node);
 	d->i++;
 	WRITE_ONCE(d->arena->nr_pages, d->arena->nr_pages + 1);
@@ -272,6 +275,17 @@ static int populate_pgtable_except_pte(struct bpf_arena *arena)
 /* The backing file must not hold a map reference. */
 static const struct file_operations arena_backing_fops = {};
 
+/* Arena pages are not page-cache entries and must not be evicted by MM. */
+static bool arena_release_folio(struct folio *folio, gfp_t gfp)
+{
+	return false;
+}
+
+static const struct address_space_operations arena_aops = {
+	.dirty_folio = noop_dirty_folio,
+	.release_folio = arena_release_folio,
+};
+
 static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 {
 	struct vm_struct *kern_vm;
@@ -341,6 +355,8 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		err = PTR_ERR(arena->file);
 		goto err_destroy_rt;
 	}
+	arena->file->f_mapping->a_ops = &arena_aops;
+	mapping_set_release_always(arena->file->f_mapping);
 
 	return &arena->map;
 
@@ -355,6 +371,14 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
+static void arena_put_page(struct page *page)
+{
+	lock_page(page);
+	page->mapping = NULL;
+	unlock_page(page);
+	__free_page(page);
+}
+
 static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct bpf_arena *arena = data;
@@ -378,7 +402,7 @@ static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
 	 * the TLB entries can stick around and continue to permit access to
 	 * the freed page. So it all relies on 1.
 	 */
-	__free_page(page);
+	arena_put_page(page);
 	return 0;
 }
 
@@ -939,7 +963,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 			 * page_cnt is big it's faster to do the batched zap.
 			 */
 			zap_pages(arena, full_uaddr, 1);
-		__free_page(page);
+		arena_put_page(page);
 	}
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 
@@ -1061,7 +1085,7 @@ static void arena_free_worker(struct work_struct *work)
 	/* free all pages collected by apply_to_existing_page_range() in the first loop */
 	llist_for_each_safe(pos, t, __llist_del_all(&free_pages)) {
 		page = llist_entry(pos, struct page, pcp_llist);
-		__free_page(page);
+		arena_put_page(page);
 	}
 
 	bpf_map_memcg_exit(old_memcg, new_memcg);
-- 
2.52.0

