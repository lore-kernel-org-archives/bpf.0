Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F58422D4C3;
	Fri, 14 Aug 2026 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746198; cv=none; b=GjiTQmI3mzKgLByH7N5SUQg287i0ArdoUG3Nb7fvN0DOqBYl+pfSJBq9fgRbMWdEv282AMcrFK3phVU1EwpPCEqtiqWpTQCAaju3N5lihSdbLJLSt9N6OAXJ13BbthwpbfIGUXemjy/VXxkYNrYc29AOuUTC8viENy4io4iq3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746198; c=relaxed/simple;
	bh=TIPanpgdLduc08v0TkRd+iN/mTlNjEv/Y2kQmAalA9s=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=LarlrouhtAeKba89SK4LWS8yl/fRhV5K8nR1YSJJr/lSA8XQCNniUwVIi3dU+/K4VlR+AIEU5f1NCG4nsmEFB85cK0FfYCxi7Mwf5sA28xQnBRp1M9+g4GwDq1dp0P9GTi0n5IPqb0TuBQEEVfsyL8PvzpzFTo0PWF8WpG0yN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgJAYCsY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgJAYCsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D1D1F000E9;
	Fri, 14 Aug 2026 22:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786746196;
	bh=9O9n6XtFY25f8AIF3HpuVyR9eltRbLbe2dZG7NKr/aI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=jgJAYCsYUktAttofZpCBLofiAwpUsuh4I3kAzlozJJkcYk/7AVY2gUm8nmwSxgAMo
	 7Kt+LQrwCKJQuTnCycuDq2qvQ0nGSsqJAdpFQUY4cE5O0ZzZI+31q4O3kQkY+W02VN
	 elngrTcplCl2/nuVCaCak0i2bnTcDm5irp7ZTjK4CqaIaCOORKiit2wNx7y5L7RPIZ
	 pOfdCym2fMlvHiwCc5F2V7rh/XJb4XKJNypev2D7oNw34PC/Xxh2KCmegg5txI+auf
	 2ydBP9SoFVydrmpFtpKxMo2cz/MMmZW8SxKqdJpnfmg3KO/TD1lL8934cwb+5YC2wG
	 Jws6nKcNiuQnA==
Date: Fri, 14 Aug 2026 12:23:15 -1000
Message-ID: <3432f79f1d8195a56a0b4fea53ceb099@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: Tao Cui <cuitao@kylinos.cn>,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	suzhidao@xiaomi.com,
	yphbchou0911@gmail.com,
	zhaomengmeng@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
In-Reply-To: <80d78aac-7fc8-4c14-a2ae-419297d953f7@linux.dev>
References: <20260814144116.2767304-1-cui.tao@linux.dev>
 <80d78aac-7fc8-4c14-a2ae-419297d953f7@linux.dev>
Subject: Re: [PATCH] sched_ext/scx_flatcg: expire cached hweights on
 weight changes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello,

On Fri, Aug 14, 2026 at 10:48:35PM +0800, Tao Cui wrote:
> Is this the intended behavior of the budget clamping, or should the
> steady-state distribution converge to the compounded shares over time?
> The header comment's model doesn't seem to hold in this scenario.

The clamp isn't the culprit. I reproduced your setup (3 busy tasks per
leaf, 4 CPUs) and dug in.

The dominant factor is that D is runnable-task limited. At weight 800
its compounded share is 3.55 CPUs but it only has 3 tasks, so 75% is
the best it can do. Below that cap, the window granting loses more:
whenever all three of D's tasks are already running and another CPU
picks D, the pop from D's DSQ comes up empty, the cgv_node gets
stashed and that CPU grants a full cgrp_slice_ns window to another
cgroup. The loss scales with the window size. Measured D shares at
weight 800:

	3 tasks/leaf			55-59%
	3 tasks/leaf, 100ms slices	52%
	5 tasks/leaf			84-86%

Disabling the clamp entirely is the 59% above, so it barely matters.
With enough runnable tasks per cgroup, the distribution converges to
the documented compounding. The model holds, but only when no cgroup
is runnable-task limited, and the window granting degrades sooner than
per-task fair queueing would as that limit is approached. That's an
inherent simplification of this example scheduler.

Separately, while digging into this, I found that the true-up in
fcg_dispatch() is broken:

	__sync_fetch_and_add(&cgc->cvtime_delta,
			     (cpuc->cur_at + cgrp_slice_ns - now) *
			     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));

In the CNS_EXPIRE case, now is past cur_at + cgrp_slice_ns, so the u64
subexpression wraps. The multiplication preserves the two's complement
encoding but the unsigned division by hweight destroys it, adding about
2^64 / hweight per expiry instead of a small correction. The sign is
also inverted. The true-up should be actual minus charged, so the
expiry overrun should be added and the CNS_EMPTY unused portion
subtracted. Under saturation the budget clamp mostly masks the garbage,
which is why the numbers above barely move with it fixed (the 86% in
the 5 tasks/leaf row), but the accounting is broken all the same. The
following fixes it and tests fine (BPF division is unsigned, keep the
dividends positive):

	s64 delta = now - cpuc->cur_at - cgrp_slice_ns;

	if (delta >= 0)
		__sync_fetch_and_add(&cgc->cvtime_delta,
				     (u64)delta * FCG_HWEIGHT_ONE /
				     (cgc->hweight ?: 1));
	else
		__sync_fetch_and_sub(&cgc->cvtime_delta,
				     (u64)-delta * FCG_HWEIGHT_ONE /
				     (cgc->hweight ?: 1));

Care to send a patch?

Thanks.

--
tejun
