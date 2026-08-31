Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050B63ACEED
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213583; cv=none; b=ussuxFGcQ+Pc26soGosMv+jqXyZQ6TsAObB1wvu8M8g4swoNMrQZxbASiCHFFIwl9/jbgmY2o7EzN7UG8hEGS6GrIU7Zk4UuRsXUTV7Qa8d6F9iryK34NKqgjYyCvieGFlagmfF9Qn5CdU2CLMzdpG6XAYvhVTTuWzChRTMWctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213583; c=relaxed/simple;
	bh=mshvOUOU7Wm2w5u+bqeGcP+6fPGbGyVl1DTonLuuS/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JRPWwqj7+ab5fCxCAtub2lPeKQqGklh0wzgbrkw9vNYEKYO3hqn1bm4NFqx3a7VITOTHH6Y04Zd/dJaJRPp5eZh4boXgFxWi6s2aEPgnXsCX/gwJon/IPgNZosZKBx03P1UKPfLLWUtmdthwSelgK+PzPujrSRXzJjR2+y/bw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUJGCIuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUJGCIuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32531F000E9;
	Mon, 31 Aug 2026 21:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788213581;
	bh=g82bh0RnffJrbeOW4tO4MICfMWwYTkVUmZ7WNpsWFic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BUJGCIuYCWc5UlwjSM9ZYszbxnkXMR5Hh8k6cNv9PWgnIKEW6YL01tpym++R/V1zx
	 JncmqQIcm/nul86npPYV0K1WMP9AgG7d2fvambdEfgCTL6VkXcJSX6aCezCzjPJpIj
	 cgC9lpodvMjvvayY/2vCd4m61kJSZHUMCs3H0vKrMF3dhlu8y3JG/DlN0+S6eEKnai
	 HAmgtP+Kwh/sarEUmbZpe+fS1vTkkgv8x3IcTt7OzQYeEKeReZotwIR+wexE8NF3j0
	 JPTULHeKoErgPgk/4D+x08ojP4d+XQa4J07r08geINu0MfEI4keAWV1T1xmhBwPmEB
	 ihAqsU/ThfnaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 02/16] arm64: barrier: Support
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831202251.305046-3-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-3-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:59:41 +0000
Message-Id: <20260831215941.B32531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Module linkage failure due to unexported symbol `arch_timer_evtstrm=
_available`.
--

commit 6f96330ea583f1ff6aede67a83cdc552196dad11
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64: barrier: Support smp_cond_load_relaxed_timeout()

This commit introduces an optimized cpu_poll_relax() for ARM64 that uses
__cmpwait_relaxed() to wait for a value change. It gates this logic on
arch_timer_evtstrm_available() being true to avoid blocking forever without
periodic wakeups from the event stream.

> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/ba=
rrier.h
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h

[ ... ]

> +/* Re-declared here to avoid include dependency. */
> +extern bool arch_timer_evtstrm_available(void);
> +
> +/*
> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxe=
d()
> + * for @ptr value to change.
> + *
> + * State this by defining CPU_POLL_RELAX_WAITS which enables a time-check
> + * optimization in smp_cond_load_{relaxed,acquire}_timeout().
> + */
> +#define CPU_POLL_RELAX_WAITS
> +
> +#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
> +	if (arch_timer_evtstrm_available())				\
> +		__cmpwait_relaxed(ptr, val);				\
> +	else								\
> +		cpu_relax();						\
> +} while (0)

[Severity: Low]
Will this cause a module linkage failure if a loadable kernel module
uses smp_cond_load_relaxed_timeout() or similar APIs?

Since cpu_poll_relax() is a macro, it expands directly in the caller's
code. However, looking at drivers/clocksource/arm_arch_timer.c, it appears
that arch_timer_evtstrm_available() is not exported to loadable modules:

drivers/clocksource/arm_arch_timer.c:arch_timer_evtstrm_available() {
        /*
         * We might get called from a preemptible context.
         ...
}

Without an EXPORT_SYMBOL declaration, any loadable module utilizing this
polling macro will fail to link with an unknown symbol error. Should
arch_timer_evtstrm_available be exported to support loadable modules?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831202251.3050=
46-1-ankur.a.arora@oracle.com?part=3D2
