Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598671C695
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776390888; cv=none; b=EBsrseJSXOOwdnh/HK4JVvYzoEWnC4hAaRZZ5e3ZwlYNoBb9LEZwCF8uINdGsUIceqxoT8JsTaJM2VaXm8U80AAEqpNQ4n7TLb4flkO4aw18nBA9zji/WgOg6ATSeehxG3mFjYiVJduPPnHRv2GYiJ4AUQbMfxNXTglBv1TUZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776390888; c=relaxed/simple;
	bh=AkowlI6a1ulQP8DvV7doe6dwZNvkxGJxnbM+JdPJGYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Heb4C8dxpUqCxbl3GLS9nwjL2nLCT/ngiA9CmlUWx5ZXtS4wqFiO8tSbQ97odmw5Gv2B9J71VeWvam7tlcu+9xs5+IgHntIe+7fWwIoO8l/nc1VXy54F4SirtWUDsklwnZ/qBXQ2VicwqRc9ksH+e03h6lb8111JtWbFE9X8nKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lCsC0gzc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lCsC0gzc"
Message-ID: <e9a504b8-e5c9-44b6-b614-916d5173038e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776390884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FWx6Sy9ILhjoG1eUpt0XKmcV3sJesZXHhc/MD2VX+oA=;
	b=lCsC0gzcs8WY556KD0d5NozSASugwr8dtJSx5TgJdCo+u7vJSQyqM46JTxYnfowen9e2jD
	2+ndsJDOY+QwQDaW4p6JA7oiC7K8RkPuX4l2KOTWT+p5Ib6/JRWy8RgUIv8+IuhtT15jf8
	h+l8ixJ0ts9sX6R6cO/FpSvgR3oWvko=
Date: Fri, 17 Apr 2026 09:54:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 5/8] bpf: Update per-CPU maps using
 BPF_F_ALL_CPUS flag
Content-Language: en-US
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260414132421.63409-6-leon.hwang@linux.dev>
 <20260414210235.2262BC19425@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260414210235.2262BC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/4/26 05:02, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
[...]
>> +	/*
>> +	 * When updating per-CPU maps via the lightweight skeleton
>> +	 * loader, use a single value slot across all CPUs. This avoids
>> +	 * two potential issues when updating on an M-CPU kernel with
>> +	 * N cached slots (N < M), especially when N is much smaller
>> +	 * than M:
>> +	 * 1) The update may trigger a page fault when copying data from
>> +	 *    the last slot, as the read may go beyond the allocated
>> +	 *    buffer.
>> +	 * 2) The update may copy unexpected data from slots [N, M-1].
>> +	 */
>> +	if (bpfptr_is_kernel(uattr) && bpf_map_supports_cpu_flags(map->map_type) &&
>> +	    !(attr->flags & (BPF_F_CPU | BPF_F_ALL_CPUS)))
>> +		attr->flags |= BPF_F_ALL_CPUS;
> 
> Does this unintentionally break the bpf_sys_bpf() helper API for
> BPF_PROG_TYPE_SYSCALL programs?
> 
> Because bpf_sys_bpf() also wraps the pointer with KERNEL_BPFPTR,
> bpfptr_is_kernel(uattr) will evaluate to true for any eBPF program calling it.
> 
> Prior to this patch, a BPF_PROG_TYPE_SYSCALL program could legitimately
> update a per-CPU map with distinct values for each CPU by providing an array
> of num_possible_cpus() elements and omitting any CPU flags, which mirrors
> standard user-space API semantics.
> 
> With this change, it appears the kernel silently overrides attr->flags by
> setting BPF_F_ALL_CPUS. This truncates the internal value_size calculation
> down to a single element (map->value_size), reads only the first element
> of the BPF program's provided buffer, and incorrectly replicates it across
> all CPUs.
> 
> Should this workaround for the skeleton loader be constrained to
> bpftool gen skeleton instead of mutating the core syscall handler?
> 

It was my intent. Even though BPF_PROG_TYPE_SYSCALL progs could be
broken, it should be fixed when verifying the oob issue is true for
SYSCALL progs.

This patch will be dropped from this series. And, a separate patch will
be posted if the oob issue is true.

Thanks,
Leon

