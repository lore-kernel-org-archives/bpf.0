Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162492C3248
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442064; cv=none; b=vFECVvD7DAkBeW+VV2SMPsRHr1eW6Q9eVOP7ReVTbe9ywD1hMOT55b4fvG+0PE4bkDMPykorfuqFuToSoc1jc+ebLFwwn8sJyGBBgOgEXpWT9GGRSHb7d5HW0E2ji2KyE3xrpyL2LA1UMVvBu+ugQeTzXMbOwFO1uh+jx0szzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442064; c=relaxed/simple;
	bh=nulA4mj4+UQdm5g3raviTfCEHgpZLSlwhDZtYYW7pmA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=muERXNR/TJewG5GVFFXkh8SLZ4AG+rdDq6x6Eop39YRBTPbPeDcJXts2tQPHa9i2V2Wj6tNviZR5kjmqSJWBMVUCZBEg73gEf+xINhCyD58L51KeZfx7lAcl7bKTGRzwg/8314aFbCTbzgS2ZL8AcRkh4S6ahEUACCItMd/BcYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=js8Qn5lJ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="js8Qn5lJ"
Message-ID: <b332207a-abd8-402a-9ce1-c1f502ed1fca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776442060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fvbgx03+qk8xfotWRd4EmEXgxaFer2/vBE0LyGuEiQs=;
	b=js8Qn5lJHUcLSBLiHtitMfdukLsOTuujqdl0FMUI/+PoOG8cODLuwqE8s7qI2hwKkuT46C
	Fwfw2jPu8RlQhob6wq4HTXZCEiVcNkKalVyIuwyw+9Ewz056NPSnQqm6qBccdefv+/m50f
	l64OI3HuUt8cp5STTRFcH0PcDuCuLwU=
Date: Sat, 18 Apr 2026 00:07:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 5/8] bpf: Update per-CPU maps using
 BPF_F_ALL_CPUS flag
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20260414132421.63409-1-leon.hwang@linux.dev>
 <20260414132421.63409-6-leon.hwang@linux.dev>
 <l6hz6k6ecgmgcwsqt63ozobbzeryupq5os5oay42tlyqom776d@z6gq7eq44eua>
 <3578a97a-bb70-4644-ab9c-4cf95be533e2@linux.dev>
Content-Language: en-US
In-Reply-To: <3578a97a-bb70-4644-ab9c-4cf95be533e2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/4/17 09:33, Leon Hwang wrote:
> On 15/4/26 10:21, Alexei Starovoitov wrote:
>> On Tue, Apr 14, 2026 at 09:24:17PM +0800, Leon Hwang wrote:
>>> When updating per-CPU maps via the lightweight skeleton loader, use
>>> a single value slot across all CPUs. This avoids two potential issues
>>> when updating on an M-CPU kernel with N cached slots (N < M), especially
>>> when N is much smaller than M:
>>>
>>> 1) The update may trigger a page fault when copying data from the last
>>>    slot, as the read may go beyond the allocated buffer.
>>> 2) The update may copy unexpected data from slots [N, M-1].
>>>
>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>> ---
>>>  kernel/bpf/syscall.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index b73b25c63073..f0f3785ef57d 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -1785,6 +1785,21 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>>>  		goto err_put;
>>>  	}
>>>  
>>> +	/*
>>> +	 * When updating per-CPU maps via the lightweight skeleton
>>> +	 * loader, use a single value slot across all CPUs. This avoids
>>> +	 * two potential issues when updating on an M-CPU kernel with
>>> +	 * N cached slots (N < M), especially when N is much smaller
>>> +	 * than M:
>>> +	 * 1) The update may trigger a page fault when copying data from
>>> +	 *    the last slot, as the read may go beyond the allocated
>>> +	 *    buffer.
>>> +	 * 2) The update may copy unexpected data from slots [N, M-1].
>>> +	 */
>>> +	if (bpfptr_is_kernel(uattr) && bpf_map_supports_cpu_flags(map->map_type) &&
>>> +	    !(attr->flags & (BPF_F_CPU | BPF_F_ALL_CPUS)))
>>> +		attr->flags |= BPF_F_ALL_CPUS;
>>
>> This looks like a hack. It's not addressing the actual bug.
>> If there is a bug submit it separately with fixes tag.
> 
> Sure, will verify whether it is a bug. If it is, will fix it with
> separate patch.
> 

By implementing two selftests [1] against syscall progs and lightweight
skeleton, it is not a real issue.

The assuming oob reading might occur when updating percpu_array map
using a small value buffer for syscall progs. However, the oob reading
won't make kernel panic, because copy kernel memory using
copy_from_kernel_nofault(). However, as for lskel, the oob reading
doesn't occur, even set value size as 32000 and update percpu_array map
using an int.

The assuming issue #2 that copies unexpected data is true for both
syscall progs and lskel. However, I think it's users' responsibility to
correctly update percpu_array map using big enough value data.

In conclusion, I'll drop this patch from this series, and won't send
separate patch because it is not a bug.

[1] https://github.com/Asphaltt/bpf/commits/bpf/lskel-oob/v1/

Thanks,
Leon


