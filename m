Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C436F419;
	Fri, 20 Mar 2026 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994470; cv=none; b=i4iPn8CQlJSHO1cZz5QVPBRNW3gw8iCk0Wz0pa4qmdIUBh8UWn05IMlJEnyicRvqCeQj+Hkjy4UCIcL5HXl+1f4JxYAR9/qGeVbmqTk0nB1g09OJpmsARbBMVACXWyE4hB+C9P+R4i5gkzchVj6qk5om4bLU4cCnj9hZLjhaAKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994470; c=relaxed/simple;
	bh=wyKmYTYD8pHBBSiKWV79qyIw8bfSgp/cY84djMq9UI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m87kLgDews+gb0HcGP7lH7SVN5uEijsSSvEcu0jqRpC9TlJNvHqTMz4CsyLIzosaxg2+J8AbqGrGZHzVYyzgGeVqFquCPJ8gJTs8OFokQoR0gpa+SUheDr86OZQNwpRRCDwDqJnKT3uWi8dRVs/q9gPhbDksSgiOZakE1OLXqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrI7OwEc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrI7OwEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9677C4CEF7;
	Fri, 20 Mar 2026 08:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773994470;
	bh=wyKmYTYD8pHBBSiKWV79qyIw8bfSgp/cY84djMq9UI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rrI7OwEccWkO3zk8OazNZYH/IQsFPiUYTLFHeYhpUbhLGPhtiX/he+mn3wh5pGV0W
	 rPUgDW71aCyYRPh3rwAqPrKt+ScAO7USJrI1Ejt/+38zMSM3McksCk/U+qR9qCl93m
	 AwvdSs/OQc1R0A4PgTMOn7E8JgLyb7F7rtwjkTubtDNy42ZTkoMSQcb7t9OhlVvYJN
	 1if/dJg5Ar96pSfYkPgzm50w6h+nVNwTC0T0HYhdedxVidFIu2yF8wKRauCsm7PjUP
	 DQqPQcAWLp0MYvmRnqsoo6BzAQoHrRwaEiwZGHFnueEPQlTc/dxDTEwq2jgnS03NGm
	 bZoNcvGF7sqAQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net 2/8] xsk: respect tailroom for ZC setups
In-Reply-To: <20260319175538.479139-3-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-3-maciej.fijalkowski@intel.com>
Date: Fri, 20 Mar 2026 09:14:27 +0100
Message-ID: <874imaq5ng.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Multi-buffer XDP stores information about frags in skb_shared_info that
> sits at the tailroom of a packet. The storage space is reserved via
> xdp_data_hard_end():
>
> 	((xdp)->data_hard_start + (xdp)->frame_sz -	\
> 	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
>
> and then we refer to it via macro below:
>
> static inline struct skb_shared_info *
> xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
> {
>         return (struct skb_shared_info *)xdp_data_hard_end(xdp);
> }
>
> Currently we do not respect this tailroom space in multi-buffer AF_XDP
> ZC scenario. To address this, introduce xsk_pool_get_tailroom() and use
> it within xsk_pool_get_rx_frame_size() which is used in ZC drivers to
> configure length of HW Rx buffer.
>
> xsk_pool_get_tailroom() is only reserving necessary space when pool is
> zc and underlying netdev supports zc multi-buffer. Rely on pool->dev
> state when configuring tailroom. xsk_pool_get_rx_frame_size() inside
> ndo_bpf is usually called when bringing up queues and before xsk's dma
> mappings have been configured, which makes it valid to rely on
> pool->dev.
>
> Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
