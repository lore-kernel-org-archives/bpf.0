Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500246;
	b=FSPIGs6wmbBekj7EFsuOfZ744oBDvvrH+RoXFOxtGoNIH2cx28bVmVUVb+8SDSieKRvD
	 XttzoZkhjh05DxIiwqxVkDD2RXLvGMAxuNqB5nBcERuxQMs3Cr8sOEljUNhFGHc5OG4K9
	 FtJS1aVBXgqvYoEBfC4fK2g6XzT3xA09UkYqnOq5PKKVl9JuEdUW6BiSe3b601WU3Mup2
	 JMmUW0Gqc2stInpfMZGcvvvgwbLHmlqnn7KmpoWGSVFbs/QrUtwgzsm9LgztdPONn55L4
	 /DNwRCf3wszYAQqgHlpIAf6ePQk2aDrKHG+YiI7iPkYCRUb/v0xu5oAkSz4NNYlQypg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mKVi9kkinGrC0GwX38fwgO2rx45odsYgJrguZKyDEsg=;
	b=jOx9W3yZbjtA2PKeG1/Q9VwlswLq3wagC0xYG8T+0rvoOddAJPJ7Lquukd6pu3YucDw5
	 rF7SNGp0aOoowLtwWvPGFCEKH1XHIfTXgvv/6u+BlisxvFVF5Wx3Y9BfjQgYZP4ykGMsU
	 NjsB5vtsqu2NI0fSJYDdRQQnOwLZ3KmaKMJbplo4f9Gzk9XLYOspwoHTAQ7PsB0NARwYu
	 8cHto1mGlyO+3ojgL2Pufx/JqtRXoCZXNxrVT178pmWo/85GW7gjDQPYUK+mUofs56r7t
	 6thlf9WBj0mr1NqSB+OQvmBHeEA+i55zx+8dZY8IiB6m/MwEYKtSRo/oqWM2Ekv+5/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b="JV8YI/oG";
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B2606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 384B2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=JV8YI/oG
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9ae391a05so27480245ad.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1795500245; x=1796105045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mKVi9kkinGrC0GwX38fwgO2rx45odsYgJrguZKyDEsg=;
        b=JV8YI/oGhRXO2Y4Rp6KvS0QDMqEZv8p1kLduMqBJ4tl/PrjaxwcrOq+aXebD2L6ppr
         J2unfnx12XV4+/sIN8qvZgIgJ+XECitZ0ZxEZmectMlZNjF5ERul4mQDX04AxQJPVSWI
         eUTntruKQITxxADGyqFUbJ3/WioJiyEYaC2/yZ6y0wZggPGdewYX26lpedte/ImRB1ht
         VsroI3040uQEIAxV7PaIqChL1zQksVAw3v3j/G38BQ+kgSBEI70utIeNWBK76z8spvA7
         3LcpFyKnLh++E64lH0vKnh9Cp06bjbxpdB3kdW8aSl9R5HNRX1bsm9OlchEgrOukV5HE
         vtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500245; x=1796105045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mKVi9kkinGrC0GwX38fwgO2rx45odsYgJrguZKyDEsg=;
        b=TXqxCfKKNPpCs5GkM/Bdim9q+B4IojrL3fCrSRDVy8N1VwqOoLIkSfkhIVvU8lfOoQ
         2WgLJlrJjHnXbLVLdEKcly6MUXHGr8xyv59eO58quSJGdv4SFQYCoPFb1tXE9n1yBTld
         hUPs8yl8VGCGewZbLMJazfqKT/bfq07OFRh+FHQzmA5QyokLbhvupwDz6+Bb/NdbfzoF
         wYZaeAoMVXH8hUvyGgiP6txbSbCJx0wa90TSuC95+CLqExCP0xIvC0K5FfeODVm/R4op
         oHXC32PiMenViNjd3Tzh+gbZWobqKpSapplESDx67EL5MyJNxiB262nW6VRqQ7YykL12
         S7Gg==
X-Gm-Message-State: APuU4Z8ihFwhL6+lXLnO5E1+hMHJn+hsr4I2gJHZckrMNSKqwSmRFO44
	7fPqAO3uYFuCCVF3npmL7zvt4Y+7uXzRRJ96Vy/cp+QzU8Z1Sjy3lCsJLRCUj6F+HrvuXwNhGRU
	JzsUPhr0=
X-Gm-Gg: AZFdTZcoj/7el9scWBaOkauVBXGFyYjWrtB8rLhmsQ8mMQ2YW9QUxUXkjhpL6ENR/bf
	+LTiAgOwe6NDdsugMhDOkGpe8W7FV6zwvWOs9DzJy05/yL6N8K1Wid9TjqqIowmJsiwhNEHxn9D
	znLAJqRdDq4E7YjGW1wlYjO94od0YEm3K3H28VYpUig15IP615JFQ3CAN6EThLBEFfX8bS2oQ9m
	fJgtz9FUTNfFN1xx2B06vfOTzhhaLX7mdsirx4wdz2gLkDRujjRW2DHtl9Rc8n21h+DCLqCUVAe
	R9uJakOU3OQbGRW3z9yObPFKoC+48oG0SQdeGoK6b+m4+Cwd2+SydJE1Ouww2v7/sz45VIgktHH
	NZ5QdYX2Guos1Zd0tGN+yxMjQzC3hKA7AFveKBBO657V4jLPtkZPM92VMwymqElRpEYIBGOKKOe
	rs8/xR9dSXibIOaDd8dxzy6vGuQrSKsqtQDIAdqsaUGr7OQKTzKH1xiogFqcoBthS+Csm9UWb3F
	JsAYN577IIP/LcE4dlqs030gJ4c3uL3LCl0aG/5yhe8FVoKdsxbo+gS/1e3V83GQb10pkA/IeLK
	EgrUQYduZx/Adop7ZcJKAyn90d4YjCBg956E7yRJf4DbC+NPxmw9S/NrnJGl11x3zWCzTK17XEU
	6P/khenJCT/23NNyE6VNz4WEArYU=
