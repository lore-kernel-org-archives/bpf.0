Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995FE4E66CE
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076125; cv=none; b=DbpMo/Xl/UrwleNaL5YPc1RxxlewQTHvSHmiGPnA6dWyrEn5M762wqZYg+qQ/gZSVHYn0o3ZUS5mEmvdFQsbqFA+6laWQ7UrtHh07vAqSqtV9KFoPg1Yh5zqCxgq9QIYP2uOIoSEk5T2trBRnuxg4RLqIIaZJKGTyY60oOpfHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076125; c=relaxed/simple;
	bh=Obq4y3yEoMEsJexcWWjvWmP/tRrJsciexyf8KN9l3JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/WaoE6KdrcqWfcFU2/4gtWLYnDwbBMWoO06ESbD2TLzYToi+7Ru8iY35YK/CJCkfXAms5ykJxnS0pVDc0+Xmunox6oJHZj86h0bZ25Y9lLGC8sQmsW3/A/7g+xJeQspfnrES3IVJScp8acgVodbpi6o1LsLMVosM/Vde/L43Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MNFyEl/w; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MNFyEl/w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZFw1BhoglTYlmbsooEHu9c7nuAsEvZjpERPiCSUbp8Q=; b=MNFyEl/w8Awvy+ZjObVMc77EpA
	oiJMeAgS19tfh9jGNXSr8/9qpKLVT/77Ec6Jwlg3blJwqT52sMKQo+NqPobta8pFEcYKzdkx5NoSV
	bwVZzo1wn9kuADWGb07QYvYUp+7PBTRGLzxrrwChPHvpF9sp2j7Q4qWgKR/lOzx38/zhfQIL9HJ04
	jRgKK5jTsNrLHSxJJ1g8nTkUnU/N6nf1j8fZmxfHtxa+WxMVEuVwPS056qimmiYuBIhli3iKkbQvV
	Ub+vLpBYL+RpeZalzvgdcXltF7GhEezfCs8cstZTZLUjg4t6g5rj9zowu4m35IEq/8QOOjAaWkpe1
	QFcOsUhQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x4mQL-000H2X-1B;
	Thu, 10 Sep 2026 23:35:13 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 4/4] selftests/bpf: Add tests for the KF_PERFMON gates
Date: Thu, 10 Sep 2026 23:35:10 +0200
Message-ID: <20260910213510.49358-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910213510.49358-1-daniel@iogearbox.net>
References: <20260910213510.49358-1-daniel@iogearbox.net>
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
  #627/7   verifier_kfunc_perfmon/get_kmem_cache_noperfmon:OK
  #627/8   verifier_kfunc_perfmon/get_kmem_cache_noperfmon @unpriv:OK
  #627/9   verifier_kfunc_perfmon/arg_untrusted_read_noperfmon:OK
  #627/10  verifier_kfunc_perfmon/arg_untrusted_read_noperfmon @unpriv:OK
  #627     verifier_kfunc_perfmon:OK
  Summary: 1/10 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_kfunc_perfmon.c        | 75 +++++++++++++++++++
 2 files changed, 77 insertions(+)
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
index 000000000000..76c39ef30e96
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_perfmon.c
@@ -0,0 +1,75 @@
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
+extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym;
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
+SEC("socket")
+__success
+__caps_unpriv(CAP_BPF)
+__failure_unpriv
+__msg_unpriv("bpf_get_kmem_cache is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
+int get_kmem_cache_noperfmon(void *ctx)
+{
+	return !!bpf_get_kmem_cache(kaddr);
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

