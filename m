Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDFC312807
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811093; cv=none; b=TKJ5xZnWUo3mn7JwruDva/85XCiOV+IEeGC0MMsyxobAZOmVLM+pAIx9H6oZRk4XWaMBK8nnPSZ8cHURlhICYL7lsjLbO1I+7mfdv8G7KrYopklQSo0zxzDvJTfgkBPg/Q/z8raIy+DHlE6TnW/01cpx+kNOUcQgDyHnsMmizjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811093; c=relaxed/simple;
	bh=M84Hq8zhwg5WHfRzEi7feMHEy+8pxt5JH7Dc5ofQ4Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgTjP0zXNVjhpF80fEzsv12+K896H12BhMVCNKSgd4BJmHvky8POn9WccS6BkDSJcSQ37gFYMUE0ZdeDsSSy/ucuIlECetq7LZilSg3ry9aBbTADatZfTccholpZxWFQIf310jWDDXGFnKV2M9mNwsosXULnK1gRcSAOPJOmrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E7E6326CDE2CA1; Wed, 26 Aug 2026 23:11:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 01/11] bpf: Record each half of a paired return value in verifier diagnostics
Date: Wed, 26 Aug 2026 23:11:19 -0700
Message-ID: <20260827061119.2515071-1-yonghong.song@linux.dev>
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

A subprogram returning more than 8 bytes comes back in the R0:R2 register
pair. There are three places, check_func_call(), prepare_func_exit() and
check_kfunc_call(), where only R0 is tracked by the diagnostic
modification scope and R2 is missed.

Fix it by opening a diagnostic modification scope for each return registe=
r.
This way, both return registers are recorded.

Fixes: 0630ad00d96d ("bpf: Add verifier support for 16-byte returns in R0=
: R2")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 56 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e036ae20bf6b..5d8162e13c20 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9995,9 +9995,14 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 		 */
 		if (!returns_void) {
 			nregs =3D bpf_ret_reg_pair(env, subprog) ? 2 : 1;
-			for (i =3D 0; i < nregs; i++)
-				mark_reg_unknown(env, caller->regs, ret_regs[i]);
+			mark_reg_unknown(env, caller->regs, ret_regs[0]);
 			bpf_diag_mod_end(env);
+			for (i =3D 1; i < nregs; i++) {
+				bpf_diag_mod_begin(env, &caller->regs[ret_regs[i]], NULL,
+						   BPF_DIAG_MOD_WRITE);
+				mark_reg_unknown(env, caller->regs, ret_regs[i]);
+				bpf_diag_mod_end(env);
+			}
 		}
=20
 		if (env->subprog_info[subprog].might_throw) {
@@ -10403,10 +10408,14 @@ static int prepare_func_exit(struct bpf_verifie=
r_env *env, int *insn_idx)
 		 * return to the caller whatever the callee had in the
 		 * return register(s)
 		 */
-		bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], r0, BPF_DIAG_MOD_WRI=
TE);
-		for (i =3D 0; i < nregs; i++)
-			caller->regs[ret_regs[i]] =3D callee->regs[ret_regs[i]];
-		bpf_diag_mod_end(env);
+		for (i =3D 0; i < nregs; i++) {
+			u32 regno =3D ret_regs[i];
+
+			bpf_diag_mod_begin(env, &caller->regs[regno], &callee->regs[regno],
+					   BPF_DIAG_MOD_WRITE);
+			caller->regs[regno] =3D callee->regs[regno];
+			bpf_diag_mod_end(env);
+		}
 	}
=20
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to call=
site,
@@ -11342,15 +11351,33 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
=20
 /*
  * Mark the register(s) holding a @size byte kfunc return value as unkno=
wn
- * scalars. Both halves of a register pair are treated the same way.
+ * scalars and return how many registers that took. Both halves of a reg=
ister
+ * pair are treated the same way.
+ *
+ * R0 is written in the diagnostic modification scope the caller opened =
before
+ * the caller-saved scrub, since R0 gets no scrub record of its own and =
that
+ * scope is what carries its pre-call value into the history. A scope tr=
acks a
+ * single register and does not nest, so close it before recording the r=
est of
+ * the return value. A value that fits in R0 leaves the caller's scope o=
pen for
+ * the caller to close, so a later write to R0 still lands in it.
  */
-static void mark_kfunc_ret_regs(struct bpf_verifier_env *env,
-				struct bpf_reg_state *regs, u32 size)
+static u32 mark_kfunc_ret_regs(struct bpf_verifier_env *env,
+			       struct bpf_reg_state *regs, u32 size)
 {
 	u32 i, nregs =3D ret_regs_cnt(size);
=20
-	for (i =3D 0; i < nregs; i++)
+	mark_reg_unknown(env, regs, ret_regs[0]);
+	if (nregs =3D=3D 1)
+		return nregs;
+
+	bpf_diag_mod_end(env);
+	for (i =3D 1; i < nregs; i++) {
+		bpf_diag_mod_begin(env, &regs[ret_regs[i]], NULL, BPF_DIAG_MOD_WRITE);
 		mark_reg_unknown(env, regs, ret_regs[i]);
+		bpf_diag_mod_end(env);
+	}
+
+	return nregs;
 }
=20
 static bool is_kfunc_acquire(struct bpf_call_arg_meta *meta)
@@ -13767,7 +13794,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 	struct bpf_insn_aux_data *insn_aux;
 	const char *operation;
 	int err, insn_idx =3D *insn_idx_p;
-	u32 i, nargs, ptr_type_id;
+	u32 i, nargs, ptr_type_id, ret_nregs =3D 1;
 	struct bpf_kfunc_desc *desc;
 	struct btf *desc_btf;
 	int id;
@@ -14021,7 +14048,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 	}
=20
 	if (btf_type_is_scalar(t)) {
-		mark_kfunc_ret_regs(env, regs, t->size);
+		ret_nregs =3D mark_kfunc_ret_regs(env, regs, t->size);
 		if (meta.btf =3D=3D btf_vmlinux && (meta.func_id =3D=3D special_kfunc_=
list[KF_bpf_res_spin_lock] ||
 		    meta.func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqsav=
e]))
 			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
@@ -14039,7 +14066,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 				btf_name_by_offset(desc_btf, t->name_off));
 			return -EINVAL;
 		}
-		mark_kfunc_ret_regs(env, regs, t->size);
+		ret_nregs =3D mark_kfunc_ret_regs(env, regs, t->size);
 	} else if (btf_type_is_ptr(t)) {
 		ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
 		err =3D check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc=
_btf);
@@ -14170,7 +14197,8 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 	 * Record R0 before process_iter_next_call() snapshots the alternate
 	 * iterator path's diagnostic position.
 	 */
-	bpf_diag_mod_end(env);
+	if (ret_nregs =3D=3D 1)
+		bpf_diag_mod_end(env);
=20
 	if (bpf_is_iter_next_kfunc(&meta)) {
 		err =3D process_iter_next_call(env, insn_idx, &meta);
--=20
2.53.0-Meta

