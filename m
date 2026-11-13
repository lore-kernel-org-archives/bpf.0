Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611330;
	b=S31YRmrWqDYgEyulbLBwoEpN9JavtSLQlmTjSsQssLXXgYMuQ4GTMLBBV+uURcRWW+qV
	 XqdMzgvl4HaHrWW/q1ykjW5i7Wqm30jrKdBlft3BiyWWHagYrUmQ4nIISJu2Ikb5XmjBC
	 ZC8W9koUN62NUMHXfmJDzPcL6dftBg9Zm8kHhsUmmC5GwJHRo4iDyOCotHdMt23c/7KDy
	 eY2r25yf6+yGwan/pnW/C3Hw+eDJ7xi3rUMRGJg4YwocH5IdFLaDZ3VWXmptPW5J1kzja
	 +Uh5ooTVfPvMnyqmBxX+Tk1X7SQTwDsk8h5uz/q0kwVAs7f46hTjqix76UwDwu5sKpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zmhVbg8kO6b322leeVZLfYhoQCZjenCwnvUFKRAPkM0=;
	b=kSnClJ/5KMsfX5WO6uSq+iFentVQouciOeAbgHXXPLia2L+55TMyrENRVHpFAebxMZec
	 itxqiFem3n8TnGOd4SVDTCk8kKZHO08W+6+b3sUN31RsS+SPJursrklX8LRKdpk6gykVR
	 l6aCs8xVUX5ED63bvDYm+w7vD9akoBKrtrQmPvM+zsXSkqehTgYqZl0RE3gikwuo+qP2o
	 3E022LY68CdXtqQaSHnEfZjrVcQMT3hKXMmPsSuVYqK96Nw+8Qv6kXEwI5bRaOYEYiZzf
	 r2yC7xPymNPa0P5v+LE+L5yfrK0SriQX25Pxr53u2uVQwDM2Fsm0Lk4SxqC+lswMFNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5ksALmE;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947D606A327
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0947D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5ksALmE
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67c6a0abc2eso1790369d50.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611329; x=1795216129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmhVbg8kO6b322leeVZLfYhoQCZjenCwnvUFKRAPkM0=;
        b=f5ksALmEb3m1Wsqjwpf4w8IgYUEcinsskHamDSh5T/8KC2O8sjmcOD6CGAEsgkUXiK
         W067r40HQT7mXhV6xP64zwqoi6+FJafBkrf2hVaWDsdaW3Iib554PLFSdlerOfM4RpzH
         jHS0GZ6KQ6xyCabefCW6BK0o1PqJpLPLHwBBSpgc+KHRzeFHGdEZ8nla+Y7Zn3WJRc7K
         6slzHNd27uiXqAgQi5EYSWUBcrz1sz/LGDftr5zrAPDjayHzKOarNk4KY8lrj2P1vw2b
         Zylc+RILESyZHfLO54stWEk41aWI8vw2upYjB8RxV7dr35aMzGRFbCgqjg8amCOA0yUi
         UEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611329; x=1795216129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmhVbg8kO6b322leeVZLfYhoQCZjenCwnvUFKRAPkM0=;
        b=KV+RYkcO8cWuQLbwbN8e7zSp3j3aAV21m0W2LJnXXQ/KV7CovEy9iMmhe+AIlazE04
         5mkkO2u0E7oMTnVZfjVz2GUC7EXrRYiDrtZaASxb23pYa1X8UHbQ41kjBFD1GWX5X7Wr
         Is1UInN0OKK047FL+bc/eYeylR8jSVncfnIFW8fZ5/7+4847ms+Ggc0VaqkRrQgYq6Ng
         952zWaSbpmEo4OUpQVt/j8jn/Go7zNVA6F1DMjFe4eVWmRMY+aYhj+XR6hCLRHJs9y0L
         qpzKTbaJZ0yhUW87Bxpq+wj4+X1cIhWobjd2qJh1NYcXR5AxsYq/iqvXzSSAzKonghZU
         4hnw==
X-Gm-Message-State: APuU4Z8gY0DvA4syaqpotkOCkGijGF3t5THxJlBzLnrra3CPU2uVMWug
	/nTuSFMUZFfP7xBPGrt7HQGAzVo5exZGHQ2IOGK+9Uuogad0Q9xSGCNf
X-Gm-Gg: AYBFou1nYmXdXFQmA9HYqnrdO7xxbZhuxbwaGKvQlDvRwSGlzJ1+CrXC7ZL/YyZtxX7
	mTH9HRxdy63g2/3joycaCeXmgq3OCDkc5Za307JBzZgr+QtzgmANB+0p0W7UXKAPBrOJNpmsQib
	9p0y6o2m62qcEoE0MBI/gHQ0RsetMKQaNWxshskqCD87LEwtsWFHgF0Ks7qVlEedahP8fmm828z
	NrwYfrfNHf0bktZpXGRAvNV2CB9gW4H5u3WmwScImPeGgEcfYoUrRJuqqMmPbMl5BatKuHjdA5q
	4Lx6q6Hnh3qa80bsZ0Z3f35jByKqvDyPieVHdsED1yo/Z8g+MMCDObMvsF0vtyzPxXjZDm740mL
	ga5QtEZAi7Ie98vpS8EdPJTJX0TPGBEcC2axAhH9O5CUhTKDPf7BpBHNMj/kdz0jd2B5SFgpRvv
	2TIh+bmenrlt7kpIvEUqwsz9ISlRPPnsff4hqJHs6iWfTld/pkUVrtBCCQgPINukIgFimTjbDCU
	DaMvQc2Emg2kx540oqSwrzbu6mQvmaLcEN1dIlukMVYSJ6umm16hEVJIh3fuvGwCf2ZmO9OVF+O
	0I0aK6Kf1FVECEwpd+w=
