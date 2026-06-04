Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CEE3B19B4
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572656; cv=pass; b=oi/j0gyAMl9LeRmQ/jRuQ8MosSz01sUxQbrrebA5chf138whRFp4nCoWqw/Kvna9tgTUXTApOUvoQRonSvpsFdqmirl0lzSrDDiRrQCOrX76PS94evRyL2SRSVBnBEpwaMYGYGNz94V9u2ugSgy+lBipXEIusj0qOY8kHbVsJJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572656; c=relaxed/simple;
	bh=IgaVd4/D/neWcGaYdf4+CIF4yFVYz7Eh1SsiQPIdiNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqjh+kRICyncOmS1/DIY/TTrQvhUYrinBmwk1TYgzrrY28H0o+4T4bmQBUghGupCe3sy0OBqK42uiIH7MUwwIvNEBhag8+tMiOs3YUPsCcS0SiBCMXErK2JVRwC/aqsVb92j/NFg6FUL+MxKs9wkJfOD6LGbvlcYGQal95OKMpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezmqC2iN; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezmqC2iN"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-59ebcbfb2b0so162157e0c.2
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 04:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780572653; cv=none;
        d=google.com; s=arc-20240605;
        b=JGUytkpS4M2kB65HhDpTW0oBL45fmJhDhkLTAsRhOCYU+blzTkPMv2HcHq2SlbgyMe
         mQ5VE7Jzv/U+pJfMjCBk3RNzSidRXMGV2n4alVpLaCGvQLp1wmgnQSNAWLeRQtg96kNr
         salE4DvTIcC0X39SJ5xn4gid3bb2a7kKCv6IBgWQmDeEErScZ0mKCs5OmxBBmyNlujBK
         hd/Kd+dDydNBH8K5a8fO0v6ItOngeCltIzXNLcAd4Vdth616nxuxJE3sZYXKkH6tTTUS
         lVVonmWH5v1b9w8yP2OHAp44TTrnugh+0Hu09iuuAE+Ssz3zQAu2CcJU2KrSzRr9Qo8G
         alzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fpp7hpo+duJ5Snlj5PG+EfICta9eCWIZjou+VYQUVQ4=;
        fh=0siHEw4ESdxrlySSrRuzRKrT0R4T472MILGEpeSO0fc=;
        b=A5FDW2GuQ8PovWLQUXz55W6vdJ5m1VYhqhCfzIiS/p+9AE3wAOdbiccL/6shQMmUrs
         kZqeotlidrF+5JTAdnOdDutOC0PmHI/r/5ZjUwsUj59vzKQhG5HpkNHChqnRdMjG9XBk
         gZlzP+FLs9GaM36Ke23GS1pnC8aNGw6SqFrN7wIEK3c+EDqWF3jSBhRonGg24+YspmMR
         m7GRY7/UHO+2GNOSFShMYqRUHJ9SAJSdlVou9XGsLWTHjxwrTdY7E5CVrFz58EXffD72
         324wsxgu2UxTc+rDMyWGjM8rMTtfjdDxgIS8W1aPJeQWjXie3O7dNCUSa70W7X6kBWUV
         l/2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780572653; x=1781177453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpp7hpo+duJ5Snlj5PG+EfICta9eCWIZjou+VYQUVQ4=;
        b=ezmqC2iNUUfJwgeZG5pY77k+XsOPGlvqQzmHybpNLf7TgfVbhGzWR/k7Etygx2EpSE
         Z6JruUu6i+sXQ1MdiNIQhWdtKUBevMu8VDIVGDED/svPKd88sD3WWuf3fk9isG8+grfP
         z7luiITciUECenfvw++v6qu+35n08EKbcfbTDepHUszlgloxnAYu4lxHmiJNISX9VVfi
         ccRz1vwWyVrp1N09BchOhOSHIdePyMAbf61zuPrbhf4qJkOn3BCKIrle7JrKLAL1hMzD
         A6UnlLA3ubDJiXX/X+bf+KGPz0FksE0UYBQZ2TTOcZ8zXrdCZo2ulqws8wYwRrqbdVcv
         evpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780572653; x=1781177453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpp7hpo+duJ5Snlj5PG+EfICta9eCWIZjou+VYQUVQ4=;
        b=Tlc0NV8Yn1BHbTdvcH5UfMGS+z6NRBc5Cgv2yfmkVhcvgU8yEWbLV2M3E6h0MHvC5/
         YnAVtCJR8RySpwHxZUjjmFhSj4B1MqqGu5maZrTyHLwIxmE95l9HsNGRvVQ7znvbHIiI
         yOBhpKrqj5i6c1IAJ7yMZia9sdDdnJaoL6re2xytKA+m209jnIcLGUU4vR2xxMk1jNDa
         7NfdEiyjaIfeJnamttXp1sdgG4mtLaeWfz5ZD0ZJk7lxZ4pBSeBJlvhpNnG47uzj84eE
         u4N8b2td+DdBW+p+K35k/79FGw79Q+rPPE5auowUY4LrL9iFetrFdfydjyXg8lvZmI0U
         hEFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9hZ08T+n5BRXZDDKp2T8w/rdUj8BCqGSq3M/W+wX6huX+nWpGxo5nzArYVwT0T84CDWD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy1wFvKsmtcJ7N9juLb7aYf4JabvNSiSg17oWjqbrNEqIXymPa
	ZQRIXTJZHicCXLjQKiaM5Odeegb2y7l4Nje33lhPw99Kfa+cz1B2BmXOhe5E8eMGnCYN6aNeLCE
	/LaVQGIp45dVkLtxrBwEbB6Ogyvn4S2I=
