Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219037;
	b=WWdxhv/d8Zh7bMcs2SX60p9LcKMY5RLijscf9FeDg5m3qtOBv/UPwLznh4ILWul2V+BI
	 UFWbFr0TWc/pxMoU6f+AAqnOGfzLCFSEMvgACLN+M1JG/0E21x5Jt/LAWzdXVYYCKh7KO
	 M4ze6Df7XWJYrjEBKryEtjsOexJkPu0OaqsmAU2Vej7sXCU8rY9kXKQfGDkDyngiPx+Ul
	 S8OUxGSu45V3sPBXfYFLzpMO54eBJBU011EKxcKq1KYD02IssPdnpweOQTX93x4KL/vpM
	 OnC5Ay8Bxdm1tWxxRS3FBYQGylJ+7ZdE2IM9TM9AkF4HOMDc+cEeeWkTh3sAfBoI5QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219037;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=DCCi5eo/fYB6tzKxD/wYOm7N8O32aM+y60ei7JSb/fM=;
	b=Rw6yYH7eKEky7VznrLeE0iDtqcjXfN8mufO+Pc509p0JgEZfX985a7f/swhKPLkP+Dhj
	 YVt5U+3bNt7KX2fR6GtTYGZnKZOPJSJg/fA18pdCnqxFk22Zu8uKA/bPwQSYcqhrp8fBC
	 /6WuLuOdwhGECvCl7u75PC5EcP91mJjLk4kYKxeqQJ70ZIpdoYR5jyPCTWRVPWtb3/yjp
	 MyzEjhZrshLurPPm6aESozZPknQrvCLWCbcg7dJwX2jqgjoK7ZMCaFuql3KELD4K915P0
	 uiDYBxOUj5W1Br226xuI0j1U8b75SUx6jBEc7ZRSreaOygJnRtUFKY7VNPCL3Zc7I1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=iuCksMNr;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB9606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 20:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5CB9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=iuCksMNr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DCCi5eo/fYB6tzKxD/wYOm7N8O32aM+y60ei7JSb/fM=; b=iuCksMNrFHfk744rcdNkL5oX4M
	hBq4vnhastmYlSqSwO3polVP/xIoSrbViPiHDNlKJoCECptZ2S7ZPimx4Vxa70zMK07e5z13GvToX
	XxfIGEnLbe6jaOxLkzUV+dntJRU7VuevoIh4BVmmYU+uAa5X0UwjN7jkQJRotUtl5/eOkZf9I9P9s
	TMEwy4wA7ko6CnVvHahJESHcNE6lfq4L9LO1QUSLzFVoulI/BcPrKYPvR4RMhi13HuWMJhtO7upac
	aWlygwiTCIT87sS9f/XBi2xYMCNP6hCCaRm4p5SraEpny+UOUB5266ElFmyhzt+UsOwxzv9t2JVBa
	FbdU2xbA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xMABX-0007IS-0r;
	Wed, 28 Oct 2026 21:23:47 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: rostedt@goodmis.org,
	ast@kernel.org,
	andrii@kernel.org,
	jolsa@kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Test kprobe and fentry/fexit programs on one function
Date: Wed, 28 Oct 2026 21:23:45 +0100
Message-ID: <20261028202345.1215859-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028202345.1215859-1-daniel@iogearbox.net>
References: <20261028202345.1215859-1-daniel@iogearbox.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28167/Wed Oct 28 07:24:17 2026)

A kprobe next to a BPF trampoline makes the ftrace site of the function
call ftrace_regs_caller and from there the list of ftrace callbacks,
the path that crashed while ftrace_ops_list_func() started at an odd
address. No test covers a function traced by both. Thus, attach an
fentry program and a kprobe to bpf_fentry_test1(), then a second fentry
program, which modifies the trampoline of the shared site, then an fexit
program, after which ftrace_regs_caller enters the trampoline by a jmp,
then detach the kprobe, after which the site jumps to it directly. After
each step, check that every attached program ran once for the call and
saw its argument, and the fexit program its return value.

