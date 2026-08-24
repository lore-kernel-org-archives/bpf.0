Received: from mta0.migadu.com (out-217.mta0.migadu.com [91.218.175.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5330E36B917
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576949; cv=none; b=ULG7CG/niNyRfcoUBNB2puXaakf+0/XzaGFZbF/tzKvJ8+EZvIPDiE7ncg94WldEaKUSHcfdBnUYyODAApJ2i8jNFj5hT9RWsHD6YMjcGzrwDDFRaOPy1o2GFGZT9HSYSl5/JlbLnqTJ6gnYyxs8KBZc54QwoKUz36TY+ZZ9de8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576949; c=relaxed/simple;
	bh=yscKTag0IJQGv9/KR0AUjg/as0gLtN/BNAtD6JEBZL4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SM7Ju21DCp1hika9PVynJlguD6H8ctNaCPQ9/sQERQzXOj3lCSMMaerluW4/ynWjhF1GTytRKSi1KrdH/sZlxF431Tob5BJxJ0y8SsffGAWxT10n7jqWkyEoWyT28NSzvraMvDdCyfN/uvdoEb7NG/UiQbZevPuXfijVFWH8Jko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JPPmYPX7; arc=none smtp.client-ip=91.218.175.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JPPmYPX7"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yscKTag0IJQGv9/KR0AUjg/as0gLtN/BNAtD6JEBZL4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787576944; v=1; x=1788181744;
 b=JPPmYPX70RM+Xb3j9f49Nh5GtaTqzBLMfZmMt9UT5o9zHXb4tLjsf4wZCsfyTt3CWGvkJe1s
 OQZ1++vhS2DUrCJTlbHUuvVcK1ivt7w2kn6kosqlW15l2o2iGW5NlGE/agGrTzksrMXoG3XW8DJ
 kNXUKwP/CPHUHSpnf1Bfu10c=
X-Envelope-To: bpf@vger.kernel.org
Received: from [192.168.110.173] (223.70.160.239)
	by smtp.migadu.com with ESMTPS id fe487304b85a5a72;
	Mon, 24 Aug 2026 13:08:54 +0000
X-Mizu-Trace-ID: fe487304b85a5a72
X-Migadu-Flow: FLOW_OUT
Message-ID: <1b2f54bd-97f5-4175-9a92-34871dd6f375@linux.dev>
Date: Mon, 24 Aug 2026 21:08:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, tj@kernel.org, void@manifault.com,
 changwoo@igalia.com, suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v3] docs/sched_ext: document that cgroup CPU knobs are
 scheduler-dependent
To: Andrea Righi <arighi@nvidia.com>
References: <20260824091501.547649-1-cui.tao@linux.dev>
 <aowxJK_KgBLLnyiN@gpd4>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <aowxJK_KgBLLnyiN@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Andrea,

在 2026/8/24 19:55, Andrea Righi 写道:
> Hi Tao,
> 
> On Mon, Aug 24, 2026 at 05:15:01PM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> The fair class enforces cpu controller knobs such as cpu.max,
>> cpu.weight and cpu.idle in the kernel. sched_ext only passes them to
>> the BPF scheduler through the ops.cgroup_set_*() callbacks. Whether
>> and how a knob takes effect is up to the loaded scheduler: it may
>> implement the corresponding callback partially or not at all. The
>> same applies to other knobs like nice levels.
>>
>> Document this in the basics section so users and container
>> orchestrators know what to expect from a BPF scheduler.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>> v2 -> v3: Drop the scheduler list and the nr_throttled example, keep
>> the section concise and generic, per review.
>>
>> v2: https://lore.kernel.org/r/20260819012157.220932-1-cui.tao@linux.dev
>>
>>  Documentation/scheduler/sched-ext.rst | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
>> index 35b550671ca7..b594d93dd6aa 100644
>> --- a/Documentation/scheduler/sched-ext.rst
>> +++ b/Documentation/scheduler/sched-ext.rst
>> @@ -242,6 +242,18 @@ optional. The following modified excerpt is from
>>              .name                   = "simple",
>>      };
>>  
>> +Scheduler-Dependent Knobs
>> +-------------------------
>> +
>> +The fair class enforces cpu controller knobs such as ``cpu.max``,
>> +``cpu.weight`` and ``cpu.idle`` in the kernel. sched_ext only passes
>> +them to the BPF scheduler through ``ops.cgroup_set_weight()``,
>> +``ops.cgroup_set_idle()``, ``ops.cgroup_set_bandwidth()`` and friends.
> 
> Existing cpu.weight and bandwidth values are delivered via ops.cgroup_init(),
> ops.cgroup_set_*() callbacks handle later changes.
> 
> Moreover, cpu.idle state is not included in scx_cgroup_init_args, so apparently
> BPF schedulers don't receive an initial value (only subsequent writes). This
> should be probably fixed separately.
> 
>> +Whether and how a knob takes effect is up to the loaded scheduler: it
>> +may implement the corresponding callback partially or not at all. The
>> +same applies to other knobs like nice levels. When relying on these
>> +knobs, check the documentation or source of the loaded scheduler.
>> +
> 
> "nice levels" can be a bit ambiguous, per-task nice changes are converted to
> weights and reported through ops.set_weight(), writes to the cgroup file
> cpu.weight.nice are reported through ops.cgroup_set_weight().
> 
> Maybe we can rephrase the whole paragraph as following, or something along these
> lines:
> 
>   The fair-class scheduler enforces CPU controller settings such as cpu.max,
>   cpu.weight, and cpu.idle. For sched_ext tasks, the scheduler core communicates
>   these settings to the BPF scheduler through ops.cgroup_init() and reports
>   subsequent changes through the corresponding ops.cgroup_set_*() callbacks.
>   Similarly, per-task nice changes are converted to weights and reported through
>   ops.set_weight().
> 
>   Each BPF scheduler is responsible for implementing the scheduling semantics of
>   these settings and may choose to ignore them. Consult the loaded scheduler's
>   documentation before relying on these controls.
> 

Thanks for the review. v4 adopts your wording: ops.cgroup_init()
for the initial values, ops.cgroup_set_*() only for subsequent
changes, and per-task nice disambiguated from cpu.weight.nice via
ops.set_weight().

On the missing cpu.idle initial value in scx_cgroup_init_args: I can
look into a separate fix for that.

Thanks,
Tao

> Thanks,
> -Andrea

