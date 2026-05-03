Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E843CF688
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827084; cv=none; b=ah1ZuvFtFFg7sq5n2oyAHdrf79foVd+Xl/MlcwUpjvTI+uOZhRaoW2p03hq5NSR8uPWDqEKgqUUYyCryNYMgflV6lnqt79gI/yhDlg1y2dX5D/qxP1Dbcn7ImFBMGr3bNk+CkngWkPdpw+x2WqgDxcdAnRpWL3U0e6PuX8FFdkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827084; c=relaxed/simple;
	bh=CKDGmZqs2BcDQFkKKJ3/LB08rMsN0Zlvgjt7hwsN2ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1KhD4Q1r8nPoeOyNqNb9d1Ul4Tdl4rD7RCWF3NQYBJB/28Cp2ZbD0ejE1MnTKl2O2SD3I1oAX5nhoGKhGV2e3MQ1s6B0/zCZXr3Kqrh5ptdTB45rBIFCZ0O71KYRsPgl/HgVKgyhaiHtpobnpASS4gvulptToA3YItr+56OgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezq3/77G; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezq3/77G"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8025aecc40so186497a12.0
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777827080; x=1778431880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/G70uBdUm2gD1KEfqVpMXmzdSE5Aaw6QQY+7czX4maU=;
        b=ezq3/77GM8zEbliP43MqIFBz/4f5duzT/BUQ11KmxGehT9ywZtsbZ6QjE95XGFOqYZ
         YmO/ZClY/6gIYCIGUFAvVN4ZyIMWg7tSNTJFx34Mou+cB7cO3IGKri8wRsZTmHdIYvK6
         xKUothfWi6WpH6U3HVr7fP6yAUvrpxWiGA3A7BBLOFTgP56d+/mP/aw7ewsoW+rlUxF0
         WDO7ZSdMDUxZvYwbiNB49ZgYkWLIi8HCJh3k6IXkHkF+9q9pkjVDpl9cu1AtJRswOoLg
         E7M7xmVGZ7IYPnGPtovbkQGpAqU/hmgwAXXZfbgIDtT2+7BNnssFbwp6BzAL1VNZsv70
         WIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827080; x=1778431880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/G70uBdUm2gD1KEfqVpMXmzdSE5Aaw6QQY+7czX4maU=;
        b=fIwMoR4yCgWotDHQoMY0+yIXy6RxzcpWa43Wsu9bdo/tKJdsFkqtCwHEsn6LDpIJ3N
         v8Y7+owcN2zQHU0N4SqqUB4Amet55PiRHrUauJ88xpv0YpsrrTVr3uJ4Jba2ZoHFAlzs
         5mWqPdPNOqom0NurFmGD/x7rMGUzuujVmQcHIBBBgsatQXQjujTpd39XQbz/X5QT9pJX
         CmsIWcGvQZyekhFOjqhMgPQD81wKzuy8thoJutwDNuV9TlBvLVub3YbAdI4wdWSJEjMX
         /0owhkagX179fIWvknOd626LtjJzp2ZIBSvCcDxpq/J+ICQnzhENXGy+rxMveiqY5twK
         5yFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hZREmFl7nj4rrV6m1Nnv6v8W/IOiTJHYMb+4LZFQEIkqo1WuA66VGhD0Y2JTu0R/AEms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9UThCpPItpdsV01HD8Xtd5eqCNXR0SNff16qZWlB61zGJPGS
	EJrgBF2x54OuuzUa+PbpDtW17GYL/zf30c1Sdyo/c7MZXPE0lEEn9iQV
