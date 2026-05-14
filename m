Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AA145355
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778717516; cv=pass; b=ZXoupm0MexMX8/079OxTrXEPOo1sePEZnyvGugASRKRiz7FMrWXWnCQauthAo6MZwgLyQIE6wWduMjSdR7L7uYrwwaPFMf1eZI/ONY0Fk6ITIHLPf7u64Xj9pn+SO4NoFtsOEAyzJvgCSChWuZIBq1Bi499sbV7xqNCkGrTmw6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778717516; c=relaxed/simple;
	bh=9Fx6TEcuhP0uKfukSu8YwwdQeCUGDwPtmvcrrmZ+k34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVV2TaDn3qHkyI+pbSWCi5P1TD4IAdsBp3+XmvuS1nAe502WCi5Rkb2jPxvqmP1hKXAw2xl9dnS/QN+Z0JW4u0ic7tfiqIpJ57S4XR1KIHnFpwyYoYqHA6H41GQf5eRQuDdHVWzquejG4Hqw1Ob1apQ453/e6oLqzgIHlYnuWCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL7KeUGI; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL7KeUGI"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a88de2b52eso9449758e87.2
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 17:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778717513; cv=none;
        d=google.com; s=arc-20240605;
        b=fGVBjkSDc2H/60Id3hO6a37ef5It3ODFpcyav+EpqUZiO9+fOTtOiuFjnyiCOaDFWV
         f9JsJnreurmuSJY1EjbE2y7MpgMcoJrviVwOd7NSVJNwCHYUlavKF7Wo+8A/4M7BI3yC
         0iVqf68MoTEoUEROiNrj2WSZkfkdFLVthlr48RtuVnsU4ST+vXrzfQu6ntXGxyxg4WD7
         CAwcj1mONH8LZMm3V7BuTOcib4OF9C5WNoDJ+9T6V3x2my3EfWGJxQCDBD1nI1QdihSV
         UB9hl7p3Tsw0ClnHFsZLZMblLkAH1M41Xkn/RRiDeR8JeAKi+DTq6rdZSVqiJLyMmVqo
         +tqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ecfv/2egnJYM7Ef3EdLiXvdvlvXcGmopKQvWn0K3Cmc=;
        fh=uC0rLc5dMQ5nOcNrvWnnOuwdz7KPRWExiGOTTLQV33s=;
        b=H5Ap4mJ1/fVglxMiklcwhHQ5Vu51M1brIY6EyLweueCC+zRi5WLiCgb0kz6WBEyGPa
         vu0nHxvMllyDDQBrPQS5DEk3iOpayy76MXXgXkbY8X4FURMpeCTS2Penp1t5dxBqy+UI
         OeFqUu56u1OHFwcYjcv9X6HOSZSrenrstvZG118nB8L221FnXE+BCVpLK07ktu9Nwbdk
         q3gUN1JUQQvW00f6eWl+2CX3cDPjcUxSw0HyA045aGbss9UaDdf8RpISKuKbpCQkmUfD
         T64kvyUEC3TEahJ1KaEYw7XyNhfDNTjoXyyUu7VExpbc3UUxo0HNva0zWZ+I2WEO1ncR
         X0kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778717513; x=1779322313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ecfv/2egnJYM7Ef3EdLiXvdvlvXcGmopKQvWn0K3Cmc=;
        b=bL7KeUGI6u2D/8mMFyw5w1ReewAJSd6Kv30eLbNPcShyQNqVxX0SP6E2Q5FgXrZSMv
         bSOiSr7m/JEg5jTjyJFcTHrjRJDG5cxkzD7WBQm3M0R50HKKAemWBXSf9sf/f1vkUHCy
         QYxbP4FPrMzWmH20w1qY9YUokrQNwYENlHgX6Ud8w+bUTFwwAkOlb7rCxHlCA/yFLI+R
         w8kVDUt74eQ5nJU7dwt1yp2OO2Kq7mKFsFZ6bexgdg7ZvYdQZWn7GEEBPcWDijI6CqKE
         x/i4EtRESD7nFVeA09g6oE22ge1P0T6CC9dwfy/O9WB7ioXYWnQOY2BD5CQfmcvZKWzi
         OxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778717513; x=1779322313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ecfv/2egnJYM7Ef3EdLiXvdvlvXcGmopKQvWn0K3Cmc=;
        b=hUxNgMYTtAinGFRYGUecwiYikYc0jn2HTtZbNMXtwOve9TwjH0QTauUAKGWtUtWX57
         NhWHGoK5uULI09XFuCAOpQKXpWev+eUpS1kLPIGWT1pLcowRxtJQmsnHeZsWk1zYYIDL
         QX+FmzZkfXIsR96+0jLVcN9cxtFPzZH9x02MjhyFBWQlTkoxgEG+fOLsHN+y4SvU9Y+W
         5/CrhV+fh5ZfdHKRMvOKphE1du2Y34/JDgvwregkiuFqcr+czJzqNqmlCcKsUypL7b6j
         cq1N9JHHZMPmiyBi0paUG5N8Eu6sXN5zcUqkBFHUcBS3XDIZE/hO1ZnmpNTFV4oV9wAq
         8C7w==
