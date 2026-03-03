Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D3436C9D1
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581356; cv=none; b=WBUlaOtBp1GAhB6xdnly/QC1lRIjOLyIJjZpMLEDh+alfNUqFxxuAyrtMyxgjWzbtSp3TWcrjQ1DYjEYdZ1Rz6/jbiswlZK10F0E4meRQxCLL7wSjWmbDtfdsv7ozouUoWrfJeUOtjsGx9ikc+F9Z+ectNu/4HwR0m8IKmu/n6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581356; c=relaxed/simple;
	bh=kWhijkX4NW9+j8hjQNKVNHbTc1OwH2G//Ljxi1C9zNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=beldPsIutoPN8BRKvWIcUEildc93RAsfnbSOChxCoa+tIq3IjEQH4MFKO5P9q5g8YT0PSjWAoFiINaak/RIoWUFgeSAtli/CUivRLGZBlhql19XNzLAdL43BBGlUXFLqmCApVuR41Hz0UMwesUTVPFWcJT2/Cju/6VMBplLcLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WiuJU9xS; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WiuJU9xS"
Message-ID: <da42af3a-7595-4e51-8c85-5b419266a8a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772581341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZ/CIewNUhK4DMFEo8Ql83aiKEIEGzE6lChFBdbn6Qw=;
	b=WiuJU9xSpPqUUi0fFmsaSFfdclDs2RnncKi0uexKiZV2/5T4+rQp/AV0D0U+vMuHTPOnJM
	SQNP2pe4y/+PsPJyUZh/iG8WrSk9ez3KpnRawQZA4Mp7+lrQvzE25mPhAWdLfESidtEZmP
	QJrH2E7Ss/GwiBZHXDJ5i6lPo3pa2YI=
Date: Tue, 3 Mar 2026 15:42:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next] net: core: allow
 netdev_upper_get_next_dev_rcu from bh context
To: Jakub Kicinski <kuba@kernel.org>, Kohei Enju <kohei@enjuk.jp>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 kohei.enju@gmail.com
References: <20260220110922.94781-1-kohei@enjuk.jp>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260220110922.94781-1-kohei@enjuk.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2/20/26 3:09 AM, Kohei Enju wrote:
> Since XDP programs are called from a NAPI poll context, the RCU
> reference liveness is ensured by local_bh_disable().
> 
> Commit aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master
> device") started to call netdev_upper_get_next_dev_rcu() from this
> context, but missed adding rcu_read_lock_bh_held() as a condition to the
> RCU checks.
> While both bh_disabled and rcu_read_lock() provide RCU protection,
> lockdep complains since the check condition is insufficient [1].
> 
> Add rcu_read_lock_bh_held() as condition to help lockdep to understand
> the dereference is safe, in the same way as commit 694cea395fde ("bpf:
> Allow RCU-protected lookups to happen from bh context").
> 
> [1]
>   WARNING: net/core/dev.c:8099 at netdev_upper_get_next_dev_rcu+0x96/0xd0, CPU#0: swapper/0/0
>   ...
>   RIP: 0010:netdev_upper_get_next_dev_rcu+0x96/0xd0
>   ...
>    <IRQ>
>    dev_map_enqueue_multi+0x411/0x970
>    xdp_do_redirect+0xdf2/0x1030
>    __igc_xdp_run_prog+0x6a0/0xc80
>    igc_poll+0x34b0/0x70b0
>    __napi_poll.constprop.0+0x98/0x490
>    net_rx_action+0x8f2/0xfa0
>    handle_softirqs+0x1c7/0x710
>    __irq_exit_rcu+0xb1/0xf0
>    irq_exit_rcu+0x9/0x20
>    common_interrupt+0x7f/0x90
>    </IRQ>
> 
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
>   net/core/dev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 096b3ff13f6b..b99d46b682c6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -8103,7 +8103,8 @@ struct net_device *netdev_upper_get_next_dev_rcu(struct net_device *dev,
>   {
>   	struct netdev_adjacent *upper;
>   
> -	WARN_ON_ONCE(!rcu_read_lock_held() && !lockdep_rtnl_is_held());
> +	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held() &&


lgtm after re-reading some of the threads related to commit 694cea395fde.

Jakub, if it looks good to you also, can you take it to the net-next 
tree? Thanks.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

> +		     !lockdep_rtnl_is_held());
>   
>   	upper = list_entry_rcu((*iter)->next, struct netdev_adjacent, list);
>   

