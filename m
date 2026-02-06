Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8BE36CE17;
	Fri,  6 Feb 2026 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388888; cv=none; b=KKiX4SAGNXR163n1dEsRtWmwYhw9AgDMomthJk9PNuu2M0NOT1FmXfTCwb+Sr1EJFH++1ZwVKTR0A1nY6diQIrZI44j3J7RHFohmeG1d+VrTM+ZZ5hzcIDDFyOHC78xk1/iB9DTVEvZEu//aIJCTX2JghMNhWgh7aXemqZkRNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388888; c=relaxed/simple;
	bh=IVpOrbiMnZuCcqYATf6ZbRJh0Zwts1wEucCBbV6v/LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUSDW0reVDNf+Ng1xce1S3EdAS4WTMF4hGBfpHE78zdVCxJTeD7zOdqh+hTYB3UDcdATwJ6CxBQuYGdZXP+6/5soW7D+jZHyzTlTyY2ZEEJCtJUmYGlKvKqOwTf6SDr2WG0aRXyAu9zBSieBTGOQxWVvmZOFWUcDxgwogR+ltpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NruK1uiJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NruK1uiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CCCC116C6;
	Fri,  6 Feb 2026 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770388888;
	bh=IVpOrbiMnZuCcqYATf6ZbRJh0Zwts1wEucCBbV6v/LQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NruK1uiJWPEpEOfzz4WdAqh2Rb3RcGd1mswYVlLNg8ZrKz5GYOp6omkJCbSV1bnDZ
	 m6qzVkBmLZw4wpFP/byCAkmW1d7IpnphBOOuR3IU3Nnbdh9J27yb+zkzkI/0wD2Al4
	 e/ADqv1foUEK3DEJTKKBvUGj0jNFoKI7rWI3oW4OWsL8D3AibhJiSuwNQggxelYO45
	 urqW04tnDI+Se00dfxSud6IGmEvC/Oo2FdXy0VX64YW0Mkw83yedKHB40AaO42WOM9
	 aS4UnX1a6X9yyhW15lhYVvWIAcP7g/byExg+P48CqiyQ6+GwpdTo/G8ePxYTcxYD56
	 W5C8ruY3I4x0w==
Message-ID: <41da26a6-4024-461f-8254-ac5dcf231397@kernel.org>
Date: Fri, 6 Feb 2026 15:41:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
To: Antoine Tenart <atenart@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, carges@cloudflare.com, kernel-team@cloudflare.com
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org>
 <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org> <877bsr1l1h.fsf@toke.dk>
 <CADCXZ1yMkZbRd7ioGw5QQ61OdmYp6misUDoj-s-g7wuoiCHKbg@mail.gmail.com>
 <87v7gbz1ru.fsf@toke.dk>
 <CADCXZ1z-gg_VsN4kjf325HvWRxL1irhUC76B_erggm5+A7qQ7g@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CADCXZ1z-gg_VsN4kjf325HvWRxL1irhUC76B_erggm5+A7qQ7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/02/2026 17.24, Antoine Tenart wrote:
> On Thu, Feb 05, 2026 at 03:46:29PM +0100, Toke Høiland-Jørgensen wrote:
>> Antoine Tenart <atenart@redhat.com> writes:
>>
>>> I'm wondering why not using the drop reason subsys logic to combine the
>>> qdisc specific enum while not conflicting with drop reasons and allowing
>>> to inject the qdisc reasons into drop reason enabled helpers as well?
>>
>> See this prior discussion for how the proposal came to be:
>>
>> https://lore.kernel.org/all/6be17a08-f8aa-4f91-9bd0-d9e1f0a92d90@kernel.org/
>>
>> Basically, figuring out which qdisc a drop came from is not possible
>> with the current drop_reason code.
>>
>> So it's not just new drop reasons, it's a separate tracepoint with more
>> information available (qdisc handle, name, etc). So you'll get two
>> events for qdisc drops with this series (from patch 1):
>>
>> +		trace_qdisc_drop(q, txq, dev, skb, reason);
>> +		kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
> 
> Right and that's fine. Using the drop reason subsys logic you could turn
> the above into:
> 
>   +		trace_qdisc_drop(q, txq, dev, skb, reason);
>   +		kfree_skb_reason(skb, (u32)reason);
> 
> You can look at enum skb_drop_reason_subsys and how that is used within
> OvS (net/openvswitch/drop.h) for example.
> 

Thanks for the input Antoine, I've adapted V2 to use skb_drop_reason_subsys.

Can you point me at the OVS userspace code that consume these subsys 
drop_reason's?

--Jesper
[V2] 
https://lore.kernel.org/all/177032644012.1975497.16411100029657607833.stgit@firesoul/

