Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043538B7D5
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087496; cv=none; b=VKFzjYR2vvkIlvMnXx8Y4R5CaedwsP/fD8yVYYaUITOcKoDRuZdRJ1No6LgoUYo3Ycv+cD7tod9SMM6hT5t7+nxtr8VnN4eIf+TR4flcQNip6nIUw+NuIusCZzhIDo/g7unzEeu+sGIQfJQHQOj5TwqWVyAJolkS/pZwM6JKX1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087496; c=relaxed/simple;
	bh=XbSYp7JQkZVOB9T33+JNyFC3UuskBxLulRs78wndIbA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YPttHwx15bCSkgYjkISjbGcGXfCmGu7AU7LpZ4BwqHNREihDz2MlyFkJU09CJKMC/t8e53pBLw25z7xI5s99MgJQZLSMJAnwM5U+HPjOymmm/NwjldZOdHiCuz8Ey5QNSxPw4SgZR3Wd8vutck5mlcn1BOP1VBoFR9KWfBI07y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag47dxCd; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag47dxCd"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-45ef616daf6so6073541f8f.3
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 03:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781087493; x=1781692293; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IyIE/9EwwGwBSMypNHlFqQrU/upNBUE0sY83YzNexo=;
        b=ag47dxCdtRCoiGebrGQ3S0T3qr4vl/v9qi2eOapgbEHymkTGMQVhAuEn6t+veXoWKQ
         4IwtCoJefc/lT86aBbyidvxjJqlq3g7GibTRNRBh6j7ATgTn3xZpvnKYX7Fq7IrtrPQa
         QlGmRVAEkeBFKK9oyxLy7Tje+0Ro8xclZi969tH/Q5FVFH0WCbSVCJ3TJ6M//ierAEzt
         y0m5QRlK7+VIZwJhwD3mtbLkykbznfy8TQOI4tea0B8uR/6nd2Mp8RAs30JmSaIXIBbB
         sJKlTUk1m0m/fAvOp6tYDn7mLAzUy/L0ppGEm1A4DYUNB4GjorUe3UX0htKR/EVvldOL
         40aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781087493; x=1781692293;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1IyIE/9EwwGwBSMypNHlFqQrU/upNBUE0sY83YzNexo=;
        b=WM1SnZ4rl8aBd8PUhmNOkrw4w539lJcHESojsUlYYahBQl29z6hYIdDsW/w0zDGJbZ
         ZcZA7BZRiiU/SHzcRaPN+cQSb0Tg46xi9f7rf39sSqS/YUsqRT6X7BHX8r4bIDRQ6OiW
         FheC754StyF6xDci0gYlfa4lhwnMQGcH8SRGggC0pTzDwFtDDFm5cLyyirmf56NRwvEv
         prvlAi8A0rgg7bryiGEiiFhXtwRDa70pxmQMbLAVf5DeDB48vy4ujVpTo19Y/GuYOd9K
         slO3hQ1I0M11hFj2C7Eojd2bkCnhmeOM9a91H7FJp1UOC69XDApxPfycnO0s3Y/ocg2k
         7drg==
X-Gm-Message-State: AOJu0Yx+AdKOlRwKQrvgLu9fFmCv6jDWV71uwq5TwkqG1y5FGMyQUzP6
	vaucPycLs+PbqQKm46cVT+6RYbn27ni6f4aZLph7ZAh1rRuIQ2jFx7LP5WkNwd2x
X-Gm-Gg: Acq92OFNU4eT+Q/TOKz634Kc8z8ekPdwczmLMflxR7EH0ztGbF521s1r4ldiijJir4W
	91K9L5aCQQCnxV+7FAmNcMogMb0T6g1QlYtWkhFhf4bRkyl235bsWU4mmRQP6ok2LT36+tB2F3g
	ijLhpWZWA5xb7aBoTiAR5mZ5LPuTZNT9d2DxV5YVIzayI0G4/XOpvlo83g3SJtdnq04rV85gkIf
	frcFZj2FsKYfDRiIOpA5xCm2Q++SSrXjKaUUKk2g5Px5+xu1mwLr7wdT/eCkzno3n4xYrSBITHP
	qnoDJGFBErLVgJslTYFw4CJCqcrA3qlgKuetzQNnuJZRt1D11ur9eX/lRjsd2lEUubm+CLCqRQl
	pXuZVQmfVjBsCxbXseTvOmZBSM/Z+JzO8KkSR4DdXusEjNVx7+Npd/vT20IqQuFqwQjzHEidtRb
	CKaPHInABxoYfYrdTqyZalA8ZziwqEp5wloQ1MajIx2dMxyGBBv6G4ZfT8+RX5ScqIZZOSEl+Il
	cXvEGeiIYFnGDfMOFLARx88HaJt89M/WVMq7CTJoCUyKQWLXMNthFeydcuobcO/dkRzl8z0oqiv
