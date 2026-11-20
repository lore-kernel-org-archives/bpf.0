Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161840;
	b=yePoTfcuzp9DQH0UM2/pHNakApQoCBxcDHnjWx/XBad1Zf2hI96yMWsAsuSzHWQDiO03
	 vkoZL3QgREDd0L6Z276RsJY34bjM+N1PAsW7jqVCnSuxuhRuBDYrk3HGB2+JMp1JwENsp
	 ViESW4bFG4EVAGZsTXiauFRNkulUdKGQybb+6A6fi4zCmqRIpLzCjKt2kKmp8gmWUzQR6
	 lytbqJG2TAL7HlhZ+81ocgpO5UzHdYrhH5zXuWF4Iw1wVhJbtJVPiY+Lp+fxk8Kv6ZFvc
	 7qL6CBKpTiiiAxbYhmItg8epOoP8G0nHqTjXCeGRzfmbwixMtHQGKLCC6zfb7AlcMgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161840;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B0+y3ILDGa7Yws/xHxcppCZ8uPViltPdoPh2X8I8dh0=;
	b=I6bQcvhj2ZXOyctEBBm9J1pxBjoKSYREQ/KqBPghhqrQ+JguY+rfui8dZplbCHLp8NY0
	 vP8meulLg72Ri6rkWXuewNf6gR18FPe5EdVxItNst/gfvEw4M6/eacl3iuUkFNEWDX+2R
	 yPSRCtjm5pFJHDMiggfHjhu+wAH09f94bntZV6NYUJSTgBIGmceTWJ6h1nshVljvISe1C
	 A1FVYK1QBXKmOqtNYX9e2880zv5xpFExOyxrmAqwAyZzaOcsmCP+oWFCjbv25tbtDe6xU
	 1SiqkW3VItoHcwj8N/8KzG1O5PDAVMDT41khbpRGdev0iBcDcz1C/jeVRUmgA1LFhig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bhzkgyfx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B658606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bhzkgyfx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88A01F000C4;
	Fri, 20 Nov 2026 08:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795161839;
	bh=B0+y3ILDGa7Yws/xHxcppCZ8uPViltPdoPh2X8I8dh0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BhzkgyfxMb+Clb8LURH/XteHSyqOyDSd/VSakxeESJuJ8JQNoo7CGJEFM7JK8ALKz
	 GKBuM636lA05lxE1YRoGKxp0Pyj/P0Ku/+p9m1hYl1sojjv1Ane7lV2Th2sWSIrlD9
	 Gp3iUOgZDarSUFXLBcOLP3aK1/xGuhEzhBf06YpH/fq5j58u/s8zbj9wB9+svRHBxW
	 CNw7i6FDWvPn/hXKMxCdgSv4G7MAU6R9zJ0cxVK7+66SAg1q8/39TMXuSB9PkClNlJ
	 OryiOT0hmQpPBE129b3TJRYzGgOoYYsC3GdkuHWJiXb9491Nr0MhJqcmkrPE/ukEsX
	 QYwhIUsREIY1g==
Message-ID: <sashiko-outbox-224677@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 04/49] bpf: Delete scalar evolution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261120074430.2704488-5-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
 <20261120074430.2704488-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:03:59 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] bpf: call to undeclared bpf_add_cost() and BPF_COST_SCAN in
  find_latch()
--

commit e5e45ce256ee98d6b03c38ed44f64ae0c972a296
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Delete scalar evolution

This commit removes the scalar evolution pre-pass (scev.c), its callers,
and helpers that were only used by it, and simplifies loop exit and latch
tracking to record only the first exit target and latch.

> diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> index 1101976850515..8a63bb1799a78 100644
> --- a/kernel/bpf/loops.c
> +++ b/kernel/bpf/loops.c

[ ... ]

