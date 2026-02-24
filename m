Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84292868B2
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918343; cv=none; b=h+ERkbA3EnZUhWX4MLadT2lED6KXjSecPhzu7KI/NEBTpPPw+Yw0qVzHyPMj6Ep/5dHgkkywJ0BRQjEHT38gv2RTQkh/K+kRZsruwUAaJRT0DqZ4nzW15VZmvXcX10oplMnMphl2wbxx3vhuNgFsdVbvOLEN5BK2G1naqj+zBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918343; c=relaxed/simple;
	bh=d0Q2rSgRuUEkQvpLjuXStow5++oAw5YGa+WZhF3+6II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/SpDALM2jyiUm640OTkyetHo/KCfTNI/SsTYopOFJ8bUoJ83p/RiPhTrBYbQVsQQVFp4R9RLnRr6ih/m9N7xcXDY4t528ZKxMsAd/uyUgfsA1yPVreNUWqeTjzQJMhHRpPKDZmJ+Slm5VC4sn/slXMGts1sChP4bbOXg5tgnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4hTPw3p; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4hTPw3p"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43638a33157so4803238f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 23:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771918339; x=1772523139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2b+TtUL0OeelBHcO+Aq8hOabke3OUGf+iwRcVyhE8I=;
        b=U4hTPw3phpiZ9GZQt2bQsCi7zVuq7JqO0QFtDdjqv3dJXLTPDZyHz92A734kRGVnH3
         w7gEeIzBV32iVzefjZnbIVDfPsAHYG61vFujy63fpyBmEjGXJ3lIN92BBTGU0pUBOX/B
         nHyv1jXe9bH0cwN++MRKDUwnEY/+dW2Mcv7gtVStTIm/K1kgFeK1E2Pt1M1K6v1IKVWI
         y99opWWl8z1qo9yEvD+U4sqqziDDHmSgAokQoJJaKBBPqYhiwWJM2PpIYaV4rZ4jKfbC
         /Ofdzd+BRKa6E8rvDnXJGI+VUEpmLUYdui68DIEQwhTGsKlIGkuFyF2vfd3cWyFEba6n
         9wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771918339; x=1772523139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2b+TtUL0OeelBHcO+Aq8hOabke3OUGf+iwRcVyhE8I=;
        b=tpHmfMsb1BYBA66ijaEnIIilaNygFmWKFBnF2NBLp9UQRVkVY2MvRh2wtynQ4n+q3i
         h0u1PeQU1KgRdPjuo4d4Mc2y/1C1GkcGeylntMBav9fYPwDrzupuusFT9HuS2E0BOoY1
         eEe4O0XPPUyUO57enLH0caU/rkeoLOSSeFJcpAGS8c8giJr316oEo28WnDA4pJknijXG
         skHZsjuFovKzeHKl/io7IsRTKKU1fJi7+l8N09Bogb2aq9WXmhWFr8keQL2pJQa++21B
         g8OQLYYGE774NkpfIzjjxrNEOCAa7a2KHfHzNA8y3GcJNCpIOT9KXXDESyfxM1uWnEMn
         9Aow==
X-Forwarded-Encrypted: i=1; AJvYcCWfumqR7wAkY53CjiOI5Ix4eO3p6xzsQU3EcsYgo7yX/M72SllcEe9OekIg3NR1YTJ54l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9b1XEtXLPcX2dKpplbUqqNmh4NeRHhF0ctAsPR+NuxMzXFHA
	WlAi/dzg+fncCXt6dnRLnrJ3cvzy7+86nklMmlcAuTLE9/SuVovm0I4Z
X-Gm-Gg: ATEYQzxwXRZwnZdyO7JkOxZkQgGWE9+gg59Ovip3rPdqsjZhaec/uN0NncXdC77UUGM
	tuwXiuHfmR8V53RFBUtoPyV1Qtu5mIJbjk16KIOD2ibfX6MPBydlS0qCmLbfjqXZmTQpLYdXfoo
	Hh2XuoGksH57UJ4OsNg9bI5nxyUHyrI7tngYewofNbuAy3/4UGGiOTdzOIE/ESreFTVmlRJEulz
	pfbEeplE/D5XSRpXIMzSm10IqTYouZfeWxOCrgDFB+Nm6CiIKWRlM2jM36oEvqq4cZxmhxP8Njv
	7l4u+J+zn+ZfTiqWovrXC5LqnT0ReT7c3ooqskc4ho3a8a7gA4qVnthmwUWp4Y/PkDKx4qfFAL4
	fLXQxPC7st/o8NhII9o2BMVCiC5TNorbFHWGSenLB9aVUef8O2Eo27JfKH3Yqaxd+wStuQCAdvK
	TGuhxn4GejXSxFeI5WpY2MWbN5KMHCWuoQm3pfTUx9yIcDViw=
X-Received: by 2002:a05:6000:2408:b0:437:6b73:ffa9 with SMTP id ffacd0b85a97d-4396f14c9b4mr20895527f8f.5.1771918339056;
        Mon, 23 Feb 2026 23:32:19 -0800 (PST)
