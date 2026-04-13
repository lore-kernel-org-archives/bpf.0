Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B463C2770
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084942; cv=none; b=dXW1BRZxgDcAChd9099/N7Z+BzVBnWpj+31i3B5goF9A74/DKnSZAgXyuxqq9A+g2Z59CfHnzOg9DBq35HxUADN4v4XZHeQruHyuaDHicyJoBKPeqvpD82fg7UcjzDolMu91F/CUUIEmi5TXsPnc0FTBeHkbJ6QOAFOHLUtoZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084942; c=relaxed/simple;
	bh=Y3hlRLHyBcfwyl+W3Am1VL3ZEtEna5WlQZGSYTY2Kak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sz+vP2pdzTYAujkmPLGiWO01L+EHfDdMjLrFEtLym1vnJdfoS6cicUsKZwRzlsDTgnPF7NPNgqAY/lt9ujLA2XayFJ47AsdUM1kWaWKWQGh3R5oEXH6FXYq7MS5MeSiXIBYmND0PirhnN58gKof1l9kO2iiGIhsKd7jylXVX2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh7uGp4L; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh7uGp4L"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6709d172dd3so2997649a12.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 05:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776084939; x=1776689739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOciD5j2zkhvaZlo8kvya+zVe7Ak1F76IZ5ZmFc7+r8=;
        b=hh7uGp4LSaJQijm3yoqpPw0SRhGkaucDnfZo4N7yYNILSlZcdhSmljfvX9tw0VVOO/
         +BZlixpzWzMOcD8Jyu3V2Wn+34vNm4HJN4YBAMc0xV+euKyRWcJOcSU78GBvYG+Aw5Bz
         wcgJnEabfVycTpn/IWSM61K2BYHjj243wuNr54uH/hFr6ggEER+EfQVoLHicEgxQ4JH9
         44HeaieeTrTf//bTiv41c25hzGgZz7MpeI3IsOwIDxJOpTCt+s6fXYOopmGiK4uzqXTQ
         cM1FeAM9C/CGDBf64+ytmNSZD4TXyQzjd7YWt3yKzmggESNObzGqgXQPGPpcCDHOoZfQ
         qLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776084939; x=1776689739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOciD5j2zkhvaZlo8kvya+zVe7Ak1F76IZ5ZmFc7+r8=;
        b=BwpExUXDN5ecUUMCgws6qY+iVNtuIhy1HLzWjILj2XjPpv2kTh9BgX7SbIPt9LHG83
         +xaLpINDlXcxPERqpE8Bgdxysyhqwqf4WsTByVpO89b24nVzhk4PQv3X8cqSJ7tmrFkU
         YDdP7RlND5NCyIprr+Xk1Js/UWi2PgKDh749jcYhwAvBU6v4D+0tTQQHbMy+M1O0nxBe
         H3NBAF7wjHOOWsi0BE6wOW8QTankMUib/f35h7hty15/i9nPW0PGXa/YolvOqnZJt613
         6h+MrvnusoE+LZF7Wf9Lzq53UWoFL7tTAVlIMWlPBIzioJ4aZHfo4oYO5UNrpnq0Q2nO
         HVRg==
X-Gm-Message-State: AOJu0Yx8jmrNSUu6TuGReXj8qEXzuXJTl5yoo8L3yuwmiTXuv2RwmEt4
	9ZS4bkJhlAV16nkkKcmRo6C0WSXwpwq/REMD4RRu/8i5rSPbXyWL/nCX
X-Gm-Gg: AeBDievw+hTgmYXBLWrv2WP0xc8P3AzPRldeRhzhC63YRn3o749OT7MA5y16u9YyVji
	O85J/SNji1crMpmqORVZ/BDgtlnTzG+MJgsGcOx3Mb5ytS7HQP8uCnALlAvkNXV2zjtNTwDLdWr
	JkYOJiVoDKLyKrwgi4lItNDbOr7rss9B1ADyjnmf8RZY/1CvbLySXfmeyHbxohjUObmBPPjc6J5
	VdVWvzTUw8bt6FQ3FFoi0+9i2FCuItf7qMK9iuKPjNftG7P7jV2NknGtmnIJRZgTNoKLXLuKSxv
	dkE/PnRItWI6XDoTpfgu+2OYO1/AsLpNxSkBZfMgi375SxTBk1XNJ4DEMk+exwPjRt7N2Ch6oc3
	Kwmzbg4MQC/HlL5JFsyf28U7ip8J2XWqqHRqNnG4P723dObGHWuHbWnvLv6iKwxzypz7wSywKKj
	Po7qR9+scQbc8RtTY7NQWErz5uGWxvf81A5rR00WDGxcaTe69QmzaYbtMJ6qF6M187IKbSKS9Xp
	pcG1VAzguU=
