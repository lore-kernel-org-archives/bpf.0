Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664D3FA5F0;
	Thu, 16 Jul 2026 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203061; cv=none; b=Lhns7HbKl0krmoQlBAy2UdIH60KZuQlXQNtaoMi8axQTTGSYs95rwDTJVp1CSsvaaZZczIvEPtsGmFDq/Xbtz5tbNFBHvJNycHoasPp51yifZQx3h7AKlb7YsIF4ZPGee5YVYMvWdt8x97RhY1UGOqP/gnOXKaqQDDHsEo6AUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203061; c=relaxed/simple;
	bh=we3UXBkNgV61YozjdH88dP9krx4vo5YA7Gzb/HWrdkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJV2JiPELjhhFzA1EHOd03lIDGtI56H0ZwxvtQ1xzr2c+wdukdvPoQbSxODOGsahC6MSRWWdOyC70mkxjS/+kURVP7uzrZUMP/6iO5xY5fq465lPIeJr6/hkuoIGuqNCSI9NCre6szt4NsallfsSBcWCufwu2lmIdtOGv8kYjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h1BNV49nyzKHMXX;
	Thu, 16 Jul 2026 19:56:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 795B34058D;
	Thu, 16 Jul 2026 19:57:32 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgC3x3Mqx1hqeWi+BQ--.49322S5;
	Thu, 16 Jul 2026 19:57:32 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add testcases for callback with tailcall
Date: Thu, 16 Jul 2026 12:01:57 +0000
Message-Id: <20260716120157.835937-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716120157.835937-1-pulehui@huaweicloud.com>
References: <20260716120157.835937-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3x3Mqx1hqeWi+BQ--.49322S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXw43Cr4kWr17Xr1rXrWxtFb_yoW5Kw45pF
	yDZw15tryrWF1fAF47Gr48uFZ8Zan5JFWUtryrJr98Ars7Ar93WFn2kry8KF93G3yrZry5
	Z3sYqFs3Cw4kJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUO_MaUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Add 2 testcases for callback with tailcall:
1. failure case: callback->subprog->tailcall.
2. success case: subprog with tailcall do not affect
   no-tailcall callback.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      |  7 ++
 .../selftests/bpf/progs/tailcall_callback.c   | 81 +++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_callback.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index a5a226d0104c..c66037162da5 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -12,6 +12,7 @@
 #include "tailcall_cgrp_storage_no_storage.skel.h"
 #include "tailcall_cgrp_storage.skel.h"
 #include "tailcall_sleepable.skel.h"
+#include "tailcall_callback.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1901,6 +1902,11 @@ static void test_tailcall_sleepable(void)
 	tailcall_sleepable__destroy(skel);
 }
 
+static void test_tailcall_callback(void)
+{
+	RUN_TESTS(tailcall_callback);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1967,4 +1973,5 @@ void test_tailcalls(void)
 		test_tailcall_cgrp_storage_no_storage_leaf();
 	if (test__start_subtest("tailcall_cgrp_storage_no_storage_bridge"))
 		test_tailcall_cgrp_storage_no_storage_bridge();
+	test_tailcall_callback();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_callback.c b/tools/testing/selftests/bpf/progs/tailcall_callback.c
new file mode 100644
index 000000000000..c41632cf423b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_callback.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_test_utils.h"
+
+int classifier_0(struct __sk_buff *skb);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__array(values, void (void));
+} jmp_table SEC(".maps") = {
+	.values = {
+		[0] = (void *) &classifier_0,
+	},
+};
+
+__auxiliary
+SEC("tc")
+int classifier_0(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+static __noinline
+int subprog_tail0(struct __sk_buff *skb)
+{
+	int ret = 0;
+
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	barrier_var(ret);
+	return ret;
+}
+
+static __noinline
+int callback_loop(int index, void **cb_ctx)
+{
+	int ret;
+
+	ret = subprog_tail0(*cb_ctx);
+	barrier_var(ret);
+	return ret ? 1 : 0;
+}
+
+static __noinline
+int callback_empty(int index, void *data)
+{
+	return 0;
+}
+
+/* callback involving subprog with tail call is rejected */
+SEC("tc")
+__failure __msg("cannot tail call within callback")
+int tailcall_callback_1(struct __sk_buff *skb)
+{
+	clobber_regs_stack();
+
+	bpf_loop(1, callback_loop, &skb, 0);
+	return 0;
+}
+
+/* subprogs with tailcall do not affect no-tailcall callback */
+SEC("tc")
+__success
+__retval(0)
+int tailcall_callback_2(struct __sk_buff *skb)
+{
+	int ret;
+
+	clobber_regs_stack();
+
+	ret = subprog_tail0(skb);
+	__sink(ret);
+
+	bpf_loop(1, callback_empty, NULL, 0);
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.34.1

