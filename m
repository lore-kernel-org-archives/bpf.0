Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE6477E37;
	Tue, 14 Jul 2026 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036861; cv=none; b=N+NlzfSuIUyCyCgLYgS+l1+lkdIFTmevQMvvHdr7ExMijvZSeWF0vam5F95dj6/dXJTJymGH83pbndAj1iKZ789cT/cJLTxOZOGjPPSwjwcOkCjOnc9NCGkvYQ1sNKv04ot/8Y8B3iI93hM0+vxvx+trvCUZmhm3eZyliEerlW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036861; c=relaxed/simple;
	bh=P10sqAu3BTK8QXsnc5a9Gq9byauFTrhK3vFf7HyJ1s0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ow8ixGmom6u7DlnxcOyQbEw3AJnNeWkOlBMHcKEsFopuMOnNrHMfKXiqpjox/AziYK0hki95fxoumGZiBriEcyUo0ocD/EWA2J2J8vbdw37v//LEtZuktJfw9YMqz6HdwvLbg5bKhO4cyUygAvBWPMp0j+ilUGwFf0TQP1z6Pjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq6CQBhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq6CQBhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509351F000E9;
	Tue, 14 Jul 2026 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784036860;
	bh=as1hyUElsqNDN3xfNf1AKsFKYJ7NSurFjoig00Tsl0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Mq6CQBhidmTO/xi6/EQBvn3kuphYWrZcjPY7r7O+6F2aLfm47t+tVk8Ux8qKX9x3U
	 C5pk9MAiD5/82RF4GQRqFrcaKjCm/gY0JI4iqUOe2pu5LVrUKls/zpxNnnm5428lxo
	 eFzc49P4G+rmvU6ND4EMjKsNIwvquNR+oQkAa2u3OMR5pCGcdQfh5Lc2EEc9pkKB8l
	 x78ucXLTZohQWunRsTCZ0ZUGaXOuak55NSEXaQtjqSng0tlZn+KcQPREr4msApwhBF
	 qTweKKFUnT3k1k/+CeuSWh+vr/fQvF+3DlAy0iNvjF7AcicM694QCYw3GZQef4cp9s
	 z/O3bI9aA5GFg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: sashiko-reviews@lists.linux.dev, Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject callback subprogs invoke
 tailcall
In-Reply-To: <20260714025645.101971F000E9@smtp.kernel.org>
References: <20260714024459.420075-1-pulehui@huaweicloud.com>
 <20260714024459.420075-2-pulehui@huaweicloud.com>
 <20260714025645.101971F000E9@smtp.kernel.org>
Date: Tue, 14 Jul 2026 15:47:35 +0200
Message-ID: <87ech5wumg.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] The patch inadvertently allows async and exception callbacks to =
execute tail calls, bypassing verifier protections and reintroducing the TC=
C register clobbering vulnerability.
> - [High] The unified `is_cb` check introduces a DFS state leakage that in=
correctly rejects valid BPF programs containing both a tail call and an unr=
elated synchronous callback.
> --
>
> --- Patch [1]: [PATCH bpf-next v2 1/2] bpf: Reject callback subprogs invo=
ke tailcall ---
> commit d260c3afbc5fedfa9c5c074686a31f057a21a53a
> Author: Pu Lehui <pulehui@huawei.com>
>
> bpf: Reject callback subprogs invoke tailcall
>
> This patch rejects tailcalls inside all subprograms of synchronous callba=
cks
> to prevent clobbering the TCC limit register on some JIT compilers. It al=
so
> consolidates async and exception callback checks into a single unified
> is_cb check.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 03e2202cca13d..3f6c8b8fc04d0 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5258,10 +5258,6 @@ static int check_max_stack_depth_subprog(struct b=
pf_verifier_env *env, int idx,
>>  		if (verifier_bug_if(sidx < 0, env, "callee not found at insn %d", nex=
t_insn))
>>  			return -EFAULT;
>>  		if (subprog[sidx].is_async_cb) {
>> -			if (subprog[sidx].has_tail_call) {
>> -				verifier_bug(env, "subprog has tail_call and async cb");
>> -				return -EFAULT;
>> -			}
>
> [Severity: High]
> Does removing this explicit check allow async and exception callbacks to
> execute tail calls when they contain no further subprogram calls?
>
> Because async and exception callbacks are evaluated as the root of their =
own
> call graphs by check_max_stack_depth_subprog() (with idx > 0), the local
> tail_call_reachable variable remains false throughout the evaluation loop=
 if
> the callback makes no normal subprogram calls.
>
> When the loop ends, the new unified is_cb check is bypassed because
> tail_call_reachable is false, and the fallback check is skipped because !=
idx
> is false for async callbacks. Can this bypass the TCC limit protections a=
nd
> lead to infinite tailcalls?
>
>>  			/* async callbacks don't increase bpf prog stack size unless called =
directly */
>>  			if (!bpf_pseudo_call(insn + i))
>>  				continue;
>> @@ -5302,8 +5298,8 @@ static int check_max_stack_depth_subprog(struct bp=
f_verifier_env *env, int idx,
>>  	 */
>>  	if (tail_call_reachable) {
>>  		for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller) {
>> -			if (subprog[tmp].is_exception_cb) {
>> -				verbose(env, "cannot tail call within exception cb\n");
>> +			if (subprog[tmp].is_cb) {
>> +				verbose(env, "cannot tail call within callback\n");
>>  				return -EINVAL;
>>  			}
>
> [Severity: High]
> Can the local tail_call_reachable variable leak across unrelated subprogr=
ams
> during the verifier's Depth-First Search?
>
> If a BPF program first calls a subprogram containing a tail call, the DFS
> will set tail_call_reachable =3D true and mark it true for all ancestors.
> When backtracking from the callee to the main program, tail_call_reachable
> is restored to the ancestor's state:
>
> kernel/bpf/verifier.c:check_max_stack_depth_subprog() {
>     ...
> 	/* reset tail_call_reachable to the parent's actual state */
> 	tail_call_reachable =3D subprog[idx].tail_call_reachable;
>
> 	goto continue_func;
>     ...
> }
>
> If the program subsequently sets up a synchronous callback (e.g., via
> bpf_loop()), the loop jumps back up without resetting tail_call_reachable=
 to
> false. When it reaches the end of the callback subprogram,
> tail_call_reachable will still be true from the leaked state.
>
> Will this cause the new unified is_cb check to incorrectly reject perfect=
ly
> valid BPF programs that contain both a tail call and an unrelated synchro=
nous
> callback?

Don't about "high severity", but this seems legit. It seems like we can
get "random" (depending of ordering) rejects of legit program, no? ...at
least the LLM I asked could construct a fix/PoC for it...


Bj=C3=B6rn

