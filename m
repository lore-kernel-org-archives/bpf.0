Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76FA2853F7
	for <bpf@vger.kernel.org>; Sun,  8 Mar 2026 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772953440; cv=none; b=AIG8JZFXxjGcWZgUSJGJ3/+jmkOgboPDCZiPAvsJJn8ODrYVrgCcr96h76jBmjcLvPK1mw8B3WRcglWMhh/oXuW1vaw79pZ8qRv+XS5Yffe1P+hubl4ZF+JNK6t+A+8bfRJ7BEBDgIv3XIqr9ZATvKE7/myI5yFLdKHG3ZGrJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772953440; c=relaxed/simple;
	bh=Zh1bm2G6WffKCPIN2jFLIG+MdQXeuGQ6TRbfmAtGFbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wx6c5/Qj3PmTwkwrX5CIen3HmXvez9HfgzmuCxrzl0Jf2rDPG+zFZiArprTqQdpQPdDSL9TVQT9hyXkbP2Qa/fHTXgSzmEeVXAw+UGqqfFOjddHbTPzIe7DChCUFrHi4bXoOuHqja3hE3DmswTVnJOdIZxTNXPDeC7bXslC/BTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVVQ14S1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVVQ14S1"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439c56e822eso4956497f8f.2
        for <bpf@vger.kernel.org>; Sat, 07 Mar 2026 23:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772953437; x=1773558237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uex+bKRQKHrL7xt0CITOz3u6A+gWG+tnnaXJC6V2/0g=;
        b=LVVQ14S1EoOU4ymyVEyBlNQx56G8RYINnMKt2AA4LKebuH0NKefUVy1O52y1FYzbUz
         C2Ln200Cq/DGaW7JUxZ+5ERpD0NQMSvwmADAjBW0vIina49PhzEsRSp4hqU8Uags9GFO
         r42hFPmzy/RBG6slzMQIsR57LhxIxc9us/rK2Fc60TDp7JNA/H0fAMIZaviJ7Q2/Z5Ls
         zJprEJ6OkM5I1H2rwU01ovMFTv/wywdqPGstlv20P/8/TqALX/iqkS9QHvDVxlDQTmHO
         4iYo3sz3PZWopZ0bdCsowLQlpG2+v+FX7fNjIHBqounU83jVPYmlr4HfwrdqyETtkdCR
         k63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772953437; x=1773558237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uex+bKRQKHrL7xt0CITOz3u6A+gWG+tnnaXJC6V2/0g=;
        b=kR5jbK0240lY7nwTAqJwHDj4dX7ncEQ9CPI7zmF0k8sruKoMXRVCQeQWmNyPgd5Ebn
         F2EoymTfdgFZCzoU+BSto2VGHkBd/kB6/fl1KjDPu1gGQnUYkkiLOa9Iu64qEt2bG4Cm
         gsqyBU/ATRe6frkhlvhWTtlyKCBmwnPjNIfrCpWf0COMfBHS+aPgkFygHAzOjj3Nd3Rl
         6m2MEYTyP6Q2NwAdUy2nkMNUKV8bIquxnUkLDLtspPDfg0ROSP1GXJhMJTosDvj3eg62
         Mj9bj1rACe/JbKuqt30x+DcT1bFpDqv6Ly8lw2GQa9y6REaf4oAL5HzdSLIlUWoXrsxE
         gjIg==
X-Forwarded-Encrypted: i=1; AJvYcCVw3tRtaScoBHb+kp3+WD1x3z34iV1rfl4UhkDPN5pVpVE/Z+7/61L+83+oricrmMosBkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcMJVOxhquIC+NbLFzWAv6yhVp5FbQEN5NgFdduonjQtvmFFYb
	zqpkKiCpZKnnkLvjzTMmNkeFeQJRI2AjtPvfjvOaUgDXmpybi0DZwcOn
X-Gm-Gg: ATEYQzyTi25XKKf6UpY1Lai1C0O8tikw52PRI/lisc2H/PZFGDdSUyxQ6/xbqgPRLtf
	3fLm33FxIh/DuSJpCpX/S7mp5scqcN60/2vfxAmXcwF+MdHZJNOiNOaEIyp/i/VhuCUZywktOGV
	u9kTgUfVXYTlKXcgjjuxfCP2h0r+4ND6G6CvRJoA9x4dVYWFclgq4/9JwojJei5M7T11yv70nAG
	gtjZXOvKAZDX7GvSnqrEPC8t87i6Hxu12YLB18cGKL+JtRMqcKNUcmS718OlPfctJUC9ZKDqgO4
	ypAbn1fULx7JYDMe283sbeO2KlmKIy0OiscJ/AR1Ns4Tz0j62uTlJ/Q/JI8bLMd4E+24rnyymJW
	6E2oryQwlV9HxR1cO/kKLcP9voAgNP5t1mL8Zt09jfOzGtBYjDimfGrEwJGDsPF/7VE77X/OtkV
	3+3xvThFmLS+ss2r8X3XFPqFp7fqybwpbBJFjXaruAt5JaEyhtbwFa/TQx4Q==
