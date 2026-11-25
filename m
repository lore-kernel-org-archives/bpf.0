Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633013;
	b=e2CLFq0oMwsCVRtaepg1+tSIZtBmm2lGWuBsI2Pc+OA1AO2q7t+3TsNXPaaLFkwFJBbP
	 Rp9K4S7i95HFwfSjSWAm7ytao5Cn/tBdoanwfTKN/Z2aeYXfyISoXWvjZXNkmtCeq9LOO
	 onUkRmtrE8UZvJh7iB+MghPAyLtuUHjrxS6obGDjacYeWLmCi+fuDIU2aMucSVt0cVl4t
	 R+mq4lmU+lzgJGdS6OvkmkWWQced/iw12bSevfPa6+WgiZJrUgOQfrEb6oADnTkgf1BSi
	 WE+ZaJIJZCgxaQozfqHVq7ZnjAVb2zlCV3vBCXzsyxcy2wBqS6E4+g07D7BPjHM+5XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=x2h3D7iH3Wc1HTtPjxPO82bLSMmVOqCjIHCRJWs8yZY=;
	b=0zm+BH8E7a+EgB0zssj12VZ+GzFUtRO7CjP29D8aBSLCC+ugNYBm2FzfmJO/bpmZbhwt
	 oN4KMdOPMZlW7EEMGOFe/hgDryoIi9ROnGIDSNdZossoqF4rPmciAu1WUuc6ANGMvftbI
	 O3Q5e3O4mHnm87JAsMJaQnNgS9drXtD5/rvxwl4Lppq1cHihDJ+SSEwDVxKz0voPJ/PGs
	 BNGgEItc4/gOYFT+UM3moziFFBohBmaOCC7aLDHCyLsCaaSqtjOnQNn0kQzRFBh0XIJgK
	 3bvTdly3BkKG9q9TEKLf8hPFz8GxnKpFzEFvseHVEZjxu1e40DdlOSFw1A9LukGTjrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=b5Wmhyhn;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C133606A326
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 18:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C133606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=b5Wmhyhn
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f0426a65e0so38997725ad.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1795633012; x=1796237812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x2h3D7iH3Wc1HTtPjxPO82bLSMmVOqCjIHCRJWs8yZY=;
        b=b5WmhyhnSs8usJCaJ7KbKAhmll/C/7YWMVAQRARG7p5UNbK6itmqgFoatTQX5p/Iq1
         KoAKn3SnqD2uIElQ6be6THf6gL4V+4jboRwBsLXWZY7YTMHd5KX7QXBzlkfuOyVRAi55
         1H0GMMVtlzh2jMYKU3X2WTWt7moR122iHeUE4tBA2NvhhmNnjeQ3e4YIaLfgxgC25P2u
         rC8O/JJZYsmAYoUJ2fo61Puyx1KbesMy+A7Vf1f6OMwfWeD0IcnO45eS5/C7etAWUGRn
         g/RmSddNhVJcPjfNwVYs2jc7RG/tw3ph+62jKnCom0D/aSe9jEnzFmF/fHlGyQdanihT
         2cKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795633012; x=1796237812;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x2h3D7iH3Wc1HTtPjxPO82bLSMmVOqCjIHCRJWs8yZY=;
        b=BqKhcud5INe/ufAVehXinurntR1jgPju9avos4GacI7ViyDlk03KhkJGek7wruCCYo
         6mfz4KSunSHNyOKoAqtbuXSfC6F3GbWlHoaM19mTmfUJpnQXCl1t/qDHkVba2Ms+HiFP
         97lyZolVxuubeA3bXZY7x9emIhtbN/ceJivRvFYHsMfTu/aJTR2EmhvsvTBUg2TRPL5L
         Y1kgvBFsjxtTJR7STuZP51R4t9GF2QqihxLuYxpuJ8QRElYlA6gcYlwajp96tS4Mm/jD
         5fVOUpG1gO3AJmcBLb396hvI9Z1pdGSNtAVWZNVIagTLzRgk7QOrgxNTsj3OTwKEXfKX
         H8Cg==
X-Forwarded-Encrypted: i=1; AL+hErEYSjLJD3qSKbpf2yHidYdaiDcTJYhpeWhxhTIH+wQXDdvSfhpk1wI5YEv7+iOF7AgeXLY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4eASQq23RcskYtSSoEcaRgqaunecsOZmw6M5Y1+XzDtFay0fK
	3LQkRWZTtpFTCNxXCn5nSo53IeFFivFnWVZI6KjmE7zbm57xGL9B9swIK6buaIxWXrU=
X-Gm-Gg: AZFdTZekIy5IJ/jnyQR4pWyDHijhKqnj8BFe4wMhKRQyzzxERJvrUrZ7S0X1yuuPo4I
	eHbZAt5UJZmBIj4wWzj5QC6TstqqoNtvSyD/V6LUEdF/DCPI0eYsFqQmj8CwIgbAnMcEak3DnwZ
	iuDmiDjN5/PoZXq6w+HM5m/5o4V4ns2NFLgqvG5ngVIQ5aZBRVEWomQWrheI9U8uw+VYaHKYjxQ
	G4hMDczVcVirnfKy7AWHqJIaFiYYdnBsBnAXjGsJUGexbmHk6ebtddlj5NAhyEccYsK9z/8o0JT
	LMyXeMi27/BbS7zZthVxjbcZLpzJwXqywQiduIVpmpxlza7OZC4QJybHLPtbxMTpXsihEgZtdEm
	wJUioY4QUX406+eEj+VwdVuk/3dNenxVs/+cUGjxrLym5EqG5uSOiw6KsfpxD/JoEbCSxcMt28K
	Xh+DyVvUnNcLkrU9EIwuzYhLaKzxkrYZgu1cFg0xdcMHn3vmW+3DJA5JZjkwmLMgGUJjDs6Ettz
	jzxZLqLcdUEqdSqgrkyVo2h+Te0KqApA7UH8s6ZRFBBr0l0LypGdwM9RPIX+jX4ObnFuIryVUT9
	WtKvujLTSMytyqLpogol0Ia1lTQT0IQaLCW2dqGTWm2vbZJ/hbCN88FOE8DHQkQ=
X-Received: by 2002:a17:902:ce0a:b0:2f0:dc93:78a4 with SMTP id d9443c01a7336-2f0dc937b50mr22557595ad.26.1795633012514;
        Wed, 25 Nov 2026 10:56:52 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d05782asm9137503a12.24.2026.11.25.10.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:56:50 -0800 (PST)
Date: Wed, 25 Nov 2026 10:56:49 -0800
From: Joe Damato <joe@dama.to>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jordan Rhee <jordanrhee@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Matt Olson <maolson@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Debarghya Kundu <debarghyak@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Eddie Phillips <eddiephillips@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] gve: add rx_critical_low_bufs ethtool statistic
Message-ID: <awcvcbCfQDQFrv/1@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jordan Rhee <jordanrhee@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Matt Olson <maolson@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Debarghya Kundu <debarghyak@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Eddie Phillips <eddiephillips@google.com>, bpf@vger.kernel.org
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124223009.331936-1-joshwash@google.com>

On Tue, Nov 24, 2026 at 02:30:09PM -0800, Joshua Washington wrote:
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
> ---
>  drivers/net/ethernet/google/gve/gve.h         |  1 +
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 17 ++++++++++++++---
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  3 +++
>  3 files changed, 18 insertions(+), 3 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