X-Received: by 2002:a05:690e:1909:b0:67c:1218:f0d2 with SMTP id 956f58d0204a3-67d8935dd80mr2110233d50.4.1794611328980;
        Fri, 13 Nov 2026 15:08:48 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a59f1afsm3291800d50.9.2026.11.13.15.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:08:48 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:27 -0800
Subject: [PATCH RFC bpf-next 04/13] bpf: Add an inline slot allocator to
 local storage caches
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-sls_f1-v1-4-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=7997;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=z25ekEdU9SAhzceYZtVyxDzBuDDRJ3SLRKDVlfLTUtM=;
 b=BUcC9K+PXUt2uWV3gdb7ggN0et/1nRIgSoItgRcVlypmpRGKgwYFOqDKNuipGVnKlI8MB7Bos
 9wGZJjj3zvrApvA20MycQr7TE5tBnL91tzZ07Y/I79ksJSARiN/CW2h
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

BPF_F_INLINE_VALUE maps will keep their values in the storage object, so
that a lookup needs no selem. Each owner type has one layout of slots for
all its objects. A table of the live inline maps holds the layout. Fail
map create with -ENOSPC if the area has no room, or if the owner type has
16 inline maps: a small table keeps the scans cheap.

The claim is in map_alloc(), with the other resources of the map, so
map_free() gives the slot back on every path. Thus -ENOSPC can come
before -EINVAL for special fields or bad BTF, and before the LSM hook. A
create that fails later holds a slot for a short time.

Old objects keep the bytes of a freed map. Each claim gets a new number.
A later patch makes the slot tag from it, so that a new map rarely sees
these bytes as its values.

The flag is not in the UAPI and not allowed yet: a later patch does that.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf_local_storage.h |  31 ++++++++++
 kernel/bpf/bpf_local_storage.c    | 119 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index ba8de9f5ec33..f8e4e47b47c6 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -51,9 +51,17 @@ struct bpf_local_storage_map {
 	 * multiple buckets to improve contention.
 	 */
 	struct bpf_local_storage_map_bucket *buckets;
+	struct bpf_local_storage_cache *cache;
 	u32 bucket_log;
 	u16 elem_size;
 	u16 cache_idx;
+	/*
+	 * Byte offset of the inline slot of a BPF_F_INLINE_VALUE map from the
+	 * start of the storage object, and the end of the slot. 0: no slot.
+	 */
+	u16 inline_off;
+	u16 inline_end;
+	u32 inline_claim;	/* Claim number of the slot, the source of its tag */
 };
 
 struct bpf_local_storage_data {
@@ -133,9 +141,32 @@ bpf_local_storage_unpin_owner(struct bpf_local_storage *local_storage)
 
 #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
 
+/*
+ * The inline area of a storage object goes from the end of the struct to
+ * at most 1 KB. A slot is an 8 byte tag, then the value.
+ */
+#define BPF_LOCAL_STORAGE_INLINE_MAX	1024
+#define BPF_LOCAL_STORAGE_INLINE_START	ALIGN(sizeof(struct bpf_local_storage), 8)
+/*
+ * Inline maps per owner type. The same as the cache size on purpose: more
+ * maps than that share cache[] entries, so they gain less from a slot.
+ */
+#define BPF_LOCAL_STORAGE_INLINE_MAPS	16
+
+/* A later patch adds this flag to the UAPI and allows it */
+#define BPF_F_INLINE_VALUE		BIT(20)
+
 struct bpf_local_storage_cache {
 	spinlock_t idx_lock;
 	u64 idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
+	/*
+	 * The live inline maps, NULL if free. Few entries keep the scans in
+	 * map create and sk diag cheap. Written under idx_lock.
+	 */
+	struct bpf_local_storage_map __rcu *inline_maps[BPF_LOCAL_STORAGE_INLINE_MAPS];
+	/* Largest slot end in inline_maps[], so new objects read no map */
+	u32 inline_end;
+	u32 inline_claims;	/* Number of claims, the source of slot tags */
 };
 
 #define DEFINE_BPF_STORAGE_CACHE(name)				\
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 2d2a627360fe..eed6f18bf52a 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -759,6 +759,110 @@ static void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cac
 	spin_unlock(&cache->idx_lock);
 }
 
