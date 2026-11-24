Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502680;
	b=m87Tn6x7nyEz+fMugFSwS7kWbC8XgVFCqw049Twu4VQo4mb4JcZxAqIYlYk0XWhSEz++
	 ns2V7uK1Ngl2ifM1bPIq1V2nkOfziOniMJNM1KpRJJC9THKrCmDTR+6+tDNcYjgAIaLs8
	 H6VUVdNuPBL8+egYmMc3AR/zQSVldnYVOJcoZF+YktUIpByivW1K9tnUg6XDtYhU4C/w9
	 BefacqSHNVfxxrEtsODGdEO4r+zmtn1dJYC+i3lcjwqJVfoxCRh/0rfwJNoNIrfPjDrx7
	 o3SK8h3iolkNvvjAduGkNz28uDcM9yqIQXmjuT+110hLNPoR2yMqt69eYIz3z8FVwbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502680;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZxZjeyzDUCPuBziPwBQouparBL6NVZFSLDryV/eFVHM=;
	b=NGZ61Pn8X2sKbUjQ7ilsi7TOxl4Nx7TOmUGhraHuhkFnNEomLDhlZJLpHZsYEnSmd0cf
	 dg02LJjtvV0r7IypEBYMixtGgPVHCCXVhBf8t47p18E9dCh7M5DvwFcZTd0pDaQpEC2F6
	 axZJzNvsrq6p5nGwnaGQWEhiNoLQS6XMlvFiv2O1kWOERt/YGCD8ZdZuGQwagNTomAGxu
	 9yaYGSxz4snURnyqYQV6JgaNTazMgi9oTA5wxgVFgweJ58CvFmgwE0oyXe/ayeb9Kz9XN
	 ed1ojXrPebjynK3827/86SkFVtbhORkWjs+EwZoYAU82YOmeYwFUz679vEh+wb/w/hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oywyypjb;
	arc=none smtp.remote-ip=91.218.175.69
