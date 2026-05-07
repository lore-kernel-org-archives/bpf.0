Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC834678E
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189535; cv=none; b=DL+5xhi3cR5eRHol+3qazUiOiEdS2fI6H3jzM3421/+5hL5/UBfIdpOYZKnjqGvEggNCr7QvH+334N0/HhZ/7gYw+o3i0hW569zV99dBXa7OIe8b6pNo6xkFkz+u3jTl64h69Ge+3Cn6yvu96PZEGrzrj4n/4WsIezLI3kiaOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189535; c=relaxed/simple;
	bh=HxHR1LTW9UezafOEc56jIbNRyYQF8GEWRGCsTV28lWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBnaCyd5sUCzArWSkJUmR2aOnyyr0SRLIc6E0cDSHTg04KjDCGXQyBObFa+VplCPH1ZhVeYCaUtIClgYUiqw0Ap0Y1W7ShpO7SR0PDWtPuQUHvw/oE8c+DJOvoJpKl9PjbZvC6wHExwF9pGhd3JLYxircvzOR0tywKrAdbrARks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id AA91592BC4A01; Thu,  7 May 2026 14:32:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v2 23/23] selftests/bpf: Enable stack argument tests for arm64
Date: Thu,  7 May 2026 14:32:06 -0700
Message-ID: <20260507213206.1141644-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507212942.1122000-1-yonghong.song@linux.dev>
References: <20260507212942.1122000-1-yonghong.song@linux.dev>
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
index 2d5ddb24e241..9a05bbecd170 100644
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
index c94905f07dcc..235b3f660904 100644
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
index b4f680e3b6a1..81edafb426e6 100644
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
index 671c79969c6c..16b3eb5f51a2 100644
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