+static struct bpf_local_storage_map *
+inline_map(struct bpf_local_storage_cache *cache, u32 i)
+{
+	return rcu_dereference_protected(cache->inline_maps[i],
+					 lockdep_is_held(&cache->idx_lock));
+}
+
+/* A live slot that overlaps [off, end), or NULL */
+static struct bpf_local_storage_map *
+inline_overlap(struct bpf_local_storage_cache *cache, u32 off, u32 end)
+{
+	struct bpf_local_storage_map *m;
+	u32 i;
+
+	for (i = 0; i < BPF_LOCAL_STORAGE_INLINE_MAPS; i++) {
+		m = inline_map(cache, i);
+		if (m && off < m->inline_end && m->inline_off < end)
+			return m;
+	}
+	return NULL;
+}
+
+/*
+ * First fit. Slots are not sorted: scan again after each overlap. An overlap
+ * ends after off, so off grows and the loop ends. 0: no room.
+ */
+static u32 bpf_local_storage_inline_fit(struct bpf_local_storage_cache *cache,
+					u32 size)
+{
+	u32 off = BPF_LOCAL_STORAGE_INLINE_START;
+	struct bpf_local_storage_map *m;
+
+	while (off + size <= BPF_LOCAL_STORAGE_INLINE_MAX) {
+		m = inline_overlap(cache, off, off + size);
+		if (!m)
+			return off;
+		off = m->inline_end;
+	}
+	return 0;
+}
+
+/* A slot is an 8 byte tag, then the value, 8 byte aligned */
+static u32 bpf_local_storage_slot_size(u32 value_size)
+{
+	return 8 + round_up(value_size, 8);
+}
+
+/*
+ * Claim a table entry and the first free range for the slot of smap. Old
+ * objects keep the tag and value bytes of a freed map. A new claim number
+ * gives a tag that does not match old tags until the counter wraps, and
+ * rarely matches old value bytes. A program can write a match on purpose,
+ * but that needs CAP_BPF or a BPF token. This is memory safe: no pointer is
+ * read from a slot.
+ */
+static int bpf_local_storage_inline_get(struct bpf_local_storage_map *smap)
+{
+	struct bpf_local_storage_cache *cache = smap->cache;
+	u32 size = bpf_local_storage_slot_size(smap->map.value_size);
+	u32 i, off;
+
+	guard(spinlock)(&cache->idx_lock);
+	for (i = 0; i < BPF_LOCAL_STORAGE_INLINE_MAPS; i++)
+		if (!inline_map(cache, i))
+			break;
+	if (i == BPF_LOCAL_STORAGE_INLINE_MAPS)
+		return -ENOSPC;
+
+	off = bpf_local_storage_inline_fit(cache, size);
+	if (!off)
+		return -ENOSPC;
+
+	/* Never 0, so that no claim number reads as unset */
+	cache->inline_claims = cache->inline_claims + 1 ?: 1;
+	smap->inline_claim = cache->inline_claims;
+	smap->inline_off = off;
+	smap->inline_end = off + size;
+	WRITE_ONCE(cache->inline_end, max(cache->inline_end, smap->inline_end));
+	rcu_assign_pointer(cache->inline_maps[i], smap);
+	return 0;
+}
+
+/* Clear the entry before map free waits for RCU readers of inline_maps[] */
+static void bpf_local_storage_inline_free(struct bpf_local_storage_map *smap)
+{
+	struct bpf_local_storage_cache *cache = smap->cache;
+	struct bpf_local_storage_map *m;
+	bool found = false;
+	u32 i, end = 0;
+
+	guard(spinlock)(&cache->idx_lock);
+	for (i = 0; i < BPF_LOCAL_STORAGE_INLINE_MAPS; i++) {
+		m = inline_map(cache, i);
+		if (m == smap) {
+			RCU_INIT_POINTER(cache->inline_maps[i], NULL);
+			found = true;
+		} else if (m) {
+			end = max(end, m->inline_end);
+		}
+	}
+	WRITE_ONCE(cache->inline_end, end);
+	WARN_ON_ONCE(!found);
+}
+
 int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
@@ -863,6 +967,19 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
 	smap->elem_size = offsetof(struct bpf_local_storage_elem,
 				   sdata.data[attr->value_size]);
 
+	smap->cache = cache;
+	/*
+	 * Only map create calls map_alloc(). The kernel's copy of an inner map
+	 * template holds no slot, but the map given as inner_map_fd holds one
+	 * until it is freed. map_free() gives the slot back, also when a later
+	 * step of map create fails.
+	 */
+	if (attr->map_flags & BPF_F_INLINE_VALUE) {
+		err = bpf_local_storage_inline_get(smap);
+		if (err)
+			goto free_smap;
+	}
+
 	smap->cache_idx = bpf_local_storage_cache_idx_get(cache);
 	return &smap->map;
 
@@ -882,6 +999,8 @@ void bpf_local_storage_map_free(struct bpf_map *map,
 
 	smap = (struct bpf_local_storage_map *)map;
 	bpf_local_storage_cache_idx_free(cache, smap->cache_idx);
+	if (smap->inline_off)
+		bpf_local_storage_inline_free(smap);
 
 	/* Note that this map might be concurrently cloned from
 	 * bpf_sk_storage_clone. Wait for any existing bpf_sk_storage_clone

-- 
2.53.1-Meta

