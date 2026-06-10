Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72647406824;
	Wed, 10 Jun 2026 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093895; cv=none; b=qglnlm+gJz3/QYxrYmU8uSoMrlcMiZwxcm5qg0L86BnluGxqV82WI4quUnlhkgLlOLvYcqUrKZWPM8lQ3sxVulmN+Es6XxDXLzFH1e0JF/C9TdDErUXD46aiw0rVADDeaJ0EMdiy7FiHELcvtlJMUoBedC1VbfH8fQlqorYgWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093895; c=relaxed/simple;
	bh=f3EB4Y5mFaDRSL4FZX5MY2mNb+pwP2mRtq2rpaS5l4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdGL504Lq1B+OxN/itG4cZEA2926DQkCgrbwNyn9D8gX4moxemHNP7Pi/yJzIomejCP8Y+wZf7EUgszB7u3e25wDSQRoFcrni9WL/0hMfVauJbEihbyCrHIhVtXrBSaINgARfTR24DpAJ0wbCFAUubbnZsQNHa0pLWRBj71B604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gb4Y638dNzYQtyb;
	Wed, 10 Jun 2026 20:17:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F41424056E;
	Wed, 10 Jun 2026 20:18:04 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP1 (Coremail) with SMTP id cCh0CgAXZzz5VSlqXFgyBQ--.57310S3;
	Wed, 10 Jun 2026 20:18:04 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Matt Bobrowski <mattbobrowski@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 1/2] bpf: Fix setting retval to -EPERM for cgroup hooks not returning errno
Date: Wed, 10 Jun 2026 20:17:23 +0000
Message-ID: <20260610201724.733943-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610201724.733943-1-xukuohai@huaweicloud.com>
References: <20260610201724.733943-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXZzz5VSlqXFgyBQ--.57310S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKr47Gr1UKw4rJw1Utw4rAFb_yoW7Cr13pF
	s7AFWYyr4Fk3yavF1kta4Fv3WrCw40ga17GryDWry0yay7Zr48Jr17Ar1Yqry5Ga4DW347
	GFWY9r4Y9a42vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x0262
	8vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07jgqXLUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

When a cgroup BPF program exits with 0, bpf_prog_run_array_cg() sets
the hook return value to -EPERM if it is not a valid errno. This is
correct for errno-based hooks, which return 0 on success and negative
errno on failure, but wrong for boolean and void LSM hooks. Boolean
LSM hooks should only return true or false, and void LSM hooks have
no return value at all.

Fix it by skipping setting -EPERM for hooks not returning errno.

Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf_lsm.h |  6 ++++++
 kernel/bpf/bpf_lsm.c    | 20 ++++++++++++++++++
 kernel/bpf/cgroup.c     | 47 +++++++++++++++++++++++++++++------------
 3 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 643809cc78c3..143775a27a2a 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -52,6 +52,7 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags);
 int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
 bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog);
+bool bpf_lsm_hook_returns_errno(u32 btf_id);
 
 #else /* !CONFIG_BPF_LSM */
 
@@ -104,6 +105,11 @@ static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
 {
 	return false;
 }
+
+static inline bool bpf_lsm_hook_returns_errno(u32 btf_id)
+{
+	return true;
+}
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index c5c925f00202..564071a92d7d 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -427,6 +427,26 @@ BTF_ID(func, bpf_lsm_audit_rule_known)
 BTF_ID(func, bpf_lsm_inode_xattr_skipcap)
 BTF_SET_END(bool_lsm_hooks)
 
