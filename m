Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581909;
	b=4qJyOzW6GvaUbAE+Ya4LaH5nBbKnCKtqG5YPFwnmytSaPYpwDoYp0Foy9mgp219QQJvY
	 Np3zaYXItYzlxKSXMh3u4DRP35u1mEPlHYfrJixO4Z9wok1XdaXcSsIO9pxIDqbnLkBmp
	 xHqSWUz8QgguA6DZjL12YJx3RpfQPXvc54WXdPfs3GR81IvpBGLmQlEFr68fixc/VEt59
	 jXThQnD7wTqNmku/0MBPaDLzdBJKKVft30pRS0iWaS/L4F+24fC9ZNi+vuRaYgImGvS8D
	 AM+smBpxfvxTSApq9iNbcqLc9nYijqdV71fG4N8/sfDMazph5U8PlhVNEequcQ7zAxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581909;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status;
	bh=RAG/2ax1ucQUbAiCg/s1Qqe5BmQBfpQgRvDtOVmHwa4=;
	b=BGSVg4XSTJHGPLK6M4f8z9/hnVwxXQMwFy91aXSNjLS7S13KLAyFjpRO+AWCshT1++x7
	 G0lH19GwDTvf08V3zyH4PzH8V8YUyd8IupFsiF8enTJsLzQdJGguYnQ0Ba0utNDxB1B4m
	 jTbSvx6513STcUqKbVaJ3rqYRkIgyZ4+WYUIRtd1o7SMyiCU0aWPVahHFJXQdCxh+RJcC
	 oZ8ChjFb0TDoNnEDddnI9jGelUKy2t4eTLoQ3NvvTNNGC58WQ3xgye31EMFgoELY6lYB0
	 MMGVAOZDGKbarPiewgKuhQulyginh5CyQbgu8+kedyMxbCZ5U7SZdcgjiiEsKOPGtDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=easystack.cn;
	spf=pass smtp.mailfrom=easystack.cn;
	arc=none smtp.remote-ip=103.209.128.28
