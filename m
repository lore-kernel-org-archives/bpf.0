Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF3D318ED3
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245564; cv=none; b=tv5KPxIiADTJRZxVbrKUGU7ZbTnmX1E4/5yvs5ZtGW7otvqPoqHqm0+1rYQ0Opq8R47GWXSMSWOLFsktk87GYELNr/kdxyj6CFP4HjvlnsORYl7Tm9958zlAIUTRGn23Elm/NO2NrF0OG/Bz8f3oTSAZ73/7vPXYng73dsNPezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245564; c=relaxed/simple;
	bh=HE8DiP1b+MmSQURxZZ2M7HpPAYG2a/CLXNu90nk5iN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVLF9ZFCOiSAMFv1VYswaEASHyLStqPoJpW9BU48v/JuHx2LPQgyGTZ78zW3cFLI4knrHFDlAZgR/o/AQGPtekzWWIljU/WH9xY27dLJolUXiEzYYvuFVPTAzmQM2HK8LhwXa/Rddkw9fWIXq9hHVtPIV2P2PixvU7REmu3Tmm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HtDRI+Qz; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HtDRI+Qz"
Message-ID: <3df436d9-5671-410c-ad0d-67d9fa540330@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770245551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJoZknlyXtAyOLBNPLzRyCmW6dHCkdD5Zvl96QPeKQE=;
	b=HtDRI+Qz+/WPhHk0OHCPF1aB7QuWSOfsCq2Bf7mxIuipnkr7S2QqYvlCBTNUb0iu+hoHUt
	/rat+5i/6Wcn6GPCTJXfdG4OWi8GiroFMZUBIyqZVEzvhDncDL+YFzwW54xpdXPJ7W6loT
	VyERfVRddW5EmiuIN3/tBwu/wn6JOGk=
Date: Wed, 4 Feb 2026 14:52:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/6] xdp: produce a warning when calculated tailroom
 is negative
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kernelxing@tencent.com>, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?=
 <rbm@suse.com>, Eelco Chaudron <echaudro@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Toke Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
 <20260203105417.2302672-2-larysa.zaremba@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260203105417.2302672-2-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/3/26 2:53 AM, Larysa Zaremba wrote:
> The issue can be fixed in all in-tree drivers, but we cannot just trust OOT
> drivers to not do this. Therefore, make tailroom a signed int and produce a
> warning when it is negative to prevent such mistakes in the future.
> 
> Fixes: bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_tail() API")
> Reviewed-by: Aleksandr Loktionov<aleksandr.loktionov@intel.com>
> Signed-off-by: Larysa Zaremba<larysa.zaremba@intel.com>
> ---
>   net/core/filter.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 616e0520a0bb..9715d957e3c5 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4149,12 +4149,13 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
>   	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
>   	skb_frag_t *frag = &sinfo->frags[sinfo->nr_frags - 1];
>   	struct xdp_rxq_info *rxq = xdp->rxq;
> -	unsigned int tailroom;
> +	int tailroom;
>   
>   	if (!rxq->frag_size || rxq->frag_size > xdp->frame_sz)
>   		return -EOPNOTSUPP;
>   
>   	tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
> +	WARN_ON_ONCE(tailroom < 0);
>   	if (unlikely(offset > tailroom))
>   		return -EINVAL;

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