X-Forwarded-Encrypted: i=1; AFNElJ/dkYxUqcq7RLdirdU7xbOFidHzYEa3x/LoB6GVwYmzyJ9Eji8Av3BEVmRguqOT79GVM7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzom+3vVlBgWo1J7ODjPKJsR+ucwxEXVQiwzv9GkDedsH49DWNC
	QcLIxTA7fLz+Hje1sskOnMnuk/RjjWaoWmSKQ4sbPLO9maX+dBLhi1YBL+an4E+92jXLssaRV1Y
	CH17wCwacWL1f8l6FgFL9Hg4XvfdO2vI=
X-Gm-Gg: Acq92OElLqNi6P9bhXg6/wX+WNkKbYIOrl2McW8oU5Fbzc9osS3EGuaOAeLsuzZyNFa
	7xvjTR8iqyvIDYE+5SWwEwwYMhMCeiZPH/+59dAxlAqubeNuAwPGRZLipWxqa5JSHwfPNoSt6rS
	qFOkDOqbFrAM1DKj1SRXQwXpq77+gtMETpnpBipM8EZKDSDI2RnCa0J1JnlYAnQ78eIbZ/8RWEx
	Nc+dpDbG4d/JI5F04N/CTMDCzevHKttuqaNdcboPWu+9VqOO7CzhAEuleKWnQXmVJajZ3Qfjt3p
	tU1ZWD/QRmZt0R7OBdNXiKGwsx6hG2rmnxb/ambIfTQbbXbWjw==
X-Received: by 2002:ac2:44c5:0:b0:5a8:f6fd:f201 with SMTP id
 2adb3069b0e04-5a8f6fdf342mr1021166e87.15.1778717512962; Wed, 13 May 2026
 17:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-2-kerneljasonxing@gmail.com> <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
 <CAL+tcoDrjJ8iHzSGz_Orf7iH-1WJ2H_LZd6BMKTnDS3MVN8daA@mail.gmail.com>
 <agOozH29XU6KQUTy@devvm7509.cco0.facebook.com> <CAL+tcoDqtEAqX65-8crUkUko5T_0nq=LSxAbMg+5jCAHa_uC=A@mail.gmail.com>
 <agSaZtBh-v6isF_8@devvm7509.cco0.facebook.com>
