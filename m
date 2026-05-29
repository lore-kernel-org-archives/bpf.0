Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7536607D;
	Fri, 29 May 2026 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071330; cv=none; b=Sa3gVAYJmoxRaJx1L4rTn1HzZ6oLbY9PHtOX1ZzFaswwACXo0aI0LT2Cya8XU+3mrX7PE0H9Lz/FgSoCzFFFj4saeWcoZNsjboVzmhIfD0sxLPJNOI65GPwcX4zj9mb7RsUqUr7GiwDfbcPqMHQqh6jLtUvaWvmax11oGuF3HcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071330; c=relaxed/simple;
	bh=uL/G0eLfOk3tPLysZ/3wSHOxP3/9s1fHmc95jIWh9Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHbIdwpbVUuoX6zRbz+Or6rR1AV2p5BRc5YbFeT4wY2lExzYTTcBCtC00d7Q7687RcjXE0eH4tqHqTbwwkN2PSSqGigYco5EhRyfDgkADpYuv8GuwXMj1h5Y4r3E3Tyz+Z5O9Fvm7mvk7C15Z1bLeCxW0leWcxTCV0ePY61U0dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=tFKhuz7u; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="tFKhuz7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1780066303;
	bh=uL/G0eLfOk3tPLysZ/3wSHOxP3/9s1fHmc95jIWh9Fk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tFKhuz7u2kk9/OBJF7dXUwCKT5j3ebFa90CpfFcs/ZRH+a9xo0FWeV3Or6WzbqGQv
	 DzCESRaHuRWtcbpSc2JaXdg0U2Kpi+ZPVsuNZAfIW1EViO8DYBQIFHukyhsYm16J3j
	 gtQZj/UwCJHnFiG9k/YsEi07l5mCG1QdyyjW4Sww=
Received: from [129.217.186.252] ([129.217.186.252])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 64TEpf6Q021874
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 16:51:41 +0200 (CEST)
Message-ID: <c8650d3a-e488-4279-b28f-549d766c23a1@tu-dortmund.de>
Date: Fri, 29 May 2026 16:51:41 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-6-hawk@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260527135418.1166665-6-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/26 15:54, hawk@kernel.org wrote:
> From: Simon Schippers <simon.schippers@tu-dortmund.de>
> +	/* If the ring is now empty and the peer TX queue is stalled by DQL
> +	 * backpressure, release completions immediately to unblock it.
> +	 */
> +	if (peer_txq && state->n_bql && __ptr_ring_empty(&rq->xdp_ring)) {
> +		/* Pairs with smp_wmb() in __ptr_ring_produce(); ensure ring
> +		 * emptiness is observed before reading peer_txq->state.
> +		 */
> +		smp_rmb();
> +		if (test_bit(__QUEUE_STATE_STACK_XOFF, &peer_txq->state))
> +			veth_bql_complete(state, peer_txq);
> +	}

"Does this leave coalesced BQL completions pending indefinitely if the
receive ring is empty but the peer TX queue isn't stalled by DQL? [...]"

Regarding this by [1]: Yes, this is desired behavior IMO.

From my understanding there should not be a BQL stall caused by
this (needs to be tested though).

A minor nit is that the observation of the minimum amount of
slack found over several iterations of the completion processing
(saved in dql->lowest_slack) is inaccurate and therefore the limit
might be set to a too low value once (at the next completion call).
I think it does not matter though.


Overall The AI reviews [1] [2] have some valid points.

Apart from that I would consider joining patch 2 and 5.

[1] Link: https://sashiko.dev/#/patchset/20260527135418.1166665-1-hawk%40kernel.org
[2] Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260527135418.1166665-1-hawk%40kernel.org


