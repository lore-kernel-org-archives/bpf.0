Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4708397922
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141782; cv=none; b=FpReXUCD6V0A8KvPMENjHxR0egQhWaMiSvLjkGa8Dmu5BA4gSUbLs/nX/x2TrEQoet7fNciO3+BgANh0oWov3ElfpSgs/miLhUOReDdl84jlIaWo802B11nLgkEEiQuApIIIk6322kNbz0KctaUnplhlaLwrjCTg9IEpj/YIjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141782; c=relaxed/simple;
	bh=iyEK+4oEzZwWv8UIFfJGu816Vg1FMZWdF9NFMqWq3mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1qMuzBqZKmQLUYnul9LjlST41hSFOWpVrbOWyu2OuRlu7wYqYSym0fdueohWZbJuyZE32cvX3w4IWQJRp4G0YLcYWkn++klGdXL2WB7IrzomXnUBmMqiONx9k9i8mOZJgyBVSkhNihiOcL06hW18YUc02ZFcUQwK8D69Pl7K7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 811DE2A1842FB5; Fri, 11 Sep 2026 08:49:29 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 03/15] bpf: Rename bpf_subprog_info::arg_cnt to arg_slot_cnt
Date: Fri, 11 Sep 2026 08:49:29 -0700
Message-ID: <20260911154929.2006014-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911154914.2004336-1-yonghong.song@linux.dev>
References: <20260911154914.2004336-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rename arg_cnt to arg_slot_cnt, as a later patch gives a parameter that
takes two argument registers, an __int128 or a 16-byte aggregate, two
slots. No functional change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h                  |  6 +++---
 kernel/bpf/btf.c                              |  2 +-
 kernel/bpf/verifier.c                         | 19 +++++++++++--------
 .../bpf/progs/verifier_stack_arg_order.c      |  4 ++--
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9727df5af83a..edb904424aba 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -828,7 +828,7 @@ struct bpf_subprog_info {
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
 	bool might_sleep: 1;
-	u8 arg_cnt:4;
+	u8 arg_slot_cnt:4;
=20
 	enum priv_stack_mode priv_stack_mode;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
@@ -838,8 +838,8 @@ struct bpf_subprog_info {
=20
 static inline u16 bpf_in_stack_arg_cnt(const struct bpf_subprog_info *su=
b)
 {
-	if (sub->arg_cnt > MAX_BPF_FUNC_REG_ARGS)
-		return sub->arg_cnt - MAX_BPF_FUNC_REG_ARGS;
+	if (sub->arg_slot_cnt > MAX_BPF_FUNC_REG_ARGS)
+		return sub->arg_slot_cnt - MAX_BPF_FUNC_REG_ARGS;
 	return 0;
 }
=20
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 31057c8f3a7c..01ec2b40f376 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8081,7 +8081,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 	}
 	args =3D (const struct btf_param *)(t + 1);
 	nargs =3D btf_type_vlen(t);
-	sub->arg_cnt =3D nargs;
+	sub->arg_slot_cnt =3D nargs;
 	if (nargs > MAX_BPF_FUNC_ARGS) {
 		bpf_log(log, "kernel supports at most %d parameters, function %s has %=
d\n",
 			MAX_BPF_FUNC_ARGS, tname, nargs);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fed576b8f7fe..e8f4c17fb27d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9772,7 +9772,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env, int subprog,
 	ret =3D btf_prepare_func_args(env, subprog);
 	if (ret) {
 		if (bpf_in_stack_arg_cnt(sub) > 0) {
-			err =3D check_outgoing_stack_args(env, caller, sub->arg_cnt,
+			err =3D check_outgoing_stack_args(env, caller, sub->arg_slot_cnt,
 							bpf_subprog_name(env, subprog),
 							NULL, NULL);
 			if (err)
@@ -9784,7 +9784,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env, int subprog,
 	func =3D btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id=
);
 	func_proto =3D btf_type_by_id(btf, func->type);
 	args =3D btf_params(func_proto);
-	ret =3D check_outgoing_stack_args(env, caller, sub->arg_cnt,
+	ret =3D check_outgoing_stack_args(env, caller, sub->arg_slot_cnt,
 					bpf_subprog_name(env, subprog), btf, args);
 	if (ret)
 		return ret;
@@ -9792,7 +9792,7 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env, int subprog,
 	/* check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
-	for (i =3D 0; i < sub->arg_cnt; i++) {
+	for (i =3D 0; i < sub->arg_slot_cnt; i++) {
 		argno_t argno =3D argno_from_arg(i + 1);
 		struct bpf_reg_state *reg =3D get_func_arg_reg(caller, regs, i);
 		struct bpf_subprog_arg_info *arg =3D &sub->args[i];
@@ -19777,13 +19777,14 @@ static int do_check_common(struct bpf_verifier_=
env *env, int subprog)
 			}
=20
 			/* Also ensure the callback only has a single scalar argument. */
-			if (sub->arg_cnt !=3D 1 || sub->args[0].arg_type !=3D ARG_ANYTHING) {
+			if (sub->arg_slot_cnt !=3D 1 || sub->args[0].arg_type !=3D ARG_ANYTHI=
NG) {
 				verbose(env, "exception cb only supports single integer argument\n")=
;
 				ret =3D -EINVAL;
 				goto out;
 			}
 		}
-		for (i =3D BPF_REG_1; i <=3D min_t(u32, sub->arg_cnt, MAX_BPF_FUNC_REG=
_ARGS); i++) {
+		for (i =3D BPF_REG_1;
+		     i <=3D min_t(u32, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS); i++)=
 {
 			arg =3D &sub->args[i - BPF_REG_1];
 			reg =3D &regs[i];
=20
@@ -19826,7 +19827,8 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
 				goto out;
 			}
 		}
-		if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT && sub->arg_cnt > MAX_BPF=
_FUNC_REG_ARGS) {
+		if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT &&
+		    sub->arg_slot_cnt > MAX_BPF_FUNC_REG_ARGS) {
 			verbose(env, "freplace programs with >%d args not supported yet\n",
 				MAX_BPF_FUNC_REG_ARGS);
 			ret =3D -EINVAL;
@@ -19839,9 +19841,10 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
 		 */
 		if (env->prog->aux->func_info_aux) {
 			ret =3D btf_prepare_func_args(env, 0);
-			if (ret || sub->arg_cnt !=3D 1 || sub->args[0].arg_type !=3D ARG_PTR_=
TO_CTX) {
+			if (ret || sub->arg_slot_cnt !=3D 1 ||
+			    sub->args[0].arg_type !=3D ARG_PTR_TO_CTX) {
 				env->prog->aux->func_info_aux[0].unreliable =3D true;
-				sub->arg_cnt =3D 1;
+				sub->arg_slot_cnt =3D 1;
 				sub->stack_arg_cnt =3D 0;
 			}
 		}
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c=
 b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
index 57f22691744a..ab1955852233 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
@@ -116,8 +116,8 @@ __naked void stack_arg_pruning_load_after_call(void)
 /*
  * "bad_ptr": the first arg is 'long *', which is not a recognized point=
er
  * type for static subprogs (not ctx, dynptr, or tagged).  btf_prepare_f=
unc_args()
- * sets arg_cnt =3D 7 / stack_arg_cnt =3D 2, then fails with -EINVAL.  T=
he subprog
- * is marked unreliable but the call still proceeds for static subprogs.
+ * sets arg_slot_cnt =3D 7 / stack_arg_cnt =3D 2, then fails with -EINVA=
L.  The
+ * subprog is marked unreliable but the call still proceeds for static s=
ubprogs.
  */
 __noinline __used __naked
 static void subprog_bad_ptr_7args(long *a, int b, int c, int d, int e, i=
nt f, int g)
--=20
2.52.0

