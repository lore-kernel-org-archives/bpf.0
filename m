Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B13B19A8
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433810; cv=none; b=SVEbIGaf6zKO6L9yE3NOnmaRTR4kDHY0lrCt4CqoA3Z9zXdhdBvOdaVuaAOBB3iVHHv3l+LyKmf/t95rsM+Z85RSqK+Yor/n3vL+pUgKP7ixe41BjXSp0HyxYCjwqml9wt0pvREXI9wJU+ey1AmqtCOVq9RlBVVAb5iMDUGviLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433810; c=relaxed/simple;
	bh=7Bt9+WpFZ/Y2pLR/kgy1H89fb2QneCxFlnjUgKGxSJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auOK3u5gMDtJUwIVQur0UCWwLOcIONkTBPZzugCZZZ4ko4EqrtIP+X+Gl1fxjV/x9LA1kT7urceybk6isEKg+FWYiWjPJ8khbME6wmJFXHbpFxP+EzKB4RQp4V+AlhX8P9Kuc8owtzK7DGi3ts0Nj0smJIhNZ2IZLcY5ywJE9+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ivA+2oHA; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ivA+2oHA"
Message-ID: <e899f951-4433-41fa-a9d2-0b7bb04246a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778433806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3c2seJuY9AHYWuhHEyFjhErb3UbDB+f9qLib1qr45M=;
	b=ivA+2oHAQYlqpQosYdTcGqpH3i4/ycNlDUqbbdFyQOrXo+nFCIOIcMjs4hX8kZfoio8zSH
	saxGW2QtEWrTC09P18QKPv7oGJpjymNbjkmtMxF7wPrdWwT01pFBFAGuIkcdYZRWkqJguh
	pFNbezuCkLO6wq6csWpSflm4soXIRjg=
Date: Sun, 10 May 2026 10:23:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 17/23] selftests/bpf: Add tests for stack
 argument validation
Content-Language: en-GB
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260507213135.1138457-1-yonghong.song@linux.dev>
 <20260509013014.A4DF6C2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260509013014.A4DF6C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/9/26 3:30 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Unconditional use of the 'r11' register in inline assembly will cause selftest build failures on older Clang compilers.
> --
>
> commit 6f66b8fd81d82b7d1f5f683d16976b8d486d440b
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> selftests/bpf: Add tests for stack argument validation
>
> This commit adds negative tests to verify that kfuncs properly reject large
> structs passed as stack arguments. It also adds tests to ensure the verifier
> rejects invalid uses of the r11 register for stack arguments.
>
>> diff --git a/tools/testing/selftests/bpf/progs/stack_arg_fail.c b/tools/testing/selftests/bpf/progs/stack_arg_fail.c
>> new file mode 100644
>> index 0000000000000..c6db302549cbd
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/stack_arg_fail.c
> [ ... ]
>
>> +#else
>> +
>> +SEC("tc")
>> +__description("stack_arg_fail: not supported, dummy test")
>> +__success
>> +int test_stack_arg_big(struct __sk_buff *skb)
>> +{
>> +	return 0;
>> +}
>> +
>> +#endif
>> +
>> +SEC("socket")
>> +__description("r11 in ALU instruction")
>> +__failure __msg("R11 is invalid")
>> +__naked void r11_alu_reject(void)
>> +{
>> +	asm volatile (
>> +	"r11 += 1;"
> Could these inline assembly blocks using r11 cause build failures on older
> Clang compilers?
>
> The r11 register is a relatively new addition to the BPF ISA and LLVM backend.
> Because these naked assembly functions are placed outside of the
> __BPF_FEATURE_STACK_ARGUMENT guard, compiling this file with an older
> toolchain might result in fatal assembler errors regarding an invalid operand.
>
> Would it be safer to move these r11 tests inside the feature guard to
> maintain selftest compatibility across toolchains?

Indeed. Will fix.

>
> [ ... ]
>

