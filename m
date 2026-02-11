Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A573EBF1D;
	Wed, 11 Feb 2026 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770794315; cv=none; b=RAzHS9mq/XiKIn/wHWDqCPFeeHtsj2ZQk/ofypDVRhad9nlOxww3NxgZL2yVQpcuiuUg91EcPWIdewNVWMerdgyC/6xSYkFIp29/bTydn2Gja16klLLOmGFrCuUH+dZ3KIL6ubSqDv6Cy4R3CrUNWwyCbumuWl8OuquFeuieqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770794315; c=relaxed/simple;
	bh=DlHPA7+fAQXwy8Xzzn0XloSOvGo6H3h3ToD5iXXAO8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzJo0wAALmCXJZMDHb0KrCDTwlxHRjHJ8wpNw3FzRBigok7NWJemyZSDpBoAsOk6SBiy1pvL7MaX2Ybf/kUwboJ9OvOY5E+b/V37eQY3xI8piVJbUAhM+4rPVot2aokSHqYC6EVq+dCIAkiVG1u0GzmpQEYwML9fvgFEn2z+Ux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kGeNBSab; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kGeNBSab"
Message-ID: <69e43aec-be29-4bea-9c7a-063361c49921@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770794311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlfA83EbQmqXsAL83u0UXPPDk7Q6NWynl98AWY5anMQ=;
	b=kGeNBSabXFjOyNQbZyPjZmgyT5cmL9BNFR0mJkwWOLbkM5bpicKmbZfPnvyuH25xE416Pl
	Glt5hL+vIw2kIVdiZN7ygz3Zs6rThcJhhR+ODCGZgpBM3w1fGcGpMGIoPs7iNUUmMPLTxP
	wEXL/0DRD2UFz3A6pLGLIp81D4n4dqc=
Date: Wed, 11 Feb 2026 15:18:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Add preempt disable for
 bpf_get_stackid
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260206090653.1336687-1-chen.dylane@linux.dev>
 <20260206090653.1336687-2-chen.dylane@linux.dev>
 <CAEf4BzZwvAUgLwz-M0Y_NJLTmedyY9U6s7LrSmn751hQdTP4Uw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzZwvAUgLwz-M0Y_NJLTmedyY9U6s7LrSmn751hQdTP4Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/2/7 01:20, Andrii Nakryiko 写道:
> On Fri, Feb 6, 2026 at 1:07 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> The get_perf_callchain() return values may be reused if a task is preempted
>> after the BPF program enters migrate disable mode, so we should add
>> preempt_disable.
>> The get build-id offset in __bpf_get_stackid may increase the length
>> of the preempt disabled section. Luckily, it is safe to enable preempt
>> after perf callchain ips copied to BPF map bucket memory, so we can enable
>> preempt before stack_map_get_build_id_offset.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/bpf/stackmap.c | 84 +++++++++++++++++++++++++++----------------
>>   1 file changed, 53 insertions(+), 31 deletions(-)
>>
> 
> Let's take a step back and look at the bigger picture. This whole
> trace_in thing is still problematic because one way or another we do
> get perf_callchain_entry, which *needs* preemption disable. So we need
> to refactor __bpf_get_stackid() in such a way that we can do all these
> steps separately:
> 
> a) get stackmap entry (pcpu_freelist_pop parts)
> b) (under disabled preemption) get temporary per-cpu callchain_entry
> and copy its IPs into stackmap entry
> c) (now with preemption enabled) perform build ID fetch and transformation
> 

Ok, I've tried to follow this approach to make the code clearer. Thanks.

> Current logic is too coupled together to allow this, but conceptually
> there is nothing preventing us from breaking __bpf_get_stackid() (and
> see my replies in previous email, we should do similar breakup for
> __bpf_get_stack) into few separate steps.
> 
> We have to do this to make all of this work in all the combinations of
> sleepable/non-sleepable and with/without build id, IMO.
> 
> Take your time, don't rush, think this through. This is a bit of a
> maze of code, we should untangle it properly, not hack our way through
> it.
> 
> [...]


-- 
Best Regards
Tao Chen
