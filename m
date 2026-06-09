Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1853BED06
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023212; cv=none; b=Xb6TTr/bwjHdP/Vt5opc64mR23RxYWbBcjtWt56qi4lX9HIOU5+vXus5W6jx1SgCo8/VgFP4PKHl8jdahKxF1JR1x56oEFIUBCTz45pltQ3GN88fETRHGOnJHVDU6f4GxsmnM8POCXi95gEAPMZEJtCIrG8176XTBSsyESjgNIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023212; c=relaxed/simple;
	bh=tH6tDKNuWYP59AEZdEc3nFr/adc/97oHVGFmmby+Fl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkJNt05N8EZZDluKuMj+e5FpwYZmsgEsMz6iS8t6qoeZoNRDFc8ZJ00CyM2tn/TWBkzADPugQBpEvGgIh41JvRlnNRE8cI3gy5DhmhqBcsJ6PcjWPnK2HS6IOqMOLvl2I8SNyEHrCSzw66zZ95VzJ7y5OQopt/FJwYnZmFyTwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 84FF514982C53F; Tue,  9 Jun 2026 09:39:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Keep int return type for tailcall subprogs
Date: Tue,  9 Jun 2026 09:39:57 -0700
Message-ID: <20260609163957.1719798-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260609163947.1717694-1-yonghong.song@linux.dev>
References: <20260609163947.1717694-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Similar to the previous patch, barrier_var() is used to prevent the
LLVM23 compiler from optimizing away the return value of subprogs that
issue a bpf_tail_call. Where the caller does not already consume the
return value, store it into a global variable as well, so the compiler
cannot change the subprog return type from 'int' to 'void'.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/tailcall_bpf2bpf2.c    |  5 ++++-
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c    | 18 +++++++++++++-----
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c    | 11 ++++++++---
 .../selftests/bpf/progs/verifier_sock.c        |  9 +++++++--
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c b/tool=
s/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c
index ce97d141daee..c4fadee5aadc 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf2.c
@@ -13,11 +13,14 @@ struct {
 static __noinline
 int subprog_tail(struct __sk_buff *skb)
 {
+	int ret =3D 1;
+
 	if (load_byte(skb, 0))
 		bpf_tail_call_static(skb, &jmp_table, 1);
 	else
 		bpf_tail_call_static(skb, &jmp_table, 0);
-	return 1;
+	barrier_var(ret);
+	return ret;
 }
=20
 int count =3D 0;
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy=
2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
index ae94c9c70ab7..8f217bef3d62 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
@@ -25,8 +25,11 @@ int count1 =3D 0;
 static __noinline
 int subprog_tail0(struct __sk_buff *skb)
 {
+	int ret =3D 0;
+
 	bpf_tail_call_static(skb, &jmp_table, 0);
-	return 0;
+	barrier_var(ret);
+	return ret;
 }
=20
 __auxiliary
@@ -41,16 +44,21 @@ int classifier_0(struct __sk_buff *skb)
 static __noinline
 int subprog_tail1(struct __sk_buff *skb)
 {
+	int ret =3D 0;
+
 	bpf_tail_call_static(skb, &jmp_table, 1);
-	return 0;
+	barrier_var(ret);
+	return ret;
 }
=20
+int ret1, ret2;
+
 __auxiliary
 SEC("tc")
 int classifier_1(struct __sk_buff *skb)
 {
 	count1++;
-	subprog_tail1(skb);
+	ret1 =3D subprog_tail1(skb);
 	return 0;
 }
=20
@@ -63,8 +71,8 @@ int tailcall_bpf2bpf_hierarchy_2(struct __sk_buff *skb)
=20
 	clobber_regs_stack();
=20
-	subprog_tail0(skb);
-	subprog_tail1(skb);
+	ret1 =3D subprog_tail0(skb);
+	ret2 =3D subprog_tail1(skb);
=20
 	__sink(ret);
 	return (count1 << 16) | count0;
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy=
3.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
index 56b6b0099840..4d89eabe1f70 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
@@ -33,17 +33,22 @@ int count =3D 0;
 static __noinline
 int subprog_tail(struct __sk_buff *skb, void *jmp_table)
 {
+	int ret =3D 0;
+
 	bpf_tail_call_static(skb, jmp_table, 0);
-	return 0;
+	barrier_var(ret);
+	return ret;
 }
=20
+int ret1, ret2;
+
 __auxiliary
 SEC("tc")
 int classifier_0(struct __sk_buff *skb)
 {
 	count++;
-	subprog_tail(skb, &jmp_table0);
-	subprog_tail(skb, &jmp_table1);
+	ret1 =3D subprog_tail(skb, &jmp_table0);
+	ret2 =3D subprog_tail(skb, &jmp_table1);
 	return count;
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/te=
sting/selftests/bpf/progs/verifier_sock.c
index 9f680cf44512..bd9fa6b2a2f9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -1120,8 +1120,11 @@ int tail_call(struct __sk_buff *sk)
 static __noinline
 int static_tail_call(struct __sk_buff *sk)
 {
+	int ret =3D 0;
+
 	bpf_tail_call_static(sk, &jmp_table, 0);
-	return 0;
+	barrier_var(ret);
+	return ret;
 }
=20
 /* Tail calls in sub-programs invalidate packet pointers. */
@@ -1138,6 +1141,8 @@ int invalidate_pkt_pointers_by_global_tail_call(str=
uct __sk_buff *sk)
 	return TCX_PASS;
 }
=20
+int ret1;
+
 /* Tail calls in static sub-programs invalidate packet pointers. */
 SEC("tc")
 __failure __msg("invalid mem access")
@@ -1147,7 +1152,7 @@ int invalidate_pkt_pointers_by_static_tail_call(str=
uct __sk_buff *sk)
=20
 	if ((void *)(p + 1) > (void *)(long)sk->data_end)
 		return TCX_DROP;
-	static_tail_call(sk);
+	ret1 =3D static_tail_call(sk);
 	*p =3D 42; /* this is unsafe */
 	return TCX_PASS;
 }
--=20
2.53.0-Meta

