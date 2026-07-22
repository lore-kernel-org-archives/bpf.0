Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB643845B3;
	Wed, 22 Jul 2026 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704740; cv=none; b=nD6N+8+7NvhAz8RpE+aJqFU3BOovpPVenX1p40b1dAmu1TRe7UmKEMZ54nA4RfW4izvWqkEMLOt0oOxd6TF6d5dy/r/Z0gceFl0j1evyxOFkRT+31eTPmzC4f+eAeAQL/aX864z3tVtXAEdNxd69trwUSs4QWcv1YyXnCvaPT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704740; c=relaxed/simple;
	bh=6kLDb/EkwL+x0uT2625WN0nWMVGKTy4T4ZBkAimrppQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZvWwnAXDuP1nV1rARQVgniSc9HPy4zTRFk3vBAcim+z1wcFrAt9ZCJpbldm+x7EbSAS9F2bDAgPIUPqZ7pDyVuQthERZ5S1GusdMcoFD8YPMQQ9t5QSEBTgeKgIaL3Z4ZSA+5+hxaN7Ej1NYeFmS2iTe0tr0UH3M9Jt5rA4cwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h4lwM0JPszYQttb;
	Wed, 22 Jul 2026 15:18:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A72534070C;
	Wed, 22 Jul 2026 15:18:55 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCHl3PfbmBqGBB_CA--.17870S6;
	Wed, 22 Jul 2026 15:18:55 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amery Hung <ameryhung@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v6 4/4] bpf, cgroup: Fix storage null-ptr-deref after replacing prog
Date: Wed, 22 Jul 2026 07:23:26 +0000
Message-Id: <20260722072326.1545677-5-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722072326.1545677-1-pulehui@huaweicloud.com>
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHl3PfbmBqGBB_CA--.17870S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCF13ArW3Zw17Ar4DXFWrXwb_yoWrKw48pF
	1kAwn8tw1UX39avF1kJ39FvF1rAa10qr1UKrZ8tw1Fkay7tayFg347CryYva43uF1DWr1f
	tw1YvF4jk3WjvFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl
	6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8c
	xan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryU
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRRyxRDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Syzkaller reported a storage null-ptr-deref issue after replacing prog.
This occurs in the following scenario:
1. prog A, an empty prog, is attached to a cgrp.
2. prog B uses BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE and calls the
   bpf_get_local_storage helper.
3. link_update is called to replace prog A with prog B.

The reason is that __cgroup_bpf_replace fails to alloc and assign the
required cgrp storage for the incoming replacement prog. Consequently,
the new prog inherits an uninit storage, leading to null-ptr-deref panic
when kick the new prog.

Fix this by properly allocating the storage and comparing the old and
new storage pointers. If the storage changed, fallback to
update_effective_progs which performs a RCU-safe update of the entire
array. If the storage remains unchanged, we can safely retain the
fast-path in-place update.

Additionally, handle the error path in __cgroup_bpf_attach strictly.
Although it is rare for update_effective_progs to fail in this context,
proper rollbacks for storage and flags are added for code rigor.

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/cgroup.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4355ccb78a9c..56d538f05520 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -813,10 +813,12 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	struct bpf_prog *old_prog = NULL;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
+	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_prog *new_prog = prog ? : link->link.prog;
 	enum cgroup_bpf_attach_type atype;
 	struct bpf_prog_list *pl;
 	struct hlist_head *progs;
+	u8 old_flags;
 	int err;
 
 	if (((flags & BPF_F_ALLOW_OVERRIDE) && (flags & BPF_F_ALLOW_MULTI)) ||
@@ -883,7 +885,10 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	pl->prog = prog;
 	pl->link = link;
 	pl->flags = flags;
+	if (old_prog)
+		bpf_cgroup_storages_assign(old_storage, pl->storage);
 	bpf_cgroup_storages_assign(pl->storage, storage);
+	old_flags = cgrp->bpf.flags[atype];
 	cgrp->bpf.flags[atype] = saved_flags;
 
 	if (type == BPF_LSM_CGROUP) {
@@ -915,12 +920,14 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (old_prog) {
 		pl->prog = old_prog;
 		pl->link = NULL;
+		bpf_cgroup_storages_assign(pl->storage, old_storage);
 	}
 	bpf_cgroup_storages_free(new_storage);
 	if (!old_prog) {
 		hlist_del(&pl->node);
 		kfree(pl);
 	}
+	cgrp->bpf.flags[atype] = old_flags;
 	return err;
 }
 
@@ -1032,11 +1039,17 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 				struct bpf_cgroup_link *link,
 				struct bpf_prog *new_prog)
 {
+	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
+	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
+	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
+	enum bpf_cgroup_storage_type stype;
 	enum cgroup_bpf_attach_type atype;
+	bool storage_changed = false;
 	struct bpf_prog *old_prog;
 	struct bpf_prog_list *pl;
 	struct hlist_head *progs;
 	bool found = false;
+	int err;
 
 	atype = bpf_cgroup_atype_find(link->link.attach_type, new_prog->aux->attach_btf_id);
 	if (atype < 0)
@@ -1056,10 +1069,39 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	if (!found)
 		return -ENOENT;
 
+	if (bpf_cgroup_storages_alloc(storage, new_storage, link->link.attach_type,
+				      new_prog, cgrp))
+		return -ENOMEM;
+
+	for_each_cgroup_storage_type(stype) {
+		if (storage[stype] != pl->storage[stype]) {
+			storage_changed = true;
+			break;
+		}
+	}
+
 	cgrp->bpf.revisions[atype] += 1;
 	old_prog = xchg(&link->link.prog, new_prog);
-	replace_effective_prog(cgrp, atype, pl);
+
+	if (!storage_changed) {
+		replace_effective_prog(cgrp, atype, pl);
+		bpf_prog_put(old_prog);
+		return 0;
+	}
+
+	bpf_cgroup_storages_assign(old_storage, pl->storage);
+	bpf_cgroup_storages_assign(pl->storage, storage);
+	err = update_effective_progs(cgrp, atype);
+	if (err) {
+		xchg(&link->link.prog, old_prog);
+		bpf_cgroup_storages_assign(pl->storage, old_storage);
+		bpf_cgroup_storages_free(new_storage);
+		cgrp->bpf.revisions[atype] -= 1;
+		return err;
+	}
+
 	bpf_prog_put(old_prog);
+	bpf_cgroup_storages_link(new_storage, cgrp, link->link.attach_type);
 	return 0;
 }
 
-- 
2.34.1

