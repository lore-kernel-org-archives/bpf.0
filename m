Received: from mta0.migadu.com (out-244.mta0.migadu.com [91.218.175.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBEB3B71D1
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787941279; cv=none; b=CDre4rctnquRRxYg6W76EN2KQxO7Ayl+YHLZjQuuT0bA5TbL3IMGRSinQEiM2z2uzT+6+5g8pktsGQ1/56ufXS+v8zUIIw0xGi5DS/A9r5cchhBn8Qbu+T9K0t/BW/VQq1cmBZ/ZZmZnoaBgHP2nQSXTS9qxOEBfp25mq6e0FEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787941279; c=relaxed/simple;
	bh=nBH3qiBd4ZDhbHEDSGRL9W0vIATCIRGCA9kijbwtm4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXCQQn5TIgDdJlMyGkHpvUQho/IOu3BqKeD4GRAFcEYvS2Xo9ILuaZEL0HK5EZwgtDsmgO6aCVOI4jDqBKnlIu+GozGxcgDhiAsMyziWilfCFJ+WtBNhkloisctZX1EiWWuLYuH3NKpHzoH2KZiSssnzCF/wrGi5uwsbNgbMElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ssm90vHe; arc=none smtp.client-ip=91.218.175.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ssm90vHe"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nBH3qiBd4ZDhbHEDSGRL9W0vIATCIRGCA9kijbwtm4s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787941274; v=1; x=1788546074;
 b=ssm90vHeS/jBMxRcBZO8KeZ6O+yu2mELQU1wFBd0d9nSNDM2LkAUThC0VUJyyOIha2snUKny
 mlRuLzZ53ThnRxGN4GXsqlPEo2uiVwQxwsMXXAjbUJ2EFs+qxb6XKWiMbTG+4ZLnG5PzZnENR15
 Vq1ZlQbC0F/0N60MoAOlQ0Ec=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8d71022c6d759fc0;
	Fri, 28 Aug 2026 18:21:04 +0000
X-Mizu-Trace-ID: 8d71022c6d759fc0
X-Migadu-Flow: FLOW_OUT
Message-ID: <30814c10-1db6-45f1-8a22-5adb7af78a58@linux.dev>
Date: Fri, 28 Aug 2026 11:20:56 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 08/11] selftests/bpf: Check the member named
 for an unsupported kfunc return type
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260827061155.2518937-1-yonghong.song@linux.dev>
 <a029d698010cf5a0306af0758d0b2d9454903521e299f0c84bc0c26864618168@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a029d698010cf5a0306af0758d0b2d9454903521e299f0c84bc0c26864618168@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/27/26 12:04 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
>> index f10e5cf6fd890..e9c82df8efb26 100644
>> --- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
> [ ... ]
>
>> @@ -72,6 +74,7 @@ __naked int aggregate_ret_kfunc_fastcall_fail(void)
>>   SEC("tc")
>>   __arch_x86_64 __arch_arm64
>>   __failure __msg("is not composed of scalars or arena pointers")
>> +__msg("member 'p' has type PTR")
>>   __naked int aggregate_ret_kfunc_ptr_fail(void)
> [ ... ]
>
>> @@ -84,6 +87,37 @@ __naked int aggregate_ret_kfunc_ptr_fail(void)
>>   	: __clobber_all);
>>   }
>>
>> +SEC("tc")
>> +__arch_x86_64 __arch_arm64
>> +__failure __msg("is not composed of scalars or arena pointers")
>> +__msg("member 'in.p' has type PTR")
>> +__naked int aggregate_ret_kfunc_nested_ptr_fail(void)
> [ ... ]
>
>> +SEC("tc")
>> +__arch_x86_64 __arch_arm64
>> +__failure __msg("max struct nesting depth exceeded")
>> +__naked int aggregate_ret_kfunc_too_deep_fail(void)
>> +{
>> +	asm volatile (
>> +	"r1 = 0;"
>> +	"call %[bpf_kfunc_call_test_ret_deep];"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(bpf_kfunc_call_test_ret_deep)
>> +	: __clobber_all);
>> +}
> A subsystem pattern flags this as potentially concerning: the commit
> message states the third case covers "a type nested deeper than the
> walk descends, which has no single member to blame and reports the
> depth instead." But the test's only assertion, __msg("max struct
> nesting depth exceeded"), pins a string that predates the series.
>
> Looking at the verifier code, the depth report text ' It nests structs
> more than %d levels deep.' was added by commit b99471ca9c385, and
> unlike the member case there is no verbose() counterpart for it - it
> is only emitted through bpf_diag_program_structure(). This diagnostic
> output is reachable to __msg since libbpf retries a failed load at
> log_level 1.
>
> If the new path->too_deep assignment and the entire 'if (path.too_deep)'
> branch were deleted, path.depth would still be 0 (the too-deep return
> bypasses the bad_member/bad_path labels), member_note would stay "",
> and nothing else would change in the log. The test would still pass even
> though the new behavior was not present.
>
> The two sibling tests don't have this problem - 'member 'p' has type
> PTR' and 'member 'in.p' has type PTR' are both new strings from
> b99471ca9c385 and directly verify that the kernel names the member
> correctly. The too_deep test also omits the __msg("is not composed of
> scalars or arena pointers") anchor that both siblings carry, so it does
> not even pin that the failure came from the kfunc-return path.
>
> Would adding an assertion on the depth diagnostic text plus the anchor
> message make the case more discriminating?

I would like to keep it as is. For path.too_deep, we do not need to
have member names. The user only needs to take a look at the top
struct which is already available.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33045482525