X-Received: by 2002:a5d:5f93:0:b0:439:b791:f920 with SMTP id ffacd0b85a97d-439da656af4mr13244466f8f.17.1772953436851;
        Sat, 07 Mar 2026 23:03:56 -0800 (PST)
Received: from [10.221.200.186] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae36785sm15614890f8f.27.2026.03.07.23.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 23:03:56 -0800 (PST)
Message-ID: <6f3c34dc-af62-4f54-b56f-4aa6e8f1c690@gmail.com>
Date: Sun, 8 Mar 2026 09:03:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/mlx5e: Precompute xdpsq assignments for
 mlx5e_xdp_xmit()
To: Finn Dayton <Finnius.Dayton@spacex.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "sdf@fomichev.me" <sdf@fomichev.me>, "saeedm@nvidia.com"
 <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
 "tariqt@nvidia.com" <tariqt@nvidia.com>,
 "mbloch@nvidia.com" <mbloch@nvidia.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <60E0EC79-4E2B-4874-9CEB-6558706A910A@spacex.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <60E0EC79-4E2B-4874-9CEB-6558706A910A@spacex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/03/2026 7:52, Finn Dayton wrote:
> mlx5e_xdp_xmit() currently selects the xdpsq (send queue) using
> smp_processor_id() (i.e. cpu id). When doing XDP_REDIRECT from a cpu
> with id >= priv->channels.num, however, mlx5e_xdp_xmit() returns -ENXIO
> and the redirect fails.
> 
> Previous discussion proposed using modulo or while loop subtraction
> in mlx5e_xdp_xmit() to map cpu id to send queue, but these approaches
> introduce hot path overhead on modern systems where the number of
> logical cores >> the number of XDP send queues (xdpsq).
> 
> The below approach precomputes per-cpu priv->xdpsq assignments when
> channels are (re)configured and does a constant-time lookup in
> mlx5e_xdp_xmit().
> 
> Because multiple CPUs may now map to the same xdpsq (whenever cpu count
> exceeds channel count), we serialize writes in xdp_xmit with a tx_lock.
> 
> Link: https://lore.kernel.org/all/610D8F9E-0038-46D9-AD8A-1D596236B1EF@spacex.com/
> Link: https://lore.kernel.org/all/474c1f71-3a5c-4fe5-a01e-80f2ba95fd7e@bytedance.com/
> Signed-off-by: Finn Dayton <finnius.dayton@spacex.com>
> ---
> v2:
> - Removed unnecessary guards
> - Improved variable naming and placement
> - Change mapping from cpu -> index to cpu -> xdpsq
> - Call smp_wmb() after updates to mapping
> 

Thanks for your patch. Sorry for the delayed feedback.

Were you able to do some basic packet-rate testing for it?
Any noticeable impact?

A few nits below.

