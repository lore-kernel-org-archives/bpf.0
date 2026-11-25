Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629077;
	b=MaGYsuePd7sX/Lmf3PhAkkMG7zVEgT8mIfYfgDajzzy3Ub5hUH/ha6N0nYY08NJyHMR6
	 vKSIblbw5zJtfy1ZhHtXUfBTqPTWIUciw/bVWeYwQy0ISykzcLpB6H5sk27F34e1JPPb3
	 v8G063593T98IEHO73ILSLa7ahuA2UZVPjmBdulysvqVcEr79PYOpjTNx9zyRIZOzqSjk
	 ZoW0H902ozmCZljNOUxkVph9swOGpfP6HzxM5yspr0FZes+N5zKpopCVlZBU0dkWBqpLV
	 B6QbA5Ct20KgjdM88whjuJ16EdNCm9Ze+9h6hVAbilDSzSpqFj0uhEGRGlEgS20XG/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629077;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JE5JrAxX9WUiqjSIaRS/A9y1gmJ/dRrwKj0ZOnLSRi4=;
	b=VYnXplSytDK+aXOluOdvBHZiOes0vlDWL1fRiIi9L/ZP74hI1khFVL1qnSIOED/egOf5
	 Fn0ZWvDpemgM0hC6FBKdxBhcXtxZZAciIoALvo1q1lns4h3OhK4/dCe4SG4aTYQBaiDUB
	 OwwAswqPFK34HoOOOdY608MyJRlxk9B0tXDzRK5NZCukEjNOZcnHBmC6uAA0JNd/y4oiQ
	 NTAWv9WdLZlOscZTXqjFqEsiGnNNhYiG+ldTx2RC+7ZESx8NZD0Xc/gottht7lT5V+1jQ
	 ch9R8l7SstDYh8nBqRcm/bOH+atjKvJBAizDg/KLTwTUjWyRTWZDRgbsCSEVWb62q3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pw5ucimn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9143F606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pw5ucimn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197191F000D3;
	Wed, 25 Nov 2026 17:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629077;
	bh=JE5JrAxX9WUiqjSIaRS/A9y1gmJ/dRrwKj0ZOnLSRi4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Pw5ucimnhQvlw/0UTMyzC9yj5piY8hfalYMCjQjietpsezEIqqnVXq0ABRbe2wkKi
	 MrxpUVfhj6bOLJFBm9c9uIRY7yYtXW25ipwgr7r8JxHtGYlaEe6OHq1r5ZYW/CV7tg
	 dE7huH8GFkImDMFGXYrECHF/1N00dW9+ZNXns/KD3tWwJgVklATimOvcSBQ0ketqSC
	 14SQCZKsZk3NtHFeQW8RczowGxBA24K2T983KKwNdtGaRnQoZYvxjzxyo0f7N8Th/M
	 q7276JtC/XK5pV33579uwrCPZtAWCJcUjvZawiEXgmhfRao7DjBXM1bOqBcZdMBum1
	 A4Zp9mYIW4Fag==
Message-ID: <sashiko-outbox-233864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/4] bpf: Add bpf_insert_insns() to insert insns
 next to an insn
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luis Gerhorst" <luis.gerhorst@fau.de>, bpf@vger.kernel.org
In-Reply-To: <45c622fb6bba40629594679c01eed836d58acd89.1795625597.git.luis.gerhorst@fau.de>
References: <20261125-nospec-result-reply-d60fdc6da8ef@fau.de>
 <cover.1795625597.git.luis.gerhorst@fau.de>
 <45c622fb6bba40629594679c01eed836d58acd89.1795625597.git.luis.gerhorst@fau.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 17:51:16 +0000
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
- [High] bpf: adjust_insn_aux_data() overwrites zext_dst of original
  insn
--

commit 4852fbba0f01b447927ce6cabc47568627f19025
Author: Luis Gerhorst <luis.gerhorst@fau.de>

bpf: Add bpf_insert_insns() to insert insns next to an insn