Received: from [10.221.199.249] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d54c5csm24737157f8f.38.2026.02.23.23.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 23:32:18 -0800 (PST)
Message-ID: <5359a23e-972a-4f88-b697-6b76334231a8@gmail.com>
Date: Tue, 24 Feb 2026 09:32:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Precompute xdpsq assignments for
 mlx5e_xdp_xmit()
To: Finn Dayton <Finnius.Dayton@spacex.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Alexei Starovoitov ," <ast@kernel.org>,
 "Daniel Borkmann ," <daniel@iogearbox.net>,
 "David S. Miller ," <davem@davemloft.net>, "Jakub Kicinski ,"
 <kuba@kernel.org>, "Jesper Dangaard Brouer ," <hawk@kernel.org>,
 "John Fastabend ," <john.fastabend@gmail.com>,
 "Stanislav Fomichev ," <sdf@fomichev.me>,
 "Saeed Mahameed ," <saeedm@nvidia.com>, "Leon Romanovsky ,"
 <leon@kernel.org>, "Tariq Toukan ," <tariqt@nvidia.com>,
 "Mark Bloch ," <mbloch@nvidia.com>, "Andrew Lunn ," <andrew+netdev@lunn.ch>,
 "Eric Dumazet ," <edumazet@google.com>, "Paolo Abeni ," <pabeni@redhat.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <610D8F9E-0038-46D9-AD8A-1D596236B1EF@spacex.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <610D8F9E-0038-46D9-AD8A-1D596236B1EF@spacex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/02/2026 2:05, Finn Dayton wrote:
> mlx5e_xdp_xmit() selects an XDP SQ (Send Queue) using smp_processor_id()
> (CPU ID). When doing XDP_REDIRECT from a CPU whose ID is
>> = priv->channels.num, mlx5e_xdp_xmit() returns -ENXIO and the
> redirect fails.
> 
> Previous discussion proposed using modulo in mlx5e_xdp_xmit() to map
> CPU IDs into the channel range, but modulo/division is too costly in
> the hot path.
> 
> Instead, this solution precomputes per-cpu priv->xdpsq assignments when
> channels are (re)configured and does a single lookup in  mlx5e_xdp_xmit().
> 
> Because multiple CPUs map to the same xdpsq when CPU count exceeds
> channel count, serialize xdp_xmit on the ring with xdp_tx_lock.
> 
> Fixes: 58b99ee3e3eb ("net/mlx5e: Add support for XDP_REDIRECT in device-out side")
> Link: https://lore.kernel.org/netdev/20251031231038.1092673-1-zijianzhang@bytedance.com/
> Link: https://lore.kernel.org/netdev/44f69955-b566-4fb1-904d-f551046ff2d4@gmail.com
> Cc: stable@vger.kernel.org # 6.12+

Do not introduce it as a fix. No bug here.

