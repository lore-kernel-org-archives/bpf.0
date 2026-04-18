Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF02B33F59B
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776518214; cv=none; b=KlxfUj8JAuQdAqe2xby8IpR1jvwhxziFQfQUXjveQSphIPs/viZlkrA34113NcktPiA/s/0GTSVbP06A7pl5ohnA+o9aQ1XTz9XCrG2KQZc+/jO6cmwybqI2zgrFpMZXzEAp9DaVXPa+vy7RZD8RrUTLxzRDVf8yskMbwo5ftSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776518214; c=relaxed/simple;
	bh=UGmgz/f6f24Dx4c6xu4Ob32EQDVt0bq65VvsV2LepmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDgy+wihFuXq9HtHPvTbmE/BOvl0SxtfHXubkEs/kFBNh5RJYcN7C4HJihgg4dXWLn02+6R7oeFDBP5AsTg31OoybO3d9gIGfcVHYCeDEvJoCaHKWzf5okCpvU5G7SF1yR/VICquy6eRdW4TOLNQg7Cr/6RxseWQW7wmrxCTmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hn6sNR2N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn6sNR2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63827C19424;
	Sat, 18 Apr 2026 13:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776518214;
	bh=UGmgz/f6f24Dx4c6xu4Ob32EQDVt0bq65VvsV2LepmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hn6sNR2NJ40FXRVFW/I//dKItOoGUPAkdMYI3C7JYO+s0gw5FIl9bKsukb8hzV+OS
	 3W02n+GqJIUqo6zE6TvXKtvxACpRjdkM2kgEYJQa9fDVS4Y9Rb6dBaOwwOkG5MxKef
	 x/T26ECmjKWyKKhB4L1X5PCLDAKwsHwCRI1mKZqyhsOoP5B1U+067xMaD7jHQmEsYT
	 JsP26X4KEsQfH3fWxz6fqnNeF5oJ1JvD4zLvuMI3DczTuhUPHBq88ObWQUi0ISLirH
	 rYZ9AbVj3rHbi1azw+HjgfvCDn7owS3O/YUkO+KvlWViB1F2MJjVuOVGiq5AylfsV1
	 Jy+8Ck6wIwvjA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kernel-team@meta.com,
	Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH bpf-next v13 5/6] selftests/bpf: add usage example for cpu time counter kfuncs
Date: Sat, 18 Apr 2026 06:16:03 -0700
Message-ID: <20260418131614.1501848-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418131614.1501848-1-puranjay@kernel.org>
References: <20260418131614.1501848-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vadim Fedorenko <vadfed@meta.com>

The selftest provides an example of how to measure the latency of bpf
kfunc/helper call using time stamp counter and how to convert measured
value into nanoseconds.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../bpf/prog_tests/test_cpu_cycles.c          | 35 +++++++++++++++++++
 .../selftests/bpf/progs/test_cpu_cycles.c     | 25 +++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_cpu_cycles.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c b/tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
new file mode 100644
index 000000000000..067307f0c4c2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_cpu_cycles.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Inc. */
+
+#include <test_progs.h>
+#include "test_cpu_cycles.skel.h"
+
+static void cpu_cycles(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct test_cpu_cycles *skel;
+	int err, pfd;
+
+	skel = test_cpu_cycles__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_cpu_cycles open and load"))
+		return;
+
+	pfd = bpf_program__fd(skel->progs.bpf_cpu_cycles);
+	if (!ASSERT_GT(pfd, 0, "test_cpu_cycles fd"))
+		goto fail;
+
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "test_cpu_cycles test run"))
+		goto fail;
+
+	ASSERT_NEQ(skel->bss->cycles, 0, "test_cpu_cycles 0 cycles");
+	ASSERT_NEQ(skel->bss->ns, 0, "test_cpu_cycles 0 ns");
+fail:
+	test_cpu_cycles__destroy(skel);
+}
+
+void test_cpu_cycles(void)
+{
+	if (test__start_subtest("cpu_cycles"))
+		cpu_cycles();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_cpu_cycles.c b/tools/testing/selftests/bpf/progs/test_cpu_cycles.c
new file mode 100644
index 000000000000..3c428f3be831
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_cpu_cycles.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Inc. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+extern u64 bpf_cpu_time_counter_to_ns(u64 cycles) __weak __ksym;
+extern u64 bpf_get_cpu_time_counter(void) __weak __ksym;
+
+__u64 cycles, ns;
+
+SEC("syscall")
+int bpf_cpu_cycles(void)
+{
+	struct bpf_pidns_info pidns;
+	__u64 start;
+
+	start = bpf_get_cpu_time_counter();
+	bpf_get_ns_current_pid_tgid(0, 0, &pidns, sizeof(struct bpf_pidns_info));
+	cycles = bpf_get_cpu_time_counter() - start;
+	ns = bpf_cpu_time_counter_to_ns(cycles);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

