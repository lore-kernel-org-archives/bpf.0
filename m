Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77B33AD8B
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875167; cv=none; b=FcypSMMQVP0byxIpSk8jHdBC4azmcqQKkCc2SxmyPsH2g4CEUCko6sjlgCLs4heNA14gkaASCRuoYkvDbdyyg8y7sYxrXyxJLShATX9FSdE/0LyOEwfXZdPmMMtSTt1wndTq5h0SO8MX8+GNzkTM3JblvybtNWvDzJqtfDs2R/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875167; c=relaxed/simple;
	bh=MYfIfv5sA2j2ZR1qxs4rUMsP9wT5v/lsb+MQsfSaJjg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VNn+madEF9hd3YrWrqptV2cwtE1SL8nCB9MqFkRGNR/WXYURTFgp1xDPUoUhOEG24oyh2WbrkIqYwQK5w5veUrT86uDr46vJWvALfTG3afojvCusVrEPQYl1o8u8fHZMMnEbr7px9+KjWEDzw0udccm0gTF7Z7Wg92VjD0N58t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KZ+R2IGP; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KZ+R2IGP"
Message-ID: <75fb9794-938e-4341-ae43-fdf0bdfc48f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782875154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5va4XwV5vfWNlbm7XiNFDbaDpwHzr9Lkk4cpeHFVto4=;
	b=KZ+R2IGPW6Iwf5TqLOttN86vQX8yQx0YifyL1jM4R7IT9njYNnjf0+fb+263+PwVN/O5im
	P3VkO431GXlKw6B+SMNUjwL6St29hWSfGloiLaLYkfI973GF8HAxyxn1fOnh9RvQWuViwy
	w7xtFEojrdoPA7H+3i+6A+Xp4Vu4bpg=
Date: Wed, 1 Jul 2026 11:05:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf 0/6] bpf: Disallow interpreter fallback for
 interpreter-unsupported insns
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Anton Protopopov <a.s.protopopov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260626154330.33619-1-leon.hwang@linux.dev>
 <DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com>
 <18678d0c-f878-4d7b-bf7e-ffca4967dec5@linux.dev>
In-Reply-To: <18678d0c-f878-4d7b-bf7e-ffca4967dec5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/7/26 10:59, Leon Hwang wrote:
> On 1/7/26 07:12, Alexei Starovoitov wrote:
>> On Fri Jun 26, 2026 at 8:43 AM PDT, Leon Hwang wrote:
> [...]
>>
>> I don't think we need such fallback in patch [3].

Sorry, it seems I misunderstood the 'patch [3]' as the patch #3 of this
series.

Will discuss the fallback further in the sibling thread:
https://lore.kernel.org/bpf/af9c0a7e-13de-c227-849f-4b35d1fb74ff@loongson.cn/.

Thanks,
Leon

> 
> Do you mean we can add the internal BPF_ADDR_PERCPU insn support to the
> interpreter?
> 
> See my reply in "PROBLEM: BPF interpreter fallback after JIT compilation
> of BPF_ADDR_PERCPU leads to kernel panic" thread [1].
> 
> [1]
> https://lore.kernel.org/bpf/90c32de0-feac-4e63-9757-2a1d115be08c@linux.dev/
> 
>>
>> And approach taken by this set also doesn't scale, since it splits
>> the verifier/JIT logic into core.c which will be hard to keep consistent.
>> I think we need another bit like jit_requested in prog like 'must_jit'
>> that the verifier set for addr_space_cast, kfuncs and the rest.
>>
>> Then the core.c change will be:
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 649cce41e13f..5126a43c1b81 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2620,7 +2620,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>>                 goto finalize;
>>
>>         if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
>> -           bpf_prog_has_kfunc_call(fp))
>> +           fp->must_jit)
>>                 jit_needed = true;
>>
> 
> Got it. Will follow your suggestion.
> 
> Thanks,
> Leon
> 

