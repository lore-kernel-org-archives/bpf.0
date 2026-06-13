Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8252032D;
	Sat, 13 Jun 2026 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390874; cv=none; b=AAqZ79UF672hkLkFqH5JCkhdioLgVR/IkiWXB+JFJziE6jPD3mIkKpX5zhAWJgAXQA/a1dGhXWZsCiNYIrgoqLucAhXE6eKjXxkIUu9FixiHIvpwWHUIRWXAMxD/+AQ4pmto9UjZpjsuyzTQq6XM4Wyzy2kM9wi5htbifUfhjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390874; c=relaxed/simple;
	bh=+jkWcWAyt1Gmd921batUW8VyPvIYZBTgCqPv0MLSDOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lr5at+Ny+PrWcpg43vMyTjhEFW7pY+sqevIAMEFswLhsfa5Hbd10LkeDAyX0VeV6X3kHtfYBI6iuJgX+Ane85+466QG0sJZuBZGxMd+n7bPlX0qMbgKMj+/7fj8eqk0zDcjrXjbZaUH7TXffrkQMYthxcbIWyOENDl1I8ISapeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7zpgD+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7zpgD+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677FF1F000E9;
	Sat, 13 Jun 2026 22:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781390872;
	bh=/VshbjM8bBu/lS5huDW4edOlGHJQX64Vdzk3casHMn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M7zpgD+/JjCsTRa2fubb3P4y2mGOaynWJi//uhYazy4YIVhkRQHhEo39Y542n8ca0
	 w9rWmc4cwyKWFBOaEAZj8PrGXmWwsoyRIE8KFbBRsCq2m4WnePTm9Qka8mmEHvo8cT
	 ty8MeqyukiM7tV/PQCfRr49qgnZaRlq2pCdHghOGBxTwvF4iHND/30zOyBvau/B6c6
	 RRxUMbHMFRKdHEKELaihW9XzaeofRO2V5JS4Jmd3a6TfDu+rfngoU4sxi3NxTJM4Cd
	 tMJ8cKFLsZjeZSuVyITBOQDCd7Fv0uSHd8WrTupjSS20T+VThmdg77tkb0xLerF8Uj
	 glKk9yzm3dyqQ==
Date: Sat, 13 Jun 2026 15:47:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Stanislav
 Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next/net 0/5] bpf: Support RX/TX HW timestamp
 proxy.
Message-ID: <20260613154750.0a2355a4@kernel.org>
In-Reply-To: <CAAVpQUBP_21b5MB8MS-wFwg9BUdcgMoNxi8s479YQHH9g5ahCw@mail.gmail.com>
References: <20260613010039.1362312-1-kuniyu@google.com>
	<20260613102041.55e3b50e@kernel.org>
	<CAAVpQUBP_21b5MB8MS-wFwg9BUdcgMoNxi8s479YQHH9g5ahCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jun 2026 14:43:46 -0700 Kuniyuki Iwashima wrote:
> On Sat, Jun 13, 2026 at 10:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > On Sat, 13 Jun 2026 00:59:57 +0000 Kuniyuki Iwashima wrote: =20
> > > When standard socket applications are run on these hosts,
> > > a userspace proxy is required to mediate traffic between the
> > > hardware and the applications.
> > >
> > >             +---------+                 +----------------------+
> > >             |  proxy  |                 |  socket application  |
> > >             +---------+                 +----------------------+
> > >               ^     ^                               ^
> > >   userspace   |     |                               |
> > >   -----------| |-----------------------------------------------
> > >              | |    |    +---------------------+    | skb
> > >              | |    `--->|  virtual interface  |<---'
> > >   kernel     | |   skb   +---------------------+
> > >   -----------| |-----------------------------------------------
> > >               |
> > >               v
> > >        +------------+
> > >        |  hardware  |
> > >        +------------+ =20
> >
> > The first patch looks kinda nonsensical but then I saw this diagram.
> > Looks like you're vibe coding an integration that makes it easier to
> > treat netdev as a slow path for a user networking stack.
> > Please tell me if I'm missing anything otherwise add my nack if you
> > repost. =20
>=20
> Hmm, what would be a better way to tell users that HW TS is
> available on tunnel devices ?
>=20
> Other options were 1) add attribute to tie the tunnel to a physical
> device and use its ndo_hwtstamp_set/get, or 2) add bpf retval
> hook in the path like update_socket_protocol().

Can you explain the use case for HW timestamps on tunnels?
I see you have some diagrams in patches 3 and 4 but the motivation
isn't really explained, and we have 250 patches in the queue still.
Not much time to play detective right now :/

> Or do you think applications should handle ENOTSUP by ioctl
> as soft error and always set SOF_TIMESTAMPING_XXX_HARDWARE
> since the underlying physical device may support it ?

And explain the deployment model and API semantics you have in mind.

> Anyway, I'm happy to drop patch 1 for now and explore options.

Not patch 1, all of it. I get the feeling y'all are sitting on a pile
of Swift related code that needs to be made upstreamable. Odd series
like this make me think it's never going to happen.

> (Believe it or not, I haven't let AI write code because I don't
>  want AI to take over the most fun part.)
