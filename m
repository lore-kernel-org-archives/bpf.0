Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A022357A3E
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911228; cv=pass; b=IoI7d9p15BvDsOmPEg/y1bZSp89WRYta2NwfxQRFijQZnpdBBnb/DVhgETjx6z3WRiGU78/2uB62HpnMLyaOTnUm8MzWaJ/THpJEXtpZxnG8QNXA5jtWUZp5dKhNS7Z/yOl9rWLYhMAla8RblFIFsYISx65AmCQhCbEA+BVbOw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911228; c=relaxed/simple;
	bh=dd0zRxtp37ODPV2FjCMyICsJaP6ly5/n0kZ36rVx90A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/YQkICOxzEuwND6Q32u8aNWhdYse1EWJA/XkLt7Io68aeKSpVJDji8O/U85/eO6hFVTC+pHHIy/5fM7z8lDkMyb7nHjy1KNnSsDXtQrZK3e3WCUrsk9xN5FPcwd7Y0tSjPtz77H0FrIg4Ihmycc38Del+T43SnFA87uL3/wAlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvDWyHOZ; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvDWyHOZ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6676d55d01dso497535a12.3
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 02:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773911226; cv=none;
        d=google.com; s=arc-20240605;
        b=i+Mc5Qd7edGBmcYl8OzTo6nReCiJ6EpcNZm8OkA7t3Del+MsMy+3sphsJr37EDMJSs
         6J5Y+f85ncIUniUdDhRM1gHUgx12DqdKNRxEwLxnjpRoZ6nuOgkRuW+UoEzA9j6tyV0r
         C7Mh/h1B/jfMvamV01UxQmdS0v8O03BtnBDbsRg7ugRz5cBDjtuiNCdXuBERPkACtU9D
         uXTXhag6z4p3VQwg5SHsIhV/hyZsnk7ivBFw85hTYB2YxIiL/TAiVbWBPp2lnw4d0PKb
         wtvJ0288qBMczY9NMDpo2lAF9Hh7I7RYIfAZsJxCvvedNzm23FQo3vsh6cSeFt26cedV
         +E3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w6USoEHlrZxJ2jp3QOzHGRGyI1gx5uY/CFM4RCIFyvA=;
        fh=ZADsPqEgqRcF44Ou56gBJ5jUdCGChIr0/funh20AL2I=;
        b=kF+aQM0q4/RUElAQfa/G+Zb/SGbMCwhea73uCfExwpyo/BlCwR/eu07lz2DxneFkDr
         dbz8JP4Gv5mR442AykEhEy0JrFyBTc8y/WQX0Hh6gmPfFCsu0qvePNFZ+GnQ5Yw7teIE
         aZDZcr6RtQUnw5CglMpFV03JAUVsDS7f/lRxo4EciPuAhrpAbBILeQ9DmPfZSn6Rjfpy
         veFyuHn28BWME0/jt2ilAcXlLFGln3cHfaDzeSa9WEoCNCnmkjYWgRxXEyR5Dwg7yyL6
         RS/P3t1GouUNaR9ogDmLP3G2yUZoIh3TToni6ClXNCr+j8VkBetnrgaqwL41gYe7ohk+
         K9/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773911226; x=1774516026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6USoEHlrZxJ2jp3QOzHGRGyI1gx5uY/CFM4RCIFyvA=;
        b=cvDWyHOZclkyB1u+vxdrzJ9O3c5+bIw25vbKz2fhth8qZj6RUNSsQyV4+7KFYzUlVX
         sM4cbKTMjFZRp82rnLbMmVrQQaPvTWzOeu/OH6HbgU2P9A8qbjpKWsMwMWtMsVAebDoC
         DZT9EpjWqJRWNIxhToryt67BhBy4b0qImBzE/rY19Xj0S9yz5oQ2v7pANxe0JqyL5Bnf
         uLNX2UK+vEX6xrXISRgl4YdXzSgt9p+899VO2PMgGUbo6Y6IN4ZlCNuWqUSR2/mpXd0P
         mpLHb1ccdIpzzVBs6/2yK1Sqf+rnxo/clkKC0soRBXLfVABZUKlvldP6z8oSHp2idqQo
         zhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773911226; x=1774516026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w6USoEHlrZxJ2jp3QOzHGRGyI1gx5uY/CFM4RCIFyvA=;
        b=nhpRYOMKtAxgFl2X1r4Np5OU838iutbcQagSIWfhXnmyf+DVPYkYvexrG5SR9F/GyT
         o+gyDzlTJKv4w15WwSsJQTUV9pTXBJxh2U9Ci2jS1nB4jNWRIlaAtly3y4ezNGgiK83C
         r2QsOQz4RGiv8eHjaSCtrndBI3ckBXdce9XQSqdQyC4Thzj6lwmKav4buBTl3M1fCsrH
         A6NWFjd94k2cFHg7xnYpT766T3GmyL8pwodsPNYAQzOU4ZORht80wQWLPvPxJ4f30D49
         Dda0dUuxBQzv2pM2qOODBY/9yy8Raij+9VPx+iNUVdIRkEhNEx4N9z3pQPrCKvpR7Gmy
         K5EA==
