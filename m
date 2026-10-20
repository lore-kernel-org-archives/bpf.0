Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508032;
	b=jkgVMcfGCDm+mNxVLHwBXAs1bXhD4gQBIhimfS6nG7oBPoIU2Gnl8CxK6OA02a901DKN
	 WdaCAzpym/9fpFPhWE8IKn3/hT+d0xiNBa7HP8w1q3Bn2YVfZ9eORiH8tEERDJ40J00A8
	 TNp8UioAqUO+Ri1sKKjmsyGrKZeoTxujXFrtmrkqvAx/l84JSPlg7D4AqyhvambKcKAe/
	 Qbm7G90t8jpGMWEhuNHNDbQDH0aDPy+8dV3JfWP3eTd6Jz47rlqVUcvAMfilLebKHDaiA
	 rQeu5jmjtLOmiqhmif6Zs/7c2RWY9LGErH29drchlH4IHavAjAP9NePq96I1BJZOGEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=YGJkwuAQVui1/Jg+z86tucVHMncYssoK2NeouG7g/NE=;
	b=Ro2WEcx+xGf+cELnlrEfrG5zD8GKelgtE1AL2ePaBnF5bsDgP5/VXuz4F52HCYremy6e
	 mYigCzJYFNlJ79QfUGbrXeGwMwv6r8EDQTNeDBdHs8x8CjZNuN9HHkYzg2uQWXhK88d0b
	 pIKj8/2vrl9qcvKfkJsuKwqOxDLXVxgQBu22ZL8Y8BporbqVYRDTbuyabYDdPJLUNIOLz
	 5DWjRYz9QaP1Ez+TrZJUvw2z+HsRZiLHP321neUSEWgqTFVy9KflBOhfd+E6x4sgB/XMb
	 UXHbSkcyZ9lDcIQTv5O0lzpQQ/eYVH2gBd4ejhTz01CPDFk+GObL0i8IXdOHbuqm7MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FYvzzuik;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471AD606A31D
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 471AD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FYvzzuik
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so2856334a91.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508031; x=1793112831; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YGJkwuAQVui1/Jg+z86tucVHMncYssoK2NeouG7g/NE=;
        b=FYvzzuikMI0ctTzO2OoDheTJx59hbURCkIyZsLGJ2aTGehl8CjXR5F33N8CBn9t6c3
         NoG8Lg9EiG2uyD8zltmuDqiMEF6eNqWrIV0+jx0xs8Yf5/27Zh+nerarJWQMjM7d6IBe
         g9JbiRC7skhRbpwywwdkBORKfqyxSdzFOb1L+1kmEoU5xxyTMszsNEQ42XT9US+3Vt57
         O5k8gx+AxdT9TiDfiEL3XAy6mab4IRfzUK5A5F86N9eYGSec/UIZj/Z0K1X3EaFLI/wy
         vP2orCcResCNZqsUP99NgCrYU+RP8pe3r5hfearYKZmMor9rk2wuCSQTu3txLbPYi0R8
         hkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508032; x=1793112832;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YGJkwuAQVui1/Jg+z86tucVHMncYssoK2NeouG7g/NE=;
        b=2xwkeTlkh5qAw1Kga/nRzT4KRn66aYFWyFNTz+P+UagnoJT3ch7gE/zhwcPHgNr2HW
         2uGYReISPygTsCeDEYuue4788F3kEnZjQHsZ5b+xtbMC9JjjB7LBNlckyyM1e/gxyw2K
         4Q4KOatoVIrwbQzH6Efy3bOyRugHF4+B3u6gY2OFi2EgcXeJFhg0fiLwSSzy9ObD8JFD
         Zzc01m7vYD0vh0g1nBWYPRLlCERV/o+GRLMKcvZ0lmcsk3Fy6hhs82xvfg84hvRswf3R
         hoon2qWZ07V3E2OAWOWZ/6BL6fTeUR3R+o+Q8JhXlFLZme2nLTMtuOp7uirNDeTw/V1Y
         5DzA==
