Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100801B3B19
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407006; cv=none; b=eNNiXGiWJsOP4A1dNqG2Fto8YC4oOdI8wruIgLxjk/curHt6m0i7jo765W7oPdPJ96fSRmtGwzhh81walZr9esy/0EgBUs8PPH1jVddIb9Zcvi2NTo6XcsS1yTXgA1tHwFdOkth1mFx5JQR9/yWFvCm2eQ7niEQsl0our8geVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407006; c=relaxed/simple;
	bh=sR4ijW+c6GJZXO/etKxr2kugBaLaJ62o1w47dYh+Tf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1s9DBwo0AiYwtmBPGB/+Ah514xGzC9mCcuK+Q8c06sptfoOJkoqBBLBdTIKycZkYltebUFpj0i457U7d7yVGyrGeeq8jAt5V7tBuHAnwnXWQ+QzY6Ezq7WfH7PNHQidrdfgsYrFcyL3dC0tqU+PJkPP0ql2RV4HHtbzFKesN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D0F7B233CF27A4; Mon, 10 Aug 2026 17:09:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 09/13] bpf: Enable aggregate return types up to 16 bytes
Date: Mon, 10 Aug 2026 17:09:57 -0700
Message-ID: <20260811000957.2382783-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811000911.2378679-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
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
and struct_ops function models, so relaxing it widens what those can atta=
ch
to. A >8 byte return stays rejected on every path that reads the target's
return value: commit c48796aa6c39 ("bpf: Reject >8 byte return values on
return-reading trampoline paths") covers fexit, fmod_ret and fsession plu=
s
their _multi variants, and struct_ops, and an fentry-only trampoline neve=
r
sets BPF_TRAMP_F_CALL_ORIG so it does not touch the return value at all. =
A
struct or union of 8 bytes or less is newly accepted for those paths; its
single eightbyte is returned in R0 like any other scalar.

btf_validate_return_type() is relaxed as well, so that it accepts a
by-value struct or union up to 16 bytes in addition to void and scalars.

With btf_distill_func_proto() and btf_validate_return_type() relaxed, the
verifier, JIT, precision-backtracking and live-register support from the
earlier patches becomes reachable: this final patch enables <=3D16 byte
aggregate return values end to end.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h                  |  2 +
 kernel/bpf/btf.c                              | 44 ++++++++++++++++---
 kernel/bpf/verifier.c                         |  6 +--
 .../selftests/bpf/progs/exceptions_fail.c     |  2 +-
 4 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 911d57ce2488..1f516daa41db 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1449,6 +1449,8 @@ void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, =
u64 stack_mask);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subpr=
og);
 int bpf_get_kfunc_ret_size(const struct bpf_prog *prog, u32 func_id,
 			   u16 btf_fd_idx, u8 *ret_size);
+bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env, const str=
uct btf *btf,
+				 const struct btf_type *t, int rec);
=20
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6606187ed4f4..5551abcea1d3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7592,7 +7592,12 @@ int btf_distill_func_proto(struct bpf_verifier_log=
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
@@ -7965,7 +7970,7 @@ static int btf_scan_type_tags(struct bpf_verifier_e=
nv *env,
=20
 /* Check whether the type is a valid return type. */
 static int btf_validate_return_type(struct bpf_verifier_env *env, struct=
 btf *btf,
-		const struct btf_type *t, int subprog)
+		const struct btf_type *t, int subprog, bool is_global)
 {
 	u32 tags =3D 0;
 	int err;
@@ -7988,6 +7993,35 @@ static int btf_validate_return_type(struct bpf_ver=
ifier_env *env, struct btf *bt
 	if (btf_type_is_void(t) || btf_type_is_int(t) || btf_is_any_enum(t))
 		return 0;
=20
+	if (btf_type_is_struct(t) && t->size <=3D 16) {
+		/*
+		 * A >8 byte struct/union is returned in the R0:R2 register pair.
+		 * A global function is verified in isolation, so its caller models
+		 * the return as an opaque R0:R2 scalar pair; it must therefore
+		 * contain only scalars, otherwise a pointer field would be
+		 * laundered into a scalar and escape provenance and reference
+		 * tracking. That requirement is enforced here: do_check_common()
+		 * propagates the error for global functions and for the main
+		 * program.
+		 *
+		 * A local (static) function is verified inline and its R0:R2 are
+		 * copied as precise register state (with the JIT forced on when
+		 * the pair is consumed), so a pointer field stays tracked and needs
+		 * no such restriction. Accepting it here is not by itself what
+		 * makes it legal: btf_check_subprog_call() drops any error other
+		 * than -EFAULT. What it avoids is needlessly marking the
+		 * subprogram's BTF unreliable.
+		 *
+		 * The main program (subprog 0) takes the scalar-only path as well,
+		 * but its return value is the program's exit code, so a >8 byte
+		 * return is rejected separately at BPF_EXIT.
+		 */
+		bool local_func =3D subprog && !is_global;
+
+		if (local_func || __btf_type_is_scalar_struct(env, btf, t, 0))
+			return 0;
+	}
+
 	return -EOPNOTSUPP;
 }
=20
@@ -8075,12 +8109,12 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
 		return -EINVAL;
 	}
=20
-	err =3D btf_validate_return_type(env, btf, t, subprog);
+	err =3D btf_validate_return_type(env, btf, t, subprog, is_global);
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
index 8f0c4aed0781..f8294359c85d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11088,9 +11088,9 @@ static bool is_kfunc_arg_implicit(const struct bp=
f_call_arg_meta *meta, u32 arg_
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

