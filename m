Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B11A51354F
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901875; cv=none; b=jqxGU5ZtPYB7PPh0EsOcHo9Vjd4/E1OV9aLxdofqD8lBIeeN6HFi0868LDPwaZ+vQVl+IaRpiYKlklRs/MA1Gnse7WMEIgjKssnmfKt3ckJKGD1NP6Yg5zwX4j9JkGwexdb6zoOwVrvvI0zYich3Rje4EYl/0Xtlu2BkqZzr3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901875; c=relaxed/simple;
	bh=aFdW3Sl2DZKCyvfpKxTeKspxeSwzXnp+EUtyc1/WGH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaW5FgaY/dAJyhbWHtTrnueqyvTreJX7F/BC8XTYypqEvNi604qgINZNq21aVo0fxJpVacZy6+rPZUttTFSuOFnMxwQoZg4W3S5SH+J4EhYqul77y301kmlFtmXyeJVrK89WJf8TezE4TFv2Srz6gjihp3/Cya6AsO5HdOo1po8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eoJlvh64; arc=none smtp.client-ip=91.218.175.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eoJlvh64"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aFdW3Sl2DZKCyvfpKxTeKspxeSwzXnp+EUtyc1/WGH4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791901871; v=1; x=1792506671;
 b=eoJlvh647ta7e54BFajN8zCUa+NouzYbkrznGYAZm4bjoOFNQmTnK/ByQJ01onAN1FtkVgVI
 d82sV4qaNjL0/XZoS8MIPA4J20x6lwXFHFGmWuhgy7X9NyXAVj9ad6GoxebiEu5aiWAxXzREyeu
 /DroAWWAXLghlgUIhYrPuJIY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e5967c2a850c3aa8;
	Tue, 13 Oct 2026 14:31:10 +0000
X-Mizu-Trace-ID: e5967c2a850c3aa8
X-Migadu-Flow: FLOW_OUT
Message-ID: <95eb26fb-f44e-48df-a549-5c2a9959f88c@linux.dev>
Date: Tue, 13 Oct 2026 07:31:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 09/11] selftests/bpf: Test trampolines on more
 BPF functions with stack args
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261013003515.1860439-1-yonghong.song@linux.dev>
 <e1e2e14c0e37c53d1bee32ec10d50b60f46c645c37b2b1cbf832a66c8fb84967@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e1e2e14c0e37c53d1bee32ec10d50b60f46c645c37b2b1cbf832a66c8fb84967@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/26 3:28 AM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Test trampolines on more BPF functions with stack args
> TL;DR: Nit only: the callee_split() comment in the selftest says h is split
> between register and stack, but that is x86-64 specific; on arm64 nothing is
> split. Suggests saying so.
>
>> diff --git a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
>> --- a/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
>> +++ b/tools/testing/selftests/bpf/progs/tracing_struct_int128_tgt.c
> [ ... ]
>
>> @@ -44,6 +44,25 @@ static __noinline __u64 callee_stack(__u64 a, __u64 b, __u64 c, __u64 d,
>>   	       i * 10;
>>   }
>>
>> +/* BPF code splits h between the last argument register and the stack. */
>> +static __noinline __u64 callee_split(__u64 a, __u64 b, __u64 c, __u64 d,
>> +				     __u64 e, struct int128_arg h, __u64 i)
>> +{
>> +	return a + b * 2 + c * 3 + d * 4 + e * 5 + (__u64)h.v * 6 +
>> +	       (__u64)((unsigned __int128)h.v >> 64) * 7 + i * 8;
>> +}
> This isn't a bug, but is this comment accurate for every architecture this
> test runs on?
>
> test_int128_tgt_prog() is built for x86-64 and for arm64, and a..e already
> occupy R1-R5 in BPF terms, so h and i are each stack arguments as far as
> the BPF ISA is concerned.
>
> The split between a register and the stack only comes from the x86-64 JIT,
> which maps the first stack argument slot to r9:
>
> arch/x86/net/bpf_jit_comp.c:x86_arg_reg[] = { BPF_REG_1, ..., BPF_REG_5,
> X86_REG_R9 }
>
> On arm64 the first three stack argument slots are mapped to x5-x7, so h
> would land in x5/x6 and i in x7, with nothing split.
>
> The commit message already says "on x86-64 it is passed split between r9
> and the stack", and the comment on the neighbouring callee_stack() names
> x86-64 and arm64 separately.
>
> Could this comment say that the split is x86-64 specific, for example "x86-64
> BPF code passes h in r9 and its first stack slot"?

You are right. The comment is not good. Will fix.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38329598343

