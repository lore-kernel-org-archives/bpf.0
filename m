Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588641;
	b=hWvrhBWosscJES2fUldxkYNin5ubcTtChfMKZuyWmVc1N900HzKmenQpPvcGnRDp0IAz
	 ACqfv7czpOPESubW2A7NfWa7KWor49uvgsVioJDt5D4YiAom4mVGb7h2JjFBmv1sWXsAV
	 pcaNovTifNIJKSC/LMVF+LpVAx4eRQPGcaCd7UMAZKiPTb9dyiNhPijLgT/9sr2Lhazej
	 5ItlfgNYLy/4oX2FS9ZatB7ziT9WkTrq21taZMrAFzFG5r7x4tY4sHJDw2yZaq4Lwx3yN
	 E1abnFMJE8FMKuiFbwUlz+pqbGezslORMAX9FByTNqtTaysp30MVY0xfBVZCwol0/8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588641;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=q/Rj58SaH5amWTyNmer9CsZ6IqXDXPNCk/zSC3unopI=;
	b=4quSZr5a0puSqKJfSzzXXwGTqP2SJlUcA7T+I0/rC2r28GkbiXghd3DBPhvmb2eU+NMZ
	 UgBVPHgxFVduhwE5cPKbbxAujKQ7w83D2uFP63bGMzIl0ZwgGt77u526sBserBb+0pRQx
	 QsQIQv+4t0yhw1NwDaew1CyTRdSdf5Oeir0I9zU1luOIROSPUGKJ9SI3LQo+A+GVj2msS
	 oK29BazYFtu6HF9KDftQq703YH0h4IAgwd5r7wp+eqLOHlObE8ywqhu6ZO3jE4VastfR0
	 wgBbs9irmtRLqrPpFUMw7zwn3lc4RiySEuqSiV6bWNGguahz87AO7+zQtSVjoq7UBvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q5d6DVJR;
	arc=none smtp.remote-ip=95.215.58.206
Received: from mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF4606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DBF4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q5d6DVJR
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Rue6WWUDqbUiDGZQOImbpN9tuORsHUiNUGcW6y17oMA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795588638; v=1; x=1796193438;
 b=q5d6DVJRa8oAnf8vyrkzerITtkrT4wiX6G9nDh5BbJ4elSbjbcPOb0p1hagSUsbbtuAP9WWg
 +UxdMf+FdxYmKXg94zEJq2QJAiTTQdQ9Pzo3JqHN9hEZdkmjAu3uIzjd3UJWINIXtyEKktd3pqJ
 qQg7xqQdikA3H7se/iDAORhE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 52e2bc64e5274c4c;
	Wed, 25 Nov 2026 06:37:17 +0000
X-Mizu-Trace-ID: 52e2bc64e5274c4c
X-Migadu-Flow: FLOW_OUT
Message-ID: <663c0be8-60c8-45d6-baf6-5bc4ac0ae173@linux.dev>
Date: Wed, 25 Nov 2026 14:37:10 +0800
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
Subject: Re: [PATCH net] tcp: fix CA module refcount underflow in
 tcp_v4_syn_recv_sock()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, edumazet@kernel.org, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, fw@strlen.de, daniel@iogearbox.net,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20261124062625.264148-1-jiayuan.chen@linux.dev>
 <179558800299.3135.4905748131998876050@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <179558800299.3135.4905748131998876050@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/25/26 2:26 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The new error path in tcp_v4_syn_recv_sock()
>   (net/ipv4/tcp_ipv4.c) jumps to clear_ca_and_exit when…
> - [Low] The commit message presents the bug as a module refcount
>   underflow that shows up as a module_put() WARNING.
> 
> --
> 
> tcp: fix CA module refcount underflow in tcp_v4_syn_recv_sock()
> 
> The child socket inherits icsk_ca_ops from the listener without taking a
> reference. If inet_csk_route_child_sock() fails, the child then puts the
> listener's reference. This patch clears icsk_ca_ops on that error path and
> makes tcp_cleanup_congestion_control() skip a socket that has no CA.
> 
>> If inet_csk_route_child_sock() fails in between, we go to put_and_exit
>> and tcp_done() ends up in tcp_cleanup_congestion_control(), which puts
>> the reference unconditionally. The one dropped belongs to the listener.
> 
> [Severity: Low]
> 
> Is the impact larger than a refcount underflow warning?
> 

