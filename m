Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B4272E6D;
	Sat, 30 May 2026 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780121928; cv=none; b=TyfsFBHVdCDi12UGv3sqEFFwwm0mFcZdZmDkEpvTVgSAHRWaHIlY/NUcNpgbqT9RYrKwbThP7Wpy1Vw2kRvH/DChw+FP55IPEVQWzZH9MwomyZINkGWEwHCc3/7UQ5VibGSejPljEo5TaRPtWN3BIKmRAp9Q57C+/osfc/g5i9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780121928; c=relaxed/simple;
	bh=zgntWj+9/IpmJ1e/RdM8e9a3X3vZqNHP4WxcdAJ3Ne4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRRZ5jnUrzD8d2+WscDJOq03AhUdEYZRsZGnx3eoQt0AFBMMrt0m0SwAOJXYslXXvPByo91Z4Y0yK6gVdsLg1ASp+ZROU4hei3NVz1w1+854NJ0ISwGt2QiVtKNmsemIp8h10JsTRfOVV+jagJIyIRFJ903PsXY3yiMIpZlBcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gS95V0JPdzKHMSW;
	Sat, 30 May 2026 14:18:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 14C4D40561;
	Sat, 30 May 2026 14:18:41 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with SMTP id gCh0CgDnr1s8gRpqNcqdEA--.3341S5;
	Sat, 30 May 2026 14:18:40 +0800 (CST)
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
	YiFei Zhu <zhuyifei@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH bpf v2 3/3] selftests/bpf: Add tests for bpf_set_retval validation
Date: Sat, 30 May 2026 05:55:57 +0000
Message-ID: <20260530055557.549474-4-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530055557.549474-1-xukuohai@huaweicloud.com>
References: <20260530055557.549474-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnr1s8gRpqNcqdEA--.3341S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4fGF4fZF18JFy7Gr1fCrg_yoWrury3p3
	WkCF9rW3sYywsxWFWxGay2vF1rGa1vv3yUZryxXw1jkFn7Jr4DJr1IkF13JasxGFZ8Zw1Y
	krWa9rWfCr1Ut3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14x
	RDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add verifier tests to validate bpf_set_retval argument for cgroup
program types.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com> #v1
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_cgroup.c     | 87 +++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cgroup.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 06cd24e37b3f..d24d52a44425 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -115,6 +115,7 @@
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
+#include "verifier_cgroup.skel.h"
 #include "verifier_lsm.skel.h"
 #include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
@@ -262,6 +263,7 @@ void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
+void test_verifier_cgroup(void)                { RUN(verifier_cgroup); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_cgroup.c b/tools/testing/selftests/bpf/progs/verifier_cgroup.c
new file mode 100644
index 000000000000..cc95e066bf61
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_cgroup.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf_sockopt_helpers.h>
+#include "bpf_misc.h"
+
+/*
+ * Cgroup programs set return values via bpf_set_retval() helper.
+ * The helper argument must be 0 (success) or negative errno.
+ * Positive values bypass IS_ERR() check and can cause kernel issues.
+ */
+
+SEC("lsm_cgroup/socket_create")
+__description("lsm_cgroup bpf_set_retval success")
+__success
+int BPF_PROG(lsm_cgroup_set_retval_zero_valid, int family, int type, int protocol, int kern)
+{
+	bpf_set_retval(0);
+	return 0;
+}
+
+SEC("lsm_cgroup/socket_create")
+__description("lsm_cgroup bpf_set_retval valid errno")
+__success
+int BPF_PROG(lsm_cgroup_set_retval_negative_valid, int family, int type, int protocol, int kern)
+{
+	bpf_set_retval(-12);
+	return 0;
+}
+
+SEC("lsm_cgroup/socket_create")
+__description("lsm_cgroup bpf_set_retval invalid negative value")
+__failure __msg("should have been in [-4095, 0]")
+int BPF_PROG(lsm_cgroup_set_retval_negative_invalid, int family, int type, int protocol, int kern)
+{
+	bpf_set_retval(-4096);
+	return 0;
+}
+
+SEC("lsm_cgroup/socket_create")
+__description("lsm_cgroup bpf_set_retval invalid positive value")
+__failure __msg("should have been in [-4095, 0]")
+int BPF_PROG(lsm_cgroup_set_retval_positive_invalid, int family, int type, int protocol, int kern)
+{
+	bpf_set_retval(1);
+	return 0;
+}
+
+SEC("cgroup/dev")
+__description("cgroup_device bpf_set_retval success")
+__success
+int cgroup_dev_set_retval_0(struct bpf_cgroup_dev_ctx *ctx)
+{
+	bpf_set_retval(0);
+	return 1;
+}
+
+SEC("cgroup/dev")
+__description("cgroup_device bpf_set_retval valid errno")
+__success
+int cgroup_dev_set_retval_neg_maxerrno(struct bpf_cgroup_dev_ctx *ctx)
+{
+	bpf_set_retval(-4095);
+	return 1;
+}
+
+SEC("cgroup/dev")
+__description("cgroup_device bpf_set_retval invalid positive value")
+__failure __msg("should have been in [-4095, 0]")
+int cgroup_dev_set_retval_1(struct bpf_cgroup_dev_ctx *ctx)
+{
+	bpf_set_retval(1);
+	return 1;
+}
+
+SEC("cgroup/dev")
+__description("cgroup_device bpf_set_retval invalid negative value")
+__failure __msg("should have been in [-4095, 0]")
+int cgroup_dev_set_retval_neg_4096(struct bpf_cgroup_dev_ctx *ctx)
+{
+	bpf_set_retval(-4096);
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

