Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67903B14AA
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205561; cv=none; b=udVAmhkurBSJzeCycM9P4NLXo5Q4JWQryysptwxZeXs2sCw9oO4P+6eZNOk/6dG23AG/8EDyCVNSFO8bAn7RU+dYIUC4IzzpOsWry8Hva+c97VTim9UIoJMUWQUrxJUrlJk//Eya4hRGg4S6YqQGfVYGdJ4WovDyc+l+KJsTayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205561; c=relaxed/simple;
	bh=TFnUOA77dNWjhypV9w1n/cU0B5lCpmPxaM51hBmIGes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOT2Q+xhl30r46AfudByRpWSHnEBwkL7uhg9VATgJI4cZALx/bVPPGtdubbU0VwWzcBAB49TKiLxkmDJ7yc7Ngi4OoDdlpM/ChEzoSuGS36CciirjeUW3LgwEP39eY/Lsr1GIXGamIQy1RQYtv4EOPlULZK74ft7RpMxwne60YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CD83631B3B003A; Fri, 16 Oct 2026 19:52:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v12 12/25] bpf: Allow a subprog to end with a call that does not return
Date: Fri, 16 Oct 2026 19:52:32 -0700
Message-ID: <20261017025232.1925266-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017025129.1914859-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A compiler emits nothing after a call it knows does not return: a cleanup
pad's call to _Unwind_Resume, which libbpf resolves to bpf_unwind_resume(=
),
or a call to a Rust function that returns `!` because it unwinds. Built
with panic=3Dunwind, rustc gives for example

        fail:
                call bpf_unwind
        L0:     goto L0
        check:
                if w1 > 0x7 goto L0
                w0 =3D w1
                exit
        L0:     call fail
        prog:
                ...
                r1 =3D r6
                call _Unwind_Resume

and check_subprogs() refuses prog() and check(): "last insn is not an exi=
t
or jmp".

Let check_subprogs() accept a final call that never returns: to
bpf_unwind() or bpf_unwind_resume(), or to a static subprog with neither
an exit insn nor the hidden exit of a tail call or of a
BPF_LD_[ABS|IND]. Any other final call is still refused, including one
to a global subprog, which do_check() takes to return.
bpf_unwind_resume() is lowered to 'r0 =3D 0; exit' as before.

Then, as keep_subprog_exits() does for a subprog with no exit, put an
exit after each such call before the CFG walk. From then on the call
simply falls through to an exit, so liveness, backtracking, fastcall and
prepare_func_exit() need not know about it, and do_check() never reaches
the exit. For a subprog that can unwind, keep_subprog_exits() keeps it
as the epilogue the walk can send the frame to.

add_exits_after_final_calls() runs after add_kfuncs(), once insn array
maps and the function pointers in read-only maps have recorded the insn
offsets the patch adjusts, and before an offloaded program's per-insn
state is set up. It also adjusts the call's own offset to a callee after
it and the exit_idx of each later subprog. explored_states is sized by
the program length, so it is now allocated after the exits are put in.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 113 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 85542afcc369..804a6835c56f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3317,6 +3317,54 @@ static void find_subprog_properties(struct bpf_ver=
ifier_env *env)
 	}
 }