Received: from mail-m12828.netease.com (mail-m12828.netease.com [103.209.128.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18A606A333;
	Wed, 21 Oct 2026 11:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE18A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 204f151ae;
	Wed, 21 Oct 2026 19:24:56 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH v3 6/7] mm/page_owner: add bpf_page_owner_get_memcg_info() kfunc
Date: Wed, 21 Oct 2026 19:24:36 +0800
Message-Id: <20261021112437.1799213-7-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20261021112437.1799213-1-zhen.ni@easystack.cn>
References: <20261021112437.1799213-1-zhen.ni@easystack.cn>
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
X-HM-Tid: 0aa15e350a610229kunme08c1fd526acf1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSUxJVhpLTBlLHxlJThhMT1YVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

Expose per-page memcg information to BPF programs, so that a bpf_iter
over page_owner can aggregate and filter allocations by memcg.
Attributing an allocation to a specific cgroup needs its full cgroup
path, not just the memcg name.

Split memcg info collection out of print_page_owner_memcg() into
get_page_memcg_info(), which fills struct memcg_info and, when given a
caller-provided buffer, writes the full cgroup path via cgroup_path().
print_page_owner_memcg() now consumes the struct; this introduces no
functional change to the debugfs output.

The helper takes a single READ_ONCE snapshot within one RCU read-side
critical section, so the flags and cgroup path reflect a consistent
view of the page. cgroup_path() returns the path relative to the cgroup
hierarchy root, so memcg attribution works on both cgroup v1 and v2.

Because scan->pfn is selected by a lockless scan, the kfunc re-resolves
it with pfn_to_online_page() under get_online_mems() to avoid accessing
a hot-removed section. If the PFN is offline or removed, the kfunc
returns -ENODATA instead of dereferencing memcg_data.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v3:
- Check the page_owner_inited static key.
- Resolve the page with pfn_to_online_page() under get_online_mems().

Changes in v2:
- bpf_page_owner_get_memcg_info() now resolves the page with
  pfn_to_online_page() for an offline or removed pfn.
- Buffer/info args renamed to info__uninit/buf__uninit/buf__sz.

v2: https://lore.kernel.org/linux-mm/20261013122125.843451-6-zhen.ni@easystack.cn/
v1: https://lore.kernel.org/linux-mm/20261009112308.240769-6-zhen.ni@easystack.cn/
---
 kernel/bpf/helpers.c |  1 +
 mm/page_owner.c      | 85 ++++++++++++++++++++++++++++++++++----------
 mm/page_owner.h      |  9 +++++
 mm/page_owner_iter.c | 48 +++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0ba836f77957..bba9eeb076c3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4954,6 +4954,7 @@ BTF_ID_FLAGS(func, bpf_iter_page_owner_next,
 BTF_ID_FLAGS(func, bpf_iter_page_owner_destroy,
 	     KF_ITER_DESTROY | KF_SLEEPABLE | KF_PERFMON)
 BTF_ID_FLAGS(func, bpf_page_owner_stack_snprint, KF_SLEEPABLE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_page_owner_get_memcg_info, KF_SLEEPABLE | KF_PERFMON)
 #endif
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp, KF_PERFMON);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 8bc15bcdc24e..7470b5d002be 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -538,16 +538,22 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 
 #ifdef CONFIG_MEMCG
 /*
- * Looking for memcg information and print it out
+ * Collect memcg information of @page into @info; when @buf and a
+ * nonzero @size are given, also copy the full cgroup path of the
+ * charged memcg into @buf.
+ *
+ * Return: 0 if @page is charged to an attributable memcg; -ENODATA
+ * otherwise.
  */
-static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
-					 struct page *page)
+int get_page_memcg_info(struct page *page, struct memcg_info *info,
+			char *buf, int size)
 {
 	unsigned long memcg_data;
 	struct obj_cgroup *objcg;
 	struct mem_cgroup *memcg;
-	bool online;
-	char name[80];
+	int ret = -ENODATA;
+
+	*info = (struct memcg_info){};
 
 	rcu_read_lock();
 	memcg_data = READ_ONCE(page->memcg_data);
@@ -555,31 +561,68 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 		goto out_unlock;
 
 	if (memcg_data & MEMCG_DATA_OBJEXTS) {
-		ret += scnprintf(kbuf + ret, count - ret,
-				"Slab cache page\n");
+		info->is_slab = true;
 		goto out_unlock;
 	}
 
 	objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
-	memcg = objcg ? obj_cgroup_memcg(objcg) : NULL;
+	if (!objcg)
+		goto out_unlock;
+
+	memcg = obj_cgroup_memcg(objcg);
 	if (!memcg)
 		goto out_unlock;
 
-	online = css_is_online(&memcg->css);
-	cgroup_name(memcg->css.cgroup, name, sizeof(name));
-	ret += scnprintf(kbuf + ret, count - ret,
-			"Charged %sto %smemcg %s\n",
-			(memcg_data & MEMCG_DATA_KMEM) ? "(via objcg) " : "",
-			online ? "" : "offline ",
-			name);
+	info->is_kmem = (memcg_data & MEMCG_DATA_KMEM) != 0;
+	info->is_online = css_is_online(&memcg->css);
+	cgroup_name(memcg->css.cgroup, info->name, sizeof(info->name));
+
+	if (buf && size)
+		cgroup_path(memcg->css.cgroup, buf, size);
+	ret = 0;
 out_unlock:
 	rcu_read_unlock();
 
+	if (ret < 0 && buf && size)
+		buf[0] = '\0';
+
+	return ret;
+}
+
+/*
+ * Print memcg information from memcg_info
+ */
+static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
+					 const struct memcg_info *info)
+{
+	if (!info)
+		return ret;
+
+	if (info->is_slab)
+		ret += scnprintf(kbuf + ret, count - ret,
+				"Slab cache page\n");
+
+	if (info->name[0])
+		ret += scnprintf(kbuf + ret, count - ret,
+				"Charged %sto %smemcg %s\n",
+				info->is_kmem ? "(via objcg) " : "",
+				info->is_online ? "" : "offline ",
+				info->name);
+
 	return ret;
 }
 #else
+int get_page_memcg_info(struct page *page, struct memcg_info *info,
+			char *buf, int size)
+{
+	*info = (struct memcg_info){};
+	if (buf && size)
+		buf[0] = '\0';
+	return -EOPNOTSUPP;
+}
+
 static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
-					 struct page *page)
+					 const struct memcg_info *info)
 {
 	return ret;
 }
