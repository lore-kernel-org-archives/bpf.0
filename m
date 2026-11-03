Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743294;
	b=gIfRlpwciApGZ7VGmfqqfvOxzNaHb+2y1DSmRwnNgzVLHXHUuIEVLOHuoHfE74t3qckR
	 Rcpbup+5E4gYho+W7urmYVj4/+w0DZHKzANDZEYvEN/8FahDPa0lGFKZgzpVKIu8JBKzw
	 AXBZ4qhW22dQ4z701sB2/wrZnJ0pu7Z20VB4vvKLAAB3tAKAjmUDs9daJeDwEpXhy1klS
	 BIxD6BC0bp/PnsAWUvjOA6/1eeVFly+/gF8KKHk/+XAsLqM1VObcQUx5vsnTZhwwu5gYh
	 Bq0PFTkAKfwxuRNHgJG6wZKsUit3zT4oPCyFlvVQomZ0FS3vgqNvrTvTtR/Af400fLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/vkfVcszp/6CANrfIIkrkEVTtlHbfMcsPJeQ0gMSiJ8=;
	b=xU6lAwmqD/fzoGOz6rojWySULSeZ9tN0MEV9iva79WYLYJ78EP34KXDo431kjOb5Ql8V
	 hAgjKas4n0QbQUcZR4ha+C0Epftgmi3h2viKEfYvakgKnJbZHeTxruwWfd04blpbILYyf
	 Fl/qqG1C9KThbjbltJMTCWNLacmH/EnUAOfhC4dmVsydXFFXAc2usvbS3C2AFdEcvHCg0
	 wWhNL6X9ngF+RHpn5tZ1ittSVSKmE3va2y4QQFj7zxU0zh8qo7iXMbYCC7TEAmh/GQrpE
	 FIDYF22KhBveyFnt4qztNXLPlT+hK8r1XuMdlF0Gfr9XwUnbjt1WcjgzUHiBs9dDMvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HuitUxjF;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B4606A33D
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 22:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 954B4606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HuitUxjF
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df54150dfso39140f8f.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 14:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793743292; x=1794348092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/vkfVcszp/6CANrfIIkrkEVTtlHbfMcsPJeQ0gMSiJ8=;
        b=HuitUxjFW9zovnmjr58SvH31extRM0vbZ7FxRWMk8xhxTo6SLpu9KlNvjdCNPfYr2y
         pnHw1ntDwCu/xCfQHB+ebGVwMioT9M8rkF6EFu8TZWR6TYDr+PjpIQd+6bO3SLOmY5YJ
         CU+4cvH1BeEtUf0/BFLSAmUfqZztW7C9JNc9wsGU3VOSx5Qw/4GXSv2TMtonyZiwNKTs
         xJeijkxVJ+xvZylZX3CkCzoZajV5Pxvv14TMQI88x4ejMuxEtqLQrqvXa/Odn7Ht/Ers
         8qflXRVVMlCxgRyYHYqJYs4WgbkOnx+7+lBby5oqCHk5ccLBSQPX4FH9EXeGbmDjCyUc
         Q7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793743292; x=1794348092;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vkfVcszp/6CANrfIIkrkEVTtlHbfMcsPJeQ0gMSiJ8=;
        b=1UEyyTzniIJWI0etb2MvJ0s1iJTkdXJkA9pdR3ORHas4RgsAcl7Zh8CD0sf1DJEzkX
         MDfclU70FdbeO26SsS0Qf1QZfJil5Nw0SXQ2Y99mu8kTLJ4QSTwWempw3AZMF78e/DSL
         SIl4hfEsNyC0CeAACLnyC36+pQup82kWMVpb89rv4RRqf+Gdlv07X6BLeVXvr9UzWILm
         s0cVcX+EB6fxyAvPKfDMvSCAaxaGMlM/BGNg/OSf5EkvElfGfJZ+gfjcaoU7m6KqFp5E
         X+bPJt6AukO16so/XQsD7vFbzx6EZZ4maDP/NavjxUprSHjZo2aMijzX55JURTVIl9ie
         c2Xw==
X-Forwarded-Encrypted: i=1; AKwUvBxtGl4D4BSt0jPHeczslebeJvTjOhC0khi5Gq3uk9+2ZKvhixdoPBBG2Doc/1oPLy60zuI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uhlvhw3Q8prFuRg6iXmnW3pIrLUnd5d4PfxC836FMSffDumSM
	n66A3PxFge4SChzFjc1mntUS/eU68muVRJEozMaYVTT2Gz/AhYa1Ql44
