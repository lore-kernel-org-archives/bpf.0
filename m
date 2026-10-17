Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E44426D0C
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279792; cv=none; b=H3Sv3HL4C25G+qzzfSoXX3Ojpmwhw4F41DKbjpzpRaNocC1EB6qbMdFC+vAFbM61QlNwnjCUgZXaCEr6yi6zhyJ1aNhOzfcB4bWxBAGUHclhRdOZ/722XZctJrhlW13odFES/UY8hKsTr0KNhLfqihKPUQoJGc1Zdu4+QzqemzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279792; c=relaxed/simple;
	bh=IXnACktxUbSg5mPEL/JgG4AzYns9jkd8NIAMy329kek=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=O7nvzZoQ3K/V8UtOSjnZh6xS5+F879RBXG7jUKzPv30rdpvh83ku/fx7wImwdJc76pvQjkooRSjgmvuAlGysPnYJWIGwR+6pQ0I2fsXNjL11wg5QpUErKAt75YzpgFwn7Q7sBYeBjwr9o5ExcdVyF4vzVRdcPGtD09G4dEGPtLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWpBIwdo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWpBIwdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687781F000C4;
	Sat, 17 Oct 2026 23:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792279790;
	bh=2A04+qg5Xv5cYzkttcRFGvYiHaTC51HKsdR5+aBKZQI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NWpBIwdo8XIlg+Pzr5phu6XC1BO/Ok34tBUyRWCAq/IF+sWm9RcItlasIM1LscE6b
	 5FYXBvLRRyor18pFwaPgpmrw8Y5olSBGW2sYOimil3t4eVWGKVMV9saAEgECWeGYMP
	 cl7bAD7l0WnG3V8d2z3m0UQzRF/LmJgqmTt0aSQVwiO3e+MChPhEzYLZfxIt9jHXyY
	 zo0IYxCvJMDBpwIh0EaPOmDEG6Xk8zPH5dQox4jpQ9snNoTWR0jyEgQRpydAyd0juA
	 apOVdsVw2FaOFCAr46hAJ/Mj2iUeifD9DRN1g+zZaOPOz3vd7p5Px9KVtCe0XXCvbn
	 UXFDcIio9xpVQ==
Message-ID: <sashiko-outbox-175849@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 11/16] bpf: Refuse the prologue for an
 extension that cannot take it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017230950.802052-12-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
 <20261017230950.802052-12-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 23:29:50 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: unclone prologue in ext_prog_takes_prologue() misses chan=
ges_pkt_data
--

commit 5782cfd239c6517a4947d82c921ca266a19c1bde
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Refuse the prologue for an extension that cannot take it

This commit rejects BPF extension programs that require an unclone prologue
unless their arguments consist of a context pointer in R1 followed only by
scalars.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index fe59e3114d828..a8739fbd03495 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -858,6 +858,25 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_ver=
ifier_env *env,
>  	return 0;
>  }
> =20
> +/*
> + * The prologue takes the context from R1, and it can clobber R2-R5. An
> + * extension gets the arguments of the function that it replaces.
> + */
> +static bool ext_prog_takes_prologue(const struct bpf_verifier_env *env)
> +{
> +	const struct bpf_subprog_info *sub =3D &env->subprog_info[0];
> +	int i, cnt =3D min_t(int, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS);
> +
> +	if (!cnt || sub->args[0].arg_type !=3D ARG_PTR_TO_CTX)
> +		return false;
> +
> +	for (i =3D 1; i < cnt; i++)
> +		if (sub->args[i].arg_type !=3D ARG_SCALAR)
> +			return false;
> +
> +	return true;
> +}
> +
>  /* convert load instructions that access fields of a context type into a
>   * sequence of instructions that access fields of the underlying structu=
re:
>   *     struct __sk_buff    -> struct sk_buff
> @@ -915,6 +934,12 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env=
 *env)
>  			verifier_bug(env, "prologue is too long");
>  			return -EFAULT;
>  		} else if (cnt) {
> +			if (env->prog->type =3D=3D BPF_PROG_TYPE_EXT &&
> +			    !ext_prog_takes_prologue(env)) {
> +				verbose(env,
> +					"Extension writing packet data must take ctx and scalars only\n");
> +				return -EINVAL;
> +			}
>  			new_prog =3D __bpf_patch_insn_data(env, 0, insn_buf, cnt,
>  							 BPF_PATCH_MOVE_TARGET);
>  			if (!new_prog)

[Severity: Critical]
When an extension program receives bpf_unclone_prologue() in
bpf_convert_ctx_accesses(), that prologue emits a call to
BPF_FUNC_skb_pull_data:

net/core/filter.c:bpf_unclone_prologue() {
	...
	/* ret =3D bpf_skb_pull_data(skb, 0); */
	*insn++ =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
	*insn++ =3D BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
	*insn++ =3D BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
			       BPF_FUNC_skb_pull_data);
	...
}

Because this call is only synthesized during bpf_convert_ctx_accesses(),
after bpf_check_cfg() and check_attach_btf_id() -> bpf_check_attach_target()
have already run, an extension that writes to packet data via direct packet
access or bpf_dynptr_slice_rdwr() without calling a packet-changing helper
will have prog->aux->changes_pkt_data =3D=3D false during target validation:

kernel/bpf/verifier.c:bpf_check_attach_target() {
	...
	tgt_changes_pkt_data =3D aux->func
			       ? aux->func[subprog]->aux->changes_pkt_data
			       : aux->changes_pkt_data;
	if (prog->aux->changes_pkt_data && !tgt_changes_pkt_data) {
		bpf_log(log,
			"Extension program changes packet data, while original does not\n");
		return -EINVAL;
	}
	...
}

If the target tc, lwt_xmit, or sk_skb program only reads packet data (or
clones the skb via bpf_clone_redirect() and reloads skb->data) and calls a
global subprogram taking (struct __sk_buff *skb, scalars...) with
changes_pkt_data =3D=3D false, check_func_call() does not call
clear_all_pkt_pointers(env), allowing the caller to hold packet pointers or
read-only skb dynptr slices in callee-saved registers across the call.

When the extension replaces that global subprogram and runs on a cloned skb,
its bpf_unclone_prologue() calls bpf_skb_pull_data() ->
skb_ensure_writable() -> pskb_expand_head(), which reallocates and frees
skb->head while the caller still holds pointers into the old skb->head.

Could this cause a use-after-free in the caller after the extension returns,
and should an extension receiving a prologue also require the target functi=
on
to have changes_pkt_data set (and set prog->aux->changes_pkt_data for
subsequent BPF_LINK_CREATE attachments)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017230950.8020=
52-1-alexei.starovoitov@gmail.com?part=3D11
