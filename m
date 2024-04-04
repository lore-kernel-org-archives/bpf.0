Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A59015EA6
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712256494; cv=none; b=Dhs74yaeFpoQhItogfHGSEi6+OaIh3LBCWVIkdgKtNZMTGahJaib14cXcpaHOuDWB2fTZq5nefCC/kmi0sJHbYY6COkWXzLCFkkb8MHAPagVww8zjzotxpIjk0SPbsJfyLd8OuUqottR+1VFsc+G3iUpWsuQ+BYdoWjoVGa5/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712256494; c=relaxed/simple;
	bh=dtR4R7QvWovKbxiN/MIE45D+GZdyBvto3z8T3F+MqCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emtao7YJwhYmaqi+2PDVUVX9xJS7O03Vy/dxWjD1A4lG6YzDo0pl3e1hFwlAGY+K4prACQFdL5Jlc8QsJ9KfwrBsOkNY0/k/N5B/pd3CjreGtwg6wDmGnjWfuMPCm2BhgTjJdp8o+Y1Gz9vg5ASPVxgq5ePJqUo+cMFtNBtRO5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CbCkAWgG; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CbCkAWgG"
Message-ID: <791f362c-cdf1-4cd7-8fa2-95d05a4f4b22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712256489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROY1p2JCrGa9quAk0jxouG1RPIL1tr1voDY3CxBRVAc=;
	b=CbCkAWgGtmQkjt7iKBIjqVwm2Ewpt76RqFVnsDs66xzKWbkSsbha0EmTWjsofCClF3ncmn
	kCdZ7v70P8qPap8GlGR+fqbHgF1s9jwiSdP6MWa82jVm8isL8kYTAfZQaS39mPGEJRINXz
	pEL49++Vv5gOcXsI0Wbjjyzn6ZcRf4Y=
Date: Thu, 4 Apr 2024 11:48:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add fp-leaking precise
 subprog result tests
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com,
 syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
References: <20240402225020.2582397-1-andrii@kernel.org>
 <20240402225020.2582397-2-andrii@kernel.org>
 <CAEf4Bza0QLa8m_iW4Rk_6+8tuJgvhF7gjk-p4HVHTRq2LJgPVg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bza0QLa8m_iW4Rk_6+8tuJgvhF7gjk-p4HVHTRq2LJgPVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/2/24 4:26 PM, Andrii Nakryiko wrote:
> On Tue, Apr 2, 2024 at 3:50 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>> Add selftests validating that BPF verifier handles precision marking
>> for SCALAR registers derived from r10 (fp) register correctly.
>>
>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
>>   .../bpf/progs/verifier_subprog_precision.c    | 86 +++++++++++++++++++
>>   1 file changed, 86 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
>> index 6f5d19665cf6..e1a8f107f0a7 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
>> @@ -76,6 +76,92 @@ __naked int subprog_result_precise(void)
>>          );
>>   }
>>
>> +__naked __noinline __used
>> +static unsigned long fp_leaking_subprog()
>> +{
>> +       asm volatile (
>> +               "r0 = (s8)r10;"
> Our CI's clang doesn't like this instruction. I guess I'll have to
> encode it in binary form :(

This patch disappeared from CI so I am not able to check the result.

But I tried with the following small example.

$ cat t.c
__attribute__((naked)) unsigned long t(void)
{
         asm volatile("r0 = (s8)r10;"
                      "exit;"
                     );
}

$ clang --target=bpf -O2 -mcpu=v2 -g -c t.c && llvm-objdump -d t.o

t.o:    file format elf64-bpf

Disassembly of section .text:

0000000000000000 <t>:
        0:       bf a0 08 00 00 00 00 00 r0 = (s8)r10
        1:       95 00 00 00 00 00 00 00 exit


-mcpu=v3/v4 has the same result.
Not sure what clang complains.

>
>> +               "exit;"
>> +       );
>> +}
>> +
> [...]
>
