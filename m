Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811791;
	b=iOWZ6S1r72A2Q8lRZQn3RsT9SzJXBe5f7UdgAqZFKvyV2RjJDpVN/U5B5F/WK5c0L5/5
	 SVXjgvPLRXL1sq3ZL76DCPXB6vTvjXKqaRRHl11tWSSAAftbD+gvCCf5dkjw7IJvu6tZd
	 7lI0K7gJiQcEp+JLDbAA76jQ7Wkud04mMJFkYeXKfSIT5hZhyaMyryiEb5bgFh75A5U5o
	 pBtXC/JFpghkrorxd+no/9mpkDVQSFJInmee6AzkCvCwxBJfGfyxu744XQLdopTyDViNi
	 XQbY2R/3MQ1vTP6oEU8hib7SMImQXCdV0HKSWT/K0Bh49SHyEhdnCeM8GIGvfP3tB9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811791;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6LOJgJcBq6NPbxYKPgO/uEgUQ4sajArMhhtV5Vxm1W4=;
	b=u/mwrCBDfsUQURJ3Lmsv2T+AGcRcIhOrBMJzt5eGBmHsinDQ8KWspb1Gk9pL8FwIQEek
	 4W1LarFsS7jfTRy3OUVzGP1vB8wo/9tzgyWIFWjLvWtbmcEAh3RcwvhS/mnT4LXOSrbk3
	 6V7BQz+gRmLQ4GpP3gepnCaEy7a1gE7LltwnideZ+7T4hlhaoQIHMidr6GML5kMZApDi0
	 arCkxGJrYNht4VcY+NOX/h8BdLU50NbjzvKob16AmC231epNZNUtWBXfzMDrGElRTk3EQ
	 ULACl25NT1rasNsojkrrnWtKW8NwHvYNA16TyJmFGhMzu4FWPQb1nzD0Zhjrdl7rr2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCy7xwCv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9E606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCy7xwCv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305141F000C9;
	Mon, 16 Nov 2026 06:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794811791;
	bh=6LOJgJcBq6NPbxYKPgO/uEgUQ4sajArMhhtV5Vxm1W4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cCy7xwCvq3W/H6nS/9gFpvShYTO9YYmuUCAH1erUr1TiAFHBEQATt11PEuVP/Q6pu
	 uTjVpz2KO8wp70yo03UP9WK5qwEgl584YLL6dR4oiy5Ux4Ih1B8qZoRu2YGx5VdoLR
	 QyjUVo/h1XbA8fHTCHsizs6BSM4n15EylFhnapCaOYIVbDvZmrlehmoJz70gVKu/Ii
	 9wxP+h9qIzuYA3LTqWSwlLSQ1OlxicG4Dw1GPmawgU788skDrYPWBmO02LvjN5+ygV
	 EMibsOpwvhm5N/zYGtCvKFJbUwkP0/86+kXxnXA4b64xEMT0cXNz0Xoa67S7IkOKPE
	 N3gIX2NcLWgfQ==
Message-ID: <sashiko-outbox-216329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 01/21] bpf: Stop a load only when the loader is
 killed or has to freeze
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116055638.4171529-2-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
 <20261116055638.4171529-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:49:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] bpf: unmasked BPF_COMMON_ATTRS in sys_bpf() skips
  -ERESTARTNOINTR
- [Medium] bpf: stale map->user state across restart on blinding abort
  in bpf_check()
- [Medium] bpf: bpf_log_attr_finalize() overwrites -EINTR on
  bpf_must_abort()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] bpf: out-of-bounds write to core_relo_rec_size in
  bpf_check_core_relo() [1]
--

commit 3d463cd1b62b606f3634c39818c65fed7d7789b2
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Stop a load only when the loader is killed or has to freeze

This commit introduces bpf_must_abort() so that BPF loading only aborts with
-EINTR on fatal signals or freezer requests, and restarts the syscall via
-ERESTARTNOINTR after freezing.

> diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
> index 8a3f2421331e0..d6b930377d753 100644
> --- a/kernel/bpf/check_btf.c
> +++ b/kernel/bpf/check_btf.c
> @@ -402,8 +402,8 @@ int bpf_check_core_relo(struct bpf_verifier_env *env,
>  			break;
>  		}
> =20
> -		err =3D bpf_core_apply(&ctx, &core_relo, i,
> -				     &prog->insnsi[core_relo.insn_off / 8]);
> +		err =3D bpf_must_abort() ? -EINTR :
> +		      bpf_core_apply(&ctx, &core_relo, i, &prog->insnsi[core_relo.insn=
_off / 8]);
>  		if (err)
>  			break;
>  		bpfptr_add(&u_core_relo, rec_size);

[Severity: High]
This problem wasn't introduced by this patch, but can the -E2BIG error path
earlier in this loop write past the end of uattr [1]?

__sys_bpf() copies size bytes from uattr into a zero-initialized union
bpf_attr without passing size down to bpf_prog_load() or bpf_check().  On
little-endian architectures, a size that covers the start of
core_relo_rec_size but ends before offsetofend(union bpf_attr,
core_relo_rec_size) still forms a valid attr->core_relo_rec_size.  When
bpf_check_uarg_tail_zero() then returns -E2BIG:

kernel/bpf/check_btf.c:bpf_check_core_relo() {
    ...
		err =3D bpf_check_uarg_tail_zero(u_core_relo, expected_size, rec_size);
		if (err) {
			if (err =3D=3D -E2BIG) {
				verbose(env, "nonzero tailing record in core_relo");
				if (copy_to_bpfptr_offset(uattr,
							  offsetof(union bpf_attr, core_relo_rec_size),
							  &expected_size, sizeof(expected_size)))
					err =3D -EFAULT;
			}
			break;
		}
    ...
}

copy_to_bpfptr_offset() writes all 4 bytes of expected_size to uattr without
checking that size covers the full field.  When invoked from a
BPF_PROG_TYPE_SYSCALL program via bpf_sys_bpf(), uattr is a kernel pointer
for which the verifier only validates [attr, attr + size), so this writes up
to three zero bytes out of bounds into adjacent BPF stack or map value
memory.

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 1d33a78d93739..735932392a87f 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -165,19 +164,6 @@ static int get_callee_stack_depth(struct bpf_verifie=
r_env *env,
>  }
>  #endif
> =20
> -/*
> - * A post-verification rewriting pass can queue a patch for each instruc=
tion
> - * of a large program. Keep the primitives that queue them killable and
> - * preemptible.
> - */
> -static bool bpf_rewrite_must_abort(void)
> -{
> -	if (fatal_signal_pending(current))
> -		return true;
> -	cond_resched();
> -	return false;
> -}
> -
>  /*
>   * Queue the replacement of insn 'off' by 'patch[0..len)' until
>   * bpf_patch_list_commit(), see __bpf_patch_list_add(). Replacing one in=
sn by
> @@ -190,7 +176,7 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifi=
er_env *env, u32 off,
>  	struct bpf_patch_list *pl =3D &env->patch_list;
>  	struct bpf_insn_patch *p =3D pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
> =20
> -	if (bpf_rewrite_must_abort())
> +	if (bpf_must_abort())
>  		return ERR_PTR(-EINTR);

[Severity: Medium]
Can aborting here on a freezer request leave map->user modified or unreleas=
ed
when BPF_PROG_LOAD restarts?

Previously bpf_rewrite_must_abort() only triggered on fatal signals, where
the task exits.  With bpf_must_abort(), a freeze during
__bpf_prog_select_runtime() -> bpf_prog_jit_compile() ->
bpf_jit_blind_constants() -> bpf_patch_list_add() returns -EINTR to
bpf_check() after two state changes have already happened for a
single-subprog program:

1. bpf_fixup_call_args() -> bpf_jit_subprogs() -> resolve_func_ptrs() has
   already set BPF_MAP_USER_PATCHED on ptr->map->user and zeroed *slot in t=
he
   map if static subprogs referenced in a frozen read-only map were removed
   as dead code.
2. env->prog->aux->used_maps has already been populated, so err_release_maps
   skips synchronous release_maps(env) and defers __bpf_free_used_maps() to
   system_wq via schedule_work(&aux->work); __bpf_free_used_maps() also only
   runs cmpxchg(&map->user, (unsigned long)aux, 0), which does not clear
   aux | BPF_MAP_USER_PATCHED.

When the task thaws and restarts BPF_PROG_LOAD via -ERESTARTNOINTR,
bpf_map_claim() or resolve_func_ptrs() can see the stale map->user state and
fail with -EBUSY or treat a private map as BPF_MAP_USER_MANY.

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 04a3b3c80c74e..9c55f5ed8ced5 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6604,7 +6604,13 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t ua=
ttr, unsigned int size,
>  SYSCALL_DEFINE5(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned =
int, size,
>  		struct bpf_common_attr __user *, uattr_common, unsigned int, size_comm=
on)
>  {
> -	return __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_commo=
n), size_common);
> +	int err =3D __sys_bpf(cmd, USER_BPFPTR(uattr), size, USER_BPFPTR(uattr_=
common), size_common);
> +
> +	/* bpf_must_abort() ended the command, nothing of it is left */
> +	if (err =3D=3D -EINTR && task_sigpending(current) &&
> +	    (cmd =3D=3D BPF_PROG_LOAD || cmd =3D=3D BPF_BTF_LOAD || cmd =3D=3D =
BPF_MAP_CREATE))
> +		return -ERESTARTNOINTR;
> +	return err;
>  }

