Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148622BDC28
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694663; cv=none; b=KQnOAtJGL4F1DRcPo2jKxlkROCZcD45vGoc6gQ4yJDUAWneY713A0kgY1iIKhHJvRs1Vk1wTYhJWX5FmOmW6EMshtvJBjsHV86yNK0ALlYapzyYYkZwRDOb1SvgJHseGpSwRWByUQmQ49WG1HLYpomFAuYPoyQ2w4aqnsm5bTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694663; c=relaxed/simple;
	bh=m6UHOuR3LcpL3VFCAzi3HyVmWN6sRi7Sup6TPBG5iAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaSMNRhtelBBVYW42HJiVEshjz5dZmbxxL613Nc6+vNAxfrrXvNBBmooCWTZOqJK4yytHUHJQUETPYD26culAZs7Ew+xLR5+64t+LkOQv+XE2j5fCxQPk6Dn4hWARlJ07/Ok/WPY2cb6kDivEvk02xhuqHBHyCwMgDJMV1lRg7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id AD5021D6982D8A; Fri, 10 Jul 2026 07:44:09 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for >8 byte return value on fexit attach
Date: Fri, 10 Jul 2026 07:44:09 -0700
Message-ID: <20260710144409.2580215-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710144404.2579671-1-yonghong.song@linux.dev>
References: <20260710144404.2579671-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The BPF trampoline preserves only 8 bytes of the target's return value
(R0), so attaching an fexit/fmod_ret/fsession program to a function that
returns a >8 byte value is now rejected by the verifier.

Add a bpf_testmod function returning __int128 and an fexit program that
targets it. The program is expected to fail to load with the
"with a >8 byte return value is not supported for this attach type"
message.

__int128 is only available on 64-bit targets (where the compiler defines
__SIZEOF_INT128__). Guard the testmod function and the test with
__SIZEOF_INT128__ so a 32-bit build still compiles; on such builds
the subtest is simply not run.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_failure.c      | 12 ++++++++++++
 tools/testing/selftests/bpf/progs/tracing_failure.c |  6 ++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c  | 13 +++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/t=
ools/testing/selftests/bpf/prog_tests/tracing_failure.c
index f9f9e1cb87bf..6c199f5ff4db 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -76,6 +76,14 @@ static void test_fexit_noreturns(void)
 			       "Attaching fexit/fsession/fmod_ret to __noreturn function 'do_=
exit' is rejected.");
 }
=20
+#ifdef __SIZEOF_INT128__
+static void test_fexit_int128_ret(void)
+{
+	test_tracing_fail_prog("fexit_int128_ret",
+			       "with a >8 byte return value is not supported for this attach =
type");
+}
+#endif
+
 void test_tracing_failure(void)
 {
 	if (test__start_subtest("bpf_spin_lock"))
@@ -86,4 +94,8 @@ void test_tracing_failure(void)
 		test_tracing_deny();
 	if (test__start_subtest("fexit_noreturns"))
 		test_fexit_noreturns();
+#ifdef __SIZEOF_INT128__
+	if (test__start_subtest("fexit_int128_ret"))
+		test_fexit_int128_ret();
+#endif
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c b/tools/=
testing/selftests/bpf/progs/tracing_failure.c
index 65e485c4468c..f7a095767679 100644
--- a/tools/testing/selftests/bpf/progs/tracing_failure.c
+++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
@@ -30,3 +30,9 @@ int BPF_PROG(fexit_noreturns)
 {
 	return 0;
 }
+
+SEC("?fexit/bpf_testmod_test_int128_ret")
+int BPF_PROG(fexit_int128_ret)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 30f1cd23093c..902dbf658250 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -161,6 +161,15 @@ bpf_testmod_test_arg_ptr_to_struct(struct bpf_testmo=
d_struct_arg_1 *a) {
 	return bpf_testmod_test_struct_arg_result;
 }
=20
+#ifdef __SIZEOF_INT128__
+noinline __int128
+bpf_testmod_test_int128_ret(int a)
+{
+	bpf_testmod_test_struct_arg_result =3D a;
+	return (__int128)a;
+}
+#endif
+
 __weak noinline void bpf_testmod_looooooooooooooooooooooooooooooong_name=
(void)
 {
 }
@@ -514,6 +523,10 @@ bpf_testmod_test_read(struct file *file, struct kobj=
ect *kobj,
=20
 	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
=20
+#ifdef __SIZEOF_INT128__
+	(void)bpf_testmod_test_int128_ret(i);
+#endif
+
 	(void)trace_bpf_testmod_test_raw_tp_null_tp(NULL);
=20
 	bpf_testmod_test_struct_ops3();
--=20
2.53.0-Meta

