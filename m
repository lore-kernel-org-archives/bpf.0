Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130577;
	b=NBtB7lkd3fIny+YB+LmKzMUwDSGerQCr9yg5khuES0i+f9RjA6WNpGM1P9DrkrLKe+JY
	 MgyGm8scs/jZkZxPA5nzT1awyzcv/pTS/2Iv66ov2Rn3xX7EbSyoSIp5WP/lZ2pGaA5vC
	 vqhdozvKc8LG/pz0cm/WkLSSwZ/vCdq1Xd1mTAqDz2Rq3vZ6/ZTD4DNWMwA2Qve2ErkFR
	 tuOZOgZN0wBhrr5859dAhlJotlku032VYz1qwJSx0QtH06WVogO+WtFLYe+JAr4kTZu6K
	 t/+g/AzO/4IH7ZC3MJTAscb3HfTm8+ekCBXMIcfkE1JG0bctqukMjKZIwq0YDcHDQSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=ilRNfn6/bKD7JKWWGxKTwYHt8GP2d4K6GHS01Pj1/t8=;
	b=GEjHqjfbdv9eb+Mp/Ff3sQPyu8szea2KoL/0lfzr7HFx/eYRj4hVc2kkJgnTdqhXxQ8z
	 scxBZavnUozLKo/dTX7icLyVPZpHTkvlNeMA8hMlPtRUWmyJ7nAWZZo5ItCxYwO8WGRvI
	 gh0c02KERTelll2Ms32skcBCapkwYL5XQrBwEE1rSr27IJKRjVqWSYYuXN/SNNPQfPvun
	 OJpT1xeioBX+vTLKKAnzFre+4qQNh8fCac/ylJLHpiuhz06zLCjv7uyR3843GEEZRvGlo
	 x1UsMvV2fsnKJ+zx3a0auztt6CailOKaTvr53TvhhmKBr+4MP7JmT1iD0Lkj4n+R+4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f8jWOja9;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA40606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CA40606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f8jWOja9
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so295514a91.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793130576; x=1793735376; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ilRNfn6/bKD7JKWWGxKTwYHt8GP2d4K6GHS01Pj1/t8=;
        b=f8jWOja99rTif1wBYGxto9Q5zo3lubHcO/TNf7UXlG0Lm4HVNdEgxv6z+GV3B0cK45
         3IewMoSHH414h7qh4fFruNakMzVM6IsrcJhKOHKeYc1y/iSKAWhGq+eEhq92yly2NRCW
         BsO+I3uZMhPuZfeysu0nh5LkMoVeHmo6W82u0BT0qSMRn+oL4CCFln2xL2lCPi/dtGPW
         euZ+FUtJdFmj6uOhG9BG8MPmCXcFkresznAo5Y9qIs5hYvEFDBOhVcJotIsb2eeyJTFz
         vM1co1i92SR4+/vo8hWxoseajN7xznj65inySDpoFYE598XXKWU+2A7p2k4+GmM9qvMX
         nXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130576; x=1793735376;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ilRNfn6/bKD7JKWWGxKTwYHt8GP2d4K6GHS01Pj1/t8=;
        b=pGVf2pj0XpGNuTZHcwQWQD4CYzgvhZ8zhQSbCxvuPOxIrtfRpU1f/cU2ZhefL+vrZc
         6VwfuIEdDunuBEL0VzdBLUStk9Uo6V6CcLYFBL6QdiMveAaiNkz/E2tMMqpT0iIUEavU
         HOGfdzOiIlfvll2Fj3EGfmykzjWQ92/1PQ8Y+LUQzc/MyNanceG0VI7gOJrNG/gWHB5v
         wIgstWVVd13z+I8ORrTLRe2ie7Z9hWts9KCzWa4fnGM9NaMAWmbkIGu3nrcr6NoyzAk9
         KqKp7KghY6jM1as85uctmsr7ZlgZi7egomBx52lHmIScWOy8j5S2dhraCznoqL7QPi2B
         YpWw==
X-Forwarded-Encrypted: i=1; AKwUvBw8TegKXriPwwNGoeaMIYvm8vA0ilVAVmAj9aN947/D87Dp/c80I87ggI1jkiVWrlluR04=@vger.kernel.org
X-Gm-Message-State: AFq9FYIY+IrBtApj/q9YM1aSJhTroQf6ar61FWjJ0SnbKy3KRDwptYTv
	83FKHuXoq/DByWwDK1k5ruE0C8zcPlIdRde7wHW8jC+OAAh3jdCq7pMC
