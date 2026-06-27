Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAB3B14BD;
	Sat, 27 Jun 2026 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571992; cv=none; b=jKTk8BmmsDrJWgPqa5ecXqD6iyOcaQRe7J45lBA7DlAjxoV+JRXs9KZZEgPsEBxWwhFrNDCENpJf5mxUicCbhJyE1bF4GBavBwwplGuKgzXrFxcAu12CbyyCL0iz20ztz9hCB2aUwaCS0gIjgxdHkY27ig9LLFyY9YMUZ/R/dHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571992; c=relaxed/simple;
	bh=eN2AmVD+Hlliw36+ApMI280DB7BK3opSJ7xw5iiAXgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auEnaFvt8dx2uWcF8I+TERbDND/4PLh+Hz0+W5W4Or3GJUkyCkjCgI3eG6YPqJomz/CDiROP4ujVtphXrxSZMty+vk7SjFu+dbb7vRd0bLyXryDxbLFC1/uvcN2POG5gobAMk5gJpjLEvYc7V4QYXmllKPtxSyvGm83jjjVh6c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gnbB413hbzKHMM6;
	Sat, 27 Jun 2026 22:52:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 78F7D408FE;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S14;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>
Subject: [RFC PATCH bpf-next 12/12] selftests/bpf: Add tests for bpf SDT probe
Date: Sat, 27 Jun 2026 22:51:46 +0000
Message-ID: <04b17848a1b9bf61c27317075829cd9570aa8557.1782571533.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S14
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1xGF43Zry7uF4UAryDGFg_yoW3WryUpa
	48ZryYkryrXa1UK34rKFWUuw4rta1Dury5JrykWr13Zw4DXrWvgw1xKr47KasxXFZ8uryr
	Z34ayFs3CrsrXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7
	CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIJ5rDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add selftests for bpf SDT probe sites and observers.

The tests include argument check for observer program, multiple target
programs in the same ELF, and programs with subprog.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/prog_tests/test_bpf_sdt.c   | 151 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_sdt_observer.c    |  30 ++++
 .../selftests/bpf/progs/bpf_sdt_target.c      |  34 ++++
 3 files changed, 215 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_sdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_sdt_observer.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_sdt_target.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_sdt.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_sdt.c