> Signed-off-by: Finn Dayton <finnius.dayton@spacex.com>
> ---
> Testing:
>   - XDP forwarding / XDP_REDIRECT verified with both low CPU ids and
>     CPU ids > than number of send queues.
>   - No -ENXIO observed, successful forwarding.
> 
>   drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +++
>   .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 16 +++++++----
>   .../net/ethernet/mellanox/mlx5/core/en_main.c | 28 +++++++++++++++++++
>   3 files changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index ea2cd1f5d1d0..387954201640 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -519,6 +519,8 @@ struct mlx5e_xdpsq {
>   	/* control path */
>   	struct mlx5_wq_ctrl        wq_ctrl;
>   	struct mlx5e_channel      *channel;
> +	/* serialize writes by multiple CPUs to this send queue */
> +	spinlock_t xdp_tx_lock;

You're already inside xdpsq, no need to repeat xdp_tx in field name.
Move field to the section with /* dirtied @xmit */.
Try to find a proper placement with minimal cacheline impact.

>   } ____cacheline_aligned_in_smp;
>   
>   struct mlx5e_xdp_buff {
> @@ -909,6 +911,8 @@ struct mlx5e_priv {
>   	struct mlx5e_rq            drop_rq;
>   
>   	struct mlx5e_channels      channels;
> +	/* selects the xdpsq during mlx5e_xdp_xmit() */
> +	int __percpu              *send_queue_idx_ptr;

Move to section with /* priv data path fields - start */.
Similarly to txq2sq, I'd switch the mapping to give xdpsq pointer, 
rather than index.

>   	struct mlx5e_rx_res       *rx_res;
>   	u32                       *tx_rates;
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 80f9fc10877a..2dd44ad873a1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -845,7 +845,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>   	struct mlx5e_priv *priv = netdev_priv(dev);
>   	struct mlx5e_xdpsq *sq;
>   	int nxmit = 0;
> -	int sq_num;
> +	int send_queue_idx = 0;

Do not break RCT.

>   	int i;
>   
>   	/* this flag is sufficient, no need to test internal sq state */
> @@ -855,13 +855,19 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>   	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>   		return -EINVAL;
>   
> -	sq_num = smp_processor_id();
>   
> -	if (unlikely(sq_num >= priv->channels.num))
> +	if (unlikely(!priv->send_queue_idx_ptr))

Should be guaranteed by the safety mechanisms.
Not needed.

>   		return -ENXIO;
>   
> -	sq = priv->channels.c[sq_num]->xdpsq;
> +	send_queue_idx = *this_cpu_ptr(priv->send_queue_idx_ptr);
> +	if (unlikely(send_queue_idx >= priv->channels.num || send_queue_idx < 0))
> +		return -ENXIO;

Should be guaranteed by the safety mechanisms.
Not needed.

>   
> +	sq = priv->channels.c[send_queue_idx]->xdpsq;
> +	/* The number of queues configured on a netdev may be smaller than the
> +	 * CPU pool, so two CPUs might map to this queue. We must serialize writes.
> +	 */
> +	spin_lock(&sq->xdp_tx_lock);
>   	for (i = 0; i < n; i++) {
>   		struct mlx5e_xmit_data_frags xdptxdf = {};
>   		struct xdp_frame *xdpf = frames[i];
> @@ -941,7 +947,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>   
>   	if (flags & XDP_XMIT_FLUSH)
>   		mlx5e_xmit_xdp_doorbell(sq);
> -
> +	spin_unlock(&sq->xdp_tx_lock);
>   	return nxmit;
>   }
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 7eb691c2a1bd..adef35d06b89 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -1492,6 +1492,7 @@ static int mlx5e_alloc_xdpsq(struct mlx5e_channel *c,
>   	sq->pdev      = c->pdev;
>   	sq->mkey_be   = c->mkey_be;
>   	sq->channel   = c;
> +	spin_lock_init(&sq->xdp_tx_lock);

placement looks arbitrary.
move it so it doesn't interfere the fields assignments/inits.

>   	sq->uar_map   = c->bfreg->map;
>   	sq->min_inline_mode = params->tx_min_inline_mode;
>   	sq->hw_mtu    = MLX5E_SW2HW_MTU(params, params->sw_mtu) - ETH_FCS_LEN;
> @@ -3283,10 +3284,30 @@ static void mlx5e_build_txq_maps(struct mlx5e_priv *priv)
>   	smp_wmb();
>   }
>   
> +static void build_priv_to_xdpsq_associations(struct mlx5e_priv *priv)

Rename. How about mlx5e_build_xdpsq_maps? Similar to mlx5e_build_txq_maps.

> +{
> +	/*

Start comment here, don't keep an empty comment line.

> +	 * Build the mapping from CPU to XDP send queue index for priv.
> +	 * This is used by mlx5e_xdp_xmit() to determine which xdpsq (send queue)
> +	 * should handle the xdptx data, based on the CPU running mlx5e_xdp_xmit()
> +	 * and the target priv (netdev).
> +	 */

Comment is too long. Can be short and to the point.

> +	int send_queue_idx, cpu;
> +
> +	if (unlikely(priv->channels.num == 0))
> +		return;
> +

Shouldn't be possible.
This will just hide bugs. Remove it.

> +	for_each_possible_cpu(cpu) {
> +		send_queue_idx = cpu % priv->channels.num;

Not sure this deserves a local var..

> +		*per_cpu_ptr(priv->send_queue_idx_ptr, cpu) = send_queue_idx;
> +	}

We probably need smp_wmb(); here.
Need to think about it...

> +}
> +
>   void mlx5e_activate_priv_channels(struct mlx5e_priv *priv)
>   {
>   	mlx5e_build_txq_maps(priv);
>   	mlx5e_activate_channels(priv, &priv->channels);
> +	build_priv_to_xdpsq_associations(priv);
>   	mlx5e_xdp_tx_enable(priv);
>   
>   	/* dev_watchdog() wants all TX queues to be started when the carrier is
> @@ -6263,8 +6284,14 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
>   	if (!priv->fec_ranges)
>   		goto err_free_channel_stats;
>   
> +	priv->send_queue_idx_ptr = alloc_percpu(int);
> +	if (!priv->send_queue_idx_ptr)
> +		goto err_free_fec_ranges;
> +
>   	return 0;
>   
> +err_free_fec_ranges:
> +	kfree(priv->fec_ranges);
>   err_free_channel_stats:
>   	kfree(priv->channel_stats);
>   err_free_tx_rates:
> @@ -6295,6 +6322,7 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
>   	for (i = 0; i < priv->stats_nch; i++)
>   		kvfree(priv->channel_stats[i]);
>   	kfree(priv->channel_stats);
> +	free_percpu(priv->send_queue_idx_ptr);

Keep order symmetric to the priv_init calls.

>   	kfree(priv->tx_rates);
>   	kfree(priv->txq2sq_stats);
>   	kfree(priv->txq2sq);

