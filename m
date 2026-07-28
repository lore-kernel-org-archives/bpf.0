Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED63442BE8F;
	Tue, 28 Jul 2026 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244747; cv=none; b=gfFxTPcyzcNrSZxG3Gsx6TxpZgxXWpwAXY4ivWVpBfI4Zk6Y8ygPUuPMqD7Am3+p+eV8QyuteKTuXZVACkegvpC7xbyUkRscm2NhBdvaJkalBgKez+1CStt5bHN12rZV2+sMdzqOu9ZMRYpMMutWprql0/ZT+MpHUK+D3mULr3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244747; c=relaxed/simple;
	bh=z0rmHFytq959MVNfM//04A9jM8KREs9x0PTBykedlA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ghkGvnWCryY68r88y4+JuNywQ3XqR4FiIUf0MJJaNLnXdJiaN4lfVsoQHjPV03Ww0fxePDaIvYn0X6kNAXiXGtManCuEoG6sI8JD2Ncc7vWmaH0dro3+l8TpTzpBcttCS9Ke29Kv82Ql+EbnFawlngCJH6ZqVKud/BE1AjlPGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h8bcb2chhzKHMlR;
	Tue, 28 Jul 2026 21:18:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D1D7C40561;
	Tue, 28 Jul 2026 21:19:00 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBXRURDrGhqDtAJAQ--.53278S2;
	Tue, 28 Jul 2026 21:19:00 +0800 (CST)
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
Subject: [PATCH bpf] bpf, cgroup: Fix potential UAF in __cgroup_bpf_attach
Date: Tue, 28 Jul 2026 13:23:36 +0000
Message-Id: <20260728132336.2857800-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXRURDrGhqDtAJAQ--.53278S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy8AF1xAw4rWFWkZF1UWrg_yoW5Xw4DpF
	1kX3Z8ta15X39a9F1kt34vvFs5uF40qr1jkrZ8tw4Fgay7trZYg34xuryavF9xZFnrur1f
	tF1YvF1qkw1jvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
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

When replacing an existing bpf_link in single-attach case in
__cgroup_bpf_attach, old_prog is NULL while old_link holds the active
link. If attachment fails midway (bpf_trampoline_link_cgroup_shim or
update_effective_progs), the cleanup check `if (!old_prog)` wrongly
treats the existing pl entry as newly allocated, calling kfree() and
causing a UAF.

Additionally, original flags and storage state are not restored on
failure.

Fix this by checking `!old_prog && !old_link` before freeing pl, and
properly restoring all previous states on error.

Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program attachment")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/cgroup.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index e2fa0ebeed83..e22e7dfe0022 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -811,10 +811,13 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 {
 	u32 saved_flags = (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI));
 	struct bpf_prog *old_prog = NULL;
+	struct bpf_cgroup_link *old_link = NULL;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
+	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_prog *new_prog = prog ? : link->link.prog;
 	enum cgroup_bpf_attach_type atype;
+	u32 old_flags, old_pl_flags;
 	struct bpf_prog_list *pl;
 	struct hlist_head *progs;
 	int err;
@@ -865,6 +868,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 
 	if (pl) {
 		old_prog = pl->prog;
+		old_link = pl->link;
+		old_pl_flags = pl->flags;
+		bpf_cgroup_storages_assign(old_storage, pl->storage);
 	} else {
 		pl = kmalloc_obj(*pl);
 		if (!pl) {
@@ -884,6 +890,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	pl->link = link;
 	pl->flags = flags;
 	bpf_cgroup_storages_assign(pl->storage, storage);
+	old_flags = cgrp->bpf.flags[atype];
 	cgrp->bpf.flags[atype] = saved_flags;
 
 	if (type == BPF_LSM_CGROUP) {
@@ -912,15 +919,18 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 		bpf_trampoline_unlink_cgroup_shim(new_prog);
 
 cleanup:
-	if (old_prog) {
+	if (old_prog || old_link) {
 		pl->prog = old_prog;
-		pl->link = NULL;
+		pl->link = old_link;
+		pl->flags = old_pl_flags;
+		bpf_cgroup_storages_assign(pl->storage, old_storage);
 	}
 	bpf_cgroup_storages_free(new_storage);
-	if (!old_prog) {
+	if (!old_prog && !old_link) {
 		hlist_del(&pl->node);
 		kfree(pl);
 	}
+	cgrp->bpf.flags[atype] = old_flags;
 	return err;
 }
 
-- 
2.34.1

