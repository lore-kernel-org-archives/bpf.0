Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF3426D2E;
	Mon, 20 Jul 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554889; cv=none; b=py+jD4AE3oWJLAqQXh+ExGxDO7hPCIG4DeACUP8XAvCvkCHA3s0E3CiYky9PaVSkWdeWWV8FwjVPNf7AmD8t9p/I7e77R81qQyGvoXvv5PqVg13l5ZvTEQ6LDsJRsSLX4cUcowpeajWSYlx5cXIAoC1Vjlls16bRMIpbhD3B0dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554889; c=relaxed/simple;
	bh=hB60V6OwzV5OdjIuZ3aCVbVNuw5mBlyw7PI3r840VR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cCwBO25Xq7dkf5+Kt5FxbEfBCL49cbG8gY2rpkgbSlgyOIJQPzfz9GQD3hDV51CPbYVRz2lkCZHEl0afEpWO256P02p2kwE2M5twqKfJ8rtncgZbrMiI2M9zLmyE3LAvhDn2PKL9kt2e67I17LsXPViaYeX+ZH7ZhcFJPAyISnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h3hVX3f01zYQtyM;
	Mon, 20 Jul 2026 21:40:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2E566407D5;
	Mon, 20 Jul 2026 21:41:18 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDn9XF8JV5qIAesBw--.40451S4;
	Mon, 20 Jul 2026 21:41:18 +0800 (CST)
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
Subject: [PATCH bpf v4 2/4] bpf: Fix UAF due to missing link type check in mprog
Date: Mon, 20 Jul 2026 13:45:45 +0000
Message-Id: <20260720134547.1289964-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720134547.1289964-1-pulehui@huaweicloud.com>
References: <20260720134547.1289964-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn9XF8JV5qIAesBw--.40451S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr47Gr4kXFWfCw1UGry8Zrb_yoW5ZF1xpF
	s3Jryvyr1Yv3y7XF4jvF1fArWY9F48Wr1jka4rWw4vvFn09a1vqF13Wr4Sqw15KFZ8Jwsa
	vw1qqryDJ34DXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUOdgAUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

In bpf_mprog_link, the code does not check the link->type first before
dereferencing link->prog->type. This missing validation allows a user to
pass an abnormal non-netkit or non-tcx link via relative_fd. If do
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

Fix this by strictly validate link->type in bpf_mprog_link against the
expected link type. bpf_mprog_tuple_relative is also adjusted to accept
and pass down the expected link type.

Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for multi-progs")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/mprog.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
index 1394168062e8..367f8f10da0a 100644
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
@@ -243,6 +244,8 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
 		return -EEXIST;
 	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd,
 				       flags & ~BPF_F_REPLACE,
+				       link ? link->type :
+				       BPF_LINK_TYPE_UNSPEC,
 				       prog_new->type);
 	if (ret)
 		return ret;
@@ -343,6 +346,8 @@ int bpf_mprog_detach(struct bpf_mprog_entry *entry,
 	if (!bpf_mprog_total(entry))
 		return -ENOENT;
 	ret = bpf_mprog_tuple_relative(&rtuple, id_or_fd, flags,
+				       link ? link->type :
+				       BPF_LINK_TYPE_UNSPEC,
 				       prog ? prog->type :
 				       BPF_PROG_TYPE_UNSPEC);
 	if (ret)
-- 
2.34.1

