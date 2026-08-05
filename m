Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953044E64F
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942530; cv=none; b=kzx0LmZ3JSSCN/FTajBN7uy+J1T4+k5TQaCvunXB5uzYYzKg++u9GbtILMPxOv0fLBLrusxpiPaqP2atgyDbO+1bAOUZrUYTvK4i6w/DK4ElsLpKbDtneim2KWISNsvFE2QvBJgXgkeu6clRYVr1kfNtFYUc3BP8gGAnhXDtC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942530; c=relaxed/simple;
	bh=5Ii+EUcR6gRiGNfLX2CgyLaYP8nwfuEFGsphfc0oDfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTFMylux/FxRgPGgYPOwJ0/I41AwvLrLmOxduh1g9Q/+WWvWmfbM6cheXf0R9L5THN+OChitGOzMHLn8dxQ79xDkHHHx/Rz6j36r08XeLZcFvms7KT1M91eaoNJjDZiJbbYy9lcrwmbF0l4OiVCK4ql2EymeIfNl8kBnUs7fQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=caUv1jxE; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="caUv1jxE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785942524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQ1bFyt6iqOdNwnHAc57w4fAPU5hgSUfE7fOGu+3Mg0=;
	b=caUv1jxEVUzoBBj9SvcZXWoO8XyCgELU0VEZeCvV4/Vnb4bR8vq8OKMtdQE50QHldedpBk
	vXX5R5r7prm9Tj4IqkojDR4e5QelDzgXW3IqtqUVP9vcr4DsAM3iTocx66KPJg3zIb9htm
	Kx7AldP5/QligcYoeegDeAOuCO+j6LE=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Viktor Malik <vmalik@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Verify rejection of sleepable tracing prog
Date: Wed,  5 Aug 2026 23:08:10 +0800
Message-ID: <20260805150810.34907-3-leon.hwang@linux.dev>
In-Reply-To: <20260805150810.34907-1-leon.hwang@linux.dev>
References: <20260805150810.34907-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a test to verify that the sleepable tracing prog cannot attach to a
'__x64_sys' prefix prog target.

When CONFIG_FUNCTION_ERROR_INJECTION is disabled, without the fix, the
test would trigger the BUG:

[    3.460756] BUG: sleeping function called from invalid context at kernel/bpf/trampoline.c:1324

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 57 +++++++++++++++++++
 .../selftests/bpf/progs/fentry_sleepable.c    | 18 ++++++
 tools/testing/selftests/bpf/progs/xdp_dummy.c |  6 ++
 3 files changed, 81 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index 4a87d7163c8c..2523c07a16c6 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -5,6 +5,7 @@
 #include <bpf/btf.h>
 #include "bind4_prog.skel.h"
 #include "freplace_progmap.skel.h"
+#include "fentry_sleepable.skel.h"
 #include "xdp_dummy.skel.h"
 
 typedef int (*test_cb)(struct bpf_object *obj);
@@ -576,6 +577,60 @@ static void test_func_replace_progmap(void)
 	freplace_progmap__destroy(skel);
 }
 
+static void test_sleepable_fentry_to_xdp(void)
+{
+	struct fentry_sleepable *skel = NULL;
+	struct xdp_dummy *skel_xdp = NULL;
+	int ifindex, prog_fd, err;
+	char buff[64] = {};
+
+#ifndef __x86_64__
+	test__skip();
+	return;
+#endif
+
+	ifindex = if_nametoindex("lo");
+	if (!ASSERT_GT(ifindex, 0, "if_nametoindex"))
+		return;
+
+	skel_xdp = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(skel_xdp, "xdp_dummy__open_and_load"))
+		return;
+
+	skel = fentry_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "fentry_sleepable__open"))
+		goto out;
+
+	skel->bss->user_ptr = buff;
+
+	prog_fd = bpf_program__fd(skel_xdp->progs.__x64_sys_nop);
+	err = bpf_program__set_attach_target(skel->progs.fentry_xdp, prog_fd, "__x64_sys_nop");
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto out;
+
+	err = fentry_sleepable__load(skel);
+	ASSERT_ERR(err, "fentry_sleepable__load");
+	if (err)
+		goto out;
+
+	skel->links.fentry_xdp = bpf_program__attach_trace(skel->progs.fentry_xdp);
+	if (!ASSERT_OK_PTR(skel->links.fentry_xdp, "bpf_program__attach_trace"))
+		goto out;
+
+	skel_xdp->links.__x64_sys_nop = bpf_program__attach_xdp(skel_xdp->progs.__x64_sys_nop,
+								ifindex);
+	if (!ASSERT_OK_PTR(skel_xdp->links.__x64_sys_nop, "bpf_program__attach_xdp"))
+		goto out;
+
+	err = system("ping -q -c 1 -W 1 127.0.0.1 > /dev/null");
+	ASSERT_OK(err, "ping");
+	ASSERT_ERR(skel->bss->retval, "retval");
+
+out:
+	fentry_sleepable__destroy(skel);
+	xdp_dummy__destroy(skel_xdp);
+}
+
 /* NOTE: affect other tests, must run in serial mode */
 void serial_test_fexit_bpf2bpf(void)
 {
@@ -607,4 +662,6 @@ void serial_test_fexit_bpf2bpf(void)
 		test_func_replace_int_with_void();
 	if (test__start_subtest("freplace_void"))
 		test_func_replace_void();
+	if (test__start_subtest("sleepable_fentry_to_xdp"))
+		test_sleepable_fentry_to_xdp();
 }
diff --git a/tools/testing/selftests/bpf/progs/fentry_sleepable.c b/tools/testing/selftests/bpf/progs/fentry_sleepable.c
new file mode 100644
index 000000000000..8c0fc691d329
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_sleepable.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+void *user_ptr;
+int retval;
+
+SEC("fentry.s")
+int BPF_PROG(fentry_xdp)
+{
+	char buff[64];
+
+	retval = bpf_copy_from_user(buff, sizeof(buff), user_ptr);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_dummy.c b/tools/testing/selftests/bpf/progs/xdp_dummy.c
index d988b2e0cee8..5f1e0771021d 100644
--- a/tools/testing/selftests/bpf/progs/xdp_dummy.c
+++ b/tools/testing/selftests/bpf/progs/xdp_dummy.c
@@ -10,4 +10,10 @@ int xdp_dummy_prog(struct xdp_md *ctx)
 	return XDP_PASS;
 }
 
+SEC("xdp")
+int __x64_sys_nop(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

