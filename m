Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B80101E6
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712201527; cv=none; b=POLbyvf0hzMJ3kTmfOSLhmt9vhG+khhoIMEYY1HBEAtWQCDU88cKDJjeWXzqMxb0bIltNuZ5BjMf+t6ncMKSRt0x8rttTitwB796yixZG9f/CSsRJVEmmRRb8AY3Eik08ZKDZiCSoGlZOejraT7SGV8so1D4aBH67+jxP7ZT5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712201527; c=relaxed/simple;
	bh=+uEaxQJooS4pt95vVxLLbpZCK6tZCOl+8P4WMzLwzQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5waBaP7eUxfn8EjYeHGhILLNd0XpbI7+KdZUViw4yHBwI1srdow4IapQLcZADGCdHPR2c1x29o/ztXl+szLxPinUOHExjsm+BvpFuIYa1kji6osiCjWf+fEUWsXXlkG91jIh3eRDV2hbnTK/TkSZxnS2odWxzhzZbRmJeb0gwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SGIhfpIS; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SGIhfpIS"
Message-ID: <d3c6024d-f57a-4e41-ba1e-07ca6d5fcd79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712201522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eeLVC5i8RmRzP3mEzig5C5qlaBnVGyxRnjWUKKc+tTw=;
	b=SGIhfpIShRx5EOBveK6KWVyu6oBsM0TF6sf9bVUnYr4zNbmFtxc1oqx00KxrIngd54z2DM
	IoufXC2S98RI2Jpe7QCUPkKW8VoRwbQBSCBVHWDc3VsMhYe2ANFQ1xzoBwMlKfOik85pw0
	JHay/RCy8Q/3iByE7/ILLTaYRkVMqS8=
Date: Wed, 3 Apr 2024 20:31:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: run bpf prog w/o sockmap [was: bpf: Add bpf_link support for
 sk_msg and sk_skb progs]
Content-Language: en-GB
To: John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022158.656285-1-yonghong.song@linux.dev>
 <CAEf4BzbkcKFVEWaHSavbRi9+9VQMbqCgP36p9fzk6Hai2v2izA@mail.gmail.com>
 <27046774-e3d6-40c2-b3e3-ae6e64ecd33b@linux.dev>
 <CAEf4BzaYh6q_0TUUARd8m0eK+5RBxWQJ8=-n84vdayPPh4Z61g@mail.gmail.com>
 <660d964a1444b_1cf6b20885@john.notmuch>
 <e49ccf43-ae90-4df1-bc10-5ee180ec47ec@linux.dev>
 <660dfe2f46769_24afa20845@john.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <660dfe2f46769_24afa20845@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/3/24 6:11 PM, John Fastabend wrote:
> Martin KaFai Lau wrote:
>> On 4/3/24 10:47 AM, John Fastabend wrote:
>>> on my todo list, I want
>>> to just remove the map notion and bind progs to socks directly.
>> Run the bpf prog without the sockmap? +1, it would be nice.
> Part of my motivation for doing this is almost all the bugs syzbot and
> others find are related to removing sockets from the map. We never
> do this in any of our code. Once a socket is in the map (added at
> accept time) it stays there until TCP stack closes it.
>
> Also we have to make up some size for the map that somehow looks like
> max number of concurrent sessions for the application. For many
> server applicatoins (nginx, httpd, ...) we know this, but is a bit
> artifically derived.
>
>>> but other than quick hacks I've never built such a thing nor ran it
>>> in production.
>> How do you see the interface will look like (e.g. attaching the bpf prog to a sk) ?
> I would propse doing it directly with a helper/kfunc from the sockops
> programs.
>
>    attach_sk_msg_prog(sk, sk_msg_prog)
>    attach_sk_skb_prog(sk, sk_skb_prog)
>
>> It will be nice if the whole function (e.g. sk->sk_data_ready or may be some of
>> the sk->sk_prot) can be implemented completely in bpf. I don't have a concrete
>> use case for now but I think it will be powerful.
> Perhaps a data_ready prog could also replace the ops?
>
>    attach_sk_data_ready(sk, sk_msg_data_ready)
>
> The attach_sk_data_ready could use pretty much the logic we have for
> creating psocks but only replace the sk_data_ready callback.

sounds a good idea. Do we need to support detach function or atomic
update function as well? Can each sk has multiple sk_msg_prog programs?

>
>> [ It is orthogonal to what Yonghong is doing, so the title changed ]
>>
