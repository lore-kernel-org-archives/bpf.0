Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36438329C57
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030439; cv=none; b=KSiUb2slxFe35FiI5+wzoB5dXsqAOef61y6uBoG72Ed4cM815nc3s+Yo4P47DtJ1CAP1E9ENWWSj9OViTiegLp95u1BrsCRzfcGRmAWKD54g+Zq7k8TUtWgvZjcbbrn8mlRHBaoUad5Gxbcd2D1GUxESAmPuv9+beVeqdTClpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030439; c=relaxed/simple;
	bh=f9o58j2jKoDmsiE25Bzjzvhv0gE4IbIk3p5xCigHkv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwqvC6fgwm8U7vrlKqsI0rbuYj1Ekp1JCGWqYeS6oZOYnHGncQuzBXv7WRuyrklO2WyHeeeQabR877RStuMuBGkx8XVuYKTAxGpcT8qmfnVTJruzQ7kaaqwyq44FsVlIzut1hBjaMjItdzovvHp+GknzQm/pDP60XfjGSASU/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 748A5CA16E26D; Sun, 17 May 2026 08:07:07 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add exception tests with stack arguments
Date: Sun, 17 May 2026 08:07:07 -0700
Message-ID: <20260517150707.289273-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260517150702.288031-1-yonghong.song@linux.dev>
References: <20260517150702.288031-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add tests to verify that bpf_throw() correctly unwinds the stack
when the program uses outgoing stack arguments (functions with >5
args). Without the preceding x86 fix, these tests crash the kernel
on x86 due to corrupted callee-saved register restore. There is
no change for arm64 to support exception with stack arguments.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/exceptions.c     |   7 ++
 .../testing/selftests/bpf/progs/exceptions.c  | 114 ++++++++++++++++++
 2 files changed, 121 insertions(+)

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
index 4206f59d7b86..c8d716fbd419 100644
--- a/tools/testing/selftests/bpf/progs/exceptions.c
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -379,4 +379,118 @@ int exception_bad_assert_range_with(struct __sk_buf=
f *ctx)
 	return 1;
 }
=20
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) \
+	&& defined(__BPF_FEATURE_STACK_ARGUMENT)
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

