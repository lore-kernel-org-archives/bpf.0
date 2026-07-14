Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F439FCD2
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997806; cv=none; b=ZhbnbVNcqNK3sISkioP4wYiGSNNJ/2M8PuPkBU0zS4VaLzEtjreDVN1sV0VGwuHF8bBEOJLmBUG0ebKhJeGeRbiKmTiW00Ss+v5icy2x9zu0da7y8AOyR7FYToY4PM83SbcpfsmJlVZ6BuYij+1r8qjxULQX5PlLbpqpdsvLrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997806; c=relaxed/simple;
	bh=F81J8l8a1N10FxqNZICAByC4d52DQknAyZA4p4rU6lE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ld8dPaBx6eywFdbQgld3+SAR8Dy04dN03dLbp+7WdLXBmp74demu1HSCikCCZgiqW+51ok7CMiSMXhlZnBAg6y4QugSVRNdbW+mkVauP6fQPliqlChcjVfVKadxDVDoyNDourqNK6+g8x96dSRUfCChfI2tVS0pZgSD8Raom4kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J50cEj/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J50cEj/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101971F000E9;
	Tue, 14 Jul 2026 02:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783997805;
	bh=phAcTHir19hSVVZU2rtPThjCWxXIB5eXcGmdbJgDYUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J50cEj/Tc4Zpz2cqYALf7H73BCcTxlCW6MtDf8i4kTF9eeKXSrNfho7yVdG5AU2NL
	 EoW0h00+u8+xn8/jtdBUfwE/g2aHOh4Qk04hDf12pqga3NqC25x3VF1SZPRr+7wP7O
	 XkkZSNIxnF46M3zavMm0xMQVIyZEUmCTN+RfBc2DImw+Wd70wM6gatwAizGKhVP89Y
	 IiQm9T8wTI9lA3CUxamKpXN06Z1P+pf5zI+Md7h9Ti+Gk8z4q8kRyBPLwLqO0AzLyT
	 JX0ZG4rr7jaKF9PjFcuIu4Tx9PtTYz9aLdfET6ZBzqnAbK/1Z+VneoCxw/xsVjuhB6
	 3k5+ae8QORceg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject callback subprogs invoke
 tailcall
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714024459.420075-2-pulehui@huaweicloud.com>
References: <20260714024459.420075-1-pulehui@huaweicloud.com>
 <20260714024459.420075-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 02:56:44 +0000
Message-Id: <20260714025645.101971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch inadvertently allows async and exception callbacks to ex=
ecute tail calls, bypassing verifier protections and reintroducing the TCC =
register clobbering vulnerability.
- [High] The unified `is_cb` check introduces a DFS state leakage that inco=
rrectly rejects valid BPF programs containing both a tail call and an unrel=
ated synchronous callback.
--

--- Patch [1]: [PATCH bpf-next v2 1/2] bpf: Reject callback subprogs invoke=
 tailcall ---
commit d260c3afbc5fedfa9c5c074686a31f057a21a53a
Author: Pu Lehui <pulehui@huawei.com>

bpf: Reject callback subprogs invoke tailcall

This patch rejects tailcalls inside all subprograms of synchronous callbacks
to prevent clobbering the TCC limit register on some JIT compilers. It also
consolidates async and exception callback checks into a single unified
is_cb check.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 03e2202cca13d..3f6c8b8fc04d0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5258,10 +5258,6 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>  		if (verifier_bug_if(sidx < 0, env, "callee not found at insn %d", next=
_insn))
>  			return -EFAULT;
>  		if (subprog[sidx].is_async_cb) {
> -			if (subprog[sidx].has_tail_call) {
> -				verifier_bug(env, "subprog has tail_call and async cb");
> -				return -EFAULT;
> -			}

[Severity: High]
Does removing this explicit check allow async and exception callbacks to
execute tail calls when they contain no further subprogram calls?

Because async and exception callbacks are evaluated as the root of their own
call graphs by check_max_stack_depth_subprog() (with idx > 0), the local
tail_call_reachable variable remains false throughout the evaluation loop if
the callback makes no normal subprogram calls.

When the loop ends, the new unified is_cb check is bypassed because
tail_call_reachable is false, and the fallback check is skipped because !idx
is false for async callbacks. Can this bypass the TCC limit protections and
lead to infinite tailcalls?

>  			/* async callbacks don't increase bpf prog stack size unless called d=
irectly */
>  			if (!bpf_pseudo_call(insn + i))
>  				continue;
> @@ -5302,8 +5298,8 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
>  	 */
>  	if (tail_call_reachable) {
>  		for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller) {
> -			if (subprog[tmp].is_exception_cb) {
> -				verbose(env, "cannot tail call within exception cb\n");
> +			if (subprog[tmp].is_cb) {
> +				verbose(env, "cannot tail call within callback\n");
>  				return -EINVAL;
>  			}

[Severity: High]
Can the local tail_call_reachable variable leak across unrelated subprograms
during the verifier's Depth-First Search?

If a BPF program first calls a subprogram containing a tail call, the DFS
will set tail_call_reachable =3D true and mark it true for all ancestors.
When backtracking from the callee to the main program, tail_call_reachable
is restored to the ancestor's state:

kernel/bpf/verifier.c:check_max_stack_depth_subprog() {
    ...
	/* reset tail_call_reachable to the parent's actual state */
	tail_call_reachable =3D subprog[idx].tail_call_reachable;

	goto continue_func;
    ...
}

If the program subsequently sets up a synchronous callback (e.g., via
bpf_loop()), the loop jumps back up without resetting tail_call_reachable to
false. When it reaches the end of the callback subprogram,
tail_call_reachable will still be true from the leaked state.

Will this cause the new unified is_cb check to incorrectly reject perfectly
valid BPF programs that contain both a tail call and an unrelated synchrono=
us
callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714024459.4200=
75-1-pulehui@huaweicloud.com?part=3D1
