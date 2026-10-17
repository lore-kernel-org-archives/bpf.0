Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16039B4A5
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278613; cv=none; b=On2BAhhx1vf9T36mMS9W3clHRGyi5zdwIUvsoBQ7MQx8HGZCFJpZUDWWUpHKwAj0nk1OPNLxeQcZa/PzZoEW3ewmw6ZkFU02qERXut9EqGTOTjiBYWZN6fphT6bt1Pdx9exAtauPj9dXdUcD6XhumbbwLTiFQfkFU9Cz4gHmvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278613; c=relaxed/simple;
	bh=MqH/aLA9uf0MMTPSmglwEbQ6/sKhCFOsaRTd4NdmppM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/Yr2El2wmU7Q7R1xCxyOBwxpC6PXwdzk1oi2HSoJcWK3ZtURxq0l4dCaWPghXl9NuaJwwLSmdGGmHYbetCSk8Za2C6DwFZC/YN4RUadF52PO/76cOfohQR1nAO1fAKkdvgB6WgGSRUHat3jPiWhDg06T+kkMVl649+vo4kxdD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvXX/2IT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvXX/2IT"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so918372a91.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278611; x=1792883411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9d+/3whG8o8YhiyXw+wnus5vIWRzb6dBmVCgcM6IHiM=;
        b=XvXX/2ITyoPB47SWoYwvCD6ItzMcfz/8Qw52pXklSmR00eCtc0tzWThKcdq7pTVvTp
         /sJrsw+t2Qgx6VL07mR+cJo+v2l0CwaZEqGl3+HRrEC8p9JI0W2C0NH9F9tlHtAhvBxv
         sUVvJJTl1fSvmGmn16++0z/v+UFoWeYo1a6vjd0QRmk5h+4OUpfwCfHw8XB1AX6C8lmQ
         vkNCug3IYwxJfJhVzcuW6x7+OhV/JNufUwXIeT+nZvVoxGgsUgUjVQvPQ3HzEaDD/ID5
         OIlN10C8yfF/kRCVcStJpkpnEfIbvgibKlyHWzUT7BMqe7FHcms2PLHDSovOD6Plmypf
         Hqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278611; x=1792883411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9d+/3whG8o8YhiyXw+wnus5vIWRzb6dBmVCgcM6IHiM=;
        b=VNBHswnNuYoldKVwJtMZSdzHgKqLosc6gRNGGs2UYp/yJHjZVjvLkBcmTe44qhsDZU
         AE/Fo+apGM79vUtnhXuzPVr1EOQ0eLqSYJO9fkefXoxq+HyuyKjmb0hoBUBFHXvShvYW
         4wZppOzwR+9rABXukc+8vi0aMM83mz8rYaSuKBG1dM9VaGkSfYzJbFbXLYnSQR6nqP+6
         jWruxuO0ey5t3tJIN3Y0ZP8O22jhp9KFJjje7jQcsOALlSsaFE9ot2XshbBfV1k1qmlC
         nGvByzDSfximmEC3IFC5v4Y6XPPJj6cAVkfQiFNo3+9oMA8wlk7ZVH3VXP08eU6nVMLx
         EYOQ==
X-Gm-Message-State: AFq9FYKnjJYeUCYvRMonmNH88I+mnEjN0+YIgC1MRnMMbhvgbrH3E0xb
	64cOGU5OXbnjtDXqhMZUQqw0wiI50pPUIDYIh8ikiVt2XHg1aVNzI7S24jaAKA==
X-Gm-Gg: AYBFou2Y2e+fUeWvOU8Cl5lDQ7g5hYjvdag7Ip0VAnYVR4ZIKU0OtiefVxDyt/SE0PJ
	KQnlbHje/Ra1YbWWjpptyCNOelne+WIU8E0VxL0QU9gWPwaxvXO3/6Io2KsSyQrhGRNAhSDKPWL
	VJHZQz/E3/YIwW51j0CT6eHvFZ4oIKkwi95kgbX4QAaG76r9OEpvLDPqakAYhW+etK4NswdugSZ
	uEzM/sWjzqigihqJ5X2NOfvHIzZNAyI8Cyhhym6tE4z+an8Fuf1tBWxMbewY1m6jklOc3UjdwDI
	aH3Us4Lvkq321u/AJiCnjpLbNezNXKpuOCEnwgCBrsLJEPeKRA4+Twjd10MN8mmOWpuWvkRNRN/
	gdk1BkkbDIXRUVF1KAtYTQVinR2SylB/aZb8Dxl0FxlYdx0Snu/lumBaC/VpmtRCxvgMP20YxBB
	chYiqb9zqnibX7hc/6KJgEdPyBO/J2gOv+kiVrwI/vuqaXxdyqbo1EPZT8vpyO2BuD6zkPxZTKi
	G+IAueN/e2Y1BlAPvMk0xRH6+VnqGkdxlYm94Cg6dSu1KMKqNRgxEqNwCv2mtKDjYFoXp0hgt6E
	x2iG+5h5c8LWn/cFuVM5RBD0ekdiwi+lnR5K/M6n+Ms=
X-Received: by 2002:a17:90a:d44d:b0:3ac:b3c7:de0a with SMTP id 98e67ed59e1d1-3acef14bed8mr3292079a91.40.1792278611409;
        Sat, 17 Oct 2026 16:10:11 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc980a548sm4817359a91.0.2026.10.17.16.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:10:11 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 03/16] bpf: Keep values of a dead owner for sleepable programs
