Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647664;
	b=v0a+FGfA0Gq3YKGc8hUbfgsgUhf5gg6Lfm4fm7ya9nRHVRIhNzaSS31vx9zESd0Nr2zE
	 34MLWsX9KqkOWuaby4xpBULR0qUCfW6e3jPbd9IEa1+9aAovkvJW+gEH2u5P+4bA6aGWv
	 k/KMr99KkeZ9T7dUb2cZyuqivfl6PFF4cplnoQfKQB1hGRmWN9v2KuCkQlHrMDl59zH4q
	 tbOSP4xl1l7iX0/GrKvkLeQ1g7G4nRxN9Fz+FEESo90MmKle+zL9UdkRhr2jsnGf5YiQi
	 X6HF4GZhSfmmCI27XjCB77AhH8IOpfaipd3pk7xJx0mbm8VrOM9KAIcdGKW7CmqR4RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647664;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RcWFfCxdcWGLHrB1Tv7j2okAoPFpeweZuQByRw5irUY=;
	b=nCHRLofJPou8Hi/tH50GSgX1WwizV6og2qXZKQqELc2kz1jdqF9EEpl3Dmy/qLOkoHzE
	 qOxtJ4Uly2BHStsFTNrATrD0LEmrsHPiWN7njS7Am56+ks4x+LZB10xEZIv1zOaiPhC5/
	 6IG9PntW7+d2i8sdIaY61evgTYl2n6zEz9e2L/fiplzvZ77BALUrMLsrSkDSqeFhGa6Co
	 FR6hvN3qjFvoHmLTVtrGl/JdeMzscJSH2HOoupw4L5A7tsKkmB6ibkdUhSq3eeIItDsuM
	 fKyvMf54kc5Ka6G0t9QHaSN7TMgMTlxWioke4N0VuJnloUSYLREGN0bj+rwjK3BnQdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.181
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FD606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 105FD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 5C080564FCB4F; Mon,  2 Nov 2026 11:27:27 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next] selftests/bpf: Fix callback recursion test with noipa global func
Date: Mon,  2 Nov 2026 11:27:27 -0800
Message-ID: <20261102192727.762933-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With llvm24 after commit 28b4a2032f97 ("[BPF] Mark global functions
noipa"), the test recursion_via_global_func_and_callback fails:

  13: (85) call bpf_loop#181 4: frame1: R1=3Dscalar() R10=3Dfp0 cb
  ; return static_calls_global(i); @ verifier_global_subprogs.c:548
  4: (85) call pc+1
  ...
  ; return global_calls_loop(x); @ verifier_global_subprogs.c:543
  6: (85) call pc+1
  Func#3 ('global_calls_loop') is global and assumed valid.
  7: frame2: R0=3Dscalar()
  7: (95) exit
  ...
  ; return static_calls_global(i); @ verifier_global_subprogs.c:548
  5: (95) exit
  At callback return the register R0 has unknown scalar value should have=
 been in [0, 1]
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  EXPECTED   SUBSTR: 'recursive call from global_calls_loop() to loop_cb_=
calls_static()'
   #669/9   verifier_global_subprogs/recursion_via_global_func_and_callba=
ck:FAIL

The callback loop_cb_calls_static() returns the result of
static_calls_global(), which in turn returns the result of the global
function global_calls_loop().

Before the above llvm24 commit, IPSCCP (interprocedural sparse
conditional constant propagation) could fold the return value of
global_calls_loop() into its callers. global_calls_loop() is not
static, but it has a non-weak definition in the same compilation unit,
so IPSCCP may assume that definition is the one called. It found that
global_calls_loop() always returns 0 and replaced the uses of the call
result with 0, which made static_calls_global() and then
loop_cb_calls_static() return a constant 0 as well. The calls stay, only
their return values are replaced. So the callback set R0 to 0 itself,
passed the bpf_loop callback return range check, and verification went
on to report the expected recursion.

The llvm24 commit marks global functions noipa, since the verifier
checks a global function only against its BTF prototype and freplace
can replace it. With noipa, IPSCCP no longer propagates the return
value of global_calls_loop() to callers. The verifier does not look
into a global function either, so R0 after the call is an unknown
scalar, and the callback return check fails before the recursion is
detected.

Make static_calls_global() return void and let loop_cb_calls_static()
return 0 explicitly. The call chain the test is about stays the same,
and the test passes with both llvm24 and earlier versions (e.g. llvm21
to llvm23).

Link: https://github.com/llvm/llvm-project/pull/237690
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../testing/selftests/bpf/progs/verifier_global_subprogs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c=
 b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 574b26b5a7df..5e8461b2167d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -538,14 +538,15 @@ int return_from_void_global(struct __sk_buff *skb)
=20
 int global_calls_loop(int x);
=20
-static __noinline int static_calls_global(int x)
+static __noinline void static_calls_global(int x)
 {
-	return global_calls_loop(x);
+	global_calls_loop(x);
 }
=20
 static __noinline int loop_cb_calls_static(u32 i, void *ctx)
 {
-	return static_calls_global(i);
+	static_calls_global(i);
+	return 0;
 }
=20
 __noinline int global_calls_loop(int x)
--=20
2.53.0-Meta

