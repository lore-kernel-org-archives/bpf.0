Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC4486E7D
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939200; cv=none; b=eaRqxK0jB8UVmmBKn8CrVKFAXOg5i2lhGnGEoGdFJwbXzeULOVJ/GUOJXyL4slkOeyVjbeM0hWZ+VcQ8x+WWwxttNmxIC+PeAyByV6JWYdL1chw10Xb8ruYg0eAVz6NqmD/aC45g2PR2beN7JjjsNM01wtXJGNRGx4B99xjFSZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939200; c=relaxed/simple;
	bh=g1x2qhESG9DcW4Q56vU+gAZcBw3KiNY932opf/UNbaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ogkhvJqTaEKke5YTx39lJq2O5DuoePh7EaZ+nnl7mkE1HlW2bnOeeObK6FWjSC9mGhsZeCVelZYbX5jciNOJOeuvG6N9es5LUDzCf/Rhdiy/dRE1y4UGGxHEkdTqHPnMs/zK3sPRc9+j5nySeXjD4/sEm3JpJ+dyfTImlFBKT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSLjFrIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSLjFrIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E041F000FF;
	Fri,  2 Oct 2026 11:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939198;
	bh=hT5yLBagSPIl7/FBy1JZ/ZvCYhQg1Xq0xsyF3/J15Oo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VSLjFrIzKlv9Y66VYZ00QvXIV0tgYm7cnvAiK7YUQoEU9JMlAVanddZME7jcQwNh4
	 DJ3n/WaFz7u5l/HVzam68CmMOnDIFPr1dSHav2Kz/UCPB0oz18s1yHQc0B+XphRkeI
	 JfjIzLfn/oCsFEnEgXv9WCdSYK9PIIN5DvMxzVbY2uk/N6RWBpwuMXghCsRSwlqjQQ
	 aIBMTAOXQojbxs8ZfVU18a5XF1/IA9Urkv5ABWWFFwQ1uHc41q0w2adRlTc4ypoDoU
	 P8xBblxdVAYVORGbqIxePvtZ2lqGumSyWBeYan9zUuJIyQL4DTap0XOq08AN4mHeK1
	 u5VtBZqaJxkAQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH bpf-next v6 5/7] bpf: Directly store kfunc desc
 index in instruction off field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261002105218.6171-6-emil@etsalapatis.com>
References: <20261002105218.6171-1-emil@etsalapatis.com>
 <20261002105218.6171-6-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:06:37 +0000
Message-Id: <20261002110638.65E041F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: JIT compilation fails for kfuncs emitted in prologues
--

commit ba562be891ad9f52f9742001cfab2a791d6aefb8
Author: Emil Tsalapatis <emil@etsalapatis.com>

bpf: Directly store kfunc desc index in instruction off field
   =20
This patch modifies the verifier to store the kfunc descriptor index direct=
ly
in the instruction's off field. It removes the need to sort the descriptor
table twice, simplifying subsequent function specialization patches.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 37cf130ebb57b..cb7219ff68bd1 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

>  const struct btf_func_model *
>  bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>  			 const struct bpf_insn *insn)
>  {
[ ... ]
>  	tab =3D prog->aux->kfunc_tab;
> -	res =3D bsearch(&desc, tab->descs, tab->nr_descs,
> -		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm_off);
> -
> -	return res ? &res->func_model : NULL;
> -}
[ ... ]
> +	if (insn->off < 0 || insn->off >=3D tab->nr_descs)
> +		return NULL;
> =20
> +	res =3D &tab->descs[insn->off];
>  	if (bpf_jit_supports_far_kfunc_call()) {
> +		if (res->func_id !=3D insn->imm)
> +			return NULL;

[Severity: Medium]
Will this lead to a JIT failure for kfuncs emitted in prologues or
epilogues?

When bpf_convert_ctx_accesses() calls gen_prologue(), it can emit a kfunc
call where insn->off is 0. This is then processed by add_kfunc_in_insns(),
which calls bpf_add_kfunc_call() to register the kfunc:

kernel/bpf/fixups.c:add_kfunc_in_insns() {
	...
	for (i =3D 0; i < cnt; i++, insn++) {
		if (bpf_pseudo_kfunc_call(insn)) {
			ret =3D bpf_add_kfunc_call(env, insn->imm, insn->off);
			if (ret < 0)
				return ret;
		}
	}
	...
}

However, add_kfunc_in_insns() does not update insn->off to the descriptor
index returned by bpf_add_kfunc_call().

Later, when the JIT compiler calls bpf_jit_find_kfunc_model() and uses
insn->off (which is still 0) to fetch the descriptor, could it fetch the
wrong descriptor and abort the compilation due to a func_id mismatch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002105218.6171=
-1-emil@etsalapatis.com?part=3D5
