Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153933815D9;
	Tue,  1 Sep 2026 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244229; cv=none; b=kiDrZDfeBCtXrwxdU6vCxA3neXWw27NKGPdJUNlDqeRnqv1Fy5rhnoMs5BuloIIUy0Lhs9NSaaWlX4R0G1rbZA9oh4S6U4C9nqNuBztH26hQJuYvfmhHq6tSX3X5sicd5E63SG4pznF0jCkRBI5G9KUDjW3egSI3PM6/DIroj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244229; c=relaxed/simple;
	bh=S4eGY462Yepo4JD995kGaKRbsAUhv8M/wPLctXTvQJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSCnIk4U7PdpLjCRF1WFmWj7GIpwvI1+DNrhlr6H5MAdEWo6cYbil7WlEbsDiAa2BJRn3ku8Oh5joFFtomGLLcL1P7yc+KPkDCkdymjLYSouIAwI8SpeJS7oTU0G8p9S/UH/as0nFHPQDdGoKfzxcKGTo/J0nqJYt/fDEnxheqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lGFgQvJc; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lGFgQvJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1r
	TN9M+Bqw98xM48PiM/4jWqJzlG1hXlHCckkiXqcmU=; b=lGFgQvJcnobvoVXrO+
	6nWKbDbApHmMBNtI5g1KzvmsvzqK2I9+ESikHP778QlRwGLmyTRmkGrSxL22vxl0
	/rKqnIGCgmPyhQfHgTvIhY+4LkzuiLlxhAnWJNNi2DPQECAZj53oOz7CicmEL9b8
	HZkGO/ZHP2IzbNq8T1ReJrBHo=
Received: from nec8-i7 (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3n5+mcJZqA6mBNA--.25535S3;
	Tue, 01 Sep 2026 14:28:59 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v3 1/4] bpf: Cancel special fields in resizable hashtab on recycle
Date: Tue,  1 Sep 2026 14:28:42 +0800
Message-ID: <20260901062845.1379760-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901062845.1379760-1-chenyuan_fl@163.com>
References: <0560a24d-2cf9-4e5b-aa61-580af1e56de1@gmail.com>
 <20260901062845.1379760-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3n5+mcJZqA6mBNA--.25535S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1fZF13AF1UGw1rtF1rtFb_yoW7Gr17pF
	Z3Wr1akr1kJrn0qFZ0yw4vk3yrX3s5t3yakFZ8GryFvw1rXF97Jr1rJayxuFyYyF1vvrsa
	qFn2vrWava15C37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrMa8UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQyHRWqWcKx2DwAA3W

From: Yuan Chen <chenyuan@kylinos.cn>

rhtab_delete_elem() and rhtab_map_update_existing() eagerly call
bpf_obj_free_fields() when an element is deleted or its value is
replaced. This runs kptr destructors in the caller's execution
context, which is unsafe for BPF programs running in NMI context
(e.g. perf_event programs attached to hardware PMU overflows):
referenced kptr destructors may take locks or otherwise cannot run
in NMI.

Commit a3a81d247651 ("bpf: Cancel special fields on map value
recycle") switched the hash map and array recycle paths to
bpf_obj_cancel_fields(), which only cancels NMI-safe fields (timer,
workqueue, task_work), but it missed the resizable hashtab.
rhtab_map_update_existing() even documents the intended "cancel"
semantics while still calling bpf_obj_free_fields().

Fix the resizable hashtab the same way: call bpf_obj_cancel_fields()
on delete and in-place update, matching htab. Referenced kptrs stay
attached to the recycled element and are destroyed by rhtab_mem_dtor()
once the element is eventually freed, keeping the reference accounting
balanced. No special-field initialization is added to the element
alloc path: fresh elements come zeroed from the bpf mem allocator,
recycled elements already had their timer/workqueue/task_work slots
reset by bpf_obj_cancel_fields(), and check_and_init_map_value() would
zero the kptr slot of a recycled element, dropping the reference
without releasing it.

Verified with a selftest: a perf_event (NMI) program overwrites a
rhtab element that holds a referenced task kptr, and a second phase
deletes and re-inserts the element to exercise the recycle path.
Before the patch the NMI update eagerly released the kptr and the
recycle path zeroed the inherited slot; after the patch the kptr is
inherited on both paths and the probe observes it non-NULL.

Fixes: a3a81d247651 ("bpf: Cancel special fields on map value recycle")
Suggested-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/hashtab.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d40cb5dd446c..aaedda3730f3 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2864,16 +2864,6 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
 	return htab_map_alloc_check(attr);
 }
 
-static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
-					struct rhtab_elem *elem)
-{
-	if (IS_ERR_OR_NULL(rhtab->map.record))
-		return;
-
-	bpf_obj_free_fields(rhtab->map.record,
-			    rhtab_elem_value(elem, rhtab->map.key_size));
-}
-
 static void rhtab_mem_dtor(void *obj, void *ctx)
 {
 	struct htab_btf_record *hrec = ctx;
@@ -2963,8 +2953,9 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
 		check_and_init_map_value(&rhtab->map, copy);
 	}
-	/* Release internal structs: kptr, bpf_timer, task_work, wq */
-	rhtab_check_and_free_fields(rhtab, elem);
+	/* Cancel NMI-safe fields; full destruction happens in rhtab_mem_dtor */
+	bpf_obj_cancel_fields(&rhtab->map,
+			      rhtab_elem_value(elem, rhtab->map.key_size));
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 	return 0;
 }
@@ -3022,10 +3013,12 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
 	 * BPF_F_LOCK, matching arraymap semantics.
 	 *
 	 * copy_map_value() skips special-field offsets, so old timers/
-	 * kptrs/etc. still sit in the slot. Cancel them after the copy
-	 * to match arraymap's update semantics.
+	 * kptrs/etc. still sit in the slot. Cancel the NMI-safe ones after
+	 * the copy to match arraymap's update semantics; referenced kptrs
+	 * stay attached and are destroyed by rhtab_mem_dtor().
 	 */
-	rhtab_check_and_free_fields(rhtab, elem);
+	bpf_obj_cancel_fields(&rhtab->map,
+			      rhtab_elem_value(elem, rhtab->map.key_size));
 	return 0;
 }
 
@@ -3066,7 +3059,14 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 
 	memcpy(elem->data, key, map->key_size);
 	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
-	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
+	/*
+	 * No explicit special-field initialization, matching the hash map's
+	 * non-prealloc path: fresh elements come zeroed from the bpf mem
+	 * allocator, and recycled elements had their timer/workqueue/task_work
+	 * slots reset by bpf_obj_cancel_fields() on delete. kptr slots are
+	 * left untouched so a recycled element keeps owning its reference
+	 * until rhtab_mem_dtor() releases it.
+	 */
 
 	/* Prevent deadlock for NMI programs attempting to take bucket lock */
 	bpf_disable_instrumentation();
-- 
2.54.0

