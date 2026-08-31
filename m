Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1733AB47A
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216474; cv=none; b=QT0pta4tVIYoWqaFk5ooi31TGxtlCelbpA+YekWSAkAPNz5wpi/Q76nJcrUksixMa/diWG3dvVX+DqX92jeYs4IMLIIe3t3ou+QDxwCOhAOafOB+gUZCicms7EDkJuJecDnVNGmE5Zs147Ml46ITPF/9Dhli78lBKJiZR2Z1nco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216474; c=relaxed/simple;
	bh=LoqyhyZmbPgqYnpWvZD+wy/lmWGK75/la3S4bDBoUbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uo0Ar82VpVH8IHQLuiUtaQd68eh9b76ZaI6rZ3eXTxE59786IPvQWRRITNzO/5oLV+9U0qQsUG7djoXfC+DWPvKf37zSns4QTk8xsJTNlz86dIUMW6tTCcOnN3e9dcX5hkRcDz7YNnQjvg7+nMiK0GotSCgrThquU0fy3Xs6kFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6f5S4Ku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6f5S4Ku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF4F1F000E9;
	Mon, 31 Aug 2026 22:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788216472;
	bh=G2TCEVGslRGFcOft4g7V/ZrQMX6SIfwZPFQdqFyveIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C6f5S4KuTLPf3Fn1IU3R+7YZuqSAtrCSIdC5zMqwrABWXUJM2pHvw/qeOSX34Mlmt
	 fUP/Mx5rKiccoB6oTvt8OAqdE0q3QeiVUFHenIA3Ji4sMi2k/uWI+2wby6S4ChFaxA
	 hwyZfDq7taOkHyXjwIGU8U9p+22zN3QHG/sQ07o3DBJQKhedJ3KBruZIg8+bGikBs8
	 vNKLu22Q3uru0QRHJRb0LcxB64TUTRiUGAuCOMKT9i5MIyJZ5cLsjoRV+EO1KN6brS
	 xnxNgLtdVoagROBl1Wp602nLSkp6DzryanX4RZy5CA1MUP3HAqGJQfPxegwl01BbqE
	 fx4f2/mzxTo4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 07/16] atomic: Add atomic_cond_read_*_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260831202251.305046-8-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-8-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:47:52 +0000
Message-Id: <20260831224752.8AF4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `atomic64_cond_read_*_timeout` uses non-atomic torn reads on 32-bi=
t platforms.
--

commit 973deb7b74ff51cb72dbcdb0e4ee3a04554587b4
Author: Ankur Arora <ankur.a.arora@oracle.com>

atomic: Add atomic_cond_read_*_timeout()

This commit adds atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces. It also
adds a short description for the atomic_cond_read_{relaxed,acquire}(), and
the atomic_cond_read_{relaxed,acquire}_timeout() interfaces.

> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 8dd57c3a99e9b..5bcb86e077845 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
[ ... ]
> @@ -31,6 +31,16 @@
>  #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->cou=
nter, (c))
>  #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->cou=
nter, (c))
> =20
> +#define atomic_cond_read_acquire_timeout(v, c, e, t) \
> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
> +#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
> +
> +#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))

[Severity: High]
This is a pre-existing issue, but does this code result in non-atomic torn
reads on 32-bit platforms?

When a caller uses atomic64_cond_read_acquire_timeout() or
atomic64_cond_read_relaxed_timeout() on a 32-bit architecture using
CONFIG_GENERIC_ATOMIC64, smp_cond_load_* executes a lockless
READ_ONCE(&(v)->counter). This causes the compiler to emit two 32-bit loads.

If generic_atomic64_add() or an interrupt handler modifies the value under a
spinlock concurrently, the read can tear. Evaluating loop conditions against
this corrupted memory could lead to spurious wakeups and returning torn,
inconsistent 64-bit values to the caller, silently breaking synchronization
logic.

The patch replicates this pre-existing flaw from atomic64_cond_read_acquire=
()
into the new timeout variants rather than utilizing the lock-protected
atomic64_read().

> +#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
> +	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831202251.3050=
46-1-ankur.a.arora@oracle.com?part=3D7
