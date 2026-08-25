Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0003A4F30;
	Tue, 25 Aug 2026 05:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787636210; cv=none; b=QNLknxWfrRKhEei9J2UAgk81S8QBupGlBlLokA/LW5WsLnH62fkz8dwUC5bliSPv9OUO8vlpq9Yrs4GcrrmQ9aX3cJQQMsLGp5B9Uw1odm+8tBa9H9l8vc5nA4zuJKCqGqwuTBT5HblQsyN6vgmj06KxGmbuGd+YAdcROSHT9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787636210; c=relaxed/simple;
	bh=eb+BWMmQhHeqiGyfChvE0Wl33jcA6Fk2uWQZfBWvfRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WWJO8cVGlC6eM33lEO20PDVu4lXbv8AqoiLalV6dPD8dEkpwCb9u5dfDb9ERW5Ixgx7IIJfyIngtap7gYVWlF2W2LawwpVsUllQ9kqEUtmZWeU/jm0Z+5InTAKlNU/mBbVLblx32l9nzwplg4eM7TgOgrz3VR8bdWnGykSFoQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7vRY8L/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7vRY8L/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7D41F000E9;
	Tue, 25 Aug 2026 05:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787636209;
	bh=WDXaaGRhIFC65XOBXYCwoLxCaDyKLPW6B4ErgZ48WVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A7vRY8L/4ZmXww591xGUt5zx3siX/hYVd/vEIYJ4leIS+0JUhImfgqUStpjAM9Uyb
	 89ukvlz6LOKdsP/CTlj80lfoi41z7vrEoURAqsRZ3BBsDPCuvI87QdM1Um2POqzwzL
	 gXBHeENjIkzSparAXqu3h7hsvne5MibVw9meDXd9mj8p6RMejZglTPcLmMm084yvVX
	 UdyNgER1RZJshI7TZnFWDPs8oFZGbdiYzVgCJMaqtGt/uppOTzoq3ytgp3YMdIchaX
	 XtAlHnfb9HBPrzNvSItnIhFk74OmInB4lyEANAL/gBB6kZvSSFdA6EDfJtvzV1jfXc
	 T92Kbpy75sQtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched_ext: Allow ops.cgroup_set_weight/idle() to be
 sleepable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260825052336.46746-1-cui.tao@linux.dev>
References: <20260825052336.46746-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 05:36:48 +0000
Message-Id: <20260825053648.EF7D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent cgroup writes to `cpu.weight`, `cpu.shares`, or `cpu.id=
le` can permanently desynchronize the core scheduler and BPF scheduler stat=
e, and cause data races on SCX fields.
--

--- Patch [1]: [PATCH] sched_ext: Allow ops.cgroup_set_weight/idle() to be =
sleepable ---
commit 1a01a0e2918fcf8ca79c6152b56ecfa3e223935c
Author: Tao Cui <cuitao@kylinos.cn>

sched_ext: Allow ops.cgroup_set_weight/idle() to be sleepable

ops.cgroup_set_weight() and ops.cgroup_set_idle() are delivered from
scx_group_set_weight() and scx_group_set_idle(), which run from the
cpu.weight and cpu.idle cgroup interface write paths. This patch adds
them to the allow-list so these callbacks can allocate on demand.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index c539d15cda637..dd4ecc0b5201d 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -8079,7 +8079,9 @@ static int bpf_scx_check_member(const struct btf_ty=
pe *t,
>  	case offsetof(struct sched_ext_ops, cgroup_init):
>  	case offsetof(struct sched_ext_ops, cgroup_exit):
>  	case offsetof(struct sched_ext_ops, cgroup_prep_move):
> +	case offsetof(struct sched_ext_ops, cgroup_set_weight):
>  	case offsetof(struct sched_ext_ops, cgroup_set_bandwidth):
> +	case offsetof(struct sched_ext_ops, cgroup_set_idle):

[Severity: High]
This isn't a bug introduced by this patch, but does making these operations
sleepable widen a race condition where concurrent cgroup writes could
permanently desynchronize the core scheduler and BPF scheduler state?

Looking at kernel/sched/core.c:cpu_weight_write_u64(), the core scheduler is
updated inside sched_group_set_shares() (which takes and drops shares_mutex=
),
leaving a gap before the BPF scheduler is updated:

kernel/sched/core.c:cpu_weight_write_u64() {
    ...
	ret =3D sched_group_set_shares(css_tg(css), scale_load(weight));
	if (!ret)
		scx_group_set_weight(css_tg(css), cgrp_weight);
    ...
}

Inside scx_group_set_weight(), the SCX scheduler state and tg->scx.weight
are updated without serialization (holding only a read lock):

kernel/sched/ext/ext.c:scx_group_set_weight() {
    ...
	SCX_CALL_OP(sch, cgroup_set_weight, NULL, tg_cgrp(tg), weight);

	tg->scx.weight =3D weight;
    ...
}

The same pattern exists in kernel/sched/core.c:cpu_idle_write_s64() calling
scx_group_set_idle() and updating tg->scx.idle.

If two threads concurrently write to cpu.weight or cpu.idle, they serialize=
 on
shares_mutex but drop it before calling the SCX functions. Because this pat=
ch
allows ops.cgroup_set_weight and ops.cgroup_set_idle to sleep, could the
threads execute out of order?=20

If Thread B's core scheduler update runs after Thread A's, but Thread B's B=
PF
callback finishes before Thread A's, the final state in the core scheduler
would be B, while the SCX state ends up as A. Can this lead to incorrect
functional behavior and data races on tg->scx.weight and tg->scx.idle?

>  #endif
>  	case offsetof(struct sched_ext_ops, cpu_online):

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825052336.4674=
6-1-cui.tao@linux.dev?part=3D1
