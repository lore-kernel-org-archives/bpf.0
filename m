Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330359;
	b=w7fcrRxdqQM+uOqrMkPFnHCxfFHlfA6ztC3mfC+AUYjvsV6d3bMdjpVNNid03cDeH1Be
	 RGFaT5ArmGb5ucC715A5TtyoRa3rPng9NDd9DS8xBhDr9voXe2QIK+dOi04Oqm+S1tvwz
	 HHVzu8gAUtKnGHt6jhUUaM4mYoP7QF4rroMapigXc+oCUbOIOL4lCur4uxWfWxT1aCyeS
	 FxYVooN15a90onms6cQ7WIjtzS4REkAitZd2yrbtByjjhVL0C2jJJuLhLT1zJphdbFLa0
	 vzG7bUaeuMKM9+cO+JxkXNhOPkr8Ur45dJnrSiHkyHCHzYUg5QxdFxvBTbREVBeog/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330359;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=cOkyLY+HHPV792y3EULbkq0WHoTNtx8PyIwoa+v2U74=;
	b=AIFb6RYwpcEXKH9u0cxaT+5eKzJ0IyjtMml/u+F4ok/GM375P0BDCdUcQKOPTwO5aj8H
	 o5OxqvMedpWniTTnhb2V3A5dcbd7SE1qmL58nM0R17+KP9KWwP+PZgM5zoDbCH5urwc+C
	 gbZgfcLH8LG3VNGhF+go2upaUnTLiiaCKKFEl2fXCYCaC5k2Y/2J6L7nBKjrHOG6hYLWL
	 +EkXSdBd2JulvdoyaShY8TLVA5UV3Kw2NoOcDer8KQaSE49jrB0w5uMGzjbI51yy176nN
	 tf/e4jMtwE1X0EC1X+uC6jqLx2/Ej5rOItLU6TOvoewWt0HebpwBs8v6t/FXy+TMxfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxjiym76;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1B606A31C;
	Tue, 10 Nov 2026 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxjiym76
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3281F0089F;
	Tue, 10 Nov 2026 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330358;
	bh=cOkyLY+HHPV792y3EULbkq0WHoTNtx8PyIwoa+v2U74=;
	h=Date:From:To:Cc:Subject;
	b=fxjiym76NZPxB+OK3srSzHcS/w9hTBnDIqw69BGPquQuc++VR6MUJbq1P6BTnH9BF
	 3sYBN+RkXBNfXruFd43woqJXD59wgT+iLpi8+b0JZ53nuUpoTwOoXW2JYBGCu8cF/N
	 r3l7v6D5DoAFgS7TSJ6g/kX/a36sad8O2xsf8gm2JgxPlvaqfGL6h/J4ktB400r07t
	 1YTeYRcV+4ttwdqrIxkeXEafTNA0EzOYZQCR7SmKgxMmoJdYXKNM0YiponDWH4bd26
	 qQXPsMx5w5jCcBFSR9BH7QV9s2Jn0sdzsVFjS4l+1sj8O0HV3PLBdR7mYFGJh+SGNB
	 6ALkQSZKuWXHg==
Date: Tue, 10 Nov 2026 17:05:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Kees Cook <kees@kernel.org>, Kees Cook <kees+treewide@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the origin tree
Message-ID: <avNO8cuAdnwv9D_5@sirena.org.uk>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L/Ic/TP4yfNtWQry"
Content-Disposition: inline


--L/Ic/TP4yfNtWQry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/cfg.c

between commit:

  0af298e62e5cf ("treewide: refresh kmalloc_obj() conversions")

