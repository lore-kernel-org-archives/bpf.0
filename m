Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249518;
	b=BQaxIGEMzDvRRoKPMBMRCvfXrUiVjB9pX6gO7ynBFWRCyGAqXkEzEGsu0macCZFKI+s3
	 GNTP0noXrRiN6xM+dp+DVWcMXI+aeoJ68lxcAifn3J3iDgo2SF72CscY5G/m8QD8sfYd7
	 fq8ZXYpJryfPvE/uMAV6wpT2tjjAWyDCS53VaomZk9HQ/RtnXYQGtZLSUEGhJbyyQ5J6K
	 wBcwnABcJ1a2x9ZDwE6pAlWHxZ0lQ1BCAoiwEUoEuuGD3Jts7khFrJoPIcsnCCm/L2tZV
	 34cW+/tDWRLzWoE0TkX4VWmCBhkcvLrl4bJ8AzOp+e5FyKMS2lqSl/YUYOu6nnQyVMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249518;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0l4+RNVQgirAlckpa+gpMeTlfb3AsXJyJI/7a/hfeUk=;
	b=dp7AVy1owrZSdw4QKviKx5dNLWsJbRT4krCehRWT1I4dhgqSz6pOg50/wOrcX79RjRoj
	 fO0tQFpmlovF91VW9p53/l+G6J8uwLHqkcKkkREou/bxkAL7D2uZ9GK6l/WhhBdjDld5C
	 sFjMjPWjnrxdQmEAPS4omHhgfDR3pddl7G5t79tLoMQlrx2sJlwtTLIhhDogN6R8PTby9
	 MbZyNvce7/Goqw2/wX2ADc+78Io6qVsD5q30DGBWi4bsP/yWEVqKlblTblkZPa3mGP8Af
	 H+T3we3SSI/4p1K4mz0q/snr3MbTvFT9WnQeKtn6KQi2iD4ATZzzBDwoYxTa7I/Alaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.65
Received: from mta0.migadu.com (out-65.mta0.migadu.com [91.218.175.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117D606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 04:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F117D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ISQGa3N2A4RKzakpfsS7Fx2EllnFI1gjln/ybfEj23g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793249507; v=1; x=1793854307;
 b=YC6UQVDbig99mhtjuvNlhefo6EeGew7pB1Y6wO+b32Y+1cCsUFWodX4eYKcZ521F/fmR4D6O
 JJqDvpRmxuAkSUvNc/a8d/kJUmaCA1M1vm/gHIp+5ubjgahjFzIty0aBWwwTmwW8UILhb06vs76
 ZEm82BCW8NeXY72wTl8pjuKI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 133843d937483977;
	Thu, 29 Oct 2026 04:51:47 +0000
X-Mizu-Trace-ID: 133843d937483977
X-Migadu-Flow: FLOW_OUT
Message-ID: <ab2efe2e-0d49-4fed-8fa0-b90f21d97aba@linux.dev>
Date: Thu, 29 Oct 2026 12:51:41 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] tcp: check congestion control restriction
 first
To: Zhiling Zou <zhilinz@nebusec.ai>, edumazet@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, jonathon.reinhart@gmail.com,
 vega@nebusec.ai
References: <71c142b2d45af6a2fe7fc6cd4a5ca52c53afbe23.1793075984.git.zhilinz@nebusec.ai>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <71c142b2d45af6a2fe7fc6cd4a5ca52c53afbe23.1793075984.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/27/26 12:46 PM, Zhiling Zou wrote:
> tcp_set_default_congestion_control() takes a reference to an algorithm
> before checking whether a non-init network namespace may select it. A
> rejected request returns -EPERM without dropping the reference.
>
> This affects module-backed algorithms too; BPF is not required. For
> example, after root loads tcp_bbr, a user with CAP_NET_ADMIN in a
> non-init network namespace can repeatedly request it as the default
> although it is not in tcp_allowed_congestion_control. Each rejected
> write leaks a module reference. Since module->refcnt is an atomic_t,
> 2^31 such writes can make it negative; later module_put() calls warn,
> and rmmod can hit the BUG_ON() in try_release_module_ref().
>
> Check the namespace restriction before acquiring the reference, as
> tcp_set_congestion_control() already does.
>
> Fixes: 8d432592f30f ("net: Only allow init netns to set default tcp cong to a restricted algo")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
> changes in v2:
>    - Check the namespace restriction before bpf_try_module_get(), following
>      tcp_set_congestion_control().
>    - Describe the module-backed reference leak and module refcount overflow.
>
>   net/ipv4/tcp_cong.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index 8e83ef81fc187..e3f462f161dd6 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -288,12 +288,12 @@ int tcp_set_default_congestion_control(struct net *net, const char *name)
>   	ca = tcp_ca_find_autoload(name);
>   	if (!ca) {
>   		ret = -ENOENT;
> -	} else if (!bpf_try_module_get(ca, ca->owner)) {
> -		ret = -EBUSY;
>   	} else if (!net_eq(net, &init_net) &&
>   			!(ca->flags & TCP_CONG_NON_RESTRICTED)) {
>   		/* Only init netns can set default to a restricted algorithm */
>   		ret = -EPERM;
> +	} else if (!bpf_try_module_get(ca, ca->owner)) {
> +		ret = -EBUSY;
>   	} else {
>   		prev = xchg(&net->ipv4.tcp_congestion_control, ca);
>   		if (prev)