X-Gm-Gg: AeBDiesDM8E9vJsScEJynv0z26ggUaJ8fQCLSeyDA3Y+4La8DWVrgU1Zr2JWNVcw93l
	j4XFSTtic7cCu/80CtGkVzppjaWltTJkO1FD8FENK0ZPcR7y6jiJ5JqRiFEXqixQxvmO2HwECsS
	WAIHt9bxT+aHQCROwin7EqJXn3jON/wlAUdCcGoSptlx5sxDMzI7l3o7Wo1t111gwnyqVa6NU5+
	WTDMZEHb0EqwVovVal44yOIn+BhWC1giYx6fh/sV6xlwLvSJpznrtjG97mzDJ8B/JvPs1aqYBQw
	SLFxSPR45rcTOVE3rfsfoTzOKZMgEMmEML/oLcQjAag0wZw/gPO5RAz+G/pLLv/ILy57LvAbp0u
	Hmq2rONZHfyiZu88dZFwMOAi55kuZIFSR4Em9FLh5jl/QmxDvQViifql2lqsWbBNnThRNRgjaXD
	k/3e/JQDoWDeVwQ25m3SCof3YGw+7S7U5vaaz+c3a1ndNY1Uc=
X-Received: by 2002:a05:6a20:4311:b0:35d:cc9a:8bc1 with SMTP id adf61e73a8af0-3a7f041ebf8mr5417275637.27.1777827079789;
        Sun, 03 May 2026 09:51:19 -0700 (PDT)
