Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129150;
	b=vsfXCKafTBpxxuIfJaVYz4mmQowc3OmLmEATIJCV2JQy3iXTqOYCyiLzUaEWlqOJY8cO
	 CAbaBrX7eNpjnqaGvyIFvTXarmLKmXUMwNP4fWj7blzu3aDXMjYxFRjBAnInZSP875+Y6
	 qNEz/mGiBxTaNJ/SwZEQ++CQCHRD/e8PsKlgT6wMaGlHMJzjbNtHKYhWbLqzX+9WcXRA5
	 uOpsMqCs/B8PvPtwNuqfQXEXpij7TEzuY5ahJfZBlwHL0bfipLFd0q5jwl2ynVbKP1o2s
	 3IEf9Dl046wP3MS+Tl9TXJn9JWk+HH5Nh44x1fkGkOdxGWp/VO0Mk/wgfPzETTcjStA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X33xQ79Q3sAPrSsIWHfJ2vy/Yc9AnxiTMwHndBcciU8=;
	b=LFTByZL0BVTiRcSkGHd6MhQjV6Ro9KJ+/8ncEjaas1wqxO13qyBXds6f/S+8r1HGOgyO
	 xhGNw5dZUu5O23V5xOD9avSpzu/20uQlnLjfMSMRZICJlt4i/3sSURWJU8KFo4hp5IrNC
	 r/Hfp4ge/T63w5p4uUWBoa3NtdSGxhXheKp7P13hI+EceQNgIYyDsJtGCTB17H08waVXY
	 t8XoCpZEWNbd5Y2EtYWucV62uhIrNYdg8McaSTsn0Ifd4RQ0E8orQyoHJyReFdPK0tYAJ
	 V0x3B0XdWKn4T5BPU6KEMElJz51rTbv7Hwuqu/oS6LYfuUgPo8CxSCV6MnUTmT61k5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=valzTcqs;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6797E606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 22:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6797E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=valzTcqs
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5365f9a04c5so4198581cf.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795129149; x=1795733949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X33xQ79Q3sAPrSsIWHfJ2vy/Yc9AnxiTMwHndBcciU8=;
        b=valzTcqsJ7RvV3PWpkJUoMkgKqdtPM37jB3OlNlElSHPhP6jDryhok2z0pR9E4vmcu
         CXIDiAP2AqlUY01qMDokeJcYMtmqcmGASBQ9TBH2ZTL9J7eqe9Y+00nsw7pZxNPYPSCa
         F/RdIME5fSa1+vU/D/b4QfhI8ayHlS2X40eNMme1WGDrXN55ZQ+YVI0961ohw3V0a/Em
         +IJkd1K8aJWfNk+C8Am4np0L5UwYMFxmzhSCgG/gWD2C6HZulWiSbLzUqdaLt6jhLkTt
         aF+dbuyHaM6KC6be0SbRUxVSa6UpwpgTKlaQ8pBGwOHUMT4DgB9ThdjTzdJriBbQtZKo
         9RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795129149; x=1795733949;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X33xQ79Q3sAPrSsIWHfJ2vy/Yc9AnxiTMwHndBcciU8=;
        b=f3TWpVlXeDWcsv6iAHmaj2xYi183efcb1x722LSbk6S6GGkkXAADLkEkKMJPO345Mj
         ycK+R5OfCVlf3CoMwxRQnCAEMwojrpvsXHrmRCu6udmgen2wtN////9Y7xjrIGDEQ9zA
         GJFPAGeodrEpKZvA+MzVSzV5tNfS2lWXPA1CZqYzJqxQiTVP+Y48zf+43t1zm+7/3Amq
         pp0CTu8erw3bMWWSmQq98rWOMlB60UZ1e383TstkhzWk1LNd94SbdtMLUvm33xeolqZS
         04SIknRBlhr62xpaKY9vuPazTRKAz3QrAKE2ur9ogXFlVP9KD0J81KSYPoZExxQDpk5u
         TwkQ==
X-Forwarded-Encrypted: i=1; AL+hErGpWH87Tgt/+mxzahJUVbWsF5VHSPvt2mc0KMFpdhovZogoOOUGmop3pt4Ye4DdQlOT63g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1x0FVMAeUHgzc4hVu48kXJJSL6o9xZ1xE/fdpf0wxjVqC1Yrd
	gaCe+gBynlQbRtIpzxJpYi7lqq6iKMUqEDAMu2SngTeBdjoyADU76mUN
