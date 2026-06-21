Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5304D25B09D
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782064025; cv=none; b=u3USMNN101vcqCz+jz0HGvgTrM3WEUFZPqi/tuO4JVIDxJD2QAKEIOLmbmQVe/5ww/+hWo3SDVZLjNLUt3ZuJwhXA88R2+hzwgBRc6H1pBs9vN3v10XkBoJ0zC/TSCcxQH43FJB73o1SigfBoaW37GFswYmwWVKiuvQrxKilSEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782064025; c=relaxed/simple;
	bh=HwMuvAu6YigLLbWfaIL7lYgTs9jyri8MlmZ9Tus4GSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nZMahxZ4mHWaMnWS7moyyfeSgVUst3XwPHfgVtg9LCSp1P7GCnuXp77id+dzvgMbv0ZLQ/sWDxSkzM5MmLuKXFXwFtv9+shibwMvDPd7RRHKeu3H6aCYeUDlBrx2jcln1GhMw+VQBVjT3SYk6WHLhWzaoi2CIqN/vdUCemAPreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntf9V8Rf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntf9V8Rf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08CB1F000E9;
	Sun, 21 Jun 2026 17:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782064024;
	bh=pOdNh5dCsE0M4ZwmRbzxKo1adeiMmSitPgfM7sCHXvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ntf9V8RfFlfylp5R2CV53xwbGM+wBJQ4d9H7QC45TkP5mT0YCeqrOJNuq1GJJrvmQ
	 bWB9kGQ7ljjT3nMzmIL6LgFeSVjMLsagCbF6xvx0Wp+6/vSuq9YXjlhphgCCX6OO2w
	 qcVS3A7p47ZxqCeecDBtoaQzfMr18Wnc6HP2hKdjxMirOESmidQu5c6r7nh9Jy5srD
	 iH7se9ky2RC6reXDJXa8TF3nlWWpE0wW33Gkou83UzqJeDEjLv7vLSJe3pUZPfMuLL
	 8C9MWSB1+ED2WBO65eUpNOjjbll0b/KsCOl2N5Tc/yfvRoxk+aDbtmVs2C4fSDNxNw
	 cRCUheJCHG5aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH stable 6.6.y v4 1/4] bpf: Track equal scalars history on
 per-instruction level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhenzhong Wu" <jt26wzz@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260621172735.409355-2-jt26wzz@gmail.com>
References: <20260621172735.409355-1-jt26wzz@gmail.com>
 <20260621172735.409355-2-jt26wzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 17:47:03 +0000
Message-Id: <20260621174703.D08CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Duplicate collection of linked registers in conditional jumps ca=
uses spurious ID clearing.
--

commit 230babf3871a45ea95a0dbe311f04085bef2de62
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: Track equal scalars history on per-instruction level

Use bpf_verifier_state->jmp_history to track which registers were
updated by find_equal_scalars() (renamed to collect_linked_regs())
when conditional jump was verified.

Link: https://lore.kernel.org/bpf/20240718202357.1746514-2-eddyz87@gmail.com
Closes: https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_=
Lf0kcFEut2Mg@mail.gmail.com/

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0d90236d0ad94..2268f095203e2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -14704,6 +14896,21 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
>  		return 0;
>  	}
> =20
> +	/* Push scalar registers sharing same ID to jump history,
> +	 * do this before creating 'other_branch', so that both
> +	 * 'this_branch' and 'other_branch' share this history
> +	 * if parent state is created.
> +	 */
> +	if (BPF_SRC(insn->code) =3D=3D BPF_X && src_reg->type =3D=3D SCALAR_VAL=
UE && src_reg->id)
> +		collect_linked_regs(this_branch, src_reg->id, &linked_regs);
> +	if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
> +		collect_linked_regs(this_branch, dst_reg->id, &linked_regs);

[Severity: Medium]
Could this result in duplicate entries and spurious ID clearing if
src_reg->id =3D=3D dst_reg->id?

If the condition compares two scalars that share the same ID,
collect_linked_regs() is called twice with the identical ID. Since it
appends all matching registers indiscriminately, this duplicates the
entries in the linked_regs array.

If the number of duplicated entries exceeds LINKED_REGS_MAX (6) (which
happens if there are 4 or more registers with this ID),
linked_regs_push() fails. In __collect_linked_regs(), the failure
path explicitly clears reg->id to 0:

kernel/bpf/verifier.c:__collect_linked_regs() {
    ...
    e =3D linked_regs_push(reg_set);
    if (e) {
        ...
    } else {
        reg->id =3D 0;
    }
}

This unintentionally breaks the precision tracking link for these
registers. This causes the verifier to unnecessarily lose bounds
information and potentially reject safe programs.

Additionally, if only 1 distinct register shares the ID, the duplicate
collection artificially increases the count to 2, causing an unnecessary
push_jmp_history memory allocation because of the check below.

> +	if (linked_regs.cnt > 1) {
> +		err =3D push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked=
_regs));
> +		if (err)
> +			return err;
> +	}
> +
>  	other_branch =3D push_stack(env, *insn_idx + insn->off + 1, *insn_idx,
>  				  false);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621172735.4093=
55-1-jt26wzz@gmail.com?part=3D1
