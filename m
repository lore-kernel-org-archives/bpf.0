Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61AF394EBD
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906782; cv=none; b=ej41+VVbDqVAdCdFi5SzNtDe/zoeaeie4NxZmxn2UW2M3u/X6Rz+Ev6tYbxSA0NhBie/KFWD8W7/IBiAvcGZHnfgsXCRsYy8MPURls0deN8lyIoQCJH2juO+owanLrAylxdruC1p8YmsaFk5LZZxSiB7dltSFt6k4Pi5elDDlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906782; c=relaxed/simple;
	bh=IM4Xli8pZAZAI5ZKG11QJIwgpbguUD6R6eCKCI+kbw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EyBWROVrN21yJlPKBX59gQsnYCzPenWEBaK1QSsQAiU1f4qAbU/JDhFtqfYmjvr9niCbAe8piRZ/ChQW0u3bsOKyU0cEN+gIYYfVjHJGp+rXrSz92A3/skcKHNaJo0Kw/w0/0XBRnVIZJfQojAUbfDclGvQa/yQqnHsqRdtPhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp6ueAOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp6ueAOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42C61F00893;
	Mon,  8 Jun 2026 08:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780906776;
	bh=mQ+QoXggOV95fdEgg1zZaGOolfY4wK1jJ9RM95ehqAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sp6ueAOY4iwEB7csuEw/0KIQ1Dreyh++8JRM7N+yLT2OEhCd0coJiLKXV/OEhe14I
	 qLi1noYPAujBoHkrgNHNzcQZmdLO01wckl0KPjTcRiP4CghiteNWdyd4ti/1zM6LO9
	 pheOL5cRTy9A8u+PjO+g+SHL0SufLZH3NMwNVI8LmZcbSMuSHmS1uwXLpbNzR545ah
	 oLSTdmIyUyFUhXCBJHpP5Rsth/oP6JAsabx/207BNcyXDr7v3GUlHcK678xd82TMrc
	 o1BKoHeFUD97x46Qo/3WXMmXv0wtmqeDvbNMgFz6cVBfuDqEYTTFrvv9GrBzKAms5k
	 oqabonuHTQxfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/15] arm64: rqspinlock: Remove private copy of
 smp_cond_load_acquire_timewait()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608080440.127491-6-ankur.a.arora@oracle.com>
References: <20260608080440.127491-6-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:19:35 +0000
Message-Id: <20260608081935.E42C61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing ARM64's custom `res_smp_cond_load_acquire` before its rep=
lacement is available introduces a bisection hole. On systems without an ev=
ent stream, it causes infinite hangs in WFE, defeating the resilient spinlo=
ck's deadlock recovery. On systems with an event stream, it causes massive =
timeout delays due to inappropriate check amortization.
--

commit b25eaf0343b443d4006d903720137a3f04682c2c
Author: Ankur Arora <ankur.a.arora@oracle.com>

arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()

In preparation for defining smp_cond_load_acquire_timeout(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

> diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm=
/rqspinlock.h
> index 9ea0a74e58927..a385603436e98 100644
> --- a/arch/arm64/include/asm/rqspinlock.h
> +++ b/arch/arm64/include/asm/rqspinlock.h
> @@ -3,91 +3,6 @@
>  #define _ASM_RQSPINLOCK_H
> =20
>  #include <asm/barrier.h>
[ ... ]
> -#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v=
, c, 0, 1)
> -
>  #include <asm-generic/rqspinlock.h>

[Severity: High]
Does removing this macro early introduce a regression during bisection?

If this is removed before the new timeout API is merged, the code will
fallback to using smp_cond_load_acquire() to evaluate the timeout:

kernel/bpf/rqspinlock.c:resilient_queued_spin_lock_slowpath()
    ...
    res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, =
ret, _Q_LOCKED_MASK));
    ...

On arm64 systems lacking an architectural timer event stream, the wfe
instruction can hang indefinitely if the lock owner is deadlocked and makes
no stores.

Additionally, this fallback activates the default RES_CHECK_TIMEOUT
amortization, which only checks the time after 65,536 loop iterations:

kernel/bpf/rqspinlock.c:RES_CHECK_TIMEOUT
    #ifndef res_smp_cond_load_acquire
    #define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
        ({                                                            \
            if (!(ts).spin++)                                     \
                (ret) =3D check_timeout((lock), (mask), &(ts)); \

Even with an event stream waking the loop every ~100us, this can delay
deadlock detection by over 6.5 seconds.

It is noted that this regression is fixed later in the series by commit
701dbe31403b3077e33df6fca96fbbc319332c40 ('bpf/rqspinlock: Use
smp_cond_load_acquire_timeout()') and commit
c456c5b49c0e193a118eb1dabfe4657afd8809bb ('bpf/rqspinlock: switch
check_timeout() to a clock interface').

Could this cause bisection holes for anyone testing across this commit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608080440.1274=
91-1-ankur.a.arora@oracle.com?part=3D5
