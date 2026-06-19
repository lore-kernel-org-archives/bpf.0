Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6593B19B5;
	Fri, 19 Jun 2026 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880356; cv=none; b=AbasbfA0Fmcofpf00qbVwH342etfo/T8YBE7NyDtYDE8TGaAhtKxDjzDc3yUsgoHed6nWt05gRYBP5LyJXGL6gJ6xdGHODsFz3qRK43W1I8Dp4VCX9WbW6Q0202PxAtl/247zFaOEWuJ3Oedd1WmEoAalSBlbnQQIHwtXMBmhAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880356; c=relaxed/simple;
	bh=0F693/35T0j2vjltTVEQctWkPr2t5okY752xshgDaII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMmrI3Fa/7y2KCYKztl4AIFA8LXxJt1jwIrFAuzrdk8078D5drIhejiteFPQkN34uUs8FkMW5BLFQQizu/peOsDNHBAYF0Tzyd71xsd/BrgQdFcABZLY6+OUYzLeR67HM76KkTU8luRK34mtmZ74Yt1otWP5DyGTsIlt7i7ublw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=qIaMsRPX; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="qIaMsRPX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=N7Dhn9uU7tdRgOCD+UWnzp9zivsRhCi
	wGIRvS64aLF0=; b=qIaMsRPXaDyjHNm+OAZy0sDQPI+kyd2kekk45aXLrPjdiY+
	ci9irvbTm6GJtWALC7uZuJ7DYzBMJYLRAishaw6XLJcSRbnRwbmxxSTrXNyeoSnI
	4pfXRKLokitGxQ/BIoPFXLWNVnILreXM32JhyZTtcazHU2zg7a2C4mVXHjV0=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQAnsbsMVjVqxDGLAg--.41554S4;
	Fri, 19 Jun 2026 22:45:32 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Fri, 19 Jun 2026 22:45:33 +0800
Subject: [PATCH bpf-next 2/2] selftests/sched_ext: Cover scx_bpf_cpu_rq()
 null return
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-f01-14-scx-cpu-rq-ret-null-v1-2-3b4281cdf0da@mails.tsinghua.edu.cn>
References: <20260619-f01-14-scx-cpu-rq-ret-null-v1-0-3b4281cdf0da@mails.tsinghua.edu.cn>
In-Reply-To: <20260619-f01-14-scx-cpu-rq-ret-null-v1-0-3b4281cdf0da@mails.tsinghua.edu.cn>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781880334; l=3029;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=0F693/35T0j2vjltTVEQctWkPr2t5okY752xshgDaII=;
 b=IGO490DFVK75vA0WDgJUrMVfi37EVGZCvxMsZLfIS1eNzUtBAezP0cKWrSkLz7+txgKZa6Q1u
 MpSxa3OmxppAJcoUVlIwoW/JkQbAxh530FoFlO4zO/7G0tsXr2g+Sfw
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQAnsbsMVjVqxDGLAg--.41554S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1fCF1fuw4ktFykCw1DAwb_yoW5CF4xpa
	18Cw1Ykr4xKF4Sg3WSkF4IgF4Fvrs3A348tF4xWrnFvryxJ3WUtrnrtrWDXF95GrZY9r4r
	uFWIgF47CF1Uuw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Xryl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0hSdPUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgMDA2o0cJzlqgAAs8

Add a sched_ext negative-load test that calls scx_bpf_cpu_rq(-1) and then
immediately reads rq->nr_running. The verifier should reject the program
because scx_bpf_cpu_rq() may return NULL.

This guards the KF_RET_NULL metadata for scx_bpf_cpu_rq().

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/sched_ext/Makefile         |  1 +
 .../selftests/sched_ext/cpu_rq_ret_null.bpf.c      | 27 +++++++++++++++
 .../testing/selftests/sched_ext/cpu_rq_ret_null.c  | 38 ++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5d2dffca0e91..15cedcf56a49 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -174,6 +174,7 @@ auto-test-targets :=			\
 	init_enable_count		\
 	maximal				\
 	maybe_null			\
+	cpu_rq_ret_null		\
 	minimal				\
 	non_scx_kfunc_deny		\
 	numa				\
diff --git a/tools/testing/selftests/sched_ext/cpu_rq_ret_null.bpf.c b/tools/testing/selftests/sched_ext/cpu_rq_ret_null.bpf.c
new file mode 100644
index 000000000000..d08f0b582542
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/cpu_rq_ret_null.bpf.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Nuoqi Gui
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+u32 nr_running;
+
+void BPF_STRUCT_OPS(cpu_rq_ret_null_enable, struct task_struct *p)
+{}
+
+void BPF_STRUCT_OPS(cpu_rq_ret_null_dispatch, s32 cpu, struct task_struct *p)
+{
+	struct rq *rq;
+
+	rq = scx_bpf_cpu_rq(-1);
+	nr_running = rq->nr_running;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops cpu_rq_ret_null = {
+	.dispatch		= (void *)cpu_rq_ret_null_dispatch,
+	.enable			= (void *)cpu_rq_ret_null_enable,
+	.name			= "cpu_rq_ret_null",
+};
diff --git a/tools/testing/selftests/sched_ext/cpu_rq_ret_null.c b/tools/testing/selftests/sched_ext/cpu_rq_ret_null.c
new file mode 100644
index 000000000000..bd82c310ad7a
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/cpu_rq_ret_null.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Nuoqi Gui
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "cpu_rq_ret_null.bpf.skel.h"
+#include "scx_test.h"
+
+static enum scx_test_status run(void *ctx)
+{
+	struct cpu_rq_ret_null *skel;
+	int err;
+
+	skel = cpu_rq_ret_null__open();
+	if (!skel) {
+		SCX_ERR("Failed to open skel");
+		return SCX_TEST_FAIL;
+	}
+
+	err = cpu_rq_ret_null__load(skel);
+	cpu_rq_ret_null__destroy(skel);
+
+	if (!err) {
+		SCX_ERR("scx_bpf_cpu_rq() direct dereference loaded");
+		return SCX_TEST_FAIL;
+	}
+
+	return SCX_TEST_PASS;
+}
+
+struct scx_test cpu_rq_ret_null = {
+	.name = "cpu_rq_ret_null",
+	.description = "Verify that scx_bpf_cpu_rq() returns a nullable pointer",
+	.run = run,
+};
+
+REGISTER_SCX_TEST(&cpu_rq_ret_null)

-- 
2.34.1