X-Gm-Gg: AYBFou2WmlH/IbjAbPgotmIdOWkjzM8FqYyjgG4RiMUbbqWOc3f/ZNYkbQKXeBbOI4g
	Is1HvyFlIeXN9pSvMDUyuiA+ZJbjBjyrRDe0/FsN0CcCQL+bBm07wYvvpspgPgWAqV69zaiQ8CY
	9fSOP5ZA6uGA4hmCRFCD7dij0cU0jGcqbsGlqNUHMZrdb3WdzzGIwtzbkN7bvZfYIDZcdOnBw41
	qJ+Z3A08qTKL/OQwjjRBPmqYlMnF4MO1p9EQazZVu3LZUVSS0PnBejvMKH6OF6WKy5faAdbSSZz
	D6EN3F/1byrzRWPfsgpGatI4T/TrKgC4EL0wqWBWLQi7o88/w2t7zE07DjJBjutiyni3ewqAyTQ
	gluLdHRs2LOmWkPL2tTm7m2idHjNzZJmeC91iJqukw/4GmnhsvQe4hjrlyZx0PyxdF9uXafzDD1
	RZhHPBn+7lVYOH4KlzNRHXIaDSX/cay1YLUcRuB7fiKCq3FM1qQTF+JYKF76+OwDXL2KrKrWjEq
	lg8q7aapQyxRsVNORUa/Eo6dEyFYejN+9OlSEKdUQ4kglHzTqZukJEPAtr45fThdGywW38PKGAv
	ABf7V7NC64gh1ET0kzw7jCPs3BdDpyTeqVhgVV+HjDrr97Um0Zch0dlFUKDsmpBKiQ==
X-Received: by 2002:a05:6000:1a85:b0:48e:7e1f:8cee with SMTP id ffacd0b85a97d-48e7e1f8d39mr20799656f8f.12.1793743291709;
        Tue, 03 Nov 2026 14:01:31 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac2772sm255044f8f.18.2026.11.03.14.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:01:31 -0800 (PST)
Date: Tue, 3 Nov 2026 22:01:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev-bot+sashiko@kernel.org,
 davem@davemloft.net, kuba@kernel.org, willemb@google.com, horms@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH v2 net] udp: restore hlist_nulls for primary and
 secondary hash tables
Message-ID: <20261103220130.215f0000@pumpkin>
In-Reply-To: <CAL4WiiobvgoNp3Y-6qEh=OV9truPNn1v8-DoqFxR1rx=rpkZXA@mail.gmail.com>
References: <20261030122045.3035709-1-edumazet@kernel.org>
	<179362213820.3131.12108035098960840444@kernel.org>
	<c573bbcc-e0d8-4f43-b14b-09c676a6fe38@redhat.com>
	<CAL4WiiobvgoNp3Y-6qEh=OV9truPNn1v8-DoqFxR1rx=rpkZXA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Nov 2026 14:34:29 +0100
Eric Dumazet <edumazet@kernel.org> wrote:

> Le mar. 3 nov. 2026 =C3=A0 09:40, Paolo Abeni <pabeni@redhat.com> a =C3=
=A9crit :
> >
> > On 11/2/26 13:22, netdev-bot+sashiko@kernel.org wrote: =20
> > > Thank you for your contribution! Sashiko AI review found 1 potential
> > > issue(s) to consider.
> > >
> > > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
> > >
> > > If you believe none of the issues are legitimate, please reply to each
> > > issue of Medium severity or higher and explain why the AI is wrong.
> > > If any of them are legitimate and you plan to respin, please let patc=
hwork
> > > know by including "pw-bot: cr" as a separate line at the end of your =
reply
> > > (one such reply per series is enough).
> > >
> > > - [High] The hlist_nulls restart does not work when an IPv6 SO_REUSEP=
ORT
> > >    socket is tail-inserted back into the bucket it was just removed f=
rom. =20
> >
> > This look real to me. On the flip side the most straight forward fix - =
avoid
> > tail insertion in udp_lib_get_port() would re-introduce the issue addre=
ssed
> > by commit d894ba18d4e449b3a7f6eb491f16c9e02933736e. But rehash already =
avoids
> > tail insertion... =20
>=20
> Agreed, it is real, although not a regression: before this patch,
> hlist_add_tail_rcu() set n->next =3D NULL and a reader parked on the
> socket stopped there as well. v2 simply did not fix this case.
>=20
> We still need the tail insertion: udp4_lib_lookup2() returns as soon
> as the first matching socket has a reuseport group without connections,
> so a dual-stack IPv6 group placed first would win over AF_INET sockets,
> despite their better score.
>=20
> The problem only exists while a reader can still be parked on the
> socket, that is less than an RCU grace period after udp_lib_unhash().
>=20
> v3 records get_state_synchronize_rcu() in udp_lib_unhash(), and
> udp_lib_get_port() only uses tail insertion if
> poll_state_synchronize_rcu() says the grace period has elapsed,
> otherwise it uses head insertion, as udp_lib_rehash() already does.
> The cookie fits in an existing hole of struct udp_sock.
>=20
> The cost is that an IPv6 SO_REUSEPORT socket rebound within a grace
> period of its disconnect keeps its head position, so the v4/v6 ordering
> is not enforced for it, the same as after a rehash today. This needs
> disconnect() then bind() on the same port, with AF_INET and dual-stack
> AF_INET6 reuseport sockets sharing that port.
>=20
> I also kept sk_nulls_add_node_rcu() unchanged, the tail insertion logic
> is now local to UDP.

Is there a different issue that is a socket is rehashed there is a chance
that it ends up back on the same list.
If that happens you need it to stay in the same place (if possible),
certainly moving it to the end would mean that a reader could miss out
some items but not see a different nulls value.

There is an even more unlikely possibility of a reader starting on chain A,
being moved to chain B, and then back to A - so missing some items on A.
Probably just worth noting that it is extremely unlikely.

David

>=20
> Thanks !
>=20
> pw-bot: cr

