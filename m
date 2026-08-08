Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D91332906
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215855; cv=none; b=GnY3ydNh3MLu97zwGAJRsxq/0+Tm2YxNSNJKXX/T8LprxrC3wJm8Ms7pFPyq8IbMjbFe4KHA7hGfapzMHymY8e0hHXIkrevoz2mKwmmvYW8EYlq2QzhOLsN/Qr8D7s9Nlih7Cp18LZ6WdIZg4DV5cmXyhOEQPj6AnCIQTYqoLZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215855; c=relaxed/simple;
	bh=chWFiUDHe8BF46Jl/WO7USvjEn28jr63QbcreH9i1oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qW+xDotjEQMMqSOisIfF8TaV0k+8ESZTQjwOYI7xH1KAeRaCAh9MPvv52rGqE6ZXhOA1wIqv6lLouak9+pJKs+v4algVqoJj8D87vhR/3dU8FUBXLykrVgW71Kx/VVzE7NJCJZvpcjljLZLC5lh9BGZXsOuCU4qX8qk68IlRAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4B7D422CA31D58; Sat,  8 Aug 2026 12:04:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 08/13] bpf: Reject register-pair returns when the subprog BTF is unreliable
Date: Sat,  8 Aug 2026 12:04:03 -0700
Message-ID: <20260808190403.1900396-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808190322.1896580-1-yonghong.song@linux.dev>
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The R0:R2 return convention is derived from the BTF function prototype:
bpf_compute_subprog_ret_regs() inspects the return type of every
subprogram and records whether its value comes back in a register pair.

btf_check_subprog_call() can decide, at a call site, that this BTF is
not to be trusted and mark the subprogram unreliable, which happens when
compiler optimizations remove arguments from a static function or when a
mismatched type is passed to a global one. From that point on the
verifier falls back to conservative, R0-only, semantics for the
subprogram, while the compiled code keeps returning a pair and leaves
the upper half in R2 behind the verifier's back.

Rather than silently mistracking R2, reject a return value larger than
8 bytes as soon as the prototype it was derived from becomes unreliable.
Add subprog_ret_pair_unreliable() and test it at the two places that can
observe the flag: check_func_call(), for the call itself, and
prepare_func_exit(), for the return from an inlined static subprogram.

Note that the main program needs no such check: a >8 byte return from
subprog 0 is rejected at BPF_EXIT regardless of whether its BTF is
reliable. Callbacks need none either: a callback address only becomes a
PTR_TO_FUNC through check_ld_imm(), which already rejects any callback
returning more than 8 bytes.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 41c47bcc3b0a..a01c8ecd9073 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -438,6 +438,21 @@ static void bpf_compute_subprog_ret_regs(struct bpf_=
verifier_env *env)
 	}
 }
=20
+/*
+ * A >8 byte BPF return changes the calling convention to R0:R2, so the
+ * verifier can only allow it while the subprogram's prototype remains
+ * reliable. Once BTF is marked unreliable, reject the feature instead o=
f
+ * silently falling back to R0-only semantics.
+ */
+static bool subprog_ret_pair_unreliable(struct bpf_verifier_env *env, in=
t subprog)
+{
+	struct bpf_prog_aux *aux =3D env->prog->aux;
+
+	return bpf_ret_reg_pair(env, subprog) &&
+	       aux->func_info_aux &&
+	       aux->func_info_aux[subprog].unreliable;
+}
+
 static const char *subprog_name(const struct bpf_verifier_env *env, int =
subprog)
 {
 	struct bpf_func_info *info;
@@ -9459,6 +9474,11 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 	err =3D btf_check_subprog_call(env, subprog, caller->regs);
 	if (err =3D=3D -EFAULT)
 		return err;
+	if (subprog_ret_pair_unreliable(env, subprog)) {
+		verbose(env, "Func#%d ('%s') returns >8 bytes, which requires reliable=
 BTF\n",
+			subprog, subprog_name(env, subprog));
+		return -EINVAL;
+	}
 	if (bpf_subprog_is_global(env, subprog)) {
 		const char *sub_name =3D subprog_name(env, subprog);
=20
@@ -9832,6 +9852,11 @@ static int prepare_func_exit(struct bpf_verifier_e=
nv *env, int *insn_idx)
=20
 	callee =3D state->frame[state->curframe];
 	r0 =3D &callee->regs[BPF_REG_0];
+	if (subprog_ret_pair_unreliable(env, callee->subprogno)) {
+		verbose(env, "Func#%d ('%s') returns >8 bytes, which requires reliable=
 BTF\n",
+			callee->subprogno, subprog_name(env, callee->subprogno));
+		return -EINVAL;
+	}
 	nregs =3D bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
 	if (nregs > 1)
 		env->prog->jit_required =3D 1;
--=20
2.53.0-Meta

