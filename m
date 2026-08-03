Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FA01E0B9C;
	Mon,  3 Aug 2026 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720901; cv=none; b=pwNiLtKxpU9yDnQ7IFo9U+uQhxTyrQ1ALKgaoGCvA7YVGjGH9DSebVqBorvm79Haa0hXitOEDQS//eC5oNFmuRplzsu3jIp7oELi9IyinAbIDlidMTg/rFr9USw77wu8wCVKeyk8Jd8kZx1E1NKaFI0dlXzeTXoooFDN6pioh00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720901; c=relaxed/simple;
	bh=yKWZBLrcKU+Jugj1XV2WZCKs4D8nX7SYgmLCpgOkaG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ex5PPv6SU6rVRBUiZUzjwFh8Yha31O/C5MOruylI8xekpJIonRXYzPIoJ3320TwURNVqEY0/lLIaqoqRkK0jl/UI57TRGwqi5fsYwbnXzRtkYOynwC+jpjc2eDW3APnxy9Wl8aGFxjij29LDBiO4M7U63olwjfLpUAKuDU+itKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hCzjT3ZshzYQtmp;
	Mon,  3 Aug 2026 09:34:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 52A2D40570;
	Mon,  3 Aug 2026 09:34:54 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgCXhUQ98G9qB+6oAw--.56178S2;
	Mon, 03 Aug 2026 09:34:54 +0800 (CST)
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
Subject: [PATCH bpf v3] bpf, cgroup: Fix invalid storage access after __cgroup_bpf_attach failed
Date: Mon,  3 Aug 2026 01:39:34 +0000
Message-Id: <20260803013934.4036646-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXhUQ98G9qB+6oAw--.56178S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF13ArWDJF1kAFyfJF18Xwb_yoW5Kr4fpF
	4kX3Z8J3W5X39YvF4kJ39FvF1rGa1vqr1jkrZ8Aw1Fkay7KF90g34xuryYvFy3ZFnruw1S
	yFn09F4qkF1jqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

A potential invalid storage access issue can occur after replacing a
cgroup bpf prog.

This occurs in the following scenario:
1. prog1 with storage is attached to a cgroup in multi-attach mode.
2. prog1 is replaced with prog2 using BPF_F_REPLACE in multi-attach
   mode, but fails midway (e.g. in bpf_trampoline_link_cgroup_shim or
   update_effective_progs).
3. A new prog3 is attached to the cgroup in multi-attach mode.

The reason is that __cgroup_bpf_attach overwrites pl->storage with the
new storage prior to attachment completion. When attachment fails
midway, the cleanup path calls bpf_cgroup_storages_free(new_storage) to
free the newly allocated storage, but fails to restore pl->storage back
to old_storage.

Consequently, the still-active prog1 holds invalid or dangling storage
pointers, leading to an invalid memory access when prog1 executes and
calls bpf_get_local_storage. Additionally, original pl->flags and
cgrp->bpf.flags[atype] are left unrestored.

Fix this by saving old_pl_flags, old_storage, and old_flags prior to the
update, and properly restoring all of them in the cleanup path on error.

Fixes: 7d9c3427894f ("bpf: Make cgroup storages shared between programs on the same cgroup")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
v3:
- Remove confusing commit message. (Emil)
- Add Reviewed-by tag by Emil.

v2: https://lore.kernel.org/bpf/20260729100208.3076769-1-pulehui@huaweicloud.com
- Remove the link relative code as link only support
  BPF_F_ALLOW_MULTI attach, so will not occur UAF pl.

v1: https://lore.kernel.org/bpf/20260728132336.2857800-1-pulehui@huaweicloud.com

 kernel/bpf/cgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index e2fa0ebeed83..be24ca453cab 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -813,8 +813,10 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	struct bpf_prog *old_prog = NULL;
 	struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
+	struct bpf_cgroup_storage *old_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
 	struct bpf_prog *new_prog = prog ? : link->link.prog;
 	enum cgroup_bpf_attach_type atype;
+	u32 old_flags, old_pl_flags;
 	struct bpf_prog_list *pl;
 	struct hlist_head *progs;
 	int err;
@@ -865,6 +867,8 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 
 	if (pl) {
 		old_prog = pl->prog;
+		old_pl_flags = pl->flags;
+		bpf_cgroup_storages_assign(old_storage, pl->storage);
 	} else {
 		pl = kmalloc_obj(*pl);
 		if (!pl) {
@@ -884,6 +888,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	pl->link = link;
 	pl->flags = flags;
 	bpf_cgroup_storages_assign(pl->storage, storage);
+	old_flags = cgrp->bpf.flags[atype];
 	cgrp->bpf.flags[atype] = saved_flags;
 
 	if (type == BPF_LSM_CGROUP) {
@@ -915,12 +920,15 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 	if (old_prog) {
 		pl->prog = old_prog;
 		pl->link = NULL;
+		pl->flags = old_pl_flags;
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
 
-- 
2.34.1

