Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1C49BD7B
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050076; cv=none; b=IVEcoXGXX6xKuisBQresIhat5vqMe5C5abQ5rULP0Vi9yjUoolRlqaWggvMj9yCQrE+trzNaXdZrG6Dzun6dpPk7xdxDlVPhhI1JFerfdl7e4l5j//SW8+tDSOq2+02Qc9zIkM20h20NtluJ58J33UR0E8UlGyCuazO82XvEn5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050076; c=relaxed/simple;
	bh=KEXZhOwEhd+rq1Vdg69J+qrsz7t5esLxBsDJa2qQpPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ve5dLrFDTRRts/pPvpYPWRNDEOir1UG366n5p9uK4Cab1RYaQNUXJobhg8W70wpkaMBqmKOgdeNt0u7N/emtRGvc3Ak64CvOfyRugaEo4e2A/ITqYPRnJ32g5Vd+UDfj1i7OGhH/GSXjIMRz66bGGGi7Q6U9DynlrQKOzq+DlI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=S028lbJy; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="S028lbJy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7h48JWPMxhAKtDp1WmmS04c9LSoSyaBWkaFs2zljscc=; b=S028lbJyKTyAMfbBdUV5XknpDJ
	wMBUzQQneA+qRcOCypEIRZd90SbpWcNL3vUvs5TM72GQpQEHXAL7vLjK+7u8qpq4kdpjYp7RjNxcR
	ffQd4AuX/NOvZWfSsbAq3fvKDcuoNOXAYUojv3rfWK9Ca3iyNg29MQMTnYN3he/K0KaHolEZV2+dE
	z+zySBlH8mhMuPrJPwAroxL5nO+jHB38TwpNekKXASkl3rItYbEU/MdqH6TauXBpNfnQNue/dg7NB
	19j9qWJWBh4+kSOrcp0rGnwkT7Ub/yo0hDPz0fYJ8hNLEymVGga//rJ/Xrz6uWFLjPvS/sFntXBRF
	s8ML/hdA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4feI-000GmD-0d;
	Thu, 10 Sep 2026 16:21:10 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf 4/4] selftests/bpf: Add tests for the KF_PERFMON gates
Date: Thu, 10 Sep 2026 16:21:07 +0200
Message-ID: <20260910142107.40582-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910142107.40582-1-daniel@iogearbox.net>
References: <20260910142107.40582-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28119/Thu Sep 10 08:24:09 2026)

Add test cases where each one loads with CAP_BPF alone and checks that
the program is correctly rejected.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_kfunc_perfmon
  [...]
  #627/1   verifier_kfunc_perfmon/rdonly_cast_noperfmon:OK
  #627/2   verifier_kfunc_perfmon/rdonly_cast_noperfmon @unpriv:OK
  #627/3   verifier_kfunc_perfmon/probe_read_kernel_dynptr_noperfmon:OK
  #627/4   verifier_kfunc_perfmon/probe_read_kernel_dynptr_noperfmon @unpriv:OK
  #627/5   verifier_kfunc_perfmon/stream_vprintk_noperfmon:OK
  #627/6   verifier_kfunc_perfmon/stream_vprintk_noperfmon @unpriv:OK
  #627/7   verifier_kfunc_perfmon/arg_untrusted_read_noperfmon:OK
  #627/8   verifier_kfunc_perfmon/arg_untrusted_read_noperfmon @unpriv:OK
  #627     verifier_kfunc_perfmon:OK
  Summary: 1/8 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_kfunc_perfmon.c        | 63 +++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_perfmon.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 64ac49ad67e6..ec9e3907c75d 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -53,6 +53,7 @@
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_jit_convergence.skel.h"
+#include "verifier_kfunc_perfmon.skel.h"
 #include "verifier_ld_ind.skel.h"
 #include "verifier_ldsx.skel.h"
 #include "verifier_leak_ptr.skel.h"
@@ -216,6 +217,7 @@ void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
+void test_verifier_kfunc_perfmon(void)        { RUN(verifier_kfunc_perfmon); }
 void test_verifier_load_acquire(void)         { RUN(verifier_load_acquire); }
 void test_verifier_ld_ind(void)               { RUN(verifier_ld_ind); }
 void test_verifier_ldsx(void)                  { RUN(verifier_ldsx); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_perfmon.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_perfmon.c
new file mode 100644
index 000000000000..c6adbb4816ce
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_perfmon.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+void *user_ptr;
+char dynptr_buf[8];
+u64 kaddr;
+
+SEC("socket")
+__success
+__caps_unpriv(CAP_BPF)
+__failure_unpriv
+__msg_unpriv("bpf_rdonly_cast is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
+int rdonly_cast_noperfmon(void *ctx)
+{
+	char *p = bpf_rdonly_cast(0, 0);
+
+	return p[0x7fff];
+}
+
+SEC("socket")
+__success
+__caps_unpriv(CAP_BPF)
+__failure_unpriv
+__msg_unpriv("bpf_probe_read_kernel_dynptr is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
+int probe_read_kernel_dynptr_noperfmon(void *ctx)
+{
+	struct bpf_dynptr dptr;
+
+	bpf_dynptr_from_mem(dynptr_buf, sizeof(dynptr_buf), 0, &dptr);
+	bpf_probe_read_kernel_dynptr(&dptr, 0, sizeof(dynptr_buf), user_ptr);
+	return 0;
+}
+
+SEC("socket")
+__success
+__caps_unpriv(CAP_BPF)
+__failure_unpriv
+__msg_unpriv("bpf_stream_vprintk is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
+int stream_vprintk_noperfmon(void *ctx)
+{
+	bpf_stream_printk(BPF_STDOUT, "%pB", (void *)kaddr);
+	return 0;
+}
+
+__weak int subprog_untrusted_read(void *p __arg_untrusted)
+{
+	return *(char *)p;
+}
+
+SEC("socket")
+__success
+__caps_unpriv(CAP_BPF)
+__failure_unpriv
+__msg_unpriv("rdonly_untrusted_mem access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
+int arg_untrusted_read_noperfmon(void *ctx)
+{
+	return subprog_untrusted_read(0);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

