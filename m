Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335DE3D5221
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541436; cv=none; b=E83DJYL9vEg990HZWpozGSnJDzo4pUKjsdOtWfz5aAYU1G9JpthzGEek+U7fkKZGkC9dxg6aM2ZQxYxNWQMRsEUXeLDSC/NRotyoWlSaawyfIJpgSoKHGHSgiwj+JLuZyv3ybYZxKdYji74MA5r0aUCPwy14j29Njh4x+zgV7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541436; c=relaxed/simple;
	bh=uZ5w4PbhT6cC3ub5i4FzF5uqz/znJBx5tZn1P8ebwfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENDL0hcAblxECVYmT4CnGMR/uv98T0lstvgAaWNPID5RTilqH9chcYTrLGBuWeup0NmELsgp7pPJUvY9gy9+q1l6F1rQhQDzYbAb9R4jhU8rZWX/VGHVI/iaSl5Cla/DEl/btTaR6jc+7v9D66Uk5Z/bXSjfNiUInQy7/AC62pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B84D21D0B6F935; Wed,  8 Jul 2026 13:10:20 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 08/12] bpf: Enable 16-byte aggregate return types
Date: Wed,  8 Jul 2026 13:10:20 -0700
Message-ID: <20260708201020.2160131-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708200939.2153664-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Relax btf_distill_func_proto() to accept a by-value struct or union that
the R0:R2 convention added in earlier patches can carry:

 - a struct or union larger than 8 and up to 16 bytes, returned in the
   R0:R2 register pair, matching what LLVM emits for the BPF target;
 - a struct or union up to 8 bytes, returned in R0 alone.

A >8 byte scalar (__int128) was already accepted and is unchanged.
Everything else stays rejected: a return type larger than 16 bytes, and a=
ny
type that __get_type_size() cannot return in registers at all (e.g. an
array), which it already reports as ret < 0.

btf_distill_func_proto() also builds the trampoline (fentry/fexit/fmod_re=
t)
and struct_ops function models. Allowing up to 16 bytes here is safe: the
previous patch already rejects >8 byte returns on the return-reading path=
s,
where the trampoline preserves only 8 bytes of the return value.

btf_validate_return_type() is relaxed as it accepts a by-value struct or
union up to 16 bytes in addition to void and scalars.

With btf_distill_func_proto() and btf_validate_return_type() relaxed, the
verifier, JIT, precision-backtracking, live-register and trampoline-guard
preparation from the earlier patches becomes reachable: this final patch
enables <=3D16 byte aggregate return values end to end.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h                       |  2 ++
 kernel/bpf/btf.c                                   | 14 +++++++++++---
 kernel/bpf/verifier.c                              |  6 +++---
 .../testing/selftests/bpf/progs/exceptions_fail.c  |  2 +-
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index fa255f326240..ae4dae8e57f9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1433,6 +1433,8 @@ void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, =
u64 stack_mask);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subpr=
og);
 bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog);
 int bpf_get_kfunc_ret_size(const struct bpf_prog *prog, u32 func_id, u16=
 offset);
+bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env, const str=
uct btf *btf,
+				 const struct btf_type *t, int rec);
=20
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index dff5c0d91641..bab82d1c8cb9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7572,7 +7572,12 @@ int btf_distill_func_proto(struct bpf_verifier_log=
 *log,
 		return -EINVAL;
 	}
 	ret =3D __get_type_size(btf, func->type, &t);
-	if (ret < 0 || btf_type_is_struct(t)) {
+	/*
+	 * __get_type_size() already restricts a non-negative ret to void, a
+	 * pointer, an int, an enum or a struct/union, so only the size is chec=
ked
+	 * here.
+	 */
+	if (ret < 0 || ret > 16) {
 		bpf_log(log,
 			"The function %s return type %s is unsupported.\n",
 			tname, btf_type_str(t));
@@ -7968,6 +7973,9 @@ static int btf_validate_return_type(struct bpf_veri=
fier_env *env, struct btf *bt
 	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
 		return 0;
=20
+	if (btf_type_is_struct(t) && t->size <=3D 16 && __btf_type_is_scalar_st=
ruct(env, btf, t, 0))
+		return 0;
+
 	return -EOPNOTSUPP;
 }
=20
@@ -8059,8 +8067,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 	if (err) {
 		if (is_global) {
 			bpf_log(log,
-				"Global function %s() return value not void or scalar. "
-				"Only those are supported.\n",
+				"Global function %s() has unsupported return type. "
+				"Only void, scalar, or a scalar-only struct/union up to 16 bytes is =
supported.\n",
 				tname);
 		}
 		return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 121f56e3fb16..bf451a2d7095 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11082,9 +11082,9 @@ static bool is_kfunc_arg_implicit(const struct bp=
f_kfunc_call_arg_meta *meta, u3
 }
=20
 /* Returns true if struct is composed of scalars, 4 levels of nesting al=
lowed */
-static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
-					const struct btf *btf,
-					const struct btf_type *t, int rec)
+bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
+				 const struct btf *btf,
+				 const struct btf_type *t, int rec)
 {
 	const struct btf_type *member_type;
 	const struct btf_member *member;
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/=
testing/selftests/bpf/progs/exceptions_fail.c
index ac44d60e5066..9708efb93683 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -60,7 +60,7 @@ __noinline int exception_cb_ok_arg_small(int a)
=20
 SEC("?tc")
 __exception_cb(exception_cb_bad_ret_type1)
-__failure __msg("Global function exception_cb_bad_ret_type1() return val=
ue not void or scalar.")
+__failure __msg("Only void, scalar, or a scalar-only struct/union up to =
16 bytes is supported.")
 int reject_exception_cb_type_1(struct __sk_buff *ctx)
 {
 	bpf_throw(0);
--=20
2.53.0-Meta

