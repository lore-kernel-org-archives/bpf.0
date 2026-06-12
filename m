Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10C37B028
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781229828; cv=none; b=JrJ8coPUXRv1OZZSfvf+dW/8n6Pb28AaGyo4ScinT/nXSW30Th8bvYKfCRui254RG+qvdJopnZU9LA9W2gG8TObdowpHuJmkXWNlJy2oeXdwMxmB392xp1hDLyLr+qO+OEiNjbhA0XVFQdtFrzgqXhg+7e5By6uIA0KmBwRaQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781229828; c=relaxed/simple;
	bh=m67m23a4xG0qobqWHnalNzioJ8dJ8P8FvC6Fy+Hmk/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3PG5h5SE61s3H4UGXrY5EuqlgVZVAqZutgLdC5Atf9ZP2lnaG0Gub/Iho7RxXCflZTeGmetqel0u1NTDtVf4w7JmzL2qnomY2yY6vQbQ4Xa0J3lhaJP17fstQqyKU+kvxe1ChJmBdiESrAtUe2Ug2TbnjhlcNUUFR2JMu50I68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I26CQV6r; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I26CQV6r"
Message-ID: <8906e52a-8206-4e7b-a51c-d3dc0c77da43@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781229812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQP9CqQmvWyk3jJqtDYRhh6E+VRdGuATnnUeQW3MGWs=;
	b=I26CQV6r+6O8OeLQfow8n27dnUYT+oXNxXWZbECaNDxp/c2krrgOJd1lq/VpOzWrCteDjg
	D4TyOiMdFeCo2ZxeZclgo9OCWcYuGD8kVho6PT9xxR5My6MMR6cYnq67xH969ombestDOQ
	VI9FfgsSHjNo/MtlKV41OCHdrsIef+o=
Date: Fri, 12 Jun 2026 10:03:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/7] bpf, sockmap: reject overflowing copy + len in
 bpf_msg_push_data()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>, Xiang Mei <xmei5@asu.edu>,
 Xinyu Ma <mmmxny@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>,
 Shuah Khan <shuah@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Sechang Lim <rhkrqnwk98@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
 <20260611123538.156005-2-jiayuan.chen@linux.dev>
 <DJ6DKMNBR4UX.27HEZMGEPEF7T@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <DJ6DKMNBR4UX.27HEZMGEPEF7T@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/12/26 12:53 AM, Alexei Starovoitov wrote:
> On Thu Jun 11, 2026 at 5:34 AM PDT, Jiayuan Chen wrote:
>> From: Weiming Shi <bestswngs@gmail.com>
>>
>> When the scatterlist ring is full or nearly full, bpf_msg_push_data()
>> enters a copy fallback path and computes copy + len for the page
>> allocation size. Since len comes from BPF with arg3_type = ARG_ANYTHING
>> and both are u32, a crafted len can wrap the sum to a small value,
>> causing an undersized allocation followed by an out-of-bounds memcpy.
>>
>>   BUG: unable to handle page fault for address: ffffed104089a402
>>   Oops: Oops: 0000 [#1] SMP KASAN NOPTI
>>   Call Trace:
>>    __asan_memcpy (mm/kasan/shadow.c:105)
>>    bpf_msg_push_data (net/core/filter.c:2852 net/core/filter.c:2788)
>>    bpf_prog_9ed8b5711920a7d7+0x2e/0x36
>>    sk_psock_msg_verdict (net/core/skmsg.c:934)
>>    tcp_bpf_sendmsg (net/ipv4/tcp_bpf.c:421 net/ipv4/tcp_bpf.c:584)
>>    __sys_sendto (net/socket.c:2206)
>>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>>
>> Add an overflow check before the allocation.
>>
>> Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
>> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
>> Tested-by: Xiang Mei <xmei5@asu.edu>
>> Tested-by: Xinyu Ma <mmmxny@gmail.com>
>> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> That's not the right way to post somebody else patches.
> You need to keep their authorship and SOB (as you did),
> but you also need to add your SOB after theirs.
>
> also pls target bpf-next.


Thanks Alexei, and sorry for the noise -- I'm still new to handling other
people's patches.

I'll keep their authorship and SOB and add my own SOB and retarget to 
bpf-next.


