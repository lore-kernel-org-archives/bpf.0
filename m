Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E763803DF
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875787; cv=none; b=jFLq5GFq5oK1X5jS4wWuvt9CkXsPXdwAjexbfBNmIFeXALqFdW0/0sukiQhBGBBRA/dyfxiT9MdjKEKdzrcMFkmUhmeAH6YCcz50DBQUfQbWOjzpnINWPD7H+52JGGyjNjdDwZcvvO6tPK7Zx9Cj5jPOfIq4m7WkNU5dZbrlMI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875787; c=relaxed/simple;
	bh=gDo8kHSsug0EddQ45yG6ICkDNlnYunuJZXoa0Be5mCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5IyayhZEz9fax432qoXN4OLerX5F/MhcZup6y5Yd86EimQgS+/xT+jzsKBFzeFz9gneTZiIsVmrfKnbp+W/qwnaDinRz4Z9ylmIP2Tv2bMPK9t4+GiXrzpeSNwJ81XtmFT/X6AL0iTMr1Pigg5wjbelcqkOKL7xtl7EdRUMuow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fo4AddfO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo4AddfO"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso59447485e9.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875784; x=1777480584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7crpKxbZ7gx3HVOAePpf+ENAlqNtH+f/Vn+uljMrmb8=;
        b=Fo4AddfO0dTqI5bbaHOlIjT4ChCwd5A+hQqHqcHEjwFZC4Vzpmo2lNZRf7lM4rNTSz
         USd4jtttFkWJsj9YoLU0iNF9b9X1rrZlWARWgY3TDiNFKzpBLggl6Xf4aHsCkNu4zBR5
         qCpI4WLKFJ1bcj3jkkL2g7i3nzvPU2NIMWFR2A3D69ze6zqrzPrzPHXlmfJVKwz6v4jl
         oSRyGbs17PJkIWJfMqgke/kbvCZFktZp10OGjQfS5z590lbIQenrf+ASO74rdNcjdpjs
         HATsEojREkpnplJ9kJVgCbCfet98TP2q5SZcobad6T+hLeG2gF7iHF6WGq2g9TI8E38p
         3JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875784; x=1777480584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7crpKxbZ7gx3HVOAePpf+ENAlqNtH+f/Vn+uljMrmb8=;
        b=U0iBejsijxRIDoe5D4orbF/zkmQBl875sNmzhP1aAhzWftZ/3H4nfmNUe6DWiPxrAD
         ElDta1FLlMu3PTLqw6YMBPOm/Fg/UAAixO+90HD1sRheyob9MNumqVUNkpeqcv6pSGUG
         WtCZP0juiJS8c0V2+o04fQ72lB+SuK0ZSUyqIXXMjWSpOQ6LqHCBIBKPqrKtGy5rBCES
         cRBHanvoEAMZAPPbbCVAlJp+CqOJKSm0QRT/Hg6Jp2eSQJMNzDY5yHY6NLKkw4p6Dt7B
         6ROfnOiVkIhkOKqQIWk2IUyPJAz1LPvyAZBqJpND3M2BM2qAl+r1hxTPtHe967dXYvAm
         WGUw==
X-Forwarded-Encrypted: i=1; AFNElJ9BTvudyqrn3c5mjmPpTjSLCm3ctgCPttKDI23IMmMx6sP7KGAql/aLfvXr7cgGeB3qX6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3l5TWyKg4+QCPBAO8mN+DryMnw8q8oesnF0QWHPIA0qE28AS
	cM5M3JS34jzI8TqIaBGfWa9/jPb2ezDoPdpFXb2U+R64VcqHdUdMWd3a
X-Gm-Gg: AeBDiesj1GZX4giAVC7PkF+Wq0pQEkiEuTH8aHT/t7RRx6h0hStNBznQd+Q6yKu3FLY
	tbkMamg53mQ2T058GaAHs6myD4lGqoggcKcKkeoqxt9f1iAmGLIwGHpECNjing6fSIv98aG6jyX
	hAFMLJ4dV7PHQoFjdjzUbKhlUKNv/QXz+wwSL36Wj5XzMI/nHquzDJUuO4j/BgkHpa9p7irgKAy
	yhrzQfc9bRkbnTb9d1XyLLl6M32dDl/fdji+nBhF/qdjz7BrNrH0cWTWAmnhejAuYIqRGdqHvdM
	pomkefM8v++WxzujXXVfVM+95bTpOlH5bZ8bC+GfceYmts6MRhZ0l9HQ/bKjZ3vZhaQjHWbh/gl
	D8I5CmDO09MIe9Q0CogqyDKDRDqXZ/ThbfHtyXVacbSQyJ95XMF1kvLK0q+cwmtLKbtv12NEDCd
	PqjBz1q8FZUGdGkU+pse5tca1+luTGzxeV4fJ2xoot1FoOTkwiGX0HcqxxLDsHcJtaeVxHb+NN/
	l+OWaNN3Q==