X-Received: by 2002:a17:903:240d:b0:2f0:446a:dd3 with SMTP id d9443c01a7336-2f0446a123bmr88002535ad.37.1795500245479;
        Mon, 23 Nov 2026 22:04:05 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42a6sm64215985ad.23.2026.11.23.22.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:04:05 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or kmalloc_nolock at call time
Date: Tue, 24 Nov 2026 06:03:54 +0000
Message-ID: <20261124060357.11700-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124060357.11700-1-emil@etsalapatis.com>
References: <20261124060357.11700-1-emil@etsalapatis.com>
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

Certain parts of the BPF runtime like task-locl storage call
kmalloc_nolock by default, even when the context within which
they are called could use regular (nonsleepable) kmalloc. Add
a helper for determining whether we can try to satisfy the
allocation with a regular kmalloc, and make a call to kmalloc
with GFP_NOWAIT when possible before resorting to kmalloc_nolock.

Spinning on the lock instead of only doing kmalloc_nolock avoids
unnecessary allocation failures. Using trylock instead of committing
to spinning during allocation risks failures under contention in the
critical path. Normally, kmalloc_nolock falls back to ZONE_DMA32 that
is in practice never contended, but the zone may be below the low
watermark and fail to allocate. This is the case, e.g., in systems with
a large amount of hugepages in use (hugepages also allocate form
ZONE_DMA32 when necessary, lowering it to below the watermark).

Make both calls in succession to maximize the possibility of success.
kmalloc_nolock() tries buckets larger than the requested size's
when necesary, which kmalloc() does not. The two calls are therefore
complementary, and we cannot call just kmalloc() when it is available.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf.h            |  3 +++
 kernel/bpf/bpf_local_storage.c |  6 ++----
 kernel/bpf/syscall.c           | 27 +++++++++++++++++++++++++--
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a5ad08b7937c7..5565a735ae7ce 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3037,6 +3037,9 @@ struct page *bpf_alloc_page(int nid, bool sleepable);
 int bpf_alloc_pages(int nid, unsigned long nr_pages,
 		    struct llist_head *pages, bool sleepable);
 void bpf_free_pages(struct llist_head *pages);
+
+void *bpf_map_kmalloc_maylock(const struct bpf_map *map, size_t size, gfp_t flags);
+
 #ifdef CONFIG_MEMCG
 void bpf_map_memcg_enter(const struct bpf_map *map, struct mem_cgroup **old_memcg,
 			 struct mem_cgroup **new_memcg);
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b12fcec47ffa0..bd79754a1e2fd 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -75,8 +75,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	if (mem_charge(smap, owner, smap->elem_size))
 		return NULL;
 
-	selem = bpf_map_kmalloc_nolock(&smap->map, smap->elem_size,
-				       __GFP_ZERO, NUMA_NO_NODE);
+	selem = bpf_map_kmalloc_maylock(&smap->map, smap->elem_size, __GFP_ZERO);
 
 	if (selem) {
 		RCU_INIT_POINTER(SDATA(selem)->smap, smap);
@@ -512,8 +511,7 @@ int bpf_local_storage_alloc(void *owner,
 	if (err)
 		return err;
 
-	storage = bpf_map_kmalloc_nolock(&smap->map, sizeof(*storage),
-					 __GFP_ZERO, NUMA_NO_NODE);
+	storage = bpf_map_kmalloc_maylock(&smap->map, sizeof(*storage), __GFP_ZERO);
 	if (!storage) {
 		err = -ENOMEM;
 		goto uncharge;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ec8e787929112..4c72b05e11eb0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -597,15 +597,38 @@ static void bpf_map_release_memcg(struct bpf_map *map)
 }
 #endif
 
-static bool can_alloc_pages(void)
+static bool can_spin_in_alloc(void)
 {
 	return preempt_count() == 0 && !irqs_disabled() &&
 		!IS_ENABLED(CONFIG_PREEMPT_RT);
 }
 
+void *bpf_map_kmalloc_maylock(const struct bpf_map *map, size_t size, gfp_t flags)
+{
+	const gfp_t nolock_flags = __GFP_ACCOUNT | __GFP_ZERO |
+				   __GFP_NOWARN | __GFP_NOMEMALLOC;
+	struct mem_cgroup *memcg, *old_memcg;
+	void *ptr = NULL;
+
+	bpf_map_memcg_enter(map, &old_memcg, &memcg);
+	if (IS_ENABLED(CONFIG_MEMCG))
+		flags |= __GFP_ACCOUNT;
+
+	/* Only try the spinning allocation when preemption disables are tracked. */
+	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && can_spin_in_alloc() &&
+	    size <= KMALLOC_MAX_CACHE_SIZE && !(flags & ~nolock_flags))
+		ptr = kmalloc(size, flags | GFP_NOWAIT | __GFP_NOMEMALLOC);
+	/* Allocation failed or kmalloc_nolock()-only context. */
+	if (!ptr)
+		ptr = kmalloc_nolock(size, flags, NUMA_NO_NODE);
+
+	bpf_map_memcg_exit(old_memcg, memcg);
+	return ptr;
+}
+
 struct page *bpf_alloc_page(int nid, bool sleepable)
 {
-	if (!sleepable || !can_alloc_pages())
+	if (!sleepable || !can_spin_in_alloc())
 		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
 
 	return alloc_pages_node(nid,
-- 
2.52.1

