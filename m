Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03AA3D810F
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691302; cv=none; b=dQKveQNnl13QQbn5XRc0aZ9b1VNAbeEq756DxIoyC/2Rh3MuCOTj0jI8+IrlMTX0tARinwceUK+NATk7Xg539+6j26hYlCLFxr8ugRcoDUsXdNDX1E+jlvEG14fskaQ9qmNHmusE6czWLC4z577JMjkTlFndlPW3mjYeONlC6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691302; c=relaxed/simple;
	bh=M4AbQvNUVBQ9CW9MRwEUmtPECzjlnKNUk0EtJ57rS34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQSykelBWeAquwsWuvSarbW/SUQye2cdPOdZJUbtSaia40h6vRkFUY0XVygw+cUFMvSfho8kBdNiKg6qNWUmunLEw+dI8YGjlnEgKLVLAGLp+i84Jl2ZMRSRD2KkXzB4iZRtSWbl2LQIjr/vMT53A/syjATGQCs1OCRj+U0Fp6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 57980268293DDA; Tue, 25 Aug 2026 13:54:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 08/10] selftests/bpf: Check the member named for an unsupported kfunc return type
Date: Tue, 25 Aug 2026 13:54:53 -0700
Message-ID: <20260825205453.1325394-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825205412.1320099-1-yonghong.song@linux.dev>
References: <20260825205412.1320099-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cover the member a rejected by-value kfunc return type is blamed on.
The existing case for a struct carrying a pointer now also checks that
the verifier names the member, and two cases are added: a pointer inside
a nested member struct, which has to be named by its path rather than by
its own name, and a type nested deeper than the walk descends, which has
no single member to blame and reports the depth instead.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/aggregate_ret_kfunc.c | 34 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 16 +++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        | 21 ++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/to=
ols/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
index f10e5cf6fd89..e9c82df8efb2 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
@@ -18,6 +18,8 @@ void __kfunc_btf_root(void)
 	: "r"(&bpf_kfunc_call_test_i128),
 	  "r"(&bpf_kfunc_call_test_ret_fastcall),
 	  "r"(&bpf_kfunc_call_test_ret_ptr),
+	  "r"(&bpf_kfunc_call_test_ret_nested),
+	  "r"(&bpf_kfunc_call_test_ret_deep),
 	  "r"(&bpf_kfunc_call_test_ret_ii),
 	  "r"(&bpf_kfunc_call_test_ret_big));
 }
@@ -72,6 +74,7 @@ __naked int aggregate_ret_kfunc_fastcall_fail(void)
 SEC("tc")
 __arch_x86_64 __arch_arm64
 __failure __msg("is not composed of scalars or arena pointers")
+__msg("member 'p' has type PTR")
 __naked int aggregate_ret_kfunc_ptr_fail(void)
 {
 	asm volatile (
@@ -84,6 +87,37 @@ __naked int aggregate_ret_kfunc_ptr_fail(void)
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
index 850cf4f830c4..76acbe29054a 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -981,6 +981,20 @@ __bpf_kfunc struct prog_test_ret_ptr bpf_kfunc_call_=
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
@@ -1539,6 +1553,8 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_pair)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_fastcall, KF_FASTCALL)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ptr)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_nested)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_deep)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
 #endif
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_big)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 65e693ada736..52227129a49e 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -70,6 +70,25 @@ struct prog_test_ret_ptr {	/* 16 bytes: contains a poi=
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
@@ -159,6 +178,8 @@ struct prog_test_ret_pair bpf_kfunc_call_test_ret_pai=
r(__u64 a, __u64 b) __ksym;
 struct prog_test_ret_pair bpf_kfunc_call_test_ret_fastcall(__u64 a, __u6=
4 b) __ksym;
 struct prog_test_ret_ii bpf_kfunc_call_test_ret_ii(int a, int b) __ksym;
 struct prog_test_ret_ptr bpf_kfunc_call_test_ret_ptr(__u64 tag) __ksym;
+struct prog_test_ret_nested bpf_kfunc_call_test_ret_nested(__u64 tag) __=
ksym;
+struct prog_test_ret_deep bpf_kfunc_call_test_ret_deep(__u64 v) __ksym;
 struct prog_test_ret_big bpf_kfunc_call_test_ret_big(void) __ksym;
 __u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d,
 			       __u64 e, __u64 f, __u64 g, __u64 h,
--=20
2.53.0-Meta

