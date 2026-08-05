Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC237AA92;
	Wed,  5 Aug 2026 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785901748; cv=none; b=EIDruHqV6ACe4WcdnAfuGoCrtt/LLQjLKVaaKUyEMU/zuvPMA5eMRfENcyG69RLj7DZ4hrgMYS6+VyjJpLeFNcUoN1wcBo+miMBHkww1WMiDXyc2LKpvAMlJROHNRbG/GgMsztTmW6H8nc085C2xsExMjLtzpLAhyUxLeHkCm1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785901748; c=relaxed/simple;
	bh=QS/0Apnh0Jwyvpj+YffDwNJ8k267ZzE2B/vruGP/qR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bzgZsLt5uAayD0lghgnGrBSs2FAWKmtKNiBF3dfwp7jZJqBIELAEM9Oa4wyHT+WMjPstwD74SEC9FD6A2gqiz9UxBzPlX7y5YMexbzZEFY20wPSrvbmHk5MR9gnFdp8M9uKVbqO0Ucc12y3EnDTxC8S+2YNAPNKO1VzOaXKyAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hFGbD4tJbzYQtvw;
	Wed,  5 Aug 2026 11:48:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1A7BD4056F;
	Wed,  5 Aug 2026 11:49:01 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3Z0arsnJqHl2pBA--.31224S2;
	Wed, 05 Aug 2026 11:49:00 +0800 (CST)
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
Subject: [PATCH bpf v5] bpf, cgroup: Fix storage null-ptr-deref after replacing prog
Date: Wed,  5 Aug 2026 03:53:42 +0000
Message-Id: <20260805035342.349421-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3Z0arsnJqHl2pBA--.31224S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF13ArW3Zw17Aw1DAF4rGrg_yoW5CF17pF
	4DAr15Ww1Ygr4vvrs7J34IvrWavan5tr1UKrZxXw1rAF42kFW09ryxurWYvFy3ZF9Fgryf
	tw1aqFWDKa42v37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
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

Fix this by rejecting link update with -EPERM if new_prog's cgroup
storage is incompatible with link->prog.

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v5:
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

