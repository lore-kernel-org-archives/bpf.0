Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407892;
	b=vllhogdCLwB42M8k5uxbHwRBs2iwlVutQ0n4eevK5oHUDx58AAVVB3CLgyQKPKxCoeVs
	 f3rJhiFsWWVH8VSnWQ4HXPfwfdcv7tYAq16FERFFEQYywOztG97xyHdoLZwTpiu9o8vgn
	 RwAqqv/e/NufaKuam/pPfmulzSE4M6U+b9NYz4Ppvir+Z8ueXrGtOgNcjxziLC1rdgNS4
	 IsMKvfYkmL2iVxIf2xhcAK3lPT7wrtHcu8pAb5CWk4ZMxK54K74aY42bcLqUJSeRcCKEJ
	 Y/UWalvrqVBzcm/fPFuPiv82In5PFaFLMoKliFG0dh5MxYvl1MTr+FEsmy2yLpcjcaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407892;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U8fhDkCvMLVZ19jT3ksqKdUKXpNfrcfX99iyCDlvcKw=;
	b=PKZwfsRM7yOlI/9rQMmz3PiOxQ5ACDmS3isur5BXFp3GEYlALa6v2QF8pI3CFLiZD25u
	 sAWuvO9jLeQ47R3Kxuv0L0S+ooZBx60AH3kuxpW1pe4RL9bu6EZsC5yjmBFHaRGQKayUM
	 WyGh+AQF6flYMsPooebnHXaTCNxai24z65CXujr2+PgpEi3aqkhuKDUr+NzOpljVpMlSU
	 +LVy6odzvL7s5fJ5evnpUet/SmvJaCfBYy3cYgITX1AE2GKnqWsFLR3CIddDBj0Z2scN8
	 nof0gZf6l+ZyVfh4KK8U+XEqkeReJxjBP0D9cXavLOzQD2t5yxaqUbpv9bBSWnUba6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcgXXHmk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182EA606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcgXXHmk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914C21F00A07;
	Wed, 11 Nov 2026 14:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407891;
	bh=U8fhDkCvMLVZ19jT3ksqKdUKXpNfrcfX99iyCDlvcKw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IcgXXHmkPmGG55X6mQhHcbPlBtZwPbRwRxgtQqsxDthYDfoG5K/aNpAAAFoDLetk8
	 CoFr2HXVfY3G6eYylG3BqknDK5uHOzYITfHfEjiOMJb7BWFrx5YIxsH6x6X3f+pPrs
	 hzjAew12gNODbgzbIFfVgTgRDLHo9nrvt1m6JsCopTVs3E5AAjIVL7Gf0YQe2ao4Uy
	 J8ZVQmyuKBHLSEcWy3xywItB4R7DvY4f7ZDlWAw8pW+ftJGArTiR3LSIdJGtY0VmWM
	 CtF9NuYxVbouoO/csIyv0qVtbPcVpddFZIxKLA1SOJys0gKEYJO9QI1D0vj+2MJBho
	 BUS62ElxgS4jA==
Message-ID: <sashiko-outbox-209175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 06/29] bpf: Keep last insn's aux data in
 add_hidden_subprog()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <4e0c5d6d96b2e917ff52effe483ec90daf0e2ac0.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <4e0c5d6d96b2e917ff52effe483ec90daf0e2ac0.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 14:38:11 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] bpf: misplaced nospec flag in adjust_insn_aux_data() [1]
--

commit f29fbac112320caad2087aefcfcc0181b977759d
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Keep last insn's aux data in add_hidden_subprog()

This commit swaps the aux data of the original last instruction and the end
of the patch in add_hidden_subprog() so that the original instruction keeps
its aux data (while leaving indirect_target on the first instruction).

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index eb5a5bca5c8d5..8597b443d5619 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -2280,8 +2280,10 @@ static int add_hidden_subprog(struct bpf_verifier_=
env *env, struct bpf_insn *pat
>  {
>  	struct bpf_subprog_info *info =3D env->subprog_info;
>  	int err, cnt =3D env->subprog_cnt;
> +	struct bpf_insn_aux_data *aux;
>  	struct bpf_insn *last;
>  	struct bpf_prog *prog;
> +	bool indirect;
> =20
>  	/* We only reserve one slot for hidden subprogs in subprog_info. */
>  	if (env->hidden_subprog_cnt) {
> @@ -2299,6 +2301,17 @@ static int add_hidden_subprog(struct bpf_verifier_=
env *env, struct bpf_insn *pat
>  	if (err)
>  		return err;
>  	prog =3D env->prog;
> +	/*
> +	 * The patch starts with the original last insn, but the commit moved t=
hat
> +	 * insn's aux data to the end of the patch: give it back to the insn. A=
ll
> +	 * but indirect_target, which the commit left with the insn, since an
> +	 * indirect jump to it lands there still, see patch_list_adj_aux().
> +	 */
> +	aux =3D &env->insn_aux_data[prog->len - len];
> +	indirect =3D aux->indirect_target;
> +	swap(aux[0], aux[len - 1]);
> +	aux[0].indirect_target =3D indirect;
> +	aux[len - 1].indirect_target =3D false;
>  	info[cnt + 1].start =3D info[cnt].start;
>  	info[cnt].start =3D prog->len - len + 1;
>  	/* The patch ends with the exit. */

[Severity: Critical]
This problem wasn't introduced by this patch, but can patch_list_adj_aux()
misplace the nospec flag [1] when expanding a single instruction into a
multi-instruction sequence?

kernel/bpf/fixups.c:patch_list_adj_aux() {
	...
	*last =3D *old;
	/* Recompute zext_dst: the last insn of the patch need not be the patched =
one. */
	last->zext_dst =3D bpf_insn_def32(prog, &patch[p->len - 1]) >=3D 0;
	memset(slot, 0, sizeof(*slot) * (p->len - 1));
	...
	/* indirect jumps to the replaced insn land on p->target */
	if (last->indirect_target && p->target !=3D p->len - 1) {
		slot[p->target].indirect_target =3D 1;
		last->indirect_target =3D 0;
	}
}

During verification with Spectre v1 mitigation active, a bpf_loop() call can
be eligible for inlining on an architectural path while a speculative path =
to
the same instruction fails in check_func_args() with -EACCES, causing
do_check() to set insn_aux->nospec on the call instruction and stop verifyi=
ng
that speculative path.

When bpf_optimize_bpf_loop() -> inline_bpf_loop() later replaces the call
with a 19-instruction sequence, patch_list_adj_aux() moves old aux data to
last and zeroes the preceding entries while only restoring indirect_target =
to
slot[p->target].  As a result, bpf_convert_ctx_accesses() emits BPF_ST_NOSP=
EC()
before the last instruction of the inlined loop instead of at its entry,
allowing speculative execution to enter the loop body and invoke the callba=
ck
with unverified state.

[1] https://sashiko.dev/#/bug/linux-9fe39327-eb21-4b95-9330-3ea552a3b9fc

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D6
