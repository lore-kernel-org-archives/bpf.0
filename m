Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37277367298;
	Mon, 24 Aug 2026 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582292; cv=none; b=O8meRb84VLcXkXsaiPkRZeBoWH7neHqSdISai2DuoIpwG4w1MKFq4C+ayO003yH2TXXWygWYYEWwyEZvfbqfk1Mgh1XkrrM+HJdWeW+igNyh5f62Y42GUI5PzPjWvt13oEC2oxKkB+6Sy+8axR0c25EsPJwjQa0nDqdYPg9SwRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582292; c=relaxed/simple;
	bh=P3AdyzdShDrUb/YgX9pMKwXXddwQSm7F29np86e13z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHS+TYKrJfuDCD81SSCrLw/oGW2tsa1j5dyOp9KilIv5bGYml8p+wtRRKz5vKLuuLaGEqovkl40+GNYxDLOSuEs/W+A3HrN4lGn5lio70aeRZHdAf51zvwmeWMXmpf4MIXRR8B1LkkAGZByVmZKOkiHV/hIg9yknzz455gog4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MkPPT7bD; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MkPPT7bD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=l+
	yg31nd4nBh5hM/Aoz4/e9I3HPD3hBY2IDhBbqEslg=; b=MkPPT7bDm9o2bXvAnC
	0yV5vGg5DGKFV2+ZJT87YgdgX/J+l+wWqwY8AGrpDB27Dv+/Y2FjMpuKdiBa9fc5
	huI+U9U71G8IYI+Z4Powkx5XOoa59pjOdQfmdqlDNkL2r4UEKIsWTHeh6przAeZ8
	Md89TtbvyMG7zrOxDjmghBOzE=
Received: from nec8-i7 (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDn+osAV4xqIt5SMw--.54939S3;
	Mon, 24 Aug 2026 22:36:50 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH 1/4] bpf: Cancel special fields in resizable hashtab on recycle
Date: Mon, 24 Aug 2026 22:36:18 +0800
Message-ID: <20260824143621.2098856-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824143621.2098856-1-chenyuan_fl@163.com>
References: <DKM6K95EN9OF.3O9XNYWVLYHDE@gmail.com>
 <20260824143621.2098856-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDn+osAV4xqIt5SMw--.54939S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF4ftF43Kry5Kw4xAr1kKrg_yoWxWw18pF
	Z5Wr13Cr1kJrnIqrZ0yw4vkrWrZ3s5tr4YkFZ5GryF934rXF97Jr1fJa97uF1jyF1vvFnY
	qF4IqFW3ua1UC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jalksUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQKTUWqMVwKt8AAA3v

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

Fix the resizable hashtab the same way:

  * rhtab_delete_elem() and rhtab_map_update_existing() now cancel
    only NMI-safe fields. Referenced kptrs stay attached to the
    recycled element and are destroyed by rhtab_mem_dtor() once the
    element is eventually freed, keeping the reference accounting
    balanced.

  * rhtab_map_update_elem() initializes the special fields of a
    freshly allocated element. The bpf memory allocator may return a
    recycled element that still owns a referenced kptr, and
    check_and_init_map_value() would zero that slot, dropping the
    reference without releasing it. rhtab_init_map_value()
    initializes the remaining fields (spin lock, timer, workqueue,
    task_work, refcount) but leaves kptr slots untouched, matching
    the hash map semantics.

Verified with a selftest: a perf_event (NMI) program overwrites a
rhtab element that holds a referenced task kptr, and a second phase
deletes and re-inserts the element to exercise the recycle path.
Before the patch the NMI update eagerly released the kptr and the
recycle path zeroed the inherited slot; after the patch the kptr is
inherited on both paths and the probe observes it non-NULL.

Fixes: a3a81d247651 ("bpf: Cancel special fields on map value recycle")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/hashtab.c | 70 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index d40cb5dd446c..0df8db27cd8c 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2864,14 +2864,56 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
 	return htab_map_alloc_check(attr);
 }
 
-static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
-					struct rhtab_elem *elem)
+static void rhtab_cancel_fields(struct bpf_rhtab *rhtab,
+				struct rhtab_elem *elem)
 {
 	if (IS_ERR_OR_NULL(rhtab->map.record))
 		return;
 
-	bpf_obj_free_fields(rhtab->map.record,
-			    rhtab_elem_value(elem, rhtab->map.key_size));
+	/*
+	 * Only cancel NMI-safe fields (timer, workqueue, task_work) here.
+	 * RHASH values can also carry referenced kptrs (and per-cpu kptrs),
+	 * whose destructors must not run from arbitrary BPF execution
+	 * contexts (e.g. NMI); leave them attached to the recycled element
+	 * and let rhtab_mem_dtor() destroy them once the element is
+	 * eventually freed. This matches the hash map semantics introduced
+	 * by a3a81d247651 ("bpf: Cancel special fields on map value
+	 * recycle").
+	 */
+	bpf_map_free_internal_structs(&rhtab->map,
+				      rhtab_elem_value(elem, rhtab->map.key_size));
+}
+
+/*
+ * Initialize special fields of a freshly allocated rhtab element, but keep
+ * kptr fields untouched. A recycled element may carry a referenced kptr from
+ * its previous life: the delete path only cancels NMI-safe fields (matching
+ * the hash map semantics), so the kptr reference stays owned by the element
+ * until rhtab_mem_dtor() destroys it. Zeroing it here (as
+ * check_and_init_map_value() would) would drop the reference without
+ * releasing it.
+ */
+static void rhtab_init_map_value(struct bpf_map *map, void *value)
+{
+	struct btf_record *rec = map->record;
+	int i;
+
+	if (IS_ERR_OR_NULL(rec))
+		return;
+
+	for (i = 0; i < rec->cnt; i++) {
+		struct btf_field *field = &rec->fields[i];
+		void *field_ptr = value + field->offset;
+
+		switch (field->type) {
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
+			continue;
+		default:
+			bpf_obj_init_field(field, field_ptr);
+		}
+	}
 }
 
 static void rhtab_mem_dtor(void *obj, void *ctx)
@@ -2963,8 +3005,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
 		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
 		check_and_init_map_value(&rhtab->map, copy);
 	}
-	/* Release internal structs: kptr, bpf_timer, task_work, wq */
-	rhtab_check_and_free_fields(rhtab, elem);
+	/* Cancel NMI-safe fields; full destruction happens in rhtab_mem_dtor */
+	rhtab_cancel_fields(rhtab, elem);
 	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
 	return 0;
 }
@@ -3022,10 +3064,11 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
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
+	rhtab_cancel_fields(rhtab, elem);
 	return 0;
 }
 
@@ -3066,7 +3109,14 @@ static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u
 
 	memcpy(elem->data, key, map->key_size);
 	copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
-	check_and_init_map_value(map, rhtab_elem_value(elem, map->key_size));
+	/*
+	 * Initialize special fields of the (possibly recycled) element, but
+	 * leave kptr slots alone: a recycled element may still own a
+	 * referenced kptr that rhtab_mem_dtor() will release, so zeroing it
+	 * here would leak the reference. Fresh memory from the bpf mem
+	 * allocator is zeroed, so skipping the kptr init is safe there too.
+	 */
+	rhtab_init_map_value(map, rhtab_elem_value(elem, map->key_size));
 
 	/* Prevent deadlock for NMI programs attempting to take bucket lock */
 	bpf_disable_instrumentation();
-- 
2.54.0

