Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C530E82B
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778983132; cv=pass; b=qsIlKoIKru2terIws3wYumD7cVp5US1e6VDjX93H6ENiIphT3PYtan4sVNnA8EMNKymZwXk0kBh8GfbxyOn6n25ca0xp5+WKuXPc+myD6Jp/WeVfiNas3SjHX5oIqqV1XHoB5s9LtR/jc3sCrcpawhGk7gAm0xNfKUD1rpaxx2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778983132; c=relaxed/simple;
	bh=niUzT6v/78AAGMPCyd6s2Gdm6YbdmHLQG49GN1uZygw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnTvbnJcV9bri+iFPPJX9zx5gVfceCpRcyWIGYjDiL1oNdtGoRc/zaCaInxdl3LiS7W7I++HIDMJFh/EmpQ9+3ksYIaTZ8u2rHA7IOaJkKh+EA91gDg5ErNkaLEMM6Fpc0QT48Db7II1hTEwOxQKeuU6PvRupxI9PRBELo8HOP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZfLUHVe; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZfLUHVe"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a746f9c092so2010420e87.1
        for <bpf@vger.kernel.org>; Sat, 16 May 2026 18:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778983129; cv=none;
        d=google.com; s=arc-20240605;
        b=dj8McoG58qhurftYZqtcQ4ZfWnGLrD1NtBnLlt7//r9DIK2V7iQOhcHP8tkfwzRJUo
         33brbxUbNpHOXptFHtgIw/1wTfz0lXd8UjdI0vlduE8ewGj82CZmsTaakB7oZLB3M3RJ
         TJIWtN5jxnwXc5ycVkiMxRZQJPgDkBZ3m03e1vurPYCGb71Mg/fWWygrRLOUsP/KS/Ey
         FAUnvumOvVhZikGtE7kKgjDlaV68Srsni6R7yFvUHSUgQ9Idw8szAq52uaI5TL1cgIcY
         eI/EEbjlZn+s8zC6kNjrSNj2bbTQDWGGnCpkfIzEZxTyVfE8bTlBUIILJDYx1P6ckP2m
         Ztag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ew6sB79joxGr9EPxo3QOB6MynY8a/vc5bdoQGNee/4Y=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=bCQOfWUVb4zQTzaySPzreuM4sLUS0GnyLc52dsOVQgfDRx4lWQLKM1Qeo3Hvq5P0cA
         aIyG1I1Fr7YdbAtzuPtxUqkSBBHVOGBLGciqE96C/HyUd2uj37l5pgnlACcLgCFIU/dX
         61MQKlv+dJphes4qdmaFuIjsnjNggGVF4dtZ7/Iyt/WM2m2r1GSRhOlkHchoyZZh4XMw
         2f28ZjplUvxLABo8jFmiGy0RU8WfinKAhWmu9AlwXz2X5Iq+3YIlxCVk6V/XCxoMUMBe
         R1FjqldfnPgOed14G+SLOTM2sWuwxFV4dzdgt72/Ga05sgFMCdsHd+dhU03tlaKJ7B3e
         6Aww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778983129; x=1779587929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ew6sB79joxGr9EPxo3QOB6MynY8a/vc5bdoQGNee/4Y=;
        b=WZfLUHVeDrYUWy3kzyr+aIp7Nrf5o6ehb/lBvtdchbrOtwjOeNmjA/1E6iFSVKmXo4
         Q1av8ZQ0eH6NOmp5bihhlHRVfkywIKZ3JPipwI8D6wcNKYj6KMD8L2fLE4TXWm8Ip4c0
         TIbyeB476xzC+hWgBWjuq7vXAano343it4WisT87h3Gnj5i6A3U2N+EkurH2VS28ljMZ
         13Y9DABWkUvFGKQ/ao9HF69ImxOq6fyOMZxfpSvOK9elINCFoAnnPQyo5711KPP9QMZI
         RY+XvYreQp7xrGMPQu0m2AaKR0/WEjE7U4Aqea9xpon7Hjvwixk8cuD95/VgOKjBWVIC
         Hz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778983129; x=1779587929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ew6sB79joxGr9EPxo3QOB6MynY8a/vc5bdoQGNee/4Y=;
        b=JtoO6OmgNkdPyeKPbM0rGavXYmZ+NnR/GIg8eWg4HEchqHtG4XwF+qtGHmkniimjkr
         Hq/okJ5JCrdDF5NcbuHJhVLm/4uiiIGP8mHqKQ2+v/e7wLeAzf1EtHr51Ptdq8PqTneb
         n4i/Ml2hYZIyFtfn+zLtVc5BQOlrSM80kZgbcPYZwz99DjL2lACyiUUd5AmIlznvT2zd
         EshX5IFjBPtfpQG8hLClzA8cFCqIL5rfFdDLMr3G4XmbGaKYSMTc1+7f1cRc2ruQ/te+
         1UMi46tAc8C7pKWSITuKJ4CR8Fnx1j+Kmja3uLNOvAZpkKAxseEhZKJkTxQuObPMZoFN
         nNqA==
