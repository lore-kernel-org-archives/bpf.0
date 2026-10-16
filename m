Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B78539449C
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175476; cv=none; b=NL+rek6lbQo7zvYl5YJKxlBj5cxSfDsbkHr0JVnw/uUA0DL0543fI6kUavUixkDLZMH+IZHnKeS0lVoJDpCCMdWzCcq4guAuxcrdJMcKJLfaHGfnXPnrJI/8cRf+htVzlUxqMw8YcTh2HgonOg29D59exZmxj8asXstHst4Xe8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175476; c=relaxed/simple;
	bh=GGkU6dOT8CnCdYyDgVROD1NhIdi/rdgEGe1Ubqhd4PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2dS4KYWpvcJkh/mPupbkHbkA0lL6+M3dWfgm48HR8s9Eee4ShZc+D5N6Av+z5Oe89Pm1tKWWrnUdKH8D7bg0AXsBTZpM0lyOfnJjYuHADHQ5sEt5I+6XGgCJwbBbRyX+0l4q8j/kOyDrfvIS9HpxuP8HRtSUjEDUZ31F2zkZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4184231A0DA9D0; Fri, 16 Oct 2026 11:31:10 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 6/9] selftests/bpf: Test trampoline args around a 16-byte aligned stack arg
Date: Fri, 16 Oct 2026 11:31:10 -0700
Message-ID: <20261016183110.1135597-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016183039.1132126-1-yonghong.song@linux.dev>
References: <20261016183039.1132126-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add two bpf_testmod functions whose 16-byte aligned argument, a struct
holding an __int128, is passed on the stack after a hole:

  - bpf_testmod_test_int128_stack(): seven u64s before the struct, so it
    leaves a register empty on arm64 and a stack slot empty on x86-64.
  - bpf_testmod_test_int128_backfill(): a 16-byte struct of two longs
    moves to the x86-64 stack and gives R9 back to the next argument; the
    struct then leaves a stack slot empty on both x86-64 and arm64.

The __int128 is wrapped in a struct because btf_ctx_access() refuses a
program reading an integer argument wider than eight bytes, while it
lets the program read each slot of a struct argument.

The fentry programs read each argument slot from ctx[] and check that
the trampoline packs them in the BPF convention, and the fexit programs
check the return value, weighted by argument slot, which is only right
if the original function got its arguments back where its convention
wants them.

Without the preceding x86 fix the test fails with:

  test_int128_args:FAIL:s:h.lo unexpected s:h.lo: actual 2 !=3D expected =
8
  ...
  test_int128_args:FAIL:s ret unexpected s ret: actual 285 !=3D expected =
385

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_struct.c | 22 +++++++--
 .../bpf/progs/tracing_struct_int128.c         | 45 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 43 ++++++++++++++++++
 3 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c b/to=
ols/testing/selftests/bpf/prog_tests/tracing_struct.c
index 8086586d3e19..a2da219e1476 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_struct.c
@@ -119,9 +119,11 @@ static void test_int128_args(void)
 {
 	/*
 	 * __int128 arguments are passed in a register pair on x86_64 and
-	 * arm64, which the trampoline packs into two context slots. Other
-	 * architectures pass a __int128 differently (e.g. s390x passes larger
-	 * arguments by reference), so only exercise this on x86_64 and arm64.
+	 * arm64, which the trampoline packs into two context slots. Past the
+	 * registers, both start an argument aligned to 16 bytes at an even
+	 * stack slot, which the trampoline packs too. Other architectures
+	 * pass a __int128 differently (e.g. s390x passes larger arguments by
+	 * reference), so only exercise this on x86_64 and arm64.
 	 */
 #if defined(__x86_64__) || defined(__aarch64__)
 	struct tracing_struct_int128 *skel;
@@ -141,6 +143,20 @@ static void test_int128_args(void)
 	ASSERT_EQ(skel->bss->t_c, 3, "t:c");
 	ASSERT_EQ(skel->bss->t_ret, 6, "t ret");
=20
+	ASSERT_EQ(skel->bss->s_g, 7, "s:g");
+	ASSERT_EQ(skel->bss->s_h_lo, 8, "s:h.lo");
+	ASSERT_EQ(skel->bss->s_h_hi, 9, "s:h.hi");
+	ASSERT_EQ(skel->bss->s_i, 10, "s:i");
+	ASSERT_EQ(skel->bss->s_ret, 385, "s ret");
+
+	ASSERT_EQ(skel->bss->b_f_a, 6, "b:f.a");
+	ASSERT_EQ(skel->bss->b_f_b, 7, "b:f.b");
+	ASSERT_EQ(skel->bss->b_g, 8, "b:g");
+	ASSERT_EQ(skel->bss->b_h, 9, "b:h");
+	ASSERT_EQ(skel->bss->b_i_lo, 10, "b:i.lo");
+	ASSERT_EQ(skel->bss->b_i_hi, 11, "b:i.hi");
+	ASSERT_EQ(skel->bss->b_ret, 506, "b ret");
+
 destroy_skel:
 	tracing_struct_int128__destroy(skel);
 #else
diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128.c b/=
tools/testing/selftests/bpf/progs/tracing_struct_int128.c
index 4638dfec1f38..5520ee500c01 100644
--- a/tools/testing/selftests/bpf/progs/tracing_struct_int128.c
+++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128.c
@@ -15,4 +15,49 @@ int test_int128_arg_fexit(unsigned long long *ctx)
 	return 0;
 }
