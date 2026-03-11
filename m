Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25A248873
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773210054; cv=none; b=PpS+WdGGRS1lxXLNZH7/wBRcShCgk+6TVcqVfc06Udh3yEKpR7maZFd/+Itzozufsg/FoObRXY5TexzGKM9k4Ynai8CwSYRvlklrI7Wtwvmn23S7cd8Zbu6Dd8rrHzp06I4EHxqc2gSqKCr/PkE3E/n/uey0zbYgCeVAUHqsywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773210054; c=relaxed/simple;
	bh=ZQtkgsk7hL3UJK4JcFTUmbrcGoAF72EzVACCBw3wpWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/DjuMLFlF0bPkS1N8Em78JJqdTjn2Qbm4+tgKeYrGISWD4qhhvxuV7zCmJlga4+ghEvpPVOQy4Uj85aLO/p/ixwBpLRwQywdHp+84fWXzoCs2HdSebW+kGbPb5Lgq6wl0EN1rDXCaOx85bRhwUQGxDHP30cCHzATvy3BXiHO1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CopyQ53b; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CopyQ53b"
Message-ID: <ea235f43-095a-4c21-8d4a-32bec84bf7c7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773210050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiiLtqMY3EaT7Cd4bvIVIdcgg7CNB1uqWrPRibdl/E4=;
	b=CopyQ53bqyO7qoQnUYwaUGVQH9yyzXBu77kPfm7ij6mISUZz1u/4Ezg8e2VPjnR68x1k6C
	IbuANXM3dk15wCHAot1+ijiAFR1cfCWmqSkycCkt/QoAB3OHKdf/2UwG2Mb0bmKTLyTtu9
	XygFCAsuv4Gsz2thxsXOy3exmjbXZOQ=
Date: Wed, 11 Mar 2026 14:20:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpftool: Enable aarch64 ISA extensions for
 JIT disassembly
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, bot+bpf-ci@kernel.org,
 puranjay@kernel.org, bpf@vger.kernel.org
Cc: puranjay12@gmail.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, mykyta.yatsenko5@gmail.com, qmo@kernel.org,
 kernel-team@meta.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260310223456.1706712-1-puranjay@kernel.org>
 <3d287b2ab8fe7ee19b3e6c98a58aba501ac191339b7f34960b5bc804ae6a23ab@mail.kernel.org>
 <41c6f48d-1e45-40b2-b2b0-7035cadfa1de@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <41c6f48d-1e45-40b2-b2b0-7035cadfa1de@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Yonghong Song wrote:
> 
> 
> On 3/10/26 4:05 PM, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/
>>> jit_disasm.c
>>> --- a/tools/bpf/bpftool/jit_disasm.c
>>> +++ b/tools/bpf/bpftool/jit_disasm.c
>>> @@ -93,7 +93,16 @@ init_context(disasm_ctx_t *ctx, const char *arch,
>>>           p_err("Failed to retrieve triple");
>>>           return -1;
>>>       }
>>> -    *ctx = LLVMCreateDisasm(triple, NULL, 0, NULL,
>>> symbol_lookup_callback);
>>> +
>>> +    /*
>>> +     * Enable all aarch64 ISA extensions so the disassembler can
>>> handle any
>>> +     * instruction the kernel JIT might emit (e.g. ARM64 LSE atomics).
>>> +     */
>>> +    if (strncmp(triple, "aarch64", 7))
>>> +        *ctx = LLVMCreateDisasmCPUFeatures(triple, "", "+all", NULL,
>>> 0, NULL,
>>> +                           symbol_lookup_callback);
>>> +    else
>>> +        *ctx = LLVMCreateDisasm(triple, NULL, 0, NULL,
>>> symbol_lookup_callback);
>> Isn't this condition inverted? strncmp() returns 0 when the
>> strings match, so when triple starts with "aarch64" the condition
>> is false and the else branch runs, which calls the old
>> LLVMCreateDisasm() without any features enabled.
>>
>> Conversely, for non-aarch64 targets (e.g. x86_64), strncmp()
>> returns non-zero, making the condition true, and
>> LLVMCreateDisasmCPUFeatures() with "+all" gets called on the
>> wrong architecture.
>>
>> It looks like this should be:
>>
>>     if (!strncmp(triple, "aarch64", 7))
>>
>> The v1 of this patch used strstr(triple, "aarch64") which has the
>> correct polarity (returns non-NULL on match). The switch to
>> strncmp() for v2 appears to have lost the negation.
> 
> AI is correct. The condition should be
>     if (strncmp(triple, "aarch64", 7) == 0)
> 

Agreed.

After addressing it,

Acked-by: Leon Hwang <leon.hwang@linux.dev>

[...]