X-Received: by 2002:a05:6402:5644:b0:671:8e48:920a with SMTP id 4fb4d7f45d1cf-6718e489360mr1023652a12.5.1776084938855;
        Mon, 13 Apr 2026 05:55:38 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:1086:f5f1:32fc:93b3? ([2a02:8109:a307:d900:1086:f5f1:32fc:93b3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-670702eec2bsm2412087a12.5.2026.04.13.05.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 05:55:38 -0700 (PDT)
Message-ID: <76e88c11-fc18-42e1-920e-e0965b984689@gmail.com>
Date: Mon, 13 Apr 2026 13:55:36 +0100
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
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQ+6s0U6dVV0r_RK4ATwmuJd+BiGvp_yTYwL58ac9GEhwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/10/26 11:55 PM, Alexei Starovoitov wrote:
> On Fri, Apr 10, 2026 at 10:09 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add bpf_prog_run_array_sleepable() for running BPF program arrays
>> on faultable tracepoints. Unlike bpf_prog_run_array_uprobe(), it
>> includes per-program recursion checking for private stack safety
>> and hardcodes is_uprobe to false.
>>
>> Keep bpf_prog_run_array_uprobe() unchanged for uprobe callers.
>>
>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   include/linux/bpf.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 0136a108d083..4e166accab35 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3077,6 +3077,56 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
>>   void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
>>   void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
>>
>> +static __always_inline u32
>> +bpf_prog_run_array_sleepable(const struct bpf_prog_array *array,
>> +                            const void *ctx, bpf_prog_run_fn run_prog)
>> +{
>> +       const struct bpf_prog_array_item *item;
>> +       struct bpf_prog *prog;
>> +       struct bpf_run_ctx *old_run_ctx;
>> +       struct bpf_trace_run_ctx run_ctx;
>> +       u32 ret = 1;
>> +
>> +       might_fault();
>> +       RCU_LOCKDEP_WARN(!rcu_read_lock_trace_held(), "no rcu lock held");
>> +
>> +       if (unlikely(!array))
>> +               return ret;
>> +
>> +       migrate_disable();
>> +
>> +       run_ctx.is_uprobe = false;
>> +
>> +       old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>> +       item = &array->items[0];
>> +       while ((prog = READ_ONCE(item->prog))) {
>> +               if (!prog->sleepable)
>> +                       rcu_read_lock();
>> +
>> +               /* Per-prog recursion check to enable private stack. */
>> +               if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> 
> from sashiko
> 
>> + old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>> + item = &array->items[0];
>> + while ((prog = READ_ONCE(item->prog))) {
>> + if (!prog->sleepable)
>> + rcu_read_lock();
>> +
>> + /* Per-prog recursion check to enable private stack. */
>> + if (unlikely(!bpf_prog_get_recursion_context(prog))) {
> 
> Can this cause a panic by dereferencing dummy_bpf_prog.prog.active?
> When a program is detached from a BPF array and memory allocation for the new
> array fails, bpf_prog_array_delete_safe() replaces the detached program with
> &dummy_bpf_prog.prog as a fallback.
> Because dummy_bpf_prog is a statically allocated placeholder, its prog.active
> field is uninitialized (NULL).
> If prog is dummy_bpf_prog.prog, bpf_prog_get_recursion_context() will
> dereference prog->active as a per-CPU pointer, accessing offset 0 in the
> per-CPU area and causing memory corruption or a panic.
> Should there be an explicit check to skip dummy_bpf_prog.prog here?

Looks like a real issue, thanks. I think the best solution is to add 
valid `prog->active` field for the dummy_bpf_prog.prog so we don't need 
to maintain special branches and can rely on the being a valid bpf_prog.

