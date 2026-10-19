Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619054AA1CD;
	Mon, 19 Oct 2026 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403903; cv=none; b=tsT+v52/UfBCDLOG7GgrgOyJMh7R7YIg41icmPg7RrisAPLWb/Ow8i7rB/pT/NO6XURA6otcLp6frYhl6Vxw+yDHu8fiuL60sqOWRH1HdhFAMhJy8o8DAf68GcnedH9ee3z3miy/INcs/huhi2R7hS/TvJ1AYnR2zajvIyCaRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403903; c=relaxed/simple;
	bh=7STzAZVE2icKcOUDIcTfyyUyejv1yzD1Rq+SGFadgCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIUSZVKR1RLzjgSJp8821MdOWLF41nYXtuzoch8/uiO/mAFiW8EtywyFsztoOCzWlHtlLPF00BJNZv9NvxxrtGWlpFbaq/5wFQsFTFbi6W9/CGVGAd8HfTHVOOSBshmxkTZd9P5VbaiwxhMMUyGYnIZ3dZHND9YE4XA01RVf+V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsQ8XZY0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsQ8XZY0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C34A1F000C4;
	Mon, 19 Oct 2026 09:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792403902;
	bh=c3RnrIDDX2/I7bSPgPTL7arfKC/4On1YTWVqBC2tUVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IsQ8XZY0yUaSWEvovFDg/M5FMNYyJxGIXCCnAbnb3D+poYtT8r9MToxAmx3Zj4aY3
	 1R629wzDJZqXv2o1IGeku8h0a0O+OvS2d1WpjA89ig3XqrrflqF+CkAitgC7lZYMVI
	 +LyXeQ/Pwx8c1yYLrhYUvVQbhxohK5sLp8sgrNcBlqwkLGB6DLflxAVEMPdO0x6rLz
	 UUdCxHc9Qk9/W1VZ8zA3N5iv/1Tsj3S+Jk2QpNBYGr0hjyuX2idiOLLWCg1zg8xkhW
	 SI1I7unpPdodJNO98KG2fmFLw2k+McAjZmWg1V13OUKiHlTOc+jbm+TROOCXUwza+k
	 Vthnlfzaj+nUg==
Message-ID: <746ba331-0a9f-46ed-8faf-d432bec5c8c6@kernel.org>
Date: Mon, 19 Oct 2026 11:58:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] veth: schedule the peer's NAPI after XDP_TX when
 only GRO is enabled
To: Lorenzo Bianconi <lorenzo@kernel.org>, Tianyi Gao <tianyi@cloudflare.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, toke@redhat.com,
 horms@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
 kernel-team@cloudflare.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, linux-kselftest@vger.kernel.org,
 bochaolucky@gmail.com, toshiaki.makita1@gmail.com
References: <20261016214217.16942-1-tianyi@cloudflare.com>
 <20261016214217.16942-2-tianyi@cloudflare.com> <atSMqdB52V494aYn@lore-desk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <atSMqdB52V494aYn@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/18/26 11:08, Lorenzo Bianconi wrote:
>> veth_xdp_xmit() queues XDP_TX frames on the peer's ring if the peer has
>> NAPI. A peer with GRO enabled and no XDP program also has NAPI.
>>
>> veth_xdp_flush() then schedules the peer's NAPI, but only if the peer's
>> xdp_prog is set, so for such a peer the frames are never processed.
>> Nothing else schedules that NAPI by default.
>>
>> Once the ring is full, every XDP_TX frame is dropped, and so are the
>> skbs that veth_xmit() queues on the same ring.
>>
>> Commit 0e672f306a28 ("veth: check for NAPI instead of xdp_prog before
>> xmit of XDP frame") changed the check in veth_xdp_xmit() but not the one
>> in veth_xdp_flush(). Make veth_xdp_flush() check the napi pointer
>> instead of xdp_prog, as veth_xdp_xmit() does.
>>
>> Fixes: 0e672f306a28 ("veth: check for NAPI instead of xdp_prog before xmit of XDP frame")
>> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>


LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


>> ---
>>   drivers/net/veth.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>> index 643b97dc5245..9405ffac598a 100644
>> --- a/drivers/net/veth.c
>> +++ b/drivers/net/veth.c
>> @@ -612,7 +612,7 @@ static void veth_xdp_flush(struct veth_rq *rq, struct veth_xdp_tx_bq *bq)
>>   	rcv_priv = netdev_priv(rcv);
>>   	rcv_rq = &rcv_priv->rq[veth_select_rxq(rcv)];
>>   	/* xdp_ring is initialized on receive side? */
>> -	if (unlikely(!rcu_access_pointer(rcv_rq->xdp_prog)))
>> +	if (unlikely(!rcu_access_pointer(rcv_rq->napi)))
>>   		goto out;
>>   
>>   	__veth_xdp_flush(rcv_rq);
>> -- 
>> 2.55.0
>>

