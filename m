Received: from mail-m12771.qiye.163.com (mail-m12771.qiye.163.com [115.236.127.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E61C862D;
	Tue, 13 Oct 2026 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894434; cv=none; b=e2s7kf0/oF17BvH0ux3n/tccTkzZ2n15wMDWGQ8unaQpdWK8TCZmTYLkixVLfJgi2512qGFdgJOI7uO5DKGInK7Pa/khEOxE7vXXETqW8ysByUwWVQ7R0x7WzBHnk4CL08NIJzjDB6G875KOFjQJouEjwma8NyMgbr4qsp5oa5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894434; c=relaxed/simple;
	bh=oGizXLmAbHK358rrzqWiKl5cjObXT+rLfAa/eHdkbeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ju6Hbc5Jjm2NX8PNuyTUrR39eF/77A1CbXGPwkPYn2kPq5u6PUr2iZ2W0rWwM9SmCL1tI6eJfYgI2zfsSynlhBsUSPalik3J1wXtRzxcvSEsKIZ4MPLMh2dImi+/v3eHC7QAFo8pcuKTKmV6EVZmNZUrlAlT10bbR3Z+KD9mtjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=115.236.127.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 200407ef2;
	Tue, 13 Oct 2026 20:21:49 +0800 (GMT+08:00)
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
Subject: [PATCH v2 5/6] mm/page_owner: add bpf_page_owner_get_memcg_info() kfunc
Date: Tue, 13 Oct 2026 20:21:24 +0800
Message-Id: <20261013122125.843451-6-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20261013122125.843451-1-zhen.ni@easystack.cn>
References: <20261013122125.843451-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa135363c650229kunm0bc94a6a5264
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHxoaVkxMTR1DSR4aHktCSFYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

Expose per-page memcg information to BPF programs, so that a bpf_iter
over page_owner can aggregate and filter allocations by memcg.
Attributing an allocation to a specific cgroup needs its full cgroup
path, not just the memcg name.

Split memcg info collection out of print_page_owner_memcg() into
get_page_memcg_info(), which fills struct memcg_info and, when given
a caller-provided buffer, writes the full cgroup path via
cgroup_path(). print_page_owner_memcg() now consumes the struct;
this introduces no functional change to the debugfs output.

The helper takes a single READ_ONCE snapshot within one RCU read-side
critical section, so the flags and cgroup path reflect a consistent
view of the page. cgroup_path() returns the path relative to the
cgroup hierarchy root, so memcg attribution works on both cgroup v1
and v2.

The kfunc gets the page via pfn_to_online_page(), so an offline or
removed pfn yields -ENODATA instead of a stale deref.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v2:
- bpf_page_owner_get_memcg_info() now resolves the page with
  pfn_to_online_page() for an offline or removed pfn.
- Buffer/info args renamed to info__uninit/buf__uninit/buf__sz.

v1: https://lore.kernel.org/linux-mm/20261009112308.240769-6-zhen.ni@easystack.cn/
---
 kernel/bpf/helpers.c |  1 +
 mm/page_owner.c      | 85 ++++++++++++++++++++++++++++++++++----------
 mm/page_owner.h      |  9 +++++
 mm/page_owner_iter.c | 17 +++++++++
 4 files changed, 93 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 23a2d2d71f4d..b46822eac894 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4951,6 +4951,7 @@ BTF_ID_FLAGS(func, bpf_iter_page_owner_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_page_owner_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_page_owner_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_page_owner_stack_snprint, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_page_owner_get_memcg_info, KF_SLEEPABLE)
 #endif
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp, KF_PERFMON);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 113e4e7e0b3a..664121be6686 100644
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
@@ -811,6 +855,7 @@ static ssize_t
 read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct page_owner_scan scan;
+	struct memcg_info memcg_info;
 	struct page_owner_filter_state *state = file->private_data;
 
 	if (!static_branch_unlikely(&page_owner_inited))
@@ -832,8 +877,10 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		/* Record the next PFN to read in the file offset */
 		*ppos = scan.pfn + 1;
 
+		get_page_memcg_info(scan.page, &memcg_info, NULL, 0);
 		return print_page_owner(buf, count, scan.pfn, scan.page,
-				&scan.po_snap, scan.po_snap.handle, state);
+				&scan.po_snap, scan.po_snap.handle, state,
+				&memcg_info);
 skip_continue:
 		scan.pfn++;
 		cond_resched();
diff --git a/mm/page_owner.h b/mm/page_owner.h
index e8e52d22abed..febf1c2807de 100644
--- a/mm/page_owner.h
+++ b/mm/page_owner.h
@@ -39,7 +39,16 @@ struct page_owner_scan {
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
index a2b90c874852..86e0b4b52bfc 100644
--- a/mm/page_owner_iter.c
+++ b/mm/page_owner_iter.c
@@ -177,4 +177,21 @@ __bpf_kfunc int bpf_page_owner_stack_snprint(struct page_owner_scan *scan,
 				   0);
 }
 
+__bpf_kfunc int bpf_page_owner_get_memcg_info(struct page_owner_scan *scan,
+					      struct memcg_info *info__uninit,
+					      char *buf__uninit, u32 buf__sz)
+{
+	/* Guard against the section being offlined after scan. */
+	struct page *page = pfn_to_online_page(scan->pfn);
+
+	if (!page) {
+		*info__uninit = (struct memcg_info){};
+		if (buf__uninit && buf__sz)
+			buf__uninit[0] = '\0';
+		return -ENODATA;
+	}
+
+	return get_page_memcg_info(page, info__uninit, buf__uninit, buf__sz);
+}
+
 __bpf_kfunc_end_defs();
-- 
2.20.1

