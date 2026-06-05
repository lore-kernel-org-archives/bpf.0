Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315272BEC27
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639460; cv=none; b=nYl9Za9cgSBi4KP5IaUeIdOkUy8bFjigfY8/hHYTev80aWJ859hruefAb/w2rK2juPaF0VT63YjScZuaN1acMW5KzIrflEpIOW3kinwW9V+LtFzLFEXJCgCgJKjRN3XounP1FnuaRDt3hXS90THf+Tcbhq1uXBuhIfu9TUIqjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639460; c=relaxed/simple;
	bh=NTRr2HptOcHETTGWQTshKpSFJPOy4yrGMvQfhlXenKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=caB9+Tp3BGyuxpzEdRzx1SFTKXMXUzOeywKzvDqMNcjR7NxlwzT5ql0lsMLaDhnBYcYGfC/9nvPvHynctyu+D7Y7gzOaIpS8xsAitO/BqDGjRRYNPJ9R0hbnq+P+s8oLed2SzogRe+f+Oy22xnf+ns0hextfNjd7AaTsv3nbDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGHYYMtq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGHYYMtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F861F00893;
	Fri,  5 Jun 2026 06:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780639458;
	bh=ZrmvClUKtRSXZWgMp2N2mT/TOiiffArCNJgbehX1Gwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bGHYYMtqTlL39HvMdUprgAL2fRGofgxYhtqAkjcThuWyW+GjlvDDT3yDcTsnWSX/S
	 SH29zsUP6+uhv7QFdX7yEpux/OyMZTdEf314iVEXxCNtndrT3RalBtGgpWcCk4OZRn
	 ftu+sGQb+XggagKscI+4e2TAkaHEe7l39JO8dMHIVBGDSBLLeb5/HwM9IZZv8JdeDO
	 o8qlPgFcLm0XDH4NYA4ZrrPK05Pev/oHbsyfuDnPliUELQ150Wjr/KlLrKhvqG9kXG
	 RdhWMb64SljYc8ZIPdmVkC1LBCPom4ywTYFg29CaYy+V8SDckF1/vYvOKSy+JM8Uz4
	 i4EQrf0Ox4tKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/13] irq: Optimize reschedule check in
 local_interrupt_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Boqun Feng" <boqun@kernel.org>
Cc: ojeda@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260605054128.5925-14-boqun@kernel.org>
References: <20260605054128.5925-14-boqun@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:04:18 +0000
Message-Id: <20260605060418.94F861F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Data race in `__preempt_count_add_return` causes lost wakeups on A=
RM64
--

commit c3bbe9e483f96a8dad6049a0192dc87491aed263
Author: Boqun Feng <boqun@kernel.org>

irq: Optimize reschedule check in local_interrupt_enable()

This patch optimizes local_interrupt_enable() by avoiding a re-read of
the preempt count. It modifies __preempt_count_{add,sub}_return() to
return unsigned long, allowing it to capture and return the
PREEMPT_NEED_RESCHED bit for reschedule checks.

> diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/pr=
eempt.h
> index 0dd8221d1bef7..e9f597d874134 100644
> --- a/arch/arm64/include/asm/preempt.h
> +++ b/arch/arm64/include/asm/preempt.h

[ ... ]

> @@ -55,20 +55,20 @@ static inline void __preempt_count_sub(int val)
>  	WRITE_ONCE(current_thread_info()->preempt.count, pc);
>  }
> =20
> -static inline int __preempt_count_add_return(int val)
> +static inline unsigned long __preempt_count_add_return(int val)
>  {
> -	u32 pc =3D READ_ONCE(current_thread_info()->preempt.count);
> +	u64 pc =3D READ_ONCE(current_thread_info()->preempt_count);
>  	pc +=3D val;
> -	WRITE_ONCE(current_thread_info()->preempt.count, pc);

[Severity: High]
Does this code introduce a regression where the need_resched flag can be
clobbered, resulting in a lost wakeup?

On ARM64, the 64-bit preempt_count union contains both the 32-bit count and
the 32-bit need_resched flag. Changing this to a non-atomic 64-bit read and
write seems like it might race with hardware interrupts.

For instance, when local_interrupt_disable() runs, it calls into
__preempt_count_add_return() via hardirq_disable_enter() before actually
disabling hardware interrupts:

include/linux/interrupt_rc.h:local_interrupt_disable() {
    ...
    new_count =3D hardirq_disable_enter();
    if (!new_count) {
        ...
        raw_local_irq_save(flags);
}

Because hardware interrupts are still fully enabled during this operation, =
if
an interrupt fires exactly between the 64-bit READ_ONCE() and WRITE_ONCE(),
and the handler wakes up a task (updating need_resched), wouldn't this
WRITE_ONCE() restore the stale need_resched value and lose the wakeup?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605054128.5925=
-1-boqun@kernel.org?part=3D13
