Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D081C84B8
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773795466; cv=pass; b=iGV+Ub76NLIV55QB3jrExtohETShzTo6jvnHCCDyv9WFdtOqAowekW+Gd8JM7QzXcFpZFFxOu/ogsF0lzuA2sXd7efP1Oz5+kJbn5y7wIohsU/uz7ouZWvnkdUBQ5VGM8FsJJA/YgzJRenMfesXuCHMZHTrTBfVe1W5tipRHaEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773795466; c=relaxed/simple;
	bh=zgBpJG/2jqM+9Mm93fLpe4VYFDz667Cipkzkcf8MrJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqJU755No5Q2CBoNQb+wYZmyxACgesTBVv56IhB6ouehIoHn7vBbaPFjGm/PyZ4dcf1yBpuQL/EvpU/ixwjMI14aJToHAJ+mxqlQcYqHf2khr1tGGID5bkL5hIH84U8e4j28ZHwgyvFdVlVTu1oz4BDX4tg5PGDEZL1u4+d5yoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7u9Ifj/; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7u9Ifj/"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b6d9c981so304226f8f.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 17:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773795464; cv=none;
        d=google.com; s=arc-20240605;
        b=lTr8wJSZz584zL+w53c3W8HP4fMEELMgTDwH0pA6BjrUpoxT9NRUWvKuvRNeGI1Ufw
         JGTcLMAG7dPxQ4eQ/WWvcjHWeOCRjhiR+/yqhv9S+PQs1NKPTwiXmSadeSFWQmsPPidf
         Yr8+jBLCRgKNzbeQXb3BrJSF1brbPHrD7aY5gxkjklyWIAr7z45L2I/iWuL92gPFXj11
         SQuObvAYszA6zveTD05bu3mqszEHsS5wRD9rCLxd9QPgK60v/aqVp+uBKeo3sfL7xPWc
         XWzezd4ewdg9yaiXvoi4zVhuiuSzpG2ZdoIpaK3NtbPM9lKbrzjLVxi9+/wh9tuPD9JZ
         +OdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zgBpJG/2jqM+9Mm93fLpe4VYFDz667Cipkzkcf8MrJE=;
        fh=LTuVRsCirhBM6rC/muoZsJwT6c+cTyObwthlx25tTxg=;
        b=kNb9s996YRrO5uaasSPldrC85xc3y+dEj3P3/i3IP5XcPHl3wG/LdRVAhGC6M3O4c+
         Udq3SAmr4zvMiZxArU38J7CvnWGx6V0pRr9yHPS0Q5JODEx7Hlc/OjqaUu5NSUxzEATd
         /IkdObqWo4QoKuAOvxtjcMSpb+L0A1OMQRfXM1LUAdTWRtL/SAK0VbG8XxI4vn3mIaeq
         flKOMfxf31TvlCQxil+Xk7TAScIlHJbdmMC5bFMsNw5j1ICubnZYl5kVnSEXhrk6MMZA
         KXFl49rNl4zEyz69/C3l4j4TIE9GpD+N/10fLnmiYfBkQX/BVKoWPBzQnn+/fzsLD+yT
         Nh9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773795464; x=1774400264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgBpJG/2jqM+9Mm93fLpe4VYFDz667Cipkzkcf8MrJE=;
        b=k7u9Ifj/KiXDYt5AGm8rpGNVuaW2Clq1UmKdb/6Zf4x+CReKfLa/dUxOfcVtYvBLS6
         NwP945ya+T2OUBiQZaKWUCHW/xp3rEJlWgETwGFmtv+5TXj0zk04BbvUsBsVm57JtXSX
         TznuXv+8vlv/mGRPq7zDRboqwqyJw3OLXfCluiFXVHqYTBO3bZG/p0t7MOOyKe+GeZ7+
         AMeeWTWlxR4cI9LCSzQpyxXancUTxHMn0Syh7FqZIcMhXcU+kzzH/mc0pR1zXKhJjNmt
         t2/jy9m1kuwYejmfC31jPI/u06qxkvT1WcRmXHhSZpSpO3wL2ar51IENQK6vAwYwZa9v
         XA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773795464; x=1774400264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zgBpJG/2jqM+9Mm93fLpe4VYFDz667Cipkzkcf8MrJE=;
        b=iP+aVMINZ2kuknOoSrVUBoCpmO34eM+v3CrbIolkiWAnmbEcejoq8kcSauQMQHU52K
         vYABTlloeD8KPSqBnmNrJsDILUZcoipS/Zj18oRBE54CDPKfC9OSecUKMW4eZYTYoFoq
         tawbiW1s3lrexsVvsD12CY9EEN2NhR+SWshOPKM1xs7tmDlOKW1IBVFkXAnG4jfy9uNd
         DQ1yksGVYKNprSAnKt/SBMiwdM6SeJ3FPtxMKSev2Eo92HwnNADlU53Pk6w2olh0s6Bz
         QYrGOQh/3N4ud0qtr6FeRzYOB36qCLM6Kp626GEOnZOyTRPVC2mri5snCpjXax8+GWGU
         y2fA==
