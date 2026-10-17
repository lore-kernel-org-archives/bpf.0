Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575A38839F
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202286; cv=none; b=etmgbrbD2lU5SoJAibz7DhOLquGkIZNxFkkh4kiYr5MlifSvO5wb2Tw1Kcp1WpvLt75cBL4Mshv1hwhf+OMRKFSqklDbRB0CRLm+NjlnHIUkMNk+Nf1KvYe145x40ASoIYV51VbaJU0jWAphas7WEDwpydhCyYkcJuzOgn2SBbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202286; c=relaxed/simple;
	bh=GAuId5vYB76oKPHC15e/H+difcXGRL3/40F1i4lczVU=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=L5yW+XS5UANyfreNGRN0HCez1FhJsCXr0RxGAuEMJm1HiZjsgZyuYD7d8+kKsoE7W1FTObE6S3MztawN6fkEfKdwcKdqcgPSBQrPa84GSkhbiFUNel/XhL9vY6P4DbwQPAVPTQUpyLgDYnxmxtvzALQFiB5P+L3so/1e9R3w+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3mfPJQ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3mfPJQ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539ED1F000C4;
	Sat, 17 Oct 2026 01:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202282;
	bh=X8p1B+OvOO8rykc8VeWKFleYYX8us6Z2nXv6gC/RvCw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=L3mfPJQ8O0PDgoyovm96Z5FF+/mWsd0nG/7YCrFNyBW1aAV/AaIl6LrZDd0aP+q6l
	 p2lC9bcm9BYjqWZzgPYD9cw2vCJd7cV77P3lyf7T9D8QadTTfHR0k152nTvRwUChQI
	 kN5jOx8m3LjqExx/GdIM5WUJUtHiv1ABBJTBOLSVtgWETKGp2rWT3N1TNG1uENw30L
	 itbKrgm6CDpoFN5ZA9clTj62zvGU8/KRf8MMA+E5EFWZxskdv6pQp3p3gOhwI6YIiA
	 e0C7sho7S4siiG2O2Er2MZ3KgY7iB6ZeEvxscPXn66CFCLblZTnhBFTOJ4xziUWryo
	 JZJ9+9MMH2icw==
Message-ID: <sashiko-outbox-175168@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 23/38] bpf: Check the maps that sleepable
 callbacks use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017012451.364800-15-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
 <20261017012451.364800-15-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 01:58:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: global subprog call under preempt/irq disable bypasses map RC=
U check
--

commit 44c0901fdd3a21bde77f64657ef1a8f91005cd05
Author: Josef Bacik <josef@toxicpanda.com>

bpf: Check the maps that sleepable callbacks use

This commit restricts map helper calls in sleepable contexts (such as bpf_wq
or bpf_task_work callbacks, or with inner maps) to maps that do not require=
 an
RCU read-side lock unless bpf_rcu_read_lock() is held or the helper runs in=
side
an RCU callback. It also adds bloom filters to the list of maps usable with=
out
RCU.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1f2a846ae415f..09173d1d66d39 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -10379,12 +10380,57 @@ bool bpf_allow_tail_call_in_subprogs(struct bpf=
_verifier_env *env)
>  	       bpf_jit_supports_subprog_tailcalls();
>  }
> =20
> +/* May the map be used outside of an RCU read side critical section? */
> +static bool map_needs_no_rcu(const struct bpf_map *map)
> +{
[ ... ]
> +}
> +
>  static int check_map_func_compatibility(struct bpf_verifier_env *env,
>  					struct bpf_map *map, int func_id)
>  {
>  	if (!map)
>  		return 0;
> =20
> +	/*
> +	 * check_map_prog_compatibility() asks the program.  That misses the
> +	 * sleepable callback of another program, and an inner map.  They may
> +	 * use any map under the RCU read lock.  Disabled preemption or
> +	 * interrupts will not do: the maps ask for rcu_read_lock_held().
> +	 */
> +	if (in_sleepable(env) && !env->cur_state->active_rcu_locks &&
> +	    !in_rcu_callback(env) && !map_needs_no_rcu(map)) {
> +		verbose(env, "map '%s' needs bpf_rcu_read_lock() in sleepable context\=
n",
> +			map->name);
> +		return -EINVAL;
> +	}

[Severity: High]
Can this check be bypassed if a sleepable callback or sleepable program
disables preemption or local IRQs and then calls a global subprogram that
accesses the map?

When a global subprogram is called in check_func_call(), the verifier recor=
ds
the calling context using in_sleepable_context(env):

kernel/bpf/verifier.c:check_func_call() {
	...
	if (sub_aux->func_info_aux =3D=3D BPF_FUNC_GLOBAL) {
		...
		sub_aux->called[in_sleepable_context(env)] =3D true;
		...
	}
}

However, in_sleepable_context() checks in_rcu_cs(), which treats disabled
preemption (active_preempt_locks) and disabled local IRQs (active_irq_id) a=
s an
RCU critical section even when active_rcu_locks is zero:

kernel/bpf/verifier.c:in_rcu_cs() {
	return env->cur_state->active_rcu_locks ||
	       env->cur_state->active_preempt_locks ||
	       env->cur_state->active_locks ||
	       env->cur_state->active_irq_id ||
	       !in_sleepable(env);
}

kernel/bpf/verifier.c:in_sleepable_context() {
	return !in_rcu_cs(env) && !in_rcu_callback(env);
}

If a bpf_wq or bpf_task_work callback calls bpf_preempt_disable() or
bpf_local_irq_save() without bpf_rcu_read_lock() and then calls a global
subprogram, in_sleepable_context(env) returns false and sets
sub_aux->called[0] =3D true.

When do_check_subprogs() later verifies that global subprogram via
do_check_common(env, i, 0), state->in_sleepable is initialized to false. In=
side
the global subprogram, in_sleepable(env) evaluates to false in
check_map_func_compatibility(), allowing helpers such as bpf_map_lookup_ele=
m()
on a sockhash or an inner RCU-requiring map without holding rcu_read_lock()=
 and
triggering the WARN_ON_ONCE(!rcu_read_lock_held()) in __sock_hash_lookup_el=
em()
at runtime.

[ ... ]

>
>
>
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017012058.3557=
87-1-alexei.starovoitov@gmail.com?part=3D23
