Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE28426439
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442190; cv=none; b=MvVm4bGidnDm6/yQSqXdKxZY4IEMYV6/uUV+GQCrCeuBw6rD7WqU8O8C3Twh5lLGrmlNr5ofbcgPsVSwED1HUaKBO09wNRfnBkJtx/sQSRK+G2Yg1x1bph4yryL4cuVkH1k/taeSl3FMkiWlg7nYclq1rpaUWwCUhdosAojWvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442190; c=relaxed/simple;
	bh=6ya9JtqTMd+eN+4H8mdTUNWi7i4nwJHzsiqiUF2oyxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIfMZh5elcxDcbtsWAZUv3bqYGTnoZwsaO78PSwNW7MYK+B6+B9H+nuyAyETbApxjv6yDd4eBzo12vNS/xvXNUbJq2+g+wj3GXpdbcP1qBcAmv7jZ0zzV6VPM9zrjuKAGhjYCe4Xkc4J/4x25Kc+1DIWxYkP3brkPo7MUDOGmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Kh/YYmAe; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Kh/YYmAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=b9
	6r7sYlZDJVYEp4CQx/9hWisRiRJcVQ/HSq/hbWBsI=; b=Kh/YYmAeUOdQzCL7N8
	txRRoCsfqEdhfdx8wPuO6QdlTYsj0IcxRtwkODkHWDeObvRPwO6BZI168IYJbYcg
	0Y+aliCna/oU5dKTEJVoH6xSEr84XNsKw4gkA5LDu0ksxvGPwa1HtJUG4XKAuDOT
	FdjhADb4P77GRKLNqq5Ksf5CM=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnnhic8XpqSKdbPA--.38984S3;
	Tue, 11 Aug 2026 17:55:45 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next 1/2] bpf: Cancel special fields in resizable hashtab on recycle
Date: Tue, 11 Aug 2026 17:55:30 +0800
Message-ID: <20260811095531.3294167-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811095531.3294167-1-chenyuan_fl@163.com>
References: <20260811095531.3294167-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnnhic8XpqSKdbPA--.38984S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr15GrWfCFWrCrW7Wr1ftFb_yoWrCF1xpF
	Z5Wr1akr1kJFn0vFZ0ya1vkrZYq3Z5JryYkFZ8K34F9w1FqF97tr1rCayxCFyFyF18AF9a
	qF4qq343Xa1UCrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTKZJUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAgHdm2p68aH5XwAA3j

From: Yuan Chen <chenyuan@kylinos.cn>

rhtab_delete_elem() and rhtab_map_update_existing() eagerly call
bpf_obj_free_fields() when an element is deleted or its value is
replaced. This runs kptr destructors (and unpins uptrs, frees list/rbtree
roots) in the caller's execution context, which is unsafe for BPF
programs running in NMI context (e.g. perf_event programs attached to
hardware PMU overflows): referenced kptr destructors may take locks or
otherwise cannot run in NMI.

Commit a3a81d247651 ("bpf: Cancel special fields on map value recycle")
switched the hash map and array recycle paths to bpf_obj_cancel_fields(),
which only cancels NMI-safe fields (timer, workqueue, task_work), but it
missed the resizable hashtab. rhtab_map_update_existing() even documents
the intended "cancel" semantics while still calling bpf_obj_free_fields().

Fix by cancelling only NMI-safe fields on rhtab update/delete and leaving
referenced kptrs (and other fields requiring full destruction) attached
to the recycled element, to be destroyed by rhtab_mem_dtor() when the
element is eventually freed. This matches the hash map semantics and
keeps the element's kptr reference accounting balanced: the reference
stays owned by the element and is released exactly once by the final
destruction path.

Verified with a selftest (perf_event NMI program overwriting a rhtab
element that holds a referenced task kptr): before this patch the NMI
update releases the kptr and the subsequent probe observes NULL in the
slot; after the patch the kptr is inherited and the probe observes it
non-NULL.

Fixes: a3a81d247651 ("bpf: Cancel special fields on map value recycle")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/hashtab.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9f394e1aa2e8..70fa1e1b4b00 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2865,14 +2865,23 @@ static int rhtab_map_alloc_check(union bpf_attr *attr)
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
+	 * kptr/uptr/list/rbtree destruction must not run from arbitrary BPF
+	 * execution contexts (e.g. NMI), so leave those fields attached to
+	 * the recycled element and let rhtab_mem_dtor() destroy them once the
+	 * element is eventually freed. This matches the hash map semantics
+	 * introduced by a3a81d247651 ("bpf: Cancel special fields on map value
+	 * recycle").
+	 */
+	bpf_map_free_internal_structs(&rhtab->map,
+				      rhtab_elem_value(elem, rhtab->map.key_size));
 }
 
 static void rhtab_mem_dtor(void *obj, void *ctx)
@@ -2964,8 +2973,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem, v
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
@@ -3024,10 +3033,11 @@ static long rhtab_map_update_existing(struct bpf_map *map, struct rhtab_elem *el
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
 
-- 
2.54.0

