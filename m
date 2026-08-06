Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CB03E49F4
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006977; cv=none; b=GrKZl/NTaAHpvoUdITEFezxQ3NFQ56h/Rtyho9zyVNmmhNiXTlnQ3g/NwJL0Jyl1dyl8Q0yPr8GEVq4uXW/3U77cN4jWbAiIJlNoN4Birz0ArLG4U5PkGXuMX7GUaaeUY8TXPg8VATV5KDvAow4NlNsXbsi/0MO+cOfeyQf1T0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006977; c=relaxed/simple;
	bh=3s7nZgauonP90y3XHlMSi//fsrT+8vGp9ui+7AsfmNo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AToK+SadR+id2v5cWn6GQkftwEBVVJO4x7q28zJwvc66GCbdln6DkUQGxxlZTLWcG5PzuqURFhIGmp15sK2Axiw5Otp8lGknh/1G/3CUDo5g93XNaTAmSBZrPY+uBoAyMEj6/bYjgZ8Sq77N4TXDBNU9tO615y6Q8diSlV9UGcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWXR62Yc; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWXR62Yc"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47f9c6bc99eso431223f8f.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786006974; x=1786611774; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jx5sb/EpGz46xxvuSXGfSNWXkbsZBvc4m4kHk10LMUw=;
        b=hWXR62YcbyXFrsG8cN6kCUug/CnwdH8Daf1heqXOGPpDwI4r8pZBW6CYXonmjDgp7v
         YMmLdtjWGHHrBAcLwAM2oY3QfgUSYdzMlPEBfGj5AUyDYmAj1LK85FOy02ZF5VUTJugm
         o97ifH6C+T+esrRFQMSLwEnGzsq0Bf9pOTMOds6AS7MZT+77/vGXFZAAbQ/nBWfTjsMy
         Ez01hMFARHSYBAZkRgjJ9sH2+60OMlsA3WvmCZtc3xZeEjpNMmQm3XCPMW9y3r9o8a2U
         qeDul3/q2nJqtOQ/C2ik9XLe0nubqQggR9dAiudnamMGD5bEzPyaSL73SqnaCdVODvf3
         TyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786006974; x=1786611774;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jx5sb/EpGz46xxvuSXGfSNWXkbsZBvc4m4kHk10LMUw=;
        b=XZg+KEQprFGTB9tCBRK9tnSKIo1BtbKz/z4xm3evv5+Z8jMGzSJjo6ndrKa/JtlRPf
         Q16jQl7zsY3tSX0Xrkw1QKbjDctojEkuMeP1ZO1CWAmLwKkOE2YmX+xMFLpFYXSuSCd5
         UMQXiMiUrc+dQPuejVcECGN2JnOCFHeAZt6YKFo9HMQPhEU/K3sYe/nu9uJOjG/qlTGn
         du4UeZxQy7UHHbrm08c6KikVao44Z2/o28s+F+MOalidsC3pijtaoggQsXfqp8GnnvGJ
         ZOilwGEDrYrzhRY8tB9gmE6poFJ833S+DZr28EjmfB00sV4GiWeEg6/RLXHmN3CB/Fnb
         u1rQ==
X-Forwarded-Encrypted: i=1; AHgh+RqkIZ2yfahbsr0+X/5lSXrUvNeLys598sZha92P4d77SBX+BGTd1ZEAYxJirjLu/gzgKVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7rUFTZ0K7rKyGJw85KeoeA5UI2P9eKrW9yishCcrUKI4DXKaW
	fOuf/ZqjEHVmq1kfphUyElqHrOfaoLc5RKUQkMLN28QfP37lSI7OvyAY