new file mode 100644
index 000000000000..b2752e7b2b09
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_sdt.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/bpf.h>
+#include "bpf_sdt_observer.skel.h"
+#include "bpf_sdt_target.skel.h"
+
+static int sdt_attach(struct bpf_program *obs)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+
+	return bpf_link_create(bpf_program__fd(obs), 0, BPF_TRACE_SDT, &opts);
+}
+
+static void read_args(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_sdt_target *tgt_skel;
+	struct bpf_sdt_observer *skel;
+	char pkt[64] = {};
+	int link, err;
+
+	tgt_skel = bpf_sdt_target__open_and_load();
+	if (!ASSERT_OK_PTR(tgt_skel, "target open_and_load"))
+		return;
+
+	skel = bpf_sdt_observer__open();
+	if (!ASSERT_OK_PTR(skel, "observer open"))
+		goto out_tgt;
+
+	bpf_program__set_autoload(skel->progs.tc_trace_prog, false);
+	bpf_program__set_autoload(skel->progs.subprog_trace_prog, false);
+	bpf_program__set_attach_target(skel->progs.xdp_trace_prog,
+				       bpf_program__fd(tgt_skel->progs.xdp_prog),
+				       "xdp_probe_len_ret");
+	err = bpf_sdt_observer__load(skel);
+	if (!ASSERT_OK(err, "observer load"))
+		goto out_obs;
+
+	link = sdt_attach(skel->progs.xdp_trace_prog);
+	if (!ASSERT_GE(link, 0, "attach xdp_probe_len_ret"))
+		goto out_obs;
+
+	topts.data_in = pkt;
+	topts.data_size_in = sizeof(pkt);
+	topts.data_size_out = sizeof(pkt);
+	err = bpf_prog_test_run_opts(bpf_program__fd(tgt_skel->progs.xdp_prog), &topts);
+	if (!ASSERT_OK(err, "prog_test_run"))
+		goto out_link;
+
+	ASSERT_EQ(skel->bss->xdp_len, sizeof(pkt), "xdp_len");
+	ASSERT_EQ(skel->bss->xdp_ret, XDP_PASS, "xdp_ret");
+
+out_link:
+	close(link);
+out_obs:
+	bpf_sdt_observer__destroy(skel);
+out_tgt:
+	bpf_sdt_target__destroy(tgt_skel);
+}
+
+static void multi_prog(void)
+{
+	struct bpf_sdt_target *tgt_skel;
+	struct bpf_sdt_observer *skel;
+	int link1, link2, err;
+
+	tgt_skel = bpf_sdt_target__open_and_load();
+	if (!ASSERT_OK_PTR(tgt_skel, "target open_and_load"))
+		return;
+
+	skel = bpf_sdt_observer__open();
+	if (!ASSERT_OK_PTR(skel, "observer open"))
+		goto out_tgt;
+
+	bpf_program__set_autoload(skel->progs.subprog_trace_prog, false);
+	bpf_program__set_attach_target(skel->progs.xdp_trace_prog,
+				       bpf_program__fd(tgt_skel->progs.xdp_prog),
+				       "xdp_probe_len_ret");
+	bpf_program__set_attach_target(skel->progs.tc_trace_prog,
+				       bpf_program__fd(tgt_skel->progs.tc_prog),
+				       "tc_probe");
+	err = bpf_sdt_observer__load(skel);
+	if (!ASSERT_OK(err, "observer load"))
+		goto out_obs;
+
+	link1 = sdt_attach(skel->progs.xdp_trace_prog);
+	ASSERT_GE(link1, 0, "attach xdp xdp_probe_len_ret");
+
+	link2 = sdt_attach(skel->progs.tc_trace_prog);
+	ASSERT_GE(link2, 0, "attach tc_probe");
+
+	close(link1);
+	close(link2);
+out_obs:
+	bpf_sdt_observer__destroy(skel);
+out_tgt:
+	bpf_sdt_target__destroy(tgt_skel);
+}
+
+static void subprog_probe(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_sdt_target *tgt_skel;
+	struct bpf_sdt_observer *skel;
+	char pkt[64] = {0, 1, 2, 3};
+	int link, err;
+
+	tgt_skel = bpf_sdt_target__open_and_load();
+	if (!ASSERT_OK_PTR(tgt_skel, "target open_and_load"))
+		return;
+
+	skel = bpf_sdt_observer__open();
+	if (!ASSERT_OK_PTR(skel, "observer open"))
+		goto out_tgt;
+
+	bpf_program__set_autoload(skel->progs.tc_trace_prog, false);
+	bpf_program__set_autoload(skel->progs.xdp_trace_prog, false);
+	bpf_program__set_attach_target(skel->progs.subprog_trace_prog,
+				       bpf_program__fd(tgt_skel->progs.xdp_prog),
+				       "xdp_probe_ctx");
+	err = bpf_sdt_observer__load(skel);
+	if (!ASSERT_OK(err, "observer load"))
+		goto out_obs;
+
+	link = sdt_attach(skel->progs.subprog_trace_prog);
+	if (!ASSERT_GE(link, 0, "attach xdp_probe_ctx"))
+		goto out_obs;
+
+	topts.data_in = pkt;
+	topts.data_size_in = sizeof(pkt);
+	topts.data_size_out = sizeof(pkt);
+	err = bpf_prog_test_run_opts(bpf_program__fd(tgt_skel->progs.xdp_prog), &topts);
+	ASSERT_OK(err, "prog_test_run");
+	ASSERT_EQ(skel->bss->xdp_len, sizeof(pkt), "xdp_len");
+
+	close(link);
+out_obs:
+	bpf_sdt_observer__destroy(skel);
+out_tgt:
+	bpf_sdt_target__destroy(tgt_skel);
+}
+
+void test_bpf_sdt(void)
+{
+	if (test__start_subtest("read_args"))
+		read_args();
+	if (test__start_subtest("multi_prog"))
+		multi_prog();
+	if (test__start_subtest("subprog_probe"))
+		subprog_probe();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_sdt_observer.c b/tools/testing/selftests/bpf/progs/bpf_sdt_observer.c
new file mode 100644
index 000000000000..ec059e86b154
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_sdt_observer.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+volatile int xdp_len;
+volatile int xdp_ret;
+
+SEC("bpf_sdt")
+int BPF_PROG(tc_trace_prog)
+{
+	return 0;
+}
+
+SEC("bpf_sdt")
+int BPF_PROG(xdp_trace_prog, int len, int ret)
+{
+	xdp_len = len;
+	xdp_ret = ret;
+	return 0;
+}
+
+SEC("bpf_sdt")
+int BPF_PROG(subprog_trace_prog, struct xdp_md *xdp_ctx)
+{
+	xdp_len = bpf_xdp_get_buff_len((struct xdp_md *)xdp_ctx);
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/bpf_sdt_target.c b/tools/testing/selftests/bpf/progs/bpf_sdt_target.c
new file mode 100644
index 000000000000..e1c14b9d7e9a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_sdt_target.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../../../../tools/lib/bpf/bpf_sdt.h"
+
+BPF_SDT_DECLARE(tc_probe);
+BPF_SDT_DECLARE1(xdp_probe_ctx, struct xdp_md *);
+BPF_SDT_DECLARE2(xdp_probe_len_ret, int, int);
+
+static __noinline int xdp_process(struct xdp_md *ctx)
+{
+	BPF_SDT_PROBE1(xdp_probe_ctx, ctx);
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_prog(struct xdp_md *ctx)
+{
+	int len = (int)(ctx->data_end - ctx->data);
+
+	BPF_SDT_PROBE2(xdp_probe_len_ret, len, XDP_PASS);
+
+	return xdp_process(ctx);
+}
+
+SEC("tc")
+int tc_prog(struct __sk_buff *skb)
+{
+	BPF_SDT_PROBE(tc_probe);
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.47.3

