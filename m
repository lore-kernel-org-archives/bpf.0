Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD163F7AA8
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252494; cv=none; b=ZO93wtYl9XWnI49CMKys5r8lb/sREbqnXfiHUzAha50ZtbVyVGxYImHWpPelqY8SmrA/DBjQqn5kE5VjlP8JUka3gL+F7yjfMxnqh2zVds2UX4OX9s5j1rxjkt4GUWKuRnUP94fKrN6qUTcjfn7DFi5JSkfxQP0ns46/DgC4Veo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252494; c=relaxed/simple;
	bh=c1WOAjKtLto+9++pozNr1RGscclDkwpzhv6f1ahBKYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLIGJZqGqNumy626cm+QAMGsna7ZBrINvKpIiMHYgHpnARDuYj2Ljv4FAL6xcLr6k40MbTCGYM2l773S0cQT311pcn3VrAw8S/x8Ie6n/bwS1F3d3RsyTLxItyrQwyTZcg38lZPRdA29U8pr/S0k8uIMom3cvx6tDzvLLu8Pom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAKlzhZ+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAKlzhZ+"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so923986b3a.2
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252491; x=1778857291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsM3MZHPJG4jSqIS5oTV4ZYkVaqZoomzaAcAboB87ak=;
        b=bAKlzhZ+BggOlVGHr+4e0NzY763oBkFE7BWjiNQPulP2EMZ0CSs8YJDBNfIsVh/Wec
         oQ/d0BH3USr/FWSIizuJwegs9PhE75lOexT3NH37EzUun4PTCQ2yC/lwQXf51m41wG4J
         tfLuK/DVyCcxZ+jpeltPk/NHPlBURGPCUVLBaYac6De6OoW+oZqHh/eAI/4eykPMETMo
         7AQDdv/RKbuIbyQkIa6KbwZamqOda36w9oN15vXygSE8pG20jKftt1lFZu42NlUNGql+
         FMcJClfr5XK1/gKsybCcmQNa/2iB+NI6EJLsBCtryCP7UgItPsvTOBlysvZDvhSudX8w
         JGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252491; x=1778857291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dsM3MZHPJG4jSqIS5oTV4ZYkVaqZoomzaAcAboB87ak=;
        b=JvHfST/m8rJMGMQ1EuTqE0FXCivNxJXw9m8F/+vF5D+qpMcGuVDizvqWDxqgZjmWZY
         4G+ElrifOfjZcNTXRA3I4bv8HSladUxWrDDhNRP+OO2qnx2OIbvNBFoNZQ4gp92WHgvk
         6NymAI+4fM+xesiJtpyL01Zf4gqErtRP6IzshMdPHsEN7pv2n5MPuRx8uRX8mnOc4E70
         AnbFACooGAoaFhnvt3Vn5Wdfns+P0LjrgamNkcxiY0V0Wc3ZM1w81kVTSVwHYRO/Hf9o
         qIxOArVBGs2LPMY7lhtu85Hu10z3uhiFWCizv1zHjH3sWeYMU7iws//FPu5CGIXKpf3O
         qwvA==
X-Forwarded-Encrypted: i=1; AFNElJ9spFzNvj7902j//6Ok4lGYgWrK+9q9jdsQpjpEZcAxWTsoNzABA06A6vDB8Xip1Nlsoyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15g21f2DWSWOV8bV93Jpu6h+dm0oG0jJ8+xLaclH2YLBlHgXj
	iI6CL5wHjK3V5S2HAFHmjtQOJIzTQHGsexPDj5g+KgzyKHrutTDvIG23
X-Gm-Gg: Acq92OFgua64LAImirhgBtEVg+hO/KA3bVEDyl7djB9z9ZB+h+J9rnygbJqXiFZptd5
	KeTgxkuffisZTZdFk5hJMoBBlhRzRkXBfdOfGLes8o7/DQhQ9h74Vq4D2HANGrVgeT0q3ysd2xX
	iO3hRk3XAI77xGl5xmwOOlYZz56TJzJwVAB6Kutf16tFwa6k27E/oVHApOo0MwSXipx2EUTLWEQ
	eO1Otedqz6dhf672u5c3kVbVPMmEdxMXXvzuhAE1EpzJN1hC7a5Tl6FfnftWe6E1M6ZAihKTrrg
	e2alM8/2v3egelplbC8aLcb18gSM+MbQNnL9VnkNFdcvgxoqXYGjFI6GqIqjxcPw9lkuUCZ56pt
	/1XvQ5ZD38G4sW5zKW+joOrLEygRcrGrPYNBj5Nwzu5/U72Lh3q1KxFO5YEtHAZVuUCrNPSmjxX
	P2eO3NjLQ+pFHrbYHJHyJnU5rkNPUXMPNRwB/E0n6lFZuyvR8=
X-Received: by 2002:a05:6a00:39a5:b0:82c:2205:507d with SMTP id d2e1a72fcca58-83a5dd5bc34mr12224188b3a.36.1778252490591;
        Fri, 08 May 2026 08:01:30 -0700 (PDT)
