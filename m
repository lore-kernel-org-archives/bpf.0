Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608684;
	b=mZ3Na5pjf/G8SIQoOrCSCiH1Rmbjnc+zFgnN9+ycLuxnSko7NxHnxEee0AmuyairhpxO
	 X/lKPNd7tS1g77ZUYGWdLFCvSV9zyXih9byDhXBfIupKjZt/Kg37ZBW11gZTURAmlSB+f
	 xasxu9ufRNNh+BvteSrEAs4UtgcnseVn8vpy830VSfA0zeqnPZN6AHXTw9pGNEg6bA/zR
	 X1EIEc+Dl+zWyvQTTFsVtmIrpU2SSV39O0+jJl15n85g/Ihm4TqGyVIhnBREph43n+ZSZ
	 9wV8hexf8H+aeImNoz9+65yEycxIP+XQQG2MwF6Jya1ASGCFLyqAxtw/w87L+A7ctUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608684;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cUbNNAjicUDaxoSqiG4B1RVTeHKOH2AuYNBb6EMHiZM=;
	b=5RkYbyWaARwstFTOiGQiixgdHnW8JKyhGA9MzcH1rF4XBeTSjp3wqK/5JP0SmAJ0TmiN
	 PHx14KvefE9mCRsi6+yqphjQ+2ogBuC1GkrTwCa/ZilE+O8jy6Q0CaL2iP7GTHEoBsS9k
	 B3H5J3de5u5KIqECNzhXfltOAg8zljW4a2hj7ZjvLWfQof7iS27MLfTn1HAQhKNmfY6gy
	 J2wcYB7kYeF9tP8JWoPnpgZEGNY4vPm57WFBXcXSSJsLdiXKN7LpvpnDsZsgcrEkWxfYR
	 YjczA0vrQkkx0ELTLHoPPxtGZdRtpUjpC7K+TE9pwTge50u89sqbxDjOeXBfoQ5Lbyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGIy5j56;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D9606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGIy5j56
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD671F000C1;
	Wed, 21 Oct 2026 18:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792608683;
	bh=cUbNNAjicUDaxoSqiG4B1RVTeHKOH2AuYNBb6EMHiZM=;
	h=From:To:Cc:Subject:Date;
	b=eGIy5j562PFf52+1Dzd3mqW3bwDxNB1KsH7ytgrJB30fGw+ffgfvUrfQFTpNYAvYN
	 iUe3VKyUNxTBHuJidSRdNQeKnRkXs+jXHKpShWGQ6SoVojsR+l/3igr8nrJDWS+o5L
	 Gj8+21VjtOrSL47rGwTHZRqtiimFf41Ta9EJkPlbFi4REPh45kyVjfa8UyISKrpBpA
	 i7PQHkTa3OuWZ0ffzxw0sC93g7HQjlNv3iqbj7gefEJGxNyWGPG4D38Y2pcZ+NPA3l
	 ErFUsSobsvmD0GmrYakv3zIS0gczgaDBL/30O6cZuYpXIR/Pgn8eEujr5wFhWqLNYt
	 EYJHbSNGRorKw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v2] bpf: Drop percpu_counter from the htab element count
