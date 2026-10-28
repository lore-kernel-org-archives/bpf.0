Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203069;
	b=SCqdk7X1NyOXZ2tD5/pxdsFa7h1zqcGSzAjdNi3pm5xHVUqdpm9DPNxMjoO14x1ebC0k
	 2zSNQTMn4Zc2VxfkRMvaiyCcsV3kZKXRU2PzIDZBx3BDZVWGAWFqrAHTg5T5YDTV60ly2
	 k60y5VsW2Di9gaDs87WlihpkJ91tkT5ybK3aOVzARrhNs9+CTCO/Kx3b3nf0FjbmoGUse
	 BTxb/Em9xm+j6fzaR59CCYyzWTazq7W6RIfBkDR1Jjmo2xYZipTqP4lHlKThY1IdJMbr3
	 dC2JFPNrbxsHTGgAQiqG6WNWx/JDuVjJZr7BRg1VbyQj5ZVaab4MNacUBAhkOcK5/pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=bIUJn5v0noI0Ozp78hAN6qBHnECEjw+ZHdq5PwPXe6o=;
	b=iRvis3J9oGkhNdYCAJtROEHR280LTueZP6MxAPfSHQCDXZLIPPTDPTYejrtJqnENhPk2
	 LFQhmOYnWiiX+NHrdUvmei+Y7jRxtPtyXYNANiAnQcMUAU2QxZEpsc0iyHyq9kMiTBQEv
	 JUinj3P8jngXc/Cpq6WJJJVt7Gu3fNz7OVo4heWF2gPZbWXZukqyPA0Z/Uyb+MDbefPJz
	 /uxMN5e78xSkNdR7GFVHxXms+NdvP8+IrEhOIl3K3jKifVMu9nC2Ro3m+NcMvUxV8R5I4
	 jlqnw3gF64s0p4kG+kxO+wYgSvdXacNEwlRwxH4YikSEO9LShNzZGNF/q/YkXqO2Gig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljK0kzZc;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF9606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 15:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDFF9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljK0kzZc
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cc7c286026aso635835a12.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793203068; x=1793807868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bIUJn5v0noI0Ozp78hAN6qBHnECEjw+ZHdq5PwPXe6o=;
        b=ljK0kzZc7OIyosJ7wtQFMgv9t4jBsM6ffPauulC3pXY1M7Uo3sQTlPAIuHZE7gbyFf
         bun0E+OttUZck8IKPE01oLJeHGP3SE8CLliMRa6yeodozKQT7iCBpdvryQnmRj02EJg3
         fd3PT3KSgpTCNaQLcTHP0p1S5CaUrDkmepEOB0R5PgcoebLDwOibI/e+A4t3fgi+7BBX
         I67SoJI+UC4wqpLQUVgGqiTHXvwUbDA8yckRpISy54uZHbl//QLdfgtU4HDqnK8Po73b
         ylXpIfIj5ezA1aObz8m3IFxxn7n5AJ6pJd8UgGKsizsN7jApUGTCiGNqk18t0eUD8GkP
         LnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203068; x=1793807868;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bIUJn5v0noI0Ozp78hAN6qBHnECEjw+ZHdq5PwPXe6o=;
        b=lpAfWtUD9qeub6oRzokLxC41pLgLqoOBX+pDIZyZre9hyrirxtgtO3JjNLbVFnWnsM
         X9ASZeSP5AokBZ5MZ+NZ0UIviGN45OFOvEK0RPwmScoYjr9EgF5EitvCDG7p60/Tb/+b
         d2IcyAVz6FXhnElsRTXd3ShuzwiI8zwVrzVZmviwRhRHXSBKaUhoicU22p9/9DGTgGYO
         3XxApfNlPX8KBdYlV/AI0xZJZNUnzjJaRSqxrENui6+7l6/YmI8FUoMCNdgk8nKapd68
         lionV0G/5L/G3UWPbBaiF7EEyArUn4292GjVy0RZ5gG87m2KDJUyeGEllpgR3MN8JlVL
         XjbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJUzBW3bVXeYvCFDOWD0T8FjDSs0zKj4A7MClATWo6LYCESFMESvM1FbyaXRh13QPgnxI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjRbslQreSXDlixLKO2Ew6Y9LqBCj3rrBl9kLQLwcIsY8pTJ9z
	F6uz4jU7abjzwqvkFgrrqjxtLXxqdVVbH4pejj0nXnrMTty1Lcc2lUoW
X-Gm-Gg: AYBFou0HjIpLiNwwMOuyQdlzsm1gC/Cfd7Ei4Cie8qgGs2tJC7Ew1RVILeImuyUwEgP
	FND256nhesJ3FA3SQEeZkk4EhyERUIqGy5MaWnLGWDDY5ygj94Nh0poBk0BkkVPnjMhq3Gi2gV/
	w6VjlD9EMZiOq+H2nMe6ohFfoOHcaElzd+WxkxV7etZAoaK7px3u1zwEb3mBWct+X7EXmlrFnX8
	gsxxkAzgS5dl5vVz91yPOAeHPI+3+pS4wa0HmRQJBCc3h1Wh/xsXNBNSC+hvMWVWzPDAJ7avk+e
	0pUUco1w7MC21CHV+3juBB5iI2o6D3gDlAWbsZdgFaPQo5nMfEzvgj+yZZWJLCYlgJznBvKbL1C
	LijEn7n2UvBxaC/yHJcQsB8HCoS23ZsjaHHTdpDXA3hWDdDK2R5KxklGiDWm3ILsfeLVBCIRKb2
	oPK6Yq5zgw3tqt0KiCjGNctvttMo4jvedH0KIf7LRv0XST0wvQt6hS0jXygpk4RBuV8fSeMJZQy
	P6pfkZx7RpjwYf3n1O2D8OqFDislTU2aU2YI7QDW5KXoPepk+a9VbFQUpIibV+Xo/5+tSYR4RV1
	TMf/ud1HJ+T3I047OXeRbaQ=
X-Received: by 2002:a05:6a00:181e:b0:89d:e6e2:b2a6 with SMTP id d2e1a72fcca58-8a6e7bc7a49mr2518493b3a.45.1793203068030;
        Wed, 28 Oct 2026 08:57:48 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:69::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a5f66bcesm1390538b3a.15.2026.10.28.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:57:47 -0700 (PDT)
Date: Wed, 28 Oct 2026 08:57:42 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] xsk: defer software checksum until the skb is
 complete
Message-ID: <auIbb0qeWoJ_eKw0@devvm16445.scu0.facebook.com>
References: <20261028025026.11401-1-testwrzwrz@gmail.com>
 <20261028025026.11401-2-testwrzwrz@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028025026.11401-2-testwrzwrz@gmail.com>

On 10/28, Rongzheng Wang wrote:
> When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> calls skb_checksum_help() while only the first descriptor has been added to
> the skb. The checksum therefore covers just the first fragment, and
> skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> fragments are never included in the checksum.
> 
> Move the software checksum calculation to the point where the last
> descriptor has been added to the skb.
> 
> On a checksum failure the packet is now dropped instead of being returned
> to the application for a retry. This path is not reachable with the
> existing metadata validation, but the behavior change is intentional.
> 
> Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