X-Gm-Gg: AYBFou1Lelrtk0V+m2R0aGcodlc/u/U+fqKgpwJ/E+5kL8CGnvZZwR7FjxpJWW20dX9
	D+Q8jOAVJvwE0eAKCySP4Dm+w2GGgKn3DTl8tguKXCbJz7aI/i7ld52fguBuW2CCp1AP+uPk58F
	794mi7ic3XBbAf6icQubwkqhfJNnns7keTi0MinHHSWIiScUBw2Dphg03/E92LDcLJZK+Cjwj2/
	UCWKy/66SOgMsQ+owFZ1OpH409ZINnQ2GqK0+c4L+xIjVucLUfaV9zEz4EqfOFMD3B5OAOjeaUw
	3Q5EQMRlkPmqufgguQjB7km7NyMVgxRmmKItQtA9LLE/sMsXV4MmXpUP1wyArZD6G21FUmJ2PHg
	lZfj5JLWLtUz/36pH/FZ/+lNZTSzOnngSYZ+yPDfRkbXHok9AZstYjIZL7bTGwm4xztmG5NgIsG
	PbDGLoUbuKcedQpa6nsKWPsAQ8PNsZFUicPig4+txfG/6yl3yVwh985sZyjYBHN+J9uvzuzCFFs
	f+SS/U0mzaQR4JQZzmN6LKoCmUVDDyhbPlIhmcr4E2Q1l9bBucVlf2U0YVM/a2nASK0h+J6t7x3
	wOiMF6TcWkRYmFbG5tAn0IirFSG+33daFIkMRCP1z2Y7iGywrAGlmTnzM2wE
X-Received: by 2002:a17:90b:54c5:b0:3ac:a204:aa27 with SMTP id 98e67ed59e1d1-3ae58195369mr74040a91.66.1793130576146;
        Tue, 27 Oct 2026 12:49:36 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae57a1aacbsm127797a91.4.2026.10.27.12.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 12:49:35 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 19:49:35 +0000
Message-Id: <DMFVQMBXF65Z.11AGYWHTHCP4G@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] selftests/bpf: libarena: Handle NMI
 reentrancy
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
In-Reply-To: <20261023002056.6647-5-emil@etsalapatis.com>
References: <20261023002056.6647-1-emil@etsalapatis.com> <20261023002056.6647-5-emil@etsalapatis.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Oct 22, 2026 at 05:20 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> An NMI can interrupt the buddy allocator while it holds the buddy lock, so
> code running in NMI context must not take that lock.
>
> Allow an allocation from NMI context only when the local cache can satisfy
> it without taking the buddy lock.

can we take the buddy and transfer locks with arena_spin_trylock()
in NMI instead ?
It succeeds only when the lock has no owner and no waiters, so it's safe
in NMI. Every caller handles a lock failure already.

With this patch nothing refills the caches in NMI, and buddy_cache_init()
leaves them empty. A prog that runs only in NMI gets NULL from every
buddy_alloc().

With trylock an empty cache gets a refill and a full cache spills.
When trylock fails, buddy_alloc() returns NULL and buddy_free() defers
the object.
Then bpf_in_nmi() is in one place instead of five by the end of the
series, and no need for buddy_deferred_free_start_bulk().

Something like this (not even compile tested):

static __always_inline int buddy_spin_lock(arena_spinlock_t __arena *lock)
{
	if (!bpf_in_nmi())
		return arena_spin_lock(lock);

	/* NMI could have interrupted the owner of the lock on this cpu */
	bpf_preempt_disable();
	if (arena_spin_trylock(lock))
		return 0;
	bpf_preempt_enable();

	return -EBUSY;
}

#define buddy_spin_lock_irqsave(lock, flags)			\
	({							\
		int __ret;					\
		bpf_local_irq_save(&(flags));			\
		__ret = buddy_spin_lock(lock);			\
		if (__ret)					\
			bpf_local_irq_restore(&(flags));	\
		(__ret);					\
	})

#define buddy_lock(buddy, flags) buddy_spin_lock_irqsave(&(buddy)->lock, flags)

and in buddy_free():

	ret = buddy_lock(buddy, flags);
	if (ret) {
		buddy_deferred_free_start(buddy, addr);
		return 0;
	}

[...]

> +	do {
> +		head = buddy->deferred_free;
> +		if (!head)
> +			break;
> +		old = head;
> +
> +		/*
> +		 * The cmpxchg is safe because we never pop from the list
> +		 * without holding the buddy lock. The next pointer of
> +		 * the element then cannot have been gotten invalidated.
> +		 */
> +
> +	} while (cmpxchg((void __arena * __arena *)&buddy->deferred_free,
> +			 old, NULL) != old && can_loop);

Also one __sync_lock_test_and_set() takes the whole list.
No need for the loop.
