Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3923A6B77
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952954; cv=none; b=BbJFabx5Ma7UpWm7OUd9ctTauZMDvPVfBM8T0+ZjXtc1/PxppnhfUTrxmS6iaeic612deUv7i74j5jj4gIyQQvP6AapZ2zNHQSI0cyY8dpRVobpJcE/piKkw/RQbsUtLvicQN4hL+Fn6IkfYObRDStePlq8005wljYRPup2u16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952954; c=relaxed/simple;
	bh=XPt6ZtRRm9mckoywJg3SEn1T8ZpZc2AFjWWRyb2gRNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ij3S1aFrusJ5/AWdTg49FMvwUOpXKYE/vmabDf/4MHn32UK1tynA+gIgMx8B+HaZKAcWr8bbr17K5Fuevk3ENRTAfQDKEUL5hfodtoNae3vAbQG2HPS6vb/XsZxwM/UIvGDc7XB9t+6iBlKLMwTGpZ9tPIGPYwM08NsmpCR3rKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0wyEjO3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0wyEjO3"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cf7683a28so1358574f8f.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 03:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774952951; x=1775557751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3frjs3zyuX0VruCChgxSC3FmqulsRwza6g8Zija1SYk=;
        b=U0wyEjO3+Bud7bz+AXbWUC3y6Mj8yH39bgEgA8msgJoVbZsB1qpk6RR35bC2iT8zjl
         wZgbjPZMRl/0cLsij1qGPdDeSfqYUGgQkrZq3FeDzwh9urtSlXdsozfCT5tZUhFTLn8n
         jQHfM0JivaRcgLXD2cJL1ekzakJk3S1aOtWBZRNgKY5XvATqhYw308iXVPrl3RK5hrf6
         gEHkU+YLnd36drSYlrjg10eBndBIM6NsYJf0R/Vb2hja5zIkdXRG+iN6R7Y4Ce5IJjn7
         0/8bs3Xwngs9FNyF3G6tUE+whE76wAfiGwoEQvQIb8Nd/Mgf1NtEFXt51VjAYIXFSD5P
         3Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774952951; x=1775557751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3frjs3zyuX0VruCChgxSC3FmqulsRwza6g8Zija1SYk=;
        b=PE4rKsE0xbImM251Nq8u8eMmCgqMRRmFLyTH9BhOypec/l7OYYE7WN2R6Vvzx/nIyU
         11n7mHC4lie1pb3WNg04kwLFQuhb70lJ2jjovkDLUPTTY3tWHoDLPEHd68KVg9lWDLpq
         sFhS1ha6v7guiE11MlwKcgHb98kdaPjv7GBNUKaJLpkT5BvKqE3TcOXtWulWnrDeDsF+
         xE8VTPHof5/jIb1LxiHI2dynuqbCmBVgo9acXvdjnZ/U5+Q7Wauu/YKBztHZmX2h3hHr
         CRVSBfP/oiFRXq4hrxyB6fD1GjOwPmTpCtha9gV7fR2YYx6QNz9hNoJAXYje9TQw7Ij8
         +c6A==
X-Gm-Message-State: AOJu0YxO/QEM+f6vXXjyhgIbv6U6fIK1tlVWdBn/pPGm+PICwhYW+Oc9
	0XpiczXxjhsqT4b8QJPKCNieydudo9R3cQueus1euxkUZvBQj+LV9zlx
X-Gm-Gg: ATEYQzwYym2Mtq46F+Sb6D1ITsqLGuLOdPUaGuyL0+/MAEHbXBP8q47Aj5zv96luWls
	og0k+EtrwFev3LJZUWH2lA2aQ4czj18Bs77C8yPi2o0EuYbZBx2fTktA5C5rXAG11I7QWPCsHkM
	WLSn6aCiJIcxnxX/u4eeZZvD4cysYtANnz11HKnxkHBspXL190Vel2a2FkN1wR42XmfzPAH7HXQ
	RnwILAYBy5qaZrBDnd37lP0k/SuojlSkWqn700UQ5CeKFqejPoSE7h8mcYbaA2gDIrRg9AEdDWU
	TssbBChj+7Moqu9BVM/2wOdZQWZ6v1GD/XtWhT6VCDz5Agz45KLxf/z8WWVRV3cf1zFGUXJZOgm
	8jy5WkYoCPPB/gi/55W9KD1nUqRAWWHM1/dVjr4WHrmXGY0bPnr0tFdUn5Oow8qofWuSxnf8yu/
	9swFQ7ctJXYEzyXvpn0p3Qlhy3E2Q+EQuy7eHPATgSyKlBwQMT8m7Oh2xLLWbY93MZEbLxt9GR2
	d0B68rge5s=
X-Received: by 2002:a05:6000:2dc8:b0:43d:578:587d with SMTP id ffacd0b85a97d-43d05785b01mr9075705f8f.18.1774952950806;
        Tue, 31 Mar 2026 03:29:10 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e29b1sm24612479f8f.8.2026.03.31.03.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 03:29:10 -0700 (PDT)
Message-ID: <cb4c2d10-8131-4166-92aa-882a182160d8@gmail.com>
Date: Tue, 31 Mar 2026 11:29:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Migrate bpf_task_work to
 kmalloc_nolock
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260330-kmalloc_special-v2-0-c90403f92ff0@meta.com>
 <20260330-kmalloc_special-v2-1-c90403f92ff0@meta.com>
 <CAEf4BzahW744tL+0DvvB_4nhstRsgMui0xEX4+obQ4kYo77YyQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzahW744tL+0DvvB_4nhstRsgMui0xEX4+obQ4kYo77YyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/31/26 1:00 AM, Andrii Nakryiko wrote:
> On Mon, Mar 30, 2026 at 3:28 PM Mykyta Yatsenko
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
> 
> I didn't quite get if this change was necessary for correctness or
> it's just an optimization?
> 

Correctness - ctx is freed via kfree_rcu(), so we need to hold rcu read 
lock when we pass refcnt to the task_work_add() callback. It worked 
before on tasks trace rcu because bpf_mem_alloc() used it (with normal 
rcu chaining) before freeing the ctx.

>>
>> Sleepable BPF programs hold rcu_read_lock_trace but not
>> regular rcu_read_lock. Since kfree_rcu
>> waits for a regular RCU grace period, the ctx memory can be freed
>> while a sleepable program is still running. Add scoped_guard(rcu)
>> around the pointer read and refcount tryget in
>> bpf_task_work_acquire_ctx to close this race window.
>>
>> Since kfree_rcu uses call_rcu internally which is not safe from
>> NMI context, defer destruction via irq_work when irqs are disabled.
>>
>> For the lost-cmpxchg path the ctx was never published, so
>> kfree_nolock is safe.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/helpers.c | 56 ++++++++++++++++++++++++++++++++++------------------
>>   1 file changed, 37 insertions(+), 19 deletions(-)
>>
> 
> [...]