X-Gm-Message-State: AOJu0YyaAPoktjK1Cj56yGgTWDhZqw35fiaAmZ/JzLSTuUyR7fgIoZO0
	Su1bTVlRq2ZxLT70XLqf0OeDJBFqnyeTrgR1q88z5JW9zRX88SPhjVLWz7YOovsz/rPJQkoix7Z
	TRlI515pfToL/lQ6az5sJCcdv7nQ4NQ==
X-Gm-Gg: ATEYQzxy4/zCoL5FAn4kixlJASpqS11SDudOya6UZkLqWfm7B8dPA04yuU2T5syVUwC
	L5a30+8qx1I6/Nuochme4CqqBrciEp6sMSQAvblVz700V80GKyXvWlOG49k3utzfqdmo8ec3QcE
	5pOzjlsQRJ+koq5mW3ipFnlzFCTnslOd2Y2etmGHuuAgqLQxP47mBAmNVEoKqddtdhNaXoRGdNy
	I37zKZyhH8zBhoWuzgJK3K6myBeHQ4hLM7JZQcSvIoh53p0IlUD6GicpZEuyPJgraQb3HH2eRaA
	0sqyT+oOwJyQwUCZ7vEH0J7/bg==
X-Received: by 2002:a05:6402:2346:b0:662:86a7:17a6 with SMTP id
 4fb4d7f45d1cf-667b19810d5mr4368248a12.8.1773911224389; Thu, 19 Mar 2026
 02:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318171906.53174-1-hao.sun@inf.ethz.ch> <CAP01T76ZazpBriekA+82aAFHKSoa+XvnvOOnQRz3XBTvBErygg@mail.gmail.com>
In-Reply-To: <CAP01T76ZazpBriekA+82aAFHKSoa+XvnvOOnQRz3XBTvBErygg@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Thu, 19 Mar 2026 10:06:53 +0100
X-Gm-Features: AaiRm52sAlIIgUwU2qeYDpUiNVE8tjEfcNtgf2HXkaCCI9UHqZhNvDYhfE6JXag
Message-ID: <CACkBjsb4tNgiVKR02R=dkqd6kNWfnyHyFgPMuNwx5f2EUL7tJw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Simplify tnum_step()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, john.fastabend@gmail.com, 
	martin.lau@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 9:18=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 18 Mar 2026 at 19:21, Hao Sun <sunhao.th@gmail.com> wrote:
> > [...]
> > in case anyone is interested:
> >         [1] https://pastebin.com/raw/czHKiyY0
>
> IMO it is worth it to include this proof inline in the commit log,
> since links are fragile.
> It's not that big, and I think it's more useful to have it inline than no=
t.
>

The only concern is that the proof mainly uses `bv_decide`, which does not
provide much insight. But it's not big, I will inline it.
