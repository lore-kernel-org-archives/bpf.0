Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0773AEF4C;
	Fri, 25 Sep 2026 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363932; cv=none; b=JY3w14AFJ7q77vq84ozg7hxim42T8wz58V1GaZuBIAg7C2Me0asXKTVNfL/iczru9vIJL4gReX5fNbaSly3jIlueJecnV5PTdwKRtjIV3EcDtZXuk8fpnQpnABafMqsXAFH3TPqsu0OwiIm9hS6z46aiL+DGjZTsh2ZMG7829TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363932; c=relaxed/simple;
	bh=hFxATNbuhTxRaoLB71t3y9FFElpJAR1VeH8p9l5w6yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CO6MOMIaD89kNKNTQJ3SyQqHdhRPEh7//7TmfUbEo22qT5266u+s0GmY1IBQmmlrTKfAmfwx97xeTx7+PJhzmhPzQqx0AWd4CphTxILubAryOAfnzJu5Jc8/eXNOm2/WrGfS1n1QTpz9pXRbfHfdut7+a2QgkTMTMY6CqSyYPKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvWQ6e9g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvWQ6e9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B0A1F000FF;
	Fri, 25 Sep 2026 19:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363930;
	bh=qq7qh2o205/vpx0R6keJ42w1i2FtZ8yCrm4A0MjiE9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dvWQ6e9gJMPPr1SIZH7zxq/Xw4Wwc1tEGZtNOKEOP7pcfOPTD/CGS2hKZhjyKgGTA
	 MiEo76qUoEWW88ycWpq9PAemmFjessIWs1TdrYFGCiXZOKAQ2f156KnOuMSY1uDfoJ
	 xvV5ccgZ/jg1pcHQPuxOMZHynfAGFrQ8q/zsNX7FJwdHEHS1kMc5ODgk5T1vsOMOYM
	 Pek/mBR6Kr4ALpNOI50G1XO/btDDs0QyUTkaX42wBNwdLouWySDHJOY2Penjw7b1oK
	 zftujMGnaDX4TG+OfUQDiSSWS9GX3WNq2Tp3z6HD46HFfLNFybDk0BelGfHXC7e0tA
	 2rAOnz7D3bxCA==
Date: Fri, 25 Sep 2026 12:18:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Jakub Sitnicki" <jakub@cloudflare.com>, "Daniel Zahka"
 <daniel.zahka@gmail.com>, <netdev@vger.kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, "Stanislav Fomichev" <sdf@fomichev.me>,
 <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
Message-ID: <20260925121849.2ac5150b@kernel.org>
In-Reply-To: <DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
	<20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com>
	<DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com>
	<87fqyypp67.fsf@cloudflare.com>
	<DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Sep 2026 01:07:47 +0000 Alexei Starovoitov wrote:
> > I've implemented Alexei's idea of skb-lifecycle tracepoints that run
> > only when an skb is marked/traced. Currently putting final touches on it
> > before sending it out for the first round of feedback. You can take
> > sneak peek at it on GH [1] to see if it meets your needs.
> >
> > The CPU overhead is lower compared to the skb extension, at least in my
> > local runs, and the kernel changes are simpler, so it seems like a win
> > overall:
> >
> > |                  | gated skb tps    | bpf skb ext      |
> > |------------------|------------------|------------------|
> > | **busy**         | **+5.44 =C2=B1 3.16** | **+8.01 =C2=B1 4.75** |
> > | sys              | +2.62 =C2=B1 2.06     | +3.67 =C2=B1 2.76     |
> > | soft             | +2.89 =C2=B1 1.43     | +3.83 =C2=B1 2.10     |
> > | ns/pkt @146k pps | **+=E2=89=88 373**       | **+=E2=89=88 549**     =
  |
> >
> > I'll be giving an update on it at LPC [1], if you're attending, and of
> > course will keep you posted here on the ML. =20
>=20
> Well, the numbers speak for themselves. I think :)

Instead of improving the existing infra we're adding more BPF-specific
glue and another bit to the skb. Matter of perspective I suppose :/
