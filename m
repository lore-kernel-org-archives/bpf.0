Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988264;
	b=ahlRStQaz58MJhwR+T0/cJr9APTEHHJKEG9WY/RTyKWJ7mVTi19v89WoOjMBypiusSv6
	 aWt2iZ7vh8MPj4V+oPCbsEHbiko7KlQNPkiuEzxzC++GmXV4OZywiLcx12Bi4+PgWKvJP
	 wa7RQ8jKf1CPdEYtYbUGBvbSn0hy0lgaRRh3ySLl5fCB6POYJ9IG4v7Dd77WIP/+ylwud
	 KBwq4qroRQY2XdOyGS2u6mBQMcxMBUrAFszPSnuTIkyFwsRd8NQdjlpUUGAHtcPoMpKup
	 /0M7VnuJKRayoLvzX3zyz8vDnv7rktp1j0B5pP9XYdws5JLx0D7okAbak8lCKyNXlMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988264;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9Gz9IBeSccjjCHOtf0va00995nWsD5fHKwWB7RAq70w=;
	b=AZ2cP0AYW+1mJLTzHWbfKcmsVsjbSyIqIYP1Flz3et6ErVcpKQeCmaWunrXSiRqTmeSv
	 R6uze/DOSKx222AJEn6t+ELftYlyOSMk2c4WHu8BotK/QFsaro3Ihdh6J9ud8tW5hjHvj
	 hsBmdw4ho/hqIw1NasB+8bLqRObCmzXi9z2Wn0sQRzE1kaxA8012Up6IBdOrwPoIYYLHS
	 fOzMit/KPrBiGsUQTGyWgvRjtUTdtKh09WJ4AIXw7A7U2R+wx+ph2cAkmlFpLAHLWa1OM
	 yNJcggiIkahg+eYoOMbhWilf54DkTemYGE9OLb6JONkYx/Zl3q4sGZpF5VVjq2gM+OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EZOl1dB/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A87606A31C;
	Wed, 18 Nov 2026 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZOl1dB/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017641F000CA;
	Wed, 18 Nov 2026 07:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794988263;
	bh=9Gz9IBeSccjjCHOtf0va00995nWsD5fHKwWB7RAq70w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EZOl1dB/r549l0Cjg4hv5vm3frN1mJhwKzcv8N+U0AfAdGRph2GCf+cfu9tPRWU9a
	 +iCkKFQvCFAKu4hmxbhrZ1HBbCOvZn7HvTKwXBL6rJINM1HKL5Lpj1P+5AmplPMrit
	 ndP3VQ6rNSZPsZzMnnGQHEeuQ+wKq26psutOxsBQSkJW4fcb8OeKdBBdUgcYSrDR40
	 rcrTsLIIO9bzklbHVpRok+xnIID2lDMGcagJVlnxq5brnkZPK8NAYnbnaSWx7IIPv7
	 YyXivQtxkN2o03cJUEz5It4N0IMH7IYyAVPbddcS0pHGBvIO6HEqxd6Zt2zEr+X9Ve
	 66RS8xK5egR3g==
Subject:
 Re: [PATCH v2] net: stmmac: Disable checksum insertion for XDP frame TX
From: netdev-bot+sashiko@kernel.org
To: jszhang@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 18 Nov 2026 07:51:02 +0000
Message-ID: <179498826255.3136.11066531883770287407@kernel.org>
In-Reply-To: <20261116134848.4793-1-jszhang@kernel.org>
References: <20261116134848.4793-1-jszhang@kernel.org>
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

- [Medium] The patch hard-codes csum=false in stmmac_xdp_xmit_xdpf()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c).

--

net: stmmac: Disable checksum insertion for XDP frame TX

This commit stops stmmac from requesting hardware checksum insertion for
frames sent through XDP_TX and ndo_xdp_xmit. It does this by passing false
as the csum argument to stmmac_prepare_tx_desc() in stmmac_xdp_xmit_xdpf().
The bugged_jumbo special case is removed because it is no longer needed.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 25894771e9e9f..aa73801119be8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5284,7 +5284,6 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  {
>  	struct skb_shared_info *sinfo = xdp_get_shared_info_from_frame(xdpf);
>  	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
> -	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;

[ ... ]

> @@ -5353,7 +5344,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  		stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, len,
>  					dma_map && frag);
>  		stmmac_set_desc_addr(priv, desc, dma_addr);
> -		stmmac_prepare_tx_desc(priv, desc, !i, len, csum,
> +		stmmac_prepare_tx_desc(priv, desc, !i, len, false,
>  				       priv->descriptor_mode, !!i, last_frame,
>  				       xdp_get_frame_len(xdpf));

[Severity: Medium]
Could this break existing XDP setups that rely on the MAC to fix up
checksums?

Since be8b38a722e6 and 8b278a5b69a2, stmmac_xdp_xmit_xdpf() has asked for
hardware checksum insertion on every XDP_TX and redirected frame. At first
it passed true, and since b1eded580ab2 it has passed:

    !priv->plat->tx_queues_cfg[queue].coe_unsupported

Some XDP programs rewrite L3/L4 headers without updating the checksums,
for example NAT, L4 load balancers that rewrite addresses or ports, and
encapsulation. On COE-capable dwmac queues these have worked because the
hardware recomputed the checksums. With csum hard-coded to false, it looks
like those frames would go out with stale checksums and receivers would
drop them.

The code change itself seems reasonable, given the stmmac_has_ip_ethertype()
limitation and the lack of checksum metadata on XDP frames. The concern is
how the change is labelled.

The commit carries two Fixes: tags pointing at 2021 commits and has no
stable annotation, so it is likely to be picked up for stable backports.
The commit message says the packet is sent "with its checksum fields
unchanged", but it doesn't mention that this changes on-wire behaviour for
existing users.

For comparison, the earlier commit ecf5985006dd ("net: stmmac: Disable
unsolicited checksum insertion for AF_XDP TX") made the same kind of change
on the AF_XDP zero-copy path. That commit included:

    Cc: stable+noautosel@kernel.org # high regression risk

and the note "Applications must supply complete checksums".

Would it make sense to add a similar noautosel annotation here? Should the
commit message also say that XDP programs must now supply complete
checksums?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116134848.4793-1-jszhang%40kernel.org
