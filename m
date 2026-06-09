Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E53EE1EE
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048061; cv=none; b=nqC8asN/hGd1VaeswbcrIM+AOhnONlqin+JTtAAiPwgkCF+WTCij+9N1PxlALJjEo8oaOU25QaVDQH3ycTJkye/a0ws7fXPsvK+KkWLX2zvKKXzD+LIiG5pAmLHgulurlxXCd3nVxsQrx6VgYMi0vKavp7QVXLmzsNQvhLDC/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048061; c=relaxed/simple;
	bh=xR7Arsvb1zUBWQv+T5D0Fb95j0VEkJ7oIa+ixunIhrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZvlkoCqLQbw+7k/KnVK33iEkzorlUSaTMkvjMG4SzUU8eCMLammTfQiy/fXfz28aOdXZ/7qV44ve5EHX7PY+gazPDQCLX424KFM98gtbdc7Pgizej/yNhsgii9esKfbMgNfMwunoeQGtw3noT7nFC3HbSHc5ksPAJzcclEaKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 249B514B04B939; Tue,  9 Jun 2026 16:34:07 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Keep int return type for tailcall subprogs
Date: Tue,  9 Jun 2026 16:34:07 -0700
Message-ID: <20260609233407.2711577-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260609233402.2711071-1-yonghong.song@linux.dev>
References: <20260609233402.2711071-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM23 ([1]) supports 'true' function signature in BTF. The return type
of the caller of a tailcall must be an 'int'. Otherwise, verification wil=
l
fail (see check_btf_func() in check_btf.c). So with llvm23, it is possibl=
e
that the compiler may change the caller's return type from 'int' to 'void=
'.
To prevent this, barrier_var() and __sink() are used to avoid returning
a constant prone to be optimized.

  [1] https://github.com/llvm/llvm-project/pull/198426

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/tailcall_bpf2bpf2.c   |  5 +++-
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   | 13 ++++++----
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   | 24 +++++++++++++------
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   | 13 +++++++---
 .../progs/tailcall_bpf2bpf_hierarchy_fentry.c | 13 +++++++---
 .../selftests/bpf/progs/verifier_sock.c       |  9 +++++--
 6 files changed, 57 insertions(+), 20 deletions(-)

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
1.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
index d556b19413d7..1fd07824d88a 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
@@ -16,20 +16,25 @@ int count =3D 0;
 static __noinline
 int subprog_tail(struct __sk_buff *skb)
 {
+	int ret =3D 0;
+
 	bpf_tail_call_static(skb, &jmp_table, 0);
-	return 0;
+	barrier_var(ret);
+	return ret;
 }
=20
 SEC("tc")
 int entry(struct __sk_buff *skb)
 {
-	int ret =3D 1;
+	int ret =3D 1, ret1, ret2;
=20
 	clobber_regs_stack();
=20
 	count++;
-	subprog_tail(skb);
-	subprog_tail(skb);
+	ret1 =3D subprog_tail(skb);
+	ret2 =3D subprog_tail(skb);
+	__sink(ret1);
+	__sink(ret2);
=20
 	return ret;
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy=
2.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
index ae94c9c70ab7..6fde0ab92148 100644
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
@@ -41,16 +44,22 @@ int classifier_0(struct __sk_buff *skb)
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
 __auxiliary
 SEC("tc")
 int classifier_1(struct __sk_buff *skb)
 {
+	int ret;
+
 	count1++;
-	subprog_tail1(skb);
+	ret =3D subprog_tail1(skb);
+	__sink(ret);
 	return 0;
 }
=20
@@ -59,13 +68,14 @@ __retval(33)
 SEC("tc")
 int tailcall_bpf2bpf_hierarchy_2(struct __sk_buff *skb)
 {
-	int ret =3D 0;
+	int ret =3D 0, ret1, ret2;
=20
 	clobber_regs_stack();
=20
-	subprog_tail0(skb);
-	subprog_tail1(skb);
-
+	ret1 =3D subprog_tail0(skb);
+	ret2 =3D subprog_tail1(skb);
+	__sink(ret1);
+	__sink(ret2);
 	__sink(ret);
 	return (count1 << 16) | count0;
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy=
3.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
index 56b6b0099840..0ef9cfb2da8d 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c
@@ -33,17 +33,24 @@ int count =3D 0;
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
 __auxiliary
 SEC("tc")
 int classifier_0(struct __sk_buff *skb)
 {
+	int ret1, ret2;
+
 	count++;
-	subprog_tail(skb, &jmp_table0);
-	subprog_tail(skb, &jmp_table1);
+	ret1 =3D subprog_tail(skb, &jmp_table0);
+	ret2 =3D subprog_tail(skb, &jmp_table1);
+	__sink(ret1);
+	__sink(ret2);
 	return count;
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy=
_fentry.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_=
fentry.c
index 5261395713cd..6db9afee2095 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry=
.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy_fentry=
.c
@@ -18,18 +18,25 @@ int count =3D 0;
 static __noinline
 int subprog_tail(void *ctx)
 {
+	int ret =3D 0;
+
 	bpf_tail_call_static(ctx, &jmp_table, 0);
-	return 0;
+	barrier_var(ret);
+	return ret;
 }
=20
 SEC("fentry/dummy")
 int BPF_PROG(fentry, struct sk_buff *skb)
 {
+	int ret1, ret2;
+
 	clobber_regs_stack();
=20
 	count++;
-	subprog_tail(ctx);
-	subprog_tail(ctx);
+	ret1 =3D subprog_tail(ctx);
+	ret2 =3D subprog_tail(ctx);
+	__sink(ret1);
+	__sink(ret2);
=20
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/te=
sting/selftests/bpf/progs/verifier_sock.c
index 9f680cf44512..4f2f3209eec8 100644
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
@@ -1144,10 +1147,12 @@ __failure __msg("invalid mem access")
 int invalidate_pkt_pointers_by_static_tail_call(struct __sk_buff *sk)
 {
 	int *p =3D (void *)(long)sk->data;
+	int ret;
=20
 	if ((void *)(p + 1) > (void *)(long)sk->data_end)
 		return TCX_DROP;
-	static_tail_call(sk);
+	ret =3D static_tail_call(sk);
+	__sink(ret);
 	*p =3D 42; /* this is unsafe */
 	return TCX_PASS;
 }
--=20
2.53.0-Meta

