Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFCF1DFDA1
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407019; cv=none; b=LB+fDAXf1lbPI1hoJtCeCsDH9hE7R+4cJazV0Gj7CxovRICoSA1Dw+1ORnIHQ6IZ2jY2mlVSelth6sqlIGiLqbhCzNYjop8QF/3qR9i6nw0VVH2MWYF7QXAW4dC7UweLf6Il/l+GCnvbyxZiJNd5hsH2990lVECas6uPdvEYcYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407019; c=relaxed/simple;
	bh=i0N2LNGC1bIMUA+NnsRdTx7QxT/ex1Bt3IrWtkf5OTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHsRsHEoL5HQp9iCHSCaKixc+sGD2U/kMEtCj0HwYvQLKD5XGs5Yr6IDXY1Lv9ObTm/TaImVDQXK7HbhxG5a4qYJC5wF2hs62lhfit1XjQEas5FFajb7+fMK9dzwX/inuCSvlEQ9Qdaq0Q4eVEgmkw7iLc012zl0vzCXSLs2Fq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3129A233CF284F; Mon, 10 Aug 2026 17:10:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 12/13] selftests/bpf: Add tests for callbacks returning more than 8 bytes
Date: Mon, 10 Aug 2026 17:10:13 -0700
Message-ID: <20260811001013.2385213-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811000911.2378679-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add two __failure tests covering the callback return-size checks:

 - timer_ret_pair_fail: a bpf_timer callback declared to return more than
   8 bytes, rejected by check_ld_imm() where the callback's PTR_TO_FUNC i=
s
   created, with "callback function with >8-byte return value is not
   supported".

 - exceptions_ret_pair_fail: an exception callback declared to return mor=
e
   than 8 bytes, rejected by do_check_common() when the callback
   subprogram is verified, with "exception cb cannot return value larger
   than 8 bytes".

Both callback bodies are written in inline asm so that the tests do not
depend on LLVM 23 R0:R2 codegen and run on any compiler. The verifier rea=
ds
the return type from BTF rather than from the instructions, so the >8 byt=
e
return prototype is supplied through __btf_func_path(), pointing at a
companion btf__*.c program that exists only to carry that BTF.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/exceptions.c     |  2 +
 .../testing/selftests/bpf/prog_tests/timer.c  |  2 +
 .../bpf/progs/btf__exceptions_ret_pair_fail.c | 10 ++++
 .../bpf/progs/btf__timer_ret_pair_fail.c      | 10 ++++
 .../bpf/progs/exceptions_ret_pair_fail.c      | 30 ++++++++++++
 .../selftests/bpf/progs/timer_ret_pair_fail.c | 49 +++++++++++++++++++
 6 files changed, 103 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__exceptions_ret=
_pair_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__timer_ret_pair=
_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ret_pair=
_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_ret_pair_fail=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/=
testing/selftests/bpf/prog_tests/exceptions.c
index 3588d6f97fd4..71d00c568d80 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -5,6 +5,7 @@
 #include "exceptions.skel.h"
 #include "exceptions_ext.skel.h"
 #include "exceptions_fail.skel.h"
+#include "exceptions_ret_pair_fail.skel.h"
 #include "exceptions_assert.skel.h"
=20
 static char log_buf[1024 * 1024];
@@ -12,6 +13,7 @@ static char log_buf[1024 * 1024];
 static void test_exceptions_failure(void)
 {
 	RUN_TESTS(exceptions_fail);
+	RUN_TESTS(exceptions_ret_pair_fail);
 }
=20
 static void test_exceptions_success(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testi=
ng/selftests/bpf/prog_tests/timer.c
index 09ff21e1ad2f..593e56d8964e 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -6,6 +6,7 @@
 #include <sys/syscall.h>
 #include "timer.skel.h"
 #include "timer_failure.skel.h"
+#include "timer_ret_pair_fail.skel.h"
 #include "timer_interrupt.skel.h"
=20
 #define NUM_THR 8
@@ -285,6 +286,7 @@ void serial_test_timer(void)
 	test_timer(timer);
=20
 	RUN_TESTS(timer_failure);
+	RUN_TESTS(timer_ret_pair_fail);
 }
=20
 void serial_test_timer_stress(void)
diff --git a/tools/testing/selftests/bpf/progs/btf__exceptions_ret_pair_f=
ail.c b/tools/testing/selftests/bpf/progs/btf__exceptions_ret_pair_fail.c
new file mode 100644
index 000000000000..a45db5d9c1d4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__exceptions_ret_pair_fail.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+unsigned __int128 exception_cb_bad_ret_type3(u64 cookie)
+{
+	for (;;)
+		;
+}
diff --git a/tools/testing/selftests/bpf/progs/btf__timer_ret_pair_fail.c=
 b/tools/testing/selftests/bpf/progs/btf__timer_ret_pair_fail.c
new file mode 100644
index 000000000000..35506c7c5a91
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__timer_ret_pair_fail.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+unsigned __int128 timer_cb_ret_pair(void *map, int *key, struct bpf_time=
r *timer)
+{
+	for (;;)
+		;
+}
diff --git a/tools/testing/selftests/bpf/progs/exceptions_ret_pair_fail.c=
 b/tools/testing/selftests/bpf/progs/exceptions_ret_pair_fail.c
new file mode 100644
index 000000000000..842f86ad8659
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/exceptions_ret_pair_fail.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+__naked __noinline __used
+unsigned __int128 exception_cb_bad_ret_type3(u64 cookie)
+{
+	asm volatile (
+	"r0 =3D r1;"
+	"r2 =3D 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("?tc")
+__exception_cb(exception_cb_bad_ret_type3)
+__failure __msg("exception cb cannot return value larger than 8 bytes")
+__btf_func_path("btf__exceptions_ret_pair_fail.bpf.o")
+int reject_exception_cb_ret_pair(void *ctx)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/timer_ret_pair_fail.c b/to=
ols/testing/selftests/bpf/progs/timer_ret_pair_fail.c
new file mode 100644
index 000000000000..29fd294dfd49
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_ret_pair_fail.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <time.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+struct elem {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} timer_map SEC(".maps");
+
+__naked __noinline __used
+static unsigned __int128 timer_cb_ret_pair(void *map, int *key, struct b=
pf_timer *timer)
+{
+	asm volatile (
+		"r0 =3D 0;"
+		"r2 =3D 0;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("fentry/bpf_fentry_test1")
+__failure __msg("callback function with >8-byte return value is not supp=
orted")
+__btf_func_path("btf__timer_ret_pair_fail.bpf.o")
+long BPF_PROG2(test_bad_ret_pair, int, a)
+{
+	int key =3D 0;
+	struct bpf_timer *timer;
+
+	timer =3D bpf_map_lookup_elem(&timer_map, &key);
+	if (timer) {
+		bpf_timer_init(timer, &timer_map, CLOCK_BOOTTIME);
+		bpf_timer_set_callback(timer, timer_cb_ret_pair);
+	}
+
+	return 0;
+}
--=20
2.53.0-Meta