Received: from mta0.migadu.com (out-69.mta0.migadu.com [91.218.175.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B0606A32C
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A1B0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oywyypjb
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eL5pZ5rp2p7r1Xu8Bzzhclg/JXgXV6fM1d0JqyHaPHM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795502677; v=1; x=1796107477;
 b=oywyypjbPH//HrQWl82iC/+qiGCNYsv+90UAbK+3asbi9CSWlSypP/OWLwNtAzbBzx9A5n5k
 8457N3nPAwHJ5A6UlICwVqLSrgeuFUlhzzCdMHHMlwLGAaWt/iQBgEDoEnnAuks2u9xnJPvGVWz
 CN/CQHV3Azthw2Tm0ZL4TfyE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 865bb19f8eb4368b;
	Tue, 24 Nov 2026 06:44:36 +0000
X-Mizu-Trace-ID: 865bb19f8eb4368b
X-Migadu-Flow: FLOW_OUT
Message-ID: <e5a6139e-814d-4aca-bf44-58871af549a5@linux.dev>
Date: Tue, 24 Nov 2026 14:44:30 +0800
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
Subject: Re: [PATCH bpf 1/2] bpf, lsm: fix bpf_setsockopt() on a half set up
 child in inet_csk_clone
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, matt@bobrowski.net,
 KP Singh <kpsingh@kernel.org>
References: <20261124061544.254586-1-jiayuan.chen@linux.dev>
 <sashiko-outbox-230603@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <sashiko-outbox-230603@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/24/26 2:34 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] bpf: NULL deref in bpf_sk_clone_setsockopt() via MPTCP
>   subflow_write_space()
> - [Medium] bpf: unnecessary rejection of IPV6_AUTOFLOWLABEL in
>   bpf_sk_clone_setsockopt()
> - [Low] bpf: multi-line comment style violation in bpf_lsm.c and
>   filter.c
> --
> 
> commit 9470b8f4e13b2c8be2cf5cc10f852d869dbb6f7c
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> bpf, lsm: fix bpf_setsockopt() on a half set up child in inet_csk_clone
> 
> This commit introduces a dedicated bpf_setsockopt() helper for the
> bpf_lsm_inet_csk_clone hook that rejects socket options unsafe to set on
> a partially initialized cloned child socket.
> 
>> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
>> index ae23511fd811b..fa71f52a055c5 100644
>> --- a/kernel/bpf/bpf_lsm.c
>> +++ b/kernel/bpf/bpf_lsm.c
>> @@ -79,6 +79,15 @@ BTF_ID(func, bpf_lsm_inet_conn_established)
>>  #endif
>>  BTF_SET_END(bpf_lsm_locked_sockopt_hooks)
>>  
>> +/* List of LSM hooks that trigger on a locked child socket which is not
>> + * set up yet, bpf_setsockopt is restricted there.
>> + */
> 
> [Severity: Low]
> This isn't a bug, but BPF multi-line comments place the opening /* on
> its own line (here and above bpf_sk_clone_setsockopt() in
> net/core/filter.c).
> 
> [ ... ]
> 
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 53c042b267ab6..77abc4cb9db51 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -5938,6 +5938,43 @@ const struct bpf_func_proto bpf_sk_setsockopt_proto = {
>>  	.arg5_type	= ARG_MEM_SIZE,
>>  };
>>  
>> +/* security_inet_csk_clone() runs at the end of inet_csk_clone_lock(), the
>> + * child is locked but not set up yet: its timers are not initialized, it
>> + * holds no reference on icsk_ca_ops and an IPv6 child still points to the
>> + * ipv6_pinfo of the listener.
>> + */
>> +BPF_CALL_5(bpf_sk_clone_setsockopt, struct sock *, sk, int, level,
>> +	   int, optname, char *, optval, int, optlen)
>> +{
>> +	switch (level) {
>> +	case SOL_SOCKET:
>> +		if (optname == SO_KEEPALIVE)
>> +			return -EOPNOTSUPP;
>> +		break;
>> +	case SOL_TCP:
>> +		if (optname == TCP_KEEPIDLE || optname == TCP_CONGESTION)
>> +			return -EOPNOTSUPP;
>> +		break;
> 
> [Severity: High]
> Should bpf_sk_clone_setsockopt() also reject SO_SNDBUF and
> TCP_NOTSENT_LOWAT?
> 
> When an incoming MPTCP subflow is cloned in inet_csk_clone_lock(),
> inet_clone_ulp() -> subflow_ulp_clone() allocates a new
> mptcp_subflow_context with new_ctx->conn still NULL while newsk inherits
> sk_write_space = subflow_write_space (new_ctx->conn is only populated
> later in subflow_syn_recv_sock()).  Both SO_SNDBUF in sk_setsockopt()
> and TCP_NOTSENT_LOWAT in do_tcp_setsockopt() invoke
> sk->sk_write_space(sk):
> 
> net/mptcp/subflow.c:subflow_write_space() {
> 	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
> 
> 	mptcp_propagate_sndbuf(sk, ssk);
> 	mptcp_write_space(sk);
> }
> 
> Passing sk == NULL into mptcp_write_space() ->
> mptcp_stream_memory_free() causes a NULL pointer dereference.



It's true.

I can add these two. But I am not sure the list will ever be
complete, the child is only half set up at this point and each option
needs a look. Or we just don't allow bpf_setsockopt() in this hook at
all?

> 
>> +	case SOL_IPV6:
>> +		if (optname == IPV6_TCLASS || optname == IPV6_AUTOFLOWLABEL)
>> +			return -EOPNOTSUPP;
>> +		break;
> 
> [Severity: Medium]
> Does IPV6_AUTOFLOWLABEL need to be rejected here?
> 
> Since commit 5121516b0c47 ("ipv6: lockless IPV6_AUTOFLOWLABEL
> implementation"), do_ipv6_setsockopt() handles IPV6_AUTOFLOWLABEL via
> inet6_assign_bit(AUTOFLOWLABEL, sk, valbool) and
> inet6_set_bit(AUTOFLOWLABEL_SET, sk), which modify
> inet_sk(sk)->inet_flags on the child socket rather than the listener's
> ipv6_pinfo.
> 

