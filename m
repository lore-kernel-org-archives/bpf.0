Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CB4CF474
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792207171; cv=none; b=pMNGKDbBivpk5aRgLeUZk+sgHmMmWiNP/Evvj2q3SE5eeWeVg5mUUe0cj1BOy7utcsgAmu2XVXSw4SKFxRgkL0vcxhadEm5axdYrSdbEYeZYWuiJTwCNHd+q+WzXVY9d6+UNFKt586pu3k0+DyYoLeXtXW3hw9mjxfQbgAUxzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792207171; c=relaxed/simple;
	bh=5BJH5nE45dY7fJWeG35zv1LStMLzQqcA3Ycit8Ilc7Q=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=NI9Aed5o4FDIYa7Fw320iVrfhTXbQ/zqOU94ll6JxS1WOUEjdOVBqGPFZVLCv4maZqm0b9XaY/FKo6+Zrv8RJE6AeMEb/ZTSpl9aczjIUP3zZaDegLilOtX+Ilzmqy4tw0GUZShN74SPk5NY41hLZg6In8y59r1fbiDNairazH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5rBePLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5rBePLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EDF1F000C4;
	Sat, 17 Oct 2026 03:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792207170;
	bh=nC8x7Y1vSvwv/dBmx/rIAmTse5U8XWiJscD2gRjjy9M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=a5rBePLFtd5wVEfmJJ+0SGpY4dC3xLmhh8kDxN5Ub/cZzjFzSJBPHtxwywtZ+4lY9
	 q7ENmSgOVjBiEFJ1rwq2VHeho9n8GSepNTlltDNA0/cYGvEu34+5BnBP795MznVgxw
	 TsoajvlLFSdxVB4hjEWezaqSf5x+vxBO9/et00E74zBJhnAA1dFB8LjwFdWpKhIfc0
	 Xa3XI08p+X1m4FYjIu9feKd1P6Nrzi7ouRtGhg8yzATb4hVL96a0T7uFCuya6sO/6a
	 ukFIzy++U47F5HdI6YZ03FeVtAG0YB9AiRqvlOX2RqGPWgOq5LcdH9JmHiymZNAU5J
	 Jd1GZWryd/WRA==
Message-ID: <sashiko-outbox-175238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v12 07/25] bpf: Refuse a callback that can
 unwind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261017025206.1920523-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
 <20261017025206.1920523-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 03:19:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: missing might_unwind propagation to callback in bpf_check_cfg=
()
--

commit 1785732c5b5ae17b86f08f6a94449da36fb9c958
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Refuse a callback that can unwind

This commit adds bpf_exc_check_callback() and calls it in
push_callback_call() to reject callback subprograms that have
might_unwind set.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fce2baa6272d1..fcf0d0fe0f2ff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11191,6 +11191,10 @@ static int push_callback_call(struct bpf_verifie=
r_env *env, struct bpf_insn *ins
>  	 * callbacks
>  	 */
>  	env->subprog_info[subprog].is_cb =3D true;
> +	err =3D bpf_exc_check_callback(env, subprog);
> +	if (err)
> +		return err;
> +
>  	if (bpf_pseudo_kfunc_call(insn) &&
>  	    !is_callback_calling_kfunc(insn->imm)) {
>  		verifier_bug(env, "kfunc %s#%d not marked as callback-calling",

[Severity: High]
Can a callback subprogram that transitively calls bpf_unwind() bypass
bpf_exc_check_callback() with env->subprog_info[subprog].might_unwind
still false?

In bpf_check_cfg(), direct calls (BPF_PSEUDO_CALL), function address
loads (BPF_PSEUDO_FUNC), and read-only map function pointer loads
(insn_func_ptrs()) are explored in a single DFS sharing
env->cfg.insn_state[]:

kernel/bpf/cfg.c:merge_callee_effects() {
	caller =3D bpf_find_containing_subprog(env, t);
	callee =3D bpf_find_containing_subprog(env, w);
	caller->changes_pkt_data |=3D callee->changes_pkt_data;
	caller->might_sleep |=3D callee->might_sleep;
	caller->might_throw |=3D callee->might_throw;
	caller->might_unwind |=3D callee->might_unwind;
}

merge_callee_effects() relies on callee w already being EXPLORED when
returning to caller t. However, if subprogram H has a conditional branch
whose fallthrough loads a read-only map containing the address of
callback cb via insn_func_ptrs() (or loads cb via BPF_PSEUDO_FUNC when H
is explored from a cleanup pad before main's fallthrough) and whose jump
target calls bpf_unwind(), while cb calls H via BPF_PSEUDO_CALL:

1. bpf_check_cfg() enters H (marking insn_state[w_H] =3D DISCOVERED) and
   explores H's fallthrough first, before visiting H's bpf_unwind()
   branch, so H->might_unwind is still false.

2. H's fallthrough visits cb via visit_func_ptrs_insn() or
   visit_func_call_insn().

3. When cb visits its BPF_PSEUDO_CALL to H, merge_callee_effects() sees
   H->might_unwind =3D=3D false, and push_insn() sees
   (insn_state[w_H] & 0xF0) =3D=3D DISCOVERED and returns DONE_EXPLORING.
   Thus cb finishes CFG exploration with cb->might_unwind =3D=3D false
   before H explores its bpf_unwind() branch and sets
   H->might_unwind =3D true.

4. At the end of bpf_check_cfg(), mark_callx_might_unwind() checks
   addr_taken_subprog_might_unwind():

kernel/bpf/cfg.c:mark_callx_might_unwind() {
	if (!addr_taken_subprog_might_unwind(env))
		return;
    ...
}

   Because the address-taken subprogram cb still has might_unwind =3D=3D fa=
lse,
   addr_taken_subprog_might_unwind() returns false and skips the
   fixed-point propagation loop.

5. Neither sort_subprogs_topo() nor check_max_stack_depth() rejects the
   program because insn_func_ptrs() edges are not call edges and async
   BPF_PSEUDO_FUNC callbacks are skipped in stack depth checks.

When push_callback_call() then calls bpf_exc_check_callback(env, cb),
env->subprog_info[cb].might_unwind is false, allowing the unwinding
callback to pass verification and cause a verifier/runtime control-flow
mismatch or jump to a zero epilogue_ip when bpf_unwind() is invoked at
runtime.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017025129.1914=
859-1-yonghong.song@linux.dev?part=3D7
