Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315E436728F;
	Wed, 22 Jul 2026 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683980; cv=none; b=oz/NMlyZzDjj7ffzCxLsgOoecVkJqicd7URVQZt0AxSSf/rsv1qBqss8VJBf1kDGe1w2aUa4LhGgLI36QJ5xHIi5l+lWM6MqnpacHLj0/FmgA9GqVSDx9HbXBqdm8M02pUyhSEnedQdHLpKFOQ/T0J344lgF4HgHpwD3PdJS+z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683980; c=relaxed/simple;
	bh=9sDrFwvxE57IkdRWhuaYlahBSyNttENsNpW2bvMavxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJ+R2QxtE6AZVdPATS24qxqfMRJ39MLu7zIS/G35sviXWMBvW1awbnJNEke91A+1EZS04oUAaLCIW2qWbR8EUDPCO6SG/YH/i4Se0LttBAVxbDTGsjlI6cqOh/Ni7RAOTZzQlif8DOSo9x60lPKnN/TEv7an8G8SIt4BXqj6Dgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxXhpc0M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxXhpc0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F301F000E9;
	Wed, 22 Jul 2026 01:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784683978;
	bh=GJ0tXnBlUAMTn2vLq/Edg9l+cM0LotSgg3TuWENMbdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AxXhpc0MAuyw11QvJ3ZWa+7FkgiGGgOwhWYp0NRErDBuIeb050T1pQu21yVnOOIN/
	 iTO+l+Po6Ckw6SKbDkBL0Z2dFqJJtItMYTQhRNaweADU3UtXDtCwo8gHqbssv0/Pgf
	 D0NS+PQO2v/p6oeBN/rQgz0OkEAxlHX/Ctaccap0Mts6dH2e4F80WW92/+hS7EUfTF
	 7P4xoed3eUGomJSJcMH4o9zz3eiz0p7Hw57A12GI6iPVx4CfYl4fH5YhbVwNgx0iJF
	 DXHH3+BodXak7EzcRKAlWLYF0WztavTDILn8g9LMQd5/9cpaxFFPdoD6UY9tMi1bOm
	 VB8XBeLvS7Ezg==
Date: Tue, 21 Jul 2026 18:32:56 -0700
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
Message-ID: <20260721183256.6f49d6e1@kernel.org>
In-Reply-To: <al_4VWS_EyyZLe8z@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
	<20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
	<aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
	<alkBnI3XcH0XGjEo@lore-desk>
	<al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
	<20260721082728.74142e6c@kernel.org>
	<al_4VWS_EyyZLe8z@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 16:03:37 -0700 Stanislav Fomichev wrote:
> > > For unnecessary, I think the safe expectation is that the bpf program
> > > will update the value of the checksum in the packet if it touches the data?  
> > 
> > Documenting as expected behavior which no driver currently follows 
> > is a bit silly. I thought the ask was to sketch out the plan of
> > explicitly updating/invalidating the checksum even if we don't
> > implement it today?  
> 
> This is about current drivers that only report UNNECESSARY with xdp: the xdp
> prog has to maintain in-packet checksum if it changes the payload. I think
> it's a fair assumption?

What about decap? If we decap the header that device validated 
as UNNECESSARY there's no possibility of maintaining the checksum
(by which IIUC you mean correcting it in along the payload changes).

I think we'd need some API to "decrement the csum level" ?
Or some heuristic in the drivers to decrement if the head moved
by at least len(IP+UDP) into the packet ?

> In terms of documentation, here is what I have on my side, lmk if that makes
> sense, roughly:
> 
> - TODAY
>   - some drivers (correctly) disable reporting COMPLETE when XDP is attached
>     - the xdp program has to modify the packet checksum value if it
>       changes the payload
>   - some drivers (incorrectly?) report COMPLETE for xdp-to-skb path -> unsafe,
>     needs to be fixed
>     - updating the payload doesn't update skb->csum, so the safest
>       option right now is to only do UNNECESSARY with xdp for all drivers

Yes, that sounds fair.

>   - the hw test needs to make sure that the csum is either
>     NONE or UNNECESSARY, and will error out on COMPLETE

Driver can report COMPLETE to XDP, just not to the stack.
I think we can use a tracepoint (bpftrace) or attach in TCP
to check the skb state?

> - TOMORROW
>   - if we want to properly support COMPLETE, we need a new set of kfuncs
>     to update skb->csum value in the skb
> 
> Does that make sense?
