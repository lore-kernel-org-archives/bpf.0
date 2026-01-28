Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB61371068
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769627361; cv=none; b=gEp2VtMebLyBhSQWFmd6Cz2/cG4GdROYFNYcT761Fd5Ea3ZHKZc5u8mpOQ5Heg2aub9HP3lTyLCTh2khUh/k8TSvcR/nwdbpQJarcVbdKcUq19GZ8M0ngAM+WyashopzLsVb0KUP8IXUJPhfCutelAylZnHOKOIUcwpd+0xV5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769627361; c=relaxed/simple;
	bh=4F1TG6+WlGTBF/WCPp6MXY9LYYj2ZXbTcfmFt02NhMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEMtvRxvnKvLznAgvnZICnE14q4lp9mvrlp6IfrHTN6xmKHBHgCnJC4YPOo6LILsvxd18zYrKtfafBAl9LHhqXOVWOyvOfunABM7AiSfnWoViF/nkCwXqptlbccoJvpD7F5xD1+qUR+6rXuaxAFR0dpCKcFHdfv/J9d7ZHrUaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QQfkmD5l; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QQfkmD5l"
Message-ID: <7dbcc5d5-476b-46e5-9e4b-b260d24a51a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769627347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uoce2O4bq+uQodOB69TrcPt+OZtvkCKYOFmKW88WqjE=;
	b=QQfkmD5lsHJq3o87CYC128K2gTqM8Je0n3mmDb7+VkG836yXHnF3KY7huFJiwuXOFZwF6+
	84fkXG22+popIKJZno2KmoEGOUfWcQ8vQiZtngJ54CILBc359vKQ7gzGPFZ8B1BKhImMSl
	PryoO/gGwx1UTolmy4wP1qSn/KnXi4E=
Date: Wed, 28 Jan 2026 11:08:54 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add bpf_arch_supports_fsession()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Chris Mason <clm@meta.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260128150112.8873-2-leon.hwang@linux.dev>
 <e64c4137e7f262e6fdab272e8ee44c8a129a36eb6d0186914375d6ba20d88474@mail.kernel.org>
 <65231eeb-1f00-4af2-9234-a290ea3f6585@meta.com>
 <a10afa70-29b7-48ab-b241-8b0f602abe2f@linux.dev>
 <CAADnVQJV=e2VgQzkpsUQwexhaVZMs7uXHCe1Fa6VwbVNUMPghA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQJV=e2VgQzkpsUQwexhaVZMs7uXHCe1Fa6VwbVNUMPghA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/28/26 10:49 AM, Alexei Starovoitov wrote:
> On Wed, Jan 28, 2026 at 9:34 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 1/28/26 7:35 AM, Chris Mason wrote:
>>>
>>>
>>> On 1/28/26 10:26 AM, bot+bpf-ci@kernel.org wrote:
>>>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>>>> index 5a075e06cf..070ba80e39 100644
>>>>> --- a/arch/x86/net/bpf_jit_comp.c
>>>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>>>> @@ -4112,3 +4112,8 @@ bool bpf_jit_supports_timed_may_goto(void)
>>>>>  {
>>>>>     return true;
>>>>>  }
>>>>> +
>>>>> +bool bpf_jit_supports_fsession(void)
>>>>        ^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> This is the actual function name in the code.
>>>
>>> Ihor, I think the script parsing review-inline.txt chopped off the
>>> part of the review where AI was complaining about the commit message?
>>
>> This is the email body pre-processing in KPD, yes.
>>
>> At some point we decided to remove the commit message before sending
>> an email, but now that AI reviews the messages too, I think we should
>> just send the generated review-inline.txt as is.
>>
>> Alexei, wdyt?
> 
> I think KPD is only supposed to trim the header until 'diff ..' line.
> In this case there is no 'diff', so I'm not sure why it trimmed so much.

There is. Here is the PR comment with the review:
https://github.com/kernel-patches/bpf/pull/10868#issuecomment-3811930805

KPD trimmed everything before the first "> diff" occurrence, as expected.

I'll try to fix this up in KPD. We should probably search for the first
line starting with "> " (a quote start) to trim the header correctly.

Alternatively, AI can be prompted to avoid generating the header in
review-inline.txt, but that's probably less reliable. And maybe it is
useful for local runs, idk.

> 
> commit sha...
> Author: ...
> 
> are useless in email reply, so we should still trim them.

