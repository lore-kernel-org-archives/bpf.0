Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578823DCDB1
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884505; cv=none; b=u+pRlGBheeyIAEjt3tw7gG7H0JqBHQ6tdjRv6RApXVhqQ3mlkAjt7CA84gv7phVo2IYp4tLTiaScZXGNRFiOvLKC5TNJzUfCoBHbe7Q7zfnIlYd79gIDn101NEYYS6/7Ozlf9885EsYrhjRlxTzu9+TCNesc6CKG+kZNfakRMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884505; c=relaxed/simple;
	bh=EtcvTRPcNXbEjTTGC4zDeu6At8YDVL1RjCHtXS/DfW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pDazrYn0Ks0BazyN6kKau5Ac+mPNGuDRnPLUGdDlRANRbF1VUN5zg0msyBN/hYp+H2zczcMk5nXl1iXWvKOOeRFAB+lOm1z6E46iO7XU90yYU/SqeONub9dgfgc04FfX4wQUtgp/iarl+cqKSLQZDqco1J1vdHolV2DY+u9+kL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZVzHw46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZVzHw46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5ED1F000E9;
	Wed, 27 May 2026 12:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779884504;
	bh=UcKao7X4s5UQqH1SRKH+ooShsblBhpP7QM/UoPj0c+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QZVzHw46aaO4uOI4PxTWRiIdCnJPakASWO7W/bzbcJJd+rvJf/MrPfC6Tw5RcuxQL
	 jhdthgHOhXgPEzDksbRYfDkBXhQ/Total8LU4DNgNkqhaIRoEebipoeIOAu39j2JdS
	 fhwDbD9InkmOodlty0cls4k3bxje6g/chyvxrNM0yftupOiojB/pR2+w7jHsi57aTa
	 DnWKWMrvhQ85hml2vAn+KNq4Q1jKTodgKpyLdTpYlQpBlFQpAwZGzanVk7R9wcGI/z
	 tp1KGGzvFmheh1H29GE18mGmQbq4GZYxY1OmfX7mZiRuygBGsavL8p6DRPYO0PV2HC
	 NPi/FLyb+Tl2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv6 bpf-next 04/29] bpf: Use mutex lock pool for bpf
 trampolines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527113951.46265-5-jolsa@kernel.org>
References: <20260527113951.46265-5-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 12:21:43 +0000
Message-Id: <20260527122143.CE5ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Hash collisions in the new global trampoline lock pool cause unrel=
ated kprobe, fprobe, and BPF link registrations to spuriously fail with -EA=
GAIN.
- [Low] Suboptimal pointer hashing API used for trampoline pointers.
- [Low] Multi-line comments modified by the patch do not follow the modern =
kernel comment style for the BPF subsystem.
--

commit db06fb69cc58248a60a56902b3ac29b2878a30f9
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Use mutex lock pool for bpf trampolines

This commit replaces the per-trampoline mutex with a global pool of 32
mutexes to reduce lock depth during multi-trampoline attachment.
Trampolines hash into this pool to acquire locks.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index a4298a25d4bae..df7634de0ca2c 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> +static struct mutex *select_trampoline_lock(struct bpf_trampoline *tr)
> +{
> +	return &trampoline_locks[hash_64((u64)(uintptr_t) tr, TRAMPOLINE_LOCKS_=
BITS)].mutex;
> +}

[Severity: Low]
This isn't a bug, but could we use the dedicated hash_ptr() macro from
linux/hash.h here instead of casting the pointer to u64?

[ ... ]

>  	if (cmd =3D=3D FTRACE_OPS_CMD_ENABLE_SHARE_IPMODIFY_SELF) {
>  		/* This is called inside register_ftrace_direct_multi(), so
> -		 * tr->mutex is already locked.
> +		 * trampoline's mutex is already locked.
>  		 */

[Severity: Low]
This isn't a bug, but since this multi-line comment is being modified,
should the opening /* be placed on its own line to match the modern
BPF subsystem comment style?

[ ... ]

>  	 * In both cases, direct_mutex is already locked. Use
> -	 * mutex_trylock(&tr->mutex) to avoid deadlock in race condition
> -	 * (something else is making changes to this same trampoline).
> +	 * mutex_trylock(select_trampoline_lock(tr)) to avoid deadlock in race =
condition
> +	 * (something else holds the same pool lock).
>  	 */
> -	if (!mutex_trylock(&tr->mutex)) {
> -		/* sleep 1 ms to make sure whatever holding tr->mutex makes
> -		 * some progress.
> +	if (!mutex_trylock(select_trampoline_lock(tr))) {

[Severity: High]
Could this shared lock pool cause unrelated probe registrations to spurious=
ly
fail with -EAGAIN?

If a tracing tool registers an ftrace function with FTRACE_OPS_FL_IPMODIFY,
ftrace calls the trampoline's ops_func callback.

If another unrelated BPF trampoline is concurrently being modified and
happens to hash to the same bucket in trampoline_locks, this mutex_trylock
will fail.

Since upstream callers do not retry on -EAGAIN, will this false sharing
lead to unpredictable probe attachment failures under load?

> +		/* sleep 1 ms to make sure whatever holding select_trampoline_lock(tr)
> +		 * makes some progress.
>  		 */
>  		msleep(1);
>  		return -EAGAIN;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527113951.4626=
5-5-jolsa@kernel.org?part=3D1
