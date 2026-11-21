Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795220516;
	b=ZG+aSIyDmlBK5NUUuHrLHzE7mneKF1kLkHCd1eq+s1PauEwCuO92kIIhERd3bjLfagdp
	 Eyu7WgDRx9y+RjYD7iOaQDgxLsxpkgJ1SAJelRIkrZvDWZ+NkwX1sTsjePl97yX7IOCyq
	 +95qaX2VxPcOTdPLPwVLcN5bms2HXF2s6aLglnX0XbqtLJDtHug1Tit0iEoT6rKE1n7dM
	 PQvdAOqz92wmLhwiTP6pZcAhQeqKsKBZ2tzEP9dbg0+WR2Zf+QZTOC+VjJW1jijCYHvP9
	 raWHo8hnyJDzwFY2hEic2wAcgWH+g1lUPU2T2HgA8yI/jBaEK1nW4Zc8Ryno2zAovyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795220516;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bPM/nVovpJ54b7mKH8TDEdoXXs0a3DNekD+ERhCMcf8=;
	b=P4BfgOkMYvNMt65RpSR7tNxWr51THktvmch5Xl5OD0zipm1NlIAItFpQeUFBKfEfyIl3
	 pxnc5kbGUNYpZdcdVgBVxDpAv0hBqTbKZuCCQYQb300WTFK7wpjJor9dmUFOPJwQ1auiO
	 fJNzYwchsuQG93+l7hYgmVAOw+bnNYPfsSG6DkcBVSzgMGawjqdBxETSzBigv94jrxCgV
	 43Jwt2nW0z2luqCFi4Fvm9GVFlQKcYxdBGam/qSbwdrtk4x3b6oeDgMGjlbolxfY/8xUF
	 1ueMzc15q2u06FS0dIwSlVlkb7Cyd5l23vx0mMx5TiZGf3Vj0v6pEs74bbTl1M0OZeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TEvyfsGd;
	arc=none smtp.remote-ip=95.215.58.249
Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E00606A6B8
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 00:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0E00606A6B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TEvyfsGd
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=71YmozTXEIZGZyvn9vxkEAc3WKEO/TnJFP1cWHJZLAI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795220504; v=1; x=1795825304;
 b=TEvyfsGdz7PVrIfx8g2hCvWcwF+Ym2gI6iujRSl6i2ZURtMALQ4DraaY7Nlc64rDjjG5BL0D
 I548gD2UD+J7SF8pMpCVHJr5KmuFMIpH3BqJUtg4DcnYHRsNFH+Z3txGPP+7v2EyEMyDCOEzRYd
 wYQ5bOf1HmiaoyBW93W36Kro=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0c17801dca966cf1;
	Sat, 21 Nov 2026 00:21:44 +0000
X-Mizu-Trace-ID: 0c17801dca966cf1
X-Migadu-Flow: FLOW_OUT
Message-ID: <c0fe98fe-767d-4f6d-8c43-20dc111984d9@linux.dev>
Date: Fri, 20 Nov 2026 16:21:40 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Test CO-RE relocations of
 signed enum values without kflag
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261120215012.870499-1-yonghong.song@linux.dev>
 <21bcff8573207e9277c3d209e6712adb4b6e76712b893cfba2e710443bf546d1@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <21bcff8573207e9277c3d209e6712adb4b6e76712b893cfba2e710443bf546d1@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/20/26 2:39 PM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Test CO-RE relocations of signed enum values without kflag
> TL;DR: Test issue: the new signed named_int_enum checks in test_core_enumval()
> may fail the enumval and enumval___no_kflag subtests on clang 12-14, which
> lack enum signedness kflag; should they be guarded by __clang_major__ >= 15?
>
>> diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
>> --- a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
>> +++ b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
> [ ... ]
>
>> @@ -85,6 +93,12 @@ int test_core_enumval(void *ctx)
>>   		out->uint_val1 = UINT_ENUM_VALUE(UINT_ENUM_VAL1);
>>   	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL2))
>>   		out->uint_val2 = UINT_ENUM_VALUE(UINT_ENUM_VAL2);
>> +
>> +	/* enum named_int_enum is optional */
>> +	if (bpf_core_enum_value_exists(enum named_int_enum, INT_ENUM_VAL1))
>> +		out->int_val1 = bpf_core_enum_value(enum named_int_enum, INT_ENUM_VAL1);
>> +	if (bpf_core_enum_value_exists(enum named_int_enum, INT_ENUM_VAL2))
>> +		out->int_val2 = bpf_core_enum_value(enum named_int_enum, INT_ENUM_VAL2);
>>   #else
>>   	data.skip = true;
>>   #endif
> Is this part of test_core_enumval() safe with clang 12 to 14?
>
> These checks sit under the same guard as the rest of the function,
> #if __has_builtin(__builtin_preserve_enum_value), which clang 12 and later
> already satisfy.  But clang only records enum signedness in the BTF kflag
> starting with LLVM 15 (enum64 support).  Before that, the local
> named_int_enum gets kflag 0, and so does the target enum built by the same
> compiler.
>
> With the libbpf change in this series, bpf_core_zext_enumval() then does not
> return early, and zero-extends the target value:
>
>      if (btf_is_enum(targ_t) && !BTF_INFO_KFLAG(targ_t->info))
>          res->new_val = (__u32)res->new_val;
>
> For INT_ENUM_VAL2 the local value is 1, so the GCC-form fixup in
> bpf_core_patch_insn() does not apply and the instruction is patched with
> 0xfffffffd.  out->int_val2 would then be 4294967293 while
> run_core_reloc_tests() expects .int_val2 = -3.  That would make both the
> existing enumval subtest and the new enumval___no_kflag subtest fail with
> clang 12 to 14.
>
> The neighbouring programs guard this compiler dependency, for example
> test_core_reloc_enum64val.c uses "#if __clang_major__ >= 15" and
> test_core_reloc_type_based.c uses
> "__has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15",
> both falling back to data.skip = true.  tools/testing/selftests/bpf/README.rst
> also says core_reloc sub-tests are skipped if Clang is too old to support
> them rather than failing.
>
> Should the named_int_enum part depend on __clang_major__ >= 15 so that it
> skips instead of failing, or silently leaving int_val1 and int_val2 at 0
> (which would also fail the comparison)?

I think we should be fine. In Documentation/process/changes.rst, the clang
minimum version is 17.0.1. Also, for this selftest, I don't think people will
build/run this selftest with `< 15' clang compiler.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44827034192

