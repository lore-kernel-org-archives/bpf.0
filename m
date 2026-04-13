Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62372701CB
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101558; cv=none; b=doT/XWRMHyIS3dHHpR6mLAlQ0lXf8W6LcB0tfRoWS0t5wowRLzo6mDEamQTQAd+AvITxMLpcig5oAZwWLNQ/dESX/xUo/iwBqZ7BOBtQe6p0okrkZ8XOSPCWklxkTD9X5Cm9uUqx83eJrh0iROz+kh6iuU6UIJ7+xWR0lCgm9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101558; c=relaxed/simple;
	bh=Siz/RJUIj81dn2eiSojkLngps4sGykzDIdKdNKIHhFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYjuHh601D6bBIf/dhkQvPR3StY3raRTdAabsr2qPdeeaudsCfZdihOmV4SLMzSHTCqRIwilr9oN7lui3LUMkbMUtjWAmT88l5L1rpeKrAAMm89fSIUAfLQGCO0n1p70w1dCoi+3FEpaXa2G3dnY6zIizQ4FxOioQxhNogccuQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoWxIV9P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoWxIV9P"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b8efed61so45176685e9.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776101555; x=1776706355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1P1CUrW7t0PnJ0ObVeIOrbq2OfUCtRYiUcSBw7BH2Y=;
        b=FoWxIV9PVq6dn19l7MW7OBjbVzvKaiymiGtxoEcREEiKFXDQmj/f3n4yaU4eTKRqja
         jYgembm9rl1r3o35xItnoKu0vK15nE9idapmAsKW5HbPi2qpprpaJT54HYNZTObZFTB7
         PlSnpL2H2UUkX4Jx7GZYzPir4FudJwT7hCz2JQPHReaoFxWa8QQY9f7juWiJg+F8K8oj
         NNjIUwOhSvInzGeJkhAav1cUtz6xah7xOBtQjXUwl8IQoBeKARUxHddoaGB/TYBjqD5a
         3UjIZcO4ewAVFFW/rTs9Crj4n3LsUYXfSkfV5UuiIBVJZN6kwPuMlSBXkyicycLn0wUy
         +GDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776101555; x=1776706355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1P1CUrW7t0PnJ0ObVeIOrbq2OfUCtRYiUcSBw7BH2Y=;
        b=pH5++MKCOO5cVMzvooCeK2IkrZb4ywLV6J3DoqT4Et6fZuoBZBQb3zB3y/jug615F9
         YK5RPuyVm+RGZCQZ8WvbUxGZ1fSOqImyGfGHMj7s4hA75yEWYLz2XHpld3hNQmBHgzif
         jk9AiG5gv5haL2cPgHG5AEfjZpeuM7Dy0E/l3r5shSjwZgROBtOTGBEtFNBYRy415JxK
         6aRChBawZPEgFmXuamBQpQKQunZto3R0w4B9p8ayyYEBjxN/RBfYMAp3hHFRHvBvC+rM
         ApHsu0QSFHx33susfoj/DNlypJVox7z/26Qs+QGuJ0ZP/B1J0/Cg/8tAAN6Uhd+PjGvm
         Qc1A==
X-Gm-Message-State: AOJu0Yy3g/x5hU8sXz+AkNMe1SGhh4nYVHH9/kyCJnj1Ahm8esx3hZmq
	ACJV+3WzO1gPwK0rv5YnQYKYHldfCwpyM781jM1eC+snCfn7cRfgoOlw
X-Gm-Gg: AeBDieukKzoNV+nDruff9ywqRy1bO+gAw2ICiYqeDTtQVuO2SH+18y94ngzEG7nYmtv
	GLmxaqDo2XmCK7pO8o9u44ev3+pdM2ehUgDITuR6kih21Fdru6BnQDDgqk9EsPeFj3wG3QtifVI
	iK3W8hoYrcaDa/phUZZwv5WIETvjbVywjV1xGKJufSc3AGHIibtyngErWVcv4RcKDJkf/2qTGYM
	w9rQv8apMwkGq9LaLLNxt+LdTsHagW5QSHtK61wy3PN7I4gY/X8zyu4fOKEjhwJsowgsSw2y5nP
	u6lKcC48A25y670LyngnNKSPriu7L0aFYUuLvy1a7vIYTZETBnhoVNIWacKu2CB/1PKuDshlBFB
	9tkdJtmOHF+7I0mBGsJcb7IjFlgNpjwL2yDdIVlYufGOxExcnbESw6zRmCWLDPGs/8LpHsiDBhd
	IKO5IG9P1fegdxtXkGScyVnvZtShjgvUfLqnyqqMazfMl0QeF1KXsdfGx6/TcUEF9B9NDrdaehD
	QHrb0hQ5ak=
