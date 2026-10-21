Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585914;
	b=rhm8uHxUVX0j1uf5uFNuNh1utrNQlhV0ZhqweO4Vg7SZ+HpQK8BZiDGd5WygIooHvcne
	 Ak7wSY6+fX+4N0R/4i+EpZRtdmcqnyleWaajPHmvmJVyXmsEkvSCusfaNexJI/lz7B3ug
	 mChOZ6qZLfLsZN5KRGjipuo4D4n7YtnXsTgSQw1lqs60kmuHNuzOuWza/RlWDvWxvXzrB
	 vr+a8CjT5UAy4iuvHFGKV6yiHI031HOwdaZw7lvV2u0+BHtdOxxvjXpLkzFv/Cjp09lBH
	 31sGttHQ4bec1D4bNtMq3tWWdlZyhVZ+dE0i3y80n9rbZY88smyZy83MGGNGSSWiDqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585914;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DvokbbwgUedu+R/7T0+nvoQgtbpEqoqXXbDX6qN/PMY=;
	b=oGY0chV/9u1iP40xr+YBg85qxkRMQJ8mcp7CHdPPj7Q3XaNgbwSBOxjc8ZU+hzaSOxc2
	 fUJYSVCraZ7eNsjYI+/eicBxVIXELTytQf2j64NnuXQsjgqtcr3xgGu+TBlbWJIrfuRa+
	 ifQFj8gZ9V0oxc5Ny4beXdThvWT2VaxM4gNAM4PnktzW9B6T4eur4pZBOmYyG0TKLpCeT
	 FSjBxnty9v3p9IC4PQPmw1GtBsMpBoZxxRLtdmo32kEjiOW92opqR5FgyPhIG1fpUe6UM
	 4yu/Ja29lLXPVq5tN+FBSwzl0Pf4AhDzofLldvDO7eijkMfNmf0yX8DC7a8Dubv/7DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epYyEUIG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459C606A322;
	Wed, 21 Oct 2026 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epYyEUIG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6B61F000C5;
	Wed, 21 Oct 2026 12:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792585913;
	bh=DvokbbwgUedu+R/7T0+nvoQgtbpEqoqXXbDX6qN/PMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=epYyEUIG4tu03eofkyY8ffP5iSgRwFlbkSzO7dMBI03AkEcjJ3sjmXW4w1pbNGMM2
	 8Ul5Zs3wpcQ+hemNNGjErsL4dZWW45c+X+09BatBwRn1vVyv+tsHYNvlhwl0dLobmN
	 LLn29m6l0VzaE1JgUW+KfYS1V/02xpsmZfeoMmx0wZXcVoIavS49RWvecoWP7rvFN9
	 pLl7naO3NIyEZlV8iUqk78Eo0v5uUDACB6o4lSoOXS7/G37RlfJXB2Ph9x/hgm/3z8
	 yLuhQExrFmg/CtxYYo230oix1ktpUmMxK1Re7lEElkr4RGTccb4eupZCGec9DDtMBF
	 G/Vwv62Ls+Ehw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Marcin Knap <Marcin.Knap@vecima.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
 Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, "jtollet@cisco.com" <jtollet@cisco.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is full
In-Reply-To: <DS4PPFFD8A841C22E2663DBBA3A1B4F581E80672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
 <ataHK9s/MpNgXWhT@boxer>
 <CAJ8uoz38cE-1diOnih=HYW+ACqq9YQhaM7tz8KCHjTxgZVc+rQ@mail.gmail.com>
 <DS4PPFFD8A841C2AC917618A9B1B19453C480672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
 <atddQ8qN/R1tU1fk@boxer>
 <DS4PPFFD8A841C22E2663DBBA3A1B4F581E80672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
Date: Wed, 21 Oct 2026 14:31:50 +0200
Message-ID: <87ld7r6xqh.fsf@all.your.base.are.belong.to.us>
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
Content-Transfer-Encoding: quoted-printable

Marcin Knap <Marcin.Knap@vecima.com> writes:

> On Tue, Oct 20, 2026 at 07:00:47AM +0000, Maciej Fijalkowski wrote:
>
>> Please don't top-post on MLs and configure your mail client to wrap your
>> lines. Kernel people get triggered by this :P
>
> Sorry for that, I was trying but not good enough...=20
> cannot setup this on web outlook and I have blocked every other client.
>
>> ZC drivers are supposed to break processing and yield cpu to
>> application when xsk rxq gets full. We didn't want to expose
>> particular packet multiple times to XDP progs as that might confuse
>> internal logic of progs. Therefore we drop the packet in the core and
>> let driver side know about this via ENOBUFS return value.
>
> Thanks, that explains it and it makes sense to me.=20
> I will drop the core change and fix the
> drivers that free the buffer again after -ENOBUFS instead.
>
>> Marcin, could you re-iterate why Jerome's fixes were not enough for
>> you?
>
> This is how I understand this but I don't know this code well and I can be
> wrong.
> Jerome's patches stop mlx5e from releasing the same WQE buffer twice
> when a refill is retried. They don't cover the case where the core
> has already freed the buffer on -ENOBUFS. mlx5e_xdp_handle() treats
> the failed redirect as XDP_DROP, skip-release isn't set, and the
> buffer is released again when its slot is refilled.
>
> xp_free() only catches this if the buffer is still on the free list.
> The free list is LIFO and refill allocates replacement buffers in
> bulk, so the buffer freed by the core is usually handed to another
> WQE before its old slot is refilled. The second free then puts a
> buffer that is still in use back on the free list, and the same UMEM
> frame is later published twice.
>
>> Would also be nice to align mlx-5 to -ENOBUFS case.
>
> Will do, I have potential mlx5 fix (this was my workaround).
>
> I did quick analysis with AI tool and it sounds like all drivers have=20
> similar problem and they don't handle -ENOBUFS correctly except=20
> Intel drivers needs_wakup path. Given that, would you prefer the driver=20
> fixes, or do you have any other ideas?

Marcin, FWIW, we'll discuss this topic on the office hours today [1].
Feel free to join! I added a link with suggested wording for a future
doc [2], and asked an LLM to audit the drivers [3].

Bj=C3=B6rn

[1] https://lore.kernel.org/netdev/aqPxxX9MeGmAqGy6@boxer/
[2] https://gist.github.com/fb-bjorn/d6835c49650bc3433b427a9c9708fbe2
[3] https://gist.github.com/fb-bjorn/181786547c4dd8182ba09e23cf394dbe
