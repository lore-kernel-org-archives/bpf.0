Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8372652AF;
	Tue, 14 Jul 2026 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996842; cv=none; b=UCBG8qIzZQZiN5ldFO+Rls2iaHW4uAcVeFCWdv1xTiCp0497XJVaUfkMHMyv17tg3EHcX/ER0vYDXZLpSN9y8a3VPZWQY4SU/JzHLeND3+RUabzs7dMxWI8amAL4KdyQXyrY/3kQzyt2ILWORogY8TDe4/quXuaZVFciduQJbs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996842; c=relaxed/simple;
	bh=9lWV+1FcDplFj4266OMUNwGWr2zRRFhyyGaSI9NFNRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XmPB87s9zMmpGmJMWmJJM+Amr6y/0escR4UZJs2e2sbaW08mDPsAaTVf5/8nJXdPZa+8flyJIEWPj+y9dsO9NlIkPbZGqnY2/cW3ugoghLoWxVOlbFIQmIY8RTLTI46YGi81dU60NV9N1l11wDE1PHYZeb59R3Yun94Cd4mZy8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzk7B1PzczYQtk3;
	Tue, 14 Jul 2026 10:40:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C1CD74058D;
	Tue, 14 Jul 2026 10:40:36 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgC3xXGioVVq8TueBA--.48464S4;
	Tue, 14 Jul 2026 10:40:36 +0800 (CST)
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add testcase for callback with tailcall
Date: Tue, 14 Jul 2026 02:44:59 +0000
Message-Id: <20260714024459.420075-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714024459.420075-1-pulehui@huaweicloud.com>
References: <20260714024459.420075-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3xXGioVVq8TueBA--.48464S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw45Kr43uw4xAw4DCrW8tFb_yoW5ur4xpF
	yDZw15KryFg3WfZF47Wr4xuFZ8Aa1kJryUtryrGr90yr4xAr93WFn2kFy8KFZ3G3yFvry5
	Z34vvFn3Cw4kJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7VUbH5lUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Add testcase for callback with tailcall, which is
callback->subprog->tailcall.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      |  7 +++
 .../bpf/progs/tailcall_bpf2bpf_callback.c     | 62 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_callback.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index a5a226d0104c..6fbf4c37e234 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -12,6 +12,7 @@
 #include "tailcall_cgrp_storage_no_storage.skel.h"
 #include "tailcall_cgrp_storage.skel.h"
 #include "tailcall_sleepable.skel.h"
+#include "tailcall_bpf2bpf_callback.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1901,6 +1902,11 @@ static void test_tailcall_sleepable(void)
 	tailcall_sleepable__destroy(skel);
 }
 
+static void test_tailcall_bpf2bpf_callback(void)
+{
+	RUN_TESTS(tailcall_bpf2bpf_callback);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1967,4 +1973,5 @@ void test_tailcalls(void)
 		test_tailcall_cgrp_storage_no_storage_leaf();
 	if (test__start_subtest("tailcall_cgrp_storage_no_storage_bridge"))
 		test_tailcall_cgrp_storage_no_storage_bridge();
+	test_tailcall_bpf2bpf_callback();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_callback.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_callback.c
new file mode 100644
index 000000000000..dfe9c49cfeb1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_callback.c
@@ -0,0 +1,62 @@
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
+static __noinline
+int subprog_tail0(struct __sk_buff *skb)
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
+int classifier_0(struct __sk_buff *skb)
+{
+	int ret;
+
+	ret = subprog_tail0(skb);
+	__sink(ret);
+	return 0;
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
+/* callback involving subprog with tail call is rejected */
+SEC("tc")
+__failure __msg("cannot tail call within callback")
+int tailcall_bpf2bpf_callback(struct __sk_buff *skb)
+{
+	clobber_regs_stack();
+
+	bpf_loop(1, callback_loop, &skb, 0);
+	return 0;
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.34.1

