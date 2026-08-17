Received: from mta1.migadu.com (out-109.mta1.migadu.com [95.215.58.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C723741
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786938840; cv=none; b=iDiMyRjVTYUc2KpeR7gpcgoP5s2MP/K4hGrqDALQIlEFoALscxpws7a+B7fPkn9Q85X2EPPPDXVyE6JZPSMIYiqU4RJZDy1W9bm+Nwwwcjry+SWKdjrvQ7p9pjFVdvoeDIsKKO+p+6MmAFKt8tXxIEHflcUM+up1m4H4RSdsF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786938840; c=relaxed/simple;
	bh=OcNBvelvz8wkN+6tJZdmzi/NGqjs/gTZoFajNODoJ0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeTB/Y/jO9Rd5hjWvefY8JqJ9Bha7JvXb3JAhOz0DikV/88SxKaJRU7hD7UdxegPPY8BR4THx5I289w3IImAmEZatyoM2vmxrB6fSnTt3RIZfboL+rWnGDxZ4p58RDJRs873myIRZVsdBDTNu/VHprYSm4vGXt/3uWFx/DJh+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WGgkc+3c; arc=none smtp.client-ip=95.215.58.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WGgkc+3c"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OcNBvelvz8wkN+6tJZdmzi/NGqjs/gTZoFajNODoJ0E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786938836; v=1; x=1787543636;
 b=WGgkc+3cu21DRMQSfiZlS7E82CQj5CJke5SWzCXYajVoHCoPOYyOYoaWeM6pPy38CHNSb7KK
 IKFykVpjkZzu7TQubXwpoX4mPOZ7VUtAHpiQPNjUtv9Lg9rBw94HsFHwcY5Z999mbjJM4DnIelH
 mzEziJ+TP+HH3TplXsAPTUTY=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id 306356fd2dff90a1;
	Mon, 17 Aug 2026 03:53:46 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <539bca85-92ce-4f89-9ed0-c1e081cbcd14@linux.dev>
Date: Sun, 16 Aug 2026 20:53:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 09/11] selftests/bpf: Add C tests for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200256.1996809-1-yonghong.song@linux.dev>
 <7b7f5154cab8e3a217047e34be0d7255e9eccc21.camel@gmail.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <7b7f5154cab8e3a217047e34be0d7255e9eccc21.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/14/26 5:47 PM, Eduard Zingerman wrote:
> On Thu, 2026-08-13 at 13:02 -0700, Yonghong Song wrote:
>> Add selftests that exercise a 16-byte return value passed in the R0:R2
>> register pair, written in C so that they depend on the compiler lowering
>> the register-pair return. Covered are an __int128 return, a 16-byte struct
>> return (from a static and from a global subprogram) and a 16-byte union
>> return, plus __int128 and 16-byte struct returns from a kfunc. The union
>> program shares an object with the struct ones.
>>
>> The R0:R2 convention is only emitted by LLVM 23 and newer, and a by-value
>> aggregate return does not compile at all before that, so the programs sit
>> behind a __clang_major__ guard. An older compiler builds the dummy test in
>> the #else branch instead, which keeps each object non-empty and says in
>> its description why nothing was exercised.
>>
>> The kfunc tests are tagged __arch_x86_64/__arch_arm64 and skip elsewhere.
>> Those are the architectures whose JIT advertises
>> bpf_jit_supports_kfunc_ret_reg_pair(), which bpf_add_kfunc_call() requires
>> before it accepts a kfunc returning more than 8 bytes, and they are also
>> the only ones building the kfuncs.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>>   .../selftests/bpf/prog_tests/aggregate_ret.c  |  13 ++
>>   .../bpf/progs/aggregate_ret_int128_c.c        |  49 ++++++++
>>   .../bpf/progs/aggregate_ret_kfunc_c.c         |  65 ++++++++++
>>   .../bpf/progs/aggregate_ret_struct_c.c        | 114 ++++++++++++++++++
> Nit: I'd merge all three files into one and move loader to prog_tests/verifier.c.
>       Also not sure about union vs struct tests.

Okay, will do.

>
>> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c b/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c
>> new file mode 100644
>> index 000000000000..913cc374215d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_int128_c.c
> ...
>
>> +#if defined(__clang_major__) && __clang_major__ >= 23
> ...
>
>> +#else
>> +
>> +SEC("socket")
>> +__description("aggregate_ret_int128_c: needs LLVM 23, dummy test")
>> +__success
>> +int dummy_test(void)
>> +{
>> +	return 0;
>> +}
> Q: what would happen w/o #else branch? Is loading an empty object an error?

With #else branch, we will have:
#1/1     aggregate_ret/aggregate_ret_int128_c: needs LLVM 23, dummy test:OK
#1/2     aggregate_ret/aggregate_ret_struct_c: needs LLVM 23, dummy test:OK
#1/3     aggregate_ret/aggregate_ret_kfunc_c: needs LLVM 23, dummy test:OK

Without #else branch, all the above three subtests will be gone.
I probably will keep it so user knows the current limitation. Once CI compiler
becomes llvm23, the above three will go through real tests.
   

>
>> +#endif
> ...

