Received: from mta1.migadu.com (out-10.mta1.migadu.com [95.215.58.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C60048097E
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204855; cv=none; b=YDHusYTPpsGFhO/kXEA5OLWlU2UBZPYBlCxLasGI+2Yn1DbWYcNfRNwaxwJlU/85Ct4TtnAq5Att2AnJTpTPZxSilFhIX7Z0csdVjshjUWWiVRl/3Lp8wFcA2mRSHuOYObe0R89bm65mZ/pNmLk9fB9momVFkVdQM2ZAK7PyDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204855; c=relaxed/simple;
	bh=81PK34U6HMG/LYFolcKWlxjW4gzrFpy554cY2x+Tp3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blDA97PnHFOUA40mGwEr9zow+RIvxgXqKJxibroX95JO+48JoXMHhDWs3bTTID99/WY3ELXZ5LM3MxdrVMGDBCMa8LloKdUy0RzekCTYIHpH5rVPZaDIe5ZXvVZheO0CPEoEl6Pdwi+ESdD9BUgE5Rj2QT0mBb8yJSPS5No5Zr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FD9OFS7h; arc=none smtp.client-ip=95.215.58.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FD9OFS7h"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=81PK34U6HMG/LYFolcKWlxjW4gzrFpy554cY2x+Tp3A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790204849; v=1; x=1790809649;
 b=FD9OFS7hhAuEiPEFo/ZINGlsqELwdbAqrWsd2vgSJUu4wIZf94ZmlNpdlMRPfBKGRSdpqt3B
 iiLqJHmcgrBWU1cirm0dRHPU+3v+ipFPE0U1LpPRVvADOWz6mvEeuv0rlpnsEgVw/ploHlD+jDr
 v6HWtrREDpW0M5QjtyxaISp0=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id ff6c0e9317fe7dd8;
	Wed, 23 Sep 2026 23:07:29 +0000
X-Mizu-Trace-ID: ff6c0e9317fe7dd8
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH bpf-next v1] selftests/bpf: Refactor cb_refs selftests
Date: Wed, 23 Sep 2026 16:07:17 -0700
Message-ID: <20260923230717.3156345-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cb_refs matches verifier messages such as "Unreleased reference id=4
alloc_insn=3". The ID is allocated from env->id_gen, so it changes
whenever the verifier assigns another ID earlier in the program.

In the bpf tree commit 71919742c83c ("bpf: Assign lock identity to
callback map values") gives each callback map value an ID, and the
nested_cb expectation was changed to id=5.

In the bpf-next tree, commit 5dc1549afac9 ("bpf: Consolidate release
argument validation") changed leak_prog to expect id=4 from the same
leak check.

The trees are merged in linux-next, and there leak_prog reports id=5
and the test fails [1]:

  Expected: Unreleased reference id=4 alloc_insn=3
  ...
  Unreleased reference id=5 alloc_insn=33

The ID is incidental. The test checks that the verifier rejects the
leak and which acquisition leaked.

Convert the test to test_loader, register the test in
prog_tests/verifier.c and drop unnecessary prog_tests/cb_refs.c file.

[1] https://github.com/kernel-patches/bpf/actions/runs/35923662147/job/107398076527

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/cb_refs.c        | 48 -------------------
 .../selftests/bpf/prog_tests/verifier.c       |  3 ++
 tools/testing/selftests/bpf/progs/cb_refs.c   |  5 ++
 3 files changed, 8 insertions(+), 48 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/cb_refs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
deleted file mode 100644
index c32c6dab49bc..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "bpf/libbpf.h"
-#include <test_progs.h>
-#include <network_helpers.h>
-
-#include "cb_refs.skel.h"
-
-static char log_buf[1024 * 1024];
-
-struct {
-	const char *prog_name;
-	const char *err_msg;
-} cb_refs_tests[] = {
-	{ "underflow_prog", "R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_" },
-	{ "leak_prog", "Unreleased reference id=4 alloc_insn=3" }, /* alloc_insn=3{2,3} */
-	{ "nested_cb", "Unreleased reference id=4 alloc_insn=2" }, /* alloc_insn=2{4,5} */
-	{ "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=1" }, /* alloc_insn=1{1,2} */
-};
-
-void test_cb_refs(void)
-{
-	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
-						.kernel_log_size = sizeof(log_buf),
-						.kernel_log_level = 1);
-	struct bpf_program *prog;
-	struct cb_refs *skel;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(cb_refs_tests); i++) {
-		LIBBPF_OPTS(bpf_test_run_opts, run_opts,
-			.data_in = &pkt_v4,
-			.data_size_in = sizeof(pkt_v4),
-			.repeat = 1,
-		);
-		skel = cb_refs__open_opts(&opts);
-		if (!ASSERT_OK_PTR(skel, "cb_refs__open_and_load"))
-			return;
-		prog = bpf_object__find_program_by_name(skel->obj, cb_refs_tests[i].prog_name);
-		bpf_program__set_autoload(prog, true);
-		if (!ASSERT_ERR(cb_refs__load(skel), "cb_refs__load"))
-			bpf_prog_test_run_opts(bpf_program__fd(prog), &run_opts);
-		if (!ASSERT_OK_PTR(strstr(log_buf, cb_refs_tests[i].err_msg), "expected error message")) {
-			fprintf(stderr, "Expected: %s\n", cb_refs_tests[i].err_msg);
-			fprintf(stderr, "Verifier: %s\n", log_buf);
-		}
-		cb_refs__destroy(skel);
-	}
-}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 4f1e1c1cd5ab..8b4be06bb181 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -5,6 +5,7 @@
 #include "arena_kfunc.skel.h"
 #include "arena_kfunc_jit.skel.h"
 #include "cap_helpers.h"
+#include "cb_refs.skel.h"
 #include "verifier_aggregate_arg.skel.h"
 #include "verifier_aggregate_ret.skel.h"
 #include "verifier_align.skel.h"
@@ -176,6 +177,8 @@ void test_arena_kfunc(void)                   { RUN_TESTS(arena_kfunc); }
 
 void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_jit); }
 
