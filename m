Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEADA372EF0;
	Wed, 22 Jul 2026 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704740; cv=none; b=J6WYHNDRTza/9SFO3MP8At7I1eGooVVKLXVFXGUuMwXOPjHf2W2+KDVe9SjJjyOCerN9NYAZ86lG1/Zr+E1mVGBOqlOI4h5dYVr3+z5rVWk7+o0aSIbKfRzRvXiS9TFxkafTo1m6J0OCoxtNoxF/BkKqa9gAG3/a+HDffO/6oos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704740; c=relaxed/simple;
	bh=5p5KnCCkjhxaTDPY8p++gCJCVjU1e8U5eMnQBy4BZrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MHrYPfBnQHvSguoFluoz/8BbgFJHoU/bbn2rvJGhO6t2e8zFMXSpZ3yGLdAXApxRzNzxV1nfbUw7Q6l4gN8WymFXVBFv12RM+ysOdNt+EjQ938zOM/d4JT7Y9AAEB9tetSTlz5QzcdBqesEOXe50U8Q0MJkBtSdXpDnYVrnoBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h4lwL70m6zYQtth;
	Wed, 22 Jul 2026 15:18:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9AF6F4061C;
	Wed, 22 Jul 2026 15:18:55 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCHl3PfbmBqGBB_CA--.17870S4;
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
Subject: [PATCH bpf v6 2/4] bpf: Fix UAF due to missing link type check in mprog
Date: Wed, 22 Jul 2026 07:23:24 +0000
Message-Id: <20260722072326.1545677-3-pulehui@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgCHl3PfbmBqGBB_CA--.17870S4
X-Coremail-Antispam: 1UD129KBjvJXoWfJF4rGFWfGF45Ww48AF1fJFb_yoWDXF1xpF
	WfJFyvyry0q3y7XF40qa18A3y5uF40gr17CFy5K34Y9FnF9Fn2qFy5WrWYy34YyrZ8CFs7
	ZF1Utr98XryUXrUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
	WIevJa73UjIFyTuYvjTRRCJPDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

In bpf_mprog_link, the code does not check the link->type first before
dereferencing link->prog->type. This missing validation allows a user to
pass an abnormal non-netkit or non-tcx link via relative_fd. If doing
BPF_LINK_UPDATE on the abnormal link, it can trigger a UAF issue.

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
safe: it may have been freed. Therefore, we need to validate link->type
to reject foreign anchors.

