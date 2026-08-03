Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8402F7EEE;
	Mon,  3 Aug 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766520; cv=none; b=LaqIOoLzXCMX74khKDUmUjkU8P2acf+hPHtNbcOubWYk4mux14nT/3eE1+49a8e7noMyjaUOE8TGuLfevMLUEhL9RJnAPLvY0UKmBglNP1Y9lalxZIdxawXcHo1PajHwxRm4Reyth17gdk/n/m/8JQN9IPI4BH36dUwM/R9eDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766520; c=relaxed/simple;
	bh=Gp9o4hZBry8VHc42uSGNtAQOR6Q1/z/wPuVgorTY7/g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=teKh79Tkhpt3tI6NuR0SKDvqzx1Vm1cBMghREabenPY/xvNJtzCxq1e6s569EUTBAKVczJ18Ne2YlCGl57CMYzPhHKRQQuOtWtwlAXr+l/fFwXRioroKxSGox2dIX+UNG7JdAJH9bhLBv9vjiQzYTUpGTCBE3osLany8KKXPYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KdK/7Ugp; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KdK/7Ugp"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wqtRf-004JeI-Vj; Mon, 03 Aug 2026 16:15:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=J3fpnl0gFFN68ghXVHPg0vD9SyKupN/MJio+qq/GIDw=; b=KdK/7UgpHbFfsLhV3ueZZybVmi
	uG/tzMAtxubETbanp2dwqUO8M4jbkpxGRbXveT5uVRSaUmbTpfqgGozoP1V8WrRWM/jbSp2vMoZWc
	aGFMmarHsyVEv1Pc8mNN9tfx2qjFTUKxAVn8LwQO8ANSqdUr1NlWo7zu3zUXTkeBzzXnzeGVT7x0n
	L06WnsrgaG294FJrCiBUzPffrmodx1JtmimOK7cVdEvJBcGnIC+DJWqm56zSyn/nVkxqAiFHfZZXU
	KNAPEqSsmZFAHm3W6HbvkbGZnPvkTohICDzctItTns6u1SK4/pFdd1Es86ki3QHzf1/CWbVOTpHHL
	7GvZ2LbA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wqtRf-0004bG-7L; Mon, 03 Aug 2026 16:15:11 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wqtRL-00EeK9-Rk;
	Mon, 03 Aug 2026 16:14:51 +0200
Message-ID: <551388d4-cdda-40a2-962a-f47c45b2879f@rbox.co>
Date: Mon, 3 Aug 2026 16:14:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references in
 lookup helpers
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
 <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
 <20260803093544.E44741F00A3A@smtp.kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <20260803093544.E44741F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/3/26 11:35, sashiko-bot@kernel.org wrote:
...
>> TC bpf_sk_assign() has the same issue; it takes a reference only when
>> sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
>> destructor it installs) re-checks sk_is_refcounted() independently at
>> release time. The same connect(AF_UNSPEC)+listen() transition leaks the
>> socket here too. I'd welcome suggestions on the right way to handle this.
> 
> [Severity: High]
> This is a pre-existing issue, but as you noted, a socket reference is
> permanently leaked if the socket state changes to unrefcounted between
> bpf_sk_assign() and the skb destructor running.
> 
> In net/core/filter.c:bpf_sk_assign(), the reference is conditionally acquired
> and the destructor is set:
> 
> 	if (sk_is_refcounted(sk) &&
> 	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> 		return -ENOENT;
> 
> 	skb_orphan(skb);
> 	skb->sk = sk;
> 	skb->destructor = sock_pfree;
> 
> Then in net/core/sock.c:sock_pfree(), the reference drop is independently
> evaluated:
> 
> void sock_pfree(struct sk_buff *skb)
> {
> 	struct sock *sk = skb->sk;
> 
> 	if (!sk_is_refcounted(sk))
> 		return;
> 
> 	...
> 	sock_gen_put(sk);
> }
> 
> If the socket transitions to SOCK_RCU_FREE via a connect(AF_UNSPEC) followed
> by a listen() before the skb is freed, sock_pfree() returns early without
> calling sock_gen_put(). 
> 
> Could this be addressed by either applying the same unconditional reference
> counting approach to bpf_sk_assign(), or by introducing a dedicated
> destructor for BPF-assigned sockets that unconditionally drops the reference
> without re-evaluating sk_is_refcounted()?

I was considering something like this in bpf_sk_assign():

	refcounted = sk_is_refcounted(sk);
	if (refcounted && unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
		return -ENOENT;
	skb->destructor = refcounted ? sock_edemux : sock_pfree;

which would unconditionally drop the ref in sock_edemux(), but setting a
non-sock_pfree dtor affects the logic in ip_rcv_core() where we have

	/* Must drop socket now because of tproxy. */
	if (!skb_sk_is_prefetched(skb))
		skb_orphan(skb);

And I'm uncertain about touching net/ipv4/ip_input.c.

