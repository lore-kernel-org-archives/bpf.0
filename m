Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560520;
	b=Ydobgog7Ssi78dx9GLTQXH3niDaX0lXgaQvfpSuO4qtcrmt8iq1r7DNK+VdpDSsdFV1c
	 LUMeVOPvnPnoaPirfL9ZqTIbP6ebtPGSbeAz2T37Zmrze6Q96yLKTKuRSMPgu355fdWnp
	 iD/lWnjSWPw01PfzW/rHrIGtyjh8RnvqA8oG0xTX4Go3QfoCn+Zfw2VaG4KqM4artqYGo
	 jd2/Vf7PQxMSdeOy/lK4ujXDxQekoVfnxYjP4pQljLspqc7j2CkEQDod82L0uXYjPxMB7
	 xPSi6AR7jRxjVXoB5cz+BX3EzcVr+6GceC9tmOP4p2C4rgGW0SGMB9MOVtFz1bkz4HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560520;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eiFf1/ZX0x4TPZURmW0qi8uagLmw49tN1yU5fbQU1KI=;
	b=TbUCaIjm93HrmoXK9tmqHzhqm+T6cUwZWo2mdGg6IZFnUye3gxn4I0GY4117CseVIjAU
	 i4j5cGxEXxTrvBl7VZ2SXh3umlXP+4R1oZcIYXVaOl4EhfiTuLcHsHJIKi0HexbuDfkH6
	 MRcloGcJQhMqZQTkgjCAsFpxlR5qqDV500Y1MMYAfWUBr1t0tRe54GLr/zYx/heUo01qd
	 /1srx/Hm86jBgV3YWz3DsfiamBGwNUjX6iHF6afwHZCiv+JR0ooSaMCAhHTkxN3Keqx79
	 SGtu30EK6exarjMoLjNBc+EtsuLQj+m8BP8vX2i0lLfj9zmIq68r85eMevbm0JorNkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="AvX/+e2o";
	arc=none smtp.remote-ip=95.215.58.69
Received: from mta1.migadu.com (out-69.mta1.migadu.com [95.215.58.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028B606A326
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E028B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AvX/+e2o
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wGzuJ2tsy16VrGrlGhasL3A14wXGG8Z8FdNekGk0n2c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795560518; v=1; x=1796165318;
 b=AvX/+e2oUV+kbAjv0sQvq8Z4GrR5yLZSgXf8sU6uxC/w4S08ilBAOCuEZlimvyLrcmqnajnF
 EUnFfio2+my3xDx9ST7m2TTfprDG55Z25//S2Urk+IXNK5YIgkAoOxTDX65PwiPOqqbIOQShg7J
 TU24QcrzLbOr3QD3aModDUis=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8276b2be94724bc7;
	Tue, 24 Nov 2026 22:48:37 +0000
X-Mizu-Trace-ID: 8276b2be94724bc7
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
Subject: [PATCH bpf-next v3 4/6] selftests/bpf: Test kfunc variant selection by prototype
Date: Tue, 24 Nov 2026 15:48:09 -0700
Message-ID: <20261124224811.16134-5-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124224811.16134-1-ihor.solodrai@linux.dev>
References: <20261124224811.16134-1-ihor.solodrai@linux.dev>
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

Register two kfunc variants in bpf_testmod that differ only in a struct
pointee:

  int bpf_kfunc_variant(struct task_struct *p);
  int bpf_kfunc_variant___v2(struct file *p);

Check that a declaration of each resolves to it, and that a __weak
declaration with struct inode * stays unresolved.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  3 ++
 .../selftests/bpf/progs/kfunc_variants.c      | 32 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 12 +++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  3 ++
 4 files changed, 50 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_variants.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 816ab3cfafc7..157267f90177 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -8,6 +8,7 @@
 #include "cap_helpers.h"
 #include "sysctl_helpers.h"
 #include "cb_refs.skel.h"
+#include "kfunc_variants.skel.h"
 #include "verifier_aggregate_arg.skel.h"
 #include "verifier_aggregate_ret.skel.h"
 #include "verifier_alu_range.skel.h"
@@ -225,6 +226,8 @@ void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_jit); }
 
 void test_cb_refs(void)                       { RUN_TESTS(cb_refs); }
 
+void test_kfunc_variants(void)                { RUN_TESTS(kfunc_variants); }
+
 void test_verifier_aggregate_arg(void)        { RUN_TESTS(verifier_aggregate_arg); }
 void test_verifier_aggregate_ret(void)        { RUN_TESTS(verifier_aggregate_ret); }
 void test_verifier_alu_range(void)            { RUN(verifier_alu_range); }
diff --git a/tools/testing/selftests/bpf/progs/kfunc_variants.c b/tools/testing/selftests/bpf/progs/kfunc_variants.c
new file mode 100644
index 000000000000..a9c393ea9d82
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kfunc_variants.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+extern int bpf_kfunc_variant___none(struct inode *p) __weak __ksym;
+
+char _license[] SEC("license") = "GPL";
+
+SEC("syscall")
+__retval(1)
+int unsuffixed_name(void *ctx)
+{
+	return bpf_kfunc_variant(NULL);
+}
+
+SEC("syscall")
+__retval(2)
+int kernel_variant(void *ctx)
+{
+	return bpf_kfunc_variant___v2(NULL);
+}
+
+SEC("syscall")
+__retval(0)
+int no_match(void *ctx)
+{
+	return bpf_ksym_exists(bpf_kfunc_variant___none);
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 1fbc0061cc24..764877cdce6e 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1928,6 +1928,16 @@ __bpf_kfunc void bpf_kfunc_trigger_ctx_check(void)
 	irq_work_queue(&ctx_check_irq);
 }
 
+__bpf_kfunc int bpf_kfunc_variant(struct task_struct *p__nullable)
+{
+	return 1;
+}
+
+__bpf_kfunc int bpf_kfunc_variant___v2(struct file *p__nullable)
+{
+	return 2;
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc, KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -2019,6 +2029,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)
 BTF_ID_FLAGS(func, bpf_kfunc_trigger_ctx_check)
+BTF_ID_FLAGS(func, bpf_kfunc_variant)
+BTF_ID_FLAGS(func, bpf_kfunc_variant___v2)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 0a7df1798603..ce579eede88d 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -381,4 +381,7 @@ void bpf_testmod_test_hardirq_fn(void);
 void bpf_testmod_test_softirq_fn(void);
 void bpf_kfunc_trigger_ctx_check(void) __ksym;
 
+int bpf_kfunc_variant(struct task_struct *p__nullable) __ksym;
+int bpf_kfunc_variant___v2(struct file *p__nullable) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.56.0

