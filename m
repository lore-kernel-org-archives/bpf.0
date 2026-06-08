Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC602EA480
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907497; cv=none; b=tOqimtQNGQ50oyKg8v2WmyHojWeWU1XGy9yrVocVbQIXxlzC69psjuiwN7KnfmlEQBhLdfMKAqxjaFnV3vQ3X100Ai93/RGIeeAdtIJQYL4D9k+5JJ8ru/E2JyLKdG9+ZbCqorxfyAFD0iUove6aLdzhyXA1u439jix2IdMmmE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907497; c=relaxed/simple;
	bh=G+NzV7bltKtIh/d9YWQAdLsulKr2ktb4r/dZ0EmPtIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TAKZyTQCSQEmLSgvL5ZwooJ0fWMSDoDP5BmpLzAYV8Anp/GJaDyRuKyyft/RZh22NJOo5XkqbyoHfPu7uzSrUqyLF1QT3A89zHwP8i+DAy1CnE5QvUWJZOoa1528PT32Pww/oR9gtIwa1hUvj/0GJO0Mp+D5D6XFIQKcicEmh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHnTYNBL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHnTYNBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A521F00898;
	Mon,  8 Jun 2026 08:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780907496;
	bh=2UNy/UM3zbsmTktlLLtd0+SEWa3Vl27gBtriIKIWUw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SHnTYNBLJzlxzzzvBcRMMFd0Aezi5CMkNKmlpRRE6h+/B0u2RuNGn0OXrizBgs02U
	 m0mR1jAf+vNnu7nfg+qXFLWLn3jLJygAhWlVzF10K4uyLyQQVqZ1sacK5SolZrwogG
	 TWlEg91a9LtoVwt4BuObaWkgZIaD9vOMj2//xnZ4ytknmQix6OZMmG34FrRDgZtPQE
	 jrROppwlF3oUaWb5ezxW9v7Lwd8k/kWOli3F7fGm8MXtwyyf8HvJDcDsGyMuVmxLY4
	 iVI0eLAKnm6wkmBoy4U7vzCm0quR+uQY1eqw6oqW3E7XxTLXbaX800TDTvQobeed9C
	 fQxcYJ7FM3wCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 12/15] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608080440.127491-13-ankur.a.arora@oracle.com>
References: <20260608080440.127491-13-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:31:35 +0000
Message-Id: <20260608083136.20A521F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] smp_cond_load_relaxed_timeout() doubles the timeout duration on ar=
chitectures where cpu_poll_relax() suspends execution (e.g., arm64 using WF=
ET).
--

commit 9f74e9110ff72d86c2f74843434b01c10db16a0c
Author: Ankur Arora <ankur.a.arora@oracle.com>

cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait=
()

The inner loop in poll_idle() currently polls over the thread_info flags us=
ing
cpu_relax(), waiting for TIF_NEED_RESCHED. This commit switches to using
tif_need_resched_relaxed_wait() instead. This aims to minimize power
consumption by utilizing optimized platform-specific waiting mechanisms.

> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index c7524e4c522a2..7443b3e971baf 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
[ ... ]
> @@ -6,41 +6,22 @@
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>  			       struct cpuidle_driver *drv, int index)
>  {
[ ... ]
>  	raw_local_irq_enable();
>  	if (!current_set_polling_and_test()) {
> -		unsigned int loop_count =3D 0;
>  		u64 limit;
> =20
>  		limit =3D cpuidle_poll_time(drv, dev);
> =20
> -		while (!need_resched()) {
> -			cpu_relax();
> -			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> -				continue;
> -
> -			loop_count =3D 0;
> -			if (local_clock_noinstr() - time_start > limit) {
> -				dev->poll_time_limit =3D true;
> -				break;
> -			}
> -		}
> +		dev->poll_time_limit =3D !tif_need_resched_relaxed_wait(limit);

[Severity: High]
Does this double the timeout duration on architectures where cpu_poll_relax=
()
suspends execution (such as arm64 using WFET)?

Looking at the generic macro smp_cond_load_relaxed_timeout() called by
tif_need_resched_relaxed_wait(), the absolute deadline __time_end is lazily
initialized after the first batch of polling iterations:

include/asm-generic/barrier.h:
    ...
		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
		if (++__count < __spin)					\
			continue;					\
		__time_now =3D (s64)(time_expr_ns);			\
		if (unlikely(__time_end =3D=3D 0))				\
			__time_end =3D __time_now + __timeout;		\
    ...

On arm64, SMP_TIMEOUT_POLL_COUNT is 1, and cpu_poll_relax() maps to
__cmpwait_relaxed_timeout(), which uses the WFET instruction to sleep for t=
he
requested timeout:

arch/arm64/include/asm/barrier.h:
#define SMP_TIMEOUT_POLL_COUNT	1

#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
    ...
}

Because __time_end is calculated as __time_now + __timeout after waking up
from this first sleep, wouldn't the deadline be erroneously set to
start_time + 2 * timeout_ns?

If so, the loop would continue, calling cpu_poll_relax() again with a
remaining timeout of timeout_ns, causing a second sleep and breaking the
timeout contract.

>  	}
>  	raw_local_irq_disable();
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608080440.1274=
91-1-ankur.a.arora@oracle.com?part=3D12
