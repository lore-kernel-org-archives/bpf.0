Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EAC3DB647;
	Mon, 20 Jul 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554893; cv=none; b=SNZEUacZ4ZTeHHTKXl/rRCgwFsTp4fYpqPT+gBXTTAtbczSLxFjIzJV702WOxlr1hJyLBHMKaSdOcfCFd3p0uKLNjwxzgoItJ8CWhhd72GTgw4toH8YFl5VhwlZp8VTozqD6cBlzUxRllRTdwph75nORiHqbJVzTn6oev4CJZCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554893; c=relaxed/simple;
	bh=/U653KpXYtfMy0gy6f3P5N8exn+7Iab6m3Bcx+8MD+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mb2tYf2CpBtZdUVLeEK48OTK0J9jxrb1Dt3wSQvxnjut1Tmb33kmkhULpzT7HtD5rPVhlCl6IAk2kQkLB57Sap8OApNcV3UUTh8I/84xa8HQxTpWqgrwcowHOtqOl0p7kARrp1yySBNcCCgs6i4+UZl3lXL2N71tHgSlksB+EjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h3hVX4NwKzYQv0p;
	Mon, 20 Jul 2026 21:40:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 482C640947;
	Mon, 20 Jul 2026 21:41:18 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDn9XF8JV5qIAesBw--.40451S5;
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
Subject: [PATCH bpf v4 3/4] bpf: Fix potential UAF when reading bpf link info
Date: Mon, 20 Jul 2026 13:45:46 +0000
Message-Id: <20260720134547.1289964-4-pulehui@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDn9XF8JV5qIAesBw--.40451S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyfGryUurWUGF4UJw1fZwb_yoW5Wr1fpF
	W3G3Wqka15ur4293W7ArW5urySgFW8WFyUKF9rW34FyF1aqrZYg34UCFWfZr9I9F97GrWf
	X3yjva43Gr17ZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7VUbpwZ7UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

In bpf_link_show_fdinfo and bpf_link_get_info_by_fd, link->prog is
accessed without holding any locks. If the prog is concurrently replaced
via bpf_link_update, the old prog can be freed, leading to a potential
UAF issue.

Fix this by holding both normal RCU and tasks trace RCU read locks
before dereferencing the prog, as BPF_LINK_TYPE_ITER support both
non-sleepable and sleepable progs.

Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
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