Date: Wed, 21 Oct 2026 11:51:16 -0700
Message-ID: <20261021185117.650403-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The element count of a large non-preallocated hash map is a
percpu_counter, whose slow path takes fbc->lock with
raw_spin_lock_irqsave(). That is not safe against BPF programs that run
while the lock is held or contended: NMI programs and, as
queued_spin_lock_slowpath() calls trace_contention_end() with the lock
already held, programs attached to the contention_end tracepoint. If such
a program updates the same map it spins on the lock its own CPU holds:

  WARNING: possible recursive locking detected
  cend/250 is trying to acquire lock:
  (key#5){....}-{2:2}, at: _raw_spin_lock_irqsave+0x18/0x30
  but task is already holding lock:
  (key#5){....}-{2:2}, at: _raw_spin_lock_irqsave+0x18/0x30
    percpu_counter_add_batch+0xd8/0x160
    alloc_htab_elem+0x408/0x480
    htab_map_update_elem+0x1e8/0x6a0
    bpf_prog_7a29a1ae68aedf07_cend+0x14c/0x1f8
    __bpf_trace_contention_end+0x14/0x20
    queued_spin_lock_slowpath+0x2e8/0x468
    percpu_counter_add_batch+0xd8/0x160
    alloc_htab_elem+0x408/0x480
    htab_map_update_elem+0x1e8/0x6a0

is_map_full() is affected too, as __percpu_counter_compare() falls back
to percpu_counter_sum(), which takes the same lock.

map.elem_count already is a lockless per-cpu count of the same elements.
Make htab->count follow it in steps of PERCPU_COUNTER_BATCH and let
is_map_full() sum elem_count once count is within nr_cpu_ids * batch of
max_entries. Each cpu's elem_count is ahead of count by less than the
batch, so that is exact, in NMI as well.

Fixes: 86fe28f7692d ("bpf: Optimize element count in non-preallocated hash map.")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---

v1: https://lore.kernel.org/all/20261020131524.207415-1-puranjay@kernel.org/
Changes in v2:
- Drop percpu_counter and make htab->count follow map.elem_count
  instead, which also covers contention_end programs (Alexei)

---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/hashtab.c | 64 ++++++++++++++++++--------------------------
 2 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 580f89c450b55..dc805e095fe86 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3042,6 +3042,8 @@ static inline void bpf_map_dec_elem_count(struct bpf_map *map)
 	this_cpu_dec(*map->elem_count);
 }
 
+s64 bpf_map_sum_elem_count(const struct bpf_map *map);
+
 extern int sysctl_unprivileged_bpf_disabled;
 
 bool bpf_token_capable(const struct bpf_token *token, int cap);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bf78e09f4d518..6e2115477cb9e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -94,10 +94,10 @@ struct bpf_htab {
 		struct bpf_lru lru;
 	};
 	struct htab_elem *__percpu *extra_elems;
-	/* number of elements in non-preallocated hashtable are kept
-	 * in either pcount or count
+	/* number of elements in non-preallocated hashtable. With
+	 * use_percpu_counter it only follows map.elem_count in steps of
+	 * PERCPU_COUNTER_BATCH, see is_map_full()
 	 */
-	struct percpu_counter pcount;
 	atomic_t count;
 	bool use_percpu_counter;
 	bool has_hash;
@@ -739,29 +739,20 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 	htab_init_buckets(htab);
 
-/* compute_batch_value() computes batch value as num_online_cpus() * 2
- * and __percpu_counter_compare() needs
- * htab->max_entries - cur_number_of_elems to be more than batch * num_online_cpus()
- * for percpu_counter to be faster than atomic_t. In practice the average bpf
- * hash map size is 10k, which means that a system with 64 cpus will fill
- * hashmap to 20% of 10k before percpu_counter becomes ineffective. Therefore
- * define our own batch count as 32 then 10k hash map can be filled up to 80%:
+/* is_map_full() needs htab->max_entries - cur_number_of_elems to be more than
+ * batch * nr_cpu_ids for the percpu counter to be faster than atomic_t. In
+ * practice the average bpf hash map size is 10k. With batch count of 32 a 10k
+ * hash map on a system with 64 cpus can be filled up to 80%:
  * 10k - 8k > 32 _batch_ * 64 _cpus_
- * and __percpu_counter_compare() will still be fast. At that point hash map
+ * and is_map_full() will still be fast. At that point hash map
  * collisions will dominate its performance anyway. Assume that hash map filled
  * to 50+% isn't going to be O(1) and use the following formula to choose
- * between percpu_counter and atomic_t.
+ * between the percpu counter and atomic_t. The batch has to be a power of 2.
  */
 #define PERCPU_COUNTER_BATCH 32
-	if (attr->max_entries / 2 > num_online_cpus() * PERCPU_COUNTER_BATCH)
+	if (attr->max_entries / 2 > nr_cpu_ids * PERCPU_COUNTER_BATCH)
 		htab->use_percpu_counter = true;
 
-	if (htab->use_percpu_counter) {
-		err = percpu_counter_init(&htab->pcount, 0, GFP_KERNEL);
-		if (err)
-			goto free_map_locked;
-	}
-
 	if (prealloc) {
 		err = prealloc_init(htab);
 		if (err)
@@ -789,8 +780,6 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 free_prealloc:
 	prealloc_destroy(htab);
 free_map_locked:
-	if (htab->use_percpu_counter)
-		percpu_counter_destroy(&htab->pcount);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
@@ -1162,30 +1151,33 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 
 static bool is_map_full(struct bpf_htab *htab)
 {
-	if (htab->use_percpu_counter)
-		return __percpu_counter_compare(&htab->pcount, htab->map.max_entries,
-						PERCPU_COUNTER_BATCH) >= 0;
-	return atomic_read(&htab->count) >= htab->map.max_entries;
+	s64 count = atomic_read(&htab->count);
+
+	/* each cpu's elem_count is ahead of count by less than the batch */
+	if (htab->use_percpu_counter &&
+	    count + nr_cpu_ids * PERCPU_COUNTER_BATCH >= htab->map.max_entries)
+		count = bpf_map_sum_elem_count(&htab->map);
+	return count >= htab->map.max_entries;
 }
 
 static void inc_elem_count(struct bpf_htab *htab)
 {
-	bpf_map_inc_elem_count(&htab->map);
+	s64 cnt = this_cpu_inc_return(*htab->map.elem_count);
 
-	if (htab->use_percpu_counter)
-		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
-	else
+	if (!htab->use_percpu_counter)
 		atomic_inc(&htab->count);
+	else if (!(cnt & (PERCPU_COUNTER_BATCH - 1)))
+		atomic_add(PERCPU_COUNTER_BATCH, &htab->count);
 }
 
 static void dec_elem_count(struct bpf_htab *htab)
 {
-	bpf_map_dec_elem_count(&htab->map);
+	s64 cnt = this_cpu_dec_return(*htab->map.elem_count);
 
-	if (htab->use_percpu_counter)
-		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
-	else
+	if (!htab->use_percpu_counter)
 		atomic_dec(&htab->count);
+	else if (!((cnt + 1) & (PERCPU_COUNTER_BATCH - 1)))
+		atomic_sub(PERCPU_COUNTER_BATCH, &htab->count);
 }
 
 static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
@@ -1866,8 +1858,6 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
-	if (htab->use_percpu_counter)
-		percpu_counter_destroy(&htab->pcount);
 	bpf_map_area_free(htab);
 }
 
@@ -2577,9 +2567,7 @@ static u64 htab_map_mem_usage(const struct bpf_map *map)
 	} else {
 #define LLIST_NODE_SZ sizeof(struct llist_node)
 
-		num_entries = htab->use_percpu_counter ?
-					  percpu_counter_sum(&htab->pcount) :
-					  atomic_read(&htab->count);
+		num_entries = bpf_map_sum_elem_count(map);
 		usage += (htab->elem_size + LLIST_NODE_SZ) * num_entries;
 		if (percpu) {
 			usage += (LLIST_NODE_SZ + sizeof(void *)) * num_entries;

base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
-- 
2.53.0-Meta

