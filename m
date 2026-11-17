Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943334;
	b=XOeTVh0FTbb3xMuZTHOP6wso34NvJU5WItmjHHNg96Ryk3nyUIZlZWVCM19c8cTKQP3u
	 mqMTRnUGqll2EMmGlHXKRkcJ6LhGNwGeAU7n+jGCLMHUIacDcuAyrIstQvL314AUwCYLF
	 J7CgWqROvCgFaN0BqVndeEs1CKd09LxSSv5Om1sViddS/ppZ+U2h81LelqDBc45Z98uYG
	 u7UequskvCoCLtdpQF8Q0Ny11CnUvhhhucxy00VuvFinddBnz4ukvQHn7PTT9C9chglgl
	 6dRl9bHhcqEc54N1/N+U4cROptKYDqf/TYHA/3Y3TkG2W+u1DqEbLoWUmTjtEKnEgTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943334;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lz1w0EbtXOaAAdwJrE+Xz3/OXCsOt9qjYg0cSN3P5K8=;
	b=wmu4P/vBGuZB9NhZiNEKTlwfEDwKsT4/hgQFbkigj4NghvLEdd3UDJi6s7h0zUHYjA7S
	 KE8Tj7OzuHpayE/tn1sAgjzqAgiqsKklesfJmACv569Kju1/y3PEd11f84X+aSWYxCfEn
	 CtbspJspL+tdSBDMkytQsEXavQChgb0Wwd3AsK+NtEWhdUZ6XaK6RUrqPRKhjXrdjrwiS
	 F2SGvb6V3bx6ev9IFuZjQptu9K0OrKhY0zeF6KYWkP7ccSLu5kzjWXlpOsqbU/tWAUjI+
	 oMqb59GBM5spD+p5KUb3PgXaCwcb7hkyPUAII+Ip7GUsMpHHDhzgWoHsbcj/ddQ5H5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kNcKugEk;
	arc=none smtp.remote-ip=95.215.58.172
Received: from mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78661606A883
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 19:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78661606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kNcKugEk
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DSL0/flEAkrpeSSX6CykC8WxfpOVs7TOq2uMFy4Bz7M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794943330; v=1; x=1795548130;
 b=kNcKugEkStDLdWg9HybVvVuFyU3N771mn79+ZBWEGhJmwD3vJmChWrUv1Qe/uRBYVQKYYk8c
 pgW7TV0hpPRUeMBHKNWgsaYOhG6sogLO9vJhj9lDbgw4KZ8jQLSPnPEN8FmJAtrPJFxZQS0bLPw
 5d2QDyxOh9adjofJxPEU8Pk4=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id c15985febec1e1e2;
	Tue, 17 Nov 2026 19:22:10 +0000
X-Mizu-Trace-ID: c15985febec1e1e2
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Song Liu <song@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v1 2/4] selftests/bpf: Test kfunc flavor resolution
Date: Tue, 17 Nov 2026 12:21:51 -0700
Message-ID: <20261117192153.3384031-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
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

Add a kfunc family to bpf_testmod: bpf_kfunc_flavor() with the current
prototype, bpf_kfunc_flavor___v1() with an older one that takes one
fewer parameter, and bpf_kfunc_flavor___v2(), an alias with the exact
prototype of bpf_kfunc_flavor().

Check that libbpf binds:
- bpf_kfunc_flavor to the kfunc itself rather than to its alias ___v2;
- the old prototype to ___v1, both under a local flavor and under the
  kernel name, as a header generated from BTF spells it;
- the kernel name with a local flavor on top to ___v1;
- a __weak kfunc that matches no member to nothing.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  3 +
 .../selftests/bpf/progs/kfunc_flavors.c       | 55 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 24 ++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  4 ++
 4 files changed, 86 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_flavors.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 57ff2578a991..351e53744e37 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -8,6 +8,7 @@
 #include "cap_helpers.h"
 #include "sysctl_helpers.h"
 #include "cb_refs.skel.h"
+#include "kfunc_flavors.skel.h"
 #include "verifier_aggregate_arg.skel.h"
 #include "verifier_aggregate_ret.skel.h"
 #include "verifier_alu_range.skel.h"
