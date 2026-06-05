Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7C384234;
	Fri,  5 Jun 2026 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669553; cv=none; b=iNacpqKv34QD/jQ8KYCCuXPhCXsrtYF/Lwa7Nb0EBM1MYJdJsUxdDlbJGRIb6ZxApyi0CeUpTOf/xCOb0vrSadiS+FfWItwKKf729ZUvdIJ+mmEB01jWIULYcX9T46P0VK7V6ifP78AotNKr0y+7H1WZjOOvbA1tVr+n8ZLuiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669553; c=relaxed/simple;
	bh=ZcJC5uxpg7KMHyly7HspNq36z7tc8iBE4Z6wTr+vLas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpQgnVJLvB07FrntmX4XszYRIawheSxGkUDJBdXUH21JHlmIlj8wCNb23crFOJbrgGqe5xBMCekQTBnplFwkfprxIEwLUaCWFM2GINb8giW/hJdZoa8gMKWQ3m/ZUKTmfKOxaVK2AFjZOuV5jYxZrv6sDnKOS+dIWTkfyyWNyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gX3cM3f4TzKHMcy;
	Fri,  5 Jun 2026 22:25:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B38814056D;
	Fri,  5 Jun 2026 22:25:36 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP1 (Coremail) with SMTP id cCh0CgBntjtd3CJqFYjiAg--.54292S5;
	Fri, 05 Jun 2026 22:25:36 +0800 (CST)
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
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Add tests for bpf_set_retval validation
Date: Fri,  5 Jun 2026 14:02:43 +0000
Message-ID: <20260605140243.664590-4-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605140243.664590-1-xukuohai@huaweicloud.com>
References: <20260605140243.664590-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBntjtd3CJqFYjiAg--.54292S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4fGF4fZrW5AF4fuw13twb_yoW7JrW8p3
	WkCF9rW3sayw43WFWxGF47ZF1rGF4vv3y5Zr97Xw1UCFs7Jr4DXr1IkF13JasxGFWDuw1Y
	kr4a9FWfur1Ut3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UA
	CztUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add verifier tests to validate bpf_set_retval argument for cgroup
program types.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com> #v1
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_set_retval.c | 107 ++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_set_retval.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 219ff2969868..89779d897aba 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -117,6 +117,7 @@
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
 #include "verifier_bits_iter.skel.h"
+#include "verifier_set_retval.skel.h"
 #include "verifier_lsm.skel.h"
 #include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
@@ -266,6 +267,7 @@ void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
 void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
+void test_verifier_set_retval(void)            { RUN(verifier_set_retval); }
 void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
 void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_set_retval.c b/tools/testing/selftests/bpf/progs/verifier_set_retval.c
new file mode 100644
index 000000000000..1415cd15cede
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_set_retval.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
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
+SEC("cgroup/dev")
+__description("bpf_set_retval bounds check survives state pruning")
+__failure __msg("should have been in [-4095, 0]")
+__naked int cgroup_dev_set_retval_pruning_bypass(struct bpf_cgroup_dev_ctx *ctx)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 0 goto 1f;"
+		"r0 = r0;"
+		"r0 = r0;"
+		"r0 = r0;"
+		"r0 = r0;"
+		"goto 2f;"
+	"1:"
+		"call %[bpf_get_prandom_u32];"
+	"2:"
+		"r1 = r0;"
+		"call %[bpf_set_retval];"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm(bpf_set_retval)
+		: __clobber_common
+	);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.47.3