=20
+/*
+ * The arguments come packed in the BPF convention whatever holes the
+ * kernel convention left between them: an eightbyte each, and two for t=
he
+ * struct holding an __int128.
+ */
+long s_g, s_h_lo, s_h_hi, s_i, s_ret;
+
+SEC("fentry/bpf_testmod_test_int128_stack")
+int test_int128_stack_fentry(unsigned long long *ctx)
+{
+	s_g =3D ctx[6];
+	s_h_lo =3D ctx[7];
+	s_h_hi =3D ctx[8];
+	s_i =3D ctx[9];
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_int128_stack")
+int test_int128_stack_fexit(unsigned long long *ctx)
+{
+	s_ret =3D ctx[10];
+	return 0;
+}
+
+long b_f_a, b_f_b, b_g, b_h, b_i_lo, b_i_hi, b_ret;
+
+SEC("fentry/bpf_testmod_test_int128_backfill")
+int test_int128_backfill_fentry(unsigned long long *ctx)
+{
+	b_f_a =3D ctx[5];
+	b_f_b =3D ctx[6];
+	b_g =3D ctx[7];
+	b_h =3D ctx[8];
+	b_i_lo =3D ctx[9];
+	b_i_hi =3D ctx[10];
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_test_int128_backfill")
+int test_int128_backfill_fexit(unsigned long long *ctx)
+{
+	b_ret =3D ctx[11];
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 00641d597f95..38edb4addc5b 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -197,6 +197,43 @@ bpf_testmod_test_int128_arg(__int128 a, int b, long =
c)
 	bpf_testmod_test_struct_arg_result =3D (long)a + b + c;
 	return bpf_testmod_test_struct_arg_result;
 }
+
+struct bpf_testmod_struct_int128 {
+	__int128 a;
+};
+
+/*
+ * x86-64 puts g in the first stack slot and h, aligned to 16 bytes, in
+ * the third and fourth, leaving a hole. arm64 leaves x7 empty and puts =
h
+ * in the first two stack slots. Either way h and i are not where the BP=
F
+ * convention packs them, right after g.
+ */
+noinline long
+bpf_testmod_test_int128_stack(u64 a, u64 b, u64 c, u64 d, u64 e, u64 f,
+			      u64 g, struct bpf_testmod_struct_int128 h, u64 i)
+{
+	bpf_testmod_test_struct_arg_result =3D a + b * 2 + c * 3 + d * 4 + e * =
5 +
+		f * 6 + g * 7 + (u64)h.a * 8 +
+		(u64)((unsigned __int128)h.a >> 64) * 9 + i * 10;
+	return bpf_testmod_test_struct_arg_result;
+}
+
+/*
+ * x86-64 has no register left for f after e, so f goes to the stack and=
 g
+ * takes R9 back; h goes to the third stack slot and i, aligned to 16
+ * bytes, to the fifth and sixth. arm64 has registers up to g, puts h in
+ * the first stack slot and i in the third and fourth.
+ */
+noinline long
+bpf_testmod_test_int128_backfill(u64 a, u64 b, u64 c, u64 d, u64 e,
+				 struct bpf_testmod_struct_arg_2 f, u64 g, u64 h,
+				 struct bpf_testmod_struct_int128 i)
+{
+	bpf_testmod_test_struct_arg_result =3D a + b * 2 + c * 3 + d * 4 + e * =
5 +
+		f.a * 6 + f.b * 7 + g * 8 + h * 9 + (u64)i.a * 10 +
+		(u64)((unsigned __int128)i.a >> 64) * 11;
+	return bpf_testmod_test_struct_arg_result;
+}
 #endif
=20
 __weak noinline void bpf_testmod_looooooooooooooooooooooooooooooong_name=
(void)
@@ -683,6 +720,12 @@ bpf_testmod_test_read(struct file *file, struct kobj=
ect *kobj,
 #ifdef __SIZEOF_INT128__
 	(void)bpf_testmod_test_int128_ret(i);
 	(void)bpf_testmod_test_int128_arg((__int128)1, 2, 3);
+	(void)bpf_testmod_test_int128_stack(1, 2, 3, 4, 5, 6, 7,
+		(struct bpf_testmod_struct_int128){ .a =3D ((__int128)9 << 64) | 8 },
+		10);
+	(void)bpf_testmod_test_int128_backfill(1, 2, 3, 4, 5,
+		(struct bpf_testmod_struct_arg_2){ .a =3D 6, .b =3D 7 }, 8, 9,
+		(struct bpf_testmod_struct_int128){ .a =3D ((__int128)11 << 64) | 10 }=
);
 #endif
=20
 	(void)trace_bpf_testmod_test_raw_tp_null_tp(NULL);
--=20
2.53.0-Meta

