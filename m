Received: from mta1.migadu.com (out-140.mta1.migadu.com [95.215.58.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E33B7757
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632284; cv=none; b=mP4wR5EOsW7DqKVUY3ErLN38S5hpj61DwPdbB4igP7Zawg7cCej8GO4KolYSqyrVHGKTjNlqDb/ofkQ7wHcOJCkzdAqyNPd/KeUuljNHWzs+B3bUlYAddl9TyU/VCIvXA16LN5+XfBAHNQwYFj+Qg03CcqP4XyxeSJwutpplr4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632284; c=relaxed/simple;
	bh=QuZOUlYYZuS9Kslz5UG/STBli+7LBXT+FgQPgWf8Z18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WvV7H5SMOQGC6AUGiEvYMGvfIC6bVPRsntLm+JBrbV9zv96fQiitjiu+rO9Di6EmJUh45d6Et8dlbJH5W3oWakdDcv9FiVdZdKOAcTfd6T65r+D1NAv6a4KABhS1DGnbqKUJlh7FKoJRc+tEi2GUgLhP6OaD060hr6ZDVSpxmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I4AuBbii; arc=none smtp.client-ip=95.215.58.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I4AuBbii"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QuZOUlYYZuS9Kslz5UG/STBli+7LBXT+FgQPgWf8Z18=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790632279; v=1; x=1791237079;
 b=I4AuBbiioMxy8JW3+qpEdimL3n1TaUlxhyPrDDsU+Gze47TcJwk6yWUdRonL1e0iy4NXflnf
 D/dqokH7UmQZDSQ2HycMlS56IwaEWJuei+pansXK0iRH7RVN+cxlwmmWFhMe3NmGsJ6/CckPoW+
 RauTvbeWMHRfkm75kQP7eyRU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a88035eb946d56e8;
	Mon, 28 Sep 2026 21:51:19 +0000
X-Mizu-Trace-ID: a88035eb946d56e8
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next] selftests/bpf: Fix linked_externs with bpf-gcc
Date: Mon, 28 Sep 2026 14:51:10 -0700
Message-ID: <20260928215110.3966357-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was reported by BPF CI [1]. test_progs-bpf_gcc fails to build:

  prog_tests/linked_externs.c:17:23: error: 'struct linked_arena' has no
      member named 'arena'

[1] https://github.com/kernel-patches/bpf/actions/runs/36243003457

Two separate problems, both from bpf-gcc not supporting address_space(1).

First, the arena globals are defined with __arena, but that macro is for
pointers -- it marks the pointee address space. The one that carries
placement is __arena_global:

  #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
  #define __arena        __attribute__((address_space(1))) __attribute__((btf_type_tag("arena")))
  #define __arena_global __attribute__((address_space(1)))
  #else
  #define __arena        __attribute__((btf_type_tag("arena")))
  #define __arena_global SEC(".addr_space.1")
  #endif

Under bpf-gcc __arena is only a BTF type tag, so the variables land in
.data, the arena map gets no initial value, and bpftool does not emit the
typed arena member, hence the build error.

Second, fixing the placement is not enough to run the test. Dereferencing
an arena global needs an addr_space_cast, which only clang emits:

  clang:                                  bpf-gcc:
    r1 = 0x0 ll                             r1 = 0x0 ll
    r1 = addr_space_cast(r1, 0x0, 0x1)      r2 = *(u64 *)(r1 + 0x0)
    r1 = *(u64 *)(r1 + 0x0)

so the verifier sees a scalar and rejects the program:

  4: (79) r2 = *(u64 *)(r1 +0)
  R1 invalid mem access 'scalar'

Guard the program bodies and skip the skeleton subtest, as
arena_atomics.c already does.

The fallback bodies reference the externs without dereferencing them,
otherwise gcc drops the unreferenced extern and relink_arena passes
without having an extern to resolve.

With this, bpf-gcc reports:

  #217/1   linked_externs/skel_arena:SKIP
  #217/2   linked_externs/relink_arena:OK
  #217/3   linked_externs/relink_maps:OK

and clang still passes all three.

Fixes: 34354db1b148 ("selftests/bpf: Add linked_externs test for externs in allocated sections")
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 .../selftests/bpf/prog_tests/linked_externs.c | 15 +++++++++++--
 .../selftests/bpf/progs/linked_arena1.c       | 22 ++++++++++++++++++-
 .../selftests/bpf/progs/linked_arena2.c       |  6 ++++-
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_externs.c b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
index 29358c82dc35..ff568f5cfc42 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_externs.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_externs.c
@@ -10,10 +10,20 @@ static void test_skel(void)
 	struct linked_arena *skel;
 	int err;
 
-	skel = linked_arena__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+	skel = linked_arena__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
+	if (skel->data->skip_tests) {
+		printf("%s:SKIP: no addr_space_cast support in the BPF compiler\n", __func__);
+		test__skip();
+		goto cleanup;
+	}
+
+	err = linked_arena__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
 	ASSERT_EQ(skel->arena->a_val, 1, "a_val_init");
 	ASSERT_EQ(skel->arena->b_val, 2, "b_val_init");
 
@@ -28,6 +38,7 @@ static void test_skel(void)
 	ASSERT_EQ(skel->arena->a_val, 11, "a_val");
 	ASSERT_EQ(skel->arena->b_val, 22, "b_val");
 
+cleanup:
 	linked_arena__destroy(skel);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/linked_arena1.c b/tools/testing/selftests/bpf/progs/linked_arena1.c
index 3e8788dec1d9..dd9c5fa424dd 100644
--- a/tools/testing/selftests/bpf/progs/linked_arena1.c
+++ b/tools/testing/selftests/bpf/progs/linked_arena1.c
@@ -10,13 +10,33 @@ struct {
 	__uint(max_entries, 1); /* number of pages */
 } arena SEC(".maps");
 
-long __arena a_val = 1;
+/*
+ * Dereferencing an arena global needs the compiler to emit an
+ * addr_space_cast, which only clang does. Keep the variables so the arena
+ * is still populated and the skeleton still has its arena member, but skip
+ * the test elsewhere.
+ */
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+bool skip_tests __attribute((__section__(".data"))) = false;
+#else
+bool skip_tests = true;
+#endif
+
+long __arena_global a_val = 1;
 extern long __arena b_val; /* defined in linked_arena2.c */
 
 SEC("syscall")
 int sum1(void *ctx)
 {
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
 	return a_val + b_val;
+#else
+	/*
+	 * Reference the extern without dereferencing it, so that the relink
+	 * test still has an extern to resolve.
+	 */
+	return (long)&b_val;
+#endif
 }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/linked_arena2.c b/tools/testing/selftests/bpf/progs/linked_arena2.c
index d0bcdf18a4b6..1bc8b97ed8cc 100644
--- a/tools/testing/selftests/bpf/progs/linked_arena2.c
+++ b/tools/testing/selftests/bpf/progs/linked_arena2.c
@@ -4,15 +4,19 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_arena_common.h"
 
-long __arena b_val = 2;
+long __arena_global b_val = 2;
 extern long __arena a_val; /* defined in linked_arena1.c */
 
 SEC("syscall")
 int bump2(void *ctx)
 {
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
 	a_val += 10;
 	b_val += 20;
 	return a_val + b_val;
+#else /* see linked_arena1.c */
+	return (long)&a_val;
+#endif
 }
 
 char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta

