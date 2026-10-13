Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F02D519DEC
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911464; cv=none; b=Mt42VP9vbYyJUv26PVu4OZqvTdgTd5mOxLCuleXmK8KK6HUS3r9ubFHpZqnRxji/npn+h+2FC11h7z/XKtupSxO+qJpnsbNE8uAvYK/q9sTwn0t2p284D9nKBm5QKkyJryPI39wGy6g4xy6uhZmmfDIWioVSyWRA1jGo9EQI7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911464; c=relaxed/simple;
	bh=unK3H1cfrtt/ZGhDeJGpigY673deRd3otCrhl0NSnSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQK4sv0VTOebPeWMwjj4iMf7P9G6IDCsVWepUa+JJUYFahYIV2xrbnMjR7kLRvETMB6WwRrb985eehFkCOaWzZ5huNUnGXQYJkx7z1En2DLy4Bim5BCDsR5UYMrcsfDNnxPVrPl0Jw+KFS+x5Bpoz0vii19sOiyGONBZTrZbRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E205130FB6598A; Tue, 13 Oct 2026 10:10:59 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 11/11] selftests/bpf: Test that a kfunc gets its __int128 stack argument aligned
Date: Tue, 13 Oct 2026 10:10:59 -0700
Message-ID: <20261013171059.2141231-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013170910.2126673-1-yonghong.song@linux.dev>
References: <20261013170910.2126673-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add bpf_kfunc_call_test_i128_arg_align(), which takes an __int128 after
seven u64s, in the stack slot after a hole, and returns the low four
bits of its address. OPTIMIZER_HIDE_VAR() keeps the compiler from taking
the alignment the ABI promises for granted and folding them to 0.

Call it from two subprograms whose frames are 8 bytes apart, so that one
of the calls starts with RSP off by 8 whatever alignment the program
was given, and check that both find the __int128 16-byte aligned.
Without the previous patch, the x86-64 JIT fails it with

	run_subtest:FAIL:1552 Unexpected retval: 2 !=3D 0
	aggregate_arg/aggregate_arg_kfunc_int128_align:FAIL

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/aggregate_arg_kfunc.c | 42 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 15 +++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 +
 3 files changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c b/to=
ols/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
index c87e886423f4..3c3bcb3a02d5 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
@@ -222,6 +222,48 @@ int aggregate_arg_kfunc_int128_pad(struct __sk_buff =
*skb)
 	return 0;
 }
=20
+/*
+ * The kfunc returns the low four bits of the address of v, which both
+ * conventions pass in a 16-byte aligned stack slot. A program's frame i=
s
+ * only 8-byte aligned on x86-64, so call it from two frames 8 bytes apa=
rt:
+ * one of them starts the call off by 8, whatever the program was given.
+ */
+static __noinline __u64 int128_align_frame1(__u64 a, __u64 b)
+{
+	volatile __u64 pad[1];
+	u128 v =3D ((u128)a << 64) | b;
+
+	pad[0] =3D a;
+	return bpf_kfunc_call_test_i128_arg_align(1, 2, 3, 4, 5, 6, pad[0], v);
+}
+
+static __noinline __u64 int128_align_frame2(__u64 a, __u64 b)
+{
+	volatile __u64 pad[2];
+	u128 v =3D ((u128)a << 64) | b;
+
+	pad[0] =3D a;
+	pad[1] =3D b;
+	return bpf_kfunc_call_test_i128_arg_align(1, 2, 3, 4, 5, pad[1], pad[0]=
, v);
+}
+
+SEC("tc")
+__arch_x86_64 __arch_arm64
+__load_if_JITed()
+__success __retval(0)
+int aggregate_arg_kfunc_int128_align(struct __sk_buff *skb)
+{
+	__u64 a =3D skb->len ^ MIX_A;
+	__u64 b =3D skb->len ^ MIX_B;
+
+	if (int128_align_frame1(a, b))
+		return 1;
+	if (int128_align_frame2(a, b))
+		return 2;
+
+	return 0;
+}
+
 #endif /* __SIZEOF_INT128__ */
=20
 #endif
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 38edb4addc5b..8550897fdfa6 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1120,6 +1120,20 @@ __bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_pad(u=
64 a, u64 b, u64 c, u64 d, u64
 	       (u64)v * 8 + (u64)((unsigned __int128)v >> 64) * 9;
 }
=20
+/*
+ * The low four bits of the address of v, which follows a stack slot hol=
e: 0 if
+ * the caller passed it in a 16-byte aligned slot, as the x86-64 ABI ask=
s.
+ */
+__bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_align(u64 a, u64 b, u64 c, =
u64 d, u64 e,
+						   u64 f, u64 g, __int128 v)
+{
+	unsigned long addr =3D (unsigned long)&v;
+
+	/* or the compiler takes the alignment the ABI promises for granted */
+	OPTIMIZER_HIDE_VAR(addr);
+	return addr & 15;
+}
+
 __bpf_kfunc u64 bpf_kfunc_call_test_pair_arg_nofit(u64 a, u64 b, u64 c, =
u64 d,
 						   struct prog_test_pair_arg s)
 {
@@ -1840,6 +1854,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd=
)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd_many)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_stack_hole)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_pad)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_align)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_nofit)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_tail)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_split8)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index a6a93c901416..da0c9b0c38a4 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -249,6 +249,8 @@ __u64 bpf_kfunc_call_test_i128_arg_stack_hole(__u64 a=
, __u64 b, __u64 c, __u64 d
 					      struct prog_test_i128_arg w) __ksym;
 __u64 bpf_kfunc_call_test_i128_arg_pad(__u64 a, __u64 b, __u64 c, __u64 =
d, __u64 e,
 				       __u64 f, __u64 g, __int128 v) __ksym;
+__u64 bpf_kfunc_call_test_i128_arg_align(__u64 a, __u64 b, __u64 c, __u6=
4 d, __u64 e,
+					 __u64 f, __u64 g, __int128 v) __ksym;
 #endif
 __u64 bpf_kfunc_call_test_pair_arg_nofit(__u64 a, __u64 b, __u64 c, __u6=
4 d,
 					 struct prog_test_pair_arg s) __ksym;
--=20
2.53.0-Meta

