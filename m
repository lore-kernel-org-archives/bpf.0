Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C9F126F3B
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120155; cv=pass; b=ICtA+u6bodcSbPmnXyb73e5PdNUEdKeixiK7sv1HqeBKPzI2HU9CrVP8XomUFhYpZHOhPsxfGuPX/HFdzQBxv3coXpDtzoOd3Ue6xd5R7xhwp1ed0dHc4H89flY9WxfFU2yyOWA1mLYe2PMao+GsSpeguzYWS/Xp6WAwWFv4ahk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120155; c=relaxed/simple;
	bh=jM9PwiiQynGITYHYFLNni4XhleNwqbUhOvoE2PXT3FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLtRAUQ4Ky5a6ZaeLRhL9gaGJ1nq2/4em5z0Th2chYpGW0aHS9bSKsWYWnbNfbiMma9ey1VdlaeSKGFNZOOsDr9xjM/+V9zttnb3hRDOm8j9C7HcVXSm47ghALmlY8yCLs/06bMVE6kSotgMApVQKDmBeCgOCmkgHrd6wUgHi3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=an1B25Co; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an1B25Co"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439a89b6fd0so8996944f8f.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 22:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773120153; cv=none;
        d=google.com; s=arc-20240605;
        b=HErOV1Sg7NEDXpNQiebfgK1HOdml/l3XqAaV+w+dCnFIKrWhZnDhPFlUlk8yafvlxH
         f4gkfvjwIIeENgyBTA620m5h3H3Kx096aocU7vSjyl8JHAp+//c+Qart0WTBWgXNrnIo
         I+8fJkEKm2MNqljdckoGNvdIyYIckMMseEfikAkQCZUBTfxGEAOo5dSaenRoR80XsIPV
         YwI5MDYjtO40uWUeE5H++pKplBxBB0iu9u2smIM9KrPT55trlE7mFEXacxN2AKiWL2Rz
         +TaoaFH1q2haN09xf3QyZGOrU9sDkOwJFy8xGF/k7+hOUOS6gGwrzKKG2G0+TkC56eLg
         1roQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=78TInadM9x0h/wvk/GOVT+2sKYzOqQst62uIVappd4I=;
        fh=BmyjvHrz/kRqjkr6QX5mlNO9bE3wxBMhUTliQSrl+1s=;
        b=hjqclJdCeky6w53WKIJS0i6itrPZeKDqaF9H7Mq0xyPYpzddhpkwLU1uhGJdfPhxkO
         dB9f2c36GcbJttyUBr5etgXXWtrCMBW7BoB/+PyMtvgUM/cfK5Q82ZWTCAbQjyk8FZif
         /XDK62aVKbZtbx/DhoFWK5EWkPxrXSRKl4TDvW+s9LxGJo1BG8+b8kzfBShqnsRQqQRx
         6as4cuCnPQFeXBd1cGoxErB08ELcYU3DZUoyA0BFhKbOIo2jCh+qqnif1NEsUJXfAnfj
         mIXatJHRD8AL9M75eB01X2PJfHsgZ0PZruBJRRWYWd7ABiqFzVz68s/1dxvzI1+kZtYV
         htaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773120153; x=1773724953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78TInadM9x0h/wvk/GOVT+2sKYzOqQst62uIVappd4I=;
        b=an1B25CoWOeo0STLoyJqkZnd9WHqgcnT+Z0HkGvEfUVEO5Xfis55Gab+0vd1VFlfJW
         xxj2F3Vnkdwy2mXZPmv8N4XnjcYHc4+kTJ3pynmvBzDanx/KcwFFeZnoHOYW/2k+TOqX
         SOAbQaar2YPzPed5JS4B52ulMRAAX+fOAoRl+jGoGDyaeHAEcSYcb4Kq06h+tmXsAXEs
         PHy4aw3SU6DiGDNOS7OtGZ+joJGHRAnBraocabxsbFNWhp3rUlcIvM2pxzkaI+816un4
         2vgahWwIC5Dubun6Z65Zm6MJhDiWipD4u9LU7Duvc8cJG757vu2sRViXbnnuHAboqvA4
         z4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773120153; x=1773724953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=78TInadM9x0h/wvk/GOVT+2sKYzOqQst62uIVappd4I=;
        b=dGrj0koVyqGHYJpuUx10ne0r0WBUJaGXeBGMP/G5Lz5MwGXS253PozWQTmsURcWxZ/
         0jZ0tNNEeEazfkoD/Sp8JnyHxdUrxmrcdSG+0gbkhsx53VjTI9iMADPg/zAC+9W4ysgW
         pMtFJkS9J2Yh8vKVyYUaMKOqhxellg2WnD4B2oishx31XqpqNTaA6QSGDCQHUQM+hynH
         HZndI5DGVS4dSdvF+/evtIQRmB3PbXRDSeRxJHsqm7conAzuG/XAzTrunhktuIPhBpOL
         9g+mGfflpGfiT9WS57FqsrNfjvLK4L1uLYtfXWCAKEqzMU3ubTb3CBYU3+SEAZKUCN7t
         0DLA==
