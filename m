Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC5D30C15E
	for <bpf@vger.kernel.org>; Sat, 16 May 2026 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778921342; cv=none; b=NHaRwxjDImxNhMm2FyEevSUSgNik3drx8lD67jLvVAPRPfbFxgcXyEB6ZMw0MKuCjP/opl5BeIP77w2gA3ae8KCsoSviCdql5qrwOCqwF3qXhXFadcB4F4zOlMqc+1pO0GxL3QZfqrq/PfIGOk9USyLj6VXFkqzjuf0rpziLPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778921342; c=relaxed/simple;
	bh=hC1pnnTj2YmTbb1/inKjFbYCPrHajsuMGjuM5RvZWq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJFpKxik23ARL6qX/KB3//cIQJ8bRNk7+w2bNinQzKwd5WjoNw0MwRVeVgYBHL2VOu4CWyR4+zVVxTb3Rhp/sarG6YQg+LQt9ug0zEkIjP+1nLqlMCJPyjTWFELIDKiE3TXFnqpo9SS5ADKKQ0YMdLfwi9F5cEU+eWy5hdxXwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKbGWecD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKbGWecD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso3807045e9.2
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778921340; x=1779526140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWDhEh0VUyusmqIuXBpbDsyQkdanrqM00cM/70nu0Ls=;
        b=rKbGWecDs1UI53OJd7gZhuKtYfU/nBwV1WHmLyjSyKXPzXaPy67DXc8cpBdkE0hphP
         PvPQ4RP2o/XBfcVRXowurYxnib9oJpg6f0Gsk8fb3jYItwVGirRdzP1dLlaxaDMM5CWK
         tn4Himm2zGsBethotVCtrs3RtTGYki6syP61pS9Z4lYowhENPcQgaJsMbA/o1UAMBYK8
         F4cIPEEgD2Zks8FfWFJGhfFogRD7hvqdYkoVqdfAfoTnrrUJHs5rtqR1pSZuoCNiQWMt
         wZJrdDRpOpYNVDj7Xe1dQaVcpeJ91CI7nHc/Syijv1H8z3Iqw65ah2dasYBtqbawCVOC
         Fxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778921340; x=1779526140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NWDhEh0VUyusmqIuXBpbDsyQkdanrqM00cM/70nu0Ls=;
        b=fA9L1xw0kJ7aJNfsVe42qgVHFDkluDaQwE82g+qY6En0AYkFV7cVnA2dAd8b6qUosZ
         Lr7lsybhODTvlNaoobN7U6DtAQ40Oa8e0PS8Kd7T4M3+JN/idMwK8dduNon1FOIOX2oL
         pzBxkgSmnjyZKgMjDB5K9qcjMYxZWcDsO6JGDAqlcv6jOw1KR027/TpyoCReh8eWtNxL
         Z5dVUSGHaaAbn18r3cC4crLrqzUIlHshJjyk/608GZhkFi5J7sygdec5HJzzxTIlsQEM
         2erEzKxhEo+AAk3GWnIMWfK2fVk7Javyhkh8dUxAuZ+yHE1+AAJr/GZ+8ypdlqpzL2Ij
         FHtg==
X-Forwarded-Encrypted: i=1; AFNElJ9QvG/+XX6lHfBD7R0hJHtn7+nfJT1mmr8FFYzsq/u9VOh6pSZ822SRikxccV0O2Ry3R9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt7aLg5jEJx7tLmdxp8TFjs5yvFFmc+RLcB24N84pMANweA6qG
	qM6+xhs4ilgiXmkJLgXeAvXSYEulcTwkd6/PKVAFBfwRp3QKKYr93R7/
X-Gm-Gg: Acq92OEm6+wMPOq3cCGvO2QyqXYXnxOvSy2FrRc66dt3sTG3qB953uMnnsuQte2rspl
	SG//AJQb0Ho3ohaxlMoelIiK2A1glVe4VovLV6KR/Rr5h0fj3BqkOnH//PS2VNBoLX9ud8/5Iz4
	DAlE8En+pBkYgs5WrqV3pyYROyCU/wYOsFnCVde45XIG24XITcD4ow+EvF3QByBfKMAdw1SirOm
	r5U5Qo1pEjD3/0YLIB9uhYyj/moRadsdZqn1aup8eSRaMbIyE+1+SjP0O7f6wE0iOk6jeSd3ThK
	cfv3G8NACwAMGk9IpCEkoAKoqxOMCaiwqiZT2jv6Mms7zKZHqxIXmI31YiAYpA+gb9WZsz9SH95
	01yu5jCDS7mQjPlvDtY80EkO8ZdPCE2jWD1Jm5jEsL2IOqPAQTSIpRrNFUDIVElF9jmoRdEwcbm
	Fn0Jo3UP/PJPiJ9Jw8sbab60pnmU8MjUVSxYMOP7Pw5DOPwzsjclC6IA3RN4ku
X-Received: by 2002:a05:600c:4e47:b0:48e:8345:6f8f with SMTP id 5b1f17b1804b1-48fe632361fmr105367375e9.18.1778921339454;
        Sat, 16 May 2026 01:48:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57943b2sm116227845e9.8.2026.05.16.01.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 01:48:59 -0700 (PDT)
Date: Sat, 16 May 2026 09:48:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Arnd Bergmann"
 <arnd@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Martin KaFai Lau"
 <kafai@fb.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Simon Horman" <horms@kernel.org>, "Stanislav Fomichev"
 <sdf@fomichev.me>, bpf <bpf@vger.kernel.org>, Netdev
 <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: test_run: reduce kernel stack usage
Message-ID: <20260516094857.2ad1c850@pumpkin>
In-Reply-To: <20260515193804.4d85283b@pumpkin>
References: <20260515113102.2389020-1-arnd@kernel.org>
	<CAADnVQLYitAZVpXCTygA1uAUtN6m8pMkWzFi9su719M=nktmQQ@mail.gmail.com>
	<b387dd31-0ee5-41b9-b07a-13b718080e89@app.fastmail.com>
	<20260515193804.4d85283b@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2026 19:38:04 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> On Fri, 15 May 2026 17:15:46 +0200
> "Arnd Bergmann" <arnd@arndb.de> wrote:
>=20
> > On Fri, May 15, 2026, at 16:47, Alexei Starovoitov wrote: =20
> > > On Fri, May 15, 2026 at 4:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.or=
g> wrote:
> > >
> > > 1k?
> > > pahole -C xdp_test_data
> > > /* size: 192, cachelines: 3, members: 9 */
> > > /* sum members: 120, holes: 1, sum holes: 56 */
> > > /* padding: 16 */
> > > /* paddings: 1, sum paddings: 36 */
> > >
> > > what s390 doing to make it huge?   =20
> >=20
> > I think it's a combination of cacheline alignment (256 byte
> > lines) that leads to padding before 'rxq' and at the end of
> > xdp_test_data, as well as CONFIG_KASAN_STACK that increases
> > the stack usage further. =20
>=20
> There will also be a 'double stack frame' in order to put an
> aligned item on stack.
> That could be slightly larger than a stack frame and probably doesn't
                                       ^ cache line
> show up in the figures.
>=20
> -- David
>=20

