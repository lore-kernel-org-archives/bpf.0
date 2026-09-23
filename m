Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6E3F8257
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139591; cv=none; b=Ql6aWXB3KWzG0HNC2olFdeK8+0ZbX3YKsdglJTiFJcP0KaWtEunYt+YHyfze2bDqauMc/6PfhJWHE/vwlNIprUFuzv1N9d6c+bpn5/tCRPcN5T6rAlnQGMCEkbi79cBi9YBuEKeauliwSYYRIomWQ2fhtYM1wZmtDeJizcSj7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139591; c=relaxed/simple;
	bh=hQ4VoCJBQ8sPTXi98B/XjX5dEisHQpKUag1erf37v9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XH59jvVAFB9ovvqU0+uObnLjMd2auyuqDhUl9ML2N3sxYjQ7U8aNgd1oE5YoslLmtrVJQtZc0dMNOLVMdDhZgRA3ZT7Oaw4pX2m2B5E8SFmkwF0xWeAaoPLI4awT6btWy1j2MExwF3kZj2In7tQ7f7VlNdwhC+x0FYYQCIm8k98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CA8702C8DA7E87; Tue, 22 Sep 2026 21:59:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 09/21] bpf: Refuse exception cleanup shapes bpf_throw() cannot dispatch
Date: Tue, 22 Sep 2026 21:59:32 -0700
Message-ID: <20260923045932.2419398-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The verifier now walks the unwind, so at every instruction it knows wheth=
er
an exception is in flight and, if it is, which frame's landing pad it
entered. do_check() asks bpf_exc_check_insn() about each instruction of
a program that carries a table, and it refuses:

  - bpf_throw() in any frame while unwinding: a second unwind over frames
    the first is still discarding. A static callee is walked from the pad=
,
    so its own throw trips this too; a global one is not walked, which is
    what subprog_info.might_throw is for
  - in the frame whose landing pad the unwind entered, where the code run=
s
    on the walker's stack: a plain exit, which is what a catch pad ends i=
n,
    a tail call, an indirect jump, an outgoing on-stack call argument, an=
d
    a BPF_LD_[ABS|IND], whose failure path leaves the frame through the
    epilogue
  - an instruction reached both inside and outside a pad: the arm64 JIT
    addresses the frame through a register only a pad entry computes. Thi=
s
    also turns away a jump into the middle of a pad

bpf_exc_check_callback() refuses a subprogram that may unwind as a
helper callback, whose helper frame would end the walk before it found a
boundary.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/exception.c       | 101 +++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       |   3 ++
 kernel/bpf/fixups.c          |   1 +
 kernel/bpf/verifier.c        |  10 ++++
 5 files changed, 117 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3146f707e030..736304d912af 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -698,6 +698,8 @@ struct bpf_insn_aux_data {
 	u64 arg_prog:4;
 	u64 throw_call:1; /* call to bpf_throw() */
 	u64 resume_call:1; /* call to bpf_unwind_resume() */
+	u64 in_cleanup_pad:1; /* runs with an exception in flight, in the pad's=
 frame */
+	u64 outside_cleanup_pad:1; /* ... and the other way round */
=20
 	/* below flags are initialized once */
 	u64 jmp_point:1;
diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index 3270e7ae2e7c..3aafbb612e7f 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -26,6 +26,15 @@ static void mark_kfunc_sites(struct bpf_verifier_env *=
env)
 	}
 }
=20
+int bpf_exc_check_callback(struct bpf_verifier_env *env, int subprog)
+{
+	if (!env->cleanup_info_cnt || !env->subprog_info[subprog].might_throw)
+		return 0;
+
+	verbose(env, "subprog %d may unwind and is used as a callback\n", subpr=
og);
+	return -EINVAL;
+}
+
 static void mark_call_sites(struct bpf_verifier_env *env)
 {
 	u32 i, j;
@@ -72,6 +81,98 @@ int bpf_prepare_cleanup_exceptions(struct bpf_verifier=
_env *env)
 	return 0;
 }
