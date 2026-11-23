Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406353;
	b=DQmYJkGhpsKIF3ZgWBr1GYSatSPwe4uZ0VQ2sxxl9IwTUe8LnMKFH72od2o5A1dOmu+s
	 UvM3DQvwFA2V0QOLPI+/QIM6M7xPogUKA5V3JWvycsI5+GGBx6mlJclw23NbCF7Yyy+x+
	 TMqtnPtKActbjj+AzKUJxNN14GMdF4nEmirXvClEpKuwSxphyFOUQS8PBLhL9OCJNrlK8
	 cvAZNq4ltolHOKovCIqLebaTvp5hg2A6ZATfbBAruJm7g13J9NZMgwhdy87ZRXBEG03H7
	 5HFbXM5FlsKa9v7G22P00LfbSoaXUuLeV+Hrs0Rq+6HmZ5LEvXvuLGaGYivhWTVe9Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406353;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9Qk8eItz01Sdldz0OQYKp5tRtKQzSzN8U2aRMjlYMCQ=;
	b=kukn3Xml9sbZ2kLIS16JrpwqjZHuKJo8v6NRmLUtWIBhvZjp+0qOy+0urkyc8+0kRmGs
	 YBEEJAZhkLx6L++qECvhE1z+idcIbN5xMKZvTLWXpuxxZ6WBDybVJVroMeQur+9TFOaZ6
	 Gt86wsoqEn9Eb/gdHpjpKlj1gTKYAyKMWyjjb3JlfRwftrYIzxycPjXaMsJuJgy+UXESn
	 QDXy2WKaiOicm3i987HHt35Vc7XCvixSEG1LWeIvsIxdxCqAsV6z8mn49gve0tmqnfw/T
	 wtn7L+eFJtADMJasQqclJt+zZm3QSzf98j/sjGlbd6joBZup3lAzgDj0WzTEKKGMP0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LI9kqZRI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A831D606A31A;
	Mon, 23 Nov 2026 03:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LI9kqZRI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152571F000D3;
	Mon, 23 Nov 2026 03:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795406352;
	bh=9Qk8eItz01Sdldz0OQYKp5tRtKQzSzN8U2aRMjlYMCQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LI9kqZRIdvueOIL9Q3zh8pZORRyV4SzppDjO7mtFAaNgb/zjabvjVKqjFGnmBAWkG
	 t35W9yfHEWwsdyRlGm4hYGO92OJaP3TnN7fBpCLGtO50ZidxWQdUGzmZcVdhjvslU/
	 OBRe6/JPsNT5ys0vJjGqJR25hZt26loJWCpsNzekkt+9QsugZ3CUe+dqAundI6kJEo
	 8tbHF9pdk+zDj63nA4ny+jMOwwa2yYaWDd5DFzGQV3ROgI9JAUZV3BrriNRVxscyMi
	 RvnmDBnx+L+JuU5QUGRo2k5j10E1WRqB1dJDviGn3wPzVeEHXgragjD63sDikaJiA8
	 g2kl7jwYxm6GA==
Subject: Re: [PATCH net-next v2 03/11] net: set tx_extra_headroom of the peer
 on XDP attach
From: netdev-bot+sashiko@kernel.org
To: tianyi@cloudflare.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, horms@kernel.org, dkeogh@amazon.com,
 hawk@kernel.org, daniel@iogearbox.net, dwmw2@infradead.org,
 dtatulea@nvidia.com, noren@nvidia.com, alasdair@mcwilliam.dev,
 willemdebruijn.kernel@gmail.com, maciej.fijalkowski@intel.com,
 sdf@fomichev.me, magnus.karlsson@intel.com, dsahern@kernel.org,
 idosch@nvidia.com, ast@kernel.org, john.fastabend@gmail.com,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, corbet@lwn.net,
 skhan@linuxfoundation.org, shuah@kernel.org, rdunlap@infradead.org,
 leitao@debian.org, ast@fiberby.net, danieller@nvidia.com, kuniyu@google.com,
 bpf@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
 nh-open-source@amazon.com, stephen@networkplumber.org, gustavoars@kernel.org,
 one-d-wide@protonmail.com, ameryhung@gmail.com, andrii@kernel.org,
 aroulin@nvidia.com, anilkaushikwireless@gmail.com, demosthenes.ra@gmail.com,
 eddyz87@gmail.com, emil@etsalapatis.com, hangbin.liu@linux.dev,
 ihor.solodrai@linux.dev, jiayuan.chen@linux.dev, jolsa@kernel.org,
 joe@dama.to, memxor@gmail.com, lirongqing@baidu.com, louis.scalbert@6wind.com,
 mkl@pengutronix.de, martin.lau@linux.dev, mkarsten@uwaterloo.ca,
 mattbobrowski@google.com, michael.bommarito@gmail.com, razor@blackwall.org,
 runyu.xiao@seu.edu.cn, song@kernel.org, linux@leemhuis.info,
 wang.zhan@smartx.com, yonghong.song@linux.dev, n0ps1edzz@gmail.com,
 tianyi.gao@linux.dev
