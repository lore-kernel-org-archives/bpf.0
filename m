Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A6E17BCA
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783389806; cv=none; b=ePhoEzfj68IyL0dzOndn1vaX9TiIqex5pXoxajurr9/45q9oZwgeeI+ovs7cgDoeu59YpU/KWHX2X8ILT7jsF7cBFXSn+kASMpNYYkrWPvraZyEmpJYzNQ41Lt0J8MiBMrMWWzX6wqihO6ENsaAW+eU1poH9CbyueqjS8hA/Mfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783389806; c=relaxed/simple;
	bh=pzhXqQJWUzVyJeN0FWY9ha5GoBBPo1m8KqsCffY7KoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8fxvwQoS3yxQi7Yw4G1PqbN05Tj2t6MV31w+zMqCebf2jVXZeZhc+3IFahF7BOcEgPbC/eYhuLtiIiXHHeOluEDHj/9aRf3WiscMUbG/bk/2J4spyRr2V35bP69wrjIylA2TTOErBvm90u6vDGbvxUUh7ie7+d+bABdeWFTfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c3Wb93rv; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c3Wb93rv"
Message-ID: <e86ba5c0-41c2-4492-a316-7693c7d8d3fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783389792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZijWm4GdBO99h0mVu1NLMKXZxw20wl2J7qO9trTUvs=;
	b=c3Wb93rvq6ra5wM8trKYU7Hsj3cphHNseVyd7hbg9uRnS8wruJRWn08uK0Y8mKDXjPoQSC
	9a/6GCOwmLDGb1ZKPZSndzK20TSJ0W7yHHDpPHKG4qnWTVTVF7RdglKNuadhHe8s6qIlY6
	3ZPdioAZpQweKjt+KtRzcMg+FD6CAjM=
Date: Tue, 7 Jul 2026 10:03:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 2/2] bpf: Reject programs with inlined helpers
 if JIT is not available
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev,
 Puranjay Mohan <puranjay@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
References: <20260706040006.10331-1-yangtiezhu@loongson.cn>
 <20260706040006.10331-3-yangtiezhu@loongson.cn>
 <abd697d839043d80e0230d2b9ab30b214dfa34d7.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <abd697d839043d80e0230d2b9ab30b214dfa34d7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/7/26 05:41, Eduard Zingerman wrote:
> On Mon, 2026-07-06 at 12:00 +0800, Tiezhu Yang wrote:
>> When an architecture (such as LoongArch, ARM64, and RISC-V) implements
>> bpf_jit_inlines_helper_call(), the verifier skips rewriting the helper
>> call offset (insn->imm) during the bpf_do_misc_fixups() phase, because
>> the helper is expected to be inlined by the JIT compiler. As a result,
>> insn->imm remains as the raw helper enum ID.
>>
>> However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0) or
>> if the JIT compilation later dynamically fails (e.g., due to OOM), the
>> core BPF subsystem falls back to the BPF interpreter.
>>
>> When the interpreter executes (__bpf_call_base + insn->imm) with the
>> unpatched raw helper ID, it jumps into an unaligned invalid address
>> space, triggering an instruction alignment fault or a memory access
>> panic.
>>
>> Fix this by setting 'jit_required' to 1 when helper call rewriting is
>> skipped for JIT inlining. Loading will be rejected early with -EINVAL
>> if JIT is disabled, or safely rejected with -ENOTSUPP during runtime
>> selection if JIT compilation dynamically fails, effectively preventing
>> the kernel panic.
>>
>> Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Suggested-by: KaFai Wan <kafai.wan@linux.dev>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
> 
> Sorry, I'm late to the party.
> As far as I understand, the patch #1 doesn't really change anything functionally,
> it just adds the flag, right?
> 
> As for the patch #2 and looking at the helpers that jits currently inline:
> - bpf_get_smp_processor_id (implemented as a function in the helpers.c)
> - bpf_get_current_task (implemented as a function in the bpf_trace.c)
> - bpf_get_current_task_btf (implemented as a function in the bpf_trace.c)
> 
> It is perfectly fine to call these as helper functions even if jit is
> not available. But this was broken since:
> 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
> from May 2024, so I guess nobody really cares?


Vincent Thiberville reported an interpreter fallback issue for the
internal BPF_ADDR_PERCPU insn [1]. And, I was trying to fix assorted
interpreter fallback issues [2].

I think it is worth fixing the interpreter fallback issue for the JIT
inlineable helper.

[1]
https://lore.kernel.org/bpf/MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM/
[2] https://lore.kernel.org/bpf/20260626154330.33619-1-leon.hwang@linux.dev/

Thanks,
Leon

> 
> Imo, the simplest and least intrusive fix is to add a wrapper in the
> verifier.c that would call both bpf_jit_inlines_helper_call() and
> check if the jit is enabled and use that wrapper instead of direct
> calls to bpf_jit_inlines_helper_call().
> 
> Anyway, since this was broken all-along, might as well land as-is.
> Thoughts?
> 
> [...]

