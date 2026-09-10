Received: from mta0.migadu.com (out-108.mta0.migadu.com [91.218.175.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86481481FD0
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043039; cv=none; b=uFqWmjp54Qxevjv2+tfBjRRsvE9k34I31rgcEGhevbqqiLB8BpC4rLsZYucDuayi1Uo6oG76k8MNgUVW2lu0gcgOr/yZP1emn3wOJ8aku8GxVrML3Fk9xWpuVIDuaqtplxgFNLP52YBfTjQYCg7F5FqUEPq8dMoOLhqUBcZfPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043039; c=relaxed/simple;
	bh=DohzmBQXhTc3W9IsG0RnpMnqXNv9xW9Kj1PEpt+9ROI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8+8prVSgJvYq8koZUf/WTcO0nMII+HZWAEQZl77wauxWfdQrSvdz0nld8GX1UHX8AJsG3J2kQbRmKntMCLXhCieph6BwE3cAcI4Fdmdne9Yt8ffEWe4qMIuD2hdtNorTaspyDn3L39egGl9/0Grr1m4I7ZLxls/UXPO7lsqI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i8//xfhw; arc=none smtp.client-ip=91.218.175.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i8//xfhw"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DohzmBQXhTc3W9IsG0RnpMnqXNv9xW9Kj1PEpt+9ROI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789043034; v=1; x=1789647834;
 b=i8//xfhwqs6Tq8vEjl0Qm9U1ZbPNV8LsCnU7B9HOW4D+DmrfbQehHa0yEHNSjVqMx1s6UE9q
 GncccUQGgmOA21QgH7+OHWshbEWDHPR2R133cJKQOdBRxd6A81UJR/HVrKP/JrmRqFE/HKvbkEg
 0AmJZ2wN+fa8gHI5xXwDNG8o=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f8d3cdd5053f8d02;
	Thu, 10 Sep 2026 12:23:54 +0000
X-Mizu-Trace-ID: f8d3cdd5053f8d02
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
	Yazhou Tang <tangyazhou518@outlook.com>,
	Amery Hung <ameryhung@gmail.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Test BTF walk into a flexible array of zero-sized elements
Date: Thu, 10 Sep 2026 20:22:56 +0800
Message-ID: <20260910122316.186384-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910122316.186384-1-jiayuan.chen@linux.dev>
References: <20260910122316.186384-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The program stashes a bpf_obj_new() object whose type ends with a flexible
array of empty structs, then reads it back as an untrusted kptr. Without
the previous patch this divides by zero in btf_struct_walk() instead of
being rejected.

  # ./test_progs -t verifier_btf_flex_array
  ...
  #602     verifier_btf_flex_array:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_btf_flex_array.c       | 56 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_btf_flex_array.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index f7f94ccebce2..33a5da37e3ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -24,6 +24,7 @@
 #include "verifier_bpf_trap.skel.h"
 #include "verifier_bswap.skel.h"
 #include "verifier_btf_ctx_access.skel.h"
+#include "verifier_btf_flex_array.skel.h"
 #include "verifier_btf_unreliable_prog.skel.h"
 #include "verifier_call_large_imm.skel.h"
 #include "verifier_cfg.skel.h"
@@ -188,6 +189,7 @@ void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_stack); }
 void test_verifier_bpf_trap(void)             { RUN(verifier_bpf_trap); }
 void test_verifier_bswap(void)                { RUN(verifier_bswap); }
 void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
+void test_verifier_btf_flex_array(void)       { RUN(verifier_btf_flex_array); }
 void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
 void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_flex_array.c b/tools/testing/selftests/bpf/progs/verifier_btf_flex_array.c
new file mode 100644
index 000000000000..59b84261f622
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_flex_array.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_experimental.h"
+#include "bpf_misc.h"
+
+struct test_empty_event {};
+
+struct test_flex_batch {
+	int nr;
+	struct test_empty_event events[];
+};
+
+struct map_value {
+	struct test_flex_batch __kptr *batch;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} batches SEC(".maps");
+
+SEC("syscall")
+__description("btf walk into flexible array of zero-sized elements")
+__failure __msg("access beyond struct test_flex_batch at off 4 size 1")
+int stash_and_peek(void *ctx)
+{
+	struct test_flex_batch *b, *old;
+	struct map_value *v;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&batches, &key);
+	if (!v)
+		return 0;
+
+	b = bpf_obj_new(struct test_flex_batch);
+	if (!b)
+		return 0;
+	b->nr = 1;
+
+	old = bpf_kptr_xchg(&v->batch, b);
+	if (old)
+		bpf_obj_drop(old);
+
+	b = v->batch;
+	if (!b)
+		return 0;
+
+	return b->nr + *(char *)&b->events[0];
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

