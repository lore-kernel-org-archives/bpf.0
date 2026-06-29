Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419673CA4A0
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769276; cv=none; b=lLZwH1g8K++JGUE+tIajU7ZYELpe1/VbKeXqQLhEm9LpaUhzjP1WdMTqtzAv1205vwEr7wyJnFQqPff+ds5bNjFBTjurtNYx8/MXCl7v+me2B1svftck+IbmLgLzGHmRU+1/Pc7uXRbxYZt2uXdexD2XY2IOUu3a6zcayS14o80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769276; c=relaxed/simple;
	bh=q/UZhJLTcR/gXnQX8qZu7rmqKVgYwFJt8zGK4X3m5bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CH3RJpP+sTwLtRmUTFJKPYrkbUtHyifzIasNBlOfpxwRsiBUb88VgwHyfVzqk0a3gLC7V+OuseEYkcK72SC+xmnaMHahZYeyUkZ+WcoqXTC1BVm4aGoCczwtOq1kIqn4dY4qYoZKC2bIydEIOpv59vzV4cJ6I6viwxTCyOYus+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=K3fzcSq1; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="K3fzcSq1"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1weJj3-001m8p-Kx; Mon, 29 Jun 2026 23:41:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=P1L8Z8G8KodH0qArwjyT17wPJ1f2sTYLoOeISVOZaH0=; b=K3fzcSq1LqO1hbDXydVIHwgQ18
	XWk53gXoNI2FnvbNZX0rFB1IvpRfGLMWPRyVE9sX2ZB6RrX2BjIMt/ru6J8SBB9ybULaMz35MOmyQ
	lkYs957HRd8TgNBwOkM8ayZ2UPD3aCuwFpNVRBJEGb+XiimGjtSFrBm1T21z9loNaFzjnYnkPxfyP
	5OwvhtJJeLHK0+7C4hUZgeo3puw1FZbcsjphKTom+/xL8ANuKTGMb5mtIJ6ZPBBxIC4cahOXCwt1I
	Ux/Ic16UFxkuSCDFXIi4+MxorOyjVTp/GAyandkHnva0SEunisORwgJ1i/fU56TgGiXi+gJn+UjQ+
	+iWrqq2A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1weJj3-0005nw-8u; Mon, 29 Jun 2026 23:41:09 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1weJik-00FxCt-NN;
	Mon, 29 Jun 2026 23:40:50 +0200
Message-ID: <26ecbce0-48ad-4b53-a0b7-34b59870e010@rbox.co>
Date: Mon, 29 Jun 2026 23:40:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
 <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
 <20260626205814.BAC3C1F000E9@smtp.kernel.org>
 <e08be4f5-0bd9-4228-843d-86ed20594bac@rbox.co>
 <87v7b137cx.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87v7b137cx.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 13:37, Jakub Sitnicki wrote:
> On Sun, Jun 28, 2026 at 11:59 PM +02, Michal Luczaj wrote:
>> On 6/26/26 22:58, sashiko-bot@kernel.org wrote:
>>> [Severity: High]
>>> Could a memory ordering regression here allow unbound UDP sockets to still
>>> bypass this check?
>>>
>>> In udp_v4_get_port(), the flag and hash are set:
>>>
>>> net/ipv4/udp.c:udp_v4_get_port() {
>>>     ...
>>>     sock_set_flag(sk, SOCK_RCU_FREE);
>>>     sk_add_node_rcu(sk, &hslot->head);
>>>     ...
>>> }
>>>
>>> Because these stores lack a memory barrier between them, could sk_hashed(sk)
>>> return true on another CPU while SOCK_RCU_FREE is not yet visible, allowing
>>> the leak to still trigger?
>>
>> I'd like to verify it on a weakly-ordered CPU; please give me a day or two.
> 
> False positive, IMO.
> Both ->get_port and sock_map_sk_state_allowed run with sk_lock held.

What about an update coming from iter/task_file? You get an unlocked socket
via bpf_sock_from_file(ctx->file). And sock_map_update_elem()'s
bh_lock_sock(sk) doesn't care if socket is owned.

I was looking at iter/task_file in the context of [0]'s follow-up. With or
without [1], we're getting closer to enforcing (stronger) locking in
sock_map_update_elem(), per Martin's suggestion. Along the lines of

   if (!has_current_bpf_ctx() && sock_owned_by_user_nocheck(sk))
      ret = -EBUSY;
   else if (WARN_ON_ONCE(has_current_bpf_ctx() && !sock_owned_by_user_nocheck(sk)))
      ret = -EINVAL;
   ...

Would that fly?

[0]: https://lore.kernel.org/bpf/20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co/
[1]: https://lore.kernel.org/bpf/20260629172704.1302218-1-rhkrqnwk98@gmail.com/

