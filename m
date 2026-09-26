Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223A3BB57
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400082; cv=none; b=KrBd3IZUjBIkFeHkJHx1PEPaQUyOecwt75eD2clPUXxx0JbiSF/sjqS6A1qFFWnm26B30TZ/traLWQFBmFDbFf0fWl5sR6sRFQgPEMbQIXeQDeOMry0jrTfa+TglFzdgcDXzx/Cd2Dz5bdsodxNtMxEfsTPLuWI84edqK0LwaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400082; c=relaxed/simple;
	bh=5VV1VsxNvI/gI90CxOoPcMqu/EWGyzcoXgJxwKBjkrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F3t37VK1JOXbyQU+77wVoQreWxBWxGpwCI00RLRZHGoBf5oKLe393QzdQXIaknIaS9IL0TZpX7KXB5yqr9iTrndWNc7nIZzI6S5QACLN6s7qbHXLONB3nNe6STzO/rLmjGHouOUzqu2ALumaXyDma28s5lhPkn+JcZWCade+/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPy5v0Ml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPy5v0Ml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFD41F000FF;
	Sat, 26 Sep 2026 05:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790400080;
	bh=afOhNhNFUbR+Jil8Z3gO7mDecnzUV63784gS4+F86yU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DPy5v0MlnLUsQcx6VCFaNyoH5KTbYxCdSdjnMwiY+DD3+i6SpPwkxeEAws9DXJzt3
	 7XYHQPoVtSPJ/qb5dAOwfCGGo0E5xX+KnRyGEB7B/RV8pc7Gw7ED4k7Gmak4Eaaw/E
	 JWzQiUDqqe+BncjP5HT8255zOcb54k611Rlf6uf2sHgthyOdVX1F2bZQvTP3am+tTU
	 X5JOvGU16vLmAb5U9Z25rl494Wdw19Ew/vLdm1RErXwwSzR3oligBVdeQrcRjmvgve
	 t9W/iVrq5sRWllFZOAvE+DWfwG8k02D7LPNsPF6Lv+uusgujFCBQz3E3rDIU4UdQK9
	 QvySbo3Fv4WVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 06/21] bpf: Make exception landing pads
 reachable in the CFG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926050037.2216265-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050037.2216265-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:21:20 +0000
Message-Id: <20260926052120.AEFD41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: DFS traversal invariant violation in visit_func_call_insn
--

commit 9f815c7b6f7049f1604884b98686a7516748e963
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Make exception landing pads reachable in the CFG

A bpf_unwind() or a bpf2bpf call inside the [begin_off, end_off) range of a
cleanup record can reach that record's landing pad. Add that edge to the
CFG walk, which explores the pad and makes both ends prune points, and to
bpf_insn_successors(), which liveness and the SCC passes walk.

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index b0bd9ba951dfb..4e2b6985bc964 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c

[ ... ]

> @@ -160,17 +161,64 @@ static int push_insn(int t, int w, int e, struct bp=
f_verifier_env *env)
>  	return DONE_EXPLORING;
>  }
> =20
> +static int visit_cleanup_pad_edge(int t, struct bpf_verifier_env *env)
> +{
> +	int *insn_stack =3D env->cfg.insn_stack;
> +	int *insn_state =3D env->cfg.insn_state;
> +	int w;
> +
> +	if (!env->cleanup_info_cnt)
> +		return DONE_EXPLORING;
> +	w =3D bpf_exc_pad_of_call(env, t);
> +	if (w < 0)
> +		return DONE_EXPLORING;
> +
> +	/*
> +	 * @t is a call that may branch here, and @w is the target of that
> +	 * branch, so both are prune points. @w especially: every covered call
> +	 * site in a region unwinds to the same pad, and without a prune point
> +	 * at its head the verifier walks the pad again for each of them.
> +	 */
> +	mark_prune_point(env, t);
> +	mark_prune_point(env, w);
> +	mark_jmp_point(env, w);
> +	mark_jump_target(env, w);
> +
> +	if (insn_state[w])
> +		return DONE_EXPLORING;
> +	if (env->cfg.cur_stack >=3D env->prog->len)
> +		return -E2BIG;
> +	insn_stack[env->cfg.cur_stack++] =3D w;
> +	insn_state[w] |=3D DISCOVERED;

[Severity: Medium]
Does setting the DISCOVERED flag here in visit_cleanup_pad_edge() mark the
pad prematurely?

By marking it DISCOVERED before fully exploring its path, any valid
cross-edges to the cleanup pad (e.g., from shared cleanup code) might be
incorrectly classified as back-edges and rejected by the verifier.

> +	return KEEP_EXPLORING;
> +}
> +

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

[Severity: Medium]
Is it safe to push the fallthrough edge even if visit_cleanup_pad_edge()
has just returned KEEP_EXPLORING?

The CFG checker typically relies on returning KEEP_EXPLORING immediately
after pushing a new node to maintain the invariant that DISCOVERED nodes are
strictly ancestors. By ignoring whether pad_ret is KEEP_EXPLORING and
eagerly pushing the fallthrough edge, this leaves the cleanup pad marked
DISCOVERED while the fallthrough path is being explored.

Could this lead to loop-free programs being incorrectly rejected if a
cross-edge on the fallthrough path is misidentified as a back-edge?

>  	if (ret)
> -		return ret;
> +		return merge_visit_ret(pad_ret, ret);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926050006.2213=
110-1-yonghong.song@linux.dev?part=3D6
