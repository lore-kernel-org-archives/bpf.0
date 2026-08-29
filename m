Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA711D4606
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984171; cv=none; b=IxMR12zATk4Xl0fGAphY6UM5kDCxdZG5osD7ndMLQ9OgyIoehgy0a6F+9uWMhYC7R9JrarKK7Hrh0lPFyFqBSZxnjghHXsyc9WDVIlWxw23nZ+8EdGQc+ir2E5V7EH7iNzDwP1T/RkvVbyBNYBaGsKNjsFjt1AOwKIX2s9RDrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984171; c=relaxed/simple;
	bh=3mNXNQjRgWYMVs8kxZk8GpsP4ueiVjqvjGes0d06tJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORC/ruxPNLn6u3nznO47P365pfD2s+FZbNwKFYgb1qD9Sb9qCuVpw4a55jOW8vP5dEimxD+rfb61A8KiBrAS7WDFynZDx8RMOEZYm16Dua6kXVZhE9DycIoPt5VHgSPQnWq/PBmLjy6qZ1zlxB1+9eS3NsX8WmFwOwg+s6oaTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5694E273BA2FFF; Fri, 28 Aug 2026 23:16:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 09/12] selftests/bpf: Check the member named for an unsupported kfunc return type
Date: Fri, 28 Aug 2026 23:16:00 -0700
Message-ID: <20260829061600.1697800-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829061514.1690730-1-yonghong.song@linux.dev>
References: <20260829061514.1690730-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add tests to cover cases where a kfunc return type is rejected with
proper messages including member names and array types.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/aggregate_ret_kfunc.c | 82 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 40 +++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        | 42 ++++++++++
 3 files changed, 164 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/to=
ols/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
index f10e5cf6fd89..0361a7b42c9b 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
@@ -19,6 +19,11 @@ void __kfunc_btf_root(void)
 	  "r"(&bpf_kfunc_call_test_ret_fastcall),
 	  "r"(&bpf_kfunc_call_test_ret_ptr),
 	  "r"(&bpf_kfunc_call_test_ret_ii),
+	  "r"(&bpf_kfunc_call_test_ret_nested),
+	  "r"(&bpf_kfunc_call_test_ret_ptr_arr),
+	  "r"(&bpf_kfunc_call_test_ret_deep),
+	  "r"(&bpf_kfunc_call_test_ret_arr_struct),
+	  "r"(&bpf_kfunc_call_test_ret_arr2d),
 	  "r"(&bpf_kfunc_call_test_ret_big));
 }
=20
@@ -72,6 +77,7 @@ __naked int aggregate_ret_kfunc_fastcall_fail(void)
 SEC("tc")
 __arch_x86_64 __arch_arm64
 __failure __msg("is not composed of scalars or arena pointers")
+__msg("member 'p' has type PTR")
 __naked int aggregate_ret_kfunc_ptr_fail(void)
 {
 	asm volatile (
@@ -84,6 +90,82 @@ __naked int aggregate_ret_kfunc_ptr_fail(void)
 	: __clobber_all);
 }
