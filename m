Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A672C9D
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947979; cv=none; b=pTy1qsWI6z8tRV1v7UgjKUBdNfdbvs+WV/qowwP4qJxHihBpLxx15fibVlZ+aL60QRcdlN+2HocneLXDo0IkpiX2dsh4I6DKSjRwWBh1TbCFFjzcd3FvTgdktN8U1wg55CkMgFo4NMe1JSY91LLrDEW+5aZfEhR4AD0S1KwA2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947979; c=relaxed/simple;
	bh=vFvtRWv5my/QgJtajCZwEuxYnBRXqR/yvXpSmmWe7rE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gF64O4mdXj3BYcC0uBhWfL+HNk42IUVcnGpHZhCvqjoOjQE5AJMQ+BD+N3v1i9MFt3/q+Q1E0JwK7Q3gt9ROXfjvJqLqGdZzjns9H3R+Yv3HtYNpG+v82+b5kKw1MYiyXga7oK1TOlNefNE5YWI+zrBN+8erZHk9jLUlrkkX7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=sFUrCgMI; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="sFUrCgMI"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wf4DG-00AOPz-Tt
	for bpf@vger.kernel.org; Thu, 02 Jul 2026 01:19:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=tdf4Tw78oKpNgiUXp94P6P/075IJ7mm7cDw4lBuKJOs=; b=sFUrCgMIgraW+CTJV002msaBFk
	zKLogTqeIKnIeT7Z/O2uACzSbkTZPHxstoo32uaOu+UoDwgwErAnj2jCFZfpbO8poDjEzOP7pjUyL
	JK4xtLHFqvmBHXZnyuGBzTEvs11V0lVQuxpso+I7PJgkExievFXerDYqx75gcBV7Bz8EBJxslbZbg
	LDGMGjeI5zpq4Zl2O8prJHGKylwOmRApKyuETQ5BOXbaX+fPkTKclsG3GDPNGIDNKcvRCWiEs7Fll
	rDW/z+Zu1iDngwrVL2MPpHZFGDIzT7YNCNriwsuZk5NoRG1LewZeEvt7VUBIqDkDZH5jFbmlUzQbe
	w5Q48//g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wf4DB-0004Z3-Fh; Thu, 02 Jul 2026 01:19:21 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wf4Cz-004HAF-1c;
	Thu, 02 Jul 2026 01:19:09 +0200
Message-ID: <b7870e24-cd90-466c-8496-9c9d8b5945e0@rbox.co>
Date: Thu, 2 Jul 2026 01:19:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
To: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
 <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
 <20260626205814.BAC3C1F000E9@smtp.kernel.org>
 <e08be4f5-0bd9-4228-843d-86ed20594bac@rbox.co>
 <87v7b137cx.fsf@cloudflare.com>
 <26ecbce0-48ad-4b53-a0b7-34b59870e010@rbox.co>
 <87echn2fhd.fsf@cloudflare.com> <akWbSP5aMxLYSmM8@john-p8>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <akWbSP5aMxLYSmM8@john-p8>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 00:58, John Fastabend wrote:
> On Wed, Jul 01, 2026 at 12:04:14PM +0200, Jakub Sitnicki wrote:
>> On Mon, Jun 29, 2026 at 11:40 PM +02, Michal Luczaj wrote:
>>> On 6/29/26 13:37, Jakub Sitnicki wrote:
>>>> On Sun, Jun 28, 2026 at 11:59 PM +02, Michal Luczaj wrote:
>>>>> On 6/26/26 22:58, sashiko-bot@kernel.org wrote:
>>>>>> [Severity: High]
>>>>>> Could a memory ordering regression here allow unbound UDP sockets to still
>>>>>> bypass this check?
>>>>>>
>>>>>> In udp_v4_get_port(), the flag and hash are set:
>>>>>>
>>>>>> net/ipv4/udp.c:udp_v4_get_port() {
>>>>>>     ...
>>>>>>     sock_set_flag(sk, SOCK_RCU_FREE);
>>>>>>     sk_add_node_rcu(sk, &hslot->head);
>>>>>>     ...
>>>>>> }
>>>>>>
>>>>>> Because these stores lack a memory barrier between them, could sk_hashed(sk)
>>>>>> return true on another CPU while SOCK_RCU_FREE is not yet visible, allowing
>>>>>> the leak to still trigger?
>>>>>
>>>>> I'd like to verify it on a weakly-ordered CPU; please give me a day or two.
>>>>
>>>> False positive, IMO.
>>>> Both ->get_port and sock_map_sk_state_allowed run with sk_lock held.
>>>
>>> What about an update coming from iter/task_file? You get an unlocked socket
>>> via bpf_sock_from_file(ctx->file). And sock_map_update_elem()'s
>>> bh_lock_sock(sk) doesn't care if socket is owned.
>>
>> You're right. No exclusive access to socket there.
>>
>> I think we should block map updates from all iterators but iter/sockmap,
>> where we know the socket is already in the correct state.
>>
>> This is in the spirit of the API lockdown that is in progress [1]
> 
> +1 lock this down to just iter/sockmap allowing these updates from
> arbitrary context is too hard to reason about.

All right, I think this also addresses Sashiko's concern. I'll do it in a
separate series.

thanks,
Michal

