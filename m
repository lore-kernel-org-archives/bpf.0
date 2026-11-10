Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310147;
	b=Zn1/ZWNbxNnZ+YM9YE3yIKDe/tCoKZCbSvEgL+TnKPTLLLhjwraPAygIZnjPw6pfjaR1
	 tVwPXYOTg7Dba2JMzxWVR7bCpA+FP1tX2KCR7fEiSbSJPApWahcj7mcUqMRHRyq6wf4eA
	 sm7WtzG3Xvb2X9/CQRLgMlYD6nqDdXecq8k7UZxyaaFi7oo/qvTzbHclpiPUGiTAM9d7L
	 t8/S+bEcvp862v5fls2vmbzMkYqVaN7O0CFNctuCvpQilUQGhi3hb4hu5v4nQ4JcqFra0
	 0b8oKLoJ1FnEaHhmJBQ6d8aH4TLtUXh7+ALxEnlXPvs3WhYrGeem47oXIN3+AW2/Lkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310147;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OSqH4r00O+LGjeH9oXTibCFF9MxmIJEz2qWtr+o/lrw=;
	b=YqJotpy6s7uObb8zUBXEOrU1ZqJtVhTqUv8ffDBh09SGmQbmYPppPxKaJR1SGgn5B6Az
	 /B4mx5X6Cy4x2keQHuuw8hQRHg84vs1cWUBm2oO3R5uRC+EnYj0QYUxVuvAxHM2fesbda
	 N48O2JiTnEcg24KduoC/HUsT9batgBhIeU/g7nqOvneHEjVsXmFFyybNQCJcD/3HklreB
	 ZlEG/XKcQAmjIKj0dIJL6e3QNieYfbCDnHNzlBL41ncnTuBHrOOxqRpwmpaadgdMcOmK2
	 EE7UAD9kdhsBjH/wYCAg/uSmnWLX/UOvNV/adyEpYcqyXoSDeSVT1aP9qWeR9NjVv1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2nGKRpX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D88606A31C;
	Tue, 10 Nov 2026 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2nGKRpX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AA11F0089F;
	Tue, 10 Nov 2026 11:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310147;
	bh=OSqH4r00O+LGjeH9oXTibCFF9MxmIJEz2qWtr+o/lrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n2nGKRpXzOdCXc3MlDtfdWiiH+Cv7Rgutlm5Sihs5QKgc02JX+UPYUJ2lgAKFURHz
	 M7adpcXKRDx37PN/bvpioifhJI7jdOYyaWtkwwgWr49DrJTnRlr2OXW3VUliKvh6bP
	 40aK4+Wg+pxM128TsFWe15r2p+xtWm41sMMVMuK7+Qgfj2/eRODG1SZNzJoaG6G1K9
	 +qE2fzA6qh1RwE15Ub7HmTyPXNiWBjjmizUWTWDKp7NoEWGAHPbuZ3nq6A+55IltY9
	 Fi+9S6k+2g0tuBdq9NttAkqY7YTaqjwcxCoK6Pttgy7u1uqfR0FgzYg/Adt8/7iZmv
	 xN8YJ4RR+3AAw==
Message-ID: <sashiko-outbox-206938@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] sched/fair: refill bandwidth for the periods the
 timer slept through
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fernand Sieber" <sieberf@amazon.com>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <681751a52093faada8da25d8dbccc59444c3d251.1794303670.git.sieberf@amazon.com>
References: <cover.1794303670.git.sieberf@amazon.com>
 <681751a52093faada8da25d8dbccc59444c3d251.1794303670.git.sieberf@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:29:06 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] sched/fair: period_timer forwarded with old period in
  tg_set_cfs_bandwidth()
--

commit 6dcac4d8cedf5c5fafb47bd8f0ac725a2be649bc
Author: Fernand Sieber <sieberf@amazon.com>

sched/fair: refill bandwidth for the periods the timer slept through

This commit refills a CFS group's accumulated bandwidth for the period
boundaries missed while its period timer was stopped, capped at quota +
burst, and updates bandwidth configuration and cpu.max.runtime reads and
writes to account for those idle periods.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 76fcd70ff207a..75a5f5d1b8f54 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9856,6 +9856,12 @@ static int tg_set_cfs_bandwidth(struct task_group =
*tg,
>  		cfs_bandwidth_usage_inc();
> =20
>  	scoped_guard (raw_spinlock_irq, &cfs_b->lock) {
> +		/*
> +		 * The new bandwidth applies from now on. The group keeps what
> +		 * it earned while idle under the old one.
> +		 */
> +		cfs_bandwidth_refill_idle_periods(cfs_b);
> +
>  		cfs_b->period =3D ns_to_ktime(period);
>  		cfs_b->quota =3D quota;
>  		cfs_b->burst =3D burst;

[Severity: Medium]
When cfs_b->period_active is 0, does calling
cfs_bandwidth_refill_idle_periods() before updating cfs_b->period arm
cfs_b->period_timer with the old period's expiry instead of the new one?

cfs_bandwidth_refill_idle_periods() calls hrtimer_forward_now() with the
old cfs_b->period, pushing period_timer's expiry into (now, now +
old_period].  When tg_set_cfs_bandwidth() then calls
start_cfs_bandwidth() after updating cfs_b->period:

kernel/sched/core.c:tg_set_cfs_bandwidth() {
	...
		__refill_cfs_bandwidth_runtime(cfs_b);

		/*
		 * Restart the period timer (if active) to handle new
		 * period expiry:
		 */
		if (runtime_enabled)
			start_cfs_bandwidth(cfs_b);
	}
}

the second cfs_bandwidth_refill_idle_periods() call inside
start_cfs_bandwidth() sees an expiry already in the future, so
hrtimer_forward_now() returns 0 without adjusting it to the new period.
When a newly created cgroup (initialized with a 100ms period) or an idle
cgroup is configured with a shorter period such as 1ms,
hrtimer_start_expires() arms period_timer up to old_period in the future,
starving the group of refills for that interval after its initial quota is
spent.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794303670.gi=
t.sieberf@amazon.com?part=3D2
