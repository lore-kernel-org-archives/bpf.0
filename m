Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC837C0E6
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984159; cv=none; b=NO8GA0WVPZaUapT5SaUc/XYeFsQt+9h80HxUvxKM/eboae3EJHRhDn+EbpqYnx6ubGbXZk75H3PSAR3DKlcvHjmnVcp+j9He5Q64pLBPuZGJA0M1IiyN4aii7zNPMUuqJ/wsLRpdFled+flB6Sah7AfYAp7XFG8iESKncnfjBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984159; c=relaxed/simple;
	bh=LxtrS0Gc3G3w4jJTEr6YzssK5189nr79OEQAqQl2Z2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3hI65duRWPYjvFzO3JcRuek407xNOMl/D6mBAJVh3NGgjXl3ES0ZNh7wZArM3Mib5r45TLFDRYfGnGGXJCplDcE9TuwQC7Z6qjVJ5J+/zTkmVGgTKniGcq+iNU2puHE48bRFXe8cP/XpMbA+cpNtcFA/MIKvMpF1CsUo0Qn3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 20677273BA2FBC; Fri, 28 Aug 2026 23:15:50 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 07/12] bpf: Allow a global function to return arena pointers by value
Date: Fri, 28 Aug 2026 23:15:50 -0700
Message-ID: <20260829061550.1696869-1-yonghong.song@linux.dev>
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

A global function may already return an arena pointer on its own, and
check_global_ret_scalar_reg() accepts one in either half of the R0:R2
pair. Let the members of a by-value struct it returns be arena pointers
as well, rather than scalars only.

Only a subprogram gets this: the main program returns to the kernel,
which has no arena to cast the address back into, so
btf_validate_return_type() keeps rejecting an arena pointer there,
whether bare or inside a struct. The rejection message therefore has to
name what the function at hand may return, or it would offer the main
program an arena pointer it cannot have.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c                              | 28 +++++++++++++++----
 .../selftests/bpf/progs/exceptions_fail.c     |  2 +-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b1f4ef614d4c..9c2cab08bb79 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7973,13 +7973,23 @@ static int btf_validate_return_type(struct bpf_ve=
rifier_env *env, struct btf *bt
 	if (btf_type_is_struct(t) && t->size <=3D 16) {
 		/*
 		 * A global function's caller models the return as an opaque
-		 * scalar pair, so it may only return scalars by value. A local
-		 * function is verified inline, so a pointer field stays tracked
-		 * and needs no such restriction.
+		 * scalar pair, so a pointer member would be laundered into a
+		 * scalar and escape provenance and reference tracking. Only
+		 * scalars and arena pointers are allowed: an arena pointer has
+		 * no provenance to lose, since a program may already derive one
+		 * from any scalar with addr_space_cast(), which confines the
+		 * result to the arena. The main program is the exception: it
+		 * returns to the kernel, which has no arena to cast the address
+		 * back into. A local function is verified inline, so its caller
+		 * receives the real register state and any member is fine.
 		 */
 		bool local_func =3D subprog && !is_global;
+		u32 member_kinds =3D BTF_MEMBER_SCALAR;
=20
-		if (local_func || btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SC=
ALAR))
+		if (subprog)
+			member_kinds |=3D BTF_MEMBER_ARENA_PTR;
+
+		if (local_func || btf_struct_is_composed_of(env, btf, t, member_kinds)=
)
 			return 0;
 	}
=20
@@ -8073,10 +8083,16 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
 	err =3D btf_validate_return_type(env, btf, t, subprog, is_global);
 	if (err) {
 		if (is_global) {
+			/* Only a subprogram may return arena pointers. */
+			const char *supported =3D subprog ?
+				"void, scalar, arena pointer, or a struct/union of "
+				"scalars and arena pointers" :
+				"void, scalar, or a scalar-only struct/union";
+
 			bpf_log(log,
 				"Global function %s() has unsupported return type. "
-				"Only void, scalar, or a scalar-only struct/union up to 16 bytes is =
supported.\n",
-				tname);
+				"Only %s up to 16 bytes is supported.\n",
+				tname, supported);
 		}
 		return err;
 	}
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/=
testing/selftests/bpf/progs/exceptions_fail.c
index 9708efb93683..22503cf62e9f 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -60,7 +60,7 @@ __noinline int exception_cb_ok_arg_small(int a)
=20
 SEC("?tc")
 __exception_cb(exception_cb_bad_ret_type1)
-__failure __msg("Only void, scalar, or a scalar-only struct/union up to =
16 bytes is supported.")
+__failure __msg("Only void, scalar, arena pointer, or a struct/union of =
scalars and arena pointers up to 16 bytes is supported.")
 int reject_exception_cb_type_1(struct __sk_buff *ctx)
 {
 	bpf_throw(0);
--=20
2.53.0-Meta

