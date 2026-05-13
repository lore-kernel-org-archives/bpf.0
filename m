Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E0E38886F
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647929; cv=none; b=gbECsaO45wBClSOHnVG+Y23cGhNRd9PQ0Cr+CBVv2/jw+MoinIUg4RI/X0xCXrb27kjpMztdVwMFtdUuvhFN2+fnaVTzhRQ2C3hYc5JMf3h30oUEyShGphCyRWMyOrTLJqAmPgpoYdrpxB6vQOLCpkkfFxX57/v0E46qWRrA5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647929; c=relaxed/simple;
	bh=WUoJwtjwYeYndhpOubs7S98qXANnmr3x8X2Jz+PJykg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IR9n1OS7JHNlCBDowAeP31BAVcMdmc6mc27dtR4ujD2k8mywK+PkyKh9Jurd/YfrwrgMDn1OKH9ci9MHOu3LQO/sJFkYaoZJUjjrymUC1viPua9zItmH3mPwHoa36xKIUJ7+bmI/+HzlnWypT9mB/c9rNPytk3PfEjMjh6FbgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A2313B19826F6; Tue, 12 May 2026 21:52:04 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v4 25/25] selftests/bpf: Enable stack argument tests for arm64
Date: Tue, 12 May 2026 21:52:04 -0700
Message-ID: <20260513045204.2403441-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513044949.2382019-1-yonghong.song@linux.dev>
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Puranjay Mohan <puranjay@kernel.org>

Now that arm64 supports stack arguments, enable the existing stack_arg,
stack_arg_kfunc and verifier_stack_arg tests for __TARGET_ARCH_arm64.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c   | 3 ++-
 .../selftests/bpf/progs/btf__verifier_stack_arg_order.c        | 3 ++-
 tools/testing/selftests/bpf/progs/stack_arg.c                  | 3 ++-
 tools/testing/selftests/bpf/progs/stack_arg_kfunc.c            | 3 ++-
 tools/testing/selftests/bpf/progs/stack_arg_precision.c        | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_stack_arg.c         | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c   | 3 ++-
 7 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c=
 b/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
index 296fddfe6804..8d38aafe66a2 100644
--- a/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
+++ b/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
@@ -4,7 +4,8 @@
 #include <bpf/bpf_helpers.h>
 #include "../test_kmods/bpf_testmod_kfunc.h"
=20
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
=20
 long subprog_call_mem_kfunc(long a, long b, long c, long d, long e, long=
 size)
 {
diff --git a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_or=
der.c b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
index 83692570d5bc..da34e8456b6c 100644
--- a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
@@ -3,7 +3,8 @@
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
=20
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
=20
 int subprog_bad_order_6args(int a, int b, int c, int d, int e, int f)
 {
diff --git a/tools/testing/selftests/bpf/progs/stack_arg.c b/tools/testin=
g/selftests/bpf/progs/stack_arg.c
index ab6240b997c5..b5e9929a4d63 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg.c
@@ -21,7 +21,8 @@ struct {
=20
 int timer_result;
=20
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
=20
 const volatile bool has_stack_arg =3D true;
=20
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c b/tools/=
testing/selftests/bpf/progs/stack_arg_kfunc.c
index fa9def876ea5..da0d4f91d273 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
@@ -6,7 +6,8 @@
 #include "bpf_kfuncs.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
=20
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
=20
 const volatile bool has_stack_arg =3D true;
=20
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_precision.c b/to=
ols/testing/selftests/bpf/progs/stack_arg_precision.c
index 2a0a344c83ca..bee2eeec021d 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_precision.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
@@ -6,7 +6,8 @@
 #include "../test_kmods/bpf_testmod_kfunc.h"
 #include "bpf_misc.h"
=20
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
=20
 /* Force kfunc extern BTF generation for inline asm call below.
  * Uses its own SEC so it's not included as a .text subprog.
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_arg.c
index 6587bf912bc0..d43a9b42034c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -12,7 +12,8 @@ struct {
 	__type(value, long long);
 } map_hash_8b SEC(".maps");
=20
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
=20
 __noinline __used
 static int subprog_6args(int a, int b, int c, int d, int e, int f)
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c=
 b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
index 938f4a2f5482..1240cf8a40d6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
@@ -5,7 +5,8 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
=20
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
=20
 __noinline __used __naked
 static int subprog_bad_order_6args(int a, int b, int c, int d, int e, in=
t f)
--=20
2.53.0-Meta

