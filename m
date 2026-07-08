Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97A2D97A6
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541431; cv=none; b=bxhA+W7ZeQbpcFQXSdjzUcDMs27GbpFqCnW8iJl9mTXsa2oZEUPn8viT5MEaq4IXOfFV4Znzv5Ih8WG+MUg2RB7XcPwcYPtk4xiMEG14da4O6ITvWVGV46FDl2g5KG7evO278wt4AYx/AEOU76nuNv3kfQrM6TSvPCn0q2vMIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541431; c=relaxed/simple;
	bh=logokV+cAV+yMOKcSHA/fccHV+v1Kr03eX1Y4i+8G20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vbokpxa1aeHA12igT/gissGDEq8BYUItprlRPiYoA5vYGhcbNO0y9CY3YdqtUSqHcSGgpJx32H3uQXmj1u56rm1kiJSEk0IwKhLmYKhLEu6f2NCAZmbKS4zjllDCjaxGswayYPBxCGRta2WrucjNMAXPgFzoz7AG2zcOELjaqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6C87D1D0B6F89D; Wed,  8 Jul 2026 13:10:10 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 06/12] bpf: Force JIT for programs using the R0:R2 register pair
Date: Wed,  8 Jul 2026 13:10:10 -0700
Message-ID: <20260708201010.2158718-1-yonghong.song@linux.dev>
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

The R0:R2 return convention introduced in this series is only implemented
in the JIT. The BPF interpreter has no notion of a second return register=
,
so a program relying on the R0:R2 convention would compute wrong results
under the interpreter. Force the JIT when bpf_prog_aux->ret_reg_pair is
set.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/core.c     |  2 +-
 kernel/bpf/verifier.c | 13 +++++++++++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c1a98fa36738..10966aba69a2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1780,6 +1780,7 @@ struct bpf_prog_aux {
 	bool changes_pkt_data;
 	bool might_sleep;
 	bool kprobe_write_ctx;
+	bool ret_reg_pair;
 	struct {
 		s32 keyring_serial;
 		u8 keyring_type;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 73dc3ee879de..819a97d25173 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2676,7 +2676,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env, struct
 		goto finalize;
=20
 	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-	    bpf_prog_has_kfunc_call(fp))
+	    bpf_prog_has_kfunc_call(fp) || fp->aux->ret_reg_pair)
 		jit_needed =3D true;
=20
 	if (!bpf_prog_select_interpreter(fp))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fcbf532159a5..ca8b2f436c20 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -453,6 +453,15 @@ bool bpf_ret_reg_pair(struct bpf_verifier_env *env, =
int subprog)
 	return false;
 }
=20
+static bool bpf_ret_reg_pair_mark(struct bpf_verifier_env *env, int subp=
rog)
+{
+	if (!bpf_ret_reg_pair(env, subprog))
+		return false;
+
+	env->prog->aux->ret_reg_pair =3D true;
+	return true;
+}
+
 static const char *subprog_name(const struct bpf_verifier_env *env, int =
subprog)
 {
 	struct bpf_func_info *info;
@@ -9877,7 +9886,7 @@ static int prepare_func_exit(struct bpf_verifier_en=
v *env, int *insn_idx)
 	} else {
 		/* return to the caller whatever r0 had in the callee */
 		caller->regs[BPF_REG_0] =3D *r0;
-		if (bpf_ret_reg_pair(env, callee->subprogno)) {
+		if (bpf_ret_reg_pair_mark(env, callee->subprogno)) {
 			if (callee->regs[BPF_REG_2].type =3D=3D PTR_TO_STACK) {
 				verbose(env, "cannot return stack pointer to the caller\n");
 				return -EINVAL;
@@ -16806,7 +16815,7 @@ static int check_global_subprog_return_code(struc=
t bpf_verifier_env *env)
 	if (err)
 		return err;
=20
-	if (!bpf_ret_reg_pair(env, subprog))
+	if (!bpf_ret_reg_pair_mark(env, subprog))
 		return 0;
=20
 	return check_global_ret_scalar_reg(env, BPF_REG_2);
--=20
2.53.0-Meta