Received: from localhost.localdomain ([114.231.84.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945c1bsm13110064b3a.15.2026.05.08.08.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:01:29 -0700 (PDT)
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
Cc: tz2294@columbia.edu,
	baohua@kernel.org,
	lance.yang@linux.dev,
	dev.jain@arm.com,
	laoar.shao@gmail.com,
	gutierrez.asier@huawei-partners.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH v2 3/4] mm: introduce bpf_mthp_ops struct ops
Date: Fri,  8 May 2026 23:00:54 +0800
Message-ID: <20260508150055.680136-4-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508150055.680136-1-vernon2gm@gmail.com>
References: <20260508150055.680136-1-vernon2gm@gmail.com>
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
 include/linux/bpf_huge_memory.h |  52 ++++++++++
 include/linux/cgroup-defs.h     |   1 +
 include/linux/huge_mm.h         |   6 ++
 kernel/cgroup/cgroup.c          |   2 +
 mm/Kconfig                      |  14 +++
 mm/Makefile                     |   1 +
 mm/bpf_huge_memory.c            | 168 ++++++++++++++++++++++++++++++++
 8 files changed, 247 insertions(+)
 create mode 100644 include/linux/bpf_huge_memory.h
 create mode 100644 mm/bpf_huge_memory.c

diff --git a/MAINTAINERS b/MAINTAINERS
index caaa0d6e6056..f1113eaa1193 100644
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
index 000000000000..ffda445c9572
--- /dev/null
+++ b/include/linux/bpf_huge_memory.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __BPF_HUGE_MEMORY_H
+#define __BPF_HUGE_MEMORY_H
+
+#include <linux/cgroup-defs.h>
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
+#ifdef CONFIG_BPF_TRANSPARENT_HUGEPAGE
+/**
+ * bpf_mthp_choose - Choose the custom mTHP orders using bpf
+ * @mm: task mm_struct
+ * @orders: original orders
+ *
+ * Return suited mTHP orders.
+ */
+unsigned long bpf_mthp_choose(struct mm_struct *mm, unsigned long orders);
+
+/**
+ * cgroup_bpf_set_mthp_ops - Set sub-cgroup mthp_ops to parent cgroup
+ * @cgrp: want to set mthp_ops of sub-cgroup
+ * @parent: parent cgroup
+ */
+static inline void cgroup_bpf_set_mthp_ops(struct cgroup *cgrp,
+					   struct cgroup *parent)
+{
+	WRITE_ONCE(cgrp->mthp_ops, parent->mthp_ops);
+}
+#else
+static inline unsigned long bpf_mthp_choose(struct mm_struct *mm,
+					    unsigned long orders)
+{
+	return orders;
+}
+static inline void cgroup_bpf_set_mthp_ops(struct cgroup *cgrp,
+					   struct cgroup *parent)
+{
+}
+#endif /* CONFIG_BPF_TRANSPARENT_HUGEPAGE */
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
index 127f9e1e7604..65da35fb0980 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -3,6 +3,7 @@
 #define _LINUX_HUGE_MM_H
 
 #include <linux/mm_types.h>
+#include <linux/bpf_huge_memory.h>
 
 #include <linux/fs.h> /* only for vma_is_dax() */
 #include <linux/kobject.h>
@@ -296,6 +297,11 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
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
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 43adc96c7f1a..1dbef3e8b179 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5836,6 +5836,8 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	if (ret)
 		goto out_stat_exit;
 
+	cgroup_bpf_set_mthp_ops(cgrp, parent);
+
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp))
 		cgrp->ancestors[tcgrp->level] = tcgrp;
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 27dc5b0139ba..be49bde783a7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -949,6 +949,20 @@ config NO_PAGE_MAPCOUNT
 
 	  EXPERIMENTAL because the impact of some changes is still unclear.
 
+config BPF_TRANSPARENT_HUGEPAGE
+	bool "BPF-based transparent hugepage (EXPERIMENTAL)"
+	depends on TRANSPARENT_HUGEPAGE && CGROUP_BPF
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
index 000000000000..851c6ebe2933
--- /dev/null
+++ b/mm/bpf_huge_memory.c
@@ -0,0 +1,168 @@
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
+
+	idx = srcu_read_lock(&mthp_bpf_srcu);
+	ops = READ_ONCE(cgrp->mthp_ops);
+	if (unlikely(ops && ops->mthp_choose))
+		orders = ops->mthp_choose(cgrp, orders);
+	srcu_read_unlock(&mthp_bpf_srcu, idx);
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
+	struct cgroup_subsys_state *child;
+	struct cgroup *cgrp;
+
+	if (!link)
+		return -EOPNOTSUPP;
+
+	cgrp = st_link->cgroup;
+	if (!cgrp)
+		return -EINVAL;
+
+	cgroup_lock();
+	css_for_each_descendant_pre(child, &cgrp->self) {
+		if (READ_ONCE(child->cgroup->mthp_ops)) {
+			pr_warn("sub-cgroup has already registered.\n");
+			cgroup_unlock();
+			return -EBUSY;
+		}
+	}
+	css_for_each_descendant_pre(child, &cgrp->self)
+		WRITE_ONCE(child->cgroup->mthp_ops, ops);
+	cgroup_unlock();
+
+	return 0;
+}
+
+static void bpf_mthp_ops_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_struct_ops_link *st_link = (struct bpf_struct_ops_link *)link;
+	struct cgroup_subsys_state *child;
+	struct cgroup *cgrp;
+
+	if (!link)
+		return;
+
+	cgrp = st_link->cgroup;
+	if (!cgrp)
+		return;
+
+	cgroup_lock();
+	css_for_each_descendant_pre(child, &cgrp->self)
+		WRITE_ONCE(child->cgroup->mthp_ops, NULL);
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

