Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE142357D11;
	Mon, 19 Oct 2026 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390367; cv=none; b=ZPqaGQuv76TJBJ30bBiU6bZcnSLmsUgl2Sd+bDpbc1vZw3vnJPjQB5ikOiT0riPPj3zzGYEArFqWewG+TxGNgBPf0u1h9Nh6SK/02f6IYe+iStXJbic2fhVJJNOptyUA1P8jRzFwUus2M7bTRPme/Q+y2RLrbQDg3+2AyQ9TgW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390367; c=relaxed/simple;
	bh=Y8atOi4iW6zMgCfQEc6MXoNFIPIJqJDfUcwTymYLk20=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWWTM3SM7Kd6uctZgoRs+ISR5Nlj7tepI5+K5MXCtI5UPGDwY7hRsUzYlwf5KZDgxYOvNb1RbwbMTaLG1rTuP4c553N6mFvGuNlD5lJzlEIoPXnjs02t1qAmxx++0gV1hwRH7a3AN4OIvH7juxCO5bLYww9NtubUEIT52XxOa1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Pz+LwG0i; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Pz+LwG0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792390365; x=1823926365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ZuEBREPnjQP0ocHOy7sJ9kz3pJPEhTb65hzCV4dBzI=;
  b=Pz+LwG0iw4J8DOl7V8VwEXRI0q+a+PT28YJG5zfuSnyH8D/sEVqtygOb
   eyrR06Wub7eUoD1CGKR1LA2VRX1YtMRJt31vU3xiPJBt6Zgiy5vBPNGCu
   pU9/wucwVPSFyuc6uYfRhKpoU7ldUpUdbiOxJdEBHQMlKYIKqV23z/4gC
   ihaw7CZr4xrmGPxSYTrnHSwzLLvfnDxAamy8/fy3EZS6O9xIDibVRcyNS
   LeP3zUEFA/orZ13wGXTpYioWfmMcZc+zPQc5qF86pr6Rt2foTcoOo7BGc
   NsDeFyU0gbWbfzQ4/iy/vBJRjuwWY+aUinysy1GzsnBLgadaUtU/i6Sim
   A==;
X-CSE-ConnectionGUID: nfnNkhEWTgmQzFq1TE3Vqw==
X-CSE-MsgGUID: JUQb/GKhSIebNguxg5Qnkg==
X-IronPort-AV: E=Sophos;i="6.27,167,1787011200"; 
   d="scan'208";a="31611543"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 06:12:42 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:26038]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.38:2525] with esmtp (Farcaster)
 id d42a3cbc-0f46-4544-ba96-583eb45a9e09; Mon, 19 Oct 2026 06:12:42 +0000 (UTC)
X-Farcaster-Flow-ID: d42a3cbc-0f46-4544-ba96-583eb45a9e09
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 19 Oct 2026 06:12:42 +0000
Received: from dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com
 (172.19.55.127) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Mon, 19 Oct 2026
 06:12:41 +0000
Date: Mon, 19 Oct 2026 06:12:33 +0000
From: David Keogh <dkeogh@amazon.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Dragos Tatulea
	<dtatulea@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, Alasdair McWilliam
	<alasdair@mcwilliam.dev>, "open list:BPF [RINGBUF]" <bpf@vger.kernel.org>
CC: Nimrod Oren <noren@nvidia.com>, <nh-open-source@amazon.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 0/6] net: configurable extra TX headroom for local
 egress
Message-ID: <atW00dwVpYS4WO5a@dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com>
References: <20261015235335.4162993-1-dkeogh@amazon.com>
 <b8914a523b4a6b80424c5001d3d8012c6a98fd04.camel@infradead.org>
 <bba453eb-769e-458b-88f7-8cc9bcafc1db@nvidia.com>
 <a8f2f84e-7dc0-473d-afb1-af710d621f69@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a8f2f84e-7dc0-473d-afb1-af710d621f69@iogearbox.net>
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Thanks David, Dragos and Daniel for the feedback, and for the pointers to
prior art. There are really two questions in your replies: can the kernel
derive the reservation instead of an operator setting it, and is a new value
even needed given what already exists. Let me take both, and correct one thing
in my own cover letter while I am at it.

