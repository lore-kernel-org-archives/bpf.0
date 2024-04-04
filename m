Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2394367
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261596; cv=none; b=Ecqqhjh2X7/MCHycrj91QBr1GJvdDvZBPdV9Cirm/Ypc/WKg19DHMzgR5FSs9Ry+ymceL1Kxt+Y2pn0TKZ8x2PWl29RF2yv7X/A711UBAPiqJAimPJrfdZ6p/L2pm2uqRa33G35vVc1UJ3R9yKhAOcKXqMSpqe1a+kj5ZY7QVEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261596; c=relaxed/simple;
	bh=qVODw7frxxckoxhlcPeWtG4P2gxE0Q4kDjzmy4kBM7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebNecRO5xxotCBzRBuYaY54JKP8sa7a0ItX7JGSTAOTUzMDl3sKqwyfHYHajadLO3gmt/qQJIlFvT9fneFr3S1jkeUV7tUcfqW6IeZNzGTPDS7r1WK/wrGigzehS3AAD9cOT9TsQr8aTd3eg1eP+euptgJMlToJ4hU7iD+Qzx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O6FFOqA4; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O6FFOqA4"
Message-ID: <04124bf0-2a78-4278-ac5d-93f11a5f242e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712261592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFQfGzOin8QPEb9+qAsjSwLmlukO1JYwycG0xwonCvE=;
	b=O6FFOqA41cLFkTYV3rr02CjsbabYmq/JNFzwuDBYItkG+06mAaHiBexxRd7IDAIgCJGdQV
	zF8b3GBJKiUhSSzl5OSYGva5yO1KPPVirPedE/HrWwnP9oiOGOwmmm2zGFMOXwq86u6EnF
	zXz847w2gQVmQjpSdAu915DlK5bd+RE=
Date: Thu, 4 Apr 2024 13:13:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add fp-leaking precise
 subprog result tests
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com,
 syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
References: <20240402225020.2582397-1-andrii@kernel.org>
 <20240402225020.2582397-2-andrii@kernel.org>
 <CAEf4Bza0QLa8m_iW4Rk_6+8tuJgvhF7gjk-p4HVHTRq2LJgPVg@mail.gmail.com>
 <791f362c-cdf1-4cd7-8fa2-95d05a4f4b22@linux.dev>
 <CAEf4BzYHL5FUB7FdpHQD=A4YZOnDvQ2FBtdjjonB_R0NDDy4NA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYHL5FUB7FdpHQD=A4YZOnDvQ2FBtdjjonB_R0NDDy4NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/4/24 1:09 PM, Andrii Nakryiko wrote:
> On Thu, Apr 4, 2024 at 11:48 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 4/2/24 4:26 PM, Andrii Nakryiko wrote:
>>> On Tue, Apr 2, 2024 at 3:50 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>>>> Add selftests validating that BPF verifier handles precision marking
>>>> for SCALAR registers derived from r10 (fp) register correctly.
>>>>
>>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>>> ---
>>>>    .../bpf/progs/verifier_subprog_precision.c    | 86 +++++++++++++++++++
>>>>    1 file changed, 86 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
>>>> index 6f5d19665cf6..e1a8f107f0a7 100644
>>>> --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
>>>> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
>>>> @@ -76,6 +76,92 @@ __naked int subprog_result_precise(void)
>>>>           );
>>>>    }
>>>>
>>>> +__naked __noinline __used
>>>> +static unsigned long fp_leaking_subprog()
>>>> +{
>>>> +       asm volatile (
>>>> +               "r0 = (s8)r10;"
>>> Our CI's clang doesn't like this instruction. I guess I'll have to
>>> encode it in binary form :(
>> This patch disappeared from CI so I am not able to check the result.
>>
>> But I tried with the following small example.
>>
>> $ cat t.c
>> __attribute__((naked)) unsigned long t(void)
>> {
>>           asm volatile("r0 = (s8)r10;"
>>                        "exit;"
>>                       );
>> }
>>
>> $ clang --target=bpf -O2 -mcpu=v2 -g -c t.c && llvm-objdump -d t.o
>>
> You are using local clang built from source code, right? I think our
> BPF CI still is on Clang 17 or something, so it doesn't yet understand
> "(s8)r10" syntax, unfortunately.

Yes, it makes sense. Indeed in that case, either using bytes or guarding
with >= llvm18 is needed.

>
>
>> t.o:    file format elf64-bpf
>>
>> Disassembly of section .text:
>>
>> 0000000000000000 <t>:
>>          0:       bf a0 08 00 00 00 00 00 r0 = (s8)r10
>>          1:       95 00 00 00 00 00 00 00 exit
>>
>>
>> -mcpu=v3/v4 has the same result.
>> Not sure what clang complains.
>>
>>>> +               "exit;"
>>>> +       );
>>>> +}
>>>> +
>>> [...]
>>>