> @@ -340,100 +291,23 @@ int bpf_loop_at_index(struct bpf_verifier_env *env=
, u32 idx)
>  }
> =20
>  /*
> - * Collect conditional jumps within n's loop that dominate 'n' and leave
> - * the loop on one edge, see bpf_edge_leaves_loop(), nearest first.
> - * A jump that cannot count the iterations takes no place, see bpf_scev_=
jump_counts().
> + * The backedge->from and its latch can reside in an inner loop of @h, e=
.g.:
> + *
> + *  1:  r7 +=3D 1;
> + *  2:  r6 +=3D 1;
> + *      if r7 =3D=3D 2 goto 1b;
> + *      if r6 < 2 goto 2b;
> + *
> + * For now, let's assume that latches are unknown for such cases.
> + * (GCC/LLVM handle this by inserting artificial cfg nodes).
>   */
> -static int find_dominating_conditions(struct bpf_verifier_env *env, int =
n,
> -				      struct bpf_backedge *backedge)
> +static int find_latch(struct bpf_verifier_env *env, int h, int n)
>  {
> -	struct bpf_insn *insns =3D env->prog->insnsi;
> -	bool t_exits_loop, f_exits_loop;
> -	int *idoms =3D env->idoms;
> -	int n_loop, counts;
> -
> -	n_loop =3D bpf_loop_at_index(env, n);
> -	if (idoms_intersect(env, n, n_loop) !=3D n_loop)
> -		return 0;
> -	while (n >=3D 0) {
> -		if (is_cond_jmp_insn(&insns[n]) && bpf_loop_at_index(env, n) =3D=3D n_=
loop) {
> -			t_exits_loop =3D bpf_edge_leaves_loop(env, n_loop, n, n + insns[n].of=
f + 1);
> -			f_exits_loop =3D bpf_edge_leaves_loop(env, n_loop, n, n + 1);
> -			/* latches[0] is the latch: it has to leave the loop itself */
> -			if ((t_exits_loop || f_exits_loop) &&
> -			    (backedge->latches_cnt || bpf_jump_leaves_loop(env, n_loop, n))) {
> -				counts =3D !backedge->latches_cnt ? 1 :
> -					 bpf_scev_jump_counts(env, n_loop, n, t_exits_loop);
> -				if (counts < 0)
> -					return counts;
> -				if (!counts)
> -					goto next;
> -				if (backedge->latches_cnt =3D=3D MAX_LATCHES)
> -					return 0;
> -				if (t_exits_loop)
> -					backedge->taken_leaves |=3D BIT(backedge->latches_cnt);
> -				backedge->latches[backedge->latches_cnt++] =3D n;
> -			}
> -		}
> -next:
> -		if (n =3D=3D n_loop)
> -			break;
> -		n =3D idoms[n];
> -	}
> -	return 0;
> -}
> -
> -/*
> - * Without @flags: the jumps that leave a loop themselves. That tells wh=
ere the verifier may add
> - * may_goto. It takes the constants that hold with these edges to follow=
 a flag.
> - * Once more after scalar evolution, which knows the jumps that count. T=
he flags that were found
> - * are remembered.
> - */
> -int bpf_find_latches(struct bpf_verifier_env *env, bool flags)
> -{
> -	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> -	struct bpf_backedge *backedge;
> -	struct bpf_loop *loop;
> -	int i, j, k, err;
> -
> -	if (flags) {
> -		err =3D bpf_compute_leave_conds(env);
> -		if (err)
> -			return err;
> -	}
> -	for (i =3D 0; i < env->prog->len; i++) {
> -		loop =3D aux[i].loop;
> -		if (!loop)
> -			continue;
> -		for (j =3D 0; j < loop->backedges_cnt; j++) {
> -			backedge =3D &loop->backedges[j];
> -			backedge->latches_cnt =3D 0;
> -			backedge->taken_leaves =3D 0;
> -			/*
> -			 * In theory, the backedge->from and it's latch can reside in
> -			 * an inner loop of `i`, e.g.:
> -			 *
> -			 *  1:  r7 +=3D 1;
> -			 *  2:  r6 +=3D 1;
> -			 *      if r7 =3D=3D 2 goto 1b;
> -			 *      if r6 < 2 goto 2b;
> -			 *
> -			 * For now, let's assume that latches are unknown for such cases.
> -			 * (GCC/LLVM handle this by inserting artificial cfg nodes).
> -			 */
> -			if (bpf_loop_at_index(env, backedge->from) !=3D i)
> -				continue;
> -			err =3D find_dominating_conditions(env, backedge->from, backedge);
> -			if (err)
> -				return err;
> -			for (k =3D 1; flags && k < backedge->latches_cnt; k++)
> -				if ((env->log.level & BPF_LOG_LEVEL2) &&
> -				    !bpf_jump_leaves_loop(env, i, backedge->latches[k]))
> -					bpf_log(&env->log, "loop at %d, exit by way of a flag at %d\n",
> -						i, backedge->latches[k]);
> -		}
> -	}
> -	return 0;
> +	if (bpf_loop_at_index(env, n) !=3D h || idoms_intersect(env, n, h) !=3D=
 h)
> +		return -1;
> +	for (; n >=3D 0 && !bpf_insn_leaves_loop(env, h, n); n =3D n =3D=3D h ?=
 -1 : env->idoms[n])
> +		bpf_add_cost(env, 1, BPF_COST_SCAN);
> +	return n;
>  }

[Severity: High]
Does find_latch() break the build at this commit by calling bpf_add_cost()
with BPF_COST_SCAN before they are defined?  Those symbols are only
introduced in the following patch in the series, commit "bpf: Limit the
cost and the memory of a load", so kernel/bpf/loops.o fails to compile
with CONFIG_BPF_SYSCALL=3Dy here, breaking bisection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120074430.2704=
488-1-alexei.starovoitov@gmail.com?part=3D4