First, one correction to my cover letter: I overstated the TCP case. TCP already
reserves MAX_TCP_HEADER of headroom, so raising needed_headroom only reallocates
a TCP segment if the push would exceed that existing room, which a modest bump
does not. The packets that actually lose are the low-headroom ones the program
does not encapsulate (forwarded and received skbs) and stacked devices that
snapshot the value.

David (Woodhouse):

> could we try really hard to have it auto-tuning?

Auto-tuning is a reasonable generalisation and I want to be honest about why I
have not gone there. It is tractable in principle: the push helper, skb_cow_head()
in the encap path, knows the exact bytes it adds and whether it reallocated, so a
per-device high-water mark learned there would be attributable, roughly the
monotonic-raise shape of ip_tunnel_adj_headroom(). But making that correct brings
in bounding, decay when a map-driven push depth shrinks, per-program attribution
when several programs are attached, and a chunk of runtime state to get wrong, and
it still eats one reallocation on the first packet of every new depth.

That is a lot of machinery for what I actually need, which is narrow: reserve a
small fixed amount of egress headroom, on the order of 128 bytes, so a UDP encap
push stops reallocating every packet. It is set once for performance and never
touched at runtime. A static reservation matches that: no learning, no per-packet
state, nothing to converge, and it is trivially observable because the value is
exactly what the operator set. I would rather keep the mechanism that simple than
build an adaptive one to avoid configuring a constant. If the consensus is that
only an auto-tuning version is acceptable upstream I will take that on board, but
I think the static reserve is the proportionate fix for this problem and I would
like to make that case before reaching for a learning loop.

Dragos:

> Maybe this tx_extra_headroom could be declared as a BTF decl tag in the
> program. If this is the only usecase there's no need for a rtnetlink uAPI.

A BTF tag is an interesting way to attach the value to the program, and for a
purely BPF deployment it may be enough. The one caveat I would flag is the one
you raise yourself: a decl tag is static per program, while a program's push
depth can depend on map state at runtime, so the tag is really an upper bound
rather than an exact figure. For my case that is fine, since I want a single
fixed reservation rather than a per-program one, but it is worth bearing in mind
if the tag is meant to be tight. Whether a device-level attribute still earns its
place for non-BPF egress transforms is really a question for you and the other
maintainers; I do not have a stake in those paths myself.

Daniel:

> there was some work in this area here in the past ...
>   - b9ed315d3c4c ("netkit: Allow for configuring needed_{head,tail}room")
>   - b73b8146d7ff ("rtnetlink: add needed_{head,tail}room attributes")

Thanks, these are the right references and I had not connected them. For traffic
generated inside a Pod on netkit, the creation-time needed_headroom already feeds
LL_RESERVED_SPACE() at the allocation sites, so Cilium setting it from the control
plane does solve that case today. The gap I am trying to close is the same value
on an ordinary egress device (a physical NIC, plain veth) without raising the
expand-on-demand threshold for traffic that is not being encapsulated. Do you see
needed_headroom as sufficient for that too, or is a separate allocation-only
reserve worth it there?

On scope: the core patches (the field and the allocation-site macros) have no
in-tree consumer without a setter, so they do not stand alone for net-next, and I
will repost them together with whatever configuration surface we land on rather
than ahead of it. What I want to avoid is turning a fixed performance reservation
into an adaptive subsystem it does not need. If a static per-device value is
acceptable, the open question is only how it is set (the rtnetlink attribute as
posted, a BPF-side declaration for the BPF case, or reusing a control-plane path
like Cilium's), and I am happy to follow the list on that.

Thanks again, this was useful.

David
