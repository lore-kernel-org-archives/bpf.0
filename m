Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700317;
	b=GKiba8PdFtC7qIWcnXmSRZi2115WxvGshxGWWtbx4mwJ+643V874aDuspW6GuQ+Sk9HP
	 ICiHeCG07/woO61jSgDd2tut3CyX5OWKUzzPkG1l8CZ2s2vECWlBuPj1PUn2BNrnrOfpa
	 s7AOml6+qIbJFHDjwRpM7aKQsULtcCTZfR96eTyAH55H0AV81vZqURV/+ePWuSfETdrLZ
	 VmKFW7qS+XpH6TSYGkjklXDsi8ZViL6b43RBN81dR1k+nHm3UYLEemn/HV5NHmQguKMQg
	 J4VThnjirHQc0Bh7tj3C6CeuALIiJ3vcN/zJyD5C/5LFUCjYmGFz11rDSKc3z3cbSDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700317;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qQrr9y2I0bNcQrfmAeXPg8Gy2tG0WPovQbWAmNnjtu8=;
	b=2LyJ6cYW3EJjrGAOdpaOm2m9E6nrj6qXFiLLGOvk52tbGvOR4HAIuhb5BQff5cpHopvT
	 oQmnGLvk6HIpXMnDEUymnRc3wzKuCLX62GBQ1Hj/J5WIqgUHYI+Bnf1ttiP/8qwQ+WROW
	 NDRarrwPw8zpunf2+dzguPlJ7CH8QHbBGlw+Meo7TP9gTVugkQ59L1egfeVm8K2+k2OVW
	 1t/TE7KM5/5p+2XPBjJbp5i/ojN0KB+R07HQXpfqTsPbSMs32rENq8EscLUMmbDGETMW+
	 xz7HUncqsnqpqqHOvtUK/tgtrQ2xbne/5Myc5hxWCh46BrkzBWDn4ljJbKVlV6sg4mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=2rdWzGrw;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04E606A31C;
	Thu, 26 Nov 2026 13:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B04E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=2rdWzGrw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1795700315; x=1827236315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uamR+XtNDrZ+BZBTB8l3qlGov1ZvPD9fndhuTr59J54=;
  b=2rdWzGrwI4flagourNTRsw3OM0pGcX0irKxflpSqlSzH7lvh0OwQ0IL/
   6VO8B+dQU3tA9n880R+NBqlXZgN44YDWkTRE6tgV/ebHuUGpSvY9om5GN
   HhpehYGUuDzKHOzCnrkDFQvFvHkTXiQ8dEbgyu4nMWrgr/jprfL6Z6oem
   QCrgsLPM9+52MQjhTAOPdVmGHnkMnraqOA7P5oLPWWdL5kW0ni89ivF2S
   M8m9C5OpAVv06h0N9vqxqIBAD/ZnYSKw7o1yHSNL2TLRfXDPpBJZzkW9W
   Gmmv9DClTS2cPyaY6ls9yD5KZ80Z2KRxHbNMmQR+Tn9nXTG827+FwO1h4
   g==;
X-CSE-ConnectionGUID: kacgNhkkQeOSMY0vtEYWyA==
X-CSE-MsgGUID: ZsKu4SUgQze0XSjmfW4oyA==
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="234131865"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Nov 2026 06:38:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 26 Nov 2026 06:38:34 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 26 Nov 2026 06:38:31 -0700
Date: Thu, 26 Nov 2026 14:38:30 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Joshua Washington <joshwash@google.com>
CC: <netdev@vger.kernel.org>, Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn
	<willemb@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Matt
 Olson <maolson@google.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Debarghya Kundu <debarghyak@google.com>, Ankit Garg <nktgrg@google.com>,
	Eddie Phillips <eddiephillips@google.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] gve: add rx_critical_low_bufs ethtool statistic
Message-ID: <20261126133830.v2tn6uieltosgq2l@DEN-DL-M70577.microsemi.net>
References: <20261124223009.331936-1-joshwash@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261124223009.331936-1-joshwash@google.com>

> From: Eddie Phillips <eddiephillips@google.com>
> 
> Commit b65352a1bac6 ("gve: fix Rx queue stall on alloc failure") added a
> starvation recovery timer to the DQO Rx path to prevent permanent queue
> stalls under severe memory pressure.
> 
> Existing allocation failure counters (such as rx_buf_alloc_fail and
> netdev queue alloc_fail) count every individual failed buffer allocation
> and do not distinguish transient, recoverable failures from severe
> buffer exhaustion where fewer than GVE_RX_BUF_THRESH_DQO (32) buffers
> remain available to hardware and starvation recovery is required.
> 
> Add a new "rx_critical_low_bufs" ethtool statistic for the DQO Rx path
> in gve_rx_post_buffers_dqo(). The counter increments on each refill
> attempt that leaves fewer than GVE_RX_BUF_THRESH_DQO buffers available
> to hardware and arms or reschedules the starvation recovery timer via
> mod_timer(). It is exposed both per-queue (rx_critical_low_bufs[%u]) and
> as an interface-wide aggregate (rx_critical_low_bufs).
> 
> Signed-off-by: Eddie Phillips <eddiephillips@google.com>
> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