=20
+static int subprog_falls_through(struct bpf_verifier_env *env, int subpr=
og, int idx)
+{
+	verbose(env, "last insn is not an exit or jmp\n");
+	bpf_diag_program_structure(
+		env, idx, "subprogram can fall through",
+		"End each subprogram with an exit or an explicit jump that keeps contr=
ol flow inside the subprogram.",
+		"Subprogram %d reaches its last instruction %d without an exit or jump=
, so control could continue into the next subprogram.",
+		subprog, idx);
+	return -EINVAL;
+}
+
+/*
+ * Put an exit after a call that ends a subprog, so that nothing from th=
e CFG
+ * walk on has to know a subprog can end that way. check_subprogs() only=
 lets
+ * such a call be to a callee that never returns, so do_check() never re=
aches
+ * the exit.
+ */
+static int add_exits_after_final_calls(struct bpf_verifier_env *env)
+{
+	struct bpf_insn patch[2] =3D { {}, BPF_EXIT_INSN() };
+	struct bpf_prog *new_prog;
+	int i, j;
+
+	for (i =3D 0; i < env->subprog_cnt; i++) {
+		int last =3D env->subprog_info[i + 1].start - 1;
+		struct bpf_insn *insn =3D &env->prog->insnsi[last];
+
+		if (!bpf_pseudo_call(insn) && !bpf_pseudo_kfunc_call(insn))
+			continue;
+		patch[0] =3D *insn;
+		new_prog =3D bpf_patch_insn_data(env, last, patch, 2);
+		if (!new_prog)
+			return -ENOMEM;
+		env->prog =3D new_prog;
+		/* The patch moved the call's aux data, orig_idx included, to the exit=
. */
+		env->insn_aux_data[last].orig_idx =3D env->insn_aux_data[last + 1].ori=
g_idx;
+		/* The patch does not adjust the call itself for a callee after it. */
+		insn =3D &new_prog->insnsi[last];
+		if (bpf_pseudo_call(insn) && insn->imm >=3D 0)
+			insn->imm++;
+		/* Nor does it move the exits check_subprogs() found after it. */
+		for (j =3D i + 1; j < env->subprog_cnt; j++)
+			if (env->subprog_info[j].exit_idx !=3D U32_MAX)
+				env->subprog_info[j].exit_idx++;
+	}
+	return 0;
+}
+
 static int check_subprogs(struct bpf_verifier_env *env)
 {
 	int i, subprog_start, subprog_end, off, cur_subprog =3D 0;
@@ -3356,26 +3404,44 @@ static int check_subprogs(struct bpf_verifier_env=
 *env)
 			/*
 			 * To avoid fall-through from one subprog into another,
 			 * the last insn of the subprog should be either exit
-			 * or unconditional jump back or bpf_throw call.
+			 * or unconditional jump back or a call that does not
+			 * return, checked below.
 			 */
 			if (code !=3D (BPF_JMP | BPF_EXIT) &&
 			    code !=3D (BPF_JMP32 | BPF_JA) &&
 			    code !=3D (BPF_JMP | BPF_JA) &&
-			    !insn_is_gotox(&insn[i])) {
-				verbose(env, "last insn is not an exit or jmp\n");
-				bpf_diag_program_structure(
-					env, i, "subprogram can fall through",
-					"End each subprogram with an exit or an explicit jump that keeps co=
ntrol flow inside the subprogram.",
-					"Subprogram %d reaches its last instruction %d without an exit or j=
ump, so control could continue into the next subprogram.",
-					cur_subprog, i);
-				return -EINVAL;
-			}
+			    !insn_is_gotox(&insn[i]) &&
+			    !bpf_pseudo_call(&insn[i]) &&
+			    !bpf_pseudo_kfunc_call(&insn[i]))
+				return subprog_falls_through(env, cur_subprog, i);
 			subprog_start =3D subprog_end;
 			cur_subprog++;
 			if (cur_subprog < env->subprog_cnt)
 				subprog_end =3D subprog[cur_subprog + 1].start;
 		}
 	}
+
+	/*
+	 * A compiler ends a subprog with a call only if the callee never
+	 * returns. Refuse any other final call.
+	 */
+	for (i =3D 0; i < env->subprog_cnt; i++) {
+		int last =3D subprog[i + 1].start - 1, callee;
+
+		if (bpf_pseudo_kfunc_call(&insn[last])) {
+			if (!bpf_is_unwind_kfunc(&insn[last]) &&
+			    !bpf_is_unwind_resume_kfunc(&insn[last]))
+				return subprog_falls_through(env, i, last);
+			continue;
+		}
+		if (!bpf_pseudo_call(&insn[last]))
+			continue;
+		callee =3D bpf_find_subprog(env, last + insn[last].imm + 1);
+		if (bpf_subprog_is_global(env, callee) ||
+		    subprog[callee].exit_idx !=3D U32_MAX ||
+		    subprog[callee].has_tail_call || subprog[callee].has_ld_abs)
+			return subprog_falls_through(env, i, last);
+	}
 	return 0;
 }
=20
@@ -23602,15 +23668,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
 	env->test_reg_invariants =3D attr->prog_flags & BPF_F_TEST_REG_INVARIAN=
TS;
 	env->arena_scalar =3D attr->prog_flags & BPF_F_ARENA_SCALAR;
=20
-	env->explored_states =3D kvzalloc_objs(struct list_head,
-					     state_htab_size(env),
-					     GFP_KERNEL_ACCOUNT);
-	ret =3D -ENOMEM;
-	if (!env->explored_states)
-		goto skip_full_check;
-
-	for (i =3D 0; i < state_htab_size(env); i++)
-		INIT_LIST_HEAD(&env->explored_states[i]);
 	INIT_LIST_HEAD(&env->free_list);
=20
 	/* Prepare BTF and func_info needed to discover all subprograms. */
@@ -23661,6 +23718,24 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
=20
+	/*
+	 * After everything above has recorded insn offsets, so the patch
+	 * adjusts them, and before an offloaded program's per-insn state.
+	 */
+	ret =3D add_exits_after_final_calls(env);
+	if (ret < 0)
+		goto skip_full_check;
+
+	env->explored_states =3D kvzalloc_objs(struct list_head,
+					     state_htab_size(env),
+					     GFP_KERNEL_ACCOUNT);
+	ret =3D -ENOMEM;
+	if (!env->explored_states)
+		goto skip_full_check;
+
+	for (i =3D 0; i < state_htab_size(env); i++)
+		INIT_LIST_HEAD(&env->explored_states[i]);
+
 	if (bpf_prog_is_offloaded(env->prog->aux)) {
 		ret =3D bpf_prog_offload_verifier_prep(env->prog);
 		if (ret)
--=20
2.53.0-Meta