@@ -220,6 +221,8 @@ void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_jit); }
 
 void test_cb_refs(void)                       { RUN_TESTS(cb_refs); }
 
+void test_kfunc_flavors(void)                 { RUN_TESTS(kfunc_flavors); }
+
 void test_verifier_aggregate_arg(void)        { RUN_TESTS(verifier_aggregate_arg); }
 void test_verifier_aggregate_ret(void)        { RUN_TESTS(verifier_aggregate_ret); }
 void test_verifier_alu_range(void)            { RUN(verifier_alu_range); }
diff --git a/tools/testing/selftests/bpf/progs/kfunc_flavors.c b/tools/testing/selftests/bpf/progs/kfunc_flavors.c
new file mode 100644
index 000000000000..6b06cb8d8447
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kfunc_flavors.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+/* the old prototype of bpf_kfunc_flavor(), under local flavors */
+extern int bpf_kfunc_flavor___old(int a) __ksym;
+extern int bpf_kfunc_flavor___v1___local(int a) __ksym;
+/* a prototype that no member of the family has */
+extern int bpf_kfunc_flavor___none(void) __weak __ksym;
+
+char _license[] SEC("license") = "GPL";
+
+/* bpf_kfunc_flavor binds itself, though its alias ___v2 matches too */
+SEC("syscall")
+__retval(3)
+int exact_name(void *ctx)
+{
+	return bpf_kfunc_flavor(1, 2);
+}
+
+/* the old prototype under a local flavor binds ___v1 */
+SEC("syscall")
+__retval(1)
+int local_flavor(void *ctx)
+{
+	return bpf_kfunc_flavor___old(1);
+}
+
+/* so does the kernel name, which strips to bpf_kfunc_flavor */
+SEC("syscall")
+__retval(1)
+int kernel_flavor(void *ctx)
+{
+	return bpf_kfunc_flavor___v1(1);
+}
+
+/* a local flavor on top of the kernel name binds ___v1 by name */
+SEC("syscall")
+__retval(1)
+int stacked_flavor(void *ctx)
+{
+	return bpf_kfunc_flavor___v1___local(1);
+}
+
+/* a __weak kfunc that matches no member stays unresolved */
+SEC("syscall")
+__retval(0)
+int no_match(void *ctx)
+{
+	return bpf_ksym_exists(bpf_kfunc_flavor___none);
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 1f8bc0c99a71..e16559607270 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1926,6 +1926,27 @@ __bpf_kfunc void bpf_kfunc_trigger_ctx_check(void)
 	irq_work_queue(&ctx_check_irq);
 }
 
+/*
+ * A kfunc family for the kfunc_flavors test: bpf_kfunc_flavor() has the
+ * current prototype, ___v1 an older one, and ___v2 is an alias with its exact
+ * prototype. ___v2 negates the result, so that the test can tell which of the
+ * two it called.
+ */
+__bpf_kfunc int bpf_kfunc_flavor(int a, int b)
+{
+	return a + b;
+}
+
+__bpf_kfunc int bpf_kfunc_flavor___v1(int a)
+{
+	return bpf_kfunc_flavor(a, 0);
+}
+
+__bpf_kfunc int bpf_kfunc_flavor___v2(int a, int b)
+{
+	return -bpf_kfunc_flavor(a, b);
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc, KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -2017,6 +2038,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)
 BTF_ID_FLAGS(func, bpf_kfunc_trigger_ctx_check)
+BTF_ID_FLAGS(func, bpf_kfunc_flavor)
+BTF_ID_FLAGS(func, bpf_kfunc_flavor___v1)
+BTF_ID_FLAGS(func, bpf_kfunc_flavor___v2)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 0a7df1798603..2c6126e4f0d0 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -381,4 +381,8 @@ void bpf_testmod_test_hardirq_fn(void);
 void bpf_testmod_test_softirq_fn(void);
 void bpf_kfunc_trigger_ctx_check(void) __ksym;
 
+int bpf_kfunc_flavor(int a, int b) __ksym;
+int bpf_kfunc_flavor___v1(int a) __ksym;
+int bpf_kfunc_flavor___v2(int a, int b) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.56.1