X-Gm-Gg: AR+sD13jFydc2nlwzjPD9MF5UY59FCHMHCCqgplrl9fzBWvmmxoj3A3bv6jMkyxiV4k
	Vpi3A+odGL8GbxWLlIgvaMoDlSUMGN5blNt6LkRUoEv8XnAdktmzqqDFQN1ive5xCCz7nDVwTPw
	+WcIWVsxyhFZ/zRpY7KMUOr9r/jRMYhj7/2yJKrdq+SFC+hYPFuvwvcjoYlnbIjUwqgarA9+xuM
	4kjlzjn189GwXK75UXTwij7C4ZRXWY3RU3eQIuYAvZ6sbtZmG7J9Viqkh6VutPDgtNCIMk+H8TM
	ACzhUuRGYGotrmo5GfgmlYP46gOwo97La/gjyRunT7bHTySGQgGtjEbDJbxtwKw4e3b+otri8HP
	jSdEoqdmGegOeyw9pF8stjw8l3pqbGE1gr+mE1J7ACQF7KLdLCfASQG1/0BrV0lQj3XcEUWIZmi
	A6yv+fXv3/c7yUmNGxoy1bPbBK81ETLiK1hgSQhngF9aT53AA+7FrZAkQFinyucUTDb1gQzJpmw
	HZ0A9GOMoUlLUrEnVslUfjQuIOQT3Z2y+MqTgfwdpq3Rk6ggXsXZh4YUOuQ4KQp/efuXdZ1UjiS
	zxRJXMBUmRgUo4cHeAxalgjzVRCrOFhsBIyq6A==
X-Received: by 2002:a5d:67cc:0:b0:47f:6dcb:3737 with SMTP id ffacd0b85a97d-47fec64be03mr15368560f8f.29.1786006974116;
        Thu, 06 Aug 2026 02:02:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b250e5sm4676930f8f.27.2026.08.06.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 11:02:52 +0200
Message-Id: <DKHQMSFIMQHR.1JSO9S9ZSZ5PY@gmail.com>
Cc: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>, "Puranjay
 Mohan" <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Invalidate RCU pointers after
 final spin unlock
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>, <paulmck@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260803112615.3362122-1-dingning04@gmail.com>
 <m2zez2i2hp.fsf@kernel.org>
 <aba45a18-fb2f-4993-868e-976723b2e017@paulmck-laptop>
 <CAJP4iuthyUKs5wYMpjGLyQKW8syiHm6pub+9rMMo7wsw-w6G+Q@mail.gmail.com>
In-Reply-To: <CAJP4iuthyUKs5wYMpjGLyQKW8syiHm6pub+9rMMo7wsw-w6G+Q@mail.gmail.com>

On Wed Aug 5, 2026 at 9:00 AM CEST, Ning Ding wrote:
>> > 1. Disabling preemption
>> > 2. Disabling bottom halves
>> > 3. Disabling interrupts
>> > 4. Acquiring a spin lock
>> >
>> > As you are doing it for 4, can you also do it for 1 and 3? I don't thi=
nk
>> > BPF can disable bottom halves right now.
>
> Hi, I have written the follow-up patch to account for
> preemption-disabled and irq-disabled regions. But still working on the
> selftests.
> While checking rcu gaps, I also found what looks like a separate issue
> for state pruning also regarding the MEM_RCU and PTR_UNTRUSTED. A
> sample example is:
>
>   bpf_rcu_read_lock();
>   bpf_iter_task_new(&it, NULL, BPF_TASK_ITER_ALL_PROCS);
>
>   if (condition) {
>   /* Safe: the outer RCU lock remains active. */
>   bpf_rcu_read_lock();
>   bpf_rcu_read_unlock();
>   } else {
>   /* Unsafe: protection reaches zero, creating an unguarded gap. */
>   bpf_rcu_read_unlock();
>   bpf_rcu_read_lock();
>   }
>
>   /* Both branches have one active RCU lock here. */
>   bpf_iter_task_next(&it);
>   bpf_rcu_read_unlock();
>
> But STACK_ITER comparison in stacksafe() does not compare
> spilled_ptr.type. So the verifier considers the trusted and untrusted
> iterator states are equivalent. It can possibly prune the unsafe path
> before is_iter_reg_valid_init() rejects it.
>

Sounds plausible. Once you have a fix and test that triggers bad pruning
behavior reliably, please send it as a patch set.

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/ker=
nel/bpf/states.c?id=3D6655c409707ec8ce9ce0850ffe4fe02331fd4d9c#n806

