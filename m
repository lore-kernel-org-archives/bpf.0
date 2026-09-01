Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D943149D;
	Tue,  1 Sep 2026 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231287; cv=none; b=FcAvBpkkpavknCWv6xMoBXDMdp2CDiLqG0JYEcDAc/LOdhIXaRTQZy+dXHB4D6T9lEga0WBVububC4UgmElMS3Cm9dAmQuSreBcw19nshhQw9mzKe80CpVsExdf8xNbeanyXm8Y9LAnMHTMOOv4qBn3YacJmq/rxU5BcO20MeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231287; c=relaxed/simple;
	bh=ML52TpRy/I+ayru1gn3GROsmLypMPRFKOD57sIvLU1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HUnxwI7P+iH1z92mnbfWVN2Lk7eA8oQO/3rJyygRyrhg7R9e/c6CS6W8t8gq7QzQyACoHYgdeFa+fzBwxSYR1ZjGHoLZlNeTNNUSPM546f0RE9SKgSJs5PPrGGpgtrbaJ3jNxr9tiihrjxHPRPVmn2tuDnujueGVFeQbpOYpFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfLUcW/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfLUcW/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DCE1F000E9;
	Tue,  1 Sep 2026 02:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788231282;
	bh=oc77boeQMwgpVdXOYlmvg+hfK36P/Af5Fg/tpEILnIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XfLUcW/ciMn9YTFcnqkRTZykxeZ7Nv347kRMmrtYIncscitntva0jy59/clGGBE0L
	 BD5sQkhhvyMbFrWEkd51qK4MOFdbI4fjHO+CPtoI196eyF/ewMzYvPFMTcdeeiSc8U
	 536S0t2qnGuLEa2F8AzVq7jPOdN8+1LH4cxX7a1puB2tUiIC84XF11jPPhegno0643
	 TeTUipiy3tBVBRkYH94x2R/tf0FkKjtiPityoj9ya9Jylx9EvrIbrof5vhnHvWYD63
	 OR373mJkP+8+WwwOzuF7819rOm9cV36q+u5qHHi5gK5zytUS8FpCM9zeTQ5hi4kLXv
	 Gmxb47xZQv0hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] sched_ext: fix vtime priority queue inversion on
 wide vtime spread
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260901024038.730424-2-cui.tao@linux.dev>
References: <20260901024038.730424-1-cui.tao@linux.dev>
 <20260901024038.730424-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 02:54:41 +0000
Message-Id: <20260901025441.B3DCE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch silently breaks the established cyclic `vtime` ordering =
contract by switching to an absolute `<` comparison, causing permanent task=
 starvation upon wraparound and contradicting existing kfunc documentation =
and selftests.
--

commit b0708e9275ee1ffad12d1e3811001b6d6ee4c741
Author: Tao Cui <cuitao@kylinos.cn>

sched_ext: fix vtime priority queue inversion on wide vtime spread

This commit replaces the time_before64() cyclic comparison in
scx_dsq_priq_less() with a plain less-than operation to prevent priority qu=
eue
inversion when vtimes have a wide spread.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 18183062f751c..db1ea9054c0ca 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1356,7 +1356,8 @@ static bool scx_dsq_priq_less(struct rb_node *node_=
a,
>  	const struct task_struct *b =3D
>  		container_of(node_b, struct task_struct, scx.dsq_priq);
> =20
> -	return time_before64(a->scx.dsq_vtime, b->scx.dsq_vtime);
> +	/* dsq_vtime is arbitrary BPF input: keep a total order */
> +	return a->scx.dsq_vtime < b->scx.dsq_vtime;

[Severity: High]
Does this break the established cyclic vtime ordering contract and cause
permanent task starvation upon wraparound?

If a BPF scheduler assigns vtime to tasks, and the vtime advances and
eventually wraps around U64_MAX, tasks that are in the queue at the time of
wraparound (with vtime near U64_MAX) will be indefinitely starved. This hap=
pens
because new post-wrap tasks (with small absolute vtimes) will be strictly l=
ess
than the old ones and placed ahead of them.

The user-facing kfunc documentation for __scx_bpf_dsq_insert_vtime() in
kernel/sched/ext/ext.c still explicitly promises the cyclic wrapping behavi=
or:

 * @args->vtime ordering is according to time_before64() which considers
 * wrapping. A numerically larger vtime may indicate an earlier position in=
 the
 * ordering and vice-versa.

Additionally, BPF schedulers still actively rely on the cyclic vtime semant=
ics,
as seen in tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c:

static inline bool vtime_before(u64 a, u64 b)
{
	return (s64)(a - b) < 0;
}

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901024038.7304=
24-1-cui.tao@linux.dev?part=3D1
