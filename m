Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B722B594
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782091284; cv=none; b=URUtfklbTudVn5AcDooQ26GrdslbCmHY+iT3tuoq2tz5HBPri7HUqZLhYzl1PwwVKRiWNyjl5R7FWopng4B7TGqJCD93fYka5kbCZpv/uiiFzwqIDslUWXf3rOAI6iwxzOMxmJqHVdbwmkpmoCwJn+zCSJOVBX0F7XyT0Icjj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782091284; c=relaxed/simple;
	bh=Jmc1eoXsgZDimuJgTelp6JB8lwcJG7/8AmTws2Cg8RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T11wOU6GqDwX7LYfSfXm0zPdvAEUOngo3LjftW/wnP+qjDcYADHpKvgiqjaGDoUxIjEhRS9lOvR8xcSKssUE7F9nd8jb63+oj53kkETqdEpaIP+wHkHQK1X0sOgn4wgQ3O9+vKWXfFLjFUBx/J0IK5iOKDHDqzmMDq6NuJmwikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T9yoE8hC; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T9yoE8hC"
Message-ID: <7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782091279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9QpWB7h+OAc4xw9YXh649wA7kd08Md/GJlPTwgijKks=;
	b=T9yoE8hCwBtPkDuxJ6uCh0Q1MfjVBZ+b2cspeZ+ElPapbtFlxWZhvf5NU1FvY6WWVoE+Xo
	AP/n0fpxX5T5eSHUiju0lgDpCx/wKZrUyuVXC1XdtH3kAvyFzeuBVTc/NENNlx/95E3xsS
	s9DRXX+Y7R1qhpgZ9EyM2JENFx8Mnqs=
Date: Mon, 22 Jun 2026 09:21:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net, bpf: check master for NULL in
 xdp_master_redirect()
To: Xiang Mei <xmei5@asu.edu>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Jussi Maki <joamaki@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Weiming Shi <bestswngs@gmail.com>
References: <20260620201531.180123-1-xmei5@asu.edu>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260620201531.180123-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/21/26 4:15 AM, Xiang Mei wrote:
> xdp_master_redirect() dereferences the result of
> netdev_master_upper_dev_get_rcu() without a NULL check, but that helper
> returns NULL when the receiving device has no upper-master adjacency.
>
> The reach guard only checks netif_is_bond_slave(). On bond slave release
> bond_upper_dev_unlink() drops the upper-master adjacency before clearing
> IFF_SLAVE, so an XDP_TX reaching xdp_master_redirect() in that window
> still passes netif_is_bond_slave() while master is already NULL, and
> faults on master->flags at offset 0xb0:
>
>    BUG: kernel NULL pointer dereference, address: 00000000000000b0
>    RIP: 0010:xdp_master_redirect (net/core/filter.c:4432)
>    Call Trace:
>     xdp_master_redirect (net/core/filter.c:4432)
>     bpf_prog_run_generic_xdp (include/net/xdp.h:700)
>     do_xdp_generic (net/core/dev.c:5608)
>     __netif_receive_skb_one_core (net/core/dev.c:6204)
>     process_backlog (net/core/dev.c:6319)
>     __napi_poll (net/core/dev.c:7729)
>     net_rx_action (net/core/dev.c:7792)
>     handle_softirqs (kernel/softirq.c:622)
>     __dev_queue_xmit (include/linux/bottom_half.h:33)
>     packet_sendmsg (net/packet/af_packet.c:3082)
>     __sys_sendto (net/socket.c:2252)
>    Kernel panic - not syncing: Fatal exception in interrupt
>
> The missing check dates back to the original code; commit 1921f91298d1
> ("net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master")
> later added the master->flags read where the fault now lands but kept the
> unconditional deref. Check master for NULL before use; a NULL master is
> treated the same as one that is not up.
>
> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>   net/core/filter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 40037413dd4e..6037860d5283 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4430,7 +4430,7 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
>   	struct net_device *master, *slave;
>   
>   	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> -	if (unlikely(!(master->flags & IFF_UP)))
> +	if (unlikely(!master || !(master->flags & IFF_UP)))
>   		return XDP_ABORTED;


I recall that when I previously modified this code, I removed the 
!master check

because this is on the fastpath. However, since this is a triggerable bug,
I think adding it here is fine.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

