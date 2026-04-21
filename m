Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EB2376466
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813413; cv=none; b=Oa2ZSlKrocbKAUZDeF33WeuccsxyMbcdrZIyQzsJBJYwZQozcL8Vmr15eQyQkdr+UcdGUKl5x9IH/4/gEH7F0fsr80d+UPuMMzXjoke76q1vfEFaTuZ194PkNFVYlP4VwokSPnZzlxh9IZkybq7sRD/+7XMZtWK7DJ5bHHoB3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813413; c=relaxed/simple;
	bh=+fkVhZol4DG5uEDm7dt206e7nmibiSudbSJYtxiqoGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUL4L4EK2SH2ntUX0iOP7s5nzWFjQPaQ8484lcWg/3O5ZGcOlqcNvc0sgN6fl3DvLfs/VYpxMyCGHbU+QJ8IgXe2TxIggnZmW5dHZyBDNpi9681jfMipPuQxeqSxGtbWpzNDZbru0V2a/TmPJZ5btAVcqqJvsQHGsGOJqHMae40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdRJI+2I; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdRJI+2I"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ad135063so41094395e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776813411; x=1777418211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4zJr/ebAUntunwhk478FIZ1n4+lgf/57DCIowg27Kk=;
        b=hdRJI+2IUVlMuMsksxtGsQ8wZezuGemArpbwNy62Kmo90plc9+6MAaKbomXbAwA4Hb
         HCbAKDpJp8EeoDLr2g0Y1k3J7dtBXdUAuSiWMbX5HS/Gt2tdnJ8ehxyn92mOSda+R9fW
         I7DnJSphVLcjS7VMNrgt9SrjDB1vreTlBAoPMXevhJQ6RdYt5uuThd5iCWruHjeoEvYj
         QcgKdx0bjJgcWzsx9JhsezgDl8LAtqDHHopWNtJyh+fpcwrrRt8TWEUA6zjCB4rD7jOX
         WhxKnBKMfKoT8EeNEz6VYY/NLrlIRhNTyCeZUPZ2ga0mhxYCXDr481dPUULnxZMZ2ebj
         lRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813411; x=1777418211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4zJr/ebAUntunwhk478FIZ1n4+lgf/57DCIowg27Kk=;
        b=chPzxkwJ6bvwNjZc8RrJ8AceHoUq2s1slgByVripx0JXufRXKyo7xFRyQP7YaKTAck
         Q+rNpItnUww9ktfFuH/rvu2nrXkZpfYaU0tj1e09XC/N/FRudHXPrhZyGZobLmdHA5jR
         byeaclL9rbF949J08Dse3I4AC4QELN0W8hGmpsmSIfjr+9TpswBVAe7zPxNiyop2QBBY
         RVOPubLAJPU3oLheyV5FxDb/EsmiEq4UFkw7pdTdBvn5Zuq+BooJj1B7qJweM8ex90gw
         qN/Y7FD5edFQyIpF520WRawNAWoxL8pQpKgNFCjqKLvUHXy4J/l50A1TWwjJOG2EJU8D
         BoQw==
X-Forwarded-Encrypted: i=1; AFNElJ8gK1zFoyPhEaSepLcCGC+0S+2rjDCzEzY0Zg/IP39xQToPWi/DmOtex+RlDPJRb1bPRrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBb9arlHT3NP/1aI9EEUWlCfhwetcU8oZkSmEse9S/Rx2+PgTf
	MoixhbDea/xW6sqfHRwRhku8tJj9cKegNmw1EXT29CbEVfA9BXAKWvnd
