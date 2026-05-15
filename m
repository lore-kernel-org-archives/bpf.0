Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965725C80E
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809816; cv=none; b=BlKrtYb1hTbCTjB90M7bs9KVMyJ8TPUe/SBhfrz3CEjgfpOK0N8W2orOaVo4l2exB30OwjjiWvcs7fUqsxO97+5GWsKbnuARGcNh391/mnLV9RMi/s+XW8rnD0f+7yUNTP8yqLEi2zU9YmG7R/VsS/giX5/o0P7HOuk1N+ox81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809816; c=relaxed/simple;
	bh=RJhaGIPkFOmYJNTCzMNe3zL+DwlinrhPIzj+6xiWioI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOcA4Suvw/B2I6Uo/qGIr8EFx30Srm6oPqc6SyHIOvJlDMWYWfJbt1ij9vXFOuQMX3Epca8t1wB/rR65xyYNJi3EFo5lckxsoGL2pwBZ74L/epXGLo4sSlmk2oEgReW4CRrGC4pMDW9muUFST38RyfMxthpLQvw//mA9jUB1nTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3ED55BBC9D38F; Thu, 14 May 2026 18:50:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add test for stack arg read without caller write
Date: Thu, 14 May 2026 18:50:03 -0700
Message-ID: <20260515015003.1187170-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515014958.1186132-1-yonghong.song@linux.dev>
References: <20260515014958.1186132-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add negative tests for the outgoing stack arg validation.
A static subprog with a 'long *' arg causes
btf_prepare_func_args() to fail after setting arg_cnt. The
validation ensures check_outgoing_stack_args() still runs.

Also update two existing tests (release_ref, stale_pkt_ptr) whose
expected error messages changed: invalidated stack arg slots are now
caught by check_outgoing_stack_args() at the call site instead of
at the callee's dereference.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/progs/btf__verifier_stack_arg_order.c |  8 +++
 .../selftests/bpf/progs/verifier_stack_arg.c  |  4 +-
 .../bpf/progs/verifier_stack_arg_order.c      | 58 +++++++++++++++++++
 3 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_or=
der.c b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
index da34e8456b6c..99bc115f8380 100644
--- a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
@@ -21,6 +21,10 @@ int subprog_pruning_call_before_load_6args(int a, int =
b, int c, int d, int e, in
 	return a + b + c + d + e + f;
 }
=20
+void subprog_bad_ptr_7args(long *a, int b, int c, int d, int e, int f, i=
nt g)
+{
+}
+
 #else
=20
 int subprog_bad_order_6args(void)
@@ -38,4 +42,8 @@ int subprog_pruning_call_before_load_6args(void)
 	return 0;
 }
=20
+void subprog_bad_ptr_7args(void)
+{
+}
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_arg.c
index d43a9b42034c..d45339b83795 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -152,7 +152,7 @@ __naked void stack_arg_pruning_type_mismatch(void)
 SEC("tc")
 __description("stack_arg: release_reference invalidates stack arg slot")
 __failure
-__msg("R{{[0-9]}} !read_ok")
+__msg("callee expects 6 args, stack arg1 is not initialized")
 __naked void stack_arg_release_ref(void)
 {
 	asm volatile (
@@ -201,7 +201,7 @@ __naked void stack_arg_release_ref(void)
 SEC("tc")
 __description("stack_arg: pkt pointer in stack arg slot invalidated afte=
r pull_data")
 __failure
-__msg("R{{[0-9]}} !read_ok")
+__msg("callee expects 6 args, stack arg1 is not initialized")
 __naked void stack_arg_stale_pkt_ptr(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c=
 b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
index 1240cf8a40d6..c9fe4857da3f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
@@ -112,6 +112,64 @@ __naked void stack_arg_pruning_load_after_call(void)
 	);
 }
=20
+/*
+ * "bad_ptr": the first arg is 'long *', which is not a recognized point=
er
+ * type for static subprogs (not ctx, dynptr, or tagged).  btf_prepare_f=
unc_args()
+ * sets arg_cnt =3D 7 / stack_arg_cnt =3D 2, then fails with -EINVAL.  T=
he subprog
+ * is marked unreliable but the call still proceeds for static subprogs.
+ */
+__noinline __used __naked
+static void subprog_bad_ptr_7args(long *a, int b, int c, int d, int e, i=
nt f, int g)
+{
+	asm volatile (
+		"r0 =3D *(u64 *)(r11 + 8);"
+		"r1 =3D *(u64 *)(r11 + 16);"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: read without caller write")
+__failure
+__msg("callee expects 7 args, stack arg1 is not initialized")
+__btf_func_path("btf__verifier_stack_arg_order.bpf.o")
+__naked void stack_arg_read_without_write_1(void)
+{
+	asm volatile (
+		"r1 =3D 0;"
+		"r2 =3D 0;"
+		"r3 =3D 0;"
+		"r4 =3D 0;"
+		"r5 =3D 0;"
+		"call subprog_bad_ptr_7args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: read with not-initialized caller write")
+__failure
+__msg("R0 !read_ok")
+__btf_func_path("btf__verifier_stack_arg_order.bpf.o")
+__naked void stack_arg_read_without_write_2(void)
+{
+	asm volatile (
+		"r1 =3D 0;"
+		"r2 =3D 0;"
+		"r3 =3D 0;"
+		"r4 =3D 0;"
+		"r5 =3D 0;"
+		"*(u64 *)(r11 - 8) =3D 0;"
+		"*(u64 *)(r11 - 16) =3D 0;"
+		"call subprog_bad_ptr_7args;"
+		"call subprog_bad_ptr_7args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
 #else
=20
 SEC("socket")
--=20
2.53.0-Meta

