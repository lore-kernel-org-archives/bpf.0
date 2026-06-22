Received: from cvsmtppost02.nmdf.navercorp.com (cvsmtppost02.nmdf.navercorp.com [114.111.35.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1436167E
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782112628; cv=none; b=oFtY9YBEQ5lTfDjxDqwqbMINgM6qNVNvSI5mnTYgfyZ15A/cslAM/JpgRfcvZD1LwdsUq+zO3l31RBx1t4BvJAtw3b9JjmphTorVVTVue235W9SldjvUPOKEyPt3e5HF8kgq3OvwQ3WwrEss3CDC7mV9P1+2SHLJ7XiW2vWyz+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782112628; c=relaxed/simple;
	bh=h+DzAsJa7hv5asI+paF0edZJsKW8tnFqF6EqOQnPl7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ds4rfxXdBnr9UXVDYlpWtMnP3SytqOVHOoLfeWh1QaUxLFYFY84U9LNql7zHyXJzy4XpDJeNqsU0C4MqIeBMxsdHrYKNZpyOHHHoP107AUH8BAx4Q+AVxD3SnIWS46QNfC9QLuTaY3tAG1MXN2SUqjgplT4eAtMb6+q+EIKnH90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com; spf=pass smtp.mailfrom=navercorp.com; dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b=VNa9X6cs; arc=none smtp.client-ip=114.111.35.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navercorp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b="VNa9X6cs"
Received: from kr0m-real-1 ([10.111.46.243])
  by cvsmtppost02.nmdf.navercorp.com with ESMTP id aR0Bj3ncSbOjuGHO5DuPyQ
  for <bpf@vger.kernel.org>;
  Mon, 22 Jun 2026 07:17:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=navercorp.com;
	s=s20171120; t=1782112622;
	bh=h+DzAsJa7hv5asI+paF0edZJsKW8tnFqF6EqOQnPl7I=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=VNa9X6cs/rip5h4s96xi/nF0RNuKBbkGjMkeYoPSxc2e+nF7MuET9ALAQiAk6ye7w
	 kg7MD3zwdavrN15uMhCATlXNygfslGs2wOjIVgHBx7GQcBDW6N0NSAh4ECa00zaxYJ
	 WfRn1k5jOZPsVJlwvuJ9TVEhrZmRI0ty9MK3Uq2Dcywyb26eEf9a9rCa1OIRdEwuX6
	 9mzv/YuvepOYdUZWA/MTReXaUGh15JINi33uPmi0+Zs5YPMDQfV4PJ+oDWtY/PIqfx
	 aMiZDLotwo3dm9CFBeoNci/XDNoFCJ2O/hgolpKsGMG1xaW9vNSbvAuaRjiJhVy+Gj
	 F018b1RPKB1Tw==
X-Session-ID: g4nwRDNJRB6op9m5mXb8fQ
X-Works-Send-Opt: T9YwjAumKAumKAbZjAgmKqKXKoJYFHmwFBwYjHmm
X-Works-Smtp-Source: Pmn/KAU/FqJZ+HmZKoUm+6E=
Received: from localhost.localdomain ([10.25.121.184])
  by cvnsmtp02.nmdf.navercorp.com with ESMTP id g4nwRDNJRB6op9m5mXb8fQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Mon, 22 Jun 2026 07:17:02 -0000
From: Gyutae Bae <gyutae.opensource@navercorp.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minsu Jeon <minsu.jeon@navercorp.com>,
	Siwan Kim <siwan.kim@navercorp.com>,
	Jonghyeon Kim <jong-hyeon.kim@navercorp.com>,
	Gyutae Bae <gyutae.bae@navercorp.com>
Subject: [RFC bpf-next 2/3] bpf: implement compare-and-delete (BPF_F_COMPARE) for BPF_MAP_TYPE_HASH
Date: Mon, 22 Jun 2026 16:16:48 +0900
Message-Id: <20260622071649.31541-3-gyutae.opensource@navercorp.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260622071649.31541-1-gyutae.opensource@navercorp.com>
References: <20260622071649.31541-1-gyutae.opensource@navercorp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gyutae Bae <gyutae.bae@navercorp.com>

map_delete_elem() now honours BPF_F_COMPARE: it copies the expected
bytes, validates the compare window against value_size, and dispatches to a
new ->map_delete_elem_cmp().  The hash-map implementation, under the bucket
lock, memcmps the [off, off+size) window of the live value and unlinks only
on a match (mismatch -EBUSY, absent -ENOENT), making the compare and the
delete atomic w.r.t. every bucket-lock holder.  Only BPF_MAP_TYPE_HASH
wires up the op; every other map type lacks it and returns -EOPNOTSUPP.

Atomicity boundary: the compare is read under the bucket lock, so it is
atomic against every other bucket-lock holder (concurrent deletes,
element-replacing updates).  It is NOT mutual exclusion against a BPF
program that writes the value in place via the pointer from
bpf_map_lookup_elem(), which takes no bucket lock; against such a writer
the compare may observe a torn value within the locked section.  For a
meaningful result the compared region should be a synchronization variable
-- written with a single aligned store such as a monotonic revision, or
replaced via an update -- not a multi-field blob mutated in place.

It compares the raw stored value, so maps whose value carries BTF-managed
fields (bpf_spin_lock, bpf_timer, kptr, ...) are also rejected with
-EOPNOTSUPP: those bytes are sanitised on lookup, so a raw compare would
never match the caller's snapshot and could expose kernel-internal bytes.

BPF_MAP_DELETE_ELEM_LAST_FIELD now reaches compare_size, so the compare*
fields pass CHECK_ATTR even without BPF_F_COMPARE.  Reject that combination
with -EINVAL: a dropped flag must not silently turn a compare-and-delete
into an unconditional delete.

Co-developed-by: Minsu Jeon <minsu.jeon@navercorp.com>
Signed-off-by: Minsu Jeon <minsu.jeon@navercorp.com>
Co-developed-by: Siwan Kim <siwan.kim@navercorp.com>
Signed-off-by: Siwan Kim <siwan.kim@navercorp.com>
Co-developed-by: Jonghyeon Kim <jong-hyeon.kim@navercorp.com>
Signed-off-by: Jonghyeon Kim <jong-hyeon.kim@navercorp.com>
Signed-off-by: Gyutae Bae <gyutae.bae@navercorp.com>
---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/hashtab.c | 39 ++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c | 54 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..2e858272f7a7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -110,6 +110,8 @@ struct bpf_map_ops {
 	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
 	long (*map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags);
 	long (*map_delete_elem)(struct bpf_map *map, void *key);
+	long (*map_delete_elem_cmp)(struct bpf_map *map, void *key,
+				    const void *compare, u32 off, u32 size);
 	long (*map_push_elem)(struct bpf_map *map, void *value, u64 flags);
 	long (*map_pop_elem)(struct bpf_map *map, void *value);
 	long (*map_peek_elem)(struct bpf_map *map, void *value);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9f394e1aa2e8..8fc3ab938b9e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1534,6 +1534,44 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	return ret;
 }
 
+static long htab_map_delete_elem_cmp(struct bpf_map *map, void *key,
+				     const void *compare, u32 off, u32 size)
+{
+	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	struct hlist_nulls_head *head;
+	struct bucket *b;
+	struct htab_elem *l;
+	unsigned long flags;
+	u32 hash, key_size;
+	int ret;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+
+	key_size = map->key_size;
+
+	hash = htab_map_hash(key, key_size, htab->hashrnd);
+	b = __select_bucket(htab, hash);
+	head = &b->head;
+
+	ret = htab_lock_bucket(b, &flags);
+	if (ret)
+		return ret;
+
+	l = lookup_elem_raw(head, hash, key, key_size);
+	if (!l)
+		ret = -ENOENT;
+	else if (memcmp(htab_elem_value(l, key_size) + off, compare, size) != 0)
+		ret = -EBUSY;
+	else
+		hlist_nulls_del_rcu(&l->hash_node);
+
+	htab_unlock_bucket(b, flags);
+
+	if (!ret)
+		free_htab_elem(htab, l);	/* ret==0 implies we unlinked l */
+	return ret;
+}
+
 static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
@@ -2366,6 +2404,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
 	.map_update_elem = htab_map_update_elem,
 	.map_delete_elem = htab_map_delete_elem,
+	.map_delete_elem_cmp = htab_map_delete_elem_cmp,
 	.map_gen_lookup = htab_map_gen_lookup,
 	.map_seq_show_elem = htab_map_seq_show_elem,
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b44106c8ea75..42fc432f82e1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1892,18 +1892,30 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 	return err;
 }
 
-#define BPF_MAP_DELETE_ELEM_LAST_FIELD key
+#define BPF_MAP_DELETE_ELEM_LAST_FIELD compare_size
 
 static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 {
 	bpfptr_t ukey = make_bpfptr(attr->key, uattr.is_kernel);
 	struct bpf_map *map;
-	void *key;
+	void *key, *compare = NULL;
+	u32 off = 0, size = 0;
 	int err;
 
 	if (CHECK_ATTR(BPF_MAP_DELETE_ELEM))
 		return -EINVAL;
 
+	if (attr->flags & ~BPF_F_COMPARE)
+		return -EINVAL;
+
+	/* The compare* fields are meaningful only with BPF_F_COMPARE.  Reject them
+	 * when the flag is absent so a dropped BPF_F_COMPARE cannot silently turn a
+	 * compare-and-delete into an unconditional delete.
+	 */
+	if (!(attr->flags & BPF_F_COMPARE) &&
+	    (attr->compare || attr->compare_offset || attr->compare_size))
+		return -EINVAL;
+
 	CLASS(fd, f)(attr->map_fd);
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
@@ -1920,6 +1932,38 @@ static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
+	if (attr->flags & BPF_F_COMPARE) {
+		bpfptr_t ucmp = make_bpfptr(attr->compare, uattr.is_kernel);
+
+		off = attr->compare_offset;
+		size = attr->compare_size ?: map->value_size;
+		/* off + size must fit in value_size, overflow-safe */
+		if (size > map->value_size || off > map->value_size - size) {
+			err = -EINVAL;
+			goto out;
+		}
+		if (!map->ops->map_delete_elem_cmp) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+		/* Compare-and-delete reads the raw stored value.  Maps whose value carries
+		 * BTF-managed fields (bpf_spin_lock, bpf_timer, kptr, ...) have
+		 * those bytes sanitised on lookup, so a raw compare would never
+		 * match the caller's snapshot and could expose kernel-internal
+		 * bytes.  Reject such maps for now.
+		 */
+		if (!IS_ERR_OR_NULL(map->record)) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+		compare = kvmemdup_bpfptr(ucmp, size);
+		if (IS_ERR(compare)) {
+			err = PTR_ERR(compare);
+			compare = NULL;
+			goto out;
+		}
+	}
+
 	if (bpf_map_is_offloaded(map)) {
 		err = bpf_map_offload_delete_elem(map, key);
 		goto out;
@@ -1932,12 +1976,16 @@ static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 
 	bpf_disable_instrumentation();
 	rcu_read_lock();
-	err = map->ops->map_delete_elem(map, key);
+	if (compare)
+		err = map->ops->map_delete_elem_cmp(map, key, compare, off, size);
+	else
+		err = map->ops->map_delete_elem(map, key);
 	rcu_read_unlock();
 	bpf_enable_instrumentation();
 	if (!err)
 		maybe_wait_bpf_programs(map);
 out:
+	kvfree(compare);
 	kvfree(key);
 err_put:
 	bpf_map_write_active_dec(map);
-- 
2.39.5 (Apple Git-154)

