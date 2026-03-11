Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658340DFB1
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 03:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773201091; cv=none; b=qt4f1u+NW+725EsFb7Nn/CpXt/dFuXFReUDgpstCd/gr0LV9KzhbngQXyV4PpVSDQy51ea4srFJC/+iY5loHrbOKbXXSYufYII5AXsWZdkPZ5K40kCqP/ZuFAasLUpe7Do69ferDKifFpZYByR2EYLVZEOaAGKFSnM0iPQba0yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773201091; c=relaxed/simple;
	bh=DT7T+cl/1Nkq6EIRFrSJVAdig3KXPY67hKYABrKWPlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kx3MXd9qWpNKUCKfaqN2ujmQq8pZKIvqt1tWkt9rTEMJ3iIIgKi6aK/H4DcpXHebo5dkRdenOATdvdTCGwC/zvden4UEuT8azmSCBBOLg5+h77vjl4sVUghAcJWQZfXeIKh/V9LjXWxULRCJsiV3FYY6doMnG6a3YFrSiZDkef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GSBlYgvH; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GSBlYgvH"
Message-ID: <41c6f48d-1e45-40b2-b2b0-7035cadfa1de@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773201086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6eJCyoeQynUN1ZkTizwf+hLDFWlqpChT33ds2EARgQ=;
	b=GSBlYgvHAQxVP10tCab60Z3YGlVoFYKIXj9toV8V6vniLVwpQJdRaDdLLCFoxGgNOvYNAM
	iZ5Y9R4Yi9/0uD2pl449gebGQBB06onr1SzFGmAHPtVc6uCcmB9k4qrDqQ7vu7R0sz6pNS
	/iBPow6WQpwp7absJN4P0+B54uX/Bxo=
Date: Tue, 10 Mar 2026 20:51:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpftool: Enable aarch64 ISA extensions for
 JIT disassembly
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, puranjay@kernel.org, bpf@vger.kernel.org
Cc: puranjay12@gmail.com, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, mykyta.yatsenko5@gmail.com, qmo@kernel.org,
 kernel-team@meta.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260310223456.1706712-1-puranjay@kernel.org>
 <3d287b2ab8fe7ee19b3e6c98a58aba501ac191339b7f34960b5bc804ae6a23ab@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <3d287b2ab8fe7ee19b3e6c98a58aba501ac191339b7f34960b5bc804ae6a23ab@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/10/26 4:05 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
>> --- a/tools/bpf/bpftool/jit_disasm.c
>> +++ b/tools/bpf/bpftool/jit_disasm.c
>> @@ -93,7 +93,16 @@ init_context(disasm_ctx_t *ctx, const char *arch,
>>   		p_err("Failed to retrieve triple");
>>   		return -1;
>>   	}
>> -	*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);
>> +
>> +	/*
>> +	 * Enable all aarch64 ISA extensions so the disassembler can handle any
>> +	 * instruction the kernel JIT might emit (e.g. ARM64 LSE atomics).
>> +	 */
>> +	if (strncmp(triple, "aarch64", 7))
>> +		*ctx = LLVMCreateDisasmCPUFeatures(triple, "", "+all", NULL, 0, NULL,
>> +						   symbol_lookup_callback);
>> +	else
>> +		*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);
> Isn't this condition inverted? strncmp() returns 0 when the
> strings match, so when triple starts with "aarch64" the condition
> is false and the else branch runs, which calls the old
> LLVMCreateDisasm() without any features enabled.
>
> Conversely, for non-aarch64 targets (e.g. x86_64), strncmp()
> returns non-zero, making the condition true, and
> LLVMCreateDisasmCPUFeatures() with "+all" gets called on the
> wrong architecture.
>
> It looks like this should be:
>
> 	if (!strncmp(triple, "aarch64", 7))
>
> The v1 of this patch used strstr(triple, "aarch64") which has the
> correct polarity (returns non-NULL on match). The switch to
> strncmp() for v2 appears to have lost the negation.

AI is correct. The condition should be
	if (strncmp(triple, "aarch64", 7) == 0)

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22927610334

