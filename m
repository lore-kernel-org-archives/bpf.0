Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910595540B1
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175470; cv=none; b=i5G4u1ykbJTiZlMyFUbTuyNkxs2HZku4TDkPB7KSlMF6BSXdQ5jU/htRjTxwsfF0eiRe0PuVi7t1FSUsvoNfOHnXSWK+PNxYCEWrEkiOpFbgJhTEntx6Zkdhayv+/D4r2fJSku7v0AmLeAUoYYUr9nP5meNfRoof8gL+xpNXiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175470; c=relaxed/simple;
	bh=fMSlhuj0aXNVvR4WTMphw9XzkLK1TOTDxbBmMuwAflw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncfTGZ84DgpaGo5UIWIFGzgquhzJYYwSvLuJq+71mXdeHXWOm71sbvrz0+T7JjJYsUoNfzSFXWeOrMB658aSmv7sdzHMajZfsOQv9znU1nFUwn9XHrYliK277QMcGNddqgUBLzJT8rFmbFbBecOGkVRRW0WD5TxOznqXLkugcX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E21C631A0DA94D; Fri, 16 Oct 2026 11:30:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 3/9] selftests/bpf: Test by-value __int128 kfunc arguments at an odd slot
Date: Fri, 16 Oct 2026 11:30:54 -0700
Message-ID: <20261016183054.1134162-1-yonghong.song@linux.dev>
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

This follows up the series "bpf: Support by-value struct and __int128
arguments" [1]. The __int128 kfunc tests it added pass the __int128 at
an even argument slot, after two u64s, or past the argument registers,
where it lands on an even arm64 stack slot. So neither the AAPCS64 rule
that rounds the register number up to an even one for an argument
aligned to 16 bytes, nor the same rule for a stack slot, is exercised.
Each leaves a hole the arm64 JIT has to open by moving the __int128 and
every argument after it up a slot.

Add three kfuncs. Like the earlier ones, each weighs its arguments by
argument slot, so that two eightbytes landing in each other's slots are
caught as well as one landing in a hole:

  - bpf_kfunc_call_test_i128_arg_odd(): the __int128 at an odd register
    slot.
  - bpf_kfunc_call_test_i128_arg_odd_many(): the same, with arguments
    after it that arm64 shifts onto its stack, and a second __int128 at
    an odd arm64 stack slot.
  - bpf_kfunc_call_test_i128_arg_stack_hole(): a struct holding an
    __int128 at an odd stack slot on both x86-64 and arm64, after x86-64
    gives R9 back to an argument following a 16-byte struct.

x86-64 has no register alignment rule and places the first two like the
BPF convention, so they check that its JIT leaves them where they are.
The last two need more than the five BPF argument registers and are only
built with a compiler that supports stack arguments.

On arm64 the first two kfuncs get BTF only with the pahole patch
"dwarf_loader: Skip the argument register the arm64 ABI leaves as a hole"
[2], in pahole master after v1.32. An older pahole finds the argument
after the __int128 in an unexpected register, x4 rather than x3, and
leaves the function out of BTF, so the tests fail to load there.

Link: https://lore.kernel.org/bpf/20260912195156.980886-1-yonghong.song@l=
inux.dev/ [1]
Link: https://lore.kernel.org/dwarves/20260917164043.1577508-1-yonghong.s=
ong@linux.dev/ [2]
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/aggregate_arg_kfunc.c | 71 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 26 +++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        | 13 ++++
 3 files changed, 110 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c b/to=
ols/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
index 52d3d5d53946..c87e886423f4 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
@@ -50,6 +50,27 @@ int aggregate_arg_kfunc_int128(struct __sk_buff *skb)
 	return 0;
 }
=20
+/*
+ * arm64 rounds the register number up to an even one for an argument
+ * aligned to 16 bytes, so it wants this __int128 in x2 and x3, leaving =
x1
+ * empty, and the last argument in x4. The x86-64 ABI has no such rule.
+ */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_int128_odd(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	u128 v =3D ((u128)a << 64) | b;
+
+	if (bpf_kfunc_call_test_i128_arg_odd(1, v, 2) !=3D 1 + 2 * b + 3 * a + =
4 * 2)
+		return 1;
+
+	return 0;
+}
+
 #endif /* __SIZEOF_INT128__ */
=20
 #if defined(__clang__) && defined(__BPF_FEATURE_STACK_ARGUMENT)
@@ -131,6 +152,56 @@ int aggregate_arg_kfunc_split8(struct __sk_buff *skb=
)
=20
 #ifdef __SIZEOF_INT128__
