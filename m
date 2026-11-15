Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794778482;
	b=HOC86hOaJrihqEcnTrMOHDaF0pk1s41EXvdjeX2KCEw8fLBofJ+7X8RLCZczRKyJO3Gy
	 hkdfwLMQl8ak22nm+H7swN+m8+xGlCMKIj27vD5FGwSY2JHt/zNK5auqa5mP7ZrifdE/v
	 LfbEDoeC1Aqgw9qdkmzFtB0ErlZTtCoq2pxqm+ZNQHzLUMfOMmsSM8ni8D+aCgDl72C1h
	 dKYk4LTgmY4/Xblg18LGqx8jQK0AAL2cXU9oItBwV/uPp2uzJh5d7wNOj5XQTVZOCWNl5
	 Hzj2Wsvsc7VrAqPfcexYm5OPCLq2JJioyPdiPD4Z5yc1/z1/sWE4AhilvKpbMwjzYrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=cs9JHELr5d8wuCO3bjOm1h46Bh/lIS6/9xmpt7kk/0s=;
	b=c43Bi/ma0J5XVcr3y89nP8YkmIRcnE0qiYx16RJETD5Vlrbhamj9J7KZkM6RpM+gLx3a
	 TJAO85vioe7KZxZJuFfguS+TTJz7U1tLS8zKuOLhKwrW7BcLtLJOJ70fPwDIKOgOvf/VQ
	 XuJuWGj26fp0WnWZRC6mCctwNoz0l/7rtePwJrJ7VWIHCuOuFEiodYJBahKKqYhic3ee6
	 QAGDTNKoEtcJxpMuVkaXLr96dHkSj7nPd8WSTsbNWhHeI7ig2ICmy4043U8NNH1pOhxaT
	 u6GhNZX/JhAnCeem/gmHj38U1fxT3QL4xw4tAAcHS4i9d+/p0PVmBzjzKXn2mb1E1yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=LQb7bpGA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F142606A332
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F142606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=LQb7bpGA
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-7190d9bdb2cso2470467eaf.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 13:34:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794778481; cv=none;
        d=google.com; s=arc-20260327;
        b=WpZdBzFfRE7ppfWaI3JTEas86xO/ycCfZ43yiYR6gtHvL+yChSbH1fLIuPKcolfmxC
         FA/Lq0ARxz2G+ketlbtpkYpCbnSFBIZnx+DvTcLJenrYoyyiIHbodiwUZNNrDajiDthi
         fOHc0FnGW/jkIrXIqwYePGHB+M+TbBfmCEPp3YEoMbNRctY2QFqAaWZTgvYZ9YXth7qc
         /PQBqVRwsDa2Ido1yXHks6V7Y2pnIz9BVZJiuktFAyWUmcqdNVPXvLQEB6RI2ExC/wMU
         G+r6N/wM6Pea4ZlFunX+cl05cvakypPJpCBY29b3+JxqSwqAVj/4dkKw3E0jZQDl7iMt
         Jciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cs9JHELr5d8wuCO3bjOm1h46Bh/lIS6/9xmpt7kk/0s=;
        fh=d0QwN8QTNCr0YvF8+xC/ZE5rPCdaZI4RxZqyYSPMTik=;
        b=fGR61Lo1/Dh3q2TERGEgbIfvGmxu4+VhnU7B+kEXjggySdWDY4ENsGSAl0YMpEs/ez
         2cOCDCNmx2tGVtf10O0+4J174qBRB2njVm9RQKOD2gMNVUvouvRJdUezh1/D4Mvtlj3W
         QtOpJbiZ9nPUmrxqkbm8GAd9HZ1ZilEo8TQxjaTBBvDlDDplkX9cJtUG6mch1DRfSONL
         C6Y7ETYuoJHmj447Ah3p67+uo9paLzl8ctuE/olD9HmCHWgqpbB1gsvWLEd9ckuDaxPT
         TJKDlNs1sMJ8cXNNWeea1WBwyJqznLC/Bd94aDVPoqXDi0WypLlDIt2/aBH/bfH1LImL
         bEww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794778481; x=1795383281; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cs9JHELr5d8wuCO3bjOm1h46Bh/lIS6/9xmpt7kk/0s=;
        b=LQb7bpGA03szUtIQx3bHdBEh40GP6gIqmFccn3+VEv955kr1PLbIVOR0uUlP87lFx7
         4/Dra29lac4PuGRuM3R/yXVFBmgDTi6WO6vI85vAlw0n1V34Jf/hJpYsAkBnMRiQ6mqh
         V3GMoen874LPOwBhk897GpaUo6XfRFJm+vBswGdzMb2I2uQPn0fQN6MCPQCsjuKV7gfF
         2GSizdod0eYE/AaE3zaC/iLIkeED6WCx5HrEXxJh4s8Cvi4lLu6aOzwNQot2VdIdJN3y
         8Bx0WHoW4EgCtFvY1FZetZuaNHmmrlxLT56LB0/prybZyypsd1+ABS5X/os09adxvk+0
         glnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794778481; x=1795383281;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cs9JHELr5d8wuCO3bjOm1h46Bh/lIS6/9xmpt7kk/0s=;
        b=WIS4ZORaFqnXUd+L1aqnKrWU8FFhSYKE2JxGeUo7rEHOcZXDKW1pdeJ1ct4guCX0XA
         T2yU6FCJgnWoQWFA5yIKT4o5C6LUSRrgarD6VnzAqKivx77Q/KJQ/jQwQq1Np35HoszW
         yE1vawJdVOWnK1gVSF50YYe903kc7oeNqrbCy4yRlrdnl3JC6K/N1fmi4DErWMGP80aE
         If4UKqWiGS9gLuQIZvxXC1Z9fYTAI3MU4HY7vQx2vzidXYhR/JzmDj5v5hnH1mQenpzz
         LIanZipLdqDf78AbNl+P2lY/XXy4t0x3xBAYXCJpFSrdb/zICELxCzod4+FnK0Gl4xpm
         zsJw==
