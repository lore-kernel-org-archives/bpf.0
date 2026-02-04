Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF8B31A549
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189360; cv=none; b=pfcvv7ME4dCY8ijGGV/g7QRmY8rwQrLY3NGlT9A3TwzZvXWlTQvWqYuNYNZagBURpg1+BW/9C8GYKaMBb79iuEX2kHxAzrZox/U17MqBatYOhVmrNTicTexOnuklDaJBN4Wdn2tB3s88mARwzIKBCbMJrmJm+rLS6iSRvl/aJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189360; c=relaxed/simple;
	bh=Fb1JguzNlrjEL6SazegIH4xSNcYGMvK/YOd9uZglxjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6a4J3X5lLZ60+XKDucZxMzxj8S5O9SaPgQl6veBk4ZjMGVHdH/HIW9MNX/I05H2dCEKwQ7S3RkJktCXT8llfqaKHBn+8tAcP4ogn1u8gDWMhtxfxwQHVuXkeALWfnqoeZfn9zvC62GMA2bCcHXXY8b9avVUECci/SZzL2eRn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FhdEUhiM; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FhdEUhiM"
Message-ID: <80865b12-7786-4787-81c8-08b754716a5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770189357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIzahF4fKiLYiAsLF0Jwew4BLtV36PrwNYbnuxLSg1w=;
	b=FhdEUhiMa8LB4K5xC9Df0p8ff3q2uin4eJhHxBVqPKGEUlIZqLNRWeR93cjKgzVvWgaUaX
	5L4sABf7CboDTUh8OXj9Rtih9VRPFX/c8jiiOf7ht7SX4Y9FzQyVPEZgj/IlFX30k0Xwho
	wppfl3xQijscSEuL85HJKAgntZP0eh0=
Date: Tue, 3 Feb 2026 23:15:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Kuniyuki Iwashima <kuniyu@google.com>, mhal@rbox.co
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jakub@cloudflare.com,
 john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
 <20260203200242.404131-1-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260203200242.404131-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/3/26 11:47 AM, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Tue, 3 Feb 2026 10:57:46 +0100
>> On 2/3/26 04:53, Martin KaFai Lau wrote:
>>> On 2/2/26 7:10 AM, Michal Luczaj wrote:
>>>> In related news, looks like bpf_iter_unix_seq_show() is missing
>>>> unix_state_lock(): lock_sock_fast() won't stop unix_release_sock(). E.g.
>>>> bpf iterator can grab unix_sock::peer as it is being released.
>>>
>>> If the concern is the bpf iterator prog may use a released unix_peer(sk)
>>> pointer, it should be fine. The unix_peer(sk) pointer is not a trusted
>>> pointer to the bpf prog, so nothing bad will happen other than
>>> potentially reading incorrect values.
>>
>> But if the prog passes a released peer pointer to a bpf helper:
>>
>> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
>> Read of size 1 at addr ffff888110654c92 by task test_progs/1936

hmm... bpf_skc_to_unix_sock is exposed to tracing. bpf_iter is a tracing 
bpf prog.

> 
> Can you cook a patch for this ? probably like below

This can help the bpf_iter but not the other tracing prog such as fentry.

> 
> ---8<---
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 02ebad6afac7..9c7e9fbde362 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3740,8 +3740,9 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
>   		return 0;
>   
>   	slow = lock_sock_fast(sk);
> +	unix_state_lock(sk);
>   
> -	if (unlikely(sk_unhashed(sk))) {
> +	if (unlikely(sock_flag(other, SOCK_DEAD))) {
>   		ret = SEQ_SKIP;
>   		goto unlock;
>   	}
> @@ -3751,6 +3752,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
>   	prog = bpf_iter_get_info(&meta, false);
>   	ret = unix_prog_seq_show(prog, &meta, v, uid);
>   unlock:
> +	unix_staet_unlock(sk);
>   	unlock_sock_fast(sk, slow);
>   	return ret;
>   }
> ---8<---
> 
> Thanks!

