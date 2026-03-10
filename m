Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A45338BF80
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773119266; cv=none; b=mV4J1tFwyXIiMEkzzozB3ck7be4z+MgqhwYpTwh4wUpU2HJcR63oiZTP6BIYqdNFnnow1eZS+OPMIJWV3OkUYKdkf1Ny8xL23PQsz/d57sA954xUBpRC/3zez8qhZMLVHxecJsSigYsLZaG9QtG+SAlTDhTgZKZSI141evktZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773119266; c=relaxed/simple;
	bh=2nnE/Y/dbS3G31VMdHhq3NfjTNJvU7D/GYMFfYxg1Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIde64V7MtMtbZyZIOl02UKNIHn9caWvjBhQJoZDnGpoII39oYfJETRRiUff9ZjR5XJl+ZcFYi5pcXS7cragp+P9ap3jPVi4DJNy1ywxnT7YGl9w50kAC63PjN27AQDOkOu5Jx5aMdlGvG5tCzq+aaFNnynePdovME+OhgwJrdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcjWGCY9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcjWGCY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCE3C2BCB7
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 05:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773119265;
	bh=2nnE/Y/dbS3G31VMdHhq3NfjTNJvU7D/GYMFfYxg1Jc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OcjWGCY94Sp3dhLNOjMMflYfhZwhbMdFx446hRAis9RnLHg3PKFqH/Gk6/ah5HWZZ
	 ccDyhN/CpZNJZIGj5vGRslGg48KCxAYooWADkKmCXZtGecSa+Y97L2Ozr2Zjcgb/Q+
	 B2AQgxRWIle3B959CF2c7QfiWtBe1B3POQwu7Bi9HHkm5ici/HU/sw1cw2Jk/sKo+z
	 BGUcnD2fpc7je+n5g9Fzg7HCCLSdnXot3xgf6/CY3oE6ZzRRjSXREzV7iyXgiEOFXt
	 aFLUhHxJHUtZdoS4UEbi+gZ5LT2aLqjzpZVIq4txCAW3It3AnIcUgmZpnO+JvZYfaY
	 5O5Uldqni0f3Q==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cd79e43da3so249656285a.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 22:07:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxiANdIw6506pUDE9KYLUTa1pLJ0CGXG1ttRUVolgSIqObzJUAPOhohlC7NHEN+5wR/Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdnlz1y36rwLfJXB0W9pbjsmU5N4GxygJfqk08VFp/43ov8Rt7
	eegUGpTGpT++GclF0hVw45pdcHqGBXJ/3vp4+yibbrrNyGLKhB1QMGNXPSFy37I2XyYWwl3Lg0a
	sfYCDUskHcSeJq+EPnVF1ZjcWLgdjgVg=
X-Received: by 2002:a05:620a:8425:b0:8cd:75d5:5456 with SMTP id
 af79cd13be357-8cd75d55cc0mr1141540885a.66.1773119264735; Mon, 09 Mar 2026
 22:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309131635.302424-1-mahe.tardy@gmail.com> <20260309131635.302424-2-mahe.tardy@gmail.com>
 <CAADnVQLyTjCk2xSdvT67kofCJS1cDOMpHdCFfNHrWg9nQMSUSA@mail.gmail.com> <aa8W5JfSZUo-Y8NG@gmail.com>
In-Reply-To: <aa8W5JfSZUo-Y8NG@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 9 Mar 2026 22:07:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7DFX1ybTCb3D_+5XpMhOipvKsgKD2X5EtWKAF+SXp4KA@mail.gmail.com>
X-Gm-Features: AaiRm51Ty7nAnw_TEpOhVOMtABIM2l8JHQpVr09bQ83ULTWLDCCqF0dZn6mEig8
Message-ID: <CAPhsuW7DFX1ybTCb3D_+5XpMhOipvKsgKD2X5EtWKAF+SXp4KA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/4] bpf: Add netpoll kfuncs for sending UDP packets
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 11:52=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> On Mon, Mar 09, 2026 at 09:26:00AM -0700, Alexei Starovoitov wrote:
> > On Mon, Mar 9, 2026 at 6:17=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com=
> wrote:
> > >
> > > +
> > > +       bnp =3D kzalloc(sizeof(*bnp), GFP_KERNEL);
> >
> > AI generated it and humans reviewed it ?
> > Sigh. AI does a better job at this.
> > Think about this line again.
>
> Yes I reviewed this, but Song might know more on how this was generated,
> my experience with handling kernel memory is fairly limited (I'm mostly
> learning) but this looked good to me.

Claude wrote this version before the tree wide kzalloc_obj change. If we
redo the vibe coding now, it should use kzalloc_obj instead.

Thanks,
Song
