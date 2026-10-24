Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792827450;
	b=N76b1dRhHIw9el360cQhQf31jC3JhdHARu9oIFO2qSB9fbGCOS+Uhygb3HWQ3yMmkoco
	 JZ4Ic/DKnaVuO9pXUGoHoS93F50DxZ9h/bDi1wvR8kKu0fFPZttncSuj8EkdgMWSZdAh3
	 2pwhq5+97SGkuO6ie9BHi0K+gtcyuWOAd78nEEPTJiksMoEu6QYqrsCz6kiCCYqG7xv6+
	 k46VK9v+7LJ8nRQy5hR3nC3e48eC63FnjEBWPeJj2EuH2qAuERe/ej/OO5PqvPULEhL7M
	 DABuQWznLDkiE2fnKREJOCo+nMj45iJAZVDCmPDAu7DWuMDSwr2F3A18T56wz5K0e1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792827450;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=QLl3K3NbhvyBUyt3G6F/2Tn6IpOlRe56J82JooDIwDQ=;
	b=qZIdpffKDqEDDZSgOOqH5E7FbDHQQMAMx+6E8RMWiyULdDiPplEuAiePSYiY2G1vTNZz
	 VaLpnBEnJ/RIMC03m881hgI8lZlwhpV/BpMjoTr38W1AVOjQIfI5jRyDvoUBqN1dPVIaj
	 YGx4xOiaHAzwBBzFeO7I28PHPBL226bcjooPtwVQ9ScpnTgiYXwHmIdwM5W22/1ZPAbHq
	 fIh+YnYs6HRmB+ZIPB0U0wFFg7Uo17YjRxof2dRhXObEsoG4W/IRQX878RGzzIxqg305B
	 HB0r225Q+NnK6gwLRooL5wPrxByqjWMoMB+WF3LZYmoUCzzD9wFoBkN77nuuG4IuRIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=DAJeOcJD;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6F606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 07:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBB6F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=DAJeOcJD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QLl3K3NbhvyBUyt3G6F/2Tn6IpOlRe56J82JooDIwDQ=; b=DAJeOcJDGu6rfDD4JE2aKjzR7Q
	9YCPY8q8IE+YHCqH91kZTW87Ga2MFts4OAUWsXZ4An0FTftK/67wBofrm0eKrzlCLEBjv7TaVj7eK
	EJLmuurULL46i3kgsXpU0D1pWgm+nIUGalocM1YhMZq9nsUaA6nFBWViUwJ1GTzqZ76BMjDLedh6m
	VYPCHvtyE/dOwf713DKjKYW8mMD8Uf8oxl4volyToWxIFPnsBxGPxrYuYU8bBi4MnWg3HpVGWhHeZ
	YYwHx5l1EuxVPh+DR4dbiqOZOhfjZSCO41LzBqiwK/SvhD3kGH7KbQO6utCBG//lvaCqymIH+VJqW
	Q5rAaBUg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xKWJV-000MYx-2Z;
	Sat, 24 Oct 2026 09:37:13 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	jolsa@kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH bpf 2/2] selftests/bpf: Test kprobe and fentry programs on one function
Date: Sat, 24 Oct 2026 09:37:12 +0200
Message-ID: <20261024073712.1074591-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024073712.1074591-1-daniel@iogearbox.net>
References: <20261024073712.1074591-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28162/Fri Oct 23 08:24:08 2026)

A kprobe next to a BPF trampoline makes the ftrace site of the function
call ftrace_regs_caller and from there the list of ftrace callbacks,
the path that crashed while ftrace_ops_list_func() started at an odd
address. No test covers a function traced by both. Thus, attach an
fentry program and a kprobe to bpf_fentry_test1(), then a second fentry
program, which modifies the trampoline of the shared site, then detach
the kprobe. After each step, check that every attached program ran once
for the call and saw its argument.

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
 .../bpf/prog_tests/fentry_kprobe_shared.c     | 54 +++++++++++++++++++
 .../bpf/progs/fentry_kprobe_shared.c          | 40 ++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c b/tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c
new file mode 100644
index 000000000000..b53ddb983f6f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fentry_kprobe_shared.c
@@ -0,0 +1,54 @@
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
+	bpf_link__destroy(skel->links.kprobe1);
+	skel->links.kprobe1 = NULL;
+	trigger(skel);
+	ASSERT_EQ(skel->bss->fentry1_hits, 3, "fentry1_hits");
+	ASSERT_EQ(skel->bss->fentry2_hits, 2, "fentry2_hits");
+	ASSERT_EQ(skel->bss->kprobe_hits, 2, "kprobe_hits");
+out:
+	fentry_kprobe_shared__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c b/tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c
new file mode 100644
index 000000000000..aae8d9d29d37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fentry_kprobe_shared.c
@@ -0,0 +1,40 @@
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
+SEC("kprobe/bpf_fentry_test1")
+int BPF_KPROBE(kprobe1, int a)
+{
+	if (from_test(a))
+		kprobe_hits++;
+	return 0;
+}
-- 
2.43.0