+void test_cb_refs(void)                       { RUN_TESTS(cb_refs); }
+
 void test_verifier_aggregate_arg(void)        { RUN_TESTS(verifier_aggregate_arg); }
 void test_verifier_aggregate_ret(void)        { RUN_TESTS(verifier_aggregate_ret); }
 void test_verifier_align(void)                { RUN(verifier_align); }
diff --git a/tools/testing/selftests/bpf/progs/cb_refs.c b/tools/testing/selftests/bpf/progs/cb_refs.c
index 5d6fc7f01ebb..d4a691db8a15 100644
--- a/tools/testing/selftests/bpf/progs/cb_refs.c
+++ b/tools/testing/selftests/bpf/progs/cb_refs.c
@@ -2,6 +2,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
 struct map_value {
@@ -24,6 +25,7 @@ static __noinline int cb1(void *map, void *key, void *value, void *ctx)
 }
 
 SEC("?tc")
+__failure __msg("R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_")
 int underflow_prog(void *ctx)
 {
 	struct prog_test_ref_kfunc *p;
@@ -47,6 +49,7 @@ static __always_inline int cb2(void *map, void *key, void *value, void *ctx)
 }
 
 SEC("?tc")
+__failure __msg("Unreleased reference id={{[0-9]+}} alloc_insn=3") /* alloc_insn=3{0,2,3} */
 int leak_prog(void *ctx)
 {
 	struct prog_test_ref_kfunc *p;
@@ -83,6 +86,7 @@ static __always_inline int cb3(void *map, void *key, void *value, void *ctx)
 }
 
 SEC("?tc")
+__failure __msg("Unreleased reference id={{[0-9]+}} alloc_insn=2") /* alloc_insn=2{2,4,5} */
 int nested_cb(void *ctx)
 {
 	struct prog_test_ref_kfunc *p;
@@ -98,6 +102,7 @@ int nested_cb(void *ctx)
 }
 
 SEC("?tc")
+__failure __msg("Unreleased reference id={{[0-9]+}} alloc_insn=1") /* alloc_insn=1{1,2} */
 int non_cb_transfer_ref(void *ctx)
 {
 	struct prog_test_ref_kfunc *p;
-- 
2.55.0

