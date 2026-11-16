Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856881;
	b=v2UhC++yzdIcBP8GKggToo0zTYXz34tPvhXossrGYppBAvj0Mc7FgJIUIJOpmcCX4v+3
	 2vJ0g4wOz76G85s6ZZZc7lFpwfv3vG7v/PUsJ9jEhYYLJwLLmyUgQjVUezbDGGQRZLzD9
	 NroON17kxe7MbjuYX5SwVTj4QoyKEColC3uHGP4ZW6OOkykQ5Iic7m5c7gV02Fg2lUz1A
	 0O0myUVja7yN7oRAdn38QsbKYFllWTCQvext4xIHeXl8Uqw8lsCDUXJiEm2zuF/IpvziA
	 DUNeaf6Upf2ZOpwOJq8rH5fkKJI36ez4jKC5dsHoGubw7moFtxgWZx0tnyRh9fRTPOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856881;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jFvkKb0JIdW5FJHR7Y8Wjg4exloLal42ylRg7zJ9g0o=;
	b=DOsojrtncucD4FJMZ3F3Xmx2kU2FIGYiXCw86aM7xAApVHrlH0tJooxkpPZXYTh56lvI
	 o1z53V85envf5xHeprEBoBKlA7gypyYBG3pj+0+n7Vc1EWacp/s3ymQC3W99FacThsAeD
	 Cf3lD90KLYMuh1vHF8drblPEtaN7IBKT+PKJOYJmWfBm9zY65WIFy6UGNF2rcqDbTpZlq
	 34zMuvh9U1uOxL7E1WbwGFbtGs7CJRayD4mmKYijjpg3LCrYfPlE8oQTfkYON+p6AzBR4
	 m8LnkRprikEpHSSBA7gzy+GVj9WKSax/ot+FyltgyEud7Qriv5S5gXdIFUvcqMBNU8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATVu33Aa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57551606A322
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATVu33Aa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B341F000C4;
	Mon, 16 Nov 2026 19:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794856881;
	bh=jFvkKb0JIdW5FJHR7Y8Wjg4exloLal42ylRg7zJ9g0o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ATVu33AafbQF5YFVvMT0IHbajzPi99rKG7ELx8GuWyEmuEauEo2U6ULXCF/uDMUNk
	 Nj91Egev16yAA8WsZ9UfFaD5YlYkx4/mESbpxzYlCS5RsK3AMPZQ9GY6iFG/TfabY9
	 g7AceSbUpUWXoVO/ZTJXGr7MjrnsnWxfVq8Xr/F/Om/bQkwOuvtuD1eXZL2iOzPtMK
	 peg96WNY+yVIkUt96zyUCSkzlMAjjv0OxMPefmZ5Un/ZmyvWiQoZb9N/iRFP54WNzp
	 oDxlUZaayHmAW/1yjcK/nYUGpTyCAYEcnEhpYCImVrMoyB6il1MoflT9Rp+Tryiumb
	 G851WOAV9x0FQ==
Message-ID: <sashiko-outbox-217549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 13/21] bpf: Keep the call graph in lists of
 edges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116152626.4032587-14-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
 <20261116152626.4032587-14-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:21:20 +0000
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
- [Medium] bpf: stale recursive flag on dead subprogs in
  check_recursion()
--

commit 539e11dd4eb699b7232e8c0101b8c5c17216cd6e
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Keep the call graph in lists of edges

