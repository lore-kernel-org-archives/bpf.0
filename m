Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845751;
	b=gTuEHXOzQIZD/FevXojxgip7aa68FDJxoHzRGqiEx1WeD0CFeqxj6rc+hKER1H+WaM34
	 0NjCJG+5joxIOcO2d32LIJ1QcoOTZ7UiyLTa03+u/yghLEEf7V/Dz8iJMY5aU/tzzanYc
	 wJ3Q0uzv2IYsLq2Dpf9bcQ9jvdfD8s5hLmGjTJxeV4q2sVkk53VuyF5f5qyxjRFFgv1MD
	 u0mJT25Nr58w/gUC5iV/Tz34qu/ifTAlauVUhQC+RMvWdlIld91uy5gJLGckE7A8TJBwb
	 6FwS7nGn3oUb/yIXt/Hoba5YVXl6mLN3VCcdMJAz619a8xDlu0Ut0IfPLqIG13kf0SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845751;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LB3eMm+y8Vg4ii/RAEgwwHpXwDy4082aZVs1cSgCziE=;
	b=H0DeeICohICwCn8SAT7FQpDCwdG/8OwZL8Srj0F85NvWLlfG/egl6AROU5YjMLw2mBR/
	 csNvIzla51PDwasQiKYo7HJICQcRewIWGRLqs9SC9oaF6NYq+hilhJd5Y4yxANT9VSoPV
	 KV3faAuMnJqNbC/MXCIfwyalRufo8Mrfw53lXmmtHI+YUZ2S8gw26+rGpllJG8taXbuwz
	 CjFlfCojhvQPzHFpHMH5fW2J4KPHWM42HM00HBS0zPNssfljUXPa/qQfXxd+2vioHm/Fe
	 BpRppvMTZbK+VsSb0jJ2jkLqklhb0D1I/rZR0onTuoMDHDIOnsrSUQwwoGPKcpqrQbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1ToS0Ii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F79606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1ToS0Ii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EF71F000C4;
	Mon, 16 Nov 2026 16:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845751;
	bh=LB3eMm+y8Vg4ii/RAEgwwHpXwDy4082aZVs1cSgCziE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=F1ToS0IihhXhqHq8CrcQC0iVfy/JFxpXqwGmArNU69LGDIUeungleTKuALGkBeCBU
	 nAv8XsBGBPTNImwRflM9Z5zoDdq6DrMSJwWzIbjVU+bArSfkWC7mdaYu6KEw2RpSZ+
	 X0E+DrddB64bwjY1yNTeV4fcpE9fWTiiNWIz6sI3WeykhvaeWsSDhtLHhf7cdF3a1g
	 nA5L5Se2oNegp3qZxADBeIsARf9Ly+pa5P8dc6krKfNkxAzZgsXMmGUep4ODcarmma
	 BRL+L60iWigS0wRfincYQvae+u2ne2JnfMKJPRPMG7rWo2MePdzW8BSWkeL14x7MvP
	 +nschLQGbJZFg==
Message-ID: <sashiko-outbox-217351@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 01/21] bpf: Stop a load only when the loader
 is killed or has to freeze
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116152626.4032587-2-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
 <20261116152626.4032587-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 16:15:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] bpf: bpf_log_attr_finalize() overwrites -EINTR on
  bpf_must_abort()
- [Medium] bpf: stale map->user state across restart on blinding abort
  in bpf_check()
--

commit 595bfc06524fa376713bc6415b648b32cc04152d
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Stop a load only when the loader is killed or has to freeze

This commit replaces signal_pending() and fatal_signal_pending() checks acr=
oss
verifier passes with a unified bpf_must_abort() helper that aborts with -EI=
NTR
only when the loader has a fatal signal or needs to freeze, and restarts
BPF_PROG_LOAD, BPF_BTF_LOAD, and BPF_MAP_CREATE via -ERESTARTNOINTR.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 1d33a78d93739..735932392a87f 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
[ ... ]
> @@ -190,7 +176,7 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifi=
er_env *env, u32 off,
>  	struct bpf_patch_list *pl =3D &env->patch_list;
>  	struct bpf_insn_patch *p =3D pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
> =20
> -	if (bpf_rewrite_must_abort())
> +	if (bpf_must_abort())
>  		return ERR_PTR(-EINTR);

[Severity: Medium]
Can aborting on a non-fatal freezer request here leave mutated map state
behind when BPF_PROG_LOAD restarts?

For a single-subprog program, bpf_check() runs bpf_fixup_call_args() ->
bpf_jit_subprogs() -> resolve_func_ptrs(), which sets BPF_MAP_USER_PATCHED =
on
ptr->map->user and zeroes dead function-pointer slots in the frozen read-on=
ly
map, and then populates env->prog->aux->used_maps before calling
__bpf_prog_select_runtime():

kernel/bpf/verifier.c:bpf_check() {
    ...
	env->prog =3D __bpf_prog_select_runtime(env, env->prog, &ret);

err_release_maps:
	err =3D bpf_log_attr_finalize(attr_log, &env->log);
	if (err)
		ret =3D err;
	if (ret)
		release_insn_arrays(env);
	if (!env->prog->aux->used_maps)
		release_maps(env);
    ...
}

If constant blinding inside __bpf_prog_select_runtime() ->
bpf_prog_jit_compile() -> bpf_jit_blind_constants() hits bpf_must_abort() in
bpf_patch_list_add(), it returns -EINTR after the map was already modified =
and
with env->prog->aux->used_maps already set.  Synchronous release_maps() is
skipped, __bpf_free_used_maps() is deferred to a workqueue (and its
cmpxchg(&map->user, (unsigned long)aux, 0) cannot clear BPF_MAP_USER_PATCHE=
D),
and when the thawed task restarts BPF_PROG_LOAD via -ERESTARTNOINTR,
bpf_map_claim() either fails with -EBUSY or races with the deferred map
release work.

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 04a3b3c80c74e..70caab9648d67 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6604,7 +6604,14 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t ua=
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
> +	cmd &=3D ~BPF_COMMON_ATTRS;
> +	/* bpf_must_abort() ended the command, nothing of it is left */
> +	if (err =3D=3D -EINTR && task_sigpending(current) &&
> +	    (cmd =3D=3D BPF_PROG_LOAD || cmd =3D=3D BPF_BTF_LOAD || cmd =3D=3D =
BPF_MAP_CREATE))
> +		return -ERESTARTNOINTR;
> +	return err;
>  }

[Severity: Medium]
Does bpf_log_attr_finalize() overwrite -EINTR with -ENOSPC and prevent the
syscall from restarting after freezing?

When bpf_check() aborts with ret =3D -EINTR, its cleanup path still finaliz=
es
the verifier log:

kernel/bpf/verifier.c:bpf_check() {
    ...
err_release_maps:
	err =3D bpf_log_attr_finalize(attr_log, &env->log);
	if (err)
		ret =3D err;
    ...
}

If the user supplied a log buffer and log->len_max > log->len_total (for
example, a rolling log buffer, or under BPF_LOG_LEVEL1 where do_check() cal=
ls
bpf_flow_print_way() on err =3D=3D -EINTR and do_check_common() skips
bpf_vlog_reset()), bpf_log_attr_finalize() returns -ENOSPC and clobbers
ret =3D -EINTR.  SYSCALL_DEFINE5(bpf) then sees err =3D=3D -ENOSPC instead =
of
-EINTR and returns -ENOSPC to user space after thawing instead of
-ERESTARTNOINTR.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152626.4032=
587-1-alexei.starovoitov@gmail.com?part=3D1