>   drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +++
>   .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 17 ++++++-------
>   .../net/ethernet/mellanox/mlx5/core/en_main.c | 25 +++++++++++++++++++
>   3 files changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index ea2cd1f5d1d0..713dc7f9bae3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -493,6 +493,8 @@ struct mlx5e_xdpsq {
>   	u16                        pc;
>   	struct mlx5_wqe_ctrl_seg   *doorbell_cseg;
>   	struct mlx5e_tx_mpwqe      mpwqe;
> +	/* serialize writes by multiple CPUs to this send queue */
> +	spinlock_t                 tx_lock;
>   
>   	struct mlx5e_cq            cq;
>   
> @@ -898,6 +900,8 @@ struct mlx5e_priv {
>   	struct mlx5e_selq selq;
>   	struct mlx5e_txqsq **txq2sq;
>   	struct mlx5e_sq_stats **txq2sq_stats;
> +	/* selects the xdpsq during mlx5e_xdp_xmit() */
> +	struct mlx5e_xdpsq * __percpu *send_queue_ptr;
>   
>   #ifdef CONFIG_MLX5_CORE_EN_DCB
>   	struct mlx5e_dcbx_dp       dcbx_dp;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 80f9fc10877a..1db83a69055c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -845,7 +845,6 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>   	struct mlx5e_priv *priv = netdev_priv(dev);
>   	struct mlx5e_xdpsq *sq;
>   	int nxmit = 0;
> -	int sq_num;
>   	int i;
>   
>   	/* this flag is sufficient, no need to test internal sq state */
> @@ -854,14 +853,12 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>   
>   	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>   		return -EINVAL;
> -
> -	sq_num = smp_processor_id();
> -
> -	if (unlikely(sq_num >= priv->channels.num))
> -		return -ENXIO;
> -
> -	sq = priv->channels.c[sq_num]->xdpsq;
> -
> +	/* Per-CPU xdpsq mapping, rebuilt on channel (re)configuration while XDP TX is disabled */

Line too long?

> +	sq = *this_cpu_ptr(priv->send_queue_ptr);
> +	/* The number of queues configured on a netdev may be smaller than the
> +	 * CPU pool, so two CPUs might map to this queue. We must serialize writes.
> +	 */
> +	spin_lock(&sq->tx_lock);
>   	for (i = 0; i < n; i++) {
>   		struct mlx5e_xmit_data_frags xdptxdf = {};
>   		struct xdp_frame *xdpf = frames[i];
> @@ -941,7 +938,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>   
>   	if (flags & XDP_XMIT_FLUSH)
>   		mlx5e_xmit_xdp_doorbell(sq);
> -
> +	spin_unlock(&sq->tx_lock);
>   	return nxmit;
>   }
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index b6c12460b54a..434db74f096b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -1505,6 +1505,7 @@ static int mlx5e_alloc_xdpsq(struct mlx5e_channel *c,
>   	sq->stop_room = param->is_mpw ? mlx5e_stop_room_for_mpwqe(mdev) :
>   					mlx5e_stop_room_for_max_wqe(mdev);
>   	sq->max_sq_mpw_wqebbs = mlx5e_get_max_sq_aligned_wqebbs(mdev);
> +	spin_lock_init(&sq->tx_lock);
>   
>   	param->wq.db_numa_node = cpu_to_node(c->cpu);
>   	err = mlx5_wq_cyc_create(mdev, &param->wq, sqc_wq, wq, &sq->wq_ctrl);
> @@ -3283,10 +3284,27 @@ static void mlx5e_build_txq_maps(struct mlx5e_priv *priv)
>   	smp_wmb();
>   }
>   
> +static void mlx5e_build_xdpsq_maps(struct mlx5e_priv *priv)
> +{
> +	/* Build mapping from CPU id to XDP send queue, used by
> +	 * mlx5e_xdp_xmit() to determine which send queue to transmit packet on.
> +	 */
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		int send_queue_idx = cpu % priv->channels.num;
> +		struct mlx5e_xdpsq *sq = priv->channels.c[send_queue_idx]->xdpsq;

maintain RCT.

> +		*per_cpu_ptr(priv->send_queue_ptr, cpu) = sq;
> +	}
> +	/* Publish the new CPU->xdpsq map before re-enabling XDP TX */
> +	smp_wmb();
> +}
> +
>   void mlx5e_activate_priv_channels(struct mlx5e_priv *priv)
>   {
>   	mlx5e_build_txq_maps(priv);
>   	mlx5e_activate_channels(priv, &priv->channels);
> +	mlx5e_build_xdpsq_maps(priv);
>   	mlx5e_xdp_tx_enable(priv);
>   
>   	/* dev_watchdog() wants all TX queues to be started when the carrier is
> @@ -6262,8 +6280,14 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
>   	if (!priv->fec_ranges)
>   		goto err_free_channel_stats;
>   
> +	priv->send_queue_ptr = alloc_percpu(struct mlx5e_xdpsq *);
> +	if (!priv->send_queue_ptr)
> +		goto err_free_fec_ranges;
> +
>   	return 0;
>   
> +err_free_fec_ranges:
> +	kfree(priv->fec_ranges);
>   err_free_channel_stats:
>   	kfree(priv->channel_stats);
>   err_free_tx_rates:
> @@ -6290,6 +6314,7 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
>   	if (!priv->mdev)
>   		return;
>   
> +	free_percpu(priv->send_queue_ptr);

keep symmetric to the order in mlx5e_priv_init.

>   	kfree(priv->fec_ranges);
>   	for (i = 0; i < priv->stats_nch; i++)
>   		kvfree(priv->channel_stats[i]);

