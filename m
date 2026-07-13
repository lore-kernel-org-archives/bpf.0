Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769831A07F
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958990; cv=none; b=N6zvYVk47A6M3TaFoI5B5zn81ul1wJAcg1A3ferkWeiaLIMsu77/oMSCpDi2khqm39ASDgvrAYXGe7FlITzIJAZZV5jWb3fc8P3Xv0F5tJW1jHMom/wXsVSpu3Boi+ADro80iSaR6KDKSP9UvIt/fGkR1Q/P5y2wgI96lss6zg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958990; c=relaxed/simple;
	bh=zbmXCsY+i9kusWpmWFkvmKh/0dpEkMzW++YZCg4j48A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M9fSQBp7KKfalbl422sxdTmgjr9kKyfUaWN5sMdg1SkxKLTX7zlav1OAgOKuPHkwlVr/IlvrZfz0L6v4qxmr0j3Ja5y+mNUKOff2C3Tlmi1wQfm22Ws2TgN0ksYWqIqtXgijqRxi1flp8RLT1Uk198KEIxxAOn3OiJbkBDeQdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tzeu4H7E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tzeu4H7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A691F000E9;
	Mon, 13 Jul 2026 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783958989;
	bh=6fdKEG+b2Tcsy28/r1bRFyeGKIKdXx8tPpG2/iYvUMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tzeu4H7Ex3iuUHs3fBmlOL+aH5NTptepJV48sUoI4ahfV0wZCJB2SLYZ1fcd2aayO
	 T5u6SFL93PpAwZwobutHRNTZJradyrGCdFqH5FLNzCna3rYZw5ALGup/yA3dpFFmnc
	 qnHBEMOySp1445jYCN2sxNjY6FBOupG3rWluqmVzCaJEUho17a5ErK1MPe2tTF7VeZ
	 iMqwdDJQPICP3V/4VHrJ2OoAK1uxOozDsfingEHqVKxYrbe0P8eAUHYCKCgbv5QsK8
	 D1UDMZXKVcdUAMwNMeud1wMyKXDEdkG0ximEQNDsIvPPv/HUdIugzLV4bESgK/ykQV
	 9J5F2zUJNSp9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 14/17] bpf: Report Policy helper and kfunc
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713153910.2556007-15-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
 <20260713153910.2556007-15-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 16:09:48 +0000
Message-Id: <20260713160948.D3A691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The verifier reads and dereferences an uninitialized stack variabl=
e `meta.func_name` when `bpf_fetch_kfunc_arg_meta` fails early with `-EACCE=
S`, leading to an out-of-bounds read or kernel panic when formatting diagno=
stic messages.
--

--- Patch [14]: [PATCH bpf-next v3 14/17] bpf: Report Policy helper and kfu=
nc errors ---
commit 64c35288a6fbbafb58f170cb81136c83e594cbdd
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Report Policy helper and kfunc errors

This commit augments selected helper and kfunc allowability failures with
Policy reports to explain which requested operation is forbidden and why.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 44e1907ac792d..c67646f981342 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13961,8 +13985,14 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  		return 0;
> =20
>  	err =3D bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
> -	if (err =3D=3D -EACCES && meta.func_name)
> +	if (err =3D=3D -EACCES && meta.func_name) {
>  		verbose(env, "calling kernel function %s is not allowed\n", meta.func_=
name);
> +		operation =3D bpf_diag_scratch_printf(env, 1, "kfunc %s", meta.func_na=
me);

[Severity: High]
This is a pre-existing issue, but could meta.func_name be uninitialized here
when bpf_fetch_kfunc_arg_meta() fails early?

Looking at bpf_fetch_kfunc_arg_meta(), if fetch_kfunc_meta() fails and
returns -EACCES, the function returns early before the meta struct is
initialized:

err =3D fetch_kfunc_meta(env, func_id, offset, &kfunc);
if (err)
	return err;

memset(meta, 0, sizeof(*meta));

Because meta is declared on the stack in check_kfunc_call(), an early error
return leaves it containing uninitialized stack garbage. If this garbage
evaluates to non-NULL in the err =3D=3D -EACCES && meta.func_name check, wo=
n't
this lead to an out-of-bounds memory read when attempting to format the
garbage pointer as a string in verbose() and bpf_diag_scratch_printf()?

> +		bpf_diag_report_policy(env, insn_idx, operation,
> +				       "this program cannot call the kfunc",
> +				       "Use a kfunc allowed for this program type and attach "
> +				       "point, or change the program context.");
> +	}
>  	if (err)
>  		return err;
>  	desc_btf =3D meta.btf;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713153910.2556=
007-1-memxor@gmail.com?part=3D14
