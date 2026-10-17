Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282433E355
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200728; cv=none; b=i73B7dlKwqKctaFc0cBlD7YBoIu5OvN384C1Ho19ens+78EtsluR4WxobT09aLaMXl2FDeF2lsUvvaaYlXOj9+fg0e2092g6KzP4WnV0Cn0CKxyb7aUM+PyYJ3xejiqCoAu38ytpGMG72zyg44Iy1M8mEt2dZBTiY9eruXGauDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200728; c=relaxed/simple;
	bh=1be5hsRqjLh/TwQS3Z2z8HtgzBnlrxCAEsz32AIyA74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5JIfFoy+sE9tDa3tlmcMSCtsAWciofPQC7ArTz8ev3H1DMDCnsjQrpQngjDTIAP9lBA/RSDXSb6q3bxS0EqldH0wodzByO5KPM82RH6gkep1BGNZiWroUqOe7thY5yN57fQIK/20m9eljlwUyxt5cGkmgKDe8tye46gQNGBphg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlnIarbP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlnIarbP"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e87c66e556so8124215ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200727; x=1792805527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3rcxqacvPpaRtSzX6QhBwa+RKxj6krjUnQp2JA6j0LI=;
        b=nlnIarbPI54uav582ciMSJ3yahfJsmt937BNq3fP++L6xY8Hb9IxdX8HSAVEGPwa9B
         2rZEBaY57synzn6R+tXtWSQMedhGEd0x5BV3kJgvBHk/GvXcrNEAJphSsW9OF3dVk2H2
         VK+w1/HnAysxW2VbCzu7pcSpWZc52/sr9gA7ZV51hmxOgLZB45k/5dyd6UqG8vgKLmDY
         TZ9GvsLZg2HNVl3WkkmexsKdTtsuhnoc3EI8xmaQ2cGVQNJpYx/zTPIMKZAUSiGePiJB
         TUNKHRIehna3Vj4bcPucsP4PCIZJTH7Nu20cJsOUcgBISfrxBZEqKhreMP3BPJT9DoPN
         J7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200727; x=1792805527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3rcxqacvPpaRtSzX6QhBwa+RKxj6krjUnQp2JA6j0LI=;
        b=1aTQUTcqEJI/KrYdAX6/LdGr646kJw9FCjfNLSEWh88MpAHCCrRgLyLCIizMYA5+eP
         ykSTEa82JYuFIlrjq1sexKov5yA2lp7Bv/9fqcvpUCRM5dV+TJs85PMGoJvsTHRuL0IG
         g4L8zv4gQTJ6lNokLmg4POwBwm3UiKxBEBjpSzB+UCTgtY9uopNWv0hlX2uEcWpqBORe
         AG+bsoU/stzGbckqsTR9tt7fVCmVBhGcFp4LAhHeF9lEN0NlhquJW4rBgq0hUwzGnUnp
         5D7rnVJRD+vgRYvypReXy30HPGcjCONklvpN9k4eFCjrwWZUvg1hyH0fhFlIRbIZHD38
         ciXQ==
X-Gm-Message-State: AFq9FYLvCSKRoqqmRAhtDlx44TlHzvIKYyzNn6ipHxkgGOY5gCZ3cjKo
	kKDRZsuY9hLt/DUJXFiM9XYnU7+rnm+miuMXRKZz70YgFLqnPa0/WBwBgXUzrIal
X-Gm-Gg: AYBFou0mW3nS9RlanNodM1pSWlTo90XytDfIsoWSYZpXTWEZ8cTA6IRFpC3AUxQgurE
	pkufr4bKyxJrbRJMp1FRYWMg0nt1rffM0Hk2X5Ax6MI/UvGjGm6WK5kl1AaTMtDPXXcGOHu0OJ3
	lt5oF8VirprFPbAyuVccdNNS4ICuZcSUgoyAitypi/1z8JdqBaEe/a2gNK4kAL0INrxUDcJFfL1
	1ULSOyVYtuRw7CiTXm1+YCoin3anz2jn/nBg9/8+QXga9NmUQek3eV8hhgcVUtCv41PGyubM/vY
	Pxp6xQIB7p0EW3STxHFBnQFO0dUazEN2qGmH6ViEUj7Ayo6N28r4T7fWPD78bUOL5euBGOXRvSf
	HsTVz5Naoype4/QiC491JM1QZH4WGzXSxzMvdC54i0uwSty5D1E4q93uVs0jFC3DkyHuJSfJx46
	/a0+pBpoUNez820ZSHwiHG9GvPKY4hvGPQKRvCtOU1CljQ2kG3Gaph/FR7YUHSt0RTALCJk/65J
	mUQaRJOlVL6c9WSIhXLB4XbCokWM+KMOAw3cLoVuIfz2mzmf87uhktGd35P0cyX7VRQdtaYZVkg
	UbVizF0QVH3EbxuF1FZj7x9msjHVT1SdBZt+bK1T9PO+XpIHO45L6w==
X-Received: by 2002:a17:903:946:b0:2dd:c100:2521 with SMTP id d9443c01a7336-2e9a6e53df0mr10273855ad.42.1792200726497;
        Fri, 16 Oct 2026 18:32:06 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d5558sm17439075ad.7.2026.10.16.18.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:32:05 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 29/38] bpf: Keep values of a dead owner for sleepable programs
Date: Sat, 17 Oct 2026 01:24:42 +0000
Message-ID: <20261017012451.364800-21-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
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

Elements of such maps now wait for sleepable programs that are running
when their owner dies.  Other maps are freed as before.

Fixes: dcf456c9a095 ("bpf: Fix usage of trace RCU in local storage.")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h            |  1 +
 kernel/bpf/bpf_local_storage.c | 11 ++++++++---
 kernel/bpf/map_in_map.c        |  7 +++++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8b26c4ec12a7..ad4ef937e112 100644
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
index f234f671e75f..3d0c455d258c 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -352,7 +352,7 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 				    struct bpf_local_storage_map_bucket *b)
 {
-	bool in_map_free = !!b, free_storage = false;
+	bool in_map_free = !!b, free_storage = false, sleepable_users = false;
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map *smap;
 	unsigned long flags;
@@ -362,6 +362,10 @@ static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
 	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
 
 	if (smap) {
+		/* A map that is freed, or NULL here, has no program left. */
+		sleepable_users = !in_map_free &&
+				  (atomic64_read(&smap->map.sleepable_refcnt) ||
+				   READ_ONCE(smap->map.was_inner_map));
 		b = b ? : select_bucket(smap, local_storage);
 		err = raw_res_spin_lock_irqsave(&b->lock, flags);
 		if (!err) {
@@ -434,11 +438,12 @@ static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
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