Fix this by strictly validating link->type in bpf_mprog_link against the
expected link type. mprog APIs is also adjusted to accept and pass down
the expected link type. Meanwhile, add a comment explaining that when
ptype == UNSPEC in bpf_mprog_detach, it acts as a wildcard.

Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for multi-progs")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 drivers/net/netkit.c      | 13 ++++++-------
 include/linux/bpf_mprog.h |  6 ++++--
 kernel/bpf/mprog.c        | 23 ++++++++++++++---------
 kernel/bpf/tcx.c          | 13 ++++++-------
 4 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index a3931cd82132..99ddf2befb23 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -768,7 +768,7 @@ int netkit_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	}
 	ret = bpf_mprog_attach(entry, &entry_new, prog, NULL, replace_prog,
 			       attr->attach_flags, attr->relative_fd,
-			       attr->expected_revision);
+			       attr->expected_revision, BPF_LINK_TYPE_NETKIT);
 	if (!ret) {
 		if (entry != entry_new) {
 			netkit_entry_update(dev, entry_new);
@@ -802,7 +802,7 @@ int netkit_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto out;
 	}
 	ret = bpf_mprog_detach(entry, &entry_new, prog, NULL, attr->attach_flags,
-			       attr->relative_fd, attr->expected_revision);
+			       attr->relative_fd, attr->expected_revision, BPF_LINK_TYPE_NETKIT);
 	if (!ret) {
 		if (!bpf_mprog_total(entry_new))
 			entry_new = NULL;
@@ -850,7 +850,7 @@ static int netkit_link_prog_attach(struct bpf_link *link, u32 flags,
 	ASSERT_RTNL();
 	entry = netkit_entry_fetch(dev, true);
 	ret = bpf_mprog_attach(entry, &entry_new, link->prog, link, NULL, flags,
-			       id_or_fd, revision);
+			       id_or_fd, revision, BPF_LINK_TYPE_NETKIT);
 	if (!ret) {
 		if (entry != entry_new) {
 			netkit_entry_update(dev, entry_new);
@@ -877,7 +877,7 @@ static void netkit_link_release(struct bpf_link *link)
 		ret = -ENOENT;
 		goto out;
 	}
-	ret = bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 0, 0);
+	ret = bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 0, 0, BPF_LINK_TYPE_NETKIT);
 	if (!ret) {
 		if (!bpf_mprog_total(entry_new))
 			entry_new = NULL;
@@ -919,9 +919,8 @@ static int netkit_link_update(struct bpf_link *link, struct bpf_prog *nprog,
 		ret = -ENOENT;
 		goto out;
 	}
-	ret = bpf_mprog_attach(entry, &entry_new, nprog, link, oprog,
-			       BPF_F_REPLACE | BPF_F_ID,
-			       link->prog->aux->id, 0);
+	ret = bpf_mprog_attach(entry, &entry_new, nprog, link, oprog, BPF_F_REPLACE | BPF_F_ID,
+			       link->prog->aux->id, 0, BPF_LINK_TYPE_NETKIT);
 	if (!ret) {
 		WARN_ON_ONCE(entry != entry_new);
 		oprog = xchg(&link->prog, nprog);
diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
index 0b9f4caeeb0a..1fbe1a923968 100644
--- a/include/linux/bpf_mprog.h
+++ b/include/linux/bpf_mprog.h
@@ -321,12 +321,14 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
 		     struct bpf_mprog_entry **entry_new,
 		     struct bpf_prog *prog_new, struct bpf_link *link,
 		     struct bpf_prog *prog_old,
-		     u32 flags, u32 id_or_fd, u64 revision);
+		     u32 flags, u32 id_or_fd, u64 revision,
+		     enum bpf_link_type expected_link_type);
 
 int bpf_mprog_detach(struct bpf_mprog_entry *entry,
 		     struct bpf_mprog_entry **entry_new,
 		     struct bpf_prog *prog, struct bpf_link *link,
-		     u32 flags, u32 id_or_fd, u64 revision);
+		     u32 flags, u32 id_or_fd, u64 revision,
+		     enum bpf_link_type expected_link_type);
 
 int bpf_mprog_query(const union bpf_attr *attr, union bpf_attr __user *uattr,
 		    struct bpf_mprog_entry *entry);
diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
index 1394168062e8..b4a1b35ff569 100644
--- a/kernel/bpf/mprog.c
+++ b/kernel/bpf/mprog.c
@@ -6,7 +6,7 @@
 
 static int bpf_mprog_link(struct bpf_tuple *tuple,
 			  u32 id_or_fd, u32 flags,
-			  enum bpf_prog_type type)
+			  enum bpf_link_type type)
 {
 	struct bpf_link *link = ERR_PTR(-EINVAL);
 	bool id = flags & BPF_F_ID;
@@ -17,7 +17,7 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
 		link = bpf_link_get_from_fd(id_or_fd);
 	if (IS_ERR(link))
 		return PTR_ERR(link);
-	if (type && link->prog->type != type) {
+	if (type && link->type != type) {
 		bpf_link_put(link);
 		return -EINVAL;
 	}
@@ -52,21 +52,22 @@ static int bpf_mprog_prog(struct bpf_tuple *tuple,
 
 static int bpf_mprog_tuple_relative(struct bpf_tuple *tuple,
 				    u32 id_or_fd, u32 flags,
-				    enum bpf_prog_type type)
+				    enum bpf_link_type ltype,
+				    enum bpf_prog_type ptype)
 {
 	bool link = flags & BPF_F_LINK;
 	bool id = flags & BPF_F_ID;
 
 	memset(tuple, 0, sizeof(*tuple));
 	if (link)
-		return bpf_mprog_link(tuple, id_or_fd, flags, type);
+		return bpf_mprog_link(tuple, id_or_fd, flags, ltype);
 	/* If no relevant flag is set and no id_or_fd was passed, then
 	 * tuple link/prog is just NULLed. This is the case when before/
 	 * after selects first/last position without passing fd.
 	 */
 	if (!id && !id_or_fd)
 		return 0;
-	return bpf_mprog_prog(tuple, id_or_fd, flags, type);
+	return bpf_mprog_prog(tuple, id_or_fd, flags, ptype);
 }
 
 static void bpf_mprog_tuple_put(struct bpf_tuple *tuple)
@@ -226,7 +227,8 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
 		     struct bpf_mprog_entry **entry_new,
 		     struct bpf_prog *prog_new, struct bpf_link *link,
 		     struct bpf_prog *prog_old,
-		     u32 flags, u32 id_or_fd, u64 revision)
+		     u32 flags, u32 id_or_fd, u64 revision,
+		     enum bpf_link_type expected_link_type)
 {
 	struct bpf_tuple rtuple, ntuple = {
 		.prog = prog_new,
@@ -243,6 +245,7 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
 		return -EEXIST;
 	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd,
 				       flags & ~BPF_F_REPLACE,
+				       expected_link_type,
 				       prog_new->type);
 	if (ret)
 		return ret;
@@ -328,7 +331,8 @@ static int bpf_mprog_fetch(struct bpf_mprog_entry *entry,
 int bpf_mprog_detach(struct bpf_mprog_entry *entry,
 		     struct bpf_mprog_entry **entry_new,
 		     struct bpf_prog *prog, struct bpf_link *link,
-		     u32 flags, u32 id_or_fd, u64 revision)
+		     u32 flags, u32 id_or_fd, u64 revision,
+		     enum bpf_link_type expected_link_type)
 {
 	struct bpf_tuple rtuple, dtuple = {
 		.prog = prog,
@@ -343,8 +347,9 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
 	if (!bpf_mprog_total(entry))
 		return -ENOENT;
 	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
-				       prog ? prog->type :
-				       BPF_PROG_TYPE_UNSPEC);
+				       expected_link_type,
+				       /* Use UNSPEC as wildcard when prog is NULL */
+				       prog ? prog->type : BPF_PROG_TYPE_UNSPEC);
 	if (ret)
 		return ret;
 	if (dtuple.prog) {
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 02db0113b8e7..f208cef13a98 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -38,7 +38,7 @@ int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	}
 	ret = bpf_mprog_attach(entry, &entry_new, prog, NULL, replace_prog,
 			       attr->attach_flags, attr->relative_fd,
-			       attr->expected_revision);
+			       attr->expected_revision, BPF_LINK_TYPE_TCX);
 	if (!ret) {
 		if (entry != entry_new) {
 			tcx_entry_update(dev, entry_new, ingress);
@@ -76,7 +76,7 @@ int tcx_prog_detach(const union bpf_attr *attr, struct bpf_prog *prog)
 		goto out;
 	}
 	ret = bpf_mprog_detach(entry, &entry_new, prog, NULL, attr->attach_flags,
-			       attr->relative_fd, attr->expected_revision);
+			       attr->relative_fd, attr->expected_revision, BPF_LINK_TYPE_TCX);
 	if (!ret) {
 		if (!tcx_entry_is_active(entry_new))
 			entry_new = NULL;
@@ -152,7 +152,7 @@ static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 id_or_fd,
 	if (!entry)
 		return -ENOMEM;
 	ret = bpf_mprog_attach(entry, &entry_new, link->prog, link, NULL, flags,
-			       id_or_fd, revision);
+			       id_or_fd, revision, BPF_LINK_TYPE_TCX);
 	if (!ret) {
 		if (entry != entry_new) {
 			tcx_entry_update(dev, entry_new, ingress);
@@ -183,7 +183,7 @@ static void tcx_link_release(struct bpf_link *link)
 		ret = -ENOENT;
 		goto out;
 	}
-	ret = bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 0, 0);
+	ret = bpf_mprog_detach(entry, &entry_new, link->prog, link, 0, 0, 0, BPF_LINK_TYPE_TCX);
 	if (!ret) {
 		if (!tcx_entry_is_active(entry_new))
 			entry_new = NULL;
@@ -229,9 +229,8 @@ static int tcx_link_update(struct bpf_link *link, struct bpf_prog *nprog,
 		ret = -ENOENT;
 		goto out;
 	}
-	ret = bpf_mprog_attach(entry, &entry_new, nprog, link, oprog,
-			       BPF_F_REPLACE | BPF_F_ID,
-			       link->prog->aux->id, 0);
+	ret = bpf_mprog_attach(entry, &entry_new, nprog, link, oprog, BPF_F_REPLACE | BPF_F_ID,
+			       link->prog->aux->id, 0, BPF_LINK_TYPE_TCX);
 	if (!ret) {
 		WARN_ON_ONCE(entry != entry_new);
 		oprog = xchg(&link->prog, nprog);
-- 
2.34.1

