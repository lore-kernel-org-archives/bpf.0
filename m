Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA8355F2A
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 05:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639036; cv=none; b=p7l7RgDmX1hOmmwSo9TlyCviE/88drTuvrnCIamzGNucvWrubNs17+f/N78GYriV+XAlxrA302m6WMxim1mwjX6DZ5xVPdNfxewRm4fausc9UoQel6tz1Icn6WtUY2K6bPvG5NRlmmgl120hk9/tXRopPGdYGHnrnoCbk7/hL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639036; c=relaxed/simple;
	bh=U6DkUbh+Kobb4CREKDAGc7PYBBWKkfEh0K3ohlvHNB4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FZ3LC08PCMLsUTg7REgtt5Ch2Idnq0KAEZf9GtX4JnXV80fsdVkqGi5E8JwlTrlNz0kPXkqBY3k1VjFImov6VI3dlWvZe2K3mnHAQaU2MVJYofb29/YTrbqJDH/n2xxldyF09KjmXOZGHzWuvoXcOmqi+2Ca21xCYyAjy6OeLRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3sNvlrr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3sNvlrr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF1A1F00893;
	Fri,  5 Jun 2026 05:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780639035;
	bh=q71YTY4F/v9OIF3YUci9B3mHKs2ETxZ3w6ex2Z1HSL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V3sNvlrrri4ExDED7F73iwwuqrK9837Ydc6+uCqImqRHR4/9Y1stLf7rxRg+SFmy7
	 xTil3whm8fYo3m1RwmFGOEuOUqp9Vkv1BoagIBD1WqYLtBjQsdys5uY1OGFrxwwv42
	 A/s0NatEMhet0EKfdq+rNR5G9+HcnCfVIv4OaXSMU/PWTx6lTe0geDvafxTqpyUeB0
	 3nrAa+kGzoEk62R7MZZkHcQGpVNaUIAmi3hSoi7ZStJTC99TjKI5TltlLplXPL5sMn
	 ASh1vJJC0b7/T5fFDHHHdqx1GxxZjV+UOEcPgWgnZAoLppB2+lC3UKx7nAggJFvLCQ
	 mcyONuexx88jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/13] locking: Switch to _irq_{disable,enable}()
 variants in cleanup guards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Boqun Feng" <boqun@kernel.org>
Cc: ojeda@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260605054128.5925-8-boqun@kernel.org>
References: <20260605054128.5925-8-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 05:57:14 +0000
Message-Id: <20260605055714.BDF1A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Switching `guard(raw_spinlock_irqsave)` and `guard(spinlock_irqsav=
e)` to use `_irq_disable()` variants breaks NMI-safety and will trigger WAR=
N splats and potential `preempt_count` corruption when used in NMI context.
--

commit 545c01b2eb680702b0d892d04382c1e8bb27b35f
Author: Boqun Feng <boqun@kernel.org>

locking: Switch to _irq_{disable,enable}() variants in cleanup guards

This commit modifies various irq disabling guards to use the
_irq_{disable,enable}() primitives instead of their previous variants.

Link: https://patch.msgid.link/20260121223933.1568682-17-lyude@redhat.com

> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index 3d405cc4c1218..799a8f7d27418 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h

[ ... ]

> @@ -592,14 +592,13 @@ DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_bh_try, __a=
cquires(_T), __releases(*(raw
>  #define class_raw_spinlock_bh_try_constructor(_T) WITH_LOCK_GUARD_1_ATTR=
S(raw_spinlock_bh_try, _T)
> =20
>  DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
> -		    raw_spin_lock_irqsave(_T->lock, _T->flags),
> -		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
> -		    unsigned long flags)
> +		    raw_spin_lock_irq_disable(_T->lock),
> +		    raw_spin_unlock_irq_enable(_T->lock))

[Severity: High]
Does this change break NMI-safety for users of guard(raw_spinlock_irqsave)?

The raw_spin_lock_irqsave primitive relies exclusively on CPU-local hardware
flag saving, which makes it safe for use in any context, including NMIs.

By switching to raw_spin_lock_irq_disable, this completely bypasses local
flags saving and relies on local_interrupt_disable() under the hood.

Because local_interrupt_disable() manipulates the task's preempt_count via
hardirq_disable_enter(), it isn't safe in NMI context and will trigger a
WARN_ON_ONCE(in_nmi()) splat and potential preempt_count corruption.

>  DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave, __acquires(_T), __relea=
ses(*(raw_spinlock_t **)_T))
>  #define class_raw_spinlock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATT=
RS(raw_spinlock_irqsave, _T)

[ ... ]

> @@ -640,14 +639,13 @@ DECLARE_LOCK_GUARD_1_ATTRS(spinlock_bh_try, __acqui=
res(_T), __releases(*(spinloc
>  #define class_spinlock_bh_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(sp=
inlock_bh_try, _T)
> =20
>  DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
> -		    spin_lock_irqsave(_T->lock, _T->flags),
> -		    spin_unlock_irqrestore(_T->lock, _T->flags),
> -		    unsigned long flags)
> +		    spin_lock_irq_disable(_T->lock),
> +		    spin_unlock_irq_enable(_T->lock))

[Severity: High]
Will this also cause preempt_count corruption and WARN splats in NMI context
for guard(spinlock_irqsave)?

Similar to the raw_spinlock_irqsave change above, moving away from the true
irqsave mechanism violates the contract that irqsave constructs are entirely
context-agnostic.

>  DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irqsave, __acquires(_T), __releases(=
*(spinlock_t **)_T))
>  #define class_spinlock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(s=
pinlock_irqsave, _T)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605054128.5925=
-1-boqun@kernel.org?part=3D7
