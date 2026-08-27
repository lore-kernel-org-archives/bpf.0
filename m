Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDD433065D
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811112; cv=none; b=bnke95L32YOuulD0bCTlxnZT9h5aGXscfcRIcpVWjhqBBU7FGiYdah0qAsote8CTXsXH5hzNq0z9d14puRM3Ux7uLsL4pvb3cJlq1y+tT5KCrUurZaqxxdXjOTnRcMyu7LwrSC41bie6Nnkw7hI8EDi9Q1rRrQ9EoqDUSieDe2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811112; c=relaxed/simple;
	bh=MAG7D/1GFdOJLqFTBjwiqaTsZ3x6SjNPDHYANQOvgZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2gcOunNg2DeWH4wZ1TxwHOwCGNGx8oPG7nmdyYozdkVYbStttx50YipOYV69uBu+zKfC/gtaZqlMGfmiFYF6WljOXsars5rh98zORXnazYN9/HZexMsvdRWa7aDZDp6heHBmbaE57Vcrj1Hr5/AzFawqTNvb2r9WsoPpbt1gTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A3F4226CDEAAFD; Wed, 26 Aug 2026 23:11:45 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 06/11] bpf: Allow a global function to return arena pointers by value
Date: Wed, 26 Aug 2026 23:11:45 -0700
Message-ID: <20260827061145.2517714-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827061114.2514603-1-yonghong.song@linux.dev>
References: <20260827061114.2514603-1-yonghong.song@linux.dev>
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

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c                              | 20 ++++++++++++++-----
 .../selftests/bpf/progs/exceptions_fail.c     |  2 +-
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index b1f4ef614d4c..f6d82a8fd617 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7973,13 +7973,22 @@ static int btf_validate_return_type(struct bpf_ve=
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
+		 * result to the arena. A local function is verified inline, so
+		 * its caller receives the real register state and any member is
+		 * fine.
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
@@ -8075,7 +8084,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 		if (is_global) {
 			bpf_log(log,
 				"Global function %s() has unsupported return type. "
-				"Only void, scalar, or a scalar-only struct/union up to 16 bytes is =
supported.\n",
+				"Only void, a scalar, an arena pointer, or a struct/union of "
+				"scalars and arena pointers up to 16 bytes is supported.\n",
 				tname);
 		}
 		return err;
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/=
testing/selftests/bpf/progs/exceptions_fail.c
index 9708efb93683..cde4982e9989 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -60,7 +60,7 @@ __noinline int exception_cb_ok_arg_small(int a)
=20
 SEC("?tc")
 __exception_cb(exception_cb_bad_ret_type1)
-__failure __msg("Only void, scalar, or a scalar-only struct/union up to =
16 bytes is supported.")
+__failure __msg("Only void, a scalar, an arena pointer, or a struct/unio=
n of scalars")
 int reject_exception_cb_type_1(struct __sk_buff *ctx)
 {
 	bpf_throw(0);
--=20
2.53.0-Meta