Date: Sat, 17 Oct 2026 23:09:37 +0000
Message-ID: <20261017230950.802052-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_local_storage_destroy() frees the elements of an owner behind a plain
RCU grace period, on the ground that no program can refer to an owner that
goes away.  But the pointer that bpf_task_storage_get() and its like
return stays valid for the verifier after the program has released the
owner, or has left the bpf_rcu_read_lock() section it had the owner from.
A sleepable program is in no RCU read side critical section, so it can
write to the value after the owner has died and the element was freed:

  BUG: KASAN: slab-use-after-free in _copy_from_user+0x42/0xa0
  Write of size 8 at addr ffff8880074404a8 by task lsuaf/55

Free the element behind an RCU Tasks Trace grace period if sleepable code
may use the map.  A program that a map is bound to was loaded, and counted
in map->sleepable_refcnt, before it got a value from the live owner, and
stays counted until a grace period behind its last run.

A program can also get at a storage map by a lookup in an outer map.  Then
only the outer map is counted, its programs can come after the inner map
was put into it, and can hold on to the inner map after it was taken out.
So note in a map that it has been an inner map, and treat it like one with
sleepable users from then on.

The same goes for what the special fields of the value hold.  The page of
a uptr has to stay pinned, and a kptr which the program stores after the
owner has died has to be released.  Leave the fields, and the smap that it
takes to free them, to bpf_selem_free_trace_rcu(), as bpf_selem_unlink()
does.  bpf_local_storage_map_free() waits for that callback, and leaves
smap alone if it comes across such an element.

Elements of such maps now wait for sleepable programs that are running
when their owner dies.  Other maps are freed as before.

Fixes: dcf456c9a095 ("bpf: Fix usage of trace RCU in local storage.")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h            |  1 +
 kernel/bpf/bpf_local_storage.c | 31 +++++++++++++++++++++++++------
 kernel/bpf/map_in_map.c        |  7 +++++--
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 22947fa192e4..a10af47978a4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -341,6 +341,7 @@ struct bpf_map {
 	bool frozen; /* write-once; write-protected by freeze_mutex */
 	bool free_after_mult_rcu_gp;
 	bool free_after_rcu_gp;
+	bool was_inner_map;
 	atomic64_t sleepable_refcnt;
 	s64 __percpu *elem_count;
 	u64 cookie; /* write-once */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 49ea00c99390..b12fcec47ffa 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -352,7 +352,8 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 				    struct bpf_local_storage_map_bucket *b)
 {
-	bool in_map_free = !!b, free_storage = false;
+	bool in_map_free = !!b, free_storage = false, sleepable_users = false;
+	bool keep_fields = false;
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	unsigned long flags;
@@ -362,17 +363,26 @@ static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 
 	if (smap) {
+		/* A map that is freed, or NULL here, has no program left. */
+		sleepable_users = !in_map_free &&
+				  (atomic64_read(&smap->map.sleepable_refcnt) ||
+				   READ_ONCE(smap->map.was_inner_map));
 		b = b ? : select_bucket(smap, local_storage);
 		err = raw_res_spin_lock_irqsave(&b->lock, flags);
 		if (!err) {
 			/*
 			 * Call bpf_obj_free_fields() under b->lock to make sure it is done
 			 * exactly once for an selem. Safe to free special fields immediately
-			 * as no BPF program should be referencing the selem.
+			 * as no BPF program should be referencing the selem, unless it
+			 * is sleepable: see below.
 			 */
 			if (likely(selem_linked_to_map(selem))) {
 				hlist_del_init_rcu(&selem->map_node);
-				bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+				if (sleepable_users)
+					keep_fields = true;
+				else
+					bpf_obj_free_fields(smap->map.record,
+							    SDATA(selem)->data);
 				unlink++;
 			}
 			raw_res_spin_unlock_irqrestore(&b->lock, flags);
@@ -387,7 +397,15 @@ static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 		 * with selem1 as raw_res_spin_lock_irqsave() returns -ETIMEDOUT.
 		 */
 		WARN_ON_ONCE(err && in_map_free);
-		if (!err || in_map_free)
+		/*
+		 * A sleepable program can still use, and fill, the fields of a value
+		 * that it got before it let go of the owner. As for bpf_selem_unlink(),
+		 * bpf_selem_free_trace_rcu() frees them, and takes smap for that:
+		 * map_free() waits for this RCU read side critical section and then
+		 * for the callback. It must not take smap away from an selem that
+		 * destroy() has unlinked from the map.
+		 */
+		if (in_map_free ? err || unlink : !err && !keep_fields)
 			RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
 	}
 
@@ -434,11 +452,12 @@ static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 	 *
 	 * The owner that map_free() takes an selem from is alive: sleepable code, which
 	 * is in no RCU read side critical section, may be walking its list for another
-	 * map.
+	 * map.  And it can still use a value that it got before it let go of an owner
+	 * that destroy() is called for.
 	 */
 	if (unlink == 2 ||
 	    atomic_cmpxchg(&selem->state, SELEM_UNLINKED, SELEM_TOFREE) == SELEM_UNLINKED)
-		bpf_selem_free(selem, !in_map_free);
+		bpf_selem_free(selem, !in_map_free && !sleepable_users);
 
 	if (free_storage)
 		bpf_local_storage_free(local_storage, !in_map_free);
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 5ee8aae7435b..0fa3f2ac0f99 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -110,10 +110,13 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 		return ERR_PTR(-ENOTSUPP);
 
 	inner_map_meta = map->inner_map_meta;
-	if (inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map))
+	if (inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map)) {
 		bpf_map_inc(inner_map);
-	else
+		/* Its users are those of the outer maps from now on */
+		WRITE_ONCE(inner_map->was_inner_map, true);
+	} else {
 		inner_map = ERR_PTR(-EINVAL);
+	}
 
 	return inner_map;
 }
-- 
2.55.0