X-Gm-Gg: Acq92OF/c2fRdoDmqAdZFCttogan/DjRR4X+gBobk4EldA5DAwe6BiLU78tIaNnBzeZ
	3ymryqc6GhCXCluyTX/VBACUn+UXwoxxYNTvvSKUMdJYP5wRj4Gj+yJjH4Zg1b14INrbVRXqdIz
	iZ1OMaa0wvTO9TmCS76Dp6+SQ7NlOqdaoxgkg+1c3BvrealqPYw/o38oBbwgtB6jGELDj/jmSXY
	D5RdPubUJQWdSZjZFuUPxwfi7CMq9D+Wff9kyjJ8JdAimiUKW4kQM7DwWCkiVXXB0ep1pIu5YyC
	lQTJjlVE5hGl5Hri
X-Received: by 2002:a05:6122:6e0f:b0:5a0:c38e:61a6 with SMTP id
 71dfb90a1353d-5a6e64b8500mr3995715e0c.8.1780572653233; Thu, 04 Jun 2026
 04:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602164635.62517-1-mail@tk154.de> <e80deefc-8467-4ec2-b61e-6cb064802473@intel.com>
In-Reply-To: <e80deefc-8467-4ec2-b61e-6cb064802473@intel.com>
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Date: Thu, 4 Jun 2026 13:30:42 +0200
X-Gm-Features: AVVi8CcDjNH2_4RpELI_VLhIrfYWmPteT4vvqOayjCSlCrLru3IZfh7g7MR56sg
Message-ID: <CAHzn2R2uvJiJM8UNw2+QEU7yqnqdJqcsDo1gBq8FKRBGs9DsDg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/4] net: mvpp2: fix XDP RX buffer handling
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Til Kaiser <mail@tk154.de>, Russell King <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Matteo Croce <mcroce@redhat.com>, 
	Sven Auhagen <sven.auhagen@voleatech.de>, Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tim,


=C5=9Br., 3 cze 2026 o 15:55 Alexander Lobakin
<aleksander.lobakin@intel.com> napisa=C5=82(a):
>
> From: Til Kaiser <mail@tk154.de>
> Date: Tue,  2 Jun 2026 18:46:31 +0200
>
> > This is v2 of the earlier XDP_PASS fix. The XDP_PASS change is retained=
,
> > and the series now also fixes related RX/XDP buffer handling issues fou=
nd
> > during review.
> >
> > ---
> > v1: https://lore.kernel.org/all/20260524122334.1730451-1-mail@tk154.de/
> >
> > Changes in v2:
> > - Fixed RX DMA sync range to account for RX headroom.
> > - Limited XDP frame size to the actual RX buffer size.
> > - Fixed refill error paths so retired buffers are not returned to BM.
> >
> > Til Kaiser (4):
> >   net: mvpp2: sync RX data at the hardware packet offset
> >   net: mvpp2: limit XDP frame size to the RX buffer
> >   net: mvpp2: do not return retired RX buffers to BM
> >   net: mvpp2: build skb from XDP-adjusted data on XDP_PASS
> >
> >  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 38 ++++++++++++-------
> >  1 file changed, 25 insertions(+), 13 deletions(-)
>
> Series:
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>

Tha changes look good, thank you.

Reviewed-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>

Best regards,
Marcin