X-Forwarded-Encrypted: i=1; AL+hErFzbGK70uocujIfQjdUNEi7vtE7uCbWluM4H1TVkPpVxQBvNZPU7UGi5ZFUQlonr4gQE/s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9+9H/Tub58Qv9vmWqY/c09Dz7QIrkRIxnNtcoa6yEGT5cpmbD
	tPsoWaz0qdrpmN2GssHfTvGyhv9QrcTR78OXv8+5DcZmySXb1FyUmnrLpR4GaPJ/jd1Z6M9zYSS
	9MkzhJ5W1OjsDgjAOEiYankYINjCLC9v181GDoK7jYA==
X-Gm-Gg: AYBFou1r6RL22T4yWobIbirYa14XuPB1lVw9clF8T64uI8cJzFF15Qvrvk75rTBI9au
	fWCbSOK5DB+j1f2CdwWHllTn4ritQskHZNFx3P/7xCP4W2tlbqiVYmnUjONQyDjgfZp1e8mgniO
	yG8bqlqe6k+UDlpWNFJ/ATkcG5fKYaFzqiaLn5h/ZNRVZF5osSEHulVmDjYWjDw8Be7li8cFdD4
	8iHs9AufGux+fairfvo6E640WlhebnO32jrypJdCHFNOkSA2DFXLtsR7EmL+9aWk1UTdnHVcJHh
	GfXw0B2TStAJcPNBaL6Pf6UxcTg59O1b5IEMQuPQyTkrC1+5UV/dAovHNOeIs1ycyJ4gXQH4KFi
	O9ZR6avBLKoJlv1AOrsGrHk12N6Hu0TN9qr9vVJbbBJRDDedC5Hc/RGlJBie9yomY7xPY6jq3Ut
	PivfYh/Xqo3Q==
X-Received: by 2002:a05:6820:3389:10b0:717:866:abde with SMTP id
 006d021491bc7-71ab50b64f8mr4048862eaf.50.1794778481265; Sun, 15 Nov 2026
 13:34:41 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115212117.48496-1-emmaonana18@gmail.com>
In-Reply-To: <20261115212117.48496-1-emmaonana18@gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Sun, 15 Nov 2026 21:34:29 +0000
X-Gm-Features: AclHuK-PPhL2FyJA0xoMqtYefnBbjo3uLjHDcDBJy-SQemPSC9ZW6IQWHZkbIBg
Message-ID: <CAG4wq-exUYFvw4i=gQZhwC8fF3tnhmOMtv+NceYTBEx_TO+F7w@mail.gmail.com>
Subject: [PATCH] selftests: net: veth: propagate channel-check failures to
 exit status
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Nov 2026 22:21:16 +0100 Omokefe Emmanuel Onanaroghene wrote:
> Fixes: c017800af5c71 ("selftests: net: veth: test peer ndo-xmit after GRO toggle while down")

The Fixes tag should point to the commit that added chk_channels():

Fixes: 1ec2230fc721 ("selftests: net: veth: add tests for set_channel")

c017800af5c7 did not change this helper. The bug is present since
v5.15.
