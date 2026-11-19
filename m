Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.208
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103869;
	b=eoD4i+EJPLLTSSWTwUDNPjn/dBaHL6AkTRS0NPaGBwtdcpp/wzO8hyrQ8Lwxa7p70ofi
	 pzj0HDEWKovjvWtKIaj7hoEspiaylLKelUi/0Rm8kpi098rPL2NsdzTMAz30HKyNmdP4R
	 XAbtMroIWS7WDfJq78uv/F6b24oMCdjkgBvbYa3lIQy+fOHKJkcI24lm5TF+MTkJgUVRI
	 kHGqVXWf9jcSE5w4f/F47kXrxJ3BtsHpsjo0CmbXpWOLOzS+0SeF2kU6czkV/tIJCDoGJ
	 rkruaYmnAR6rPqSN07fblk5/4hC270k44c9W10QyL96pUgiZj9Ryj0bdN7Tkp1JMwGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103869;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6UWrlS/skRUldXJXG7x98Qy8ovQTf/v121kIzkHXTNA=;
	b=o5pmGGvPAM4p1O/FkFnW7r2Mhnnx1r6iEXBVfIS/BX3/VIU0M9/6jjZAAHBE40+IIww3
	 cDvc9tlxOqyBXHQPD03OEax+qQYOg60LmPPeMQYj3qjRbh4FuvU46LpuhtM+AT+Q3oLBG
	 Gp+As4XvlN5TqgoNAJv1JKz8H8GWHfO7UpZs4OLrCbmztN2sQAm62zAHQO6nGFJaBjWtG
	 BgP2sS04oDFfbnEpJN9q5Pu2Prb8rnJfe9juqivPpShqyGq7g7aLLwBV5rdNSf0YUafrN
	 SXKmAuEk+oH1q7ty8VvT5gKQ2R8jlGA80mdhWmLiZ4yaSELCNZX5yVyHKSqC8YLgTfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OQjrM4Xz;
	arc=none smtp.remote-ip=95.215.58.208
Received: from mta1.migadu.com (out-208.mta1.migadu.com [95.215.58.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC6606A337
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 15:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1BC6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OQjrM4Xz
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ORueQHtBtDO6jYs9rPSJAwQL8rrlHEyCflNyo/uLzHo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795103866; v=1; x=1795708666;
 b=OQjrM4XzL/LD0lTPGisvzBV845fAqForpmdORA8duDtx9HEgv9Rbog6x4QOjcNp1yChSvV1C
 PSmCPRVDPjjJPvb2Ra1hm7M+vmvp+TCi/mmKjswhxPQoqSLDJprxfXP12DY7wd17f0DzAQOx9/r
 JkFFn2YdD1rH8sXc6uJhhulU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a47f7905d1af218d;
	Thu, 19 Nov 2026 15:57:46 +0000
X-Mizu-Trace-ID: a47f7905d1af218d
X-Migadu-Flow: FLOW_OUT
Message-ID: <473a226d-311a-43f4-a494-b0ce25862c75@linux.dev>
Date: Thu, 19 Nov 2026 07:57:42 -0800
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
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Test CO-RE relocations of
 unsigned 32-bit enum values
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261119051453.1902726-1-yonghong.song@linux.dev>
 <4b1c106f8c17afddbdacf8814838a3c0aca16456e7655da2be23bad0bc40405f@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <4b1c106f8c17afddbdacf8814838a3c0aca16456e7655da2be23bad0bc40405f@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/18/26 9:54 PM, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Test CO-RE relocations of unsigned 32-bit enum values
> TL;DR: The new enum test likely fails core_reloc/enumval on the GCC-BPF flavor
> at this commit, since GCC sign-extends the value; fixes come later in the
> series, so it isn't bisectable.
>
>> diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
>> --- a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
>> +++ b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
> [ ... ]
>
>> @@ -64,6 +72,12 @@ int test_core_enumval(void *ctx)
>>   	out->anon_val1 = bpf_core_enum_value(anon, ANON_ENUM_VAL1);
>>   	out->anon_val2 = bpf_core_enum_value(anon, ANON_ENUM_VAL2);
>>   	/* ANON_ENUM_VAL3 value is optional */
>> +
>> +	/* enum named_uint_enum is optional */
>> +	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL1))
>> +		out->uint_val1 = bpf_core_enum_value(enum named_uint_enum, UINT_ENUM_VAL1);
>> +	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL2))
>> +		out->uint_val2 = bpf_core_enum_value(enum named_uint_enum, UINT_ENUM_VAL2);
> Will this pass for the GCC-BPF flavor of the object (test_progs-bpf_gcc)?
>
> Under !__clang__, bpf_core_enum_value() expands to
> __builtin_preserve_enum_value(), which returns int, so GCC emits the
> ld_imm64 sign-extended (for example lddw %r1,-2147483648 for 0x80000000).
>
> With f3507c4b38e8 applied, bpf_core_calc_enumval_relo() gets orig_val from
> btf_enum_value(), which is (__u32)e->val for a kflag 0 enum, and
> bpf_core_patch_insn() then validates it against the instruction:
>
>      imm = (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);
>      if (res->validate && imm != orig_val) {
>          pr_warn("... unexpected insn #%d (LDIMM64) value: ...");
>          return -EINVAL;
>      }
>
> For the GCC-built object imm is 0xffffffff80000000 while orig_val is
> 0x80000000, so bpf_object__load() should fail and ASSERT_OK(err,
> "obj_load") would fail core_reloc/enumval, and core_reloc_btfgen/enumval
> the same way.  ENUMVAL_CASE(enumval) does not set .fails, neither subtest
> is in ci/vmtest/configs/DENYLIST.test_progs-bpf_gcc, and the gcc-bpf job
> (KERNEL_TEST: test_progs-bpf_gcc) runs on x86_64.
>
> Even with only the libbpf fix, the int result stored into the new long
> uint_val1/uint_val2 fields would read back as 0xffffffff80000001, while
> core_reloc.c expects 0x80000001 and 0xffffffff.
>
> This looks to be fixed later in the series, and both are needed for GCC:
>
>    aa93e7e947e0 ("libbpf: Accept sign-extended 32-bit enum values in CO-RE
>    relocations") makes libbpf accept the sign-extended form.
>
>    ec81091d83f1 ("selftests/bpf: Take unsigned enum values as unsigned int
>    for GCC") adds UINT_ENUM_VALUE(), which casts to unsigned int under
>    !__clang__.
>
> Until both land, test_progs-bpf_gcc fails at this commit, so the series is
> not bisectable for that flavor.  Could those changes be folded into this
> commit and f3507c4b38e8, or the series reordered?
>
> The commit message also describes only the clang behaviour ("whose values
> clang emits zero-extended in the ld_imm64 of the relocations").

You are correct. this will still have gcc test failure.
So in the next revision, I will merge 1/3 as the first commit
and 2/4 as the second commit. This way, we can avoid the selftest failure
during bisecting.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44465301903