X-Gm-Gg: AYBFou3gzO3V/FeZ3ukz6NvAdpIw+kc40qsX1YoQ6gexnlz+Md3kgo7mtbepdMSMmBO
	5P8t73cf+CxsidOzisRavbswVsglpTNxj5ulWgjQiUd1U3vKtXJoR8Ok62vfjZYQVxDs2LP4RKZ
	QsZGZwFLQA0nyY5YRapXbvD81Rg6CjXhw+AQY4Xy/AIZq8eoX3cZVgMeOBPG69ED7ioZ6Kmf1QK
	9zfPIDevGj7SjQJSQWohr3v2wdJemU6kjWQunFrQQsccX11Tww5FnAbj/ccWrQm71lPQEv+mbDg
	fksXnslPU3fVu+tqsKVuR5Rh/Lg3+JoOa2NYOhdfOc/mexkkmgdCTtj5pmIroCvGKiuJHgBabHO
	Jx5eMDy2v5pPb+c2ofR4zlv3lg4++2khO1fQDtFFbW4YeeEgQTb51CdOJGbUNau70WkhEgbkDET
	N+th/3VXPKYBVprUuGvRal6uYTIdEczP4cwCEYh1tqNuASGPQ+W772sS354HnK+jTWIEftM4S+1
	vfWFhkdw9hpaBMTsxp1FreOKHcQbZ3LObtmt5O522cB4GvaS9+uqgve0fp08jneUOu/DS0cr7fe
	Py2ircvyVXD1U1iRg8njC4Zs7hxQabF2AscBeuax5t0QOfc7bOb2xM9QPWZYJKUT2L+KDiWKvzf
	btU65/iAKYRrYBlzruWE7tjU6MwU9z6CFAMTqSrrsxCwxUdLcO2l0gCOLIGvR7rE=
X-Received: by 2002:ac8:5d08:0:b0:55d:2caf:ae85 with SMTP id d75a77b69052e-55d76a1e921mr25459981cf.18.1795129149061;
        Thu, 19 Nov 2026 14:59:09 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134796329sm10045486d6.2.2026.11.19.14.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 14:59:08 -0800 (PST)
Date: Thu, 19 Nov 2026 17:59:08 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 michael.chan@broadcom.com, 
 manishc@marvell.com, 
 joshwash@google.com, 
 hramamurthy@google.com, 
 tariqt@nvidia.com, 
 saeedm@nvidia.com, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 sdf@fomichev.me, 
 willemb@google.com, 
 przemyslaw.kitszel@intel.com, 
 bpf@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.7756e60d4e06@gmail.com>
In-Reply-To: <20261118232315.3593731-4-kuba@kernel.org>
References: <20261118232315.3593731-1-kuba@kernel.org>
 <20261118232315.3593731-4-kuba@kernel.org>
