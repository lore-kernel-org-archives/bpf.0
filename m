Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CFE390C84;
	Fri, 17 Jul 2026 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273374; cv=none; b=XP+Q2L/Ep5KH0W3CykF5SeKqcCFZmPKQoNDUhvXdnrjfgD4HmzGc31KKkl9y68rws8T+CkDrWQTYK/5ELkBxBOIH/wfZnR/SHK1ZdBJ0GveFB++ykxcDIz26mm9WudDyssyxLR4p81R79wuAHyaXeAx5AyhKchHaCaYzYhyk6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273374; c=relaxed/simple;
	bh=jKKFSiOgumrI/CYJElT/KK5tE9WcL353AroqtODhQlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F9tFyY39FSsQsbKOkb9CPMxjVrXgprbGdCp3IB2+VsFsVq99+UHYNKUhw68+ozRnF5NsDeCILr/JufT8o43s1y7jHsocT7NY4zMw+bV60924taLPldvVX/ElGxwT+t8eoWBCJYjBEcRyXfqAiueWUyQfUdK41uismaKPdM3aweA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h1hNV3Cw8zKHLwm;
	Fri, 17 Jul 2026 15:28:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A595A4056F;
	Fri, 17 Jul 2026 15:29:17 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDH1XHM2VlqGyogBg--.61085S2;
	Fri, 17 Jul 2026 15:29:17 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v2] bpf, cgroup: Fix storage null-ptr-deref after replacing prog
Date: Fri, 17 Jul 2026 07:33:43 +0000
Message-Id: <20260717073343.958862-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDH1XHM2VlqGyogBg--.61085S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF13ArW3Zw17Ar4DXFWrXwb_yoW5uw43pF
	1DAwn8tw15J39avFn7J3y2vFy3Xa10qr1UKrZ8Jw1Fka17tayFgry7CryYva43ZF1DWr1S
	qw1YqF4jk3WUZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
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

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v2:
- Fix invalid access for in-place update when storage changed. (Sashiko)

v1: https://lore.kernel.org/bpf/20260714014659.401063-1-pulehui@huaweicloud.com

 kernel/bpf/cgroup.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4355ccb78a9c..e2fa0ebeed83 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1032,11 +1032,17 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
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
@@ -1056,10 +1062,39 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
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

