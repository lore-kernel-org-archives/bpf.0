Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7DB407570;
	Wed, 22 Jul 2026 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745330; cv=none; b=tRTMdRrJR6MG1zvR+mb9WlfRPq7HXQRXofRWH70SY0ivSGQolIK9DSeFvQh8oUP9UNkoqGWe54KuxOkEVneomJIez2CkqyTILDs9vyKIsvY/43GycyrPnPXxR9LInoxiWNG4padM5TnDovQwog114XSkSmOzbDX65N2fiBAISsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745330; c=relaxed/simple;
	bh=dSlnlKe07hlOR23uhYPBh8ZTHKH8iB8wQID+iaO+xXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hbttmt6bzJ+qz87tSjj9nn9pSwITKXiQZuChare3AfCLELk6YzoNowcBIfUZNvMpDcbcVzmjmwCBwiAlCkN2Nk+C1AWS5Hs6Tm+evZGXOA0r3V1OYHgsxbhL7Zby5QY7SXftqJk10+onzvZraiqUPUZAv7sabBzImeGGJJjLvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6LTxb6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6LTxb6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4751F00A3A;
	Wed, 22 Jul 2026 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784745328;
	bh=670ICVCxpkbIIsTKMOsa+I+z+C4FgJRDQNs6RF7SdGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a6LTxb6Me6mG2aUNvx62hRLaJopZgj2ogTsG8vH+9nTrF7phHbWJSmGpvev0Mxvvt
	 3c8U84ok5cF/v+rxZT6PsnyNEZnEti27oSLMZ9CjBWQ14jQOM+KjpEdYKOjUnyscea
	 bD75r9/q7UDGNM7PAAcphCZ39vlipGyeAoYzQ+fLUEH8VNtac1NbFbz50FqsCzoChy
	 yx4Eo3Q4/fyiLdyQPCRVfHlVSFX0DNSbXI2sqB0ToGN4AG0xOBFEB1dtrm4HHoicKc
	 Z1YlaRTqCujzVsoH4VJYq92fziN8WHTbT/wc//wfZW0o1XGNXS+uwZmLenI7DcjKu+
	 iVpXtEUew6/mw==
Date: Wed, 22 Jul 2026 11:35:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Vladimir Vdovin
 <deliran@verdict.gg>, Jakub Sitnicki <jakub@cloudflare.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 8/8] selftests: net: add test for XDP_PASS
 skb checksum invalidation
Message-ID: <20260722113525.34092660@kernel.org>
In-Reply-To: <amEEEohxmC8hkBvY@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
	<20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
	<aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
	<alkBnI3XcH0XGjEo@lore-desk>
	<al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
	<20260721082728.74142e6c@kernel.org>
	<al_4VWS_EyyZLe8z@devvm7509.cco0.facebook.com>
	<20260721183256.6f49d6e1@kernel.org>
	<amEEEohxmC8hkBvY@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 11:00:07 -0700 Stanislav Fomichev wrote:
> > > This is about current drivers that only report UNNECESSARY with xdp: the xdp
> > > prog has to maintain in-packet checksum if it changes the payload. I think
> > > it's a fair assumption?  
> > 
> > What about decap? If we decap the header that device validated 
> > as UNNECESSARY there's no possibility of maintaining the checksum
> > (by which IIUC you mean correcting it in along the payload changes).
> > 
> > I think we'd need some API to "decrement the csum level" ?
> > Or some heuristic in the drivers to decrement if the head moved
> > by at least len(IP+UDP) into the packet ?  
> 
> True :-/ I guess one more case to document?

What would we be documenting? That it's a known bug and we have no idea
how to address it? Or am I missing something?

Again: 
 .. the ask was to sketch out the plan of explicitly
 updating/invalidating the checksum even if we don't 
 implement it today