Subject: Re: [PATCH net-next 3/8] net: state the "XDP excludes HW-GRO" rule in
 the core
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> XDP has to see the frames as the wire delivered them, so HW-GRO must be
> off while a program is attached. Drivers currently open-code that policy,
> and they diverge: mlx5, gve and virtio_net refuse the attach, bnxt and
> qede clear the feature from ndo_fix_features(), and idpf does nothing
> at all and happily runs RSC under XDP.
> 
> Clear HW-GRO in __netdev_update_features(), and make sure XDP setup
> paths refresh the features.
> 
> Take extra care to make sure the disablement actually works, some
> drivers add the feature back in ndo_fix_features, even when removed
> from wanted features (mlx5 does for header-data-split).
> 
> This change also removes the warn-only check dev_disable_gro_hw()
> performed. On mlx5 with tcp-data-split on, attaching a multi-buf
> generic XDP program reached generic_xdp_install(), whose
> dev_disable_gro_hw() cleared wanted_features, recomputed, saw
> mlx5e_fix_features() put NETIF_F_GRO_HW straight back, and splatted:
> 
>   ------------[ cut here ]------------
>   netdevice: eth0: failed to disable GRO_HW!
>   WARNING: net/core/dev.c:1880 at generic_xdp_install+0x135/0x190, CPU#53: ip/667
>   RIP: 0010:generic_xdp_install+0x17a/0x190
>   Call Trace:
>    <TASK>
>    dev_xdp_install+0x2aa/0x380
>    dev_xdp_attach+0x41f/0x460
>    dev_change_xdp_fd+0xbb/0x110
>    do_setlink+0xfb9/0x1030
>    rtnl_newlink+0x9f5/0xaf0
>    rtnetlink_rcv_msg+0x442/0x490
>    netlink_rcv_skb+0x16a/0x1a0
>    netlink_unicast+0x1fc/0x320
>    netlink_sendmsg+0x2d6/0x380
> 
> and then attached anyway, leaving XDP looking at coalesced frames.
> The device also lost the bit from wanted_features for good, so HW-GRO
> never came back after detach - on mlx5 that took header-data split
> with it, and with it devmem and io_uring zero-copy Rx.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../networking/net_cachelines/net_device.rst  |  1 +
>  include/linux/netdevice.h                     |  6 ++
>  net/core/dev.c                                | 97 ++++++++++++++-----
>  3 files changed, 81 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index 7620d3fcb8dc..25cf02a184ec 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -169,6 +169,7 @@ unsigned_long:1                     see_all_hwtstamp_requests
>  unsigned_long:1                     change_proto_down
>  unsigned_long:1                     netns_immutable
>  unsigned_long:1                     fcoe_mtu
> +unsigned_long:1                     xdp_pending
>  unsigned_long:1                     xdp_from_upper
>  struct list_head                    net_notifier_list
>  struct macsec_ops*                  macsec_ops
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0325c6f2a7d1..049538b13e61 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2531,6 +2531,12 @@ struct net_device {
>  	unsigned long		change_proto_down:1;
>  	unsigned long		netns_immutable:1;
>  	unsigned long		fcoe_mtu:1;
> +	/**
> +	 * @xdp_pending: an XDP program is being installed, but is not in
> +	 *	@xdp_state yet. Most users should access it implicitly via
> +	 *	helpers like dev_xdp_prog_count(), rather than directly.
> +	 */
> +	unsigned long		xdp_pending:1;
>  	/**
>  	 * @xdp_from_upper: the program in @xdp_state was installed by an
>  	 *	upper device with netif_xdp_propagate(); it belongs to the
> diff --git a/net/core/dev.c b/net/core/dev.c
> index d88af07aea29..c0bb5eb9fdea 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1901,23 +1901,6 @@ void netif_disable_lro(struct net_device *dev)
>  	}
>  }
>  
> -/**
> - *	dev_disable_gro_hw - disable HW Generic Receive Offload on a device
> - *	@dev: device
> - *
> - *	Disable HW Generic Receive Offload (GRO_HW) on a net device.  Must be
> - *	called under RTNL.  This is needed if Generic XDP is installed on
> - *	the device.
> - */
> -static void dev_disable_gro_hw(struct net_device *dev)
> -{
> -	dev->wanted_features &= ~NETIF_F_GRO_HW;
> -	netdev_update_features(dev);
> -
> -	if (unlikely(dev->features & NETIF_F_GRO_HW))
> -		netdev_WARN(dev, "failed to disable GRO_HW!\n");
> -}
> -
>  const char *netdev_cmd_to_name(enum netdev_cmd cmd)
>  {
>  #define N(val) 						\
> @@ -6652,7 +6635,6 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
>  		} else if (new && !old) {
>  			static_branch_inc(&generic_xdp_needed_key);
>  			netif_disable_lro(dev);
> -			dev_disable_gro_hw(dev);
>  		}
>  		break;
>  
> @@ -10571,7 +10553,7 @@ u8 dev_xdp_prog_count(struct net_device *dev)
>  	for (i = 0; i < __MAX_XDP_MODE; i++)
>  		if (dev->xdp_state[i].prog || dev->xdp_state[i].link)
>  			count++;
> -	return count;
> +	return count ?: !!dev->xdp_pending;
>  }
>  EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
>  
> @@ -10612,6 +10594,32 @@ static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,
>  	dev->xdp_state[mode].prog = prog;
>  }
>  
> +/* Try to clear HW-GRO before the driver reconfigures for XDP.
> + * Driver may add features back in via ndo_fix_features(), due to feature
> + * dependencies. In that case we can't run XDP at all.
> + */
> +static int dev_xdp_clear_rx_agg(struct net_device *dev,
> +				struct netlink_ext_ack *extack)
> +{
> +	if (!(dev->features & NETIF_F_GRO_HW))
> +		return 0;
> +	if (!(dev->hw_features & NETIF_F_GRO_HW)) {
> +		NL_SET_ERR_MSG(extack,
> +			       "unable to disable HW-GRO, fixed on");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	netdev_update_features(dev);
> +
> +	if (dev->features & NETIF_F_GRO_HW) {
> +		NL_SET_ERR_MSG(extack,
> +			       "unable to disable HW-GRO, required by another feature");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
>  int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
>  {
>  	struct bpf_prog *old_prog;
> @@ -10645,11 +10653,17 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
>  				       "unable to propagate XDP to device using memory provider");
>  			return -EBUSY;
>  		}
> +
> +		dev->xdp_pending = 1;
> +
> +		err = dev_xdp_clear_rx_agg(dev, bpf->extack);
> +		if (err)
> +			goto err_clear_pending;
>  	}
>  
>  	err = dev->netdev_ops->ndo_bpf(dev, bpf);
>  	if (err)
> -		return err;
> +		goto err_clear_pending;
>  	if (bpf->prog)
>  		bpf_prog_inc(bpf->prog);
>  
> @@ -10662,11 +10676,22 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
>  	old_prog = dev_xdp_prog(dev, XDP_MODE_DRV);
>  	bpf_prog_change_xdp(old_prog, bpf->prog);
>  	dev_xdp_set_prog(dev, XDP_MODE_DRV, bpf->prog);
> +	dev->xdp_pending = 0;
>  	dev->xdp_from_upper = !!bpf->prog;
> -	if (old_prog)
> +
> +	if (old_prog) {
>  		bpf_prog_put(old_prog);
> +		/* The last program is gone, HW-GRO may be available again */
> +		if (!bpf->prog)
> +			netdev_update_features(dev);
> +	}
>  
>  	return 0;
> +
> +err_clear_pending:
> +	dev->xdp_pending = 0;
> +	netdev_update_features(dev);
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(netif_xdp_propagate);
>  
> @@ -10875,19 +10900,36 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>  			return -EOPNOTSUPP;
>  		}
>  
> +		if (new_prog) {
> +			dev->xdp_pending = 1;
> +			err = dev_xdp_clear_rx_agg(dev, extack);
> +			if (err)
> +				goto err_clear_pending;
> +		}
> +
>  		err = dev_xdp_install(dev, mode, bpf_op, extack, flags, new_prog);
>  		if (err)
> -			return err;
> +			goto err_clear_pending;
>  	}
>  
>  	if (link)
>  		dev_xdp_set_link(dev, mode, link);
>  	else
>  		dev_xdp_set_prog(dev, mode, new_prog);
> -	if (cur_prog)
> +	dev->xdp_pending = 0;
> +	if (cur_prog) {
>  		bpf_prog_put(cur_prog);
> +		/* The last program is gone, HW-GRO may be available again */
> +		if (!new_prog)
> +			netdev_update_features(dev);
> +	}
>  
>  	return 0;
> +
> +err_clear_pending:
> +	dev->xdp_pending = 0;
> +	netdev_update_features(dev);
> +	return err;
>  }
>  
>  static int dev_xdp_attach_link(struct net_device *dev,
> @@ -10913,6 +10955,7 @@ static int dev_xdp_detach_link(struct net_device *dev,
>  	bpf_op = dev_xdp_bpf_op(dev, mode);
>  	WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
>  	dev_xdp_set_link(dev, mode, NULL);
> +	netdev_update_features(dev);
>  	return 0;
>  }
>  
> @@ -11385,6 +11428,14 @@ int __netdev_update_features(struct net_device *dev)
>  
>  	features = netdev_get_wanted_features(dev);
>  
> +	/* GRO_HW may be added back in via ndo_fix_features e.g. if driver needs
> +	 * it to honor the HDS config, clear it before the fix features call.
> +	 */
> +	if ((features & NETIF_F_GRO_HW) && dev_xdp_prog_count(dev)) {
> +		netdev_dbg(dev, "Dropping HW-GRO feature since XDP is attached.\n");
> +		features &= ~NETIF_F_GRO_HW;
> +	}
> +

Apparently drivers can enable HW_GRO in some edge case (that can be
plugged itself?):

    The rule is only enforced at attach time (dev_xdp_clear_rx_agg). Later
    recomputes don't re-check after ndo_fix_features. Example:
      1. Attach a multi-buf XDP program to mlx5 with HDS off. HW-GRO goes off.
      2. Enable tcp-data-split. rings.c:253 only refuses this for
         single-buffer XDP, via dev_xdp_sb_prog_count().
      3. The next feature recompute runs mlx5e_fix_features(), and its
         "Keeping HW-GRO enabled" block (en_main.c:4643) sets GRO_HW again,
         after this strip. HW-GRO is now on with XDP attached.
    This already happens today, but once 5/8 removes mlx5's own XDP check
    the core is the only guard, and it misses this case. Either add a
    post-fix_features check here (warn and strip, or refuse the change), or
    make the HDS-enable path in rings.c refuse while any XDP program is
    attached and the driver ties HDS to HW-GRO.

>  	if (dev->netdev_ops->ndo_fix_features)
>  		features = dev->netdev_ops->ndo_fix_features(dev, features);
>  
> -- 
> 2.56.1
> 


