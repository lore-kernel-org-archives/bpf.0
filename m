Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502144;
	b=wOvSQFLNUfDsU82aP80O64bCUTF2HyvK8MlVRXZz0hEc1wybkT9EZjHMLPx/ZFrR3SUA
	 q7Tfry7EwASE87Gu9hNjq4+okphWtttvw4LWTUZdL/HCBD/Zq1HWhO2fEIoihZ1s2lE14
	 kYeSikAQLw1C8+VPvQywgitTTDOVhmKz2RH73rKpKo9qf0vY7Pvk2jpuULHDvbt6kHj9J
	 ylheuMu2tatiz4xrHQEaDw6ozC7oVVxlzihbpQFIct6D9YIhmcETy2BNQm5hq6n4Mav/t
	 yUKYDyuAaa1OMF2uewu67oZhWENpqijAYoMbXE7wcjU+RVhPK6cUEghLzbuKBON2WWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502144;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iD1o1sc5rhM8eL2oWcB3VcoUQguaYFm2HuUIhLXHPVo=;
	b=PTanBbxC3436iPdGN1r3ipj6YJKEuLWdLn2hf1y36JwplCcYEwOD2LdMBtTJ2O+ZEtt4
	 OPBvGQe2g9+gsGMAJJXXu5neEGD7dZy77MCukyTLdholrDRHi5dvh09RlTZZXTT+znpHM
	 nsaQnBmthQK6Gc6lLhfJOFxWv/nmlHKj386Uayyyo3oILRusB7DtLNdDVHM7USytQbaVT
	 XNKpl/h4C9xPKHcfT1WEG1cxzrkJdq+2PEC/n5w44aj95D65JP/UoZ1ARnsfmNPmAqhlB
	 6OLZNJgANuY44WgZE7yTqEyueCafrHuPR7oAqjGUWTU+G04BIJ75MJyamnSHtgrJI4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WW64Us1D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96560A2605
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WW64Us1D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6612B1F000C4;
	Tue, 20 Oct 2026 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792502143;
	bh=iD1o1sc5rhM8eL2oWcB3VcoUQguaYFm2HuUIhLXHPVo=;
	h=From:To:Cc:Subject:Date;
	b=WW64Us1DzNBqIX2opFxZ3hEnWCJFsvj+J6uz6LQYAveILnVCkey3a6XsRm7YgNnDg
	 XHgQnfxCx308W/VdcicBEdNc3zOnvSkzeyHwWzG/g9Rl/ZSpC+sdwr91BGiWL7Asyv
	 OTP7XLNtQjxFQx1DGfNI0Aaz69T8Hsz+Lwos0lx58Bg2gu6/aKz22QL+Vn+BolWnzl
	 OK4jCcOJ/Lu9F6ptL4Ov0Wzypr5HVVJsyyrbFp+W0lAoVHbMO8gp28LLP5jPkGs4GG
	 kkcEzWOCznxPiTDZliabfkUK2pYYkr1fIDlwMZiDf/QDe3/Azujmpc3EFE+ZT7OfKX
	 dHb6YLhEz7T7Q==
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
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next] bpf: Don't use percpu_counter for the htab element count in NMI
Date: Tue, 20 Oct 2026 06:15:22 -0700
Message-ID: <20261020131524.207415-1-puranjay@kernel.org>
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

BPF programs attached to perf events run in NMI and can update a
non-preallocated hash map. For large maps the element count is a
percpu_counter, whose slow path takes fbc->lock with
raw_spin_lock_irqsave(). That does not exclude NMIs, so an NMI that
interrupts a holder of the lock and then updates the same map spins on it
forever:

  WARNING: inconsistent lock state
  inconsistent {INITIAL USE} -> {IN-NMI} usage.
  kstress/261 [HC2[2]:SC0[0]:HE0:SE1] takes:
  (key#5){....}-{2:2}, at: _raw_spin_lock_irqsave+0x18/0x30
  {INITIAL USE} state was registered at:
    percpu_counter_add_batch+0xd8/0x160
    alloc_htab_elem+0x408/0x480
    htab_map_update_elem+0x1e8/0x6a0

is_map_full() is affected too, as __percpu_counter_compare() falls back
to percpu_counter_sum(), which takes the same lock.

Count the elements added or removed in NMI in htab->count, which is
otherwise unused for such maps, and add it to the percpu_counter where
that is read. In NMI is_map_full() only reads the percpu_counter, so the
limit is approximate by up to PERCPU_COUNTER_BATCH * num_online_cpus()
there.

Fixes: 86fe28f7692d ("bpf: Optimize element count in non-preallocated hash map.")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/hashtab.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bf78e09f4d518..7a27479c46dc5 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -95,7 +95,8 @@ struct bpf_htab {
 	};
 	struct htab_elem *__percpu *extra_elems;
 	/* number of elements in non-preallocated hashtable are kept
-	 * in either pcount or count
+	 * in either pcount or count; with pcount, those added or removed
+	 * in NMI are in count, see is_map_full()
 	 */
 	struct percpu_counter pcount;
 	atomic_t count;
@@ -1160,11 +1161,23 @@ static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
 	}
 }
 
+/*
+ * With use_percpu_counter the elements added or removed in NMI are counted in
+ * @count, as percpu_counter takes a spinlock that the NMI could have
+ * interrupted the holder of.
+ */
 static bool is_map_full(struct bpf_htab *htab)
 {
-	if (htab->use_percpu_counter)
-		return __percpu_counter_compare(&htab->pcount, htab->map.max_entries,
+	if (htab->use_percpu_counter) {
+		/* percpu_counter_sum() takes that lock, so only read it in NMI */
+		if (in_nmi())
+			return percpu_counter_read(&htab->pcount) +
+			       atomic_read(&htab->count) >= htab->map.max_entries;
+		return __percpu_counter_compare(&htab->pcount,
+						(s64)htab->map.max_entries -
+						atomic_read(&htab->count),
 						PERCPU_COUNTER_BATCH) >= 0;
+	}
 	return atomic_read(&htab->count) >= htab->map.max_entries;
 }
 
@@ -1172,7 +1185,7 @@ static void inc_elem_count(struct bpf_htab *htab)
 {
 	bpf_map_inc_elem_count(&htab->map);
 
-	if (htab->use_percpu_counter)
+	if (htab->use_percpu_counter && !in_nmi())
 		percpu_counter_add_batch(&htab->pcount, 1, PERCPU_COUNTER_BATCH);
 	else
 		atomic_inc(&htab->count);
@@ -1182,7 +1195,7 @@ static void dec_elem_count(struct bpf_htab *htab)
 {
 	bpf_map_dec_elem_count(&htab->map);
 
-	if (htab->use_percpu_counter)
+	if (htab->use_percpu_counter && !in_nmi())
 		percpu_counter_add_batch(&htab->pcount, -1, PERCPU_COUNTER_BATCH);
 	else
 		atomic_dec(&htab->count);
@@ -2578,7 +2591,8 @@ static u64 htab_map_mem_usage(const struct bpf_map *map)
 #define LLIST_NODE_SZ sizeof(struct llist_node)
 
 		num_entries = htab->use_percpu_counter ?
-					  percpu_counter_sum(&htab->pcount) :
+					  percpu_counter_sum(&htab->pcount) +
+					  atomic_read(&htab->count) :
 					  atomic_read(&htab->count);
 		usage += (htab->elem_size + LLIST_NODE_SZ) * num_entries;
 		if (percpu) {

base-commit: b71326388a8a24674846c1d8d3b6dd831d9843a9
-- 
2.53.0-Meta