This commit replaces the bitmap-based call graph with edge lists sorted via
Tarjan's algorithm and restricts post-verification call graph analysis to
instructions seen during the main pass.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c5a44c887adaa..5fe15a4b3bd8e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -5447,122 +5385,75 @@ static int round_up_stack_depth(struct bpf_verif=
ier_env *env, int stack_depth)
[ ... ]
>  static int build_call_graph(struct bpf_verifier_env *env, struct bpf_cal=
l_graph *cg)
>  {
>  	struct bpf_subprog_info *si =3D env->subprog_info;
>  	struct bpf_insn *insn =3D env->prog->insnsi;
> -	int cnt =3D env->subprog_cnt, words =3D BITS_TO_LONGS(cnt);
> -	int i, j, s;
[ ... ]
> +	err =3D bpf_call_graph_init(cg, cnt);
>  	for (s =3D 0; s < cnt; s++) {
> -		for (i =3D si[s].start; i < si[s + 1].start; i++) {
> -			/* the subprog that takes the address of a subprog counts as its call=
er */
> -			if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
> -				continue;
[ ... ]
> -		}
> -		/* the callees of callx and the callbacks of helpers, see record_callx=
_edge() */
> -		for (j =3D next_callx_callee(env, s, 0); j >=3D 0; j =3D next_callx_ca=
llee(env, s, j + 1))
> -			__set_bit(j, subprog_calls(cg, s));
> +		for (i =3D si[s].start; i < si[s + 1].start && !err; i++)
> +			if (bpf_pseudo_call(insn + i) && env->insn_aux_data[i].seen)
> +				err =3D bpf_call_graph_add(cg, s, bpf_find_subprog(env,
> +							 i + insn[i].imm + 1));
> +		/* the callees of callx and the callbacks of helpers */
> +		for (i =3D si[s].callx_edge; i && !err; i =3D env->callx_edges[i - 1].=
next)
> +			err =3D bpf_call_graph_add(cg, s, env->callx_edges[i - 1].callee);
>  	}
> -	memcpy(cg->reach, cg->calls, cnt * words * sizeof(long));
> -	close_call_graph(cg->reach, cnt);
> +	if (err)
> +		return err;
> +	bpf_call_graph_sort(cg, 0);
> =20
>  	for (s =3D 0; s < cnt; s++)
>  		if (!s || si[s].is_async_cb)
> -			add_reach(cg, cg->live, s);
> +			cg->marks[s] =3D CG_LIVE;
> +	bpf_call_graph_mark_callees(cg, CG_LIVE);
[ ... ]
> @@ -5611,8 +5498,8 @@ static int check_recursion(struct bpf_verifier_env =
*env, struct bpf_call_graph *
>  {
>  	int j, s;
> =20
> -	for_each_set_bit(s, cg->live, cg->cnt) {
> -		if (!test_bit(s, subprog_reach(cg, s))) {
> +	for_each_marked_subprog(cg, s, CG_LIVE) {
> +		if (!bpf_call_graph_recursive(cg, s)) {
>  			env->subprog_info[s].recursive =3D false;
>  			continue;
>  		}

[Severity: Medium]
Does check_recursion() leave env->subprog_info[s].recursive set on
subprogs that are not marked CG_LIVE?

Before the main pass, mark_recursive_subprogs() builds a conservative call
graph over all instructions and sets si[s].recursive =3D true for every
subprog on a cycle.  After the main pass, build_call_graph() ignores unseen
bpf_pseudo_call instructions and bpf_pseudo_func address loads, so a
subprog reachable only from a dead call or an uncalled address load is no
longer marked CG_LIVE and check_recursion() skips it without clearing
env->subprog_info[s].recursive.

Later, bpf_insert_recursion_checks() runs before bpf_opt_remove_dead_code()
and inspects si[s].recursive across all subprogs regardless of CG_LIVE:

kernel/bpf/fixups.c:bpf_insert_recursion_checks() {
	...
	for (s =3D 1; s < env->subprog_cnt; s++)
		found |=3D si[s].recursive;
	if (!found)
		return 0;
	env->prog->jit_required =3D 1;
	...
}

This patches recursion checks into the dead subprog and sets
prog->jit_required =3D 1, causing bpf_fixup_call_args() to reject valid
non-JITed programs with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152626.4032=
587-1-alexei.starovoitov@gmail.com?part=3D13
