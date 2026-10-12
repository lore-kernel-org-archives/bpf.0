Received: from mail-m19731102.qiye.163.com (mail-m19731102.qiye.163.com [220.197.31.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B244C4FC
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795827; cv=none; b=WL3jVdGj7d/KIevAiTNWIhW5dW+chQusrQPYDymUqt7pCOtkJXZf6Xf4lQWNCte788y3xLr+hJpia0Ws+LILTXfGOFsVJBJePVQ0W+O/sOHpc3SSkTgY43BHeBDxm7SbqiKsHhnG0rDZaRpFKjjnGxM8/c+oYS2jpY5ynbnOzUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795827; c=relaxed/simple;
	bh=qq24gq8xOODGxEvRZIzQk13CKpmloXCbSVQeI82A8GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9kJ5Gi0ZEf6RQEmufzX2/yFI5JI9DjNsm8/8beRuPuPXz9iSfPVBKQKAgb16ktZq37uP4YU1q9L9wMxDAuihe+t8oEmDEbPN98dm/J/s97h7MpR/y0dI3MZ4r+0/vjx9ekNwxutmkIeUYpmnYYXoYllVjeS9z7cWFm6qMTR5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.31.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.0.59] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1ff4ec573;
	Mon, 12 Oct 2026 14:41:15 +0800 (GMT+08:00)
Message-ID: <d64b6ea9-20a6-47bf-b0ff-1f63d9c8ca20@easystack.cn>
Date: Mon, 12 Oct 2026 14:41:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mm/page_owner: add open-coded page_owner iterator
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
 <20261009112308.240769-4-zhen.ni@easystack.cn>
 <sashiko-outbox-165462@kernel.org>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <sashiko-outbox-165462@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa12ed8141e0229kunm8bb9177258ed1e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTh1CVk4fHUJIGRhMGUoZTlYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVCQk
	lOS1VKS0tVSkJLQlkG


在 2026/10/9 20:00, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] bpf: buffer overflow in bpf_page_owner_stack_snprint() due to missing __sz suffix
> - [High] bpf: Panic DoS and OOB read via untrusted stack depot handle in bpf_page_owner_stack_snprint()
> --
> 
> commit f5344767004d7fb48b115dd782835818e60504bc
> Author: Zhen Ni <zhen.ni@easystack.cn>
> 
> mm/page_owner: add open-coded page_owner iterator
> 
> This commit adds an open-coded bpf_iter for pages eligible for page_owner
> output. It also introduces a bpf_page_owner_stack_snprint() kfunc to render
> the stack trace for a stack_depot handle into a caller-provided buffer.
> 
>> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
>> index 33dc9dcd59dec..80693d4174077 100644
>> --- a/mm/page_owner_iter.c
>> +++ b/mm/page_owner_iter.c
> [ ... ]
>> @@ -114,3 +115,54 @@ int page_owner_iter_register(void)
> [ ... ]
>> +__bpf_kfunc int bpf_page_owner_stack_snprint(depot_stack_handle_t handle,
>> +					     char *buf, u32 buf_size)
>> +{
> 
> [Severity: Critical]
> Does this kfunc bypass the verifier's bounds checking for the buffer?
> 
> Because the buffer size argument is named buf_size instead of using the
> required __sz or __szk suffix (such as buf__sz), the BPF verifier treats it
> as an independent integer scalar. It only validates that the buffer points to
> a memory region of at least 1 byte.
> 
> If a BPF program passes a 1-byte valid buffer along with a maliciously large
> buf_size, stack_depot_snprint() will blindly write past the end of the buffer,
> which can corrupt adjacent stack, heap, or map memory.
> 

The size argument will be renamed to buf__sz.

> [Severity: High]
> Is it safe to accept an untrusted depot_stack_handle_t directly from the
> BPF program here?
> 
> Since the BPF verifier does not track scalar bounds for opaque handles, a
> program could pass a forged handle. If depot_fetch_stack() receives an
> invalid pool index, it unconditionally triggers a kernel warning:
> 
> lib/stackdepot.c:depot_fetch_stack() {
> 	if (pool_index >= pools_num_cached) {
> 		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
> 		     pool_index, pools_num_cached, handle);
> 		return NULL;
> 	}
> 	...
> }
> 
> This can panic systems configured with panic_on_warn=1.
> 
> Even if the index is valid, a maximized offset could cause the stack pointer
> to point near the end of the pool allocation. Accessing the stack size and
> entries would then result in an out-of-bounds read past the allocated pool.
> This can cause a hard page fault panic, or format arbitrary kernel pointers
> into the BPF-provided buffer, which the program could then exfiltrate.
> 
> Would it be better to change this kfunc to accept a trusted
> struct page_owner_scan *scan instead of a raw scalar?
> 
>> +	return stack_depot_snprint(handle, buf, buf_size, 0);
>> +}
>> +
>> +__bpf_kfunc_end_defs();
> 

I will take the trusted struct page_owner_scan * returned by
bpf_iter_page_owner_next() and use scan->po_snap.handle.



Thanks,
Zhen
