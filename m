Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7555C1D5
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091788; cv=none; b=Pq1uwKa3Wj5uDbqtZkF8kj7+kOqXY7mv2wWqobxzSk3FmRIldomAwtTXyqMUHVIm4W9UbKYo6Dxv4lyxpIZ/+0/ZoN0ve2UdSi2cEaq2ZE9QnzUuwLsG+7cWxS9SEhn3EQ0TLsAosSBErEDfru7ZjkQIBKUw48IGT90KpSbU7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091788; c=relaxed/simple;
	bh=l07At5e/FtwvFEhvmUdFRuvOuYiPaFWdFCcvR7eYvUQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjQXxfO8HWwZF5Y3xarqGPqnMjU2T0ilzjSOrpHFt+6wtSar1Uoh6xRkA6gvJnQIotnwgpH9eeRta32/rSZT9sPWg3uB3HyKxY4QGHGfUPRPi6H1r27PlRL5b3ZIwuJKCwn3wDJ662PgHCxbc1ptw28w4jq1VY3Kw+i1b8jwkQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=HmGRtZ1u; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="HmGRtZ1u"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109f067cso3417085a.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790091783; x=1790696583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NGKku8nyry7LJ3cQ2W+BxzqUbPO2qtN0RpKOVM2oOc8=;
        b=HmGRtZ1uXSJy5W2bLzIdB1jBwSa2qtnPXke0stGNe+fv+pNP9rnPPL4WDaTnfqr3bt
         /7mN16YmsLXQjygdMHRJMwD2buCTN0SwoJvV9Xt71/2SJDmRyKHX7Yxant0YMAAeTh+n
         zMMYMgD9RkdDN6WmPHeeAVOpKlJgusqLOlJYPXWrg6OPzNRnLOF1cumRsSfzMYfMedQo
         SasVdnkynUDXsyn2hBqYSpiJfXtJLmzc6JYBrZc3FciPxHOnxvkykWzZTP51OwaxXsYW
         3y9TznhMdcQCZSOBat6hh6sqcQaexAnF22qR4Uwcg6gLuk5bp/ze94gRCCbIZz7PJxHx
         fp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091783; x=1790696583;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGKku8nyry7LJ3cQ2W+BxzqUbPO2qtN0RpKOVM2oOc8=;
        b=shlmx7ntpKLEjXFshRasZO8rUAvnj/6n9qGHiqCfcvPhKY3rfCYD321Tyf+RgVsH3V
         4sU0gneny6aVfQLM2oTHE2SqUJj7kc3Zd1EznXgiBhHbblvI2iM/3VT9F7EXw3Fc/Kvy
         0gpu/TsGt49KSMM3MN9jcUBfSSTyRbY2ZIwTsGaJfbh8qkhR8psqx28MvjjEUUIy1qsJ
         BGMj0T2VRaemqEiOxJdJPPC4RaNxc9VK1nVZjsguOmJzvOQLs6dA3G91P9e1UGs0sA1n
         uepjewj4EYF+UaAk5rrl856V94mW7w13rN6vU+E1IjgbIxoVaO34TOIK6e/yDD7iK+fd
         0HXw==
X-Forwarded-Encrypted: i=1; AKwUvByheOO90o9KhkIKIgXded89Ix/NxBjvFL2mhkbP8Hir/IcsYo1H5QhMnfad2Dy2CMMGvtI=@vger.kernel.org
X-Gm-Message-State: AFuF++nT9lfBDttlBsn91UctK26xGMZJrQ7YCpIjkEUKRckyhSXJkIs9
	CWnixcncqQy8zydqaC/v0JrCy3sfw0q3a8gM87PMYh8bRmQ/MJcVpvVQ3K24g0wKwkE=
X-Gm-Gg: AYBFou2AO5lJyJJV56HZ31f0Wg2tg0Kt98JQ13qsE/wuPITylUHnQ9buu6krcS1vgoY
	e8t/yZyTJ4UMHjM8PpHMq6Xv0OuvhslRHkLm3o2GvOmpNkr+2iAl1L3ZHAW4Z2JOlEaN+dyxRCX
	2YOsvoYeA1+oB+xmDjCexZF1Vue4c6h9V6n4SNbI9KHiWSx00/XaXsmeRtpiLWayunx8/QGrBwN
	Dldt5LEpDLKyioVBGB43L3tc5h7ABr+lvhxKpwKhmKQazAusGYG85obpTdEaXNdnCh9xyq0btbW
	IlvduzZCeN4gQQoLXxyWC7GCLMBm7a718aezySxqT/R2XWc0BDsRCNBY4XMB6XIKsl6SEwSjOo9
	NL3OgaosLEkAQ9Js4J/7Sv78Xz7SbMuMxJaWjxcgulrRGI0V+zQ+UKaPuerKFPbtgX8g2mH46OD
	pn4rWCXYpJGpf7YU9KEp44zrlp9zPb7jCH+7kWhGr3f7UF084CquJbA4GraFj4911VFMrrEkiY7
	045YWu0n4KxtlM=
X-Received: by 2002:a05:620a:6006:b0:93b:d79f:d955 with SMTP id af79cd13be357-93c15f2e6e5mr588176085a.74.1790091783184;
        Tue, 22 Sep 2026 08:43:03 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2485dce4sm1063585a.23.2026.09.22.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:43:01 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:42:15 +0000
Message-ID: <d36fdaad78296f3c43f84bc9c5b15a36.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v3 03/13] rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines
In-Reply-To: <aqxLgT41UyA-bV5J@pavilion.home>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-3-0ad30c4c5ee7@toxicpanda.com> <aqxLgT41UyA-bV5J@pavilion.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 22:20:17 +0200, Frederic Weisbecker wrote:
> > +	lockdep_assert_irqs_disabled();
> > +	WRITE_ONCE(t->rcu_tasks_irq_ip, ip);
> > +	t->rcu_tasks_exit_cpu = smp_processor_id();
> > +	raw_spin_lock_rcu_node(rtpcp);
> > +	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);
> > +	raw_spin_unlock_rcu_node(rtpcp);
>
> I don't think we can do that. This is too much unconditional overhead
> on the hot preemption path. rcu_tasks_trampoline_text() should be
> a condition here.

Sorry, I missed this one before sending v4/v5. Agreed, and it is gone
for v6: the hook is now just the WRITE_ONCE() of the IP plus the
rcu_tasks_trampoline_text() check, and the exit side a single store.

The IP store itself has to stay unconditional because of the kprobe
jump optimizer: its window is ordinary text, so a task parked there
before the optimizer decided to patch was not "trampoline text" when it
was preempted, and the optimizer needs to find it afterwards.

> And do we really need to maintain both lists? I understand that they
> have different purposes.
[...]
> Can the latter replace the former?

With the above there is only the holdout list left. The optimizer's
rcu_tasks_wait_irq_preempted() now does what classic does for its scan:
walk the task list plus the per-CPU exit lists (exit_tasks_rcu_start()
and friends stay shared between the two flavors for that), checking each
task's recorded IP. That is a slow path that only kprobe optimization
hits.

And thanks for picking up the core-RCU follow-on.

Josef
