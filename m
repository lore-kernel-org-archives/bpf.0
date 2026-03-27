Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC1227565
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622203; cv=none; b=qO9LqMvuc40HjBYYnh/j/dgI/w4qaoOXC0QSl7f5kWTAgwSIE1mapccFH3bxAd2BrrZ48SBrTiDfQekIO17E2MDDhMLvmFKJkfpLE8YU+0AAw54aIWUw48eBWJ7mqcR32K3riE1wab80rK0J5eLgO2VgqtbX57zliKUDLW8Cpyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622203; c=relaxed/simple;
	bh=wGuwV+P0Sd5PvLNxcIC4QtztIlDC6o2xMTY2WtHlqeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I6Vb7K27vaX/MAPp+I/K0ajfZCLvkoZP+UuE/rhbxP+P2D5R6rzAT+H8ipTvQUI+f7QPVfRHHnbBzFWSwMhF1sw759CJLcwR7zNWLtOwcLnQv5t2FIQb9L1iH3WVZT4g9kbuwv5BMML1coHB1d4s5hudnt9p1tcyNzDVw7wxVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZ3rnOxd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ3rnOxd"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b527ac5d0so1201716f8f.2
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774622200; x=1775227000; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUIAR0bNal1dvHqlrH9p/yhT1l8v1OfYziXq/rjrD+Q=;
        b=cZ3rnOxdOM/DAn1cUXKG2zmYMOHjhGBNVKJZYFNKQzg7DHc6QrIEEPfWoctffffXdt
         v9PQxJ5uK0dglcI5u4KchnIZz0tEDa4ikvGEfPZmw/nnV1irx2dkimR7mqF2gFa2zxhe
         cjvikHGRgfaMqP0BIaIWsKjfsJnT7RibYQK6htJubRCV37LZ+JWueVTmtglaL785mJo7
         4wMnBJAEin4AEjTJkBTsqhD1+4iNVaXrxpTMRXSRvoExid84npR4j0OyF6lF4Qw0RFFr
         uA44VCTnoBlbPg27oXTfbsQ92jCHQ6LbRnKQVwnukej5AlVXsc7F8JS9JybyGdXK6ATw
         hM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774622200; x=1775227000;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUIAR0bNal1dvHqlrH9p/yhT1l8v1OfYziXq/rjrD+Q=;
        b=hBN3eau51RIHTe3poVhdaXFJ9JoSTsQrjXHMZXH4cWQ7uBy+g//p7CdYVoOAEi+R/8
         /urwkXWcp6Z8ql+Kw8RhQ0lyK1Fln8g09/ZRiBNwEzOSw2MCxTKCDuo7JbJGPg4zLo6Q
         XhNkrRqPtpaD+u5tWMfsLOZxmCBQQa38UPVv53Zp4Rjxx8XBoqWou1FLmBJkFYDWuGKq
         JANG/FDt1HVhfW2tiwd7+w8ZWuzhrQ1aXBwe7RHoJMEWnqG25mvPbbGuVbkthzAn+pz/
         pH5YAlpXx32ttTKkO3QXIuycHkAV/x/fytULWz3dP+SH3h0J4LoQXowx31dgF2xpXkic
         Sb5Q==
X-Gm-Message-State: AOJu0YzTMl5CX8ifDi6pCQcuIlNBFosNFs2a0cPOxQS+f1Sq7wZmSrFc
	JraFFcFAo4m78VSHTKqopa94XETnjkkmvZQA4jKienKssjZGX35norPu
X-Gm-Gg: ATEYQzyqfiMZ0+KZZKgAQPKAE/w8uZ5jCI5kqrowInE43s7GS8gvgJjnM+HFDsUh2ws
	soApxXZxnqDUpmQVgY/Yj13aFFiKk1qfwVt+JdjNwsgJLNHj5FPNpeNx7bswHzWkDyEWH+7f3EA
	LChPaThtNNAkSdV4lmnRmh7FWwFimCbp75f8pTraQf3UL3I8aQTBKAY/hYS3lpkBDiIAd0zMQ7t
	QKP84zonZ2BIMA5XhiE1rUxyJAfssqs7+v1YifnVHpzauKdubHgtFuXMonYrxcrUsNPkIptLQYh
	83t1RKHsLUxYeivziq9o77D/SRiXwJocT6FBXb4nQ4UhfcZyVog/dtHSkSDkMTx+bdATthq0I7w
	xhSDeAAfRmsa3ACviCFVLl5nn3t48mIz45LmshjlPWlRa3KIEG6dHnPX03ZADZzp1zjUmAF74y6
	4RJ5k8/y8wYmCkbRMM++cB/iC5auzhRLd9Ug==
