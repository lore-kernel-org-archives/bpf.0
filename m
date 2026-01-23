Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF493285C91
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165249; cv=none; b=j8am2hPj0AgC2sll50LmtgJx1zgnTY994VEQBK2TfWsSkFEPFrf1vEjnBt8xLD/dW1M0/lAjAmqsNePpAeH+3swYzDqhg1LdFInEmSlxaZDSrWJkKI21eMH3EFT473yrD66uDf0zfMjjQl+/odDrOKCXhtfYlLep4V5IJ+zjHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165249; c=relaxed/simple;
	bh=8ecJNz5yllF6F+H9yEy8Qi62K2qBjHzNI8R2yBzDIHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4Ey2sK848EAvZbeamRIFVWVaoLxkkIrRZ94GrgsY8U2RRvAkQ1Lc/aPLGwdi4UNoU3xIkkKAJex4sE4SGFVrhKasEAOTAXhqTf6vD4tWJvY2YtpSPxS1qR3i6HZDejaIT66DUprRfkaq5J0xL+AKbBx9TG4bVj2b95vH4TQc74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhPXVgss; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhPXVgss"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65807298140so3402458a12.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 02:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769165246; x=1769770046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1e6/SEvb5tQQY/CYtg5loGZLQC6p+o6lvqMhBNoWaA=;
        b=BhPXVgsspr5mGSY7NyEedJzpc3rU0Aj7MVM8PjmiJXNrr7YiojnSenGnIWgQrLjIkf
         rg4mNrLf6P5RjL4gs1TgmLxMHuCf5YAXOwveUa13JoQbEKfUfFSALN+HaSR3pv87FlG/
         P+tXyJcw3V2ORhFVnEyZqIAI9E3ObaFgEK9iqa/Fq9A3LDD/WWDWjHo/pvvErQQyAyWy
         q3GHWV9Gx9vqiECQjOS9LHuqTJxhAvEKScvKI6623EoEdJ/dsDTZgmjj1yUKD8UkbKUp
         YY514b4AhiVHuMi591AdT8ltal4/ChegBvmzkOJLR/7QeKPU9n1lupgfYK5G5s2i+UMM
         Lnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769165246; x=1769770046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1e6/SEvb5tQQY/CYtg5loGZLQC6p+o6lvqMhBNoWaA=;
        b=XsVfa8nlN18NBUZDi1VJxZzXuAdKrYlVbvsZaHk8q4JlImI14n9dWVYhkJCZethyAQ
         JPmxnuR+BW6CYsMwdQ4it3L444i1UEk045WjXpxpF4pqLY0PN76wnQ7CTANssRURe1/z
         Yt5X3MuA640TRpB8tUSS7o320sV7HBV8AUWKcTafvvNK2/LOwkLO5iAVCm6y3+MO0rcA
         tdl9IIqSH5QH50GmPNr1wVII6bvUAbfEekYVusYD7SNXgPe/cU6awvALt7IOes7erWyg
         JM8bKCDOik0POYoGASIcIK+FDH0RE4ATvEuBr72W1fbcoqfQzfYMrvt8uhj95PCTKjgC
         Etvw==
X-Gm-Message-State: AOJu0Yygf4MaP8VnW0TwZdvu3rXy8g+vBLE4bov/DBOq0+X3iuF9RSoX
	5rxnbwBJu11b7B60bvb+uDW6JVghN+dLWsRu2Tqmgr/yP19tcgZil1Gd41dqMw==
X-Gm-Gg: AZuq6aKTBPUGI2jQQtsZ6ZbfjkiV9W3hGQ719TmhO8d0pTFOUS6PNFXToICIbDBuU8p
	kzPvsA1/njM5rrIilzmhKywcTJ/Kzn9Ka+ES7Boe85t1V7+ZpqUGsBEYHjWxe1y1AjUVBDFCtyO
	HfFLtqw5s9gc/Efe09iv+BlhxxtLquzon+XknwNHDu25QlzDilSKi8bYIDA2dX+r1m2QyR6YwfY
	Jh/j7qHq8VIvgX7+nayjYa9FWIjcVskznZarBl5722DB02zFELzRZGXFalCCqwZ/C2ws4oDJjgb
	q4+3t3ZIlFrSmU6f2AfkyO/7+OYvr8F+8tS0Bbpfrh2bKR6RzqhXOwg8Zk91wMzqidYN+prgLyF
	OdlQqDhsUZVXcVBawhssaFAo7vAwUop0jUE0a5y68K5P1zfaG3izcLUz4Q6W6/gx+sneXB9avMq
	2kExkyLF+1zBxhIRpgy6EW20esMZUU7y052HxjlHaz2qzZmUTihmHFDkKEjwDqkawxKy83
X-Received: by 2002:a05:6402:2745:b0:658:3c7b:5c3f with SMTP id 4fb4d7f45d1cf-6584876232bmr1649440a12.11.1769165245717;
        Fri, 23 Jan 2026 02:47:25 -0800 (PST)
Received: from ?IPV6:2a02:8109:a307:d900:1e85:edcb:5d9:8c9a? ([2a02:8109:a307:d900:1e85:edcb:5d9:8c9a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b96d6besm757306a12.30.2026.01.23.02.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 02:47:25 -0800 (PST)
Message-ID: <4b2ac07f-091f-4180-ad36-63811e32c5ec@gmail.com>
Date: Fri, 23 Jan 2026 10:47:24 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 1/8] bpf: Enable bpf timer and workqueue use
 in NMI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 memxor@gmail.com, eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
 <20260122-timer_nolock-v7-1-04a45c55c2e2@meta.com>
 <CAEf4BzbV_g6SZqB-6N3eRz1x3ODKFGGrDxG4GO+BxoNnV4fojg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzbV_g6SZqB-6N3eRz1x3ODKFGGrDxG4GO+BxoNnV4fojg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/22/26 23:48, Andrii Nakryiko wrote:
> On Thu, Jan 22, 2026 at 10:03 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Refactor bpf timer and workqueue helpers to allow calling them from NMI
>> context by making all operations lock-free and deferring NMI-unsafe
>> work to irq_work.
>>
>> Previously, bpf_timer_start(), and bpf_wq_start()
>> could not be called from NMI context because they acquired
>> bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
>> patch removes these limitations.
>>
>> Key changes:
>>   * Remove bpf_spin_lock from struct bpf_async_kern.
>>   * Initialize/Destroy via setting/unsetting bpf_async_cb pointer
>>     atomically.
>>   * Add per-bpf_async_cb irq_work to defer NMI-unsafe
>>     operations (hrtimer_start, hrtimer_try_to_cancel, schedule_work) from
>>     NMI to softirq context.
>>   * Use the lock-free seqcount_latch_t to pass operation
>>     commands (start/cancel/free) and parameters
>>     from NMI-safe callers to the irq_work handler.
>>   * Add reference counting to bpf_async_cb to ensure the object stays
>>     alive until all scheduled irq_work completes.
>>   * Move bpf_prog_put() to RCU callback to handle races between
>>     set_callback() and cancel_and_free().
>>   * Modify cancel_and_free() path:
>>     * Detach bpf_async_cb.
>>     * Signal destruction to irq_work side via setting last_seq to
>>       BPF_ASYNC_DESTROY.
>>     * On receiving BPF_ASYNC_DESTROY, cancel timer/wq.
>>   * Free bpf_async_cb on refcnt reaching 0, wait for both rcu and rcu
>>     task trace grace periods before freeing the bpf_async_cb. Removed
>>     unnecessary rcu locks, as kfunc/helper allways assumes rcu or rcu
>>     task trace lock.
>>
>> This enables BPF programs attached to NMI-context hooks (perf
>> events) to use timers and workqueues for deferred processing.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/helpers.c | 434 ++++++++++++++++++++++++++++++---------------------
>>   1 file changed, 252 insertions(+), 182 deletions(-)
>>
> Aside from that premature refcount_put in cancel_and_free, it all
> looks good to me.
>
> Reviewed-by: Andrii Nakryiko <andrii@kernel.org>
>
> [...]
>
>> -static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *async)
>> +static void __bpf_async_cancel_and_free(struct bpf_async_kern *async)
>>   {
>>          struct bpf_async_cb *cb;
>>
>>          /* Performance optimization: read async->cb without lock first. */
>>          if (!READ_ONCE(async->cb))
>> -               return NULL;
>> +               return;
>>
>> -       __bpf_spin_lock_irqsave(&async->lock);
>> -       /* re-read it under lock */
>> -       cb = async->cb;
>> +       cb = xchg(&async->cb, NULL);
>>          if (!cb)
>> -               goto out;
>> -       bpf_async_update_prog_callback(cb, NULL, NULL);
>> -       /* The subsequent bpf_timer_start/cancel() helpers won't be able to use
>> -        * this timer, since it won't be initialized.
>> +               return;
>> +
>> +       atomic64_set(&cb->last_seq, BPF_ASYNC_DESTROY);
>> +       if (!in_nmi()) {
>> +               bpf_async_refcount_put(cb);
> __bpf_async_cancel_and_free can be called (through an amazingly long
> chain of function calls) from bpf_map_fops->release callback. And I
> don't see any rcu_read_lock() there. So... why would you put a
> refcount *before* calling bpf_async_process(cb)?  Please move it after
> we are done with cb. I don't think we need to guard(rcu) in this
> function just to handle this.
Right, good idea, thanks!
>
>> +               bpf_async_process(cb);
>> +               return;
>> +       }
>> +       /*
>> +        * Attempt to pass our initial map's reference to
>> +        * irq_work callback, if we fail to schedule it (meaning it is
>> +        * already scheduled by someone else having their own ref), we have to
>> +        * put that ref here.
> [...]

