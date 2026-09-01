Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E039A054;
	Tue,  1 Sep 2026 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267408; cv=none; b=qQy7OoytWQ41KTTl0zcj++bmq5VQZyrFc/AoiBiFnfc5PPyG1WtYTqBYOVHLPP8DvgQR3Ha+mfSoNYV/TVgsCdvi7WLUYk30/AThvikXMJMrcGSVLbWUU1uEnPzMB7+DgOc/g+XTa6JlfJDT90a0LuTjE1dq9VpY1grjVWaErgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267408; c=relaxed/simple;
	bh=rDVRkDrV28wDfghg4rwVKQQfENxd1izFza24kT8xpvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pqPYgLcoHHbO5V+xpAl2dkdtrbqZDUOX0zsgSsruPJaZ9pHvs/4DSbaFzaG6pHKPMJnUDZgOvuuFRyr/7ncGkR0OFIXCZ+BHqEOsNrtfMYA7WvMA3TcxEiF9tcW/b26JKvM6Vra1phIZotjV1kjofOgqmJo+2BpZykrevFbBPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/nAspJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/nAspJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D682B1F000E9;
	Tue,  1 Sep 2026 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788267407;
	bh=pPPYWfnEXXxlePIBP7cnq0DyUwWbd54u3uDbpGavSp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q/nAspJ5dXiswLaxawl+5R6xzhqUg2lqNZ4kDnMR4ogd8xRQYy+bpU7crz4/+OvUz
	 YeOHzjteEA+JZt4wV36tSZRnkEg0PtxDVMTWKnrw9fdUHOmQge4SNc3xyJvthDuZI/
	 xtvuFCxNqeISlqGHrPSalhCjQ9jI4vKhjpXtYHcs1Q3AZN8WnmW5Ho/gzD8Qa9ZWpQ
	 kG9SntufqndanDT7vV0ZhsQ9AC7wYD1pgT3l9UxbSvEc13U7Y5uOhEbKevGTlAH4O7
	 A1UU74E0UuIGvTsaIBZjQHiK+/VUeYVQMi3BJdlvTqCT1jAhQW3Wi3u1J/6emxHetA
	 RdujtRah+eIIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] sched_ext: don't deliver duplicate
 ops.cgroup_set_idle() for same value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260901124347.755904-1-cui.tao@linux.dev>
References: <20260901124347.755904-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 12:56:46 +0000
Message-Id: <20260901125646.D682B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Lockless state check introduces a Time-of-Check to Time-of-Use (TO=
CTOU) race that can permanently desynchronize the BPF scheduler from the ac=
tual cgroup state.
- [Low] Compilation failure due to use of non-existent field `sched_idle` i=
n `struct scx_task_group`.
--

commit 47d6f0af51f3086b39745cdfc5f053f908dbd0c7
Author: Tao Cui <cuitao@kylinos.cn>

sched_ext: don't deliver duplicate ops.cgroup_set_idle() for same value
   =20
This commit avoids sending duplicate cgroup_set_idle() callbacks to the BPF
scheduler by checking if the cgroup's idle state has actually changed.

Link: https://lore.kernel.org/r/b53c61a1-4d7d-4232-941f-d48b0563d4ed@linux.=
dev

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index c539d15cda637..c72d9780830b8 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4930,7 +4930,8 @@ void scx_group_set_idle(struct task_group *tg, bool=
 idle)
>  	percpu_down_read(&scx_cgroup_ops_rwsem);
>  	sch =3D scx_tg_knob_sched(tg);
> =20
> -	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_idle))
> +	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_idle) &&
> +	    tg->scx.sched_idle !=3D idle)

[Severity: Low]
Does sched_idle exist in struct scx_task_group? It looks like this might
cause a compile failure when building with CONFIG_SCHED_CLASS_EXT and
CONFIG_EXT_GROUP_SCHED enabled. Should this be checking tg->scx.idle instea=
d?

[Severity: High]
Is it possible for concurrent writes to cpu.idle to permanently desynchroni=
ze
the BPF scheduler from the actual cgroup state here?

Since this state check is performed locklessly before the callback is sent,
if Thread A writes 1 and Thread B concurrently writes 0, could Thread B
evaluate the new check while the state is still 0, and falsely skip sending
its callback?

If Thread A then sends its callback for 1, and Thread B subsequently updates
the state to 0, the BPF scheduler might think the state is 1 while the
internal tracking state is 0.

If a user tries to manually fix this by echoing 0 again, wouldn't the
lockless check see the internal state is already 0 and skip the corrective
callback, leaving the BPF scheduler trapped in the wrong state?

>  		SCX_CALL_OP(sch, cgroup_set_idle, NULL, tg_cgrp(tg), idle);
> =20
>  	/* Update the task group's idle state */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901124347.7559=
04-1-cui.tao@linux.dev?part=3D1
