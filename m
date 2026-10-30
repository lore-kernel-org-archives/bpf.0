Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336052;
	b=cGzouxRy/R9ljDVlPMwSt/vLOdw02qGlDAAfcjvCJ+XbVo3aU17EO3OcNukJJe3Hj8Pp
	 0ga7emZqG7JYu8Zze4W++LLw8UlFdIV4aedFOxkZOdPM2Afws5YDmcsBEP2I/4YvY78GO
	 NJOB75qMo6RLmPPAnfxlj18jZM82u11DuMo9Q0IV1BJw+WpUqkNrUjTQirrwyCUePTiET
	 MCbAAMK1aQ+YxepuQnWiuSEI0Y6FqJLFpZAme3ZRuYFtzcos/zNOWi1PB7m7nG3XAhCZw
	 7qny91CZywPN4S9lurM5Px69KTpjWtrJAScZHF/acRsIhgi3Fv3bqJQXgMKJDQIY2YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336052;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TbGHKFPPLo2wQPCmojJuICMylpn/j7mUUAS4fY43dqA=;
	b=uZvdv0OluqxBioj6Y521GBsfH6L7NPwJzbMQYEWisSbeKFyAUspzpTIRrtxruLbKqqXI
	 X4eWEMVW7w/zneA1pidzAHSLrYPe79sjfmPHeJEvnmZZx/HDDWiK+6zRRT7Pj8ddl+6Hv
	 I1G60szywKaGhjXDxSQQD8V4QFV380/lQy+XfnfoPDKAwaa/d2NyOZ6wwOiqDyUsz0wkm
	 U2cDIvv2gZsPTT/q7p3/wdwPavkQ6nlFEzJxw2x/YxR5X2GYHrDlCnCG59VnWnTwJ/Z4P
	 +yvMytN0oyoS9raIZf0QLX/vkhR1L2sG8L0Ar3GR3+c8yyD8b1zlRcc4tVjzS3Ym0Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3lr+5PY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C0606A31E
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3lr+5PY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A294E1F00A02;
	Fri, 30 Oct 2026 04:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336051;
	bh=TbGHKFPPLo2wQPCmojJuICMylpn/j7mUUAS4fY43dqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B3lr+5PYIJOPMgRqWH46+55/QBWflLNHADCWGiAqQ/qgt113rGWznx693kgIPe+kn
	 slFlBel1HOcMbr5Pizh0bnomI2egOmp37P9XnSmIK6vs+K0xl+yxtel0raMHMe9JDT
	 dbJvNpH7CEXqDkqWVjP53v6N7oKgF2vIzmvMFnIacw+xfkTh6KUm5+iDn68BVw9Wn2
	 SaMzT9t1hiwC1VO7y59RUr8Mw2gQ8cxBAi/+AXnV2NBPRVohIM98F6HLKTAghfqkhj
	 wTUfnIL90FRBiu6F8KL/xPYH87TxCsanWIVZ7a6+LMzS6bOyhdP/zo3SAbKKr7R5F+
	 O6cPGuRpTd7EQ==
Message-ID: <sashiko-outbox-190419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 4/4] veth: use generic skb XDP handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260509084858.773921-5-maciej.fijalkowski@intel.com>
References: <20260509084858.773921-5-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:11 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing statistic accounting for skb-backed XDP_TX failures.
--

commit 3f79161429d884ed3854644cf3a7b111ce3c40fa
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

veth: use generic skb XDP handling

This commit transitions veth to use the generic skb XDP helper for skb-back=
ed
packets. It routes XDP_REDIRECT and XDP_TX through the generic paths while
retaining the existing veth xdp_frame path for packets arriving as frames.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -808,94 +764,33 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth=
_rq *rq,
>  		goto out;
>  	}
> =20
> +	ret =3D __do_xdp_generic(xdp_prog, &skb, &ctx);
> +	switch (ctx.act) {
>  	case XDP_PASS:
>  		break;
>  	case XDP_TX:
> +		if (!ctx.err)
> +			stats->xdp_skb_tx++;

Should there be an else branch here to increment stats->xdp_tx_err?

It looks like if the generic XDP_TX fails and ctx.err is non-zero, the
failure is not recorded in the local stats structure.

[ ... ]

> @@ -947,7 +842,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budge=
t,
> =20
>  	u64_stats_update_begin(&rq->stats.syncp);
>  	rq->stats.vs.xdp_redirect +=3D stats->xdp_redirect;
> +	rq->stats.vs.xdp_tx +=3D stats->xdp_skb_tx;
>  	rq->stats.vs.xdp_bytes +=3D stats->xdp_bytes;
> +	rq->stats.vs.xdp_tx_err +=3D stats->xdp_tx_err;

This aggregation was added to collect the errors, but since stats->xdp_tx_e=
rr
is never incremented in veth_xdp_rcv_skb(), are the skb-backed XDP_TX errors
entirely missing from veth's private ethtool statistics?

If the local increment was intentionally omitted to prevent double-counting=
 in
the global dev_core_stats->tx_dropped (which generic_xdp_tx() increments),
does adding this aggregation line leave the ethtool stats inconsistent by
only tracking xdp_frame drops?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509084858.7739=
21-1-maciej.fijalkowski@intel.com?part=3D4