> module_put() uses atomic_dec_if_positive() and only warns when the count
> would go negative:
> 
> kernel/module/main.c:module_put() {
>     ...
> 		ret = atomic_dec_if_positive(&module->refcnt);
> 		WARN_ON(ret < 0);	/* Failed to put refcount */
>     ...
> }
> 
> While the listener still holds its reference, the child's put in
> tcp_cleanup_congestion_control() succeeds silently and uses up the
> listener's reference. The quoted WARN only fires after earlier occurrences
> have already drained that reference.
> 
> Once that has happened, try_release_module_ref() lets rmmod of tcp_bbr
> succeed while the listener's icsk_ca_ops still points into the module.
> Later children read icsk_ca_ops->owner through bpf_try_module_get() in
> tcp_ca_openreq_child(), and closing the listener calls ->release() on it.
> Could either of these be a use-after-free?
> 
> If the count has dropped below the base instead, rmmod would hit
> BUG_ON(ret < 0) in try_release_module_ref().
> 
> For BPF struct_ops congestion control, bpf_module_put() goes through
> bpf_struct_ops_put() -> bpf_map_put():
> 
> include/linux/bpf.h:bpf_module_put() {
> 	if (owner == BPF_MODULE_OWNER)
> 		bpf_struct_ops_put(data);
> 	else
> 		module_put(owner);
> }
> 
> In that case the extra put drops a struct_ops map reference while the
> listener is still using the map.
> 
> Could the commit message describe this impact, for the benefit of stable
> maintainers?
> 

It's meanless, we can't enumerate all cases‌ into commit message.


>> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
>> index e3f462f161dd6..0f99405a78b11 100644
>> --- a/net/ipv4/tcp_cong.c
>> +++ b/net/ipv4/tcp_cong.c
>> @@ -271,6 +271,9 @@ void tcp_cleanup_congestion_control(struct sock *sk)
>>  {
>>  	struct inet_connection_sock *icsk = inet_csk(sk);
>>  
>> +	if (!icsk->icsk_ca_ops)
>> +		return;
>> +
>>  	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
>>  		icsk->icsk_ca_ops->release(sk);
>>  	icsk->icsk_ca_initialized = 0;
>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>> index 2fc92a7884fc8..8aa52376cf0aa 100644
>> --- a/net/ipv4/tcp_ipv4.c
>> +++ b/net/ipv4/tcp_ipv4.c
>> @@ -1732,7 +1732,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>>  	if (!dst) {
>>  		dst = inet_csk_route_child_sock(sk, newsk, req);
>>  		if (!dst)
>> -			goto put_and_exit;
>> +			goto clear_ca_and_exit;
>>  	} else {
>>  		/* syncookie case : see end of cookie_v4_check() */
>>  	}
>> @@ -1789,6 +1789,9 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
>>  exit:
>>  	tcp_listendrop(sk);
>>  	return NULL;
>> +clear_ca_and_exit:
>> +	/* newsk holds no reference on the inherited CA yet. */
>> +	inet_csk(newsk)->icsk_ca_ops = NULL;
> 
> [Severity: Medium]
> 
> Does this comment hold in all cases?
> 



> tcp_create_openreq_child() calls inet_csk_clone_lock(). That function moves
> the child to TCP_SYN_RECV and then calls security_inet_csk_clone(), all
> before the route lookup above:
> 
> net/ipv4/inet_connection_sock.c:inet_csk_clone_lock() {
>     ...
> 	inet_sk_set_state(newsk, TCP_SYN_RECV);
> 
> 	inet_clone_ulp(req, newsk, priority);
> 
> 	security_inet_csk_clone(newsk, req);
>     ...
> }
> 
> bpf_lsm_inet_csk_clone is listed in bpf_lsm_locked_sockopt_hooks in
> kernel/bpf/bpf_lsm.c. A BPF_LSM_CGROUP program attached there can
> therefore call bpf_setsockopt(TCP_CONGESTION) on the child:
> 
> sol_tcp_sockopt_congestion()
>   do_tcp_setsockopt()
>     tcp_set_congestion_control()
>       bpf_try_module_get(ca, ca->owner)  <- takes a reference on the new CA
>       tcp_reinit_congestion_control()
>         tcp_init_congestion_control()    <- ca->init(),
>                                             icsk_ca_initialized = 1
> 

It's not for net tree and I have already sent a fix to bpf tree. 

I also intentionally mentioned it under diff stat to suppress this review
but I think I failed:

'''
   ...
   Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
   ---
   security_inet_csk_clone() -> bpf_setsockopt(TCP_CONGESTION) from a
   lsm_cgroup prog has a similar problem, the child puts a reference it
   never took. That one is being fixed in the bpf tree.
   ...
'''

