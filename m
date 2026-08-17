Received: from mta1.migadu.com (out-241.mta1.migadu.com [95.215.58.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2AF3DD84F
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985630; cv=none; b=am3hGRQOzz6xgJl0l1WtXEdXo9pGDmTwMLfw03JYVpK1u80xjrTJilIwWtxXcjFypQTzdZ/8x/URK8RbAW51xCQGZb2rTgRSq1XwH7ai28Q8397SgNYnxkYBtcGq+GQgCBSI5zGO3YKlEur3v1+2CC/GOwxmTK3PBY5LCE6ZHJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985630; c=relaxed/simple;
	bh=9A99tP2RVKFtRuAvAPnizc74i2WsWuguVDsFF7Y/zUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKRkqq9GJVR2XwlHeywWFVFsKyXbxIOQFhfpRDL+H8YWCCLMOJIC7vOPA7C4DPlms5V2dwyg9EPBejg0d6bCs3gnSJYBZNFBGK/1raMrmaqh8x6FQkAg4qBRMG5+Zilfif8aDTn9dq2e5n0x7PT1i+hiX7/ymV9iB+xBuKXUCPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c5XERpjW; arc=none smtp.client-ip=95.215.58.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c5XERpjW"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9A99tP2RVKFtRuAvAPnizc74i2WsWuguVDsFF7Y/zUs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786985621; v=1; x=1787590421;
 b=c5XERpjWHjdKDIunQXBhL0k2u3ulySRd4SZVjFPm2a+PL9wkqeFSBo2otEMziyiE2K0KWfmE
 nwvX67w+M1ICo70KBxRRzLSjuR+mmLCmUR74IhrEJ2bsY0IRjGY8a+0z2aPfvcCbFNZBNqfPTm8
 u48KeoM6o6yx/eIW/nQT2PpA=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5604)
	by smtp.migadu.com with ESMTPS id ab001f380118c4c6;
	Mon, 17 Aug 2026 16:53:40 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <c5d05037-e32e-4126-b336-3e44dba8054e@linux.dev>
Date: Mon, 17 Aug 2026 09:53:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 09/10] selftests/bpf: Add inline-asm and
 subprog tests for R0:R2 returns
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
 <20260817042227.2296079-1-yonghong.song@linux.dev>
 <20260817044221.152F31F00A3A@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260817044221.152F31F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/16/26 9:42 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The test `aggregate_ret_kfunc_too_big_fail` is incorrectly restricted to only run on x86_64 and arm64 architectures.
> --
>
> --- Patch [9]: [PATCH bpf-next v6 09/10] selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns ---
> commit b44fbeb59afa99f6be0f33037220d124e0fb4e12
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add inline-asm and subprog tests for R0:R2 returns
>
> This commit adds BPF inline-assembly tests to cover BPF-to-BPF returns, kfunc
> calls, backtracking, and liveness for functions returning values in the R0:R2
> register pair. It also includes an extension test to ensure a function returning
> R0:R2 cannot be replaced.
>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
>> new file mode 100644
>> index 0000000000000..c23b4beb1773c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
> [ ... ]
>
>> +/*
>> + * A return value larger than 16 bytes does not fit in R0:R2 and is rejected by
>> + * btf_distill_func_proto(), before the KF_FASTCALL and JIT-capability checks,
>> + * so this behaves the same on every architecture.
>> + */
>> +SEC("tc")
>> +__arch_x86_64 __arch_arm64
> [Severity: Medium]
> Are these architecture restriction tags intended here?
>
> The comment right above mentions that this test behaves the same on every
> architecture, but the __arch_x86_64 and __arch_arm64 tags artificially limit
> aggregate_ret_kfunc_too_big_fail() to only run on those two architectures,
> which prevents the test from running on others.

Okay, I don't have 100% confidence about every architecture. So let us
change to

/*
  * A return value larger than 16 bytes does not fit in R0:R2 and is rejected by
  * btf_distill_func_proto() before the KF_FASTCALL and JIT-capability checks.
  */

>
>> +__failure __msg("The function bpf_kfunc_call_test_ret_big return type STRUCT is unsupported")
>> +__naked int aggregate_ret_kfunc_too_big_fail(void)
>> +{
>> +	asm volatile (
>> +	"call %[bpf_kfunc_call_test_ret_big];"
>> +	"r0 = 0;"
>> +	"exit;"
>> +	:
>> +	: __imm(bpf_kfunc_call_test_ret_big)
>> +	: __clobber_all);
>> +}

