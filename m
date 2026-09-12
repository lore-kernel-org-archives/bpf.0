Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11838F656
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242791; cv=none; b=akZVDOwmK/iPyvjhwZWA9R/bJYT5ycaNKbP6zGRlB33SQRPW0tpYXXZsXkqsTj+v9SWXl7/Nal3X3xbAhV2VHdK8vwXAkBwFAbjzAmHXQGKrLaqGxVa+zUkI+TpkT0Z8LqaDuqmSF9W1QeUhljo8l/TnrdX3FjCb0/cc5zEevOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242791; c=relaxed/simple;
	bh=80bBlX8W7rH9dCqRpCZ7OrjBJSDy9Jsz1YGwgcO+ld8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHX9IA40mqhQ48LWmL+sfkiX+SbBO7cLaSDojtt/XFlAD07TQKbhMttfICmx2pFKl9NKr39KnY6A7z0WF+8l3ZYKfqcF+ESrXE77L8mr3N7Phn5j+IQhBMuuCvdzms4ipTvRLJaRfHUtseEIqzikhngkmYgGxfOFynEjqtmufys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DF5F02A58A0DFD; Sat, 12 Sep 2026 12:53:02 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 13/15] selftests/bpf: Add C tests for by-value arguments up to 16 bytes
Date: Sat, 12 Sep 2026 12:53:02 -0700
Message-ID: <20260912195302.991273-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912195156.980886-1-yonghong.song@linux.dev>
References: <20260912195156.980886-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Extend the by-value argument test with the aggregate cases, written in C
so that they depend on the compiler lowering the argument into a pair of
argument registers rather than on a hand-written register layout.

The programs cover a struct and a union that fill two registers, a
smaller struct that fills one, and two struct arguments in a row,
alongside the __int128 already there. Each has an int argument around it
so that a wrong slot count shows up as a wrong value in the parameters
beside it; two pairs leave room for only one, which follows them. A
global function taking a struct with a pointer member is rejected: the
callee would receive the pointer as an opaque scalar.

A struct the argument registers cannot hold reaches the callee partly on
the stack, which the interpreter does not implement, so that case is
loaded only when the JIT is on.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/progs/verifier_aggregate_arg.c        | 165 ++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c b=
/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c
index fc7c1b18bc40..b0ecccede47e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_aggregate_arg.c
@@ -7,6 +7,131 @@
 #define MIX_A	0xdeadbeefcafef00dULL
 #define MIX_B	0x0123456789abcdefULL
=20
+struct pair {
+	__u64 lo;
+	__u64 hi;
+};
+
+struct small {
+	__u32 a;
+	__u32 b;
+};
+
+union upair {
+	__u64 halves[2];
+	struct {
+		__u64 lo;
+		__u64 hi;
+	} parts;
+};
+
+struct with_ptr {
+	void *p;
+	__u64 x;
+};
+
+static __noinline __u64 take_pair(int a, struct pair p, int c)
+{
+	return (__u64)a + p.lo + p.hi + c;
+}
+
+SEC("tc")
+__success __retval(0)
+int aggregate_arg_static_struct_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct pair p =3D { .lo =3D a, .hi =3D b };
+
+	if (take_pair(1, p, 2) !=3D a + b + 3)
+		return 1;
+
+	return 0;
+}
+
+#if defined(__clang__)
+
+__noinline __u64 take_pair_global(int a, struct pair p, int c)
+{
+	return (__u64)a + p.lo + p.hi + c;
+}
+
+SEC("tc")
+__success __retval(0)
+int aggregate_arg_global_struct_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct pair p =3D { .lo =3D a, .hi =3D b };
+
+	if (take_pair_global(1, p, 2) !=3D a + b + 3)
+		return 1;
+
+	return 0;
+}
+
+__noinline __u64 take_two_pairs_global(struct pair p, struct pair q, int=
 d)
+{
+	return p.lo + p.hi + q.lo + q.hi + d;
+}
+
+SEC("tc")
+__success __retval(0)
+int aggregate_arg_two_structs_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct pair p =3D { .lo =3D a, .hi =3D b };
+	struct pair q =3D { .lo =3D a + 1, .hi =3D b + 2 };
+
+	if (take_two_pairs_global(p, q, 3) !=3D 2 * a + 2 * b + 6)
+		return 1;
+
+	return 0;
+}
+
+__noinline __u64 take_small_global(int a, struct small s, int c)
+{
+	return (__u64)a + s.a + s.b + c;
+}
+
+SEC("tc")
+__success __retval(0)
+int aggregate_arg_small_struct_c_test(struct __sk_buff *skb)
+{
+	__u32 a =3D skb->len ^ (__u32)MIX_A;
+	__u32 b =3D skb->len ^ (__u32)MIX_B;
+	struct small s =3D { .a =3D a, .b =3D b };
+
+	if (take_small_global(1, s, 2) !=3D (__u64)a + b + 3)
+		return 1;
+
+	return 0;
+}
+
+__noinline __u64 take_upair_global(int a, union upair u, int c)
+{
+	return (__u64)a + u.parts.lo + u.parts.hi + c;
+}
+
+SEC("tc")
+__success __retval(0)
+int aggregate_arg_union_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	union upair u;
+
+	u.halves[0] =3D a;
+	u.halves[1] =3D b;
+	if (take_upair_global(1, u, 2) !=3D a + b + 3)
+		return 1;
+
+	return 0;
+}
+
+#endif
+
 #ifdef __SIZEOF_INT128__
=20
 typedef unsigned __int128 u128;
@@ -32,4 +157,44 @@ int aggregate_arg_int128_c_test(struct __sk_buff *skb=
)
=20
 #endif /* __SIZEOF_INT128__ */
=20
+#if defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+static __noinline __u64 take_spilled_pair(int a, int b, int c, int d, st=
ruct pair p)
+{
+	return (__u64)a + b + c + d + p.lo + p.hi;
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_spilled_struct_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct pair p =3D { .lo =3D a, .hi =3D b };
+	int n =3D skb->len;
+
+	if (take_spilled_pair(n, n + 1, n + 2, n + 3, p) !=3D a + b + 4 * n + 6=
)
+		return 1;
+
+	return 0;
+}
+
+#endif
+
+__noinline __u64 take_with_ptr_global(struct with_ptr s)
+{
+	return s.x;
+}
+
+SEC("tc")
+__failure __msg("type STRUCT in take_with_ptr_global() is not composed o=
f scalars")
+int aggregate_arg_ptr_member_fail(struct __sk_buff *skb)
+{
+	struct with_ptr s =3D { .p =3D skb, .x =3D skb->len };
+
+	return take_with_ptr_global(s);
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.53.0-Meta