@@ -589,7 +632,8 @@ static ssize_t
 print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		struct page *page, struct page_owner *page_owner,
 		depot_stack_handle_t handle,
-		struct page_owner_filter_state *state)
+		struct page_owner_filter_state *state,
+		const struct memcg_info *memcg_info)
 {
 	int ret, pageblock_mt, page_mt;
 	char *kbuf;
@@ -639,7 +683,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 			migrate_reason_names[page_owner->last_migrate_reason]);
 	}
 
-	ret = print_page_owner_memcg(kbuf, count, ret, page);
+	ret = print_page_owner_memcg(kbuf, count, ret, memcg_info);
 
 	ret += snprintf(kbuf + ret, count - ret, "\n");
 	if (ret >= count)
@@ -822,6 +866,7 @@ static ssize_t
 read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct page_owner_scan scan;
+	struct memcg_info memcg_info;
 	struct page_owner_filter_state *state = file->private_data;
 
 	if (!static_branch_unlikely(&page_owner_inited))
@@ -855,8 +900,10 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		/* Record the next PFN to read in the file offset */
 		*ppos = scan.pfn + 1;
 
+		get_page_memcg_info(page, &memcg_info, NULL, 0);
 		ret = print_page_owner(buf, count, scan.pfn, page,
-				&scan.po_snap, scan.po_snap.handle, state);
+				&scan.po_snap, scan.po_snap.handle, state,
+				&memcg_info);
 		put_online_mems();
 		return ret;
 
diff --git a/mm/page_owner.h b/mm/page_owner.h
index 934bc9f84d6f..65598415af73 100644
--- a/mm/page_owner.h
+++ b/mm/page_owner.h
@@ -41,7 +41,16 @@ struct page_owner_scan {
 	int nid;
 };
 
+struct memcg_info {
+	char name[80];
+	bool is_slab;
+	bool is_kmem;
+	bool is_online;
+};
+
 bool page_owner_next_eligible(struct page_owner_scan *scan);
+int get_page_memcg_info(struct page *page, struct memcg_info *info,
+			char *buf, int size);
 
 /*
  * mm/page_owner_iter.c
diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
index b7e0ce1dfa80..a649e1207e24 100644
--- a/mm/page_owner_iter.c
+++ b/mm/page_owner_iter.c
@@ -181,4 +181,52 @@ __bpf_kfunc int bpf_page_owner_stack_snprint(struct page_owner_scan *scan,
 	return len;
 }
 
+/**
+ * bpf_page_owner_get_memcg_info - Report the memcg charged for the current page
+ * @scan: page_owner scan handle.
+ * @info__uninit: output buffer for the memcg_info.
+ * @buf__uninit: optional output buffer for the full cgroup path.
+ * @buf__sz: size of @buf__uninit.
+ *
+ * Fills @info__uninit with the memcg charged for the page backing
+ * @scan->pfn.  If @buf__uninit and @buf__sz are provided, the full
+ * cgroup path is also copied out, so a BPF program can attribute a
+ * page_owner allocation to a specific cgroup.
+ *
+ * @scan->pfn is resolved to a struct page under get_online_mems(),
+ * so the page cannot be accessed after its memory section is offlined
+ * or removed.
+ *
+ * Returns:
+ * * 0 on success
+ * * -ENODATA if the page is not online or not charged to a memcg
+ * * -EOPNOTSUPP if built without CONFIG_MEMCG
+ */
+__bpf_kfunc int bpf_page_owner_get_memcg_info(struct page_owner_scan *scan,
+					      struct memcg_info *info__uninit,
+					      char *buf__uninit, u32 buf__sz)
+{
+	struct page *page;
+	int ret = -ENODATA;
+
+	if (!static_branch_unlikely(&page_owner_inited))
+		goto nodata;
+
+	get_online_mems();
+	page = pfn_to_online_page(scan->pfn);
+	if (!page) {
+		put_online_mems();
+		goto nodata;
+	}
+	ret = get_page_memcg_info(page, info__uninit, buf__uninit, buf__sz);
+	put_online_mems();
+	return ret;
+
+nodata:
+	*info__uninit = (struct memcg_info){};
+	if (buf__uninit && buf__sz)
+		buf__uninit[0] = '\0';
+	return ret;
+}
+
 __bpf_kfunc_end_defs();
-- 
2.20.1