X-Forwarded-Encrypted: i=1; AJvYcCWdEZeJK9ZNtoWEhiJx/AEbt+0vsVyN+Rwl5USVcg/jqQD1bt7JbvbSKa8sFHR01+3Rp8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYIGw+E9kbmYcK6zPkUKY6XaejOH+i38uxyJ2jHKkDrDpbLoGU
	zc1e6VAbtBwiVRg6WMhFC4pv1k9oJ71hXnOU5Lz+I1LwPRUW5rCvAsdqM0EZFKkDzn7sc4xcU0N
	fiFPt39rAjdgtAzoBRmPneLktRQCoK8M=
X-Gm-Gg: ATEYQzys1gRB8tQTApmpOzCknW/BvzFWOwJN5KYmkZ8p2ANBiIl3Vx9ryQ84IBF5azx
	9R7tesVgLbmAHTkw2pRFy0+HI7zCUc7ZeLoOiRVdCGTwZa9o80DCC+sxqWFkUea5zeg0pUtNZQy
	1rTWaB1+wknAafx36R6mKuIuj37ILqnTIYIh6Z3iGClZH/LK4SAy7yK1OE+Hor3AL9t59pw1huh
	HP46cIcOhF0BIfQOfMk2czori/IpsBDi6xnv8eTQeHwCNr1PN7aDFUWI1pPY00macVxt9WtAqGW
	PVO+1IaZ3iIviNfUFDC0cmg2e6hoaIUmRoL5NeYVDhU+UMjl1Z7Kxxy+/rsjSBbdbn3y9tiIddN
	0wQeHlSJRrDGVXLboiuZn5Ymcrg==
X-Received: by 2002:a05:6000:144d:b0:439:adc3:f0e7 with SMTP id
 ffacd0b85a97d-43b4981a37emr10343567f8f.9.1773795463711; Tue, 17 Mar 2026
 17:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
 <20260316171200.4b8a96a0@kernel.org> <CAADnVQJ=nryHHb5A3r77H6dzg=vzC97eHe8mCeBA=BMxa=+P5Q@mail.gmail.com>
 <20260317152045.58c719a7@kernel.org>
In-Reply-To: <20260317152045.58c719a7@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Mar 2026 17:57:32 -0700
X-Gm-Features: AaiRm535rY1ksCmYjCVo8Mr_kBCyfeLnf6hnp14oRGDNzNgMiG-yzjHw7PLCL6Q
Message-ID: <CAADnVQLZOUMGxNDwxhRzfx4finsF3aua31cggKpgTA6h0pjgAA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
To: Jakub Kicinski <kuba@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 3:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 17 Mar 2026 08:09:08 -0700 Alexei Starovoitov wrote:
> > On Mon, Mar 16, 2026 at 5:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Mon, 16 Mar 2026 15:05:57 +0100 Maciej Fijalkowski wrote:
> > > > Commit f620af11c27b ("xsk: avoid double checking against rx queue b=
eing
> > > > full") addressed a case in copy mode, when working with multi-buffe=
r
> > > > xdp_buff, where we were peeking onto XSK Rx queue twice, to find ou=
t if
> > > > there is a space to produce descriptors.
> > > >
> > > > Adjust ZC path to follow the same principle.
> > >
> > > Acked-by: Jakub Kicinski <kuba@kernel.org>
> >
> > Do you guys need it in net-next in this merge window ?
> >
> > We have nothing in bpf-next/net so far, so should be fine
> > to take this patch into net-next directly?
>
> Somehow __xsk_rcv_zc_safe() landed in bpf-next/master f620af11c27b8ec9
> So I think we have limited number of possible moves now :)

I wasn't paying attention. We can revert it in bpf-next and reapply
in net-next and probably route all future xsk patches to net/net-next ?
since it doesn't have much to do with bpf anymore.