Without the previous fix the test crashes the kernel, but only where
ftrace_ops_list_func() is at an odd address (in my test with gcc +
CONFIG_CC_OPTIMIZE_FOR_SIZE=y). With the fix it passes:

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t fentry_kprobe_shared
  [...]
  #147     fentry_kprobe_shared:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Menglong Dong <dongml2@chinatelecom.cn>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 .../bpf/prog_tests/fentry_kprobe_shared.c     | 65 +++++++++++++++++++
 .../bpf/progs/fentry_kprobe_shared.c          | 49 ++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c b/tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c
new file mode 100644
index 000000000000..751aa49d6106
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "fentry_kprobe_shared.skel.h"
+
+static void trigger(struct fentry_kprobe_shared *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.fentry1), &topts);
+	ASSERT_OK(err, "test_run");
+}
+
+/*
+ * With a kprobe next to the trampoline, the ftrace site of the function
+ * reaches the trampoline through the list of ftrace callbacks, and so does
+ * the site of a trampoline that is modified to add or remove a program.
+ * With the fexit program, the trampoline is entered by a jmp.
+ */
+void test_fentry_kprobe_shared(void)
+{
+	struct fentry_kprobe_shared *skel;
+
+	skel = fentry_kprobe_shared__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	skel->bss->pid = getpid();
+
+	skel->links.fentry1 = bpf_program__attach(skel->progs.fentry1);
+	if (!ASSERT_OK_PTR(skel->links.fentry1, "attach_fentry1"))
+		goto out;
+	skel->links.kprobe1 = bpf_program__attach(skel->progs.kprobe1);
+	if (!ASSERT_OK_PTR(skel->links.kprobe1, "attach_kprobe1"))
+		goto out;
+	trigger(skel);
+	ASSERT_EQ(skel->bss->fentry1_hits, 1, "fentry1_hits");
+	ASSERT_EQ(skel->bss->kprobe_hits, 1, "kprobe_hits");
+
+	skel->links.fentry2 = bpf_program__attach(skel->progs.fentry2);
+	if (!ASSERT_OK_PTR(skel->links.fentry2, "attach_fentry2"))
+		goto out;
+	trigger(skel);
+	ASSERT_EQ(skel->bss->fentry1_hits, 2, "fentry1_hits");
+	ASSERT_EQ(skel->bss->fentry2_hits, 1, "fentry2_hits");
+	ASSERT_EQ(skel->bss->kprobe_hits, 2, "kprobe_hits");
+
+	skel->links.fexit1 = bpf_program__attach(skel->progs.fexit1);
+	if (!ASSERT_OK_PTR(skel->links.fexit1, "attach_fexit1"))
+		goto out;
+	trigger(skel);
+	ASSERT_EQ(skel->bss->fentry1_hits, 3, "fentry1_hits");
+	ASSERT_EQ(skel->bss->fentry2_hits, 2, "fentry2_hits");
+	ASSERT_EQ(skel->bss->fexit_hits, 1, "fexit_hits");
+	ASSERT_EQ(skel->bss->kprobe_hits, 3, "kprobe_hits");
+
+	bpf_link__destroy(skel->links.kprobe1);
+	skel->links.kprobe1 = NULL;
+	trigger(skel);
+	ASSERT_EQ(skel->bss->fentry1_hits, 4, "fentry1_hits");
+	ASSERT_EQ(skel->bss->fentry2_hits, 3, "fentry2_hits");
+	ASSERT_EQ(skel->bss->fexit_hits, 2, "fexit_hits");
+	ASSERT_EQ(skel->bss->kprobe_hits, 3, "kprobe_hits");
+out:
+	fentry_kprobe_shared__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c b/tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c
new file mode 100644
index 000000000000..3d16773aada8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pid;
+int fentry1_hits;
+int fentry2_hits;
+int fexit_hits;
+int kprobe_hits;
+
+static bool from_test(int a)
+{
+	return (bpf_get_current_pid_tgid() >> 32) == pid && a == 1;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry1, int a)
+{
+	if (from_test(a))
+		fentry1_hits++;
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry2, int a)
+{
+	if (from_test(a))
+		fentry2_hits++;
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(fexit1, int a, int ret)
+{
+	if (from_test(a) && ret == 2)
+		fexit_hits++;
+	return 0;
+}
+
+SEC("kprobe/bpf_fentry_test1")
+int BPF_KPROBE(kprobe1, int a)
+{
+	if (from_test(a))
+		kprobe_hits++;
+	return 0;
+}
-- 
2.43.0

