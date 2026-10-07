Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0267455603;
	Wed,  7 Oct 2026 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368710; cv=none; b=jYN9mpgSZNMaau6iCtL43C6Haaid62DPPKGFh5nVJ2rDbnLOwPZpkMoLtBzO7yY6sqrnJ9HwU0gR1ocxRWl8x/FrWbn8ovgo655z7ShmcB2ysxjAtQZYBaA5P7lIBFYXDsbpKWEkjSgG94WBmJZ8hX82ggvCTBMNqpgX7eXsG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368710; c=relaxed/simple;
	bh=QOUb04sxdXJ4221QrxSmrML56hTwzjpUDFrLQvh6Mxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/eleycqf5vHiIxW4Lc9nFzbpmcq7eI5c4ZdvdNHr/SFVGetVYoSwBznHEQsomPJQla8f65S3x6XD/MImH16my6BYgMTXZmuFi6wrUY1WAe6IkERWiYIL6aWubmBuiOBm1dAid/92gf8iKyxP09UJE1A2b121U4pS7FX3clEpVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILrAvlPL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILrAvlPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564D61F0089C;
	Wed,  7 Oct 2026 10:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791368698;
	bh=0TjPFKzMmL1X7IwNPLU8VAISwb34EtuySdi+5AAzRUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ILrAvlPL6C+1SnZPm2B3aP4N6vP6QgJzq3YOr38GwR2FbvJg8W6QYWgE+u2+4WkEh
	 OG+8laOqIkkD/hMDAEzdXVOPuBTC65TAn01sGHZT0A1DLfcI9XT1M3gYTmb6AXPXKt
	 oX6YazLxj5vznGIpNzr5RyzUjTEsbnuZdvBGspp3Xr5YDNhiB+SJjPb5Vx8CtynIeR
	 QqiQWP98JGIJllDXrPzRL3Kw1IPVoGYgattzLI3LPE9fo+3VfpUCjdhCIPQ3k+7xuE
	 bY1QJDB83rs6jkYoi7tGWubc7awYGxwhpD+bfdZMx8FcfLgT6xvCIyotqPfAgNjX4n
	 rf6JgL72hMZPA==
Message-ID: <3a683dd9-5d95-456b-b7db-da1fe1ce0e66@kernel.org>
Date: Wed, 7 Oct 2026 12:24:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] veth: fix peer NETDEV_XDP_ACT_NDO_XMIT after GRO
 is toggled while down
To: Tianyi Gao <tianyi@cloudflare.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, toke@redhat.com, lorenzo@kernel.org,
 horms@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
 kernel-team@cloudflare.com, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, linux-kselftest@vger.kernel.org
References: <20261006173241.65945-1-tianyi@cloudflare.com>
 <20261006173241.65945-2-tianyi@cloudflare.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20261006173241.65945-2-tianyi@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/6/26 19:32, Tianyi Gao wrote:
> A veth device advertises NETDEV_XDP_ACT_NDO_XMIT only if its peer has an
> XDP program attached or GRO enabled, that is, only if the peer will have
> NAPI to receive the frames.
> 
> veth_set_features() updates the peer's flag when GRO is toggled, but
> returns early if the device is down, and veth_open() only refreshes the
> flags of the device being opened. Toggling GRO while the device is down
> therefore leaves the peer's flag stale after the device comes up.
> 
> If GRO was enabled while down, the device comes up with NAPI but the
> peer does not advertise NDO_XMIT, and devmap rejects redirects to the
> peer with -EOPNOTSUPP. If GRO was disabled while down, the device comes
> up without NAPI but the peer still advertises NDO_XMIT, so redirects are
> accepted and then dropped in veth_xdp_xmit() with -ENXIO.
> 
> Commit 7a6102aa6df0 ("veth: Update XDP feature set when bringing up
> device") made veth_open() refresh the device's own flags. Refresh the
> peer's flags there too. The peer's flag depends on this device's XDP
> program and GRO setting, not on whether the peer is up, so it is
> correct to set it even if the peer is down.
> 
> Fixes: 8267fc71abb2 ("veth: take into account peer device for NETDEV_XDP_ACT_NDO_XMIT xdp_features flag")
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

>   drivers/net/veth.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 71227d0389aa..643b97dc5245 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1415,6 +1415,7 @@ static int veth_open(struct net_device *dev)
>   	}
>   
>   	veth_set_xdp_features(dev);
> +	veth_set_xdp_features(peer);
>   
>   	return 0;
>   }

