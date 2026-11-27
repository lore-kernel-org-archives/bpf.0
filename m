Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794944;
	b=eP7zoCyBV/hN914bsdw5isbf1kOp0g4epKVTvrlrB4bnylYBde0ZWWifCb9Cu6epQSJK
	 /7DfRIjSrNWD0jTOWOf3wIQ3vVOCINUuICQLh6NAMPMvKOi9pPtzoV3zIb6OSGXkJFNym
	 XQt8C6bcPUDl+jLjzca1G1XYiZ5BWgTAYRC0KWwyuIylB5+UIGRi4ADpuQAGw9ADIE4E7
	 1+zB1ZCnI1hKBQY3NrRA3wDmSt6fthxqflzoek+T7Q5KK80grVZr5KpQKXEJWlSeg+8ro
	 kX/lb0SKnryYxUJQvsfh46H81I9/b8nJz6YJ6sWZOakswXAclWyuiXeZ8DLzV6JhLVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794944;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=1pqLOfrF4A8gzlm1vcy72kMFFObqAYDDR49GStzDPdE=;
	b=NysZnNLp7sOfR97QTSZg8O/8TFPiMU9g8lW7wrcWGFbFG/vMwu1nrszSnJGf9CVzY7O1
	 Jax3y6dP5GtFMk+Wm/W16R5EqRzM+jN1tEihGE1lgsv1GiV1Vkils+4kKHBck2vA4uOj/
	 j0YQDcyLZGtmmtSTcITNtBz028eebdizkJQbmZXsAGUR69AQQYTaINIbGLsI3rVC53jWd
	 oO3O7F9dvZ+sI9HHI0TWwKuwG4i3c2YaVGCZzPn+3i+kptQkdIKp5CRgP46O2VNhCKX99
	 4D6UEgUsgA5AfusHH6DuaAQjyYjGeLCyUOEXLvxoaaX8ImxBToketnBhqoqhnYcNp4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esHtmYzR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC0A606A6B2;
	Fri, 27 Nov 2026 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esHtmYzR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2E21F00935;
	Fri, 27 Nov 2026 15:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794944;
	bh=1pqLOfrF4A8gzlm1vcy72kMFFObqAYDDR49GStzDPdE=;
	h=Date:From:To:Cc:Subject;
	b=esHtmYzR9mOJwSZWNxi3fvy2fk8vFZ/W7wPy8e6WxiJNpFT087gCImuyRzyWEfmzB
	 iE0Jin7VyV6M5L2bPXqB8GTvsi2RJPOJPfBIYP16izzSCDa+TCFEmwU4Lmz0BMk6V2
	 emd08Qk2pHrlnjPCN8rrlMqWbpxNMHaAAFnEJFHr1jAtjjIAAb5WK4OKOr4nt77PvV
	 XK9D8hzGUHEbRi9o+Rrg2kNe65AvumeU33FUU1XQpn3jCvpOz/pWF229f8VfvfeBNw
	 Y5KKeFA89EP/GyF9iN/9l+dEK+oJyhyYiXGTJr6IhHEfEzSMnHUvxGPcY9y89qRydt
	 /TUxXp2qU5PfQ==
Date: Fri, 27 Nov 2026 15:55:39 +0000
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
Message-ID: <awmn-8pxvHphS_xZ@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="/PoCzhzasBjJC5sz"
Content-Disposition: inline


--/PoCzhzasBjJC5sz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/verifier.c

between commit:

  02d3452bdd80c ("bpf: Set the run context for async callbacks")

=66rom the bpf tree and commit:

  d83c595d9480e ("bpf: Put a barrier where no mask fits")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc kernel/bpf/verifier.c
index 85fec1f389277,b5dda95c286f7..0000000000000
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@@ -11493,13 -11472,9 +11477,15 @@@ static int push_callback_call(struct bp
  	if (bpf_is_async_callback_calling_insn(insn)) {
  		struct bpf_verifier_state *async_cb;
 =20
+ 		if (state->speculative)
+ 			return 0;
  		/* there is no real recursion here. timer and workqueue callbacks are a=
sync */
 +		/* there is no cgroup to take the storage from */
 +		if (env->prog->aux->cgroup_storage[BPF_CGROUP_STORAGE_SHARED] ||
 +		    env->prog->aux->cgroup_storage[BPF_CGROUP_STORAGE_PERCPU]) {
 +			verbose(env, "async callback in a program with cgroup storage\n");
 +			return -EINVAL;
 +		}
  		env->subprog_info[subprog].is_async_cb =3D true;
  		async_cb =3D push_async_cb(env, env->subprog_info[subprog].start,
  					 insn_idx, subprog,
@@@ -20834,46 -21913,109 +21938,109 @@@ static int do_check_block(struct bp=
f_ve
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
 -		/* only a store that stays gets it, see bpf_convert_ctx_accesses() */
++		/* End speculation at a retained store with a trailing barrier. */
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

--/PoCzhzasBjJC5sz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsJp/oACgkQJNaLcl1U
h9Cgdgf/Sd/j3w9NuY65xVxvzrMsCU66equD86VLI+q8OEoqjjKeZqAUhk1XsA6z
YVMejQHO6276bzqcDELizjYRaUKr2r4erE8MEWtUskbVi0HbLM24swha+CLRURr2
aZTjo0mk76zMP/7A6tS90ceYH+cgLuSLcQhj4Cuk24FpmFOfVtHgtKi7n6MLruTM
AgZxI/3mBIDk2fSsl1+qW9jzs9cpVCxZ+eu/Zrz/UNrZ5gzi2hPKxwfktU0N+Ny5
L0M0US3TYcet8D1jlxe8XAEQweYcQzjsETTf+qH6X5pLrZ4fdD9BTOqtn+d8NUgM
CpZB9U7mgugBUcHIHol+iHxhKYkNtQ==
=LfCN
-----END PGP SIGNATURE-----

--/PoCzhzasBjJC5sz--