X-Forwarded-Encrypted: i=1; AJvYcCViSwXIRw06BqkV6Tgh0CK2TL7D6JTQ580RwKL+ocNGSfwWC0uNUEWDursVUXi9UvA1RFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVsApU2Dskd8iHV2x5gkClg0I3xO+9fphSew0w830WgmnWsLIp
	i9a26JjHXCDr1TKsdLT0ka7QYJr1B95d3HJ/VIat3mX1es/Lb4MvOe7ThT5ifJHgllmwfwoyRHF
	y/TGnwlK62GAhto6X23XAkomxQ2Tig6Q=
X-Gm-Gg: ATEYQzw9l+nGU6W26v3InGsDgHWTlupsjc7bjfU7lWcRGv/QMjy7dFNjAFmp/+malXz
	u1CCxol/iHFCHo4bUK4K4QemPXxlxyRA9ncb/ADCcnYiu182QSHQLigXsDEntagxyyvaXchJyOd
	Jnoi036Qqsp0pil21j072TDvZ9QywNzYIZk2kQRyHY97UuAKpBdMh1XUeBC9iHv5pTQDThQLGx5
	OjGSV6no+rMwmEw/AJEvqX2XgOB4B80/2A6d8VrvzBuwHdeAV+Xp/8o6OIwoAUGrwIKvarJGKof
	qjwsOwTLcQwOf4xb+k1ZQoBUAJepe7ULx4T4mP8ZufOsjCxyu0LYthFHhCj1jAvzB7qF8JZWsHc
	nxX2D0+v+PpCTHsMw6XxnA+oJjg==
X-Received: by 2002:a05:6000:24c9:b0:439:cc06:e134 with SMTP id
 ffacd0b85a97d-439da6632bcmr24216366f8f.24.1773120152703; Mon, 09 Mar 2026
 22:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309131635.302424-1-mahe.tardy@gmail.com> <20260309131635.302424-2-mahe.tardy@gmail.com>
 <CAADnVQLyTjCk2xSdvT67kofCJS1cDOMpHdCFfNHrWg9nQMSUSA@mail.gmail.com>
 <aa8W5JfSZUo-Y8NG@gmail.com> <CAPhsuW7DFX1ybTCb3D_+5XpMhOipvKsgKD2X5EtWKAF+SXp4KA@mail.gmail.com>
In-Reply-To: <CAPhsuW7DFX1ybTCb3D_+5XpMhOipvKsgKD2X5EtWKAF+SXp4KA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Mar 2026 22:22:21 -0700
X-Gm-Features: AaiRm53nRzUWu9qVVPBqEfucm5HWnwOKxBva-aA-WzMhWBWGgOkfbBe6hZXElLU
Message-ID: <CAADnVQJp0aykAwZmSj3k=d-=K=fHEHzwx3UZ_DcYC_jr6E5CQQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/4] bpf: Add netpoll kfuncs for sending UDP packets
To: Song Liu <song@kernel.org>
Cc: Mahe Tardy <mahe.tardy@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 10:07=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Mon, Mar 9, 2026 at 11:52=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com>=
 wrote:
> >
> > On Mon, Mar 09, 2026 at 09:26:00AM -0700, Alexei Starovoitov wrote:
> > > On Mon, Mar 9, 2026 at 6:17=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.c=
om> wrote:
> > > >
> > > > +
> > > > +       bnp =3D kzalloc(sizeof(*bnp), GFP_KERNEL);
> > >
> > > AI generated it and humans reviewed it ?
> > > Sigh. AI does a better job at this.
> > > Think about this line again.
> >
> > Yes I reviewed this, but Song might know more on how this was generated=
,
> > my experience with handling kernel memory is fairly limited (I'm mostly
> > learning) but this looked good to me.
>
> Claude wrote this version before the tree wide kzalloc_obj change. If we
> redo the vibe coding now, it should use kzalloc_obj instead.

That's what I expected :)
