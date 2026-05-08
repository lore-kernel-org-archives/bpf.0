Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED33A5447;
	Fri,  8 May 2026 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232571; cv=none; b=GQxsunkKA8hosqbA06gWp7U/QnPwZrQ9tsywF0kjKqG+namJi4OKL9ty4xx0iM/rpwkgYFQr1zok2kmdY75ZoEoLiUaMmJ9QPLEIXCHP7rf6HkjDtRNO2YRRYy/oFTKYQy5fje96SDdMA8ZuP9ryANKBKuYV4KL2pk795FKcvGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232571; c=relaxed/simple;
	bh=OWocBCiCRiNzZ55rS8SQ7rdxXEK59IvkiVjXZanqfsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeTwvUJettOWfjs7P24Z+uF5FIF3ZIO/v9xBy9mGpsPni5Z8aWbIQzDwQ73cfmZQakgiFgEND520ULWMgAMt/NEoklY5M4QnplrQBOrluV7PPUSDeMWx6iDjz+soQBeFcIDU1mfz/Z2WGsDoDJe6I01hl7w2n/1DytzMqoczCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cJQp5qBE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cJQp5qBE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EC471BCA;
	Fri,  8 May 2026 02:29:23 -0700 (PDT)
Received: from [10.57.89.33] (unknown [10.57.89.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026973F7B4;
	Fri,  8 May 2026 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778232568; bh=OWocBCiCRiNzZ55rS8SQ7rdxXEK59IvkiVjXZanqfsI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cJQp5qBEs/JLgLFuzvpcp32McrOqjlMGbMXjGmHkHIXGcUNHowE+vQeYGeFv9VOh8
	 xG0W+EvheUw9fnBU051PPmx5gSEX3Md+Ie7b+CjyRH7ed0TgvbZH4pDkijF+Mc6fSO
	 f7gS6TVJCk0wocRk82rbK9ZRJZb+oBn9HT7WmZuY=
Message-ID: <26f2d829-1083-4cff-b737-a3701c7ddd85@arm.com>
Date: Fri, 8 May 2026 10:29:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Add scx_ai_numa scheduler example for AI
 workloads
To: Andrea Righi <arighi@nvidia.com>, Qiliang Yuan <realwujing@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, bpf@vger.kernel.org
References: <20260508-feat-scx_ai_example-v1-1-2b498af3514d@gmail.com>
 <af2XRpaX_rFh_GI9@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <af2XRpaX_rFh_GI9@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 08:56, Andrea Righi wrote:
> Hi Qiliang,
> 
> On Fri, May 08, 2026 at 03:51:35PM +0800, Qiliang Yuan wrote:
>> Implement an AI-focused NUMA-aware scheduler that optimizes task dispatch for
>> GPU-accelerated AI training. The scheduler maintains per-NUMA-node dispatch
>> queues to preserve L3 cache warmth and minimize remote DRAM accesses that
>> would stall GPU kernel launches waiting on CPU preprocessing.
>>
>> Key features:
>> - Per-NUMA-node DSQs (dispatch queues) to maintain cache locality
>> - Idle fast path that bypasses DSQ for minimum latency
>> - Per-task NUMA affinity tracking to remember task placement
>> - Work stealing across nodes to prevent starvation during load imbalance
>>
>> The BPF component (scx_ai_numa.bpf.c) implements the core scheduler
>> callbacks, while the userspace loader (scx_ai_numa.c) detects NUMA
>> topology, installs the BPF program, and reports per-node dispatch
>> statistics every second.
>>
>> This scheduler is suitable for AI training workloads where GPU command
>> launches depend on rapid CPU preprocessing with minimal scheduling latency.
>>
>> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> 
> I think this would be more appropriate for inclusion in
> https://github.com/sched-ext/scx.

That repo no longer hosts C schedulers though, no?
I guess it's trivial to convert this particular one to rust.

