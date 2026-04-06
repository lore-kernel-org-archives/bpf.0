Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AC39479B;
	Mon,  6 Apr 2026 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501844; cv=none; b=HbUvF401v2OeaZpGuZDjtQoc696jXTCfuAZSkOJw+SE10ab5wsztjRy+dJqcTW38Q8SqW+Yy85/+WEK/Q94w3KgGFeoIgEKApkAeS0KOekVMr/3g3WeotvkWfesRyhs0LQIJvsRc6HEIE7/2B+VW3MrzcshTRXdf//BW1yi0gfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501844; c=relaxed/simple;
	bh=AOvyHiPthGgSLewLa4aW5PjQwPNHqTguJEpEZSlqRuM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cymeyidikceuvctljVrikyNmnIj2nls+7WBaNfzymm3gM7fLGo1ueNRXIbEIScxq5pS0+cDiPL3iYuf1ED2uWH5dcr9nQaxTkveELVfpnk2mJGWSSkWDdoQE/ik/8LlzSdpIEqWRzbnZCmu+gMoDs4EjXKgTmbNHQnqyCP/uxkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ttT18aPR; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="ttT18aPR"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71A79A588E;
	Mon,  6 Apr 2026 20:57:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775501840; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vV5kf64SP6+k/IU1k5jaGnzVjB3ccwynBTcT9z/NRMw=;
	b=ttT18aPRjBrYsxUVXj6TQFGdPAxcVQs6NmCAuwXWVD+PO53keZwhZdjs/ZFjkESQGZk5GS
	W82h4fMocDIRBpd1ICTNJHImyCsLTtiVhgBTEHdktiHEIaHzJJTdinJajkhXkKNUgN1OmF
	EQA8YPO3EASagUtLrfZnwjBJrnBG4Txnhu/Zq16fLqXb+eZgnfs9JbAERmB8ogCdnGEI25
	4RVoL/gJHil9dLbQcB9Qoo3uFmxRe5OcKyFqHzu4JAmzJc4hfPwDU0QkHY6HPZDOyaiKzZ
	094zgU+Jrj4tnPteh4YE1AhJVe1pBFtKKAkSOFqoKPBe2opqeVn0B3hHl6F8hg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Apr 2026 20:57:19 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>, Simon Horman <horms@kernel.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/7] net: bcmgenet: add basic XDP support
 (PASS/DROP)
In-Reply-To: <20260406083536.839517-4-nb@tipi-net.de>
References: <20260406083536.839517-1-nb@tipi-net.de>
 <20260406083536.839517-4-nb@tipi-net.de>
Message-ID: <f1f65b359dc7d6a2d2bdf05ba8644111@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 6.4.2026 10:35, Nicolai Buchwitz wrote:
> Add XDP program attachment via ndo_bpf and execute XDP programs in the
> RX path. XDP_PASS builds an SKB from the xdp_buff (handling
> xdp_adjust_head/tail), XDP_DROP returns the page to page_pool without
> SKB allocation.

> [...]

> 
>  		/* Set up checksum offload */
>  		if (dev->features & NETIF_F_RXCSUM) {
> -			rx_csum = (__force __be16)(status->rx_csum & 0xffff);
>  			if (rx_csum) {
>  				skb->csum = (__force __wsum)ntohs(rx_csum);
>  				skb->ip_summed = CHECKSUM_COMPLETE;

Sashiko:
Will this cause hardware checksum validation failures if the XDP program
modifies the packet?
The driver saves the hardware checksum before executing the XDP program, 
and
then unconditionally applies CHECKSUM_COMPLETE if XDP_PASS is returned. 
If
the BPF program alters the packet payload or adjusts the headers, the 
saved
hardware checksum will no longer match the new packet contents.
When the networking stack later attempts to validate this checksum, 
won't it
result in a mismatch, causing the packet to be dropped and the stack to 
emit
a hardware checksum failure warning?
Does the driver need to clear the hardware checksum and set 
skb->ip_summed
to CHECKSUM_NONE when an XDP program is present, or otherwise ensure the
checksum is only applied when the packet is unmodified?

Reponse:
CHECKSUM_COMPLETE with a stale HW checksum causes the stack to fall back 
to
software verification, not a silent drop. This is how ice and other XDP 
drivers
handle it as well. Programs that modify packets typically return TX or 
REDIRECT,
not PASS.

> @@ -3744,6 +3810,37 @@ static int bcmgenet_change_carrier(struct 
> net_device *dev, bool new_carrier)
>  	return 0;
>  }

> [...]