This commit adds bpf_insert_insns() to insert instructions before or after
an existing instruction while preserving all of the original instruction's
insn_aux_data fields, and converts insertion sites in fixups.c to use it.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index a656634fa9e46..485feffe05363 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -170,82 +170,60 @@ enum bpf_patch_mode {
>  	BPF_PATCH_MOVE_TARGET,	/* targets of 'off' follow the original insn to =
'off + len - 1' */
>  };
> =20
> +/* The patch does not contain the insn that it replaces. */
> +#define BPF_PATCH_NO_ORIG	-1
> +
>  /* single env->prog->insni[off] instruction was replaced with the range
>   * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
>   * [0, off) and [off, end) to new locations, so the patched range stays =
zero
> + *
> + * The aux data of the original insn stays with the insn if the range st=
ill
> + * contains it, at index 'orig'. Otherwise 'orig' is BPF_PATCH_NO_ORIG a=
nd the
> + * aux data moves to the last insn of the range.
>   */
>  static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>  				 struct bpf_prog *new_prog, u32 off, u32 cnt,
> -				 struct bpf_insn *original_insn,
> -				 enum bpf_patch_mode mode)
> +				 int orig, enum bpf_patch_mode mode)
>  {
>  	struct bpf_insn_aux_data *data =3D env->insn_aux_data;
>  	struct bpf_insn *insn =3D new_prog->insnsi;
> +	u32 last =3D off + cnt - 1;
> +	u32 keep =3D orig =3D=3D BPF_PATCH_NO_ORIG ? last : off + orig;
> +	u32 target =3D mode =3D=3D BPF_PATCH_MOVE_TARGET ? keep : off;
> +	bool indirect_target =3D data[off].indirect_target;
>  	u32 old_seen =3D data[off].seen;
> -	u32 prog_len;
> +	u32 prog_len =3D new_prog->len;
>  	int i;
> =20
> -	/* aux info at OFF always needs adjustment, no matter fast path
> -	 * (cnt =3D=3D 1) is taken or not. There is no guarantee INSN at OFF is=
 the
> -	 * original insn at old prog.
> -	 */
> -	data[off].zext_dst =3D bpf_insn_def32(new_prog, insn + off + cnt - 1) >=
=3D 0;
> -
> -	if (cnt =3D=3D 1) {
> -		/*
> -		 * A non-memory accessing insn could have been replaced by a
> -		 * memory accessing insn, systematically mark it for non-stack
> -		 * access
> -		 */
> -		data[off].non_stack_access =3D bpf_is_mem_insn(insn + off);
> -		return;
> +	if (cnt > 1) {
> +		env->insn_aux_data_len =3D prog_len;
> +		memmove(data + last, data + off,
> +			sizeof(struct bpf_insn_aux_data) * (prog_len - last));
> +		/* The aux data of the original insn is at 'off' and 'last' now. */
> +		data[keep] =3D data[last];
> +		for (i =3D off; i <=3D last; i++)
> +			if (i !=3D keep)
> +				memset(data + i, 0, sizeof(struct bpf_insn_aux_data));
>  	}
> -	prog_len =3D new_prog->len;
> -	env->insn_aux_data_len =3D prog_len;
> =20
> -	memmove(data + off + cnt - 1, data + off,
> -		sizeof(struct bpf_insn_aux_data) * (prog_len - off - cnt + 1));
> -	memset(data + off, 0, sizeof(struct bpf_insn_aux_data) * (cnt - 1));
> -	for (i =3D off; i < off + cnt - 1; i++) {
> +	for (i =3D off; i <=3D last; i++) {
>  		/* Expand insni[off]'s seen count to the patched range. */
>  		data[i].seen =3D old_seen;
>  		data[i].zext_dst =3D bpf_insn_def32(new_prog, insn + i) >=3D 0;
>  		/*
> -		 * In BPF_PATCH_MOVE_TARGET mode the original insn is the last
> -		 * slot by construction.
> +		 * A new insn can access memory. Systematically mark it for
> +		 * non-stack access, only the original insn keeps its marking.
>  		 */
> -		if (mode =3D=3D BPF_PATCH_KEEP_TARGET &&
> -		    !memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
> -			data[i].non_stack_access =3D
> -				data[off + cnt - 1].non_stack_access;
> -			data[off + cnt - 1].non_stack_access =3D false;
> -		} else if (bpf_is_mem_insn(insn + i)) {
> -			data[i].non_stack_access =3D true;
> -		}
> +		if (orig =3D=3D BPF_PATCH_NO_ORIG || i !=3D keep)
> +			data[i].non_stack_access =3D bpf_is_mem_insn(insn + i);
>  	}

[Severity: High]
Does setting data[i].zext_dst unconditionally across [off, last] clobber
data[keep].zext_dst for the original instruction when called from
bpf_insert_insns()?

For BPF_ALU64 arithmetic on PTR_TO_ARENA, adjust_ptr_min_max_vals() sets
aux->needs_zext =3D true and aux->zext_dst =3D true while leaving insn->cod=
e as
BPF_ALU64 until bpf_do_misc_fixups() rewrites it to BPF_ALU.  If
bpf_insert_insns() runs on that instruction first (for example, inserting
BPF_ST_NOSPEC() in bpf_convert_ctx_accesses() when aux->nospec is set),
bpf_insn_def32(new_prog, insn + keep) sees BPF_ALU64 and overwrites
data[keep].zext_dst to false while preserving data[keep].needs_zext =3D tru=
e.

After bpf_do_misc_fixups() converts the instruction to 32-bit BPF_ALU,
bpf_opt_subreg_zext_lo32_rnd_hi32() sees zext_dst =3D=3D false: it skips
BPF_ZEXT_REG on bpf_jit_needs_zext() architectures, and under
BPF_F_TEST_RND_HI32 it emits rnd_hi32_patch to OR random bits into the
upper 32 bits of the PTR_TO_ARENA register, causing subsequent
BPF_PROBE_MEM32 dereferences to access outside the 4GB arena region.

Conversely, for a 32-bit instruction where bpf_compute_live_registers()
cleared zext_dst because the upper 32 bits are dead, bpf_insert_insns()
resets data[keep].zext_dst back to true.

Should data[i].zext_dst also be updated only inside the
"if (orig =3D=3D BPF_PATCH_NO_ORIG || i !=3D keep)" block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795625597.gi=
t.luis.gerhorst@fau.de?part=3D1
