Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DEA412C04
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498662; cv=none; b=qkCyf8gI8Ynz2Tr6PSSm2udoOgm1OOyLp/300ufFDQn3NBUUtn6lJN9MMxBAezilB1qUEZoV5XMG4L1vE4YKcoD0Y6QtXj3yXqNoGGShxKb2bN4YxPSQbRwcDWbcopQdN8UPk9+jCnBsL/h8qzOQoBxj0Is2/aVx5R5p6EYZn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498662; c=relaxed/simple;
	bh=HlRLrsim+uu2IJcWCDBRYpKbojcADfNkVa757clJsMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLu0oYXECndcB1OD65kTWKLefxzfE3fQTiLkl2oW+KbCJ1VkmbD144SsENm8NyvIUUMWTMrpGIqutIx7arFGNlCTNLilLjcJapkjjwAJadTlFZgElaLnNx3UVjc+ZQSd2UKpXi404fgImmT30XanWr8UGaL9ZRTVodS2kVp5NNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CB6AE288148814; Thu,  3 Sep 2026 22:10:49 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 10/12] selftests/bpf: Add C tests for by-value arguments up to 16 bytes
Date: Thu,  3 Sep 2026 22:10:49 -0700
Message-ID: <20260904051049.3982644-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904050957.3976119-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
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
smaller struct that fills one, and two struct arguments in a row, each
with an int argument on either side so that a wrong slot count shows up
as a wrong value in the parameters around it, alongside the __int128
already there. A global function taking a struct with a pointer member
is rejected: the callee would receive the pointer as an opaque scalar.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/verifier_int128_arg.c | 164 ++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c b/to=
ols/testing/selftests/bpf/progs/verifier_int128_arg.c
index 044fc4a80055..b10fb4aeb405 100644
--- a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
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
+__noinline __u64 take_two_pairs_global(struct pair p, struct pair q)
+{
+	return p.lo + p.hi + q.lo + q.hi;
+}
+
+SEC("tc")
+__success __retval(0)
+int aggregate_arg_two_structs_c_test(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct pair p =3D { .lo =3D a, .hi =3D b };
+	struct pair q =3D { .lo =3D b, .hi =3D a };
+
+	if (take_two_pairs_global(p, q) !=3D 2 * (a + b))
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
 typedef unsigned __int128 u128;
=20
 __noinline __u64 take_i128_global(int a, u128 v, int c)
@@ -28,4 +153,43 @@ int aggregate_arg_int128_c_test(struct __sk_buff *skb=
)
 	return 0;
 }
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

