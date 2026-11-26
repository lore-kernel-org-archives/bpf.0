Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704183;
	b=qABgfYNeLtzc2jQR/aE46Lavh5/B5BUgy4VsJp9UTrRBLB5grqpVoERIe4nxlmo//rhO
	 oAOb/5956y7qduv/Xc09lw9QyjeR5M3ezPgT0l7Z8r+dq6Bv+D+PeP2I4A7KdbdhA4WR4
	 zEMpL3o8cTuDn/+srjT33SqUNvtkX1RXaVuaFPJrBwZxDTv3mw/gMiJzeOYXNN7b+CEZJ
	 6wBKdUQ5KpWsRn52hY3I4Dzvkjl9VyueMCm560cCc4732kT7vgGcPVX5PCn6QN+K43g6Q
	 T0FS1zpx3IDzARQsUaO7vDhu7aHV+ymNO5rWerrE6WkEY/PX4T1CxwkCT68qfUQxmlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704183;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=CcGbGJ88j2wdE3cB00bWLmVuExdAsGR8UtThY1qAHWQ=;
	b=WIsPNxWomJ/ZJjb5py2H07O7ustDO5VUGlyUZ22z2BWdKYKJglfbQ2T+GqSPiUmuHL8Q
	 5dj+NEbGmBilP/1w4+hDJllS/9cnTHlTuTYTov2Mj6DhgGWxrZmwWdVd2zEEgz74HDF8f
	 3A2zsU53Fgn9nCOjwvI3qPb+gPdylSzvq7kqbTX+/l9K9IL8XIR26ONOQwuBqFzIFiGJT
	 O40dWhVK+N0yasib55APMhkDAWr7sguzW3dGWJ5yXSYVWrfnulBGKlXNmPbAVcKnek/dR
	 xDs9RecqiJS7C6F7EVCo9f4C9thfoTratpKsoukvcImlTbkgADnJksDWKsxaBFPealQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAJy03AW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BFB606A31C;
	Thu, 26 Nov 2026 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kAJy03AW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD7D1F000F4;
	Thu, 26 Nov 2026 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704182;
	bh=CcGbGJ88j2wdE3cB00bWLmVuExdAsGR8UtThY1qAHWQ=;
	h=Date:From:To:Cc:Subject;
	b=kAJy03AWQ5XlQ8RWzZkJhloOsDmg30QbXBX1+8pUXnNatF03y4tta2k6YPrwBdAZ+
	 wyXKLZbPmAquHCl5un2eac6iEivlwnb2VIM4QDOP/nbdN++7jDjXo7g1SvifprAlri
	 rBI0ANRamcoI1HQdiU9lO26f4gYSquMxj/EdAmfBC0CJ8ZPS+1Qf6ENbR7prXkf1ql
	 1TUxiBwI0EzdFoQBMmZv/Cj8beUC0TVCJZ2BXhThaB3YhEsmshIFoSYlNwXlvRRyhe
	 cpF7+OhwoQSS5HC9HNDSQ493FvcgDS/8gdO4EP83i+me+FCPNYW9HXKFgBw7mCs90R
	 2yNKucTFW57lQ==
Date: Thu, 26 Nov 2026 14:42:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <awhFcE3ojGLJv8V_@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="MGF565JeDia0oc80"
Content-Disposition: inline


--MGF565JeDia0oc80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/verifier.c

between commit:

  703826e497ffa ("bpf: Give the error of bpf_res_spin_lock() a 32-bit range=
")

=66rom the bpf tree and commit:

  8f58839c9ebbb ("bpf: Keep more of what is known about a number")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined kernel/bpf/verifier.c
index d4b31990fcb9c,e7013ed8cadd7..0000000000000
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@@ -18,6 -18,7 +18,7 @@@
  #include <linux/vmalloc.h>
  #include <linux/stringify.h>
  #include <linux/bsearch.h>
+ #include <linux/jhash.h>
  #include <linux/sort.h>
  #include <linux/perf_event.h>
  #include <linux/ctype.h>
@@@ -28,6 -29,7 +29,7 @@@
  #include <linux/keyctl.h>
  #include <linux/btf_ids.h>
  #include <linux/poison.h>
+ #include <linux/random.h>
  #include <linux/module.h>
  #include <linux/cpumask.h>
  #include <linux/cnum.h>
@@@ -62,19 -64,16 +64,16 @@@ static bool bpf_global_percpu_ma_set
 =20
  /* bpf_check() is a static code analyzer that walks eBPF program
   * instruction by instruction and updates register/stack state.
-  * All paths of conditional branches are analyzed until 'bpf_exit' insn.
   *
-  * The first pass is depth-first-search to check that the program is a DA=
G.
+  * The first pass is depth-first-search over the control flow graph.
   * It rejects the following programs:
-  * - larger than BPF_MAXINSNS insns
-  * - if loop is present (detected via back-edge)
+  * - if loop is present (detected via back-edge) and the program is unpri=
vileged
   * - unreachable insns exist (shouldn't be a forest. program =3D one func=
tion)
   * - out of bounds or malformed jumps
-  * The second pass is all possible path descent from the 1st insn.
-  * Since it's analyzing all paths through the program, the length of the
-  * analysis is limited to 64k insn, which may be hit even if total number=
 of
-  * insn is less then 4K, but there are too many branches that change stac=
k/regs.
-  * Number of 'branches to be analyzed' is limited to 1k
+  * The second pass goes from basic block to basic block, starting at the =
1st
+  * insn. States that meet at the start of a block are joined, so the leng=
th of
+  * the analysis follows the size of the program and not the number of pat=
hs
+  * through it. See flow.c.
   *
   * On entry to each instruction, each register has a type, and the instru=
ction
   * changes the types of the registers depending on instruction semantics.
@@@ -185,7 -184,10 +184,10 @@@
   * reference remains at the end of the program, the verifier rejects it.
   */
 =20
- /* verifier_state + insn_idx are pushed to stack when branch is encounter=
ed */
+ /*
+  * verifier_state + insn_idx are pushed to stack when branch is encounter=
ed.
+  * It's emptied after every insn, see flow_drain().
+  */
  struct bpf_verifier_stack_elem {
  	/* verifier state is 'st'
  	 * before processing instruction 'insn_idx'
@@@ -194,22 -196,16 +196,16 @@@
  	struct bpf_verifier_state st;
  	int insn_idx;
  	int prev_insn_idx;
+ 	bool again;	/* see bpf_flow_deliver() */
  	struct bpf_verifier_stack_elem *next;
- 	/* length of verifier log at the time this state was pushed on stack */
- 	u32 log_pos;
- 	u64 diag_log_pos;
  };
 =20
- #define BPF_COMPLEXITY_LIMIT_JMP_SEQ	8192
- #define BPF_COMPLEXITY_LIMIT_STATES	64
-=20
  #define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
 =20
  #define BPF_PRIV_STACK_MIN_SIZE		64
 =20
  static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, =
int parent_id);
- static int __release_reference_nomark(struct bpf_verifier_state *state, i=
nt id);
- static int release_reference_nomark(struct bpf_verifier_env *env, int id);
+ static int release_reference_nomark(struct bpf_verifier_state *state, int=
 id);
  static int release_reference(struct bpf_verifier_env *env, int id);
  static int invalidate_reference(struct bpf_verifier_env *env, int id);
  static u32 reg_lifetime_id(struct bpf_verifier_env *env,
@@@ -224,8 -220,6 +220,6 @@@ static bool is_trusted_reg(struct bpf_v
  static inline bool in_sleepable_context(struct bpf_verifier_env *env);
  static bool in_rcu_callback(struct bpf_verifier_env *env);
  static const char *non_sleepable_context_description(struct bpf_verifier_=
env *env);
- static void scalar32_min_max_add(struct bpf_reg_state *dst_reg, struct bp=
f_reg_state *src_reg);
- static void scalar_min_max_add(struct bpf_reg_state *dst_reg, struct bpf_=
reg_state *src_reg);
 =20
  static void bpf_map_ptr_store(struct bpf_insn_aux_data *aux,
  			      struct bpf_map *map,
@@@ -303,11 -297,6 +297,6 @@@ static int arg_from_argno(argno_t a
  	return -1;
  }
 =20
- static int arg_idx_from_argno(argno_t a)
- {
- 	return arg_from_argno(a) - 1;
- }
-=20
  /* Normalize helper register numbers and kfunc argument numbers to ABI sl=
ots. */
  static u32 arg_slot_from_argno(argno_t a)
  {
@@@ -357,6 -346,11 +346,11 @@@ static void verbose_invalid_scalar(stru
  	verbose(env, " should have been in [%d, %d]\n", range.minval, range.maxv=
al);
  }
 =20
+ static bool offset_is_far(const struct bpf_reg_state *reg)
+ {
+ 	return reg_smin(reg) <=3D -BPF_MAX_VAR_OFF || reg_smax(reg) >=3D BPF_MAX=
_VAR_OFF;
+ }
+=20
  static bool reg_not_null(struct bpf_verifier_env *env, const struct bpf_r=
eg_state *reg)
  {
  	enum bpf_reg_type type;
@@@ -369,7 -363,7 +363,7 @@@
  	 * The types below guarantee a non-NULL base, an unbounded offset can
  	 * still wrap base + offset to zero.
  	 */
- 	if (reg_smin(reg) <=3D -BPF_MAX_VAR_OFF || reg_smax(reg) >=3D BPF_MAX_VA=
R_OFF)
+ 	if (offset_is_far(reg))
  		return false;
 =20
  	type =3D base_type(type);
@@@ -465,6 -459,7 +459,7 @@@ static int bpf_compute_subprog_ret_regs
  			return -EFAULT;
  		if (ret_regs_cnt(size) > 1) {
  			subprog_info(env, subprog)->ret_reg_pair =3D true;
+ 			subprog_aux(env, subprog)->ret_reg_pair =3D true;
  			env->prog->jit_required =3D 1;
  		}
  	}
@@@ -726,7 -721,7 +721,7 @@@ static void mark_dynptr_stack_regs(stru
  				   struct bpf_reg_state *sreg2,
  				   enum bpf_dynptr_type type, int parent_id)
  {
- 	int id =3D ++env->id_gen;
+ 	int id =3D bpf_new_id(env);
 =20
  	__mark_dynptr_reg(sreg1, type, true, id, parent_id);
  	__mark_dynptr_reg(sreg2, type, false, id, parent_id);
@@@ -736,7 -731,7 +731,7 @@@ static void mark_dynptr_cb_reg(struct b
  			       struct bpf_reg_state *reg,
  			       enum bpf_dynptr_type type)
  {
- 	__mark_dynptr_reg(reg, type, true, ++env->id_gen, 0);
+ 	__mark_dynptr_reg(reg, type, true, bpf_new_id(env), 0);
  }
 =20
  static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
@@@ -856,15 -851,12 +851,12 @@@ static int unmark_stack_slots_dynptr(st
  				      : reg->id);
  }
 =20
- static void __mark_reg_unknown(const struct bpf_verifier_env *env,
- 			       struct bpf_reg_state *reg);
-=20
  static void mark_reg_invalid(const struct bpf_verifier_env *env, struct b=
pf_reg_state *reg)
  {
  	if (!env->allow_ptr_leaks)
  		bpf_mark_reg_not_init(env, reg);
  	else
- 		__mark_reg_unknown(env, reg);
+ 		bpf_mark_reg_unknown(reg);
  }
 =20
  static int dynptr_ref_cnt(struct bpf_verifier_env *env, int v_parent_id)
@@@ -1037,6 -1029,16 +1029,16 @@@ static bool in_rcu_cs(struct bpf_verifi
 =20
  static bool is_kfunc_rcu_protected(struct bpf_call_arg_meta *meta);
 =20
+ /* The number of loops that the frames of @st below @frameno are in */
+ static u32 nr_loops_below(const struct bpf_verifier_state *st, u32 framen=
o)
+ {
+ 	u32 fr, nr =3D 0;
+=20
+ 	for (fr =3D 0; fr < frameno; fr++)
+ 		nr +=3D st->frame[fr]->loop_stack_cnt;
+ 	return nr;
+ }
+=20
  static int mark_stack_slots_iter(struct bpf_verifier_env *env,
  				 struct bpf_call_arg_meta *meta,
  				 struct bpf_reg_state *reg, int insn_idx,
@@@ -1069,7 -1071,7 +1071,7 @@@
  		st->iter.btf =3D btf;
  		st->iter.btf_id =3D btf_id;
  		st->iter.state =3D BPF_ITER_STATE_ACTIVE;
- 		st->iter.depth =3D 0;
+ 		st->iter.loops =3D nr_loops_below(env->cur_state, env->cur_state->curfr=
ame + 1);
 =20
  		for (j =3D 0; j < BPF_REG_SIZE; j++)
  			slot->slot_type[j] =3D STACK_ITER;
@@@ -1356,7 -1358,7 +1358,7 @@@ static bool is_stack_slot_special(cons
   * - STACK_POISON, which truly forbids access to the slot.
   * Regardless of allow_ptr_leaks setting (i.e., privileged or unprivileged
   * mode), we won't promote STACK_INVALID to STACK_MISC. In privileged cas=
e it is
-  * unnecessary as both are considered equivalent when loading data and pr=
uning,
+  * unnecessary as both are considered equivalent when loading data and co=
mparing states,
   * in case of unprivileged mode it will be incorrect to allow reads of in=
valid
   * slots.
   */
@@@ -1420,7 -1422,7 +1422,7 @@@ static void *realloc_array(void *arr, s
  		goto out;
 =20
  	alloc_size =3D kmalloc_size_roundup(size_mul(new_n, size));
- 	new_arr =3D krealloc(arr, alloc_size, GFP_KERNEL_ACCOUNT);
+ 	new_arr =3D krealloc(arr, alloc_size, BPF_VERIFIER_GFP);
  	if (!new_arr) {
  		kfree(arr);
  		return NULL;
@@@ -1437,17 -1439,11 +1439,11 @@@ out
  static int copy_reference_state(struct bpf_verifier_state *dst, const str=
uct bpf_verifier_state *src)
  {
  	dst->refs =3D copy_array(dst->refs, src->refs, src->acquired_refs,
- 			       sizeof(struct bpf_reference_state), GFP_KERNEL_ACCOUNT);
+ 			       sizeof(struct bpf_reference_state), BPF_VERIFIER_GFP);
  	if (!dst->refs)
  		return -ENOMEM;
 =20
- 	dst->acquired_refs =3D src->acquired_refs;
- 	dst->active_locks =3D src->active_locks;
- 	dst->active_preempt_locks =3D src->active_preempt_locks;
- 	dst->active_rcu_locks =3D src->active_rcu_locks;
- 	dst->active_irq_id =3D src->active_irq_id;
- 	dst->active_lock_id =3D src->active_lock_id;
- 	dst->active_lock_ptr =3D src->active_lock_ptr;
+ 	dst->held =3D src->held;
  	return 0;
  }
 =20
@@@ -1456,7 -1452,7 +1452,7 @@@ static int copy_stack_state(struct bpf_
  	size_t n =3D bpf_stack_nr_slots(src);
 =20
  	dst->stack =3D copy_array(dst->stack, src->stack, n, sizeof(struct bpf_s=
tack_state),
- 				GFP_KERNEL_ACCOUNT);
+ 				BPF_VERIFIER_GFP);
  	if (!dst->stack)
  		return -ENOMEM;
 =20
@@@ -1467,7 -1463,7 +1463,7 @@@
  	if (n) {
  		dst->stack_arg_regs =3D copy_array(dst->stack_arg_regs, src->stack_arg_=
regs, n,
  						 sizeof(struct bpf_reg_state),
- 						 GFP_KERNEL_ACCOUNT);
+ 						 BPF_VERIFIER_GFP);
  		if (!dst->stack_arg_regs)
  			return -ENOMEM;
  	}
@@@ -1490,7 -1486,7 +1486,7 @@@ static int resize_reference_state(struc
  /* Possibly update state->allocated_stack to be at least size bytes. Also
   * possibly update the function's high-water mark in its bpf_subprog_info.
   */
- int bpf_grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_st=
ate *state, int size)
+ static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func=
_state *state, int size)
  {
  	size_t old_n =3D bpf_stack_nr_slots(state), n;
 =20
@@@ -1508,8 -1504,10 +1504,10 @@@
  	state->allocated_stack =3D size;
 =20
  	/* update known max for given subprogram */
- 	if (env->subprog_info[state->subprogno].stack_depth < size)
+ 	if (env->subprog_info[state->subprogno].stack_depth < size) {
  		env->subprog_info[state->subprogno].stack_depth =3D size;
+ 		env->subprog_info[state->subprogno].deepest_insn =3D env->insn_idx;
+ 	}
 =20
  	return 0;
  }
@@@ -1558,9 -1556,9 +1556,9 @@@ static int acquire_reference(struct bpf
  	if (!s)
  		return -ENOMEM;
  	s->type =3D REF_TYPE_PTR;
- 	s->id =3D ++env->id_gen;
+ 	s->id =3D bpf_new_id(env);
  	s->parent_id =3D parent_id;
- 	bpf_diag_record_ref_acquire(env, insn_idx, s->id);
+ 	bpf_diag_record_ref_acquire(env, s);
  	return s->id;
  }
 =20
@@@ -1594,7 -1592,7 +1592,7 @@@ static int acquire_irq_state(struct bpf
  	if (!s)
  		return -ENOMEM;
  	s->type =3D REF_TYPE_IRQ;
- 	s->id =3D ++env->id_gen;
+ 	s->id =3D bpf_new_id(env);
 =20
  	state->active_irq_id =3D s->id;
  	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_IRQ, true,
@@@ -1604,9 -1602,14 +1602,14 @@@
 =20
  static void release_reference_state(struct bpf_verifier_state *state, int=
 idx)
  {
- 	int last_idx;
+ 	int last_idx, fr;
  	size_t rem;
 =20
+ 	/* the frames that were entered with it don't hold it ever since */
+ 	for (fr =3D 0; fr <=3D state->curframe; fr++)
+ 		if (idx < state->frame[fr]->entry_refs)
+ 			state->frame[fr]->entry_refs--;
+=20
  	/* IRQ state requires the relative ordering of elements remaining the
  	 * same, since it relies on the refs array to behave as a stack, so that
  	 * it can detect out-of-order IRQ restore. Hence use memmove to shift
@@@ -1621,6 -1624,20 +1624,20 @@@
  	return;
  }
 =20
+ /* bpf_rcu_read_unlock() or bpf_preempt_enable() is done, see release_ref=
erence_state() */
+ static void release_context_state(struct bpf_verifier_state *state)
+ {
+ 	struct bpf_func_state *frame;
+ 	int fr;
+=20
+ 	for (fr =3D 0; fr <=3D state->curframe; fr++) {
+ 		frame =3D state->frame[fr];
+ 		frame->entry_rcu_locks =3D min(frame->entry_rcu_locks, state->active_rc=
u_locks);
+ 		frame->entry_preempt_locks =3D min(frame->entry_preempt_locks,
+ 						 state->active_preempt_locks);
+ 	}
+ }
+=20
  static bool find_reference_state(struct bpf_verifier_state *state, int id)
  {
  	int i;
@@@ -1715,34 -1732,51 +1732,51 @@@ static struct bpf_reference_state *find
  	return NULL;
  }
 =20
+ static void leave_loops(struct bpf_func_state *state, u32 cnt)
+ {
+ 	while (state->loop_stack_cnt > cnt)
+ 		bpf_flow_put_header_state(&state->loop_stack[--state->loop_stack_cnt]);
+ }
+=20
  static void free_func_state(struct bpf_func_state *state)
  {
  	if (!state)
  		return;
+ 	leave_loops(state, 0);
  	kfree(state->loop_stack);
  	kfree(state->stack_arg_regs);
  	kfree(state->stack);
  	kfree(state);
  }
 =20
- void bpf_clear_jmp_history(struct bpf_verifier_state *state)
+ /* @st is new or has grown */
+ void bpf_charge_state(struct bpf_verifier_env *env, struct bpf_verifier_s=
tate *st)
  {
- 	kfree(state->jmp_history);
- 	state->jmp_history =3D NULL;
- 	state->jmp_history_cnt =3D 0;
+ 	/* with the struct that holds it */
+ 	u32 bytes =3D 2 * sizeof(*st) + ksize(st->refs), fr;
+ 	struct bpf_func_state *f;
+=20
+ 	bytes +=3D bpf_equations_bytes(&st->equations);
+ 	for (fr =3D 0; fr <=3D st->curframe && (f =3D st->frame[fr]); fr++)
+ 		bytes +=3D kmalloc_size_roundup(sizeof(*f)) + ksize(f->stack) +
+ 			 ksize(f->stack_arg_regs) + ksize(f->loop_stack);
+ 	env->mem +=3D bytes - (s64)st->bytes;
+ 	st->bytes =3D bytes;
  }
 =20
- void bpf_free_verifier_state(struct bpf_verifier_state *state,
- 			    bool free_self)
+ void bpf_free_verifier_state(struct bpf_verifier_env *env, struct bpf_ver=
ifier_state *state,
+ 			     bool free_self)
  {
  	int i;
 =20
+ 	env->mem -=3D state->bytes;
+ 	state->bytes =3D 0;
  	for (i =3D 0; i <=3D state->curframe; i++) {
  		free_func_state(state->frame[i]);
  		state->frame[i] =3D NULL;
  	}
  	kfree(state->refs);
- 	bpf_clear_jmp_history(state);
+ 	bpf_equations_free(&state->equations);
  	if (free_self)
  		kfree(state);
  }
@@@ -1753,55 -1787,52 +1787,52 @@@
  static int copy_func_state(struct bpf_func_state *dst,
  			   const struct bpf_func_state *src)
  {
+ 	u32 i;
+=20
+ 	leave_loops(dst, 0);
  	memcpy(dst, src, offsetof(struct bpf_func_state, stack));
  	/* Instruction accounting is path-local, not part of verifier state. */
  	dst->insns_subtotal =3D 0;
+ 	dst->loop_stack_cnt =3D 0;
  	dst->loop_stack =3D copy_array(dst->loop_stack, src->loop_stack, src->lo=
op_stack_cnt,
- 				     sizeof(*src->loop_stack), GFP_KERNEL_ACCOUNT);
+ 				     sizeof(*src->loop_stack), BPF_VERIFIER_GFP);
  	if (!dst->loop_stack)
  		return -ENOMEM;
+ 	dst->loop_stack_cnt =3D src->loop_stack_cnt;
+ 	for (i =3D 0; i < src->loop_stack_cnt; i++)
+ 		if (src->loop_stack[i].header_state)
+ 			src->loop_stack[i].header_state->refcnt++;
  	return copy_stack_state(dst, src);
  }
 =20
- int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
- 			   const struct bpf_verifier_state *src)
+ int bpf_copy_verifier_state(struct bpf_verifier_env *env, struct bpf_veri=
fier_state *dst_state,
+ 			    const struct bpf_verifier_state *src)
  {
  	struct bpf_func_state *dst;
  	int i, err;
 =20
- 	dst_state->jmp_history =3D copy_array(dst_state->jmp_history, src->jmp_h=
istory,
- 					  src->jmp_history_cnt, sizeof(*dst_state->jmp_history),
- 					  GFP_KERNEL_ACCOUNT);
- 	if (!dst_state->jmp_history)
- 		return -ENOMEM;
- 	dst_state->jmp_history_cnt =3D src->jmp_history_cnt;
-=20
- 	/* if dst has more stack frames then src frame, free them, this is also
- 	 * necessary in case of exceptional exits using bpf_throw.
- 	 */
+ 	/* if dst has more stack frames then src frame, free them */
  	for (i =3D src->curframe + 1; i <=3D dst_state->curframe; i++) {
  		free_func_state(dst_state->frame[i]);
  		dst_state->frame[i] =3D NULL;
  	}
- 	err =3D copy_reference_state(dst_state, src);
+ 	err =3D copy_reference_state(dst_state, src) ?:
+ 	      bpf_equations_copy(env, &dst_state->equations, &src->equations);
  	if (err)
  		return err;
+ 	bpf_add_cost(env, bpf_xreg_cnt(src) + src->acquired_refs, BPF_COST_COPY);
  	dst_state->speculative =3D src->speculative;
- 	dst_state->in_sleepable =3D src->in_sleepable;
- 	dst_state->unwound =3D src->unwound;
- 	dst_state->curframe =3D src->curframe;
- 	dst_state->branches =3D src->branches;
- 	dst_state->parent =3D src->parent;
- 	dst_state->first_insn_idx =3D src->first_insn_idx;
+ 	dst_state->infeasible =3D src->infeasible;
+ 	dst_state->max_held_cnt =3D src->max_held_cnt;
+ 	dst_state->suspect_loops =3D src->suspect_loops;
+ 	dst_state->join_key =3D src->join_key;
+ 	dst_state->instance_id =3D src->instance_id;
+ 	dst_state->insn_idx =3D src->insn_idx;
  	dst_state->last_insn_idx =3D src->last_insn_idx;
- 	dst_state->dfs_depth =3D src->dfs_depth;
- 	dst_state->callback_unroll_depth =3D src->callback_unroll_depth;
- 	dst_state->may_goto_depth =3D src->may_goto_depth;
- 	dst_state->equal_state =3D src->equal_state;
  	for (i =3D 0; i <=3D src->curframe; i++) {
  		dst =3D dst_state->frame[i];
  		if (!dst) {
- 			dst =3D kzalloc_obj(*dst, GFP_KERNEL_ACCOUNT);
+ 			dst =3D kzalloc_obj(*dst, BPF_VERIFIER_GFP);
  			if (!dst)
  				return -ENOMEM;
  			dst_state->frame[i] =3D dst;
@@@ -1810,87 -1841,16 +1841,16 @@@
  		if (err)
  			return err;
  	}
+ 	bpf_charge_state(env, dst_state);
  	return 0;
  }
 =20
- static u32 state_htab_size(struct bpf_verifier_env *env)
+ /*
+  * A check failed, so the insn is unproven in this state. The program is =
not rejected: a later
+  * pass can prove the insn. This pass continues, to find the other unprov=
en insns.
+  */
+ static bool error_is_recoverable(int err)
  {
- 	return env->prog->len;
- }
-=20
- struct list_head *bpf_explored_state(struct bpf_verifier_env *env, int id=
x)
- {
- 	struct bpf_verifier_state *cur =3D env->cur_state;
- 	struct bpf_func_state *state =3D cur->frame[cur->curframe];
-=20
- 	return &env->explored_states[(idx ^ state->callsite) % state_htab_size(e=
nv)];
- }
-=20
- static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verif=
ier_state *b)
- {
- 	int fr;
-=20
- 	if (a->curframe !=3D b->curframe)
- 		return false;
-=20
- 	for (fr =3D a->curframe; fr >=3D 0; fr--)
- 		if (a->frame[fr]->callsite !=3D b->frame[fr]->callsite)
- 			return false;
-=20
- 	return true;
- }
-=20
- void bpf_free_backedges(struct bpf_scc_visit *visit)
- {
- 	struct bpf_scc_backedge *backedge, *next;
-=20
- 	for (backedge =3D visit->backedges; backedge; backedge =3D next) {
- 		bpf_free_verifier_state(&backedge->state, false);
- 		next =3D backedge->next;
- 		kfree(backedge);
- 	}
- 	visit->backedges =3D NULL;
- }
-=20
- static int pop_stack(struct bpf_verifier_env *env, int *prev_insn_idx,
- 		     int *insn_idx, bool pop_log)
- {
- 	struct bpf_verifier_state *cur =3D env->cur_state;
- 	struct bpf_verifier_stack_elem *elem, *head =3D env->head;
- 	int err;
-=20
- 	if (env->head =3D=3D NULL)
- 		return -ENOENT;
-=20
- 	if (cur) {
- 		err =3D bpf_copy_verifier_state(cur, &head->st);
- 		if (err)
- 			return err;
- 		bpf_diag_event_log_restore(env, head->diag_log_pos);
- 	}
- 	if (pop_log)
- 		bpf_vlog_reset(&env->log, head->log_pos);
- 	if (insn_idx)
- 		*insn_idx =3D head->insn_idx;
- 	if (prev_insn_idx)
- 		*prev_insn_idx =3D head->prev_insn_idx;
- 	elem =3D head->next;
- 	bpf_free_verifier_state(&head->st, false);
- 	kfree(head);
- 	env->head =3D elem;
- 	env->stack_size--;
- 	return 0;
- }
-=20
- static bool error_recoverable_with_nospec(int err)
- {
- 	/* Should only return true for non-fatal errors that are allowed to
- 	 * occur during speculative verification. For these we can insert a
- 	 * nospec and the program might still be accepted. Do not include
- 	 * something like ENOMEM because it is likely to re-occur for the next
- 	 * architectural path once it has been recovered-from in all speculative
- 	 * paths.
- 	 */
  	return err =3D=3D -EPERM || err =3D=3D -EACCES || err =3D=3D -EINVAL;
  }
 =20
@@@ -1902,38 -1862,18 +1862,18 @@@ static struct bpf_verifier_state *push_
  	struct bpf_verifier_stack_elem *elem;
  	int err;
 =20
- 	elem =3D kzalloc_obj(struct bpf_verifier_stack_elem, GFP_KERNEL_ACCOUNT);
+ 	elem =3D kzalloc_obj(struct bpf_verifier_stack_elem, BPF_VERIFIER_GFP);
  	if (!elem)
  		return ERR_PTR(-ENOMEM);
 =20
  	elem->insn_idx =3D insn_idx;
  	elem->prev_insn_idx =3D prev_insn_idx;
  	elem->next =3D env->head;
- 	elem->log_pos =3D env->log.end_pos;
- 	elem->diag_log_pos =3D bpf_diag_event_log_save(env);
  	env->head =3D elem;
- 	env->stack_size++;
- 	err =3D bpf_copy_verifier_state(&elem->st, cur);
+ 	err =3D bpf_copy_verifier_state(env, &elem->st, cur) ?: bpf_check_limits=
(env);
  	if (err)
- 		return ERR_PTR(-ENOMEM);
+ 		return ERR_PTR(err);
  	elem->st.speculative |=3D speculative;
- 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
- 		verbose(env, "The sequence of %d jumps is too complex.\n",
- 			env->stack_size);
- 		return ERR_PTR(-E2BIG);
- 	}
- 	if (elem->st.parent) {
- 		++elem->st.parent->branches;
- 		/* WARN_ON(branches > 2) technically makes sense here,
- 		 * but
- 		 * 1. speculative states will bump 'branches' for non-branch
- 		 * instructions
- 		 * 2. is_state_visited() heuristics may decide not to create
- 		 * a new state for a sequence of branches and all such current
- 		 * and cloned states will be pointing to a single parent state
- 		 * which might have large 'branches' count.
- 		 */
- 	}
  	return &elem->st;
  }
 =20
@@@ -1968,58 -1908,65 +1908,65 @@@ static void bpf_diag_record_caller_save
  	}
  }
 =20
- static void reg_step_reset(struct bpf_reg_state *reg)
+ static void scalar_step_reset(struct scalar *s)
  {
- 	reg->base =3D 0;
- 	reg->step =3D 1;
+ 	s->base =3D 0;
+ 	s->step =3D 1;
  }
 =20
- static void scalar_step_add(struct bpf_reg_state *dst_reg,
- 			    const struct bpf_reg_state *a,
- 			    const struct bpf_reg_state *b)
+ static void scalar_step_add(struct scalar *dst, const struct scalar *a, c=
onst struct scalar *b)
  {
- 	const struct bpf_reg_state *reg;
  	s64 amount, tmp;
+ 	u16 step;
 =20
- 	if (tnum_is_const(b->var_off)) {
- 		reg =3D a;
- 		amount =3D (s64)b->var_off.value;
- 	} else if (tnum_is_const(a->var_off)) {
- 		reg =3D b;
- 		amount =3D (s64)a->var_off.value;
- 	} else {
- 		reg_step_reset(dst_reg);
- 		return;
- 	}
+ 	if (tnum_is_const(a->var_off) && !tnum_is_const(b->var_off))
+ 		swap(a, b);
+ 	/* b is d + k * step. A constant has no step. */
+ 	amount =3D tnum_is_const(b->var_off) ? b->var_off.value : b->base;
+ 	step =3D tnum_is_const(b->var_off) ? a->step : gcd(a->step, b->step);
 =20
  	/*
  	 * Let x be a possible signed value of the register,
- 	 * d =3D amount, s =3D reg->step, and b =3D reg->base.
+ 	 * d =3D amount, s =3D step, and b =3D a->base mod s.
  	 * Then x mod s =3D b, with s > 0 and 0 <=3D b < s.
  	 * If the addition causes signed underflow, the resulting value
  	 * is x + d + 2**64.
  	 *
  	 * Taking the result modulo s and substituting x mod s =3D b gives:
  	 *   (x + d + 2**64) mod s =3D (b + d + (2**64 mod s)) mod s      (1)
- 	 * Keeping reg->step =3D s and updating reg->base to (b + d) mod s
+ 	 * Keeping the step s and updating the base to (b + d) mod s
  	 * requires (1) to equal (b + d) mod s, which holds if and only
  	 * if 2**64 mod s =3D 0.
  	 * Signed overflow subtracts 2**64 and has the same requirement.
  	 *
  	 * Conservatively reset the stride if either wrap is possible.
  	 */
- 	if (check_add_overflow(reg_smin(reg), amount, &tmp) ||
- 	    check_add_overflow(reg_smax(reg), amount, &tmp)) {
- 		reg_step_reset(dst_reg);
+ 	if (step =3D=3D 1 || check_add_overflow(cnum64_smin(a->r64), cnum64_smin=
(b->r64), &tmp) ||
+ 	    check_add_overflow(cnum64_smax(a->r64), cnum64_smax(b->r64), &tmp)) {
+ 		scalar_step_reset(dst);
  		return;
  	}
 =20
- 	dst_reg->base =3D (reg->base + imod(amount, reg->step)) % reg->step;
- 	dst_reg->step =3D reg->step;
+ 	dst->base =3D (a->base + imod(amount, step)) % step;
+ 	dst->step =3D step;
  }
 =20
- static void scalar_step_scale(struct bpf_reg_state *dst_reg, u64 amount)
+ /*
+  * dst =3D a + b in each of the four parts. @dst can be @a or @b.
+  * The sum of reduced scalars is not always reduced: the caller calls sca=
lar_bounds_sync().
+  */
+ void scalar_add(struct scalar *dst, const struct scalar *a, const struct =
scalar *b)
  {
+ 	scalar_step_add(dst, a, b);
+ 	dst->r32 =3D cnum32_add(a->r32, b->r32);
+ 	dst->r64 =3D cnum64_add(a->r64, b->r64);
+ 	dst->var_off =3D tnum_add(a->var_off, b->var_off);
+ }
+=20
+ /* The step of @dst * @amount. The ranges are those before the product. */
+ void scalar_step_scale(struct scalar *dst, s64 amount)
+ {
+ 	u64 factor =3D amount < 0 ? -(u64)amount : amount;
  	u16 step;
  	s64 tmp;
 =20
@@@ -2032,25 -1979,24 +1979,24 @@@
  	 * Taking the result modulo s * d gives:
  	 *   (x * d - n * 2**64) mod (s * d) =3D
  	 *   (b * d - (n * 2**64 mod (s * d))) mod (s * d)              (1)
- 	 * Updating dst_reg->base to b * d and dst_reg->step to s * d
+ 	 * Updating dst->base to b * d and dst->step to s * d
  	 * requires (1) to equal b * d, which holds if and only if
  	 * n * 2**64 mod (s * d) =3D 0.
  	 *
  	 * Conservatively reset the stride if a wrap is possible.
  	 */
- 	if (amount =3D=3D 0 || check_mul_overflow(dst_reg->step, amount, &step) =
||
- 	    check_mul_overflow(reg_smin(dst_reg), (s64)amount, &tmp) ||
- 	    check_mul_overflow(reg_smax(dst_reg), (s64)amount, &tmp)) {
- 		reg_step_reset(dst_reg);
+ 	if (amount =3D=3D 0 || check_mul_overflow(dst->step, factor, &step) ||
+ 	    check_mul_overflow(cnum64_smin(dst->r64), amount, &tmp) ||
+ 	    check_mul_overflow(cnum64_smax(dst->r64), amount, &tmp)) {
+ 		scalar_step_reset(dst);
  		return;
  	}
  	/*
- 	 * The above established that `step =3D dst_reg->step * amount`
- 	 * does not overflow, therefore the base < step invariant holds
- 	 * after assignments below.
+ 	 * The above established that `step =3D dst->step * |amount|`
+ 	 * does not overflow. For d < 0 the same holds modulo s * -d.
  	 */
- 	dst_reg->base =3D dst_reg->base * amount;
- 	dst_reg->step =3D step;
+ 	dst->base =3D imod(dst->base * amount, step);
+ 	dst->step =3D step;
  }
 =20
  /*
@@@ -2073,19 -2019,27 +2019,27 @@@
   * the range where the conversion leaves them unchanged.
   * Call before updating the register's bounds. Requires 0 < bits < 64.
   */
- static void reg_step_check_unsigned(struct bpf_reg_state *reg, u32 bits)
+ static void scalar_step_check_unsigned(struct scalar *s, u32 bits)
  {
- 	if (reg_umax(reg) >=3D (1ULL << bits))
- 		reg_step_reset(reg);
+ 	if (cnum64_umax(s->r64) >=3D (1ULL << bits))
+ 		scalar_step_reset(s);
  }
 =20
- /* This helper doesn't clear reg->id */
- static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
+ /* Nothing is known about the value, or about the variable part of the of=
fset of a pointer. */
+ void scalar_set_unknown(struct scalar *s)
  {
- 	reg->var_off =3D tnum_const(imm);
- 	reg->r64 =3D cnum64_from_urange(imm, imm);
- 	reg->r32 =3D cnum32_from_urange((u32)imm, (u32)imm);
- 	reg_step_reset(reg);
+ 	s->var_off =3D tnum_unknown;
+ 	s->r64 =3D CNUM64_UNBOUNDED;
+ 	s->r32 =3D CNUM32_UNBOUNDED;
+ 	scalar_step_reset(s);
+ }
+=20
+ void scalar_set_const(struct scalar *s, u64 imm)
+ {
+ 	s->var_off =3D tnum_const(imm);
+ 	s->r64 =3D cnum64_const(imm);
+ 	s->r32 =3D cnum32_const(imm);
+ 	scalar_step_reset(s);
  }
 =20
  /* Mark the unknown part of a register (variable offset or scalar value) =
as
@@@ -2093,13 -2047,12 +2047,12 @@@
   */
  static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
  {
- 	/* Clear off and union(map_ptr, range) */
- 	memset(((u8 *)reg) + sizeof(reg->type), 0,
- 	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
+ 	/* Clear union(map_ptr, range) */
+ 	memset(&reg->raw, 0, sizeof(reg->raw));
  	reg->id =3D 0;
  	reg->parent_id =3D 0;
  	reg->map_uid =3D 0;
- 	___mark_reg_known(reg, imm);
+ 	scalar_set_const(scalar_of(reg), imm);
  }
 =20
  void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm)
@@@ -2108,10 -2061,10 +2061,10 @@@
  	reg->type =3D SCALAR_VALUE;
  }
 =20
- static void __mark_reg32_known(struct bpf_reg_state *reg, u64 imm)
+ static void __mark_scalar32_known(struct scalar *s, u64 imm)
  {
- 	reg->var_off =3D tnum_const_subreg(reg->var_off, imm);
- 	reg->r32 =3D cnum32_from_urange((u32)imm, (u32)imm);
+ 	s->var_off =3D tnum_const_subreg(s->var_off, imm);
+ 	s->r32 =3D cnum32_const(imm);
  }
 =20
  /* Mark the 'variable offset' part of a register as zero.  This should be
@@@ -2122,14 -2075,10 +2075,10 @@@ static void __mark_reg_known_zero(struc
  	__mark_reg_known(reg, 0);
  }
 =20
- static void __mark_reg_const_zero(const struct bpf_verifier_env *env, str=
uct bpf_reg_state *reg)
+ static void __mark_reg_const_zero(struct bpf_reg_state *reg)
  {
  	__mark_reg_known(reg, 0);
  	reg->type =3D SCALAR_VALUE;
- 	/* all scalars are assumed imprecise initially (unless unprivileged,
- 	 * in which case everything is forced to be precise)
- 	 */
- 	reg->precise =3D !env->bpf_capable;
  }
 =20
  static void mark_reg_known_zero(struct bpf_verifier_env *env,
@@@ -2226,33 -2175,33 +2175,33 @@@ static bool reg_is_init_pkt_pointer(con
  	       tnum_equals_const(reg->var_off, 0);
  }
 =20
- static void __mark_reg32_unbounded(struct bpf_reg_state *reg)
+ static void __mark_scalar32_unbounded(struct scalar *s)
  {
- 	reg->r32 =3D CNUM32_UNBOUNDED;
+ 	s->r32 =3D CNUM32_UNBOUNDED;
  }
 =20
- static void __mark_reg64_unbounded(struct bpf_reg_state *reg)
+ static void __mark_scalar64_unbounded(struct scalar *s)
  {
- 	reg->r64 =3D CNUM64_UNBOUNDED;
+ 	s->r64 =3D CNUM64_UNBOUNDED;
  }
 =20
- /* Reset the min/max bounds of a register */
- static void __mark_reg_unbounded(struct bpf_reg_state *reg)
+ /* Reset the min/max bounds */
+ static void __mark_scalar_unbounded(struct scalar *s)
  {
- 	__mark_reg64_unbounded(reg);
- 	__mark_reg32_unbounded(reg);
+ 	__mark_scalar64_unbounded(s);
+ 	__mark_scalar32_unbounded(s);
  }
 =20
- static void reset_reg64_and_tnum(struct bpf_reg_state *reg)
+ static void reset_scalar64_and_tnum(struct scalar *s)
  {
- 	__mark_reg64_unbounded(reg);
- 	reg->var_off =3D tnum_unknown;
+ 	__mark_scalar64_unbounded(s);
+ 	s->var_off =3D tnum_unknown;
  }
 =20
- static void reset_reg32_and_tnum(struct bpf_reg_state *reg)
+ static void reset_scalar32_and_tnum(struct scalar *s)
  {
- 	__mark_reg32_unbounded(reg);
- 	reg->var_off =3D tnum_unknown;
+ 	__mark_scalar32_unbounded(s);
+ 	s->var_off =3D tnum_unknown;
  }
 =20
  static struct cnum32 cnum32_from_tnum(struct tnum tnum)
@@@ -2278,213 -2227,251 +2227,251 @@@ static struct cnum64 cnum64_from_tnum=
(s
  		return cnum64_from_urange(tnum.value, (tnum.value | tnum.mask));
  }
 =20
- static void __update_reg32_bounds(struct bpf_reg_state *reg)
+ static void __update_scalar32_bounds(struct scalar *s)
  {
- 	cnum32_intersect_with(&reg->r32, cnum32_from_tnum(reg->var_off));
+ 	cnum32_intersect_with(&s->r32, cnum32_from_tnum(s->var_off));
  }
 =20
- static void __update_reg64_bounds(struct bpf_reg_state *reg)
+ static void __update_scalar64_bounds(struct scalar *s)
  {
  	u64 tnum_next, tmax;
  	bool umin_in_tnum;
 =20
- 	cnum64_intersect_with(&reg->r64, cnum64_from_tnum(reg->var_off));
+ 	cnum64_intersect_with(&s->r64, cnum64_from_tnum(s->var_off));
 =20
  	/* Check if u64 and tnum overlap in a single value */
- 	tnum_next =3D tnum_step(reg->var_off, reg_umin(reg));
- 	umin_in_tnum =3D (reg_umin(reg) & ~reg->var_off.mask) =3D=3D reg->var_of=
f.value;
- 	tmax =3D reg->var_off.value | reg->var_off.mask;
- 	if (umin_in_tnum && tnum_next > reg_umax(reg)) {
+ 	tnum_next =3D tnum_step(s->var_off, cnum64_umin(s->r64));
+ 	umin_in_tnum =3D (cnum64_umin(s->r64) & ~s->var_off.mask) =3D=3D s->var_=
off.value;
+ 	tmax =3D s->var_off.value | s->var_off.mask;
+ 	if (umin_in_tnum && tnum_next > cnum64_umax(s->r64)) {
  		/* The u64 range and the tnum only overlap in umin.
  		 * u64:  ---[xxxxxx]-----
  		 * tnum: --xx----------x-
  		 */
- 		___mark_reg_known(reg, reg_umin(reg));
+ 		scalar_set_const(s, cnum64_umin(s->r64));
  	} else if (!umin_in_tnum && tnum_next =3D=3D tmax) {
  		/* The u64 range and the tnum only overlap in the maximum value
  		 * represented by the tnum, called tmax.
  		 * u64:  ---[xxxxxx]-----
  		 * tnum: xx-----x--------
  		 */
- 		___mark_reg_known(reg, tmax);
- 	} else if (!umin_in_tnum && tnum_next <=3D reg_umax(reg) &&
- 		   tnum_step(reg->var_off, tnum_next) > reg_umax(reg)) {
+ 		scalar_set_const(s, tmax);
+ 	} else if (!umin_in_tnum && tnum_next <=3D cnum64_umax(s->r64) &&
+ 		   tnum_step(s->var_off, tnum_next) > cnum64_umax(s->r64)) {
  		/* The u64 range and the tnum only overlap in between umin
  		 * (excluded) and umax.
  		 * u64:  ---[xxxxxx]-----
  		 * tnum: xx----x-------x-
  		 */
- 		___mark_reg_known(reg, tnum_next);
+ 		scalar_set_const(s, tnum_next);
  	}
  }
 =20
- static void __update_reg_bounds(struct bpf_reg_state *reg)
+ static void __update_scalar_bounds(struct scalar *s)
  {
- 	__update_reg32_bounds(reg);
- 	__update_reg64_bounds(reg);
+ 	__update_scalar32_bounds(s);
+ 	__update_scalar64_bounds(s);
  }
 =20
- static void deduce_bounds_32_from_64(struct bpf_reg_state *reg)
+ static void deduce_bounds_32_from_64(struct scalar *s)
  {
- 	cnum32_intersect_with(&reg->r32, cnum32_from_cnum64(reg->r64));
+ 	cnum32_intersect_with(&s->r32, cnum32_from_cnum64(s->r64));
  }
 =20
- static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
+ static void deduce_bounds_64_from_32(struct scalar *s)
  {
- 	reg->r64 =3D cnum64_cnum32_intersect(reg->r64, reg->r32);
+ 	s->r64 =3D cnum64_cnum32_intersect(s->r64, s->r32);
  }
 =20
- static void __reg_deduce_bounds(struct bpf_reg_state *reg)
+ static void __scalar_deduce_bounds(struct scalar *s)
  {
- 	deduce_bounds_32_from_64(reg);
- 	deduce_bounds_64_from_32(reg);
+ 	deduce_bounds_32_from_64(s);
+ 	deduce_bounds_64_from_32(s);
  }
 =20
  /* Attempts to improve var_off based on unsigned min/max information */
- static void __reg_bound_offset(struct bpf_reg_state *reg)
+ static void __scalar_bound_offset(struct scalar *s)
  {
- 	struct tnum var64_off =3D tnum_intersect(reg->var_off,
- 					       tnum_range(reg_umin(reg),
- 							  reg_umax(reg)));
+ 	struct tnum var64_off =3D tnum_intersect(s->var_off,
+ 					       tnum_range(cnum64_umin(s->r64),
+ 							  cnum64_umax(s->r64)));
  	struct tnum var32_off =3D tnum_intersect(tnum_subreg(var64_off),
- 					       tnum_range(reg_u32_min(reg),
- 							  reg_u32_max(reg)));
+ 					       tnum_range(cnum32_umin(s->r32),
+ 							  cnum32_umax(s->r32)));
  	u32 trailing_zero_bits;
- 	u16 base =3D reg->base;
- 	u16 step =3D reg->step;
+ 	u16 base =3D s->base;
+ 	u16 step =3D s->step;
 =20
- 	reg->var_off =3D tnum_or(tnum_clear_subreg(var64_off), var32_off);
+ 	s->var_off =3D tnum_or(tnum_clear_subreg(var64_off), var32_off);
 =20
  	if (base =3D=3D 0)
  		trailing_zero_bits =3D count_trailing_zeros(step);
  	else
  		trailing_zero_bits =3D min(count_trailing_zeros(base),
  					 count_trailing_zeros(step));
- 	reg->var_off =3D tnum_and(reg->var_off, tnum_const(~0ULL << trailing_zer=
o_bits));
+ 	s->var_off =3D tnum_and(s->var_off, tnum_const(~0ULL << trailing_zero_bi=
ts));
  }
 =20
- static void __update_bounds_from_step(struct bpf_reg_state *reg)
+ static void __update_bounds_from_step(struct scalar *s)
  {
- 	reg->r64 =3D cnum64_intersect_linear(reg->r64, reg->base, reg->step);
- 	deduce_bounds_32_from_64(reg);
+ 	s->r64 =3D cnum64_intersect_linear(s->r64, s->base, s->step);
+ 	deduce_bounds_32_from_64(s);
  }
 =20
- static bool range_bounds_violation(struct bpf_reg_state *reg);
+ static bool range_bounds_violation(const struct scalar *s);
 =20
- static void reg_bounds_sync(struct bpf_reg_state *reg)
+ void scalar_bounds_sync(struct scalar *s)
  {
  	/* If the input reg_state is invalid, we can exit early */
- 	if (range_bounds_violation(reg))
+ 	if (range_bounds_violation(s))
  		return;
  	/* We might have learned new bounds from the var_off. */
- 	__update_reg_bounds(reg);
+ 	__update_scalar_bounds(s);
  	/* We might have learned something about the sign bit. */
- 	__reg_deduce_bounds(reg);
- 	__reg_deduce_bounds(reg);
+ 	__scalar_deduce_bounds(s);
+ 	__scalar_deduce_bounds(s);
  	/* We might have learned some bits from the bounds. */
- 	__reg_bound_offset(reg);
+ 	__scalar_bound_offset(s);
  	/* Intersecting with the old var_off might have improved our bounds
  	 * slightly, e.g. if umax was 0x7f...f and var_off was (0; 0xf...fc),
  	 * then new var_off is (0; 0x7f...fc) which improves our umax.
  	 */
- 	__update_reg_bounds(reg);
+ 	__update_scalar_bounds(s);
  	/*
  	 * Both tnum and base+step define a sequence of points,
  	 * potentially w/o intersection, or intersecting after N
  	 * tnum_step()'s, where N can be large. On the other hand,
  	 * step+base *must* be in sync with r64 in order for
  	 * array traversal logic starting at reg_smin() to be sound.
- 	 * Hence, place this as a final step in the reg_bounds_sync().
+ 	 * Hence, place this as a final step in the scalar_bounds_sync().
  	 */
- 	__update_bounds_from_step(reg);
+ 	__update_bounds_from_step(s);
  }
 =20
- static bool const_tnum_range_mismatch(struct bpf_reg_state *reg)
+ static void reg_bounds_sync(struct bpf_reg_state *reg)
  {
- 	if (!tnum_is_const(reg->var_off))
+ 	scalar_bounds_sync(scalar_of(reg));
+ }
+=20
+ static bool const_tnum_range_mismatch(const struct scalar *s)
+ {
+ 	if (!tnum_is_const(s->var_off))
  		return false;
 =20
- 	return !cnum64_is_const(reg->r64) || reg->r64.base !=3D reg->var_off.val=
ue;
+ 	return !cnum64_is_const(s->r64) || s->r64.base !=3D s->var_off.value;
  }
 =20
- static bool const_tnum_range_mismatch_32(struct bpf_reg_state *reg)
+ static bool const_tnum_range_mismatch_32(const struct scalar *s)
  {
- 	if (!tnum_subreg_is_const(reg->var_off))
+ 	if (!tnum_subreg_is_const(s->var_off))
  		return false;
 =20
- 	return !cnum32_is_const(reg->r32) || reg->r32.base !=3D tnum_subreg(reg-=
>var_off).value;
+ 	return !cnum32_is_const(s->r32) || s->r32.base !=3D tnum_subreg(s->var_o=
ff).value;
  }
 =20
- static bool range_bounds_violation(struct bpf_reg_state *reg)
+ static bool range_bounds_violation(const struct scalar *s)
  {
- 	return cnum32_is_empty(reg->r32) || cnum64_is_empty(reg->r64);
+ 	return cnum32_is_empty(s->r32) || cnum64_is_empty(s->r64);
  }
 =20
+ /* Do @t and [min, max] overlap: is a member of @t in the range? */
+ static bool tnum_overlaps_urange(struct tnum t, u64 min, u64 max)
+ {
+ 	u64 tnum_next =3D tnum_step(t, min);
+=20
+ 	return (min & ~t.mask) =3D=3D t.value || (tnum_next > min && tnum_next <=
=3D max);
+ }
+=20
+ /* The same for the cnum [@base, @base + @size]. It wraps around at @ut_m=
ax. */
+ static bool tnum_overlaps_cnum(struct tnum t, u64 base, u64 size, u64 ut_=
max)
+ {
+ 	u64 end =3D (base + size) & ut_max;
+=20
+ 	if (base <=3D end)
+ 		return tnum_overlaps_urange(t, base, end);
+ 	return tnum_overlaps_urange(t, base, ut_max) || tnum_overlaps_urange(t, =
0, end);
+ }
+=20
+ /*
+  * A range and var_off don't overlap. reg_bounds_sync() compares var_off =
with umin and umax: it
+  * doesn't see that [-2, 1], which crosses 0, has no member with 5 in its=
 low three bits.
+  */
+ static bool scalar_is_empty(const struct scalar *s)
+ {
+ 	return range_bounds_violation(s) ||
+ 	       !tnum_overlaps_cnum(s->var_off, s->r64.base, s->r64.size, U64_MAX=
) ||
+ 	       !tnum_overlaps_cnum(tnum_subreg(s->var_off), s->r32.base, s->r32.=
size,
+ 				   U32_MAX);
+ }
+=20
+ static bool reg_is_empty(const struct bpf_reg_state *reg)
+ {
+ 	return scalar_is_empty(scalar_of(reg));
+ }
+=20
+ /*
+  * var_off, r64, r32 and the line base + step * k are a product that reg_=
bounds_sync() doesn't
+  * reduce to the end. The verifier can take an infeasible path with a reg=
ister that has no value
+  * while each part looks sane, and a later insn finds it out. That is not=
 a verifier bug: no WARN,
+  * a line in the log, the ranges are forgotten. A malformed base or step =
is a bug.
+  */
  static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
  				   struct bpf_reg_state *reg, const char *ctx)
  {
+ 	struct scalar *s =3D scalar_of(reg);
  	const char *msg;
 =20
- 	if (range_bounds_violation(reg)) {
+ 	if (range_bounds_violation(s)) {
  		msg =3D "range bounds violation";
  		goto out;
  	}
 =20
- 	if (const_tnum_range_mismatch(reg)) {
+ 	if (const_tnum_range_mismatch(s)) {
  		msg =3D "const tnum out of sync with range bounds";
  		goto out;
  	}
 =20
- 	if (const_tnum_range_mismatch_32(reg)) {
+ 	if (const_tnum_range_mismatch_32(s)) {
  		msg =3D "const subreg tnum out of sync with range bounds";
  		goto out;
  	}
 =20
- 	if (reg->step =3D=3D 0 || reg->base >=3D reg->step) {
+ 	if (verifier_bug_if(reg->step =3D=3D 0 || reg->base >=3D reg->step, env,=
 "%s", ctx)) {
  		msg =3D "invalid base/step";
  		goto out;
  	}
 =20
  	return 0;
  out:
- 	verifier_bug(env, "REG INVARIANTS VIOLATION (%s): %s r64=3D{.base=3D%#ll=
x, .size=3D%#llx} "
- 		     "r32=3D{.base=3D%#x, .size=3D%#x} var_off=3D(%#llx, %#llx) step=3D=
%u+%u",
- 		     ctx, msg,
- 		     reg->r64.base, reg->r64.size,
- 		     reg->r32.base, reg->r32.size,
- 		     reg->var_off.value, reg->var_off.mask,
- 		     reg->base, reg->step);
+ 	if (env->test_reg_invariants)
+ 		bpf_note_bug(env);
+ 	verbose(env, "REG INVARIANTS VIOLATION (%s): %s r64=3D{.base=3D%#llx, .s=
ize=3D%#llx} "
+ 		"r32=3D{.base=3D%#x, .size=3D%#x} var_off=3D(%#llx, %#llx) step=3D%u+%u=
\n",
+ 		ctx, msg,
+ 		reg->r64.base, reg->r64.size,
+ 		reg->r32.base, reg->r32.size,
+ 		reg->var_off.value, reg->var_off.mask,
+ 		reg->base, reg->step);
  	if (env->test_reg_invariants)
  		return -EFAULT;
- 	__mark_reg_unbounded(reg);
- 	reg_step_reset(reg);
+ 	env->cur_state->infeasible =3D true;
+ 	__mark_scalar_unbounded(s);
+ 	scalar_step_reset(s);
  	return 0;
  }
 =20
  /* Mark a register as having a completely unknown (scalar) value. */
- void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
+ void bpf_mark_reg_unknown(struct bpf_reg_state *reg)
  {
  	memset(reg, 0, sizeof(*reg));
  	reg->type =3D SCALAR_VALUE;
- 	reg->var_off =3D tnum_unknown;
- 	__mark_reg_unbounded(reg);
- 	reg_step_reset(reg);
- }
-=20
- /* Mark a register as having a completely unknown (scalar) value,
-  * initialize .precise as true when not bpf capable.
-  */
- static void __mark_reg_unknown(const struct bpf_verifier_env *env,
- 			       struct bpf_reg_state *reg)
- {
- 	bpf_mark_reg_unknown_imprecise(reg);
- 	reg->precise =3D !env->bpf_capable;
+ 	scalar_set_unknown(scalar_of(reg));
  }
 =20
  static void mark_reg_unknown(struct bpf_verifier_env *env,
  			     struct bpf_reg_state *regs, u32 regno)
  {
- 	__mark_reg_unknown(env, regs + regno);
+ 	bpf_mark_reg_unknown(regs + regno);
  }
 =20
  static int __mark_reg_s32_range(struct bpf_verifier_env *env,
@@@ -2510,7 -2497,7 +2497,7 @@@
  void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
  			   struct bpf_reg_state *reg)
  {
- 	__mark_reg_unknown(env, reg);
+ 	bpf_mark_reg_unknown(reg);
  	reg->type =3D NOT_INIT;
  }
 =20
@@@ -2530,7 -2517,7 +2517,7 @@@ static int mark_btf_ld_reg(struct bpf_v
  		regs[regno].btf =3D btf;
  		regs[regno].btf_id =3D btf_id;
  		if (type_may_be_null(flag))
- 			regs[regno].id =3D ++env->id_gen;
+ 			regs[regno].id =3D bpf_new_id(env);
  		return 0;
  	case PTR_TO_MEM:
  		mark_reg_known_zero(env, regs, regno);
@@@ -2589,31 -2576,22 +2576,22 @@@ static struct bpf_verifier_state *push_
  	struct bpf_verifier_stack_elem *elem;
  	struct bpf_func_state *frame;
 =20
- 	elem =3D kzalloc_obj(struct bpf_verifier_stack_elem, GFP_KERNEL_ACCOUNT);
+ 	elem =3D kzalloc_obj(struct bpf_verifier_stack_elem, BPF_VERIFIER_GFP);
  	if (!elem)
  		return ERR_PTR(-ENOMEM);
 =20
  	elem->insn_idx =3D insn_idx;
  	elem->prev_insn_idx =3D prev_insn_idx;
  	elem->next =3D env->head;
- 	elem->log_pos =3D env->log.end_pos;
- 	elem->diag_log_pos =3D bpf_diag_event_log_save(env);
  	env->head =3D elem;
- 	env->stack_size++;
- 	if (env->stack_size > BPF_COMPLEXITY_LIMIT_JMP_SEQ) {
- 		verbose(env,
- 			"The sequence of %d jumps is too complex for async cb.\n",
- 			env->stack_size);
- 		return ERR_PTR(-E2BIG);
- 	}
  	/* Unlike push_stack() do not bpf_copy_verifier_state().
  	 * The caller state doesn't matter.
  	 * This is async callback. It starts in a fresh stack.
  	 * Initialize it similar to do_check_common().
  	 */
- 	elem->st.branches =3D 1;
  	elem->st.in_sleepable =3D is_sleepable;
- 	frame =3D kzalloc_obj(*frame, GFP_KERNEL_ACCOUNT);
+ 	elem->st.suspect_loops =3D env->cur_state->suspect_loops;
+ 	frame =3D kzalloc_obj(*frame, BPF_VERIFIER_GFP);
  	if (!frame)
  		return ERR_PTR(-ENOMEM);
  	init_func_state(env, frame,
@@@ -2656,31 -2634,14 +2634,14 @@@ int bpf_find_subprog(struct bpf_verifie
  	return p - env->subprog_info;
  }
 =20
- static int add_subprog(struct bpf_verifier_env *env, int off)
+ static int add_subprog(struct bpf_verifier_env *env, unsigned long *start=
s, int off)
  {
- 	struct bpf_subprog_info *subprog =3D env->subprog_info;
- 	int insn_cnt =3D env->prog->len;
- 	int i;
-=20
- 	if (off >=3D insn_cnt || off < 0) {
+ 	if (off >=3D env->prog->len || off < 0) {
  		verbose(env, "call to invalid destination\n");
  		return -EINVAL;
  	}
- 	i =3D bpf_find_subprog(env, off);
- 	if (i >=3D 0)
- 		return i;
- 	if (env->subprog_cnt >=3D BPF_MAX_SUBPROGS) {
- 		verbose(env, "too many subprograms\n");
- 		return -E2BIG;
- 	}
- 	/*
- 	 * Determine subprog starts. The end is one before the next starts.
- 	 * The array stays sorted: subprogs that start after 'off' move up.
- 	 */
- 	for (i =3D env->subprog_cnt++; i > 0 && subprog[i - 1].start > off; i--)
- 		subprog[i] =3D subprog[i - 1];
- 	subprog[i] =3D (struct bpf_subprog_info){ .start =3D off, .exit_idx =3D =
U32_MAX };
- 	return i;
+ 	__set_bit(off, starts);
+ 	return 0;
  }
 =20
  static int bpf_find_exception_callback_insn_off(struct bpf_verifier_env *=
env)
@@@ -2745,48 -2706,28 +2706,28 @@@
  	return ret;
  }
 =20
- #define MAX_KFUNC_BTFS	256
-=20
  struct bpf_kfunc_btf {
  	struct btf *btf;
  	struct module *module;
- 	u16 offset;
  };
 =20
  struct bpf_kfunc_btf_tab {
- 	struct bpf_kfunc_btf descs[MAX_KFUNC_BTFS];
+ 	struct bpf_kfunc_btf *descs;
  	u32 nr_descs;
  };
 =20
- static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
+ /* The key of env->kfunc_index. The BTF of a module has func_id 0. */
+ static u64 kfunc_key(u32 func_id, u16 offset, bool specialized)
  {
- 	const struct bpf_kfunc_desc *d0 =3D a;
- 	const struct bpf_kfunc_desc *d1 =3D b;
-=20
- 	/* func_id is not greater than BTF_MAX_TYPE */
- 	return d0->func_id - d1->func_id ?: d0->offset - d1->offset;
- }
-=20
- static int kfunc_btf_cmp_by_off(const void *a, const void *b)
- {
- 	const struct bpf_kfunc_btf *d0 =3D a;
- 	const struct bpf_kfunc_btf *d1 =3D b;
-=20
- 	return d0->offset - d1->offset;
+ 	return func_id | (u64)offset << 32 | (u64)specialized << 48;
  }
 =20
  static struct bpf_kfunc_desc *
- find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
+ find_kfunc_desc(struct bpf_verifier_env *env, u32 func_id, u16 offset)
  {
- 	struct bpf_kfunc_desc desc =3D {
- 		.func_id =3D func_id,
- 		.offset =3D offset,
- 	};
- 	struct bpf_kfunc_desc_tab *tab;
+ 	int i =3D bpf_index_find(&env->kfunc_index, kfunc_key(func_id, offset, f=
alse));
 =20
- 	tab =3D prog->aux->kfunc_tab;
- 	return bsearch(&desc, tab->descs, tab->nr_base_descs,
- 		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
+ 	return func_id && i >=3D 0 ? &env->prog->aux->kfunc_tab->descs[i] : NULL;
  }
 =20
  int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
@@@ -2886,50 -2827,38 +2827,38 @@@ static struct btf *fd_array_get_btf(str
  static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
  					 s16 offset)
  {
- 	struct bpf_kfunc_btf kf_btf =3D { .offset =3D offset };
- 	struct bpf_kfunc_btf_tab *tab;
+ 	struct bpf_kfunc_btf_tab *tab =3D env->prog->aux->kfunc_btf_tab;
+ 	int i =3D bpf_index_find(&env->kfunc_index, kfunc_key(0, offset, false));
  	struct bpf_kfunc_btf *b;
  	struct module *mod;
  	struct btf *btf;
 =20
- 	tab =3D env->prog->aux->kfunc_btf_tab;
- 	b =3D bsearch(&kf_btf, tab->descs, tab->nr_descs,
- 		    sizeof(tab->descs[0]), kfunc_btf_cmp_by_off);
- 	if (!b) {
- 		if (tab->nr_descs =3D=3D MAX_KFUNC_BTFS) {
- 			verbose(env, "too many different module BTFs\n");
- 			return ERR_PTR(-E2BIG);
- 		}
+ 	if (i >=3D 0)
+ 		return tab->descs[i].btf;
 =20
- 		btf =3D fd_array_get_btf(env, offset);
- 		if (IS_ERR(btf))
- 			return btf;
- 		if (!btf_is_module(btf)) {
- 			verbose(env, "BTF fd for kfunc is not a module BTF\n");
- 			btf_put(btf);
- 			return ERR_PTR(-EINVAL);
- 		}
+ 	b =3D bpf_table_next(tab->descs, tab->nr_descs);
+ 	if (!b)
+ 		return ERR_PTR(-ENOMEM);
 =20
- 		mod =3D btf_try_get_module(btf);
- 		if (!mod) {
- 			btf_put(btf);
- 			return ERR_PTR(-ENXIO);
- 		}
-=20
- 		b =3D &tab->descs[tab->nr_descs++];
- 		b->btf =3D btf;
- 		b->module =3D mod;
- 		b->offset =3D offset;
-=20
- 		/* sort() reorders entries by value, so b may no longer point
- 		 * to the right entry after this
- 		 */
- 		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
- 		     kfunc_btf_cmp_by_off, NULL);
- 	} else {
- 		btf =3D b->btf;
+ 	btf =3D fd_array_get_btf(env, offset);
+ 	if (IS_ERR(btf))
+ 		return btf;
+ 	if (!btf_is_module(btf)) {
+ 		verbose(env, "BTF fd for kfunc is not a module BTF\n");
+ 		btf_put(btf);
+ 		return ERR_PTR(-EINVAL);
  	}
 =20
+ 	mod =3D btf_try_get_module(btf);
+ 	if (!mod) {
+ 		btf_put(btf);
+ 		return ERR_PTR(-ENXIO);
+ 	}
+=20
+ 	b->btf =3D btf;
+ 	b->module =3D mod;
+ 	if (bpf_index_add(&env->kfunc_index, kfunc_key(0, offset, false), tab->n=
r_descs++))
+ 		return ERR_PTR(-ENOMEM);
  	return btf;
  }
 =20
@@@ -2942,6 -2871,7 +2871,7 @@@ void bpf_free_kfunc_btf_tab(struct bpf_
  		module_put(tab->descs[tab->nr_descs].module);
  		btf_put(tab->descs[tab->nr_descs].btf);
  	}
+ 	kvfree(tab->descs);
  	kfree(tab);
  }
 =20
@@@ -2963,22 -2893,14 +2893,14 @@@ static struct btf *find_kfunc_desc_btf(
 =20
  static struct btf *find_kfunc_desc_btf_cached(struct bpf_verifier_env *en=
v, s16 offset)
  {
- 	struct bpf_kfunc_btf kf_btf =3D { .offset =3D offset };
- 	struct bpf_kfunc_btf_tab *tab;
- 	struct bpf_kfunc_btf *b;
+ 	int i =3D bpf_index_find(&env->kfunc_index, kfunc_key(0, offset, false));
 =20
  	if (!offset)
  		return btf_vmlinux ?: ERR_PTR(-ENOENT);
  	if (offset < 0)
  		return ERR_PTR(-EINVAL);
 =20
- 	tab =3D env->prog->aux->kfunc_btf_tab;
- 	if (!tab)
- 		return ERR_PTR(-ENOENT);
-=20
- 	b =3D bsearch(&kf_btf, tab->descs, tab->nr_descs,
- 		    sizeof(tab->descs[0]), kfunc_btf_cmp_by_off);
- 	return b ? b->btf : ERR_PTR(-ENOENT);
+ 	return i >=3D 0 ? env->prog->aux->kfunc_btf_tab->descs[i].btf : ERR_PTR(=
-ENOENT);
  }
 =20
  #define KF_IMPL_SUFFIX "_impl"
@@@ -3112,7 -3034,7 +3034,7 @@@ int bpf_add_kfunc_call(struct bpf_verif
  			return -EINVAL;
  		}
 =20
- 		tab =3D kzalloc_obj(*tab, GFP_KERNEL_ACCOUNT);
+ 		tab =3D kzalloc_obj(*tab, BPF_VERIFIER_GFP);
  		if (!tab)
  			return -ENOMEM;
  		prog_aux->kfunc_tab =3D tab;
@@@ -3130,25 -3052,15 +3052,15 @@@
  		return 0;
 =20
  	if (!btf_tab && offset) {
- 		btf_tab =3D kzalloc_obj(*btf_tab, GFP_KERNEL_ACCOUNT);
+ 		btf_tab =3D kzalloc_obj(*btf_tab, BPF_VERIFIER_GFP);
  		if (!btf_tab)
  			return -ENOMEM;
  		prog_aux->kfunc_btf_tab =3D btf_tab;
  	}
 =20
- 	if (find_kfunc_desc(env->prog, func_id, offset))
+ 	if (find_kfunc_desc(env, func_id, offset))
  		return 0;
 =20
- 	if (tab->nr_base_descs =3D=3D MAX_KFUNC_DESCS) {
- 		verbose(env, "too many different kernel function calls\n");
- 		return -E2BIG;
- 	}
- 	if (tab->nr_descs !=3D tab->nr_base_descs) {
- 		verifier_bug(env, "unexpected specialized func desc found (%d descs, %d=
 base descs)",
- 			     tab->nr_descs, tab->nr_base_descs);
- 		return -EFAULT;
- 	}
-=20
  	err =3D fetch_kfunc_meta(env, func_id, offset, &kfunc);
  	if (err)
  		return err;
@@@ -3188,12 -3100,9 +3100,9 @@@
  	meta.func_name =3D kfunc.name;
  	meta.kfunc_flags =3D kfunc.flags ? *kfunc.flags : 0;
 =20
- 	tab =3D krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1), GFP_KE=
RNEL_ACCOUNT);
- 	if (!tab)
+ 	desc =3D bpf_table_next(tab->descs, tab->nr_descs);
+ 	if (!desc)
  		return -ENOMEM;
- 	prog_aux->kfunc_tab =3D tab;
-=20
- 	desc =3D &tab->descs[tab->nr_descs];
  	memset(desc, 0, sizeof(*desc));
 =20
  	err =3D gen_kfunc_arg_proto(env, &meta, &func_model, &desc->proto);
@@@ -3204,24 -3113,22 +3113,22 @@@
  	desc->offset =3D offset;
  	desc->addr =3D addr;
  	desc->func_model =3D func_model;
- 	tab->nr_descs++;
- 	tab->nr_base_descs++;
- 	sort(tab->descs, tab->nr_base_descs, sizeof(tab->descs[0]),
- 	     kfunc_desc_cmp_by_id_off, NULL);
- 	return 0;
+ 	return bpf_index_add(&env->kfunc_index, kfunc_key(func_id, offset, false=
), tab->nr_descs++);
  }
 =20
  static int add_subprogs(struct bpf_verifier_env *env)
  {
- 	struct bpf_subprog_info *subprog =3D env->subprog_info;
- 	int i, ret, insn_cnt =3D env->prog->len, ex_cb_insn;
+ 	int i, cnt, ret, insn_cnt =3D env->prog->len, ex_cb_insn;
+ 	unsigned long *starts __free(kvfree) =3D NULL;
  	struct bpf_insn *insn =3D env->prog->insnsi;
  	const char *operation, *suggestion;
+ 	struct bpf_subprog_info *subprog;
 =20
+ 	starts =3D kvcalloc(BITS_TO_LONGS(insn_cnt), sizeof(long), BPF_VERIFIER_=
GFP);
+ 	if (!starts)
+ 		return -ENOMEM;
  	/* Add entry function. */
- 	ret =3D add_subprog(env, 0);
- 	if (ret)
- 		return ret;
+ 	__set_bit(0, starts);
 =20
  	for (i =3D 0; i < insn_cnt; i++, insn++) {
  		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
@@@ -3243,7 -3150,7 +3150,7 @@@
  			return -EPERM;
  		}
 =20
- 		ret =3D add_subprog(env, i + insn->imm + 1);
+ 		ret =3D add_subprog(env, starts, i + insn->imm + 1);
  		if (ret < 0)
  			return ret;
  	}
@@@ -3258,7 -3165,7 +3165,7 @@@
  		struct bpf_prog_aux *aux =3D env->prog->aux;
 =20
  		for (i =3D 1; i < aux->func_info_cnt; i++) {
- 			ret =3D add_subprog(env, aux->func_info[i].insn_off);
+ 			ret =3D add_subprog(env, starts, aux->func_info[i].insn_off);
  			if (ret < 0)
  				return ret;
  		}
@@@ -3272,23 -3179,32 +3179,32 @@@
  	/* If ex_cb_insn > 0, this means that the main program has a subprog
  	 * marked using BTF decl tag to serve as the exception callback.
  	 */
- 	if (ex_cb_insn) {
- 		ret =3D add_subprog(env, ex_cb_insn);
- 		if (ret < 0)
- 			return ret;
- 		for (i =3D 1; i < env->subprog_cnt; i++) {
- 			if (env->subprog_info[i].start !=3D ex_cb_insn)
- 				continue;
- 			env->exception_callback_subprog =3D i;
- 			bpf_mark_subprog_exc_cb(env, i);
- 			break;
- 		}
+ 	ret =3D add_subprog(env, starts, ex_cb_insn);
+ 	if (ret < 0)
+ 		return ret;
+=20
+ 	/* + 2 for the fake and the hidden subprogs */
+ 	cnt =3D bitmap_weight(starts, insn_cnt);
+ 	subprog =3D env->subprog_info =3D kvcalloc(cnt + 2, sizeof(*subprog), BP=
F_VERIFIER_GFP);
+ 	env->subprog_topo_order =3D kvcalloc(cnt, sizeof(int), BPF_VERIFIER_GFP);
+ 	if (!subprog || !env->subprog_topo_order)
+ 		return -ENOMEM;
+=20
+ 	/* Determine subprog starts. The end is one before the next starts. */
+ 	for_each_set_bit(i, starts, insn_cnt) {
+ 		subprog[env->subprog_cnt].start =3D i;
+ 		subprog[env->subprog_cnt++].exit_idx =3D U32_MAX;
  	}
 =20
  	/* Add a fake 'exit' subprog which could simplify subprog iteration
  	 * logic. 'subprog_cnt' should not be increased.
  	 */
- 	subprog[env->subprog_cnt].start =3D insn_cnt;
+ 	subprog[cnt].start =3D insn_cnt;
+=20
+ 	if (ex_cb_insn) {
+ 		env->exception_callback_subprog =3D bpf_find_subprog(env, ex_cb_insn);
+ 		bpf_mark_subprog_exc_cb(env, env->exception_callback_subprog);
+ 	}
 =20
  	if (env->log.level & BPF_LOG_LEVEL2)
  		for (i =3D 0; i < env->subprog_cnt; i++)
@@@ -3315,7 -3231,7 +3231,7 @@@ static int add_kfuncs(struct bpf_verifi
  			return -EPERM;
  		}
 =20
- 		ret =3D bpf_add_kfunc_call(env, insn->imm, insn->off);
+ 		ret =3D bpf_must_abort() ? -EINTR : bpf_add_kfunc_call(env, insn->imm, =
insn->off);
  		if (ret < 0)
  			return ret;
  	}
@@@ -3323,7 -3239,8 +3239,8 @@@
  	return 0;
  }
 =20
- static void find_subprog_properties(struct bpf_verifier_env *env)
+ /* Before the main pass all insns count, after it those that were 'seen' =
*/
+ static void find_subprog_properties(struct bpf_verifier_env *env, bool se=
en)
  {
  	struct bpf_subprog_info *subprog =3D env->subprog_info;
  	struct bpf_insn *insn =3D env->prog->insnsi;
@@@ -3332,10 -3249,15 +3249,15 @@@
  	for (cur_subprog =3D 0; cur_subprog < env->subprog_cnt; cur_subprog++) {
  		int i;
 =20
+ 		subprog[cur_subprog].has_tail_call =3D false;
+ 		subprog[cur_subprog].tail_call_reachable =3D false;
+ 		subprog[cur_subprog].has_ld_abs =3D false;
  		for (i =3D subprog[cur_subprog].start;
  		     i < subprog[cur_subprog + 1].start; i++) {
  			u8 code =3D insn[i].code;
 =20
+ 			if (seen && !env->insn_aux_data[i].seen)
+ 				continue;
  			if (code =3D=3D (BPF_JMP | BPF_CALL) &&
  			    insn[i].src_reg =3D=3D 0 &&
  			    insn[i].imm =3D=3D BPF_FUNC_tail_call) {
@@@ -3416,37 -3338,22 +3338,22 @@@ next
  /*
   * The callee of callx is known to the main verification pass only, which
   * records the 'caller' -> 'callee' edge of the call graph for the checks
-  * that follow it: absence of recursion and the maximum stack depth.
+  * that follow it: recursion that was not seen coming and the maximum sta=
ck depth.
   */
  static int record_callx_edge(struct bpf_verifier_env *env, int caller, in=
t callee)
  {
- 	u32 cnt =3D env->subprog_cnt;
+ 	u32 *first =3D &env->subprog_info[caller].callx_edge, cnt =3D env->callx=
_index.cnt;
+ 	u64 key =3D (u64)caller << 32 | callee;
 =20
- 	if (!env->callx_edges) {
- 		env->callx_edges =3D kvcalloc(BITS_TO_LONGS(cnt * cnt), sizeof(long),
- 					    GFP_KERNEL_ACCOUNT);
- 		if (!env->callx_edges)
- 			return -ENOMEM;
- 	}
- 	__set_bit(caller * cnt + callee, env->callx_edges);
+ 	if (bpf_index_find(&env->callx_index, key) >=3D 0)
+ 		return 0;
+ 	if (!bpf_table_next(env->callx_edges, cnt) || bpf_index_add(&env->callx_=
index, key, cnt))
+ 		return -ENOMEM;
+ 	env->callx_edges[cnt] =3D (struct bpf_callx_edge){ callee, *first };
+ 	*first =3D cnt + 1;
  	return 0;
  }
 =20
- /*
-  * Return the first subprog with the number >=3D 'from' that 'caller' cal=
ls
-  * via callx, or -1 when there is none.
-  */
- static int next_callx_callee(struct bpf_verifier_env *env, int caller, in=
t from)
- {
- 	u32 cnt =3D env->subprog_cnt;
- 	unsigned long bit, end =3D (caller + 1) * cnt;
-=20
- 	if (!env->callx_edges || from >=3D cnt)
- 		return -1;
- 	bit =3D find_next_bit(env->callx_edges, end, caller * cnt + from);
- 	return bit < end ? bit - caller * cnt : -1;
- }
-=20
  /*
   * 'call foo; unwind_goto pad' goes to the pad when foo left with unwind_=
exit.
   * JITs don't emit a branch for it. unwind_exit finds the pad by its retu=
rn
@@@ -3458,7 -3365,17 +3365,17 @@@ static int check_unwind_insns(struct bp
  	bool seen =3D false;
  	int i;
 =20
+ 	for (i =3D 0; i < env->subprog_cnt; i++)
+ 		env->subprog_info[i].bail_insn =3D -1;
+=20
  	for (i =3D 0; i < env->prog->len; i++, insn++) {
+ 		if (bpf_is_ldimm64(insn)) {
+ 			i++;
+ 			insn++;
+ 			continue;
+ 		}
+ 		if (insn->code =3D=3D (BPF_JMP | BPF_EXIT))
+ 			bpf_find_containing_subprog(env, i)->bail_insn =3D i;
  		if (bpf_is_unwind_exit(insn)) {
  			bpf_find_containing_subprog(env, i)->can_unwind =3D true;
  			seen =3D true;
@@@ -3494,103 -3411,49 +3411,49 @@@
   * the current subprog to discover callees (direct subprogs and sync
   * callbacks).
   *
-  * The callees of callx are not known before the main verification pass.
-  * When callx is used the sort is repeated after it with the recorded cal=
lx
-  * edges added to the call graph to reject recursion through indirect cal=
ls.
+  * The callees of callx are not known before the main verification pass: =
callx
+  * is no edge here. The order within a cycle is arbitrary. For recursion =
see
+  * mark_recursive_subprogs() and check_recursion().
   */
  static int sort_subprogs_topo(struct bpf_verifier_env *env)
  {
  	struct bpf_subprog_info *si =3D env->subprog_info;
  	int *insn_postorder =3D env->cfg.insn_postorder;
  	struct bpf_insn *insn =3D env->prog->insnsi;
- 	int cnt =3D env->subprog_cnt;
- 	int *dfs_stack =3D NULL;
- 	int top =3D 0, order =3D 0;
- 	int i, ret =3D 0;
- 	u8 *color =3D NULL;
+ 	int cnt =3D env->subprog_cnt, i, j, idx, ret;
+ 	struct bpf_call_graph cg;
 =20
- 	color =3D kvzalloc_objs(*color, cnt, GFP_KERNEL_ACCOUNT);
- 	dfs_stack =3D kvmalloc_objs(*dfs_stack, cnt, GFP_KERNEL_ACCOUNT);
- 	if (!color || !dfs_stack) {
- 		ret =3D -ENOMEM;
- 		goto out;
- 	}
-=20
- 	/*
- 	 * DFS post-order traversal.
- 	 * Color values: 0 =3D unvisited, 1 =3D on stack, 2 =3D done.
- 	 */
+ 	ret =3D bpf_call_graph_init(&cg, cnt);
  	for (i =3D 0; i < cnt; i++) {
- 		if (color[i])
- 			continue;
- 		color[i] =3D 1;
- 		dfs_stack[top++] =3D i;
-=20
- 		while (top > 0) {
- 			int cur =3D dfs_stack[top - 1];
- 			int po_start =3D si[cur].postorder_start;
- 			int po_end =3D si[cur + 1].postorder_start;
- 			bool pushed =3D false;
- 			int j;
-=20
- 			for (j =3D po_start; j < po_end; j++) {
- 				int idx =3D insn_postorder[j];
- 				int callee;
-=20
- 				if (bpf_is_callx(&insn[idx])) {
- 					/* find a callee that is not explored yet */
- 					callee =3D -1;
- 					do {
- 						callee =3D next_callx_callee(env, cur, callee + 1);
- 					} while (callee >=3D 0 && color[callee] =3D=3D 2);
- 					if (callee < 0)
- 						continue;
- 				} else if (bpf_pseudo_call(&insn[idx]) || bpf_pseudo_func(&insn[idx])=
) {
- 					callee =3D bpf_find_subprog(env, idx + insn[idx].imm + 1);
- 					if (callee < 0) {
- 						ret =3D -EFAULT;
- 						goto out;
- 					}
- 				} else {
- 					continue;
- 				}
- 				if (color[callee] =3D=3D 2)
- 					continue;
- 				if (color[callee] =3D=3D 1) {
- 					if (bpf_pseudo_func(&insn[idx]))
- 						continue;
- 					verbose(env, "recursive call from %s() to %s()\n",
- 						bpf_subprog_name(env, cur),
- 						bpf_subprog_name(env, callee));
- 					bpf_diag_program_structure(
- 						env, idx, "recursive subprogram call",
- 						"Rewrite the recursion as an explicit bounded loop, or split the lo=
gic so subprogram calls do not form a cycle.",
- 						"This bpf2bpf call would make the subprogram call graph recursive. "
- 						"The verifier requires a finite, acyclic call graph so it can bound=
 stack depth and analysis.");
- 					ret =3D -EINVAL;
- 					goto out;
- 				}
- 				color[callee] =3D 1;
- 				dfs_stack[top++] =3D callee;
- 				pushed =3D true;
+ 		for (j =3D si[i].postorder_start; j < si[i + 1].postorder_start && !ret=
; j++) {
+ 			idx =3D insn_postorder[j];
+ 			if (!bpf_pseudo_call(&insn[idx]) && !bpf_pseudo_func(&insn[idx]))
+ 				continue;
+ 			/*
+ 			 * The call that is its own target never returns. It is
+ 			 * also what libbpf leaves in place of a call that it
+ 			 * could not resolve.
+ 			 */
+ 			if (bpf_pseudo_call(&insn[idx]) && insn[idx].imm =3D=3D -1) {
+ 				verbose(env, "call at insn %d calls itself\n", idx);
+ 				ret =3D -EINVAL;
  				break;
  			}
-=20
- 			if (!pushed) {
- 				color[cur] =3D 2;
- 				env->subprog_topo_order[order++] =3D cur;
- 				top--;
- 			}
+ 			ret =3D bpf_call_graph_add(&cg, i,
+ 						 bpf_find_subprog(env, idx + insn[idx].imm + 1));
  		}
  	}
+ 	if (ret)
+ 		goto out;
+ 	bpf_call_graph_sort(&cg, 0);
+ 	memcpy(env->subprog_topo_order, cg.postorder, cnt * sizeof(u32));
 =20
  	if (env->log.level & BPF_LOG_LEVEL2)
  		for (i =3D 0; i < cnt; i++)
  			verbose(env, "topo_order[%d] =3D %s\n",
  				i, bpf_subprog_name(env, env->subprog_topo_order[i]));
  out:
- 	kvfree(dfs_stack);
- 	kvfree(color);
+ 	bpf_call_graph_free(&cg);
  	return ret;
  }
 =20
@@@ -3654,74 -3517,6 +3517,6 @@@ static void mark_non_stack_access(struc
  	env->insn_aux_data[idx].non_stack_access =3D true;
  }
 =20
- /* Layout of one packed linked register in the jump history, see linked_r=
egs_pack() */
- #define LR_FRAMENO_BITS	4
- #define LR_INDEX_BITS	11
- #define LR_FRAMENO_MASK	((1u << LR_FRAMENO_BITS) - 1)
- #define LR_IS_REG	BIT(LR_FRAMENO_BITS)
- #define LR_INDEX_OFF	(LR_FRAMENO_BITS + 1)
- #define LR_INDEX_MASK	((1u << LR_INDEX_BITS) - 1)
- #define LINKED_REGS_MAX	BPF_LINKED_REGS_MAX
-=20
- static_assert(MAX_CALL_FRAMES <=3D (1 << LR_FRAMENO_BITS));
- static_assert(MAX_BPF_REG <=3D (1 << LR_INDEX_BITS));
- static_assert(MAX_BPF_STACK_SLOTS <=3D (1 << LR_INDEX_BITS));
- static_assert(LR_INDEX_OFF + LR_INDEX_BITS <=3D 16);
-=20
- struct linked_reg {
- 	u8 frameno;
- 	union {
- 		u16 spi;
- 		u16 regno;
- 	};
- 	bool is_reg;
- };
-=20
- struct linked_regs {
- 	int cnt;
- 	struct linked_reg entries[LINKED_REGS_MAX];
- };
-=20
- static struct linked_reg *linked_regs_push(struct linked_regs *s)
- {
- 	if (s->cnt < LINKED_REGS_MAX)
- 		return &s->entries[s->cnt++];
-=20
- 	return NULL;
- }
-=20
- /*
-  * Pack linked registers for a jump history entry, one u16 each:
-  * - 4 bits frameno
-  * - 1 bit  is_reg
-  * - 11 bits register or stack slot index
-  */
- static void linked_regs_pack(const struct linked_regs *s, u16 *packed)
- {
- 	int i;
-=20
- 	for (i =3D 0; i < s->cnt; ++i) {
- 		const struct linked_reg *e =3D &s->entries[i];
-=20
- 		packed[i] =3D e->frameno | (e->is_reg ? LR_IS_REG : 0) | (e->spi << LR_=
INDEX_OFF);
- 	}
- }
-=20
- static void linked_regs_unpack(const struct bpf_jmp_history_entry *hist, =
struct linked_regs *s)
- {
- 	int i;
-=20
- 	s->cnt =3D hist->linked_regs_cnt;
- 	for (i =3D 0; i < s->cnt; ++i) {
- 		struct linked_reg *e =3D &s->entries[i];
- 		u16 packed =3D hist->linked_regs[i];
-=20
- 		e->frameno =3D packed & LR_FRAMENO_MASK;
- 		e->is_reg  =3D packed & LR_IS_REG;
- 		e->spi     =3D (packed >> LR_INDEX_OFF) & LR_INDEX_MASK;
- 	}
- }
-=20
  const char *bpf_disasm_kfunc_name(void *data, const struct bpf_insn *insn)
  {
  	const struct btf_type *func;
@@@ -3751,67 -3546,21 +3546,21 @@@ void bpf_verbose_insn(struct bpf_verifi
  	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
  }
 =20
- /* If any register R in hist->linked_regs is marked as precise in bt,
-  * do bt_set_frame_{reg,slot}(bt, R) for all registers in hist->linked_re=
gs.
-  */
- void bpf_bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_h=
istory_entry *hist)
+ static bool scalar_is_const(const struct scalar *s, bool subreg32)
  {
- 	struct linked_regs linked_regs;
- 	bool some_precise =3D false;
- 	int i;
-=20
- 	if (!hist || !hist->linked_regs_cnt)
- 		return;
-=20
- 	linked_regs_unpack(hist, &linked_regs);
- 	for (i =3D 0; i < linked_regs.cnt; ++i) {
- 		struct linked_reg *e =3D &linked_regs.entries[i];
-=20
- 		if ((e->is_reg && bt_is_frame_reg_set(bt, e->frameno, e->regno)) ||
- 		    (!e->is_reg && bt_is_frame_slot_set(bt, e->frameno, e->spi))) {
- 			some_precise =3D true;
- 			break;
- 		}
- 	}
-=20
- 	if (!some_precise)
- 		return;
-=20
- 	for (i =3D 0; i < linked_regs.cnt; ++i) {
- 		struct linked_reg *e =3D &linked_regs.entries[i];
-=20
- 		if (e->is_reg)
- 			bpf_bt_set_frame_reg(bt, e->frameno, e->regno);
- 		else
- 			bpf_bt_set_frame_slot(bt, e->frameno, e->spi);
- 	}
- }
-=20
- int mark_chain_precision(struct bpf_verifier_env *env, int regno)
- {
- 	return bpf_mark_chain_precision(env, env->cur_state, regno, NULL);
- }
-=20
- /* mark_chain_precision_batch() assumes that env->bt is set in the caller=
 to
-  * desired reg and stack masks across all relevant frames
-  */
- static int mark_chain_precision_batch(struct bpf_verifier_env *env,
- 				      struct bpf_verifier_state *starting_state)
- {
- 	return bpf_mark_chain_precision(env, starting_state, -1, NULL);
+ 	return tnum_is_const(subreg32 ? tnum_subreg(s->var_off) : s->var_off);
  }
 =20
  /* check if register is a constant scalar value */
  static bool is_reg_const(struct bpf_reg_state *reg, bool subreg32)
  {
- 	return reg->type =3D=3D SCALAR_VALUE &&
- 	       tnum_is_const(subreg32 ? tnum_subreg(reg->var_off) : reg->var_off=
);
+ 	return reg->type =3D=3D SCALAR_VALUE && scalar_is_const(scalar_of(reg), =
subreg32);
  }
 =20
- /* assuming is_reg_const() is true, return constant value of a register */
- static u64 reg_const_value(struct bpf_reg_state *reg, bool subreg32)
+ /* assuming scalar_is_const() is true, return the constant */
+ static u64 scalar_const_value(const struct scalar *s, bool subreg32)
  {
- 	return subreg32 ? tnum_subreg(reg->var_off).value : reg->var_off.value;
+ 	return subreg32 ? tnum_subreg(s->var_off).value : s->var_off.value;
  }
 =20
  static bool is_pointer_regtype(enum bpf_reg_type type)
@@@ -3825,28 -3574,8 +3574,8 @@@ static bool __is_pointer_value(bool all
  	if (allow_ptr_leaks)
  		return false;
 =20
- 	return is_pointer_regtype(reg->type);
- }
-=20
- static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
- 					struct bpf_reg_state *src_reg)
- {
- 	if (src_reg->type !=3D SCALAR_VALUE)
- 		return;
- 	/*
- 	 * The verifier is processing rX =3D rY insn and
- 	 * rY->id has special linked register already.
- 	 * Cleared it, since multiple rX +=3D const are not supported.
- 	 */
- 	if (src_reg->id & BPF_ADD_CONST)
- 		clear_scalar_id(src_reg);
- 	/*
- 	 * Ensure that src_reg has a valid ID that will be copied to
- 	 * dst_reg and then will be used by sync_linked_regs() to
- 	 * propagate min/max range.
- 	 */
- 	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
- 		src_reg->id =3D ++env->id_gen;
+ 	/* an unreadable xreg can have a pointer */
+ 	return reg->type !=3D SCALAR_VALUE;
  }
 =20
  static void save_register_state(struct bpf_verifier_env *env,
@@@ -3875,14 -3604,21 +3604,21 @@@ static bool is_bpf_st_mem(struct bpf_in
  	return BPF_CLASS(insn->code) =3D=3D BPF_ST && BPF_MODE(insn->code) =3D=
=3D BPF_MEM;
  }
 =20
- static int get_reg_width(struct bpf_reg_state *reg)
+ /* See bpf_partition_for_pessimized() */
+ static void note_pessimized_insn(struct bpf_verifier_env *env, u32 idx)
  {
- 	return fls64(reg_umax(reg));
+ 	if (!env->imprecise)
+ 		return;
+ 	env->insn_aux_data[idx].pessimized =3D true;
+ 	env->pessimized =3D true;
+ 	if (!env->err)
+ 		env->err_insn =3D idx;
  }
 =20
  /* See comment for mark_fastcall_pattern_for_call() */
  static void check_fastcall_stack_contract(struct bpf_verifier_env *env,
- 					  struct bpf_func_state *state, int insn_idx, int off)
+ 					  struct bpf_func_state *state, int insn_idx, int off,
+ 					  bool var_off)
  {
  	struct bpf_subprog_info *subprog =3D &env->subprog_info[state->subprogno=
];
  	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
@@@ -3900,6 -3636,10 +3636,10 @@@
  	 * happens at most once per subprogram
  	 */
  	for (i =3D subprog->start; i < (subprog + 1)->start; ++i) {
+ 		/* the spills can be too much for the stack, see bpf_find_unproven_afte=
r_pass() */
+ 		aux[insn_idx].pessimized |=3D aux[i].fastcall_spills_num && env->imprec=
ise;
+ 		if (aux[i].fastcall_spills_num && var_off)
+ 			note_pessimized_insn(env, insn_idx);
  		aux[i].fastcall_spills_num =3D 0;
  		aux[i].fastcall_pattern =3D 0;
  	}
@@@ -3931,8 -3671,6 +3671,6 @@@ static int check_stack_write_fixed_off(
  	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE, err;
  	struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
  	struct bpf_reg_state *reg =3D NULL;
- 	int insn_flags =3D INSN_F_STACK_ACCESS;
- 	int hist_spi =3D spi, hist_frame =3D state->frameno;
  	struct bpf_stack_state *ss =3D bpf_stack_slot(state, spi);
 =20
  	/*
@@@ -3982,16 -3720,7 +3720,7 @@@
 =20
  	mark_stack_slot_scratched(env, spi);
  	if (reg && !(off % BPF_REG_SIZE) && reg->type =3D=3D SCALAR_VALUE && env=
->bpf_capable) {
- 		bool reg_value_fits;
-=20
- 		reg_value_fits =3D get_reg_width(reg) <=3D BITS_PER_BYTE * size;
- 		/* Make sure that reg had an ID to build a relation on spill. */
- 		if (reg_value_fits)
- 			assign_scalar_id_before_mov(env, reg);
  		save_register_state(env, state, spi, reg, size);
- 		/* Break the relation on a narrowing spill. */
- 		if (!reg_value_fits)
- 			clear_scalar_id(&ss->spilled_ptr);
  	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
  		   env->bpf_capable) {
  		struct bpf_reg_state *tmp_reg =3D &env->fake_reg[0];
@@@ -4000,8 -3729,13 +3729,13 @@@
  		__mark_reg_known(tmp_reg, insn->imm);
  		tmp_reg->type =3D SCALAR_VALUE;
  		save_register_state(env, state, spi, tmp_reg, size);
- 	} else if (reg && is_pointer_regtype(reg->type)) {
- 		/* register containing pointer is being spilled into stack */
+ 	} else if (reg && is_pointer_regtype(reg->type) &&
+ 		   (size =3D=3D BPF_REG_SIZE || !env->allow_ptr_leaks)) {
+ 		/*
+ 		 * register containing pointer is being spilled into stack.
+ 		 * A part of it is a number, which is fine when the program
+ 		 * may see values of pointers anyway.
+ 		 */
  		if (size !=3D BPF_REG_SIZE) {
  			verbose_linfo(env, insn_idx, "; ");
  			verbose(env, "invalid size of register spill\n");
@@@ -4014,36 -3748,33 +3748,33 @@@
  		save_register_state(env, state, spi, reg, size);
  	} else {
  		u8 type =3D STACK_MISC;
+ 		int keep =3D 0;
 =20
- 		if (bpf_is_spilled_reg(ss))
- 			bpf_diag_record_scrub(env, &ss->spilled_ptr,
- 					      BPF_DIAG_MOD_WRITE);
- 		scrub_special_slot(state, spi);
+ 		/* the bytes before the write still have the low bytes of a number */
+ 		if (bpf_is_spilled_scalar_reg(ss) && off % BPF_REG_SIZE)
+ 			keep =3D min_t(int, rounddown_pow_of_two(off & (BPF_REG_SIZE - 1)),
+ 				     bpf_spill_size(ss));
+ 		if (keep && bpf_stack_narrow_access_ok(0, keep, bpf_spill_size(ss))) {
+ 			for (i =3D 0; i < BPF_REG_SIZE - keep; i++)
+ 				if (ss->slot_type[i] =3D=3D STACK_SPILL)
+ 					ss->slot_type[i] =3D STACK_MISC;
+ 		} else {
+ 			if (bpf_is_spilled_reg(ss))
+ 				bpf_diag_record_scrub(env, &ss->spilled_ptr, BPF_DIAG_MOD_WRITE);
+ 			scrub_special_slot(state, spi);
+ 		}
 =20
  		/* when we zero initialize stack slots mark them as such */
  		if ((reg && bpf_register_is_null(reg)) ||
- 		    (!reg && is_bpf_st_mem(insn) && insn->imm =3D=3D 0)) {
- 			/* STACK_ZERO case happened because register spill
- 			 * wasn't properly aligned at the stack slot boundary,
- 			 * so it's not a register spill anymore; force
- 			 * originating register to be precise to make
- 			 * STACK_ZERO correct for subsequent states
- 			 */
- 			err =3D mark_chain_precision(env, value_regno);
- 			if (err)
- 				return err;
+ 		    (!reg && is_bpf_st_mem(insn) && insn->imm =3D=3D 0))
  			type =3D STACK_ZERO;
- 		}
 =20
  		/* Mark slots affected by this stack write. */
  		for (i =3D 0; i < size; i++)
  			ss->slot_type[(slot - i) % BPF_REG_SIZE] =3D type;
- 		insn_flags =3D 0; /* not a register spill */
+ 		return 0;
  	}
-=20
- 	if (insn_flags)
- 		return bpf_push_jmp_history(env, env->cur_state, insn_flags,
- 					    hist_spi, hist_frame, NULL, 0);
+ 	bpf_equations_spill(env, state, spi, value_regno);
  	return 0;
  }
 =20
@@@ -4077,16 -3808,17 +3808,17 @@@ static int check_stack_write_var_off(st
  	struct bpf_reg_state *value_reg =3D NULL;
  	struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
  	bool writing_zero =3D false;
- 	/* set if the fact that we're writing a zero is used to let any
- 	 * stack slots remain STACK_ZERO
- 	 */
- 	bool zero_used =3D false;
 =20
  	cur =3D env->cur_state->frame[env->cur_state->curframe];
  	min_off =3D reg_smin(ptr_reg) + off;
  	max_off =3D reg_smax(ptr_reg) + off + size;
  	if (value_regno >=3D 0)
  		value_reg =3D &cur->regs[value_regno];
+ 	/* no slot remembers the pointer, a load gets it as a number */
+ 	if (value_reg && __is_pointer_value(env->allow_ptr_leaks, value_reg)) {
+ 		verbose(env, "R%d leaks addr into stack\n", value_regno);
+ 		return -EACCES;
+ 	}
  	if ((value_reg && bpf_register_is_null(value_reg)) ||
  	    (!value_reg && is_bpf_st_mem(insn) && insn->imm =3D=3D 0))
  		writing_zero =3D true;
@@@ -4131,10 -3863,8 +3863,8 @@@
  		if (writing_zero && *stype =3D=3D STACK_SPILL && bpf_is_spilled_scalar_=
reg(ss)) {
  			struct bpf_reg_state *spill_reg =3D &ss->spilled_ptr;
 =20
- 			if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value =3D=
=3D 0) {
- 				zero_used =3D true;
+ 			if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value =3D=
=3D 0)
  				continue;
- 			}
  		}
 =20
  		/*
@@@ -4147,10 -3877,8 +3877,8 @@@
 =20
  		/* Update the slot type. */
  		new_type =3D STACK_MISC;
- 		if (writing_zero && *stype =3D=3D STACK_ZERO) {
+ 		if (writing_zero && *stype =3D=3D STACK_ZERO)
  			new_type =3D STACK_ZERO;
- 			zero_used =3D true;
- 		}
  		/* If the slot is STACK_INVALID, we check whether it's OK to
  		 * pretend that it will be initialized by this write. The slot
  		 * might not actually be written to, and so if we mark it as
@@@ -4168,12 -3896,6 +3896,6 @@@
  		}
  		*stype =3D new_type;
  	}
- 	if (zero_used) {
- 		/* backtracking doesn't work for STACK_ZERO yet. */
- 		err =3D mark_chain_precision(env, value_regno);
- 		if (err)
- 			return err;
- 	}
  	bpf_diag_record_scrub_stack(env, state, min_off, max_off,
  				    BPF_DIAG_MOD_VAR_WRITE);
  	return 0;
@@@ -4188,21 -3910,18 +3910,18 @@@
   * read.
   *
   * STACK_SPILL bytes backed by spilled scalar const zeroes are also consi=
dered
-  * zero bytes. In that case, mark the contributing stack slots precise so
-  * pruning cannot reuse a zero-spill state for a later non-zero spill sta=
te.
-  *
-  * Returns an error if precision backtracking fails.
+  * zero bytes.
   */
- static int mark_reg_stack_read(struct bpf_verifier_env *env,
- 			       /* func where src register points to */
- 			       struct bpf_func_state *ptr_state,
- 			       int min_off, int max_off, int dst_regno)
+ static void mark_reg_stack_read(struct bpf_verifier_env *env,
+ 				/* func where src register points to */
+ 				struct bpf_func_state *ptr_state,
+ 				int min_off, int max_off, int dst_regno)
  {
  	struct bpf_verifier_state *vstate =3D env->cur_state;
  	struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
  	int i, slot, spi;
  	u8 *stype;
- 	int zeros =3D 0, zero_spills =3D 0;
+ 	int zeros =3D 0;
 =20
  	for (i =3D min_off; i < max_off; i++) {
  		slot =3D -i - 1;
@@@ -4215,7 -3934,6 +3934,6 @@@
  		}
  		if (stype[slot % BPF_REG_SIZE] =3D=3D STACK_SPILL &&
  		    bpf_register_is_null(&bpf_stack_slot(ptr_state, spi)->spilled_ptr))=
 {
- 			zero_spills++;
  			zeros++;
  			continue;
  		}
@@@ -4225,23 -3943,11 +3943,11 @@@
  		/* Any access_size read into register is zero extended,
  		 * so the whole register =3D=3D const_zero.
  		 */
- 		__mark_reg_const_zero(env, &state->regs[dst_regno]);
- 		if (zero_spills) {
- 			for (i =3D min_off; i < max_off; i++) {
- 				slot =3D -i - 1;
- 				spi =3D slot / BPF_REG_SIZE;
- 				stype =3D bpf_stack_slot(ptr_state, spi)->slot_type;
- 				if (stype[slot % BPF_REG_SIZE] =3D=3D STACK_SPILL)
- 					bpf_bt_set_frame_slot(&env->bt, ptr_state->frameno, spi);
- 			}
- 			return mark_chain_precision_batch(env, env->cur_state);
- 		}
+ 		__mark_reg_const_zero(&state->regs[dst_regno]);
  	} else {
  		/* have read misc data from the stack */
  		mark_reg_unknown(env, state->regs, dst_regno);
  	}
-=20
- 	return 0;
  }
 =20
  static void bpf_diag_stack_read_invalid(struct bpf_verifier_env *env, int=
 off, int i, int size,
@@@ -4305,9 -4011,6 +4011,6 @@@ static int check_stack_read_fixed_off(s
  	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE;
  	struct bpf_reg_state *reg;
  	u8 *stype, type;
- 	int err;
- 	int insn_flags =3D INSN_F_STACK_ACCESS;
- 	int hist_spi =3D spi, hist_frame =3D reg_state->frameno;
  	struct bpf_stack_state *ss =3D bpf_stack_slot(reg_state, spi);
 =20
  	stype =3D ss->slot_type;
@@@ -4336,22 -4039,19 +4039,19 @@@
  				if (dst_regno < 0)
  					return 0;
 =20
- 				if (env->bpf_capable && size =3D=3D 4 && spill_size =3D=3D 4 &&
- 				    get_reg_width(reg) <=3D 32)
- 					/* Ensure stack slot has an ID to build a relation
- 					 * with the destination register on fill.
- 					 */
- 					assign_scalar_id_before_mov(env, reg);
+ 				/* coerce_scalar_to_size will adjust the boundaries. */
  				state->regs[dst_regno] =3D *reg;
-=20
- 				/* Break the relation on a narrowing fill.
- 				 * coerce_reg_to_size will adjust the boundaries.
- 				 */
- 				if (get_reg_width(reg) > size * BITS_PER_BYTE)
- 					clear_scalar_id(&state->regs[dst_regno]);
+ 				bpf_equations_fill(env, reg_state, spi, size);
  			} else {
+ 				/* the low bytes are from the spill */
+ 				bool fill_exceeds_spill =3D
+ 					size > spill_size && !(off % BPF_REG_SIZE) &&
+ 					!IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
  				int spill_cnt =3D 0, zero_cnt =3D 0;
 =20
+ 				if (fill_exceeds_spill)
+ 					bpf_equations_fill(env, reg_state, spi, spill_size);
+=20
  				for (i =3D 0; i < size; i++) {
  					type =3D stype[(slot - i) % BPF_REG_SIZE];
  					if (type =3D=3D STACK_SPILL) {
@@@ -4382,32 -4082,23 +4082,23 @@@
 =20
  				if (spill_cnt =3D=3D size &&
  				    tnum_is_const(reg->var_off) && reg->var_off.value =3D=3D 0) {
- 					__mark_reg_const_zero(env, &state->regs[dst_regno]);
- 					/* this IS register fill, so keep insn_flags */
+ 					__mark_reg_const_zero(&state->regs[dst_regno]);
  				} else if (zero_cnt =3D=3D size) {
  					/* similarly to mark_reg_stack_read(), preserve zeroes */
- 					__mark_reg_const_zero(env, &state->regs[dst_regno]);
- 					insn_flags =3D 0; /* not restoring original register state */
+ 					__mark_reg_const_zero(&state->regs[dst_regno]);
  				} else {
- 					err =3D mark_reg_stack_read(env, reg_state, off, off + size,
- 								  dst_regno);
- 					if (err)
- 						return err;
- 					insn_flags =3D 0; /* not restoring original register state */
+ 					mark_reg_stack_read(env, reg_state, off, off + size,
+ 							    dst_regno);
+ 					if (fill_exceeds_spill)
+ 						scalar_intersect(scalar_of(&state->regs[dst_regno]),
+ 								 scalar_of(reg),
+ 								 spill_size * BITS_PER_BYTE);
  				}
  			}
  		} else if (dst_regno >=3D 0) {
  			/* restore register state from stack */
- 			if (env->bpf_capable)
- 				/* Ensure stack slot has an ID to build a relation
- 				 * with the destination register on fill.
- 				 */
- 				assign_scalar_id_before_mov(env, reg);
  			state->regs[dst_regno] =3D *reg;
- 			/* mark reg as written since spilled pointer state likely
- 			 * has its liveness marks cleared by is_state_visited()
- 			 * which resets stack/reg liveness for state transitions
- 			 */
+ 			bpf_equations_fill(env, reg_state, spi, size);
  		} else if (__is_pointer_value(env->allow_ptr_leaks, reg)) {
  			/* If dst_regno=3D=3D-1, the caller is asking us whether
  			 * it is acceptable to use this value as a SCALAR_VALUE
@@@ -4438,16 -4129,9 +4129,9 @@@
  			}
  			return -EACCES;
  		}
- 		if (dst_regno >=3D 0) {
- 			err =3D mark_reg_stack_read(env, reg_state, off, off + size, dst_regno=
);
- 			if (err)
- 				return err;
- 		}
- 		insn_flags =3D 0; /* we are not restoring spilled register */
+ 		if (dst_regno >=3D 0)
+ 			mark_reg_stack_read(env, reg_state, off, off + size, dst_regno);
  	}
- 	if (insn_flags)
- 		return bpf_push_jmp_history(env, env->cur_state, insn_flags,
- 					    hist_spi, hist_frame, NULL, 0);
  	return 0;
  }
 =20
@@@ -4476,9 -4160,8 +4160,8 @@@ static struct bpf_reg_state *reg_state(
   * As opposed to check_stack_read_fixed_off, this function doesn't deal w=
ith
   * filling registers (i.e. reads of spilled register cannot be detected w=
hen
   * the offset is not fixed). We conservatively mark 'dst_regno' as contai=
ning
-  * SCALAR_VALUE. That's why we assert that the 'reg' has a variable
-  * offset; for a fixed offset check_stack_read_fixed_off should be used
-  * instead.
+  * SCALAR_VALUE. A fixed offset gets here only for a part of a spilled
+  * pointer, see check_stack_read().
   */
  static int check_stack_read_var_off(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg,
  				    argno_t ptr_argno, int off, int size, int dst_regno)
@@@ -4496,10 -4179,7 +4179,7 @@@
 =20
  	min_off =3D reg_smin(reg) + off;
  	max_off =3D reg_smax(reg) + off;
- 	err =3D mark_reg_stack_read(env, ptr_state, min_off, max_off + size,
- 				  dst_regno);
- 	if (err)
- 		return err;
+ 	mark_reg_stack_read(env, ptr_state, min_off, max_off + size, dst_regno);
  	return 0;
  }
 =20
@@@ -4517,6 -4197,7 +4197,7 @@@ static int check_stack_read(struct bpf_
  			    int dst_regno)
  {
  	struct bpf_func_state *state =3D bpf_func(env, reg);
+ 	struct bpf_stack_state *ss;
  	int err;
  	/* Some accesses are only permitted with a static offset. */
  	bool var_off =3D !tnum_is_const(reg->var_off);
@@@ -4550,6 -4231,11 +4231,11 @@@
  	 * just checking it here would be insufficient as speculative stack
  	 * writes could still lead to unsafe speculative behaviour.
  	 */
+ 	if (!var_off && dst_regno >=3D 0 && size !=3D BPF_REG_SIZE && env->allow=
_ptr_leaks) {
+ 		ss =3D bpf_stack_slot(state, (-off - reg->var_off.value - 1) / BPF_REG_=
SIZE);
+ 		/* a part of a pointer is a number, as with a variable offset */
+ 		var_off =3D bpf_is_spilled_reg(ss) && !bpf_is_spilled_scalar_reg(ss);
+ 	}
  	if (!var_off) {
  		off +=3D reg->var_off.value;
  		err =3D check_stack_read_fixed_off(env, state, off, size,
@@@ -4625,6 -4311,23 +4311,23 @@@ static int check_stack_write(struct bpf
  	return err;
  }
 =20
+ /*
+  * The function that is verified on its own has no caller to look at. Its=
 incoming
+  * arguments are in its stack_arg_regs until it is done with loading them.
+  */
+ static void end_stack_arg_loads(struct bpf_verifier_env *env, struct bpf_=
func_state *state)
+ {
+ 	int i;
+=20
+ 	if (state->no_stack_arg_load)
+ 		return;
+ 	state->no_stack_arg_load =3D true;
+ 	if (state->frameno)
+ 		return;
+ 	for (i =3D 0; i < state->out_stack_arg_cnt; i++)
+ 		bpf_mark_reg_not_init(env, &state->stack_arg_regs[i]);
+ }
+=20
  /*
   * Write a value to the outgoing stack arg area.
   * off is a negative offset from r11 (e.g. -8 for arg6, -16 for arg7).
@@@ -4632,24 -4335,31 +4335,31 @@@
  static int check_stack_arg_write(struct bpf_verifier_env *env, struct bpf=
_func_state *state,
  				 int off, struct bpf_reg_state *value_reg)
  {
- 	int max_stack_arg_regs =3D MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS;
+ 	int max_stack_arg_regs =3D MAX_STACK_ARG_SLOTS;
  	struct bpf_subprog_info *subprog =3D &env->subprog_info[state->subprogno=
];
  	int spi =3D -off / BPF_REG_SIZE - 1;
  	struct bpf_reg_state *arg;
  	int err;
 =20
+ 	/* BTF is not needed for stack arguments, so ask here. There is no load =
without a store. */
+ 	if (!bpf_jit_supports_stack_args()) {
+ 		verbose(env, "JIT does not support stack arguments\n");
+ 		return -EOPNOTSUPP;
+ 	}
+=20
  	if (spi >=3D max_stack_arg_regs) {
  		verbose(env, "stack arg write offset %d exceeds max %d stack args\n",
  			off, max_stack_arg_regs);
  		return -EINVAL;
  	}
 =20
+ 	end_stack_arg_loads(env, state);
  	err =3D grow_stack_arg_slots(env, state, spi + 1);
  	if (err)
  		return err;
 =20
  	/* Track the max outgoing stack arg slot count. */
- 	if (spi + 1 > subprog->max_out_stack_arg_cnt)
+ 	if (spi + 1 > subprog->max_out_stack_arg_cnt && !env->cur_state->specula=
tive)
  		subprog->max_out_stack_arg_cnt =3D spi + 1;
 =20
  	arg =3D &state->stack_arg_regs[spi];
@@@ -4663,9 -4373,7 +4373,7 @@@
  		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
  	}
  	bpf_diag_mod_end(env);
- 	state->no_stack_arg_load =3D true;
- 	return bpf_push_jmp_history(env, env->cur_state,
- 				    INSN_F_STACK_ARG_ACCESS, spi, 0, NULL, 0);
+ 	return 0;
  }
 =20
  /*
@@@ -4692,7 -4400,7 +4400,7 @@@ static int check_stack_arg_read(struct=20
  		return -EACCES;
  	}
 =20
- 	caller =3D vstate->frame[vstate->curframe - 1];
+ 	caller =3D vstate->frame[vstate->curframe ? vstate->curframe - 1 : 0];
  	arg =3D bpf_get_spilled_stack_arg(spi, caller);
  	if (!arg) {
  		verbose(env, "invalid read from uninitialized stack arg off %d\n", off);
@@@ -4703,26 -4411,7 +4411,7 @@@
  	bpf_diag_mod_begin(env, &cur->regs[dst_regno], arg, BPF_DIAG_MOD_WRITE);
  	cur->regs[dst_regno] =3D *arg;
  	bpf_diag_mod_end(env);
- 	return bpf_push_jmp_history(env, env->cur_state,
- 				    INSN_F_STACK_ARG_ACCESS, spi, 0, NULL, 0);
- }
-=20
- static int mark_stack_arg_precision(struct bpf_verifier_env *env, int arg=
_idx)
- {
- 	struct bpf_func_state *caller =3D cur_func(env);
- 	int spi =3D arg_idx - MAX_BPF_FUNC_REG_ARGS;
-=20
- 	bt_set_frame_stack_arg_slot(&env->bt, caller->frameno, spi);
- 	return mark_chain_precision_batch(env, env->cur_state);
- }
-=20
- static int mark_arg_precision(struct bpf_verifier_env *env, argno_t argno)
- {
- 	int regno =3D reg_from_argno(argno);
-=20
- 	if (regno >=3D 0)
- 		return mark_chain_precision(env, regno);
- 	return mark_stack_arg_precision(env, arg_idx_from_argno(argno));
+ 	return 0;
  }
 =20
  static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct=
 bpf_func_state *caller,
@@@ -4743,7 -4432,7 +4432,7 @@@
  				nargs, spi + 1);
  			bpf_diag_stack_arg_uninit(env, env->insn_idx, nargs, spi,
  						  callee_name, arg_name);
- 			return -EFAULT;
+ 			return -EINVAL;
  		}
  	}
 =20
@@@ -5027,6 -4716,7 +4716,7 @@@ bad_type
  	verbose(env, "invalid kptr access, R%d type=3D%s%s ", regno,
  		reg_type_str(env, reg->type), reg_name);
  	verbose(env, "expected=3D%s%s", reg_type_str(env, PTR_TO_BTF_ID), targ_n=
ame);
+ 	bpf_note_needs_ptr(env, reg);
  	if (kptr_field->type =3D=3D BPF_KPTR_UNREF)
  		verbose(env, " or %s%s\n", reg_type_str(env, PTR_TO_BTF_ID | PTR_UNTRUS=
TED),
  			targ_name);
@@@ -5134,7 -4824,7 +4824,7 @@@ static int mark_uptr_ld_reg(struct bpf_
  	reg =3D reg_state(env, regno);
  	reg->type =3D PTR_TO_MEM | PTR_MAYBE_NULL;
  	reg->mem_size =3D t->size;
- 	reg->id =3D ++env->id_gen;
+ 	reg->id =3D bpf_new_id(env);
 =20
  	return 0;
  }
@@@ -5187,14 -4877,8 +4877,8 @@@ static int check_map_kptr_access(struc
  			return ret;
  	} else if (class =3D=3D BPF_STX) {
  		val_reg =3D reg_state(env, value_regno);
- 		if (bpf_register_is_null(val_reg)) {
- 			/*
- 			 * This store is valid only because the scalar is known to be
- 			 * zero. Mark it precise so another scalar cannot be pruned
- 			 * against this state.
- 			 */
- 			return mark_chain_precision(env, value_regno);
- 		}
+ 		if (bpf_register_is_null(val_reg))
+ 			return 0;
  		if (map_kptr_match_type(env, kptr_field, val_reg, value_regno))
  			return -EACCES;
  	} else if (class =3D=3D BPF_ST) {
@@@ -5239,48 -4923,43 +4923,43 @@@ static int check_map_access(struct bpf_
  	if (IS_ERR_OR_NULL(map->record))
  		return 0;
  	rec =3D map->record;
- 	for (i =3D 0; i < rec->cnt; i++) {
+ 	/* If any part of a field can be touched by load/store, reject this prog=
ram. */
+ 	for (i =3D btf_record_first_field(rec, reg_smin(reg) + off);
+ 	     i < rec->cnt && rec->fields[i].offset < reg_umax(reg) + off + size;=
 i++) {
  		struct btf_field *field =3D &rec->fields[i];
  		u32 p =3D field->offset;
 =20
- 		/* If any part of a field  can be touched by load/store, reject
- 		 * this program. To check that [x1, x2) overlaps with [y1, y2),
- 		 * it is sufficient to check x1 < y2 && y1 < x2.
- 		 */
- 		if (reg_smin(reg) + off < p + field->size &&
- 		    p < reg_umax(reg) + off + size) {
- 			switch (field->type) {
- 			case BPF_KPTR_UNREF:
- 			case BPF_KPTR_REF:
- 			case BPF_KPTR_PERCPU:
- 			case BPF_UPTR:
- 				if (src !=3D ACCESS_DIRECT) {
- 					verbose(env, "%s cannot be accessed indirectly by helper\n",
- 						btf_field_type_name(field->type));
- 					return -EACCES;
- 				}
- 				if (!tnum_is_const(reg->var_off)) {
- 					verbose(env, "%s access cannot have variable offset\n",
- 						btf_field_type_name(field->type));
- 					return -EACCES;
- 				}
- 				if (p !=3D off + reg->var_off.value) {
- 					verbose(env, "%s access misaligned expected=3D%u off=3D%llu\n",
- 						btf_field_type_name(field->type),
- 						p, off + reg->var_off.value);
- 					return -EACCES;
- 				}
- 				if (size !=3D bpf_size_to_bytes(BPF_DW)) {
- 					verbose(env, "%s access size must be BPF_DW\n",
- 						btf_field_type_name(field->type));
- 					return -EACCES;
- 				}
- 				break;
- 			default:
- 				verbose(env, "%s cannot be accessed directly by load/store\n",
+ 		switch (field->type) {
+ 		case BPF_KPTR_UNREF:
+ 		case BPF_KPTR_REF:
+ 		case BPF_KPTR_PERCPU:
+ 		case BPF_UPTR:
+ 			if (src !=3D ACCESS_DIRECT) {
+ 				verbose(env, "%s cannot be accessed indirectly by helper\n",
  					btf_field_type_name(field->type));
  				return -EACCES;
  			}
+ 			if (!tnum_is_const(reg->var_off)) {
+ 				verbose(env, "%s access cannot have variable offset\n",
+ 					btf_field_type_name(field->type));
+ 				return -EACCES;
+ 			}
+ 			if (p !=3D off + reg->var_off.value) {
+ 				verbose(env, "%s access misaligned expected=3D%u off=3D%llu\n",
+ 					btf_field_type_name(field->type),
+ 					p, off + reg->var_off.value);
+ 				return -EACCES;
+ 			}
+ 			if (size !=3D bpf_size_to_bytes(BPF_DW)) {
+ 				verbose(env, "%s access size must be BPF_DW\n",
+ 					btf_field_type_name(field->type));
+ 				return -EACCES;
+ 			}
+ 			break;
+ 		default:
+ 			verbose(env, "%s cannot be accessed directly by load/store\n",
+ 				btf_field_type_name(field->type));
+ 			return -EACCES;
  		}
  	}
  	return 0;
@@@ -5361,6 -5040,17 +5040,17 @@@ static bool is_var_ctx_off_allowed(stru
  	return resolve_prog_type(prog) =3D=3D BPF_PROG_TYPE_SYSCALL;
  }
 =20
+ /* The id of the reference that came with __ref argument @arg. 0 if there=
 is none. */
+ static u32 ctx_arg_ref_id(const struct bpf_verifier_state *st, u32 arg)
+ {
+ 	u32 i;
+=20
+ 	for (i =3D 0; arg && i < st->acquired_refs; i++)
+ 		if (st->refs[i].type =3D=3D REF_TYPE_PTR && st->refs[i].ctx_arg =3D=3D =
arg)
+ 			return st->refs[i].id;
+ 	return 0;
+ }
+=20
  /* check access to 'struct bpf_context' fields.  Supports fixed offsets o=
nly */
  static int __check_ctx_access(struct bpf_verifier_env *env, int insn_idx,=
 int off, int size,
  			      enum bpf_access_type t, struct bpf_insn_access_aux *info)
@@@ -5375,8 -5065,7 +5065,7 @@@
  		 * type of narrower access.
  		 */
  		if (base_type(info->reg_type) =3D=3D PTR_TO_BTF_ID) {
- 			if (info->ref_id &&
- 			    !find_reference_state(env->cur_state, info->ref_id)) {
+ 			if (info->ref_arg && !ctx_arg_ref_id(env->cur_state, info->ref_arg)) {
  				verbose(env, "invalid bpf_context access off=3D%d. Reference may alre=
ady be released\n",
  					off);
  				return -EACCES;
@@@ -5742,6 -5431,15 +5431,15 @@@ static enum priv_stack_mode bpf_enable_
  	 */
  	switch (prog->type) {
  	case BPF_PROG_TYPE_KPROBE:
+ 		/*
+ 		 * Uprobes are preemptible and lack recursion protection. Classic
+ 		 * kprobe and uprobe progs have no expected attach type, so enable
+ 		 * private stacks only for kprobe.multi and kprobe.session progs.
+ 		 */
+ 		if (prog->expected_attach_type !=3D BPF_TRACE_KPROBE_MULTI &&
+ 		    prog->expected_attach_type !=3D BPF_TRACE_KPROBE_SESSION)
+ 			return NO_PRIV_STACK;
+ 		fallthrough;
  	case BPF_PROG_TYPE_TRACEPOINT:
  	case BPF_PROG_TYPE_PERF_EVENT:
  	case BPF_PROG_TYPE_RAW_TRACEPOINT:
@@@ -5770,322 -5468,682 +5468,682 @@@ static int round_up_stack_depth(struc=
t=20
  	return round_up(max_t(u32, stack_depth, 1), 32);
  }
 =20
- /* temporary state used for call frame depth calculation */
- struct bpf_subprog_call_depth_info {
- 	int ret_insn; /* caller instruction where we return to. */
- 	int caller; /* caller subprogram idx */
- 	int frame; /* # of consecutive static call stack frames on top of stack =
*/
- 	int callx_insn; /* callx instruction whose callees are being walked */
- 	int callx_next; /* next callee of callx_insn to walk */
- 	bool via_callx; /* the subprogram is entered via callx */
+ enum {
+ 	CG_LIVE		=3D BIT(0), /* what the kernel calls and what that gets to */
+ 	CG_IN_CB	=3D BIT(1), /* callbacks and what they get to */
+ 	CG_IN_ASYNC_CB	=3D BIT(2), /* async callbacks and what they get to */
+ 	CG_IN_RECURSION	=3D BIT(3), /* recursive subprogs and what they get to */
+ 	CG_TAIL_CALL	=3D BIT(4), /* subprogs that get to a tail call */
+ 	CG_ARENA_SP	=3D BIT(5), /* subprogs that get to r12 */
+ 	CG_CB		=3D BIT(6),
+ 	CG_GLOBAL	=3D BIT(7),
  };
 =20
- /* starting from main bpf function walk all instructions of the function
-  * and recursively walk all callees that given function can call.
-  * Ignore jump and exit insns.
+ #define for_each_marked_subprog(cg, s, mark) \
+ 	for (s =3D 0; s < (cg)->cnt; s++) if (!((cg)->marks[s] & (mark))) {} else
+=20
+ /*
+  * Who calls whom. It's known after the main verification pass, which fin=
ds out
+  * what callx and the helpers that take callbacks call, and what is dead =
code.
+  *
+  * What follows for a subprog from its callers, or from what it calls, is=
 computed
+  * over this graph and not by a walk of one chain of calls after another:=
 the
+  * number of chains grows exponentially, and there is no end to them when=
 subprogs
+  * call themselves.
   */
- static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, in=
t idx,
- 					 struct bpf_subprog_call_depth_info *dinfo,
- 					 bool priv_stack_supported)
+ static int build_call_graph(struct bpf_verifier_env *env, struct bpf_call=
_graph *cg)
  {
- 	struct bpf_subprog_info *subprog =3D env->subprog_info;
+ 	struct bpf_subprog_info *si =3D env->subprog_info;
  	struct bpf_insn *insn =3D env->prog->insnsi;
- 	int depth =3D 0, frame =3D 0, i, subprog_end, subprog_depth;
- 	bool tail_call_reachable =3D false;
- 	int total;
- 	int tmp;
+ 	int cnt =3D env->subprog_cnt, i, s, err;
 =20
- 	/* no caller idx */
- 	dinfo[idx].caller =3D -1;
- 	dinfo[idx].via_callx =3D false;
+ 	err =3D bpf_call_graph_init(cg, cnt);
+ 	for (s =3D 0; s < cnt; s++) {
+ 		for (i =3D si[s].start; i < si[s + 1].start && !err; i++)
+ 			if (bpf_pseudo_call(insn + i) && env->insn_aux_data[i].seen)
+ 				err =3D bpf_call_graph_add(cg, s, bpf_find_subprog(env,
+ 							 i + insn[i].imm + 1));
+ 		/* the callees of callx and the callbacks of helpers */
+ 		for (i =3D si[s].callx_edge; i && !err; i =3D env->callx_edges[i - 1].n=
ext)
+ 			err =3D bpf_call_graph_add(cg, s, env->callx_edges[i - 1].callee);
+ 	}
+ 	if (err)
+ 		return err;
+ 	bpf_call_graph_sort(cg, 0);
 =20
- 	i =3D subprog[idx].start;
- 	if (!priv_stack_supported)
- 		subprog[idx].priv_stack_mode =3D NO_PRIV_STACK;
- process_func:
- 	dinfo[idx].callx_insn =3D -1;
- 	if (subprog[idx].has_ld_abs) {
- 		for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller) {
- 			if (subprog[tmp].is_cb) {
- 				verbose(env, "cannot use BPF_LD_[ABS|IND] within callback\n");
+ 	for (s =3D 0; s < cnt; s++)
+ 		if (!s || si[s].is_async_cb)
+ 			cg->marks[s] =3D CG_LIVE;
+ 	bpf_call_graph_mark_callees(cg, CG_LIVE);
+ 	for_each_marked_subprog(cg, s, CG_LIVE)
+ 		cg->marks[s] |=3D (si[s].is_cb ? CG_CB | CG_IN_CB : 0) |
+ 				(si[s].is_async_cb ? CG_IN_ASYNC_CB : 0) |
+ 				(bpf_call_graph_recursive(cg, s) ? CG_IN_RECURSION : 0) |
+ 				(si[s].has_tail_call ? CG_TAIL_CALL : 0) |
+ 				(si[s].uses_arena_sp ? CG_ARENA_SP : 0) |
+ 				(bpf_subprog_is_global(env, s) ? CG_GLOBAL : 0);
+ 	bpf_call_graph_mark_callees(cg, CG_IN_CB | CG_IN_ASYNC_CB | CG_IN_RECURS=
ION);
+ 	bpf_call_graph_mark_callers(cg, CG_TAIL_CALL, 0);
+ 	return 0;
+ }
+=20
+ static bool subprog_calls(struct bpf_call_graph *cg, u32 caller, u32 call=
ee)
+ {
+ 	u32 j;
+=20
+ 	bpf_for_each_callee(cg, caller, j)
+ 		if (j =3D=3D callee)
+ 			return true;
+ 	return false;
+ }
+=20
+ /* the insn of subprog 'caller' that is the edge to subprog 'callee' */
+ static int find_call_insn(struct bpf_verifier_env *env, int caller, int c=
allee)
+ {
+ 	struct bpf_subprog_info *si =3D env->subprog_info;
+ 	struct bpf_insn *insn =3D env->prog->insnsi;
+ 	int i, end =3D si[caller + 1].start;
+=20
+ 	for (i =3D si[caller].start; i < end; i++)
+ 		if (bpf_pseudo_call(insn + i) && i + insn[i].imm + 1 =3D=3D si[callee].=
start)
+ 			return i;
+ 	/* It's not recorded which callx or helper calls what. Take the first on=
e. */
+ 	for (i =3D si[caller].start; i < end - 1; i++)
+ 		if (bpf_is_callx(insn + i) || bpf_calls_callback(env, i))
+ 			break;
+ 	return i;
+ }
+=20
+ /* The exception callback is an async callback, so only a call is an edge=
 to it */
+ static int check_exception_cb(struct bpf_verifier_env *env, struct bpf_ca=
ll_graph *cg)
+ {
+ 	int cb =3D env->exception_callback_subprog, s;
+=20
+ 	for_each_marked_subprog(cg, s, CG_LIVE) {
+ 		if (!cb || !subprog_calls(cg, s, cb))
+ 			continue;
+ 		verbose(env, "insn %d cannot call exception cb directly\n",
+ 			find_call_insn(env, s, cb));
+ 		return -EINVAL;
+ 	}
+ 	return 0;
+ }
+=20
+ static bool bpf_prog_reenters_datapath(const struct bpf_prog *prog);
+=20
+ /*
+  * Every subprog on a cycle has to check the stack at run time. mark_recu=
rsive_subprogs()
+  * didn't see the cycle coming when a helper got the callback from a tabl=
e of
+  * functions, or from another subprog. A subprog that it marked for callx=
, which turned out
+  * to call something else, needs no check.
+  */
+ static int check_recursion(struct bpf_verifier_env *env, struct bpf_call_=
graph *cg)
+ {
+ 	bool reenters =3D bpf_prog_reenters_datapath(env->prog);
+ 	int j, s;
+=20
+ 	for_each_marked_subprog(cg, s, CG_LIVE) {
+ 		if (!bpf_call_graph_recursive(cg, s)) {
+ 			env->subprog_info[s].recursive =3D false;
+ 			continue;
+ 		}
+ 		if (env->subprog_info[s].recursive) {
+ 			/*
+ 			 * These progs run on top of other progs. Their frames belong in the
+ 			 * private stack, which has room for one frame of a subprog. A kprobe =
prog
+ 			 * that can be attached to a uprobe has no private stack, and is no be=
tter.
+ 			 */
+ 			if ((bpf_enable_priv_stack(env->prog) !=3D NO_PRIV_STACK ||
+ 			     env->prog->type =3D=3D BPF_PROG_TYPE_KPROBE) &&
+ 			    !env->prog->aux->priv_stack_requested) {
+ 				verbose(env, "recursive %s() in a tracing program\n",
+ 					bpf_subprog_name(env, s));
  				return -EINVAL;
  			}
- 		}
- 	}
-=20
- 	/* protect against potential stack overflow that might happen when
- 	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
- 	 * depth for such case down to 256 so that the worst case scenario
- 	 * would result in 8k stack size (32 which is tailcall limit * 256 =3D
- 	 * 8k).
- 	 *
- 	 * To get the idea what might happen, see an example:
- 	 * func1 -> sub rsp, 128
- 	 *  subfunc1 -> sub rsp, 256
- 	 *  tailcall1 -> add rsp, 256
- 	 *   func2 -> sub rsp, 192 (total stack size =3D 128 + 192 =3D 320)
- 	 *   subfunc2 -> sub rsp, 64
- 	 *   subfunc22 -> sub rsp, 128
- 	 *   tailcall2 -> add rsp, 128
- 	 *    func3 -> sub rsp, 32 (total stack size 128 + 192 + 64 + 32 =3D 416)
- 	 *
- 	 * tailcall will unwind the current stack frame but it will not get rid
- 	 * of caller's stack as shown on the example above.
- 	 */
- 	if (idx && subprog[idx].has_tail_call && depth >=3D 256) {
- 		verbose(env,
- 			"tail_calls are not allowed when call stack of previous frames is %d b=
ytes. Too large\n",
- 			depth);
- 		return -EACCES;
- 	}
-=20
- 	subprog_depth =3D round_up_stack_depth(env, subprog[idx].stack_depth);
- 	if (IS_ENABLED(CONFIG_X86_64) && subprog[idx].stack_arg_cnt) {
- 		/* x86-64 uses R9 for both private stack frame pointer and arg6. */
- 		subprog[idx].priv_stack_mode =3D NO_PRIV_STACK;
- 	} else if (priv_stack_supported) {
- 		/* Request private stack support only if the subprog stack
- 		 * depth is no less than BPF_PRIV_STACK_MIN_SIZE. This is to
- 		 * avoid jit penalty if the stack usage is small.
- 		 */
- 		if (subprog[idx].priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN &&
- 		    subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE)
- 			subprog[idx].priv_stack_mode =3D PRIV_STACK_ADAPTIVE;
- 	}
-=20
- 	if (subprog[idx].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE) {
- 		if (subprog_depth > env->max_stack_depth)
- 			env->max_stack_depth =3D subprog_depth;
- 		if (subprog_depth > env->stack_limit) {
- 			verbose(env, "stack size of subprog %d is %d. Too large\n",
- 				idx, subprog_depth);
- 			return -EACCES;
- 		}
- 	} else {
- 		depth +=3D subprog_depth;
- 		if (depth > env->max_stack_depth)
- 			env->max_stack_depth =3D depth;
- 		if (depth > env->stack_limit) {
- 			total =3D 0;
- 			for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller)
- 				total++;
-=20
- 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
- 				total, depth);
- 			return -EACCES;
- 		}
- 	}
- continue_func:
- 	subprog_end =3D subprog[idx + 1].start;
- 	for (; i < subprog_end; i++) {
- 		int next_insn, sidx;
-=20
- 		if (bpf_pseudo_kfunc_call(insn + i) && !insn[i].off &&
- 		    bpf_is_throw_kfunc(insn + i)) {
- 			bool err =3D false;
-=20
- 			for (tmp =3D idx; tmp >=3D 0 && !err; tmp =3D dinfo[tmp].caller) {
- 				if (subprog[tmp].is_cb) {
- 					err =3D true;
- 					break;
- 				}
+ 			/* It runs on top of its own frames. The half of the stack is not enou=
gh. */
+ 			if (reenters) {
+ 				verbose(env, "recursive %s() in a program that calls bpf_clone_redire=
ct()\n",
+ 					bpf_subprog_name(env, s));
+ 				return -EINVAL;
  			}
- 			if (!err)
+ 			if (bpf_prog_has_invocation_budget(env->prog))
+ 				continue;
+ 			verbose(env, "JIT does not support recursive calls\n");
+ 			return -EOPNOTSUPP;
+ 		}
+ 		/* the last call of the cycle */
+ 		for (j =3D 0; cg->cycle[j] !=3D cg->cycle[s] || !subprog_calls(cg, j, s=
); j++)
+ 			;
+ 		verbose(env, "recursive call from %s() to %s()\n",
+ 			bpf_subprog_name(env, j), bpf_subprog_name(env, s));
+ 		bpf_diag_program_structure(
+ 			env, find_call_insn(env, j, s), "recursive subprogram call",
+ 			"Load the address of the callback in the subprogram that passes it to =
the helper, or rewrite the recursion as a loop.",
+ 			"This call or callback closes a cycle of the call graph that was not s=
een before the main pass: "
+ 			"the callback comes from a table of functions or from another subprogr=
am. Nothing checks the stack.");
+ 		return -EINVAL;
+ 	}
+ 	return 0;
+ }
+=20
+ static int check_callbacks(struct bpf_verifier_env *env, struct bpf_call_=
graph *cg)
+ {
+ 	struct bpf_subprog_info *si =3D env->subprog_info;
+ 	struct bpf_insn *insn =3D env->prog->insnsi;
+ 	int i, s;
+=20
+ 	for_each_marked_subprog(cg, s, CG_IN_CB) {
+ 		if (si[s].has_ld_abs) {
+ 			verbose(env, "cannot use BPF_LD_[ABS|IND] within callback\n");
+ 			return -EINVAL;
+ 		}
+ 		for (i =3D si[s].start; i < si[s + 1].start; i++) {
+ 			if (!bpf_is_throw_kfunc(insn + i) || !env->insn_aux_data[i].seen)
  				continue;
  			verbose(env,
  				"bpf_throw kfunc (insn %d) cannot be called from callback subprog %d\=
n",
- 				i, idx);
+ 				i, s);
  			return -EINVAL;
  		}
+ 	}
+ 	return 0;
+ }
 =20
- 		if (bpf_is_callx(insn + i) || bpf_calls_callback(env, i)) {
- 			/*
- 			 * Walk the callees and the callbacks recorded by
- 			 * the main verification pass one by one, returning to
- 			 * this insn after each.
- 			 */
- 			if (dinfo[idx].callx_insn !=3D i) {
- 				dinfo[idx].callx_insn =3D i;
- 				dinfo[idx].callx_next =3D 0;
- 			}
- 			sidx =3D next_callx_callee(env, idx, dinfo[idx].callx_next);
- 			if (sidx < 0)
- 				continue;
- 			dinfo[idx].callx_next =3D sidx + 1;
- 			dinfo[idx].ret_insn =3D i;
- 			next_insn =3D subprog[sidx].start;
- 		} else if (bpf_pseudo_call(insn + i) || bpf_pseudo_func(insn + i)) {
- 			/* find the callee */
- 			next_insn =3D i + insn[i].imm + 1;
- 			sidx =3D bpf_find_subprog(env, next_insn);
- 			if (verifier_bug_if(sidx < 0, env, "callee not found at insn %d", next=
_insn))
- 				return -EFAULT;
- 			if (subprog[sidx].is_async_cb) {
- 				/* async callbacks don't increase bpf prog stack size unless called d=
irectly */
- 				if (!bpf_pseudo_call(insn + i))
- 					continue;
- 				if (subprog[sidx].is_exception_cb) {
- 					verbose(env, "insn %d cannot call exception cb directly", i);
- 					return -EINVAL;
- 				}
- 			}
- 			/* remember insn to return to */
- 			dinfo[idx].ret_insn =3D i + 1;
- 		} else {
+ /*
+  * Mark the subprogs that get to a tail call as tail call reachable subpr=
ogs;
+  * this info will be utilized by JIT so that we will be preserving the
+  * tail call counter throughout bpf2bpf calls combined with tailcalls
+  */
+ static int check_tail_calls(struct bpf_verifier_env *env, struct bpf_call=
_graph *cg)
+ {
+ 	struct bpf_subprog_info *si =3D env->subprog_info;
+ 	int s;
+=20
+ 	for_each_marked_subprog(cg, s, CG_LIVE) {
+ 		if (!(cg->marks[s] & CG_TAIL_CALL))
  			continue;
+ 		if (si[s].is_cb) {
+ 			verbose(env, "cannot tail call within callback\n");
+ 			return -EINVAL;
+ 		}
+ 		if (si[s].stack_arg_cnt) {
+ 			verbose(env, "tail_calls are not allowed in programs with stack args\n=
");
+ 			return -EINVAL;
+ 		}
+ 		/*
+ 		 * JITs pass tail call counter in a register that is
+ 		 * not available when the callee is called via callx.
+ 		 */
+ 		if (si[s].via_callx) {
+ 			verbose(env, "tail_calls are not allowed in functions called via callx=
\n");
+ 			return -EINVAL;
+ 		}
+ 		si[s].tail_call_reachable =3D true;
+ 	}
+ 	if (si[0].tail_call_reachable)
+ 		env->prog->aux->tail_call_reachable =3D true;
+ 	return 0;
+ }
+=20
+ /*
+  * The kernel calls a callback. It knows nothing about r12. So a callback=
 takes a
+  * stack in arena, like the main prog does, when it uses r12 or calls what
+  * does. The callbacks below it are not its business: they take their own.
+  */
+ static void mark_arena_stack_entries(struct bpf_verifier_env *env, struct=
 bpf_call_graph *cg)
+ {
+ 	int s;
+=20
+ 	bpf_call_graph_sort(cg, CG_CB);
+ 	bpf_call_graph_mark_callers(cg, CG_ARENA_SP, CG_CB);
+ 	for_each_marked_subprog(cg, s, CG_CB)
+ 		env->subprog_info[s].arena_stack_entry =3D cg->marks[s] & CG_ARENA_SP;
+ }
+=20
+ /* temporary state used for call frame depth calculation */
+ struct bpf_subprog_call_depth_info {
+ 	int calls; /* the number of frames that take the most on the stack */
+ 	int depth; /* the most that the frames of the callers take */
+ 	int arena_depth; /* the same in the stack in arena */
+ 	int frame; /* the most consecutive static call stack frames on top of st=
ack */
+ };
+=20
+ /* what the frame of the subprog adds to the frames of its callers */
+ static int subprog_stack_size(struct bpf_verifier_env *env, int s)
+ {
+ 	struct bpf_subprog_info *sub =3D &env->subprog_info[s];
+=20
+ 	if (sub->priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE)
+ 		return 0;
+ 	return round_up_stack_depth(env, sub->stack_depth);
+ }
+=20
+ static void max_call_depth(struct bpf_subprog_call_depth_info *to,
+ 			   const struct bpf_subprog_call_depth_info *from)
+ {
+ 	if (from->depth > to->depth || !to->calls) {
+ 		to->depth =3D max(to->depth, from->depth);
+ 		to->calls =3D from->calls;
+ 	}
+ 	to->arena_depth =3D max(to->arena_depth, from->arena_depth);
+ }
+=20
+ /*
+  * A subprog is entered with no more than what one of its callers is ente=
red with plus
+  * the frame of that caller. Not when both are recursive: the callee chec=
ks the stack at run
+  * time. A cycle adds nothing: all subprogs on it have the same.
+  * The count of frames starts anew in a global subprog.
+  */
+ static void compute_call_depth(struct bpf_verifier_env *env, struct bpf_c=
all_graph *cg,
+ 			       struct bpf_subprog_call_depth_info *dinfo)
+ {
+ 	struct bpf_subprog_call_depth_info in, out, *callee;
+ 	struct bpf_subprog_info *si =3D env->subprog_info;
+ 	u32 start, end, i, j, s;
+ 	int frame;
+=20
+ 	memset(dinfo, 0, cg->cnt * sizeof(*dinfo));
+ 	bpf_call_graph_sort(cg, 0);
+ 	for (end =3D cg->cnt; end; end =3D start) {
+ 		start =3D cg->cycle[cg->order[end - 1]];
+ 		for (i =3D start, in =3D dinfo[cg->order[i]]; i < end; i++)
+ 			max_call_depth(&in, &dinfo[cg->order[i]]);
+ 		for (i =3D start; i < end; i++) {
+ 			s =3D cg->order[i];
+ 			if (!(cg->marks[s] & CG_LIVE))
+ 				continue;
+ 			bpf_for_each_callee(cg, s, j) {
+ 				out =3D in;
+ 				out.calls++;
+ 				if (!si[s].recursive || !si[j].recursive) {
+ 					out.depth +=3D subprog_stack_size(env, s);
+ 					out.arena_depth +=3D si[s].arena_stack_depth;
+ 				}
+ 				max_call_depth(&dinfo[j], &out);
+ 			}
+ 		}
+ 	}
+=20
+ 	bpf_call_graph_sort(cg, CG_GLOBAL);
+ 	for (end =3D cg->cnt; end; end =3D start) {
+ 		start =3D cg->cycle[cg->order[end - 1]];
+ 		for (i =3D start, frame =3D 0; i < end; i++)
+ 			frame =3D max(frame, dinfo[cg->order[i]].frame);
+ 		for (i =3D start; i < end; i++) {
+ 			bpf_for_each_callee(cg, cg->order[i], j) {
+ 				callee =3D &dinfo[j];
+ 				if (!(cg->marks[cg->order[i]] & CG_LIVE) ||
+ 				    (cg->marks[j] & CG_GLOBAL))
+ 					continue;
+ 				callee->frame =3D max(callee->frame, frame + !si[j].recursive);
+ 			}
+ 		}
+ 	}
+ }
+=20
+ /*
+  * The stack in arena has no check of its own, see bpf_insert_recursion_c=
hecks(). A frame
+  * of a recursive subprog takes at least the same part of a half of the k=
ernel stack as of the
+  * room in the stack in arena: there is room in arena for the frames that=
 pass the check. The
+  * last of them and the one that doesn't pass come on top.
+  *
+  * Returns 1 when frames in the kernel stack grew.
+  */
+ static int pad_recursive_frames(struct bpf_verifier_env *env, struct bpf_=
call_graph *cg,
+ 				struct bpf_subprog_call_depth_info *dinfo)
+ {
+ 	struct bpf_subprog_info *si =3D env->subprog_info;
+ 	u32 arena_frame =3D 0, depth =3D 0, room, frame;
+ 	int s;
+=20
+ 	for_each_marked_subprog(cg, s, CG_LIVE) {
+ 		depth =3D max_t(u32, depth, dinfo[s].arena_depth + si[s].arena_stack_de=
pth);
+ 		if (si[s].recursive)
+ 			arena_frame =3D max(arena_frame, si[s].arena_stack_depth);
+ 	}
+ 	if (!arena_frame)
+ 		return 0;
+ 	if (depth + 2 * arena_frame >=3D BPF_ARENA_STACK_MAX)
+ 		goto no_room;
+ 	room =3D BPF_ARENA_STACK_MAX - depth - 2 * arena_frame;
+ 	env->max_arena_stack_depth =3D BPF_ARENA_STACK_MAX;
+=20
+ 	for_each_marked_subprog(cg, s, CG_LIVE) {
+ 		if (!si[s].recursive)
+ 			continue;
+ 		frame =3D DIV_ROUND_UP(si[s].arena_stack_depth * (THREAD_SIZE / 2), roo=
m);
+ 		if (frame > env->stack_limit)
+ 			goto no_room;
+ 		si[s].stack_depth =3D max(si[s].stack_depth, frame);
+ 	}
+ 	return 1;
+ no_room:
+ 	verbose(env, "no room in the stack in arena for recursion\n");
+ 	return -EACCES;
+ }
+=20
+ static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call=
_graph *cg)
+ {
+ 	struct bpf_subprog_info *si =3D env->subprog_info;
+ 	struct bpf_subprog_call_depth_info *dinfo;
+ 	int depth, s, err;
+=20
+ 	dinfo =3D kvzalloc_objs(*dinfo, cg->cnt, BPF_VERIFIER_GFP);
+ 	if (!dinfo)
+ 		return -ENOMEM;
+ 	compute_call_depth(env, cg, dinfo);
+ 	err =3D pad_recursive_frames(env, cg, dinfo);
+ 	if (err < 0)
+ 		goto out;
+ 	if (err)
+ 		compute_call_depth(env, cg, dinfo);
+=20
+ 	for_each_marked_subprog(cg, s, CG_LIVE) {
+ 		/* A caller of it is over a limit. That one is reported, not what it ca=
lls. */
+ 		if (dinfo[s].frame > MAX_CALL_FRAMES || dinfo[s].depth > env->stack_lim=
it ||
+ 		    dinfo[s].arena_depth > BPF_ARENA_STACK_MAX)
+ 			continue;
+=20
+ 		err =3D -E2BIG;
+ 		if (dinfo[s].frame >=3D MAX_CALL_FRAMES) {
+ 			verbose(env, "the call stack of %d frames is too deep !\n",
+ 				dinfo[s].frame);
+ 			goto out;
+ 		}
+=20
+ 		err =3D -EOPNOTSUPP;
+ 		if (dinfo[s].frame >=3D MAX_CALL_FRAMES_INTERP) {
+ 			if (!env->prog->jit_requested) {
+ 				verbose(env, "JIT is required for a call stack of more than %d frames=
\n",
+ 					MAX_CALL_FRAMES_INTERP);
+ 				goto out;
+ 			}
+ 			env->prog->jit_required =3D true;
+ 		}
+=20
+ 		err =3D -EACCES;
+ 		depth =3D dinfo[s].arena_depth + si[s].arena_stack_depth;
+ 		if (depth > env->max_arena_stack_depth)
+ 			env->max_arena_stack_depth =3D depth;
+ 		if (depth > BPF_ARENA_STACK_MAX) {
+ 			verbose(env, "combined size of the frames in the stack in arena is %d.=
 Too large\n",
+ 				depth);
+ 			goto out;
  		}
 =20
  		/*
- 		 * sort_subprogs_topo() tolerates cycles in the call graph that
- 		 * go through the address of a function being taken, since it
- 		 * doesn't know what it is taken for. Such cycle is a recursion
- 		 * unless it's an async callback, which are skipped above.
- 		 * The main verification pass limits the depth of the recursion,
- 		 * but it doesn't follow calls of global functions.
+ 		 * protect against potential stack overflow that might happen when
+ 		 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
+ 		 * depth for such case down to 256 so that the worst case scenario
+ 		 * would result in 8k stack size (32 which is tailcall limit * 256 =3D
+ 		 * 8k).
+ 		 *
+ 		 * To get the idea what might happen, see an example:
+ 		 * func1 -> sub rsp, 128
+ 		 *  subfunc1 -> sub rsp, 256
+ 		 *  tailcall1 -> add rsp, 256
+ 		 *   func2 -> sub rsp, 192 (total stack size =3D 128 + 192 =3D 320)
+ 		 *   subfunc2 -> sub rsp, 64
+ 		 *   subfunc22 -> sub rsp, 128
+ 		 *   tailcall2 -> add rsp, 128
+ 		 *    func3 -> sub rsp, 32 (total stack size 128 + 192 + 64 + 32 =3D 41=
6)
+ 		 *
+ 		 * tailcall will unwind the current stack frame but it will not get rid
+ 		 * of caller's stack as shown on the example above.
  		 */
- 		for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller) {
- 			if (tmp !=3D sidx)
- 				continue;
- 			verbose(env, "recursive call from %s() to %s()\n",
- 				bpf_subprog_name(env, idx), bpf_subprog_name(env, sidx));
- 			bpf_diag_program_structure(
- 				env, i, "recursive subprogram call",
- 				"Rewrite the recursion as an explicit bounded loop, or split the logi=
c so subprogram calls do not form a cycle.",
- 				"This call or callback would make the subprogram call graph recursive=
=2E "
- 				"The verifier requires a finite, acyclic call graph so it can bound s=
tack depth and analysis.");
- 			return -EINVAL;
+ 		depth =3D dinfo[s].depth;
+ 		/* nor of the frames of recursive subprogs, see bpf_insert_recursion_ch=
ecks() */
+ 		si[s].in_recursion =3D cg->marks[s] & CG_IN_RECURSION;
+ 		if (si[s].in_recursion)
+ 			depth +=3D THREAD_SIZE / 2;
+ 		if (s && si[s].has_tail_call && depth >=3D 256) {
+ 			verbose(env,
+ 				"tail_calls are not allowed when call stack of previous frames is %d =
bytes. Too large\n",
+ 				depth);
+ 			goto out;
  		}
 =20
- 		/* store caller info for after we return from callee */
- 		dinfo[idx].frame =3D frame;
-=20
- 		/* push caller idx into callee's dinfo */
- 		dinfo[sidx].caller =3D idx;
- 		dinfo[sidx].via_callx =3D bpf_is_callx(insn + i);
-=20
- 		i =3D next_insn;
-=20
- 		idx =3D sidx;
- 		if (!priv_stack_supported)
- 			subprog[idx].priv_stack_mode =3D NO_PRIV_STACK;
-=20
- 		/* sync tail_call_reachable with callee state on entry */
- 		tail_call_reachable =3D subprog[idx].has_tail_call;
-=20
- 		frame =3D bpf_subprog_is_global(env, idx) ? 0 : frame + 1;
- 		if (frame >=3D MAX_CALL_FRAMES) {
- 			verbose(env, "the call stack of %d frames is too deep !\n",
- 				frame);
- 			return -E2BIG;
+ 		if (si[s].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE) {
+ 			depth =3D round_up_stack_depth(env, si[s].stack_depth);
+ 			if (depth > env->max_stack_depth)
+ 				env->max_stack_depth =3D depth;
+ 			if (depth > env->stack_limit) {
+ 				verbose(env, "stack size of subprog %d is %d. Too large\n",
+ 					s, depth);
+ 				goto out;
+ 			}
+ 			continue;
+ 		}
+ 		depth =3D dinfo[s].depth + subprog_stack_size(env, s);
+ 		if (depth > env->max_stack_depth)
+ 			env->max_stack_depth =3D depth;
+ 		if (depth > env->stack_limit) {
+ 			verbose(env, "combined stack size of %d calls is %d. Too large\n",
+ 				dinfo[s].calls + 1, depth);
+ 			goto out;
  		}
- 		goto process_func;
  	}
- 	/* if tail call got detected across bpf2bpf calls then mark each of the
- 	 * currently present subprog frames as tail call reachable subprogs;
- 	 * this info will be utilized by JIT so that we will be preserving the
- 	 * tail call counter throughout bpf2bpf calls combined with tailcalls
- 	 */
- 	if (tail_call_reachable) {
- 		for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller) {
- 			if (subprog[tmp].is_cb) {
- 				verbose(env, "cannot tail call within callback\n");
- 				return -EINVAL;
+ 	err =3D 0;
+ out:
+ 	kvfree(dinfo);
+ 	return err;
+ }
+=20
+ /*
+  * The address of the callback at @idx goes nowhere but to a helper that =
keeps it for
+  * later: a timer, a work queue, call_rcu.
+  */
+ static bool func_is_kept_for_later(struct bpf_verifier_env *env, int idx,=
 int end)
+ {
+ 	struct bpf_insn *insn =3D env->prog->insnsi;
+ 	u8 class, reg =3D insn[idx].dst_reg;
+ 	int i;
+=20
+ 	if (reg < BPF_REG_1 || reg > BPF_REG_5)
+ 		return false;
+ 	for (i =3D idx + 2; i < end; i++) {
+ 		class =3D BPF_CLASS(insn[i].code);
+ 		if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32)
+ 			return bpf_is_async_callback_calling_insn(&insn[i]);
+ 		if (insn[i].dst_reg =3D=3D reg)
+ 			return false;
+ 		if (bpf_is_ldimm64(&insn[i]))
+ 			i++;
+ 		else if (insn[i].src_reg =3D=3D reg)
+ 			return false;
+ 	}
+ 	return false;
+ }
+=20
+ /*
+  * Find the subprogs on cycles of the call graph. It is not known yet wha=
t callx
+  * calls: it may be any subprog whose address is taken. A subprog that is
+  * marked for no reason is treated like a recursive one all the same.
+  */
+ static int mark_recursive_subprogs(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_subprog_info *si =3D env->subprog_info;
+ 	struct bpf_insn *insn =3D env->prog->insnsi;
+ 	int cnt =3D env->subprog_cnt, i, j, s, err;
+ 	struct bpf_call_graph cg;
+ 	bool plain_callx =3D false;
+=20
+ 	/* callx calls node 'cnt', which calls each subprog whose address is tak=
en */
+ 	err =3D bpf_call_graph_init(&cg, cnt + 1);
+ 	for (s =3D 0; s < cnt; s++) {
+ 		for (i =3D si[s].start; i < si[s + 1].start && !err; i++) {
+ 			if (bpf_is_callx(&insn[i])) {
+ 				err =3D bpf_call_graph_add(&cg, s, cnt);
+ 				if (!bpf_is_unwind_goto(&insn[i + 1]))
+ 					plain_callx =3D true;
  			}
- 			if (subprog[tmp].stack_arg_cnt) {
- 				verbose(env, "tail_calls are not allowed in programs with stack args\=
n");
- 				return -EINVAL;
+ 			if (bpf_pseudo_call(&insn[i]) || bpf_pseudo_func(&insn[i])) {
+ 				j =3D bpf_find_subprog(env, i + insn[i].imm + 1);
+ 				if (j < 0)
+ 					continue;
+ 				/*
+ 				 * The first insns of the main prog are for the kernel. A call from
+ 				 * an async callback is on no cycle.
+ 				 */
+ 				if (!j && bpf_pseudo_call(&insn[i])) {
+ 					verbose(env, "recursive call of the main program\n");
+ 					err =3D -EINVAL;
+ 					goto out;
+ 				}
+ 				/* the helper that calls a callback doesn't expect it to unwind */
+ 				if (bpf_pseudo_func(&insn[i]) || !bpf_is_unwind_goto(&insn[i + 1]))
+ 					si[j].plain_call =3D true;
+ 				/*
+ 				 * The helper that takes a callback calls it, or keeps it: the
+ 				 * callback that arms itself again doesn't call itself.
+ 				 */
+ 				if (bpf_pseudo_call(&insn[i]) ||
+ 				    !func_is_kept_for_later(env, i, si[s + 1].start))
+ 					err =3D bpf_call_graph_add(&cg, s, j);
+ 				if (bpf_pseudo_func(&insn[i]))
+ 					si[j].addr_taken =3D true;
  			}
- 			/*
- 			 * JITs pass tail call counter in a register that is
- 			 * not available when the callee is called via callx.
- 			 */
- 			if (dinfo[tmp].via_callx) {
- 				verbose(env, "tail_calls are not allowed in functions called via call=
x\n");
- 				return -EINVAL;
- 			}
- 			subprog[tmp].tail_call_reachable =3D true;
+ 			if (bpf_is_ldimm64(&insn[i]))
+ 				i++;
  		}
- 	} else if (!idx && subprog[0].has_tail_call && subprog[0].stack_arg_cnt)=
 {
- 		verbose(env, "tail_calls are not allowed in programs with stack args\n"=
);
- 		return -EINVAL;
+ 	}
+ 	for (i =3D 0; i < env->func_ptr_cnt; i++) {
+ 		j =3D bpf_find_subprog(env, env->func_ptrs[i].xlated_off);
+ 		if (j >=3D 0)
+ 			si[j].addr_taken =3D true;
+ 	}
+ 	for (s =3D 0; s < cnt && !err; s++)
+ 		if (si[s].addr_taken)
+ 			err =3D bpf_call_graph_add(&cg, cnt, s);
+ 	if (err)
+ 		goto out;
+=20
+ 	/*
+ 	 * Callers of a global subprog look at can_unwind before the subprog is =
verified.
+ 	 * The main prog returns to the kernel.
+ 	 */
+ 	for (s =3D 0; s < cnt; s++) {
+ 		if (plain_callx && si[s].addr_taken)
+ 			si[s].plain_call =3D true;
+ 		si[s].bail_unwinds =3D si[s].can_unwind ||
+ 				     (s && !si[s].plain_call && !bpf_subprog_is_global(env, s) &&
+ 				      bpf_jit_supports_unwind() &&
+ 				      !bpf_prog_is_offloaded(env->prog->aux));
  	}
 =20
- 	if (subprog[0].tail_call_reachable)
- 		env->prog->aux->tail_call_reachable =3D true;
+ 	bpf_call_graph_sort(&cg, 0);
 =20
- 	/* end of for() loop means the last insn of the 'subprog'
- 	 * was reached. Doesn't matter whether it was JA or EXIT
- 	 */
- 	if (frame =3D=3D 0 && dinfo[idx].caller < 0)
- 		return 0;
- 	if (subprog[idx].priv_stack_mode !=3D PRIV_STACK_ADAPTIVE)
- 		depth -=3D round_up_stack_depth(env, subprog[idx].stack_depth);
-=20
- 	/* pop caller idx from callee */
- 	idx =3D dinfo[idx].caller;
-=20
- 	/* retrieve caller state from its frame */
- 	frame =3D dinfo[idx].frame;
- 	i =3D dinfo[idx].ret_insn;
-=20
- 	/* reset tail_call_reachable to the parent's actual state */
- 	tail_call_reachable =3D subprog[idx].tail_call_reachable;
-=20
- 	goto continue_func;
+ 	for (s =3D 0; s < cnt; s++) {
+ 		if (!bpf_call_graph_recursive(&cg, s))
+ 			continue;
+ 		err =3D -EINVAL;
+ 		if (!s) {
+ 			verbose(env, "recursive call of the main program\n");
+ 			break;
+ 		}
+ 		/*
+ 		 * Each call of the function that it replaces is an invocation of its o=
wn: a
+ 		 * loop in the prog that it extends gets a new time slice each time.
+ 		 */
+ 		if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT) {
+ 			verbose(env, "recursive %s() in an extension\n", bpf_subprog_name(env,=
 s));
+ 			break;
+ 		}
+ 		/* the device runs the insns that the driver was given, without the che=
cks */
+ 		if (bpf_prog_is_offloaded(env->prog->aux)) {
+ 			verbose(env, "recursive %s() in an offloaded program\n",
+ 				bpf_subprog_name(env, s));
+ 			break;
+ 		}
+ 		if (si[s].has_tail_call || si[s].has_ld_abs) {
+ 			verbose(env, "recursive %s() cannot have %s\n", bpf_subprog_name(env, =
s),
+ 				si[s].has_tail_call ? "tail calls" : "LD_ABS");
+ 			break;
+ 		}
+ 		if (si[s].bail_insn < 0) {
+ 			verbose(env, "recursive %s() has no exit\n", bpf_subprog_name(env, s));
+ 			break;
+ 		}
+ 		si[s].recursive =3D true;
+ 		j =3D cg.cycle[s];
+ 		si[s].cycle =3D cg.order[j] =3D min_t(u32, cg.order[j], s);
+ 		err =3D 0;
+ 	}
+ out:
+ 	bpf_call_graph_free(&cg);
+ 	return err;
  }
 =20
  static int check_max_stack_depth(struct bpf_verifier_env *env)
  {
  	enum priv_stack_mode priv_stack_mode =3D PRIV_STACK_UNKNOWN;
- 	struct bpf_subprog_call_depth_info *dinfo;
  	struct bpf_subprog_info *si =3D env->subprog_info;
- 	bool priv_stack_supported;
- 	int ret;
+ 	struct bpf_call_graph cg;
+ 	int s, ret;
 =20
- 	dinfo =3D kvzalloc_objs(*dinfo, env->subprog_cnt, GFP_KERNEL_ACCOUNT);
- 	if (!dinfo)
- 		return -ENOMEM;
+ 	find_subprog_properties(env, true);
+ 	/* see bpf_remove_fastcall_spills_fills() */
+ 	for (s =3D 0; s < env->subprog_cnt; s++)
+ 		for (int i =3D si[s].start; i < si[s + 1].start && !si[s].keep_fastcall=
_stack; i++)
+ 			if (env->insn_aux_data[i].fastcall_spills_num)
+ 				si[s].stack_depth =3D -si[s].fastcall_stack_off;
 =20
  	for (int i =3D 0; i < env->subprog_cnt; i++) {
  		if (si[i].has_tail_call) {
+ 			/* the stack in arena wouldn't be returned */
+ 			if (env->uses_arena_sp) {
+ 				verbose(env, "tail_calls are not allowed in programs that use R%d\n",
+ 					BPF_REG_ARENA_SP);
+ 				return -EINVAL;
+ 			}
  			priv_stack_mode =3D NO_PRIV_STACK;
  			break;
  		}
  	}
+ 	/* x86 JIT has one register for both */
+ 	if (env->uses_arena_sp)
+ 		priv_stack_mode =3D NO_PRIV_STACK;
 =20
  	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
  		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
 =20
- 	/* All async_cb subprogs use normal kernel stack. If a particular
- 	 * subprog appears in both main prog and async_cb subtree, that
- 	 * subprog will use normal kernel stack to avoid potential nesting.
- 	 * The reverse subprog traversal ensures when main prog subtree is
- 	 * checked, the subprogs appearing in async_cb subtrees are already
- 	 * marked as using normal kernel stack, so stack size checking can
- 	 * be done properly.
- 	 */
- 	for (int i =3D env->subprog_cnt - 1; i >=3D 0; i--) {
- 		if (!i || si[i].is_async_cb) {
- 			priv_stack_supported =3D !i && priv_stack_mode =3D=3D PRIV_STACK_ADAPT=
IVE;
- 			ret =3D check_max_stack_depth_subprog(env, i, dinfo,
- 					priv_stack_supported);
- 			if (ret < 0) {
- 				kvfree(dinfo);
- 				return ret;
- 			}
- 		}
- 	}
+ 	ret =3D build_call_graph(env, &cg);
+ 	ret =3D ret ?: check_exception_cb(env, &cg);
+ 	ret =3D ret ?: check_recursion(env, &cg);
+ 	ret =3D ret ?: check_callbacks(env, &cg);
+ 	ret =3D ret ?: check_tail_calls(env, &cg);
+ 	if (ret)
+ 		goto out;
+ 	mark_arena_stack_entries(env, &cg);
 =20
- 	for (int i =3D 0; i < env->subprog_cnt; i++) {
- 		if (si[i].priv_stack_mode =3D=3D PRIV_STACK_ADAPTIVE) {
+ 	for_each_marked_subprog(&cg, s, CG_LIVE) {
+ 		/*
+ 		 * All async_cb subprogs use normal kernel stack. If a particular
+ 		 * subprog appears in both main prog and async_cb subtree, that
+ 		 * subprog will use normal kernel stack to avoid potential nesting.
+ 		 * The private stack has room for one frame of a subprog.
+ 		 * x86-64 uses R9 for both private stack frame pointer and arg6.
+ 		 */
+ 		if (priv_stack_mode !=3D PRIV_STACK_ADAPTIVE || (cg.marks[s] & CG_IN_AS=
YNC_CB) ||
+ 		    si[s].recursive || (IS_ENABLED(CONFIG_X86_64) && si[s].stack_arg_cn=
t)) {
+ 			si[s].priv_stack_mode =3D NO_PRIV_STACK;
+ 			continue;
+ 		}
+ 		/*
+ 		 * Request private stack support only if the subprog stack
+ 		 * depth is no less than BPF_PRIV_STACK_MIN_SIZE. This is to
+ 		 * avoid jit penalty if the stack usage is small.
+ 		 */
+ 		if (round_up_stack_depth(env, si[s].stack_depth) >=3D BPF_PRIV_STACK_MI=
N_SIZE) {
+ 			si[s].priv_stack_mode =3D PRIV_STACK_ADAPTIVE;
  			env->prog->aux->jits_use_priv_stack =3D true;
- 			break;
  		}
  	}
 =20
- 	kvfree(dinfo);
-=20
- 	return 0;
+ 	ret =3D check_call_depth(env, &cg);
+ out:
+ 	bpf_call_graph_free(&cg);
+ 	return ret;
  }
 =20
  static int __check_buffer_access(struct bpf_verifier_env *env,
@@@ -6159,59 -6217,64 +6217,64 @@@ static int check_buffer_access(struct b
  	return 0;
  }
 =20
- /* BPF architecture zero extends alu32 ops into 64-bit registesr */
- static void zext_32_to_64(struct bpf_reg_state *reg)
+ /* s =3D (u32)s. BPF architecture zero extends alu32 ops into 64-bit regi=
sters. */
+ static void scalar_zext32(struct scalar *s)
  {
- 	reg_step_check_unsigned(reg, 32);
- 	reg->var_off =3D tnum_subreg(reg->var_off);
- 	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
+ 	scalar_step_check_unsigned(s, 32);
+ 	s->var_off =3D tnum_subreg(s->var_off);
+ 	s->r64 =3D cnum64_zext32(s->r32);
  }
 =20
- /* truncate register to smaller size (in bytes)
+ /* truncate to smaller size (in bytes)
   * must be called with size < BPF_REG_SIZE
   */
- static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
+ static void coerce_scalar_to_size(struct scalar *s, int size)
  {
  	u64 mask =3D (1ULL << (size * 8)) - 1;
 =20
- 	reg_step_check_unsigned(reg, size * 8);
+ 	scalar_step_check_unsigned(s, size * 8);
 =20
  	/* clear high bits in bit representation */
- 	reg->var_off =3D tnum_cast(reg->var_off, size);
+ 	s->var_off =3D tnum_cast(s->var_off, size);
 =20
  	/* fix arithmetic bounds */
- 	if ((reg_umin(reg) & ~mask) =3D=3D (reg_umax(reg) & ~mask))
- 		reg_set_urange64(reg, reg_umin(reg) & mask, reg_umax(reg) & mask);
+ 	if ((cnum64_umin(s->r64) & ~mask) =3D=3D (cnum64_umax(s->r64) & ~mask))
+ 		s->r64 =3D cnum64_from_urange(cnum64_umin(s->r64) & mask, cnum64_umax(s=
->r64) & mask);
  	else
- 		reg_set_urange64(reg, 0, mask);
+ 		s->r64 =3D cnum64_from_urange(0, mask);
 =20
  	/* If size is smaller than 32bit register the 32bit register
  	 * values are also truncated so we push 64-bit bounds into
  	 * 32-bit bounds. Above were truncated < 32-bits already.
  	 */
  	if (size < 4)
- 		__mark_reg32_unbounded(reg);
+ 		__mark_scalar32_unbounded(s);
 =20
- 	reg_bounds_sync(reg);
+ 	scalar_bounds_sync(s);
  }
 =20
- static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
+ static void set_sext64_default_val(struct scalar *s, int size)
  {
  	if (size =3D=3D 1) {
- 		reg_set_srange64(reg, S8_MIN, S8_MAX);
- 		reg_set_srange32(reg, S8_MIN, S8_MAX);
+ 		s->r64 =3D cnum64_from_srange(S8_MIN, S8_MAX);
+ 		s->r32 =3D cnum32_from_srange(S8_MIN, S8_MAX);
  	} else if (size =3D=3D 2) {
- 		reg_set_srange64(reg, S16_MIN, S16_MAX);
- 		reg_set_srange32(reg, S16_MIN, S16_MAX);
+ 		s->r64 =3D cnum64_from_srange(S16_MIN, S16_MAX);
+ 		s->r32 =3D cnum32_from_srange(S16_MIN, S16_MAX);
  	} else {
  		/* size =3D=3D 4 */
- 		reg_set_srange64(reg, S32_MIN, S32_MAX);
- 		reg_set_srange32(reg, S32_MIN, S32_MAX);
+ 		s->r64 =3D cnum64_from_srange(S32_MIN, S32_MAX);
+ 		s->r32 =3D cnum32_from_srange(S32_MIN, S32_MAX);
  	}
- 	reg->var_off =3D tnum_unknown;
  }
 =20
- static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
+ /* The low @num_bits bits do not change. The other bits are copies of the=
 sign. */
+ static struct tnum tnum_sext(struct tnum t, u32 num_bits)
+ {
+ 	return tnum_arshift(tnum_lshift(t, 64 - num_bits), 64 - num_bits, 64);
+ }
+=20
+ static void coerce_scalar_to_size_sx(struct scalar *s, int size)
  {
  	s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
  	u64 top_smax_value, top_smin_value;
@@@ -6220,44 -6283,45 +6283,45 @@@
  	struct cnum32 r32;
 =20
  	/* If every value fits the signed N-bit range sign extension is a noop. =
*/
- 	if (reg_smin(reg) >=3D -limit && reg_smax(reg) < limit)
+ 	if (cnum64_smin(s->r64) >=3D -limit && cnum64_smax(s->r64) < limit)
  		return;
 =20
- 	/* See commen at reg_step_check_unsigned(). */
- 	reg_step_reset(reg);
+ 	/* See comment at scalar_step_check_unsigned(). */
+ 	scalar_step_reset(s);
 =20
- 	if (tnum_is_const(reg->var_off)) {
- 		u64_cval =3D reg->var_off.value;
+ 	if (tnum_is_const(s->var_off)) {
+ 		u64_cval =3D s->var_off.value;
  		if (size =3D=3D 1)
- 			reg->var_off =3D tnum_const((s8)u64_cval);
+ 			s->var_off =3D tnum_const((s8)u64_cval);
  		else if (size =3D=3D 2)
- 			reg->var_off =3D tnum_const((s16)u64_cval);
+ 			s->var_off =3D tnum_const((s16)u64_cval);
  		else
  			/* size =3D=3D 4 */
- 			reg->var_off =3D tnum_const((s32)u64_cval);
+ 			s->var_off =3D tnum_const((s32)u64_cval);
 =20
- 		u64_cval =3D reg->var_off.value;
- 		reg->r64 =3D cnum64_from_urange(u64_cval, u64_cval);
- 		reg->r32 =3D cnum32_from_urange((u32)u64_cval, (u32)u64_cval);
+ 		u64_cval =3D s->var_off.value;
+ 		s->r64 =3D cnum64_const(u64_cval);
+ 		s->r32 =3D cnum32_const(u64_cval);
  		return;
  	}
 =20
- 	top_smax_value =3D ((u64)reg_smax(reg) >> num_bits) << num_bits;
- 	top_smin_value =3D ((u64)reg_smin(reg) >> num_bits) << num_bits;
+ 	s->var_off =3D tnum_sext(s->var_off, num_bits);
+ 	top_smax_value =3D ((u64)cnum64_smax(s->r64) >> num_bits) << num_bits;
+ 	top_smin_value =3D ((u64)cnum64_smin(s->r64) >> num_bits) << num_bits;
 =20
  	if (top_smax_value !=3D top_smin_value)
  		goto out;
 =20
  	/* find the s64_min and s64_min after sign extension */
  	if (size =3D=3D 1) {
- 		init_s64_max =3D (s8)reg_smax(reg);
- 		init_s64_min =3D (s8)reg_smin(reg);
+ 		init_s64_max =3D (s8)cnum64_smax(s->r64);
+ 		init_s64_min =3D (s8)cnum64_smin(s->r64);
  	} else if (size =3D=3D 2) {
- 		init_s64_max =3D (s16)reg_smax(reg);
- 		init_s64_min =3D (s16)reg_smin(reg);
+ 		init_s64_max =3D (s16)cnum64_smax(s->r64);
+ 		init_s64_min =3D (s16)cnum64_smin(s->r64);
  	} else {
- 		init_s64_max =3D (s32)reg_smax(reg);
- 		init_s64_min =3D (s32)reg_smin(reg);
+ 		init_s64_max =3D (s32)cnum64_smax(s->r64);
+ 		init_s64_min =3D (s32)cnum64_smin(s->r64);
  	}
 =20
  	s64_max =3D max(init_s64_max, init_s64_min);
@@@ -6265,86 -6329,100 +6329,100 @@@
 =20
  	/* both of s64_max/s64_min positive or negative */
  	if ((s64_max >=3D 0) =3D=3D (s64_min >=3D 0)) {
- 		reg_set_srange64(reg, s64_min, s64_max);
- 		reg_set_srange32(reg, s64_min, s64_max);
- 		reg->var_off =3D tnum_range(s64_min, s64_max);
+ 		s->r64 =3D cnum64_from_srange(s64_min, s64_max);
+ 		s->r32 =3D cnum32_from_srange(s64_min, s64_max);
+ 		scalar_bounds_sync(s);
  		return;
  	}
 =20
  out:
- 	r32 =3D reg->r32;
- 	set_sext64_default_val(reg, size);
+ 	r32 =3D s->r32;
+ 	set_sext64_default_val(s, size);
  	/* the low 32 bits fit, they do not change */
  	if (cnum32_smin(r32) >=3D -limit && cnum32_smax(r32) < limit) {
- 		reg->r32 =3D r32;
- 		reg->r64 =3D cnum64_from_srange(cnum32_smin(r32), cnum32_smax(r32));
+ 		s->r32 =3D r32;
+ 		s->r64 =3D cnum64_from_srange(cnum32_smin(r32), cnum32_smax(r32));
  	}
+ 	scalar_bounds_sync(s);
  }
 =20
- static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
+ static void set_sext32_default_val(struct scalar *s, int size)
  {
  	if (size =3D=3D 1)
- 		reg_set_srange32(reg, S8_MIN, S8_MAX);
+ 		s->r32 =3D cnum32_from_srange(S8_MIN, S8_MAX);
  	else
  		/* size =3D=3D 2 */
- 		reg_set_srange32(reg, S16_MIN, S16_MAX);
- 	reg->var_off =3D tnum_subreg(tnum_unknown);
+ 		s->r32 =3D cnum32_from_srange(S16_MIN, S16_MAX);
  }
 =20
- static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
+ static void coerce_subreg_to_size_sx(struct scalar *s, int size)
  {
  	s32 init_s32_max, init_s32_min, s32_max, s32_min, u32_val;
+ 	s32 field_smin, field_smax;
  	u32 top_smax_value, top_smin_value;
  	u32 num_bits =3D size * 8;
 =20
+ 	if (size =3D=3D 1) {
+ 		field_smin =3D S8_MIN;
+ 		field_smax =3D S8_MAX;
+ 	} else {
+ 		/* size =3D=3D 2 */
+ 		field_smin =3D S16_MIN;
+ 		field_smax =3D S16_MAX;
+ 	}
+=20
  	/*
- 	 * If value fits the non-negative half of the signed N-bit range,
- 	 * sign extension is a noop.
+ 	 * The range already fits the signed N-bit range, so (sN)v =3D=3D v for =
every
+ 	 * value of the low 32 bits and the sign extension is a no-op.
+ 	 *
+ 	 * This has to precede scalar_step_reset() below: the base/step line sta=
ys.
+ 	 * It is about all 64 bits: scalar_zext32() in the caller discards it
+ 	 * if the upper 32 bits are not zero.
  	 */
- 	if (reg_umax(reg) < (1ULL << (num_bits - 1)))
+ 	if (cnum32_smin(s->r32) >=3D field_smin && cnum32_smax(s->r32) <=3D fiel=
d_smax)
  		return;
 =20
- 	/* See comment at reg_step_check_unsigned(). */
- 	reg_step_reset(reg);
+ 	/* See comment at scalar_step_check_unsigned(). */
+ 	scalar_step_reset(s);
 =20
- 	if (tnum_is_const(reg->var_off)) {
- 		u32_val =3D reg->var_off.value;
+ 	if (tnum_is_const(s->var_off)) {
+ 		u32_val =3D s->var_off.value;
  		if (size =3D=3D 1)
- 			reg->var_off =3D tnum_const((s8)u32_val);
+ 			s->var_off =3D tnum_const((s8)u32_val);
  		else
- 			reg->var_off =3D tnum_const((s16)u32_val);
+ 			s->var_off =3D tnum_const((s16)u32_val);
 =20
- 		u32_val =3D reg->var_off.value;
- 		reg_set_srange32(reg, u32_val, u32_val);
+ 		u32_val =3D s->var_off.value;
+ 		s->r32 =3D cnum32_from_srange(u32_val, u32_val);
  		return;
  	}
 =20
- 	top_smax_value =3D ((u32)reg_s32_max(reg) >> num_bits) << num_bits;
- 	top_smin_value =3D ((u32)reg_s32_min(reg) >> num_bits) << num_bits;
+ 	s->var_off =3D tnum_sext(s->var_off, num_bits);
+ 	top_smax_value =3D ((u32)cnum32_smax(s->r32) >> num_bits) << num_bits;
+ 	top_smin_value =3D ((u32)cnum32_smin(s->r32) >> num_bits) << num_bits;
 =20
  	if (top_smax_value !=3D top_smin_value)
  		goto out;
 =20
  	/* find the s32_min and s32_min after sign extension */
  	if (size =3D=3D 1) {
- 		init_s32_max =3D (s8)reg_s32_max(reg);
- 		init_s32_min =3D (s8)reg_s32_min(reg);
+ 		init_s32_max =3D (s8)cnum32_smax(s->r32);
+ 		init_s32_min =3D (s8)cnum32_smin(s->r32);
  	} else {
  		/* size =3D=3D 2 */
- 		init_s32_max =3D (s16)reg_s32_max(reg);
- 		init_s32_min =3D (s16)reg_s32_min(reg);
+ 		init_s32_max =3D (s16)cnum32_smax(s->r32);
+ 		init_s32_min =3D (s16)cnum32_smin(s->r32);
  	}
  	s32_max =3D max(init_s32_max, init_s32_min);
  	s32_min =3D min(init_s32_max, init_s32_min);
 =20
  	if ((s32_min >=3D 0) =3D=3D (s32_max >=3D 0)) {
- 		reg_set_srange32(reg, s32_min, s32_max);
- 		reg->var_off =3D tnum_subreg(tnum_range(s32_min, s32_max));
+ 		s->r32 =3D cnum32_from_srange(s32_min, s32_max);
  		return;
  	}
 =20
  out:
- 	set_sext32_default_val(reg, size);
+ 	set_sext32_default_val(s, size);
  }
 =20
  bool bpf_map_is_rdonly(const struct bpf_map *map)
@@@ -6400,17 -6478,6 +6478,6 @@@ int bpf_map_direct_read(struct bpf_map=20
  	return 0;
  }
 =20
- static int cmp_func_ptrs(const void *_a, const void *_b)
- {
- 	const struct bpf_func_ptr *a =3D _a, *b =3D _b;
-=20
- 	if (a->map !=3D b->map)
- 		return a->map < b->map ? -1 : 1;
- 	if (a->map_off !=3D b->map_off)
- 		return a->map_off < b->map_off ? -1 : 1;
- 	return 0;
- }
-=20
  /* Find the first pointer to a function at or after 'off' in the value of=
 'map' */
  static u32 func_ptr_lower_bound(struct bpf_verifier_env *env, const struc=
t bpf_map *map, u64 off)
  {
@@@ -6459,51 -6526,6 +6526,6 @@@ struct bpf_func_ptr *bpf_map_func_ptrs(
  	return bpf_map_range_func_ptrs(env, map, 0, (u64)map->value_size, cnt);
  }
 =20
- /* instructions [off, off + len) replaced the instruction at 'off' */
- void bpf_adjust_func_ptrs(struct bpf_verifier_env *env, u32 off, u32 len)
- {
- 	struct bpf_func_ptr *p;
- 	u32 i;
-=20
- 	if (len <=3D 1)
- 		return;
-=20
- 	for (i =3D 0; i < env->func_ptr_cnt; i++) {
- 		p =3D &env->func_ptrs[i];
- 		if (p->xlated_off <=3D off || p->xlated_off =3D=3D BPF_FUNC_PTR_DELETED)
- 			continue;
- 		p->xlated_off +=3D len - 1;
- 	}
- }
-=20
- /*
-  * Instructions [off, off + len) are about to be removed. It's called bef=
ore
-  * the starts of subprogs are adjusted. A subprog is gone when all of its
-  * instructions are. Otherwise, e.g. when its first instruction is a nop,
-  * it starts where the removed instructions did.
-  */
- void bpf_adjust_func_ptrs_after_remove(struct bpf_verifier_env *env, u32 =
off, u32 len)
- {
- 	struct bpf_func_ptr *p;
- 	int subprog;
- 	u32 i;
-=20
- 	for (i =3D 0; i < env->func_ptr_cnt; i++) {
- 		p =3D &env->func_ptrs[i];
- 		if (p->xlated_off < off || p->xlated_off =3D=3D BPF_FUNC_PTR_DELETED)
- 			continue;
- 		if (p->xlated_off >=3D off + len) {
- 			p->xlated_off -=3D len;
- 			continue;
- 		}
- 		subprog =3D bpf_find_subprog(env, p->xlated_off);
- 		if (subprog > 0 && env->subprog_info[subprog + 1].start > off + len)
- 			p->xlated_off =3D off;
- 		else
- 			p->xlated_off =3D BPF_FUNC_PTR_DELETED;
- 	}
- }
-=20
  #define BTF_TYPE_SAFE_RCU(__type)  __PASTE(__type, __safe_rcu)
  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or_=
null)
  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
@@@ -7012,8 -7034,7 +7034,7 @@@ static int check_stack_access_within_bo
  		min_off =3D (s64)reg->var_off.value + off;
  		max_off =3D min_off + access_size;
  	} else {
- 		if (reg_smax(reg) >=3D BPF_MAX_VAR_OFF ||
- 		    reg_smin(reg) <=3D -BPF_MAX_VAR_OFF) {
+ 		if (offset_is_far(reg)) {
  			verbose(env, "invalid unbounded variable-offset%s stack %s\n",
  				err_extra, reg_arg_name(env, argno));
  			return -EACCES;
@@@ -7045,27 -7066,33 +7066,33 @@@
  		return err;
  	}
 =20
+ 	/* the callers look at each byte */
+ 	bpf_add_cost(env, max_off - min_off, BPF_COST_COPY);
+=20
  	/*
  	 * Every stack access passes through here, including buffers passed to
  	 * helpers and kfuncs and accesses into a caller's frame, so check the
  	 * fastcall contract of the frame that owns the slots once for all of
- 	 * them. Zero-sized accesses touch no stack and keep the rewrite enabled.
+ 	 * them. An empty range touches no stack and keeps the rewrite enabled.
  	 */
- 	if (access_size)
- 		check_fastcall_stack_contract(env, state, env->insn_idx, min_off);
+ 	if (min_off < max_off)
+ 		check_fastcall_stack_contract(env, state, env->insn_idx, min_off,
+ 					      !tnum_is_const(reg->var_off) ||
+ 					      env->prev_insn_idx =3D=3D env->insn_idx);
 =20
  	/* Note that there is no stack access with offset zero, so the needed st=
ack
  	 * size is -min_off, not -min_off+1.
  	 */
- 	return bpf_grow_stack_state(env, state, -min_off /* size */);
+ 	return grow_stack_state(env, state, -min_off /* size */);
  }
 =20
  static bool get_func_retval_range(struct bpf_prog *prog,
  				  struct bpf_retval_range *range)
  {
- 	if (prog->type =3D=3D BPF_PROG_TYPE_LSM &&
+ 	if (IS_ENABLED(CONFIG_BPF_LSM) && prog->type =3D=3D BPF_PROG_TYPE_LSM &&
  		prog->expected_attach_type =3D=3D BPF_LSM_MAC &&
- 		!bpf_lsm_get_retval_range(prog, range)) {
+ 		prog->aux->attach_func_proto->type) {
+ 		bpf_lsm_get_retval_range(prog, range);
  		return true;
  	}
  	return false;
@@@ -7073,19 -7100,13 +7100,13 @@@
 =20
  static void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)
  {
- 	struct bpf_reg_state fake_reg;
+ 	struct scalar off;
 =20
  	if (!val)
  		return;
 =20
- 	fake_reg.type =3D SCALAR_VALUE;
- 	__mark_reg_known(&fake_reg, val);
-=20
- 	scalar_step_add(dst_reg, dst_reg, &fake_reg);
- 	scalar32_min_max_add(dst_reg, &fake_reg);
- 	scalar_min_max_add(dst_reg, &fake_reg);
- 	dst_reg->var_off =3D tnum_add(dst_reg->var_off, fake_reg.var_off);
-=20
+ 	scalar_set_const(&off, val);
+ 	scalar_add(scalar_of(dst_reg), scalar_of(dst_reg), &off);
  	reg_bounds_sync(dst_reg);
  }
 =20
@@@ -7112,10 -7133,47 +7133,47 @@@ static void mark_reg_func_ptr(struct bp
  	regs[regno].subprogno =3D subprog;
  }
 =20
- /* a read from a table of functions branches into that many states at mos=
t */
- #define BPF_MAX_FUNC_PTR_TARGETS 64
- /* and that many pointers at most are next to what is read at variable of=
fset */
- #define BPF_MAX_FUNC_PTR_RANGE 4096
+ /*
+  * A load from a table of functions gives one register: a pointer to one =
of a set of functions.
+  * One state for each function would differ in nothing else up to the cal=
l, and there every
+  * function of the set is verified.
+  * Equal sets have the same number, so registers are compared as they are.
+  */
+ static int mark_reg_func_set(struct bpf_verifier_env *env, struct bpf_reg=
_state *regs, int regno,
+ 			     const u32 *subprogs, u32 n)
+ {
+ 	struct bpf_func_set *set;
+ 	u64 key;
+ 	int i;
+=20
+ 	mark_reg_func_ptr(env, regs, regno, n =3D=3D 1 ? subprogs[0] : 0);
+ 	if (n =3D=3D 1)
+ 		return 0;
+=20
+ 	/* sets with the same hash have keys in a row */
+ 	key =3D (u64)jhash2(subprogs, n, 0) << 32;
+ 	for (; (i =3D bpf_index_find(&env->func_set_index, key)) >=3D 0; key++) {
+ 		set =3D env->func_sets[i];
+ 		if (set->cnt =3D=3D n && !memcmp(set->subprog, subprogs, n * sizeof(*su=
bprogs)))
+ 			break;
+ 	}
+ 	if (i < 0) {
+ 		i =3D env->func_set_cnt;
+ 		set =3D kvzalloc_flex(*set, subprog, n, BPF_VERIFIER_GFP);
+ 		/* nothing fails between the entry of the index and the set that it sta=
nds for */
+ 		if (!set || !bpf_table_next(env->func_sets, i) ||
+ 		    bpf_index_add(&env->func_set_index, key, i)) {
+ 			kvfree(set);
+ 			return -ENOMEM;
+ 		}
+ 		env->mem +=3D struct_size(set, subprog, n);
+ 		set->cnt =3D n;
+ 		memcpy(set->subprog, subprogs, n * sizeof(*subprogs));
+ 		env->func_sets[env->func_set_cnt++] =3D set;
+ 	}
+ 	regs[regno].func_set =3D i + 1;
+ 	return 0;
+ }
 =20
  /* Count up to 'limit' offsets in [min_off, max_off] that the read is pos=
sible at */
  static u32 count_read_offsets(struct tnum offs, u64 min_off, u64 max_off,=
 u32 limit)
@@@ -7145,7 -7203,7 +7203,7 @@@
   * is possible at, e.g. var_off is the stride of the elements of an array.
   * A read of exactly one pointer yields PTR_TO_FUNC. When the offset is v=
ariable
   * and only pointers can be read, which is how an element of a table of
-  * functions is loaded, the verification continues with each of them. Oth=
er
+  * functions is loaded, it is one of them, see mark_reg_func_set(). Other
   * reads that overlap with a pointer are rejected, because their result i=
s not
   * known until the program is jitted.
   *
@@@ -7158,20 -7216,27 +7216,27 @@@ static int check_func_ptr_read(struct b
  	struct tnum offs =3D tnum_add(reg->var_off, tnum_const(off));
  	struct bpf_reg_state *regs =3D cur_regs(env);
  	struct bpf_map *map =3D reg->map_ptr;
- 	struct bpf_verifier_state *branch;
- 	int subprog, targets[BPF_MAX_FUNC_PTR_TARGETS];
+ 	unsigned long *found __free(kvfree) =3D NULL;
+ 	u32 *targets __free(kvfree) =3D NULL;
  	struct bpf_func_ptr *ptrs;
  	u32 i, cnt, n =3D 0;
  	u64 o, lo, hi;
- 	int err;
+ 	int err, subprog;
 =20
  	ptrs =3D bpf_map_range_func_ptrs(env, map, min_off, max_off - min_off + =
size, &cnt);
  	if (!ptrs)
  		return -ENOENT;
- 	if (cnt > BPF_MAX_FUNC_PTR_RANGE)
- 		goto overlap;
+ 	err =3D bpf_add_cost_and_check(env, cnt * sizeof(u64), BPF_COST_COPY);
+ 	if (err)
+ 		return err;
+ 	targets =3D kvmalloc_array(min(cnt, env->subprog_cnt), sizeof(*targets),=
 BPF_VERIFIER_GFP);
+ 	found =3D kvcalloc(BITS_TO_LONGS(env->subprog_cnt), sizeof(long), BPF_VE=
RIFIER_GFP);
+ 	if (!targets || !found)
+ 		return -ENOMEM;
 =20
  	for (i =3D 0; i < cnt; i++) {
+ 		if (bpf_must_abort())
+ 			return -EINTR;
  		/* the offsets at which the read overlaps with the pointer */
  		lo =3D ptrs[i].map_off >=3D size ? ptrs[i].map_off - size + 1 : 0;
  		lo =3D max(lo, min_off);
@@@ -7181,17 -7246,13 +7246,13 @@@
  				continue;
  			if (o !=3D ptrs[i].map_off || size !=3D sizeof(u64) || value_regno < 0)
  				goto overlap;
- 			if (n =3D=3D BPF_MAX_FUNC_PTR_TARGETS) {
- 				verbose(env, "read from map '%s' may yield more than %d pointers to f=
unctions\n",
- 					map->name, BPF_MAX_FUNC_PTR_TARGETS);
- 				return -E2BIG;
- 			}
  			subprog =3D bpf_find_subprog(env, ptrs[i].xlated_off);
  			if (verifier_bug_if(subprog <=3D 0, env,
  					    "no function at insn %u for map '%s' offset %u",
  					    ptrs[i].xlated_off, map->name, ptrs[i].map_off))
  				return -EFAULT;
- 			targets[n++] =3D subprog;
+ 			__set_bit(subprog, found);
+ 			n++;
  		}
  	}
  	/* pointers are next to what is read, e.g. the data of an array of vtabl=
es */
@@@ -7206,16 -7267,10 +7267,10 @@@
  	if (err)
  		return err;
 =20
- 	for (i =3D 0; i < n - 1; i++) {
- 		branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx,
- 				    env->cur_state->speculative);
- 		if (IS_ERR(branch))
- 			return PTR_ERR(branch);
- 		mark_reg_func_ptr(env, branch->frame[branch->curframe]->regs, value_reg=
no,
- 				  targets[i]);
- 	}
- 	mark_reg_func_ptr(env, regs, value_regno, targets[n - 1]);
- 	return 0;
+ 	n =3D 0;
+ 	for_each_set_bit(subprog, found, env->subprog_cnt)
+ 		targets[n++] =3D subprog;
+ 	return mark_reg_func_set(env, regs, value_regno, targets, n);
 =20
  overlap:
  	verbose(env, "read of %d bytes at offset [%llu,%llu] of map '%s' overlap=
s with a pointer to a function\n",
@@@ -7293,8 -7348,10 +7348,10 @@@ static int check_mem_access(struct bpf_
  		return size;
 =20
  	err =3D check_ptr_alignment(env, reg, off, size, strict_alignment_once);
- 	if (err)
+ 	if (err) {
+ 		bpf_note_needs_ptr(env, reg);
  		return err;
+ 	}
 =20
  	if (reg->type =3D=3D PTR_TO_MAP_KEY) {
  		if (t =3D=3D BPF_WRITE) {
@@@ -7410,12 -7467,13 +7467,13 @@@
  				if (base_type(info.reg_type) =3D=3D PTR_TO_BTF_ID) {
  					regs[value_regno].btf =3D info.btf;
  					regs[value_regno].btf_id =3D info.btf_id;
- 					regs[value_regno].id =3D info.ref_id;
+ 					regs[value_regno].id =3D
+ 						ctx_arg_ref_id(env->cur_state, info.ref_arg);
  				} else if (base_type(info.reg_type) =3D=3D PTR_TO_MEM) {
  					regs[value_regno].mem_size =3D info.mem_size;
  				}
  				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
- 					regs[value_regno].id =3D ++env->id_gen;
+ 					regs[value_regno].id =3D bpf_new_id(env);
  			}
  			regs[value_regno].type =3D info.reg_type;
  		}
@@@ -7506,6 -7564,7 +7564,7 @@@
 =20
  		verbose(env, "%s invalid mem access '%s'\n", reg_arg_name(env, argno),
  			reg_type_str(env, reg->type));
+ 		bpf_note_needs_ptr(env, reg);
  		if (reg->type =3D=3D SCALAR_VALUE)
  			kind =3D BPF_DIAG_DEREF_SCALAR;
  		else if (type_may_be_null(reg->type))
@@@ -7519,20 -7578,9 +7578,9 @@@
  	    regs[value_regno].type =3D=3D SCALAR_VALUE) {
  		if (!is_ldsx) {
  			/* b/h/w load zero-extends, mark upper bits as known 0 */
- 			coerce_reg_to_size(&regs[value_regno], size);
+ 			coerce_scalar_to_size(scalar_of(&regs[value_regno]), size);
  		} else {
- 			/*
- 			 * Sign-extension can change the register value relative
- 			 * to a scalar it is linked with by id (e.g. a zero-
- 			 * extending fill of the same spilled stack slot), thus
- 			 * drop the shared id in that case.
- 			 */
- 			bool no_sext =3D reg_umax(&regs[value_regno]) <
- 					(1ULL << (size * BITS_PER_BYTE - 1));
-=20
- 			coerce_reg_to_size_sx(&regs[value_regno], size);
- 			if (!no_sext)
- 				clear_scalar_id(&regs[value_regno]);
+ 			coerce_scalar_to_size_sx(scalar_of(&regs[value_regno]), size);
  		}
  	}
 =20
@@@ -7545,6 -7593,9 +7593,9 @@@
  static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_t=
ype type,
  			     bool allow_trust_mismatch);
 =20
+ static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *e=
nv);
+ static int fixups_differ(struct bpf_verifier_env *env, const char *msg);
+=20
  static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *=
insn,
  			  bool strict_alignment_once, bool is_ldsx,
  			  bool allow_trust_mismatch, const char *ctx)
@@@ -7574,6 -7625,17 +7625,17 @@@
  		return err;
 =20
  	src_reg_type =3D regs[insn->src_reg].type;
+ 	/* A flexible array has no end, see btf_struct_access(). A far load from=
 it can fault. */
+ 	if (base_type(src_reg_type) =3D=3D PTR_TO_BTF_ID && offset_is_far(&regs[=
insn->src_reg])) {
+ 		if (BPF_CLASS(insn->code) !=3D BPF_LDX) {
+ 			verbose(env, "BPF_ATOMIC loads from R%d with a far offset is not allow=
ed\n",
+ 				insn->src_reg);
+ 			return -EACCES;
+ 		}
+ 		src_reg_type |=3D PTR_UNTRUSTED;
+ 	}
+ 	/* a fill copies it from the slot, see mark_from_unproven(); dst can be =
src */
+ 	regs[insn->dst_reg].from_unproven =3D regs[insn->src_reg].from_unproven;
 =20
  	/*
  	 * check_stack_read_fixed_off() may refine the modification's origin to
@@@ -7589,12 -7651,13 +7651,13 @@@
  	 * may share the insn, see save_aux_ptr_type(). Record a load that did
  	 * not produce an arena pointer from an __arena member, the only load
  	 * through a kernel struct pointer that does, next to the one
- 	 * check_arena_member_load() records, so that arena_member_fixup() can
- 	 * tell when the paths disagree.
+ 	 * check_arena_member_load() records. Fail if the insn has both.
  	 */
  	if (!err && !(base_type(src_reg_type) =3D=3D PTR_TO_BTF_ID &&
  		      regs[insn->dst_reg].type =3D=3D PTR_TO_ARENA))
- 		env->insn_aux_data[env->insn_idx].non_arena_load =3D true;
+ 		cur_aux(env)->non_arena_load =3D true;
+ 	if (!err && cur_aux(env)->arena_member && cur_aux(env)->non_arena_load)
+ 		return fixups_differ(env, "an insn loads an arena pointer member on one=
 path and something else on another");
  	err =3D err ?: save_aux_ptr_type(env, src_reg_type,
  				       allow_trust_mismatch);
  	err =3D err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
@@@ -7830,8 -7893,9 +7893,9 @@@ static int check_stack_range_initialize
  	u32 arg_slot =3D arg_slot_from_argno(argno);
  	bool uninit =3D clobber && meta && arg_slot < MAX_BPF_FUNC_ARGS &&
  		      (meta->arg_raw_mem.mask & BIT(arg_slot));
- 	bool raw_mode =3D uninit && env->allow_uninit_stack &&
- 			!(meta->arg_raw_mem.var_size_mask & BIT(arg_slot));
+ 	bool var_size =3D meta && arg_slot < MAX_BPF_FUNC_ARGS &&
+ 			(meta->arg_raw_mem.var_size_mask & BIT(arg_slot));
+ 	bool raw_mode =3D uninit && env->allow_uninit_stack && !var_size;
 =20
  	access_size =3D abs(access_size);
 =20
@@@ -7880,6 -7944,10 +7944,10 @@@
  		struct bpf_stack_state *ss;
  		u8 *stype;
 =20
+ 		/* The byte is between two accesses. See size_at_max_offset() for @var_=
size. */
+ 		if (reg->step > 1 && !var_size &&
+ 		    imod(i - off - reg->base, reg->step) >=3D access_size)
+ 			continue;
  		slot =3D -i - 1;
  		spi =3D slot / BPF_REG_SIZE;
  		if (state->allocated_stack <=3D slot) {
@@@ -7909,7 -7977,7 +7977,7 @@@
  		    (ss->spilled_ptr.type =3D=3D SCALAR_VALUE ||
  		     env->allow_ptr_leaks)) {
  			if (clobber) {
- 				__mark_reg_unknown(env, &ss->spilled_ptr);
+ 				bpf_mark_reg_unknown(&ss->spilled_ptr);
  				for (j =3D 0; j < BPF_REG_SIZE; j++)
  					scrub_spilled_slot(&ss->slot_type[j]);
  			}
@@@ -7970,10 -8038,6 +8038,10 @@@ static int check_helper_mem_access(stru
  		return check_mem_region_access(env, reg, argno, 0, access_size,
  					       reg->map_ptr->key_size, false);
  	case PTR_TO_MAP_VALUE:
 +		if (reg->map_ptr->map_type =3D=3D BPF_MAP_TYPE_INSN_ARRAY && !env->allo=
w_ptr_leaks) {
 +			verbose(env, "%s leaks addr from insn_array\n", reg_arg_name(env, argn=
o));
 +			return -EACCES;
 +		}
  		if (check_map_access_type(env, reg, 0, access_size, access_type))
  			return -EACCES;
  		return check_map_access(env, reg, argno, 0, access_size,
@@@ -8035,6 -8099,7 +8103,7 @@@
  		verbose(env, "%s type=3D%s ", reg_arg_name(env, argno),
  			reg_type_str(env, reg->type));
  		verbose(env, "expected=3D%s\n", reg_type_str(env, PTR_TO_STACK));
+ 		bpf_note_needs_ptr(env, reg);
  		return -EACCES;
  	}
  }
@@@ -8045,6 -8110,28 +8114,28 @@@ enum bpf_mem_size_failure=20
  	BPF_MEM_SIZE_FAIL_SIZE,
  };
 =20
+ /*
+  * The check looks at the bytes from the smallest offset to the largest o=
ffset plus the size.
+  * The largest offset and the largest size do not have to go together:
+  *	read(buf + off, 64 - off);
+  * So the result is not the size of the access. It is 0 for off =3D 0..64.
+  * The checked bytes of a packet pointer are relative to the pointer. It =
needs the largest size.
+  */
+ static u32 size_at_max_offset(struct bpf_verifier_env *env, struct bpf_re=
g_state *mem_reg,
+ 			      struct bpf_reg_state *size_reg, argno_t mem_argno, argno_t size_=
argno)
+ {
+ 	u32 type =3D base_type(mem_reg->type);
+ 	s64 end;
+=20
+ 	if ((type !=3D PTR_TO_MAP_VALUE && type !=3D PTR_TO_MEM && type !=3D PTR=
_TO_STACK) ||
+ 	    reg_smin(mem_reg) <=3D -BPF_MAX_VAR_OFF || reg_smax(mem_reg) >=3D BP=
F_MAX_VAR_OFF)
+ 		return reg_umax(size_reg);
+ 	end =3D bpf_equations_max_sum(env, reg_from_argno(mem_argno), reg_from_a=
rgno(size_argno));
+ 	end =3D clamp(end, reg_smax(mem_reg) + (s64)reg_umin(size_reg),
+ 		    reg_smax(mem_reg) + (s64)reg_umax(size_reg));
+ 	return end - reg_smax(mem_reg);
+ }
+=20
  /* verify arguments to helpers or kfuncs consisting of a pointer and an a=
ccess
   * size.
   *
@@@ -8059,6 -8146,7 +8150,7 @@@ static int check_mem_size_reg(struct bp
  			      enum bpf_mem_size_failure *failure)
  {
  	int err =3D 0;
+ 	u32 size;
 =20
  	if (failure)
  		*failure =3D BPF_MEM_SIZE_FAIL_NONE;
@@@ -8102,18 -8190,16 +8194,16 @@@
  		goto size_error;
  	}
 =20
+ 	size =3D size_at_max_offset(env, mem_reg, size_reg, mem_argno, size_argn=
o);
  	if (access_type & BPF_READ)
- 		err =3D check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size_=
reg),
+ 		err =3D check_helper_mem_access(env, mem_reg, mem_argno, size,
  					      BPF_READ, zero_size_allowed, meta, NULL);
  	if (!err && access_type & BPF_WRITE)
- 		err =3D check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size_=
reg),
+ 		err =3D check_helper_mem_access(env, mem_reg, mem_argno, size,
  					      BPF_WRITE, zero_size_allowed, meta, NULL);
  	if (err && failure)
  		*failure =3D BPF_MEM_SIZE_FAIL_MEMORY;
 =20
- 	if (!err)
- 		err =3D mark_arg_precision(env, size_argno);
-=20
  	return err;
 =20
  size_error:
@@@ -8134,7 -8220,7 +8224,7 @@@ static int check_mem_reg(struct bpf_ver
  	int size, err =3D 0;
 =20
  	if (bpf_register_is_null(reg))
- 		return mark_arg_precision(env, argno);
+ 		return 0;
  	if (known_memory)
  		*known_memory =3D true;
 =20
@@@ -8164,9 -8250,6 +8254,6 @@@
  static int process_const_alloc_mem_size(struct bpf_verifier_env *env, str=
uct bpf_reg_state *reg,
  					argno_t argno, struct ret_mem_desc *ret_mem)
  {
- 	int regno =3D reg_from_argno(argno);
- 	int err;
-=20
  	if (ret_mem->found) {
  		verifier_bug(env, "only one allocation size argument permitted");
  		return -EFAULT;
@@@ -8182,13 -8265,6 +8269,6 @@@
  		return -EINVAL;
  	}
 =20
- 	if (regno >=3D 0)
- 		err =3D mark_chain_precision(env, regno);
- 	else
- 		err =3D mark_stack_arg_precision(env, arg_idx_from_argno(argno));
- 	if (err)
- 		return err;
-=20
  	ret_mem->size =3D reg->var_off.value;
  	ret_mem->found =3D true;
 =20
@@@ -8198,9 -8274,6 +8278,6 @@@
  static int process_const_arg(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg,
  			     argno_t argno, struct bpf_call_arg_meta *meta)
  {
- 	int regno =3D reg_from_argno(argno);
- 	int err;
-=20
  	if (meta->arg_constant.found) {
  		verifier_bug(env, "only one constant argument permitted");
  		return -EFAULT;
@@@ -8211,13 -8284,6 +8288,6 @@@
  		return -EINVAL;
  	}
 =20
- 	if (regno >=3D 0)
- 		err =3D mark_chain_precision(env, regno);
- 	else
- 		err =3D mark_stack_arg_precision(env, arg_idx_from_argno(argno));
- 	if (err < 0)
- 		return err;
-=20
  	meta->arg_constant.found =3D true;
  	meta->arg_constant.value =3D reg->var_off.value;
 =20
@@@ -8806,85 -8872,6 +8876,6 @@@ static int process_iter_arg(struct bpf_
  	return 0;
  }
 =20
- /* Look for a previous loop entry at insn_idx: nearest parent state
-  * stopped at insn_idx with callsites matching those in cur->frame.
-  */
- static struct bpf_verifier_state *find_prev_entry(struct bpf_verifier_env=
 *env,
- 						  struct bpf_verifier_state *cur,
- 						  int insn_idx)
- {
- 	struct bpf_verifier_state_list *sl;
- 	struct bpf_verifier_state *st;
- 	struct list_head *pos, *head;
-=20
- 	/* Explored states are pushed in stack order, most recent states come fi=
rst */
- 	head =3D bpf_explored_state(env, insn_idx);
- 	list_for_each(pos, head) {
- 		sl =3D container_of(pos, struct bpf_verifier_state_list, node);
- 		/* If st->branches !=3D 0 state is a part of current DFS verification p=
ath,
- 		 * hence cur & st for a loop.
- 		 */
- 		st =3D &sl->state;
- 		if (st->insn_idx =3D=3D insn_idx && st->branches && same_callsites(st, =
cur) &&
- 		    st->dfs_depth < cur->dfs_depth)
- 			return st;
- 	}
-=20
- 	return NULL;
- }
-=20
- /*
-  * Check if scalar registers are exact for the purpose of not widening.
-  * More lenient than regs_exact()
-  */
- static bool scalars_exact_for_widen(const struct bpf_reg_state *rold,
- 				    const struct bpf_reg_state *rcur)
- {
- 	return !memcmp(rold, rcur, offsetof(struct bpf_reg_state, id));
- }
-=20
- static void maybe_widen_reg(struct bpf_verifier_env *env,
- 			    struct bpf_reg_state *rold, struct bpf_reg_state *rcur)
- {
- 	if (rold->type !=3D SCALAR_VALUE)
- 		return;
- 	if (rold->type !=3D rcur->type)
- 		return;
- 	if (rold->precise || rcur->precise || scalars_exact_for_widen(rold, rcur=
))
- 		return;
- 	__mark_reg_unknown(env, rcur);
- }
-=20
- static int widen_imprecise_scalars(struct bpf_verifier_env *env,
- 				   struct bpf_verifier_state *old,
- 				   struct bpf_verifier_state *cur)
- {
- 	struct bpf_func_state *fold, *fcur;
- 	int i, fr, num_slots;
-=20
- 	for (fr =3D old->curframe; fr >=3D 0; fr--) {
- 		fold =3D old->frame[fr];
- 		fcur =3D cur->frame[fr];
-=20
- 		for (i =3D 0; i < MAX_BPF_REG; i++)
- 			maybe_widen_reg(env,
- 					&fold->regs[i],
- 					&fcur->regs[i]);
-=20
- 		num_slots =3D min(bpf_stack_nr_slots(fold), bpf_stack_nr_slots(fcur));
- 		for (i =3D 0; i < num_slots; i++) {
- 			struct bpf_stack_state *old_ss =3D bpf_stack_slot(fold, i);
- 			struct bpf_stack_state *cur_ss =3D bpf_stack_slot(fcur, i);
-=20
- 			if (!bpf_is_spilled_reg(old_ss) || !bpf_is_spilled_reg(cur_ss))
- 				continue;
-=20
- 			maybe_widen_reg(env, &old_ss->spilled_ptr, &cur_ss->spilled_ptr);
- 		}
- 	}
- 	return 0;
- }
-=20
  static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_stat=
e *cur_st,
  						 struct bpf_call_arg_meta *meta)
  {
@@@ -8894,6 -8881,37 +8885,37 @@@
  	return &bpf_stack_slot(cur_st->frame[iter_frameno], iter_spi)->spilled_p=
tr;
  }
 =20
+ /*
+  * Every trip of a loop goes through bpf_iter_*_next(). It stops the loop=
 if the iterator is older
+  * than the loop: every trip takes an element, and the number of elements=
 is finite.
+  * It does not stop
+  * - the loop that makes the iterator. The iterator starts again in every=
 trip:
+  *	while (v->x) { bpf_for(i, 0, 10) ...; }
+  *   The loops that the program entered before it made the iterator are a=
mong the first
+  *   iter.loops loops.
+  * - any loop, if no element was left already. The program knew that and =
did not leave.
+  */
+ static void iter_stops_loops(struct bpf_verifier_env *env, int insn_idx,
+ 			     const struct bpf_reg_state *iter)
+ {
+ 	const struct bpf_verifier_state *st =3D env->cur_state;
+ 	struct bpf_func_state *frame =3D st->frame[st->curframe];
+ 	u32 below =3D nr_loops_below(st, st->curframe);
+ 	struct loop_stack_entry *entry;
+ 	bool stops;
+ 	int i;
+=20
+ 	/* the loops of this subprog: flow_is_bound() doesn't look into the func=
tions it calls */
+ 	for (i =3D frame->loop_stack_cnt - 1; i >=3D 0 && !st->speculative; i--)=
 {
+ 		entry =3D &frame->loop_stack[i];
+ 		stops =3D iter->iter.state !=3D BPF_ITER_STATE_DRAINED && below + i >=
=3D iter->iter.loops;
+ 		if (entry->loop->kind !=3D BPF_LOOP_JUMPS || stops)
+ 			continue;
+ 		bpf_flow_next_is_no_bound(env, insn_idx, entry->loop->header);
+ 		return;
+ 	}
+ }
+=20
  /* process_iter_next_call() is called when verifier gets to iterator's ne=
xt
   * "method" (e.g., bpf_iter_num_next() for numbers iterator) call. We'll =
refer
   * to it as just "iter_next()" in comments below.
@@@ -8908,74 -8926,18 +8930,18 @@@
   * without having to simulate infinite amount of iterations.
   *
   * In current state, we first assume that iter_next() returned NULL and
-  * iterator state is set to DRAINED (BPF_ITER_STATE_DRAINED). In such
-  * conditions we should not form an infinite loop and should eventually r=
each
-  * exit.
+  * iterator state is set to DRAINED (BPF_ITER_STATE_DRAINED).
   *
-  * Besides that, we also fork current state and enqueue it for later
-  * verification. In a forked state we keep iterator state as ACTIVE
-  * (BPF_ITER_STATE_ACTIVE) and assume non-NULL return from iter_next(). We
-  * also bump iteration depth to prevent erroneous infinite loop detection
-  * later on (see iter_active_depths_differ() comment for details). In this
-  * state we assume that we'll eventually loop back to another iter_next()
-  * calls (it could be in exactly same location or in some other instructi=
on,
-  * it doesn't matter, we don't make any unnecessary assumptions about thi=
s,
-  * everything revolves around iterator state in a stack slot, not which
-  * instruction is calling iter_next()). When that happens, we either will=
 come
-  * to iter_next() with equivalent state and can conclude that next iterat=
ion
-  * will proceed in exactly the same way as we just verified, so it's safe=
 to
-  * assume that loop converges. If not, we'll go on another iteration
-  * simulation with a different input state, until all possible starting s=
tates
-  * are validated or we reach maximum number of instructions limit.
-  *
-  * This way, we will either exhaustively discover all possible input stat=
es
-  * that iterator loop can start with and eventually will converge, or we'=
ll
-  * effectively regress into bounded loop simulation logic and either reach
-  * maximum number of instructions if loop is not provably convergent, or =
there
-  * is some statically known limit on number of iterations (e.g., if there=
 is
-  * an explicit `if n > 100 then break;` statement somewhere in the loop).
-  *
-  * Iteration convergence logic in is_state_visited() relies on exact
-  * states comparison, which ignores read and precision marks.
-  * This is necessary because read and precision marks are not finalized
-  * while in the loop. Exact comparison might preclude convergence for
-  * simple programs like below:
-  *
-  *     i =3D 0;
-  *     while(iter_next(&it))
-  *       i++;
-  *
-  * At each iteration step i++ would produce a new distinct state and
-  * eventually instruction processing limit would be reached.
-  *
-  * To avoid such behavior speculatively forget (widen) range for
-  * imprecise scalar registers, if those registers were not precise at the
-  * end of the previous iteration and do not match exactly.
-  *
-  * This is a conservative heuristic that allows to verify wide range of p=
rograms,
-  * however it precludes verification of programs that conjure an
-  * imprecise value on the first loop iteration and use it as precise on a=
 second.
-  * For example, the following safe program would fail to verify:
-  *
-  *     struct bpf_num_iter it;
-  *     int arr[10];
-  *     int i =3D 0, a =3D 0;
-  *     bpf_iter_num_new(&it, 0, 10);
-  *     while (bpf_iter_num_next(&it)) {
-  *       if (a =3D=3D 0) {
-  *         a =3D 1;
-  *         i =3D 7; // Because i changed verifier would forget
-  *                // it's range on second loop entry.
-  *       } else {
-  *         arr[i] =3D 42; // This would fail to verify.
-  *       }
-  *     }
-  *     bpf_iter_num_destroy(&it);
+  * Besides that, we also fork current state. In a forked state we keep it=
erator
+  * state as ACTIVE (BPF_ITER_STATE_ACTIVE) and assume non-NULL return from
+  * iter_next(). This state goes around the loop like in any other loop: w=
hat
+  * comes back to the head of the loop is joined with what is there until
+  * nothing changes, see flow.c.
   */
  static int process_iter_next_call(struct bpf_verifier_env *env, int insn_=
idx,
  				  struct bpf_call_arg_meta *meta)
  {
- 	struct bpf_verifier_state *cur_st =3D env->cur_state, *queued_st, *prev_=
st;
+ 	struct bpf_verifier_state *cur_st =3D env->cur_state, *queued_st;
  	struct bpf_func_state *cur_fr =3D cur_st->frame[cur_st->curframe], *queu=
ed_fr;
  	struct bpf_reg_state *cur_iter, *queued_iter;
 =20
@@@ -8990,20 -8952,9 +8956,9 @@@
  		return -EFAULT;
  	}
 =20
+ 	iter_stops_loops(env, insn_idx, cur_iter);
+=20
  	if (cur_iter->iter.state =3D=3D BPF_ITER_STATE_ACTIVE) {
- 		/* Because iter_next() call is a checkpoint is_state_visitied()
- 		 * should guarantee parent state with same call sites and insn_idx.
- 		 */
- 		if (!cur_st->parent || cur_st->parent->insn_idx !=3D insn_idx ||
- 		    !same_callsites(cur_st->parent, cur_st)) {
- 			verifier_bug(env, "bad parent state for iter next call");
- 			return -EFAULT;
- 		}
- 		/* Note cur_st->parent in the call below, it is necessary to skip
- 		 * checkpoint created for cur_st by is_state_visited()
- 		 * right at this instruction.
- 		 */
- 		prev_st =3D find_prev_entry(env, cur_st->parent, insn_idx);
  		/* branch out active iter state */
  		queued_st =3D push_stack(env, insn_idx + 1, insn_idx, false);
  		if (IS_ERR(queued_st))
@@@ -9011,18 -8962,14 +8966,14 @@@
 =20
  		queued_iter =3D get_iter_from_state(queued_st, meta);
  		queued_iter->iter.state =3D BPF_ITER_STATE_ACTIVE;
- 		queued_iter->iter.depth++;
- 		if (prev_st)
- 			widen_imprecise_scalars(env, prev_st, queued_st);
 =20
  		queued_fr =3D queued_st->frame[queued_st->curframe];
  		mark_ptr_not_null_reg(&queued_fr->regs[BPF_REG_0]);
  	}
 =20
- 	/* switch to DRAINED state, but keep the depth unchanged */
  	/* mark current iter state as drained and assume returned NULL */
  	cur_iter->iter.state =3D BPF_ITER_STATE_DRAINED;
- 	__mark_reg_const_zero(env, &cur_fr->regs[BPF_REG_0]);
+ 	__mark_reg_const_zero(&cur_fr->regs[BPF_REG_0]);
 =20
  	return 0;
  }
@@@ -9148,7 -9095,6 +9099,6 @@@ static bool is_bpf_obj_drop_kfunc(u32 f
  static bool is_bpf_percpu_obj_drop_kfunc(u32 func_id);
  static bool is_bpf_rbtree_add_kfunc(u32 func_id);
  static int get_bpf_res_spin_lock_kfunc_flags(const struct bpf_call_arg_me=
ta *meta);
- static struct bpf_insn_aux_data *cur_aux(const struct bpf_verifier_env *e=
nv);
  static int process_irq_flag(struct bpf_verifier_env *env,
  			    struct bpf_reg_state *reg, argno_t argno,
  			    struct bpf_call_arg_meta *meta);
@@@ -9509,6 -9455,7 +9459,7 @@@ static int check_reg_type(struct bpf_ve
  	for (j =3D 0; j + 1 < i; j++)
  		verbose(env, "%s, ", reg_type_str(env, compatible->types[j]));
  	verbose(env, "%s\n", reg_type_str(env, compatible->types[j]));
+ 	bpf_note_needs_ptr(env, reg);
  	actual =3D bpf_diag_fmt(env, "%s", reg_type_str(env, reg->type));
  	accepted =3D bpf_diag_expected_reg_types(env, compatible->types, i);
  	bpf_diag_call_arg_fmt(env, env->insn_idx, argno, meta->func_name,
@@@ -9650,7 -9597,8 +9601,8 @@@ static int check_arg_const_str(struct b
  		return -EACCES;
  	}
 =20
- 	if (!tnum_is_const(reg->var_off)) {
+ 	/* the cpu can speculate past the test of a variable offset */
+ 	if (!tnum_is_const(reg->var_off) && !env->bypass_spec_v1) {
  		verbose(env, "%s is not a constant address'\n", reg_arg_name(env, argno=
));
  		return -EACCES;
  	}
@@@ -9660,13 -9608,12 +9612,12 @@@
  		return -EACCES;
  	}
 =20
- 	err =3D check_map_access(env, reg, argno, 0,
- 			       map->value_size - reg->var_off.value, false,
- 			       ACCESS_HELPER);
+ 	err =3D check_map_access(env, reg, argno, 0, 1, false, ACCESS_HELPER);
  	if (err)
  		return err;
 =20
- 	map_off =3D reg->var_off.value;
+ 	/* the zero of the last string ends all strings that start before it */
+ 	map_off =3D reg_umax(reg);
  	err =3D map->ops->map_direct_value_addr(map, &map_addr, map_off);
  	if (err) {
  		verbose(env, "direct value access on string failed\n");
@@@ -9679,18 -9626,22 +9630,22 @@@
  		return -EINVAL;
  	}
  	/* the bytes of a pointer to a function are not known until the program =
is jitted */
- 	if (bpf_map_range_func_ptrs(env, map, map_off, strlen(str_ptr + map_off)=
 + 1, &cnt)) {
+ 	map_off +=3D strlen(str_ptr + map_off) + 1;
+ 	if (bpf_map_range_func_ptrs(env, map, reg_umin(reg), map_off - reg_umin(=
reg), &cnt)) {
  		verbose(env, "string overlaps with a pointer to a function\n");
  		return -EACCES;
  	}
  	return 0;
  }
 =20
- /* Returns constant key value in `value` if possible, else negative error=
 */
- static int get_constant_map_key(struct bpf_verifier_env *env,
- 				struct bpf_reg_state *key,
- 				u32 key_size,
- 				s64 *value)
+ /*
+  * Returns the largest value of the key in `value` if it is below `max_en=
tries`,
+  * else negative error
+  */
+ static int get_max_map_key(struct bpf_verifier_env *env,
+ 			   struct bpf_reg_state *key,
+ 			   u32 key_size, u32 max_entries,
+ 			   u64 *value)
  {
  	struct bpf_func_state *state =3D bpf_func(env, key);
  	struct bpf_stack_state *ss;
@@@ -9699,7 -9650,7 +9654,7 @@@
  	int spill_size =3D 0;
  	int zero_size =3D 0;
  	int stack_off;
- 	int i, err;
+ 	int i;
  	u8 *stype;
 =20
  	if (!env->bpf_capable)
@@@ -9732,20 -9683,16 +9687,16 @@@
  	if (spill_size !=3D key_size)
  		return -EOPNOTSUPP;
 =20
+ 	/*
+ 	 * The slot has the range of the 64-bit register that was spilled. A val=
ue
+ 	 * below max_entries fits in the 4 bytes of the key.
+ 	 */
  	reg =3D &ss->spilled_ptr;
- 	if (!tnum_is_const(reg->var_off))
- 		/* Stack value not statically known */
+ 	if (reg_umax(reg) >=3D max_entries)
+ 		/* The lookup can return NULL: nothing depends on the key */
  		return -EOPNOTSUPP;
 =20
- 	/* We are relying on a constant value. So mark as precise
- 	 * to prevent pruning on it.
- 	 */
- 	bpf_bt_set_frame_slot(&env->bt, key->frameno, spi);
- 	err =3D mark_chain_precision_batch(env, env->cur_state);
- 	if (err < 0)
- 		return err;
-=20
- 	*value =3D reg->var_off.value;
+ 	*value =3D reg_umax(reg);
  	return 0;
  }
 =20
@@@ -9862,12 -9809,8 +9813,8 @@@ static int check_func_arg(struct bpf_ve
  	if (arg_type_is_raw_mem(arg_type))
  		meta->arg_raw_mem.mask |=3D BIT(slot);
 =20
- 	if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
- 		err =3D mark_arg_precision(env, argno);
- 		if (err)
- 			return err;
+ 	if (bpf_register_is_null(reg) && type_may_be_null(arg_type))
  		return 0;
- 	}
 =20
  	err =3D check_func_arg_nullability(env, reg, arg, argno, arg_type, meta,=
 insn_idx);
  	if (err)
@@@ -9928,9 -9871,10 +9875,10 @@@
  		if (err)
  			return err;
  		if (can_elide_value_nullness(meta->map.ptr)) {
- 			err =3D get_constant_map_key(env, reg, key_size, &meta->const_map_key);
+ 			err =3D get_max_map_key(env, reg, key_size, meta->map.ptr->max_entries,
+ 					      &meta->max_map_key);
  			if (err < 0) {
- 				meta->const_map_key =3D -1;
+ 				meta->max_map_key =3D U64_MAX;
  				if (err =3D=3D -EOPNOTSUPP)
  					err =3D 0;
  				else
@@@ -10465,8 -10409,10 +10413,10 @@@ static int check_func_args(struct bpf_v
  		err =3D check_outgoing_stack_args(env, caller, proto_slots, meta->func_=
name,
  						meta->btf, proto_slots =3D=3D nargs ? args : NULL);
  		if (err)
- 			return err;
+ 			return meta->subprog_is_static ? -ENODATA : err;
  	}
+ 	/* the other errors only make BTF unreliable, see btf_check_subprog_call=
() */
+ 	env->no_report |=3D meta->subprog_is_static;
 =20
  	for (arg =3D 0; arg < nargs; arg++, prev_slot =3D slot, slot +=3D nslots=
) {
  		const struct btf_type *t;
@@@ -11035,6 -10981,8 +10985,8 @@@ static void clear_all_pkt_pointers(stru
  			mark_reg_invalid(env, reg);
  		}
  	}));
+ 	if (env->cur_state->instance_id)
+ 		env->cur_state->changed_pkt_data =3D true;
  }
 =20
  static bool holds_pkt_pointers(struct bpf_verifier_env *env)
@@@ -11077,7 -11025,7 +11029,7 @@@ static void mark_pkt_end(struct bpf_ver
  		reg->range =3D AT_PKT_END;
  }
 =20
- static int __release_reference_nomark(struct bpf_verifier_state *state, i=
nt id)
+ static int release_reference_nomark(struct bpf_verifier_state *state, int=
 id)
  {
  	int i;
 =20
@@@ -11092,16 -11040,6 +11044,6 @@@
  	return -EINVAL;
  }
 =20
- static int release_reference_nomark(struct bpf_verifier_env *env, int id)
- {
- 	int err;
-=20
- 	err =3D __release_reference_nomark(env->cur_state, id);
- 	if (!err)
- 		bpf_diag_record_ref_release(env, env->insn_idx, id);
- 	return err;
- }
-=20
  static int idstack_push(struct bpf_idmap *idmap, u32 id)
  {
  	int i;
@@@ -11198,7 -11136,7 +11140,7 @@@ static int invalidate_reference(struct=
=20
  static int release_reference(struct bpf_verifier_env *env, int id)
  {
  	if (find_reference_state(env->cur_state, id))
- 		WARN_ON_ONCE(release_reference_nomark(env, id));
+ 		WARN_ON_ONCE(release_reference_nomark(env->cur_state, id));
 =20
  	return invalidate_reference(env, id);
  }
@@@ -11239,7 -11177,7 +11181,7 @@@ static int ref_convert_alloc_rcu_protec
  	struct bpf_reg_state *reg;
  	int err;
 =20
- 	err =3D release_reference_nomark(env, id);
+ 	err =3D release_reference_nomark(env->cur_state, id);
  	if (err)
  		return err;
 =20
@@@ -11303,8 -11241,13 +11245,13 @@@ static int setup_func_entry(struct bpf_
  	if (state->curframe + 1 >=3D MAX_CALL_FRAMES) {
  		verbose(env, "the call stack of %d frames is too deep\n",
  			state->curframe + 2);
+ 		/* drop the path: a pass possibly does not have these calls in frames */
+ 		env->cur_state->infeasible |=3D env->path_sensitive;
  		return -E2BIG;
  	}
+ 	/* in the frames of the callers it has no end */
+ 	if (state->speculative && env->subprog_info[subprog].recursive)
+ 		return -EACCES;
 =20
  	if (state->frame[state->curframe + 1]) {
  		verifier_bug(env, "Frame %d already allocated", state->curframe + 1);
@@@ -11312,7 -11255,7 +11259,7 @@@
  	}
 =20
  	caller =3D state->frame[state->curframe];
- 	callee =3D kzalloc_obj(*callee, GFP_KERNEL_ACCOUNT);
+ 	callee =3D kzalloc_obj(*callee, BPF_VERIFIER_GFP);
  	if (!callee)
  		return -ENOMEM;
  	state->frame[state->curframe + 1] =3D callee;
@@@ -11326,6 -11269,9 +11273,9 @@@
  			callsite,
  			state->curframe + 1 /* frameno within this callchain */,
  			subprog /* subprog number within this prog */);
+ 	callee->entry_refs =3D state->acquired_refs;
+ 	callee->entry_rcu_locks =3D state->active_rcu_locks;
+ 	callee->entry_preempt_locks =3D state->active_preempt_locks;
  	err =3D set_callee_state_cb(env, caller, callee, callsite);
  	if (err)
  		goto err_out;
@@@ -11373,6 -11319,23 +11323,23 @@@ static void gen_subprog_arg_proto(cons
  	}
  }
 =20
+ /*
+  * The argument slots that the code of a static subprog takes, whatever i=
ts BTF says.
+  * Liveness errs on the safe side: a callx in the subprog counts as a rea=
d of all that the subprogs
+  * whose address is taken read or declare.
+  * But it misses r3-r5 of bpf_trace_printk() and the flags of bpf_get_bra=
nch_snapshot(), which
+  * their protos do not declare. Such a subprog prints or passes a wrong n=
umber under a tracer.
+  * The helpers are safe with any value there: the verifier never checks t=
hese registers.
+  */
+ static u32 code_arg_slots(struct bpf_verifier_env *env, struct bpf_subpro=
g_info *sub)
+ {
+ 	u32 live_regs =3D env->insn_aux_data[sub->start].live_regs_before;
+=20
+ 	if (bpf_in_stack_arg_cnt(sub))
+ 		return MAX_BPF_FUNC_REG_ARGS + bpf_in_stack_arg_cnt(sub);
+ 	return fls((live_regs & GENMASK(BPF_REG_5, BPF_REG_1)) >> BPF_REG_1);
+ }
+=20
  static int btf_check_func_arg_match(struct bpf_verifier_env *env, int sub=
prog, struct btf *btf)
  {
  	struct bpf_subprog_info *sub =3D subprog_info(env, subprog);
@@@ -11380,25 -11343,18 +11347,18 @@@
  	const struct btf_type *func, *func_proto;
  	struct bpf_call_arg_meta meta;
  	struct bpf_func_proto *fn;
- 	int ret, err;
+ 	int ret;
  	u32 i;
 =20
  	memset(&meta, 0, sizeof(meta));
  	meta.btf =3D btf;
  	meta.subprog_may_change_pkt =3D sub->changes_pkt_data;
+ 	meta.subprog_is_static =3D !bpf_subprog_is_global(env, subprog);
  	meta.func_name =3D bpf_subprog_name(env, subprog);
 =20
  	ret =3D btf_prepare_func_args(env, subprog);
- 	if (ret) {
- 		if (bpf_in_stack_arg_cnt(sub) > 0) {
- 			err =3D check_outgoing_stack_args(env, caller, sub->arg_slot_cnt,
- 							bpf_subprog_name(env, subprog),
- 							NULL, NULL);
- 			if (err)
- 				return err;
- 		}
+ 	if (ret)
  		return ret;
- 	}
 =20
  	func =3D btf_type_by_id(btf, env->prog->aux->func_info[subprog].type_id);
  	func_proto =3D btf_type_by_id(btf, func->type);
@@@ -11409,13 -11365,20 +11369,20 @@@
  	meta.func_proto =3D func_proto;
 =20
  	/*
- 	 * Check if all register arguments declared in BTF are initialized.
- 	 * If they aren't the BTF is unreliable.
+ 	 * Check if all arguments declared in BTF are initialized,
+ 	 * and if the code takes no other arguments: a trampoline keeps only
+ 	 * what BTF declares. If not, the BTF is unreliable.
  	 */
  	if (!bpf_subprog_is_global(env, subprog)) {
+ 		if (code_arg_slots(env, sub) > sub->arg_slot_cnt)
+ 			return -EINVAL;
  		for (i =3D 0; i < min_t(u32, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS);=
 i++)
  			if (caller->regs[BPF_REG_1 + i].type =3D=3D NOT_INIT)
  				return -EINVAL;
+ 		/* check_func_args() reports a missing slot that the code loads: it has=
 the name */
+ 		for (i =3D max(i, code_arg_slots(env, sub)); i < sub->arg_slot_cnt; i++)
+ 			if (!bpf_get_spilled_stack_arg(i - MAX_BPF_FUNC_REG_ARGS, caller))
+ 				return -EINVAL;
  	}
  	return check_func_args(env, &meta, env->insn_idx);
  }
@@@ -11425,6 -11388,7 +11392,7 @@@
   *
   * Returns:
   * EFAULT - there is a verifier bug. Abort verification.
+  * ENODATA - a static function loads a stack argument that is not there.
   * Other errors - there is a type mismatch or BTF is not available.
   * 0 - BTF matches with what bpf_reg_state expects.
   */
@@@ -11432,6 -11396,7 +11400,7 @@@ static int btf_check_subprog_call(struc
  {
  	struct bpf_prog *prog =3D env->prog;
  	struct btf *btf =3D prog->aux->btf;
+ 	bool no_report =3D env->no_report;
  	u32 btf_id;
  	int err;
 =20
@@@ -11446,15 -11411,26 +11415,26 @@@
  		return -EINVAL;
 =20
  	err =3D btf_check_func_arg_match(env, subprog, btf);
+ 	env->no_report =3D no_report;
  	/* Compiler optimizations can remove arguments from static functions
  	 * or mismatched type can be passed into a global function.
- 	 * In such cases mark the function as unreliable from BTF point of view.
+ 	 * Mark a static function as unreliable from BTF point of view. The othe=
r call is unproven.
  	 */
- 	if (err)
+ 	if (err && !bpf_subprog_is_global(env, subprog))
  		prog->aux->func_info_aux[subprog].unreliable =3D true;
  	return err;
  }
 =20
+ /* The helper returns */
+ static void leave_callback(struct bpf_func_state *caller)
+ {
+ 	struct loop_stack_entry *entry =3D bpf_top_loop(caller);
+=20
+ 	caller->callback_depth =3D 0;
+ 	if (entry && entry->loop->kind =3D=3D BPF_LOOP_CALLBACK)
+ 		leave_loops(caller, caller->loop_stack_cnt - 1);
+ }
+=20
  static int push_callback_call(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
  			      int insn_idx, int subprog,
  			      set_callee_state_fn set_callee_state_cb)
@@@ -11492,6 -11468,8 +11472,8 @@@
  	if (bpf_is_async_callback_calling_insn(insn)) {
  		struct bpf_verifier_state *async_cb;
 =20
+ 		if (state->speculative)
+ 			return 0;
  		/* there is no real recursion here. timer and workqueue callbacks are a=
sync */
  		env->subprog_info[subprog].is_async_cb =3D true;
  		async_cb =3D push_async_cb(env, env->subprog_info[subprog].start,
@@@ -11500,9 -11478,8 +11482,8 @@@
  		if (IS_ERR(async_cb))
  			return PTR_ERR(async_cb);
  		if (is_async_cb_sleepable(env, insn))
- 			mark_sleepable_async_cb(env);
+ 			env->sleepable_async_cb =3D true;
  		callee =3D async_cb->frame[0];
- 		callee->async_entry_cnt =3D state->frame[0]->async_entry_cnt + 1;
 =20
  		/* Convert bpf_timer_set_callback() args into timer callback args */
  		err =3D set_callee_state_cb(env, caller, callee, insn_idx);
@@@ -11525,7 -11502,7 +11506,7 @@@
  	    (insn->imm =3D=3D BPF_FUNC_loop || insn->imm =3D=3D BPF_FUNC_for_eac=
h_map_elem))
  		env->subprog_info[subprog].is_loop_cb =3D true;
  	else
- 		env->subprog_info[subprog].is_called =3D true;
+ 		env->subprog_info[subprog].is_other_cb =3D true;
 =20
  	/* for callback functions enqueue entry to callback and
  	 * proceed with next instruction within current frame.
@@@ -11539,25 -11516,284 +11520,284 @@@
  	if (err)
  		return err;
 =20
- 	callback_state->callback_unroll_depth++;
  	callback_state->frame[callback_state->curframe - 1]->callback_depth++;
- 	caller->callback_depth =3D 0;
+ 	leave_callback(caller);
  	return 0;
  }
 =20
+ enum {
+ 	PROCESS_BPF_EXIT =3D 1,
+ 	INSN_IDX_UPDATED =3D 2,
+ };
+=20
  static int process_bpf_exit_full(struct bpf_verifier_env *env,
  				 bool *do_print_state, bool exception_exit);
+ static void account_current_path(struct bpf_verifier_env *env);
 =20
  /*
-  * Call of a static subprog. The callee is verified in the context of
-  * the caller, hence set up a new frame and continue from the first
-  * instruction of the callee.
+  * The function can be verified on its own, for the state at its entry, w=
hen
+  * what it does depends on its arguments only and it cannot get to what i=
ts
+  * callers have: nothing points to their stack.
+  *
+  * What the callers hold, references, locks and so on, is a part of that =
state:
+  * it matters for what the function can do.
+  */
+=20
+ /* What func_is_on_its_own() asks of an argument, be it in a register or =
on the stack */
+ static bool arg_needs_caller(struct bpf_verifier_env *env, const struct b=
pf_verifier_state *state,
+ 			     const struct bpf_subprog_info *sub, const struct bpf_reg_state *r=
eg)
+ {
+ 	/* it can load a __ref argument from the context and release it */
+ 	if (reg->type =3D=3D PTR_TO_CTX && state->acquired_refs &&
+ 	    env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS)
+ 		return true;
+ 	/* only the ids of what is held mean something without the caller */
+ 	if (bpf_id_is_xreg(reg->id | reg->parent_id | reg->map_uid))
+ 		return true;
+ 	/*
+ 	 * Packet pointers that share an id have ranges of the same size, see
+ 	 * find_good_pkt_pointers(). The result has the range of all calls of th=
e instance.
+ 	 */
+ 	if (reg_is_pkt_pointer(reg) && reg->id)
+ 		return true;
+ 	/* it checks how much of the packet is there, for the caller */
+ 	if ((reg->type =3D=3D PTR_TO_PACKET_END ||
+ 	     (reg->type =3D=3D PTR_TO_PACKET && sub->loads_pkt_end)) && !sub->re=
cursive)
+ 		return true;
+ 	/* or whether there is something to point to */
+ 	return type_may_be_null(reg->type) && !sub->recursive;
+ }
+=20
+ static bool func_is_on_its_own(struct bpf_verifier_env *env, struct bpf_v=
erifier_state *state,
+ 			       int subprog)
+ {
+ 	struct bpf_func_state *caller =3D state->frame[state->curframe];
+ 	struct bpf_subprog_info *sub =3D &env->subprog_info[subprog];
+ 	u16 live =3D env->insn_aux_data[sub->start].live_regs_before;
+ 	u32 i;
+=20
+ 	if (sub->changes_pkt_data || sub->has_tail_call || sub->has_ld_abs ||
+ 	    sub->is_cb || sub->is_async_cb || sub->is_exception_cb)
+ 		return false;
+ 	if (env->path_sensitive)
+ 		return false;
+ 	if (sub->releases_inherited &&
+ 	    (state->acquired_refs || state->active_rcu_locks || state->active_pr=
eempt_locks))
+ 		return false;
+ 	/* what must not be done in that callback is refused by looking at the f=
rames */
+ 	if (in_rbtree_lock_required_cb(env))
+ 		return false;
+ 	for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
+ 		if (!(live & BIT(i)))
+ 			continue;
+ 		if (caller->regs[i].type =3D=3D PTR_TO_STACK ||
+ 		    base_type(caller->regs[i].type) =3D=3D CONST_PTR_TO_DYNPTR)
+ 			return false;
+ 		if (arg_needs_caller(env, state, sub, &caller->regs[i]))
+ 			return false;
+ 	}
+ 	/* callx of one function of a set asks before it is checked that the arg=
uments are there */
+ 	for (i =3D 0; i < bpf_in_stack_arg_cnt(sub) && i < caller->out_stack_arg=
_cnt; i++) {
+ 		if (caller->stack_arg_regs[i].type =3D=3D PTR_TO_STACK ||
+ 		    base_type(caller->stack_arg_regs[i].type) =3D=3D CONST_PTR_TO_DYNPT=
R)
+ 			return false;
+ 		if (arg_needs_caller(env, state, sub, &caller->stack_arg_regs[i]))
+ 			return false;
+ 	}
+ 	return sub->recursive || !bpf_call_needs_frames(env, state, live);
+ }
+=20
+ static int enter_recursion(struct bpf_verifier_env *env, struct bpf_func_=
state *callee);
+ static int check_held_in_leftover(struct bpf_verifier_env *env,
+ 				  const struct loop_stack_entry *entry);
+=20
+ static int call_func_on_its_own(struct bpf_verifier_env *env, int subprog=
, int insn_idx)
+ {
+ 	u16 live =3D env->insn_aux_data[env->subprog_info[subprog].start].live_r=
egs_before;
+ 	struct bpf_verifier_state *state =3D env->cur_state;
+ 	struct bpf_func_state *caller =3D state->frame[state->curframe], *callee=
, *frame;
+ 	struct bpf_verifier_state entry =3D {};
+ 	struct bpf_reg_state *reg;
+ 	int i, err;
+=20
+ 	callee =3D kzalloc_obj(*callee, BPF_VERIFIER_GFP);
+ 	if (!callee)
+ 		return -ENOMEM;
+ 	entry.frame[0] =3D callee;
+ 	entry.speculative =3D state->speculative;
+ 	entry.in_sleepable =3D state->in_sleepable;
+ 	entry.suspect_loops =3D state->suspect_loops;
+ 	entry.callers_unknown =3D state->callers_unknown;
+ 	init_func_state(env, callee, BPF_MAIN_FUNC, 0, subprog);
+ 	/* the frame that says so is not there when the function is verified */
+ 	callee->in_rcu_callback_fn =3D in_rcu_callback(env);
+ 	for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
+ 		if (live & BIT(i))
+ 			callee->regs[i] =3D caller->regs[i];
+ 	i =3D bpf_in_stack_arg_cnt(&env->subprog_info[subprog]);
+ 	err =3D grow_stack_arg_slots(env, callee, i) ?: enter_recursion(env, cal=
lee);
+ 	if (err) {
+ 		bpf_free_verifier_state(env, &entry, false);
+ 		return err;
+ 	}
+ 	for (i =3D 0; i < callee->out_stack_arg_cnt; i++)
+ 		callee->stack_arg_regs[i] =3D caller->stack_arg_regs[i];
+=20
+ 	err =3D copy_reference_state(&entry, state);
+ 	if (err) {
+ 		bpf_free_verifier_state(env, &entry, false);
+ 		return err;
+ 	}
+ 	bpf_for_each_reg_in_vstate(&entry, frame, reg, reg->grew_once =3D false);
+ 	entry.max_held_cnt =3D state->max_held_cnt;
+ 	callee->entry_refs =3D entry.acquired_refs;
+ 	callee->entry_rcu_locks =3D entry.active_rcu_locks;
+ 	callee->entry_preempt_locks =3D entry.active_preempt_locks;
+=20
+ 	account_current_path(env);
+ 	env->subprog_info[subprog].on_its_own =3D true;
+ 	err =3D bpf_flow_call(env, state, &entry, subprog, insn_idx);
+ 	bpf_free_verifier_state(env, &entry, false);
+ 	/* the call waits, there is nothing to go on with */
+ 	return err ?: PROCESS_BPF_EXIT;
+ }
+=20
+ /*
+  * A void function can leave a pointer to the stack in r0. The caller can=
not read it. That holds
+  * for the stack of a caller too: for stack liveness a call returns no po=
inter to the stack.
+  */
+ static void hide_returned_stack_ptrs(struct bpf_verifier_env *env, int su=
bprog,
+ 				     struct bpf_reg_state *regs)
+ {
+ 	u32 i, nregs =3D bpf_ret_reg_pair(env, subprog) ? 2 : 1;
+=20
+ 	for (i =3D 0; i < nregs; i++) {
+ 		if (regs[ret_regs[i]].type !=3D PTR_TO_STACK)
+ 			continue;
+ 		verbose(env, "the caller cannot read the stack pointer in R%d\n", ret_r=
egs[i]);
+ 		bpf_diag_record_scrub(env, &regs[ret_regs[i]], BPF_DIAG_MOD_RET_STACK_P=
TR);
+ 		bpf_mark_reg_not_init(env, &regs[ret_regs[i]]);
+ 	}
+ }
+=20
+ /* The current state is at exit of a function that is verified on its own=
=2E */
+ static int exit_func_on_its_own(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_verifier_state *state =3D env->cur_state;
+ 	struct bpf_func_state *callee =3D state->frame[0];
+ 	int err;
+=20
+ 	hide_returned_stack_ptrs(env, callee->subprogno, callee->regs);
+ 	state->unwound |=3D bpf_is_unwind_exit(&env->prog->insnsi[env->insn_idx]=
);
+=20
+ 	/* Invalidate callee-local dynptrs and their slices before the frame goe=
s away. */
+ 	err =3D destroy_dynptrs_in_stack_slots(env, callee, 0,
+ 					     callee->allocated_stack / BPF_REG_SIZE - 1);
+ 	/* what comes out of a recursion goes around too */
+ 	if (!err && env->subprog_info[callee->subprogno].recursive)
+ 		err =3D check_held_in_leftover(env, callee->loop_stack);
+ 	if (err)
+ 		return err;
+=20
+ 	account_current_path(env);
+ 	err =3D bpf_flow_exit(env, state, env->insn_idx);
+ 	return err ?: PROCESS_BPF_EXIT;
+ }
+=20
+ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 =
regno, bool is_null);
+=20
+ static u32 returned_id(u32 id)
+ {
+ 	return bpf_id_is_xreg(id) ? BPF_RETURNED_ID(id) : id;
+ }
+=20
+ /*
+  * @caller waits at the call at @call_idx. @exit is the state at the exit=
 of the
+  * function. Make @caller the state after the call.
+  */
+ int bpf_flow_return(struct bpf_verifier_env *env, struct bpf_verifier_sta=
te *caller,
+ 		    const struct bpf_verifier_state *exit, int call_idx)
+ {
+ 	struct bpf_func_state *frame =3D caller->frame[caller->curframe];
+ 	const struct bpf_func_state *callee =3D exit->frame[0];
+ 	u32 i, nregs, nheld =3D caller->acquired_refs;
+ 	struct bpf_reg_state *reg;
+ 	int err;
+=20
+ 	caller->speculative |=3D exit->speculative;
+ 	/*
+ 	 * Keep only what the function held all the time. The state at its exit =
looks the same if
+ 	 * the function released a lock and acquired it again. Else verify the f=
unction in the
+ 	 * instance of the caller.
+ 	 */
+ 	if (callee->entry_refs < nheld || callee->entry_rcu_locks < caller->acti=
ve_rcu_locks ||
+ 	    callee->entry_preempt_locks < caller->active_preempt_locks) {
+ 		if (exit->speculative)
+ 			return -EACCES;
+ 		if (env->log.level & BPF_LOG_LEVEL2)
+ 			verbose(env, "func#%d releases what its caller holds at insn %d\n",
+ 				callee->subprogno, call_idx);
+ 		env->subprog_info[callee->subprogno].releases_inherited =3D true;
+ 		return BPF_EXIT_NEEDS_CALLER;
+ 	}
+ 	if (exit->unwound && !bpf_is_unwind_goto(&env->prog->insnsi[call_idx + 1=
])) {
+ 		verbose(env, "unwind_exit, but no unwind_goto after the call at insn %d=
\n",
+ 			call_idx);
+ 		return -EINVAL;
+ 	}
+ 	caller->unwound =3D exit->unwound;
+ 	caller->max_held_cnt =3D max(caller->max_held_cnt, exit->max_held_cnt);
+ 	caller->suspect_loops |=3D exit->suspect_loops;
+=20
+ 	/*
+ 	 * bpf_check_cfg() takes the subprog that loads the address of a functio=
n for the
+ 	 * one that calls it. This one got the address from its caller. What it =
means for
+ 	 * the packet pointers of the caller is found out in the context of the =
caller.
+ 	 */
+ 	if (exit->changed_pkt_data) {
+ 		if (exit->speculative)
+ 			return -EACCES;
+ 		env->subprog_info[callee->subprogno].changes_pkt_data =3D true;
+ 		return BPF_EXIT_NEEDS_CALLER;
+ 	}
+=20
+ 	for (i =3D 0; i < CALLER_SAVED_REGS; i++)
+ 		bpf_mark_reg_not_init(env, &frame->regs[caller_saved[i]]);
+ 	for (i =3D 0; i < frame->out_stack_arg_cnt; i++)
+ 		bpf_mark_reg_not_init(env, &frame->stack_arg_regs[i]);
+=20
+ 	/* what is held now is what was held at the call and what the function t=
ook */
+ 	err =3D resize_reference_state(caller, exit->acquired_refs);
+ 	if (err)
+ 		return err;
+ 	for (i =3D nheld; i < exit->acquired_refs; i++)
+ 		caller->refs[i] =3D exit->refs[i];
+ 	caller->held =3D exit->held;
+=20
+ 	nregs =3D bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
+ 	for (i =3D 0; i < nregs; i++) {
+ 		reg =3D &frame->regs[ret_regs[i]];
+ 		*reg =3D callee->regs[ret_regs[i]];
+ 		reg->id =3D returned_id(reg->id);
+ 		reg->parent_id =3D returned_id(reg->parent_id);
+ 		reg->map_uid =3D returned_id(reg->map_uid);
+ 		/* the function saw that a reference of the caller is not NULL */
+ 		if (reg->id && !type_may_be_null(reg->type))
+ 			mark_ptr_or_null_regs(caller, ret_regs[i], false);
+ 	}
+ 	return 0;
+ }
+=20
+ /*
+  * Call of a static subprog. Unless the callee is verified on its own it =
is
+  * verified in the context of the caller, hence set up a new frame and
+  * continue from the first instruction of the callee.
   */
  static int check_static_func_call(struct bpf_verifier_env *env, int subpr=
og,
  				  int *insn_idx)
  {
+ 	struct bpf_subprog_info *caller_info, *callee_info =3D &env->subprog_inf=
o[subprog];
  	struct bpf_verifier_state *state =3D env->cur_state;
- 	struct bpf_subprog_info *caller_info;
  	u16 callee_incoming, stack_arg_cnt;
  	struct bpf_func_state *caller;
  	int err;
@@@ -11568,12 -11804,26 +11808,26 @@@
  	/*
  	 * Track caller's total stack arg count (incoming + max outgoing).
  	 * This is needed so the JIT knows how much stack arg space to allocate.
+ 	 * The callee can load less than its prototype has, and the caller can s=
till store
+ 	 * all of it. Count the slots of the prototype only as far as the caller=
 has stored
+ 	 * them: compilers store before the call. check_after_pass() fails for t=
he rest.
  	 */
  	caller_info =3D &env->subprog_info[caller->subprogno];
- 	callee_incoming =3D bpf_in_stack_arg_cnt(&env->subprog_info[subprog]);
- 	stack_arg_cnt =3D bpf_in_stack_arg_cnt(caller_info) + callee_incoming;
+ 	callee_incoming =3D bpf_in_stack_arg_cnt(callee_info);
+ 	stack_arg_cnt =3D bpf_in_stack_arg_cnt(caller_info) +
+ 			max_t(int, callee_incoming,
+ 			      min_t(int, caller_info->max_out_stack_arg_cnt,
+ 				    callee_info->arg_slot_cnt - MAX_BPF_FUNC_REG_ARGS));
  	if (stack_arg_cnt > caller_info->stack_arg_cnt)
  		caller_info->stack_arg_cnt =3D stack_arg_cnt;
+ 	/* btf_check_subprog_call() doesn't get to it when BTF is not reliable */
+ 	err =3D check_outgoing_stack_args(env, caller, MAX_BPF_FUNC_REG_ARGS + c=
allee_incoming,
+ 					bpf_subprog_name(env, subprog), NULL, NULL);
+ 	if (err)
+ 		return err;
+=20
+ 	if (func_is_on_its_own(env, state, subprog))
+ 		return call_func_on_its_own(env, subprog, *insn_idx);
 =20
  	/*
  	 * For regular function entry setup new frame and continue
@@@ -11617,6 -11867,8 +11871,8 @@@ static int check_func_call(struct bpf_v
  	err =3D btf_check_subprog_call(env, subprog);
  	if (err =3D=3D -EFAULT)
  		return err;
+ 	if (err =3D=3D -ENODATA)
+ 		return -EINVAL;
  	if (bpf_subprog_is_global(env, subprog)) {
  		struct bpf_func_info_aux *sub_aux =3D subprog_aux(env, subprog);
  		const char *sub_name =3D bpf_subprog_name(env, subprog);
@@@ -11736,13 -11988,106 +11992,106 @@@
   * PTR_TO_FUNC register identifies the callee, so from here on callx is v=
erified
   * as a direct call of that static subprog.
   */
+ static int check_func_callx_one(struct bpf_verifier_env *env, int subprog=
, int *insn_idx)
+ {
+ 	int err;
+=20
+ 	err =3D btf_check_subprog_call(env, subprog);
+ 	if (err =3D=3D -EFAULT)
+ 		return err;
+ 	if (err =3D=3D -ENODATA)
+ 		return -EINVAL;
+=20
+ 	/* bpf_compute_live_registers() counts on it */
+ 	if (verifier_bug_if(!env->subprog_info[subprog].addr_taken, env,
+ 			    "callx of %s() whose address is not taken",
+ 			    bpf_subprog_name(env, subprog)))
+ 		return -EFAULT;
+=20
+ 	err =3D record_callx_edge(env, cur_func(env)->subprogno, subprog);
+ 	if (err)
+ 		return err;
+ 	env->subprog_info[subprog].via_callx =3D true;
+=20
+ 	return check_static_func_call(env, subprog, insn_idx);
+ }
+=20
+ /* The insn needs to know the function: go on with each function of the s=
et. */
+ static int split_func_set(struct bpf_verifier_env *env, int regno)
+ {
+ 	struct bpf_reg_state *reg =3D reg_state(env, regno);
+ 	struct bpf_verifier_state *branch;
+ 	struct bpf_func_set *set;
+ 	u32 i;
+=20
+ 	if (reg->type !=3D PTR_TO_FUNC || !reg->func_set)
+ 		return 0;
+ 	set =3D env->func_sets[reg->func_set - 1];
+ 	reg->func_set =3D 0;
+ 	for (i =3D 0; i < set->cnt; i++) {
+ 		reg->subprogno =3D set->subprog[i];
+ 		if (i =3D=3D set->cnt - 1)
+ 			break;
+ 		branch =3D push_stack(env, env->insn_idx, env->insn_idx, false);
+ 		if (IS_ERR(branch))
+ 			return PTR_ERR(branch);
+ 		env->head->again =3D true;
+ 	}
+ 	return 0;
+ }
+=20
+ /*
+  * callx of one of the functions of a set. A function that is verified on=
 its own
+  * gets a copy of the state that waits for it. Nothing meets at an insn.
+  */
+ static int check_func_callx_set(struct bpf_verifier_env *env, int regno, =
int *insn_idx)
+ {
+ 	struct bpf_verifier_state *cur =3D env->cur_state, *copy, *branch;
+ 	struct bpf_reg_state *reg =3D reg_state(env, regno);
+ 	struct bpf_func_set *set =3D env->func_sets[reg->func_set - 1];
+ 	int err =3D 0;
+ 	u32 i;
+=20
+ 	/* once, and not in every copy */
+ 	account_current_path(env);
+ 	reg->func_set =3D 0;
+ 	for (i =3D 0; i < set->cnt && !err; i++) {
+ 		reg->subprogno =3D set->subprog[i];
+ 		if (!func_is_on_its_own(env, cur, set->subprog[i])) {
+ 			branch =3D push_stack(env, *insn_idx, *insn_idx, false);
+ 			if (IS_ERR(branch))
+ 				return PTR_ERR(branch);
+ 			env->head->again =3D true;
+ 			continue;
+ 		}
+ 		copy =3D kzalloc_obj(*copy, BPF_VERIFIER_GFP);
+ 		if (!copy)
+ 			return -ENOMEM;
+ 		err =3D bpf_copy_verifier_state(env, copy, cur);
+ 		if (!err) {
+ 			env->cur_state =3D copy;
+ 			err =3D check_func_callx_one(env, set->subprog[i], insn_idx);
+ 			env->cur_state =3D cur;
+ 			/* do_check_block() looks at the state that failed */
+ 			if (err < 0)
+ 				swap(*cur, *copy);
+ 		}
+ 		bpf_free_verifier_state(env, copy, true);
+ 		if (err =3D=3D PROCESS_BPF_EXIT)
+ 			err =3D 0;
+ 		else if (verifier_bug_if(!err, env, "callx: func#%d doesn't wait", set-=
>subprog[i]))
+ 			err =3D -EFAULT;
+ 	}
+ 	/* all that is to be done has a state of its own */
+ 	return err ?: PROCESS_BPF_EXIT;
+ }
+=20
  static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
  			    int *insn_idx)
  {
- 	struct bpf_func_state *caller =3D cur_func(env);
  	struct bpf_reg_state *reg;
  	const char *reason;
- 	int err, subprog;
+ 	int err;
 =20
  	err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
  	if (err)
@@@ -11750,6 -12095,7 +12099,7 @@@
 =20
  	reg =3D reg_state(env, insn->dst_reg);
  	if (reg->type !=3D PTR_TO_FUNC) {
+ 		bpf_note_needs_ptr(env, reg);
  		verbose(env, "R%d has type %s, expected func\n", insn->dst_reg,
  			reg_type_str(env, reg->type));
  		reason =3D bpf_diag_fmt(
@@@ -11775,16 -12121,19 +12125,19 @@@
  		return err;
 =20
  	/* PTR_TO_FUNC is a pointer to a static subprog */
- 	subprog =3D reg->subprogno;
- 	err =3D btf_check_subprog_call(env, subprog);
- 	if (err =3D=3D -EFAULT)
- 		return err;
+ 	if (reg->func_set)
+ 		return check_func_callx_set(env, insn->dst_reg, insn_idx);
+ 	return check_func_callx_one(env, reg->subprogno, insn_idx);
+ }
 =20
- 	err =3D record_callx_edge(env, caller->subprogno, subprog);
- 	if (err)
- 		return err;
-=20
- 	return check_static_func_call(env, subprog, insn_idx);
+ static void mark_map_callback_reg(struct bpf_reg_state *reg,
+ 				  const struct bpf_reg_state *map_reg,
+ 				  enum bpf_reg_type type)
+ {
+ 	reg->type =3D type;
+ 	__mark_reg_known_zero(reg);
+ 	reg->map_ptr =3D map_reg->map_ptr;
+ 	reg->map_uid =3D map_reg->map_uid;
  }
 =20
  int map_set_for_each_callback_args(struct bpf_verifier_env *env,
@@@ -11798,25 -12147,25 +12151,25 @@@
  	 */
  	callee->regs[BPF_REG_1] =3D caller->regs[BPF_REG_1];
 =20
- 	callee->regs[BPF_REG_2].type =3D PTR_TO_MAP_KEY;
- 	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
- 	callee->regs[BPF_REG_2].map_ptr =3D caller->regs[BPF_REG_1].map_ptr;
- 	callee->regs[BPF_REG_2].map_uid =3D caller->regs[BPF_REG_1].map_uid;
-=20
- 	callee->regs[BPF_REG_3].type =3D PTR_TO_MAP_VALUE;
- 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
- 	callee->regs[BPF_REG_3].map_ptr =3D caller->regs[BPF_REG_1].map_ptr;
- 	callee->regs[BPF_REG_3].map_uid =3D caller->regs[BPF_REG_1].map_uid;
- 	callee->regs[BPF_REG_3].id =3D ++env->id_gen;
+ 	mark_map_callback_reg(&callee->regs[BPF_REG_2], &caller->regs[BPF_REG_1]=
, PTR_TO_MAP_KEY);
+ 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_1]=
, PTR_TO_MAP_VALUE);
+ 	callee->regs[BPF_REG_3].id =3D bpf_new_id(env);
 =20
  	/* pointer to stack or null */
  	callee->regs[BPF_REG_4] =3D caller->regs[BPF_REG_3];
-=20
- 	/* unused */
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
  	return 0;
  }
 =20
+ /* The arg points into the stack frame of the helper that calls the callb=
ack */
+ void mark_frame_scoped_arg(struct bpf_verifier_env *env,
+ 			   struct bpf_func_state *callee, u32 regno)
+ {
+ 	if (!callee->frame_id)
+ 		callee->frame_id =3D bpf_new_id(env);
+ 	callee->regs[regno].id =3D callee->frame_id;
+ 	callee->regs[regno].parent_id =3D callee->frame_id;
+ }
+=20
  static int set_callee_state(struct bpf_verifier_env *env,
  			    struct bpf_func_state *caller,
  			    struct bpf_func_state *callee, int insn_idx)
@@@ -11882,11 -12231,6 +12235,6 @@@ static int set_loop_callback_state(stru
  	callee->regs[BPF_REG_1].type =3D SCALAR_VALUE;
  	callee->regs[BPF_REG_2] =3D caller->regs[BPF_REG_3];
 =20
- 	/* unused */
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
-=20
  	callee->in_callback_fn =3D true;
  	callee->callback_ret_range =3D retval_range(0, 1);
  	return 0;
@@@ -11897,33 -12241,15 +12245,15 @@@ static int set_timer_callback_state(s=
tr
  				    struct bpf_func_state *callee,
  				    int insn_idx)
  {
- 	struct bpf_map *map_ptr =3D caller->regs[BPF_REG_1].map_ptr;
- 	u32 map_uid =3D caller->regs[BPF_REG_1].map_uid;
-=20
  	/* bpf_timer_set_callback(struct bpf_timer *timer, void *callback_fn);
  	 * callback_fn(struct bpf_map *map, void *key, void *value);
  	 */
- 	callee->regs[BPF_REG_1].type =3D CONST_PTR_TO_MAP;
- 	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
- 	callee->regs[BPF_REG_1].map_ptr =3D map_ptr;
- 	callee->regs[BPF_REG_1].map_uid =3D map_uid;
+ 	mark_map_callback_reg(&callee->regs[BPF_REG_1], &caller->regs[BPF_REG_1]=
, CONST_PTR_TO_MAP);
+ 	mark_map_callback_reg(&callee->regs[BPF_REG_2], &caller->regs[BPF_REG_1]=
, PTR_TO_MAP_KEY);
+ 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_1]=
, PTR_TO_MAP_VALUE);
+ 	callee->regs[BPF_REG_3].id =3D bpf_new_id(env);
 =20
- 	callee->regs[BPF_REG_2].type =3D PTR_TO_MAP_KEY;
- 	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
- 	callee->regs[BPF_REG_2].map_ptr =3D map_ptr;
- 	callee->regs[BPF_REG_2].map_uid =3D map_uid;
-=20
- 	callee->regs[BPF_REG_3].type =3D PTR_TO_MAP_VALUE;
- 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
- 	callee->regs[BPF_REG_3].map_ptr =3D map_ptr;
- 	callee->regs[BPF_REG_3].map_uid =3D map_uid;
- 	callee->regs[BPF_REG_3].id =3D ++env->id_gen;
-=20
- 	/* unused */
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
  	callee->in_async_callback_fn =3D true;
- 	callee->callback_ret_range =3D retval_range(0, 0);
  	return 0;
  }
 =20
@@@ -11946,10 -12272,6 +12276,6 @@@ static int set_find_vma_callback_state(
 =20
  	/* pointer to stack or null */
  	callee->regs[BPF_REG_3] =3D caller->regs[BPF_REG_4];
-=20
- 	/* unused */
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
  	callee->in_callback_fn =3D true;
  	/* bpf_find_vma() runs the callback under mmap_lock and RCU. */
  	callee->in_rcu_callback_fn =3D true;
@@@ -11966,15 -12288,10 +12292,10 @@@ static int set_user_ringbuf_callback_=
st
  	 *			  callback_ctx, u64 flags);
  	 * callback_fn(const struct bpf_dynptr_t* dynptr, void *callback_ctx);
  	 */
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
  	mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
+ 	mark_frame_scoped_arg(env, callee, BPF_REG_1);
  	callee->regs[BPF_REG_2] =3D caller->regs[BPF_REG_3];
 =20
- 	/* unused */
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
-=20
  	callee->in_callback_fn =3D true;
  	callee->callback_ret_range =3D retval_range(0, 1);
  	return 0;
@@@ -12005,9 -12322,6 +12326,6 @@@ static int set_rbtree_add_callback_stat
  	mark_reg_graph_node(callee->regs, BPF_REG_2, &field->graph_root);
  	ref_set_non_owning(env, &callee->regs[BPF_REG_2]);
 =20
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
  	callee->in_callback_fn =3D true;
  	callee->callback_ret_range =3D retval_range(0, 1);
  	return 0;
@@@ -12018,31 -12332,14 +12336,14 @@@ static int set_task_work_schedule_cal=
lb
  						 struct bpf_func_state *callee,
  						 int insn_idx)
  {
- 	struct bpf_map *map_ptr =3D caller->regs[BPF_REG_3].map_ptr;
- 	u32 map_uid =3D caller->regs[BPF_REG_3].map_uid;
-=20
  	/*
  	 * callback_fn(struct bpf_map *map, void *key, void *value);
  	 */
- 	callee->regs[BPF_REG_1].type =3D CONST_PTR_TO_MAP;
- 	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
- 	callee->regs[BPF_REG_1].map_ptr =3D map_ptr;
- 	callee->regs[BPF_REG_1].map_uid =3D map_uid;
+ 	mark_map_callback_reg(&callee->regs[BPF_REG_1], &caller->regs[BPF_REG_3]=
, CONST_PTR_TO_MAP);
+ 	mark_map_callback_reg(&callee->regs[BPF_REG_2], &caller->regs[BPF_REG_3]=
, PTR_TO_MAP_KEY);
+ 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_3]=
, PTR_TO_MAP_VALUE);
+ 	callee->regs[BPF_REG_3].id =3D bpf_new_id(env);
 =20
- 	callee->regs[BPF_REG_2].type =3D PTR_TO_MAP_KEY;
- 	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
- 	callee->regs[BPF_REG_2].map_ptr =3D map_ptr;
- 	callee->regs[BPF_REG_2].map_uid =3D map_uid;
-=20
- 	callee->regs[BPF_REG_3].type =3D PTR_TO_MAP_VALUE;
- 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
- 	callee->regs[BPF_REG_3].map_ptr =3D map_ptr;
- 	callee->regs[BPF_REG_3].map_uid =3D map_uid;
- 	callee->regs[BPF_REG_3].id =3D ++env->id_gen;
-=20
- 	/* unused */
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
  	callee->in_async_callback_fn =3D true;
  	callee->callback_ret_range =3D retval_range(S32_MIN, S32_MAX);
  	return 0;
@@@ -12053,30 -12350,13 +12354,13 @@@ static int set_rcu_callback_state(str=
uc
  				  struct bpf_func_state *callee,
  				  int insn_idx)
  {
- 	struct bpf_map *map_ptr =3D caller->regs[BPF_REG_2].map_ptr;
- 	u32 map_uid =3D caller->regs[BPF_REG_2].map_uid;
-=20
  	/*
  	 * callback_fn(struct bpf_map *map, void *key, void *value);
  	 */
- 	callee->regs[BPF_REG_1].type =3D CONST_PTR_TO_MAP;
- 	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
- 	callee->regs[BPF_REG_1].map_ptr =3D map_ptr;
- 	callee->regs[BPF_REG_1].map_uid =3D map_uid;
+ 	mark_map_callback_reg(&callee->regs[BPF_REG_1], &caller->regs[BPF_REG_2]=
, CONST_PTR_TO_MAP);
+ 	mark_map_callback_reg(&callee->regs[BPF_REG_2], &caller->regs[BPF_REG_2]=
, PTR_TO_MAP_KEY);
+ 	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_2]=
, PTR_TO_MAP_VALUE);
 =20
- 	callee->regs[BPF_REG_2].type =3D PTR_TO_MAP_KEY;
- 	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
- 	callee->regs[BPF_REG_2].map_ptr =3D map_ptr;
- 	callee->regs[BPF_REG_2].map_uid =3D map_uid;
-=20
- 	callee->regs[BPF_REG_3].type =3D PTR_TO_MAP_VALUE;
- 	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
- 	callee->regs[BPF_REG_3].map_ptr =3D map_ptr;
- 	callee->regs[BPF_REG_3].map_uid =3D map_uid;
-=20
- 	/* unused */
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
- 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
  	callee->in_async_callback_fn =3D true;
  	callee->callback_ret_range =3D retval_range(S32_MIN, S32_MAX);
  	return 0;
@@@ -12089,6 -12369,7 +12373,7 @@@ static void account_processed_insn(stru
  	struct bpf_func_state *frame =3D cur_func(env);
 =20
  	env->insn_processed++;
+ 	bpf_add_cost(env, 1, BPF_COST_INSN);
  	frame->insns_subtotal++;
  	env->subprog_info[frame->subprogno].insns_self++;
  }
@@@ -12156,31 -12437,18 +12441,18 @@@ static bool retval_range_within(struc=
t=20
 =20
  static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
  {
- 	struct bpf_verifier_state *state =3D env->cur_state, *prev_st;
+ 	struct bpf_verifier_state *state =3D env->cur_state;
  	struct bpf_func_state *caller, *callee;
  	struct bpf_reg_state *r0;
- 	bool in_callback_fn;
  	u32 i, nregs;
  	int err;
 =20
  	callee =3D state->frame[state->curframe];
  	r0 =3D &callee->regs[BPF_REG_0];
  	nregs =3D bpf_ret_reg_pair(env, callee->subprogno) ? 2 : 1;
- 	for (i =3D 0; i < nregs; i++) {
- 		if (callee->regs[ret_regs[i]].type !=3D PTR_TO_STACK)
- 			continue;
- 		/* technically it's ok to return caller's stack pointer
- 		 * (or caller's caller's pointer) back to the caller,
- 		 * since these pointers are valid. Only current stack
- 		 * pointer will be invalid as soon as function exits,
- 		 * but let's be conservative
- 		 */
- 		verbose(env, "cannot return stack pointer to the caller\n");
- 		return -EINVAL;
- 	}
 =20
  	caller =3D state->frame[state->curframe - 1];
- 	if (bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx])) {
+ 	if (bpf_is_unwind_exit(&env->prog->insnsi[*insn_idx]) || state->unwound)=
 {
  		/* the helper or the kfunc that called it doesn't expect that */
  		if (callee->in_callback_fn) {
  			verbose(env, "callback cannot unwind\n");
@@@ -12194,15 -12462,23 +12466,23 @@@
  		state->unwound =3D true;
  	}
  	if (callee->in_callback_fn) {
+ 		/* the helper continues after the barrier of its call */
+ 		if (state->speculative)
+ 			return -EACCES;
  		if (r0->type !=3D SCALAR_VALUE) {
  			verbose(env, "R0 not a scalar value\n");
  			return -EACCES;
  		}
 =20
- 		/* we are going to rely on register's precise value */
- 		err =3D mark_chain_precision(env, BPF_REG_0);
- 		if (err)
- 			return err;
+ 		/* It's called any number of times: what it takes it has to release. */
+ 		for (i =3D callee->entry_refs; i < state->acquired_refs; i++) {
+ 			if (state->refs[i].type !=3D REF_TYPE_PTR)
+ 				continue;
+ 			verbose(env, "Unreleased reference id=3D%d alloc_insn=3D%d\n",
+ 				state->refs[i].id, state->refs[i].insn_idx);
+ 			bpf_diag_leak(env, &state->refs[i], *insn_idx);
+ 			return -EINVAL;
+ 		}
 =20
  		/* enforce R0 return value range, and bpf_callback_t returns 64bit */
  		if (!retval_range_within(callee->callback_ret_range, r0)) {
@@@ -12228,6 -12504,7 +12508,7 @@@
  			caller->regs[regno] =3D callee->regs[regno];
  			bpf_diag_mod_end(env);
  		}
+ 		hide_returned_stack_ptrs(env, callee->subprogno, caller->regs);
  	}
 =20
  	/* Invalidate callee-local dynptrs and their slices before the frame goe=
s away. */
@@@ -12236,13 -12513,16 +12517,16 @@@
  	if (err)
  		return err;
  	invalidate_stack_slices(env, callee->frameno, INT_MIN, 0);
+ 	if (callee->frame_id) {
+ 		err =3D invalidate_reference(env, callee->frame_id);
+ 		if (err)
+ 			return err;
+ 	}
 =20
  	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to calls=
ite,
- 	 * there function call logic would reschedule callback visit. If iterati=
on
- 	 * converges is_state_visited() would prune that visit eventually.
+ 	 * there function call logic would reschedule callback visit.
  	 */
- 	in_callback_fn =3D callee->in_callback_fn;
- 	if (in_callback_fn)
+ 	if (callee->in_callback_fn)
  		*insn_idx =3D callee->callsite;
  	else
  		*insn_idx =3D callee->callsite + 1;
@@@ -12255,28 -12535,10 +12539,10 @@@
  	}
  	account_processed_insns(env, callee, caller);
  	/* clear everything in the callee. In case of exceptional exits using
- 	 * bpf_throw, this will be done by copy_verifier_state for extra frames.=
 */
+ 	 * bpf_throw, this will be done by do_check_block() for extra frames. */
  	free_func_state(callee);
  	state->frame[state->curframe--] =3D NULL;
  	invalidate_outgoing_stack_args(env, caller);
-=20
- 	/* for callbacks widen imprecise scalars to make programs like below ver=
ify:
- 	 *
- 	 *   struct ctx { int i; }
- 	 *   void cb(int idx, struct ctx *ctx) { ctx->i++; ... }
- 	 *   ...
- 	 *   struct ctx =3D { .i =3D 0; }
- 	 *   bpf_loop(100, cb, &ctx, 0);
- 	 *
- 	 * This is similar to what is done in process_iter_next_call() for open
- 	 * coded iterators.
- 	 */
- 	prev_st =3D in_callback_fn ? find_prev_entry(env, state, *insn_idx) : NU=
LL;
- 	if (prev_st) {
- 		err =3D widen_imprecise_scalars(env, prev_st, state);
- 		if (err)
- 			return err;
- 	}
  	return 0;
  }
 =20
@@@ -12316,10 -12578,6 +12582,10 @@@ static int do_refine_retval_range(struc
  		    env->prog->expected_attach_type =3D=3D BPF_CGROUP_GETSOCKOPT)
  			break;
 =20
 +		/* It is what the previous struct bpf_tcp_ops returned, any int */
 +		if (prog_type =3D=3D BPF_PROG_TYPE_STRUCT_OPS)
 +			break;
 +
  		if (prog_type =3D=3D BPF_PROG_TYPE_LSM &&
  		    env->prog->expected_attach_type =3D=3D BPF_LSM_CGROUP) {
  			if (!env->prog->aux->attach_func_proto->type)
@@@ -12339,12 -12597,43 +12605,43 @@@
  	return reg_bounds_sanity_check(env, ret_reg, "retval");
  }
 =20
+ /*
+  * The call is rewritten with @num and @meta. One call has one rewrite:
+  *
+  *   if (...) p =3D type1; else p =3D type2;
+  *   bpf_obj_drop(p);                      <- the check fails if the spec=
ial fields differ
+  */
+ static int record_call_fixup(struct bpf_verifier_env *env, u64 num, struc=
t btf_struct_meta *meta)
+ {
+ 	struct bpf_insn_aux_data *aux =3D cur_aux(env);
+ 	struct btf_struct_meta *first =3D aux->kptr_struct_meta;
+=20
+ 	if (!aux->call_recorded) {
+ 		aux->call_recorded =3D true;
+ 		aux->call_num =3D num;
+ 		aux->kptr_struct_meta =3D meta;
+ 		return 0;
+ 	}
+ 	if (aux->call_num =3D=3D num &&
+ 	    btf_record_equal(first ? first->record : NULL, meta ? meta->record :=
 NULL))
+ 		return 0;
+ 	bpf_diag_program_structure(
+ 		env, env->insn_idx, "one call for two types",
+ 		"Use one call for each type. "
+ 		"If the call is in a static function, inline that function. "
+ 		"If a compiler merged two calls, mark the callee with __attribute__((no=
merge)).",
+ 		"This call gets objects with different sizes, special fields or offsets=
, "
+ 		"or two kinds of percpu pointers.");
+ 	return fixups_differ(env, "same call cannot be used with different types=
");
+ }
+=20
  static int
  record_func_map(struct bpf_verifier_env *env, struct bpf_call_arg_meta *m=
eta,
  		int func_id, int insn_idx)
  {
  	struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[insn_idx];
  	struct bpf_map *map =3D meta->map.ptr;
+ 	bool other;
 =20
  	if (func_id !=3D BPF_FUNC_tail_call &&
  	    func_id !=3D BPF_FUNC_map_lookup_elem &&
@@@ -12376,12 -12665,13 +12673,13 @@@
  		return -EACCES;
  	}
 =20
- 	if (!aux->map_ptr_state.map_ptr)
- 		bpf_map_ptr_store(aux, meta->map.ptr,
- 				  !meta->map.ptr->bypass_spec_v1, false);
- 	else if (aux->map_ptr_state.map_ptr !=3D meta->map.ptr)
- 		bpf_map_ptr_store(aux, meta->map.ptr,
- 				  !meta->map.ptr->bypass_spec_v1, true);
+ 	other =3D aux->map_ptr_state.map_ptr && aux->map_ptr_state.map_ptr !=3D =
map;
+ 	/* the index is masked for one map */
+ 	if (func_id =3D=3D BPF_FUNC_tail_call && other &&
+ 	    (bpf_map_ptr_unpriv(aux) || !map->bypass_spec_v1))
+ 		return fixups_differ(env, "tail_call abusing map_ptr");
+ 	if (other || !aux->map_ptr_state.map_ptr)
+ 		bpf_map_ptr_store(aux, map, !map->bypass_spec_v1, other);
  	return 0;
  }
 =20
@@@ -12393,7 -12683,6 +12691,6 @@@ record_func_key(struct bpf_verifier_en
  	struct bpf_reg_state *reg;
  	struct bpf_map *map =3D meta->map.ptr;
  	u64 val, max;
- 	int err;
 =20
  	if (func_id !=3D BPF_FUNC_tail_call)
  		return 0;
@@@ -12411,9 -12700,6 +12708,6 @@@
  		return 0;
  	}
 =20
- 	err =3D mark_chain_precision(env, BPF_REG_3);
- 	if (err)
- 		return err;
  	if (bpf_map_key_unseen(aux))
  		bpf_map_key_store(aux, val);
  	else if (!bpf_map_key_poisoned(aux) &&
@@@ -12444,7 -12730,7 +12738,7 @@@ static int check_reference_leak(struct=
=20
  			continue;
  		verbose(env, "Unreleased reference id=3D%d alloc_insn=3D%d\n",
  			state->refs[i].id, state->refs[i].insn_idx);
- 		bpf_diag_leak(env, state->refs[i].id, state->refs[i].insn_idx, env->ins=
n_idx);
+ 		bpf_diag_leak(env, &state->refs[i], env->insn_idx);
  		refs_lingering =3D true;
  	}
  	return refs_lingering ? -EINVAL : 0;
@@@ -12508,9 -12794,12 +12802,12 @@@ static int check_bpf_snprintf_call(stru
  		return -EINVAL;
  	num_args =3D data_len_reg->var_off.value / 8;
 =20
- 	/* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
- 	 * and map_direct_value_addr is set.
- 	 */
+ 	if (!tnum_is_const(fmt_reg->var_off)) {
+ 		verbose(env, "R3 is not a constant address\n");
+ 		return -EACCES;
+ 	}
+=20
+ 	/* fmt being ARG_PTR_TO_CONST_STR guarantees that map_direct_value_addr =
is set */
  	fmt_map_off =3D fmt_reg->var_off.value;
  	err =3D fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
  						  fmt_map_off);
@@@ -12556,50 -12845,40 +12853,40 @@@ static struct bpf_insn_aux_data *cur_=
au
  	return &env->insn_aux_data[env->insn_idx];
  }
 =20
- /* Returns 1 if R4 is a known zero, 0 if it is not, a negative errno on e=
rror. */
- static int loop_flag_is_zero(struct bpf_verifier_env *env)
+ /* An insn has one fixup for all states. The state that was here first ca=
n be wrong too. */
+ static int fixups_differ(struct bpf_verifier_env *env, const char *msg)
  {
- 	struct bpf_reg_state *reg =3D reg_state(env, BPF_REG_4);
- 	int err;
-=20
- 	if (!bpf_register_is_null(reg))
- 		return 0;
-=20
- 	err =3D mark_chain_precision(env, BPF_REG_4);
- 	if (err)
- 		return err;
- 	return 1;
+ 	verbose(env, "%s\n", msg);
+ 	bpf_note_fixups_differ(env);
+ 	return -EINVAL;
  }
 =20
- static int update_loop_inline_state(struct bpf_verifier_env *env, u32 sub=
progno)
+ static bool loop_flag_is_zero(struct bpf_verifier_env *env)
+ {
+ 	return bpf_register_is_null(reg_state(env, BPF_REG_4));
+ }
+=20
+ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 su=
bprogno)
  {
  	struct bpf_loop_inline_state *state =3D &cur_aux(env)->loop_inline_state;
- 	int flag_is_zero;
 =20
  	if (!state->initialized) {
- 		flag_is_zero =3D loop_flag_is_zero(env);
- 		if (flag_is_zero < 0)
- 			return flag_is_zero;
  		state->initialized =3D 1;
- 		state->fit_for_inline =3D flag_is_zero;
+ 		state->fit_for_inline =3D loop_flag_is_zero(env);
  		state->callback_subprogno =3D subprogno;
- 		return 0;
+ 		return;
  	}
 =20
  	if (!state->fit_for_inline)
- 		return 0;
+ 		return;
 =20
- 	flag_is_zero =3D loop_flag_is_zero(env);
- 	if (flag_is_zero < 0)
- 		return flag_is_zero;
- 	state->fit_for_inline =3D (flag_is_zero &&
+ 	state->fit_for_inline =3D (loop_flag_is_zero(env) &&
  				 state->callback_subprogno =3D=3D subprogno);
- 	return 0;
  }
 =20
  /* Returns whether or not the given map can potentially elide
-  * lookup return value nullness check. This is possible if the key
-  * is statically known.
+  * lookup return value nullness check. This is possible if the largest
+  * value of the key is statically known.
   */
  static bool can_elide_value_nullness(const struct bpf_map *map)
  {
@@@ -12813,9 -13092,6 +13100,6 @@@ static int check_helper_call(struct bpf
  			verbose(env, "get_local_storage() doesn't support non-zero flags\n");
  			return -EINVAL;
  		}
- 		err =3D mark_chain_precision(env, BPF_REG_2);
- 		if (err)
- 			return err;
  		break;
  	case BPF_FUNC_for_each_map_elem:
  		err =3D push_callback_call(env, insn, insn_idx, meta.subprogno,
@@@ -12833,20 -13109,12 +13117,12 @@@
  		err =3D check_bpf_snprintf_call(env, regs);
  		break;
  	case BPF_FUNC_loop:
- 		err =3D update_loop_inline_state(env, meta.subprogno);
- 		if (err)
- 			return err;
- 		/* Verifier relies on R1 value to determine if bpf_loop() iteration
- 		 * is finished, thus mark it precise.
- 		 */
- 		err =3D mark_chain_precision(env, BPF_REG_1);
- 		if (err)
- 			return err;
+ 		update_loop_inline_state(env, meta.subprogno);
  		if (cur_func(env)->callback_depth < reg_umax(&regs[BPF_REG_1])) {
  			err =3D push_callback_call(env, insn, insn_idx, meta.subprogno,
  						 set_loop_callback_state);
  		} else {
- 			cur_func(env)->callback_depth =3D 0;
+ 			leave_callback(cur_func(env));
  			if (env->log.level & BPF_LOG_LEVEL2)
  				verbose(env, "frame%d bpf_loop iteration limit reached\n",
  					env->cur_state->curframe);
@@@ -12890,10 -13158,6 +13166,6 @@@
  			bpf_lsm_get_retval_range(env->prog, &range);
  		}
 =20
- 		err =3D mark_chain_precision(env, BPF_REG_1);
- 		if (err)
- 			return err;
-=20
  		if (!retval_range_within(range, r1)) {
  			verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
  			return -EINVAL;
@@@ -12916,6 -13180,15 +13188,15 @@@
 =20
  		break;
  	}
+ 	case BPF_FUNC_override_return:
+ 		/* see bpf_check_tail_call() */
+ 		for (i =3D 0; i < env->used_map_cnt; i++) {
+ 			if (!map_type_contains_progs(env->used_maps[i]))
+ 				continue;
+ 			verbose(env, "bpf_override_return() and a map of programs are used\n");
+ 			return -EINVAL;
+ 		}
+ 		break;
  	case BPF_FUNC_per_cpu_ptr:
  	case BPF_FUNC_this_cpu_ptr:
  	{
@@@ -12929,8 -13202,8 +13210,8 @@@
  				return -EFAULT;
  			}
  			returns_cpu_specific_alloc_ptr =3D true;
- 			env->insn_aux_data[insn_idx].call_with_percpu_alloc_ptr =3D true;
  		}
+ 		err =3D record_call_fixup(env, returns_cpu_specific_alloc_ptr, NULL);
  		break;
  	}
  	case BPF_FUNC_user_ringbuf_drain:
@@@ -12977,8 -13250,7 +13258,7 @@@
 =20
  		if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
  		    can_elide_value_nullness(meta.map.ptr) &&
- 		    meta.const_map_key >=3D 0 &&
- 		    meta.const_map_key < meta.map.ptr->max_entries)
+ 		    meta.max_map_key < meta.map.ptr->max_entries)
  			ret_flag &=3D ~PTR_MAYBE_NULL;
 =20
  		regs[BPF_REG_0].map_ptr =3D meta.map.ptr;
@@@ -12986,7 -13258,7 +13266,7 @@@
  		regs[BPF_REG_0].type =3D PTR_TO_MAP_VALUE | ret_flag;
  		if (type_may_be_null(ret_flag) ||
  		    btf_record_has_field(meta.map.ptr->record, BPF_SPIN_LOCK | BPF_RES_=
SPIN_LOCK)) {
- 			regs[BPF_REG_0].id =3D ++env->id_gen;
+ 			regs[BPF_REG_0].id =3D bpf_new_id(env);
  		}
  		/* requires regs[BPF_REG_0].id to be set because of the map-in-map case=
 */
  		refine_map_lookup_value(&regs[BPF_REG_0]);
@@@ -13088,7 -13360,7 +13368,7 @@@
  	}
 =20
  	if (type_may_be_null(regs[BPF_REG_0].type) && !regs[BPF_REG_0].id)
- 		regs[BPF_REG_0].id =3D ++env->id_gen;
+ 		regs[BPF_REG_0].id =3D bpf_new_id(env);
 =20
  	if (is_ptr_cast_function(func_id) &&
  	    find_reference_state(env->cur_state, meta.ref_obj.id)) {
@@@ -13171,7 -13443,28 +13451,28 @@@
  		env->prog->call_get_func_ip =3D true;
  	}
 =20
+ 	/* a call that only a speculative state reaches is dead code */
+ 	if (func_id =3D=3D BPF_FUNC_override_return && !env->cur_state->speculat=
ive)
+ 		env->prog->kprobe_override =3D 1;
+=20
+ 	if (func_id =3D=3D BPF_FUNC_tail_call && !env->cur_state->speculative) {
+ 		/* the other program can access all of it */
+ 		if (env->prog->expected_attach_type =3D=3D BPF_TRACE_ITER)
+ 			env->prog->aux->max_rdonly_access =3D
+ 				env->prog->aux->max_rdwr_access =3D U32_MAX;
+ 		if (env->prog->type =3D=3D BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE)
+ 			env->prog->aux->max_tp_access =3D U32_MAX;
+ 	}
+=20
  	if (func_id =3D=3D BPF_FUNC_tail_call) {
+ 		/*
+ 		 * The program which a tail call jumps to returns for this one,
+ 		 * and a program array does not check the values it may return.
+ 		 */
+ 		if (env->fmodret_retvals) {
+ 			verbose(env, "tail calls are not allowed in fmod_ret programs with res=
tricted return values\n");
+ 			return -EINVAL;
+ 		}
  		if (env->cur_state->curframe) {
  			struct bpf_verifier_state *branch;
 =20
@@@ -13291,6 -13584,22 +13592,22 @@@ static bool is_kfunc_arg_const_mem_size
  	return btf_param_match_suffix(btf, arg, "__szk");
  }
 =20
+ /* A kfunc only reads through 'const T *arg'. The compiler enforces it. */
+ static enum bpf_type_flag kfunc_arg_mem_flag(const struct btf *btf,
+ 					     const struct btf_param *arg)
+ {
+ 	const struct btf_type *t =3D btf_type_skip_modifiers(btf, arg->type, NUL=
L);
+ 	u32 id, ref_id;
+=20
+ 	btf_type_skip_modifiers(btf, t->type, &ref_id);
+ 	for (id =3D t->type; id !=3D ref_id; id =3D t->type) {
+ 		t =3D btf_type_by_id(btf, id);
+ 		if (btf_kind(t) =3D=3D BTF_KIND_CONST)
+ 			return MEM_RDONLY;
+ 	}
+ 	return MEM_WRITE;
+ }
+=20
  static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf=
_param *arg)
  {
  	return btf_param_match_suffix(btf, arg, "__k");
@@@ -13672,7 -13981,8 +13989,8 @@@ static int resolve_func_arg_type(struc
  			PTR_ERR(resolve_ret));
  		return -EINVAL;
  	}
- 	*arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
+ 	*arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
+ 		    kfunc_arg_mem_flag(meta->btf, &args[arg]) |
  		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
 =20
  	return 0;
@@@ -14224,7 -14534,7 +14542,7 @@@ get_kfunc_arg_type(struct bpf_verifier_
  				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
  			return -EINVAL;
  		}
- 		arg_type =3D ARG_PTR_TO_MEM | MEM_WRITE;
+ 		arg_type =3D ARG_PTR_TO_MEM | kfunc_arg_mem_flag(meta->btf, &args[arg]);
  	} else if (btf_type_is_struct(ref_t))
  		/* A pointer to a struct without a size argument is classified as ARG_P=
TR_TO_BTF_ID */
  		arg_type =3D ARG_PTR_TO_BTF_ID;
@@@ -14249,7 -14559,8 +14567,8 @@@
  			return -EINVAL;
  		}
  		proto->arg_size[arg] =3D type_size;
- 		arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
+ 		arg_type =3D ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
+ 			   kfunc_arg_mem_flag(meta->btf, &args[arg]);
  	}
 =20
  	if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
@@@ -14532,7 -14843,7 +14851,7 @@@ static void ref_convert_owning_non_owni
  	struct bpf_reg_state *reg;
  	int err;
 =20
- 	err =3D release_reference_nomark(env, id);
+ 	err =3D release_reference_nomark(env->cur_state, id);
  	WARN_ON_ONCE(err);
 =20
  	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
@@@ -14669,55 -14980,6 +14988,6 @@@ static bool kfunc_spin_allowed(struct b
  	return *kfunc.flags & KF_SPINLOCK_SAFE;
  }
 =20
- /*
-  * True if insn calls a helper/kfunc that requires one of its arguments to
-  * be a stack pointer with a constant offset.
-  */
- bool bpf_needs_fixed_stack_off(struct bpf_verifier_env *env, int insn_idx)
- {
- 	const struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
- 	const struct bpf_func_proto *fn;
- 	struct bpf_kfunc_desc *desc;
- 	u32 *flags, btf_id;
- 	int i;
-=20
- 	if (bpf_helper_call(insn)) {
- 		if (bpf_get_helper_proto(env, insn->imm, &fn) < 0)
- 			return false;
- 	} else if (bpf_pseudo_kfunc_call(insn)) {
- 		desc =3D find_kfunc_desc(env->prog, insn->imm, insn->off);
- 		if (!desc)
- 			return false;
- 		fn =3D &desc->proto;
- 	} else {
- 		return false;
- 	}
-=20
- 	/* Both initialized and uninitialized stack dynptrs need a fixed offset.=
 */
- 	for (i =3D 0; i < ARRAY_SIZE(fn->arg_type); i++)
- 		if (arg_type_is_dynptr(fn->arg_type[i]))
- 			return true;
-=20
- 	/* vmlinux kfuncs only */
- 	if (!bpf_pseudo_kfunc_call(insn) || insn->off !=3D 0)
- 		return false;
- 	btf_id =3D insn->imm;
-=20
- 	flags =3D btf_kfunc_flags(btf_vmlinux, btf_id, env->prog);
- 	if (flags && (*flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY)))
- 		return true;
-=20
- 	if (btf_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock] ||
- 	    btf_id =3D=3D special_kfunc_list[KF_bpf_res_spin_unlock] ||
- 	    btf_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqsave] ||
- 	    btf_id =3D=3D special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore] =
||
- 	    btf_id =3D=3D special_kfunc_list[KF_bpf_local_irq_save] ||
- 	    btf_id =3D=3D special_kfunc_list[KF_bpf_local_irq_restore])
- 		return true;
-=20
- 	return false;
- }
-=20
  static bool is_sync_callback_calling_kfunc(u32 btf_id)
  {
  	return is_bpf_rbtree_add_kfunc(btf_id);
@@@ -15016,7 -15278,7 +15286,7 @@@ int bpf_fetch_kfunc_arg_meta(struct bpf
   * Describe a helper's stack access through argument @arg (0-based, R1-R5=
).
   * must_write means the verifier destroys prior state throughout size byt=
es.
   * In other words, must_write follows the verifier's model of the
-  * function's behaviour, which is safe to use for is_state_visited() prun=
ing.
+  * function's behaviour, which is safe to use when states are cleaned and=
 compared.
   */
  struct arg_access_info
  bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
@@@ -15044,7 -15306,6 +15314,6 @@@
  	case ARG_PTR_TO_MAP_KEY:
  	case ARG_PTR_TO_MAP_VALUE: {
  		bool is_key =3D base_type(at) =3D=3D ARG_PTR_TO_MAP_KEY;
- 		u64 val;
  		int i, map_reg;
 =20
  		for (i =3D 0; i < arg; i++) {
@@@ -15080,23 -15341,9 +15349,9 @@@ scan_all_maps
  		 */
  		exact_size =3D false;
  		access_type |=3D BPF_READ;
- 		val =3D 0;
- 		for (i =3D 0; i < env->used_map_cnt; i++) {
- 			struct bpf_map *map =3D env->used_maps[i];
- 			u32 sz =3D is_key ? map->key_size : map->value_size;
-=20
- 			if (sz > val)
- 				val =3D sz;
- 			if (map->inner_map_meta) {
- 				sz =3D is_key ? map->inner_map_meta->key_size
- 					    : map->inner_map_meta->value_size;
- 				if (sz > val)
- 					val =3D sz;
- 			}
- 		}
- 		if (!val)
+ 		size =3D is_key ? env->max_key_size : env->max_value_size;
+ 		if (!size)
  			return info;
- 		size =3D val;
  		goto out;
  	}
  	case ARG_PTR_TO_MEM:
@@@ -15125,6 -15372,14 +15380,14 @@@
  		 * analyzed separately.
  		 */
  		return (struct arg_access_info) {};
+ 	case ARG_ANYTHING:
+ 		/*
+ 		 * A number that the program is free to choose. bpf_probe_read_kernel()=
 and
+ 		 * the like may read what it points to. check_func_arg() does not look =
at
+ 		 * the number: do_check() keeps what it knows about the stack over the =
call.
+ 		 */
+ 		info.may_write =3D false;
+ 		return info;
  	default:
  		return info;
  	}
@@@ -15141,6 -15396,15 +15404,15 @@@ out
  	return info;
  }
 =20
+ bool bpf_insn_is_iter_next(struct bpf_verifier_env *env, struct bpf_insn =
*insn)
+ {
+ 	struct bpf_call_arg_meta meta;
+=20
+ 	return bpf_pseudo_kfunc_call(insn) &&
+ 	       !bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) &&
+ 	       bpf_is_iter_next_kfunc(&meta);
+ }
+=20
  /*
   * Describe a kfunc's stack access through argument slot @arg (0-based).
   * As for helpers, must_write describes destruction of prior verifier sta=
te,
@@@ -15249,12 -15513,29 +15521,29 @@@ static bool try_btf_prepare_func_args=
(s
  /* Prepare argument metadata for liveness; the main program is handled se=
parately. */
  static void prepare_subprog_args(struct bpf_verifier_env *env)
  {
- 	int i;
+ 	struct bpf_subprog_info *sub;
+ 	struct bpf_insn *insn;
+ 	int i, j, cnt;
 =20
  	for (i =3D 1; i < env->subprog_cnt; i++) {
+ 		sub =3D &env->subprog_info[i];
  		if (!try_btf_prepare_func_args(env, i) && bpf_subprog_is_global(env, i))
  			/* Keep all argument registers live if the prototype is unavailable. */
- 			env->subprog_info[i].arg_slot_cnt =3D MAX_BPF_FUNC_REG_ARGS;
+ 			sub->arg_slot_cnt =3D MAX_BPF_FUNC_REG_ARGS;
+ 		if (bpf_subprog_is_global(env, i))
+ 			continue;
+ 		cnt =3D 0;
+ 		for (j =3D sub->start; j < (sub + 1)->start; j++) {
+ 			insn =3D &env->prog->insnsi[j];
+ 			if (is_stack_arg_ldx(insn))
+ 				cnt =3D max(cnt, insn->off / BPF_REG_SIZE);
+ 		}
+ 		sub->stack_args_from_code =3D true;
+ 		sub->code_stack_args =3D min(cnt, MAX_STACK_ARG_SLOTS);
+ 		/* incoming + max outgoing. Calls add the latter. */
+ 		sub->stack_arg_cnt =3D sub->code_stack_args;
+ 		if (env->prog->aux->func_info_aux)
+ 			env->prog->aux->func_info_aux[i].stack_args =3D sub->code_stack_args;
  	}
  }
 =20
@@@ -15314,9 -15595,10 +15603,10 @@@ bpf_global_subprog_stack_access_bytes(s
   * < 0 - not fall-through to 'else' branch, return error
   */
  static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_c=
all_arg_meta *meta,
- 			       struct bpf_reg_state *regs, struct bpf_insn_aux_data *insn_aux,
- 			       const struct btf_type *ptr_type, struct btf *desc_btf)
+ 			       struct bpf_reg_state *regs, const struct btf_type *ptr_type,
+ 			       struct btf *desc_btf)
  {
+ 	struct btf_struct_meta *struct_meta;
  	const struct btf_type *ret_t;
  	int err =3D 0;
 =20
@@@ -15324,7 -15606,6 +15614,6 @@@
  		return 0;
 =20
  	if (is_bpf_obj_new_kfunc(meta->func_id) || is_bpf_percpu_obj_new_kfunc(m=
eta->func_id)) {
- 		struct btf_struct_meta *struct_meta;
  		struct btf *ret_btf;
  		u32 ret_btf_id;
 =20
@@@ -15400,17 -15681,21 +15689,21 @@@
  		if (is_bpf_percpu_obj_new_kfunc(meta->func_id))
  			regs[BPF_REG_0].type |=3D MEM_PERCPU;
 =20
- 		insn_aux->obj_new_size =3D ret_t->size;
- 		insn_aux->kptr_struct_meta =3D struct_meta;
+ 		err =3D record_call_fixup(env, ret_t->size, struct_meta);
+ 		if (err)
+ 			return err;
  	} else if (is_bpf_refcount_acquire_kfunc(meta->func_id)) {
  		mark_reg_known_zero(env, regs, BPF_REG_0);
  		regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | MEM_ALLOC;
  		regs[BPF_REG_0].btf =3D meta->arg_btf;
  		regs[BPF_REG_0].btf_id =3D meta->arg_btf_id;
 =20
- 		insn_aux->kptr_struct_meta =3D
- 			btf_find_struct_meta(meta->arg_btf,
- 					     meta->arg_btf_id);
+ 		/* The call reads only the offset of the refcount. The other fields can=
 differ. */
+ 		struct_meta =3D btf_find_struct_meta(meta->arg_btf, meta->arg_btf_id);
+ 		err =3D record_call_fixup(env, struct_meta->record->refcount_off,
+ 					cur_aux(env)->kptr_struct_meta ?: struct_meta);
+ 		if (err)
+ 			return err;
  	} else if (is_list_node_type(ptr_type)) {
  		struct btf_field *field =3D meta->arg_list_head.field;
 =20
@@@ -15497,6 -15782,7 +15790,7 @@@ static int check_kfunc_call(struct bpf_
  	const struct btf_type *t, *ptr_type;
  	struct bpf_call_arg_meta meta;
  	struct bpf_insn_aux_data *insn_aux;
+ 	struct btf_struct_meta *struct_meta;
  	const char *operation;
  	int err, insn_idx =3D *insn_idx_p;
  	u32 i, proto_slots, ptr_type_id, ret_nregs =3D 1;
@@@ -15504,9 -15790,10 +15798,10 @@@
  	struct btf *desc_btf;
  	int id;
 =20
- 	/* skip for now, but return error when we find this in fixup_kfunc_call =
*/
- 	if (!insn->imm)
- 		return 0;
+ 	if (!insn->imm) {
+ 		verbose(env, "invalid kernel function call not eliminated in verifier p=
ass\n");
+ 		return -EINVAL;
+ 	}
 =20
  	err =3D bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
  	if (err =3D=3D -EACCES && meta.func_name) {
@@@ -15522,14 -15809,13 +15817,13 @@@
  	func_name =3D meta.func_name;
  	insn_aux =3D &env->insn_aux_data[insn_idx];
 =20
- 	desc =3D find_kfunc_desc(env->prog, insn->imm, insn->off);
+ 	desc =3D find_kfunc_desc(env, insn->imm, insn->off);
  	if (!desc) {
  		verifier_bug(env, "kfunc descriptor not found for func_id %u", insn->im=
m);
  		return -EFAULT;
  	}
  	meta.fn =3D &desc->proto;
 =20
- 	insn_aux->is_iter_next =3D bpf_is_iter_next_kfunc(&meta);
 =20
  	if (!insn->off &&
  	    (insn->imm =3D=3D special_kfunc_list[KF_bpf_res_spin_lock] ||
@@@ -15549,10 -15835,12 +15843,10 @@@
  		for (i =3D 0; i < CALLER_SAVED_REGS; i++)
  			bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
 =20
 +		/* The kfunc returns int, the upper half of r0 is not known */
  		mark_reg_unknown(env, regs, BPF_REG_0);
 -		err =3D __mark_reg_s32_range(env, regs, BPF_REG_0, -MAX_ERRNO, -1);
 -		if (err) {
 -			verbose(env, "failed to mark s32 range for retval in forked state for =
lock\n");
 -			return err;
 -		}
 +		reg_set_srange32(&regs[BPF_REG_0], -MAX_ERRNO, -1);
 +		reg_bounds_sync(&regs[BPF_REG_0]);
  	} else if (!insn->off && insn->imm =3D=3D special_kfunc_list[KF___bpf_tr=
ap]) {
  		verbose(env, "unexpected __bpf_trap() due to uninitialized variable?\n"=
);
  		return -EFAULT;
@@@ -15612,8 -15900,6 +15906,6 @@@
  	     /* is_tracing_prog_type() for now doesn't cover non-iterator tracin=
g progs. */
  	     (prog_type =3D=3D BPF_PROG_TYPE_TRACING && env->prog->expected_atta=
ch_type !=3D BPF_TRACE_ITER
  	      && !env->prog->sleepable))) {
- 		struct btf_struct_meta *struct_meta;
-=20
  		struct_meta =3D btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
  		if (struct_meta && btf_record_has_nmi_unsafe_fields(struct_meta->record=
)) {
  			verbose(env, "%s cannot be used in tracing programs on types with NMI =
unsafe fields\n",
@@@ -15681,6 -15967,7 +15973,7 @@@
  			return -EINVAL;
  		}
  		env->cur_state->active_rcu_locks--;
+ 		release_context_state(env->cur_state);
  		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_RCU, false,
  					env->cur_state->active_rcu_locks);
  		if (!in_rcu_cs(env))
@@@ -15698,6 -15985,7 +15991,7 @@@
  			return -EINVAL;
  		}
  		env->cur_state->active_preempt_locks--;
+ 		release_context_state(env->cur_state);
  		bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_PREEMPT, false,
  					env->cur_state->active_preempt_locks);
  		if (!in_rcu_cs(env))
@@@ -15727,10 -16015,11 +16021,11 @@@
  	}
 =20
  	if (is_bpf_list_push_kfunc(meta.func_id) || is_bpf_rbtree_add_kfunc(meta=
=2Efunc_id)) {
- 		id =3D regs[BPF_REG_2].id;
- 		insn_aux->insert_off =3D regs[BPF_REG_2].var_off.value;
- 		insn_aux->kptr_struct_meta =3D btf_find_struct_meta(meta.arg_btf, meta.=
arg_btf_id);
- 		ref_convert_owning_non_owning(env, id);
+ 		ref_convert_owning_non_owning(env, regs[BPF_REG_2].id);
+ 		struct_meta =3D btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
+ 		err =3D record_call_fixup(env, regs[BPF_REG_2].var_off.value, struct_me=
ta);
+ 		if (err)
+ 			return err;
  	}
 =20
  	if ((is_kfunc_call(&meta, special_kfunc_list[KF_bpf_dynptr_slice]) ||
@@@ -15793,7 -16082,7 +16088,7 @@@
  		ret_nregs =3D mark_kfunc_ret_regs(env, regs, t->size);
  		if (meta.btf =3D=3D btf_vmlinux && (meta.func_id =3D=3D special_kfunc_l=
ist[KF_bpf_res_spin_lock] ||
  		    meta.func_id =3D=3D special_kfunc_list[KF_bpf_res_spin_lock_irqsave=
]))
- 			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
+ 			__mark_reg_const_zero(&regs[BPF_REG_0]);
  	} else if (btf_type_is_struct(t)) {
  		struct btf_member_path path =3D {};
  		const char *member_note =3D "";
@@@ -15849,18 -16138,12 +16144,18 @@@
  		ret_nregs =3D mark_kfunc_ret_regs(env, regs, t->size);
  	} else if (btf_type_is_ptr(t)) {
  		ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
- 		err =3D check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc_=
btf);
+ 		err =3D check_special_kfunc(env, &meta, regs, ptr_type, desc_btf);
  		if (err) {
  			if (err < 0)
  				return err;
  		} else if (btf_type_is_void(ptr_type)) {
  			/* kfunc returning 'void *' is equivalent to returning scalar */
 +			if (!env->allow_ptr_leaks) {
 +				verbose(env,
 +					"%s is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
 +					func_name);
 +				return -EPERM;
 +			}
  			mark_reg_unknown(env, regs, BPF_REG_0);
  		} else if (!__btf_type_is_struct(ptr_type)) {
  			if (!meta.ret_mem.found) {
@@@ -15943,7 -16226,7 +16238,7 @@@
  		if (is_kfunc_ret_null(&meta)) {
  			regs[BPF_REG_0].type |=3D PTR_MAYBE_NULL;
  			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
- 			regs[BPF_REG_0].id =3D ++env->id_gen;
+ 			regs[BPF_REG_0].id =3D bpf_new_id(env);
  		}
  		if (is_kfunc_acquire(&meta)) {
  			id =3D acquire_reference(env, insn_idx, 0);
@@@ -15955,14 -16238,15 +16250,15 @@@
  		}
 =20
  		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
- 			regs[BPF_REG_0].id =3D ++env->id_gen;
+ 			regs[BPF_REG_0].id =3D bpf_new_id(env);
  	} else if (btf_type_is_void(t)) {
  		if (meta.btf =3D=3D btf_vmlinux) {
  			if (is_bpf_obj_drop_kfunc(meta.func_id) ||
  			    is_bpf_percpu_obj_drop_kfunc(meta.func_id)) {
- 				insn_aux->kptr_struct_meta =3D
- 					btf_find_struct_meta(meta.arg_btf,
- 							     meta.arg_btf_id);
+ 				struct_meta =3D btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
+ 				err =3D record_call_fixup(env, 0, struct_meta);
+ 				if (err)
+ 					return err;
  			}
  		}
  	}
@@@ -16021,7 -16305,7 +16317,7 @@@ static bool check_reg_sane_offset_scala
  	s64 val =3D reg->var_off.value;
  	s64 smin =3D reg_smin(reg);
 =20
- 	if (known && (val >=3D BPF_MAX_VAR_OFF || val <=3D -BPF_MAX_VAR_OFF)) {
+ 	if (known && val <=3D -BPF_MAX_VAR_OFF) {
  		verbose(env, "math between %s pointer and %lld is not allowed\n",
  			reg_type_str(env, type), val);
  		return false;
@@@ -16033,7 -16317,7 +16329,7 @@@
  		return false;
  	}
 =20
- 	if (smin >=3D BPF_MAX_VAR_OFF || smin <=3D -BPF_MAX_VAR_OFF) {
+ 	if (smin <=3D -BPF_MAX_VAR_OFF) {
  		verbose(env, "value %lld makes %s pointer be out of bounds\n",
  			smin, reg_type_str(env, type));
  		return false;
@@@ -16042,36 -16326,29 +16338,29 @@@
  	return true;
  }
 =20
- static bool check_reg_sane_offset_ptr(struct bpf_verifier_env *env,
- 				      const struct bpf_reg_state *reg,
- 				      enum bpf_reg_type type)
+ /*
+  * A far pointer is no error: a state with near offsets gets here, so thi=
s one does too.
+  * An access through it is unproven or gets a fault handler, see check_lo=
ad_mem().
+  * But a constant offset has to fit in an int.
+  */
+ void bpf_blur_far_offset(struct bpf_verifier_env *env, struct bpf_reg_sta=
te *reg)
  {
- 	bool known =3D tnum_is_const(reg->var_off);
- 	s64 val =3D reg->var_off.value;
- 	s64 smin =3D reg_smin(reg);
+ 	s64 smin =3D reg_smin(reg), smax =3D reg_smax(reg);
 =20
- 	if (known && (val >=3D BPF_MAX_VAR_OFF || val <=3D -BPF_MAX_VAR_OFF)) {
- 		verbose(env, "%s pointer offset %lld is not allowed\n",
- 			reg_type_str(env, type), val);
- 		return false;
+ 	/* an id and a range need an offset that does not wrap around */
+ 	if (reg_is_pkt_pointer(reg) && offset_is_far(reg)) {
+ 		reg->id =3D bpf_new_id(env);
+ 		reg->range =3D 0;
  	}
-=20
- 	if (smin >=3D BPF_MAX_VAR_OFF || smin <=3D -BPF_MAX_VAR_OFF) {
- 		verbose(env, "%s pointer offset %lld is not allowed\n",
- 			reg_type_str(env, type), smin);
- 		return false;
- 	}
-=20
- 	return true;
+ 	if (reg->type =3D=3D SCALAR_VALUE || (smin < BPF_MAX_VAR_OFF && smax > -=
BPF_MAX_VAR_OFF))
+ 		return;
+ 	scalar_set_unknown(scalar_of(reg));
+ 	reg->r64 =3D cnum64_from_srange(min(smin, BPF_MAX_VAR_OFF - 1),
+ 				      max(smax, 1 - BPF_MAX_VAR_OFF));
+ 	reg_bounds_sync(reg);
  }
 =20
- enum {
- 	REASON_BOUNDS	=3D -1,
- 	REASON_TYPE	=3D -2,
- 	REASON_PATHS	=3D -3,
- 	REASON_LIMIT	=3D -4,
- 	REASON_STACK	=3D -5,
- };
+ #define NO_MASK_FITS	1
 =20
  static int retrieve_ptr_limit(const struct bpf_verifier_env *env,
  			      const struct bpf_reg_state *ptr_reg,
@@@ -16094,11 -16371,11 +16383,11 @@@
  		ptr_limit =3D mask_to_left ? reg_smin(ptr_reg) : reg_umax(ptr_reg);
  		break;
  	default:
- 		return REASON_TYPE;
+ 		return NO_MASK_FITS;
  	}
 =20
  	if (ptr_limit >=3D max)
- 		return REASON_LIMIT;
+ 		return NO_MASK_FITS;
  	*alu_limit =3D ptr_limit;
  	return 0;
  }
@@@ -16106,7 -16383,7 +16395,7 @@@
  static bool can_skip_alu_sanitation(const struct bpf_verifier_env *env,
  				    const struct bpf_insn *insn)
  {
- 	return env->bypass_spec_v1 ||
+ 	return env->bypass_spec_v1 || env->path_sensitive ||
  		BPF_SRC(insn->code) =3D=3D BPF_K ||
  		cur_aux(env)->nospec;
  }
@@@ -16120,7 -16397,7 +16409,7 @@@ static int update_alu_sanitation_state(
  	if (aux->alu_state &&
  	    (aux->alu_state !=3D alu_state ||
  	     aux->alu_limit !=3D alu_limit))
- 		return REASON_PATHS;
+ 		return NO_MASK_FITS;
 =20
  	/* Corresponding fixup done in do_misc_fixups(). */
  	aux->alu_state =3D alu_state;
@@@ -16147,6 -16424,7 +16436,7 @@@ static bool sanitize_needed(u8 opcode
  struct bpf_sanitize_info {
  	struct bpf_insn_aux_data aux;
  	bool mask_to_left;
+ 	u64 max_off;
  };
 =20
  static int sanitize_speculative_path(struct bpf_verifier_env *env,
@@@ -16178,8 -16456,7 +16468,7 @@@ static int sanitize_ptr_alu(struct bpf_
  			    const bool commit_window)
  {
  	struct bpf_insn_aux_data *aux =3D commit_window ? cur_aux(env) : &info->=
aux;
- 	struct bpf_verifier_state *vstate =3D env->cur_state;
- 	bool off_is_imm =3D tnum_is_const(off_reg->var_off);
+ 	bool off_is_imm =3D cnum64_is_const(off_reg->r64);
  	bool off_is_neg =3D reg_smin(off_reg) < 0;
  	bool ptr_is_dst_reg =3D ptr_reg =3D=3D dst_reg;
  	u8 opcode =3D BPF_OP(insn->code);
@@@ -16190,24 -16467,18 +16479,18 @@@
  	if (can_skip_alu_sanitation(env, insn))
  		return 0;
 =20
- 	/* We already marked aux for masking from non-speculative
- 	 * paths, thus we got here in the first place. We only care
- 	 * to explore bad access from here.
- 	 */
- 	if (vstate->speculative)
- 		goto do_sim;
-=20
  	if (!commit_window) {
- 		if (!tnum_is_const(off_reg->var_off) &&
+ 		if (!off_is_imm &&
  		    (reg_smin(off_reg) < 0) !=3D (reg_smax(off_reg) < 0))
- 			return REASON_BOUNDS;
+ 			return NO_MASK_FITS;
 =20
+ 		info->max_off =3D off_is_neg ? -(u64)reg_smin(off_reg) : reg_umax(off_r=
eg);
  		info->mask_to_left =3D (opcode =3D=3D BPF_ADD &&  off_is_neg) ||
  				     (opcode =3D=3D BPF_SUB && !off_is_neg);
  	}
 =20
  	err =3D retrieve_ptr_limit(env, ptr_reg, &alu_limit, info->mask_to_left);
- 	if (err < 0)
+ 	if (err)
  		return err;
 =20
  	if (commit_window) {
@@@ -16216,23 -16487,24 +16499,24 @@@
  		 */
  		alu_state =3D info->aux.alu_state;
  		alu_limit =3D abs(info->aux.alu_limit - alu_limit);
+ 		/*
+ 		 * The mask passes what was checked: it cuts no real offset and adds no=
 other one.
+ 		 * It passes all smaller offsets too. The slots of the stack are not al=
ike.
+ 		 * A stack pointer plus a range gets here if the step makes the sum a c=
onstant.
+ 		 */
+ 		if (alu_limit !=3D info->max_off ||
+ 		    (ptr_reg->type =3D=3D PTR_TO_STACK && !(alu_state & BPF_ALU_IMMEDIA=
TE)))
+ 			return NO_MASK_FITS;
  	} else {
  		alu_state  =3D off_is_neg ? BPF_ALU_NEG_VALUE : 0;
  		alu_state |=3D off_is_imm ? BPF_ALU_IMMEDIATE : 0;
  		alu_state |=3D ptr_is_dst_reg ?
  			     BPF_ALU_SANITIZE_SRC : BPF_ALU_SANITIZE_DST;
-=20
- 		/* Limit pruning on unknown scalars to enable deep search for
- 		 * potential masking differences from other program paths.
- 		 */
- 		if (!off_is_imm)
- 			env->explore_alu_limits =3D true;
  	}
 =20
  	err =3D update_alu_sanitation_state(aux, alu_state, alu_limit);
- 	if (err < 0)
+ 	if (err)
  		return err;
- do_sim:
  	/* If we're in commit phase, we're done here given we already
  	 * pushed the truncated dst_reg into the speculative verification
  	 * stack.
@@@ -16259,7 -16531,7 +16543,7 @@@
  	}
  	err =3D sanitize_speculative_path(env, NULL, env->insn_idx + 1, env->ins=
n_idx);
  	if (err < 0)
- 		return REASON_STACK;
+ 		return err;
  	if (!ptr_is_dst_reg)
  		*dst_reg =3D tmp;
  	return 0;
@@@ -16275,43 -16547,41 +16559,41 @@@ static void sanitize_mark_insn_seen(s=
tr
  	 * rewrite/sanitize them.
  	 */
  	if (!vstate->speculative)
- 		env->insn_aux_data[env->insn_idx].seen =3D env->pass_cnt;
+ 		env->insn_aux_data[env->insn_idx].seen =3D env->check_cnt;
  }
 =20
- static int sanitize_err(struct bpf_verifier_env *env, const struct bpf_in=
sn *insn, int reason)
+ /*
+  * The insn at @idx gets a barrier, and no mask. A fall-through, a jump, =
a call or a return to
+  * @idx runs the barrier first. So it ends a speculative state that comes=
 that way. The other
+  * edges have their own barrier, and a speculative state does not take th=
em:
+  *
+  *	exit of a callback --> call of the helper	barrier at the exit
+  *	may_goto --> r0 =3D 0; exit			see emit_unwind_exit()
+  *	return --> dead code				see bpf_opt_hard_wire_dead_code_branches()
+  */
+ static void need_nospec(struct bpf_verifier_env *env, u32 idx)
  {
- 	static const char *err =3D "pointer arithmetic with it prohibited for !r=
oot";
- 	const char *op =3D BPF_OP(insn->code) =3D=3D BPF_ADD ? "add" : "sub";
- 	u32 dst =3D insn->dst_reg, src =3D insn->src_reg;
- 	struct bpf_reg_state *regs =3D cur_regs(env);
+ 	struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[idx];
+ 	struct bpf_insn *insn =3D &env->prog->insnsi[idx];
 =20
- 	switch (reason) {
- 	case REASON_BOUNDS:
- 		verbose(env, "R%d has unknown scalar with mixed signed bounds, %s\n",
- 			regs[src].type =3D=3D SCALAR_VALUE ? src : dst, err);
- 		break;
- 	case REASON_TYPE:
- 		verbose(env, "R%d has pointer with unsupported alu operation, %s\n",
- 			regs[src].type =3D=3D SCALAR_VALUE ? dst : src, err);
- 		break;
- 	case REASON_PATHS:
- 		verbose(env, "R%d tried to %s from different maps, paths or scalars, %s=
\n",
- 			dst, op, err);
- 		break;
- 	case REASON_LIMIT:
- 		verbose(env, "R%d tried to %s beyond pointer bounds, %s\n",
- 			dst, op, err);
- 		break;
- 	case REASON_STACK:
- 		verbose(env, "R%d could not be pushed for speculative verification, %s\=
n",
- 			dst, err);
- 		return -ENOMEM;
- 	default:
- 		verifier_bug(env, "unknown reason (%d)", reason);
- 		break;
+ 	/* nothing fits between it and the call */
+ 	if (bpf_is_unwind_goto(insn)) {
+ 		need_nospec(env, idx + 1);
+ 		return need_nospec(env, idx + insn->off + 1);
  	}
+ 	note_pessimized_insn(env, idx);
+ 	aux->nospec =3D true;
+ 	aux->alu_state =3D 0;
+ }
 =20
- 	return -EACCES;
+ static int sanitize_err(struct bpf_verifier_env *env, int err)
+ {
+ 	if (err !=3D NO_MASK_FITS)
+ 		return err;
+ 	if (env->cur_state->speculative)
+ 		return -EACCES;
+ 	need_nospec(env, env->insn_idx);
+ 	return 0;
  }
 =20
  /* check that stack access falls within stack limits and that 'reg' doesn=
't
@@@ -16377,22 -16647,22 +16659,22 @@@ static int sanitize_check_bounds(struc
  	return 0;
  }
 =20
- static void scalar_step_mul(struct bpf_reg_state *dst_reg, struct bpf_reg=
_state *src_reg)
+ static void scalar_step_mul(struct scalar *dst, const struct scalar *src)
  {
- 	if (tnum_is_const(src_reg->var_off))
- 		scalar_step_scale(dst_reg, src_reg->var_off.value);
+ 	if (tnum_is_const(src->var_off))
+ 		scalar_step_scale(dst, src->var_off.value);
  	else
- 		reg_step_reset(dst_reg);
+ 		scalar_step_reset(dst);
  }
 =20
- static void scalar_step_lsh(struct bpf_reg_state *dst_reg, struct bpf_reg=
_state *src_reg)
+ static void scalar_step_lsh(struct scalar *dst, const struct scalar *src)
  {
- 	u64 amount =3D src_reg->var_off.value;
+ 	u64 amount =3D src->var_off.value;
 =20
- 	if (tnum_is_const(src_reg->var_off) && amount < 64)
- 		scalar_step_scale(dst_reg, 1ULL << amount);
+ 	if (tnum_is_const(src->var_off) && amount < 64)
+ 		scalar_step_scale(dst, 1ULL << amount);
  	else
- 		reg_step_reset(dst_reg);
+ 		scalar_step_reset(dst);
  }
 =20
  /* Handles arithmetic on a pointer and a scalar: computes new min/max and=
 var_off.
@@@ -16414,12 -16684,13 +16696,13 @@@ static int adjust_ptr_min_max_vals(st=
ru
  	u8 opcode =3D BPF_OP(insn->code);
  	u32 dst =3D insn->dst_reg;
  	const char *reason;
- 	int ret, bounds_ret;
+ 	int ret, bounds_ret, min_len;
  	bool to_scalar;
+ 	s64 smax;
 =20
  	dst_reg =3D &regs[dst];
  	/*
- 	 * Only +=3D and -=3D keep a pointer. Any other op makes a number of it,
+ 	 * Only 64-bit +=3D and -=3D keep a pointer. Any other op makes a number=
 of it,
  	 * which is fine when the program may see values of pointers anyway.
  	 */
  	to_scalar =3D opcode !=3D BPF_ADD && opcode !=3D BPF_SUB && env->allow_p=
tr_leaks;
@@@ -16429,14 -16700,14 +16712,14 @@@
  		/* Taint dst register if offset had invalid bounds derived from
  		 * e.g. dead branches.
  		 */
- 		__mark_reg_unknown(env, dst_reg);
+ 		bpf_mark_reg_unknown(dst_reg);
  		return 0;
  	}
 =20
  	if (BPF_CLASS(insn->code) !=3D BPF_ALU64 && !to_scalar) {
  		/* 32-bit ALU ops on pointers produce (meaningless) scalars */
- 		if (opcode =3D=3D BPF_SUB && env->allow_ptr_leaks) {
- 			__mark_reg_unknown(env, dst_reg);
+ 		if (env->allow_ptr_leaks) {
+ 			bpf_mark_reg_unknown(dst_reg);
  			return 0;
  		}
 =20
@@@ -16500,7 -16771,7 +16783,7 @@@
  	}
 =20
  	if (to_scalar) {
- 		__mark_reg_unknown(env, dst_reg);
+ 		bpf_mark_reg_unknown(dst_reg);
  		return 0;
  	}
 =20
@@@ -16510,6 -16781,8 +16793,8 @@@
  	 */
  	if (dst_reg !=3D ptr_reg)
  		*dst_reg =3D *ptr_reg;
+ 	/* a far pointer that comes back leaves its copies */
+ 	bpf_blur_far_offset(env, dst_reg);
 =20
  	/*
  	 * Accesses to untrusted PTR_TO_MEM are done through probe
@@@ -16520,29 -16793,19 +16805,19 @@@
 =20
  	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type)) {
  		reason =3D bpf_diag_fmt(
- 			env, "The scalar offset used with R%d is unbounded or outside the veri=
fier's safe pointer-offset range [-%u, %u].",
- 			ptr_regno, BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF);
+ 			env, "The scalar offset used with R%d can be -%u or less.",
+ 			ptr_regno, BPF_MAX_VAR_OFF);
  		bpf_diag_register_type(
  			env, env->insn_idx, ptr_regno, "pointer offset is not safe", reason,
  			"Clamp or bounds-check the scalar offset before applying it to the poi=
nter.");
  		return -EINVAL;
  	}
- 	if (!check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type)) {
- 		reason =3D bpf_diag_fmt(
- 			env, "R%d already has an offset outside the verifier's safe range [-%u=
, %u] for %s.",
- 			ptr_regno, BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF,
- 			bpf_diag_reg_type_plain(env, ptr_reg->type));
- 		bpf_diag_register_type(
- 			env, env->insn_idx, ptr_regno, "pointer offset is not safe", reason,
- 			"Keep the base pointer within the verifier's allowed offset range befo=
re applying more arithmetic.");
- 		return -EINVAL;
- 	}
 =20
  	if (sanitize_needed(opcode)) {
- 		ret =3D sanitize_ptr_alu(env, insn, ptr_reg, off_reg, dst_reg,
- 				       &info, false);
- 		if (ret < 0)
- 			return sanitize_err(env, insn, ret);
+ 		ret =3D sanitize_err(env, sanitize_ptr_alu(env, insn, ptr_reg, off_reg,=
 dst_reg,
+ 							 &info, false));
+ 		if (ret)
+ 			return ret;
  	}
 =20
  	/*
@@@ -16551,7 -16814,8 +16826,8 @@@
  	 * speculative path: otherwise reg_bounds_sanity_check() might hit some
  	 * constraints violations.
  	 */
- 	__mark_reg32_unbounded(dst_reg);
+ 	__mark_scalar32_unbounded(scalar_of(dst_reg));
+ 	min_len =3D pkt_min_len(ptr_reg);
 =20
  	switch (opcode) {
  	case BPF_ADD:
@@@ -16563,21 -16827,25 +16839,25 @@@
  		 * added into the variable offset, and we copy the fixed offset
  		 * from ptr_reg.
  		 */
- 		scalar_step_add(dst_reg, ptr_reg, off_reg);
- 		dst_reg->r64 =3D cnum64_add(ptr_reg->r64, off_reg->r64);
- 		dst_reg->var_off =3D tnum_add(ptr_reg->var_off, off_reg->var_off);
+ 		scalar_add(scalar_of(dst_reg), scalar_of(dst_reg), scalar_of(off_reg));
  		dst_reg->raw =3D ptr_reg->raw;
  		if (reg_is_pkt_pointer(ptr_reg)) {
  			if (!known)
- 				dst_reg->id =3D ++env->id_gen;
+ 				dst_reg->id =3D bpf_new_id(env);
  			/*
- 			 * Clear range for unknown addends since we can't know
- 			 * where the pkt pointer ended up. Also clear AT_PKT_END /
+ 			 * The range is what umax of the pointer may get to, see
+ 			 * check_packet_access(). umax of the addend was added to it
+ 			 * and the pointer moved by that much at most, so the range
+ 			 * holds. Clear it if the addend may be negative: umax says
+ 			 * nothing then. Clear it if umax got to it: it permits no
+ 			 * byte at or after the pointer, and it would only keep equal
+ 			 * states apart in regsafe(). Also clear AT_PKT_END /
  			 * BEYOND_PKT_END from prior comparison as any pointer
  			 * arithmetic invalidates them.
  			 */
- 			if (!known || dst_reg->range < 0)
- 				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
+ 			if (dst_reg->range < 0 ||
+ 			    (!known && (smin_val < 0 || reg_umax(dst_reg) >=3D dst_reg->range)=
))
+ 				dst_reg->range =3D 0;
  		}
  		break;
  	case BPF_SUB:
@@@ -16609,12 -16877,12 +16889,12 @@@
  				"Use addition from R10 to form stack addresses within the tracked sta=
ck frame.");
  			return -EACCES;
  		}
- 		dst_reg->r64 =3D cnum64_add(ptr_reg->r64, cnum64_negate(off_reg->r64));
+ 		dst_reg->r64 =3D cnum64_sub(ptr_reg->r64, off_reg->r64);
  		dst_reg->var_off =3D tnum_sub(ptr_reg->var_off, off_reg->var_off);
  		dst_reg->raw =3D ptr_reg->raw;
  		if (reg_is_pkt_pointer(ptr_reg)) {
  			if (!known)
- 				dst_reg->id =3D ++env->id_gen;
+ 				dst_reg->id =3D bpf_new_id(env);
  			/*
  			 * Clear range if the subtrahend may be negative since
  			 * pkt pointer could move past its bounds. A positive
@@@ -16623,9 -16891,9 +16903,9 @@@
  			 * prior comparison as arithmetic invalidates them.
  			 */
  			if ((!known && smin_val < 0) || dst_reg->range < 0)
- 				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
+ 				dst_reg->range =3D 0;
  		}
- 		reg_step_reset(dst_reg);
+ 		scalar_step_reset(scalar_of(dst_reg));
  		break;
  	case BPF_AND:
  	case BPF_OR:
@@@ -16655,25 -16923,24 +16935,24 @@@
  		return -EACCES;
  	}
 =20
- 	if (!check_reg_sane_offset_ptr(env, dst_reg, ptr_reg->type)) {
- 		reason =3D bpf_diag_fmt(
- 			env, "After this arithmetic, R%d would be outside the verifier's safe =
offset range [-%u, %u] for %s.",
- 			dst, BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF,
- 			bpf_diag_reg_type_plain(env, ptr_reg->type));
- 		bpf_diag_register_type(
- 			env, env->insn_idx, ptr_regno, "pointer offset is not safe", reason,
- 			"Tighten the scalar bounds before the arithmetic so the resulting poin=
ter remains within the allowed range.");
- 		return -EINVAL;
- 	}
  	/*
  	 * A packet pointer that keeps its id or range is checked against a
  	 * range set from the checked pointer's umax, so var_off must not tighten
  	 * its umax. r32 must still match var_off for reg_bounds_sanity_check().
+ 	 * A sum with a new id is different: progs rely on what var_off and the
+ 	 * step tell about it (alignment, umin). No other pointer has its id, so
+ 	 * it is enough that its range loses what its umax loses.
  	 */
- 	if (reg_is_pkt_pointer(dst_reg) && (known || dst_reg->range > 0))
- 		__update_reg32_bounds(dst_reg);
+ 	smax =3D reg_smax(dst_reg);
+ 	if (reg_is_pkt_pointer(dst_reg) &&
+ 	    (known || (opcode =3D=3D BPF_SUB && dst_reg->range > 0)))
+ 		__update_scalar32_bounds(scalar_of(dst_reg));
  	else
  		reg_bounds_sync(dst_reg);
+ 	if (reg_is_pkt_pointer(dst_reg))
+ 		dst_reg->pkt_min_len =3D min_len;
+ 	bpf_trim_pkt_range(dst_reg, smax);
+ 	bpf_blur_far_offset(env, dst_reg);
  	bounds_ret =3D sanitize_check_bounds(env, insn, dst_reg);
  	if (bounds_ret =3D=3D -EACCES)
  		return bounds_ret;
@@@ -16681,62 -16948,45 +16960,45 @@@
  		ret =3D sanitize_ptr_alu(env, insn, dst_reg, off_reg, dst_reg,
  				       &info, true);
  		if (verifier_bug_if(!can_skip_alu_sanitation(env, insn)
- 				    && !env->cur_state->speculative
  				    && bounds_ret
  				    && !ret,
  				    env, "Pointer type unsupported by sanitize_check_bounds() not rej=
ected by retrieve_ptr_limit() as required")) {
  			return -EFAULT;
  		}
- 		if (ret < 0)
- 			return sanitize_err(env, insn, ret);
+ 		return sanitize_err(env, ret);
  	}
 =20
  	return 0;
  }
 =20
- static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
- 				 struct bpf_reg_state *src_reg)
+ static void scalar32_min_max_sub(struct scalar *dst, const struct scalar =
*src)
  {
- 	dst_reg->r32 =3D cnum32_add(dst_reg->r32, src_reg->r32);
+ 	dst->r32 =3D cnum32_sub(dst->r32, src->r32);
  }
 =20
- static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
- 			       struct bpf_reg_state *src_reg)
+ static void scalar_min_max_sub(struct scalar *dst, const struct scalar *s=
rc)
  {
- 	dst_reg->r64 =3D cnum64_add(dst_reg->r64, src_reg->r64);
+ 	dst->r64 =3D cnum64_sub(dst->r64, src->r64);
  }
 =20
- static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
- 				 struct bpf_reg_state *src_reg)
+ static void scalar32_min_max_mul(struct scalar *dst, const struct scalar =
*src)
  {
- 	dst_reg->r32 =3D cnum32_add(dst_reg->r32, cnum32_negate(src_reg->r32));
- }
-=20
- static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
- 			       struct bpf_reg_state *src_reg)
- {
- 	dst_reg->r64 =3D cnum64_add(dst_reg->r64, cnum64_negate(src_reg->r64));
- }
-=20
- static void scalar32_min_max_mul(struct bpf_reg_state *dst_reg,
- 				 struct bpf_reg_state *src_reg)
- {
- 	s32 smin =3D reg_s32_min(dst_reg);
- 	s32 smax =3D reg_s32_max(dst_reg);
- 	u32 umin =3D reg_u32_min(dst_reg);
- 	u32 umax =3D reg_u32_max(dst_reg);
+ 	s32 smin =3D cnum32_smin(dst->r32);
+ 	s32 smax =3D cnum32_smax(dst->r32);
+ 	u32 umin =3D cnum32_umin(dst->r32);
+ 	u32 umax =3D cnum32_umax(dst->r32);
  	s32 tmp_prod[4];
 =20
- 	if (check_mul_overflow(umax, reg_u32_max(src_reg), &umax) ||
- 	    check_mul_overflow(umin, reg_u32_min(src_reg), &umin)) {
+ 	if (check_mul_overflow(umax, cnum32_umax(src->r32), &umax) ||
+ 	    check_mul_overflow(umin, cnum32_umin(src->r32), &umin)) {
  		/* Overflow possible, we know nothing */
  		umin =3D 0;
  		umax =3D U32_MAX;
  	}
- 	if (check_mul_overflow(smin, reg_s32_min(src_reg), &tmp_prod[0]) ||
- 	    check_mul_overflow(smin, reg_s32_max(src_reg), &tmp_prod[1]) ||
- 	    check_mul_overflow(smax, reg_s32_min(src_reg), &tmp_prod[2]) ||
- 	    check_mul_overflow(smax, reg_s32_max(src_reg), &tmp_prod[3])) {
+ 	if (check_mul_overflow(smin, cnum32_smin(src->r32), &tmp_prod[0]) ||
+ 	    check_mul_overflow(smin, cnum32_smax(src->r32), &tmp_prod[1]) ||
+ 	    check_mul_overflow(smax, cnum32_smin(src->r32), &tmp_prod[2]) ||
+ 	    check_mul_overflow(smax, cnum32_smax(src->r32), &tmp_prod[3])) {
  		/* Overflow possible, we know nothing */
  		smin =3D S32_MIN;
  		smax =3D S32_MAX;
@@@ -16745,29 -16995,28 +17007,28 @@@
  		smax =3D max_array(tmp_prod, 4);
  	}
 =20
- 	dst_reg->r32 =3D cnum32_intersect(cnum32_from_urange(umin, umax),
- 					cnum32_from_srange(smin, smax));
+ 	dst->r32 =3D cnum32_intersect(cnum32_from_urange(umin, umax),
+ 				    cnum32_from_srange(smin, smax));
  }
 =20
- static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
- 			       struct bpf_reg_state *src_reg)
+ static void scalar_min_max_mul(struct scalar *dst, const struct scalar *s=
rc)
  {
- 	s64 smin =3D reg_smin(dst_reg);
- 	s64 smax =3D reg_smax(dst_reg);
- 	u64 umin =3D reg_umin(dst_reg);
- 	u64 umax =3D reg_umax(dst_reg);
+ 	s64 smin =3D cnum64_smin(dst->r64);
+ 	s64 smax =3D cnum64_smax(dst->r64);
+ 	u64 umin =3D cnum64_umin(dst->r64);
+ 	u64 umax =3D cnum64_umax(dst->r64);
  	s64 tmp_prod[4];
 =20
- 	if (check_mul_overflow(umax, reg_umax(src_reg), &umax) ||
- 	    check_mul_overflow(umin, reg_umin(src_reg), &umin)) {
+ 	if (check_mul_overflow(umax, cnum64_umax(src->r64), &umax) ||
+ 	    check_mul_overflow(umin, cnum64_umin(src->r64), &umin)) {
  		/* Overflow possible, we know nothing */
  		umin =3D 0;
  		umax =3D U64_MAX;
  	}
- 	if (check_mul_overflow(smin, reg_smin(src_reg), &tmp_prod[0]) ||
- 	    check_mul_overflow(smin, reg_smax(src_reg), &tmp_prod[1]) ||
- 	    check_mul_overflow(smax, reg_smin(src_reg), &tmp_prod[2]) ||
- 	    check_mul_overflow(smax, reg_smax(src_reg), &tmp_prod[3])) {
+ 	if (check_mul_overflow(smin, cnum64_smin(src->r64), &tmp_prod[0]) ||
+ 	    check_mul_overflow(smin, cnum64_smax(src->r64), &tmp_prod[1]) ||
+ 	    check_mul_overflow(smax, cnum64_smin(src->r64), &tmp_prod[2]) ||
+ 	    check_mul_overflow(smax, cnum64_smax(src->r64), &tmp_prod[3])) {
  		/* Overflow possible, we know nothing */
  		smin =3D S64_MIN;
  		smax =3D S64_MAX;
@@@ -16776,40 -17025,55 +17037,55 @@@
  		smax =3D max_array(tmp_prod, 4);
  	}
 =20
- 	dst_reg->r64 =3D cnum64_intersect(cnum64_from_urange(umin, umax),
- 					cnum64_from_srange(smin, smax));
+ 	dst->r64 =3D cnum64_intersect(cnum64_from_urange(umin, umax),
+ 				    cnum64_from_srange(smin, smax));
  }
 =20
- static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
- 				  struct bpf_reg_state *src_reg)
+ static void scalar_min_max_uhmul(struct scalar *dst, const struct scalar =
*src)
  {
- 	u32 src_val =3D reg_u32_min(src_reg); /* non-zero, const divisor */
+ 	u64 a =3D scalar_const_value(dst, false);
+ 	u64 b =3D scalar_const_value(src, false);
 =20
- 	reg_set_urange32(dst_reg, reg_u32_min(dst_reg) / src_val,
- 			 reg_u32_max(dst_reg) / src_val);
+ 	scalar_set_const(dst, bpf_uhmul64(a, b));
+ }
+=20
+ static void scalar_min_max_shmul(struct scalar *dst, const struct scalar =
*src)
+ {
+ 	s64 a =3D scalar_const_value(dst, false);
+ 	s64 b =3D scalar_const_value(src, false);
+=20
+ 	scalar_set_const(dst, bpf_shmul64(a, b));
+ }
+=20
+ static void scalar32_min_max_udiv(struct scalar *dst, const struct scalar=
 *src)
+ {
+ 	u32 src_min =3D cnum32_umin(src->r32), src_max =3D cnum32_umax(src->r32)=
; /* src_max isn't 0 */
+=20
+ 	/* The largest divisor gives the smallest result, but for x / 0 =3D 0 */
+ 	dst->r32 =3D cnum32_from_urange(src_min ? cnum32_umin(dst->r32) / src_ma=
x : 0,
+ 				      cnum32_umax(dst->r32) / (src_min ?: 1));
 =20
  	/* Reset other ranges/tnum to unbounded/unknown. */
- 	reset_reg64_and_tnum(dst_reg);
+ 	reset_scalar64_and_tnum(dst);
  }
 =20
- static void scalar_min_max_udiv(struct bpf_reg_state *dst_reg,
- 				struct bpf_reg_state *src_reg)
+ static void scalar_min_max_udiv(struct scalar *dst, const struct scalar *=
src)
  {
- 	u64 src_val =3D reg_umin(src_reg); /* non-zero, const divisor */
+ 	u64 src_min =3D cnum64_umin(src->r64), src_max =3D cnum64_umax(src->r64)=
; /* src_max isn't 0 */
 =20
- 	reg_set_urange64(dst_reg, div64_u64(reg_umin(dst_reg), src_val),
- 			 div64_u64(reg_umax(dst_reg), src_val));
+ 	/* The largest divisor gives the smallest result, but for x / 0 =3D 0 */
+ 	dst->r64 =3D cnum64_from_urange(src_min ? div64_u64(cnum64_umin(dst->r64=
), src_max) : 0,
+ 				      div64_u64(cnum64_umax(dst->r64), src_min ?: 1));
 =20
  	/* Reset other ranges/tnum to unbounded/unknown. */
- 	reset_reg32_and_tnum(dst_reg);
+ 	reset_scalar32_and_tnum(dst);
  }
 =20
- static void scalar32_min_max_sdiv(struct bpf_reg_state *dst_reg,
- 				  struct bpf_reg_state *src_reg)
+ static void scalar32_min_max_sdiv(struct scalar *dst, const struct scalar=
 *src)
  {
- 	s32 smin =3D reg_s32_min(dst_reg);
- 	s32 smax =3D reg_s32_max(dst_reg);
- 	s32 src_val =3D reg_s32_min(src_reg); /* non-zero, const divisor */
+ 	s32 smin =3D cnum32_smin(dst->r32);
+ 	s32 smax =3D cnum32_smax(dst->r32);
+ 	s32 src_val =3D cnum32_smin(src->r32); /* non-zero, const divisor */
  	s32 res1, res2;
 =20
  	/* BPF div specification: S32_MIN / -1 =3D S32_MIN */
@@@ -16835,17 -17099,16 +17111,16 @@@
  	smax =3D max(res1, res2);
 =20
  reset:
- 	reg_set_srange32(dst_reg, smin, smax);
+ 	dst->r32 =3D cnum32_from_srange(smin, smax);
  	/* Reset other ranges/tnum to unbounded/unknown. */
- 	reset_reg64_and_tnum(dst_reg);
+ 	reset_scalar64_and_tnum(dst);
  }
 =20
- static void scalar_min_max_sdiv(struct bpf_reg_state *dst_reg,
- 				struct bpf_reg_state *src_reg)
+ static void scalar_min_max_sdiv(struct scalar *dst, const struct scalar *=
src)
  {
- 	s64 smin =3D reg_smin(dst_reg);
- 	s64 smax =3D reg_smax(dst_reg);
- 	s64 src_val =3D reg_smin(src_reg); /* non-zero, const divisor */
+ 	s64 smin =3D cnum64_smin(dst->r64);
+ 	s64 smax =3D cnum64_smax(dst->r64);
+ 	s64 src_val =3D cnum64_smin(src->r64); /* non-zero, const divisor */
  	s64 res1, res2;
 =20
  	/* BPF div specification: S64_MIN / -1 =3D S64_MIN */
@@@ -16871,53 -17134,52 +17146,52 @@@
  	smax =3D max(res1, res2);
 =20
  reset:
- 	reg_set_srange64(dst_reg, smin, smax);
+ 	dst->r64 =3D cnum64_from_srange(smin, smax);
  	/* Reset other ranges/tnum to unbounded/unknown. */
- 	reset_reg32_and_tnum(dst_reg);
+ 	reset_scalar32_and_tnum(dst);
  }
 =20
- static void scalar32_min_max_umod(struct bpf_reg_state *dst_reg,
- 				  struct bpf_reg_state *src_reg)
+ static void scalar32_min_max_umod(struct scalar *dst, const struct scalar=
 *src)
  {
- 	u32 src_val =3D reg_u32_min(src_reg); /* non-zero, const divisor */
- 	u32 res_max =3D src_val - 1;
+ 	u32 src_min =3D cnum32_umin(src->r32), src_max =3D cnum32_umax(src->r32)=
; /* src_max isn't 0 */
 =20
  	/*
- 	 * If dst_umax <=3D res_max, the result remains unchanged.
- 	 * e.g., [2, 5] % 10 =3D [2, 5].
+ 	 * If dst_umax < src_min, the result remains unchanged.
+ 	 * e.g., [2, 5] % [10, 20] =3D [2, 5].
  	 */
- 	if (reg_u32_max(dst_reg) <=3D res_max)
+ 	if (cnum32_umax(dst->r32) < src_min)
  		return;
 =20
- 	reg_set_urange32(dst_reg, 0, min(reg_u32_max(dst_reg), res_max));
+ 	/* The result is below the divisor and not above x, and x % 0 =3D x */
+ 	dst->r32 =3D cnum32_from_urange(0, min(cnum32_umax(dst->r32),
+ 					     src_min ? src_max - 1 : U32_MAX));
 =20
  	/* Reset other ranges/tnum to unbounded/unknown. */
- 	reset_reg64_and_tnum(dst_reg);
+ 	reset_scalar64_and_tnum(dst);
  }
 =20
- static void scalar_min_max_umod(struct bpf_reg_state *dst_reg,
- 				struct bpf_reg_state *src_reg)
+ static void scalar_min_max_umod(struct scalar *dst, const struct scalar *=
src)
  {
- 	u64 src_val =3D reg_umin(src_reg); /* non-zero, const divisor */
- 	u64 res_max =3D src_val - 1;
+ 	u64 src_min =3D cnum64_umin(src->r64), src_max =3D cnum64_umax(src->r64)=
; /* src_max isn't 0 */
 =20
  	/*
- 	 * If dst_umax <=3D res_max, the result remains unchanged.
- 	 * e.g., [2, 5] % 10 =3D [2, 5].
+ 	 * If dst_umax < src_min, the result remains unchanged.
+ 	 * e.g., [2, 5] % [10, 20] =3D [2, 5].
  	 */
- 	if (reg_umax(dst_reg) <=3D res_max)
+ 	if (cnum64_umax(dst->r64) < src_min)
  		return;
 =20
- 	reg_set_urange64(dst_reg, 0, min(reg_umax(dst_reg), res_max));
+ 	/* The result is below the divisor and not above x, and x % 0 =3D x */
+ 	dst->r64 =3D cnum64_from_urange(0, min(cnum64_umax(dst->r64),
+ 					     src_min ? src_max - 1 : U64_MAX));
 =20
  	/* Reset other ranges/tnum to unbounded/unknown. */
- 	reset_reg32_and_tnum(dst_reg);
+ 	reset_scalar32_and_tnum(dst);
  }
 =20
- static void scalar32_min_max_smod(struct bpf_reg_state *dst_reg,
- 				  struct bpf_reg_state *src_reg)
+ static void scalar32_min_max_smod(struct scalar *dst, const struct scalar=
 *src)
  {
- 	s32 src_val =3D reg_s32_min(src_reg); /* non-zero, const divisor */
+ 	s32 src_val =3D cnum32_smin(src->r32); /* non-zero, const divisor */
 =20
  	/*
  	 * Safe absolute value calculation:
@@@ -16937,26 -17199,25 +17211,25 @@@
  	 * If the dividend is already within the result range,
  	 * the result remains unchanged. e.g., [-2, 5] % 10 =3D [-2, 5].
  	 */
- 	if (reg_s32_min(dst_reg) >=3D -res_max_abs && reg_s32_max(dst_reg) <=3D =
res_max_abs)
+ 	if (cnum32_smin(dst->r32) >=3D -res_max_abs && cnum32_smax(dst->r32) <=
=3D res_max_abs)
  		return;
 =20
  	/* General case: result has the same sign as the dividend. */
- 	if (reg_s32_min(dst_reg) >=3D 0) {
- 		reg_set_srange32(dst_reg, 0, min(reg_s32_max(dst_reg), res_max_abs));
- 	} else if (reg_s32_max(dst_reg) <=3D 0) {
- 		reg_set_srange32(dst_reg, max(reg_s32_min(dst_reg), -res_max_abs), 0);
+ 	if (cnum32_smin(dst->r32) >=3D 0) {
+ 		dst->r32 =3D cnum32_from_srange(0, min(cnum32_smax(dst->r32), res_max_a=
bs));
+ 	} else if (cnum32_smax(dst->r32) <=3D 0) {
+ 		dst->r32 =3D cnum32_from_srange(max(cnum32_smin(dst->r32), -res_max_abs=
), 0);
  	} else {
- 		reg_set_srange32(dst_reg, -res_max_abs, res_max_abs);
+ 		dst->r32 =3D cnum32_from_srange(-res_max_abs, res_max_abs);
  	}
 =20
  	/* Reset other ranges/tnum to unbounded/unknown. */
- 	reset_reg64_and_tnum(dst_reg);
+ 	reset_scalar64_and_tnum(dst);
  }
 =20
- static void scalar_min_max_smod(struct bpf_reg_state *dst_reg,
- 				struct bpf_reg_state *src_reg)
+ static void scalar_min_max_smod(struct scalar *dst, const struct scalar *=
src)
  {
- 	s64 src_val =3D reg_smin(src_reg); /* non-zero, const divisor */
+ 	s64 src_val =3D cnum64_smin(src->r64); /* non-zero, const divisor */
 =20
  	/*
  	 * Safe absolute value calculation:
@@@ -16976,178 -17237,164 +17249,164 @@@
  	 * If the dividend is already within the result range,
  	 * the result remains unchanged. e.g., [-2, 5] % 10 =3D [-2, 5].
  	 */
- 	if (reg_smin(dst_reg) >=3D -res_max_abs && reg_smax(dst_reg) <=3D res_ma=
x_abs)
+ 	if (cnum64_smin(dst->r64) >=3D -res_max_abs && cnum64_smax(dst->r64) <=
=3D res_max_abs)
  		return;
 =20
  	/* General case: result has the same sign as the dividend. */
- 	if (reg_smin(dst_reg) >=3D 0) {
- 		reg_set_srange64(dst_reg, 0, min(reg_smax(dst_reg), res_max_abs));
- 	} else if (reg_smax(dst_reg) <=3D 0) {
- 		reg_set_srange64(dst_reg, max(reg_smin(dst_reg), -res_max_abs), 0);
+ 	if (cnum64_smin(dst->r64) >=3D 0) {
+ 		dst->r64 =3D cnum64_from_srange(0, min(cnum64_smax(dst->r64), res_max_a=
bs));
+ 	} else if (cnum64_smax(dst->r64) <=3D 0) {
+ 		dst->r64 =3D cnum64_from_srange(max(cnum64_smin(dst->r64), -res_max_abs=
), 0);
  	} else {
- 		reg_set_srange64(dst_reg, -res_max_abs, res_max_abs);
+ 		dst->r64 =3D cnum64_from_srange(-res_max_abs, res_max_abs);
  	}
 =20
  	/* Reset other ranges/tnum to unbounded/unknown. */
- 	reset_reg32_and_tnum(dst_reg);
+ 	reset_scalar32_and_tnum(dst);
  }
 =20
- static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
- 				 struct bpf_reg_state *src_reg)
+ static void scalar32_min_max_and(struct scalar *dst, const struct scalar =
*src)
  {
- 	bool src_known =3D tnum_subreg_is_const(src_reg->var_off);
- 	bool dst_known =3D tnum_subreg_is_const(dst_reg->var_off);
- 	struct tnum var32_off =3D tnum_subreg(dst_reg->var_off);
- 	u32 umax_val =3D reg_u32_max(src_reg);
+ 	bool src_known =3D tnum_subreg_is_const(src->var_off);
+ 	bool dst_known =3D tnum_subreg_is_const(dst->var_off);
+ 	struct tnum var32_off =3D tnum_subreg(dst->var_off);
+ 	u32 umax_val =3D cnum32_umax(src->r32);
 =20
  	if (src_known && dst_known) {
- 		__mark_reg32_known(dst_reg, var32_off.value);
+ 		__mark_scalar32_known(dst, var32_off.value);
  		return;
  	}
 =20
  	/* We get our minimum from the var_off, since that's inherently
  	 * bitwise.  Our maximum is the minimum of the operands' maxima.
  	 */
- 	reg_set_urange32(dst_reg,
- 			 var32_off.value,
- 			 min(reg_u32_max(dst_reg), umax_val));
+ 	dst->r32 =3D cnum32_from_urange(var32_off.value,
+ 				      min(cnum32_umax(dst->r32), umax_val));
  }
 =20
- static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
- 			       struct bpf_reg_state *src_reg)
+ static void scalar_min_max_and(struct scalar *dst, const struct scalar *s=
rc)
  {
- 	bool src_known =3D tnum_is_const(src_reg->var_off);
- 	bool dst_known =3D tnum_is_const(dst_reg->var_off);
- 	u64 umax_val =3D reg_umax(src_reg);
+ 	bool src_known =3D tnum_is_const(src->var_off);
+ 	bool dst_known =3D tnum_is_const(dst->var_off);
+ 	u64 umax_val =3D cnum64_umax(src->r64);
 =20
  	if (src_known && dst_known) {
- 		__mark_reg_known(dst_reg, dst_reg->var_off.value);
+ 		scalar_set_const(dst, dst->var_off.value);
  		return;
  	}
 =20
  	/* We get our minimum from the var_off, since that's inherently
  	 * bitwise.  Our maximum is the minimum of the operands' maxima.
  	 */
- 	reg_set_urange64(dst_reg,
- 			 dst_reg->var_off.value,
- 			 min(reg_umax(dst_reg), umax_val));
+ 	dst->r64 =3D cnum64_from_urange(dst->var_off.value,
+ 				      min(cnum64_umax(dst->r64), umax_val));
 =20
  	/* We may learn something more from the var_off */
- 	__update_reg_bounds(dst_reg);
+ 	__update_scalar_bounds(dst);
  }
 =20
- static void scalar32_min_max_or(struct bpf_reg_state *dst_reg,
- 				struct bpf_reg_state *src_reg)
+ static void scalar32_min_max_or(struct scalar *dst, const struct scalar *=
src)
  {
- 	bool src_known =3D tnum_subreg_is_const(src_reg->var_off);
- 	bool dst_known =3D tnum_subreg_is_const(dst_reg->var_off);
- 	struct tnum var32_off =3D tnum_subreg(dst_reg->var_off);
- 	u32 umin_val =3D reg_u32_min(src_reg);
+ 	bool src_known =3D tnum_subreg_is_const(src->var_off);
+ 	bool dst_known =3D tnum_subreg_is_const(dst->var_off);
+ 	struct tnum var32_off =3D tnum_subreg(dst->var_off);
+ 	u32 umin_val =3D cnum32_umin(src->r32);
 =20
  	if (src_known && dst_known) {
- 		__mark_reg32_known(dst_reg, var32_off.value);
+ 		__mark_scalar32_known(dst, var32_off.value);
  		return;
  	}
 =20
  	/* We get our maximum from the var_off, and our minimum is the
  	 * maximum of the operands' minima
  	 */
- 	reg_set_urange32(dst_reg,
- 			 max(reg_u32_min(dst_reg), umin_val),
- 			 var32_off.value | var32_off.mask);
+ 	dst->r32 =3D cnum32_from_urange(max(cnum32_umin(dst->r32), umin_val),
+ 				      var32_off.value | var32_off.mask);
  }
 =20
- static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
- 			      struct bpf_reg_state *src_reg)
+ static void scalar_min_max_or(struct scalar *dst, const struct scalar *sr=
c)
  {
- 	bool src_known =3D tnum_is_const(src_reg->var_off);
- 	bool dst_known =3D tnum_is_const(dst_reg->var_off);
- 	u64 umin_val =3D reg_umin(src_reg);
+ 	bool src_known =3D tnum_is_const(src->var_off);
+ 	bool dst_known =3D tnum_is_const(dst->var_off);
+ 	u64 umin_val =3D cnum64_umin(src->r64);
 =20
  	if (src_known && dst_known) {
- 		__mark_reg_known(dst_reg, dst_reg->var_off.value);
+ 		scalar_set_const(dst, dst->var_off.value);
  		return;
  	}
 =20
  	/* We get our maximum from the var_off, and our minimum is the
  	 * maximum of the operands' minima
  	 */
- 	reg_set_urange64(dst_reg,
- 			 max(reg_umin(dst_reg), umin_val),
- 			 dst_reg->var_off.value | dst_reg->var_off.mask);
+ 	dst->r64 =3D cnum64_from_urange(max(cnum64_umin(dst->r64), umin_val),
+ 				      dst->var_off.value | dst->var_off.mask);
 =20
  	/* We may learn something more from the var_off */
- 	__update_reg_bounds(dst_reg);
+ 	__update_scalar_bounds(dst);
  }
 =20
- static void scalar32_min_max_xor(struct bpf_reg_state *dst_reg,
- 				 struct bpf_reg_state *src_reg)
+ static void scalar32_min_max_xor(struct scalar *dst, const struct scalar =
*src)
  {
- 	bool src_known =3D tnum_subreg_is_const(src_reg->var_off);
- 	bool dst_known =3D tnum_subreg_is_const(dst_reg->var_off);
- 	struct tnum var32_off =3D tnum_subreg(dst_reg->var_off);
+ 	bool src_known =3D tnum_subreg_is_const(src->var_off);
+ 	bool dst_known =3D tnum_subreg_is_const(dst->var_off);
+ 	struct tnum var32_off =3D tnum_subreg(dst->var_off);
 =20
  	if (src_known && dst_known) {
- 		__mark_reg32_known(dst_reg, var32_off.value);
+ 		__mark_scalar32_known(dst, var32_off.value);
  		return;
  	}
 =20
  	/* We get both minimum and maximum from the var32_off. */
- 	reg_set_urange32(dst_reg, var32_off.value, var32_off.value | var32_off.m=
ask);
+ 	dst->r32 =3D cnum32_from_urange(var32_off.value, var32_off.value | var32=
_off.mask);
  }
 =20
- static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
- 			       struct bpf_reg_state *src_reg)
+ static void scalar_min_max_xor(struct scalar *dst, const struct scalar *s=
rc)
  {
- 	bool src_known =3D tnum_is_const(src_reg->var_off);
- 	bool dst_known =3D tnum_is_const(dst_reg->var_off);
+ 	bool src_known =3D tnum_is_const(src->var_off);
+ 	bool dst_known =3D tnum_is_const(dst->var_off);
 =20
  	if (src_known && dst_known) {
- 		/* dst_reg->var_off.value has been updated earlier */
- 		__mark_reg_known(dst_reg, dst_reg->var_off.value);
+ 		/* dst->var_off.value has been updated earlier */
+ 		scalar_set_const(dst, dst->var_off.value);
  		return;
  	}
 =20
  	/* We get both minimum and maximum from the var_off. */
- 	reg_set_urange64(dst_reg,
- 			 dst_reg->var_off.value,
- 			 dst_reg->var_off.value | dst_reg->var_off.mask);
+ 	dst->r64 =3D cnum64_from_urange(dst->var_off.value,
+ 				      dst->var_off.value | dst->var_off.mask);
  }
 =20
- static void __scalar32_min_max_lsh(struct bpf_reg_state *dst_reg,
- 				   u64 umin_val, u64 umax_val)
+ static void __scalar32_min_max_lsh(struct scalar *dst, u64 umin_val, u64 =
umax_val)
  {
  	/* If we might shift our top bit out, then we know nothing */
- 	if (umax_val > 31 || reg_u32_max(dst_reg) > 1ULL << (31 - umax_val))
- 		reg_set_urange32(dst_reg, 0, U32_MAX);
+ 	if (umax_val > 31 || cnum32_umax(dst->r32) > 1ULL << (31 - umax_val))
+ 		dst->r32 =3D cnum32_from_urange(0, U32_MAX);
  	else
  		/* We lose all sign bit information (except what we can pick
  		 * up from var_off)
  		 */
- 		reg_set_urange32(dst_reg, reg_u32_min(dst_reg) << umin_val,
- 				 reg_u32_max(dst_reg) << umax_val);
+ 		dst->r32 =3D cnum32_from_urange(cnum32_umin(dst->r32) << umin_val,
+ 					      cnum32_umax(dst->r32) << umax_val);
  }
 =20
- static void scalar32_min_max_lsh(struct bpf_reg_state *dst_reg,
- 				 struct bpf_reg_state *src_reg)
+ static void scalar32_min_max_lsh(struct scalar *dst, const struct scalar =
*src)
  {
- 	u32 umax_val =3D reg_u32_max(src_reg);
- 	u32 umin_val =3D reg_u32_min(src_reg);
+ 	u32 umax_val =3D cnum32_umax(src->r32);
+ 	u32 umin_val =3D cnum32_umin(src->r32);
  	/* u32 alu operation will zext upper bits */
- 	struct tnum subreg =3D tnum_subreg(dst_reg->var_off);
+ 	struct tnum subreg =3D tnum_subreg(dst->var_off);
 =20
- 	__scalar32_min_max_lsh(dst_reg, umin_val, umax_val);
- 	dst_reg->var_off =3D tnum_subreg(tnum_lshift(subreg, umin_val));
+ 	__scalar32_min_max_lsh(dst, umin_val, umax_val);
+ 	dst->var_off =3D tnum_subreg(tnum_lshift(subreg, umin_val));
  	/* Not required but being careful mark reg64 bounds as unknown so
  	 * that we are forced to pick them up from tnum and zext later and
  	 * if some path skips this step we are still safe.
  	 */
- 	__mark_reg64_unbounded(dst_reg);
- 	__update_reg32_bounds(dst_reg);
+ 	__mark_scalar64_unbounded(dst);
+ 	__update_scalar32_bounds(dst);
  }
 =20
- static void __scalar64_min_max_lsh(struct bpf_reg_state *dst_reg,
- 				   u64 umin_val, u64 umax_val)
+ static void __scalar64_min_max_lsh(struct scalar *dst, u64 umin_val, u64 =
umax_val)
  {
  	struct cnum64 u, s;
 =20
@@@ -17157,140 -17404,139 +17416,139 @@@
  	 * 32bits.
  	 */
  	if (umin_val =3D=3D 32 && umax_val =3D=3D 32)
- 		s =3D cnum64_from_srange((s64)reg_s32_min(dst_reg) << 32,
- 				       (s64)reg_s32_max(dst_reg) << 32);
+ 		s =3D cnum64_from_srange((s64)cnum32_smin(dst->r32) << 32,
+ 				       (s64)cnum32_smax(dst->r32) << 32);
  	else
  		s =3D CNUM64_UNBOUNDED;
 =20
  	/* If we might shift our top bit out, then we know nothing */
- 	if (reg_umax(dst_reg) > 1ULL << (63 - umax_val))
+ 	if (cnum64_umax(dst->r64) > 1ULL << (63 - umax_val))
  		u =3D CNUM64_UNBOUNDED;
  	else
- 		u =3D cnum64_from_urange(reg_umin(dst_reg) << umin_val,
- 				       reg_umax(dst_reg) << umax_val);
+ 		u =3D cnum64_from_urange(cnum64_umin(dst->r64) << umin_val,
+ 				       cnum64_umax(dst->r64) << umax_val);
 =20
- 	dst_reg->r64 =3D cnum64_intersect(u, s);
+ 	dst->r64 =3D cnum64_intersect(u, s);
  }
 =20
- static void scalar_min_max_lsh(struct bpf_reg_state *dst_reg,
- 			       struct bpf_reg_state *src_reg)
+ static void scalar_min_max_lsh(struct scalar *dst, const struct scalar *s=
rc)
  {
- 	u64 umax_val =3D reg_umax(src_reg);
- 	u64 umin_val =3D reg_umin(src_reg);
+ 	u64 umax_val =3D cnum64_umax(src->r64);
+ 	u64 umin_val =3D cnum64_umin(src->r64);
 =20
  	/* scalar64 calc uses 32bit unshifted bounds so must be called first */
- 	__scalar64_min_max_lsh(dst_reg, umin_val, umax_val);
- 	__scalar32_min_max_lsh(dst_reg, umin_val, umax_val);
+ 	__scalar64_min_max_lsh(dst, umin_val, umax_val);
+ 	__scalar32_min_max_lsh(dst, umin_val, umax_val);
 =20
- 	dst_reg->var_off =3D tnum_lshift(dst_reg->var_off, umin_val);
+ 	dst->var_off =3D tnum_lshift(dst->var_off, umin_val);
  	/* We may learn something more from the var_off */
- 	__update_reg_bounds(dst_reg);
+ 	__update_scalar_bounds(dst);
  }
 =20
- static void scalar32_min_max_rsh(struct bpf_reg_state *dst_reg,
- 				 struct bpf_reg_state *src_reg)
+ static void scalar32_min_max_rsh(struct scalar *dst, const struct scalar =
*src)
  {
- 	struct tnum subreg =3D tnum_subreg(dst_reg->var_off);
- 	u32 umax_val =3D reg_u32_max(src_reg);
- 	u32 umin_val =3D reg_u32_min(src_reg);
+ 	struct tnum subreg =3D tnum_subreg(dst->var_off);
+ 	u32 umax_val =3D cnum32_umax(src->r32);
+ 	u32 umin_val =3D cnum32_umin(src->r32);
 =20
- 	/* BPF_RSH is an unsigned shift.  If the value in dst_reg might
+ 	/* BPF_RSH is an unsigned shift.  If the value in dst might
  	 * be negative, then either:
- 	 * 1) src_reg might be zero, so the sign bit of the result is
+ 	 * 1) src might be zero, so the sign bit of the result is
  	 *    unknown, so we lose our signed bounds
  	 * 2) it's known negative, thus the unsigned bounds capture the
  	 *    signed bounds
  	 * 3) the signed bounds cross zero, so they tell us nothing
  	 *    about the result
- 	 * If the value in dst_reg is known nonnegative, then again the
+ 	 * If the value in dst is known nonnegative, then again the
  	 * unsigned bounds capture the signed bounds.
  	 * Thus, in all cases it suffices to blow away our signed bounds
  	 * and rely on inferring new ones from the unsigned bounds and
  	 * var_off of the result.
  	 */
 =20
- 	dst_reg->var_off =3D tnum_rshift(subreg, umin_val);
- 	reg_set_urange32(dst_reg, reg_u32_min(dst_reg) >> umax_val,
- 			 reg_u32_max(dst_reg) >> umin_val);
+ 	dst->var_off =3D tnum_rshift(subreg, umin_val);
+ 	dst->r32 =3D cnum32_from_urange(cnum32_umin(dst->r32) >> umax_val,
+ 				      cnum32_umax(dst->r32) >> umin_val);
 =20
- 	__mark_reg64_unbounded(dst_reg);
- 	__update_reg32_bounds(dst_reg);
+ 	__mark_scalar64_unbounded(dst);
+ 	__update_scalar32_bounds(dst);
  }
 =20
- static void scalar_min_max_rsh(struct bpf_reg_state *dst_reg,
- 			       struct bpf_reg_state *src_reg)
+ static void scalar_min_max_rsh(struct scalar *dst, const struct scalar *s=
rc)
  {
- 	u64 umax_val =3D reg_umax(src_reg);
- 	u64 umin_val =3D reg_umin(src_reg);
+ 	u64 umax_val =3D cnum64_umax(src->r64);
+ 	u64 umin_val =3D cnum64_umin(src->r64);
 =20
- 	/* BPF_RSH is an unsigned shift.  If the value in dst_reg might
+ 	/* BPF_RSH is an unsigned shift.  If the value in dst might
  	 * be negative, then either:
- 	 * 1) src_reg might be zero, so the sign bit of the result is
+ 	 * 1) src might be zero, so the sign bit of the result is
  	 *    unknown, so we lose our signed bounds
  	 * 2) it's known negative, thus the unsigned bounds capture the
  	 *    signed bounds
  	 * 3) the signed bounds cross zero, so they tell us nothing
  	 *    about the result
- 	 * If the value in dst_reg is known nonnegative, then again the
+ 	 * If the value in dst is known nonnegative, then again the
  	 * unsigned bounds capture the signed bounds.
  	 * Thus, in all cases it suffices to blow away our signed bounds
  	 * and rely on inferring new ones from the unsigned bounds and
  	 * var_off of the result.
  	 */
- 	dst_reg->var_off =3D tnum_rshift(dst_reg->var_off, umin_val);
- 	reg_set_urange64(dst_reg, reg_umin(dst_reg) >> umax_val,
- 			 reg_umax(dst_reg) >> umin_val);
+ 	dst->var_off =3D tnum_rshift(dst->var_off, umin_val);
+ 	dst->r64 =3D cnum64_from_urange(cnum64_umin(dst->r64) >> umax_val,
+ 				      cnum64_umax(dst->r64) >> umin_val);
 =20
  	/* Its not easy to operate on alu32 bounds here because it depends
  	 * on bits being shifted in. Take easy way out and mark unbounded
  	 * so we can recalculate later from tnum.
  	 */
- 	__mark_reg32_unbounded(dst_reg);
- 	__update_reg_bounds(dst_reg);
+ 	__mark_scalar32_unbounded(dst);
+ 	__update_scalar_bounds(dst);
  }
 =20
- static void scalar32_min_max_arsh(struct bpf_reg_state *dst_reg,
- 				  struct bpf_reg_state *src_reg)
+ static void scalar32_min_max_arsh(struct scalar *dst, const struct scalar=
 *src)
  {
- 	u64 umin_val =3D reg_u32_min(src_reg);
+ 	u32 umin_val =3D cnum32_umin(src->r32), umax_val =3D cnum32_umax(src->r3=
2);
+ 	struct cnum32 known =3D cnum32_from_tnum(dst->var_off);
+ 	s32 smin =3D max(cnum32_smin(dst->r32), cnum32_smin(known));
+ 	s32 smax =3D min(cnum32_smax(dst->r32), cnum32_smax(known));
 =20
- 	/* Upon reaching here, src_known is true and
- 	 * umax_val is equal to umin_val.
- 	 * Blow away the dst_reg umin_value/umax_value and rely on
- 	 * dst_reg var_off to refine the result.
+ 	/*
+ 	 * A larger count brings the result closer to 0, or to -1.
+ 	 * Blow away the dst umin_value/umax_value and rely on
+ 	 * dst var_off to refine the result.
  	 */
- 	reg_set_srange32(dst_reg,
- 			 (u32)(((s32)reg_s32_min(dst_reg)) >> umin_val),
- 			 (u32)(((s32)reg_s32_max(dst_reg)) >> umin_val));
+ 	dst->r32 =3D cnum32_from_srange(smin >> (smin < 0 ? umin_val : umax_val),
+ 				      smax >> (smax < 0 ? umax_val : umin_val));
 =20
- 	dst_reg->var_off =3D tnum_arshift(tnum_subreg(dst_reg->var_off), umin_va=
l, 32);
+ 	dst->var_off =3D tnum_arshift(tnum_subreg(dst->var_off), umin_val, 32);
 =20
- 	__mark_reg64_unbounded(dst_reg);
- 	__update_reg32_bounds(dst_reg);
+ 	__mark_scalar64_unbounded(dst);
+ 	__update_scalar32_bounds(dst);
  }
 =20
- static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
- 				struct bpf_reg_state *src_reg)
+ static void scalar_min_max_arsh(struct scalar *dst, const struct scalar *=
src)
  {
- 	u64 umin_val =3D reg_umin(src_reg);
+ 	u64 umin_val =3D cnum64_umin(src->r64), umax_val =3D cnum64_umax(src->r6=
4);
+ 	struct cnum64 known =3D cnum64_from_tnum(dst->var_off);
+ 	/* a range that crosses S64_MAX has no signed bounds, the known bits hav=
e: 0..0xf0 << 56 */
+ 	s64 smin =3D max(cnum64_smin(dst->r64), cnum64_smin(known));
+ 	s64 smax =3D min(cnum64_smax(dst->r64), cnum64_smax(known));
 =20
- 	/* Upon reaching here, src_known is true and umax_val is equal
- 	 * to umin_val.
- 	 */
- 	reg_set_srange64(dst_reg, reg_smin(dst_reg) >> umin_val,
- 			 reg_smax(dst_reg) >> umin_val);
+ 	/* A larger count brings the result closer to 0, or to -1 */
+ 	dst->r64 =3D cnum64_from_srange(smin >> (smin < 0 ? umin_val : umax_val),
+ 				      smax >> (smax < 0 ? umax_val : umin_val));
 =20
- 	dst_reg->var_off =3D tnum_arshift(dst_reg->var_off, umin_val, 64);
+ 	dst->var_off =3D tnum_arshift(dst->var_off, umin_val, 64);
 =20
  	/* Its not easy to operate on alu32 bounds here because it depends
  	 * on bits being shifted in from upper 32-bits. Take easy way out
  	 * and mark unbounded so we can recalculate later from tnum.
  	 */
- 	__mark_reg32_unbounded(dst_reg);
- 	__update_reg_bounds(dst_reg);
+ 	__mark_scalar32_unbounded(dst);
+ 	__update_scalar_bounds(dst);
  }
 =20
- static void scalar_byte_swap(struct bpf_reg_state *dst_reg, struct bpf_in=
sn *insn)
+ static void scalar_byte_swap(struct scalar *dst, const struct bpf_insn *i=
nsn)
  {
  	/*
  	 * Byte swap operation - update var_off using tnum_bswap.
@@@ -17314,51 -17560,45 +17572,45 @@@
  	/* Apply bswap if alu64 or switch between big-endian and little-endian m=
achines */
  	bool need_bswap =3D alu64 || (to_le =3D=3D is_big_endian);
 =20
- 	/*
- 	 * If the register is mutated, manually reset its scalar ID to break
- 	 * any existing ties and avoid incorrect bounds propagation.
- 	 */
- 	if (need_bswap || insn->imm =3D=3D 16 || insn->imm =3D=3D 32)
- 		clear_scalar_id(dst_reg);
-=20
  	if (need_bswap) {
  		if (insn->imm =3D=3D 16)
- 			dst_reg->var_off =3D tnum_bswap16(dst_reg->var_off);
+ 			dst->var_off =3D tnum_bswap16(dst->var_off);
  		else if (insn->imm =3D=3D 32)
- 			dst_reg->var_off =3D tnum_bswap32(dst_reg->var_off);
+ 			dst->var_off =3D tnum_bswap32(dst->var_off);
  		else if (insn->imm =3D=3D 64)
- 			dst_reg->var_off =3D tnum_bswap64(dst_reg->var_off);
+ 			dst->var_off =3D tnum_bswap64(dst->var_off);
  		/*
  		 * Byteswap scrambles the range, so we must reset bounds.
  		 * Bounds will be re-derived from the new tnum later.
  		 */
- 		__mark_reg_unbounded(dst_reg);
- 		reg_step_reset(dst_reg);
+ 		__mark_scalar_unbounded(dst);
+ 		scalar_step_reset(dst);
  	}
  	/* For bswap16/32, truncate dst register to match the swapped size */
  	if (insn->imm =3D=3D 16 || insn->imm =3D=3D 32)
- 		coerce_reg_to_size(dst_reg, insn->imm / 8);
+ 		coerce_scalar_to_size(dst, insn->imm / 8);
  }
 =20
- static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
- 					     const struct bpf_reg_state *src_reg)
+ static bool is_safe_to_compute_dst_reg_range(const struct bpf_insn *insn,
+ 					     const struct scalar *src)
  {
  	bool src_is_const =3D false;
  	u64 insn_bitness =3D (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) ? 64 : 32;
 =20
  	if (insn_bitness =3D=3D 32) {
- 		if (tnum_subreg_is_const(src_reg->var_off)
- 		    && reg_s32_min(src_reg) =3D=3D reg_s32_max(src_reg)
- 		    && reg_u32_min(src_reg) =3D=3D reg_u32_max(src_reg))
+ 		if (tnum_subreg_is_const(src->var_off)
+ 		    && cnum32_smin(src->r32) =3D=3D cnum32_smax(src->r32)
+ 		    && cnum32_umin(src->r32) =3D=3D cnum32_umax(src->r32))
  			src_is_const =3D true;
  	} else {
- 		if (tnum_is_const(src_reg->var_off)
- 		    && reg_smin(src_reg) =3D=3D reg_smax(src_reg)
- 		    && reg_umin(src_reg) =3D=3D reg_umax(src_reg))
+ 		if (tnum_is_const(src->var_off)
+ 		    && cnum64_smin(src->r64) =3D=3D cnum64_smax(src->r64)
+ 		    && cnum64_umin(src->r64) =3D=3D cnum64_umax(src->r64))
  			src_is_const =3D true;
  	}
 =20
  	switch (BPF_OP(insn->code)) {
+ 	case BPF_MOV:
  	case BPF_ADD:
  	case BPF_SUB:
  	case BPF_NEG:
@@@ -17369,32 -17609,29 +17621,29 @@@
  	case BPF_END:
  		return true;
 =20
- 	/*
- 	 * Division and modulo operators range is only safe to compute when the
- 	 * divisor is a constant.
- 	 */
+ 	/* The range of a signed division or modulo is computed for a constant d=
ivisor only */
  	case BPF_DIV:
  	case BPF_MOD:
- 		return src_is_const;
+ 		return src_is_const || !insn->off;
 =20
- 	/* Shift operators range is only computable if shift dimension operand
- 	 * is a constant. Shifts greater than 31 or 63 are undefined. This
- 	 * includes shifts by a negative number.
+ 	/*
+ 	 * Shifts greater than 31 or 63 are undefined. This includes shifts by
+ 	 * a negative number.
  	 */
  	case BPF_LSH:
  	case BPF_RSH:
  	case BPF_ARSH:
- 		return (src_is_const && reg_umax(src_reg) < insn_bitness);
+ 		return cnum64_umax(src->r64) < insn_bitness;
  	default:
  		return false;
  	}
  }
 =20
  static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env, struc=
t bpf_insn *insn,
- 				      struct bpf_reg_state *dst_reg, struct bpf_reg_state src_reg);
+ 				      struct bpf_reg_state *dst_reg, struct scalar src_val);
 =20
  static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
- 			      struct bpf_reg_state *dst_reg, const struct bpf_reg_state *src_r=
eg)
+ 			      struct bpf_reg_state *dst_reg, const struct scalar *src)
  {
  	struct bpf_verifier_state *branch;
  	struct bpf_reg_state *reg;
@@@ -17407,51 -17644,55 +17656,55 @@@
  	else
  		return 0;
 =20
+ 	/* with a step only a later insn can find that a part has no value */
+ 	scalar_step_reset(scalar_of(dst_reg));
  	branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, false);
  	if (IS_ERR(branch))
  		return PTR_ERR(branch);
 =20
  	reg =3D &branch->frame[branch->curframe]->regs[insn->dst_reg];
  	if (alu32) {
- 		__mark_reg32_known(reg, 0);
- 		__mark_reg32_known(dst_reg, -1ull);
+ 		__mark_scalar32_known(scalar_of(reg), 0);
+ 		__mark_scalar32_known(scalar_of(dst_reg), -1ull);
  	} else {
  		__mark_reg_known(reg, 0);
  		__mark_reg_known(dst_reg, -1ull);
  	}
+ 	bpf_equations_fork(env, branch, scalar_of(reg));
+ 	bpf_equations_fork(env, env->cur_state, scalar_of(dst_reg));
  	/*
  	 * The insn is done with in the branch too, and what gets to the next in=
sn is a state
  	 * like any other. At this insn the branch is a part of the state that i=
s looked at:
  	 * it must not be compared with it.
  	 */
- 	clear_scalar_id(reg);
- 	return adjust_scalar_min_max_vals(env, insn, reg, *src_reg);
+ 	return adjust_scalar_min_max_vals(env, insn, reg, *src);
  }
 =20
- /* WARNING: This function does calculations on 64-bit values, but the act=
ual
+ /*
+  * dst =3D dst <op> src: the transfer function of the ALU insn @insn.
+  * @src can't be @dst. BPF_NEG and BPF_END ignore its value: any valid sc=
alar will do.
+  *
+  * WARNING: This function does calculations on 64-bit values, but the act=
ual
   * execution may occur on 32-bit values. Therefore, things like bitshifts
   * need extra checks in the 32-bit case.
   */
- static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
- 				      struct bpf_insn *insn,
- 				      struct bpf_reg_state *dst_reg,
- 				      struct bpf_reg_state src_reg)
+ void scalar_alu(struct scalar *dst, const struct scalar *src, const struc=
t bpf_insn *insn)
  {
  	u8 opcode =3D BPF_OP(insn->code);
  	s16 off =3D insn->off;
  	bool alu32 =3D (BPF_CLASS(insn->code) !=3D BPF_ALU64);
- 	int ret;
+ 	struct scalar tmp;
+ 	u64 cleared;
 =20
- 	if (!is_safe_to_compute_dst_reg_range(insn, &src_reg)) {
- 		__mark_reg_unknown(env, dst_reg);
- 		return 0;
+ 	if (!is_safe_to_compute_dst_reg_range(insn, src)) {
+ 		scalar_set_unknown(dst);
+ 		return;
  	}
 =20
- 	if (sanitize_needed(opcode)) {
- 		ret =3D sanitize_val_alu(env, insn);
- 		if (ret < 0)
- 			return sanitize_err(env, insn, ret);
- 	}
+ 	/* The count of a shift is a range: a bit of dst can end up in more than=
 one place */
+ 	if ((opcode =3D=3D BPF_LSH || opcode =3D=3D BPF_RSH || opcode =3D=3D BPF=
_ARSH) &&
+ 	    cnum64_umin(src->r64) !=3D cnum64_umax(src->r64))
+ 		dst->var_off =3D tnum_unknown;
 =20
  	/* Calculate sign/unsigned bounds and tnum for alu32 and alu64 bit ops.
  	 * There are two classes of instructions: The first class we track both
@@@ -17468,118 -17709,141 +17721,141 @@@
  	 * tnum to calculate an approximation of the sign/unsigned bounds.
  	 */
  	switch (opcode) {
+ 	case BPF_MOV:
+ 		*dst =3D *src;
+ 		if (off && alu32)
+ 			coerce_subreg_to_size_sx(dst, off >> 3);
+ 		else if (off)
+ 			coerce_scalar_to_size_sx(dst, off >> 3);
+ 		break;
  	case BPF_ADD:
- 		scalar_step_add(dst_reg, dst_reg, &src_reg);
- 		scalar32_min_max_add(dst_reg, &src_reg);
- 		scalar_min_max_add(dst_reg, &src_reg);
- 		dst_reg->var_off =3D tnum_add(dst_reg->var_off, src_reg.var_off);
+ 		scalar_add(dst, dst, src);
  		break;
  	case BPF_SUB:
- 		scalar32_min_max_sub(dst_reg, &src_reg);
- 		scalar_min_max_sub(dst_reg, &src_reg);
- 		dst_reg->var_off =3D tnum_sub(dst_reg->var_off, src_reg.var_off);
- 		reg_step_reset(dst_reg);
+ 		scalar32_min_max_sub(dst, src);
+ 		scalar_min_max_sub(dst, src);
+ 		dst->var_off =3D tnum_sub(dst->var_off, src->var_off);
+ 		scalar_step_reset(dst);
  		break;
  	case BPF_NEG:
- 		env->fake_reg[0] =3D *dst_reg;
- 		__mark_reg_known(dst_reg, 0);
- 		scalar32_min_max_sub(dst_reg, &env->fake_reg[0]);
- 		scalar_min_max_sub(dst_reg, &env->fake_reg[0]);
- 		dst_reg->var_off =3D tnum_neg(env->fake_reg[0].var_off);
- 		reg_step_reset(dst_reg);
+ 		tmp =3D *dst;
+ 		scalar_set_const(dst, 0);
+ 		scalar32_min_max_sub(dst, &tmp);
+ 		scalar_min_max_sub(dst, &tmp);
+ 		dst->var_off =3D tnum_neg(tmp.var_off);
+ 		scalar_step_reset(dst);
  		break;
  	case BPF_MUL:
- 		scalar_step_mul(dst_reg, &src_reg);
- 		dst_reg->var_off =3D tnum_mul(dst_reg->var_off, src_reg.var_off);
- 		scalar32_min_max_mul(dst_reg, &src_reg);
- 		scalar_min_max_mul(dst_reg, &src_reg);
+ 		/*
+ 		 * Range analysis for UHMUL/SHMUL is not implemented yet.
+ 		 * Compute an exact result only when both operands are constants.
+ 		 * Ordinary low-half MUL continues to use the analysis below.
+ 		 */
+ 		if (bpf_insn_is_hmul(insn) &&
+ 		    (!scalar_is_const(dst, false) ||
+ 		     !scalar_is_const(src, false))) {
+ 			scalar_set_unknown(dst);
+ 			break;
+ 		}
+ 		if (!alu32 && insn->off =3D=3D BPF_UHMUL) {
+ 			scalar_min_max_uhmul(dst, src);
+ 			break;
+ 		}
+ 		if (!alu32 && insn->off =3D=3D BPF_SHMUL) {
+ 			scalar_min_max_shmul(dst, src);
+ 			break;
+ 		}
+ 		scalar_step_mul(dst, src);
+ 		dst->var_off =3D tnum_mul(dst->var_off, src->var_off);
+ 		scalar32_min_max_mul(dst, src);
+ 		scalar_min_max_mul(dst, src);
  		break;
  	case BPF_DIV:
  		/* BPF div specification: x / 0 =3D 0 */
- 		if ((alu32 && reg_u32_min(&src_reg) =3D=3D 0) || (!alu32 && reg_umin(&s=
rc_reg) =3D=3D 0)) {
- 			___mark_reg_known(dst_reg, 0);
+ 		if ((alu32 && cnum32_umax(src->r32) =3D=3D 0) ||
+ 		    (!alu32 && cnum64_umax(src->r64) =3D=3D 0)) {
+ 			scalar_set_const(dst, 0);
  			break;
  		}
  		if (alu32)
  			if (off =3D=3D 1)
- 				scalar32_min_max_sdiv(dst_reg, &src_reg);
+ 				scalar32_min_max_sdiv(dst, src);
  			else
- 				scalar32_min_max_udiv(dst_reg, &src_reg);
+ 				scalar32_min_max_udiv(dst, src);
  		else
  			if (off =3D=3D 1)
- 				scalar_min_max_sdiv(dst_reg, &src_reg);
+ 				scalar_min_max_sdiv(dst, src);
  			else
- 				scalar_min_max_udiv(dst_reg, &src_reg);
- 		reg_step_reset(dst_reg);
+ 				scalar_min_max_udiv(dst, src);
+ 		scalar_step_reset(dst);
  		break;
  	case BPF_MOD:
  		/* BPF mod specification: x % 0 =3D x */
- 		if ((alu32 && reg_u32_min(&src_reg) =3D=3D 0) || (!alu32 && reg_umin(&s=
rc_reg) =3D=3D 0))
+ 		if ((alu32 && cnum32_umax(src->r32) =3D=3D 0) ||
+ 		    (!alu32 && cnum64_umax(src->r64) =3D=3D 0))
  			break;
  		if (alu32)
  			if (off =3D=3D 1)
- 				scalar32_min_max_smod(dst_reg, &src_reg);
+ 				scalar32_min_max_smod(dst, src);
  			else
- 				scalar32_min_max_umod(dst_reg, &src_reg);
+ 				scalar32_min_max_umod(dst, src);
  		else
  			if (off =3D=3D 1)
- 				scalar_min_max_smod(dst_reg, &src_reg);
+ 				scalar_min_max_smod(dst, src);
  			else
- 				scalar_min_max_umod(dst_reg, &src_reg);
- 		reg_step_reset(dst_reg);
+ 				scalar_min_max_umod(dst, src);
+ 		scalar_step_reset(dst);
  		break;
  	case BPF_AND:
- 		if (tnum_is_const(src_reg.var_off)) {
- 			ret =3D maybe_fork_scalars(env, insn, dst_reg, &src_reg);
- 			if (ret)
- 				return ret;
- 		}
- 		dst_reg->var_off =3D tnum_and(dst_reg->var_off, src_reg.var_off);
- 		scalar32_min_max_and(dst_reg, &src_reg);
- 		scalar_min_max_and(dst_reg, &src_reg);
- 		reg_step_reset(dst_reg);
+ 		cleared =3D (dst->var_off.value | dst->var_off.mask) & ~src->var_off.va=
lue;
+ 		tmp =3D *dst;
+ 		dst->var_off =3D tnum_and(dst->var_off, src->var_off);
+ 		scalar32_min_max_and(dst, src);
+ 		scalar_min_max_and(dst, src);
+ 		scalar_step_reset(dst);
+ 		/*
+ 		 * If no bit is cleared, the old ranges hold too.
+ 		 * A part from maybe_fork_scalars() can have no value.
+ 		 */
+ 		if (!(u32)cleared && !scalar_is_empty(&tmp))
+ 			scalar_intersect(dst, &tmp, cleared ? 32 : 64);
  		break;
  	case BPF_OR:
- 		if (tnum_is_const(src_reg.var_off)) {
- 			ret =3D maybe_fork_scalars(env, insn, dst_reg, &src_reg);
- 			if (ret)
- 				return ret;
- 		}
- 		dst_reg->var_off =3D tnum_or(dst_reg->var_off, src_reg.var_off);
- 		scalar32_min_max_or(dst_reg, &src_reg);
- 		scalar_min_max_or(dst_reg, &src_reg);
- 		reg_step_reset(dst_reg);
+ 		dst->var_off =3D tnum_or(dst->var_off, src->var_off);
+ 		scalar32_min_max_or(dst, src);
+ 		scalar_min_max_or(dst, src);
+ 		scalar_step_reset(dst);
  		break;
  	case BPF_XOR:
- 		dst_reg->var_off =3D tnum_xor(dst_reg->var_off, src_reg.var_off);
- 		scalar32_min_max_xor(dst_reg, &src_reg);
- 		scalar_min_max_xor(dst_reg, &src_reg);
- 		reg_step_reset(dst_reg);
+ 		dst->var_off =3D tnum_xor(dst->var_off, src->var_off);
+ 		scalar32_min_max_xor(dst, src);
+ 		scalar_min_max_xor(dst, src);
+ 		scalar_step_reset(dst);
  		break;
  	case BPF_LSH:
- 		scalar_step_lsh(dst_reg, &src_reg);
+ 		scalar_step_lsh(dst, src);
  		if (alu32)
- 			scalar32_min_max_lsh(dst_reg, &src_reg);
+ 			scalar32_min_max_lsh(dst, src);
  		else
- 			scalar_min_max_lsh(dst_reg, &src_reg);
+ 			scalar_min_max_lsh(dst, src);
  		break;
  	case BPF_RSH:
  		if (alu32)
- 			scalar32_min_max_rsh(dst_reg, &src_reg);
+ 			scalar32_min_max_rsh(dst, src);
  		else
- 			scalar_min_max_rsh(dst_reg, &src_reg);
- 		reg_step_reset(dst_reg);
+ 			scalar_min_max_rsh(dst, src);
+ 		scalar_step_reset(dst);
  		break;
  	case BPF_ARSH:
  		if (alu32)
- 			scalar32_min_max_arsh(dst_reg, &src_reg);
+ 			scalar32_min_max_arsh(dst, src);
  		else
- 			scalar_min_max_arsh(dst_reg, &src_reg);
- 		reg_step_reset(dst_reg);
+ 			scalar_min_max_arsh(dst, src);
+ 		scalar_step_reset(dst);
  		break;
  	case BPF_END:
- 		scalar_byte_swap(dst_reg, insn);
- 		reg_step_reset(dst_reg);
+ 		scalar_byte_swap(dst, insn);
+ 		scalar_step_reset(dst);
  		break;
  	default:
  		break;
@@@ -17595,8 -17859,29 +17871,29 @@@
  	 * but we should not zero extend the result.
  	 */
  	if (alu32 && opcode !=3D BPF_END)
- 		zext_32_to_64(dst_reg);
- 	reg_bounds_sync(dst_reg);
+ 		scalar_zext32(dst);
+ 	scalar_bounds_sync(dst);
+ }
+=20
+ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env, struc=
t bpf_insn *insn,
+ 				      struct bpf_reg_state *dst_reg, struct scalar src_val)
+ {
+ 	u8 opcode =3D BPF_OP(insn->code);
+ 	int ret;
+=20
+ 	if (sanitize_needed(opcode)) {
+ 		ret =3D sanitize_err(env, sanitize_val_alu(env, insn));
+ 		if (ret)
+ 			return ret;
+ 	}
+=20
+ 	if ((opcode =3D=3D BPF_AND || opcode =3D=3D BPF_OR) && tnum_is_const(src=
_val.var_off)) {
+ 		ret =3D maybe_fork_scalars(env, insn, dst_reg, &src_val);
+ 		if (ret)
+ 			return ret;
+ 	}
+=20
+ 	scalar_alu(scalar_of(dst_reg), &src_val, insn);
  	return 0;
  }
 =20
@@@ -17610,10 -17895,8 +17907,8 @@@ static int adjust_reg_min_max_vals(stru
  	struct bpf_func_state *state =3D vstate->frame[vstate->curframe];
  	struct bpf_reg_state *regs =3D state->regs, *dst_reg, *src_reg;
  	struct bpf_reg_state *ptr_reg =3D NULL, off_reg =3D {0};
- 	bool alu32 =3D (BPF_CLASS(insn->code) !=3D BPF_ALU64);
  	struct bpf_insn_aux_data *aux =3D cur_aux(env);
  	u8 opcode =3D BPF_OP(insn->code);
- 	int err;
 =20
  	dst_reg =3D &regs[insn->dst_reg];
  	if (BPF_SRC(insn->code) =3D=3D BPF_X)
@@@ -17624,6 -17907,11 +17919,11 @@@
  	/* Case where at least one operand is an arena. */
  	if (dst_reg->type =3D=3D PTR_TO_ARENA || (src_reg && src_reg->type =3D=
=3D PTR_TO_ARENA)) {
 =20
+ 		if (bpf_insn_is_hmul(insn)) {
+ 			verbose(env, "UHMUL/SHMUL with arena pointers are not supported\n");
+ 			return -EOPNOTSUPP;
+ 		}
+=20
  		if (dst_reg->type !=3D PTR_TO_ARENA)
  			*dst_reg =3D *src_reg;
 =20
@@@ -17635,10 -17923,8 +17935,8 @@@
  			 * prevent zext from being set if the instruction has
  			 * been previously called with non-arena registers.
  			 */
- 			if (aux->prevent_zext) {
- 				verbose(env, "same insn cannot be used with and without arena pointer=
\n");
- 				return -EINVAL;
- 			}
+ 			if (aux->prevent_zext)
+ 				return fixups_differ(env, "same insn cannot be used with and without =
arena pointer");
 =20
  			/*
  			 * 32-bit operations zero upper bits automatically.
@@@ -17654,10 -17940,8 +17952,8 @@@
 =20
  	/* Prevent the instruction from being used with arena pointers (see abov=
e). */
  	if (env->prog->aux->arena && BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
- 		if (aux->needs_zext) {
- 			verbose(env, "same insn cannot be used with and without arena pointer\=
n");
- 			return -EINVAL;
- 		}
+ 		if (aux->needs_zext)
+ 			return fixups_differ(env, "same insn cannot be used with and without a=
rena pointer");
 =20
  		aux->prevent_zext =3D true;
  	}
@@@ -17668,11 -17952,11 +17964,11 @@@
  	if (BPF_SRC(insn->code) =3D=3D BPF_X) {
  		if (src_reg->type !=3D SCALAR_VALUE) {
  			if (dst_reg->type !=3D SCALAR_VALUE) {
- 				/* Combining two pointers by any ALU op yields
- 				 * an arbitrary scalar. Disallow all math except
- 				 * pointer subtraction
+ 				/*
+ 				 * Combining two pointers by any ALU op yields
+ 				 * an arbitrary scalar.
  				 */
- 				if (opcode =3D=3D BPF_SUB && env->allow_ptr_leaks) {
+ 				if (env->allow_ptr_leaks) {
  					mark_reg_unknown(env, regs, insn->dst_reg);
  					return 0;
  				}
@@@ -17685,24 -17969,13 +17981,13 @@@
  				 * This is legal, but we have to reverse our
  				 * src/dest handling in computing the range
  				 */
- 				err =3D mark_chain_precision(env, insn->dst_reg);
- 				if (err)
- 					return err;
  				off_reg =3D *dst_reg;
  				return adjust_ptr_min_max_vals(env, insn, insn->src_reg, src_reg,
  							       &off_reg);
  			}
  		} else if (ptr_reg) {
  			/* pointer +=3D scalar */
- 			err =3D mark_chain_precision(env, insn->src_reg);
- 			if (err)
- 				return err;
  			return adjust_ptr_min_max_vals(env, insn, insn->dst_reg, dst_reg, src_=
reg);
- 		} else if (dst_reg->precise) {
- 			/* if dst_reg is precise, src_reg should be precise as well */
- 			err =3D mark_chain_precision(env, insn->src_reg);
- 			if (err)
- 				return err;
  		}
  	} else {
  		/* Pretend the src is a reg with a known value, since we only
@@@ -17726,69 -17999,7 +18011,7 @@@
  		verbose(env, "verifier internal error: no src_reg\n");
  		return -EFAULT;
  	}
- 	/*
- 	 * For alu32 linked register tracking, we need to check dst_reg's
- 	 * umax_value before the ALU operation. After adjust_scalar_min_max_vals=
(),
- 	 * alu32 ops will have zero-extended the result, making umax_value <=3D =
U32_MAX.
- 	 */
- 	u64 dst_umax =3D reg_umax(dst_reg);
-=20
- 	err =3D adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
- 	if (err)
- 		return err;
- 	/*
- 	 * Compilers can generate the code
- 	 * r1 =3D r2
- 	 * r1 +=3D 0x1
- 	 * if r2 < 1000 goto ...
- 	 * use r1 in memory access
- 	 * So remember constant delta between r2 and r1 and update r1 after
- 	 * 'if' condition.
- 	 */
- 	if (env->bpf_capable &&
- 	    (BPF_OP(insn->code) =3D=3D BPF_ADD || BPF_OP(insn->code) =3D=3D BPF_=
SUB) &&
- 	    dst_reg->id && is_reg_const(src_reg, alu32) &&
- 	    !(BPF_SRC(insn->code) =3D=3D BPF_X && insn->src_reg =3D=3D insn->dst=
_reg)) {
- 		u64 val =3D reg_const_value(src_reg, alu32);
- 		s32 off;
-=20
- 		if (!alu32 && ((s64)val < S32_MIN || (s64)val > S32_MAX))
- 			goto clear_id;
-=20
- 		if (alu32 && (dst_umax > U32_MAX))
- 			goto clear_id;
-=20
- 		off =3D (s32)val;
-=20
- 		if (BPF_OP(insn->code) =3D=3D BPF_SUB) {
- 			/* Negating S32_MIN would overflow */
- 			if (off =3D=3D S32_MIN)
- 				goto clear_id;
- 			off =3D -off;
- 		}
-=20
- 		if (dst_reg->id & BPF_ADD_CONST) {
- 			/*
- 			 * If the register already went through rX +=3D val
- 			 * we cannot accumulate another val into rx->off.
- 			 */
- clear_id:
- 			clear_scalar_id(dst_reg);
- 		} else {
- 			if (alu32)
- 				dst_reg->id |=3D BPF_ADD_CONST32;
- 			else
- 				dst_reg->id |=3D BPF_ADD_CONST64;
- 			dst_reg->delta =3D off;
- 		}
- 	} else {
- 		/*
- 		 * Make sure ID is cleared otherwise dst_reg min/max could be
- 		 * incorrectly propagated into other registers by sync_linked_regs()
- 		 */
- 		clear_scalar_id(dst_reg);
- 	}
- 	return 0;
+ 	return adjust_scalar_min_max_vals(env, insn, dst_reg, *scalar_of(src_reg=
));
  }
 =20
  /*
@@@ -17844,70 -18055,157 +18067,157 @@@ bool bpf_same_memory_origin(const s=
truc
   * 'range - smax' bytes from a packet pointer are in the packet. reg_boun=
ds_sync() can make smax
   * smaller than @smax: with a step of 8, or with 3 zero bits in var_off, =
58 becomes 56. Make the
   * range smaller by the same number, so that the number of bytes does not=
 grow. umax is not
-  * sufficient: it is U64_MAX when the offset can be negative.
+  * sufficient: it is U64_MAX when the offset can be negative. A jump can =
take smax from S64_MAX
+  * to -3: the difference does not fit in s64. If smax is larger than @sma=
x the range is lost.
+  * If smax is below pkt_min_len, the range is at least pkt_min_len.
   */
  void bpf_trim_pkt_range(struct bpf_reg_state *reg, s64 smax)
  {
- 	if (type_is_pkt_pointer(reg->type) && reg->range > 0)
- 		reg->range =3D max_t(s64, reg->range - (smax - reg_smax(reg)), 0);
- }
+ 	u64 lost =3D (u64)smax - reg_smax(reg);
 =20
- int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state =
*reg,
- 		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step)
- {
- 	reg->r64 =3D r64;
- 	reg->r32 =3D r32;
- 	reg->step =3D step;
- 	reg->base =3D base;
- 	reg->var_off =3D tnum_unknown;
- 	reg_bounds_sync(reg); /* this should infer the tnum alignment */
- 	bpf_trim_pkt_range(reg, cnum64_smax(r64));
- 	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
+ 	if (!type_is_pkt_pointer(reg->type) || reg->range < 0)
+ 		return;
+ 	reg->range =3D lost < reg->range ? reg->range - lost : 0;
+ 	if (reg->pkt_min_len > reg_smax(reg))
+ 		reg->range =3D max(reg->range, reg->pkt_min_len);
  }
 =20
  /*
-  * Checks if pointer and packet metadata matches between two registers.
-  * For use with bpf_reg_union().
+  * @s is what @old became after a trip around a cycle, @old included. The=
 end
+  * of the range that moved will move again. Move it to a threshold where =
it
+  * can stop. @min_threshold, @max_threshold: the caller guesses that it s=
tops there.
+  * Take the nearest threshold. Each value between the range and the thres=
hold is made up,
+  * and the program is checked with it. With each threshold the range only=
 gets larger.
   */
- bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct=
 bpf_reg_state *b)
+ void scalar_widen(struct scalar *s, const struct scalar *old, s64 min_thr=
eshold, s64 max_threshold)
  {
- 	if (a->type !=3D b->type)
- 		return false;
- 	if (a->type =3D=3D SCALAR_VALUE)
- 		return true;
- 	return !memcmp(a, b, offsetof(struct bpf_reg_state, var_off)) &&
- 	       a->id =3D=3D b->id && a->parent_id =3D=3D b->parent_id && a->map_=
uid =3D=3D b->map_uid;
- }
+ 	bool moved =3D s->r64.base !=3D old->r64.base || s->r64.size !=3D old->r=
64.size ||
+ 		     s->r32.base !=3D old->r32.base || s->r32.size !=3D old->r32.size;
+ 	s64 min =3D cnum64_smin(s->r64), max =3D cnum64_smax(s->r64), threshold;
 =20
- /*
-  * Extends acc's scalar range to include src's scalar range.
-  * Caller must ensure that other kinds of metadata is compatible.
-  * Caller must clear acc's scalar ID.
-  */
- int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
- 		  const struct bpf_reg_state *src)
- {
- 	u16 base, step;
+ 	/* Only the step got weaker. It comes to rest without help, see below. */
+ 	if (!moved && s->var_off.value =3D=3D old->var_off.value &&
+ 	    s->var_off.mask =3D=3D old->var_off.mask)
+ 		return;
 =20
- 	if (!bpf_reg_union_compatible(acc, src)) {
- 		verifier_bug(env, "union of incompatible registers");
- 		return -EFAULT;
+ 	if (max > cnum64_smax(old->r64)) {
+ 		threshold =3D max <=3D 0 ? 0 :
+ 			    max <=3D S32_MAX ? S32_MAX :
+ 			    max <=3D U32_MAX ? U32_MAX : S64_MAX;
+ 		max =3D min(threshold, max_threshold);
  	}
+ 	if (min < cnum64_smin(old->r64)) {
+ 		threshold =3D min >=3D 0 ? 0 :
+ 			    min >=3D S32_MIN ? S32_MIN : S64_MIN;
+ 		min =3D max(threshold, min_threshold);
+ 	}
+ 	if (min =3D=3D S64_MIN && max =3D=3D S64_MAX) {
+ 		scalar_set_unknown(s);
+ 		return;
+ 	}
+ 	/*
+ 	 * A fixed threshold is a guess. A number of 32 bits that gets past S32_=
MAX stops at
+ 	 * U32_MAX. No threshold stops what gets past S32_MAX, U32_MAX or S32_MI=
N and out of
+ 	 * 32 bits:
+ 	 *	sum +=3D a[i]; if (sum =3D=3D 77) ...
+ 	 * It wraps in the next trip, and the other bound is gone as well.
+ 	 */
+ 	if ((max =3D=3D S64_MAX &&
+ 	     (cnum64_smax(old->r64) =3D=3D S32_MAX || cnum64_smax(old->r64) =3D=
=3D U32_MAX)) ||
+ 	    (min =3D=3D S64_MIN && cnum64_smin(old->r64) =3D=3D S32_MIN)) {
+ 		scalar_set_unknown(s);
+ 		return;
+ 	}
+ 	/* every part has to include what it did before, hence no scalar_bounds_=
sync() */
+ 	s->r64 =3D cnum64_union(s->r64, cnum64_from_srange(min, max));
+ 	if (min >=3D 0 && max <=3D U32_MAX) {
+ 		s->r32 =3D cnum32_union(s->r32, cnum32_from_urange(min, max));
+ 		s->var_off =3D tnum_union(s->var_off, tnum_range(min, max));
+ 	} else if (min >=3D S32_MIN && max <=3D S32_MAX) {
+ 		s->r32 =3D cnum32_union(s->r32, cnum32_from_srange(min, max));
+ 		s->var_off =3D tnum_unknown;
+ 	} else {
+ 		s->r32 =3D CNUM32_UNBOUNDED;
+ 		s->var_off =3D min >=3D 0 ? tnum_union(s->var_off, tnum_range(min, max))
+ 					: tnum_unknown;
+ 	}
+ 	/*
+ 	 * No range moved: the known bits or the step got weaker. The step comes=
 to rest without
+ 	 * help: it gives way to one of its divisors only.
+ 	 *	off =3D n * 4; do { sum +=3D *(u32 *)(a + off); off -=3D 4; } while (=
off !=3D -4);
+ 	 * counts on "a multiple of 4".
+ 	 */
+ 	if (moved)
+ 		scalar_step_reset(s);
+ }
+=20
+ void scalar_union(struct scalar *acc, const struct scalar *src)
+ {
+ 	bool acc_const =3D cnum64_is_const(acc->r64), src_const =3D cnum64_is_co=
nst(src->r64);
+ 	/* A constant is its own base. Its step is 0: every number divides 0. */
+ 	s64 a =3D acc_const ? cnum64_smin(acc->r64) : acc->base;
+ 	s64 b =3D src_const ? cnum64_smin(src->r64) : src->base;
+ 	u16 step =3D gcd(acc_const ? 0 : acc->step, src_const ? 0 : src->step);
+ 	s64 diff;
+=20
  	acc->r64 =3D cnum64_union(acc->r64, src->r64);
  	acc->r32 =3D cnum32_union(acc->r32, src->r32);
  	acc->var_off =3D tnum_union(acc->var_off, src->var_off);
 =20
- 	/* Retain a common congruence if the bases agree modulo the gcd. */
- 	step =3D gcd(acc->step, src->step);
- 	base =3D acc->base % step;
- 	if (base !=3D src->base % step) {
- 		reg_step_reset(acc);
- 	} else {
- 		acc->base =3D base;
- 		acc->step =3D step;
+ 	/* a + s * k and b + t * k are both of the form a + gcd(s, t, a - b) * k=
 */
+ 	if (check_sub_overflow(a, b, &diff) || (!step && (diff > U16_MAX || diff=
 < -U16_MAX)))
+ 		step =3D 1;
+ 	else
+ 		step =3D (step ? gcd(step, imod(diff, step)) : abs(diff)) ?: 1;
+ 	acc->step =3D step;
+ 	acc->base =3D imod(a, step);
+ 	/*
+ 	 * No reg_bounds_sync(): every part of the result has to include that
+ 	 * part of both inputs, and an input is not always in sync.
+ 	 */
+ }
+=20
+ /*
+  * There are no address spaces in Rust. The compiler doesn't cast a point=
er that
+  * comes from the kernel. But it can't always tell, and then it casts the=
 pointer
+  * to as(0) before the access, like an address in arena.
+  * A pointer that the verifier knows is in as(0) already, so the cast is =
a move.
+  * arg_track_xfer() does the same for pointers to stack.
+  */
+ static bool is_cast_mov(const struct bpf_insn *insn, const struct bpf_reg=
_state *src_reg)
+ {
+ 	/* cast from as(1) to as(0) */
+ 	if (insn->imm !=3D 1)
+ 		return false;
+=20
+ 	switch (base_type(src_reg->type)) {
+ 	case SCALAR_VALUE:
+ 	case PTR_TO_ARENA:
+ 		return false;
+ 	default:
+ 		return true;
  	}
- 	reg_bounds_sync(acc);
- 	return reg_bounds_sanity_check(env, acc, "bpf_reg_union");
+ }
+=20
+ static int check_addr_space_cast(struct bpf_verifier_env *env, struct bpf=
_insn *insn,
+ 				 struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg)
+ {
+ 	struct bpf_insn_aux_data *aux =3D cur_aux(env);
+=20
+ 	if (is_cast_mov(insn, src_reg)) {
+ 		aux->cast_mov =3D true;
+ 		*dst_reg =3D *src_reg;
+ 	} else {
+ 		aux->cast_arena =3D true;
+ 		mark_reg_unknown(env, cur_regs(env), insn->dst_reg);
+ 		if (insn->imm =3D=3D 1) /* cast from as(1) to as(0) */
+ 			dst_reg->type =3D PTR_TO_ARENA;
+ 	}
+=20
+ 	/* it's either wX =3D wY or rX =3D rY, see bpf_lower_cast_mov() */
+ 	if (aux->cast_mov && aux->cast_arena)
+ 		return fixups_differ(env, "same addr_space_cast insn cannot be used wit=
h a number and with a pointer");
+ 	return 0;
  }
 =20
  /* check validity of 32-bit and 64-bit arithmetic operations */
@@@ -17936,7 -18234,7 +18246,7 @@@ static int check_alu_op(struct bpf_veri
  			err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
  			err =3D err ?: adjust_scalar_min_max_vals(env, insn,
  							 &regs[insn->dst_reg],
- 							 regs[insn->dst_reg]);
+ 							 *scalar_of(&regs[insn->dst_reg]));
  		} else {
  			err =3D check_reg_arg(env, insn->dst_reg, DST_OP);
  		}
@@@ -17971,14 -18269,13 +18281,13 @@@
  			if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
  				if (insn->imm) {
  					/* off =3D=3D BPF_ADDR_SPACE_CAST */
- 					mark_reg_unknown(env, regs, insn->dst_reg);
- 					if (insn->imm =3D=3D 1) /* cast from as(1) to as(0) */
- 						dst_reg->type =3D PTR_TO_ARENA;
+ 					err =3D check_addr_space_cast(env, insn, dst_reg, src_reg);
+ 					if (err)
+ 						return err;
  				} else if (insn->off =3D=3D 0) {
  					/* case: R1 =3D R2
  					 * copy register state to dest reg
  					 */
- 					assign_scalar_id_before_mov(env, src_reg);
  					*dst_reg =3D *src_reg;
  				} else {
  					/* case: R1 =3D (s8, s16 s32)R2 */
@@@ -17988,15 -18285,9 +18297,9 @@@
  							insn->src_reg);
  						return -EACCES;
  					} else if (src_reg->type =3D=3D SCALAR_VALUE) {
- 						bool no_sext;
-=20
- 						no_sext =3D reg_umax(src_reg) < (1ULL << (insn->off - 1));
- 						if (no_sext)
- 							assign_scalar_id_before_mov(env, src_reg);
  						*dst_reg =3D *src_reg;
- 						if (!no_sext)
- 							clear_scalar_id(dst_reg);
- 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
+ 						coerce_scalar_to_size_sx(scalar_of(dst_reg),
+ 									 insn->off >> 3);
  					} else {
  						mark_reg_unknown(env, regs, insn->dst_reg);
  					}
@@@ -18009,34 -18300,16 +18312,16 @@@
  						insn->src_reg);
  					return -EACCES;
  				} else if (src_reg->type =3D=3D SCALAR_VALUE) {
- 					if (insn->off =3D=3D 0) {
- 						bool is_src_reg_u32 =3D get_reg_width(src_reg) <=3D 32;
-=20
- 						if (is_src_reg_u32)
- 							assign_scalar_id_before_mov(env, src_reg);
- 						*dst_reg =3D *src_reg;
- 						/* Make sure ID is cleared if src_reg is not in u32
- 						 * range otherwise dst_reg min/max could be incorrectly
- 						 * propagated into src_reg by sync_linked_regs()
- 						 */
- 						if (!is_src_reg_u32)
- 							clear_scalar_id(dst_reg);
- 					} else {
- 						/* case: W1 =3D (s8, s16)W2 */
- 						bool no_sext =3D reg_umax(src_reg) < (1ULL << (insn->off - 1));
-=20
- 						if (no_sext)
- 							assign_scalar_id_before_mov(env, src_reg);
- 						*dst_reg =3D *src_reg;
- 						if (!no_sext)
- 							clear_scalar_id(dst_reg);
- 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
- 					}
+ 					*dst_reg =3D *src_reg;
+ 					/* case: W1 =3D (s8, s16)W2 */
+ 					if (insn->off)
+ 						coerce_subreg_to_size_sx(scalar_of(dst_reg),
+ 									 insn->off >> 3);
  				} else {
  					mark_reg_unknown(env, regs,
  							 insn->dst_reg);
  				}
- 				zext_32_to_64(dst_reg);
+ 				scalar_zext32(scalar_of(dst_reg));
  				reg_bounds_sync(dst_reg);
  			}
  		} else {
@@@ -18177,37 -18450,37 +18462,37 @@@ static void find_good_pkt_pointers(st=
ru
  	}));
  }
 =20
- static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_re=
g_state *reg2,
- 				u8 opcode, bool is_jmp32);
  /*
   * Learn more information about live branches by simulating refinement on=
 both branches.
-  * regs_refine_cond_op() is sound, so producing ill-formed register bound=
s for the branch means
+  * scalars_refine_cond_op() is sound, so producing ill-formed register bo=
unds for the branch means
   * that branch is dead.
   */
  static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 =
opcode, bool is_jmp32)
  {
  	/* Fallthrough (FALSE) branch */
- 	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, bpf_rev_opcode(o=
pcode), is_jmp32);
+ 	scalars_refine_cond_op(scalar_of(&env->false_reg1), scalar_of(&env->fals=
e_reg2),
+ 			       bpf_rev_opcode(opcode), is_jmp32);
  	reg_bounds_sync(&env->false_reg1);
  	reg_bounds_sync(&env->false_reg2);
+ 	/* Jump (TRUE) branch. If FALSE is dead refine_live_branch() takes these=
 registers. */
+ 	scalars_refine_cond_op(scalar_of(&env->true_reg1), scalar_of(&env->true_=
reg2), opcode,
+ 			       is_jmp32);
+ 	reg_bounds_sync(&env->true_reg1);
+ 	reg_bounds_sync(&env->true_reg2);
  	/*
  	 * If there is a range bounds violation in *any* of the abstract values =
in either
  	 * reg_states in the FALSE branch (i.e. reg1, reg2), the FALSE branch mu=
st be dead. Only
  	 * TRUE branch will be taken.
  	 */
- 	if (range_bounds_violation(&env->false_reg1) || range_bounds_violation(&=
env->false_reg2))
+ 	if (reg_is_empty(&env->false_reg1) || reg_is_empty(&env->false_reg2))
  		return 1;
 =20
- 	/* Jump (TRUE) branch */
- 	regs_refine_cond_op(&env->true_reg1, &env->true_reg2, opcode, is_jmp32);
- 	reg_bounds_sync(&env->true_reg1);
- 	reg_bounds_sync(&env->true_reg2);
  	/*
  	 * If there is a range bounds violation in *any* of the abstract values =
in either
  	 * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the TRUE b=
ranch must be dead.
  	 * Only FALSE branch will be taken.
  	 */
- 	if (range_bounds_violation(&env->true_reg1) || range_bounds_violation(&e=
nv->true_reg2))
+ 	if (reg_is_empty(&env->true_reg1) || reg_is_empty(&env->true_reg2))
  		return 0;
 =20
  	/* Both branches are possible, we can't determine which one will be take=
n. */
@@@ -18447,6 -18720,18 +18732,18 @@@ static int is_branch_taken(struct bpf_v
  	if (reg_is_pkt_pointer_any(reg1) && reg_is_pkt_pointer_any(reg2) && !is_=
jmp32)
  		return is_pkt_ptr_branch_taken(reg1, reg2, opcode);
 =20
+ 	/* Two pointers to one object have the order of their offsets */
+ 	if (reg1->type !=3D SCALAR_VALUE && !is_jmp32 && opcode !=3D BPF_JSET &&=
 env->bypass_spec_v1 &&
+ 	    !(reg1->type & PTR_UNTRUSTED) && bpf_same_memory_origin(reg1, reg2))=
 {
+ 		/* an object can be at a low address, but not in the first page */
+ 		struct cnum64 lim =3D cnum64_from_srange(opcode =3D=3D BPF_JEQ || opcod=
e =3D=3D BPF_JNE ?
+ 						       -BPF_MAX_VAR_OFF : -SZ_4K, BPF_MAX_VAR_OFF);
+=20
+ 		if (!cnum64_is_subset(lim, reg1->r64) || !cnum64_is_subset(lim, reg2->r=
64))
+ 			return -1;
+ 		return is_scalar_branch_taken(env, reg1, reg2, bpf_signed_opcode(opcode=
), false);
+ 	}
+=20
  	if (__is_pointer_value(false, reg1) || __is_pointer_value(false, reg2)) {
  		u64 val;
 =20
@@@ -18472,7 -18757,7 +18769,7 @@@
  		/* If pointer is valid tests against zero will fail so we can
  		 * use this to direct branch taken.
  		 */
- 		val =3D reg_const_value(reg2, is_jmp32);
+ 		val =3D scalar_const_value(scalar_of(reg2), is_jmp32);
  		if (val !=3D 0)
  			return -1;
 =20
@@@ -18515,9 -18800,8 +18812,8 @@@ u8 bpf_rev_opcode(u8 opcode
  	}
  }
 =20
- /* Refine range knowledge for <reg1> <op> <reg>2 conditional operation. */
- static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_re=
g_state *reg2,
- 				u8 opcode, bool is_jmp32)
+ /* Refine range knowledge for <a> <op> <b> conditional operation. */
+ void scalars_refine_cond_op(struct scalar *a, struct scalar *b, u8 opcode=
, bool is_jmp32)
  {
  	struct tnum t;
  	u64 val;
@@@ -18529,7 -18813,7 +18825,7 @@@
  	case BPF_JSGE:
  	case BPF_JSGT:
  		opcode =3D bpf_flip_opcode(opcode);
- 		swap(reg1, reg2);
+ 		swap(a, b);
  		break;
  	default:
  		break;
@@@ -18538,44 -18822,44 +18834,44 @@@
  	switch (opcode) {
  	case BPF_JEQ:
  		if (is_jmp32) {
- 			reg1->r32 =3D cnum32_intersect(reg1->r32, reg2->r32);
- 			reg2->r32 =3D reg1->r32;
+ 			a->r32 =3D cnum32_intersect(a->r32, b->r32);
+ 			b->r32 =3D a->r32;
 =20
- 			t =3D tnum_intersect(tnum_subreg(reg1->var_off), tnum_subreg(reg2->var=
_off));
- 			reg1->var_off =3D tnum_with_subreg(reg1->var_off, t);
- 			reg2->var_off =3D tnum_with_subreg(reg2->var_off, t);
+ 			t =3D tnum_intersect(tnum_subreg(a->var_off), tnum_subreg(b->var_off));
+ 			a->var_off =3D tnum_with_subreg(a->var_off, t);
+ 			b->var_off =3D tnum_with_subreg(b->var_off, t);
  		} else {
- 			reg1->r64 =3D cnum64_intersect(reg1->r64, reg2->r64);
- 			reg2->r64 =3D reg1->r64;
+ 			a->r64 =3D cnum64_intersect(a->r64, b->r64);
+ 			b->r64 =3D a->r64;
 =20
- 			reg1->var_off =3D tnum_intersect(reg1->var_off, reg2->var_off);
- 			reg2->var_off =3D reg1->var_off;
+ 			a->var_off =3D tnum_intersect(a->var_off, b->var_off);
+ 			b->var_off =3D a->var_off;
  		}
  		break;
  	case BPF_JNE:
- 		if (!is_reg_const(reg2, is_jmp32))
- 			swap(reg1, reg2);
- 		if (!is_reg_const(reg2, is_jmp32))
+ 		if (!scalar_is_const(b, is_jmp32))
+ 			swap(a, b);
+ 		if (!scalar_is_const(b, is_jmp32))
  			break;
 =20
- 		/* try to recompute the bound of reg1 if reg2 is a const and
- 		 * is exactly the edge of reg1.
+ 		/* try to recompute the bound of a if b is a const and
+ 		 * is exactly the edge of a.
  		 */
- 		val =3D reg_const_value(reg2, is_jmp32);
+ 		val =3D scalar_const_value(b, is_jmp32);
  		if (is_jmp32) {
  			/* Complement of the range [val, val] as cnum32. */
- 			cnum32_intersect_with(&reg1->r32, (struct cnum32){ val + 1, U32_MAX - =
1 });
+ 			cnum32_intersect_with(&a->r32, (struct cnum32){ val + 1, U32_MAX - 1 }=
);
  		} else {
  			/* Complement of the range [val, val] as cnum64. */
- 			cnum64_intersect_with(&reg1->r64, (struct cnum64){ val + 1, U64_MAX - =
1 });
+ 			cnum64_intersect_with(&a->r64, (struct cnum64){ val + 1, U64_MAX - 1 }=
);
  		}
  		break;
  	case BPF_JSET:
- 		if (!is_reg_const(reg2, is_jmp32))
- 			swap(reg1, reg2);
- 		if (!is_reg_const(reg2, is_jmp32))
+ 		if (!scalar_is_const(b, is_jmp32))
+ 			swap(a, b);
+ 		if (!scalar_is_const(b, is_jmp32))
  			break;
- 		val =3D reg_const_value(reg2, is_jmp32);
+ 		val =3D scalar_const_value(b, is_jmp32);
  		/* BPF_JSET (i.e., TRUE branch, *not* BPF_JSET | BPF_X)
  		 * requires single bit to learn something useful. E.g., if we
  		 * know that `r1 & 0x3` is true, then which bits (0, 1, or both)
@@@ -18589,64 -18873,64 +18885,64 @@@
  		if (hweight64(val) !=3D 1)
  			break;
  		if (is_jmp32) {
- 			t =3D tnum_or(tnum_subreg(reg1->var_off), tnum_const(val));
- 			reg1->var_off =3D tnum_with_subreg(reg1->var_off, t);
+ 			t =3D tnum_or(tnum_subreg(a->var_off), tnum_const(val));
+ 			a->var_off =3D tnum_with_subreg(a->var_off, t);
  		} else {
- 			reg1->var_off =3D tnum_or(reg1->var_off, tnum_const(val));
+ 			a->var_off =3D tnum_or(a->var_off, tnum_const(val));
  		}
  		break;
  	case BPF_JSET | BPF_X: /* reverse of BPF_JSET, see bpf_rev_opcode() */
- 		if (!is_reg_const(reg2, is_jmp32))
- 			swap(reg1, reg2);
- 		if (!is_reg_const(reg2, is_jmp32))
+ 		if (!scalar_is_const(b, is_jmp32))
+ 			swap(a, b);
+ 		if (!scalar_is_const(b, is_jmp32))
  			break;
- 		val =3D reg_const_value(reg2, is_jmp32);
+ 		val =3D scalar_const_value(b, is_jmp32);
  		/* Forget the ranges before narrowing tnums, to avoid invariant
  		 * violations if we're on a dead branch.
  		 */
- 		__mark_reg_unbounded(reg1);
- 		reg_step_reset(reg1);
+ 		__mark_scalar_unbounded(a);
+ 		scalar_step_reset(a);
  		if (is_jmp32) {
- 			t =3D tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
- 			reg1->var_off =3D tnum_with_subreg(reg1->var_off, t);
+ 			t =3D tnum_and(tnum_subreg(a->var_off), tnum_const(~val));
+ 			a->var_off =3D tnum_with_subreg(a->var_off, t);
  		} else {
- 			reg1->var_off =3D tnum_and(reg1->var_off, tnum_const(~val));
+ 			a->var_off =3D tnum_and(a->var_off, tnum_const(~val));
  		}
  		break;
  	case BPF_JLE:
  		if (is_jmp32) {
- 			cnum32_intersect_with_urange(&reg1->r32, 0, reg_u32_max(reg2));
- 			cnum32_intersect_with_urange(&reg2->r32, reg_u32_min(reg1), U32_MAX);
+ 			cnum32_intersect_with_urange(&a->r32, 0, cnum32_umax(b->r32));
+ 			cnum32_intersect_with_urange(&b->r32, cnum32_umin(a->r32), U32_MAX);
  		} else {
- 			cnum64_intersect_with_urange(&reg1->r64, 0, reg_umax(reg2));
- 			cnum64_intersect_with_urange(&reg2->r64, reg_umin(reg1), U64_MAX);
+ 			cnum64_intersect_with_urange(&a->r64, 0, cnum64_umax(b->r64));
+ 			cnum64_intersect_with_urange(&b->r64, cnum64_umin(a->r64), U64_MAX);
  		}
  		break;
  	case BPF_JLT:
  		if (is_jmp32) {
- 			cnum32_intersect_with_urange(&reg1->r32, 0, reg_u32_max(reg2) - 1);
- 			cnum32_intersect_with_urange(&reg2->r32, reg_u32_min(reg1) + 1, U32_MA=
X);
+ 			cnum32_intersect_with_urange(&a->r32, 0, cnum32_umax(b->r32) - 1);
+ 			cnum32_intersect_with_urange(&b->r32, cnum32_umin(a->r32) + 1, U32_MAX=
);
  		} else {
- 			cnum64_intersect_with_urange(&reg1->r64, 0, reg_umax(reg2) - 1);
- 			cnum64_intersect_with_urange(&reg2->r64, reg_umin(reg1) + 1, U64_MAX);
+ 			cnum64_intersect_with_urange(&a->r64, 0, cnum64_umax(b->r64) - 1);
+ 			cnum64_intersect_with_urange(&b->r64, cnum64_umin(a->r64) + 1, U64_MAX=
);
  		}
  		break;
  	case BPF_JSLE:
  		if (is_jmp32) {
- 			cnum32_intersect_with_srange(&reg1->r32, S32_MIN, reg_s32_max(reg2));
- 			cnum32_intersect_with_srange(&reg2->r32, reg_s32_min(reg1), S32_MAX);
+ 			cnum32_intersect_with_srange(&a->r32, S32_MIN, cnum32_smax(b->r32));
+ 			cnum32_intersect_with_srange(&b->r32, cnum32_smin(a->r32), S32_MAX);
  		} else {
- 			cnum64_intersect_with_srange(&reg1->r64, S64_MIN, reg_smax(reg2));
- 			cnum64_intersect_with_srange(&reg2->r64, reg_smin(reg1), S64_MAX);
+ 			cnum64_intersect_with_srange(&a->r64, S64_MIN, cnum64_smax(b->r64));
+ 			cnum64_intersect_with_srange(&b->r64, cnum64_smin(a->r64), S64_MAX);
  		}
  		break;
  	case BPF_JSLT:
  		if (is_jmp32) {
- 			cnum32_intersect_with_srange(&reg1->r32, S32_MIN, reg_s32_max(reg2) - =
1);
- 			cnum32_intersect_with_srange(&reg2->r32, reg_s32_min(reg1) + 1, S32_MA=
X);
+ 			cnum32_intersect_with_srange(&a->r32, S32_MIN, cnum32_smax(b->r32) - 1=
);
+ 			cnum32_intersect_with_srange(&b->r32, cnum32_smin(a->r32) + 1, S32_MAX=
);
  		} else {
- 			cnum64_intersect_with_srange(&reg1->r64, S64_MIN, reg_smax(reg2) - 1);
- 			cnum64_intersect_with_srange(&reg2->r64, reg_smin(reg1) + 1, S64_MAX);
+ 			cnum64_intersect_with_srange(&a->r64, S64_MIN, cnum64_smax(b->r64) - 1=
);
+ 			cnum64_intersect_with_srange(&b->r64, cnum64_smin(a->r64) + 1, S64_MAX=
);
  		}
  		break;
  	default:
@@@ -18686,7 -18970,7 +18982,7 @@@ static void mark_ptr_or_null_reg(struc
  		if (is_null) {
  			/* We don't need id from this point
  			 * onwards anymore, thus we should better reset it,
- 			 * so that state pruning has chances to take effect.
+ 			 * so that states have chances to be equal.
  			 */
  			__mark_reg_known_zero(reg);
  			reg->type =3D SCALAR_VALUE;
@@@ -18718,7 -19002,7 +19014,7 @@@ static void mark_ptr_or_null_regs(struc
  		 * No one could have freed the reference state before
  		 * doing the NULL check.
  		 */
- 		WARN_ON_ONCE(__release_reference_nomark(vstate, id));
+ 		WARN_ON_ONCE(release_reference_nomark(vstate, id));
 =20
  	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
  		mark_ptr_or_null_reg(state, reg, id, is_null);
@@@ -18830,130 -19114,164 +19126,164 @@@ static bool try_match_pkt_pointers=
(cons
  	return true;
  }
 =20
- static void __collect_linked_regs(struct linked_regs *reg_set, struct bpf=
_reg_state *reg,
- 				  u32 id, u32 frameno, u32 spi_or_reg, bool is_reg)
+ /* a =3D=3D b (mod 2^N) implies a =3D=3D b if both fit in uN or both fit =
in sN. N is @bits. */
+ bool scalars_fit_in_bits(const struct scalar *a, const struct scalar *b, =
u32 bits)
  {
- 	struct linked_reg *e;
+ 	u64 umax =3D GENMASK_ULL(bits - 1, 0);
+ 	s64 smax =3D umax >> 1;
 =20
- 	if (reg->type !=3D SCALAR_VALUE || (reg->id & ~BPF_ADD_CONST) !=3D id)
- 		return;
+ 	return (cnum64_umax(a->r64) <=3D umax && cnum64_umax(b->r64) <=3D umax) =
||
+ 	       (cnum64_smin(a->r64) >=3D -smax - 1 && cnum64_smax(a->r64) <=3D s=
max &&
+ 		cnum64_smin(b->r64) >=3D -smax - 1 && cnum64_smax(b->r64) <=3D smax);
+ }
 =20
- 	e =3D linked_regs_push(reg_set);
- 	if (e) {
- 		e->frameno =3D frameno;
- 		e->is_reg =3D is_reg;
- 		e->regno =3D spi_or_reg;
+ /*
+  * The values of @dst and @src are equal in their low @bits bits: @dst be=
comes the intersection.
+  * Fewer than 32 bits say nothing about a range. Returns false if the int=
ersection is empty.
+  * Then no execution gets here with these values, and @dst does not chang=
e.
+  */
+ bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 b=
its)
+ {
+ 	struct tnum a =3D dst->var_off, b =3D src->var_off;
+ 	struct scalar s =3D *dst;
+=20
+ 	if (scalars_fit_in_bits(dst, src, bits))
+ 		bits =3D 64;
+ 	if (bits < 64)
+ 		b =3D tnum_or(tnum_cast(b, bits / BITS_PER_BYTE), tnum_lshift(tnum_unkn=
own, bits));
+ 	/* tnum_intersect() of two tnums that don't overlap is not empty */
+ 	if (!tnum_overlap(a, b))
+ 		return false;
+ 	s.var_off =3D tnum_intersect(a, b);
+ 	/*
+ 	 * Equal in 64 bits is equal in the low 32 bits too. 'if w1 s> 200' on a=
 zero extended int
+ 	 * refines nothing but the 32-bit range.
+ 	 */
+ 	if (bits >=3D 32)
+ 		s.r32 =3D cnum32_intersect(dst->r32, src->r32);
+ 	if (bits =3D=3D 64) {
+ 		s.r64 =3D cnum64_intersect(dst->r64, src->r64);
+ 		if (src->step % dst->step =3D=3D 0) {
+ 			if (src->base % dst->step !=3D dst->base)
+ 				return false;
+ 			s.step =3D src->step;
+ 			s.base =3D src->base;
+ 		}
+ 		s.r64 =3D cnum64_intersect_linear(s.r64, s.base, s.step);
+ 	}
+ 	scalar_bounds_sync(&s);
+ 	if (scalar_is_empty(&s) || const_tnum_range_mismatch(&s) ||
+ 	    const_tnum_range_mismatch_32(&s))
+ 		return false;
+ 	*dst =3D s;
+ 	return true;
+ }
+=20
+ /*
+  * One branch of the jump @insn is dead, the current state takes the othe=
r one. @reg1 and @reg2 are
+  * the operands as that branch refines them. They hold every value that t=
akes it, whether the other
+  * branch is dead or not.
+  */
+ static int refine_live_branch(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
+ 			      struct bpf_reg_state *reg1, struct bpf_reg_state *reg2)
+ {
+ 	struct bpf_reg_state *regs =3D cur_regs(env);
+ 	bool empty;
+ 	int err;
+=20
+ 	/* is_branch_taken() knew the branch before it refined anything */
+ 	if (reg_value_equal(reg1, &regs[insn->dst_reg]) &&
+ 	    (BPF_SRC(insn->code) =3D=3D BPF_K || reg_value_equal(reg2, &regs[ins=
n->src_reg])))
+ 		return 0;
+ 	/*
+ 	 * The fall-through branch of JSET forgets the ranges. Or this branch is=
 dead too: the path
+ 	 * is infeasible. The registers are left as they are.
+ 	 */
+ 	empty =3D reg_is_empty(reg1) || reg_is_empty(reg2);
+ 	env->cur_state->infeasible |=3D empty;
+ 	if (BPF_OP(insn->code) =3D=3D BPF_JSET || empty)
+ 		return 0;
+ 	err =3D reg_bounds_sanity_check(env, reg1, "live_reg1");
+ 	err =3D err ?: reg_bounds_sanity_check(env, reg2, "live_reg2");
+ 	if (err)
+ 		return err;
+=20
+ 	regs[insn->dst_reg] =3D *reg1;
+ 	if (BPF_SRC(insn->code) =3D=3D BPF_X)
+ 		regs[insn->src_reg] =3D *reg2;
+ 	return 0;
+ }
+=20
+ /* How many values of @reg are before the end of the order of @insn? 0 if=
 all of them are. */
+ static u64 values_to_end(const struct bpf_insn *insn, const struct bpf_re=
g_state *reg)
+ {
+ 	u8 op =3D BPF_OP(insn->code);
+ 	bool sign =3D op =3D=3D BPF_JSGT || op =3D=3D BPF_JSGE || op =3D=3D BPF_=
JSLT || op =3D=3D BPF_JSLE;
+ 	u64 first =3D sign ? S64_MIN : 0;
+ 	u32 cnt32 =3D (first >> 32) - reg->r32.base;
+ 	u64 cnt =3D first - reg->r64.base;
+=20
+ 	if (BPF_CLASS(insn->code) =3D=3D BPF_JMP32)
+ 		return cnt32 <=3D reg->r32.size && reg->r32.size !=3D U32_MAX ? cnt32 :=
 0;
+ 	return cnt <=3D reg->r64.size && reg->r64.size !=3D U64_MAX ? cnt : 0;
+ }
+=20
+ /*
+  * A jump can cut a range in two: 'x u>=3D 3' leaves -4..-1 and 3 of -4..=
3. One range has both and
+  * all values between them. So a state that knows less is proven where th=
is one is not.
+  * Do the jump for the values before the end of the order, then again for=
 the values after it.
+  * Returns 1 if the current state has fewer values now.
+  */
+ static int cut_range(struct bpf_verifier_env *env, const struct bpf_insn =
*insn, u32 regno,
+ 		     const struct bpf_reg_state *taken, const struct bpf_reg_state *not=
_taken)
+ {
+ 	struct bpf_verifier_state *st =3D env->cur_state, *other;
+ 	struct bpf_reg_state *reg =3D &cur_regs(env)[regno], front =3D *reg, bac=
k =3D *reg;
+ 	u64 cnt =3D values_to_end(insn, reg);
+ 	u8 op =3D BPF_OP(insn->code);
+ 	const struct bpf_reg_state *equal =3D op =3D=3D BPF_JEQ ? taken : not_ta=
ken;
+=20
+ 	/* 'x !=3D 0' is 'x u> 0' */
+ 	if ((op =3D=3D BPF_JEQ || op =3D=3D BPF_JNE) && !tnum_equals_const(tnum_=
subreg(equal->var_off), 0))
+ 		return 0;
+ 	if (op =3D=3D BPF_JSET || reg->type !=3D SCALAR_VALUE || !cnt ||
+ 	    !(values_to_end(insn, taken) || values_to_end(insn, not_taken)))
+ 		return 0;
+ 	env->imprecise |=3D !env->err;
+ 	if (!env->path_sensitive && !bpf_xreg_in_deps(env, st, st->curframe, reg=
no))
+ 		return 0;
+ 	if (BPF_CLASS(insn->code) =3D=3D BPF_JMP32) {
+ 		front.r32.size =3D cnt - 1;
+ 		back.r32.base +=3D cnt;
+ 		back.r32.size -=3D cnt;
  	} else {
- 		clear_scalar_id(reg);
- 	}
- }
-=20
- /* For all R being scalar registers or spilled scalar registers
-  * in verifier state, save R in linked_regs if R->id =3D=3D id.
-  * If there are too many Rs sharing same id, reset id for leftover Rs.
-  */
- static void collect_linked_regs(struct bpf_verifier_env *env,
- 				struct bpf_verifier_state *vstate,
- 				u32 id,
- 				struct linked_regs *linked_regs)
- {
- 	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
- 	struct bpf_func_state *func;
- 	struct bpf_reg_state *reg;
- 	u16 live_regs;
- 	int i, j;
-=20
- 	id =3D id & ~BPF_ADD_CONST;
- 	for (i =3D vstate->curframe; i >=3D 0; i--) {
- 		live_regs =3D aux[bpf_frame_insn_idx(vstate, i)].live_regs_before;
- 		func =3D vstate->frame[i];
- 		for (j =3D 0; j < BPF_REG_FP; j++) {
- 			if (!(live_regs & BIT(j)))
- 				continue;
- 			reg =3D &func->regs[j];
- 			__collect_linked_regs(linked_regs, reg, id, i, j, true);
- 		}
- 		for (j =3D 0; j < bpf_stack_nr_slots(func); j++) {
- 			struct bpf_stack_state *ss =3D bpf_stack_slot(func, j);
-=20
- 			if (!bpf_is_spilled_reg(ss))
- 				continue;
- 			reg =3D &ss->spilled_ptr;
- 			__collect_linked_regs(linked_regs, reg, id, i, j, false);
- 		}
- 	}
- }
-=20
- /* For all R in linked_regs, copy known_reg range into R
-  * if R->id =3D=3D known_reg->id.
-  */
- static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_ver=
ifier_state *vstate,
- 			     struct bpf_reg_state *known_reg, struct linked_regs *linked_regs)
- {
- 	struct bpf_reg_state fake_reg;
- 	struct bpf_reg_state *reg;
- 	struct linked_reg *e;
- 	int i;
-=20
- 	for (i =3D 0; i < linked_regs->cnt; ++i) {
- 		e =3D &linked_regs->entries[i];
- 		reg =3D e->is_reg ? &vstate->frame[e->frameno]->regs[e->regno]
- 				: &bpf_stack_slot(vstate->frame[e->frameno], e->spi)->spilled_ptr;
- 		if (reg->type !=3D SCALAR_VALUE || reg =3D=3D known_reg)
- 			continue;
- 		if ((reg->id & ~BPF_ADD_CONST) !=3D (known_reg->id & ~BPF_ADD_CONST))
- 			continue;
- 		/*
- 		 * Skip mixed 32/64-bit links: the delta relationship doesn't
- 		 * hold across different ALU widths.
- 		 */
- 		if (((reg->id ^ known_reg->id) & BPF_ADD_CONST) =3D=3D BPF_ADD_CONST)
- 			continue;
- 		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
- 		    reg->delta =3D=3D known_reg->delta) {
- 			*reg =3D *known_reg;
- 		} else {
- 			s32 saved_off =3D reg->delta;
- 			u32 saved_id =3D reg->id;
-=20
- 			fake_reg.type =3D SCALAR_VALUE;
- 			__mark_reg_known(&fake_reg, (s64)reg->delta - (s64)known_reg->delta);
-=20
- 			/* reg =3D known_reg; reg +=3D delta */
- 			*reg =3D *known_reg;
- 			/*
- 			 * Must preserve off and id, otherwise another sync_linked_regs()
- 			 * will be incorrect.
- 			 */
- 			reg->delta =3D saved_off;
- 			reg->id =3D saved_id;
-=20
- 			scalar_step_add(reg, reg, &fake_reg);
- 			scalar32_min_max_add(reg, &fake_reg);
- 			scalar_min_max_add(reg, &fake_reg);
- 			reg->var_off =3D tnum_add(reg->var_off, fake_reg.var_off);
- 			if ((reg->id | known_reg->id) & BPF_ADD_CONST32)
- 				zext_32_to_64(reg);
- 			reg_bounds_sync(reg);
- 		}
- 		if (e->is_reg)
- 			mark_reg_scratched(env, e->regno);
- 		else
- 			mark_stack_slot_scratched(env, e->spi);
+ 		front.r64.size =3D cnt - 1;
+ 		back.r64.base +=3D cnt;
+ 		back.r64.size -=3D cnt;
  	}
+ 	reg_bounds_sync(&front);
+ 	reg_bounds_sync(&back);
+ 	if (reg_is_empty(&front) || reg_is_empty(&back))
+ 		return 0;
+ 	other =3D push_stack(env, env->insn_idx, env->insn_idx, false);
+ 	if (IS_ERR(other))
+ 		return PTR_ERR(other);
+ 	env->head->again =3D true;
+ 	other->frame[other->curframe]->regs[regno] =3D back;
+ 	*reg =3D front;
+ 	return 1;
  }
 =20
  static int check_cond_jmp_op(struct bpf_verifier_env *env,
  			     struct bpf_insn *insn, int *insn_idx)
  {
+ 	struct cnum64 near =3D cnum64_from_srange(-MAX_PACKET_OFF, 2 * MAX_PACKE=
T_OFF);
  	struct bpf_verifier_state *this_branch =3D env->cur_state;
  	struct bpf_verifier_state *other_branch;
  	struct bpf_reg_state *regs =3D this_branch->frame[this_branch->curframe]=
->regs;
  	struct bpf_reg_state *dst_reg, *other_branch_regs, *src_reg =3D NULL;
  	struct bpf_reg_state *eq_branch_regs;
- 	struct linked_regs linked_regs =3D {};
  	u8 opcode =3D BPF_OP(insn->code);
- 	int insn_flags =3D 0;
  	bool is_jmp32;
  	int pred =3D -1;
  	int err;
@@@ -18982,19 -19300,14 +19312,14 @@@
  	}
 =20
  	if (opcode =3D=3D BPF_JCOND) {
- 		struct bpf_verifier_state *cur_st =3D env->cur_state, *queued_st, *prev=
_st;
+ 		struct bpf_verifier_state *queued_st;
  		int idx =3D *insn_idx;
 =20
- 		prev_st =3D find_prev_entry(env, cur_st->parent, idx);
-=20
  		/* branch out 'fallthrough' insn as a new state to explore */
  		queued_st =3D push_stack(env, idx + 1, idx, false);
  		if (IS_ERR(queued_st))
  			return PTR_ERR(queued_st);
 =20
- 		queued_st->may_goto_depth++;
- 		if (prev_st)
- 			widen_imprecise_scalars(env, prev_st, queued_st);
  		*insn_idx +=3D insn->off;
  		return 0;
  	}
@@@ -19012,62 -19325,31 +19337,31 @@@
  			return err;
 =20
  		src_reg =3D &regs[insn->src_reg];
- 		if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg=
)) &&
+ 		/* A header and a 16-bit length fit. If a pointer wraps, it leaks the a=
ddress. */
+ 		if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg=
) &&
+ 		      cnum64_is_subset(near, dst_reg->r64) &&
+ 		      cnum64_is_subset(near, src_reg->r64)) &&
  		    is_pointer_value(env, insn->src_reg)) {
  			verbose(env, "R%d pointer comparison prohibited\n",
  				insn->src_reg);
  			return -EACCES;
  		}
 =20
- 		if (src_reg->type =3D=3D PTR_TO_STACK)
- 			insn_flags |=3D INSN_F_SRC_REG_STACK;
- 		if (dst_reg->type =3D=3D PTR_TO_STACK)
- 			insn_flags |=3D INSN_F_DST_REG_STACK;
  	} else {
  		src_reg =3D &env->fake_reg[0];
  		memset(src_reg, 0, sizeof(*src_reg));
  		src_reg->type =3D SCALAR_VALUE;
  		__mark_reg_known(src_reg, insn->imm);
-=20
- 		if (dst_reg->type =3D=3D PTR_TO_STACK)
- 			insn_flags |=3D INSN_F_DST_REG_STACK;
  	}
 =20
- 	if (insn_flags) {
- 		err =3D bpf_push_jmp_history(env, this_branch, insn_flags, 0, 0, NULL, =
0);
- 		if (err)
- 			return err;
- 	}
-=20
- 	/*
- 	 * Collect the linked registers before env->{true,false}_reg{1,2} setup,
- 	 * otherwise ids dropped by collect_linked_regs() would be resurrected
- 	 * when env->{true,false}_reg{1,2} are copied back.
- 	 */
- 	if (BPF_SRC(insn->code) =3D=3D BPF_X && src_reg->type =3D=3D SCALAR_VALU=
E && src_reg->id)
- 		collect_linked_regs(env, this_branch, src_reg->id, &linked_regs);
- 	if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
- 		collect_linked_regs(env, this_branch, dst_reg->id, &linked_regs);
-=20
  	is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
+ again:
  	env->false_reg1 =3D *dst_reg;
  	env->false_reg2 =3D *src_reg;
  	env->true_reg1 =3D *dst_reg;
  	env->true_reg2 =3D *src_reg;
+ 	bpf_collect_iv_thresholds(env);
  	pred =3D is_branch_taken(env, dst_reg, src_reg, opcode, is_jmp32);
- 	if (pred >=3D 0) {
- 		/* If we get here with a dst_reg pointer type it is because
- 		 * above is_branch_taken() special cased the 0 comparison.
- 		 */
- 		if (!__is_pointer_value(false, dst_reg))
- 			err =3D mark_chain_precision(env, insn->dst_reg);
- 		if (BPF_SRC(insn->code) =3D=3D BPF_X && !err &&
- 		    !__is_pointer_value(false, src_reg))
- 			err =3D mark_chain_precision(env, insn->src_reg);
- 		if (err)
- 			return err;
- 	}
-=20
  	if (pred =3D=3D 1) {
  		/* Only follow the goto, ignore fall-through. If needed, push
  		 * the fall-through branch for simulation under speculative
@@@ -19078,6 -19360,10 +19372,10 @@@
  			if (err < 0)
  				return err;
  		}
+ 		err =3D refine_live_branch(env, insn, &env->true_reg1, &env->true_reg2);
+ 		if (err)
+ 			return err;
+ 		bpf_equations_jump(env, this_branch, *insn_idx, true);
  		if (env->log.level & BPF_LOG_LEVEL)
  			print_insn_state(env, this_branch, this_branch->curframe);
  		*insn_idx +=3D insn->off;
@@@ -19093,24 -19379,22 +19391,22 @@@
  			if (err < 0)
  				return err;
  		}
+ 		err =3D refine_live_branch(env, insn, &env->false_reg1, &env->false_reg=
2);
+ 		if (err)
+ 			return err;
+ 		bpf_equations_jump(env, this_branch, *insn_idx, false);
  		if (env->log.level & BPF_LOG_LEVEL)
  			print_insn_state(env, this_branch, this_branch->curframe);
  		return 0;
  	}
 =20
- 	/* Push scalar registers sharing same ID to jump history,
- 	 * do this before creating 'other_branch', so that both
- 	 * 'this_branch' and 'other_branch' share this history
- 	 * if parent state is created.
- 	 */
- 	if (linked_regs.cnt > 1) {
- 		u16 packed[LINKED_REGS_MAX];
-=20
- 		linked_regs_pack(&linked_regs, packed);
- 		err =3D bpf_push_jmp_history(env, this_branch, 0, 0, 0, packed, linked_=
regs.cnt);
- 		if (err)
- 			return err;
- 	}
+ 	err =3D cut_range(env, insn, insn->dst_reg, &env->true_reg1, &env->false=
_reg1);
+ 	if (!err && BPF_SRC(insn->code) =3D=3D BPF_X)
+ 		err =3D cut_range(env, insn, insn->src_reg, &env->true_reg2, &env->fals=
e_reg2);
+ 	if (err > 0)
+ 		goto again;
+ 	if (err)
+ 		return err;
 =20
  	other_branch =3D push_stack(env, *insn_idx + insn->off + 1, *insn_idx, f=
alse);
  	if (IS_ERR(other_branch))
@@@ -19127,20 -19411,6 +19423,6 @@@
  	if (BPF_SRC(insn->code) =3D=3D BPF_X)
  		other_branch_regs[insn->src_reg] =3D env->true_reg2;
 =20
- 	if (BPF_SRC(insn->code) =3D=3D BPF_X &&
- 	    src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
- 	    !WARN_ON_ONCE(src_reg->id !=3D other_branch_regs[insn->src_reg].id))=
 {
- 		sync_linked_regs(env, this_branch, src_reg, &linked_regs);
- 		sync_linked_regs(env, other_branch, &other_branch_regs[insn->src_reg],
- 				 &linked_regs);
- 	}
- 	if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id &&
- 	    !WARN_ON_ONCE(dst_reg->id !=3D other_branch_regs[insn->dst_reg].id))=
 {
- 		sync_linked_regs(env, this_branch, dst_reg, &linked_regs);
- 		sync_linked_regs(env, other_branch, &other_branch_regs[insn->dst_reg],
- 				 &linked_regs);
- 	}
-=20
  	/* if one pointer register is compared to another pointer
  	 * register check if PTR_MAYBE_NULL could be lifted.
  	 * E.g. register A - maybe null
@@@ -19189,15 -19459,6 +19471,6 @@@
  	    type_may_be_null(dst_reg->type) &&
  	    ((BPF_SRC(insn->code) =3D=3D BPF_K && insn->imm =3D=3D 0) ||
  	     (BPF_SRC(insn->code) =3D=3D BPF_X && bpf_register_is_null(src_reg))=
)) {
- 		/*
- 		 * For BPF_X the zero is a property of this execution path,
- 		 * hence src_reg has to be precise.
- 		 */
- 		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
- 			err =3D mark_chain_precision(env, insn->src_reg);
- 			if (err)
- 				return err;
- 		}
  		/* Mark all identical registers in each branch as either
  		 * safe or unknown depending R =3D=3D 0 or R !=3D 0 conditional.
  		 */
@@@ -19212,6 -19473,9 +19485,9 @@@
  			insn->dst_reg);
  		return -EACCES;
  	}
+ 	/* last: the code above takes the operands of one branch for both */
+ 	bpf_equations_jump(env, this_branch, *insn_idx, false);
+ 	bpf_equations_jump(env, other_branch, *insn_idx, true);
  	if (env->log.level & BPF_LOG_LEVEL)
  		print_insn_state(env, this_branch, this_branch->curframe);
  	return 0;
@@@ -19304,8 -19568,7 +19580,7 @@@ static int check_ld_imm(struct bpf_veri
  	if (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE ||
  	    insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE) {
  		if (map->map_type =3D=3D BPF_MAP_TYPE_ARENA) {
- 			__mark_reg_unknown(env, dst_reg);
- 			dst_reg->map_ptr =3D map;
+ 			bpf_mark_reg_unknown(dst_reg);
  			bpf_diag_mod_end(env);
  			return 0;
  		}
@@@ -19587,6 -19850,64 +19862,64 @@@ static bool program_returns_void(struc
  	return false;
  }
 =20
+ static bool fmodret_retval_allowed(const char *list, s64 value)
+ {
+ 	char *end;
+=20
+ 	if (!value)
+ 		return true;
+ 	for (; *list; list =3D *end ? end + 1 : end) {
+ 		if (simple_strtoll(list, &end, 10) =3D=3D value)
+ 			return true;
+ 	}
+ 	return false;
+ }
+=20
+ /*
+  * The build tags the functions which return errors: "bpf_fmodret_retval:=
-22,-12",
+  * see tools/bpf/resolve_btfids/fmodret.c. An fmod_ret program can attach=
 to such
+  * a function. A caller can get each of these errors today: the function =
returns
+  * them itself. So the program must return one of them, or 0 to call the =
function.
+  */
+ static int check_fmodret_retval(struct bpf_verifier_env *env, int regno,
+ 				const char *exit_ctx, const char *reg_name)
+ {
+ 	const struct bpf_prog_aux *aux =3D env->prog->aux;
+ 	struct bpf_reg_state *reg =3D reg_state(env, regno);
+ 	s64 smin =3D reg_smin(reg), smax =3D reg_smax(reg), v;
+ 	const struct btf_type *t;
+=20
+ 	if (reg->type !=3D SCALAR_VALUE) {
+ 		verbose(env, "%s the register %s is not a known value (%s)\n",
+ 			exit_ctx, reg_name, reg_type_str(env, reg->type));
+ 		return -EINVAL;
+ 	}
+=20
+ 	/*
+ 	 * "w0 =3D -22" zero-extends. The trampoline sign-extends the low 32 bit=
s of
+ 	 * the value for an int function, so its caller sees -22. The low 32 bits
+ 	 * decide if the high ones are 0. Else the 64 bits have to be in the lis=
t.
+ 	 *
+ 	 * The trampolines of x86-64, arm64 and s390x do that: look here before
+ 	 * another architecture is added to CONFIG_BPF_FMODRET_SCAN.
+ 	 */
+ 	t =3D btf_type_skip_modifiers(aux->attach_btf, aux->attach_func_proto->t=
ype, NULL);
+ 	if (t->size =3D=3D 4 && reg_umax(reg) <=3D U32_MAX) {
+ 		smin =3D reg_s32_min(reg);
+ 		smax =3D reg_s32_max(reg);
+ 	}
+=20
+ 	/* Stops at the first value which is not in the list, however wide the r=
ange is */
+ 	for (v =3D smin; v <=3D smax; v++) {
+ 		if (!fmodret_retval_allowed(env->fmodret_retvals, v)) {
+ 			verbose(env, "%s the register %s should be 0 or one of %s\n",
+ 				exit_ctx, reg_name, env->fmodret_retvals);
+ 			return -EINVAL;
+ 		}
+ 	}
+ 	return 0;
+ }
+=20
  static int check_return_code(struct bpf_verifier_env *env, int regno, con=
st char *reg_name)
  {
  	const char *exit_ctx =3D "At program exit";
@@@ -19608,8 -19929,7 +19941,8 @@@
  		 * matches the operator's return type and is in its unmodified
  		 * form. A scalar zero (i.e., a null pointer) is also allowed.
  		 */
 -		reg_type =3D reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
 +		reg_type =3D base_type(reg->type) =3D=3D PTR_TO_BTF_ID ?
 +			   btf_type_by_id(reg->btf, reg->btf_id) : NULL;
  		ret_type =3D btf_type_resolve_ptr(prog->aux->attach_btf,
  						prog->aux->attach_func_proto->type,
  						NULL);
@@@ -19644,6 -19964,9 +19977,9 @@@
  	if (prog_type =3D=3D BPF_PROG_TYPE_CGROUP_SKB && (env->prog->expected_at=
tach_type =3D=3D BPF_CGROUP_INET_EGRESS))
  		enforce_attach_type_range =3D tnum_range(2, 3);
 =20
+ 	if (env->fmodret_retvals)
+ 		return check_fmodret_retval(env, regno, exit_ctx, reg_name);
+=20
  	if (!return_retval_range(env, &range))
  		return 0;
 =20
@@@ -19654,10 -19977,6 +19990,6 @@@ enforce_retval
  		return -EINVAL;
  	}
 =20
- 	err =3D mark_chain_precision(env, regno);
- 	if (err)
- 		return err;
-=20
  	if (!retval_range_within(range, reg)) {
  		verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
  		if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP &&
@@@ -19668,7 -19987,7 +20000,7 @@@
  	}
 =20
  	if (!tnum_is_unknown(enforce_attach_type_range) &&
- 	    tnum_in(enforce_attach_type_range, reg->var_off))
+ 	    reg_smax(reg) > 1)
  		env->prog->enforce_expected_attach_type =3D 1;
  	return 0;
  }
@@@ -19763,10 -20082,12 +20095,12 @@@ bool bpf_get_call_summary(struct bpf_=
ve
  				bpf_jit_inlines_helper_call(call->imm));
  		cs->is_void =3D fn->ret_type =3D=3D RET_VOID;
  		cs->arg_slot_cnt =3D 0;
+ 		cs->implicit_slot_cnt =3D 0;
  		for (i =3D 0; i < ARRAY_SIZE(fn->arg_type); ++i) {
  			if (fn->arg_type[i] =3D=3D ARG_UNUSED)
  				break;
  			cs->arg_slot_cnt++;
+ 			cs->implicit_slot_cnt +=3D fn->arg_type[i] =3D=3D ARG_PTR_TO_PROG_AUX;
  		}
  		return true;
  	}
@@@ -19779,6 -20100,14 +20113,14 @@@
  			/* error would be reported later */
  			return false;
  		cs->arg_slot_cnt =3D btf_proto_slots(meta.btf, meta.func_proto);
+ 		cs->implicit_slot_cnt =3D 0;
+ 		if (meta.kfunc_flags & KF_IMPLICIT_ARGS) {
+ 			const struct btf_type *func =3D btf_type_by_id(meta.btf, meta.func_id);
+=20
+ 			/* the prototype without implicit args, see is_kfunc_arg_implicit() */
+ 			cs->implicit_slot_cnt =3D cs->arg_slot_cnt -
+ 				btf_proto_slots(meta.btf, btf_type_by_id(meta.btf, func->type));
+ 		}
  		cs->fastcall =3D meta.kfunc_flags & KF_FASTCALL;
  		cs->is_void =3D btf_type_is_void(btf_type_by_id(meta.btf, meta.func_pro=
to->type));
  		return true;
@@@ -19953,11 -20282,7 +20295,11 @@@ static void mark_fastcall_pattern_for_c
  		env->insn_aux_data[insn_idx].fastcall_spills_num =3D i - 1;
  	else
  		subprog->keep_fastcall_stack =3D 1;
 -	subprog->fastcall_stack_off =3D min(subprog->fastcall_stack_off, off);
 +	/*
 +	 * The upper end of the longest pattern: no slot of a pattern is above i=
t. Code that never
 +	 * runs may have a pattern that ends above the frame pointer.
 +	 */
 +	subprog->fastcall_stack_off =3D max(subprog->fastcall_stack_off, min_t(s=
16, off, 0));
  }
 =20
  static int mark_fastcall_patterns(struct bpf_verifier_env *env)
@@@ -19968,7 -20293,6 +20310,7 @@@
  	int s, i;
 =20
  	for (s =3D 0; s < env->subprog_cnt; ++s, ++subprog) {
 +		subprog->fastcall_stack_off =3D S16_MIN;
  		/* find lowest stack spill offset used in this subprog */
  		lowest_off =3D 0;
  		for (i =3D subprog->start; i < (subprog + 1)->start; ++i) {
@@@ -20002,69 -20326,6 +20344,6 @@@ static void adjust_btf_func(struct bpf_
  		aux->func_info[i].insn_off =3D env->subprog_info[i].start;
  }
 =20
- /* Find id in idset and increment its count, or add new entry */
- static void idset_cnt_inc(struct bpf_idset *idset, u32 id)
- {
- 	u32 i;
-=20
- 	for (i =3D 0; i < idset->num_ids; i++) {
- 		if (idset->entries[i].id =3D=3D id) {
- 			idset->entries[i].cnt++;
- 			return;
- 		}
- 	}
- 	/* New id */
- 	if (idset->num_ids < BPF_ID_MAP_SIZE) {
- 		idset->entries[idset->num_ids].id =3D id;
- 		idset->entries[idset->num_ids].cnt =3D 1;
- 		idset->num_ids++;
- 	}
- }
-=20
- /* Find id in idset and return its count, or 0 if not found */
- static u32 idset_cnt_get(struct bpf_idset *idset, u32 id)
- {
- 	u32 i;
-=20
- 	for (i =3D 0; i < idset->num_ids; i++) {
- 		if (idset->entries[i].id =3D=3D id)
- 			return idset->entries[i].cnt;
- 	}
- 	return 0;
- }
-=20
- /*
-  * Clear singular scalar ids in a state.
-  * A register with a non-zero id is called singular if no other register =
shares
-  * the same base id. Such registers can be treated as independent (id=3D0=
).
-  */
- void bpf_clear_singular_ids(struct bpf_verifier_env *env,
- 			    struct bpf_verifier_state *st)
- {
- 	struct bpf_idset *idset =3D &env->idset_scratch;
- 	struct bpf_func_state *func;
- 	struct bpf_reg_state *reg;
-=20
- 	idset->num_ids =3D 0;
-=20
- 	bpf_for_each_reg_in_vstate(st, func, reg, ({
- 		if (reg->type !=3D SCALAR_VALUE)
- 			continue;
- 		if (!reg->id)
- 			continue;
- 		idset_cnt_inc(idset, reg->id & ~BPF_ADD_CONST);
- 	}));
-=20
- 	bpf_for_each_reg_in_vstate(st, func, reg, ({
- 		if (reg->type !=3D SCALAR_VALUE)
- 			continue;
- 		if (!reg->id)
- 			continue;
- 		if (idset_cnt_get(idset, reg->id & ~BPF_ADD_CONST) =3D=3D 1)
- 			clear_scalar_id(reg);
- 	}));
- }
-=20
  /* Return true if it's OK to have the same insn return a different type. =
*/
  static bool reg_type_mismatch_ok(enum bpf_reg_type type)
  {
@@@ -20152,18 -20413,13 +20431,13 @@@ static int save_aux_ptr_type(struct b=
pf
  			 */
  			*prev_type =3D merge_ptr_types(type, *prev_type);
  		} else {
- 			verbose(env, "same insn cannot be used with different pointers\n");
- 			return -EINVAL;
+ 			return fixups_differ(env, "same insn cannot be used with different poi=
nters");
  		}
  	}
 =20
  	return 0;
  }
 =20
- enum {
- 	PROCESS_BPF_EXIT =3D 1,
- 	INSN_IDX_UPDATED =3D 2,
- };
 =20
  static int process_bpf_exit_full(struct bpf_verifier_env *env,
  				 bool *do_print_state,
@@@ -20171,6 -20427,9 +20445,9 @@@
  {
  	struct bpf_func_state *cur_frame =3D cur_func(env);
 =20
+ 	if (!exception_exit && !env->cur_state->curframe && env->cur_state->inst=
ance_id)
+ 		return exit_func_on_its_own(env);
+=20
  	/* We must do check_reference_leak here before
  	 * prepare_func_exit to handle the case when
  	 * state->curframe > 0, it may be a callback function,
@@@ -20187,8 -20446,8 +20464,8 @@@
  	/* The side effect of the prepare_func_exit which is
  	 * being skipped is that it frees bpf_func_state.
  	 * Typically, process_bpf_exit will only be hit with
- 	 * outermost exit. copy_verifier_state in pop_stack will
- 	 * handle freeing of any extra bpf_func_state left over
+ 	 * outermost exit. do_check_block() frees the state with
+ 	 * any extra bpf_func_state left over
  	 * from not processing all nested function exits. We
  	 * also skip return code checks as they are not needed
  	 * for exceptional exits.
@@@ -20300,6 -20559,11 +20577,11 @@@ static int check_indirect_jump(struct b
  		return -EFAULT;
 =20
  	err =3D indirect_jump_min_max_index(env, insn->dst_reg, map, &min_index,=
 &max_index);
+ 	if (err)
+ 		return err;
+ 	/* the targets are sorted */
+ 	n =3D max_index - min_index + 1;
+ 	err =3D bpf_add_cost_and_check(env, (u64)n * ilog2(n), BPF_COST_COPY);
  	if (err)
  		return err;
 =20
@@@ -20334,6 -20598,11 +20616,11 @@@
  	if (env->gotox_tmp_buf->items[0] < subprog_start)
  		return reject_gotox_out_of_subprog(env, env->gotox_tmp_buf->items[0],
  						   subprog_start, subprog_end);
+ 	/* it's the first insn of a function, it would be executed again */
+ 	if (is_arena_sp_adj(&env->prog->insnsi[env->gotox_tmp_buf->items[0]])) {
+ 		verbose(env, "jump to the insn that changes R%d\n", BPF_REG_ARENA_SP);
+ 		return -EINVAL;
+ 	}
  	if (env->gotox_tmp_buf->items[n - 1] >=3D subprog_end)
  		return reject_gotox_out_of_subprog(env, env->gotox_tmp_buf->items[n - 1=
],
  						   subprog_start, subprog_end);
@@@ -20350,12 -20619,64 +20637,64 @@@
  	return INSN_IDX_UPDATED;
  }
 =20
+ /*
+  * r12 is not in regs[]. Only the kernel and 'r12 +=3D N' change it, so i=
t points
+  * to the stack in arena. What is there is not tracked, like the rest of =
arena.
+  */
+ static int check_arena_sp_insn(struct bpf_verifier_env *env, struct bpf_i=
nsn *insn)
+ {
+ 	struct bpf_reg_state arena =3D { .type =3D PTR_TO_ARENA };
+ 	argno_t argno =3D argno_from_reg(BPF_REG_ARENA_SP);
+ 	struct bpf_reg_state *regs =3D cur_regs(env);
+ 	int size =3D BPF_SIZE(insn->code);
+ 	int err, value_regno =3D -1;
+=20
+ 	if (is_arena_sp_adj(insn))
+ 		return 0;
+=20
+ 	/* the address of the frame is a number */
+ 	if (is_arena_sp_mov(insn)) {
+ 		bpf_diag_mod_begin(env, &regs[insn->dst_reg], NULL, BPF_DIAG_MOD_WRITE);
+ 		err =3D check_reg_arg(env, insn->dst_reg, DST_OP);
+ 		if (!err)
+ 			bpf_diag_mod_end(env);
+ 		return err;
+ 	}
+=20
+ 	if (is_arena_sp_ldx(insn)) {
+ 		err =3D check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
+ 		if (err)
+ 			return err;
+ 		bpf_diag_mod_begin(env, &regs[insn->dst_reg], NULL, BPF_DIAG_MOD_WRITE);
+ 		err =3D check_mem_access(env, env->insn_idx, &arena, argno, insn->off, =
size,
+ 				       BPF_READ, insn->dst_reg, false,
+ 				       BPF_MODE(insn->code) =3D=3D BPF_MEMSX);
+ 		err =3D err ?: save_aux_ptr_type(env, PTR_TO_ARENA, false);
+ 		if (!err)
+ 			bpf_diag_mod_end(env);
+ 		return err;
+ 	}
+=20
+ 	if (BPF_CLASS(insn->code) =3D=3D BPF_STX) {
+ 		err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
+ 		if (err)
+ 			return err;
+ 		value_regno =3D insn->src_reg;
+ 	}
+ 	err =3D check_mem_access(env, env->insn_idx, &arena, argno, insn->off, s=
ize,
+ 			       BPF_WRITE, value_regno, false, false);
+ 	return err ?: save_aux_ptr_type(env, PTR_TO_ARENA, false);
+ }
+=20
  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_sta=
te)
  {
- 	int err;
+ 	int err, i;
  	struct bpf_insn *insn =3D &env->prog->insnsi[env->insn_idx];
  	u8 class =3D BPF_CLASS(insn->code);
 =20
+ 	if (is_arena_sp_insn(insn))
+ 		return check_arena_sp_insn(env, insn);
+=20
  	switch (class) {
  	case BPF_ALU:
  	case BPF_ALU64:
@@@ -20401,7 -20722,6 +20740,6 @@@
  	case BPF_JMP32: {
  		u8 opcode =3D BPF_OP(insn->code);
 =20
- 		env->jmps_processed++;
  		if (opcode =3D=3D BPF_CALL) {
  			if (env->cur_state->active_locks) {
  				/* similar to static subprog calls callx is allowed under a lock */
@@@ -20422,11 -20742,20 +20760,20 @@@
  			}
  			mark_reg_scratched(env, BPF_REG_0);
  			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]))
- 				cur_func(env)->no_stack_arg_load =3D true;
+ 				end_stack_arg_loads(env, cur_func(env));
+ 			/* func_is_on_its_own() uses the names of the ids */
  			if (bpf_is_callx(insn))
- 				return check_func_callx(env, insn, &env->insn_idx);
+ 				return bpf_renumber_ids(env, env->cur_state) ?:
+ 				       check_func_callx(env, insn, &env->insn_idx);
  			if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
- 				return check_func_call(env, insn, &env->insn_idx);
+ 				return bpf_renumber_ids(env, env->cur_state) ?:
+ 				       check_func_call(env, insn, &env->insn_idx);
+ 			/* a callback is one function */
+ 			for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
+ 				err =3D split_func_set(env, i);
+ 				if (err)
+ 					return err;
+ 			}
  			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL)
  				return check_kfunc_call(env, insn, &env->insn_idx);
  			return check_helper_call(env, insn, &env->insn_idx);
@@@ -20465,6 -20794,106 +20812,106 @@@
  	return -EFAULT;
  }
 =20
+ /* Does the insn read what an unproven insn made up? Then what it writes =
is made up too. */
+ static bool reads_from_unproven(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_reg_state *regs =3D cur_regs(env);
+ 	int i;
+=20
+ 	for (i =3D BPF_REG_0; env->err && i < BPF_REG_FP; i++)
+ 		if ((cur_aux(env)->use_regs & BIT(i)) && regs[i].from_unproven)
+ 			return true;
+ 	return false;
+ }
+=20
+ /* The operands of @insn that have more than one value, without the numbe=
r that is stored */
+ static unsigned long operands_with_range(struct bpf_verifier_env *env, co=
nst struct bpf_insn *insn)
+ {
+ 	unsigned long use =3D cur_aux(env)->use_regs & GENMASK(BPF_REG_9, BPF_RE=
G_0), ranges =3D 0;
+ 	struct bpf_reg_state *regs =3D cur_regs(env);
+ 	int i;
+=20
+ 	if (BPF_CLASS(insn->code) =3D=3D BPF_STX && !bpf_atomic_is_load_acq(insn=
))
+ 		use &=3D BIT(insn->dst_reg);
+ 	for_each_set_bit(i, &use, BPF_REG_FP)
+ 		if (regs[i].r64.size)
+ 			ranges |=3D BIT(i);
+ 	return ranges;
+ }
+=20
+ static void mark_from_unproven(struct bpf_verifier_env *env, int idx, boo=
l from_unproven)
+ {
+ 	struct bpf_reg_state *regs =3D cur_regs(env);
+ 	int i;
+=20
+ 	/* a fill has what was spilled */
+ 	if (!from_unproven && BPF_CLASS(env->prog->insnsi[idx].code) =3D=3D BPF_=
LDX)
+ 		return;
+ 	for (i =3D BPF_REG_0; env->err && i < BPF_REG_FP; i++)
+ 		if (env->insn_aux_data[idx].def_regs & BIT(i))
+ 			regs[i].from_unproven =3D from_unproven;
+ }
+=20
+ static void note_error(struct bpf_verifier_env *env, int err);
+=20
+ static u32 held_cnt(const struct bpf_verifier_state *st)
+ {
+ 	return st->acquired_refs + st->active_rcu_locks + st->active_preempt_loc=
ks;
+ }
+=20
+ /* The current state enters @loop in @frame. It is in trip 0. */
+ static struct loop_stack_entry *push_loop(struct bpf_verifier_env *env,
+ 					  struct bpf_func_state *frame, struct bpf_loop *loop)
+ {
+ 	u32 cnt =3D frame->loop_stack_cnt;
+ 	struct loop_stack_entry *stack;
+=20
+ 	stack =3D krealloc(frame->loop_stack, kmalloc_size_roundup((cnt + 1) * s=
izeof(*stack)),
+ 			 BPF_VERIFIER_GFP);
+ 	if (!stack)
+ 		return NULL;
+ 	frame->loop_stack =3D stack;
+ 	stack[cnt] =3D (struct loop_stack_entry){
+ 		.loop =3D loop,
+ 		.held_cnt =3D held_cnt(env->cur_state),
+ 		.entry_id =3D ++env->loop_entry_cnt,
+ 		.peeled =3D true,
+ 		.exit_threshold =3D U64_MAX,
+ 	};
+ 	scalar_set_const(&frame->loop_stack[cnt].trip_index, 0);
+ 	frame->loop_stack_cnt++;
+ 	return &frame->loop_stack[cnt];
+ }
+=20
+ static bool try_peel_trip(const struct loop_stack_entry *entry)
+ {
+ 	struct bpf_loop *loop =3D entry->loop;
+=20
+ 	if (entry->trip >=3D loop->peel_cnt &&
+ 	    (entry->trip >=3D loop->max_peel_cnt || !bpf_loop_partition_is_activ=
e(loop)))
+ 		return false;
+ 	loop->this_pass.peeled_cnt =3D max(loop->this_pass.peeled_cnt, entry->tr=
ip + 1);
+ 	return true;
+ }
+=20
+ /* The loop of @entry starts its leftover. Nothing grew in it so far. */
+ static void leave_peeled_trips(struct bpf_verifier_env *env, struct loop_=
stack_entry *entry)
+ {
+ 	struct bpf_func_state *frame;
+ 	struct bpf_reg_state *reg;
+ 	u32 i;
+=20
+ 	entry->peeled =3D false;
+ 	entry->loop->this_pass.has_leftover =3D true;
+ 	entry->loop->leftover_epoch++;
+ 	/* the leftover of the last pass had no trip count */
+ 	entry->loop->guarded |=3D entry->loop->last_pass.needs_guard && !env->cu=
r_state->speculative;
+ 	entry->trip_index.grew_once =3D entry->trip_widened =3D false;
+ 	bpf_for_each_reg_in_vstate(env->cur_state, frame, reg, reg->grew_once =
=3D false);
+ 	for (i =3D 0; i < env->cur_state->equations.sym_cnt; i++)
+ 		env->cur_state->equations.syms[i].grew_once =3D false;
+ }
+=20
  /*
   * Push the loop entered at insn_idx onto the stack. Usually this adds a =
single
   * entry on top of its enclosing loop. However, an edge may enter an inne=
r loop
@@@ -20478,8 -20907,6 +20925,6 @@@
   *
   * Such a bypass makes the enclosing loop irreducible, so its header is m=
issing
   * from the stack and both headers (1) and (2) need to be pushed onto sta=
ck.
-  * Only the innermost loop (the one actually entered at insn_idx) carries=
 SCEV bounds;
-  * the bypassed ancestors are irreducible and pushed as non-terminating.
   *
   * Assumes loop_stack_pop() has already truncated the stack to the common=
 ancestor
   * of the bpf_loop_at_index(env->insn_idx) and whatever was at the top of=
 the loop stack.
@@@ -20488,45 -20915,33 +20933,33 @@@ static int loop_stack_push(struct bpf=
_v
  {
  	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
  	struct bpf_func_state *frame =3D cur_func(env);
- 	struct loop_stack_entry *loop_stack =3D frame->loop_stack;
+ 	struct loop_stack_entry *entry =3D bpf_top_loop(frame);
  	u32 missing_headers[LOOP_STACK_SIZE];
- 	u32 cnt =3D frame->loop_stack_cnt;
  	u32 num_missing =3D 0;
  	int h;
 =20
- 	*pushed =3D false;
+ 	/* bpf_compute_loops() checked how deep loops nest */
+ 	for (h =3D bpf_loop_at_index(env, env->insn_idx);
+ 	     h >=3D 0 && !(entry && entry->loop =3D=3D aux[h].loop); h =3D aux[h=
].loop_header)
+ 		missing_headers[num_missing++] =3D h;
 =20
- 	for (h =3D bpf_loop_at_index(env, env->insn_idx); h >=3D 0; h =3D aux[h]=
=2Eloop_header, num_missing++) {
- 		if (cnt && loop_stack[cnt - 1].loop_id =3D=3D h)
- 			break;
- 		if (num_missing =3D=3D LOOP_STACK_SIZE)
- 			goto e2big;
- 		missing_headers[num_missing] =3D h;
- 	}
-=20
- 	if (num_missing =3D=3D 0)
- 		return 0;
- 	if (cnt + num_missing > LOOP_STACK_SIZE)
- 		goto e2big;
- 	frame->loop_stack =3D realloc_array(frame->loop_stack, cnt, cnt + num_mi=
ssing,
- 					 sizeof(*frame->loop_stack));
- 	if (!frame->loop_stack)
- 		return -ENOMEM;
- 	loop_stack =3D frame->loop_stack;
-=20
- 	for (; num_missing; num_missing--, cnt++) {
- 		h =3D missing_headers[num_missing - 1];
- 		loop_stack[cnt] =3D (struct loop_stack_entry){ .loop_id =3D h };
+ 	*pushed =3D num_missing;
+ 	while (num_missing--) {
+ 		h =3D missing_headers[num_missing];
+ 		/* wherever it is entered: a loop can have more than one entry */
+ 		if (aux[h].loop->exit_to < 0) {
+ 			verbose(env, "loop at insn %d never exits\n", h);
+ 			return -EINVAL;
+ 		}
+ 		entry =3D push_loop(env, frame, aux[h].loop);
+ 		if (!entry)
+ 			return -ENOMEM;
  		if (env->log.level & BPF_LOG_LEVEL2)
  			verbose(env, "entering loop %d\n", h);
- 		*pushed =3D true;
+ 		if (h !=3D env->insn_idx && !env->path_sensitive && !try_peel_trip(entr=
y))
+ 			leave_peeled_trips(env, entry);
  	}
- 	frame->loop_stack_cnt =3D cnt;
  	return 0;
-=20
- e2big:
- 	verbose(env, "Too many nested loops (%d/%d) at %d\n", cnt, num_missing, =
env->insn_idx);
- 	return -E2BIG;
  }
 =20
  /*
@@@ -20538,13 -20953,15 +20971,15 @@@
   *            if ...:    // before goto the loop stack is [1, 2, 3 <top>]
   *              goto 1b; // after goto it should become [1]
   */
- static int loop_stack_pop(struct bpf_verifier_env *env)
+ static void loop_stack_pop(struct bpf_verifier_env *env)
  {
  	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
  	struct bpf_func_state *frame =3D cur_func(env);
- 	int new_cnt =3D 0;
+ 	int cnt =3D frame->loop_stack_cnt, new_cnt;
  	int h, i;
 =20
+ 	/* the function stays in its recursion */
+ 	new_cnt =3D cnt && frame->loop_stack[0].loop->kind =3D=3D BPF_LOOP_RECUR=
SION;
  	/*
  	 * Walk the loop nest of insn_idx outwards (innermost first) and stop at
  	 * the first loop that is present on the stack - that loop is the common
@@@ -20552,8 -20969,8 +20987,8 @@@
  	 * stack, drop all loops.
  	 */
  	for (h =3D bpf_loop_at_index(env, env->insn_idx); h >=3D 0; h =3D aux[h]=
=2Eloop_header) {
- 		for (i =3D frame->loop_stack_cnt - 1; i >=3D 0; i--) {
- 			if (frame->loop_stack[i].loop_id =3D=3D h) {
+ 		for (i =3D cnt - 1; i >=3D 0; i--) {
+ 			if (frame->loop_stack[i].loop =3D=3D aux[h].loop) {
  				new_cnt =3D i + 1;
  				goto pop;
  			}
@@@ -20562,102 -20979,746 +20997,746 @@@
 =20
  pop:
  	if (env->log.level & BPF_LOG_LEVEL2)
- 		for (i =3D frame->loop_stack_cnt - 1; i >=3D new_cnt; i--)
- 			verbose(env, "exiting loop %d\n", frame->loop_stack[i].loop_id);
- 	frame->loop_stack_cnt =3D new_cnt;
+ 		for (i =3D cnt - 1; i >=3D new_cnt; i--)
+ 			if (frame->loop_stack[i].loop->kind =3D=3D BPF_LOOP_JUMPS)
+ 				verbose(env, "exiting loop %d\n",
+ 					frame->loop_stack[i].loop->header);
+ 	leave_loops(frame, new_cnt);
+ 	if (new_cnt !=3D cnt)
+ 		bpf_equations_clean(env, env->cur_state);
+ }
+=20
+ static bool xreg_has_id(struct bpf_verifier_state *st, u32 id)
+ {
+ 	u32 mask =3D BIT(STACK_SPILL) | BIT(STACK_DYNPTR) | BIT(STACK_ITER) | BI=
T(STACK_IRQ_FLAG);
+ 	struct bpf_stack_state *slot;
+ 	struct bpf_func_state *frame;
+ 	struct bpf_reg_state *reg;
+=20
+ 	bpf_for_each_reg_in_vstate_mask(st, frame, reg, slot, mask, ({
+ 		if (reg->id =3D=3D id || reg->parent_id =3D=3D id)
+ 			return true;
+ 	}));
+ 	return false;
+ }
+=20
+ /*
+  * The current state went around a loop. If it holds more than the states=
 at the header, none of
+  * them subsumes it, and it has no join. It goes around again:
+  *	bpf_for(i, 0, n) { if (prev) release(prev); prev =3D cur; cur =3D acqu=
ire(); }
+  * The number of xregs limits the references: a reference that is in no x=
reg is a leak. The
+  * number of peeled trips limits the rest. The state continues until it h=
olds more, so it is
+  * unproven where a check fails on a path. Returns 1 if it ends here.
+  */
+ static int check_held_in_leftover(struct bpf_verifier_env *env,
+ 				  const struct loop_stack_entry *entry)
+ {
+ 	struct bpf_verifier_state *st =3D env->cur_state;
+ 	u32 held =3D held_cnt(st), i;
+ 	bool leak =3D false;
+=20
+ 	if (entry->peeled || held <=3D entry->held_cnt)
+ 		return 0;
+ 	/* the callers have xregs for the first ones */
+ 	for (i =3D st->frame[0]->entry_refs; i < st->acquired_refs && !leak; i++=
) {
+ 		if (st->refs[i].type !=3D REF_TYPE_PTR || st->refs[i].ctx_arg)
+ 			continue;
+ 		bpf_add_cost(env, bpf_xreg_cnt(st), BPF_COST_SCAN);
+ 		leak =3D !xreg_has_id(st, st->refs[i].id);
+ 		held--;
+ 	}
+ 	if (!leak && held <=3D entry->held_cnt + entry->loop->this_pass.peeled_c=
nt)
+ 		return 0;
+ 	if (st->speculative)
+ 		return -EINVAL;
+ 	verbose(env, "loop at insn %d acquires more than it releases\n", entry->=
loop->header);
+ 	env->imprecise |=3D !env->err;
+ 	st->suspect_loops |=3D entry->loop->suspect_bit;
+ 	st->holds_too_much =3D true;
+ 	if (bpf_same_insns_unproven(env))
+ 		return -EINVAL;
+ 	note_error(env, -EINVAL);
+ 	st->holds_too_much =3D false;
+ 	st->max_held_cnt =3D st->max_held_cnt ?: held_cnt(st);
+ 	return held_cnt(st) > st->max_held_cnt;
+ }
+=20
+ /*
+  * A path-sensitive run is in a loop with a trip count. If only the jump =
on the iv depends on
+  * the xregs that moved, the path can take the same edges again and again:
+  *	for (i =3D 0; i < 100000; i++) { if (rnd() && n < 8) n++; }
+  * Two trips show a step also for 'sum +=3D i', and more than 2^32 trips =
also for a ring index.
+  * If the steps are not constant, the skip or "infinite" is a guess.
+  * If the bound moved, there is no skip. A later saved trip can have the =
same bound.
+  * Returns 1 if it skipped these trips.
+  */
+ static int fast_forward_trips(struct bpf_verifier_env *env, struct loop_s=
tack_entry *entry)
+ {
+ 	struct bpf_verifier_state *cur =3D env->cur_state, *old =3D &entry->head=
er_state->st;
+ 	const struct loop_stack_entry *saved =3D bpf_top_loop(old->frame[old->cu=
rframe]);
+ 	u32 period =3D entry->trip - saved->trip;
+ 	bool infinite =3D entry->trips_left > BPF_MAX_TRIPS, guess;
+ 	u64 factor =3D div_u64(entry->trips_left - 1, period);
+ 	DECLARE_BITMAP(iv_xregs, MAX_BPF_XREG) =3D {};
+ 	int err;
+=20
+ 	/* the answer needs a walk over the program */
+ 	if ((infinite ? entry->loop->infinite : entry->trips_left <=3D period) ||
+ 	    (!infinite && saved->exit_threshold !=3D entry->exit_threshold) ||
+ 	    (u64)entry->trip * entry->loop->nr_insns < env->prog->len)
+ 		return 0;
+ 	bpf_fast_forward_xregs(env, old, cur, 0, iv_xregs);
+ 	err =3D bpf_jumps_see_same(env, old, cur, entry->iv_jump_idx, infinite ?=
 NULL : iv_xregs);
+ 	if (err <=3D 0)
+ 		return err;
+ 	guess =3D !bpf_steps_are_constant(env, entry, iv_xregs, infinite, factor=
);
+ 	if (infinite) {
+ 		entry->loop->infinite =3D true;
+ 		entry->loop->infinite_is_guess =3D guess || env->run_has_guess;
+ 		return 0;
+ 	}
+ 	env->run_has_guess |=3D guess;
+ 	bpf_fast_forward_xregs(env, old, cur, factor, iv_xregs);
+ 	entry->iv_jump_idx =3D 0;
+ 	entry->trips_left =3D 1;
+ 	return 1;
+ }
+=20
+ /*
+  * A path of a path-sensitive run starts a trip. Compare it with the stat=
e in which it started
+  * trip 0, 1, 2, 4, ...
+  * If the jumps see the same values, the loop is infinite and needs may_g=
oto.
+  * With a trip count the path makes that many trips. Else it makes up to
+  * env->failing_path_max_trips. Returns 1 if it ends here.
+  */
+ static int failing_path_trip(struct bpf_verifier_env *env, struct loop_st=
ack_entry *entry)
+ {
+ 	struct bpf_verifier_state *cur =3D env->cur_state, *old =3D &entry->head=
er_state->st;
+ 	struct bpf_loop *loop =3D entry->loop;
+ 	struct loop_stack_entry mine;
+ 	int err;
+=20
+ 	if (entry->trip > env->failing_path_max_trips &&
+ 	    (!entry->trips_left || entry->trips_left > BPF_MAX_TRIPS)) {
+ 		env->too_deep =3D true;
+ 		return 1;
+ 	}
+ 	if (entry->header_state) {
+ 		mine =3D *entry;
+ 		*entry =3D *bpf_top_loop(old->frame[old->curframe]);
+ 		err =3D bpf_same_join_key(old, cur);
+ 		*entry =3D mine;
+ 		if (err)
+ 			err =3D entry->trips_left ? fast_forward_trips(env, entry) :
+ 						  bpf_jumps_see_same(env, old, cur, -1, NULL);
+ 		if (err < 0)
+ 			return err;
+ 		if (err && entry->trips_left)
+ 			return bpf_flow_save_header_state(env, entry);
+ 		if (err && !loop->infinite && !loop->rt_bounded) {
+ 			loop->infinite =3D true;
+ 			/* the next runs keep it */
+ 			loop->infinite_is_guess =3D env->run_has_guess;
+ 			return bpf_flow_needs_guard(env, loop);
+ 		} else if (err && !bpf_values_grew_in_deps(env, old, cur)) {
+ 			return 1;
+ 		}
+ 	}
+ 	return bpf_trip_is_saved(entry) ? bpf_flow_save_header_state(env, entry)=
 : 0;
+ }
+=20
+ /*
+  * The cpu can speculate past the jump that the equations decide.
+  * The removal of dead code can delete an edge only from a conditional ju=
mp.
+  */
+ static bool infeasible_state_ends(struct bpf_verifier_env *env)
+ {
+ 	int from =3D env->cur_state->last_insn_idx;
+=20
+ 	return env->cur_state->equations.infeasible && env->bypass_spec_v1 && fr=
om >=3D 0 &&
+ 	       bpf_insn_is_cond_jump(env->prog->insnsi[from].code);
+ }
+=20
+ /* The current state came back to the header of the loop of @entry. Retur=
ns 1 if it ends here. */
+ static int next_trip(struct bpf_verifier_env *env, struct loop_stack_entr=
y *entry,
+ 		     bool *starts_leftover)
+ {
+ 	entry->trip++;
+ 	if (entry->loop->kind !=3D BPF_LOOP_RECURSION) {
+ 		bpf_equations_next_trip(env, env->cur_state, entry - cur_func(env)->loo=
p_stack);
+ 		/* No run makes 2^63 trips. The header is not dead code: a trip started=
 there. */
+ 		if (infeasible_state_ends(env) ||
+ 		    (env->bypass_spec_v1 && cnum64_is_empty(entry->trip_index.r64)))
+ 			return 1;
+ 	}
+ 	if (env->path_sensitive)
+ 		return failing_path_trip(env, entry);
+ 	if (!entry->peeled)
+ 		return check_held_in_leftover(env, entry);
+ 	*starts_leftover =3D !bpf_flow_trip_is_new(env, entry) || !try_peel_trip=
(entry);
+ 	if (*starts_leftover)
+ 		entry->entry_id =3D ++env->loop_entry_cnt;
  	return 0;
  }
 =20
- static int maybe_clamp_scev_regs(struct bpf_verifier_env *env)
+ /* @callee is the frame of a function that is verified on its own */
+ static int enter_recursion(struct bpf_verifier_env *env, struct bpf_func_=
state *callee)
  {
- 	struct bpf_func_state *frame =3D cur_func(env);
- 	struct loop_stack_entry *entry;
+ 	u32 cycle =3D env->subprog_info[callee->subprogno].cycle;
+ 	struct bpf_loop *loop =3D env->insn_aux_data[env->subprog_info[cycle].st=
art].recursion_loop;
+ 	struct loop_stack_entry *entry, *from =3D env->cur_state->frame[0]->loop=
_stack;
+ 	bool starts_leftover;
+ 	int err =3D 0;
 =20
- 	if (frame->loop_stack_cnt =3D=3D 0) {
- 		verifier_bug(env, "%s: loop stack empty at %d", __FUNCTION__, env->insn=
_idx);
- 		return -EFAULT;
- 	}
-=20
- 	entry =3D &frame->loop_stack[frame->loop_stack_cnt - 1];
- 	if (!entry->terminates)
+ 	if (!loop)
  		return 0;
-=20
- 	return bpf_clamp_scev_regs(env, frame, env->insn_idx, entry->entry_state,
- 				   entry->max_header_count);
+ 	entry =3D push_loop(env, callee, loop);
+ 	if (!entry)
+ 		return -ENOMEM;
+ 	starts_leftover =3D !try_peel_trip(entry);
+ 	if (env->cur_state->frame[0]->loop_stack_cnt && from->loop =3D=3D loop) {
+ 		*entry =3D *from;
+ 		starts_leftover =3D false;
+ 		err =3D next_trip(env, entry, &starts_leftover);
+ 	}
+ 	if (starts_leftover)
+ 		leave_peeled_trips(env, entry);
+ 	return err;
  }
 =20
- static int handle_loop_entry_exit(struct bpf_verifier_env *env)
+ /* The helper at env->insn_idx calls the callback again and again. @back:=
 the callback returned. */
+ static int enter_callback(struct bpf_verifier_env *env, bool back, struct=
 bpf_loop **backedge_loop)
  {
- 	struct bpf_verifier_state *cur =3D env->cur_state;
+ 	struct bpf_loop *loop =3D cur_aux(env)->callback_loop;
  	struct bpf_func_state *frame =3D cur_func(env);
  	struct loop_stack_entry *entry;
- 	struct bpf_loop_iters iters;
- 	bool pushed, terminates;
+ 	bool starts_leftover =3D false;
+ 	int err =3D 0;
+=20
+ 	if (!loop)
+ 		return 0;
+ 	if (back) {
+ 		entry =3D bpf_top_loop(frame);
+ 		err =3D next_trip(env, entry, &starts_leftover);
+ 		*backedge_loop =3D starts_leftover ? NULL : loop;
+ 	} else {
+ 		entry =3D push_loop(env, frame, loop);
+ 		if (!entry)
+ 			return -ENOMEM;
+ 		if (env->path_sensitive)
+ 			return failing_path_trip(env, entry);
+ 		starts_leftover =3D !try_peel_trip(entry);
+ 	}
+ 	if (starts_leftover)
+ 		leave_peeled_trips(env, entry);
+ 	return err;
+ }
+=20
+ /* The current state is at the header of a loop and starts its leftover */
+ int bpf_flow_start_leftover(struct bpf_verifier_env *env)
+ {
+ 	leave_peeled_trips(env, bpf_top_loop(cur_func(env)));
+ 	return enter_callback(env, false, NULL);
+ }
+=20
+ /*
+  * The current state gets to env->insn_idx. Leave the loops that the insn=
 is not in. Enter
+  * the loops that it is in. Returns 1 if the state ends here.
+  * @backedge_loop: the state came back to the header of that loop.
+  * @starts_leftover: see bpf_flow_start_leftover()
+  */
+ int bpf_flow_loop_enter(struct bpf_verifier_env *env, struct bpf_loop **b=
ackedge_loop,
+ 			bool *starts_leftover)
+ {
+ 	struct bpf_func_state *frame =3D cur_func(env);
+ 	struct loop_stack_entry *entry;
+ 	bool pushed;
  	int err;
 =20
- 	err =3D loop_stack_pop(env);
- 	if (err)
- 		return err;
+ 	if (infeasible_state_ends(env))
+ 		return 1;
+=20
+ 	/* The callback came back to the helper that calls it, in the same trip.=
 */
+ 	if (frame->callback_depth)
+ 		return enter_callback(env, true, backedge_loop);
+=20
+ 	loop_stack_pop(env);
+ 	if (infeasible_state_ends(env))
+ 		return 1;
 =20
  	err =3D loop_stack_push(env, &pushed);
  	if (err)
  		return err;
 =20
- 	if (frame->loop_stack_cnt =3D=3D 0)
- 		return 0;
+ 	entry =3D bpf_top_loop(frame);
+ 	if (!entry || entry->loop !=3D cur_aux(env)->loop)
+ 		return enter_callback(env, false, NULL);
+ 	if (env->path_sensitive)
+ 		return (pushed ? failing_path_trip(env, entry) :
+ 			next_trip(env, entry, starts_leftover)) ?:
+ 		       enter_callback(env, false, NULL);
+ 	if (pushed) {
+ 		*starts_leftover =3D !try_peel_trip(entry);
+ 		return *starts_leftover ? 0 : enter_callback(env, false, NULL);
+ 	}
 =20
- 	entry =3D &frame->loop_stack[frame->loop_stack_cnt - 1];
- 	if (env->insn_idx !=3D entry->loop_id)
- 		return 0;
-=20
- 	/* If nothing was pushed and env->insn_idx is a loop header, we've taken=
 a backedge. */
- 	if (!pushed)
- 		return maybe_clamp_scev_regs(env);
-=20
- 	err =3D bpf_compute_loop_iters(env, env->cur_state, &iters);
- 	if (err < 0)
+ 	*backedge_loop =3D entry->loop;
+ 	err =3D next_trip(env, entry, starts_leftover);
+ 	if (err || *starts_leftover)
  		return err;
+ 	return enter_callback(env, false, NULL);
+ }
 =20
- 	terminates =3D err =3D=3D 1;
- 	if (!terminates)
+ /* Can the main program return 0? */
+ static bool zero_is_valid_retval(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_retval_range range;
+=20
+ 	if (program_returns_void(env) || !return_retval_range(env, &range))
+ 		return true;
+ 	return range.minval <=3D 0 && range.maxval >=3D 0;
+ }
+=20
+ /*
+  * A loop or a recursion is out of budget in the current frame of @st. Wh=
at the
+  * program computed so far is not what it was meant to compute, so it's b=
etter
+  * not to go on. The way to stop is to unwind: 'r0 =3D 0; unwind_exit'. T=
he landing
+  * pads of the callers are code like any other. They release what the cal=
lers
+  * hold, or the program is rejected.
+  *
+  * False when it cannot:
+  * - There is no landing pad for what this frame took itself.
+  * - There is a call of the subprog that unwind_goto doesn't follow. That=
 is every
+  *   program that is compiled without unwinding.
+  * - A helper that calls a callback doesn't expect it to unwind.
+  * Then the program goes on along a path that it has, like after may_goto=
 of
+  * its own. It releases what it holds there.
+  *
+  * @or_exit: there is no such path. 'r0 =3D 0; exit' has to do where the =
subprog
+  * cannot unwind, and the caller goes on with 0 in place of the result.
+  */
+ static bool state_can_unwind(struct bpf_verifier_env *env, const struct b=
pf_verifier_state *st,
+ 			     bool or_exit)
+ {
+ 	const struct bpf_func_state *frame =3D st->frame[st->curframe];
+ 	const struct bpf_subprog_info *sub =3D &env->subprog_info[frame->subprog=
no];
+ 	bool top;
+=20
+ 	if (sub->bail_insn < 0)
+ 		return false;
+ 	if (st->acquired_refs !=3D frame->entry_refs ||
+ 	    st->active_rcu_locks !=3D frame->entry_rcu_locks ||
+ 	    st->active_preempt_locks !=3D frame->entry_preempt_locks)
+ 		return false;
+ 	if (frame->in_callback_fn || frame->in_exception_callback_fn)
+ 		return false;
+ 	/* the kernel called it: either exit ends it */
+ 	top =3D !st->curframe && !st->callers_unknown &&
+ 	      (!frame->subprogno || frame->in_async_callback_fn);
+ 	if (top && !frame->subprogno && !zero_is_valid_retval(env))
+ 		return false;
+ 	return top || sub->bail_unwinds || or_exit;
+ }
+=20
+ /* May_goto at the head of a loop skips the body. Does it go to code that=
 reads what is not set? */
+ static bool guard_reads_unset_reg(struct bpf_verifier_env *env,
+ 				  const struct bpf_insn_aux_data *aux)
+ {
+ 	u16 live =3D env->insn_aux_data[aux->guard_to].live_regs_before;
+ 	int r;
+=20
+ 	for (r =3D BPF_REG_0; r < BPF_REG_FP; r++)
+ 		if ((live & BIT(r)) && cur_regs(env)[r].type =3D=3D NOT_INIT)
+ 			return true;
+ 	return false;
+ }
+=20
+ /*
+  * The current frame leaves with 0 in place of the result: with unwind_ex=
it if the subprog
+  * can do that, with exit otherwise. The insns are added when the main pa=
ss is over. Until
+  * then an exit that the subprog has stands for them.
+  */
+ static int push_unwind_exit(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_subprog_info *sub =3D &env->subprog_info[cur_func(env)->subpr=
ogno];
+ 	struct bpf_verifier_state *branch;
+ 	struct bpf_reg_state *regs;
+=20
+ 	if (env->cur_state->speculative)
  		return 0;
-=20
- 	/* Create a loop_entry checkpoint before widening */
- 	err =3D bpf_split_cur_state(env);
- 	if (err)
- 		return err;
-=20
- 	entry->min_header_count =3D iters.min_header_count;
- 	entry->max_header_count =3D iters.max_header_count;
- 	entry->entry_state =3D cur->parent;
- 	entry->terminates =3D true;
- 	err =3D bpf_widen_scev_regs(env, cur, cur->parent, &iters);
- 	if (err < 0)
- 		return err;
+ 	branch =3D push_stack(env, sub->bail_insn, env->insn_idx, false);
+ 	if (IS_ERR(branch))
+ 		return PTR_ERR(branch);
+ 	branch->unwound =3D sub->bail_unwinds;
+ 	regs =3D branch->frame[branch->curframe]->regs;
+ 	__mark_reg_const_zero(&regs[BPF_REG_0]);
+ 	if (bpf_ret_reg_pair(env, cur_func(env)->subprogno))
+ 		__mark_reg_const_zero(&regs[BPF_REG_2]);
+ 	bpf_equations_forget_xreg(env, branch, bpf_xreg(branch->curframe, BPF_RE=
G_0));
+ 	bpf_equations_forget_xreg(env, branch, bpf_xreg(branch->curframe, BPF_RE=
G_2));
  	return 0;
  }
 =20
- static int do_check(struct bpf_verifier_env *env)
+ /*
+  * A loop has no trip count, and nothing stops it at run time. It gets ma=
y_goto
+  * before this insn. When may_goto is out of budget, the program goes to =
its
+  * target with the registers and the stack that it has here.
+  * Every state that goes through the loop does that, see bpf_flow_needs_g=
uard().
+  */
+ static int check_loop_guard(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_insn_aux_data *aux =3D &env->insn_aux_data[env->insn_idx];
+ 	struct bpf_loop *loop;
+ 	int err;
+=20
+ 	/* The callback came back to the helper that calls it: the program is no=
t in front of it. */
+ 	if (!aux->guard_place || cur_func(env)->callback_depth)
+ 		return 0;
+ 	loop =3D env->insn_aux_data[bpf_loop_at_index(env, env->insn_idx)].loop;
+ 	if (loop->rt_bounded)
+ 		return 0;
+ 	if (!(env->path_sensitive ? loop->infinite : loop->guarded)) {
+ 		loop->this_pass.no_guard_edges =3D true;
+ 		return 0;
+ 	}
+=20
+ 	env->imprecise |=3D !env->err;
+ 	env->run_has_guess |=3D loop->infinite_is_guess;
+ 	/* the device runs the insns that the driver was given, without may_goto=
 */
+ 	if (bpf_prog_is_offloaded(env->prog->aux)) {
+ 		verbose(env, "loop at insn %d has no known bound in an offloaded progra=
m\n",
+ 			loop->header);
+ 		env->cur_state->suspect_loops |=3D loop->suspect_bit;
+ 		return -EINVAL;
+ 	}
+=20
+ 	/*
+ 	 * A guard has one way out, and only that one is verified.
+ 	 *
+ 	 * Leave the subprog, if that is possible every time the program gets he=
re:
+ 	 *	do { p =3D lookup(); } while (!p); *p
+ 	 * The code after the loop relies on the result of the jump that leaves =
it.
+ 	 *
+ 	 * Otherwise leave the loop:
+ 	 *	lock(); do { ... } while (...); unlock();
+ 	 * The code after the loop releases what is held.
+ 	 *
+ 	 * The program has no edge from the header of a loop to the exit of the =
loop:
+ 	 *	for (;;) { c =3D *s++; if (!c) return 0; if (c =3D=3D '*') return 1; }
+ 	 * The loop is left to 'exit', and only its body sets r0. Then leave the=
 subprog. Use
+ 	 * a plain exit if it cannot unwind, like check_recursion_guard().
+ 	 *
+ 	 * All states that get here take the same way, or the pass starts again.
+ 	 * A speculative state does not select the way.
+ 	 */
+ 	if (env->cur_state->speculative)
+ 		goto out;
+ 	if (aux->guard_at_header && !aux->guard_unset_reg && guard_reads_unset_r=
eg(env, aux)) {
+ 		aux->guard_unset_reg =3D true;
+ 		env->guards_late |=3D aux->guard_no_unwind && aux->loop_guard;
+ 		aux->guard_no_unwind =3D false;
+ 	}
+ 	if (!aux->guard_no_unwind &&
+ 	    !state_can_unwind(env, env->cur_state, aux->guard_unset_reg)) {
+ 		env->guards_late |=3D aux->loop_guard;
+ 		aux->guard_no_unwind =3D true;
+ 	}
+ 	/* another state selected the target, possibly a state that only a join =
makes */
+ 	env->run_has_guess |=3D aux->guard_no_unwind &&
+ 			      state_can_unwind(env, env->cur_state, aux->guard_unset_reg);
+ out:
+ 	aux->loop_guard =3D true;
+ 	aux->guard_unwinds =3D !aux->guard_no_unwind;
+ 	if (aux->guard_no_unwind)
+ 		err =3D PTR_ERR_OR_ZERO(push_stack(env, aux->guard_to, env->insn_idx, f=
alse));
+ 	else
+ 		err =3D push_unwind_exit(env);
+ 	/* more peeled trips can show that the edge is dead */
+ 	if (!err && env->head)
+ 		env->head->st.suspect_loops |=3D loop->suspect_bit;
+ 	return err;
+ }
+=20
+ /* The states that the insn pushed go where they were pushed to. */
+ static int flow_drain(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_verifier_stack_elem *elem;
+ 	int err =3D 0;
+=20
+ 	while ((elem =3D env->head)) {
+ 		env->head =3D elem->next;
+ 		if (!err)
+ 			err =3D bpf_flow_deliver(env, &elem->st, elem->insn_idx,
+ 					       elem->prev_insn_idx, elem->again);
+ 		bpf_free_verifier_state(env, &elem->st, false);
+ 		kfree(elem);
+ 	}
+ 	return err;
+ }
+=20
+ /*
+  * A subprog on a cycle of the call graph checks the stack at run time, s=
ee
+  * bpf_insert_recursion_checks(). When there is no room, or the time slic=
e is over, it leaves
+  * at once with 0 in place of the result: it unwinds if it can, see bail_=
unwinds, otherwise
+  * it returns and callers have to be fine with that.
+  */
+ static int check_recursion_guard(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_subprog_info *sub =3D &env->subprog_info[cur_func(env)->subpr=
ogno];
+=20
+ 	if (!sub->recursive || env->insn_idx !=3D sub->start)
+ 		return 0;
+ 	return push_unwind_exit(env);
+ }
+=20
+ static bool is_error_of_state(struct bpf_verifier_env *env, int err)
+ {
+ 	return err !=3D -ENOMEM && err !=3D -EINTR && !env->over_limit && !env->=
bug;
+ }
+=20
+ /* The pass has an error. The log ends with the first error. */
+ static void note_error(struct bpf_verifier_env *env, int err)
+ {
+ 	if (!is_error_of_state(env, err))
+ 		return;
+ 	if (!env->err) {
+ 		env->err =3D err;
+ 		env->err_insn =3D env->insn_idx;
+ 		env->log.level =3D 0;
+ 		env->pass_max_cost =3D min(env->pass_max_cost, bpf_pass_max_cost(env));
+ 	}
+ 	if (!env->path_sensitive)
+ 		bpf_note_unproven_insn(env, env->cur_state, env->insn_idx);
+ }
+=20
+ /* An error in a speculative state is no error */
+ static bool nospec_ends_path(struct bpf_verifier_env *env,
+ 			     const struct bpf_verifier_state *st, int err)
+ {
+ 	return st->speculative && err < 0 && is_error_of_state(env, err);
+ }
+=20
+ /* @st cannot take the edge to or from @idx. Returns 1 if only its path e=
nds. */
+ int bpf_flow_edge_unproven(struct bpf_verifier_env *env, struct bpf_verif=
ier_state *st, u32 idx,
+ 			   int err)
+ {
+ 	bool last;
+=20
+ 	if (nospec_ends_path(env, st, err)) {
+ 		need_nospec(env, idx);
+ 		return 1;
+ 	}
+ 	swap(env->insn_idx, idx);
+ 	last =3D !error_is_recoverable(err) || env->path_sensitive || bpf_same_i=
nsns_unproven(env);
+ 	swap(env->cur_state, st);
+ 	if (!env->path_sensitive)
+ 		note_error(env, err);
+ 	env->cur_state =3D st;
+ 	if (last)
+ 		return err;
+ 	env->insn_idx =3D idx;
+ 	return 1;
+ }
+=20
+ /* The call releases, locks, or makes a dynptr, an iterator or an irq fla=
g */
+ static bool call_writes_held(struct bpf_verifier_env *env, const struct b=
pf_insn *insn)
+ {
+ 	const struct bpf_func_proto *fn =3D NULL;
+ 	struct bpf_kfunc_desc *desc;
+ 	enum bpf_arg_type type;
+ 	int i;
+=20
+ 	if (bpf_helper_call(insn)) {
+ 		bpf_get_helper_proto(env, insn->imm, &fn);
+ 	} else {
+ 		desc =3D find_kfunc_desc(env, insn->imm, insn->off);
+ 		fn =3D desc ? &desc->proto : NULL;
+ 	}
+ 	for (i =3D 0; fn && i < MAX_BPF_FUNC_REG_ARGS; i++) {
+ 		/* nothing is held for a pointer that an unproven insn made up */
+ 		if (cur_regs(env)[BPF_REG_1 + i].type =3D=3D SCALAR_VALUE)
+ 			continue;
+ 		type =3D fn->arg_type[i];
+ 		if (arg_type_is_release(type) || (arg_type_is_dynptr(type) && (type & M=
EM_UNINIT)))
+ 			return true;
+ 		switch (base_type(type)) {
+ 		case ARG_PTR_TO_SPIN_LOCK:
+ 		case ARG_PTR_TO_RES_SPIN_LOCK:
+ 		case ARG_PTR_TO_IRQ_FLAG:
+ 		case ARG_PTR_TO_ITER:
+ 		case ARG_PTR_TO_LIST_NODE:
+ 		case ARG_PTR_TO_RB_NODE:
+ 			return true;
+ 		default:
+ 			break;
+ 		}
+ 	}
+ 	return false;
+ }
+=20
+ /*
+  * Continue as if @insn is proven, to find the other unproven insns of th=
e pass.
+  * If it changes what is held, the next errors follow from this one, so t=
he path ends.
+  * Returns 0 if the path continues.
+  */
+ static int skip_unproven_insn(struct bpf_verifier_env *env, const struct =
bpf_insn *insn)
+ {
+ 	struct bpf_func_state *frame =3D cur_func(env);
+ 	struct bpf_reg_state *regs =3D cur_regs(env);
+ 	u16 def =3D cur_aux(env)->def_regs;
+ 	u8 class =3D BPF_CLASS(insn->code), *type;
+ 	int i, spi;
+=20
+ 	if (bpf_insn_is_cond_jump(insn->code))
+ 		return PTR_ERR_OR_ZERO(push_stack(env, env->insn_idx + insn->off + 1,
+ 						  env->insn_idx, false));
+ 	if (class =3D=3D BPF_LD || ((class =3D=3D BPF_JMP || class =3D=3D BPF_JM=
P32) &&
+ 				!bpf_helper_call(insn) && !bpf_pseudo_kfunc_call(insn)))
+ 		return PROCESS_BPF_EXIT;
+ 	if (class =3D=3D BPF_JMP && call_writes_held(env, insn))
+ 		return PROCESS_BPF_EXIT;
+ 	/* what it stores can be read */
+ 	for_each_set_bit(spi, cur_aux(env)->may_write_mask, bpf_stack_nr_slots(f=
rame)) {
+ 		type =3D bpf_stack_slot(frame, spi)->slot_type;
+ 		for (i =3D 0; i < BPF_REG_SIZE; i++)
+ 			if (type[i] =3D=3D STACK_INVALID || type[i] =3D=3D STACK_POISON)
+ 				type[i] =3D STACK_MISC;
+ 	}
+ 	for (i =3D BPF_REG_0; i < BPF_REG_FP; i++) {
+ 		if (!(def & BIT(i)))
+ 			continue;
+ 		if (class =3D=3D BPF_JMP && i)
+ 			bpf_mark_reg_not_init(env, &regs[i]);
+ 		else
+ 			mark_reg_unknown(env, regs, i);
+ 	}
+ 	leave_callback(frame);
+ 	return 0;
+ }
+=20
+ /* These decide where the program can be attached, or what it reads */
+ struct prog_requirements {
+ 	u32 val[12];
+ };
+=20
+ static struct prog_requirements get_prog_requirements(struct bpf_verifier=
_env *env)
+ {
+ 	const struct bpf_prog *prog =3D env->prog;
+ 	const struct bpf_prog_aux *aux =3D prog->aux;
+=20
+ 	return (struct prog_requirements){{
+ 		env->ops->convert_ctx_access ? 0 : aux->max_ctx_offset,
+ 		aux->max_tp_access, aux->max_rdonly_access, aux->max_rdwr_access,
+ 		aux->min_rdwr_write, aux->max_rdwr_write, aux->kprobe_write_ctx,
+ 		prog->type =3D=3D BPF_PROG_TYPE_EXT && env->seen_direct_write,
+ 		prog->type =3D=3D BPF_PROG_TYPE_PERF_EVENT && prog->call_get_stack,
+ 		prog->tstamp_type_access, prog->kprobe_override, prog->enforce_expected=
_attach_type,
+ 	}};
+ }
+=20
+ static void free_pushed_states(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_verifier_stack_elem *elem;
+=20
+ 	while ((elem =3D env->head)) {
+ 		env->head =3D elem->next;
+ 		bpf_free_verifier_state(env, &elem->st, false);
+ 		kfree(elem);
+ 	}
+ }
+=20
+ /*
+  * A load with a range of offsets makes a number of the pointers that are=
 spilled there. If an
+  * insn needed a pointer and got that number, load each slot in its own s=
tate:
+  *	char *p[2] =3D { a, b };
+  *	return p[i & 1][63];
+  * Other loads keep the number: 'sum +=3D word[i]' fails for a pointer.
+  */
+ static int fork_stack_load(struct bpf_verifier_env *env, const struct bpf=
_insn *insn,
+ 			   unsigned long ranges)
+ {
+ 	struct bpf_verifier_state *st =3D env->cur_state, *part;
+ 	DECLARE_BITMAP(slots, MAX_BPF_XREG) =3D {};
+ 	u32 regno =3D insn->src_reg, xregno, last;
+ 	struct bpf_stack_state *slot;
+ 	struct bpf_func_state *frame;
+ 	struct bpf_reg_state *reg;
+ 	struct scalar value =3D {};
+ 	bool has_ptr =3D false, needs_ptr;
+ 	s64 min_off, max_off;
+ 	int spi;
+=20
+ 	/* the cpu can speculate with the address of another state */
+ 	if (insn->code !=3D (BPF_LDX | BPF_MEM | BPF_DW) || !(ranges & BIT(regno=
)) ||
+ 	    cur_regs(env)[regno].type !=3D PTR_TO_STACK || !env->bypass_spec_v1)
+ 		return 0;
+ 	/* without allow_ptr_leaks the load fails */
+ 	needs_ptr =3D !env->allow_ptr_leaks || bpf_insn_makes_ptr(env);
+ 	reg =3D &cur_regs(env)[regno];
+ 	frame =3D bpf_func(env, reg);
+ 	min_off =3D reg_smin(reg) + insn->off;
+ 	max_off =3D reg_smax(reg) + insn->off;
+ 	if (offset_is_far(reg) || min_off < -frame->allocated_stack || max_off >=
=3D 0 ||
+ 	    !tnum_is_aligned(tnum_add(reg->var_off, tnum_const(insn->off)), BPF_=
REG_SIZE))
+ 		return 0;
+ 	bpf_add_cost(env, (max_off - min_off) / BPF_REG_SIZE, BPF_COST_XREG);
+ 	for (spi =3D bpf_get_spi(max_off); spi <=3D bpf_get_spi(min_off); spi++)=
 {
+ 		scalar_set_const(&value, -(spi + 1) * BPF_REG_SIZE - insn->off);
+ 		if (!scalar_subsumes(scalar_of(reg), &value))
+ 			continue;
+ 		slot =3D bpf_stack_slot(frame, spi);
+ 		__set_bit(bpf_spi_to_xreg(spi), slots);
+ 		has_ptr |=3D bpf_is_spilled_reg(slot) && !bpf_is_spilled_scalar_reg(slo=
t);
+ 	}
+ 	if (!has_ptr)
+ 		return 0;
+ 	env->imprecise |=3D !env->err;
+ 	if (!needs_ptr)
+ 		return 0;
+ 	/* no run has to load from all slots */
+ 	env->extra_values =3D true;
+ 	if (env->log.level & BPF_LOG_LEVEL)
+ 		verbose(env, "fork R%d\n", regno);
+ 	mark_reg_scratched(env, regno);
+ 	last =3D find_last_bit(slots, MAX_BPF_XREG);
+ 	for_each_set_bit(xregno, slots, MAX_BPF_XREG) {
+ 		part =3D xregno =3D=3D last ? st : push_stack(env, env->insn_idx, env->=
insn_idx, false);
+ 		if (IS_ERR(part))
+ 			return PTR_ERR(part);
+ 		spi =3D bpf_xreg_to_spi(xregno);
+ 		scalar_set_const(scalar_of(&part->frame[part->curframe]->regs[regno]),
+ 				 -(spi + 1) * BPF_REG_SIZE - insn->off);
+ 		bpf_equations_refine_by_reg(env, part, regno);
+ 		if (part !=3D st)
+ 			env->head->again =3D true;
+ 	}
+ 	return 0;
+ }
+=20
+ /* Process the current state until it gets to the start of a basic block.=
 */
+ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
  {
- 	bool pop_log =3D !(env->log.level & BPF_LOG_LEVEL2);
  	struct bpf_verifier_state *state =3D env->cur_state;
+ 	struct bpf_verifier_stack_elem *elem;
  	struct bpf_insn *insns =3D env->prog->insnsi;
  	int insn_cnt =3D env->prog->len;
- 	bool do_print_state =3D false;
- 	int prev_insn_idx =3D -1;
+ 	bool do_print_state =3D true, from_unproven;
+ 	struct prog_requirements prog_requirements, new_requirements;
+ 	bool again =3D prev_insn_idx =3D=3D env->insn_idx;
+ 	unsigned long ranges;
+ 	bool stack_args;
+ 	u32 held;
 =20
+ 	mark_verifier_state_scratched(env);
  	for (;;) {
  		struct bpf_insn *insn;
  		struct bpf_insn_aux_data *insn_aux;
+ 		struct bpf_insn_fixups fixups;
  		int err;
 =20
- 		if (signal_pending(current))
- 			return -EAGAIN;
-=20
- 		cond_resched_tasks_rcu_qs();
-=20
- 		/* reset current history entry on each new instruction */
- 		env->cur_hist_ent =3D NULL;
+ 		err =3D bpf_check_limits(env);
+ 		if (err)
+ 			return err;
 =20
  		env->prev_insn_idx =3D prev_insn_idx;
  		if (env->insn_idx >=3D insn_cnt) {
@@@ -20671,18 -21732,10 +21750,10 @@@
 =20
  		account_processed_insn(env);
 =20
- 		if (env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
- 			verbose(env,
- 				"BPF program is too large. Processed %d insn\n",
- 				env->insn_processed);
- 			return -E2BIG;
- 		}
-=20
  		state->last_insn_idx =3D env->prev_insn_idx;
  		state->insn_idx =3D env->insn_idx;
  		/*
- 		 * Record the incoming edge so active and queued paths use the same
- 		 * branch-recording path. A zero-offset conditional has identical
+ 		 * Record the incoming edge. A zero-offset conditional has identical
  		 * successors, so its outcome cannot be reconstructed from the edge.
  		 */
  		if (!state->speculative && prev_insn_idx >=3D 0 && prev_insn_idx < insn=
_cnt) {
@@@ -20702,40 -21755,6 +21773,6 @@@
  			}
  		}
 =20
- 		/*
- 		 * Possibly widen the registers before creating a checkpoint
- 		 * in bpf_is_state_visited(). The next loop iteration will
- 		 * have a chance to hit this checkpoint and converge.
- 		 */
- 		err =3D handle_loop_entry_exit(env);
- 		if (err)
- 			return err;
-=20
- 		if (bpf_is_prune_point(env, env->insn_idx)) {
- 			err =3D bpf_is_state_visited(env, env->insn_idx);
- 			if (err < 0)
- 				return err;
- 			if (err =3D=3D 1) {
- 				/* found equivalent state, can prune the search */
- 				if (env->log.level & BPF_LOG_LEVEL) {
- 					if (do_print_state)
- 						verbose(env, "\nfrom %d to %d%s: safe\n",
- 							env->prev_insn_idx, env->insn_idx,
- 							env->cur_state->speculative ?
- 							" (speculative execution)" : "");
- 					else
- 						verbose(env, "%d: safe\n", env->insn_idx);
- 				}
- 				goto process_bpf_exit;
- 			}
- 		}
-=20
- 		if (bpf_is_jmp_point(env, env->insn_idx)) {
- 			err =3D bpf_push_jmp_history(env, state, 0, 0, 0, NULL, 0);
- 			if (err)
- 				return err;
- 		}
-=20
  		if (env->log.level & BPF_LOG_LEVEL2 && do_print_state) {
  			verbose(env, "\nfrom %d to %d%s:",
  				env->prev_insn_idx, env->insn_idx,
@@@ -20745,13 -21764,6 +21782,6 @@@
  			do_print_state =3D false;
  		}
 =20
- 		if (bpf_loop_at_index(env, env->insn_idx) >=3D 0 &&
- 		    cur_func(env)->loop_stack_cnt =3D=3D 0) {
- 			verifier_bug(env, "loop stack empty at %d, while inside the loop %d\n",
- 				     env->insn_idx, bpf_loop_at_index(env, env->insn_idx));
- 			return -EFAULT;
- 		}
-=20
  		if (env->log.level & BPF_LOG_LEVEL) {
  			if (verifier_state_scratched(env))
  				print_insn_state(env, state, state->curframe);
@@@ -20765,18 -21777,23 +21795,23 @@@
  			env->prev_log_pos =3D env->log.end_pos;
  		}
 =20
- 		if (bpf_prog_is_offloaded(env->prog->aux)) {
+ 		if (env->replay) {
  			err =3D bpf_prog_offload_verify_insn(env, env->insn_idx,
  							   env->prev_insn_idx);
  			if (err)
  				return err;
+ 		} else if (bpf_prog_is_offloaded(env->prog->aux)) {
+ 			/* the driver cannot forget what an imprecise state shows */
+ 			note_pessimized_insn(env, env->insn_idx);
  		}
 =20
  		sanitize_mark_insn_seen(env);
+ 		insn_aux->suspect_loops |=3D state->suspect_loops;
  		prev_insn_idx =3D env->insn_idx;
 =20
  		/* Sanity check: precomputed constants must match verifier state */
- 		if (!state->speculative && insn_aux->const_reg_mask) {
+ 		if (!state->speculative && !env->err && !env->extra_values &&
+ 		    insn_aux->const_reg_mask) {
  			struct bpf_reg_state *regs =3D cur_regs(env);
  			u16 mask =3D insn_aux->const_reg_mask;
 =20
@@@ -20799,69 -21816,178 +21834,178 @@@
  		/* Reduce verification complexity by stopping speculative path
  		 * verification when a nospec is encountered.
  		 */
+ 		if (state->speculative && insn_aux->non_speculative_first)
+ 			need_nospec(env, env->insn_idx);
  		if (state->speculative && insn_aux->nospec)
  			goto process_bpf_exit;
+ 		insn_aux->speculative_first |=3D !insn_aux->seen;
 =20
- 		err =3D do_check_insn(env, &do_print_state);
- 		if (error_recoverable_with_nospec(err) && state->speculative) {
+ 		ranges =3D operands_with_range(env, insn);
+ 		stack_args =3D cur_func(env)->out_stack_arg_cnt;
+=20
+ 		err =3D check_loop_guard(env) ?: check_recursion_guard(env);
+ 		err =3D err ?: fork_stack_load(env, insn, ranges);
+ 		if (err)
+ 			return err;
+=20
+ 		bpf_equations_before_insn(env);
+ 		held =3D held_cnt(state);
+ 		from_unproven =3D reads_from_unproven(env);
+ 		fixups =3D insn_aux->fixups;
+ 		prog_requirements =3D get_prog_requirements(env);
+ 		env->no_report =3D state->speculative;
+ 		err =3D do_check_insn(env, &do_print_state) ?: bpf_equations_after_insn=
(env);
+ 		env->no_report =3D false;
+ 		new_requirements =3D get_prog_requirements(env);
+ 		/* a join adds values only to a range */
+ 		if ((ranges || stack_args || again) &&
+ 		    memcmp(&prog_requirements, &new_requirements, sizeof(new_requiremen=
ts)))
+ 			note_pessimized_insn(env, prev_insn_idx);
+ 		/* a call or an exit gave the state to the flow, the error is from ther=
e */
+ 		if (err < 0 && !state->frame[0])
+ 			return err;
+ 		insn_aux->releases |=3D held_cnt(state) < held && err !=3D PROCESS_BPF_=
EXIT;
+ 		insn_aux->acquires |=3D held_cnt(state) > held;
+ 		if (nospec_ends_path(env, state, err)) {
  			/* Prevent this speculative path from ever reaching the
  			 * insn that would have been unsafe to execute.
+ 			 * What it noted does not apply to the other paths.
+ 			 * check_fastcall_stack_contract() clears the pattern only once.
  			 */
- 			insn_aux->nospec =3D true;
- 			/* If it was an ADD/SUB insn, potentially remove any
- 			 * markings for alu sanitization.
- 			 */
- 			insn_aux->alu_state =3D 0;
+ 			fixups.fastcall_spills_num =3D insn_aux->fastcall_spills_num;
+ 			insn_aux->fixups =3D fixups;
+ 			need_nospec(env, prev_insn_idx);
+ 			free_pushed_states(env);
  			goto process_bpf_exit;
+ 		} else if (error_is_recoverable(err) && !env->path_sensitive) {
+ 			env->insn_idx =3D prev_insn_idx;
+ 			if (bpf_same_insns_unproven(env))
+ 				return err;
+ 			if (from_unproven)
+ 				bpf_note_reads_from_unproven(env, prev_insn_idx);
+ 			else
+ 				note_error(env, err);
+ 			err =3D skip_unproven_insn(env, insn);
+ 			if (err < 0)
+ 				return err;
+ 			if (err)
+ 				goto process_bpf_exit;
+ 			mark_from_unproven(env, prev_insn_idx, true);
+ 			env->insn_idx++;
  		} else if (err < 0) {
  			return err;
  		} else if (err =3D=3D PROCESS_BPF_EXIT) {
  			goto process_bpf_exit;
  		} else if (err =3D=3D INSN_IDX_UPDATED) {
  		} else if (err =3D=3D 0) {
+ 			if (!bpf_pseudo_call(insn) && !bpf_is_callx(insn))
+ 				mark_from_unproven(env, prev_insn_idx, from_unproven);
  			env->insn_idx++;
  		}
 =20
- 		if (state->speculative && insn_aux->nospec_result) {
- 			/* If we are on a path that performed a jump-op, this
- 			 * may skip a nospec patched-in after the jump. This can
- 			 * currently never happen because nospec_result is only
- 			 * used for the write-ops
- 			 * `*(size*)(dst_reg+off)=3Dsrc_reg|imm32` and helper
- 			 * calls. These must never skip the following insn
- 			 * (i.e., bpf_insn_successors()'s opcode_info.can_jump
- 			 * is false). Still, add a warning to document this in
- 			 * case nospec_result is used elsewhere in the future.
- 			 *
- 			 * All non-branch instructions have a single
- 			 * fall-through edge. For these, nospec_result should
- 			 * already work.
- 			 */
- 			if (verifier_bug_if((BPF_CLASS(insn->code) =3D=3D BPF_JMP ||
- 					     BPF_CLASS(insn->code) =3D=3D BPF_JMP32) &&
- 					    BPF_OP(insn->code) !=3D BPF_CALL, env,
- 					    "speculation barrier after jump instruction may not have the des=
ired effect"))
- 				return -EFAULT;
+ 		/* only a store that stays gets it, see bpf_convert_ctx_accesses() */
+ 		if (state->speculative && insn_aux->nospec_result && !insn_aux->fastcal=
l_pattern &&
+ 		    bpf_is_mem_insn(insn) && BPF_MODE(insn->code) =3D=3D BPF_MEM) {
  process_bpf_exit:
  			account_current_path(env);
- 			mark_verifier_state_scratched(env);
- 			err =3D bpf_update_branch_counts(env, env->cur_state);
- 			if (err)
- 				return err;
- 			err =3D pop_stack(env, &prev_insn_idx, &env->insn_idx,
- 					pop_log);
- 			if (err < 0) {
- 				if (err !=3D -ENOENT)
- 					return err;
- 				break;
- 			} else {
- 				do_print_state =3D true;
- 				continue;
- 			}
+ 			bpf_free_verifier_state(env, state, false);
+ 			memset(state, 0, sizeof(*state));
+ 			return flow_drain(env);
+ 		}
+=20
+ 		/* if the insn pushed a part, the current state is a part too */
+ 		for (elem =3D env->head; elem; elem =3D elem->next)
+ 			again |=3D elem->again;
+ 		err =3D flow_drain(env);
+ 		if (err)
+ 			return err;
+=20
+ 		/* the parts of a state meet at the next insn */
+ 		if (env->insn_idx < insn_cnt &&
+ 		    (again || bpf_flow_is_bb_start(env, env->insn_idx))) {
+ 			account_current_path(env);
+ 			return bpf_flow_deliver(env, state, env->insn_idx, prev_insn_idx, fals=
e);
  		}
  	}
+ }
 =20
- 	return 0;
+ /* What the pass assumed about loops does not hold, see do_check_all() */
+ static bool pass_needs_restart(struct bpf_verifier_env *env)
+ {
+ 	return (env->restart && bpf_flow_loops_lost_bound(env)) || env->guards_l=
ate;
+ }
+=20
+ /*
+  * The loops that keep the current state apart pay for the work since the=
 last state, but not
+  * a loop that the state enters. A trip that is peeled on the budget of a=
 loop belongs to that
+  * loop. Such trips can use up the budget of an inner loop.
+  */
+ static void charge_loops(struct bpf_verifier_env *env, u64 cost)
+ {
+ 	const struct bpf_verifier_state *st =3D env->cur_state;
+ 	const struct loop_stack_entry *e;
+ 	struct bpf_loop *starved_loop =3D NULL;
+ 	int fr, i;
+=20
+ 	for (fr =3D st->curframe; env->pass && fr >=3D 0; fr--) {
+ 		for (i =3D st->frame[fr]->loop_stack_cnt - 1; i >=3D 0; i--) {
+ 			e =3D &st->frame[fr]->loop_stack[i];
+ 			if ((e->peeled || e->loop->disjoint_apart) &&
+ 			    (e->trip || e->loop->header !=3D st->insn_idx))
+ 				e->loop->this_pass.cost +=3D cost;
+ 			if (e->peeled && e->trip >=3D e->loop->peel_cnt) {
+ 				if (starved_loop && e->loop->partitioned)
+ 					starved_loop->this_pass.starved =3D
+ 						e->loop->this_pass.starves =3D true;
+ 				return;
+ 			}
+ 			if (e->loop->partitioned && !bpf_loop_has_budget(e->loop))
+ 				starved_loop =3D e->loop;
+ 		}
+ 	}
+ }
+=20
+ static int do_check(struct bpf_verifier_env *env)
+ {
+ 	bool level2 =3D env->log.level & BPF_LOG_LEVEL2;
+ 	u64 log_pos =3D env->log.end_pos, diag_pos =3D 0;
+ 	u64 cost =3D env->cost;
+ 	int prev_insn_idx, err;
+=20
+ 	err =3D bpf_flow_deliver(env, env->cur_state, env->insn_idx, -1, false);
+ 	while (!err && !(env->path_sensitive && env->cost >=3D env->failing_path=
_max_cost)) {
+ 		err =3D bpf_flow_next(env, &prev_insn_idx, &log_pos, &diag_pos);
+ 		/* at the limit the work on equations is not complete, such a pass prov=
es nothing */
+ 		if (err =3D=3D -ENOENT)
+ 			return bpf_check_limits(env);
+ 		if (err)
+ 			break;
+ 		charge_loops(env, env->cost - cost);
+ 		cost =3D env->cost;
+ 		/* A pass logs one basic block at a time. A path-sensitive run logs a f=
ull path. */
+ 		bpf_diag_event_log_restore(env, diag_pos);
+ 		if (!level2) {
+ 			bpf_vlog_reset(&env->log, log_pos);
+ 			env->prev_linfo =3D NULL;
+ 		}
+ 		err =3D do_check_block(env, prev_insn_idx);
+ 		if (env->bug)
+ 			return -EFAULT;
+ 		/* a pass had no error at this insn, possibly with a state that has mor=
e values */
+ 		if (err && env->path_sensitive && is_error_of_state(env, err) &&
+ 		    (env->cur_state->infeasible || env->cur_state->equations.infeasible=
 ||
+ 		     !bpf_failing_path_may_end_at(env, env->insn_idx))) {
+ 			bpf_free_verifier_state(env, env->cur_state, false);
+ 			memset(env->cur_state, 0, sizeof(*env->cur_state));
+ 			free_pushed_states(env);
+ 			err =3D 0;
+ 		}
+ 	}
+ 	/* bpf_flow_edge_unproven() noted it with the state that failed */
+ 	if (err && !bpf_insn_is_unproven(env))
+ 		note_error(env, err);
+ 	env->run_over_budget |=3D !err;
+ 	return err;
  }
 =20
  static int find_btf_percpu_datasec(struct btf *btf)
@@@ -20899,26 -22025,21 +22043,21 @@@ static int __add_used_btf(struct bpf_=
ve
  {
  	struct btf_mod_pair *btf_mod;
  	int ret =3D 0;
- 	int i;
 =20
  	/* check whether we recorded this BTF (and maybe module) already */
- 	for (i =3D 0; i < env->used_btf_cnt; i++)
- 		if (env->used_btfs[i].btf =3D=3D btf)
- 			goto ret_put;
+ 	if (bpf_index_find(&env->used_index, (unsigned long)btf) >=3D 0)
+ 		goto ret_put;
 =20
  	if (env->signature) {
  		verbose(env, "signed program cannot bind any BTF\n");
  		ret =3D -EACCES;
  		goto ret_put;
  	}
- 	if (env->used_btf_cnt >=3D MAX_USED_BTFS) {
- 		verbose(env, "The total number of btfs per program has reached the limi=
t of %u\n",
- 			MAX_USED_BTFS);
- 		ret =3D -E2BIG;
+ 	btf_mod =3D bpf_table_next(env->used_btfs, env->used_btf_cnt);
+ 	if (!btf_mod) {
+ 		ret =3D -ENOMEM;
  		goto ret_put;
  	}
-=20
- 	btf_mod =3D &env->used_btfs[env->used_btf_cnt];
  	btf_mod->btf =3D btf;
  	btf_mod->module =3D NULL;
 =20
@@@ -20931,8 -22052,7 +22070,7 @@@
  		}
  	}
 =20
- 	env->used_btf_cnt++;
- 	return 0;
+ 	return bpf_index_add(&env->used_index, (unsigned long)btf, env->used_btf=
_cnt++);
 =20
  ret_put:
  	/* Either error or this BTF was already added */
@@@ -20994,12 -22114,6 +22132,12 @@@ static int __check_pseudo_btf_id(struc
  		}
  	}
 =20
 +	if (!percpu && !env->allow_ptr_leaks) {
 +		verbose(env, "access to '%s' is allowed only to CAP_PERFMON and CAP_SYS=
_ADMIN\n",
 +			sym_name);
 +		return -EPERM;
 +	}
 +
  	type =3D t->type;
  	t =3D btf_type_skip_modifiers(btf, type, NULL);
  	if (percpu) {
@@@ -21045,11 -22159,6 +22183,11 @@@ static int check_pseudo_btf_id(struct b
  			verbose(env, "invalid module BTF object FD specified.\n");
  			return -EINVAL;
  		}
 +		if (!btf_is_kernel(btf)) {
 +			verbose(env, "BTF fd for ksym is not a kernel BTF\n");
 +			btf_put(btf);
 +			return -EINVAL;
 +		}
  	} else {
  		if (!btf_vmlinux) {
  			verbose(env, "kernel is missing BTF, make sure CONFIG_DEBUG_INFO_BTF=
=3Dy is specified in Kconfig.\n");
@@@ -21236,6 -22345,8 +22374,8 @@@ static int claim_used_maps(struct bpf_v
 =20
  		if (map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY)
  			continue;
+ 		if (!bpf_table_next(env->insn_array_maps, env->insn_array_map_cnt))
+ 			return -ENOMEM;
  		err =3D bpf_insn_array_init(map, env->prog);
  		if (err) {
  			verbose(env, "Failed to properly initialize insn array\n");
@@@ -21249,12 -22360,13 +22389,13 @@@
 =20
  static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *m=
ap)
  {
+ 	struct bpf_map *inner =3D map->inner_map_meta ?: map;
  	int i, err;
 =20
  	/* check whether we recorded this map already */
- 	for (i =3D 0; i < env->used_map_cnt; i++)
- 		if (env->used_maps[i] =3D=3D map)
- 			return i;
+ 	i =3D bpf_index_find(&env->used_index, (unsigned long)map);
+ 	if (i >=3D 0)
+ 		return i;
 =20
  	if (env->signature &&
  	    env->prog->aux->sig.verdict =3D=3D BPF_SIG_VERIFIED) {
@@@ -21262,16 -22374,17 +22403,17 @@@
  			map->name);
  		return -EACCES;
  	}
- 	if (env->used_map_cnt >=3D MAX_USED_MAPS) {
- 		verbose(env, "The total number of maps per program has reached the limi=
t of %u\n",
- 			MAX_USED_MAPS);
- 		return -E2BIG;
- 	}
 =20
  	err =3D check_map_prog_compatibility(env, map, env->prog);
  	if (err)
  		return err;
 =20
+ 	if (!bpf_table_next(env->used_maps, env->used_map_cnt) ||
+ 	    bpf_index_add(&env->used_index, (unsigned long)map, env->used_map_cn=
t))
+ 		return -ENOMEM;
+ 	env->max_key_size =3D max3(env->max_key_size, map->key_size, inner->key_=
size);
+ 	env->max_value_size =3D max3(env->max_value_size, map->value_size, inner=
->value_size);
+=20
  	if (bpf_prog_runs_sleepable(env->prog))
  		atomic64_inc(&map->sleepable_refcnt);
 =20
@@@ -21347,6 -22460,31 +22489,31 @@@ static int fd_array_get_map_idx(struct=
=20
  	return -EPROTO;
  }
 =20
+ static bool is_valid_alu_variant(const struct bpf_insn *insn)
+ {
+ 	switch (BPF_OP(insn->code)) {
+ 	case BPF_MUL:
+ 		return insn->off =3D=3D 0 || bpf_insn_is_hmul(insn);
+ 	case BPF_DIV:
+ 	case BPF_MOD:
+ 		/* off =3D=3D 1 selects SDIV/SMOD. */
+ 		return insn->off =3D=3D 0 || insn->off =3D=3D 1;
+ 	default:
+ 		return insn->off =3D=3D 0;
+ 	}
+ }
+=20
+ /* The interpreter supports uhmul and shmul. JITs opt in. */
+ static int check_hmul_jit(struct bpf_verifier_env *env)
+ {
+ 	if (bpf_prog_is_offloaded(env->prog->aux) ||
+ 	    (env->prog->jit_requested && !bpf_jit_supports_hmul())) {
+ 		verbose(env, "JIT doesn't support uhmul and shmul\n");
+ 		return -EOPNOTSUPP;
+ 	}
+ 	return 0;
+ }
+=20
  static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn=
 *insn)
  {
  	u8 class =3D BPF_CLASS(insn->code);
@@@ -21402,18 -22540,14 +22569,14 @@@
  	case BPF_MUL:
  	case BPF_DIV:
  	case BPF_MOD:
- 		if (BPF_SRC(insn->code) =3D=3D BPF_X) {
- 			if (insn->imm !=3D 0 || (insn->off !=3D 0 && insn->off !=3D 1) ||
- 			    (insn->off =3D=3D 1 && opcode !=3D BPF_MOD && opcode !=3D BPF_DIV)=
) {
- 				verbose(env, "BPF_ALU uses reserved fields\n");
- 				return -EINVAL;
- 			}
- 		} else if (insn->src_reg !=3D BPF_REG_0 ||
- 			   (insn->off !=3D 0 && insn->off !=3D 1) ||
- 			   (insn->off =3D=3D 1 && opcode !=3D BPF_MOD && opcode !=3D BPF_DIV))=
 {
+ 		if (!is_valid_alu_variant(insn) ||
+ 		    (BPF_SRC(insn->code) =3D=3D BPF_X && insn->imm !=3D 0) ||
+ 		    (BPF_SRC(insn->code) =3D=3D BPF_K && insn->src_reg !=3D BPF_REG_0))=
 {
  			verbose(env, "BPF_ALU uses reserved fields\n");
  			return -EINVAL;
  		}
+ 		if (bpf_insn_is_hmul(insn))
+ 			return check_hmul_jit(env);
  		return 0;
  	default:
  		verbose(env, "invalid BPF_ALU opcode %x\n", opcode);
@@@ -21539,6 -22673,86 +22702,86 @@@ static int check_insn_fields(struct bpf
  	}
  }
 =20
+ static bool jumps_to_arena_sp_adj(struct bpf_insn *insn)
+ {
+ 	u8 class =3D BPF_CLASS(insn->code), op =3D BPF_OP(insn->code);
+=20
+ 	if (class !=3D BPF_JMP && class !=3D BPF_JMP32)
+ 		return false;
+ 	if (op =3D=3D BPF_CALL || op =3D=3D BPF_EXIT || insn->code =3D=3D (BPF_J=
MP | BPF_JA | BPF_X))
+ 		return false;
+ 	return is_arena_sp_adj(insn + bpf_jmp_offset(insn) + 1);
+ }
+=20
+ /*
+  * Find the insns with BPF_REG_ARENA_SP. The sizes of the frames are in t=
he text
+  * of the program.
+  */
+ static int check_arena_stack(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_subprog_info *sub =3D env->subprog_info;
+ 	struct bpf_insn *insn =3D env->prog->insnsi;
+ 	int i;
+=20
+ 	for (i =3D 0; i < env->prog->len; i++, insn++) {
+ 		if (i =3D=3D (sub + 1)->start)
+ 			sub++;
+ 		/* it would be executed again */
+ 		if (jumps_to_arena_sp_adj(insn)) {
+ 			verbose(env, "jump to the insn that changes R%d\n", BPF_REG_ARENA_SP);
+ 			return -EINVAL;
+ 		}
+ 		if (!is_arena_sp_insn(insn))
+ 			continue;
+ 		sub->uses_arena_sp =3D true;
+ 		env->uses_arena_sp =3D true;
+ 		if (!is_arena_sp_adj(insn))
+ 			continue;
+ 		if (i !=3D sub->start) {
+ 			verbose(env, "R%d can be changed by the first insn of a function only\=
n",
+ 				BPF_REG_ARENA_SP);
+ 			return -EINVAL;
+ 		}
+ 		if (insn->imm <=3D 0 || insn->imm % 16 || insn->imm > BPF_ARENA_STACK_M=
AX) {
+ 			verbose(env, "invalid size of the frame in the stack in arena %d\n",
+ 				insn->imm);
+ 			return -EINVAL;
+ 		}
+ 		sub->arena_stack_depth =3D insn->imm;
+ 	}
+ 	if (!env->uses_arena_sp)
+ 		return 0;
+=20
+ 	if (!env->prog->aux->arena) {
+ 		verbose(env, "R%d can only be used in a program that has an associated =
arena\n",
+ 			BPF_REG_ARENA_SP);
+ 		return -EINVAL;
+ 	}
+ 	if (!bpf_jit_supports_arena_stack() || !bpf_jit_supports_percpu_insn() ||
+ 	    bpf_prog_is_offloaded(env->prog->aux)) {
+ 		verbose(env, "JIT doesn't support R%d\n", BPF_REG_ARENA_SP);
+ 		return -EOPNOTSUPP;
+ 	}
+ 	/* bpf_insert_arena_stack() relies on r2-r5 being free when the program =
starts */
+ 	if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT) {
+ 		verbose(env, "R%d is not supported in extension programs\n", BPF_REG_AR=
ENA_SP);
+ 		return -EINVAL;
+ 	}
+ 	/*
+ 	 * It ends the function when the offset is out of the packet. bpf_do_mis=
c_fixups()
+ 	 * emits that exit, after bpf_insert_arena_stack(): the frame wouldn't b=
e dropped
+ 	 * and the stack wouldn't be returned.
+ 	 */
+ 	for (i =3D 0; i < env->subprog_cnt; i++) {
+ 		if (!env->subprog_info[i].has_ld_abs)
+ 			continue;
+ 		verbose(env, "BPF_LD_[ABS|IND] is not allowed in programs that use R%d\=
n",
+ 			BPF_REG_ARENA_SP);
+ 		return -EINVAL;
+ 	}
+ 	return bpf_arena_stack_init(env->prog->aux->arena);
+ }
+=20
  /*
   * Check that insns are sane and rewrite pseudo imm in ld_imm64 instructi=
ons:
   *
@@@ -21559,11 -22773,13 +22802,13 @@@ static int check_and_resolve_insns(st=
ru
 =20
  	for (i =3D 0; i < insn_cnt; i++, insn++) {
  		if (insn->dst_reg >=3D MAX_BPF_REG &&
- 		    !is_stack_arg_st(insn) && !is_stack_arg_stx(insn)) {
+ 		    !is_stack_arg_st(insn) && !is_stack_arg_stx(insn) &&
+ 		    !is_arena_sp_adj(insn) && !is_arena_sp_st(insn)) {
  			verbose(env, "R%d is invalid\n", insn->dst_reg);
  			return -EINVAL;
  		}
- 		if (insn->src_reg >=3D MAX_BPF_REG && !is_stack_arg_ldx(insn)) {
+ 		if (insn->src_reg >=3D MAX_BPF_REG && !is_stack_arg_ldx(insn) &&
+ 		    !is_arena_sp_mov(insn) && !is_arena_sp_ldx(insn)) {
  			verbose(env, "R%d is invalid\n", insn->src_reg);
  			return -EINVAL;
  		}
@@@ -21693,29 -22909,11 +22938,11 @@@ next_insn
  	return claim_used_maps(env);
  }
 =20
- /* that many pointers to functions are recognized in the maps of a progra=
m at most */
- #define BPF_MAX_FUNC_PTRS (1 << 20)
-=20
  static int add_func_ptr(struct bpf_verifier_env *env, struct bpf_map *map=
, u32 map_off,
  			u32 xlated_off)
  {
- 	struct bpf_func_ptr *ptrs;
-=20
- 	if (env->func_ptr_cnt =3D=3D BPF_MAX_FUNC_PTRS) {
- 		verbose(env, "too many pointers to functions in maps, the limit is %d\n=
",
- 			BPF_MAX_FUNC_PTRS);
- 		return -E2BIG;
- 	}
-=20
- 	/* grow by doubling, the array is sorted and searched later */
- 	if (!(env->func_ptr_cnt & (env->func_ptr_cnt - 1))) {
- 		ptrs =3D kvrealloc(env->func_ptrs,
- 				 array_size(max(2 * env->func_ptr_cnt, 16U), sizeof(*ptrs)),
- 				 GFP_KERNEL_ACCOUNT);
- 		if (!ptrs)
- 			return -ENOMEM;
- 		env->func_ptrs =3D ptrs;
- 	}
+ 	if (!bpf_table_next(env->func_ptrs, env->func_ptr_cnt))
+ 		return -ENOMEM;
  	env->func_ptrs[env->func_ptr_cnt++] =3D (struct bpf_func_ptr){
  		.map =3D map,
  		.map_off =3D map_off,
@@@ -21725,6 -22923,11 +22952,11 @@@
  	return 0;
  }
 =20
+ static int cmp_maps(const void *a, const void *b)
+ {
+ 	return cmp_int(*(const unsigned long *)a, *(const unsigned long *)b);
+ }
+=20
  /*
   * Compilers put pointers to functions into read-only data: tables of fun=
ctions,
   * structures of operations, vtables, where they are mixed with other dat=
a.
@@@ -21749,17 -22952,24 +22981,24 @@@
   */
  static int resolve_func_ptrs(struct bpf_verifier_env *env)
  {
+ 	struct bpf_map *map, **maps __free(kvfree) =3D NULL;
  	int insn_cnt =3D env->prog->len;
  	int i, err, subprog;
- 	struct bpf_map *map;
  	u64 addr, val;
  	u32 off;
 =20
- 	if (!env->has_callx || !env->allow_ptr_leaks)
+ 	if (!env->has_callx || !env->allow_ptr_leaks || !env->used_map_cnt)
  		return 0;
 =20
+ 	/* with the maps in order the pointers are in order */
+ 	maps =3D kvmalloc_objs(*maps, env->used_map_cnt, BPF_VERIFIER_GFP);
+ 	if (!maps)
+ 		return -ENOMEM;
+ 	memcpy(maps, env->used_maps, env->used_map_cnt * sizeof(*maps));
+ 	sort(maps, env->used_map_cnt, sizeof(*maps), cmp_maps, NULL);
+=20
  	for (i =3D 0; i < env->used_map_cnt; i++) {
- 		map =3D env->used_maps[i];
+ 		map =3D maps[i];
  		/* coincidences in maps that are shared with other programs don't matte=
r */
  		if (READ_ONCE(map->user) !=3D (unsigned long)env->prog->aux)
  			continue;
@@@ -21771,8 -22981,8 +23010,8 @@@
  			continue;
 =20
  		for (off =3D 0; off + sizeof(u64) <=3D map->value_size; off +=3D sizeof=
(u64)) {
- 			if (!(off % SZ_64K))
- 				cond_resched();
+ 			if (bpf_must_abort())
+ 				return -EINTR;
  			val =3D *(u64 *)(unsigned long)(addr + off);
  			if (!val || val % sizeof(struct bpf_insn) ||
  			    val / sizeof(struct bpf_insn) >=3D insn_cnt)
@@@ -21785,9 -22995,6 +23024,6 @@@
  				return err;
  		}
  	}
- 	if (env->func_ptr_cnt)
- 		sort(env->func_ptrs, env->func_ptr_cnt, sizeof(*env->func_ptrs),
- 		     cmp_func_ptrs, NULL);
  	return 0;
  }
 =20
@@@ -21796,12 -23003,14 +23032,14 @@@ static void release_maps(struct bpf_v=
er
  {
  	__bpf_free_used_maps(env->prog->aux, env->used_maps,
  			     env->used_map_cnt);
+ 	kvfree(env->used_maps);
  }
 =20
  /* drop refcnt of maps used by the rejected program */
  static void release_btfs(struct bpf_verifier_env *env)
  {
  	__bpf_free_used_btfs(env->used_btfs, env->used_btf_cnt);
+ 	kvfree(env->used_btfs);
  }
 =20
  /* convert pseudo BPF_LD_IMM64 into generic BPF_LD_IMM64 */
@@@ -21857,45 -23066,20 +23095,20 @@@ static void sanitize_dead_code(struct=
 b
 =20
  static void free_states(struct bpf_verifier_env *env)
  {
- 	struct bpf_verifier_state_list *sl;
- 	struct list_head *head, *pos, *tmp;
- 	struct bpf_scc_info *info;
- 	int i, j;
-=20
- 	bpf_free_verifier_state(env->cur_state, true);
+ 	bpf_free_verifier_state(env, env->cur_state, true);
  	env->cur_state =3D NULL;
- 	while (!pop_stack(env, NULL, NULL, false));
+ 	free_pushed_states(env);
+ 	bpf_flow_reset(env);
+ }
 =20
- 	list_for_each_safe(pos, tmp, &env->free_list) {
- 		sl =3D container_of(pos, struct bpf_verifier_state_list, node);
- 		bpf_free_verifier_state(&sl->state, false);
- 		kfree(sl);
- 	}
- 	INIT_LIST_HEAD(&env->free_list);
+ /* A multiple of the shortest path. It doubles with each pass. A function=
 gets half. */
+ static u64 func_failing_path_budget(struct bpf_verifier_env *env)
+ {
+ 	u64 hops =3D (bpf_failing_path_hops(env, env->cur_state) + 1ULL) * BPF_C=
OST_STATE;
 =20
- 	for (i =3D 0; i < env->scc_cnt; ++i) {
- 		info =3D env->scc_info[i];
- 		if (!info)
- 			continue;
- 		for (j =3D 0; j < info->num_visits; j++)
- 			bpf_free_backedges(&info->visits[j]);
- 		kvfree(info);
- 		env->scc_info[i] =3D NULL;
- 	}
-=20
- 	if (!env->explored_states)
- 		return;
-=20
- 	for (i =3D 0; i < state_htab_size(env); i++) {
- 		head =3D &env->explored_states[i];
-=20
- 		list_for_each_safe(pos, tmp, head) {
- 			sl =3D container_of(pos, struct bpf_verifier_state_list, node);
- 			bpf_free_verifier_state(&sl->state, false);
- 			kfree(sl);
- 		}
- 		INIT_LIST_HEAD(&env->explored_states[i]);
- 	}
+ 	env->failing_path_budget =3D min(hops << env->failing_path_budget_shift,
+ 				       env->failing_path_budget);
+ 	return env->failing_path_budget / 2;
  }
 =20
  static int do_check_common(struct bpf_verifier_env *env, int subprog,
@@@ -21911,17 -23095,18 +23124,18 @@@
  	int ret, i;
 =20
  	env->prev_linfo =3D NULL;
- 	env->pass_cnt++;
+ 	env->check_cnt++;
 =20
- 	state =3D kzalloc_obj(struct bpf_verifier_state, GFP_KERNEL_ACCOUNT);
+ 	state =3D kzalloc_obj(struct bpf_verifier_state, BPF_VERIFIER_GFP);
  	if (!state)
  		return -ENOMEM;
  	state->curframe =3D 0;
  	state->speculative =3D false;
- 	state->branches =3D 1;
  	state->in_sleepable =3D context =3D=3D BPF_FUNC_CTX_SLEEPABLE;
+ 	/* nobody knows what the callers of a global function or of an extension=
 hold */
+ 	state->callers_unknown =3D subprog || env->prog->type =3D=3D BPF_PROG_TY=
PE_EXT;
  	env->no_rcu_read_lock =3D context =3D=3D BPF_FUNC_CTX_NO_RCU_LOCK;
- 	state->frame[0] =3D kzalloc_obj(struct bpf_func_state, GFP_KERNEL_ACCOUN=
T);
+ 	state->frame[0] =3D kzalloc_obj(struct bpf_func_state, BPF_VERIFIER_GFP);
  	if (!state->frame[0]) {
  		kfree(state);
  		return -ENOMEM;
@@@ -21931,7 -23116,6 +23145,6 @@@
  			BPF_MAIN_FUNC /* callsite */,
  			0 /* frameno */,
  			subprog);
- 	state->first_insn_idx =3D env->subprog_info[subprog].start;
  	state->last_insn_idx =3D -1;
 =20
  	regs =3D state->frame[state->curframe]->regs;
@@@ -21983,7 -23167,8 +23196,8 @@@
  				 * Take it for that of an skb, so that a write
  				 * through it and its slices are treated with care.
  				 */
- 				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_SKB, true, ++env->id_gen, 0);
+ 				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_SKB, true,
+ 						  bpf_new_id(env), 0);
  			} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_MEM) {
  				reg->type =3D PTR_TO_MEM;
  				reg->type |=3D arg->arg_type &
@@@ -21991,7 -23176,7 +23205,7 @@@
  				mark_reg_known_zero(env, regs, i);
  				reg->mem_size =3D arg->mem_size;
  				if (arg->arg_type & PTR_MAYBE_NULL)
- 					reg->id =3D ++env->id_gen;
+ 					reg->id =3D bpf_new_id(env);
  			} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_BTF_ID) {
  				reg->type =3D PTR_TO_BTF_ID;
  				if (arg->arg_type & PTR_MAYBE_NULL)
@@@ -22003,7 -23188,7 +23217,7 @@@
  				mark_reg_known_zero(env, regs, i);
  				reg->btf =3D bpf_get_btf_vmlinux(); /* can't fail at this point */
  				reg->btf_id =3D arg->btf_id;
- 				reg->id =3D ++env->id_gen;
+ 				reg->id =3D bpf_new_id(env);
  			} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_ARENA) {
  				/* caller can pass either PTR_TO_ARENA or SCALAR */
  				mark_reg_unknown(env, regs, i);
@@@ -22026,13 -23211,12 +23240,12 @@@
  		 * it's matching expected signature, and otherwise mark BTF
  		 * info for main program as unreliable
  		 */
- 		if (env->prog->aux->func_info_aux) {
+ 		if (env->prog->aux->func_info_aux && !env->prog->aux->func_info_aux[0].=
unreliable) {
  			ret =3D btf_prepare_func_args(env, 0);
  			if (ret || sub->arg_slot_cnt !=3D 1 ||
  			    sub->args[0].arg_type !=3D ARG_PTR_TO_CTX) {
  				env->prog->aux->func_info_aux[0].unreliable =3D true;
  				sub->arg_slot_cnt =3D 1;
- 				sub->stack_arg_cnt =3D 0;
  			}
  		}
 =20
@@@ -22048,18 -23232,23 +23261,23 @@@
  			if (ret < 0)
  				goto out;
 =20
- 			aux->ctx_arg_info[i].ref_id =3D ret;
+ 			aux->ctx_arg_info[i].ref_arg =3D ret ? i + 1 : 0;
+ 			if (ret)
+ 				state->refs[state->acquired_refs - 1].ctx_arg =3D i + 1;
  		}
  	}
 =20
+ 	state->insn_idx =3D sub->start;
+ 	if (env->path_sensitive)
+ 		env->failing_path_max_cost =3D env->cost + func_failing_path_budget(env=
);
  	ret =3D do_check(env);
  out:
+ 	if (ret && !env->err)
+ 		note_error(env, ret);
  	account_current_path(env);
- 	if (!ret) {
- 		if (pop_log)
- 			bpf_vlog_reset(&env->log, 0);
- 		bpf_diag_event_log_restore(env, 0);
- 	}
+ 	if (!ret && pop_log)
+ 		bpf_vlog_reset(&env->log, 0);
+ 	bpf_diag_event_log_restore(env, 0);
  	free_states(env);
 =20
  	/*
@@@ -22069,7 -23258,7 +23287,7 @@@
  	 * Accumulate their total counts as total counts of the main or
  	 * global subprog hosting the async call.
  	 * Start from the saved total of earlier contexts: adding to the current
- 	 * total would count this pass's synchronous paths twice.
+ 	 * total would count the synchronous paths of this check twice.
  	 */
  	sub->insns_total =3D old_insns_total + (env->insn_processed - insn_proce=
ssed);
  	return ret;
@@@ -22160,6 -23349,475 +23378,475 @@@ static int do_check_main(struct bpf_=
ver
  	return ret;
  }
 =20
+ /* What a pass writes outside of the states */
+ struct bpf_snapshot {
+ 	struct bpf_env_per_pass env;
+ 	struct bpf_prog_aux aux;
+ 	struct bpf_insn_fixups *insns;
+ 	struct bpf_subprog_info *subprogs;
+ 	struct bpf_func_info_aux *funcs;
+ 	struct bpf_prog prog;
+ };
+=20
+ static void copy_snapshot(struct bpf_verifier_env *env, struct bpf_snapsh=
ot *snapshot, bool save)
+ {
+ 	bool has_callchain_buf =3D env->prog->has_callchain_buf;
+ 	struct bpf_prog_aux *aux =3D env->prog->aux;
+ 	struct bpf_subprog_info *sub;
+ 	int i;
+=20
+ #define COPY(kept, live)	(save ? ((kept) =3D (live)) : ((live) =3D (kept)=
))
+ #define COPY_AUX(field)		COPY(snapshot->aux.field, aux->field)
+ 	COPY(snapshot->env, env->per_pass);
+ 	COPY(snapshot->prog, *env->prog);
+ 	/* it is taken once */
+ 	env->prog->has_callchain_buf =3D has_callchain_buf;
+ 	COPY_AUX(max_ctx_offset);
+ 	COPY_AUX(max_pkt_offset);
+ 	COPY_AUX(max_tp_access);
+ 	COPY_AUX(max_rdonly_access);
+ 	COPY_AUX(max_rdwr_access);
+ 	COPY_AUX(min_rdwr_write);
+ 	COPY_AUX(max_rdwr_write);
+ 	COPY_AUX(stack_depth);
+ 	COPY_AUX(tail_call_reachable);
+ 	COPY_AUX(jits_use_priv_stack);
+ 	COPY_AUX(kprobe_write_ctx);
+ 	for (i =3D 0; i < env->prog->len; i++)
+ 		COPY(snapshot->insns[i], env->insn_aux_data[i].fixups);
+ 	for (i =3D 0, sub =3D env->subprog_info; i < env->subprog_cnt; i++, sub+=
+) {
+ 		/* the sum over all passes */
+ 		snapshot->subprogs[i].insns_total =3D sub->insns_total;
+ 		snapshot->subprogs[i].insns_self =3D sub->insns_self;
+ 		COPY(snapshot->subprogs[i], *sub);
+ 	}
+ 	for (i =3D 0; aux->func_info_aux && i < aux->func_info_cnt; i++)
+ 		COPY(snapshot->funcs[i], aux->func_info_aux[i]);
+ #undef COPY_AUX
+ #undef COPY
+ 	bpf_add_cost(env, env->prog->len, BPF_COST_XREG);
+ }
+=20
+ static struct bpf_snapshot *save_snapshot(struct bpf_verifier_env *env,
+ 					  struct bpf_snapshot *snapshot)
+ {
+ 	size_t insns =3D array_size(env->prog->len, sizeof(*snapshot->insns));
+ 	size_t subprogs =3D env->subprog_cnt * sizeof(*snapshot->subprogs);
+=20
+ 	if (!snapshot) {
+ 		snapshot =3D kvmalloc(sizeof(*snapshot) + insns + subprogs +
+ 				    env->prog->aux->func_info_cnt * sizeof(*snapshot->funcs),
+ 				    BPF_VERIFIER_GFP);
+ 		if (!snapshot)
+ 			return NULL;
+ 		env->mem +=3D insns + subprogs;
+ 		snapshot->insns =3D (void *)(snapshot + 1);
+ 		snapshot->subprogs =3D (void *)snapshot->insns + insns;
+ 		snapshot->funcs =3D (void *)snapshot->subprogs + subprogs;
+ 	}
+ 	copy_snapshot(env, snapshot, true);
+ 	return snapshot;
+ }
+=20
+ static void restore_snapshot(struct bpf_verifier_env *env, struct bpf_sna=
pshot *snapshot)
+ {
+ 	copy_snapshot(env, snapshot, false);
+ }
+=20
+ /*
+  * The prologue takes the context from R1, and it can clobber R2-R5. An
+  * extension gets the arguments of the function that it replaces.
+  */
+ static int check_ext_takes_prologue(struct bpf_verifier_env *env)
+ {
+ 	const struct bpf_subprog_info *sub =3D &env->subprog_info[0];
+ 	int i, cnt =3D min_t(int, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS);
+ 	struct bpf_prog *prog =3D env->prog;
+=20
+ 	if (prog->type !=3D BPF_PROG_TYPE_EXT || !env->ops->gen_prologue ||
+ 	    !env->ops->gen_prologue(env->insn_buf, env->seen_direct_write, prog))
+ 		return 0;
+ 	for (i =3D 0; i < cnt; i++)
+ 		if (sub->args[i].arg_type !=3D (i ? ARG_SCALAR : ARG_PTR_TO_CTX))
+ 			break;
+ 	if (!cnt || i < cnt) {
+ 		verbose(env, "Extension writing packet data must take ctx and scalars o=
nly\n");
+ 		return -EINVAL;
+ 	}
+ 	if (bpf_check_ext_prologue(&env->log, prog->aux->dst_prog, prog->aux->at=
tach_btf_id))
+ 		return -EINVAL;
+ 	return 0;
+ }
+=20
+ /* What the pass found about functions and about the program has to be co=
nsistent */
+ static int check_after_pass(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_subprog_info *sub =3D env->subprog_info;
+ 	u16 outgoing;
+ 	int i, err;
+=20
+ 	err =3D check_max_stack_depth(env) ?: check_ext_takes_prologue(env);
+ 	if (err)
+ 		return err;
+ 	for (i =3D 0; i < env->subprog_cnt; i++, sub++) {
+ 		/* the caller would get r12 of the callee back */
+ 		if (env->uses_arena_sp && (!i || sub->arena_stack_entry) && sub->is_cal=
led) {
+ 			verbose(env, "%s() uses R%d and is both called and a callback\n",
+ 				bpf_subprog_name(env, i), BPF_REG_ARENA_SP);
+ 			return -EINVAL;
+ 		}
+ 		outgoing =3D sub->stack_arg_cnt - bpf_in_stack_arg_cnt(sub);
+ 		if (sub->max_out_stack_arg_cnt > outgoing) {
+ 			verbose(env,
+ 				"func#%d writes %u stack arg slots, but calls only require %u\n",
+ 				i, sub->max_out_stack_arg_cnt, outgoing);
+ 			return -EINVAL;
+ 		}
+ 	}
+ 	return 0;
+ }
+=20
+ /* Returns the first error */
+ static int check_funcs(struct bpf_verifier_env *env, struct bpf_snapshot =
*initial)
+ {
+ 	u32 level =3D env->log.level;
+ 	int ret;
+=20
+ 	restore_snapshot(env, initial);
+ 	kvfree(env->callx_edges);
+ 	kvfree(env->callx_index.slots);
+ 	env->callx_edges =3D NULL;
+ 	env->callx_index =3D (struct bpf_index){};
+ 	bpf_flow_new_pass(env);
+ 	ret =3D do_check_main(env) ?: do_check_subprogs(env) ?: bpf_check_limits=
(env);
+ 	env->log.level =3D level;
+ 	env->pass_max_cost =3D U64_MAX;
+ 	return ret =3D=3D -EINTR ? ret : env->err ?: ret;
+ }
+=20
+ static int check_pass(struct bpf_verifier_env *env, struct bpf_snapshot *=
initial)
+ {
+ 	int ret;
+=20
+ 	if (env->pass && (env->log.level & BPF_LOG_LEVEL2))
+ 		verbose(env, "pass %u\n", env->pass);
+ 	bpf_precision_new_pass(env);
+ 	ret =3D check_funcs(env, initial);
+ 	if (ret || pass_needs_restart(env))
+ 		return ret;
+ 	ret =3D check_after_pass(env);
+ 	if (ret)
+ 		bpf_find_unproven_after_pass(env);
+ 	env->err =3D ret;
+ 	return ret;
+ }
+=20
+ /*
+  * If the error of a pass is real, do_check_all() limits the next passes =
and logs a path to it.
+  * To see if it is real, reproduce it with no joins. Check one path after=
 another, depth first
+  * from the entry of the function, until the check of an insn in err_insn=
s fails:
+  * - there are no joins, a call stays in the instance of its caller, each=
 trip is peeled
+  * - a state is dropped if a state with the same values in the deps was a=
t the insn
+  * - only a loop that is found to be infinite gets may_goto, see failing_=
path_trip()
+  * That path is the failing path. The run accepts nothing. It is not the =
verdict: a path has
+  * ranges too, and a check can fail on it where the joined state is prove=
n.
+  * run_has_guess: the run made a guess, on any of its paths. Then the fai=
ling path can be false,
+  * see fast_forward_trips() and check_loop_guard().
+  * @repeat: see log_failing_path()
+  * Returns the error on the path, 0 if there is none.
+  */
+ static int run_path_sensitive(struct bpf_verifier_env *env, struct bpf_sn=
apshot *initial,
+ 			      bool repeat)
+ {
+ 	u64 budget =3D env->failing_path_budget;
+ 	int ret;
+=20
+ 	env->path_sensitive =3D true;
+ 	env->run_has_guess =3D false;
+ 	env->err =3D 0;
+ 	ret =3D bpf_failing_path_prepare(env, repeat) ?: check_funcs(env, initia=
l);
+ 	env->path_sensitive =3D false;
+ 	/* for the repeat */
+ 	if (env->err)
+ 		env->failing_path_budget =3D budget;
+ 	if (env->err && env->run_has_guess)
+ 		verbose(env, "this path has a guess, its values can be wrong\n");
+ 	return ret =3D=3D -EINTR ? ret : env->err;
+ }
+=20
+ /*
+  * The path-sensitive runs, in their order:
+  *
+  *	trips of a loop without a trip count	1, any number, 3, 7, ...
+  *	which edge goes first			the shortest path; if over budget, the fall-th=
rough
+  *
+  * A function gets half of the budget that is left. @last: the budget is =
twice the cost so far.
+  */
+ static int find_failing_path(struct bpf_verifier_env *env, struct bpf_sna=
pshot *initial, bool last)
+ {
+ 	u32 trips;
+ 	u64 start;
+ 	int ret;
+=20
+ 	if (env->log.level & BPF_LOG_LEVEL2)
+ 		verbose(env, "path-sensitive run after pass %u\n", env->pass);
+ 	env->failing_path_budget_shift =3D last ? 20 : min(env->pass + 3, 20);
+ 	env->failing_path_budget =3D last ? 2 * env->cost : bpf_precision_budget=
(env) / 4;
+ 	env->failing_path_max_trips =3D trips =3D 1;
+ 	env->fallthrough_first =3D false;
+ 	for (;;) {
+ 		start =3D env->cost;
+ 		ret =3D run_path_sensitive(env, initial, false);
+ 		if (ret || env->over_limit || env->bug ||
+ 		    env->cost - start >=3D env->failing_path_budget)
+ 			return ret;
+ 		env->failing_path_budget -=3D env->cost - start;
+ 		env->fallthrough_first =3D !env->fallthrough_first && env->run_over_bud=
get;
+ 		if (env->fallthrough_first)
+ 			continue;
+ 		if (env->no_mem || (!env->run_over_budget && !env->too_deep))
+ 			return 0;
+ 		if (env->failing_path_max_trips =3D=3D 1)
+ 			env->failing_path_max_trips =3D U32_MAX;
+ 		else
+ 			env->failing_path_max_trips =3D trips =3D 2 * trips + 1;
+ 	}
+ }
+=20
+ /* Level 2 has the log of all passes. Else the log has one pass, or the f=
ailing path. */
+ struct pass_log {
+ 	u32 level, len_max;
+ 	u64 pos;
+ };
+=20
+ static void restart_log(struct bpf_verifier_env *env, struct pass_log *lo=
g)
+ {
+ 	env->log.level =3D log->level;
+ 	/* the log is dropped when a function is found to be safe */
+ 	log->pos =3D min(log->pos, env->log.end_pos);
+ 	if (log->level & BPF_LOG_LEVEL2)
+ 		return;
+ 	bpf_vlog_reset(&env->log, log->pos);
+ 	env->log.len_max =3D log->len_max;
+ }
+=20
+ /* Repeat the last run. The verdict does not depend on the log, so it has=
 no cost. */
+ static int log_failing_path(struct bpf_verifier_env *env, struct bpf_snap=
shot *initial,
+ 			    struct pass_log *log)
+ {
+ 	u32 insns =3D env->insn_processed, states =3D env->total_states;
+ 	u64 cost =3D env->cost;
+ 	int i, ret;
+=20
+ 	restart_log(env, log);
+ 	ret =3D run_path_sensitive(env, initial, true);
+ 	env->log.level =3D 0;
+ 	env->cost =3D cost;
+ 	env->insn_processed =3D insns;
+ 	env->total_states =3D states;
+ 	/* @initial has the sums from before the run, see copy_snapshot() */
+ 	for (i =3D 0; i < env->subprog_cnt; i++) {
+ 		env->subprog_info[i].insns_total =3D initial->subprogs[i].insns_total;
+ 		env->subprog_info[i].insns_self =3D initial->subprogs[i].insns_self;
+ 	}
+ 	return ret;
+ }
+=20
+ /*
+  *          pass 0: join all numbers
+  *                    |
+  *    +---------> run a pass
+  *    |               |
+  *    |            error ? --- no ---> pessimized ? --- no ---> ACCEPT
+  *    |               | yes                 | yes
+  *    |               v                     v
+  *    |       good pass before ?      save the good pass,
+  *    |          | no      | yes      partition, cut the budget
+  *    |          |         v                |
+  *    |          |   ACCEPT, use that pass  +---> run a pass
+  *    |          v
+  *    |      partition
+  *    |          |
+  *    |  failing path ? --- yes ---> log it; if no guess, cut the budget
+  *    |          | no                       |
+  *    |          +<-------------------------+
+  *    |          v
+  *    +- yes - is more kept apart ? --- no ---> REJECT
+  *
+  * Each pass starts from the snapshot @initial. The good pass is in the s=
napshot @good_pass.
+  * The path-sensitive run needs the deps, so it comes after the partition.
+  * There is no more precision when the budget is used up, or when no stat=
e was imprecise.
+  *
+  * A pass assumes what stops each loop, and checks it, see pass_needs_res=
tart(). If the
+  * assumption is wrong, the pass starts again.
+  *
+  * The log has the failing path. If there is none, or if it has a guess a=
nd the error of a pass
+  * is real, the log has the basic block of an error. Below level 2 the la=
ter passes and the
+  * path-sensitive runs write no log. The one that gives the log runs once=
 more.
+  */
+ static int do_check_all(struct bpf_verifier_env *env)
+ {
+ 	bool offload =3D bpf_prog_is_offloaded(env->prog->aux), limit =3D false,=
 last, replay;
+ 	struct pass_log log =3D { env->log.level, env->log.len_max, env->log.end=
_pos };
+ 	bool quiet =3D log.level && !(log.level & BPF_LOG_LEVEL2), logged =3D fa=
lse, replayed =3D false;
+ 	struct bpf_snapshot *initial, *good_pass =3D NULL;
+ 	int ret, more, path_err =3D 0, err =3D 0;
+ 	bool guess =3D false, real;
+ 	u64 max_cost =3D 0;
+=20
+ 	initial =3D save_snapshot(env, NULL);
+ 	if (!initial || bpf_precision_init(env)) {
+ 		bpf_precision_free(env);
+ 		kvfree(initial);
+ 		return -ENOMEM;
+ 	}
+ 	env->max_mem =3D min(env->max_mem, env->mem + BPF_PASS_MEM_BASE +
+ 			   (u64)BPF_PASS_MEM_PER_INSN * env->prog->len);
+ 	for (;; env->pass +=3D !env->for_log) {
+ 		if (!env->pass || !quiet)
+ 			restart_log(env, &log);
+ 		ret =3D check_pass(env, initial);
+ 		if (quiet)
+ 			env->log.level =3D 0;
+ 		replay =3D env->replay;
+ 		env->replay =3D false;
+ 		if (ret =3D=3D -EINTR || env->bug || env->no_mem) {
+ 			err =3D ret;
+ 			break;
+ 		}
+ 		more =3D bpf_undo_precision(env);
+ 		if (more > 0)
+ 			continue;
+ 		if (more =3D=3D -ENOMEM && !good_pass) {
+ 			err =3D more;
+ 			break;
+ 		}
+ 		if (ret && good_pass) {
+ 			restore_snapshot(env, good_pass);
+ 			err =3D 0;
+ 			if (!offload)
+ 				break;
+ 			bpf_restore_precision(env);
+ 		} else if (!ret) {
+ 			bpf_flow_drop_guards(env);
+ 			if (pass_needs_restart(env))
+ 				continue;
+ 			if (env->for_log && (!offload || replay))
+ 				break;
+ 			max_cost =3D good_pass ? max_cost : env->max_cost;
+ 			if (!replayed && !env->for_log && bpf_partition_for_pessimized(env) > =
0) {
+ 				env->max_cost =3D min(env->max_cost, env->cost + BPF_MIN_BUDGET);
+ 				good_pass =3D save_snapshot(env, good_pass);
+ 				if (good_pass)
+ 					continue;
+ 			}
+ 			if (!offload || replay) {
+ 				err =3D 0;
+ 				break;
+ 			}
+ 		}
+ 		if (!ret || good_pass) {
+ 			/* The driver sees a pass without errors. It can refuse an insn. */
+ 			kvfree(good_pass);
+ 			good_pass =3D NULL;
+ 			env->max_cost =3D max_cost;
+ 			env->replay =3D replayed =3D true;
+ 			ret =3D bpf_prog_offload_verifier_prep(env->prog);
+ 			if (!ret)
+ 				continue;
+ 			err =3D ret;
+ 			break;
+ 		}
+ 		if (env->for_log)
+ 			break;
+ 		err =3D path_err ?: ret;
+ 		limit =3D !env->err;
+ 		if (limit)
+ 			goto reject;
+ 		/* a valid program that no precision can prove must not use up the limi=
t */
+ 		env->max_cost =3D min(env->max_cost, max(2 * env->cost, BPF_PARTITION_B=
UDGET));
+ 		last =3D real =3D !env->imprecise;
+ 		more =3D bpf_partition_more(env);
+ 		if (more < 0 && more !=3D -E2BIG)
+ 			err =3D more;
+ 		limit =3D more < 0;
+ 		last |=3D more !=3D 1;
+ 		if (!limit && !path_err && (last || bpf_failing_path_is_due(env))) {
+ 			path_err =3D find_failing_path(env, initial, last);
+ 			if (path_err) {
+ 				err =3D path_err;
+ 				guess =3D env->run_has_guess;
+ 				logged =3D quiet && log_failing_path(env, initial, &log) =3D=3D err;
+ 			}
+ 			if (path_err && !guess)
+ 				env->max_cost =3D min(env->max_cost, env->cost +
+ 						    2 * bpf_precision_first_budget(env));
+ 		}
+ 		if (real && guess && err =3D=3D path_err && err !=3D -EINTR) {
+ 			err =3D ret;
+ 			logged =3D false;
+ 		}
+ 		if (err =3D=3D -EINTR || env->bug)
+ 			break;
+ 		if (!last)
+ 			continue;
+ reject:
+ 		if (logged || !quiet || (limit && !env->pass))
+ 			break;
+ 		/* Run a pass with an error once more, for the log. It has a limit of i=
ts own. */
+ 		env->for_log =3D true;
+ 		quiet =3D false;
+ 		env->max_cost =3D 2 * env->cost;
+ 	}
+ 	env->log.level =3D log.level;
+ 	/* after an abort the error and the log can be wrong */
+ 	if (err && env->aborted)
+ 		err =3D -EINTR;
+ 	if (env->bug)
+ 		err =3D -EFAULT;
+ 	if (!err)
+ 		restart_log(env, &log);
+ 	if (err && (!path_err || guess) && (limit || (env->for_log && !env->err)=
))
+ 		verbose(env, "the limit on cost or memory ended pass %u\n", env->pass);
+ 	if (!err && env->sleepable_async_cb)
+ 		mark_sleepable_async_cb(env);
+ 	bpf_precision_free(env);
+ 	kvfree(initial);
+ 	kvfree(good_pass);
+ 	return err;
+ }
+=20
+ /*
+  * What it took to verify a static subprog on its own is not in insns_tot=
al of its callers.
+  * Add it, once per caller. The main prog and global subprogs have all of=
 it already.
+  */
+ static void add_insns_of_callees(struct bpf_verifier_env *env)
+ {
+ 	struct bpf_subprog_info *si =3D env->subprog_info;
+ 	struct bpf_insn *insn =3D env->prog->insnsi;
+ 	int *added, i, j, s, c;
+=20
+ 	added =3D kvcalloc(env->subprog_cnt, sizeof(*added), BPF_VERIFIER_GFP);
+ 	if (!added)
+ 		return;
+ 	/* callees first */
+ 	for (i =3D 0; i < env->subprog_cnt; i++) {
+ 		s =3D env->subprog_topo_order[i];
+ 		if (!s || bpf_subprog_is_global(env, s))
+ 			continue;
+ 		for (j =3D si[s].start; j < si[s + 1].start; j++) {
+ 			if (!bpf_pseudo_call(&insn[j]))
+ 				continue;
+ 			c =3D bpf_find_subprog(env, j + insn[j].imm + 1);
+ 			if (c <=3D 0 || c =3D=3D s || !si[c].on_its_own || added[c] =3D=3D s)
+ 				continue;
+ 			added[c] =3D s;
+ 			si[s].insns_total +=3D si[c].insns_total;
+ 		}
+ 	}
+ 	kvfree(added);
+ }
+=20
  static void print_verification_stats(struct bpf_verifier_env *env)
  {
  	/* Skip over hidden subprogs which are not verified. */
@@@ -22183,17 -23841,18 +23870,18 @@@
  				env->subprog_info[i].stack_depth);
  		}
  	}
- 	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
- 		"total_states %d peak_states %d mark_read %d\n",
- 		env->insn_processed, BPF_COMPLEXITY_LIMIT_INSNS,
+ 	/* user space parses this line. There is no limit and there are no read =
marks. */
+ 	verbose(env, "processed %d insns (limit 0) max_states_per_insn %d "
+ 		"total_states %d peak_states %d mark_read 0\n",
+ 		env->insn_processed,
  		env->max_states_per_insn, env->total_states,
- 		env->peak_states, env->longest_mark_read_walk);
+ 		env->peak_states);
  }
 =20
  int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
  			       const struct bpf_ctx_arg_aux *info, u32 cnt)
  {
- 	prog->aux->ctx_arg_info =3D kmemdup_array(info, cnt, sizeof(*info), GFP_=
KERNEL_ACCOUNT);
+ 	prog->aux->ctx_arg_info =3D kmemdup_array(info, cnt, sizeof(*info), BPF_=
VERIFIER_GFP);
  	prog->aux->ctx_arg_info_size =3D cnt;
 =20
  	return prog->aux->ctx_arg_info ? 0 : -ENOMEM;
@@@ -22312,6 -23971,12 +24000,12 @@@ static int check_struct_ops_btf_id(stru
  		}
  	}
 =20
+ 	/* A run that gets no stack in arena is skipped. Nobody would release th=
e argument. */
+ 	if (has_refcounted_arg && env->uses_arena_sp) {
+ 		verbose(env, "program with __ref argument cannot use R%d\n", BPF_REG_AR=
ENA_SP);
+ 		return -EINVAL;
+ 	}
+=20
  	prog->aux->st_ops =3D st_ops;
  	prog->aux->attach_st_ops_member_off =3D member_off;
 =20
@@@ -22553,33 -24218,6 +24247,6 @@@ static int flatten_bpf_func_model(struc
  	return 0;
  }
 =20
- /*
-  * The verifier lets a static function use stack arguments counted from i=
ts
-  * BTF, even if that BTF turns out unreliable. A trampoline on the functi=
on is
-  * then given only MAX_BPF_FUNC_REG_ARGS u64 arguments and would lose the
-  * stack arguments, so such a function cannot be attached to.
-  */
- static int check_unreliable_func_args(struct bpf_verifier_log *log, struc=
t btf *btf,
- 				      const struct btf_type *func_proto, const char *tname)
- {
- 	struct btf_func_model m;
- 	u32 i, nslots =3D 0;
-=20
- 	if (btf_distill_func_proto(NULL, btf, func_proto, tname, &m)) {
- 		/* at least a slot for each argument */
- 		nslots =3D btf_type_vlen(func_proto);
- 	} else {
- 		for (i =3D 0; i < m.nr_args; i++)
- 			nslots +=3D btf_func_model_arg_slots(&m, i);
- 	}
- 	if (nslots <=3D MAX_BPF_FUNC_REG_ARGS)
- 		return 0;
-=20
- 	bpf_log(log, "Cannot attach to static function %s: unreliable BTF and st=
ack arguments\n",
- 		tname);
- 	return -EINVAL;
- }
-=20
  /* Functions may share a type id. The first of them is attached to. */
  static int find_tgt_subprog(const struct bpf_prog *tgt_prog, u32 btf_id)
  {
@@@ -22702,7 -24340,6 +24369,7 @@@ int bpf_check_attach_target(struct bpf_
  	}
  	if (tgt_prog) {
  		struct bpf_prog_aux *aux =3D tgt_prog->aux;
 +		enum bpf_cgroup_storage_type stype;
  		bool tgt_changes_pkt_data;
  		bool tgt_might_sleep;
  		bool tgt_can_unwind;
@@@ -22728,6 -24365,12 +24395,12 @@@
  			bpf_log(log, "Cannot attach to a target with arena context arguments\n=
");
  			return -EOPNOTSUPP;
  		}
+ 		/* x86: the trampoline and the extension don't preserve BPF_REG_ARENA_S=
P */
+ 		if (subprog && aux->arena_stack_size) {
+ 			bpf_log(log, "Cannot attach to a subprog of a program that uses R%d\n",
+ 				BPF_REG_ARENA_SP);
+ 			return -EOPNOTSUPP;
+ 		}
  		if (aux->func && aux->func[subprog]->aux->exception_cb) {
  			bpf_log(log,
  				"%s programs cannot attach to exception callback\n",
@@@ -22744,6 -24387,11 +24417,11 @@@
  			bpf_log(log, "Only fentry can attach to %s, which can unwind\n", tname=
);
  			return -EINVAL;
  		}
+ 		/* What it takes of the stack is not counted, see bpf_insert_recursion_=
checks() */
+ 		if (aux->func && aux->func[subprog]->aux->in_recursion) {
+ 			bpf_log(log, "Cannot attach to %s, which is called in a recursion\n", =
tname);
+ 			return -EINVAL;
+ 		}
  		conservative =3D aux->func_info_aux[subprog].unreliable;
  		if (prog_extension) {
  			if (aux->func_info_aux[subprog].linkage !=3D BTF_FUNC_GLOBAL ||
@@@ -22757,16 -24405,6 +24435,16 @@@
  					"Extension programs should be JITed\n");
  				return -EINVAL;
  			}
 +			/* bpf_get_local_storage() returns the storage of the target */
 +			for_each_cgroup_storage_type(stype) {
 +				struct bpf_map *storage =3D prog->aux->cgroup_storage[stype];
 +
 +				if (storage && storage !=3D aux->cgroup_storage[stype]) {
 +					bpf_log(log,
 +						"Extension program has another cgroup storage than original\n");
 +					return -EINVAL;
 +				}
 +			}
  			/*
  			 * How much of the buffer of the tracepoint is used
  			 * is checked for the program that is attached to it.
@@@ -22831,14 -24469,16 +24509,14 @@@
  			bpf_log(log, "Cannot recursively attach\n");
  			return -EINVAL;
  		}
 -		if (tgt_prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
 -		    prog_extension &&
 -		    (tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FENTRY ||
 -		     tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT ||
 -		     tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FENTRY_MULTI ||
 -		     tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FEXIT_MULTI ||
 -		     tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FSESSION ||
 -		     tgt_prog->expected_attach_type =3D=3D BPF_TRACE_FSESSION_MULTI)) {
 -			/* Program extensions can extend all program types
 -			 * except fentry/fexit. The reason is the following.
 +		if (prog_extension &&
 +		    (tgt_prog->type =3D=3D BPF_PROG_TYPE_TRACING ||
 +		     tgt_prog->type =3D=3D BPF_PROG_TYPE_LSM ||
 +		     tgt_prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS)) {
 +			/*
 +			 * These types are checked against the BTF of their hook,
 +			 * and an extension has the BTF of its target instead.
 +			 * There is one more reason for fentry/fexit.
  			 * The fentry/fexit programs are used for performance
  			 * analysis, stats and can be attached to any program
  			 * type. When extension program is replacing XDP function
@@@ -22851,7 -24491,7 +24529,7 @@@
  			 * beyond reasonable stack size. Hence extending fentry
  			 * is not allowed.
  			 */
 -			bpf_log(log, "Cannot extend fentry/fexit/fsession\n");
 +			bpf_log(log, "Cannot extend tracing, LSM and struct_ops programs\n");
  			return -EINVAL;
  		}
  	} else {
@@@ -22970,10 -24610,16 +24648,16 @@@
  			return -EINVAL;
 =20
  		if (tgt_prog && conservative) {
- 			if (subprog > 0) {
- 				ret =3D check_unreliable_func_args(log, btf, t, tname);
- 				if (ret)
- 					return ret;
+ 			/*
+ 			 * The verifier lets a static function use the stack arguments that
+ 			 * its code loads, whatever its BTF says. The trampoline is given
+ 			 * MAX_BPF_FUNC_REG_ARGS u64 arguments and would lose them.
+ 			 */
+ 			if (tgt_prog->aux->func_info_aux[subprog].stack_args) {
+ 				bpf_log(log,
+ 					"Cannot attach to static function %s: unreliable BTF and stack argum=
ents\n",
+ 					tname);
+ 				return -EINVAL;
  			}
  			t =3D NULL;
  		}
@@@ -22987,7 -24633,9 +24671,9 @@@
  				return ret;
  		}
 =20
- 		if (tgt_info->fmodel.ret_size > 8 &&
+ 		/* The model for unreliable BTF has a u64. The function still returns R=
0:R2. */
+ 		if ((tgt_info->fmodel.ret_size > 8 ||
+ 		     (tgt_prog && tgt_prog->aux->func_info_aux[subprog].ret_reg_pair)) =
&&
  		    attach_uses_trampoline_retval(prog->expected_attach_type)) {
  			bpf_log(log,
  				"Attach to function %s with a >8 byte return value is not supported f=
or this attach type\n",
@@@ -23047,6 -24695,13 +24733,13 @@@
  			if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
  			    !check_attach_modify_return(addr, tname))
  				ret =3D 0;
+ 			if (ret) {
+ 				/* Nobody declared it as a target. Has the build tagged it? */
+ 				tgt_info->fmodret_retvals =3D
+ 					btf_find_func_tag_value(btf, btf_id, "bpf_fmodret_retval:");
+ 				if (tgt_info->fmodret_retvals)
+ 					ret =3D 0;
+ 			}
  			if (ret) {
  				module_put(mod);
  				bpf_log(log, "%s() is not modifiable\n", tname);
@@@ -23199,13 -24854,10 +24892,13 @@@ static int check_attach_btf_id(struct=
 b
  		prog->aux->saved_dst_attach_type =3D tgt_prog->expected_attach_type;
  	}
 =20
 -	if (prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP) {
 +	/* An extension has expected_attach_type of its target, it can be any va=
lue */
 +	if (prog->type !=3D BPF_PROG_TYPE_EXT &&
 +	    prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP) {
  		prog->aux->attach_btf_trace =3D true;
  		return 0;
 -	} else if (prog->expected_attach_type =3D=3D BPF_TRACE_ITER) {
 +	} else if (prog->type !=3D BPF_PROG_TYPE_EXT &&
 +		   prog->expected_attach_type =3D=3D BPF_TRACE_ITER) {
  		return bpf_iter_prog_supported(prog);
  	}
 =20
@@@ -23228,6 -24880,11 +24921,11 @@@
  		return -EINVAL;
  	}
 =20
+ 	env->fmodret_retvals =3D tgt_info.fmodret_retvals;
+ 	/* The interpreter returns only 32 bits */
+ 	if (env->fmodret_retvals && tgt_info.fmodel.ret_size =3D=3D 8)
+ 		prog->jit_required =3D 1;
+=20
  	/*
  	 * We don't get trampoline for tracing_multi programs at this point,
  	 * it's done when tracing_multi link is created.
@@@ -23363,39 -25020,31 +25061,31 @@@ static int add_fd_from_fd_array(struc=
t=20
  	return PTR_ERR(map);
  }
 =20
- /*
-  * A continuous fd_array is resolved into an in-memory cache with one slot
-  * per entry. The bound here is deliberately generous and not derived from
-  * the per-program object limits: Duplicate entries /are/ permitted, and
-  * the number of distinct maps and BTFs a program can bind is enforced wh=
en
-  * each entry is resolved by __add_used_map() and __add_used_btf().
-  */
- #define MAX_FD_ARRAY_CNT 4096
-=20
+ /* A continuous fd_array is resolved into an in-memory cache with one slo=
t per entry. */
  static int process_fd_array_continuous(struct bpf_verifier_env *env,
  				       bpfptr_t fd_array, u32 cnt)
  {
  	int fd, ret;
  	u32 i;
 =20
- 	if (cnt > MAX_FD_ARRAY_CNT) {
- 		verbose(env, "fd_array has too many entries (%u, max %u)\n",
- 			cnt, MAX_FD_ARRAY_CNT);
+ 	if (!env->bpf_capable && cnt > BPF_MAXINSNS) {
+ 		verbose(env, "fd_array has too many entries (%u, max %u)\n", cnt, BPF_M=
AXINSNS);
  		return -E2BIG;
  	}
 =20
- 	env->fd_array =3D kvzalloc_objs(*env->fd_array, cnt, GFP_KERNEL_ACCOUNT);
- 	if (!env->fd_array)
- 		return -ENOMEM;
- 	env->fd_array_cnt =3D cnt;
  	for (i =3D 0; i < cnt; i++) {
+ 		if (bpf_must_abort())
+ 			return -EINTR;
  		if (copy_from_bpfptr_offset(&fd, fd_array,
  					    (size_t)i * sizeof(fd), sizeof(fd)))
  			return -EFAULT;
+ 		if (!bpf_table_next(env->fd_array, i))
+ 			return -ENOMEM;
  		ret =3D add_fd_from_fd_array(env, i, fd);
  		if (ret)
  			return ret;
  	}
+ 	env->fd_array_cnt =3D cnt;
  	return 0;
  }
 =20
@@@ -23474,64 -25123,21 +25164,21 @@@ static int specialize_kfunc(struct bp=
f_
  	return 0;
  }
 =20
- static int add_kfunc_desc_target(struct bpf_verifier_env *env,
- 				 const struct bpf_kfunc_desc *target_desc,
- 				 u16 base_desc_idx, u16 *desc_idx)
+ /* A kfunc has at most one specialized target. Returns the index of its d=
escriptor. */
+ static int add_specialized_kfunc(struct bpf_verifier_env *env, const stru=
ct bpf_kfunc_desc *desc)
  {
- 	struct bpf_kfunc_desc desc =3D *target_desc;
- 	struct bpf_kfunc_desc_tab *new_tab;
- 	struct bpf_kfunc_desc_tab *tab;
- 	struct bpf_prog_aux *prog_aux;
- 	u32 i;
+ 	struct bpf_kfunc_desc_tab *tab =3D env->prog->aux->kfunc_tab;
+ 	u64 key =3D kfunc_key(desc->func_id, desc->offset, true);
+ 	int i =3D bpf_index_find(&env->kfunc_index, key);
 =20
- 	prog_aux =3D env->prog->aux;
- 	tab =3D prog_aux->kfunc_tab;
-=20
- 	if (base_desc_idx >=3D tab->nr_base_descs) {
- 		verifier_bug(env, "kfunc desc_idx %d out of bounds (%d descriptors)",
- 				base_desc_idx, tab->nr_base_descs);
- 		return -EFAULT;
- 	}
- 	if (tab->descs[base_desc_idx].func_id !=3D desc.func_id) {
- 		verifier_bug(env, "kfunc desc %d has invalid id (expected %d, got %d)",
- 				base_desc_idx, tab->descs[base_desc_idx].func_id, desc.func_id);
- 		return -EFAULT;
- 	}
- 	if (tab->descs[base_desc_idx].offset !=3D desc.offset) {
- 		verifier_bug(env, "kfunc desc %d has invalid offset (expected %d, got %=
d)",
- 				base_desc_idx, tab->descs[base_desc_idx].offset, desc.offset);
- 		return -EFAULT;
- 	}
-=20
- 	if (tab->descs[base_desc_idx].addr =3D=3D desc.addr) {
- 		*desc_idx =3D base_desc_idx;
- 		return 0;
- 	}
-=20
- 	for (i =3D tab->nr_base_descs; i < tab->nr_descs; i++) {
- 		if (tab->descs[i].func_id =3D=3D desc.func_id &&
- 		    tab->descs[i].offset =3D=3D desc.offset &&
- 		    tab->descs[i].addr =3D=3D desc.addr) {
- 			*desc_idx =3D i;
- 			return 0;
- 		}
- 	}
-=20
- 	if (tab->nr_descs =3D=3D MAX_KFUNC_CALL_DESCS) {
- 		verbose(env, "too many different kernel function call targets\n");
- 		return -E2BIG;
- 	}
-=20
- 	new_tab =3D krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1),
- 			   GFP_KERNEL_ACCOUNT);
- 	if (!new_tab)
+ 	if (i >=3D 0)
+ 		return verifier_bug_if(tab->descs[i].addr !=3D desc->addr, env,
+ 				       "two targets of kfunc %u", desc->func_id) ? -EFAULT : i;
+ 	if (!bpf_table_next(tab->descs, tab->nr_descs) ||
+ 	    bpf_index_add(&env->kfunc_index, key, tab->nr_descs))
  		return -ENOMEM;
- 	tab =3D new_tab;
- 	prog_aux->kfunc_tab =3D tab;
-=20
- 	*desc_idx =3D tab->nr_descs;
- 	tab->descs[tab->nr_descs++] =3D desc;
- 	return 0;
+ 	tab->descs[tab->nr_descs] =3D *desc;
+ 	return tab->nr_descs++;
  }
 =20
  static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *ins=
n_aux,
@@@ -23557,14 -25163,8 +25204,8 @@@ int bpf_fixup_kfunc_call(struct bpf_ver
  	struct bpf_kfunc_desc desc_copy;
  	struct bpf_kfunc_desc *desc;
  	unsigned long call_imm;
- 	u16 base_desc_idx, desc_idx;
+ 	int err, desc_idx;
  	bool near_call;
- 	int err;
-=20
- 	if (!insn->imm) {
- 		verbose(env, "invalid kernel function call not eliminated in verifier p=
ass\n");
- 		return -EINVAL;
- 	}
 =20
  	*cnt =3D 0;
 =20
@@@ -23572,13 -25172,13 +25213,13 @@@
  	 * __bpf_call_base, unless the JIT needs to call functions that are
  	 * further than 32 bits away (bpf_jit_supports_far_kfunc_call()).
  	 */
- 	desc =3D find_kfunc_desc(env->prog, insn->imm, insn->off);
+ 	desc =3D find_kfunc_desc(env, insn->imm, insn->off);
  	if (!desc) {
  		verifier_bug(env, "kernel function descriptor not found for func_id %u",
  			     insn->imm);
  		return -EFAULT;
  	}
- 	base_desc_idx =3D desc - env->prog->aux->kfunc_tab->descs;
+ 	desc_idx =3D desc - env->prog->aux->kfunc_tab->descs;
 =20
  	near_call =3D !bpf_jit_supports_far_kfunc_call();
  	desc_copy =3D *desc;
@@@ -23598,9 -25198,15 +25239,15 @@@
  		insn->imm =3D call_imm;
  	}
 =20
- 	err =3D add_kfunc_desc_target(env, desc, base_desc_idx, &desc_idx);
- 	if (err)
- 		return err;
+ 	if (desc->addr !=3D env->prog->aux->kfunc_tab->descs[desc_idx].addr)
+ 		desc_idx =3D add_specialized_kfunc(env, desc);
+ 	if (desc_idx < 0)
+ 		return desc_idx;
+ 	/* JITs find the descriptor by insn->off */
+ 	if (desc_idx > U16_MAX) {
+ 		verbose(env, "too many different kernel function calls\n");
+ 		return -E2BIG;
+ 	}
  	insn->off =3D desc_idx;
 =20
  	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(d=
esc->func_id)) {
@@@ -23877,13 -25483,6 +25524,13 @@@ static int bpf_prog_verify_signature(st
  			err =3D -EPERM;
  			goto out;
  		}
 +		/* The freeze is not final for it, see bpf_map_mmap() */
 +		if ((map->map_flags & BPF_F_MMAPABLE) && !(map->map_flags & BPF_F_RDONL=
Y_PROG)) {
 +			verbose(env, "signed program metadata map '%s' must not be mmapable\n",
 +				map->name);
 +			err =3D -EPERM;
 +			goto out;
 +		}
  		data_sz +=3D map->value_size;
  	}
  	if (bpf_dynptr_check_size(data_sz)) {
@@@ -23891,7 -25490,7 +25538,7 @@@
  		err =3D -E2BIG;
  		goto out;
  	}
- 	data =3D kvmalloc(data_sz, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+ 	data =3D kvmalloc(data_sz, BPF_VERIFIER_GFP | __GFP_ZERO);
  	if (!data) {
  		err =3D -ENOMEM;
  		goto out;
@@@ -23963,13 -25562,9 +25610,9 @@@ static void log_program(struct bpf_veri
  	u64 pos, insn_pos;
  	u32 i, j;
 =20
- 	verbose(env, "Program dump (scc? loop_header? idom insn#: live_regs_befo=
re):\n");
+ 	verbose(env, "Program dump (loop_header? idom insn#: live_regs_before):\=
n");
  	for (i =3D 0; i < insn_cnt; ++i) {
  		verbose_linfo(env, i, "    ; ");
- 		if (env->insn_aux_data[i].scc)
- 			verbose(env, "%3d ", env->insn_aux_data[i].scc);
- 		else
- 			verbose(env, "    ");
  		if (env->insn_aux_data[i].loop_header >=3D 0)
  			verbose(env, "%3d ", env->insn_aux_data[i].loop_header);
  		else
@@@ -24010,11 -25605,10 +25653,10 @@@ int bpf_check(struct bpf_prog **prog,=
 u
  	/* 'struct bpf_verifier_env' can be global, but since it's not small,
  	 * allocate/free it every time bpf_check() is called
  	 */
- 	env =3D kvzalloc_obj(struct bpf_verifier_env, GFP_KERNEL_ACCOUNT);
+ 	env =3D kvzalloc_obj(struct bpf_verifier_env, BPF_VERIFIER_GFP);
  	if (!env)
  		return -ENOMEM;
 =20
- 	env->bt.env =3D env;
  	env->prog =3D *prog;
  	env->ops =3D bpf_verifier_ops[env->prog->type];
  	env->stack_limit =3D bpf_prog_stack_limit(env->prog);
@@@ -24026,12 -25620,17 +25668,17 @@@
  	env->bypass_spec_v1 =3D bpf_bypass_spec_v1(env->prog->aux->token);
  	env->bypass_spec_v4 =3D bpf_bypass_spec_v4(env->prog->aux->token);
  	env->bpf_capable =3D is_priv =3D bpf_token_capable(env->prog->aux->token=
, CAP_BPF);
+ 	env->max_cost =3D BPF_MAX_COST >> (is_priv ? 0 : BPF_LIMITS_SHIFT_UNPRIV=
);
+ 	env->pass_max_cost =3D U64_MAX;
+ 	env->max_mem =3D BPF_MAX_MEM >> (is_priv ? 0 : BPF_LIMITS_SHIFT_UNPRIV);
+ 	env->hash_seed =3D get_random_u64();
  	env->signature =3D attr->signature;
 =20
  	/* user could have requested verbose verifier output
  	 * and supplied buffer to store the verification trace
  	 */
  	ret =3D bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_l=
og->size);
+ 	env->log_level =3D env->log.level;
  	if (ret)
  		goto err_free_env;
  	ret =3D bpf_diag_init(env);
@@@ -24063,14 -25662,20 +25710,20 @@@
  	/* Serialize verification of unprivileged programs. */
  	if (!is_priv)
  		mutex_lock(&bpf_verifier_lock);
+ 	ret =3D -EINTR;
+ 	if (bpf_must_abort())
+ 		goto skip_full_check;
 =20
  	len =3D env->insn_aux_data_len =3D env->prog->len;
  	env->insn_aux_data =3D
  		__vmalloc(array_size(sizeof(struct bpf_insn_aux_data), len),
- 			  GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+ 			  BPF_VERIFIER_GFP | __GFP_ZERO);
  	ret =3D -ENOMEM;
  	if (!env->insn_aux_data)
  		goto skip_full_check;
+ 	env->mem =3D len * sizeof(struct bpf_insn_aux_data);
+ 	/* the analyses that look at an insn once */
+ 	bpf_add_cost(env, len, BPF_COST_INSN);
  	for (i =3D 0; i < len; i++)
  		env->insn_aux_data[i].orig_idx =3D i;
  	env->succ =3D bpf_iarray_realloc(NULL, 2);
@@@ -24092,21 -25697,8 +25745,8 @@@
  	if (attr->prog_flags & BPF_F_ANY_ALIGNMENT)
  		env->strict_alignment =3D false;
 =20
- 	if (is_priv)
- 		env->test_state_freq =3D attr->prog_flags & BPF_F_TEST_STATE_FREQ;
  	env->test_reg_invariants =3D attr->prog_flags & BPF_F_TEST_REG_INVARIANT=
S;
 =20
- 	env->explored_states =3D kvzalloc_objs(struct list_head,
- 					     state_htab_size(env),
- 					     GFP_KERNEL_ACCOUNT);
- 	ret =3D -ENOMEM;
- 	if (!env->explored_states)
- 		goto skip_full_check;
-=20
- 	for (i =3D 0; i < state_htab_size(env); i++)
- 		INIT_LIST_HEAD(&env->explored_states[i]);
- 	INIT_LIST_HEAD(&env->free_list);
-=20
  	/* Prepare BTF and func_info needed to discover all subprograms. */
  	ret =3D bpf_prepare_btf_info(env, attr, uattr);
  	if (ret < 0)
@@@ -24122,7 -25714,7 +25762,7 @@@
  	if (ret < 0)
  		goto skip_full_check;
 =20
- 	find_subprog_properties(env);
+ 	find_subprog_properties(env, false);
 =20
  	/* Validate BTF before reporting subprogram layout errors. */
  	ret =3D bpf_check_btf_info(env, attr, uattr);
@@@ -24138,6 -25730,10 +25778,10 @@@
  	if (ret < 0)
  		goto skip_full_check;
 =20
+ 	ret =3D check_arena_stack(env);
+ 	if (ret < 0)
+ 		goto skip_full_check;
+=20
  	/* Find pointers to functions in the read-only maps of the program. */
  	ret =3D resolve_func_ptrs(env);
  	if (ret < 0)
@@@ -24148,12 -25744,6 +25792,6 @@@
  	if (ret < 0)
  		goto skip_full_check;
 =20
- 	if (bpf_prog_is_offloaded(env->prog->aux)) {
- 		ret =3D bpf_prog_offload_verifier_prep(env->prog);
- 		if (ret)
- 			goto skip_full_check;
- 	}
-=20
  	ret =3D bpf_check_cfg(env);
  	if (ret < 0)
  		goto skip_full_check;
@@@ -24186,7 -25776,8 +25824,8 @@@
  	if (ret < 0)
  		goto skip_full_check;
 =20
- 	ret =3D bpf_compute_scc(env);
+ 	/* what no JIT can run is reported first */
+ 	ret =3D mark_recursive_subprogs(env);
  	if (ret < 0)
  		goto skip_full_check;
 =20
@@@ -24205,6 -25796,17 +25844,17 @@@
  	if (ret < 0)
  		goto skip_full_check;
 =20
+ 	/*
+ 	 * It took the constants to remove dead branches and find the loops. Now=
 it's known
+ 	 * which edges the verifier may add, see bpf_head_guard_target(). What f=
ollows
+ 	 * believes the constants.
+ 	 */
+ 	ret =3D bpf_flow_place_guards(env);
+ 	if (ret > 0)
+ 		ret =3D bpf_compute_const_regs(env);
+ 	if (ret < 0)
+ 		goto skip_full_check;
+=20
  	ret =3D bpf_compute_live_registers(env);
  	if (ret < 0)
  		goto skip_full_check;
@@@ -24212,46 -25814,46 +25862,46 @@@
  	if (env->log.level & BPF_LOG_LEVEL2)
  		log_program(env);
 =20
- 	ret =3D bpf_init_scev(env);
+ 	ret =3D bpf_equation_env_init(env);
  	if (ret < 0)
  		goto skip_full_check;
 =20
- 	ret =3D bpf_compute_scev(env);
+ 	ret =3D bpf_flow_prepare(env);
  	if (ret < 0)
  		goto skip_full_check;
 =20
+ 	/* the device runs the insns that the driver was given */
+ 	ret =3D bpf_prog_is_offloaded(env->prog->aux) ? 0 : mark_fastcall_patter=
ns(env);
+ 	if (ret < 0)
+ 		goto skip_full_check;
+=20
+ 	ret =3D do_check_all(env);
  	bpf_free_subprog_jts(env);
+ 	/* while the calls are what they are in the program */
+ 	if (env->log.level & BPF_LOG_STATS)
+ 		add_insns_of_callees(env);
 =20
- 	ret =3D mark_fastcall_patterns(env);
- 	if (ret < 0)
- 		goto skip_full_check;
-=20
- 	ret =3D do_check_main(env);
- 	ret =3D ret ?: do_check_subprogs(env);
-=20
- 	/* reject recursion through the callx edges found by the main pass */
- 	if (ret =3D=3D 0 && env->callx_edges)
- 		ret =3D sort_subprogs_topo(env);
-=20
+ 	/* the driver numbers the insns like the program that it was given */
  	if (ret =3D=3D 0 && bpf_prog_is_offloaded(env->prog->aux))
  		ret =3D bpf_prog_offload_finalize(env);
 =20
- skip_full_check:
- 	kvfree(env->explored_states);
+ 	if (ret =3D=3D 0)
+ 		ret =3D bpf_insert_loop_guards(env);
 =20
- 	/* might decrease stack depth, keep it before passes that
- 	 * allocate additional slots.
- 	 */
+ skip_full_check:
+ 	/* instruction rewrites happen after this point */
  	if (ret =3D=3D 0)
  		ret =3D bpf_remove_fastcall_spills_fills(env);
 =20
- 	if (ret =3D=3D 0)
- 		ret =3D check_max_stack_depth(env);
-=20
- 	/* instruction rewrites happen after this point */
  	if (ret =3D=3D 0)
  		ret =3D bpf_optimize_bpf_loop(env);
 =20
+ 	if (ret =3D=3D 0)
+ 		ret =3D bpf_insert_recursion_checks(env);
+=20
+ 	if (ret =3D=3D 0)
+ 		bpf_lower_cast_mov(env);
+=20
  	if (is_priv) {
  		if (ret =3D=3D 0)
  			bpf_opt_hard_wire_dead_code_branches(env);
@@@ -24264,6 -25866,9 +25914,9 @@@
  			sanitize_dead_code(env);
  	}
 =20
+ 	if (ret =3D=3D 0)
+ 		ret =3D bpf_insert_arena_stack(env);
+=20
  	if (ret =3D=3D 0)
  		/* program is valid, convert *(u32*)(ctx + off) accesses */
  		ret =3D bpf_convert_ctx_accesses(env);
@@@ -24287,43 -25892,14 +25940,14 @@@
  	print_verification_stats(env);
  	env->prog->aux->verified_insns =3D env->insn_processed;
 =20
- 	/* preserve original error even if log finalization is successful */
- 	err =3D bpf_log_attr_finalize(attr_log, &env->log);
- 	if (err)
- 		ret =3D err;
-=20
  	if (ret)
  		goto err_release_maps;
 =20
- 	if (env->used_map_cnt) {
- 		/* if program passed verifier, update used_maps in bpf_prog_info */
- 		env->prog->aux->used_maps =3D kmalloc_objs(env->used_maps[0],
- 							 env->used_map_cnt,
- 							 GFP_KERNEL_ACCOUNT);
-=20
- 		if (!env->prog->aux->used_maps) {
- 			ret =3D -ENOMEM;
- 			goto err_release_maps;
- 		}
-=20
- 		memcpy(env->prog->aux->used_maps, env->used_maps,
- 		       sizeof(env->used_maps[0]) * env->used_map_cnt);
- 		env->prog->aux->used_map_cnt =3D env->used_map_cnt;
- 	}
- 	if (env->used_btf_cnt) {
- 		/* if program passed verifier, update used_btfs in bpf_prog_aux */
- 		env->prog->aux->used_btfs =3D kmalloc_objs(env->used_btfs[0],
- 							 env->used_btf_cnt,
- 							 GFP_KERNEL_ACCOUNT);
- 		if (!env->prog->aux->used_btfs) {
- 			ret =3D -ENOMEM;
- 			goto err_release_maps;
- 		}
-=20
- 		memcpy(env->prog->aux->used_btfs, env->used_btfs,
- 		       sizeof(env->used_btfs[0]) * env->used_btf_cnt);
- 		env->prog->aux->used_btf_cnt =3D env->used_btf_cnt;
- 	}
+ 	/* if program passed verifier, it gets the tables */
+ 	env->prog->aux->used_maps =3D env->used_maps;
+ 	env->prog->aux->used_map_cnt =3D env->used_map_cnt;
+ 	env->prog->aux->used_btfs =3D env->used_btfs;
+ 	env->prog->aux->used_btf_cnt =3D env->used_btf_cnt;
  	if (env->used_map_cnt || env->used_btf_cnt) {
  		/* program is valid. Convert pseudo bpf_ld_imm64 into generic
  		 * bpf_ld_imm64 instructions
@@@ -24342,6 -25918,14 +25966,14 @@@
  	env->prog =3D __bpf_prog_select_runtime(env, env->prog, &ret);
 =20
  err_release_maps:
+ 	/*
+ 	 * Finalize the log after the runtime is selected, which blinds the
+ 	 * constants of a prog of one function and can log an error. Preserve
+ 	 * the original error even if log finalization is successful.
+ 	 */
+ 	err =3D bpf_log_attr_finalize(attr_log, &env->log);
+ 	if (err)
+ 		ret =3D err;
  	if (ret)
  		release_insn_arrays(env);
  	if (!env->prog->aux->used_maps)
@@@ -24370,18 -25954,30 +26002,30 @@@ err_free_env
  	if (env->insn_aux_data)
  		bpf_clear_insn_aux_data(env, 0, env->insn_aux_data_len);
  	vfree(env->insn_aux_data);
+ 	bpf_patch_list_free(env);
  	kvfree(env->fd_array);
- 	bpf_free_scev(env);
+ 	kvfree(env->used_index.slots);
+ 	kvfree(env->kfunc_index.slots);
+ 	kvfree(env->insn_array_maps);
+ 	bpf_equation_env_free(env);
+ 	bpf_flow_free(env);
  	bpf_stack_liveness_free(env);
  	kvfree(env->cfg.postorder_nums);
  	kvfree(env->cfg.insn_postorder);
- 	kvfree(env->scc_info);
  	kvfree(env->succ);
  	kvfree(env->gotox_tmp_buf);
+ 	kvfree(env->pkt_pairs);
  	kvfree(env->callx_edges);
+ 	kvfree(env->callx_index.slots);
  	kvfree(env->func_ptrs);
+ 	for (i =3D 0; i < env->func_set_cnt; i++)
+ 		kvfree(env->func_sets[i]);
+ 	kvfree(env->func_sets);
+ 	kvfree(env->func_set_index.slots);
  	bpf_diag_free(env);
  	kvfree(env->idoms);
+ 	kvfree(env->subprog_info);
+ 	kvfree(env->subprog_topo_order);
  	kvfree(env);
  	return ret;
  }

--MGF565JeDia0oc80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsIRXAACgkQJNaLcl1U
h9Ab/Af/fgD1Dy4OjalJLWolfTTgoJ9UdYzOlFQcgIo9/lOOzkBzKiNCPmiKgnTX
OKMYu0XRcSWwK1WQ+s3FNmiH73JId15WcwojOuJ2T82J+nCH5MZZXbZZVk7FgUrS
u2sB9mYwu6s5AcxAQaAS+1sMe+go1B08da4BUAP6xagD7do+VzRkYgfbma9ayYFO
6mioQAN+5o4SCVKvgdVtRSNuyx9paUqTTB2Nyt/UnyoXp/bx3D8QkHhUNPYzzVtG
PC8EAgAz1fafayz8chL1XvzbOluYBgVOkH8EQ79e3zGEKaTouHlcPyNf1sCTrszA
mpDnA2YvuTszaasW2D/GOWWehxhfTQ==
=ep+/
-----END PGP SIGNATURE-----

--MGF565JeDia0oc80--