=20
+/*
+ * The hole of aggregate_arg_kfunc_int128_odd, with arguments after it t=
hat
+ * arm64 shifts through x5 to x7, where its JIT keeps the BPF stack slot=
s,
+ * and onto its stack. The second __int128 then leaves the second arm64
+ * stack slot empty. x86-64 packs the eightbytes like the BPF convention=
,
+ * so nothing moves there.
+ */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_int128_odd_many(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	u128 v =3D ((u128)a << 64) | b;
+	u128 w =3D ((u128)~a << 64) | ~b;
+
+	if (bpf_kfunc_call_test_i128_arg_odd_many(1, v, 2, 3, 4, 5, 6, w) !=3D
+	    1 + 2 * b + 3 * a + 4 * 2 + 5 * 3 + 6 * 4 + 7 * 5 + 8 * 6 +
+	    9 * ~b + 10 * ~a)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * x86-64 moves s to the stack and gives R9 back to the seventh argument=
.
+ * w, aligned to 16 bytes by the __int128 it holds, then leaves a stack =
slot
+ * empty before it: the fourth on x86-64, the second on arm64.
+ */
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_int128_stack_hole(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+	struct prog_test_pair_arg s =3D { .lo =3D a, .hi =3D b };
+	struct prog_test_i128_arg w =3D { .v =3D ((u128)~a << 64) | ~b };
+
+	if (bpf_kfunc_call_test_i128_arg_stack_hole(1, 2, 3, 4, 5, s, 6, 7, w) =
!=3D
+	    1 + 2 * 2 + 3 * 3 + 4 * 4 + 5 * 5 + 6 * a + 7 * b + 8 * 6 + 9 * 7 +
+	    10 * ~b + 11 * ~a)
+		return 1;
+
+	return 0;
+}
+
 /*
  * Both conventions pad the stack to align this __int128, and the BPF
  * convention pads for neither, so both JITs move it up an eightbyte.
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index b4f0af2aeca4..00641d597f95 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1047,6 +1047,29 @@ __bpf_kfunc u64 bpf_kfunc_call_test_i128_arg(u64 a=
, u64 b, __int128 v)
 	return a + b * 2 + (u64)v * 3 + (u64)((unsigned __int128)v >> 64) * 4;
 }
=20
+__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_odd(u64 a, __int128 v, u64 =
b)
+{
+	return a + (u64)v * 2 + (u64)((unsigned __int128)v >> 64) * 3 + b * 4;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_odd_many(u64 a, __int128 v,=
 u64 b, u64 c,
+						      u64 d, u64 e, u64 f, __int128 w)
+{
+	return a + (u64)v * 2 + (u64)((unsigned __int128)v >> 64) * 3 +
+	       b * 4 + c * 5 + d * 6 + e * 7 + f * 8 +
+	       (u64)w * 9 + (u64)((unsigned __int128)w >> 64) * 10;
+}
+
+__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_stack_hole(u64 a, u64 b, u6=
4 c, u64 d, u64 e,
+							struct prog_test_pair_arg s,
+							u64 f, u64 g,
+							struct prog_test_i128_arg w)
+{
+	return a + b * 2 + c * 3 + d * 4 + e * 5 + s.lo * 6 + s.hi * 7 +
+	       f * 8 + g * 9 + (u64)w.v * 10 +
+	       (u64)((unsigned __int128)w.v >> 64) * 11;
+}
+
 __bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_pad(u64 a, u64 b, u64 c, u6=
4 d, u64 e,
 						 u64 f, u64 g, __int128 v)
 {
@@ -1770,6 +1793,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_deep)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd_many)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_stack_hole)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_pad)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_nofit)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_tail)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 67c02a421d13..a6a93c901416 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -66,6 +66,12 @@ struct prog_test_pair_arg {	/* 16 bytes: two argument =
registers */
 	__u64 hi;
 };
=20
+#ifdef __SIZEOF_INT128__
+struct prog_test_i128_arg {	/* 16 bytes, aligned to 16 like its member *=
/
+	__int128 v;
+};
+#endif
+
 struct prog_test_ptr_arg {	/* 16 bytes, but holds a pointer */
 	void *p;
 	__u64 x;
@@ -234,6 +240,13 @@ struct prog_test_ret_ii bpf_kfunc_call_test_ret_ii(i=
nt a, int b) __ksym;
 __u64 bpf_kfunc_call_test_pair_arg(__u64 a, struct prog_test_pair_arg s,=
 __u64 b) __ksym;
 #ifdef __SIZEOF_INT128__
 __u64 bpf_kfunc_call_test_i128_arg(__u64 a, __u64 b, __int128 v) __ksym;
+__u64 bpf_kfunc_call_test_i128_arg_odd(__u64 a, __int128 v, __u64 b) __k=
sym;
+__u64 bpf_kfunc_call_test_i128_arg_odd_many(__u64 a, __int128 v, __u64 b=
, __u64 c,
+					    __u64 d, __u64 e, __u64 f, __int128 w) __ksym;
+__u64 bpf_kfunc_call_test_i128_arg_stack_hole(__u64 a, __u64 b, __u64 c,=
 __u64 d,
+					      __u64 e, struct prog_test_pair_arg s,
+					      __u64 f, __u64 g,
+					      struct prog_test_i128_arg w) __ksym;
 __u64 bpf_kfunc_call_test_i128_arg_pad(__u64 a, __u64 b, __u64 c, __u64 =
d, __u64 e,
 				       __u64 f, __u64 g, __int128 v) __ksym;
 #endif
--=20
2.53.0-Meta

