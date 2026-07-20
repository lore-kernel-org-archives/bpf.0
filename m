Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D2393DE8;
	Mon, 20 Jul 2026 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518007; cv=none; b=ROeVjJvEloiFjAVMx+qMJiDWJOL1cjN1D5xoEM7gErVkeu0ovdUR/G2lgPGx5/0TvP+UXJX9Lzi6q8R5rnmnoRiqU5MsGUnnLlJF9Mf2NSsvm4ODIyr0ZvjWxqCQHy+tTCeFUQu5dYFPAAgRa4LtHFbqeTu3CmILdoe74sLcZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518007; c=relaxed/simple;
	bh=2JunEdrPcLhl3BZ8kfAyGiRjIBTY9wGsAlAMNwKo4fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U7buImdYb6BPoHyKlhcuedt1I4ummDblxg1WDX5B5iHVhjFyak9x+lPF/6GKw5bBUjJMlFJh/WtWW9DzGE5WIxluV9IyalnXsdbM8iF7IWabCc0s+iASOrunUK/8zJ0DyeJtjEagWEvG/oDL3p0Qnm7itennUovZkDatCphR/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h3QsK2XGwzYQtxm;
	Mon, 20 Jul 2026 11:26:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3078E40570;
	Mon, 20 Jul 2026 11:26:27 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDXMm9hlV1q56Z3Bw--.11895S3;
	Mon, 20 Jul 2026 11:26:27 +0800 (CST)
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
Subject: [PATCH bpf v3 1/3] bpf: Fix potential UAF when reading bpf link info
Date: Mon, 20 Jul 2026 03:30:53 +0000
Message-Id: <20260720033055.1215477-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720033055.1215477-1-pulehui@huaweicloud.com>
References: <20260720033055.1215477-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXMm9hlV1q56Z3Bw--.11895S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyfGryUurWUGF4UJw1fZwb_yoW5Xw1rpF
	W3GFn0ka15ur429F17Zr45urySgF48GFyUtF9rW34FyF1YqFZYg34UCrWfZr9IkF97GrWx
	X3y2va43Gr17XFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfU8XdbUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

In bpf_link_show_fdinfo and bpf_link_get_info_by_fd, link->prog is
accessed without holding any locks. If the prog is concurrently replaced
via bpf_link_update, the old prog can be freed, leading to a potential
UAF issue.

Fix this by holding both normal RCU and tasks trace RCU read locks
before dereferencing the prog, as BPF_LINK_TYPE_ITER support both
non-sleepable and sleepable progs.

Fixes: f9d041271cf4 ("bpf: Refactor bpf_link update handling")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/syscall.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6db306d23b47..2458c68146b9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3471,9 +3471,10 @@ static const char *bpf_link_type_strs[] = {
 static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 {
 	const struct bpf_link *link = filp->private_data;
-	const struct bpf_prog *prog = link->prog;
+	const struct bpf_prog *prog;
 	enum bpf_link_type type = link->type;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
+	u32 prog_id;
 
 	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
 		if (link->type == BPF_LINK_TYPE_KPROBE_MULTI)
@@ -3490,13 +3491,23 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 	}
 	seq_printf(m, "link_id:\t%u\n", link->id);
 
+	/* prog can be sleepable */
+	rcu_read_lock_trace();
+	rcu_read_lock();
+	prog = READ_ONCE(link->prog);
 	if (prog) {
 		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
+		prog_id = prog->aux->id;
+	}
+	rcu_read_unlock();
+	rcu_read_unlock_trace();
+
+	if (prog) {
 		seq_printf(m,
 			   "prog_tag:\t%s\n"
 			   "prog_id:\t%u\n",
 			   prog_tag,
-			   prog->aux->id);
+			   prog_id);
 	}
 	if (link->ops->show_fdinfo)
 		link->ops->show_fdinfo(link, m);
@@ -5535,6 +5546,7 @@ static int bpf_link_get_info_by_fd(struct file *file,
 {
 	struct bpf_link_info __user *uinfo = u64_to_user_ptr(attr->info.info);
 	struct bpf_link_info info;
+	const struct bpf_prog *prog;
 	u32 info_len = attr->info.info_len;
 	int err;
 
@@ -5549,8 +5561,15 @@ static int bpf_link_get_info_by_fd(struct file *file,
 
 	info.type = link->type;
 	info.id = link->id;
-	if (link->prog)
-		info.prog_id = link->prog->aux->id;
+
+	/* prog can be sleepable */
+	rcu_read_lock_trace();
+	rcu_read_lock();
+	prog = READ_ONCE(link->prog);
+	if (prog)
+		info.prog_id = prog->aux->id;
+	rcu_read_unlock();
+	rcu_read_unlock_trace();
 
 	if (link->ops->fill_link_info) {
 		err = link->ops->fill_link_info(link, &info);
-- 
2.34.1

