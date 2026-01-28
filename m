Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658931531C1
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769568190; cv=none; b=jPG+oI7A+7NOuzT71muMQV3z3L1POeb24sLjAkG4osFQZllbURguMhahy3oLr6vqw5AfMm8cGma3mMZtBGbdxJlxF3+acBlGMxlCi1bjCpfgORAcuh2DwWn+LEAEC7gDXxSV8+8bKqppw8TYK7Y/Vk3+TzEy1ZiMtgPD8eq5vFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769568190; c=relaxed/simple;
	bh=PbWvRcJ3c+xdZWQtluSKFLPOZnTrfryBFE4JLh7QeOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOEnK0CzOgC8RZwcm33ab7ZTYMDnE4+sSZWpzopG0fXyClg1Jhum8T4rNgEGuL2cnxHS3H4s/dLJW91G3Hf5aLzOd9Rp9t0Y4OmAl1jucBQerCD+P2Xj5jl02/gmajjNZyukl6YhllWBMzvT56d3SLpEXZr7Y2YqMbQovoKhEXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IumkEMS6; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IumkEMS6"
Message-ID: <3b84f222-8d4c-4bb6-b224-946cd934ba56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769568186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cr0HBAa6ysK/fvkpmCswuBf4NAEKUQJpxydwXpZQlRw=;
	b=IumkEMS6gxgZModB023g2qIvBFgS7QwV+QoCJrkLVQCk4Qv47YOC2AKfIfQGmiBd8fwu3Z
	njh5nJx8w1eoYbT5DEYUL/XcTKrkecweqSearnw6rXhtek2LK9bfTC5DZUrG1lq7pB31Ro
	e47dGR41S55P+7JEnflFX9y/tKlhSLw=
Date: Wed, 28 Jan 2026 10:42:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev>
 <CAEf4BzZq8g_BciT3JNXuYZpzq9zphaVsvOTuOVnqjDS=9w73Gw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzZq8g_BciT3JNXuYZpzq9zphaVsvOTuOVnqjDS=9w73Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/1/28 05:07, Andrii Nakryiko 写道:
> On Sun, Jan 25, 2026 at 11:45 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>>  From BPF stack map, we want to ensure that the callchain buffer
>> will not be overwritten by other preemptive tasks and we also aim
>> to reduce the preempt disable interval, Based on the suggestions from Peter
>> and Andrrii, export new API __get_perf_callchain and the usage scenarios
>> are as follows from BPF side:
>>
>> preempt_disable()
>> entry = get_callchain_entry()
>> preempt_enable()
>> __get_perf_callchain(entry)
>> put_callchain_entry(entry)
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   include/linux/perf_event.h |  5 +++++
>>   kernel/events/callchain.c  | 34 ++++++++++++++++++++++------------
>>   2 files changed, 27 insertions(+), 12 deletions(-)
> 
> [...]
> 
>> +struct perf_callchain_entry *
>> +get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>> +                  u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie)
>> +{
>> +       struct perf_callchain_entry *entry;
>> +       int ret;
>> +
>> +       entry = get_callchain_entry();
>> +       if (!entry)
>> +               return NULL;
>>
>> -exit_put:
>> +       ret = __get_perf_callchain(entry, regs, kernel, user, max_stack, crosstask, add_mark,
>> +                                  defer_cookie);
>>          put_callchain_entry(entry);
>> +       if (ret)
>> +               entry = NULL;
>>
> 
> purely stylistical nit, so this can be ignored if you disagree, but I
> find code that modifies some variable before returning it slightly
> less preferable to more explicit:
> 
> 
> if (__get_perf_callchain(...)) {
>      put_callchain_entry(entry);
>      return NULL;
> }
> 
> return entry;
> 
>>          return entry;
>>   }
> 

agree, will change it in v9, thanks.

>> --
>> 2.48.1
>>


-- 
Best Regards
Tao Chen
