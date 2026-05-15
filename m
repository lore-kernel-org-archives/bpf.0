Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B863EE1EE
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885478; cv=none; b=XcnHnOXQYgf88E/LJzQgLHsDvXvWX8Nv/7TB3NoQWM2QBeYlf2Um9Z+SH9EbbFW+REGvhpxs/4C0e44Jrf4apewEczFHOX1jvo4Xu73xwtyzjudlLQPDFb1brXZi2/K1iDJ0ikDEzK5rPXZe6ZzfnMoFyXyqny0GWzE2CrS62yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885478; c=relaxed/simple;
	bh=WvWSsDQ0nwCa7yq2rQl8658hoNhX1w/x519UilV1pJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrOH3zRjWbLLWhOKRB5QNWABxowmpbTDcM90Zy3IijUDnG+MW12Nm/v0sH6c2hrtOq2934Wkg8ilCjW6bRMxzZtK2VDUDM0+s4o+SqH7t95AyE/8NrVsZRiYMuDbYyo6QIBbX8kURoj7Ydxf+D2Aqae8f+4OY8l9tTswWe0X2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9944EC062F4BB; Fri, 15 May 2026 15:51:11 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: Add exception tests with stack arguments
Date: Fri, 15 May 2026 15:51:11 -0700
Message-ID: <20260515225111.825224-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515225035.821178-1-yonghong.song@linux.dev>
References: <20260515225035.821178-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add tests to verify that bpf_throw() correctly unwinds the stack
when the program uses outgoing stack arguments (functions with >5
args). Without the preceding fix, these tests crash the kernel
due to corrupted callee-saved register restore.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/exceptions.c     |   7 ++
 .../testing/selftests/bpf/progs/exceptions.c  | 113 ++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/=
testing/selftests/bpf/prog_tests/exceptions.c
index e8cbaf2a3e82..3588d6f97fd4 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -85,6 +85,13 @@ static void test_exceptions_success(void)
 	RUN_SUCCESS(exception_bad_assert_range_with, 10);
 	RUN_SUCCESS(exception_throw_from_void_global, 11);
=20
+	if (skel->rodata->has_stack_arg) {
+		RUN_SUCCESS(exception_throw_stack_arg, 56);
+		RUN_SUCCESS(exception_throw_after_stack_arg, 56);
+		RUN_SUCCESS(exception_throw_subprog_stack_arg, 56);
+		RUN_SUCCESS(exception_throw_subprog_after_stack_arg, 56);
+	}
+
 #define RUN_EXT(load_ret, attach_err, expr, msg, after_link)			  \
 	{									  \
 		LIBBPF_OPTS(bpf_object_open_opts, o, .kernel_log_buf =3D log_buf,		 \
diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testi=
ng/selftests/bpf/progs/exceptions.c
index 4206f59d7b86..f236aadfe7e6 100644
--- a/tools/testing/selftests/bpf/progs/exceptions.c
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -379,4 +379,117 @@ int exception_bad_assert_range_with(struct __sk_buf=
f *ctx)
 	return 1;
 }
=20
+#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+const volatile bool has_stack_arg =3D true;
+
+long arg1 =3D 1, arg2 =3D 2, arg3 =3D 3, arg4 =3D 4, arg5 =3D 5;
+long arg6 =3D 6, arg7 =3D 7, arg8 =3D 8, arg9 =3D 9, arg10 =3D 10;
+
+__noinline static long throwing_many_args(long a, long b, long c, long d=
,
+					  long e, long f, long g, long h,
+					  long i, long j)
+{
+	bpf_throw(a + b + c + d + e + f + g + h + i + j);
+	return 0;
+}
+
+__noinline int exception_cb_sa(u64 cookie)
+{
+	return cookie + 1;
+}
+
+SEC("tc")
+__exception_cb(exception_cb_sa)
+int exception_throw_stack_arg(struct __sk_buff *ctx)
+{
+	throwing_many_args(arg1, arg2, arg3, arg4, arg5,
+			   arg6, arg7, arg8, arg9, arg10);
+	return 0;
+}
+
+__noinline static long no_throw_many_args(long a, long b, long c, long d=
,
+					  long e, long f, long g, long h,
+					  long i, long j)
+{
+	return a + b + c + d + e + f + g + h + i + j;
+}
+
+SEC("tc")
+__exception_cb(exception_cb_sa)
+int exception_throw_after_stack_arg(struct __sk_buff *ctx)
+{
+	long ret;
+
+	ret =3D no_throw_many_args(arg1, arg2, arg3, arg4, arg5,
+				 arg6, arg7, arg8, arg9, arg10);
+	if (ret > 0)
+		bpf_throw(ret);
+	return 0;
+}
+
+__noinline static long subprog_throw_sa(long val)
+{
+	throwing_many_args(val, val + 1, val + 2, val + 3, val + 4,
+			   val + 5, val + 6, val + 7, val + 8, val + 9);
+	return 0;
+}
+
+SEC("tc")
+__exception_cb(exception_cb_sa)
+int exception_throw_subprog_stack_arg(struct __sk_buff *ctx)
+{
+	subprog_throw_sa(arg1);
+	return 0;
+}
+
+__noinline static long subprog_throw_after_sa(long val)
+{
+	long ret;
+
+	ret =3D no_throw_many_args(val, val + 1, val + 2, val + 3, val + 4,
+				 val + 5, val + 6, val + 7, val + 8, val + 9);
+	if (ret > 0)
+		bpf_throw(ret);
+	return 0;
+}
+
+SEC("tc")
+__exception_cb(exception_cb_sa)
+int exception_throw_subprog_after_stack_arg(struct __sk_buff *ctx)
+{
+	subprog_throw_after_sa(arg1);
+	return 0;
+}
+
+#else
+
+const volatile bool has_stack_arg =3D false;
+
+SEC("tc")
+int exception_throw_stack_arg(struct __sk_buff *ctx)
+{
+	return 0;
+}
+
+SEC("tc")
+int exception_throw_after_stack_arg(struct __sk_buff *ctx)
+{
+	return 0;
+}
+
+SEC("tc")
+int exception_throw_subprog_stack_arg(struct __sk_buff *ctx)
+{
+	return 0;
+}
+
+SEC("tc")
+int exception_throw_subprog_after_stack_arg(struct __sk_buff *ctx)
+{
+	return 0;
+}
+
+#endif
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

