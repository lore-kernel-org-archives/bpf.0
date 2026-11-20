Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212784;
	b=fBldAxmTfsfOXm6Tyj+3qmrlTxUDfCDmlsLrRD9K1ikt+/tAR0zpZMgj8ALwejCQWMtq
	 cCf0Oqls8qAE3425gvgE1iZNx5crCyVCWIGEWZKNQISI5v0dyjWslBd2HBuu7yKm0BNPI
	 ByTh5vVUTwTBiIerInjMzdJxoSHpBEGVvoaJbdhAhwI4lQ3nTWnZYUEBKw9mrVCvlf0sY
	 ngl6p+zW7U2QXzBStrCoK9sb9faBhmYvtMLeE3dJods3a+jIlfX579By85BiNLMUFIbXo
	 w3UrBAKr/2J049i07+mpyU5aqd2uy0BNTbyrd7Eh0hkuv75d6yHLzv06ulQb8rrDs0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212784;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RAg6Mpdcvh/+KxfIFzt5il4MRvFCLhL1yfr5pd9t0uU=;
	b=AZnEmzV5UUH6tEwTqW+ZsD3B/YHXJeJr5qGs0NwuExlr1kPs+sn/ollNsmm7PETv0yNv
	 0Eaflxbohfl9LKaYBpPNvQT8cCufRN5dCeANnEtQf/l8WQ1+AwuKf2sk/Pu40eAKdKxRp
	 PBr2g0qK5xWRRm7B+p2kI5hclnQnZoAoMFYEMlZBCX7azSZRmvYEdA4FZIfgJFjk2iU7c
	 2xkbvh3KqDaeNGxTEv94olEAUMp5VXX3MwSrpZEFlIws19T/Sl1sbCSqcDr0osJ+HNa8B
	 VP9ZAwRlkgXqvmHyPdlL1IpdXKcxr+91v/KxNcCmft8jQE7T5baqsFxrs5CQdh/flhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbGS0YAn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3E606A68E;
	Fri, 20 Nov 2026 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbGS0YAn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AD41F000C4;
	Fri, 20 Nov 2026 22:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795212784;
	bh=RAg6Mpdcvh/+KxfIFzt5il4MRvFCLhL1yfr5pd9t0uU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bbGS0YAnzWyC9pNnjeqTIN4We0y2jDbCIvxCiwfv1iPgiLdN0KneN/C9T1GT1w6Xn
	 25Ug2RfndDjIeKLkSxH/HLc2ZICbcKv3pJYODnW3L7ikp9NoyF8yfpGJYq0QtfG53w
	 y8lI9GmkbaOX0EiwXfC4/lUL4m/+VkEDHireXy+2MADHTQYdR51UL2RdI1VHC2FH95
	 vRd4ScRbSo4zZPfJNrl9ibYOyR2LR6J3VV2sIkVdjudnv3xPFe3yiLHfr2XC1t4xrv
	 gLDSPj32vVoA5CRKEhG3WsX8LPjaCosUG6er0vb7/If7gOIAUysx7V1L5tFSmV75Hq
	 bf5A23hfp0XUw==
Date: Fri, 20 Nov 2026 14:13:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 3/8] net: state the "XDP excludes HW-GRO" rule
 in the core
Message-ID: <20261120141302.5bb2b7ae@kernel.org>
In-Reply-To: <willemdebruijn.kernel.7756e60d4e06@gmail.com>
References: <20261118232315.3593731-1-kuba@kernel.org>
	<20261118232315.3593731-4-kuba@kernel.org>
	<willemdebruijn.kernel.7756e60d4e06@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Nov 2026 17:59:08 -0500 Willem de Bruijn wrote:
> Apparently drivers can enable HW_GRO in some edge case (that can be
> plugged itself?):
> 
>     The rule is only enforced at attach time (dev_xdp_clear_rx_agg). Later
>     recomputes don't re-check after ndo_fix_features. Example:
>       1. Attach a multi-buf XDP program to mlx5 with HDS off. HW-GRO goes off.
>       2. Enable tcp-data-split. rings.c:253 only refuses this for
>          single-buffer XDP, via dev_xdp_sb_prog_count().
>       3. The next feature recompute runs mlx5e_fix_features(), and its
>          "Keeping HW-GRO enabled" block (en_main.c:4643) sets GRO_HW again,
>          after this strip. HW-GRO is now on with XDP attached.
>     This already happens today, but once 5/8 removes mlx5's own XDP check
>     the core is the only guard, and it misses this case. Either add a
>     post-fix_features check here (warn and strip, or refuse the change), or
>     make the HDS-enable path in rings.c refuse while any XDP program is
>     attached and the driver ties HDS to HW-GRO.

Enabling of HDS can't happen in the sequence you describe, driver
checks:

static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv, 
...
        if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&                 
            !(dev->features & NETIF_F_GRO_HW)) {    

and with XDP attached GRO_HW is not in features (only wanted_features)

Thanks for the reviews, I'll spin v2 before EOD
