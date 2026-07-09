Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615E39A7F5;
	Thu,  9 Jul 2026 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598126; cv=none; b=b2xQN5W7FPhRLuspO7xYoZ/cX2A+Ajd5REOzeGMQU7GCh1t8aMijSWl/FwmXxsiStSMNiOAdjzqpYniBjvMDIzL+hEhMk4enFm3+P3vg6B5x2uveHFch5aPsdzv6KMNm0J8ZsDbcm6HAuqRoOHup8Jw1kDoof6w/i8g7O0gD7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598126; c=relaxed/simple;
	bh=bCNossEeZ0inwxzXPkoSEYgfKI5nca1J7WOrQta5+ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmYgl/M2g4wzJLWlo2ilgCSde0t7X11GBr/V4uVf5njHuNe4ZLwTTIeeySvE1t8S35DJfz/q40PPt+DcHEljJBnR/nDnndOjxJKY8pgH2yFGwphOG2ubUAp8DjfJrk5Ni+RiYRX4/yll3HJIj9Y9/05EoPonXTMRpULjYUs2HgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=eOxqtakS; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="eOxqtakS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ksXUMFlciHDceRDaryNPqxWMMDzzkTmWa9cZy3atTSY=; b=eOxqtakSjpjVlsnI84sOkEbrt8
	ysi9ZE+0iuCdr4MMDCjqT2UIg/nfYeMB36YEhrMo0UM8r8ibMB/kCBA7Z6yEJpdk2Qyk+wpzx6TIc
	FT+dPNwDge/8Ow1VcyrNNw4Impwj7CzVvxYBwclk8GShdNGFqe19ULRVqFEpGBegHXPpMQ3FVXgst
	+swcVCRQqn9ZyIRDysIlQV9tL7cVo2RVrLt6hA6famqwhPIc2QQDeKizS7eHSomdBT4d+UMaRQ+vw
	Pjc3Wn68mcLg3Oi8jRCDWuTjIbei14n11X/2UCDOAdlDjPTeR1b22qVjD+siX5TDVrazXCzzBu6jw
	HEH9SmMA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whnLe-00027s-2v;
	Thu, 09 Jul 2026 13:55:23 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1whnLe-000FXS-0c;
	Thu, 09 Jul 2026 13:55:22 +0200
Message-ID: <b0ebaa8e-108d-451f-a7b2-26810f3d9b03@iogearbox.net>
Date: Thu, 9 Jul 2026 13:55:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: fix UAF in sock clone early bailouts
To: sashiko-reviews@lists.linux.dev, Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
References: <20260709025316.999913-1-mattbobrowski@google.com>
 <20260709032007.9E4D61F000E9@smtp.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260709032007.9E4D61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28055/Thu Jul  9 08:25:20 2026)

Hi Matt, hi Kuniyuki,

On 7/9/26 5:20 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] BPF map corruption via shallow-copied sk_user_data and sk_reuseport_cb during sk_clone early bailouts.
> - [High] Unbalanced decrement of global network timestamp static key during sk_clone early bailouts.

Do either one of you also have a chance to look into these?

Thanks a lot,
Daniel

> --- Patch [1]: [PATCH bpf] bpf: fix UAF in sock clone early bailouts ---
> commit 81577dfc9f1b10000a3b1dfc19a5b577e986ec33
> Author: Matt Bobrowski <mattbobrowski@google.com>
> 
> bpf: fix UAF in sock clone early bailouts
> 
> This commit fixes a use-after-free on parent socket's BPF local storage
> caused by an early bailout in sk_clone() prior to clearing
> newsk->sk_bpf_storage. By resetting newsk->sk_bpf_storage to NULL
> immediately after sock_copy(), the deallocation path won't destroy the
> parent socket's storage.
> 
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 8a59bfaa8096e..498a57f34f5b5 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -2492,6 +2492,9 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
>>   	sock_copy(newsk, sk);
>>   
>>   	newsk->sk_prot_creator = prot;
>> +#ifdef CONFIG_BPF_SYSCALL
>> +	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
>> +#endif
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed there might be a similar issue
> with sk_reuseport_cb and sk_user_data. Since sock_copy() does a shallow
> copy, newsk initially points to the parent's sk_reuseport_cb and
> sk_user_data.
> 
> If sk_clone() bails out early (e.g., sk_filter_charge() fails):
> 
> net/core/sock.c:sk_clone() {
>      ...
>      if (unlikely(!is_charged || xfrm_sk_clone_policy(newsk, sk))) {
>          ...
>          goto free;
>      }
> 
>      RCU_INIT_POINTER(newsk->sk_reuseport_cb, NULL);
>      ...
> }
> 
> The bailout happens before sk_reuseport_cb is cleared. When newsk is freed,
> bpf_sk_reuseport_detach() can follow the copied sk_user_data to the parent's
> BPF map slot and write NULL to it:
> 
> kernel/bpf/reuseport_array.c:bpf_sk_reuseport_detach() {
>      ...
>      RCU_INIT_POINTER(*socks, NULL);
>      ...
> }
> 
> Does this corrupt the parent socket's BPF map during early bailouts?
> 
> 
> [Severity: High]
> This is also a pre-existing issue, but could the same early bailout pattern
> cause an unbalanced decrement of the global network timestamp static key?
> 
> sock_copy() copies SK_FLAGS_TIMESTAMP into newsk->sk_flags. The global
> timestamp counter is only incremented at the end of sk_clone():
> 
> net/core/sock.c:sk_clone() {
>      ...
>      if (sock_needs_netstamp(sk) && newsk->sk_flags & SK_FLAGS_TIMESTAMP)
>          net_enable_timestamp();
> }
> 
> However, during destruction of the aborted clone, the global counter is
> decremented unconditionally because the copied flag was set:
> 
> net/core/sock.c:__sk_destruct() {
>      ...
>      sock_disable_timestamp(sk, SK_FLAGS_TIMESTAMP);
>      ...
> }
> 
> Could an early bailout skip the net_enable_timestamp() call but still
> execute the sock_disable_timestamp() call on free, leading to an underflow?
> 
>>   	/* SANITY */
>>   	if (likely(newsk->sk_net_refcnt)) {
> 