X-Gm-Gg: AeBDieuP3kubC/ghi3Sybgi2BB8VE77J4J+YiXWvRt6MuuEWec58NpIBpKWePA+Lrcq
	ssqy1xb1KNCraduuFgkJD3BikFEvZP131sguSkdCTbtfVZsZ7YHd0LduU/VJ6woE+zjwC1zbf4I
	nZWIn8uZ9RTnapC6dYcHOUJGiVXzIxv2rAEYOBcCOdNcM3XzJ8CVxp9wgSIj1YgtEFUgvXQ1xwm
	aHLDOyb/n1J55YEZz6rfLgECRyzK6BT8XjvIKFCwa5z5ja7bvzVV5BJZE2ZAawDEpxKluffjOh+
	QZeT8l5JdtPC+/7kBi21+DwlGnx4TfG9kt2VTZ9Go/GCDGtnqlUUUOSsTz5zimwvqAGL/0pG1N2
	TbNxA4rkMq++5SwZdW7fAAiku88W6zmJQpPIsQ2g+T+rpazFspOZDs6ytfq6LValRAL0sKHhXn5
	qnhIScD1clgBejzPQPSX6NbFM4z37U/D+DNMnDruUuM4R7SXLXw2/RJMOY3gdq51cMzgb7pIi9h
	tEYsm9BWr4N00UHkeyqmA==
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id 5b1f17b1804b1-4891c1f38c8mr166655175e9.6.1776813410585;
        Tue, 21 Apr 2026 16:16:50 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10019bsm412611615e9.4.2026.04.21.16.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 16:16:50 -0700 (PDT)
Message-ID: <2a2c0fdf-9d4b-494f-ba76-f94799bb3ca5@gmail.com>
Date: Wed, 22 Apr 2026 00:16:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 2/6] bpf: Add bpf_prog_run_array_sleepable()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 peterz@infradead.org, rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260421-sleepable_tracepoints-v11-0-d8ff138d6f05@meta.com>
 <20260421-sleepable_tracepoints-v11-2-d8ff138d6f05@meta.com>
 <DHZ4I3RWVVCU.16XRZX1HPFI8K@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DHZ4I3RWVVCU.16XRZX1HPFI8K@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/21/26 9:42 PM, Alexei Starovoitov wrote:
> On Tue Apr 21, 2026 at 10:14 AM PDT, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add bpf_prog_run_array_sleepable() for running BPF program arrays
>> on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
>> includes per-program recursion checking for private stack safety
>> and hardcodes is_uprobe to false.
>>
>> Skip dummy_bpf_prog at the top of the loop. When
>> bpf_prog_array_delete_safe() replaces a detached program with
>> dummy_bpf_prog on allocation failure, the dummy is statically
>> allocated and has NULL active, stats, and aux fields. Identify
>> it by prog->len == 0, since every real program has at least one
>> instruction.
>>
>> Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.
>>
>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   include/linux/bpf.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 3cb6b9e70080..b6e96c939846 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3079,6 +3079,61 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
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
>> +	might_fault();
>> +	RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held");
> 
> The only caller of this function is in the next patch trace_call_bpf_faultable()
> that does
> +	might_fault();
> +	guard(rcu_tasks_trace)();
> 
> imo above two lines are redunant.
> We can defensive programming when another caller appears.
> 
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
>> +		if (!prog->sleepable)
>> +			rcu_read_lock();
>> +
>> +		if (unlikely(!bpf_prog_get_recursion_context(prog))) {
>> +			bpf_prog_inc_misses_counter(prog);
>> +			bpf_prog_put_recursion_context(prog);
>> +			if (!prog->sleepable)
>> +				rcu_read_unlock();
> 
> Why grab rcu_read_lock() and undo it?
> imo it would be cleaner and faster to do
> bpf_prog_get_recursion_context() here ...
> 
>> +			item++;
>> +			continue;
>> +		}
>> +
>> +		run_ctx.bpf_cookie = item->bpf_cookie;
>> +		ret &= run_prog(prog, ctx);
> 
> ... and then here:
> if (!prog->sleepable) {
>    guard(rcu)();
>    ret &= run_prog(prog, ctx);
> } else {
>    ret &= run_prog(prog, ctx);
> }
> 

Good point, postponing rcu lock makes the code cleaner. I'll send v12, 
thanks.

