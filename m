Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208886;
	b=W04u6M0m1Hv27DdfO1UMaL8zFym7BRQk/+2//jF0Tr+fel+h9hMI/OTq2V2y+9A6C2Wg
	 WHlxDpL3ktJC2zFoxMTEBaXzsGANcsJoUpVhQD13pPrgDNyYNYQ1rdlQP4dH5/lWImhL/
	 kNi86DnzyJ8+epMEnszff/lgiYplcdTqk3ZIZljEGE6SCGyNx9bzKyMTVXV1PIDPFZVu3
	 uTSnqpyzv72f3PXLu0UNc0s64se6JY7le0+jXiFXB8/7L40f7qujOCCl0oWehyFifZ6r5
	 BbQz/vy9qA5lg/EGaOTuFci8axBNRrBF33Yb1CoVtwjWE9hB7PhZLFvncfe4l0rpT7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=neK5tVmH8BJN6Iaz3+r0fZXi0ughyglHJUA1SeN9g+0=;
	b=ciVsEpWBj0MNE2bAZXhDNu0TPFker9w1XyNBsZta11aOZEoOAJqnxuNzJl0nbEZrrOqP
	 YPfYVeymIMWvRuQobYhUmhwrJTSycJTE8w83TkgpQbrMUsPZk9Xy8EhxFPclJbpfSPFBA
	 Qm4UPxjFR5MjF2TkULwJNkrR4a9jMLUz3I7stanE00qFsCWhAeVVuBem76usxeSBsoeZI
	 /OxtshsDyJuGMhC4H072e6M0cPtblfMMcf+9qHKpxZFUuS+4yqnE3KeXRuoJDSEBzHquO
	 wgafMHSNiTS9VdVyyyNOHUUl6h5Lnd5u0by13rsZsUltlr+LrGnjoi0y5I4aJCPV+8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IcBAz/Tq";
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC455606A321
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 17:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC455606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IcBAz/Tq
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso727550a12.2
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793208885; x=1793813685; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=neK5tVmH8BJN6Iaz3+r0fZXi0ughyglHJUA1SeN9g+0=;
        b=IcBAz/TquQVqZ2oOB72uUSGmRjQN9MLnoiMyqRSAvhZEQLTmITo3ZcJFBIBpBjrtum
         CZLHlBF0I25fGpD7uDTM/OrLAXW1rOgesr59MfgfEr7vA3Y0B6wT7WJ+wHZ32r9X43Nd
         05Gk67L5MQY4a2ijzAXTMT4SFQkiTbNZOrtXPk9TrNkKQhs0pTizDssbHAMriXwp8hGJ
         eHz0Ej1DtE8scFKVD+K/XA4n76S19tExhKLAaLdrc672kUi4eW4hPpL/TWn/vY33e/LR
         KOEjMvdHb6k3+w3PzeGnv9yB48eRekekgRn1MI7lp3guuENZq7ZuQi5XGR7WhDucUENi
         e6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208885; x=1793813685;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=neK5tVmH8BJN6Iaz3+r0fZXi0ughyglHJUA1SeN9g+0=;
        b=LvpsH+LixseDjty0C3B58XvI7zHSPsqMm0IiUOF2S/y4DY1x0c8jDuYKlNm9N5ORBi
         4OPpis8hxdjCEU+E/2r4ecNK9h1M/9Tvw0P9+JSVvWAtiXylLa17eFNv6ujXwxTfBFvZ
         LY+YiGuAmqvjDwgEfMpC2RSAFXI8U68ikxpgL5hVA4g5ixdXxO1OI81cK6gAlpIOqKGM
         YRPjiUSBlXPTdWswRYlY09GHQhIemyWPU+gxHmxfUK90/jgOoNvETR7jOadxYhdrFOMx
         DR0Ej/njTNQOh86+426T9dGa5dJLEHY87E/AOcCUXf/s2IVzf3hhFSnJzAkURsmSTc4p
         iQkA==
X-Forwarded-Encrypted: i=1; AKwUvByqYtRCYTn0LBMHtOt7uF560QeBiwOmXMG5sutPyFNXrWddHIMQayBDulYtCyk0cQFoswg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ84MSdr9CyCvkMxBapwGjqRVDw3hbbmmzFgjSm77hcSNcWUR5p
	wenwWyZHUNJvhXsRIO92K8LCTasmGk/poPe65nu9s8YxTDEcBbwlr9vq