X-Forwarded-Encrypted: i=1; AKwUvBxOlkh7ICFAKwxq10szT8aJKOhrPvvRaK6GcA/bxGsjSnOueJDsgO44jukFpLbE/FnMtFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJQELWX3pjfTUMMogKHCP6EnSL2QmJpQG6IfHTlBrjS7bHdlR/
	56rj+wGsG/UnlAqxDUAQr7kf8jpk3HI4nW2ZoVh+vAvQU1EHePIm4V3a
X-Gm-Gg: AYBFou20s3bSFlNBaO4cMkhBiWihopmCSYYujbJl6SA4JCWfZaRpzOshCjXjoVD6INw
	jEue7KMt/Y/QKu9BqOh+5VzrPnE0fLSWt6K6FxYLaPETuOx+435PMCqO2cSuCIQdO6tGoO7lajm
	HjkrcXIJfxTM0QOW4X/gEzLCi0WGi+K9Llx8vhJQSyWMqFccz4xN5tOZ1obKD7SQguKkVBxLSin
	mV0ICtBI4QLKz0QopB6ydqJz4eBkkkYxGOY+ZTbYMeMjSPMeWaCmnFDHyOuRmQbVOedrI55n5TW
	A1MGv/qflkubGzOxKpty/ziHpnIO8+PHN3PhWKdvmPGfnXJKbj20wsUInSXF9D2BWy/seZFycZh
	xHupkBwQeJWwYIUnGVj1VTC+pRgQO9Pb28befut6NL/cQx7uE38IBS6zSo1ypDcP9+8xkINk8N+
	50LM3j9+rDue0+Qp5kBIKR/Qfza3ODgtArAD7sxSXcABiUJSfU+2PrU0Ezc1+qZcdyoIxIB4qiD
	GOpq1/C70C0Gd/nozrV2s1NQ4/GWtem1mQtOXmMSD136zc1XkJZWUnvcUcfLt+v1HpJdC+JVrue
	EsXh
X-Received: by 2002:a17:90b:4d0a:b0:3ab:884b:65b4 with SMTP id 98e67ed59e1d1-3acef521f53mr9899280a91.59.1792508031375;
        Tue, 20 Oct 2026 07:53:51 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9e47588sm11338921a91.1.2026.10.20.07.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 07:53:50 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 14:53:49 +0000
Message-Id: <DM9R2CURM0WN.2FT8Z1Y21S8MA@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: Don't use percpu_counter for the htab
 element count in NMI
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261020131524.207415-1-puranjay@kernel.org>
References: <20261020131524.207415-1-puranjay@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 06:15 AM Puranjay Mohan <puranjay@kernel.org> wrote:
> Count the elements added or removed in NMI in htab->count, which is
> otherwise unused for such maps, and add it to the percpu_counter where
> that is read. In NMI is_map_full() only reads the percpu_counter, so the
> limit is approximate by up to PERCPU_COUNTER_BATCH * num_online_cpus()
> there.

Not only NMI. queued_spin_lock_slowpath() calls trace_contention_end()
with the lock already held. When percpu_counter_add_batch() contends on
fbc->lock, a tp_btf/contention_end prog that updates the same map sees
the same this_cpu counter, goes to the slow path too and spins on
fbc->lock that its own cpu holds. in_nmi() is false there.

can we drop percpu_counter from htab instead ?
map.elem_count is already a lockless per-cpu count of the same elements.
htab->count can follow it in steps of the batch and is_map_full() can
sum elem_count when it gets close to max_entries. That is exact in NMI
as well. Then no need for pcount, in_nmi() checks and adding up two
counters.

Something like this (compile tested only):

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7750df9..b298b89 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3041,6 +3041,8 @@ static inline void bpf_map_dec_elem_count(struct bpf_map *map)
 	this_cpu_dec(*map->elem_count);
 }

+s64 bpf_map_sum_elem_count(const struct bpf_map *map);
+
 extern int sysctl_unprivileged_bpf_disabled;

 bool bpf_token_capable(const struct bpf_token *token, int cap);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bf78e09..6e21154 100644
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

pw-bot: cr