=20
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("is not composed of scalars or arena pointers")
+__msg("member 'in.p' has type PTR")
+__naked int aggregate_ret_kfunc_nested_ptr_fail(void)
+{
+	asm volatile (
+	"r1 =3D 0;"
+	"call %[bpf_kfunc_call_test_ret_nested];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_ret_nested)
+	: __clobber_all);
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("is not composed of scalars or arena pointers")
+__msg("member 'p[]' has type PTR")
+__naked int aggregate_ret_kfunc_ptr_arr_fail(void)
+{
+	asm volatile (
+	"call %[bpf_kfunc_call_test_ret_ptr_arr];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_ret_ptr_arr)
+	: __clobber_all);
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("is not composed of scalars or arena pointers")
+__msg("member 'in1[].in2.p' has type PTR")
+__naked int aggregate_ret_kfunc_arr_struct_fail(void)
+{
+	asm volatile (
+	"call %[bpf_kfunc_call_test_ret_arr_struct];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_ret_arr_struct)
+	: __clobber_all);
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("is not composed of scalars or arena pointers")
+__msg("member 'a[].p' has type PTR")
+__naked int aggregate_ret_kfunc_arr2d_fail(void)
+{
+	asm volatile (
+	"call %[bpf_kfunc_call_test_ret_arr2d];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_ret_arr2d)
+	: __clobber_all);
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__failure __msg("max struct nesting depth exceeded")
+__naked int aggregate_ret_kfunc_too_deep_fail(void)
+{
+	asm volatile (
+	"r1 =3D 0;"
+	"call %[bpf_kfunc_call_test_ret_deep];"
+	"r0 =3D 0;"
+	"exit;"
+	:
+	: __imm(bpf_kfunc_call_test_ret_deep)
+	: __clobber_all);
+}
+
 SEC("tc")
 __arch_x86_64 __arch_arm64
 __failure __msg("R2 !read_ok")
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 850cf4f830c4..dff1ad6f491f 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -981,6 +981,41 @@ __bpf_kfunc struct prog_test_ret_ptr bpf_kfunc_call_=
test_ret_ptr(u64 tag)
 	return r;
 }
=20
+__bpf_kfunc struct prog_test_ret_nested bpf_kfunc_call_test_ret_nested(u=
64 tag)
+{
+	struct prog_test_ret_nested r =3D { .in =3D { .p =3D NULL }, .tag =3D t=
ag };
+
+	return r;
+}
+
+__bpf_kfunc struct prog_test_ret_ptr_arr bpf_kfunc_call_test_ret_ptr_arr=
(void)
+{
+	struct prog_test_ret_ptr_arr r =3D { .p =3D { NULL, NULL } };
+
+	return r;
+}
+
+__bpf_kfunc struct prog_test_ret_arr_struct bpf_kfunc_call_test_ret_arr_=
struct(void)
+{
+	struct prog_test_ret_arr_struct r =3D {};
+
+	return r;
+}
+
+__bpf_kfunc struct prog_test_ret_arr2d bpf_kfunc_call_test_ret_arr2d(voi=
d)
+{
+	struct prog_test_ret_arr2d r =3D {};
+
+	return r;
+}
+
+__bpf_kfunc struct prog_test_ret_deep bpf_kfunc_call_test_ret_deep(u64 v=
)
+{
+	struct prog_test_ret_deep r =3D { .l1 =3D { .l2 =3D { .l3 =3D { .l4 =3D=
 { .v =3D v } } } } };
+
+	return r;
+}
+
 __bpf_kfunc struct prog_test_ret_ii bpf_kfunc_call_test_ret_ii(int a, in=
t b)
 {
 	struct prog_test_ret_ii r =3D { .a =3D a, .b =3D b };
@@ -1539,6 +1574,11 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_pair)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_fastcall, KF_FASTCALL)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ptr)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_nested)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ptr_arr)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arr_struct)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_arr2d)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_deep)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
 #endif
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_big)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 65e693ada736..9202c31ba6c9 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -70,6 +70,43 @@ struct prog_test_ret_ptr {	/* 16 bytes: contains a poi=
nter */
 	__u64 tag;
 };
=20
+struct prog_test_ret_nested {	/* 16 bytes: the pointer hides one level d=
own */
+	struct {
+		void *p;
+	} in;
+	__u64 tag;
+};
+
+struct prog_test_ret_ptr_arr {	/* 16 bytes: an array of pointers */
+	void *p[2];
+};
+
+struct prog_test_ret_arr_struct {	/* 16 bytes: the pointer is under an a=
rray of structs */
+	struct {
+		struct {
+			void *p;
+		} in2;
+	} in1[2];
+};
+
+struct prog_test_ret_arr2d {	/* 16 bytes: a two dimensional array of str=
ucts */
+	struct {
+		void *p;
+	} a[1][2];
+};
+
+struct prog_test_ret_deep {	/* 8 bytes, but nested past the 4-level walk=
 limit */
+	struct {
+		struct {
+			struct {
+				struct {
+					__u64 v;
+				} l4;
+			} l3;
+		} l2;
+	} l1;
+};
+
 struct prog_test_ret_big {	/* 24 bytes: too large for R0:R2 */
 	__u64 a;
 	__u64 b;
@@ -159,6 +196,11 @@ struct prog_test_ret_pair bpf_kfunc_call_test_ret_pa=
ir(__u64 a, __u64 b) __ksym;
 struct prog_test_ret_pair bpf_kfunc_call_test_ret_fastcall(__u64 a, __u6=
4 b) __ksym;
 struct prog_test_ret_ii bpf_kfunc_call_test_ret_ii(int a, int b) __ksym;
 struct prog_test_ret_ptr bpf_kfunc_call_test_ret_ptr(__u64 tag) __ksym;
+struct prog_test_ret_nested bpf_kfunc_call_test_ret_nested(__u64 tag) __=
ksym;
+struct prog_test_ret_ptr_arr bpf_kfunc_call_test_ret_ptr_arr(void) __ksy=
m;
+struct prog_test_ret_arr_struct bpf_kfunc_call_test_ret_arr_struct(void)=
 __ksym;
+struct prog_test_ret_arr2d bpf_kfunc_call_test_ret_arr2d(void) __ksym;
+struct prog_test_ret_deep bpf_kfunc_call_test_ret_deep(__u64 v) __ksym;
 struct prog_test_ret_big bpf_kfunc_call_test_ret_big(void) __ksym;
 __u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d,
 			       __u64 e, __u64 f, __u64 g, __u64 h,
--=20
2.53.0-Meta

