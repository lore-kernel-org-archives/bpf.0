Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248999;
	b=A1f3MR7/bGxhZxatWRcDIp89empZwe+tFNSWZTMCCEqzpshO6jkdlvIUa8m6pRjkPvdI
	 6UJvWvyQ14aHRLFbeKwGmsYPjbngue0OFkV1VfKhCHZbWbE9w/nQAGBPBdpLIrLHsoZ7o
	 mWq80H7iq9c+2KTS1/Ymlx/ifqgXuEJqIXMZVMWjYdSSH1LlV0zjdVMNLAtRLWiNu2axB
	 HxNmjblqNgB/BvB1mrQUbhsKDRqpr5i8I5YhuEM5TByS2E3qqOa2pp/wdmDky/SXouPtK
	 8St/p2m8gkGTejBBCef89IbS5G4r6LjIyUemNwawXWZuvOybd5Myr/b4PXPtxGR6YSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248999;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wr2Fne36ZmBZXjriwQr5YOpU5H4DUdnZ0gMvtliIg40=;
	b=BSPoYwVhryr8lXUOAlBI4rLtEX1M3KF9IcbK+eXL2P/VCUVKFZL7owt4tcEy5ObYyjFr
	 itVsC9ySN121Y16kTReYnJwBg1XzK6ANOQVkc5wvFMgxzOwmt6i4J41KncigKPJ5wtKEz
	 s44zUPblq2IB4zj1wgmSsGIX55rnQbGkW/rBeicQrR1toKcqPAZ+qn0vKtBlvbTqdH/J8
	 kY+ozBb3MVmVQ0PLnv4FEW1+i0/yzqnGdTKHD1AgV+7ZPP2Vix2xdushCjI1nJiFtFxpr
	 IV//ezvZ01pn4c4U4U4zwsiNRIrMW2JeHnNW0lLeCsDf0WF5a9hFB+B3Lv0zxp3nJJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W190IXs9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAFB606A33D
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W190IXs9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829071F0089F;
	Mon,  9 Nov 2026 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794248998;
	bh=Wr2Fne36ZmBZXjriwQr5YOpU5H4DUdnZ0gMvtliIg40=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=W190IXs9yNPggnOL1XzKUFSl2zSlRm4o8OFBfAQRXUaA3RIt/KsvXUJdGCmPGqjr1
	 tnuEjTwdPP/kdjvSpMr87mgl7ZLw52HhKIdPhtORYBT6P/k4criTvPtN40BVXnNBpM
	 JyQYJW3kVCBgQj5yS69kMdIYUnmpHIk/4QWV9wfvcqOud+DniFJA7Q7eC3GDwZcF4y
	 ksow6oBVJqU1jjrje6yyNt9C5e0cHPXkV+z3kLAAC2Tx0NaRfvtsVsj1CJBF5Fq8O8
	 gbsHfZkwJ/dW3OKZmnY+i4wDucGBfU9c19GuyoThiS1GX/jKTkyPSfXttqxFDWAeID
	 lyEFfcDOeFDiQ==
Message-ID: <sashiko-outbox-205415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/9] selftests/bpf: libarena: Make spinlock
 trylock match arena_spin_unlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>, bpf@vger.kernel.org
In-Reply-To: <20261109182055.7581-4-emil@etsalapatis.com>
References: <20261109182055.7581-1-emil@etsalapatis.com>
 <20261109182055.7581-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 18:29:58 +0000
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
- [Low] selftests/bpf: inconsistent return values in
  arena_spin_trylock() variants
--

commit 3875fb781c61e9ab8efcf22a434ad87a4732478e
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Make spinlock trylock match arena_spin_unlock

This commit updates arena_spin_trylock() to disable preemption on lock
acquisition, splits out arena_spin_trylock_raw() for the lock slowpath,
and adds arena_spin_trylock_irqsave().

> diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_=
lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> index 055b5892cb636..560ee18fd287f 100644
> --- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> +++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
> @@ -233,7 +233,26 @@ static __always_inline int arena_spin_trylock(arena_=
spinlock_t __arena *lock)
>  	if (unlikely(val))
>  		return 0;
> =20
> -	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VA=
L));
> +	bpf_preempt_disable();
> +	val =3D atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL);
> +	if (unlikely(!val))
> +		bpf_preempt_enable();
> +
> +	return val;
> +}

[ ... ]

> @@ -527,6 +546,17 @@ static __always_inline void arena_spin_unlock(arena_=
spinlock_t __arena *lock)
>  		(__ret);                                 \
>  	})
> =20
> +#define arena_spin_trylock_irqsave(lock, flags)			\
> +	({							\
> +		int __ret;					\
> +		bpf_local_irq_save(&(flags));			\
> +		__ret =3D arena_spin_trylock((lock)) ? 0 : -EBUSY;\
> +		if (__ret)					\
> +			bpf_local_irq_restore(&(flags)); 	\
> +		(__ret);                                 	\
> +	})

[Severity: Low]
Should arena_spin_trylock() and arena_spin_trylock_irqsave() use the same
return value convention?

arena_spin_trylock() returns 1 on success and 0 on failure, whereas
arena_spin_trylock_irqsave() (like arena_spin_lock() and
arena_spin_lock_irqsave()) returns 0 on success and -EBUSY on failure, so
callers switching between the two trylock variants have to invert the
check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109182055.7581=
-1-emil@etsalapatis.com?part=3D3
