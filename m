Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1F54302EA;
	Fri,  7 Aug 2026 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099173; cv=none; b=BHcSO7NWEHAtv9fDOR+3hCi5M2tUFbtsxhlMkSPfe1rGygyOfOMZHbO4MeSYut0pBAGNMrFMWwINoafrhSLP3sEALwjYb1gNjEFvbbgiZvXql8GZ82NNLtMGDDTW8LBuMcDnI9lpQVOYLFdFn9Uo+UnPBpf7L8S+njsLWS/QATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099173; c=relaxed/simple;
	bh=qztSZqbVH+51nmCpoFXWlIHiIknOTSX5rsof7KP7AIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rr++xU1zB5j1sc2BT7avIsC01uGypMp2DBmHsTFfh90MIAWglH2NsJ7QpeFqgRke+VJrnYzvhCPZPiWAs1H2gpysMqDJp1ypF2n8Jk7L8XntC5MlZ3MLms98xa6/X2dqHMnd0N2QUlipttYag5MoUhxi/X5aCgQv17vyIXvHWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hGgbg4BZRzYQvXl;
	Fri,  7 Aug 2026 18:38:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D2CC04058D;
	Fri,  7 Aug 2026 18:39:19 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgDn1UTWtXVqt1DBBQ--.14391S2;
	Fri, 07 Aug 2026 18:39:19 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Amery Hung <ameryhung@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v6] bpf, cgroup: Fix storage null-ptr-deref after replacing prog
Date: Fri,  7 Aug 2026 10:44:03 +0000
Message-Id: <20260807104403.1013064-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDn1UTWtXVqt1DBBQ--.14391S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF13ArW3Zw17Aw4DKrWDtwb_yoW5ur17pF
	4DZr15Ww1Ygr4vvrs7t34IvFWavw4rtr1UKrZxJw1rZF42kFy09ryxu3yYvFy3ZF9Fgryf
	twnIvFWDKa42v37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
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

Fix this by rejecting a link update if new_prog's cgroup storage is
incompatible with link->prog.

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v6:
- Update inconsistent commit msg.
- Add Acked-by tag by Leon.

v5: https://lore.kernel.org/bpf/20260805035342.349421-1-pulehui@huaweicloud.com
- Reject link update if new_prog's storage is incompatible with link->prog. (Andrii)

v4: https://lore.kernel.org/bpf/20260728133058.2858367-1-pulehui@huaweicloud.com
- Extract the fix for __cgroup_bpf_attach() into a standalone patch [0].
- Add Reviewed-by tag by Amery.
- Separate from patchset [1]. (Andrii)

Link: https://lore.kernel.org/bpf/20260728132336.2857800-1-pulehui@huaweicloud.com [0]
Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@huaweicloud.com [1]

v3: https://lore.kernel.org/bpf/20260720134547.1289964-5-pulehui@huaweicloud.com
- Include the storage and flags rollbacks to patch4 for sake of code rigor,
  as it's hard to make update_effective_progs fail in __cgroup_bpf_attach.

v2: https://lore.kernel.org/bpf/20260717073343.958862-1-pulehui@huaweicloud.com
- Fix invalid access for in-place update when storage changed. (Sashiko)

v1: https://lore.kernel.org/bpf/20260714014659.401063-1-pulehui@huaweicloud.com

 kernel/bpf/cgroup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 57fd1d784e44..31c63ff276fa 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1026,6 +1026,20 @@ static void replace_effective_prog(struct cgroup *cgrp,
 	}
 }
 
+static bool cgroup_bpf_storages_compatible(struct bpf_prog *old_prog,
+					   struct bpf_prog *new_prog)
+{
+	enum bpf_cgroup_storage_type stype;
+
+	for_each_cgroup_storage_type(stype) {
+		if (old_prog->aux->cgroup_storage[stype] !=
+		    new_prog->aux->cgroup_storage[stype])
+			return false;
+	}
+
+	return true;
+}
+
 /**
  * __cgroup_bpf_replace() - Replace link's program and propagate the change
  *                          to descendants
@@ -1064,6 +1078,9 @@ static int __cgroup_bpf_replace(struct cgroup *cgrp,
 	if (!found)
 		return -ENOENT;
 
+	if (!cgroup_bpf_storages_compatible(link->link.prog, new_prog))
+		return -EINVAL;
+
 	cgrp->bpf.revisions[atype] += 1;
 	old_prog = xchg(&link->link.prog, new_prog);
 	replace_effective_prog(cgrp, atype, pl);
-- 
2.34.1

