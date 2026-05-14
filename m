Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0831716D;
	Thu, 14 May 2026 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771131; cv=none; b=uGMvRMv6t6pnTYsDePbRg0NROxczhzl5BSg+S47VnVYSXV+iVVjdjObb9VHryV8N4XGb/3E+egJccCmkadY7+TMO8kTC54uFKlLKlm7FA94Yj3EZ1zSOeO1julUHxhZUSyRygdAVCunb40uYXzbbVK0F953dluxvVaM7Jccg2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771131; c=relaxed/simple;
	bh=uHXk142rdXP9Quc1HvPGg5PrsaBwyT37DlZuCMCtLw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ch/Iel4srkagDJ42lADgM7zeGyE5tEiI/OxLh6+NBjEMj7lx5BXwPJo6Y19QU9bRoASdhnaK5u10DG3V8/sqY8xJimtJMYTbE3fOTKC7AqCTZhPEvBwOgDqWvxDnpRWANukjvCfgwzMB3cONMBSxTMYrcMsWEsoH34x7VrQ/O78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=W+8VcpKM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CvhPvrHw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="W+8VcpKM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CvhPvrHw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DAA45EC022B;
	Thu, 14 May 2026 11:05:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 14 May 2026 11:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778771126; x=
	1778857526; bh=t9AFOTY5ZkS/lLxTJk2f8rmgQ3k4DF6eF4A3cXW1DEg=; b=W
	+8VcpKMukUrOtPLAyC3O8cr43iIuB9WhWs7dGTWI7xd8H6n0ML72V4/AntsWtr+5
	HJOZYSe0muYjLh5T/2GVAKWBlaX7Im2uddnd577Nj/CVqDJnmsHELQ1WoP0doDgO
	+/2aIxkbypS9mI0guBCcrOXDFJiJDzvxglOA2HQsqWyOSv+fAMOs+z37rhFjC+CA
	z4BSl1+u2j3bQRsrI0zUU0Byt4KwgoKmspbhJV8Rl99CUwJNvEuOrhpW0qqNRI7G
	q/pNTpscsZ52sk3UD+QjJOHZ3Ic+fqrtZVtEZVZtd88P+8qOVVqcRP8DrFkGE5o4
	71CbrpDQbuf55rWXn8I3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778771126; x=1778857526; bh=t9AFOTY5ZkS/lLxTJk2f8rmgQ3k4DF6eF4A
	3cXW1DEg=; b=CvhPvrHwlXiTzcITz4tXlnhChhsGA0pVZCO/i+dfZZx8OwXliNN
	6P3uabJqbfBwFKJR9koN9AWBpax3Z4Z6yraOjBu6HWNJci+E20RWeub/p8yFmKHH
	NxP9mSi3koQkoBkLQsgDh47QVVdDMWRvWKJORccugS5wt9/iijXFJBxySbNJknqH
	RGXtvok7LMSVTkKTEUEIQ0G4ss0aV1WX6pTckHyAFTy7n80ninKOq+0LsSL2InIa
	zK5HD/CgIMwj9ZVCSDnI+oj25dI6H15DhDhrEeYT6I+OvRg055U5enzoG3Q6yECl
	fDM+9KjzUBrKrO2OOKkWFHNtfw9P2nJhreQ==
X-ME-Sender: <xms:tuQFaq2WjPSU4xTQ2-5bGCil1bHPeAZBGhm9wU_K3ZEGBzVb5tNr4A>
    <xme:tuQFanvFN94QUKx4oL6R4TA-eXXdSDvrg0XGlgXPbvMQZ-X6enJ7GQdf8lKPnDd9p
    YzIA1m_V3Kz4qUNN2ZFLt_Kq5mbopS4bSWbmorrmWf2BdoNjeTP4WY>
X-ME-Received: <xmr:tuQFao5NMYLyW_Ff2XowEpFs0Ui1FHTw-AHigwQj4RxN8OhDvDggMcKQETFsB5swLNLONpYXwnOmEvlwBs9r7k0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvghm
    segurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpth
    htohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghs
    thgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tuQFareVmiaTAQfg8tf38x3x8SLzJ5MO_VG9wPa-6V9CsnehQF51Tg>
    <xmx:tuQFatwP1IBPOyJJkX6rPTW5-LSYNLq8FE7rl4w49mIt9CHYRn0Qgg>
    <xmx:tuQFao-hADsLMd4EU9aY0R0KXJOpnglPqCP0Fyp6sttX26ukDtjg7A>
    <xmx:tuQFajxFtNIa5WP40RRyyCLz2CnvuNFeWcN1zgEP2stprgUM1aiKrQ>
    <xmx:tuQFaigzlHloWKKl9IjQwt6B64FwNasjCm9OqkWqJ-ayXsz8BE70krYV>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 11:05:25 -0400 (EDT)
Date: Thu, 14 May 2026 17:05:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	horms@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 4/4] net: tls: remove bad rollback and UAF on
 ENOSPC
Message-ID: <agXks9BGNvcE3WPz@krikkit>
References: <20260511174920.433155-1-kuba@kernel.org>
 <20260511174920.433155-5-kuba@kernel.org>
 <a83d79d1-b932-458a-b5fa-1cb623fa03f1@redhat.com>
 <agXGJ2v-Gnf5trWX@krikkit>
 <20260514075504.1790a187@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260514075504.1790a187@kernel.org>

2026-05-14, 07:55:04 -0700, Jakub Kicinski wrote:
> On Thu, 14 May 2026 14:55:03 +0200 Sabrina Dubroca wrote:
> > > The sashiko report here looks like a pre-existing issue that could be
> > > handled separately.
> 
> Or not, cause frankly TLS+sockmap feels a bit hopeless at this
> stage.

:/
How long do you want to give Daniel/John (or others) to chime in on
the cover letter? (it's been only 2 days, but it feels like much longer)

> > > Still let me play safe and merge just the 2 first patch in the series.  
> > 
> > Kind of. We had agreed that #2 could be fixed in a somewhat better
> > way.
> > 
> > @Jakub removal of the content_type chaining can be done in net-next as
> > a clean up now I guess
> 
> Oh, TBH I also thought you are okay with the patch as posted.
> I'll follow up in net-next shortly (once Linus pulls).

Ah, ok. Fine then, thanks.

-- 
Sabrina
