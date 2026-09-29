Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B624F30E5
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724852; cv=none; b=g+gpOu84xPB0nAkkiDny36M/Gjr6TTHJwIKf+t4sXflrqM4ncNAn4W34EJcm3CVkXh38fef8/JW9k7gtHrT17comCaYzu4WSXNlAXumbcG1NlWA3GCRAp+ARCJKwh1rsbYNgCKVbSixpCMxVPtm09fIcvv7NgaVD+THbP3gQQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724852; c=relaxed/simple;
	bh=TSFedrkdsAHaN9aejTdWtXWyUH/Srv+1ePO3zcjFvCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaS1TiYy0M4kYp7aNxyreghY98+/huYOJkOb4FPYwI7H7iIQfonediRTIEy/0g8U1jaABPapMmozipwBL6aEHL4JbuvwlPZ8jrq9BGX6Y1wOwRY9dI2XbhtKH+sBYVa1JDKlDY5lpaLC5CghNr/4jsrjQDwbutOj/7AG63CQ9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL8kiCpp; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL8kiCpp"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2dd9bce707bso16544155ad.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790724850; x=1791329650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9DSKh0dbyMhLQzORvY3t9iqgHHDfHJLJlZzXZ+x7vpI=;
        b=jL8kiCppM4U4HnL+R2A9Zfwm90tIwiUdTOx8lBShTYX8C/SQWViQD7mP7U9MAUdGBk
         iJXqxMj6xULPnfzINm4WB0HB9KG6gu036lMb3E40ThBXZ4Nhx1qF+DzVmtfJLEbbmsAi
         3WVh2NEnyMl8PvM0v/uknCaZ/DWViVPWPoneN8z8jh/zGdEJyJq2j/QI+yopfR+MYOWy
         3PiLWaiWXZCUeua3a895mdqFAzbu5z8rYclWnSd8wYWY8zBk6X2DLCrAIXjwp/8ycTK6
         C7njUsgCpYfzQJVqGKsK0ZZoGDgbWk4uv8O1Kv6Bh3eOqJal2iFRqa0bHVLmm4SgO+T4
         9reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790724850; x=1791329650;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9DSKh0dbyMhLQzORvY3t9iqgHHDfHJLJlZzXZ+x7vpI=;
        b=yrcFQ0mfp881QsWCLeh5iq/+UlkAj4J/H0atrR546KCXHYhOw4c6cP/SPoxCxwz53d
         /XwK1OnAeRCEHfMOhi0O0f91iDYwVjB3y3Cx195qeSspqVQaY5IIvdyHHxtoJFCi9IyZ
         LrTI7dbbtb+0Bgya/0eqIunEaWYS4diNVnJbPV+DzmWJ3e5W2KbeK0Yk+TGI8Wa5lw3H
         2KTa//ovStgHJqM8LEdlJiXi1dfz6Pd3lID1bF70McIaWH9+pvFMm7F0w53mjSBVardO
         v4MrJ7uHYaqcuLXMsZbHPZFHvR0iMCdxjps7UDFKmeqAO35yHC46pnvT+Ue4GlINzvS3
         wHKg==
X-Forwarded-Encrypted: i=1; AKwUvBzpTpPRMGBOI2qbDhZTOvw3lR44CtpopYnM5Wipl5uLjAfzYDX5H0VI+hZzIp8p1BkhGq4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1z3sHAH1MBn/QmO+fpaHa6JsiVVjR4PlxJ/YujlsgwG7Edo6F
	PjxU+ti24L2/as7B1GPCsTVl1pXHraIgJOrmpt2MkyXmWwkK0mItgLqT
X-Gm-Gg: AYBFou2ubpyIxo+yjrMrYacD2759EtdFPBRFeUnNgP8iWc0Q9dJHAktqKXJeA1+x7SB
	W/GhGKGjLbRyT0bnKquQiw2ErS/V/tQs5yGOxWjD2Y9oUF8FdzSW70N97guXpUnG7Qjm52broGO
	MUOnZZaFMcW0WhtkbR6737IwDGtC3VD+xPGkc04w+zMBy6CqYdS+IillmwA4OJUH3tifa8EtK+1
	ak7D11GtJoRwyF/AguIu5Yl26hhDMX0VgchTdcGt17CV+Opl815nQ/ZCIY3R1gmSWw5x/s/khaE
	lRDpbbWzrg/YmOYzbP6wQrUbVaqLx+zCSDxXRZz9SaWXy+BFvyrGJYZiFhsSo5svFfU9HWQEC5c
	Pw0UzFddFHJuAgYd+4/AEK9btflpIHn4t6qsWivWrgNxHdfb2GxwM4kyGX64mKAS1fWx/ygaPyx
	PNqx0CJR4V/jRqc5q06YW+qpIpoSE5RPxxfzzTXH59/E3DBsdjE1NBqI3iV/9Xhp7j
X-Received: by 2002:a17:902:f650:b0:2df:ab73:7e94 with SMTP id d9443c01a7336-2e2de587119mr4694255ad.51.1790724849971;
        Tue, 29 Sep 2026 16:34:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2dd516cd9sm1984695ad.30.2026.09.29.16.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:34:09 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:33:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	hawk@kernel.org, sdf@fomichev.me, emil@etsalapatis.com, liuhangbin@gmail.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	aleksander.lobakin@intel.com
Subject: Re: [PATCH net-next 5/5] net: drop GSO skbs instead of handing them
 to XDP
Message-ID: <arxK3DhmtyQ97Ewq@devvm7509.cco0.facebook.com>
References: <20260928223648.2739371-1-kuba@kernel.org>
 <20260928223648.2739371-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928223648.2739371-6-kuba@kernel.org>

On 09/28, Jakub Kicinski wrote:
> skb BPF paths have a number of helpers to fix up the GSO
> state after packet modifications. XDP has no such support.
> 
> "Real" / driver XDP runs before the SW GRO, and drivers generally
> disable HW-GRO when XDP is attached (with the exception of IDPF,
> story for another time), so this is not an issue. We also try
> to disable HW-GRO and elide SW GRO when generic XDP prog is
> attached. These precautions are not 100% today, and IMHO fixing
> that is impossible. Let's explicitly drop GSO skbs on input to XDP.
> 
> First example how things can go sideways today - bonding.
> We only disable & elide GRO on the device to which program is
> attached. Nothing reaches the devices below it, and for a stacked
> device that is where the packets come from:
> 
>   ip link set dev bond0 xdpgeneric obj prog.o sec xdp
> 
> leaves every slave with GRO on and no xdp_prog of its own, so
> netif_elide_gro() lets them coalesce as usual. bond_handle_frame()
> then returns RX_HANDLER_ANOTHER, __netif_receive_skb_core() loops back
> round to another_round with skb->dev switched to the bond, and the
> program gets handed a packet which was never on the wire. HW-GRO is
> the same story - while netif_disable_lro() walks the lower devices,
> its HW-GRO counterpart never did (this is largely the point of
> distinguishing between LRO and HW-GRO).
> 
> Example two - veth. Generic XDP on a veth gets there by a different route.
> veth_xdp_set() takes NETIF_F_GSO_SOFTWARE away from the peer so that
> no GSO skb is ever built for a device running XDP, but generic XDP does
> not go through ndo_bpf, so none of that happens.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