Received: from localhost.localdomain ([114.231.84.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83707fab756sm1494277b3a.44.2026.05.03.09.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:51:17 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	roman.gushchin@linux.dev,
	inwardvessel@gmail.com,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	surenb@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	baohua@kernel.org,
	lance.yang@linux.dev,
	dev.jain@arm.com,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH 3/4] mm: introduce bpf_mthp_ops struct ops
Date: Mon,  4 May 2026 00:50:23 +0800
Message-ID: <20260503165024.1526680-4-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503165024.1526680-1-vernon2gm@gmail.com>
References: <20260503165024.1526680-1-vernon2gm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

Introducing bpf_mthp_ops enables eBPF programs to register the
mthp_choose callback function via cgroup-ebpf.

Using cgroup-bpf to customize mTHP size for different scenarios，
automatically select different mTHP sizes for different cgroups,
let's focus on making them truly transparent.

Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 MAINTAINERS                     |   3 +
 include/linux/bpf_huge_memory.h |  35 +++++++
 include/linux/cgroup-defs.h     |   1 +
 include/linux/huge_mm.h         |   6 ++
 mm/Kconfig                      |  14 +++
 mm/Makefile                     |   1 +
 mm/bpf_huge_memory.c            | 169 ++++++++++++++++++++++++++++++++
 7 files changed, 229 insertions(+)
 create mode 100644 include/linux/bpf_huge_memory.h
 create mode 100644 mm/bpf_huge_memory.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 27a073f53cea..39f00676eeb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4887,7 +4887,10 @@ M:	Shakeel Butt <shakeel.butt@linux.dev>
 L:	bpf@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Maintained
+F:	include/linux/bpf_huge_memory.h
+F:	mm/bpf_huge_memory.c
 F:	mm/bpf_memcontrol.c
+F:	samples/bpf/mthp_ext.*
 
 BPF [MISC]
 L:	bpf@vger.kernel.org
diff --git a/include/linux/bpf_huge_memory.h b/include/linux/bpf_huge_memory.h
new file mode 100644
index 000000000000..1c8a6f7ad8f1
--- /dev/null
+++ b/include/linux/bpf_huge_memory.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __BPF_HUGE_MEMORY_H
+#define __BPF_HUGE_MEMORY_H
+
+/**
+ * struct bpf_mthp_ops - BPF callbacks for mTHP operations
+ * @mthp_choose: Choose the custom mTHP orders
+ *
+ * This structure defines the interface for BPF programs to customize
+ * mTHP behavior through struct_ops programs.
+ */
+struct bpf_mthp_ops {
+	unsigned long (*mthp_choose)(struct cgroup *cgrp, unsigned long orders);
+};
+
+#if defined(CONFIG_BPF_TRANSPARENT_HUGEPAGE) && defined(CONFIG_BPF_SYSCALL)
+/**
+ * bpf_mthp_choose: Choose the custom mTHP orders using bpf
+ * @mm: task mm_struct
+ * @orders: original orders
+ *
+ * Return suited mTHP orders.
+ */
+unsigned long bpf_mthp_choose(struct mm_struct *mm, unsigned long orders);
+#else
+static inline unsigned long bpf_mthp_choose(struct mm_struct *mm,
+					    unsigned long orders)
+{
+	return orders;
+}
+#endif /* CONFIG_BPF_SYSCALL */
+
+#endif /* __BPF_HUGE_MEMORY_H */
+
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index f42563739d2e..78854d0e06ab 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -628,6 +628,7 @@ struct cgroup {
 
 #ifdef CONFIG_BPF_SYSCALL
 	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
+	struct bpf_mthp_ops *mthp_ops;
 #endif
 #ifdef CONFIG_EXT_SUB_SCHED
 	struct scx_sched __rcu *scx_sched;
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2949e5acff35..80ec622213df 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -3,6 +3,7 @@
 #define _LINUX_HUGE_MM_H
 
 #include <linux/mm_types.h>
+#include <linux/bpf_huge_memory.h>
 
 #include <linux/fs.h> /* only for vma_is_dax() */
 #include <linux/kobject.h>
@@ -291,6 +292,11 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 				       enum tva_type type,
 				       unsigned long orders)
 {
+	/* The eBPF-specified orders overrides which order is selected. */
+	orders &= bpf_mthp_choose(vma->vm_mm, orders);
+	if (!orders)
+		return 0;
+
 	/*
 	 * Optimization to check if required orders are enabled early. Only
 	 * forced collapse ignores sysfs configs.
diff --git a/mm/Kconfig b/mm/Kconfig
index e8bf1e9e6ad9..12382431ddc7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -963,6 +963,20 @@ config NO_PAGE_MAPCOUNT
 
 	  EXPERIMENTAL because the impact of some changes is still unclear.
 
+config BPF_TRANSPARENT_HUGEPAGE
+	bool "BPF-based transparent hugepage (EXPERIMENTAL)"
+	depends on TRANSPARENT_HUGEPAGE
+	help
+	  Using cgroup-bpf to customize mTHP size for different scenarios,
+	  automatically select different mTHP sizes for different cgroups,
+	  let's focus on making them truly transparent.
+
+	  This is an experimental feature, that might go away at any time,
+	  Please do not rely any production environment.
+
+	  EXPERIMENTAL because the BPF interface is unstable and may be removed
+	  at any time.
+
 endif # TRANSPARENT_HUGEPAGE
 
 # simple helper to make the code a bit easier to read
diff --git a/mm/Makefile b/mm/Makefile
index 8ad2ab08244e..b474c21c3253 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
 ifdef CONFIG_BPF_SYSCALL
 obj-$(CONFIG_MEMCG) += bpf_memcontrol.o
+obj-$(CONFIG_BPF_TRANSPARENT_HUGEPAGE) += bpf_huge_memory.o
 endif
 obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
 obj-$(CONFIG_GUP_TEST) += gup_test.o
diff --git a/mm/bpf_huge_memory.c b/mm/bpf_huge_memory.c
new file mode 100644
index 000000000000..e34e0a35edac
--- /dev/null
+++ b/mm/bpf_huge_memory.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Huge memory related BPF code
+ *
+ * Author: Vernon Yang <yanglincheng@kylinos.cn>
+ */
+
+#include <linux/bpf.h>
+#include <linux/srcu.h>
+
+/* Protects cgrp->mthp_ops pointer for read and write. */
+DEFINE_SRCU(mthp_bpf_srcu);
+
+unsigned long bpf_mthp_choose(struct mm_struct *mm, unsigned long orders)
+{
+	struct cgroup *cgrp;
+	struct mem_cgroup *memcg;
+	struct bpf_mthp_ops *ops;
+	int idx;
+
+	memcg = get_mem_cgroup_from_mm(mm);
+	if (!memcg)
+		return orders;
+
+	cgrp = memcg->css.cgroup;
+	ops = READ_ONCE(cgrp->mthp_ops);
+	if (unlikely(ops)) {
+		idx = srcu_read_lock(&mthp_bpf_srcu);
+		if (ops->mthp_choose)
+			orders = ops->mthp_choose(cgrp, orders);
+		srcu_read_unlock(&mthp_bpf_srcu, idx);
+	}
+
+	mem_cgroup_put(memcg);
+
+	return orders;
+}
+
+static int bpf_mthp_ops_btf_struct_access(struct bpf_verifier_log *log,
+		const struct bpf_reg_state *reg, int off, int size)
+{
+	return -EACCES;
+}
+
+static bool bpf_mthp_ops_is_valid_access(int off, int size, enum bpf_access_type type,
+		const struct bpf_prog *prog, struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+const struct bpf_verifier_ops bpf_mthp_verifier_ops = {
+	.get_func_proto = bpf_base_func_proto,
+	.btf_struct_access = bpf_mthp_ops_btf_struct_access,
+	.is_valid_access = bpf_mthp_ops_is_valid_access,
+};
+
+static int bpf_mthp_ops_reg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *st_link = (struct bpf_struct_ops_link *)link;
+	struct bpf_mthp_ops *ops = kdata;
+	struct cgroup *cgrp = st_link->cgroup;
+	struct cgroup_subsys_state *pos;
+
+	/* The link is not yet fully initialized, but cgroup should be set */
+	if (!link)
+		return -EOPNOTSUPP;
+
+	cgroup_lock();
+	css_for_each_descendant_pre(pos, &cgrp->self) {
+		struct cgroup *child = pos->cgroup;
+
+		if (READ_ONCE(child->mthp_ops)) {
+			/* TODO
+			 * Do not destroy the cgroup hierarchy property.
+			 * If an eBPF program already exists in the sub-cgroup,
+			 * trigger an error and clear the already set
+			 * bpf_mthp_ops data.
+			 */
+			continue;
+		}
+		WRITE_ONCE(child->mthp_ops, ops);
+	}
+	cgroup_unlock();
+
+	return 0;
+}
+
+static void bpf_mthp_ops_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *st_link = (struct bpf_struct_ops_link *)link;
+	struct bpf_mthp_ops *ops = kdata;
+	struct cgroup *cgrp = st_link->cgroup;
+	struct cgroup_subsys_state *pos;
+
+	cgroup_lock();
+	css_for_each_descendant_pre(pos, &cgrp->self) {
+		struct cgroup *child = pos->cgroup;
+
+		if (READ_ONCE(child->mthp_ops) == ops)
+			WRITE_ONCE(child->mthp_ops, NULL);
+	}
+	cgroup_unlock();
+
+	synchronize_srcu(&mthp_bpf_srcu);
+}
+
+static int bpf_mthp_ops_check_member(const struct btf_type *t,
+				     const struct btf_member *member,
+				     const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct bpf_mthp_ops, mthp_choose):
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (prog->sleepable)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int bpf_mthp_ops_init_member(const struct btf_type *t,
+				    const struct btf_member *member,
+				    void *kdata, const void *udata)
+{
+	return 0;
+}
+
+static int bpf_mthp_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+static unsigned long cfi_mthp_choose(struct cgroup *cgrp, unsigned long orders)
+{
+	return 0;
+}
+
+static struct bpf_mthp_ops cfi_bpf_mthp_ops = {
+	.mthp_choose = cfi_mthp_choose,
+};
+
+static struct bpf_struct_ops bso_bpf_mthp_ops = {
+	.verifier_ops = &bpf_mthp_verifier_ops,
+	.reg = bpf_mthp_ops_reg,
+	.unreg = bpf_mthp_ops_unreg,
+	.check_member = bpf_mthp_ops_check_member,
+	.init_member = bpf_mthp_ops_init_member,
+	.init = bpf_mthp_ops_init,
+	.name = "bpf_mthp_ops",
+	.owner = THIS_MODULE,
+	.cfi_stubs = &cfi_bpf_mthp_ops,
+};
+
+static int __init bpf_huge_memory_init(void)
+{
+	int err;
+
+	err = register_bpf_struct_ops(&bso_bpf_mthp_ops, bpf_mthp_ops);
+	if (err)
+		pr_warn("Registration of bpf_mthp_ops failed, err %d\n", err);
+
+	return err;
+}
+late_initcall(bpf_huge_memory_init);
-- 
2.53.0

