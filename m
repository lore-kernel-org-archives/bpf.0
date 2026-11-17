Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794939378;
	b=dLq2DSVcuC4k36EgpXkRqwNrBn1ZlgkgEJK5rlL16PlXj9sNDO7XB/PDgNCKCjjFaPqZ
	 Vco59T0ziWz63jGGA5UBXZ2KULz7Aot/g7JLdLjohrj1lZUycX+C177TpequJD/0GKgxj
	 8qSAwREkKE5nKov5x52LVFqH42lOi0GF9kZImZNnt8XyJX3hrdOmMNXl4OTufZek1byA8
	 MumgFZHdTosj3yNLhoARb7Vjmsi6Pgc9iJhZf/0cD9HfRfrx5A0WxLqbB4P+Krmd9Ymbv
	 eqcbEOhzl5GRBkZ4JBUMiYi/E0HzM/MWd3kykABvr+KTHuzJev7FpI+cLXgvU412eQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=G3F1D5a6ZABD/Ct6UJJ0a/xHnccDHKfohgnWBX8JTZo=;
	b=o1zCLyCLvQJ/bs2CSMz7G37YsR0zOGAFLbZmm5bvbNXh2cy03/KNusMgF5/upRg5OqvT
	 qP9Jpk0aqM9aTzI03rF4qeJnzJdcC2dO0C0IYhKAFPDGWikK9nur1dEUlj9k1NEtgSROu
	 UGCyxEfpuY5dY/Jhu7Vjoyy7Z9QmhwpOwsTZNeRase1PnDbmDMu4D8tgSKPBApqM9vPc9
	 eG4MDH9SuGNro60gFcWXiOt7557SR7lEG32OnjNALHr2CSo0krNbng93+ANNi5B15xv83
	 LDXmWM7K/LQyRYW4U+mG2QsYrU1pKGSDjFLnXFrDlrDRlKm/KfaGxOdOUw8fLJUAnPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=FqQ862oe;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8193606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 18:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8193606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=FqQ862oe
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b876afbb86so175243a12.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794939376; x=1795544176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G3F1D5a6ZABD/Ct6UJJ0a/xHnccDHKfohgnWBX8JTZo=;
        b=FqQ862oetmz1K12bF74clKD6N1+dPa/uE3WY/3hPfxyjvk19FalxbBVFypbiwog2Vr
         c4T+iwR8gTiPjsGK2SFczq+LS+oSAX4/8jCqj1GOut8VR2FHRFQ9z+VZCfDPl9Ks7oh+
         P2n5gsl4OpTBPGuhQyUoyMpmpfh5kO2SdRzRcDeUoxHpY96ie5sh4erhAuBm4HRVlaKX
         UedtR6XkOXX6CjXIyHql0Qe+/6HO7dPw02CjdIjmVH8VYLtZmqS8Zn7Ypt2RddjCvNNg
         9CXHEN0eoaJNPGIhVWhWW5uizVU99GS1pTOUki/iUc4U8l1apn4mQHorzxuCHZqHi3nI
         SakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794939376; x=1795544176;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G3F1D5a6ZABD/Ct6UJJ0a/xHnccDHKfohgnWBX8JTZo=;
        b=JcO5irierNUUYVmI4DyuYMcW2tPClgJoyVt43RIFCAB8SM5DbrVgIwHqzyMgCOjEFk
         7AMYUC1Yj4NtGdjsl5WWT6oCvl5raB2RXOCM6GOwV2wWPEYXDrlBaxhbv395VHHWSGy5
         Hiyp5Tq9wqgJcypRf6Hqgaq4Q/LTUbI5QIbAbR9ZmwfROXTKfHLwZb++f8rbPII/TmeK
         nWuE1zmCqMuYFmHwMYV1TYA+bG6n0sSe7vgQREPeIRLU8vP093j8Xp+TOP/PWwaJQ/51
         mVj1xQlZ8xBFPNSVn/PnstE9eIDqeVYN80yQ7PEBs8U5toXrJvSjXMlPDXA1K8eCDi42
         zKtA==