In-Reply-To: <agSaZtBh-v6isF_8@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 14 May 2026 08:11:15 +0800
X-Gm-Features: AVHnY4K-2doFlvgfTjD9RnebzpNCpRm6uN5I6-q9Co6W9ht1PFJwC1E0IPKHRyA
Message-ID: <CAL+tcoCEoptgzBgbDUH9tdoqJYa8QVgqe=7R4XThKocRM9SOPg@mail.gmail.com>
Subject: Re: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 11:37=E2=80=AFPM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 05/13, Jason Xing wrote:
> > On Wed, May 13, 2026 at 6:34=E2=80=AFAM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> > >
> > > On 05/12, Jason Xing wrote:
> > > > On Mon, May 11, 2026 at 11:03=E2=80=AFPM Stanislav Fomichev
> > > > <sdf.kernel@gmail.com> wrote:
> > > > >
> > > > > On 05/10, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > The TX metadata area resides in the UMEM buffer which is memory=
-mapped
> > > > > > and concurrently writable by userspace. In xsk_skb_metadata(),
> > > > > > csum_start and csum_offset are read from shared memory for boun=
ds
> > > > > > validation, then read again for skb assignment. A malicious use=
rspace
> > > > > > application can race to overwrite these values between the two =
reads,
> > > > > > bypassing the bounds check and causing out-of-bounds memory acc=
ess
> > > > > > during checksum computation in the transmit path.
> > > > > >
> > > > > > Fix this by reading csum_start and csum_offset into local varia=
bles
> > > > > > once, then using the local copies for both validation and assig=
nment.
> > > > > >
> > > > > > Note that other metadata fields (flags, launch_time) and the ca=
ched
> > > > > > csum fields may be mutually inconsistent due to concurrent user=
space
> > > > > > writes, but this is benign: the only security-critical invarian=
t is
> > > > > > that each field's validated value is the same one used, which l=
ocal
> > > > > > caching guarantees.
> > > > > >
> > > > > > Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@=
smtp.kernel.org/
> > > > > > Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum off=
load support")
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  net/xdp/xsk.c | 11 +++++++----
> > > > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > > index 6bcd77068e52..cd039e397018 100644
> > > > > > --- a/net/xdp/xsk.c
> > > > > > +++ b/net/xdp/xsk.c
> > > > > > @@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff =
*skb, void *buffer,
> > > > > >                           u32 hr)
> > > > > >  {
> > > > > >       struct xsk_tx_metadata *meta =3D NULL;
> > > > > > +     u16 csum_start, csum_offset;
> > > > > >
> > > > > >       if (unlikely(pool->tx_metadata_len =3D=3D 0))
> > > > > >               return -EINVAL;
> > > > > > @@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buf=
f *skb, void *buffer,
> > > > > >               return -EINVAL;
> > > > > >
> > > > > >       if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > > > > > -             if (unlikely(meta->request.csum_start +
> > > > > > -                          meta->request.csum_offset +
> > > > > > +             csum_start =3D meta->request.csum_start;
> > > > > > +             csum_offset =3D meta->request.csum_offset;
> > > > >
> > > > > Wondering if it's better to READ_ONCE(x) these?
> > > >
> > > > I still chose not to use it after reading the suggestion from local
> > > > AI. The reason is there is no WRITE_ONCE pair to make sure everythi=
ng
> > > > is no data-race. I also checked some existing implementations aroun=
d
> > > > the shared buffer (between userspace and kernel) and didn't manage =
to
> > > > see the usage of XXXX_ONCE(). Does it make any sense to you :) ?
> > >
> > > Without READ_ONCE your patch relies on the compiler honoring exactly =
the
> > > loads and stores as written. Which I don't think it does (hence that
> > > whole WRITE_ONCE/READ_ONCE mess). IOW, it can pretty much generate
> > > the same code (and read csum_start twice) even with your patch applie=
d. Happy
> > > to argue with your local AI if you give me the output :-D
> > >
> > > I grepped io_uring/ and I see similar pattern for reading user suppli=
ed
> > > entries (via READ_ONCE).
> >
> > I roughly understand what your meaning is here. My thought is the
> > data-race condition in this case still happens even with the
> > READ_ONCE() protection (because no such corresponding operation is
> > performed on the writer side).
> >
> > Actually the local AI said use READ_ONCE instead.
> >
> > I can change this as you suggested for sure. Maybe related fields can
> > be protected in the same way in another patch.
>
> In general, feels like we should be doing READ_ONCE on all user-supplied
> descriptors (to make it more apparent that those can be concurrently chan=
ged
> by the userspace). In practice, probably too late and too much churn to u=
pdate
> everything at this point, so let's only fix the ones that can lead to
> TOCTOU.

Agreed. Will update it then :)

Thanks,
Jason
