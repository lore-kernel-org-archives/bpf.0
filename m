Received: from mta0.migadu.com (out-99.mta0.migadu.com [91.218.175.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9836B921
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645635; cv=none; b=mFq+5eLSbRwB6zbU2eykmpDulYqkjQDNCeiQCtAzNH49SjVXhu2YxismARKm7Jf+L5QVQgR+ebNftoSnO74zgjD50HpYfMx45xio6YYmJm6UGdgTpviQfV0fRpsdatkwH149XXODVPYA/VVXCYJMQH908yLKUnoSTmBieUEuKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645635; c=relaxed/simple;
	bh=FzQvoeN+ONjT/45yHEOioVhS2GZsHnRX8mwt/+4Jre8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mghl380NWp1LxyeWYR8PjLR8fUtJcVEtddZREiRO7waLdwYZMBP3YlaxPt2TNBCE3TnXWkhGHd3xw+BTMv/yFoHQ53Gkid+sq8GcIoiHkuYE7TyigPM1VRZ1mqmSFCu0AvxcaSGu+X0lUoBXZrsZug3i3lmBz/Qz+7l5QPcOyNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AjEmHprW; arc=none smtp.client-ip=91.218.175.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AjEmHprW"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FzQvoeN+ONjT/45yHEOioVhS2GZsHnRX8mwt/+4Jre8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786645631; v=1; x=1787250431;
 b=AjEmHprW7F0pUhcBdDvcsYAX0JKYTnwqaEjwAyDvgIPauYojC0h81UbNcBtuREZM2vGK384W
 lhrnctoUwu34qjuI3Wdm1pWSCQC0YZWJDjyQL4le7qe0DBUPyYGQm10vlcS7hwbLb3hwpcTSQ6B
 US8WxVva2CmS9SAP77dVfiAk=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:381:1f2d:e3e3:185d:58c3:4c79:68c] (2600:381:1f2d:e3e3:185d:58c3:4c79:68c)
	by smtp.migadu.com with ESMTPS id b8aba4742252cc49;
	Thu, 13 Aug 2026 18:27:11 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <5bfba08b-995f-4ebe-bd4c-c485b4d28ca3@linux.dev>
Date: Thu, 13 Aug 2026 11:27:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 12/13] selftests/bpf: Add tests for callbacks
 returning more than 8 bytes
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
 <20260811001013.2385213-1-yonghong.song@linux.dev>
 <04dcc1dd9b0eb24707a83c2bf7a9755af1477953.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <04dcc1dd9b0eb24707a83c2bf7a9755af1477953.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/26 5:10 PM, Eduard Zingerman wrote:
> On Mon, 2026-08-10 at 17:10 -0700, Yonghong Song wrote:
>> Add two __failure tests covering the callback return-size checks:
>>
>>   - timer_ret_pair_fail: a bpf_timer callback declared to return more than
>>     8 bytes, rejected by check_ld_imm() where the callback's PTR_TO_FUNC is
>>     created, with "callback function with >8-byte return value is not
>>     supported".
>>
>>   - exceptions_ret_pair_fail: an exception callback declared to return more
>>     than 8 bytes, rejected by do_check_common() when the callback
>>     subprogram is verified, with "exception cb cannot return value larger
>>     than 8 bytes".
>>
>> Both callback bodies are written in inline asm so that the tests do not
>> depend on LLVM 23 R0:R2 codegen and run on any compiler. The verifier reads
>> the return type from BTF rather than from the instructions, so the >8 byte
>> return prototype is supplied through __btf_func_path(), pointing at a
>> companion btf__*.c program that exists only to carry that BTF.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../selftests/bpf/prog_tests/exceptions.c     |  2 +
>>   .../testing/selftests/bpf/prog_tests/timer.c  |  2 +
>>   .../bpf/progs/btf__exceptions_ret_pair_fail.c | 10 ++++
>>   .../bpf/progs/btf__timer_ret_pair_fail.c      | 10 ++++
>>   .../bpf/progs/exceptions_ret_pair_fail.c      | 30 ++++++++++++
>>   .../selftests/bpf/progs/timer_ret_pair_fail.c | 49 +++++++++++++++++++
>>   6 files changed, 103 insertions(+)
> Dropping callback checks avoids adding all this code.

Yes, I removed 'bpf: Reject callbacks returning more than 8 bytes' so
this patch will be removed as well.

>
> ...

