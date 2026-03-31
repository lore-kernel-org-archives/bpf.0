Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1707F3A5436
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951858; cv=none; b=uMxTlMKfX5nusku7H7kNjVKpQWC2OU/TqRH+cIvHNhuGukrCfOPmKhNzTmp5hpEjskQWI9JLdLrkAq1JXVZfIJFDfY43nqmI/Jtk5azARLXuw5s9+FXw/7bzbt0i7sjqHnL8ZPcg0ephhEjZgS8gLlIIZxDGVJ+XnVrnFowp7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951858; c=relaxed/simple;
	bh=37sycQgKDkDJI97x7meEkf4Qt4Xli9rNUDE7VjYVydY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNKlrALzEZGf5wdEmde7kZL9E2KAddDfGPt3Jz48SwQEbosSDQXpMZKHyDIyWB82MKuyUoT9MmD/yzEySio2QHqDY/MiAWakJkM+7JPRRANcDam49Jv+1yAb82sz5+I8I/f5f4Bu7Gig+eisaf4RX7KjkjtryqE8kmXBvSaglws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTDpD95I; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTDpD95I"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so65906515e9.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774951855; x=1775556655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lmGI3gBtDhlOmGGkv4CKDLxJX6dz4pUpHviQhoik+w=;
        b=aTDpD95IMyCAgRsNReDhYuLN2nBlu/cgiZ0lakbiqYjhMvJ74CHS6M7D59qs/Y4Md3
         EcYT6v5J153weKrOpJi0seG0CoKBIR2u3ZSMHTTZZEvzKSBMT7zK07BZOYGa6rUNQtO6
         IohBiJe/h187hgpNFQd2ae39J5NqfFDzjfJOfv9n46aP68DnanXVjjyltpddouJlw13T
         /AtXPhYB0Ci8xshB7XcT5sI2FBNOjyK0zz8uHOzprD5PBnlDQLp7E+GJ5rqxsEgLiS0v
         1+s99Hoy8SV1yHRlpp9C5koiPo1r61KiN3027MspAGj0htV6gcNFF+8ayKPdIzGyQDjd
         REyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774951855; x=1775556655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lmGI3gBtDhlOmGGkv4CKDLxJX6dz4pUpHviQhoik+w=;
        b=G3V78VPe82yZe0evQBVfepDA/Ata3EaeZEdpZB5rc5eg6lJdDSyP+F3YdWRNt+WgMk
         05IjK07N2yx8D1MhuILVdmPwAlnEgBcoGn8ulw6bP6c3GmFiGdNSugffEhfzq/ZAFZxN
         yfUoxC5CwzXgRATkRn440TX1ACDexYrYjU8Tec0fPMRzyXoMkQkxE1Tf47F975mDbh8f
         XPcb67jOHbREi4FfzBCi8PMNgXuN0J9VlM3NW+VLX9TBc+XZYErCdCOkWgA4Gs0JSLFx
         jmQLznLWzaaU0E1/P6r7EliHX5Ly9g96ucw72qsc920NIUmO4Sts3nQCF1XMoSE1Sb4M
         5e4w==
X-Gm-Message-State: AOJu0Yxtzxfm1m7pB066KsWQf3FGzNT4P0JDaRAKcjXngpco2QaIT7qT
	sTLld47GIBvA5vlVW/UuMhV9/R2qIT+kd71LTg4P/52S79XPKbI9Vg2M
