Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3489537AA78
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036450; cv=none; b=uFwph/onWMCQLIZjJnfPcjY+2J4xGzkkd00Bgt4rW51aoa4X6CoQ8sc0kQdgZFX1vk90GF1GW0JP0WpntnoCnQoqipejP9wDeCI0cBisBgUVURBEgqU/JO5L8aAi6kUCZf3sfyIi683QGhwOtDmHl6emijDeh5ffjcfBwegdAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036450; c=relaxed/simple;
	bh=0wAtpdvWXEG21Xa/Ub+S+luMyQM6s7O66ygfOuPCmn0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MWgJzm2tjIzTMW5kUSnt3Bl3xztO6WGlB+JwwCqiPzkhSNdHK5+j2qbb1B7yz5AG9xi0bWeTH7jt3sXlXE0QoG6dec12Zr0LeHiBOiDe0q7asn4ywemSTShXgy8+XW6XKE5H5G7DTKo2Q4DtsW7ypAjAR8c+B5PoSsyjWYkVpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CW7JmFhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CW7JmFhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF14E1F000E9;
	Thu,  6 Aug 2026 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036449;
	bh=RJFVwqWzwRkJBU9Fz7dFyX44JWzadu+1tDP7+H5B2Go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CW7JmFhH/FOB/XXMylKVLp/w406gyGwMyUX9k+ttDRUL3wDZdvULYv8FsBgLkHhIj
	 bn7SCmH1PjLog30IOGc7cxEVWvegnhvWNhpwxZsbWJxs1235nO7gSDX0vFWu17niqB
	 nGzhU0e35fO/l+sNwJ8RhuRekeV/SBGHDUClPwhG82NxNpLSa511R2arUglVV4i82p
	 CllNqK7mM7Ia+sAaqxAkFXdl8Y4XxFPAi9gwaEF3sijjrpadWGGaB/lAIDX6mc8s9n
	 KB273iVWXT1hdq8j+gPjM1r5BSCnHLzlaOskRvPO6y+qd5T77RFHIwD73MX8diTXqg
	 P2UOjGnB9tvDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Fix sleepable context checks and
 remove in_sleepable helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806164049.3158887-2-memxor@gmail.com>
References: <20260806164049.3158887-1-memxor@gmail.com>
 <20260806164049.3158887-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:14:08 +0000
Message-Id: <20260806171408.EF14E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Replacing `in_sleepable()` with `in_sleepable_context()` in the =
first sleepable check renders the second check dead code and degrades the v=
erifier error message.

Pre-existing issues:
- [High] Incomplete fix: Bypassed sleepable context restrictions on the `cs=
s_task` iterator for LSM and TRACE_ITER BPF programs allow 'sleeping in ato=
mic context' bugs on PREEMPT_RT.
--

--- Patch [1]: [PATCH bpf-next v1 1/2] bpf: Fix sleepable context checks an=
d remove in_sleepable helper ---
commit fe09e0b3c58d1fc2d9c5ba46b9ee32ba789423ae
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Fix sleepable context checks and remove in_sleepable helper

This patch updates several call sites to use in_sleepable_context() instead
of in_sleepable() to ensure that sleepable kfuncs and iterators are rejected
when called from non-sleepable contexts, such as inside RCU read-side
critical sections. It also removes the in_sleepable helper entirely to
prevent future misuse.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e6233c0081d10..3dadf2b33a367 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12083,7 +12078,7 @@ static bool check_css_task_iter_allowlist(struct =
bpf_verifier_env *env)
>  			return true;
>  		fallthrough;
>  	default:
> -		return in_sleepable(env);
> +		return in_sleepable_context(env);
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but does this bypass the newly applied sleepa=
ble
context check for LSM and TRACE_ITER programs?

Looking at the full function:

static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
{
	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);

	switch (prog_type) {
	case BPF_PROG_TYPE_LSM:
		return true;
	case BPF_PROG_TYPE_TRACING:
		if (env->prog->expected_attach_type =3D=3D BPF_TRACE_ITER)
			return true;
...

If an LSM or BPF_TRACE_ITER program explicitly enters a non-sleepable
context (e.g., via bpf_preempt_disable()) and then initializes a css_task
iterator via bpf_iter_css_task_new(), they return true unconditionally.

Because the css_task iterator acquires css_set_lock (which maps to a sleepa=
ble
rt_mutex on PREEMPT_RT), could this cause a fatal lockdep splat or "sleeping
in atomic context" kernel panic on PREEMPT_RT kernels?

[ ... ]

> @@ -13090,7 +13085,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  	}
> =20
>  	sleepable =3D bpf_is_kfunc_sleepable(&meta);
> -	if (sleepable && !in_sleepable(env)) {
> +	if (sleepable && !in_sleepable_context(env)) {
>  		verbose(env, "program must be sleepable to call sleepable kfunc %s\n",=
 func_name);
>  		return -EACCES;
>  	}

[Severity: Medium]
Does replacing this check render the second sleepable check in this function
unreachable?

Because sleepable kfuncs are not lock-manipulation kfuncs themselves, the
context state cannot change between this first check and the second check
further down in check_kfunc_call():

	if (sleepable && !in_sleepable_context(env)) {
		verbose(env, "kernel func %s is sleepable within %s\n",
			func_name, non_sleepable_context_description(env));
		return -EACCES;
	}

If a user writes a sleepable BPF program, enters a non-sleepable context,
and then calls a sleepable kfunc, the verifier will exit at the first check
with the generic "program must be sleepable..." error.

This is factually misleading since the program is sleepable but just inside
a non-sleepable context.

Is it possible to remove the first check entirely or consolidate them so we
keep the more accurate context-aware error message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806164049.3158=
887-1-memxor@gmail.com?part=3D1
