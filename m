Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425D385516;
	Sat, 23 May 2026 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779528059; cv=none; b=IYQOdy8gyHUxuWQH0Wd4Fl8rsi1gjFS5vgTMLcIzD2nOrtmVOwvEKlP5dEOtzsDdMxYd/0CY3egRB2O2O+dfOcdM6wFCrddk7x21irvVW9IQeDDVB4ds0uaoj4d5/gKGrsRB+0pQNyW+KskPwQW4YFtODCRmOI6BDwNlnnA9Tsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779528059; c=relaxed/simple;
	bh=GVWAfMF5gHb2uG3uG0vh8+bYmhf/M0bQ1PrJr46hNJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUQ0J0vFC6NUf1WmAyha4Ryg1Dese46Z93D9LuYa5t0QXu3aFKnzoBh0rE45f827c6vL8ch2WqzvtaXFF+HDK38M5la7EvdpdV9X5aVQUqNh9DtZsotBu1S1Fq5cWL3psCU8o74TJOZcC0Bu9YSUbsPWmvKC63qA7HKBsW1RGKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gMxT34XjwzKHMc1;
	Sat, 23 May 2026 17:20:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A1BA140573;
	Sat, 23 May 2026 17:20:47 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with SMTP id gCh0CgC3flpscRFqWE9VDQ--.41561S4;
	Sat, 23 May 2026 17:20:47 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH bpf 2/2] selftests/bpf: Add return value tests for lsm cgroup
Date: Sat, 23 May 2026 08:58:06 +0000
Message-ID: <20260523085806.417723-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523085806.417723-1-xukuohai@huaweicloud.com>
References: <20260523085806.417723-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3flpscRFqWE9VDQ--.41561S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyDJw4fCryUtFyxJr1DZFb_yoW8urWrp3
	Z7A34DZ3sY9rW3Wr40gFWUZF1rXF4v9rWrXrZ3Xw1UAa4fJrsrJryIk34UJFnxtas8uwnI
	9Fs09FW3uryUta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UCZXrU
	UUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add tests to check return values set by bpf_set_retval() helper for lsm
cgroup programs.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/progs/verifier_lsm.c        | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
index 38e8e9176862..2072671ed643 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -188,4 +188,49 @@ int BPF_PROG(null_check, struct file *file)
 	return 0;
 }
 
+SEC("lsm_cgroup/socket_create")
+__description("lsm_cgroup with -4095~0 retval test 1")
+__success
+int BPF_PROG(lsm_cgroup_set_retval_zero_valid, struct task_struct *task)
+{
+	bpf_set_retval(0);
+	return 0;
+}
+
+SEC("lsm_cgroup/socket_create")
+__description("lsm_cgroup with -4095~0 retval test 2")
+__success
+int BPF_PROG(lsm_cgroup_set_retval_negative_valid, struct task_struct *task)
+{
+	bpf_set_retval(-12);
+	return 0;
+}
+
+SEC("lsm_cgroup/socket_create")
+__description("lsm_cgroup with -4095~0 retval test 3")
+__failure __msg("should have been in [-4095, 0]")
+int BPF_PROG(lsm_cgroup_set_retval_negative_invalid, struct task_struct *task)
+{
+	bpf_set_retval(-4096);
+	return 0;
+}
+
+SEC("lsm_cgroup/socket_create")
+__description("lsm_cgroup with -4095~0 retval test 4")
+__failure __msg("should have been in [-4095, 0]")
+int BPF_PROG(lsm_cgroup_set_retval_positive_invalid, struct task_struct *task)
+{
+	bpf_set_retval(1);
+	return 0;
+}
+
+SEC("lsm_cgroup/file_release")
+__description("lsm_cgroup bpf_set_retval on void hook test")
+__failure __msg("BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value")
+int BPF_PROG(lsm_cgroup_set_retval_for_void_hook, struct file *file)
+{
+	bpf_set_retval(0);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