=66rom the origin tree and commit:

  6771f70a47332 ("bpf: Remove is_state_visited(), bpf_compute_scc() and ite=
r.depth")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined kernel/bpf/cfg.c
index 1b04538351a1f,bbcf42eae9d92..0000000000000
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@@ -75,21 -75,28 +75,28 @@@ static void mark_subprog_might_throw(st
  	subprog->might_throw =3D true;
  }
 =20
- /* 't' is an index of a call-site.
+ /*
+  * 't' is an index of a call-site.
   * 'w' is a callee entry point.
   * Eventually this function would be called when env->cfg.insn_state[w] =
=3D=3D EXPLORED.
-  * Rely on DFS traversal order and absence of recursive calls to guarante=
e that
-  * callee's effect marks would be correct at that moment.
+  * DFS traversal order guarantees that callee's effect marks are correct =
at that
+  * moment, unless the callee calls one of its callers: see close_callee_e=
ffects().
+  * Returns true if the marks of the caller changed.
   */
- static void merge_callee_effects(struct bpf_verifier_env *env, int t, int=
 w)
+ static bool merge_callee_effects(struct bpf_verifier_env *env, int t, int=
 w)
  {
  	struct bpf_subprog_info *caller, *callee;
 =20
  	caller =3D bpf_find_containing_subprog(env, t);
  	callee =3D bpf_find_containing_subprog(env, w);
+ 	if (caller->changes_pkt_data >=3D callee->changes_pkt_data &&
+ 	    caller->might_sleep >=3D callee->might_sleep &&
+ 	    caller->might_throw >=3D callee->might_throw)
+ 		return false;
  	caller->changes_pkt_data |=3D callee->changes_pkt_data;
  	caller->might_sleep |=3D callee->might_sleep;
  	caller->might_throw |=3D callee->might_throw;
+ 	return true;
  }
 =20
  enum {
@@@ -123,12 -130,8 +130,8 @@@ static int push_insn(int t, int w, int=20
  		return -EINVAL;
  	}
 =20
- 	if (e =3D=3D BRANCH) {
- 		/* mark branch target for state pruning */
- 		mark_prune_point(env, w);
- 		mark_jmp_point(env, w);
+ 	if (e =3D=3D BRANCH)
  		mark_jump_target(env, w);
- 	}
 =20
  	if (insn_state[w] =3D=3D 0) {
  		/* tree-edge */
@@@ -172,13 -175,8 +175,8 @@@ static int visit_func_call_insn(int t,=20
  	if (ret)
  		return ret;
 =20
- 	mark_prune_point(env, t + insn_sz);
- 	/* when we exit from subprog, we need to record non-linear history */
- 	mark_jmp_point(env, t + insn_sz);
-=20
  	if (visit_callee) {
  		w =3D t + insns[t].imm + 1;
- 		mark_prune_point(env, t);
  		merge_callee_effects(env, t, w);
  		ret =3D push_insn(t, w, BRANCH, env);
  	}
@@@ -439,14 -437,12 +437,12 @@@ static int visit_gotox_insn(int t, stru
  		return -E2BIG;
  	}
 =20
- 	mark_prune_point(env, t);
  	for (i =3D 0; i < jt->cnt; i++) {
  		w =3D jt->items[i];
  		if (verifier_bug_if(w < 0 || w >=3D env->prog->len, env,
  				    "indirect jump from insn %d to %d out of range", t, w))
  			return -EFAULT;
 =20
- 		mark_jmp_point(env, w);
  		mark_jump_target(env, w);
 =20
  		/* EXPLORED || DISCOVERED */
@@@ -521,19 -517,43 +517,43 @@@ static int visit_func_ptrs_insn(int t,=20
  	}
 =20
  	/* all functions are explored, their effects are known */
- 	mark_prune_point(env, t);
  	for (i =3D 0; i < cnt; i++) {
  		w =3D ptrs[i].xlated_off;
  		merge_callee_effects(env, t, w);
 =20
- 		/* the same marks as push_insn() leaves on a branch target */
- 		mark_prune_point(env, w);
- 		mark_jmp_point(env, w);
+ 		/* the same mark as push_insn() leaves on a branch target */
  		mark_jump_target(env, w);
  	}
  	return DONE_EXPLORING;
  }
 =20
+ /*
+  * A subprog that calls one of its callers is EXPLORED before that caller=
 is: it
+  * took the marks that the caller had so far, and so did everybody who ca=
lled it
+  * since. Merge again at every call until nothing changes.
+  */
+ static void close_callee_effects(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_insn *insn =3D env->prog->insnsi;
+ 	struct bpf_func_ptr *ptrs;
+ 	bool changed;
+ 	u32 cnt, j;
+ 	int t;
+=20
+ 	do {
+ 		changed =3D false;
+ 		for (t =3D 0; t < env->prog->len; t++) {
+ 			if (bpf_pseudo_call(&insn[t]) || bpf_pseudo_func(&insn[t]))
+ 				changed |=3D merge_callee_effects(env, t, t + insn[t].imm + 1);
+ 			ptrs =3D insn_func_ptrs(env, t, &cnt);
+ 			for (j =3D 0; j < cnt; j++)
+ 				changed |=3D merge_callee_effects(env, t, ptrs[j].xlated_off);
+ 			if (bpf_is_ldimm64(&insn[t]))
+ 				t++;
+ 		}
+ 	} while (changed);
+ }
+=20
  /* Visits the instruction at index t and returns one of the following:
   *  < 0 - an error occurred
   *  DONE_EXPLORING - the instruction was fully explored
@@@ -565,28 -585,13 +585,13 @@@ static int visit_insn(int t, struct bpf
  		return DONE_EXPLORING;
 =20
  	case BPF_CALL:
- 		if (bpf_is_async_callback_calling_insn(insn))
- 			/* Mark this call insn as a prune point to trigger
- 			 * is_state_visited() check before call itself is
- 			 * processed by __check_func_call(). Otherwise new
- 			 * async state will be pushed for further exploration.
- 			 */
- 			mark_prune_point(env, t);
  		/* For functions that invoke callbacks it is not known how many times
  		 * callback would be called. Verifier models callback calling functions
  		 * by repeatedly visiting callback bodies and returning to origin call
  		 * instruction.
- 		 * In order to stop such iteration verifier needs to identify when a
- 		 * state identical some state from a previous iteration is reached.
- 		 * Check below forces creation of checkpoint before callback calling
- 		 * instruction to allow search for such identical states.
  		 */
- 		if (bpf_is_sync_callback_calling_insn(insn)) {
+ 		if (bpf_is_sync_callback_calling_insn(insn))
  			mark_calls_callback(env, t);
- 			mark_force_checkpoint(env, t);
- 			mark_prune_point(env, t);
- 			mark_jmp_point(env, t);
- 		}
  		if (bpf_helper_call(insn)) {
  			const struct bpf_func_proto *fp;
 =20
@@@ -606,21 -611,6 +611,6 @@@
  			struct bpf_call_arg_meta meta;
 =20
  			ret =3D bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
- 			if (ret =3D=3D 0 && bpf_is_iter_next_kfunc(&meta)) {
- 				mark_prune_point(env, t);
- 				/* Checking and saving state checkpoints at iter_next() call
- 				 * is crucial for fast convergence of open-coded iterator loop
- 				 * logic, so we need to force it. If we don't do that,
- 				 * is_state_visited() might skip saving a checkpoint, causing
- 				 * unnecessarily long sequence of not checkpointed
- 				 * instructions and jumps, leading to exhaustion of jump
- 				 * history buffer, and potentially other undesired outcomes.
- 				 * It is expected that with correct open-coded iterators
- 				 * convergence will happen quickly, so we don't run a risk of
- 				 * exhausting memory.
- 				 */
- 				mark_force_checkpoint(env, t);
- 			}
  			/* Same as helpers, if called in a non-sleepable context
  			 * program will be rejected anyway, so we should end up
  			 * with precise sleepable marks on subprogs, except for
@@@ -649,18 -639,12 +639,12 @@@
  		if (ret)
  			return ret;
 =20
- 		mark_prune_point(env, t + off + 1);
- 		mark_jmp_point(env, t + off + 1);
  		mark_jump_target(env, t + off + 1);
 =20
  		return ret;
 =20
  	default:
  		/* conditional jump with two edges */
- 		mark_prune_point(env, t);
- 		if (bpf_is_may_goto_insn(insn))
- 			mark_force_checkpoint(env, t);
-=20
  		ret =3D push_insn(t, t + 1, FALLTHROUGH, env);
  		if (ret)
  			return ret;
@@@ -759,6 -743,7 +743,7 @@@ walk_cfg
  		}
  	}
  	ret =3D 0; /* cfg looks good */
+ 	close_callee_effects(env);
  	env->prog->aux->changes_pkt_data =3D env->subprog_info[0].changes_pkt_da=
ta;
  	env->prog->aux->might_sleep =3D env->subprog_info[0].might_sleep;
 =20
@@@ -833,201 -818,3 +818,3 @@@ int bpf_compute_postorder(struct bpf_ve
  	kvfree(state);
  	return 0;
  }
-=20
- /*
-  * Compute strongly connected components (SCCs) on the CFG.
-  * Assign an SCC number to each instruction, recorded in env->insn_aux[*]=
=2Escc.
-  * If instruction is a sole member of its SCC and there are no self edges,
-  * assign it SCC number of zero.
-  * Uses a non-recursive adaptation of Tarjan's algorithm for SCC computat=
ion.
-  */
- int bpf_compute_scc(struct bpf_verifier_env *env)
- {
- 	const u32 NOT_ON_STACK =3D U32_MAX;
-=20
- 	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
- 	const u32 insn_cnt =3D env->prog->len;
- 	int stack_sz, dfs_sz, err =3D 0;
- 	u32 *stack, *pre, *low, *dfs, *dfs_pos;
- 	u32 i, j, t, w;
- 	u32 next_preorder_num;
- 	u32 next_scc_id;
- 	bool assign_scc;
- 	struct bpf_iarray *succ;
-=20
- 	next_preorder_num =3D 1;
- 	next_scc_id =3D 1;
- 	/*
- 	 * - 'stack' accumulates vertices in DFS order, see invariant comment be=
low;
- 	 * - 'pre[t] =3D=3D p' =3D> preorder number of vertex 't' is 'p';
- 	 * - 'low[t] =3D=3D n' =3D> smallest preorder number of the vertex reach=
able from 't' is 'n';
- 	 * - 'dfs' DFS traversal stack, used to emulate explicit recursion;
- 	 * - 'dfs_pos[k] =3D=3D j' =3D> the frame 'dfs[k]' resumes visiting its
- 	 *   successors at index 'j'.
- 	 */
- 	stack =3D kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
- 	pre =3D kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
- 	low =3D kvcalloc(insn_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
- 	dfs =3D kvzalloc_objs(*dfs, insn_cnt, GFP_KERNEL_ACCOUNT);
- 	dfs_pos =3D kvzalloc_objs(*dfs_pos, insn_cnt, GFP_KERNEL_ACCOUNT);
- 	if (!stack || !pre || !low || !dfs || !dfs_pos) {
- 		err =3D -ENOMEM;
- 		goto exit;
- 	}
- 	/*
- 	 * References:
- 	 * [1] R. Tarjan "Depth-First Search and Linear Graph Algorithms"
- 	 * [2] D. J. Pearce "A Space-Efficient Algorithm for Finding Strongly Co=
nnected Components"
- 	 *
- 	 * The algorithm maintains the following invariant:
- 	 * - suppose there is a path 'u' ~> 'v', such that 'pre[v] < pre[u]';
- 	 * - then, vertex 'u' remains on stack while vertex 'v' is on stack.
- 	 *
- 	 * Consequently:
- 	 * - If 'low[v] < pre[v]', there is a path from 'v' to some vertex 'u',
- 	 *   such that 'pre[u] =3D=3D low[v]'; vertex 'u' is currently on the st=
ack,
- 	 *   and thus there is an SCC (loop) containing both 'u' and 'v'.
- 	 * - If 'low[v] =3D=3D pre[v]', loops containing 'v' have been explored,
- 	 *   and 'v' can be considered the root of some SCC.
- 	 *
- 	 * Here is a pseudo-code for an explicitly recursive version of the algo=
rithm:
- 	 *
- 	 *    NOT_ON_STACK =3D insn_cnt + 1
- 	 *    pre =3D [0] * insn_cnt
- 	 *    low =3D [0] * insn_cnt
- 	 *    scc =3D [0] * insn_cnt
- 	 *    stack =3D []
- 	 *
- 	 *    next_preorder_num =3D 1
- 	 *    next_scc_id =3D 1
- 	 *
- 	 *    def recur(w):
- 	 *        nonlocal next_preorder_num
- 	 *        nonlocal next_scc_id
- 	 *
- 	 *        pre[w] =3D next_preorder_num
- 	 *        low[w] =3D next_preorder_num
- 	 *        next_preorder_num +=3D 1
- 	 *        stack.append(w)
- 	 *        for s in successors(w):
- 	 *            # Note: for classic algorithm the block below should look =
as:
- 	 *            #
- 	 *            # if pre[s] =3D=3D 0:
- 	 *            #     recur(s)
- 	 *            #     low[w] =3D min(low[w], low[s])
- 	 *            # elif low[s] !=3D NOT_ON_STACK:
- 	 *            #     low[w] =3D min(low[w], pre[s])
- 	 *            #
- 	 *            # But replacing both 'min' instructions with 'low[w] =3D m=
in(low[w], low[s])'
- 	 *            # does not break the invariant and makes iterative version=
 of the algorithm
- 	 *            # simpler. See 'Algorithm #3' from [2].
- 	 *
- 	 *            # 's' not yet visited
- 	 *            if pre[s] =3D=3D 0:
- 	 *                recur(s)
- 	 *            # if 's' is on stack, pick lowest reachable preorder numbe=
r from it;
- 	 *            # if 's' is not on stack 'low[s] =3D=3D NOT_ON_STACK > low=
[w]',
- 	 *            # so 'min' would be a noop.
- 	 *            low[w] =3D min(low[w], low[s])
- 	 *
- 	 *        if low[w] =3D=3D pre[w]:
- 	 *            # 'w' is the root of an SCC, pop all vertices
- 	 *            # below 'w' on stack and assign same SCC to them.
- 	 *            while True:
- 	 *                t =3D stack.pop()
- 	 *                low[t] =3D NOT_ON_STACK
- 	 *                scc[t] =3D next_scc_id
- 	 *                if t =3D=3D w:
- 	 *                    break
- 	 *            next_scc_id +=3D 1
- 	 *
- 	 *    for i in range(0, insn_cnt):
- 	 *        if pre[i] =3D=3D 0:
- 	 *            recur(i)
- 	 *
- 	 * Below implementation replaces explicit recursion with array 'dfs'.
- 	 */
- 	for (i =3D 0; i < insn_cnt; i++) {
- 		if (pre[i])
- 			continue;
- 		stack_sz =3D 0;
- 		dfs_sz =3D 1;
- 		dfs[0] =3D i;
- 		dfs_pos[0] =3D 0;
- dfs_continue:
- 		while (dfs_sz) {
- 			w =3D dfs[dfs_sz - 1];
- 			if (pre[w] =3D=3D 0) {
- 				low[w] =3D next_preorder_num;
- 				pre[w] =3D next_preorder_num;
- 				next_preorder_num++;
- 				stack[stack_sz++] =3D w;
- 			}
- 			/* Visit remaining 'w' successors */
- 			succ =3D bpf_insn_successors(env, w);
- 			for (j =3D dfs_pos[dfs_sz - 1]; j < succ->cnt; ++j) {
- 				if (pre[succ->items[j]]) {
- 					low[w] =3D min(low[w], low[succ->items[j]]);
- 				} else {
- 					/*
- 					 * Once DFS for succ->items[j] is complete,
- 					 * pre[succ->items[j]] is non-zero, hence
- 					 * resuming at 'j' allows to follow the
- 					 * low[w] =3D min(...) update branch above.
- 					 */
- 					dfs_pos[dfs_sz - 1] =3D j;
- 					dfs_pos[dfs_sz] =3D 0;
- 					dfs[dfs_sz] =3D succ->items[j];
- 					dfs_sz++;
- 					goto dfs_continue;
- 				}
- 			}
- 			/*
- 			 * Preserve the invariant: if some vertex above in the stack
- 			 * is reachable from 'w', keep 'w' on the stack.
- 			 */
- 			if (low[w] < pre[w]) {
- 				dfs_sz--;
- 				goto dfs_continue;
- 			}
- 			/*
- 			 * Assign SCC number only if component has two or more elements,
- 			 * or if component has a self reference, or if instruction is a
- 			 * callback calling function (implicit loop).
- 			 */
- 			assign_scc =3D stack[stack_sz - 1] !=3D w;	/* two or more elements? */
- 			for (j =3D 0; j < succ->cnt; ++j) {	/* self reference? */
- 				if (succ->items[j] =3D=3D w) {
- 					assign_scc =3D true;
- 					break;
- 				}
- 			}
- 			if (bpf_calls_callback(env, w)) /* implicit loop? */
- 				assign_scc =3D true;
- 			/* Pop component elements from stack */
- 			do {
- 				t =3D stack[--stack_sz];
- 				low[t] =3D NOT_ON_STACK;
- 				if (assign_scc)
- 					aux[t].scc =3D next_scc_id;
- 			} while (t !=3D w);
- 			if (assign_scc)
- 				next_scc_id++;
- 			dfs_sz--;
- 		}
- 	}
- 	env->scc_info =3D kvzalloc_objs(*env->scc_info, next_scc_id,
- 				      GFP_KERNEL_ACCOUNT);
- 	if (!env->scc_info) {
- 		err =3D -ENOMEM;
- 		goto exit;
- 	}
- 	env->scc_cnt =3D next_scc_id;
- exit:
- 	kvfree(stack);
- 	kvfree(pre);
- 	kvfree(low);
- 	kvfree(dfs);
- 	kvfree(dfs_pos);
- 	return err;
- }

--L/Ic/TP4yfNtWQry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrzTvEACgkQJNaLcl1U
h9BfYQf/YA8V7NBSbRzM9lidQpHtF1mN3KNcVG405b2VuAe3RO/HrF5i5Im9FqcU
5pRrtmK2Ed8EcZxOd5t6a/2GA4A9mFvUVWW+rHCmr4uvcNYNB9gDjrDylzpp683A
mhHQMp9Y96D1T4AYs5hWyC447qfMpLWtxVychkpGLHaweIVqa4IWtaxg5vUgoPob
XoNK+YGkH3/TIiZ4oX48ET5oLhi/hQ9TnULOG6JYwsG2aHGLdDgY7WU64RSJIr14
P5RAPTBQxz9Pt4upECv2LckTFoCkW1mFU9Or6qC1st1Ht1HkO5YQ1so4g3FW1gRV
OxwvexG5veU27i2AQ2sY1fca9Szf4Q==
=Z056
-----END PGP SIGNATURE-----

--L/Ic/TP4yfNtWQry--