X-Gm-Gg: AYBFou0Tq/VoBD10N+VI4sw8mZ+mQEvzyGBDJX4ZVZienowB2f21xcmKf430Li1FVJP
	P7fdpz9kILkfs+gNOwsx5APWWjO2B7Wy0N5V5vFOlTaJGN5AGqiS1+LFuLXjaN6UX4DX82MStAx
	3N1Id0hDgk5XIqwhlY423h3razX2dz56FNCyM8WajT+LgMOSeWpkgdjkpHCVCG6+sRsokyoAmEB
	nKMPUG4q6ba/GNL2ynh7uHyDKj6D6Tu+V25o2M09eT3L2zyxwAVC72lluUMQc8zOTy7kJpxp/S5
	QOLD8UvQ5qVSX8YYwE5b+h5V4KYLA7/XSpO90lY18Ni07oaxiU75SymMdlcF0WCO/KbNPgegaYN
	9dfDZ1EFYEpTI3WMcJWC188du+jkd636vHmbagJQbDM9Z0s98PqXOEBYAyUFA9kfCRezITrvAuo
	F8/D2LFqiDnmNGDQKiRj02t5L4rAyUgFyTlkVLJ8j6d5rGJLfi/fdP+KI2T5jUV5lu/6HB6MoBw
	ojPlgufj3rJbXIXTdjChriiMUuG4L1peo8pbyCmEqnhcKtg1w4dYFwMPowgPNh/kqXHW0hEXO3o
	nLji/OmbTz0Gyk2H/hRfGTv/Gq8709eie3GiLo6zd5YZlBev2OkeMoEXp6mWgJQkOKpiw18oM/k
	gfsSinjcviWOjadmwGbnxTBqexT4M8VA5uOu3c1KMd7wlT+n11y8Q6U4=
X-Received: by 2002:a05:6a20:918e:b0:3e2:99ef:ae90 with SMTP id adf61e73a8af0-3e90241ebe0mr2592968637.53.1793208884997;
        Wed, 28 Oct 2026 10:34:44 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc212f9sm4521917a12.9.2026.10.28.10.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:34:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 17:34:44 +0000
Message-Id: <DMGNHWT5M153.3C6CZBKTPNBAY@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eric Dumazet" <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>
Cc: "Willem de Bruijn" <willemb@google.com>, "Simon Horman"
 <horms@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "Aaron Conole" <aconole@redhat.com>,
 "Eelco Chaudron" <echaudro@redhat.com>, "Ilya Maximets"
 <i.maximets@ovn.org>, "Jamal Hadi Salim" <jhs@mojatatu.com>, "Jiri Pirko"
 <jiri@resnulli.us>, <dev@openvswitch.org>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>, "Ren Wei" <weir@nebusec.ai>
Subject: Re: [PATCH net v2 0/5] net: fix eth_type_trans() crashes on skbs
 coming from the stack
In-Reply-To: <20261028122703.2093730-1-edumazet@kernel.org>
References: <20261028122703.2093730-1-edumazet@kernel.org>
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

On Wed, Oct 28, 2026 at 05:26 AM Eric Dumazet <edumazet@kernel.org> wrote:
> Other eth_type_trans() users already pull the header or never see
> such skbs:

netkit_xmit() has the same problem, I think.
It calls eth_skb_pull_mac() directly, not eth_type_trans().
It pulls ETH_HLEN before netkit_run(). The prog can shrink the linear
part after that:

  AF_PACKET SOCK_RAW on nk0          eth (ETH_P_IP) / eth / 8192 bytes
  tc egress on nk0
    vlan pop_eth                     skb_headlen() == 0
                                     skb_mac_header_len() == 0
  netkit_xmit()
    pskb_may_pull(skb, ETH_HLEN)     skb_headlen() == 14
    netkit_run()
      bpf_skb_adjust_room(skb, -1, BPF_ADJ_ROOM_MAC, 0)
        bpf_skb_generic_pop()        off == 0, skb_headlen() == 13
    eth_skb_pull_mac()               BUG() in __skb_pull()

It's an old bug and it doesn't block this series.
It can be a follow up.

Something like this (compile tested only):

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 82e608e..f093103 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -116,6 +116,9 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 	switch (ret) {
 	case NETKIT_NEXT:
 	case NETKIT_PASS:
+		/* The prog may have shrunk the linear part */
+		if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
+			goto drop;
 		eth_skb_pull_mac(skb);
 		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 		if (likely(__netif_rx(skb) == NET_RX_SUCCESS)) {

For the series:
Acked-by: Alexei Starovoitov <ast@kernel.org>
