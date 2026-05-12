Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72104395ADA;
	Tue, 12 May 2026 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581305; cv=none; b=JaFVC9hzYPHgyiBT+WNXnj40rRguksB5odrEarp6nO5U1UzYVuWMgv/C/f2j6dCqkrfrE5hFXeVGDXTiGBs+JvdCOhTyikHqUULXFY3D1x7PQGqUxkxE/y9mpI7oC8m/1mCczFKUU515q3vVwrbGMQYwLX4gWOcVrzvACEWn2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581305; c=relaxed/simple;
	bh=AfU7dk2bJmBu9bniAEQBtTwUkW59X6XTQIpcV7H1Xuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esxgLopaSkcZiWS0J3jsgyyK0biK/XwRzPB1mQKZZnWYj59TI0do5QBlEKNN9L5fd3NqZ98vrvigI0nJjJcC9pEGrvIG0y+GaR5Ou3IqCLBpmkMcjC1F2ZH8glb1R/l5Ut0ExBx53oKesdXsW4HZImfBN/jZDIDrJwSfz6wU6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=MoABu1bj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5GCDq/Y; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="MoABu1bj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d5GCDq/Y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E73F7A0067;
	Tue, 12 May 2026 06:21:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 12 May 2026 06:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1778581302; x=1778667702; bh=xVxq0sObjHoBRr65RLCzBiSoE8Y4hOAJ
	8upIvYky/UA=; b=MoABu1bjDUYPNSd0B3DDvw/HaCXa93BP4Ac2Jp4lFGFag6J0
	PswgvZGQh2lbNoAOwwfWyKbPZ1OdV7uQFkLz6Ek4TjfNyofuqdihjobjBLo848DC
	5i+GMM2iCnZq5EB0AONlCOCmaQwAoyr47Xzn+qvszOoS1z4vIIMWwuOpSGMFmYhN
	VWivqomPhbTglePHLZwyj89xCl1Zp+2YQody9liRGiRKJnubVG3Bd3Y+NQ3ITdNb
	jstbd96ifPpOwmfbxNYB6rCBnnJC2XBXljE4a6oj3ZgO6iVG86gC0W6hJAWXRq4O
	FScQpAsoDQvAefgVqlUQZduIsuF+QjPpsprEZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778581302; x=
	1778667702; bh=xVxq0sObjHoBRr65RLCzBiSoE8Y4hOAJ8upIvYky/UA=; b=d
	5GCDq/YRMAvIlz46XfuUahX4y5xuaJXAmb0XJbp5l3VEYjfF5ItuQ62quDda34Eb
	nhzVXOpjYkZIYKezpXckH1P9/wpQkcPh7JVgxgbw3QIi8mgO5xJKI1Upo9g4RJD3
	yeUCXot0VRVU6BuvJIjtRvPNnNHql6uTqOa1lJ9BaDEl70VoEI1y8quw1CxHOeIT
	S1Ohh2fK1n60CCcw+2C+mydeMeAZWg8s2xP6JgV3DI77wbHvNgMVs5ds12LfEc4B
	WOUft+jEL2Zd3sZSnkJidw0J4loyLIhXZNIMZKMeB7J5eL7CLuDC6Mn6Y32o+wZ0
	VSuy32bLSut7kDN0oQWBw==
X-ME-Sender: <xms:Nf8CahiZKTgZgUqOI1RSFrFYIxov76-mj-eVMuXDWG56PJkL_Qo9NA>
    <xme:Nf8Cann8D26Z_Db43wICp8Aj_AXlvKtmjaNtd0nfXcmIU1YC9SFeU7M6GXF-HYwZE
    UooNXA7AvdPvgCtD2qgBJUDOkyTifa_3aiIPmuOdEk3umr0bQm2vQ>
X-ME-Received: <xmr:Nf8CagXMuS0R6cTvKwthRIGV2X3Y_gHXkbquL_DPlpH1-Q9_y_XVJ2RDBcPzZG5m-XP0V1KaswTMy1a1Ns22GWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggr
    shihshhnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvgeeitefffedvgfdutd
    elgeeihfegueehteevveegveejudelfeffieehledvnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvg
    htpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    khhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlh
    hofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhn
    vghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdp
    rhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Nf8CasstA_vNXnFAN61f4W2AHrlXzr6NAOMNHCNimcrhUG9dX-czmQ>
    <xmx:Nf8Caj7vO8auUsKf13KzsYwFJTzL0VsDjjzuC_oSkURbdgJYC2LCXw>
    <xmx:Nf8CavQPCeTd4wXlVhEb6j3QzP-iRF3yIChKk5Tdw3dW_986YHucoQ>
    <xmx:Nf8CamskEQZvizfWyFk9oD_kTqhkXRc7SjUNXAhpYzyerfw_tWrRkw>
    <xmx:Nv8Cag2FCHH6ILPV6aWP3lf67HxbfJYHP4GQCu-46j9IUKMfJhc2tdDE>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 06:21:41 -0400 (EDT)
Date: Tue, 12 May 2026 12:21:40 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	john.fastabend@gmail.com, bpf@vger.kernel.org,
	=?utf-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>,
	daniel@iogearbox.net, jonathan.lemon@gmail.com
Subject: Re: [PATCH net v2 1/4] net: tls: fix off-by-one in sg_chain entry
 count for wrapped sk_msg ring
Message-ID: <agL_NNcOAVGyWb2K@krikkit>
References: <20260511174920.433155-1-kuba@kernel.org>
 <20260511174920.433155-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511174920.433155-2-kuba@kernel.org>

2026-05-11, 10:49:17 -0700, Jakub Kicinski wrote:
> When an sk_msg scatterlist ring wraps (sg.end < sg.start),
> tls_push_record() chains the tail portion of the ring to the head
> using sg_chain(). An extra entry in the sg array is reserved for
> this:
> 
>   struct sk_msg_sg {
>         [...]
>         /* The extra two elements:
>          * 1) used for chaining the front and sections when the list becomes
>          *    partitioned (e.g. end < start). The crypto APIs require the
>          *    chaining;
>          * 2) to chain tailer SG entries after the message.
>          */
>         struct scatterlist              data[MAX_MSG_FRAGS + 2];
> 
> The current code uses MAX_SKB_FRAGS + 1 as the ring size:
> 
>     sg_chain(&msg_pl->sg.data[msg_pl->sg.start],
>              MAX_SKB_FRAGS - msg_pl->sg.start + 1,
>              msg_pl->sg.data);
> 
> This places the chain pointer at
> 
>   sg_chain(data[start], (MAX_SKB_FRAGS - msg_start + 1) .. =
>   &data[start] + (MAX_SKB_FRAGS - msg_start + 1) - 1 =
>   data[start + (MAX_SKB_FRAGS - start + 1) - 1] =
>   data[MAX_SKB_FRAGS]
> 
> instead of the true last entry. This is likely due to a "race" of
> the commit under Fixes landing close to
> commit 031097d9e079 ("bpf: sk_msg, zap ingress queue on psock down")
> 
> Convert to ARRAY_SIZE and drop the data[start] / - start (as suggested
> by Sabrina).
> 
> Reported-by: 钱一铭 <yimingqian591@gmail.com>
> Fixes: 9aaaa56845a0 ("bpf: Sockmap/tls, skmsg can have wrapped skmsg that needs extra chaining")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina
