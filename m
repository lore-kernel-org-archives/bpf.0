Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F127281E;
	Fri, 12 Jun 2026 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273480; cv=none; b=TfKuL7AkmI8NLo2oFp9eN4OAHJohEufDPH7I5VKKdbaqeFRqHObzTgu8omdS+mah2JBa0w1E8AvaY4GTzTYtCPDOvoo4FNWL80BPd9ZSBe6mBUNOXdQECwqGZMsrDhL5X/6G+WsngX321ea/GBb7+IYcgDskSReAftIoNGkv01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273480; c=relaxed/simple;
	bh=oPO49LavRySQArjb5xLNZiJKs+3Af93bbmhsdT5XVJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3MG3v5T6nnIelh3nbdd8PdAR8BDyt1yNmXYTaoBLmwvnrZdkTTVHaaRm0tYPuKddbAGy5XuBixuIVZ09yB1QvXN2QP7T3T/HJpUvnu4yalUMA7GcTkcyGFeBqDnymoFkFZ52GVlMTKaB2KojN0v6H9zUVl8U91fhy1TWuxQUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=i5wQLgmW; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="i5wQLgmW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1781273446;
	bh=oPO49LavRySQArjb5xLNZiJKs+3Af93bbmhsdT5XVJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i5wQLgmWaja2kvmVXruFK277J38lpjUw0u/q0aHXsIk2gPyzUixoLxj/qjYli/ey6
	 6Y/iHV5w7SZjtdH7VUcm16T3b9Px7FbKKQuaPbEAhS7OqbmUEZiBbhB2rZYvBNU2UQ
	 zQjhQNaKxQl0Tf7cJIQAL9Ni3crlE9YUf7PUcoQg=
Received: from [192.168.178.68] (pd9eaa69d.dip0.t-ipconnect.de [217.234.166.157])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 65CEAiDH000903
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 16:10:44 +0200 (CEST)
Message-ID: <5c326cb0-9b7c-4d67-8f80-0c9be1e8fcba@tu-dortmund.de>
Date: Fri, 12 Jun 2026 16:10:43 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/5] veth: add Byte Queue Limits (BQL) support
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Chris Arges <carges@cloudflare.com>,
        Mike Freemon <mfreemon@cloudflare.com>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        Breno Leitao <leitao@debian.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
References: <20260612083530.1650245-1-hawk@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260612083530.1650245-1-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/26 10:35, hawk@kernel.org wrote:
> From: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
> latency by dynamically limiting in-flight packets in the ptr_ring and
> moving buffering into the qdisc where AQM algorithms can act on it.

LGTM, thanks for the detailed changelog :)

Maybe we should stop searching for the perfect tx-usecs value.
100us is probably fine for most hardware to not have a performance
regression. And lowering it does not really improve the RTT anyways.
Do you agree?

Nevertheless, I will compile and run the benchmarks again.

I will go on vacation from 15th to 24th of June, so I will not be able
to contribute code or run benchmarks then.

Thanks,
Simon