X-Gm-Message-State: AOJu0YzNWSu4iwRipH6bN8JS0v4e8SRrDeJLHkd6cBG4PgnH7NydYuk3
	Lh8GCEb4bgENa0WM0k4aZDBPwwezV+81jmZzaZh66fDWQRUx974a0234RXweaAmJp2/83HW2TNc
	Z3QBQDZCESQEmcB4iXujJPHGz7hFqZbv4eufVBg3qlQ==
X-Gm-Gg: Acq92OHobOasfC+U6mcosQh0LFZ7zq9RlTnyqMFWwVQOZZ0bLSPP+pUHc5BskK+jkcj
	jbpnfBNf2oFOrA/y2DhUQtyZkVp2hy0UmujzwwykkPZpNS9ySKpklfn9HbU4hbgTwBaiofrwz2n
	XWt5adczp/NwZrxY+X5+rXnhe6wbs+zhaAZFFXdLCUNU182HfPiciVhguYpKWZsK/MBVi5IOF7U
	6H+EHIDu+G5T9gNiI0rt6llxU85R0Kg8sneBbjajP/Shd5EZ5cObF4PuFQ3sCisooZdMEMT/Lfb
	0kWQ7oqmjSmjupErPvMabNjrrwNiSK6U1u1LJl5PciYH0mX+bQ==
X-Received: by 2002:ac2:55a2:0:b0:5aa:e35:2270 with SMTP id
 2adb3069b0e04-5aa0e35232fmr1815281e87.0.1778983128646; Sat, 16 May 2026
 18:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515123018.80147-5-kerneljasonxing@gmail.com> <20260516123127.C4D41C19425@smtp.kernel.org>
In-Reply-To: <20260516123127.C4D41C19425@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 17 May 2026 09:58:11 +0800
X-Gm-Features: AVHnY4JoqwHWhpB4ebfeYxk1Uub3xyBo8iu99DllyE5LJL7pdjqufcGCBLrFwjo
Message-ID: <CAL+tcoBTEiL0t2zeh4CyKvfMTVXgPgh7-OS62GexPdV+aivmQg@mail.gmail.com>
Subject: Re: [PATCH net v2 4/5] xsk: drain continuation descs on invalid
 descriptor in __xsk_generic_xmit()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 8:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] State machine logic flaw causing valid packet drop due to un-cle=
ared drain_cont flag.
> --
>
> commit 8841b899f0208ddaf58f3df5eb5feff9db62147f
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit=
()
>
> This commit addresses an issue in the TX loop where an invalid descriptor
> mid-packet leaves remaining continuation fragments in the ring, which
> corrupts the packet stream. It introduces a drain_cont flag to drain the
> remaining fragments on the next iteration.
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 9c51eed6ee99c..ac4884a87a0fb 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
>
> [ ... ]
>
> > @@ -1125,6 +1125,8 @@ static int __xsk_generic_xmit(struct sock *sk)
> >               if (xs->skb)
> >                       xsk_drop_skb(xs->skb);
> >               xskq_cons_release(xs->tx);
> > +             if (xp_mb_desc(&desc))
> > +                     xs->drain_cont =3D true;
>
> Does this logic inadvertently leave the socket stuck in the drain state?
>
> If xs->drain_cont is already true and the current invalid descriptor is t=
he
> final fragment of the packet (meaning XDP_PKT_CONTD is not set), the flag
> is not explicitly cleared since there is no else branch.
>
> If xs->drain_cont remains true, could the next invocation of
> __xsk_generic_xmit() intercept the first fragment of a completely valid,
> unrelated packet in the if (unlikely(xs->drain_cont)) drain loop?
>
> It appears the valid packet would then be drained to the completion queue
> and silently dropped with -EOVERFLOW.
>
> Would it be safer to unconditionally update the state based on the
> descriptor boundary, such as:
>
> xs->drain_cont =3D xp_mb_desc(&desc);

Yes, I noticed this yesterday and changed it to:
if (xp_mb_desc(&desc))
xs->drain_cont =3D true;
else
xs->drain_cont =3D false;

Sure, one-liner code is much better. I'll apply your suggestion. Thanks.

>
> >       }
> >
> >  out:
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515123018.80=
147-1-kerneljasonxing@gmail.com?part=3D4