Date: Mon, 23 Nov 2026 03:59:08 +0000
Message-ID: <179540634863.3135.17027370406892686055@kernel.org>
In-Reply-To: <20261119013830.36935-4-tianyi@cloudflare.com>
References: <20261119013830.36935-4-tianyi@cloudflare.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Native XDP on veth still copies every locally generated
  packet, and the commit message implies this patch fixes that.

--

net: set tx_extra_headroom of the peer on XDP attach

While the peer of a veth or netkit device has an XDP program, this patch
sets tx_extra_headroom of the device to XDP_PACKET_HEADROOM minus
needed_headroom, so locally generated packets have the headroom XDP
needs. netdev_update_tx_extra_headroom() recalculates the value on XDP
attach, on detach, and when an upper device propagates its program
through netif_xdp_propagate().

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 85b7c61015c7c..6e053f612d720 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -10677,6 +10678,41 @@ u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
>  	return prog ? prog->aux->id : 0;
>  }
>  
> +static void __netdev_update_tx_extra_headroom(struct net_device *dev,
> +					      struct net_device *peer)
> +{
> +	unsigned int needed_headroom = READ_ONCE(dev->needed_headroom);
> +	unsigned int tx_extra_headroom = 0;
> +
> +	if (peer && dev_xdp_prog_count(peer) &&
> +	    needed_headroom < XDP_PACKET_HEADROOM)
> +		tx_extra_headroom = XDP_PACKET_HEADROOM - needed_headroom;

[Severity: Medium]

Does this avoid the copy for native XDP on veth? The commit message says:

  XDP on the peer of a veth or netkit device
  then copies every packet. Generic XDP copies it in
  netif_skb_check_for_xdp(), and native XDP on veth in
  veth_convert_skb_to_xdp_buff().

veth_convert_skb_to_xdp_buff() still copies whenever the head is not a
page fragment:

drivers/net/veth.c:veth_convert_skb_to_xdp_buff() {
    ...
	if (skb_shared(skb) || skb_head_is_locked(skb) ||
	    skb_is_nonlinear(skb) ||
	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
    ...
}

skb_head_is_locked() is true when !skb->head_frag. The local paths that
now add tx_extra_headroom are __ip_append_data(), raw_send_hdrinc(),
packet_snd() and xsk_build_skb(). All of them allocate the head with
alloc_skb() or sock_alloc_send_pskb(), so head_frag is 0 and these
packets are still copied.

veth has ndo_bpf, so dev_xdp_mode() picks XDP_MODE_DRV by default. In
that default case, every locally generated skb sent to the peer gets up
to 256 extra bytes of headroom. This can push small packets into a
larger kmalloc bucket, and no copy is saved.

The generic XDP path does look fixed. netif_receive_generic_xdp() only
checks cloned, nonlinear and headroom, not head_frag.

The note below the --- line says a follow-up veth series will fix the
head_frag condition, but git am drops that note. Could the commit message
say that native XDP on veth still copies after this patch?

The new text in Documentation/networking/netdevices.rst has the same gap:

  When the peer has an XDP program, locally generated UDP, raw and
  AF_PACKET packets and AF_XDP packets in copy mode have enough headroom
  for it.

Should it mention that native XDP on veth still copies these packets?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119013830.36935-1-tianyi%40cloudflare.com