+/* hooks returning void */
+#define LSM_HOOK_void(DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
+#define LSM_HOOK_int(DEFAULT, NAME, ...)  /* nothing */
+#define LSM_HOOK(RET, DEFAULT, NAME, ...) LSM_HOOK_##RET(DEFAULT, NAME, __VA_ARGS__)
+BTF_SET_START(void_lsm_hooks)
+#include <linux/lsm_hook_defs.h>
+#undef LSM_HOOK
+#undef LSM_HOOK_void
+#undef LSM_HOOK_int
+BTF_SET_END(void_lsm_hooks)
+
+bool bpf_lsm_hook_returns_errno(u32 btf_id)
+{
+	if (btf_id_set_contains(&bool_lsm_hooks, btf_id))
+		return false;
+	if (btf_id_set_contains(&void_lsm_hooks, btf_id))
+		return false;
+	return true;
+}
+
 int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
 			     struct bpf_retval_range *retval_range)
 {
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 35d1f1428ef3..83ce66296ac1 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -55,6 +55,28 @@ void __init cgroup_bpf_lifetime_notifier_init(void)
 						&cgroup_bpf_lifetime_nb));
 }
 
+#ifdef CONFIG_BPF_LSM
+struct cgroup_lsm_atype {
+	u32 attach_btf_id;
+	int refcnt;
+	bool returns_errno;
+};
+
+static struct cgroup_lsm_atype cgroup_lsm_atype[CGROUP_LSM_NUM];
+
+static bool cgroup_bpf_hook_returns_errno(enum cgroup_bpf_attach_type atype)
+{
+	if (atype >= CGROUP_LSM_START && atype <= CGROUP_LSM_END)
+		return READ_ONCE(cgroup_lsm_atype[atype - CGROUP_LSM_START].returns_errno);
+	return true;
+}
+#else
+static bool cgroup_bpf_hook_returns_errno(enum cgroup_bpf_attach_type atype)
+{
+	return true;
+}
+#endif
+
 /* __always_inline is necessary to prevent indirect call through run_prog
  * function pointer.
  */
@@ -83,7 +105,8 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
 			*(ret_flags) |= (func_ret >> 1);
 			func_ret &= 1;
 		}
-		if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
+		if (!func_ret && cgroup_bpf_hook_returns_errno(atype) &&
+		    !IS_ERR_VALUE((long)run_ctx.retval))
 			run_ctx.retval = -EPERM;
 		item++;
 	}
@@ -156,13 +179,6 @@ unsigned int __cgroup_bpf_run_lsm_current(const void *ctx,
 }
 
 #ifdef CONFIG_BPF_LSM
-struct cgroup_lsm_atype {
-	u32 attach_btf_id;
-	int refcnt;
-};
-
-static struct cgroup_lsm_atype cgroup_lsm_atype[CGROUP_LSM_NUM];
-
 static enum cgroup_bpf_attach_type
 bpf_cgroup_atype_find(enum bpf_attach_type attach_type, u32 attach_btf_id)
 {
@@ -191,10 +207,13 @@ void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype)
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	WARN_ON_ONCE(cgroup_lsm_atype[i].attach_btf_id &&
-		     cgroup_lsm_atype[i].attach_btf_id != attach_btf_id);
-
-	cgroup_lsm_atype[i].attach_btf_id = attach_btf_id;
+	if (!cgroup_lsm_atype[i].attach_btf_id) {
+		cgroup_lsm_atype[i].attach_btf_id = attach_btf_id;
+		WRITE_ONCE(cgroup_lsm_atype[i].returns_errno,
+			   bpf_lsm_hook_returns_errno(attach_btf_id));
+	} else {
+		WARN_ON_ONCE(cgroup_lsm_atype[i].attach_btf_id != attach_btf_id);
+	}
 	cgroup_lsm_atype[i].refcnt++;
 }
 
@@ -203,8 +222,10 @@ void bpf_cgroup_atype_put(int cgroup_atype)
 	int i = cgroup_atype - CGROUP_LSM_START;
 
 	cgroup_lock();
-	if (--cgroup_lsm_atype[i].refcnt <= 0)
+	if (--cgroup_lsm_atype[i].refcnt <= 0) {
+		WRITE_ONCE(cgroup_lsm_atype[i].returns_errno, true);
 		cgroup_lsm_atype[i].attach_btf_id = 0;
+	}
 	WARN_ON_ONCE(cgroup_lsm_atype[i].refcnt < 0);
 	cgroup_unlock();
 }
-- 
2.43.0

