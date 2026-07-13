Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064932B103
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958783; cv=none; b=b7XK50PsvK9uYZ+cxsfU3rpvAmALYwVvXTpRfihREzFeVSW+YYGdQiuEIax6awql8o6yzaT+jojLQhMx3SCaiDatsXCO76K9ER/vWJ1H0u2dZrzIbaFK28fomHV/3SfEM/whXi1ARRRieiUhU1Oz9TwjRymVn+eaaakLWPfsee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958783; c=relaxed/simple;
	bh=/XH5fZJNxo+ntO5uK4NqryzXUfVYsJev2zjCqdOo80Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uks0UuP6D7UqezIQ0fdPFQUhXEQ//HGJ36MuUlARk1XUbOR49mvrqwV8mDMgQqFvp3g7+Sh12dBzcSt3Irk/GqLLvn07z0f5EliH6uKV2fug/fxp++0cla0vdiDyTmnSFrc6S6p75oSCW9KFKCLmJWxPE7HTDMBBizstMP1U5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZIlA9dQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZIlA9dQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED7A1F00A3A;
	Mon, 13 Jul 2026 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783958780;
	bh=BaLRH0uNnYRk2jzR+jb3JaI2UplT8GdZ679d8+t9cL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZIlA9dQJ9TEv1QPq5YRij3t1MnO9oHpyxGvhLUYYOAtPe+JBskITe9XamkAQsx2H
	 jq9r22/RPrDmeK51uiQobaHPw/E+ZYe8rqI8L73CFkXLbOXlHBrpSybKMgE5UMZXw7
	 a/q6hONlION/QKn0Vx5Knl+wCgC2d8VbKLa1bA8hBf/feAf7OC2zxYvVrptp3kh5Ld
	 57JkFj6a1PLTlpPEMBFlbhCvQtYSc9m0b3BjKveHVR2RdV7pjhSbHhYJhliYiyd6bX
	 jww0OUfrN39hw7WEJ2Q9bSwYOrIBxKo8cgfGYRgvLikHy39CS1Qy1FSUiwMif+6i40
	 AfUPBGOUfpUJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 05/17] bpf: Track verifier register
 diagnostic events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713153910.2556007-6-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
 <20260713153910.2556007-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:06:19 +0000
Message-Id: <20260713160620.1ED7A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing diagnostic history for R0 return values on alternate ver=
ification branches pushed during iterator kfunc evaluation.
--

--- Patch [5]: [PATCH bpf-next v3 05/17] bpf: Track verifier register diagn=
ostic events ---
commit 89ba11918f62e11a29a14afb1bb19f115cbbdd40
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Track verifier register diagnostic events

This commit adds diagnostic tracking for the BPF verifier to explain how a
register or stack value reached its current state. It records register and
stack modifications, invalidations, and causal history in a diagnostic
event stream.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 648adf3b7aaa1..4a468299f05e9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -13392,6 +13685,8 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  			return err;
>  	}
> =20
> +	bpf_diag_record_call_ret(env, insn_idx, regs);
> +
>  	if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_session_cookie])
>  		env->prog->call_session_cookie =3D true;
> =20

[Severity: Medium]
Will this miss diagnostic history for R0 return values on alternate
verification branches pushed during iterator kfunc evaluation?

When an iterator next kfunc (e.g., bpf_iter_num_next) is evaluated,
process_iter_next_call() pushes the alternate verification branch via
push_stack(), which snapshots the diagnostic log position.

The current branch then proceeds to call bpf_diag_record_call_ret() here,
adding the R0 modification to its log. When the pushed branch resumes, its
log is reset to the snapshot taken before this bpf_diag_record_call_ret()
call, permanently skipping the event on that path.

Could this result in a confused developer seeing that R0 was invalidated
as a caller-saved register, but not seeing the subsequent function return
assignment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713153910.2556=
007-1-memxor@gmail.com?part=3D5
