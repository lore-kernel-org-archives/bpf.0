Received: from mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E14052A4
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586432; cv=none; b=fz1MiMk/bufq0Cr7gKN/UWptIabsvz1e64z4DF/jLc7k9QSurnEJYv49isoFDzhN7+hn1aAxNiX0VR/Y7Zd4cJ5usibbWRwsNsKIG3rJUa/ECOMtn1rurlHcVatxuex9F7V67K+6jmenuiE8qOv3e10R1aU9AkBOeOj9QjMEJPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586432; c=relaxed/simple;
	bh=HSHq58jeCE+eWcX3YxLp68lXMyOW8zWkwqkyWzBmR1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fFxP8CYjR4g2ZrnqAVXvZlicjYZEvqJYY97sbln2kpA/VUrIL4DsRF5zs4z/IgWpJdCcxhEZq2BQu39HBUKW34sEQY7m2zdZ+7DL7ytS7Oe5t1zix7MJ9+CDyMussT1cU4I9XjTYjzfc5K9MGmM3agZu9BUYfKkxxNDngDNy63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Btp4KmeE; arc=none smtp.client-ip=91.218.175.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Btp4KmeE"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HSHq58jeCE+eWcX3YxLp68lXMyOW8zWkwqkyWzBmR1k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789586414; v=1; x=1790191214;
 b=Btp4KmeEqzgbNb8NpGB8YjvPCzprYPSxDSsJV+3c+j30Uic8QlFN5Cpn/HhFwrRzKTFyHsZy
 D5aoPeD2GNCT870aPl2JXuWTtSoFKVvZuvPEtofwqAIcS2mi/Ms2llGsdUbuu6CEXhSPJwe7qLf
 tWZvYHLPvFdlt0nn3kGBWS3E=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f6a5b7a9c2e752b6;
	Wed, 16 Sep 2026 19:20:13 +0000
X-Mizu-Trace-ID: f6a5b7a9c2e752b6
X-Migadu-Flow: FLOW_OUT
Message-ID: <e426a91d-2364-4c30-a242-856c27db055a@linux.dev>
Date: Wed, 16 Sep 2026 20:20:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: local_storage: avoid redundant IRQ save on bucket
 locks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, ast@kernel.org,
 andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, martin.lau@linux.dev, morbo@google.com,
 nathan@kernel.org, ndesaulniers@google.com, song@kernel.org,
 yonghong.song@linux.dev, yatsenko@meta.com, kernel-team@meta.com,
 Amery Hung <ameryhung@gmail.com>
References: <20260916181001.201787-1-usama.arif@linux.dev>
 <DLGY7IFP8MOG.YFISSWRDGKR3@gmail.com>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <DLGY7IFP8MOG.YFISSWRDGKR3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/09/2026 19:22, Kumar Kartikeya Dwivedi wrote:
> +Cc Amery
> 
> On Wed Sep 16, 2026 at 8:10 PM CEST, Usama Arif wrote:
>> bpf_local_storage_update() takes the map bucket lock while holding
>> local_storage->lock. bpf_selem_unlink_map() does the same; its only
>> caller holds local_storage->lock. The outer lock is acquired with
>> raw_res_spin_lock_irqsave(), so interrupts are already disabled at both
>> sites.
>>
>> Using raw_res_spin_lock_irqsave() for the nested lock saves the already
>> disabled IRQ state and issues another IRQ disable. The matching unlock
>> tests that saved state before leaving interrupts disabled. On x86-64,
>> this adds a pushfq/popq/cli sequence and a test/branch around an
>> unreachable sti to each acquisition.
>>
>> Use raw_res_spin_lock() and raw_res_spin_unlock() instead. They retain
>> preemption nesting, memory ordering and resilient-lock bookkeeping. The
>> outer unlock remains responsible for restoring the caller's IRQ state.
>>
>> In the tested clang x86-64 build, this removes five executed instructions
>> from each uncontended nested acquisition. It also shrinks
>> bpf_local_storage_update() from 1732 to 1702 bytes and bpf_selem_unlink()
>> from 1030 to 992 bytes. The affected paths are updates that add or replace
>> an element in existing owner storage and successful unlinks.
>>
>> Document the owner-lock requirement of bpf_selem_unlink_map() and assert
>> that interrupts are disabled.
>>
>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>> ---
> 
> Makes sense. But did you observe any measurable improvement with this change?

Meta fleet wide profile shows bpf_local_storage_update() as one of the more expensive
bpf functions in the fleet. I saw it in production when profiling a hhvm workload as
well.

The main argument for the patch was reduced number of instructions executed in
this expensive path that I see in disassembly (which is mentioned in the 2nd paragraph)
and better code hygiene as it doesnt make sense to to save irq again. I would imagine
this patch alone wont move the needle in application metrics, but would make this function
cheaper (hopefully :)) fleetwide.


> 
>> [...]

