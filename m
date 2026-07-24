Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4033B27C9
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908504; cv=none; b=XL6ZDV+rjY/UEypjqGlG06j3HPDvnu00G3sHo4gENv8EWaTdFu2FdeKdL9MTl/e+xZW7Dsr5sEhwKECdOeB+i8ntIJK8gvECgQgcsVtL1jq09N05KiE6OHENUSQj2n5roqFdKGKmh4hKFjHj3lqsMyf9/w70PhQrp+/+wrgJwsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908504; c=relaxed/simple;
	bh=+LlpLgT6kwy/yBhhVM/Uxqwvqr3VH/O/jaDZ77Jj0r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulQ+7/TpOrqj43mDOF5zRznhtNeiBbuZVi4C2EaBl2D+UI+e41QE31uskR46g7SAYJkz2JcOdAXUMq7iZwE5jW/Egq037rmTsUEILZTiH+dSu2D1yHgz3JMC2MJL9opcO7ypqBNciI69Nn7Vt8Bwj9TnSJ/NY9UWwQYYPSyHiQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y4F3qYic; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y4F3qYic"
Message-ID: <543929db-24c4-408c-99ae-99b4eca002e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784908499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LQaNR+lU++/LsUYSodNcVYtomEsMSpCfL3MqWelMpw=;
	b=Y4F3qYiciy9df5DUl5Ips0OECQOdiO4Ghd89lXJ/U1KXBheW+VpBQLsbcs+P+2frBJyT5q
	H2Cz2cXIyDDQDWWhbVryIY3gO81RTWD88V3eqsIqT/UrDOYxQW7sgkri6G0gFBKa8B6gPo
	CNpXwGoniCJbssQJ+8DmVQNkG42GqKw=
Date: Fri, 24 Jul 2026 23:54:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix sleepable check for tracing prog
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 Sechang Lim <rhkrqnwk98@gmail.com>, Varun R Mallya <varunrmallya@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260724141422.10463-1-leon.hwang@linux.dev>
 <20260724141422.10463-2-leon.hwang@linux.dev>
 <f13939eb-d8b9-401b-aac6-6004d395a049@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <f13939eb-d8b9-401b-aac6-6004d395a049@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/24 23:41, Viktor Malik wrote:
> On 7/24/26 16:14, Leon Hwang wrote:
>> When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing prog
>> is allowed to attach to '__x64_'-alike prefix symbols.
>>
>> It is because the verifier does not verify whether the symbol is a kernel
>> function or a bpf prog. That said, a sleepable tracing prog is allowed to
>> attach to a bpf prog target whose name has '__x64_'-alike prefix.
>>
>> For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP
>> prog, and copies buffer from a user pointer with bpf_copy_from_user()
>> helper. After attaching the XDP prog to lo interface, the kernel BUG
>> could be triggered by 'ping -c 1 -W 1 127.0.0.1':
>>
>> [    3.460756] BUG: sleeping function called from invalid context at kernel/bpf/trampoline.c:1324
>>
>> Fix it by disallowing sleepable tracing prog always when its target is
>> bpf prog.
>>
>> Fixes: 16d9c5660692 ("bpf: Always allow sleepable programs on syscalls")
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  kernel/bpf/verifier.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 52be0a118cce..40d567b90d24 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18935,13 +18935,16 @@ static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
>>  }
>>  
>>  static int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct bpf_prog *prog,
>> -				  const struct btf *btf)
>> +				  const struct btf *btf, const struct bpf_prog *tgt_prog)
>>  {
>>  	const struct btf_type *t;
>>  	const char *tname;
>>  
>>  	switch (prog->type) {
>>  	case BPF_PROG_TYPE_TRACING:
>> +		if (tgt_prog)
>> +			return prog->sleepable ? -EINVAL : 0;
> 
> The prog->sleepable check is redundant since btf_id_allow_sleepable() is
> only called if prog->sleepable is true.


Good catch.

Will drop the prog->sleepable check.

> 
> Other than that:
> 
> Acked-by: Viktor Malik <vmalik@redhat.com>

Thanks for your review.

Leon

> [...]

