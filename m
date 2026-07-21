Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C14C955A;
	Tue, 21 Jul 2026 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647651; cv=none; b=GEuegWSZeBq5EJsSjQNisF3cmnYcm2dXhM+ouE7hyU1bO/CxAdB3oFsjZH3j6Z/XYFz8N0Kmkrp3LrLlSJjCwNgFFbSDrgbuWRDj1BmKyhGwes1KCEXtiMrTrjkfR3kQ5mJ9Qnj16vp5x2L5zrYrv+NCfcihejwO12bh7LPod6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647651; c=relaxed/simple;
	bh=H5jWaQ0cOa+r/7mLs7Z5fFJ/rayVRPPefk7WkRBdLAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVZg022l98ACsfphfZgHlTzcQQNhHvjDolqOarfQzrq8irQWcduhERFd8pHiQ6DkmsGEQiFYg/lxMB3N+QbdBmTXg92GtG+UCJES0sevuC/w13gNsxpRbNmYnAcFKdJcfW3xoTVov8k9xUhSZrP3KQkXYzouFdQpvaQUelniHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igXyWV2g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igXyWV2g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADAF1F00A3A;
	Tue, 21 Jul 2026 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784647650;
	bh=u4TeXif3XA0edOu5Wg4bLz8wX2a3RQrUFGCChfCYTAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=igXyWV2gARFCsyTb5BOcsDN/NU4C6Tf+kBJtZazDmZj8BBcbTRDGFCFcyaMmILHsY
	 QqOey/xYnRYOCVqSPDAUNArqve8bTEvNwmd9iE0TzAJT5JKrHTjIJm1qQ2ufXT6zMc
	 mLnc7TB/2eN7mCk6wip5ta6L228/AjxK+adP/CgeLYhYs4ZWCcrQ/nuMans0RNf89A
	 wuqRj18TyGw8K9tUR/URpr2LeV5R42JtNFmnrfBUqPI++TcFf39dIRx7agqCna5QJ2
	 94B5fOaMl0dgzAKVyMBO7g3v0N4n8aE71TIwB7tGH/vBqPDxc+3oMg5wo7wfuVT5lb
	 H0hckyjPPn1/A==
Date: Tue, 21 Jul 2026 08:27:28 -0700
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
Message-ID: <20260721082728.74142e6c@kernel.org>
In-Reply-To: <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
	<20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
	<aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
	<alkBnI3XcH0XGjEo@lore-desk>
	<al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 12:32:55 -0700 Stanislav Fomichev wrote:
> > > (although for gve I might be wrong, there is also gve_rx_skb_csum that only
> > > does UNNECESSARY).
> > > 
> > > I'd wait for Jakub to chime in, but it feels like we should just document
> > > what we currently do as a recommended approach: for the drivers
> > > that support COMPLETE, do not report it when the bpf program is attached.
> > > Both NONE and UNNECESSARY are ok.  
> > 
> > I am not completely sure the UNNECESSARY case is different from the COMPLETE
> > one. What are we supposed to do if the driver reports UNNECESSARY and the ebpf
> > program modifies some fields covered by the rx-checksum?  
> 
> For unnecessary, I think the safe expectation is that the bpf program
> will update the value of the checksum in the packet if it touches the data?

Documenting as expected behavior which no driver currently follows 
is a bit silly. I thought the ask was to sketch out the plan of
explicitly updating/invalidating the checksum even if we don't
implement it today?

> > > Also, did you run this test on real HW? NIPA now has HW tests, maybe it
> > > makes sense to route this series via net-next to get the real coverage?  
> > 
> > What about splitting this series and have two different series:
> > - bpf-next: add xdp rx kfunc and related selftest
> > - net-next: add kselftest for the driver expected behaviour.
> > 
> > What do you think?  
> 
> I'd post everything to net-next to get the HW coverage. Once you get all
> the acks we can ask the maintainers' guidance.

+1, and please add proper tests for the real drivers exercising the
kfunc with traffic (would be good to try to send a non-TCP/UDP frame
to try to cajole the driver into using COMPLETE).
