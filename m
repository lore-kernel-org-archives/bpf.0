Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7073EBF01;
	Sat, 24 Jan 2026 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769254201; cv=none; b=jGBITElbJUCx3ZLOHlRq0TQX6dK2kfpa2+MRw+cX1T44jRdYfZ9sbGnFCOO3D3e8oZVKEZ7Vp8ZFZytpI9SQyAiX8ukHYgF3V4/Z5T6gFqEJvNwkd9AFsm5zw0Ta/9Lyo65a1gqGo/QU5lkR6xJDkz4U5MCCL72wMs3V/YC3XlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769254201; c=relaxed/simple;
	bh=IrO9hNgOWsd5B+SRp4zrLjYCAzbHl5GjTs6B2AFTmmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCTtxcXd+lXA5TJxgTI4bdlP/IXnMTydyxvsEdYoOIhbMZJ44PuD0m3drZQhxGU16R0Gph8p6uZDOlxM/tCxKfqoqkP14+PuYFAseait4fMEhPw625BU2CU/tzL/59KLlzns3iWE1w3wZKWTMTCLbxL6PFiPoKpWmL8htHKYuAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Y8bCUnkz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Y8bCUnkz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xLdgTFSsgILLUq8UDqyG8adReEFkQdmZvwX/nd4lviI=; b=Y8bCUnkzodv+SH6kgBc7GXHSkB
	D+V9oYNYNK08Ih6XGXR9dDwMDv2LI3ZQoeIBztD0yXIikyvBxq9/nNblhNocTij0dDEs1FxFgjU6/
	tQHvE6HYaSNdqZGsOOJ96cOpX3KrZrTnNNR8ucV+/TGlcRsDDCAE2yqqL2VavDf7ih+upb23xqyDz
	MRXUbCic+SxPGQymaLqSPpBIhQes5A9V8g6fLeov2XSKU1vFIXS0H4qU42pRWTYaBaNrG0gNJELLG
	xJsVMJMLUW7YbDHEbWwcXQRK1nf4Hhj6v6mtE/69k5OYG6gw8U9+E4eR4rQUoSAmwQdFCHJE8Pyfk
	tKOwPNxQ==;
Received: from [175.114.83.198] (helo=[192.168.45.92])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vjbpc-009MZh-Hp; Sat, 24 Jan 2026 12:29:32 +0100
Message-ID: <933f94c8-d74c-4d01-8e55-d8dab3d79f61@igalia.com>
Date: Sat, 24 Jan 2026 20:29:20 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Introduce execution context
 detection kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 kernel-dev@igalia.com, bpf <bpf@vger.kernel.org>, sched-ext@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20260123084248.259278-1-changwoo@igalia.com>
 <20260123084248.259278-2-changwoo@igalia.com>
 <CAADnVQJTaYo0=aaTii6n+yXLuacLcc9XSj=PLgbq+-mn5Num9Q@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko, en-HK
In-Reply-To: <CAADnVQJTaYo0=aaTii6n+yXLuacLcc9XSj=PLgbq+-mn5Num9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alexei,

Thank you for the feedback.

On 1/24/26 1:37 AM, Alexei Starovoitov wrote:
> On Fri, Jan 23, 2026 at 12:43 AM Changwoo Min <changwoo@igalia.com> wrote:
>>
>> Introduce bpf_in_nmi(), bpf_in_hardirq(), bpf_in_serving_softirq(), and
>> bpf_in_task() kfuncs to allow BPF programs to query the current execution
>> context.
>>
>> While BPF programs can sometimes infer context based on the attach point,
>> certain programs (such as those in sched_ext) may be called from multiple
>> contexts. These kfuncs provide a reliable way for logic to branch based on
>> whether the CPU is currently handling an interrupt or executing in task
>> context.
>>
>> For example, this is particularly useful for sched_ext schedulers that need
>> to differentiate between task-to-task wake-ups and interrupt-to-task
>> wake-ups.
>>
>> As the names imply, these helpers wrap the kernel's internal in_nmi(),
>> in_hardirq(), in_serving_softirq(), and in_task() macros.
>>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>> ---
>>   kernel/bpf/helpers.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 637677815365..cb36bc7a80c6 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -4365,6 +4365,46 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
>>          return 0;
>>   }
>>
>> +/**
>> + * bpf_in_nmi - Test if the current execution context is in NMI context.
>> + *
>> + * Return: true if we are in NMI context, false otherwise.
>> + */
>> +__bpf_kfunc bool bpf_in_nmi(void)
>> +{
>> +       return in_nmi();
>> +}
>> +
>> +/**
>> + * bpf_in_hardirq - Test if the current execution context is in hard IRQ context.
>> + *
>> + * Return: true if we are in hard IRQ context, false otherwise.
>> + */
>> +__bpf_kfunc bool bpf_in_hardirq(void)
>> +{
>> +       return in_hardirq();
>> +}
>> +
>> +/**
>> + * bpf_in_serving_softirq - Test if the current execution context is in softirq context.
>> + *
>> + * Return: true if we are in softirq context, false otherwise.
>> + */
>> +__bpf_kfunc bool bpf_in_serving_softirq(void)
>> +{
>> +       return in_serving_softirq();
>> +}
>> +
>> +/**
>> + * bpf_in_task - Test if the current execution context is in task context.
>> + *
>> + * Return: true if we are in task context, false otherwise.
>> + */
>> +__bpf_kfunc bool bpf_in_task(void)
>> +{
>> +       return in_task();
>> +}
>> +
> 
> This functionality is already available.
> See bpf_in_interrupt() and get_preempt_count() in bpf_experimental.h.
> 
> No need to replicate that as kfuncs.

I see. While bpf_in_interrupt() provides a general check, certain use
cases in sched_ext require more granular differentiation -- specifically
between hardirq and softirq contexts to handle different wake-up paths
correctly.

> If something can be implemented as a bpf program it should stay as
> pure bpf code, since it's more flexible and faster this way.
> llvm together with JITs completely inline get_preempt_count().
> 

I agree. Implementing these checks as pure BPF code is more efficient
due to JIT inlining. I was initially hesitant to duplicate kernel-side
macros in BPF, but since the precedent is already established in
bpf_experimental.h, I will follow that pattern.

I will drop the kfunc implementations in Patch 1 and instead add
bpf_in_nmi(), bpf_in_hardirq(), bpf_in_serving_softirq(), and
bpf_in_task() to bpf_experimental.h by wrapping get_preempt_count().

I will also update the selftests in Patch 2 to use these new headers and
submit a v2 shortly.

Regards,
Changwoo Min
