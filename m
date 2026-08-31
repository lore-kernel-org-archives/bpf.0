Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9313E7621
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218405; cv=none; b=spArVC+RvNyrjWUg58msrTZCZY051tR5Qa+UKSF/ziEd0us7Iyo0aihYt4Uj7T9zTjZEAQyrp7RHGLo7oMZ0GMBEXtENiDMZBYJvSRHY8PUrV2ZDC8a0ks1hQ4emFeomm5EdsO+5Y2iuzg8dABe62hiPxvBa/s65DY6a7lPZHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218405; c=relaxed/simple;
	bh=o/jJ6rSP8XzE9XGO5mnAi30LWAOvHE4Bhx/wS7KM9K0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sTyNgSLNUlEOE1ItXyMYrsXC69cip44ZQBRpb58Mt5w27bp36HRhazHOM5+y5QfvtiIz0riaVd63sSzt2IRT+2xwAM15R8XLNBtV5yLO9b7Gab86O8FbU7BzIByERC++AAcoQJVBUlhizRs32hdcLweHrpShf1MIkh3di+WHXco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6pu2V1N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6pu2V1N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9101F000E9;
	Mon, 31 Aug 2026 23:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788218403;
	bh=HcIbu3rcfjqCSX9vMTBozll8Sha3Toz0HB4EtuJshPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R6pu2V1NkQSQbiQjEYJsp3nKd/k+HFh4IqYjhv9StFZvpznPWr2ALKktDKkDbPZpY
	 rCdMUWZ3wYJ4PcohlSdVKghYC/RhO1gaubfUka/qUCVp1/AYqevWGhdmnDTaTuYlGf
	 vmZs8KrMpd0InK1W4dWK21NUHg/zW5I9tUlVzJNq5shUDlj4Zox6XheWg11itVUl7L
	 aucf4fdyTOwTRKPznDpYM5/hR4bo9vHT/3L17rlGFZH/AzSBoMdLZnJSZAJ70nmAT4
	 WYthDYnYEq7yT4K9Yd3hN87maVOtvrUs7fhTHBxuksQdbWoyG4u8thAtLu4rYvGzFs
	 6tcnivvPgarLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 12/16] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831202251.305046-13-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-13-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:20:03 +0000
Message-Id: <20260831232003.7C9101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The timeout for the idle polling loop is erroneously extended be=
cause the generic wait macro calculates the timeout start time only after t=
he first 200 spin iterations. Additionally, the commit relies on an archite=
cture-specific optimization that does not actually exist on the target plat=
form.
--

commit 9b952e08004e7de674a695400c7ab21ff69df4db
Author: Ankur Arora <ankur.a.arora@oracle.com>

cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait=
()

This commit replaces the manual polling loop in poll_idle() with a call to
tif_need_resched_relaxed_wait() to optimize idle power consumption.

> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index c7524e4c522a2..7443b3e971baf 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
[ ... ]
> @@ -21,15 +20,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *=
dev,
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

[Severity: Medium]
Does this unintentionally extend the polling timeout?

When tif_need_resched_relaxed_wait() uses the generic
__smp_cond_load_relaxed_timeout() macro, it first spins for 200 iterations
before capturing the start time for the timeout:

include/asm-generic/barrier.h:__smp_cond_load_relaxed_timeout() {
    ...
    cpu_poll_relax(__PTR, VAL, (u64)__scl_timeout); \
    if (++__scl_count < __scl_spin)                 \
            continue;                               \
    __scl_time_now =3D (s64)(time_expr_ns);           \
    if (unlikely(__scl_time_end =3D=3D 0)) {            \
            __scl_timeout =3D (s64)(timeout_ns);      \
            __scl_time_end =3D __scl_time_now + __scl_timeout; \
    ...
}

Since the timeout calculation is deferred until after the initial spin loop,
the total wait time becomes the requested limit plus the duration of those
first 200 iterations.

On platforms where 200 cpu_relax() iterations can take a significant amount
of time (e.g. ~14 microseconds on modern x86), could this effectively delay
entry into deeper C-states and cause a power regression for short polling
intervals?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831202251.3050=
46-1-ankur.a.arora@oracle.com?part=3D12
