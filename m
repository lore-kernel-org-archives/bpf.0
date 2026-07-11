Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F87284690
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783767448; cv=none; b=CU1XOWf9R3uHR/JCx0mLEkKu3erl8HDdO5/GxW4h/XgbWq0KnbS7NImAz7RyO50ZXRrUuLXM8gHDK83j4G6FJsJk/73MNHB7uitbc3o83CM9RB48TI6TXJnb7Vvh1wK032HW2qbKCv5RSNogOnfNPRJmhh8V568VD0gHjweVDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783767448; c=relaxed/simple;
	bh=B9FPUT92fwRRaUM1DrNY+LDJF8KEo/6xY7ABJglEGPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RQ1DOjxN0Ev46IU5qOooAXzWRuX0cTJSqJndxDPXR9asrXtPnoR+sJHYKRD/xi3witWGKc3WtsoqlzkmqmS3NNMnqxZrIWU5dk7yd1uskYjv688sa6QJ1EbfEcjPiBV2I8ybbuQGme2bNngAMkNXRziKpRVF7ds+RlZGjCZ1evI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc8GNdoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc8GNdoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80321F000E9;
	Sat, 11 Jul 2026 10:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783767446;
	bh=vk/ylEVeH8K5kkQDrJ4Zdxv8Zu72HIbDkvL3/+AT4no=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dc8GNdojXSl/xwlPMMiSOL53kUIKcXwocu2snZeKvVfcAJ480g/F31QuZVj3PVQ+k
	 fevxLwODatRm9c0k8qTGAlLP0nqtEeg4+krBknIKfMjCkhGJtP/Gh53RfZloX7xNXq
	 GVpwJ+lkIwweoz0Y74Vsjsp5xLSHkG2s1kILwpy0iVEsULyh9JdJRmkUe3/znhW8be
	 FxwaYTLQ7OmEzipYaDDR7Gk9XYgVDoJsVzm8HFEhr1Tb75f84f2rAjy0EJYL1JxLIT
	 1EuqWaR6Y32rSnv0P563txkklu8H1dZ3Lm62E/53Txb7fEEvm+GIp0P5nyEcLDYPuH
	 PWsfhWb5AF0EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject callback subprogs invoke
 tailcall
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260711104727.4023420-2-pulehui@huaweicloud.com>
References: <20260711104727.4023420-1-pulehui@huaweicloud.com>
 <20260711104727.4023420-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 10:57:26 +0000
Message-Id: <20260711105726.A80321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Security / Logic Bypass: Direct tail calls in async and exception =
callbacks bypass the verifier restrictions.
- [Medium] Spurious Verifier Rejection (False Positive): Valid BPF programs=
 combining tail calls and sync callbacks are incorrectly rejected.
--

--- Patch [1]: [PATCH bpf-next 1/2] bpf: Reject callback subprogs invoke ta=
ilcall ---
commit 0cf6a6c653bf111f813aea810bb3fffbfc857ff7
Author: Pu Lehui <pulehui@huawei.com>

bpf: Reject callback subprogs invoke tailcall

The commit rejects tailcalls inside all subprograms of sync callbacks to
prevent infinite tailcalls caused by register clobbering. It also cleanly
consolidates the existing async and exception callback checks into a single
unified validation.

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
Does removing this check allow async and exception callbacks with direct
tail calls to bypass verifier restrictions?

Because tail_call_reachable is initialized to false at the start of
check_max_stack_depth_subprog(), a direct tail call inside an async
callback (when evaluated as a root subprog) does not trigger the logic
to set tail_call_reachable to true.=20

By removing this explicit check, the new validation block below is entirely
bypassed. This seems to allow unprivileged users to bypass the Tail Call
Counter (TCC) limits, potentially leading to runaway infinite tail calls and
kernel hangs.

>  			/* async callbacks don't increase bpf prog stack size unless called d=
irectly */
>  			if (!bpf_pseudo_call(insn + i))
>  				continue;

[ ... ]

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

[Severity: Medium]
Could this unified check spuriously reject valid BPF programs combining
tail calls and sync callbacks?

When the verifier descends into a new subprogram (like a sync callback):

		idx =3D sidx;
		if (!priv_stack_supported)
			subprog[idx].priv_stack_mode =3D NO_PRIV_STACK;

		if (subprog[idx].has_tail_call)
			tail_call_reachable =3D true;

It appears the tail_call_reachable state is not reset to false. If a BPF
program sequentially calls a tail-call-reachable subprogram, and subsequent=
ly
passes a synchronous callback to a helper (like bpf_loop), the
tail_call_reachable boolean state from the first call leaks into the
callback's DFS evaluation.

The verifier might then wrongly assume the callback itself is
tail-call-reachable, incorrectly rejecting legitimate programs with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711104727.4023=
420-1-pulehui@huaweicloud.com?part=3D1
