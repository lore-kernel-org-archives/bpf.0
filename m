Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16C2010EE
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265400; cv=none; b=b26WxZFy7pmGq9uKB8cdOkf/YnURxKbeErzmw6JQMrrPr5goUdWF8TeclpKLhXRGDv3LnCK+APdnakGpm258HscRhKaM9nBu5mNuf/u0SlWa+YihPNribq01AFT7wEz9KaXpR3Eo9QYHvhBAv3LQvMhk/w9OgX8q/hy0Ncickv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265400; c=relaxed/simple;
	bh=cJ7O0ZLD0Pd5i+N/UryeSxeBbtkb1V+krtTpKFUgCQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBXfNPGZkwyu2iu/Z4oO6gIfVxEmZNKehCLsBAd+LQmuz6CK9FoGznstILhPrgKxcP9sQd6gFjKSgAVi86KAkIwsd2q/bd+1HJvIxOWeW2SccNUI7NTBXZ8CyHN0NQkfn+Sid+HeKRWhGWk49L9gwk2X2F/3xXBaBMD7Kyu/cLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u2YC5kn5; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u2YC5kn5"
Message-ID: <bc410b38-f5ab-47cf-a434-fa4f43751921@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773265387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oY0ScjjYBmbgesl65ClATdNaDwRrK4lWRWVjLXSQrjY=;
	b=u2YC5kn5TmPwfryYEjMFgHQzd5h4eTKlPtBYCgUwaBqasWFA4drPEdJMCN13+e73nEndcL
	oBC6yVMPjNQu37+6/rEArC1/32PpJ9WwGioiRErOhEv9exc7OrQA4JQN1dWDBlumZKW/E2
	4rYWs/phHEC+VQ6OPg/Okg4Nfe1K5gU=
Date: Wed, 11 Mar 2026 14:42:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: improve test coverage for kfunc call
To: Hari Bathini <hbathini@linux.ibm.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard <eddyz87@gmail.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20260303131453.328674-1-hbathini@linux.ibm.com>
 <CAADnVQKuARvSirPjnTcSifLPunCiKC4Nenq0Mr61GpzbW5WxWg@mail.gmail.com>
 <bbf6a46c-37e9-4d8d-968e-a99bb12dcc14@linux.ibm.com>
 <CAADnVQ+4N4WWLxan_qibZ7HmONJyMZaP=RF+a9tMSPoz=0LqkQ@mail.gmail.com>
 <09b101af-9722-4c45-bda0-c8a3dd417c03@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <09b101af-9722-4c45-bda0-c8a3dd417c03@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/11/26 11:03 AM, Hari Bathini wrote:
>
> On 11/03/26 9:32 pm, Alexei Starovoitov wrote:
>> On Wed, Mar 11, 2026 at 8:10 AM Hari Bathini <hbathini@linux.ibm.com> 
>> wrote:
>>>
>>>>
>>>>> +
>>>>> +       /* Check zero-extension */
>>>>> +       if (val != (unsigned long)a)
>>>>> +               return 1;
>>>>> +       /* Check no sign-extension */
>>>>> +       if (val < 0)
>>>>> +               return 2;
>>>>> +
>>>>> +       val = b;
>>>>> +       if (val != (unsigned long)b)
>>>>> +               return 3;
>>>>> +       if (val < 0)
>>>>> +               return 4;
>>>>> +
>>>>> +       val = c;
>>>>> +       if (val != (unsigned long)c)
>>>>> +               return 5;
>>>>> +       if (val < 0)
>>>>> +               return 6;
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>
>>>> Overall this looks very useful.
>>>> I would expand with another test where a,b,c are s8,s16,s32.
>>>
>>> Slightly different approach but kfunc_call_test4/bpf_kfunc_call_test4
>>> cover signed arguments already?
>>
>> Ahh. Then may be tweak it to adopt similar fine grained
>> error reporting as your bpf_kfunc_call_test5()
>
> I Prefer this.
>
> Does the below change to bpf_kfunc_call_test4 look fine:
>
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c 
> b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 48dcaf93bb9f..6237c2222633 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -760,8 +760,30 @@ __bpf_kfunc struct sock 
> *bpf_kfunc_call_test3(struct sock *sk)
>
>  __bpf_kfunc long noinline bpf_kfunc_call_test4(signed char a, short 
> b, int c, long d)

I might regret for bringing this up as it could be yet another ABI 
fiasco between gcc and llvm.

As per C standard, sign of unadorned char (i.e. w/o explicit signed or 
unsigned prefix) is ABI defined.
For gcc-bpf char is specified to be signed.
So test4 has s8, while new test5 has u8. Would it make sense to have an 
additional test without signed/unsigned annotation for char ?
This will flag any discrepancy between the two compilers.

Thx,
-Vineet

>  {
> +       /*
> +        * Make val as volatile to avoid compiler optimizations.
> +        * Verify that negative signed values remain negative after
> +        * sign-extension (JIT must sign-extend, not zero-extend).
> +        */
> +       volatile long val;
> +
> +       /* val will be positive, if JIT does zero-extension instead of 
> sign-extension */
> +       val = a;
> +       if (val >= 0)
> +               return 1;
> +
> +       val = b;
> +       if (val >= 0)
> +               return 2;
> +
> +       val = c;
> +       if (val >= 0)
> +               return 3;
> +
>         /* Provoke the compiler to assume that the caller has 
> sign-extended a,
>          * b and c on platforms where this is required (e.g. s390x).
> +        *
> +        * Original behavior: return sum for backward compatibility
>          */
>         return (long)a + (long)b + (long)c + d;
>  }
>
>
> - Hari

