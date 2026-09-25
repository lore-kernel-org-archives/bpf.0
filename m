Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11144CA29D
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790358784; cv=none; b=gd7ejJK5TEHlhKWnLoucsFI7uZ4BmgVkuyOZRQywg1Gl2NvsuVlU6mx8828np91KAh5SxQvnV3mbP7dpUdNIM+ri1RyDENR/9xcB6HpGogheoDFJFBK+1Sz3jH7gnH1l/vU0QjHTL/o0arHqxUb/LYSPFtrCQAPP2B3csMI3+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790358784; c=relaxed/simple;
	bh=lLGiMh6ZuNOcXl5z8r9yJLxGoUWmjqVX7H3p5MCPazs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS3mXSbVPhDhx8ePuG4GsiRcVri8+OhpYzicq2yuqkZ6Xnhrm/qDPgEw2NZiPbSsZLpXc8UVDUKlQomkGmRwJIT6bLTga+qxIU3h5MoKa9ALhf07FIuUfcWD2MdDGTzgwNsBiNpwFC1p5Av3hlGDNEtTforyeWRuOA7qIBd5mwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=BO1KY/2R; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="BO1KY/2R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9YUsW8A74GAH04bD4/VKsrtXYmG2/LHg9+7dzmw4vJA=; b=BO1KY/2RpeKsz9XNmMBYg2kACg
	d5yAWnq2UbzTDv7e6cInJm+f/EIum3ygOkCRWzsD1QIpzHJcwUU3jXgh1V9b4TSfaETLblSaFcqDb
	IXcurHuKN+R3oFCODUhkKOhMfeyY4myZaXGbP3r2IXmcbUbyrnwbeIGFLXc0h4CNnj5oKNHllzrua
	WFmtwD7qPYefot/BamYhqCgt3LxahbVcZbnYfoVMsDHGcvZQ4BWBW12QHYoAQFEMfnHrMLUan5slA
	+J6+KR6mp4ofVNpaVyf6Hfkx1g3RqGJleQRQPzPZ0B5JxCSWSpmnqK+0lcLSQeXpEKoo49vVWp0Ux
	uh+uP1zA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xAA6R-000Jlf-0h;
	Fri, 25 Sep 2026 19:52:55 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 16/16] selftests/bpf: Add a test for an exception callback behind a dead subprog
Date: Fri, 25 Sep 2026 19:52:43 +0200
Message-ID: <20260925175244.1136329-17-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
References: <20260925175244.1136329-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28134/Fri Sep 25 08:25:58 2026)

Add a test where a static subprogram only called from dead code sits in
front of the exception callback, so that its removal compacts
subprog_info[] underneath the callback's index.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t exceptions
  [...]
  #129/119 exceptions/exception_cb_behind_dead_subprog:OK
  #129     exceptions:OK
  Summary: 1/119 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/exceptions.c     |  7 ++++
 .../bpf/progs/exceptions_dead_subprog.c       | 40 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_dead_subprog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
index 639866ce09a9..3705db18c1bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -6,6 +6,7 @@
 #include "exceptions_ext.skel.h"
 #include "exceptions_fail.skel.h"
 #include "exceptions_assert.skel.h"
+#include "exceptions_dead_subprog.skel.h"
 
 static char log_buf[1024 * 1024];
 
@@ -410,9 +411,15 @@ static void test_exceptions_assertions(void)
 	RUN_TESTS(exceptions_assert);
 }
 
+static void test_exceptions_dead_subprog(void)
+{
+	RUN_TESTS(exceptions_dead_subprog);
+}
+
 void test_exceptions(void)
 {
 	test_exceptions_success();
 	test_exceptions_failure();
 	test_exceptions_assertions();
+	test_exceptions_dead_subprog();
 }
diff --git a/tools/testing/selftests/bpf/progs/exceptions_dead_subprog.c b/tools/testing/selftests/bpf/progs/exceptions_dead_subprog.c
new file mode 100644
index 000000000000..4f8b82a85234
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_dead_subprog.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+/*
+ * Read-only and frozen, so the verifier sees a constant zero, while clang
+ * cannot fold the volatile read and keeps the call below.
+ */
+const volatile int never;
+
+/* Only called from dead code, hence removed as a whole before the JIT runs. */
+static __noinline int dead_subprog(struct __sk_buff *ctx)
+{
+	return ctx->len;
+}
+
+__noinline int exception_cb_behind_dead_subprog_cb(u64 cookie)
+{
+	return 42;
+}
+
+/*
+ * libbpf appends the exception callback behind the subprograms reached by
+ * calls, so removing the dead one compacts subprog_info[] underneath the
+ * callback's index.
+ */
+SEC("?tc")
+__exception_cb(exception_cb_behind_dead_subprog_cb)
+__success __retval(42)
+int exception_cb_behind_dead_subprog(struct __sk_buff *ctx)
+{
+	if (never)
+		return dead_subprog(ctx);
+	bpf_throw(0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