X-Gm-Gg: ATEYQzzV9sxLMfCDl2fcp7eqdZApHyO+Ba7WGzqhfP2BkqbPVMpMCp0oghEv2RLjbgS
	GUeZMGeeZD3uyTegPfE1EbyquygTYwZmEj/sCiezRTuSSgkI/suWR5hUN7K/lJmeJg8PcRiiRyc
	gzKPvYAXPk5k0TWGQjrJQaOzHYlSTfZDnRk8B9s1vUE1MaXuSTyRgyP1f6nXKONKr+IJe0oxJk8
	Bps24g5B3mkBMWbYI/s8tsocGiHGKTXyzri5nZiQsRtgCw7RlVi4GB+uh/1zdweYlr1WtCedvkf
	5ZtRMJpaI/uZpjOK00O0+qW9RS6PXNMbpHBXnhc+xBRLVWI1Uc3gP2XeEy0+Hym9zJOSrb5XVuR
	cJASpc7AbylCRide+TWBdIh3QuEc+1H3cfWGO03XR0SHbbNzFVFUrfusBQKT1AVr3ey3DvYJicx
	DMtJ1R5NqWFiapKRQ9g7kOwOb1wFB0g6L7vRUPokwcL/OdPCLKXRD3Ut5nZMAOzX/63H8d0pTkN
	tlxtbOGIRg=
X-Received: by 2002:a05:600c:c8f:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-48727d45a8emr270772785e9.5.1774951855183;
        Tue, 31 Mar 2026 03:10:55 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c884f77sm11900175e9.20.2026.03.31.03.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 03:10:54 -0700 (PDT)
Message-ID: <ad6e293e-6ce4-4a7d-8896-2848c4477ffd@gmail.com>
Date: Tue, 31 Mar 2026 11:10:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 2/6] bpf: Rename bpf_prog_run_array_uprobe()
 to bpf_prog_run_array_sleepable()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org,
 rostedt@goodmis.org, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
 <20260330-sleepable_tracepoints-v8-2-2e323467f3a0@meta.com>
 <CAEf4BzamwGd=_q4aHiWDx5cyRWPNHpH=9JwpsHeFrxCv0AFg7g@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzamwGd=_q4aHiWDx5cyRWPNHpH=9JwpsHeFrxCv0AFg7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/31/26 1:46 AM, Andrii Nakryiko wrote:
> On Mon, Mar 30, 2026 at 3:20 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> bpf_prog_run_array_uprobe() will be used by both uprobes and faultable
>> classic tracepoints. Rename it to bpf_prog_run_array_sleepable()
>> to reflect its general purpose:
>> per-program RCU flavor selection for sleepable program support.
>>
>> Add a bool is_uprobe parameter instead of hardcoding
>> run_ctx.is_uprobe = true. This flag controls bpf_get_func_ip_kprobe()
>> address resolution and should only be set for actual uprobe callers.
>>
>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   include/linux/bpf.h         | 7 ++++---
>>   kernel/trace/trace_uprobe.c | 2 +-
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 05b34a6355b0..9fe19ab21cfc 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2487,8 +2487,9 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
>>    * rcu-protected dynamically sized maps.
>>    */
>>   static __always_inline u32
>> -bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
>> -                         const void *ctx, bpf_prog_run_fn run_prog)
>> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
>> +                            const void *ctx, bpf_prog_run_fn run_prog,
>> +                            bool is_uprobe)
>>   {
>>          const struct bpf_prog_array_item *item;
>>          const struct bpf_prog *prog;
>> @@ -2504,7 +2505,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
>>
>>          migrate_disable();
>>
>> -       run_ctx.is_uprobe = true;
>> +       run_ctx.is_uprobe = is_uprobe;
>>
> 
> nah, we can't make it into generic "run_array_sleepable", it's clearly
> uprobe-specific due to this
> 

What's the alternative, though, just make a new 
bpf_prog_run_array_tracepoint() hardcoding tracepoint-specific 
implementation into it?

>>          old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>>          item = &array->items[0];
>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
>> index 2cabf8a23ec5..eb4d78e689ac 100644
>> --- a/kernel/trace/trace_uprobe.c
>> +++ b/kernel/trace/trace_uprobe.c
>> @@ -1402,7 +1402,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
>>
>>                  rcu_read_lock_trace();
>>                  array = rcu_dereference_check(call->prog_array, rcu_read_lock_trace_held());
>> -               ret = bpf_prog_run_array_uprobe(array, regs, bpf_prog_run);
>> +               ret = bpf_prog_run_array_sleepable(array, regs, bpf_prog_run, true);
>>                  rcu_read_unlock_trace();
>>                  if (!ret)
>>                          return;
>>
>> --
>> 2.52.0
>>

