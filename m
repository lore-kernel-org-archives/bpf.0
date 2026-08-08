Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817FF39A057
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215872; cv=none; b=E25ZYW9en4SgNUF4TU4EV3KEdSktnvQcpUtw/WiGTWgzAhDqdq2rT8jOhhZt0+rn/q0FoQY8f+JyP8fc6q3a/0BCxLUH6qwpsgESCoWtNb6pETcFh4+sUjgILMAUFid5x9lYFBNKUfb48f2OHk9s2C7cyBRpwk/1lwljJXLreZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215872; c=relaxed/simple;
	bh=i0N2LNGC1bIMUA+NnsRdTx7QxT/ex1Bt3IrWtkf5OTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVV2nyGxPQiOqgmGuhkApkyT6uokEtWUx4kzNM+E7Y7LXcHYfhxn7TlUtogv8oQBafQI0IhnsFsvynwwxa1Is7V/J1lSfb7TRSPUzmYTUGkIxPCkg6fPulhTnXA1EipbfwJyKKNHY6a6RaRgLozIRCHCaZuOtKpIiDL9wR+B5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BF4C522CA31E64; Sat,  8 Aug 2026 12:04:23 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 12/13] selftests/bpf: Add tests for callbacks returning more than 8 bytes
Date: Sat,  8 Aug 2026 12:04:23 -0700
Message-ID: <20260808190423.1903543-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808190322.1896580-1-yonghong.song@linux.dev>
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
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

