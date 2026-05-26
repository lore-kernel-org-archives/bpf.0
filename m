Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DC3DBD6F
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793873; cv=none; b=FPfpSAOq1x7famdd+N3FhDodw3GbeC7gXRPxRoEuZ4iDv7yZkmC9a/5p5Be0ZiAw40fD5TwviYYuelZOw82nZ7/oZK+1DYAaM03nr3G09K5VU4fomb4hNjGinu9xwsQxu5cAArBIqn5Q5VDYcUzQvu1qvCn6GzfDqI7ot9H6fiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793873; c=relaxed/simple;
	bh=/6uOX5Edz+dtsyI/C+aHhNgTe0z5PYprl0F29KhuLsA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bqqs4nuWhyTdzcaOhLjiyChPyydJt9l4/Y5AkArBsdcBmS6XEIXjWefuNJOd1CiJqaTsvD1AfqAIYrUEzjPnjigqSUE6xV3dCLYaZfAwKAv+Jb6meVWQ+MO+XCXwHoZVnX/DL5TMCc0HGJ/si+RAD4LC+AUOsWkz6q5sRksC1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erHPrPLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erHPrPLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B541F000E9;
	Tue, 26 May 2026 11:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779793872;
	bh=Z8BAPiB7UEj1Nw03DJqwnWmjeAf/1cEpxpMaA06cAHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=erHPrPLJFNv6OPTIG//d0Tf2ON7GJ1g8dmyRP2kJH+72zuaq2tUlEwocjO/4VaGtP
	 e7iExu0xp0rO7jdfmlWptu4/gt0TNlkhhzIQ2bTqv0m2e/yI0ER4SzJi08ideSQFak
	 A+2HdGPjTT2TZWV9lY4IWNpvQvnpNc0fMWO69w4qRcDp7CquWO7y8aAKSzJBvYVq5X
	 Id97C6qOD7uHoQVyfc93akw/Tx46zDX/PtWNuXsZkVSgZNnITfpwiorj3X+7Z+fR5q
	 3zTFyW4luqZWGypWbN2udd+6YqYqgemDrH8MUCQYVOie+K4hmoLMBy8i79Y47FP6bi
	 VzYGtGglF46CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 5/6] bpf: report register diff summary for
 hot callchains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526-better-1m-reporting-v1-5-51e4f2c59780@gmail.com>
References: <20260526-better-1m-reporting-v1-5-51e4f2c59780@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 11:11:11 +0000
Message-Id: <20260526111112.06B541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Misuse of the `list_for_each` macro in `bpf_sample_state_diffs()` =
causes out-of-bounds reads and an eventual kernel panic.
- [Medium] Early returns in `states_equal()` and `func_states_equal()` fail=
 to populate the `bpf_state_diff` output parameter, misleadingly attributin=
g differences to register R0.

Pre-existing issues:
- [High] The `printed_subs` bitmap in `print_hotspots()` is undersized, whi=
ch can lead to a stack buffer overflow.
--

commit d10e1bb2745385ee84a9743a4009ae6e95842d64
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: report register diff summary for hot callchains

This commit modifies the verifier to report a summary of register differenc=
es
for hot callchains ending at iter_next, may_goto, or callback-calling
instructions. It does this by taking the most frequently varying register
or stack locations from explored states.

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 8773381360095..17b48d9f0c105 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
[ ... ]
> @@ -970,7 +1004,8 @@ static void reset_idmap_scratch(struct bpf_verifier_=
env *env)
>  static bool states_equal(struct bpf_verifier_env *env,
>  			 struct bpf_verifier_state *old,
>  			 struct bpf_verifier_state *cur,
> -			 enum exact_level exact)
> +			 enum exact_level exact,
> +			 struct bpf_state_diff *diff)
>  {
>  	u32 insn_idx;
>  	int i;

[Severity: Medium]
Since diff is initialized to zero by the caller, will early returns in
states_equal() and func_states_equal() (such as mismatches in in_sleepable,
callback_depth, or refsafe()) fail to update the diff parameter?

Would this result in falsely attributing state mismatches to register R0
and producing misleading profiling statistics?

[ ... ]
> @@ -1588,3 +1627,94 @@ int bpf_is_state_visited(struct bpf_verifier_env *=
env, int insn_idx)
[ ... ]
> +int bpf_sample_state_diffs(struct bpf_verifier_env *env,
> +			   struct bpf_callchain *cc,
> +			   struct bpf_state_diff *top_diffs,
> +			   int *nr_diffs)
> +{
[ ... ]
> +	list_for_each(pos_i, head) {
> +		sl_i =3D container_of(pos_i, struct bpf_verifier_state_list, node);
> +		if (!callchain_matches_state(cc, &sl_i->state))
> +			continue;
> +		list_for_each(pos_j, pos_i) {
> +			struct bpf_state_diff diff =3D {};
> +
> +			sl_j =3D container_of(pos_j, struct bpf_verifier_state_list, node);
> +			if (!callchain_matches_state(cc, &sl_j->state))

[Severity: High]
Does this nested loop traversal result in processing the dummy list head?

Because list_for_each() iterates until the pointer wraps around to its
start point (in this case, pos_i), the traversal will inevitably evaluate
the dummy head (&env->explored_states[hash_idx]).

When container_of() computes sl_j from this dummy head, won't the
subsequent callchain_matches_state() dereference an invalid pointer and
cause an out-of-bounds read?

> +				continue;
> +			if (states_equal(env, &sl_i->state, &sl_j->state, NOT_EXACT, &diff))
> +				continue;
[ ... ]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8eb8f1ce17c76..7a84eeae395fa 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -17340,16 +17369,16 @@ static void disasm_subprog(struct bpf_verifier_=
env *env, struct bpf_subprog_info
>   * Print several most visited simulated stack traces,
>   * and a disasembly of related subprograms.
>   */
> -static void print_hotspots(struct bpf_verifier_env *env)
> +static int print_hotspots(struct bpf_verifier_env *env)
>  {
>  	DECLARE_BITMAP(printed_subs, BPF_MAX_SUBPROGS) =3D {};

[Severity: High]
This is a pre-existing issue, but could the printed_subs bitmap be too small
here?

The subprog_info array in the verifier environment contains BPF_MAX_SUBPROGS
+ 2 elements to account for fake and exception subprograms.

If a recorded hot callchain includes an exception subprogram, will the offs=
et
sub - env->subprog_info evaluate to an index greater than or equal to
BPF_MAX_SUBPROGS, causing a stack buffer overflow when __set_bit() is
called?

>  	struct bpf_callchain_entry *top[3] =3D {};
>  	struct bpf_callchain_entry *entry;
>  	struct bpf_subprog_info *sub;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-better-1m-=
reporting-v1-0-51e4f2c59780@gmail.com?part=3D5