X-Received: by 2002:a05:600c:3483:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-488fb77d343mr311359745e9.18.1776875783753;
        Wed, 22 Apr 2026 09:36:23 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:4807:7c72:b2bd:e787? ([2620:10d:c092:500::5:1502])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7aa593sm143818385e9.24.2026.04.22.09.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 09:36:23 -0700 (PDT)
Message-ID: <5e93b4e4-12db-454f-b900-68ebad02ba5b@gmail.com>
Date: Wed, 22 Apr 2026 17:36:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 2/6] bpf: Add bpf_prog_run_array_sleepable()
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 peterz@infradead.org, rostedt@goodmis.org
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260422-sleepable_tracepoints-v12-2-744bf0e3b311@meta.com>
 <e93b3ecc3e3406ac70466f8083544d896295f6fbb3f07c8e5a059fa25f8f19b2@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <e93b3ecc3e3406ac70466f8083544d896295f6fbb3f07c8e5a059fa25f8f19b2@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/22/26 5:06 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3079,6 +3079,56 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
>>   void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
>>   void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
>>
>> +static __always_inline u32
>> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
>> +			     const void *ctx, bpf_prog_run_fn run_prog)
>> +{
>> +	const struct bpf_prog_array_item *item;
>> +	struct bpf_prog *prog;
>> +	struct bpf_run_ctx *old_run_ctx;
>> +	struct bpf_trace_run_ctx run_ctx;
>> +	u32 ret = 1;
>> +
>> +	if (unlikely(!array))
>> +		return ret;
>> +
>> +	migrate_disable();
>> +
>> +	run_ctx.is_uprobe = false;
>> +
>> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>> +	item = &array->items[0];
>> +	while ((prog = READ_ONCE(item->prog))) {
>> +		/* Skip dummy_bpf_prog placeholder (len == 0) */
>> +		if (unlikely(!prog->len)) {
>> +			item++;
>> +			continue;
>> +		}
>> +
>> +		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
>> +			bpf_prog_inc_misses_counter(prog);
>> +			bpf_prog_put_recursion_context(prog);
>> +			item++;
>> +			continue;
>> +		}
>> +
>> +		run_ctx.bpf_cookie = item->bpf_cookie;
>> +
>> +		if (prog->sleepable) {
>> +			guard(rcu)();
>> +			ret &= run_prog(prog, ctx);
>> +		} else {
>> +			ret &= run_prog(prog, ctx);
>> +		}
> 

Yep, this one should be inverted.
I'll send v13, if Alexei does not mind.

> The sleepable/non-sleepable branches appear inverted relative to
> bpf_prog_run_array_uprobe(). In the uprobe sibling at
> include/linux/bpf.h:2491-2526, classic RCU is acquired only for
> non-sleepable programs:
> 
>    while ((prog = READ_ONCE(item->prog))) {
>        if (!prog->sleepable)
>            rcu_read_lock();
>        run_ctx.bpf_cookie = item->bpf_cookie;
>        ret &= run_prog(prog, ctx);
>        item++;
>        if (!prog->sleepable)
>            rcu_read_unlock();
>    }
> 
> Here, the condition takes classic RCU (guard(rcu)() expands to
> rcu_read_lock()/rcu_read_unlock() via DEFINE_LOCK_GUARD_0 in
> include/linux/rcupdate.h:1181) around sleepable programs while taking no
> RCU read-side lock for non-sleepable ones.
> 
> Sleepable BPF programs are designed to fault and sleep. Executing them
> inside a classic RCU read-side critical section violates the RCU
> requirement that classic readers must not block. On CONFIG_PREEMPT_RCU=n
> kernels this can cause RCU stalls.
> 
> Meanwhile, non-sleepable BPF programs often rely on classic-RCU-protected
> structures (like classic RCU-protected map entries). Invoking them with no
> classic RCU read-side critical section weakens protection. The caller added
> in the subsequent commit 864dee5d55d1 holds only guard(rcu_tasks_trace)(),
> so no outer classic RCU protects these accesses.
> 
> Should the condition be inverted to match the uprobe pattern?
> 
> This was raised by Alexei Starovoitov in v11 review:
> https://lore.kernel.org/bpf/DHZ4I3RWVVCU.16XRZX1HPFI8K@gmail.com/
> 
> Alexei suggested in his April 21st comment:
> 
>    "Why grab rcu_read_lock() and undo it?
>    imo it would be cleaner and faster to do
>    bpf_prog_get_recursion_context() here ...
> 
>    ... and then here:
>    if (!prog->sleepable) {
>      guard(rcu)();
>      ret &= run_prog(prog, ctx);
>    } else {
>      ret &= run_prog(prog, ctx);
>    }"
> 
> Was this feedback addressed in v12?
> 
>> +
>> +		bpf_prog_put_recursion_context(prog);
>> +		item++;
>> +	}
>> +	bpf_reset_run_ctx(old_run_ctx);
>> +	migrate_enable();
>> +	return ret;
>> +}
>> +
>>   #else /* !CONFIG_BPF_SYSCALL */
>>   static inline struct bpf_prog *bpf_prog_get(u32 ufd)
>>   {
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24787752194

