Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0B3D6662;
	Wed, 16 Sep 2026 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546509; cv=none; b=jGZBQrLVvU8CONUFrNao84B77PuBGsZtc3JiDXPal48f0Axlcm2rJdGQ+WzwY/lYLfEa40ZSjIWqnFd/rQNrUPKGe7L3noypkWsq09w8PdNDKZzcrv0woTa+8G3IHtx6wGkBAMiQJu3yJ2d1MceIVc+CN2sJggAVwD7mEKPnhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546509; c=relaxed/simple;
	bh=nyL5IWzpydVjpCH/OgbKHsn40UXHbYHTISGJwQxLKLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddeMv+OknOPCUI/vwwAbPeW76qEE4VUAlYqQ8dPnUJmQLsODfsPDJObojHxh1nr2+yoYWxPBzzvzMEuxBlTw/XF3tEu9yYIeOjOL5fURPIWKUl7qMClMSPSy9pkoAI+BH36TCQWLxRS9fvBB6XVadl7tFXk4W94w2KoYoJY/G7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from [129.217.186.100] ([129.217.186.100])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 68G8ECk4026897
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 10:14:12 +0200 (CEST)
Message-ID: <f4509145-1148-4ec1-b1aa-9bf944de7263@tu-dortmund.de>
Date: Wed, 16 Sep 2026 10:14:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/5] veth: add Byte Queue Limits (BQL) support
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
        =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Cc: kernel-team@cloudflare.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Chris Arges <carges@cloudflare.com>,
        Mike Freemon <mfreemon@cloudflare.com>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Breno Leitao <leitao@debian.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
References: <20260612083530.1650245-1-hawk@kernel.org>
 <ed63c31c-0d05-4532-bed6-23b7608ec5e2@tu-dortmund.de>
 <3a3a99dc-b554-4b5d-a004-67454e66e5e0@tu-dortmund.de>
 <a184d9c0-aa3a-4d00-9a0e-e7a1d9d344b0@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <a184d9c0-aa3a-4d00-9a0e-e7a1d9d344b0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/26 08:45, Jesper Dangaard Brouer wrote:
> 
> 
> On 9/15/26 16:30, Simon Schippers wrote:
>> On 8/10/26 15:25, Simon Schippers wrote:
>>> On 6/12/26 10:35, hawk@kernel.org wrote:
>>>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>
>>>> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
>>>> latency by dynamically limiting in-flight packets in the ptr_ring and
>>>> moving buffering into the qdisc where AQM algorithms can act on it.
>>>
>>> Hi :)
>>>
>>> I worked on my implementation of DQL coalescing that lives in
>>> dynamic_queue_limits.{h,c} and wanted to share it so we can consider it
>>> for the next cycle. This is because in the next cycle I would
>>> like to add BQL support for tun/tap as well, in addition to veth.
>>> Is that fine for you?
>>>
>>> I think it is in good shape. It uses the same logic as the v7, but
>>> every new field fits inside the existing dql struct, and drivers only
>>> need to call the usual netdev_tx_sent_queue() and
>>> netdev_tx_completed_queue() to use it. Patch 3, 5 and 6 are the same
>>> as before, only 1, 2 and 4 are new. Benchmarks looked fine for me.
>>>
>>> There should be no regressions for other DQL/BQL users. I paid close
>>> attention not to break the dql cache lines or other logic.
>>> coal_usecs is now configurable per queue via sysfs and also via ethtool
>>> as usual.
>>>
>>> While working on this, I found a missing barrier in v7:
>>> There was no smp_rmb() pairing the smp_wmb() in __ptr_ring_produce()
>>> before dql_completed() reads dql->num_queued. This happens to be safe
>>> on x86, but on other platforms the read of dql->num_queued could be
>>> reordered before __ptr_ring_consume(), triggering a BUG_ON() in
>>> dql_completed(). Fixed by adding the missing smp_rmb() in veth_xdp_rcv()
>>> before completing.
>>>
>>> Would love to hear your thoughts on the implementation!
>>>
>>> Thanks,
>>> Simon
>>
>> Hi! Any thoughts on this? Do you want to continue this series?
> 
> Appreciate getting poked :-)
> 
> I will not have time to work on this until after October 5th.

Noted, no problem.

> 
> If you Simon have time, feel free to submit a V8 patchset with the
> barrier fix mentioned above.  I should have cycles to review and ACK
> (except between 26 sep to Oct 4).

I would then also move the coalescing logic to
dynamic_queue_limits.{h,c}, ok?

I am convinced that it is the right decision, because it:
- saves us the new struct veth_bql_state, everything fits nicely into
  the dql struct in the existing cachelines
- allows other software interfaces like tun/tap to use the same logic,
  which is my goal :-) others could be e.g. wireguard and ifb
- allows to change coal_usecs per queue

> 
> We are still interested in getting this merged. Notice the bug fix from
> Jonas 60db47f02bfa ("veth: fix queue index used to wake the peer txq in
> veth_poll").  We are running XDP on our veth production interfaces, so
> we didn't notice this.  Still, we are currently waiting for this fix to
> get fully rolled out, before proceeding with the BQL variant.

Yes, I saw that. Probably did not happen to me because I was always
using single queue..

Thanks.

