Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BE64E50AF
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626156; cv=none; b=mlbJLGmBJZaYnxQ3wgNvHbaZR58OtRrSR22ciIcGhAdguJogLUi7WdlMV2kGGqB4Izw2l6/I5SLOyIhW4spIMgqUY6VYraqPeUBWcNEiZVAjSNgTwobnOqS/QAKDkhL9WjtE3fkaTAccwNpbrVlBn16oi2JV0lu1tgLhD3qoV/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626156; c=relaxed/simple;
	bh=Yd1i1T7tLyBm0a3fb3bopzqmRdHd4XkFE3D0yQ6/G5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=buyP7n0ePhlAlqpvS0ulO+Dr/FX8TVGSMjbskUOAD7BNKy5Aok7PiTdVe/TzboKJohGydm9HMI3xjxEWIHp4zFeA3aKSxqmYqxyxSPHtJ37sK8rijLDVFFqyIreCdtomGOpn2lJEh+/0YXwCP3Ud3IQd9IPjFqhydOTVjnlHkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFr6uu7v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFr6uu7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD78D1F000FF;
	Thu, 17 Sep 2026 06:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789626155;
	bh=4P2Oin0bbaVrJTiZpbKfPX1hB2Hs6fWDN340WxLghGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gFr6uu7vgX4ljBaFasuM8ssg7EcmBsVxUJ6wnpc7olhfW9OyhPdzMwklZyM82tIb/
	 onW6kNGlqAIpa0YEQ/xDzegEqTh3ZqNEU/qVvhIaOSHBv8BfvVQDFoZ0H3JXIsdGx1
	 X52s7OvlmZPZHRDBZ4BGucAZMjsWXj+s/ONfJjJ2JuRBSjCVog6HnfgbCVwrCNTvjU
	 Z0RApHqzyJ+ltEoi/5hRNFioGgG09KAws+F5n2lHuT819OzNziOgRtAa3bXHNItMdh
	 GDhXVi1ULuAUd2eZkv2nMWxMwQ6TFb9kVNlkQqLSJigcHgClXglIJr4w4XktbaNS1Q
	 F9kiBJEkBTIOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 05/20] bpf: Make exception landing pads
 reachable in the CFG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917055710.3929202-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055710.3929202-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:22:34 +0000
Message-Id: <20260917062234.CD78D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: bpf_unwind_resume() retains fallthrough edge in CFG walk
--

commit 663c539069f6d8aab713a59c4d2aa7c90391da34
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Make exception landing pads reachable in the CFG

This commit updates the verifier's CFG walk and liveness analysis to account
for exception landing pads. It adds edges from calls within a cleanup recor=
d's
range to that record's landing pad. The commit message also states that
bpf_unwind_resume() reaches nothing after it and should have no successors.

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 842c7d1eabccc..9f8b8b54d5ea7 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
[ ... ]
> @@ -158,17 +159,57 @@ static int push_insn(int t, int w, int e, struct bp=
f_verifier_env *env)
[ ... ]
>  static int visit_func_call_insn(int t, struct bpf_insn *insns,
>  				struct bpf_verifier_env *env,
>  				bool visit_callee)
>  {
> -	int ret, insn_sz;
> +	int ret, insn_sz, pad_ret;
>  	int w;
> =20
> +	pad_ret =3D visit_cleanup_pad_edge(t, env);
> +	if (pad_ret < 0)
> +		return pad_ret;
> +
>  	insn_sz =3D bpf_is_ldimm64(&insns[t]) ? 2 : 1;
>  	ret =3D push_insn(t, t + insn_sz, FALLTHROUGH, env);

[Severity: High]
Does this unconditionally push a fallthrough edge for all call instructions,
failing to account for non-returning kfuncs like bpf_unwind_resume()?

If the compiler places a bpf_unwind_resume() call at the very end of the
program (the end of the .text section) without any trailing instructions, w=
ill
the CFG walk attempt to push a fallthrough edge out of bounds and incorrect=
ly
reject valid BPF programs with a 'jump out of range' error?

>  	if (ret)
> -		return ret;
> +		return merge_visit_ret(pad_ret, ret);
> =20
>  	mark_prune_point(env, t + insn_sz);
[ ... ]
> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 44ecdc5b4ec2d..9cfd05f970bc9 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
[ ... ]
> @@ -256,6 +258,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32=
 idx)
>  	succ =3D env->succ;
>  	succ->cnt =3D 0;
> =20
> +	if (unlikely(bpf_is_unwind_resume_kfunc(insn)))
> +		return succ;
> +

[Severity: High]
This correctly applies the logic mentioned in the commit message (that
bpf_unwind_resume() reaches nothing after it and has no successors) to the
liveness algorithm. Should visit_func_call_insn() in kernel/bpf/cfg.c be
updated with similar logic to avoid pushing a fallthrough edge?

>  	opcode_info =3D &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->c=
ode)];
>  	insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
>  	if (opcode_info->can_fallthrough)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917055645.3926=
444-1-yonghong.song@linux.dev?part=3D5
