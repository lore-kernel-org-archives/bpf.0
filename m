Received: from mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FE7286D56
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255885; cv=none; b=YsCRBkxUOkpYenF6enVARSGZqghbo9Tvfk/Lprlg17T6joRgyp7T/2qWE+C+fmJaqU8xEvN22fL4Wps4NzJFDUsCuDSnotSBuGe1xB9Quq/h3qB897pWW2eoakJF9WamkYkz8N1jMgMQYfWxl6ppNnBpbu7GRKrK7BwMwkS77z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255885; c=relaxed/simple;
	bh=U+tcZw15K68mlanjAK2UomlTuTP3P1oMlvmlSPrqeWc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=omj7wvkaECp5eRgoeN3c6nQ71FiWv56iHfJoLqB4oIqua74ljohFl6D+AP0gZp556OUn5AfmcZs2ECxBcsN4e1fOWGeXvRll4v7YHSbjlHxcZ2w7170c5fY4dKEiIfk6bYBXqMLNs5Ymjo8859V5an91Rjr3Rq5nfTOYZScWbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oWIWW9PC; arc=none smtp.client-ip=91.218.175.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oWIWW9PC"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=U+tcZw15K68mlanjAK2UomlTuTP3P1oMlvmlSPrqeWc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788255879; v=1; x=1788860679;
 b=oWIWW9PCmW0CL63T+bQYiIuVZzYQVXfduq6nRxjRNKreWJPn5zCr5NOQcf1mj0yTFm9JYka+
 MHA/FhDp/WoQUKVYmtiTk7QsMgthPFYxDalhzDh52SCC++cZpm8vz3vwR+v0rPxAC/9321IYy0Z
 7HMnn46nscdo8N9uuqF12Y4U=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c7013bc8d2cf59a0;
	Tue, 01 Sep 2026 09:44:29 +0000
X-Mizu-Trace-ID: c7013bc8d2cf59a0
X-Migadu-Flow: FLOW_OUT
Message-ID: <d8665587-a825-48d8-afb2-53fe10af0546@linux.dev>
Date: Tue, 1 Sep 2026 17:44:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, tj@kernel.org, void@manifault.com,
 changwoo@igalia.com, michalblk@google.com, liwanwu@kylinos.cn,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 1/2] sched_ext: fix vtime priority queue inversion on wide
 vtime spread
To: Andrea Righi <arighi@nvidia.com>
References: <20260901024038.730424-1-cui.tao@linux.dev>
 <20260901024038.730424-2-cui.tao@linux.dev> <apZ06G_-oC5cTprM@gpd4>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <apZ06G_-oC5cTprM@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Andrea, Tejun.

在 2026/9/1 14:47, Andrea Righi 写道:
> Hi Tao,
> 
> On Tue, Sep 01, 2026 at 10:40:37AM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> scx_dsq_priq_less() compares dsq_vtime with time_before64(), a cyclic
>> comparison that is only valid when the values in the queue are less
>> than 2^63 apart. Unlike CFS, which enforces that invariant with
>> min_vruntime clamping, sched_ext takes dsq_vtime directly from the BPF
>> scheduler and cannot bound the spread. A scheduler that inserts tasks
>> with vtimes wider than 2^63 apart into one DSQ gets the order inverted:
>> the tasks it placed last run first and the rest starve. Reproduced with
>> a probe scheduler assigning half its tasks vtimes near 0 and the other
>> half vtimes above 2^63 -- four of eight busy tasks monopolized the CPU
>> while the other four starved.
>>
>> Compare with plain u64 < instead, which is a total order and always
>> honors the order the scheduler asked for. The transient misordering
>> around the natural 2^64 wrap is the same class of anomaly the cyclic
>> comparison trades it for, but bounded.
> 
> I don't think switching to plain u64 ordering is safe here.
> 
> The current scx_bpf_dsq_insert_vtime() documentation explicitly defines the
> ordering in terms of time_before64(), including wraparound. For example:
> 
>   a = U64_MAX - 5
>   b = 3
> 
> a is earlier than b in cyclic vtime ordering. time_before64(a, b) correctly
> returns true, while plain a < b would place b first.
> 
> Moreover, this is not a short transient. If post-wrap tasks continue to be
> reinserted with small vtimes, a can remain behind them until their vtime
> traverses almost the entire u64 range, resulting in effective starvation.
> 
> Can we preserve time_before64() and document or enforce the half-range
> requirement instead?
> 

You're both right, patch 1/2 was wrong. My probe fed values that
violate the rolling-cursor assumption, and the "inversion" was the
API behaving as documented. Dropping 1/2.

I'll send the documentation patch Tejun suggested.

Thanks,
Tao

> Thanks,
> -Andrea
> 
>>
>> Fixes: 06e51be3d5e7 ("sched_ext: Add vtime-ordered priority queue to dispatch_q's")
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>  kernel/sched/ext/ext.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
>> index 8041c87a3562..dd0ce01370d1 100644
>> --- a/kernel/sched/ext/ext.c
>> +++ b/kernel/sched/ext/ext.c
>> @@ -1417,7 +1417,8 @@ static bool scx_dsq_priq_less(struct rb_node *node_a,
>>  	const struct task_struct *b =
>>  		container_of(node_b, struct task_struct, scx.dsq_priq);
>>  
>> -	return time_before64(a->scx.dsq_vtime, b->scx.dsq_vtime);
>> +	/* dsq_vtime is arbitrary BPF input: keep a total order */
>> +	return a->scx.dsq_vtime < b->scx.dsq_vtime;
>>  }
>>  
>>  static void dsq_inc_nr(struct scx_dispatch_q *dsq, struct task_struct *p, u64 enq_flags)
>> -- 
>> 2.43.0
>>

