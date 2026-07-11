Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063D43BB11D;
	Sat, 11 Jul 2026 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766592; cv=none; b=PV73zaBIIrlGUeOBvCUraSzeFnmsa91efx7s8L1YhTrEqDVuHZKSMeKaCQxpvJwdxe1otAQBcKIln8JFx81gAhQNEwmstA7Tsuz/NlcVXfmEKFKkV9zF3ADyK+MDblnUPyiGlpduN0gHzm1XLJBVCm201bEMB6vENoqVfAN7hTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766592; c=relaxed/simple;
	bh=8tDCCdSmK0jEOaFz7MMcd4RAT3Pnrlt+Zzw39vG7Kus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A/bzo0OI0c73WYJSYvPuGyL+XYfroV47280Kv/ZXov9VjlFs2iIHZ/jGHvXiET+kOdONdxHMtyAekHLFIVLw09rTTbx//fSSe4mYaKg2ZRaarJQ3BIFSj7pqxbxPP2NkOZUw7HV1440aHqm1YqyqZembx5yvVWvqEk7ks3D0n8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gy4zN1vMMzYQthP;
	Sat, 11 Jul 2026 18:42:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 490C0407C4;
	Sat, 11 Jul 2026 18:43:06 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDHIm84HlJqX_VcAw--.36025S4;
	Sat, 11 Jul 2026 18:43:06 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add testcases for callback with tailcall
Date: Sat, 11 Jul 2026 10:47:27 +0000
Message-Id: <20260711104727.4023420-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711104727.4023420-1-pulehui@huaweicloud.com>
References: <20260711104727.4023420-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHIm84HlJqX_VcAw--.36025S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAr4UKFyUZw1rZr18Jr43Wrg_yoWrKryxpF
	yDuw1UJryruF1xCF47Cr48uFZ8Zan5JFW5tryrGFyFyrs2yr93KF97KFy09FZ3G3yrZry5
	Z3sYqFs3Cw4kJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add 3 testcases for callback with tailcall.
1. callback directly invokes tailcall
2. callback->subprog->tailcall
3. callback->subprog0->subprog1->tailcall

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      |   7 +
 .../selftests/bpf/progs/tailcall_callback.c   | 129 ++++++++++++++++++
 2 files changed, 136 insertions(+)
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
index 000000000000..504d8e7a6996
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_callback.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_test_utils.h"
+
+int classifier_0(struct __sk_buff *skb);
+int classifier_1(struct __sk_buff *skb);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 2);
+	__uint(key_size, sizeof(__u32));
+	__array(values, void (void));
+} jmp_table SEC(".maps") = {
+	.values = {
+		[0] = (void *) &classifier_0,
+		[1] = (void *) &classifier_1,
+	},
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} arraymap SEC(".maps");
+
+__auxiliary
+SEC("tc")
+int classifier_0(struct __sk_buff *skb)
+{
+	return 0;
+}
+
+static __noinline
+int subprog_tail1(struct __sk_buff *skb)
+{
+	int ret = 0;
+
+	bpf_tail_call_static(skb, &jmp_table, 1);
+	barrier_var(ret);
+	return ret;
+}
+
+__auxiliary
+SEC("tc")
+int classifier_1(struct __sk_buff *skb)
+{
+	int ret;
+
+	ret = subprog_tail1(skb);
+	__sink(ret);
+	return 0;
+}
+
+static __noinline
+int subprog_tail0(struct __sk_buff *skb)
+{
+	int ret;
+
+	ret = subprog_tail1(skb);
+	barrier_var(ret);
+	return ret;
+}
+
+static __noinline
+int callback_loop_1(int index, void **cb_ctx)
+{
+	int ret = 0;
+
+	bpf_tail_call_static(*cb_ctx, &jmp_table, 0);
+	barrier_var(ret);
+	return ret;
+}
+
+static __noinline
+int callback_loop_2(int index, void **cb_ctx)
+{
+	int ret;
+
+	ret = subprog_tail1(*cb_ctx);
+	barrier_var(ret);
+	return ret ? 1 : 0;
+}
+
+static __noinline
+int callback_for_each(void *map, __u32 *key, __u64 *val, void **cb_ctx)
+{
+	int ret;
+
+	ret = subprog_tail0(*cb_ctx);
+	barrier_var(ret);
+	return ret ? 1 : 0;
+}
+/* callback involving tail call directly is rejected */
+SEC("tc")
+__failure __msg("callback unexpected regs 1")
+int tailcall_direct_callback(struct __sk_buff *skb)
+{
+	clobber_regs_stack();
+
+	bpf_loop(1, callback_loop_1, &skb, 0);
+	return 0;
+}
+
+/* callback involving 1 subprog with tail call is rejected */
+SEC("tc")
+__failure __msg("cannot tail call within callback")
+int tailcall_bpf2bpf_callback_1(struct __sk_buff *skb)
+{
+	clobber_regs_stack();
+
+	bpf_loop(1, callback_loop_2, &skb, 0);
+	return 0;
+}
+
+/* callback involving 2 subprogs with tail call is rejected */
+SEC("tc")
+__failure __msg("cannot tail call within callback")
+int tailcall_bpf2bpf_callback_2(struct __sk_buff *skb)
+{
+	clobber_regs_stack();
+
+	bpf_for_each_map_elem(&arraymap, callback_for_each, &skb, 0);
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.34.1