X-Received: by 2002:a05:600c:698d:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-488d6ac9ce5mr200705715e9.14.1776101554919;
        Mon, 13 Apr 2026 10:32:34 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:699e:f085:b19f:def1? ([2a02:8109:a307:d900:699e:f085:b19f:def1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f1f9sm372374165e9.1.2026.04.13.10.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 10:32:34 -0700 (PDT)
Message-ID: <c9f44057-a6ab-4307-9a43-48aa870fc2e1@gmail.com>
Date: Mon, 13 Apr 2026 18:32:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 2/6] bpf: Add bpf_prog_run_array_sleepable()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
 <20260410-sleepable_tracepoints-v9-2-e719e664e84c@meta.com>
 <CAADnVQ+6s0U6dVV0r_RK4ATwmuJd+BiGvp_yTYwL58ac9GEhwg@mail.gmail.com>
 <76e88c11-fc18-42e1-920e-e0965b984689@gmail.com>
 <CAADnVQ+SUUQEmM_gA7tTEWV=N43m1zJoTT3_7poGJ8ndiViaqg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQ+SUUQEmM_gA7tTEWV=N43m1zJoTT3_7poGJ8ndiViaqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/13/26 5:25 PM, Alexei Starovoitov wrote:
> On Mon, Apr 13, 2026 at 5:55 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>>
>>
>> On 4/10/26 11:55 PM, Alexei Starovoitov wrote:
>>> On Fri, Apr 10, 2026 at 10:09 AM Mykyta Yatsenko
>>> <mykyta.yatsenko5@gmail.com> wrote:
>>>>
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Add bpf_prog_run_array_sleepable() for running BPF program arrays
>>>> on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
>>>> includes per-program recursion checking for private stack safety
>>>> and hardcodes is_uprobe to false.
>>>>
>>>> Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.
>>>>
>>>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>> ---
>>>>    include/linux/bpf.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 50 insertions(+)
>>>>
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index 0136a108d083..4e166accab35 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>>> @@ -3077,6 +3077,56 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
>>>>    void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
>>>>    void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
>>>>
>>>> +static __always_inline u32
>>>> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
>>>> +                            const void *ctx, bpf_prog_run_fn run_prog)
>>>> +{
>>>> +       const struct bpf_prog_array_item *item;
>>>> +       struct bpf_prog *prog;
>>>> +       struct bpf_run_ctx *old_run_ctx;
>>>> +       struct bpf_trace_run_ctx run_ctx;
>>>> +       u32 ret = 1;
>>>> +
>>>> +       might_fault();
>>>> +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held");
>>>> +
>>>> +       if (unlikely(!array))
>>>> +               return ret;
>>>> +
>>>> +       migrate_disable();
>>>> +
>>>> +       run_ctx.is_uprobe = false;
>>>> +
>>>> +       old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>>>> +       item = &array->items[0];
>>>> +       while ((prog = READ_ONCE(item->prog))) {
>>>> +               if (!prog->sleepable)
>>>> +                       rcu_read_lock();
>>>> +
>>>> +               /* Per-prog recursion check to enable private stack. */
>>>> +               if (unlikely(!bpf_prog_get_recursion_context(prog))) {
>>>
>>> from sashiko
>>>
>>>> + old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>>>> + item = &array->items[0];
>>>> + while ((prog = READ_ONCE(item->prog))) {
>>>> + if (!prog->sleepable)
>>>> + rcu_read_lock();
>>>> +
>>>> + /* Per-prog recursion check to enable private stack. */
>>>> + if (unlikely(!bpf_prog_get_recursion_context(prog))) {
>>>
>>> Can this cause a panic by dereferencing dummy_bpf_prog.prog.active?
>>> When a program is detached from a BPF array and memory allocation for the new
>>> array fails, bpf_prog_array_delete_safe() replaces the detached program with
>>> &dummy_bpf_prog.prog as a fallback.
>>> Because dummy_bpf_prog is a statically allocated placeholder, its prog.active
>>> field is uninitialized (NULL).
>>> If prog is dummy_bpf_prog.prog, bpf_prog_get_recursion_context() will
>>> dereference prog->active as a per-CPU pointer, accessing offset 0 in the
>>> per-CPU area and causing memory corruption or a panic.
>>> Should there be an explicit check to skip dummy_bpf_prog.prog here?
>>
>> Looks like a real issue, thanks. I think the best solution is to add
>> valid `prog->active` field for the dummy_bpf_prog.prog so we don't need
>> to maintain special branches and can rely on the being a valid bpf_prog.
> 
> No. Don't copy paste from claude. Ask it to do the home work.
> This was already discussed on the list.
> I mean 'oh it's NULL let's add it'. It was similar issue elsewhere
> and solved differently.

Actually claude suggested to simply check if prog == 
dummy_bpf_prog.prog, similarly to how it's done in kernel/bpf/core.c 
(for example function bpf_prog_array_copy_core()), but to me adding a 
valid `active` field sounds like a more future proof solution.



