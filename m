Received: from mail-m4920.qiye.163.com (mail-m4920.qiye.163.com [45.254.49.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0534D3BE;
	Fri,  9 Oct 2026 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557572; cv=none; b=gX/xGIFTrf6MEF9OIdoKnXp0Xc7ZNBUN94x8JANfFh8A1Ay+mgvyZ3dn7fQa568Is48y4+B5Sg/WdgKY9s2n7LpYMfwSYOtAQ58qMoL1fKytq+y/RYny1KpzJoCC4qb+d1Sb0kJ6l9OBgWIZ8rS3HOHRBmx9lP6YarS3z4IGDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557572; c=relaxed/simple;
	bh=sA/DsWao9GwTHZp1eDTeWcxf7HKsdYenxCEWajcGEu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnimbbQFQ/xJOrLUI2D7W9XcnvsXUkdCO979SgnQIQHNRU9594vGTchwojGyRkjTSuWFw/f00VMkTzNBN5S9UuSl+IBy61KMQZfNyn54bf2B9ypR8+hhZ/qtc98RShxDgS9pxQJ42aGmCqCBcv/Z/BgSWihz6k2eZFhCRuamlaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1fe2901a0;
	Fri, 9 Oct 2026 19:23:27 +0800 (GMT+08:00)
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
Subject: [PATCH 2/6] mm/page_owner: add bpf_iter target "page_owner"
Date: Fri,  9 Oct 2026 19:23:04 +0800
Message-Id: <20261009112308.240769-3-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20261009112308.240769-1-zhen.ni@easystack.cn>
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa120675c160229kunmd33b3e054cb27e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTx5KVhlDT0wYTE5DHklNSFYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

Register a bpf_iter target "page_owner" that walks the pages eligible
for page_owner output, with the same eligibility rules as the
/sys/kernel/debug/page_owner read path.

For each eligible page the attached BPF program receives the pfn, the
page and the page_owner record, and can freely filter and format output.

The po_snap record in the scan cursor is taken inside the page_ext
RCU window and handed to the BPF program as a copy, so no RCU window
is needed at consumption time. Torn reads remain possible if the
record is concurrently updated while it is copied, but this is the
same best-effort behavior as the read path has always had.

The target is registered from pageowner_init() when both
CONFIG_PAGE_OWNER and CONFIG_BPF_SYSCALL are enabled; a registration
failure only disables the bpf_iter target.

Userspace tools such as bpftrace can attach to this target like any
other bpf_iter. For example, to count pages owned by init (pid 1):

    bpftrace -e 'iter:page_owner / ctx->po->pid == 1 / { @ = count(); }'

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 mm/Makefile          |   3 ++
 mm/page_owner.c      |  33 +++---------
 mm/page_owner.h      |  48 ++++++++++++++++++
 mm/page_owner_iter.c | 116 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 174 insertions(+), 26 deletions(-)
 create mode 100644 mm/page_owner.h
 create mode 100644 mm/page_owner_iter.c

diff --git a/mm/Makefile b/mm/Makefile
index e7245cb88c66..d7307b5a964c 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -115,6 +115,9 @@ obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
 obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
 obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
 obj-$(CONFIG_PAGE_OWNER) += page_owner.o
+ifdef CONFIG_BPF_SYSCALL
+obj-$(CONFIG_PAGE_OWNER) += page_owner_iter.o
+endif
 obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
 obj-$(CONFIG_ZSMALLOC)	+= zsmalloc.o
 obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
diff --git a/mm/page_owner.c b/mm/page_owner.c
index bafe474f3360..eb420803a434 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -14,6 +14,7 @@
 #include <linux/sched/clock.h>
 
 #include "page_alloc.h"
+#include "page_owner.h"
 
 /*
  * TODO: teach PAGE_OWNER_STACK_DEPTH (__dump_page_owner and save_stack)
@@ -21,31 +22,6 @@
  */
 #define PAGE_OWNER_STACK_DEPTH (16)
 
-struct page_owner {
-	unsigned short order;
-	short last_migrate_reason;
-	gfp_t gfp_mask;
-	depot_stack_handle_t handle;
-	depot_stack_handle_t free_handle;
-	u64 ts_nsec;
-	u64 free_ts_nsec;
-	char comm[TASK_COMM_LEN];
-	pid_t pid;
-	pid_t tgid;
-	pid_t free_pid;
-	pid_t free_tgid;
-};
-
-/*
- * Cursor and per-page result of page_owner_next_eligible().
- */
-struct page_owner_scan {
-	/* resume point */
-	unsigned long pfn;
-	struct page *page;
-	struct page_owner po_snap;
-};
-
 struct stack {
 	struct stack_record *stack_record;
 	struct stack *next;
@@ -741,7 +717,7 @@ void __dump_page_owner(const struct page *page)
  * must advance scan->pfn past the hit before calling again to resume
  * the scan.
  */
-static bool page_owner_next_eligible(struct page_owner_scan *scan)
+bool page_owner_next_eligible(struct page_owner_scan *scan)
 {
 	unsigned long pfn = scan->pfn;
 
@@ -1196,6 +1172,11 @@ static int __init pageowner_init(void)
 			    &stack_fops);
 	debugfs_create_file("count_threshold", 0600, dir, NULL,
 			    &threshold_fops);
+
+#ifdef CONFIG_BPF_SYSCALL
+	if (page_owner_iter_register())
+		pr_warn("page_owner: failed to register bpf_iter target\n");
+#endif
 	return 0;
 }
 late_initcall(pageowner_init)
diff --git a/mm/page_owner.h b/mm/page_owner.h
new file mode 100644
index 000000000000..fda83be69275
--- /dev/null
+++ b/mm/page_owner.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mm/ internal page_owner and page_owner_iter declarations
+ */
+
+#ifndef __MM_PAGE_OWNER_H
+#define __MM_PAGE_OWNER_H
+
+#include <linux/page_ext.h>
+#include <linux/sched.h>
+#include <linux/stackdepot.h>
+
+/*
+ * mm/page_owner.c
+ */
+struct page_owner {
+	unsigned short order;
+	short last_migrate_reason;
+	gfp_t gfp_mask;
+	depot_stack_handle_t handle;
+	depot_stack_handle_t free_handle;
+	u64 ts_nsec;
+	u64 free_ts_nsec;
+	char comm[TASK_COMM_LEN];
+	pid_t pid;
+	pid_t tgid;
+	pid_t free_pid;
+	pid_t free_tgid;
+};
+
+/*
+ * Cursor and per-page result of page_owner_next_eligible().
+ */
+struct page_owner_scan {
+	/* resume point */
+	unsigned long pfn;
+	struct page *page;
+	struct page_owner po_snap;
+};
+
+bool page_owner_next_eligible(struct page_owner_scan *scan);
+
+/*
+ * mm/page_owner_iter.c
+ */
+int page_owner_iter_register(void);
+
+#endif /* __MM_PAGE_OWNER_H */
diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
new file mode 100644
index 000000000000..33dc9dcd59de
--- /dev/null
+++ b/mm/page_owner_iter.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/seq_file.h>
+
+#include "page_owner.h"
+
+struct bpf_iter__page_owner {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct page *, page);
+	__bpf_md_ptr(struct page_owner *, po);
+	u64 pfn;
+};
+
+DEFINE_BPF_ITER_FUNC(page_owner, struct bpf_iter_meta *meta,
+		     struct page *page, struct page_owner *po, u64 pfn)
+
+static void *page_owner_seq_start(struct seq_file *seq, loff_t *posp)
+{
+	struct page_owner_scan *scan = seq->private;
+
+	if (*posp == 0)
+		scan->pfn = min_low_pfn;
+	else
+		scan->pfn++;
+
+	if (!page_owner_next_eligible(scan))
+		return NULL;
+	return scan->page;
+}
+
+static void *page_owner_seq_next(struct seq_file *seq, void *v, loff_t *posp)
+{
+	struct page_owner_scan *scan = seq->private;
+
+	++*posp;
+	scan->pfn++;
+	if (!page_owner_next_eligible(scan))
+		return NULL;
+
+	return scan->page;
+}
+
+static void page_owner_seq_stop(struct seq_file *seq, void *v)
+{
+}
+
+static int page_owner_prog_seq_show(struct bpf_prog *prog,
+				    struct bpf_iter_meta *meta, void *v)
+{
+	struct page_owner_scan *scan = meta->seq->private;
+	struct bpf_iter__page_owner ctx;
+
+	/* @po: hit-time snapshot, no RCU window needed. */
+	ctx.meta = meta;
+	ctx.page = (struct page *)v;
+	ctx.po = &scan->po_snap;
+	ctx.pfn = scan->pfn;
+
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static int page_owner_seq_show(struct seq_file *seq, void *v)
+{
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, false);
+	if (!prog)
+		return 0;
+
+	return page_owner_prog_seq_show(prog, &meta, v);
+}
+
+static const struct seq_operations page_owner_iter_seq_ops = {
+	.start	= page_owner_seq_start,
+	.next	= page_owner_seq_next,
+	.stop	= page_owner_seq_stop,
+	.show	= page_owner_seq_show,
+};
+
+static const struct bpf_iter_seq_info page_owner_iter_seq_info = {
+	.seq_ops		= &page_owner_iter_seq_ops,
+	.init_seq_private	= NULL,
+	.fini_seq_private	= NULL,
+	.seq_priv_size		= sizeof(struct page_owner_scan),
+};
+
+static struct bpf_iter_reg page_owner_iter_reg_info = {
+	.target			= "page_owner",
+	.ctx_arg_info_size	= 2,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__page_owner, page),
+		  PTR_TO_BTF_ID_OR_NULL },
+		{ offsetof(struct bpf_iter__page_owner, po),
+		  PTR_TO_BTF_ID_OR_NULL },
+	},
+	.seq_info		= &page_owner_iter_seq_info,
+};
+
+BTF_ID_LIST(page_owner_btf_ids)
+BTF_ID(struct, page)
+BTF_ID(struct, page_owner)
+
+int page_owner_iter_register(void)
+{
+	page_owner_iter_reg_info.ctx_arg_info[0].btf_id =
+		page_owner_btf_ids[0];
+	page_owner_iter_reg_info.ctx_arg_info[1].btf_id =
+		page_owner_btf_ids[1];
+
+	return bpf_iter_reg_target(&page_owner_iter_reg_info);
+}
-- 
2.20.1

