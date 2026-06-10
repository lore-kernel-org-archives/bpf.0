Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D73DA7EC
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082965; cv=none; b=pQzNYLBz3phY8cbObTBC6dwaZUT4geMKTk2LJzAPUi/0I0KX8uNbi2W2qqX3uqIcbI0+G1cuKS05FmC896vOPeQ3JT6OG/Xt6EvCSukvTMWeHh0MzNNup/DYD0r3qIWBTVW7o/NRzgDG15Lbhz/PmPkBbzSQRImgnW56gCur2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082965; c=relaxed/simple;
	bh=6CO0HY7YhlQl9KxMOXSv5WRrkHsiGcoYnpQf06tiJ9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h20qVmKi0XylaWvIvShKogufhVcPw0l2S2X3OL08Btn/iqs/73iLhXGrI1am4DPRxMNk6rySpFLoUuKaA1ciNCTC5pkCbcF5Mv52cnFpPu19w4yxiKnQnk3KbG/q+i2CDxqtgi8Pe4xgMklp0dEdW6+xoFL6kLgWlRv3Gi2Of7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjM0EBgl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjM0EBgl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318C01F00893;
	Wed, 10 Jun 2026 09:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781082962;
	bh=S34aw0kzol5+K4s+86yn3CriLUKLxkE9W/n+Lat+hWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hjM0EBgl4iPNuKCzvvNSW52tTjDUu+woyNBhqCh9oQtF+13dxqnjGaCisBNQcFY6k
	 vvl81ON5AiC+FptIl134DYmpMFpgo1cKlgusnfphqyFSdvj36qrSiArzAKqEjgMkZc
	 EtP4cHh3/s1GvtRD+IQGnkERipTJLdcI3LAVhGbziLd4qrL6mpAFZV4PhZKnKrFXeq
	 bl5IXgzAAPY7pBMkdDPf8MWhs1x5bJpEfmt4AE08YFtuEg29AlN1Z2806LT+fUO8/p
	 TRk9h3DR1WDWjJLyDgyNQu4N7aeEj3sB8gYaZWHdUl2NmVQKN1SYndkOzzcGjMkWpU
	 VNyCjVELMK54g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] rqspinlock: Fix order in
 raw_res_spin_(un)lock_irq to allow schedule
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610090431.32427-1-gmonaco@redhat.com>
References: <20260610090431.32427-1-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 09:16:01 +0000
Message-Id: <20260610091602.318C01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] kernel/locking/locktorture.c ignores the return value of raw_res_s=
pin_lock and raw_res_spin_lock_irqsave, proceeding to modify shared state w=
ithout holding the lock on failure.
--

commit 92f88363aff605830b5600d6bc2a3ec351170c8e
Author: Gabriele Monaco <gmonaco@redhat.com>

rqspinlock: Fix order in raw_res_spin_(un)lock_irq to allow schedule

This commit fixes the preemption enabling order in the resilient spinlock
unlock macros. It ensures interrupts are enabled before preemption to
allow scheduling, maintaining consistency with other spinlock implementatio=
ns.

> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspi=
nlock.h
> index 151d267a496b3..4d46643f46cbc 100644
> --- a/include/asm-generic/rqspinlock.h
> +++ b/include/asm-generic/rqspinlock.h
> @@ -243,12 +243,20 @@ static __always_inline void res_spin_unlock(rqspinl=
ock_t *lock)
>  	({                                        \
>  		int __ret;                        \
>  		local_irq_save(flags);            \
> -		__ret =3D raw_res_spin_lock(lock);  \
> -		if (__ret)                        \
> +		preempt_disable();                \
> +		__ret =3D res_spin_lock(lock);      \
> +		if (__ret) {                      \
>  			local_irq_restore(flags); \
> +			preempt_enable();         \
> +		}                                 \
>  		__ret;                            \
>  	})
> =20
> -#define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlo=
ck(lock); local_irq_restore(flags); })
> +#define raw_res_spin_unlock_irqrestore(lock, flags) \
> +	({                                          \
> +		res_spin_unlock(lock);              \
> +		local_irq_restore(flags);           \
> +		preempt_enable();                   \
> +	})

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the resilient
spinlock changes, I noticed a pre-existing issue in the locktorture module.

Does locktorture correctly handle the return values from the resilient
spinlock API?

In kernel/locking/locktorture.c:torture_raw_res_spin_write_lock(), the
return value is discarded:

    raw_res_spin_lock(&rqspinlock);
    return 0;

Similarly, in torture_raw_res_spin_write_lock_irq():

    raw_res_spin_lock_irqsave(&rqspinlock, flags);
    cxt.cur_ops->flags =3D flags;
    return 0;

Since raw_res_spin_lock and raw_res_spin_lock_irqsave can fail and return
an error code like -EDEADLK or -ETIMEDOUT, ignoring the return value
allows the caller to proceed unlocked into the critical section.

When the torture thread later calls raw_res_spin_unlock(), it will cause
an unbalanced preempt_enable() because the failed lock acquisition path
already restored preemption.

Furthermore, it forcibly clears the lock state, which could unlock a lock
legitimately held by another thread, potentially causing lock state
corruption and panics.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610090431.3242=
7-1-gmonaco@redhat.com?part=3D1