X-Received: by 2002:adf:e00a:0:20b0:43d:6fb7:fedb with SMTP id ffacd0b85a97d-46030623307mr26149361f8f.36.1781087492616;
        Wed, 10 Jun 2026 03:31:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm124308489f8f.27.2026.06.10.03.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 03:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 12:31:31 +0200
Message-Id: <DJ5ATM1R9KGE.18HBGC4MWTYU2@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] rqspinlock: Fix order in
 raw_res_spin_(un)lock_irq to allow schedule
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Gabriele Monaco"
 <gmonaco@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260610090431.32427-1-gmonaco@redhat.com>
 <20260610091602.318C01F00893@smtp.kernel.org>
In-Reply-To: <20260610091602.318C01F00893@smtp.kernel.org>

On Wed Jun 10, 2026 at 11:16 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] kernel/locking/locktorture.c ignores the return value of raw_res=
_spin_lock and raw_res_spin_lock_irqsave, proceeding to modify shared state=
 without holding the lock on failure.
> --
>
> commit 92f88363aff605830b5600d6bc2a3ec351170c8e
> Author: Gabriele Monaco <gmonaco@redhat.com>
>
> rqspinlock: Fix order in raw_res_spin_(un)lock_irq to allow schedule
>
> This commit fixes the preemption enabling order in the resilient spinlock
> unlock macros. It ensures interrupts are enabled before preemption to
> allow scheduling, maintaining consistency with other spinlock implementat=
ions.
>
>> diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqsp=
inlock.h
>> index 151d267a496b3..4d46643f46cbc 100644
>> --- a/include/asm-generic/rqspinlock.h
>> +++ b/include/asm-generic/rqspinlock.h
>> @@ -243,12 +243,20 @@ static __always_inline void res_spin_unlock(rqspin=
lock_t *lock)
>>  	({                                        \
>>  		int __ret;                        \
>>  		local_irq_save(flags);            \
>> -		__ret =3D raw_res_spin_lock(lock);  \
>> -		if (__ret)                        \
>> +		preempt_disable();                \
>> +		__ret =3D res_spin_lock(lock);      \
>> +		if (__ret) {                      \
>>  			local_irq_restore(flags); \
>> +			preempt_enable();         \
>> +		}                                 \
>>  		__ret;                            \
>>  	})
>>
>> -#define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unl=
ock(lock); local_irq_restore(flags); })
>> +#define raw_res_spin_unlock_irqrestore(lock, flags) \
>> +	({                                          \
>> +		res_spin_unlock(lock);              \
>> +		local_irq_restore(flags);           \
>> +		preempt_enable();                   \
>> +	})
>
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing the resili=
ent
> spinlock changes, I noticed a pre-existing issue in the locktorture modul=
e.
>
> Does locktorture correctly handle the return values from the resilient
> spinlock API?
>
> In kernel/locking/locktorture.c:torture_raw_res_spin_write_lock(), the
> return value is discarded:
>
>     raw_res_spin_lock(&rqspinlock);
>     return 0;
>
> Similarly, in torture_raw_res_spin_write_lock_irq():
>
>     raw_res_spin_lock_irqsave(&rqspinlock, flags);
>     cxt.cur_ops->flags =3D flags;
>     return 0;
>
> Since raw_res_spin_lock and raw_res_spin_lock_irqsave can fail and return
> an error code like -EDEADLK or -ETIMEDOUT, ignoring the return value
> allows the caller to proceed unlocked into the critical section.
>
> When the torture thread later calls raw_res_spin_unlock(), it will cause
> an unbalanced preempt_enable() because the failed lock acquisition path
> already restored preemption.
>
> Furthermore, it forcibly clears the lock state, which could unlock a lock
> legitimately held by another thread, potentially causing lock state
> corruption and panics.

In case of locktorture, error checking is skipped because it does not exerc=
ise
deadlocks, it's only for locking scalability and correctness checks.

