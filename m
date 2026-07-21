Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E12EF653;
	Tue, 21 Jul 2026 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784606799; cv=none; b=izEeFaa5JSR5t5c2GjcrT+yzhS7dPSVIIN3oFn40pGhlWYdkOd26ouzMFNs1pHELK22ZzzAYVTYx2QJI/qnYX4BCVJGUR/RQImx3IqUBgEpHnq1xxe0eoQyWjK6+SUDcqAJ28S3+rUusa/NK65ZeTcH+WPoI/bthR0Zb674m3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784606799; c=relaxed/simple;
	bh=H/V0jVFnZ1pQMZit3JMtoGaXSaYiPGPcKaFv6kDu8RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpSPhdEdry5ZF/YiwfI1lHD/1vPv30cYa/DdKsiXY0yZoR/WpiK+RggFotYdBSu09Cj6+G+colZ6r25PNYyjP5FRA666/kRCSYfkxy6Gj6gXbYuGH3WVNbcnQxeGdwJsq87AfYmXZVW60Bski896uygUoP5XXUUJeaM1dIRrXms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h43hc1rgBzKHMPd;
	Tue, 21 Jul 2026 12:05:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E535F405B5;
	Tue, 21 Jul 2026 12:06:18 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAHF3M58F5qwav1Bw--.64145S4;
	Tue, 21 Jul 2026 12:06:18 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Amery Hung <ameryhung@gmail.com>
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
Subject: [PATCH bpf v5 2/4] bpf: Fix UAF due to missing link type check in mprog
Date: Tue, 21 Jul 2026 04:10:46 +0000
Message-Id: <20260721041048.1394085-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721041048.1394085-1-pulehui@huaweicloud.com>
References: <20260721041048.1394085-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHF3M58F5qwav1Bw--.64145S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr47Gr4kKry8tryxXr43Jrb_yoW5Kw4kpF
	s3JryvyF1Yv3y7XF4jvF1fAryY9F48Wr1jkas5Ww4vvrn0ga1vqF1fWr4Sqw15KFZ8Grsa
	vw1qqryDA34DXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUOdgAUUUUU
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
  link = bpf_link_get_from_fd(id_or_fd);
                                          BPF_LINK_UPDATE
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
expected link type. bpf_mprog_tuple_relative is also adjusted to accept
and pass down the expected link type.

Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for multi-progs")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/mprog.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
index 1394168062e8..37ce91e0bcd2 100644
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
@@ -243,6 +244,7 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
 		return -EEXIST;
 	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd,
 				       flags & ~BPF_F_REPLACE,
+				       link ? link->type : BPF_LINK_TYPE_UNSPEC,
 				       prog_new->type);
 	if (ret)
 		return ret;
@@ -343,6 +345,7 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
 	if (!bpf_mprog_total(entry))
 		return -ENOENT;
 	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
+				       link ? link->type : BPF_LINK_TYPE_UNSPEC,
 				       prog ? prog->type :
 				       BPF_PROG_TYPE_UNSPEC);
 	if (ret)
-- 
2.34.1

