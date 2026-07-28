Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8E3191D3;
	Tue, 28 Jul 2026 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785224276; cv=none; b=CkBCrLHa8lTNY/SPkjsFYWbdRPblWEqcZ0t7yzozr6NsDd7hydjOPnTRemin1j+V4jMemnf9ceDthszGcUCXiTY93wWw/yqWEFRLioddEYFIpRMC7xpcFG9EWjTcVs6Hz/qFzuC82t+ptJykgkxc3x2cZ/52TGHJbwxCmb4P+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785224276; c=relaxed/simple;
	bh=3ne188fbzYrohrPMPCMgrOtWBZZQ5DhvqiSgEIs5lVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rlB4PhtXiLZ/ltYv0I/OeZ6RRW8p6UWDA0qS6wkqAligeQt1CfwSxhtXm/j66Y+JMd7IC5pwWipIEIyxLsJ3Nxw9K8vJwfT68zmGhOHvZzEwKrpyxEfp9Ov7A6+C3j8oftu56FEKOPgjDskD1nJDWlCg70AogjgExTETESG6Oos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h8S393JL2zYQtvx;
	Tue, 28 Jul 2026 15:37:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6BBEB40570;
	Tue, 28 Jul 2026 15:37:48 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBHN0ZLXGhqmhDtAA--.47842S2;
	Tue, 28 Jul 2026 15:37:48 +0800 (CST)
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
Subject: [PATCH bpf v4] bpf: Fix UAF when reading prog type in bpf_mprog_link
Date: Tue, 28 Jul 2026 07:42:23 +0000
Message-Id: <20260728074223.2831773-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBHN0ZLXGhqmhDtAA--.47842S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyUtr4DAw1rtF17uF1Dtrb_yoWrGFWUpF
	s3J34kGw1jgrW2qw48Zry7ury5uF48Kw17Gas8uw4F9FnI9FyFvryxWr4rZr1rGrWqga93
	XF1qqFyvk34DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

In bpf_mprog_link, the code currently allows a user to pass an abnormal
non-netkit or non-tcx link via relative_fd. If a concurrent
BPF_LINK_UPDATE is performed on this abnormal link before dereferencing
link->prog->type in bpf_mprog_link(), it can trigger a UAF issue.

CPU0                                      CPU1
netkit_link_prog_attach
bpf_mprog_attach
bpf_mprog_tuple_relative
bpf_mprog_link
  /* non-netkit or non-tcx link */
  link = bpf_link_get_from_fd(id_or_fd);
                                          BPF_LINK_UPDATE on relative link
                                          ...
                                          old_prog = xchg(&link->link.prog, new_prog);
                                          bpf_prog_put(old_prog);
  if (type && link->prog->type != type) <-- trigger UAF

The reason for the UAF is that each subsystem provides its own
protection for link->prog. Since there is no cross subsystem protection
(if not considering the RCU of prog tear down), dereferencing the prog
of an anchor link that does not belong to the current subsystem is not
safe: it may have been freed.

To resolve this, we access link->prog under RCU protection to safely
fetch the pointer and guarantee its lifetime during the type check.
Meanwhile, add a comment explaining that when ptype == UNSPEC in
bpf_mprog_detach, it acts as a wildcard.

Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for multi-progs")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v4:
- Access prog->type under rcu protection to simplify the repair logic,
  and let unconditional detachment make sense when the bare prog or
  link->prog being detached is NULL.
- Add Reviewed-by tag by Emil.
- Separate from patchset [0]. (Andrii)

Link: https://lore.kernel.org/bpf/f87b53c0-8f00-45a6-82db-8242fa9b143f@huaweicloud.com [0]

v3: https://lore.kernel.org/bpf/20260722072326.1545677-3-pulehui@huaweicloud.com
- BPF_F_LINK flag set means the relative id_or_fd is a link, not the object being
  attached. We can not get the link while attach a bare prog with relative link.
  So passing expected link type from callers of bpf_mprog_attach/detach. (Sashiko)
- Add comment to explain that why ptype == UNSPEC. (Emil)

v2: https://lore.kernel.org/bpf/20260721041048.1394085-3-pulehui@huaweicloud.com
- Improve commit msg for patch 2. (Amery)

v1: https://lore.kernel.org/bpf/20260720134547.1289964-3-pulehui@huaweicloud.com

 kernel/bpf/mprog.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
index 1394168062e8..af3e6c1c6a1f 100644
--- a/kernel/bpf/mprog.c
+++ b/kernel/bpf/mprog.c
@@ -10,6 +10,8 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
 {
 	struct bpf_link *link = ERR_PTR(-EINVAL);
 	bool id = flags & BPF_F_ID;
+	bool type_mismatch = false;
+	struct bpf_prog *prog;
 
 	if (id)
 		link = bpf_link_by_id(id_or_fd);
@@ -17,13 +19,20 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
 		link = bpf_link_get_from_fd(id_or_fd);
 	if (IS_ERR(link))
 		return PTR_ERR(link);
-	if (type && link->prog->type != type) {
+
+	rcu_read_lock();
+	prog = READ_ONCE(link->prog);
+	if (!prog || (type && prog->type != type))
+		type_mismatch = true;
+	rcu_read_unlock();
+
+	if (type_mismatch) {
 		bpf_link_put(link);
 		return -EINVAL;
 	}
 
 	tuple->link = link;
-	tuple->prog = link->prog;
+	tuple->prog = prog;
 	return 0;
 }
 
@@ -343,8 +352,8 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
 	if (!bpf_mprog_total(entry))
 		return -ENOENT;
 	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
-				       prog ? prog->type :
-				       BPF_PROG_TYPE_UNSPEC);
+				       /* Use UNSPEC as wildcard when prog is NULL */
+				       prog ? prog->type : BPF_PROG_TYPE_UNSPEC);
 	if (ret)
 		return ret;
 	if (dtuple.prog) {
-- 
2.34.1