X-Received: by 2002:a05:6000:250f:b0:43b:45d1:f448 with SMTP id ffacd0b85a97d-43b9e9e8c75mr4583271f8f.14.1774622199874;
        Fri, 27 Mar 2026 07:36:39 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9194311asm16750138f8f.10.2026.03.27.07.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:36:39 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH 1/2] bpf: Migrate bpf_task_work to kmalloc_nolock
In-Reply-To: <CAP01T74d63iXXxz6UhjLQWgC_FOvJTrUbfrREcf=+qkshbOoag@mail.gmail.com>
References: <20260325-kmalloc_special-v1-0-269666afb1ea@meta.com>
 <20260325-kmalloc_special-v1-1-269666afb1ea@meta.com>
 <CAP01T74d63iXXxz6UhjLQWgC_FOvJTrUbfrREcf=+qkshbOoag@mail.gmail.com>
Date: Fri, 27 Mar 2026 14:36:38 +0000
Message-ID: <87fr5libk9.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> nit: I think you need to target bpf-next in next respin, patch subject
> is incorrect.
Thanks, forgot to apply bpf-next prefix.
>
> On Wed, 25 Mar 2026 at 22:12, Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Replace bpf_mem_alloc/bpf_mem_free with
>> kmalloc_nolock/kfree_rcu for bpf_task_work_ctx.
>>
>> Replace guard(rcu_tasks_trace)() with guard(rcu)() in
>> bpf_task_work_irq(). The function only accesses ctx struct members
>> (not map values), so tasks trace protection is not needed - regular
>> RCU is sufficient since ctx is freed via kfree_rcu. The guard in
>> bpf_task_work_callback() remains as tasks trace since it accesses map
>> values from process context.
>>
>
> I think a comment in both places would be useful. Also, this bit can
> (should?) probably be a separate patch preceding the conversion.
Do you mean a separate patch to migrate from rcu TT to rcu? I'm not sure
it's worth it, it's not a problem right now, because bpf_mem_free()
actually frees memory only after both TT and normal rcus. But because we
are moving to kfree_rcu() it should be paired with rcu guard, because
now free does not wait for rcu TT.
>
>> Sleepable BPF programs (e.g. BPF_PROG_TYPE_SYSCALL) hold
>> rcu_read_lock_trace but not regular rcu_read_lock. Since kfree_rcu
>> waits for a regular RCU grace period, the ctx memory can be freed
>> while a sleepable program is still running. Add explicit
>> rcu_read_lock/unlock around the pointer read and refcount tryget in
>> bpf_task_work_acquire_ctx to close this race window.
>>
>> For the lost-cmpxchg path the ctx was never published, so plain kfree
>> is safe.
>> ---
>> [...]
>>
>> @@ -4296,13 +4292,27 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
>>  {
>>         struct bpf_task_work_ctx *ctx;
>>
>> +       /*
>> +        * Sleepable BPF programs hold rcu_read_lock_trace but not
>> +        * regular rcu_read_lock. Since kfree_rcu waits for regular
>> +        * RCU GP, the ctx can be freed while we're between reading
>> +        * the pointer and incrementing the refcount. Take regular
>> +        * rcu_read_lock to prevent kfree_rcu from freeing the ctx
>> +        * before we can tryget it.
>> +        */
>> +       rcu_read_lock();
>>         ctx = bpf_task_work_fetch_ctx(tw, map);
>> -       if (IS_ERR(ctx))
>> +       if (IS_ERR(ctx)) {
>> +               rcu_read_unlock();
>>                 return ctx;
>> +       }
>>
>>         /* try to get ref for task_work callback to hold */
>> -       if (!bpf_task_work_ctx_tryget(ctx))
>> +       if (!bpf_task_work_ctx_tryget(ctx)) {
>> +               rcu_read_unlock();
>>                 return ERR_PTR(-EBUSY);
>> +       }
>> +       rcu_read_unlock();
>
> nit: This might look cleaner with explicit block {} and guard(rcu)() inside?
>
yeah, I think you are right.
>>
>>         if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) != BPF_TW_STANDBY) {
>>                 /* lost acquiring race or map_release_uref() stole it from us, put ref and bail */
>>
>> --
>> 2.52.0
>>