[Severity: Medium]
Does this check miss calls that set BPF_COMMON_ATTRS in cmd?

__sys_bpf() clears BPF_COMMON_ATTRS on its local copy of cmd (cmd &=3D
~BPF_COMMON_ATTRS), so cmd in SYSCALL_DEFINE5(bpf) still has that bit set a=
nd
returns -EINTR instead of -ERESTARTNOINTR to callers usinguattr_common.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e4fcd1c9242d4..03f8b2f335969 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21790,11 +21790,8 @@ static int do_check_block(struct bpf_verifier_en=
v *env, int prev_insn_idx)
>  		struct bpf_insn_aux_data *insn_aux;
>  		int err;
> =20
> -		if (signal_pending(current))
> -			return -EAGAIN;
> -
> -		if (need_resched())
> -			cond_resched();
> +		if (bpf_must_abort())
> +			return -EINTR;

[Severity: Medium]
Can bpf_log_attr_finalize() overwrite -EINTR with -ENOSPC when a load with a
user log buffer is aborted by bpf_must_abort()?

In both bpf_check() and bpf_btf_load(), the error path runs:

kernel/bpf/verifier.c:bpf_check() {
    ...
err_release_maps:
	err =3D bpf_log_attr_finalize(attr_log, &env->log);
	if (err)
		ret =3D err;
    ...
}

If log->len_max > log->len_total when bpf_must_abort() triggers (including
under BPF_LOG_LEVEL1 when ret =3D=3D -EINTR causes do_check() to run
bpf_flow_print_way() and do_check_common() to skip bpf_vlog_reset(&env->log,
0) before print_verification_stats()), bpf_log_attr_finalize() returns
-ENOSPC and overwrites ret =3D -EINTR, so SYSCALL_DEFINE5(bpf) returns -ENO=
SPC
to user space instead of restarting with -ERESTARTNOINTR.

[1] https://sashiko.dev/#/bug/linux-e8be0f6f-dada-49a6-9534-0a5b7e8f9218

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055638.4171=
529-1-alexei.starovoitov@gmail.com?part=3D1