X-Forwarded-Encrypted: i=1; AL+hErHSGTz7RBZWy7gF+aW4+P23TXG/fOn8eMzhhApY+eUaOdsNVl6PVz4lOpcwKm32CclGE/U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sXhXc5FFzZ0yx6kfJSXs8iZ1tMikyS24oq0oEvn0izr1fpTwX
	0dVi5VJH9qyvoX+WMsx1UXrUEbH57dDpzu/uRP4xGn+LuCXojxjppWuJpnoleN4zt3o=
X-Gm-Gg: AYBFou1sz9n0ciyTy769r/633/Ut68p/08yBj35wskG/RmyJaIK1PFjV4UuYh8rs9f0
	O39f5UPnoToKszd+9uy0DMdTplQ4trN9MuLRXDHuwbeIK5axnIvR/ZbZlrtneml3xG9xp3SHl4K
	I5pjpZpKayrjkPKtYOHf9InybPa+eT6gd6MT90fQV+iDMFM9kXezSjdFh5Ap3FlPPUs8Ztmo7LK
	3Qml2WKJ7MVZdcJ7pA24nsn8OAQq654NOnlai7vw6Nzi81i8GzUij3xa8F8ynxWa2JIe8qBV47x
	xIroAdNX0+/Sq4f7HcTy6/UEeAFnOZhvJgs3S97vixC7IghFFIGTqu+YtYnXeQimHSCaoAzl0Dc
	SXCpGTP9drG+gAiDo0x61uYGrkyWmAdQsaZnlPET+l0aORhc4BPkTXTBUdsJKho/uQnZLwBa2LP
	T0c5xE9UE3uXy8y6bbZlGFLff//sfDOeI0ZGj11KkmDoQV/d7qbSd069rMu5AoVwBm8fVrh8FyP
	bNQb+QsY1L7jyPbcVlJeMMdimH1XZk5Y2egEAo4ZQAsDFkSzULPWm8mzAlpG+O8AR1hgn8rLI0/
	pRYiVGh25sDbQXB73IRdkxpvsQuMmosRK+tMLGW1D8uufegwHHvNKpbg6JhuWfbjf33g
X-Received: by 2002:a05:6402:2341:b0:6b7:ce4a:7cfb with SMTP id 4fb4d7f45d1cf-6b887eb69e5mr71531a12.24.1794939376195;
        Tue, 17 Nov 2026 10:16:16 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b886a7d7b2sm93434a12.6.2026.11.17.10.16.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 10:16:14 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Toshiaki Makita <toshiaki.makita1@gmail.com>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH net 2/2] veth: wake the peer txq when deleting NAPI
Date: Tue, 17 Nov 2026 18:16:06 +0000
Message-ID: <20261117181607.30219-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113104648.225983-3-simon.schippers@tu-dortmund.de>
References: <20261113104648.225983-1-simon.schippers@tu-dortmund.de> <20261113104648.225983-3-simon.schippers@tu-dortmund.de>
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
Content-Transfer-Encoding: 8bit

Hi Simon,

On Fri, Nov 13, 2026 at 11:46:48AM +0100, Simon Schippers wrote:
> +		/* veth_poll() can no longer wake a txq stopped on a full ring */
> +		if (peer && i < peer->num_tx_queues)
> +			netif_wake_subqueue(peer, i);

I have reproduced the stall with your script and repro_delay_us 2000
(stuck after 14 GRO toggles) and confirmed this patch fixes it (all 300
toggles pass).
It is tested with veth from net at 5e9b2ad9b838, as a module on an arm64
VM with 8 vCPUs.

Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>
Tested-by: Tianyi Gao <tianyi@cloudflare.com>

Cheers,
Tianyi
