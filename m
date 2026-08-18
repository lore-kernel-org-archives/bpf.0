Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14BC441627;
	Tue, 18 Aug 2026 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062254; cv=none; b=XD6kTctKZcUKB4PFJ8NOwu5mhEkgUDvW+5mLxnRrwVjrCK85vJEIvAaE7+0/3abD8C0uZDj/8AFDfVC/H8uim/7Aw1Z+iARiOMS7s3Cz5U4WQPCG3p3c1wjFfmaHMXvaltJIy5Tu4cToKE/eKVhLcxKN74gjgnsHbv7hZtidzmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062254; c=relaxed/simple;
	bh=CNWdVBPLLb7YsiBn3KIRBJ1qXG6Dcdfp8HA1crpm8oo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l21Y9y2Xlk9/qDxSYfbPzYQ+1bvUwEDjK8Gk2Q2Lx7dkvF+Banf0hzXPbVbIIcMP2ZpqVNtcaaX2ij4xpHedPX8vKMsFkTX7+aRFmh/FpWlPP6yUiSmWlZff4blRiczIVVHWpAnUy5ajr6U9AT4KIWJf2nPXMSMXWQjasmpQ3pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7CtCF5+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7CtCF5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443E81F000E9;
	Tue, 18 Aug 2026 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787062252;
	bh=wxquUJFnu6mdKW6gzatMFDWlHjtdPeKiLmg0bieVPJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h7CtCF5+PMfHz3XSHB6q+TxxQmdbSVOhz2dkLuG+eERBvhWH0laxUtj44AV3w8NHy
	 scrWJqIDl0PgSI0ZECXpyO3ElhgDjyuY8WUYFAHwiQ/9snhL36aVL2TfyxuwoJUciY
	 Z4NaDZ72QxjYGELs74UJS9aLeLVBdvo5b6MXcA36IdQQtY52Mk9m3/+LOXTTo6mMcI
	 JOo4Sp0AUZ02t7c5fTj0YEopKyMJOArij/q0SrEl5QmlrvrcL7yHw5g77IywnPDp25
	 1bb9n2Wthu5Kv08YNreZCyvykJ7iMgTgyQerOc3mN7PUR3EaeipvP/OmzDQT940mDG
	 3cSaHXa10ZZrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] sched_ext: warn when cpu.max is set but the BPF
 scheduler doesn't implement bandwidth control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260818135328.174152-1-cui.tao@linux.dev>
References: <20260818135328.174152-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 14:10:51 +0000
Message-Id: <20260818141052.443E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new warning for unenforced `cpu.max` is missing during BPF s=
cheduler initialization, meaning preexisting cgroup quotas are silently ign=
ored without notification.
--

--- Patch [1]: [PATCH RFC] sched_ext: warn when cpu.max is set but the BPF =
scheduler doesn't implement bandwidth control ---
commit 88bd45e8c02c048f00992a1d03614c8ef709c738
Author: Tao Cui <cuitao@kylinos.cn>

sched_ext: warn when cpu.max is set but the BPF scheduler doesn't implement=
 bandwidth control

This commit adds a one-time warning when a finite cpu.max quota is
configured on a cgroup but the active BPF scheduler lacks the
cgroup_set_bandwidth callback. The intent is to notify users and
orchestrators that the quota is silently ignored and not enforced by the
scheduler.

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 18183062f751c..1067d271f6b27 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4565,6 +4565,12 @@ void scx_group_set_bandwidth(struct task_group *tg,
>  	     tg->scx.bw_burst_us !=3D burst_us))
>  		SCX_CALL_OP(sch, cgroup_set_bandwidth, NULL,
>  			    tg_cgrp(tg), period_us, quota_us, burst_us);
> +	else if (scx_cgroup_enabled && sch &&
> +		 !SCX_HAS_OP(sch, cgroup_set_bandwidth) &&
> +		 quota_us !=3D RUNTIME_INF)
> +		pr_warn_once("sched_ext: BPF scheduler \"%s\" does not implement "
> +			     "ops.cgroup_set_bandwidth(); cpu.max will not be enforced\n",
> +			     sch->ops.name);

[Severity: Medium]
Will this warning also catch preexisting cgroup bandwidth configurations?

If a user configures a finite cpu.max limit on a cgroup before the BPF
scheduler is loaded, the initialization path in scx_cgroup_init() passes
the existing quota to the scheduler:

kernel/sched/ext/ext.c:scx_cgroup_init() {
    ...
		struct scx_cgroup_init_args args =3D {
			.weight =3D tg->scx.weight,
			.bw_period_us =3D tg->scx.bw_period_us,
			.bw_quota_us =3D tg->scx.bw_quota_us,
			.bw_burst_us =3D tg->scx.bw_burst_us,
		};
    ...
		ret =3D SCX_CALL_OP_RET(sch, cgroup_init, NULL,
				      css->cgroup, &args);
    ...
}

Should scx_cgroup_init() also check for an unenforced quota and emit this
warning, to ensure users are notified when preexisting configurations are
silently ignored?

> =20
>  	tg->scx.bw_period_us =3D period_us;
>  	tg->scx.bw_quota_us =3D quota_us;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818135328.1741=
52-1-cui.tao@linux.dev?part=3D1