=20
+int bpf_exc_check_insn(struct bpf_verifier_env *env, struct bpf_insn *in=
sn)
+{
+	struct bpf_verifier_state *state =3D env->cur_state;
+	struct bpf_insn_aux_data *aux;
+	u32 i =3D env->insn_idx;
+	bool in_pad;
+
+	aux =3D &env->insn_aux_data[i];
+	in_pad =3D state->unwinding && state->curframe =3D=3D state->unwind_fra=
meno;
+
+	if (in_pad ? aux->outside_cleanup_pad : aux->in_cleanup_pad) {
+		verbose(env,
+			"insn %u runs both inside and outside an exception cleanup landing pa=
d\n",
+			i);
+		return -EINVAL;
+	}
+	if (in_pad)
+		aux->in_cleanup_pad =3D true;
+	else
+		aux->outside_cleanup_pad =3D true;
+
+	if (!state->unwinding)
+		return 0;
+
+	if (bpf_is_throw_kfunc(insn)) {
+		verbose(env,
+			"bpf_throw() at insn %u throws while an exception is in flight\n",
+			i);
+		return -EINVAL;
+	}
+	if (bpf_pseudo_call(insn)) {
+		int subprog =3D bpf_find_subprog(env, i + insn->imm + 1);
+
+		if (subprog >=3D 0 && bpf_subprog_is_global(env, subprog) &&
+		    env->subprog_info[subprog].might_throw) {
+			verbose(env,
+				"insn %u calls global subprog %d, which can throw while an exception=
 is in flight\n",
+				i, subprog);
+			return -EINVAL;
+		}
+	}
+
+	if (!in_pad)
+		return 0;
+
+	if (insn->code =3D=3D (BPF_JMP | BPF_EXIT)) {
+		verbose(env,
+			"exit at insn %u ends an exception cleanup landing pad: a catch pad i=
s not supported yet, only cleanup pads that resume\n",
+			i);
+		return -EOPNOTSUPP;
+	}
+	if (bpf_helper_call(insn) && insn->imm =3D=3D BPF_FUNC_tail_call) {
+		verbose(env,
+			"bpf_tail_call() at insn %u is in an exception cleanup landing pad\n"=
,
+			i);
+		return -EINVAL;
+	}
+	if (insn->code =3D=3D (BPF_JMP | BPF_JA | BPF_X) ||
+	    insn->code =3D=3D (BPF_JMP32 | BPF_JA | BPF_X)) {
+		verbose(env,
+			"indirect jump at insn %u is in an exception cleanup landing pad\n",
+			i);
+		return -EINVAL;
+	}
+	/* A BPF_LD_[ABS|IND] can leave the frame through its epilogue. */
+	if (BPF_CLASS(insn->code) =3D=3D BPF_LD &&
+	    (BPF_MODE(insn->code) =3D=3D BPF_ABS || BPF_MODE(insn->code) =3D=3D=
 BPF_IND)) {
+		verbose(env,
+			"BPF_LD_[ABS|IND] at insn %u is in an exception cleanup landing pad\n=
",
+			i);
+		return -EINVAL;
+	}
+	if (is_stack_arg_st(insn) || is_stack_arg_stx(insn)) {
+		verbose(env,
+			"insn %u stages an on-stack call argument in an exception cleanup lan=
ding pad\n",
+			i);
+		return -EINVAL;
+	}
+	if (bpf_pseudo_kfunc_call(insn)) {
+		struct bpf_call_summary cs;
+
+		if (bpf_get_call_summary(env, insn, &cs) &&
+		    cs.arg_slot_cnt > MAX_BPF_FUNC_REG_ARGS) {
+			verbose(env,
+				"insn %u calls a kfunc with an on-stack argument in an exception cle=
anup landing pad\n",
+				i);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn)
 {
 	return bpf_pseudo_kfunc_call(insn) && insn->off =3D=3D 0 &&
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index b96b2c429e22..0872a3f70583 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -5,9 +5,12 @@
=20
 #include <linux/types.h>
=20
+struct bpf_insn;
 struct bpf_verifier_env;
=20
 int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env);
+int bpf_exc_check_insn(struct bpf_verifier_env *env, struct bpf_insn *in=
sn);
+int bpf_exc_check_callback(struct bpf_verifier_env *env, int subprog);
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
=20
 #endif /* _LINUX_BPF_EXCEPTION_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fed5b66ed3b7..53a737c88dcc 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -252,6 +252,7 @@ static void adjust_insn_aux_data(struct bpf_verifier_=
env *env,
 		/* Expand insni[off]'s seen count to the patched range. */
 		data[i].seen =3D old_seen;
 		data[i].zext_dst =3D bpf_insn_def32(new_prog, insn + i) >=3D 0;
+		data[i].in_cleanup_pad =3D data[off + cnt - 1].in_cleanup_pad;
 		if (!memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
 			data[i].non_stack_access =3D
 				data[off + cnt - 1].non_stack_access;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53edce3d64ea..7b74dd9b9f48 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10549,6 +10549,10 @@ static int push_callback_call(struct bpf_verifie=
r_env *env, struct bpf_insn *ins
 	 * callbacks
 	 */
 	env->subprog_info[subprog].is_cb =3D true;
+	err =3D bpf_exc_check_callback(env, subprog);
+	if (err)
+		return err;
+
 	if (bpf_pseudo_kfunc_call(insn) &&
 	    !is_callback_calling_kfunc(insn->imm)) {
 		verifier_bug(env, "kfunc %s#%d not marked as callback-calling",
@@ -19041,6 +19045,12 @@ static int do_check(struct bpf_verifier_env *env=
)
 				return err;
 		}
=20
+		if (unlikely(env->cleanup_info_cnt)) {
+			err =3D bpf_exc_check_insn(env, insn);
+			if (err)
+				return err;
+		}
+
 		sanitize_mark_insn_seen(env);
 		prev_insn_idx =3D env->insn_idx;
=20
--=20
2.53.0-Meta

