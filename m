Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604217D6
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777185097; cv=none; b=WZEi7hwEQ8zBFGObE1OI4rfjUcFfaHmHMUmXjUJdNFaQifmoRhjGL8dpRHAKfFsGBvV7W/j5J3cEhSN8zqRPgABlWRETsZW7kYxC1RUuIVz+d9R9OgA+RTuKePACmptbWuBviyGEm+zZILD27E1Brlmdjo/Xnvay5uxVDQD2aAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777185097; c=relaxed/simple;
	bh=HxZVHvWazSVorOvbpUJDJhXnaoAWTKCRWrUhAhzsq0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhQrKfA/Yz4d6hQGx9DkwabnLRGmYxw5tAQblwTkgVqf5TH/wJ5l2OabxKZahZAA5agaFnPMiFoGFhF753b/pLUTWwLeSxchPgXcVHgYrENsnBBfR61c56HTmWxdU8S5YL7atpR6xBbNSXehnf7VwVfIFvmrYqvBDkbZEcIDEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qUraleRI; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qUraleRI"
Message-ID: <daab27eb-2763-462b-8a9f-34adf0c92e0b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777185093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hcsw6u5oUUHH4lK0hwux6zR3OGq3uFxkPRUG26PVa5Q=;
	b=qUraleRIi/EyCohjYn2anF9Btn8a9wY0sT35yziTGOQMt/MbggGIR+OnbXTX4sdxfvOnJ3
	gNnqfgRScqb77nvNSdn0uxC1ShrMJdmM/DAG1pMZsxw9Q4yP6zEXJuTt5/Souia32wR4eg
	ItNqMVDBNhDywQPHfcGVjhIul9vHil8=
Date: Sun, 26 Apr 2026 14:31:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: zero-initialize pages allocated in
 bpf_msg_push_data
To: Weiming Shi <bestswngs@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Simon Horman <horms@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
 Xinyu Ma <mmmxny@gmail.com>
References: <20260424190310.1520555-2-bestswngs@gmail.com>
 <c4a9412d-b6ad-4b80-9580-865575f4152c@linux.dev> <aey55I9gC0VtaN1p@Air.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <aey55I9gC0VtaN1p@Air.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/26/26 1:59 AM, Weiming Shi wrote:
> On 26-04-25 11:17, Jiayuan Chen wrote:
>> On 4/25/26 3:03 AM, Weiming Shi wrote:
>>> bpf_msg_push_data() allocates pages via alloc_pages() without
>>> __GFP_ZERO. In the non-copy path, the entire page of uninitialized
>>> heap content is added directly to the sk_msg scatterlist, which is
>>> then transmitted over TCP to userspace via tcp_bpf_push(). In the
>>> copy path, a gap of len bytes between the front and back memcpy
>>> regions is similarly left uninitialized.
>>>
>>> This leads to a kernel heap information leak: stale page content
>>> including kernel pointers from the direct-map and vmemmap regions
>>> is transmitted to userspace, which can be used to defeat KASLR.
>>>
>>> Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
>>> page is always zeroed before it enters the scatterlist.
>>
>>
>> As the helper's own documentation says:
>>
>>      If a program of type BPF_PROG_TYPE_SK_MSG is run on a msg it may
>>      want to insert metadata or options into the msg. This can later be
>>      read and used by any of the lower layer BPF hooks.
>>
>> The inserted region is meant to be written by the BPF program — that's the
>> entire point of calling push.
>>
>> If the program doesn't fill it,  the push has no purpose to begin with.
>>
>>
>> Isn't the uninitialized content a bug in the BPF program rather than
>> something the kernel helper should paper over?
>>
> Hi, Thanks for the review.
>
> In my testing a process with only CAP_BPF + CAP_NET_ADMIN can receive
> kernel heap and vmalloc pointers through recv() from the uninitialized
> pushed region. The uninitialized memory contains critical kernel metadata
> such as direct-map and vmalloc pointers, which breaks KASLR.
>
> Kernels without CONFIG_INIT_ON_ALLOC_DEFAULT_ON (e.g. RHEL) are
> directly affected the leak is not masked by any mitigation.
>
> Thanks,
> Weiming Shi
>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


Previously I thought this was as same as bpf_xdp_adjust_head / 
bpf_xdp_adjust_meta,
but the function itself allocates a page, I believed the cost of 
GFP_ZERO flag was irrelevant.

Add one more thing: in the future, more and more AI systems will 
complain about
this kind of problem. I believe it is worth it.


