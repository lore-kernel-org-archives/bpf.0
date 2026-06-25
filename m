Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3232AABD
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782351231; cv=pass; b=X1tM7JeE+OC5EuDzi79m36ksyeI7ErtE/KHSYsC2Wdo54/ILKWBN6ZwWykNC21zT3ab2uMRq+4BO9eABgQNwSIieWTzU0gcnxxZKxbRccPwIje5bdMDJigTxvxTzpsCPOlzeONZeIjRAZYJbyNIp/U7T5IdzPSi9fibk4DAO/uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782351231; c=relaxed/simple;
	bh=bvJIM8/xCthwijHLxhVnOuQsC8i91NXSMk/PMpAllSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olvPZ1dKWcXRb3ab94uJWO9zG8TH0KKKptqPpHRpsdjcAM6+vvPJKabfAki3AJE/n+Zv2zh16I64atJ+cLFPZVdKFIGREvKDMloM+hwkSyIcwNKsWNwc9ll03sZrqNdirVeWOuh14+LnHYYKKWvhqNhAMQGl9zwwfICnr5x5hzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOGLeW1X; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOGLeW1X"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5ad58584037so1497382e87.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782351228; cv=none;
        d=google.com; s=arc-20260327;
        b=BNNzEaQqkOYo2OAsBYRuWgsMjUTqMWah1ASVCaqsPgadEzuVYdK6QldWxg03f+0uMC
         AmjDCvg98wvWCLbuX0oQfD2UBzW/1pPbUWlu4MgXo/EYnrfglmqHrIeYxw08vo1ZJ39S
         kxx8+5/urq3sgRLpKerXLv497ojKafu/9ZtP7ueiMTdJcZTGZYXca/7mQ4yPZudzn1dX
         EBQ5FoiAQ6JxHwvHlqfL6opRX0aIMaTwqH45Em7AQMhvYVfJeqAeY+grEixe3sb+M54O
         Pgt0bzUZYQ5v8ejXumsTLpdKj0KQz0EMFJw0KhLUQX5JCnCQXw/pv/LoTbyJNTFyy4B4
         QaNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p25QcqFGNKxKtghtrqFddtm02z5yxf+9EN9Y2xNA14E=;
        fh=Wp+1WBuDhS4c/L/RhP8zHAlBxOBvGiUaoPxSmxSFVFY=;
        b=Kdo9fNdeVItU/EQmeVmOWKxXJIz/zsxo2IWX0EVOGBIJz+xYvo/R5yz+JnV6WkqXML
         5Dp1aBVvTLPuOWZItldVHsrVuof0pCDr3VVDcZnB1QELG3cSzS4n8bqdyWnE+mhhlrE8
         ORt8sYF4TB6wSOA/s/C+LYlO5U7jxvuhINkab2X2igInhv63bF6dnsoNbvKhpA9UDe5q
         yoUlNYLc/CVfETTVD4ZvFauqRPAk8k7krHipciJvjRK7cfMZ4ZfiauAfm/7wzlqjAgHQ
         cgbkb2MD3j5h9LK1ZYskdot606K5M65frqCWB+qvo6AELCkWyYZ/Elb3qdSpNxMJ18Lh
         6lKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782351228; x=1782956028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p25QcqFGNKxKtghtrqFddtm02z5yxf+9EN9Y2xNA14E=;
        b=dOGLeW1XCqPoUtl0QbGMxGQ0St1ctJOpZG6SCkne0NWV6mIYc3eSg6N5mHsmqKs1ud
         zuSshqi+ulN6Z5FFCSiOKW17NpomcdiOA2p4gNIkc+ujPozI9tnrrMEoh4wqxe3QNv9s
         PQHGFWZ7UFx+mWPwx9TlD6eQQPfRbxHv0ozMIc+nH+AV4qF06VgOe10jL/x/kGXYLyv/
         GzcyAn3C24fSLOCeNh+pkwxGHjvnY6jco7rg3JJpVXaVVWPHsdUQKvvLkNKFnyZ/MkmO
         PNb0+OLm7LlKpoisYLWRucPfKZJMMwCke7Ebez8iJisNdBWMMXFEPf//2YdmZMCNtr90
         vKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782351228; x=1782956028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p25QcqFGNKxKtghtrqFddtm02z5yxf+9EN9Y2xNA14E=;
        b=fZ6ePtET6uA0n5uxtMFxAtrF4gqhq1jlgrCJYmkXQPfT6BEjCwBX+y2WNNQrZ+XfII
         U4IZlbB3mYIMpv18Dws/4UMkyeDea0U9xtgLsVToxDg7DJDTp5yyTtfhyhVbamy3qCDo
         wJQ8Ev6+uOakek0moMggZb5wkLQ8bIQbIwSnT5sTcS5lQotlK7M1PE4t+gT0OLCHMLUO
         GwQOXmiMoqCrYtZ+bVw+7OmQV8CsMQZd5V8w8tEldTe7xmqblhY6BEczE4FncbuEaW/M
         LhylIHL5Mi/ETHOc4rbsZrT96jpGjuVw2rkP5/v6ddQeR2qUoo5LuHDnX7hAPwqThTyP
         IkbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3IIZbxL/Ifs/PSJbmqA7KyPsHsYFl7bOxdoJ9FjJQ6zLeQ0TeUokrVm+RfbwW1UX8FHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXOdWOax8XaRusAMmtV0VZ/2Ts8jFwcvGMcXjKKANaJxJUyJuu
	DyTH1WzitmvSEn2163aMq5vFp0tcrY9sKEHb7B286k9NClsn9j7T/uMB1pLv867bYIYzCoKcvyv
	O4lr3DyLv7nRWKo2azVl0R/8EDnGL9A4=
X-Gm-Gg: AfdE7ckfFWIgWqzBRaS0MWZsWzRaQG4dmm5d7tjKb+1iUqMIRHL7QkDcR8fmcv5xzLP
	o5qicYBmM9oPQ6Jf/0TXua4Y3gpDYy5Vym3RzvSTceadHCKVvaIs0LM9KPRRNOkrU1/2gSYzCeC
	fx9AaxFp3R4ma6m58UJkURLXxSs+jmObmj4gjvMWIuKxqnmfTYymbbFsauegldajZXXfp9C/c9i
	cTrGoZ3Zc29FzVg1DQPqTAv0dUId8JwhY9xa8UOzYr3sUCACPOChpxkoDasVz0ZJp9vmghsBBkU
	aBy43q7O235WVilrjg9+ap90bliXoj3ma8Fksxu9s6LmdGXdAhrA/lZatGWn5ES3MFittzz0BoC
	aIotGkyPJTFHkTSru6+KjSQ==
X-Received: by 2002:a05:6512:4409:b0:5ae:9fb0:b96b with SMTP id
 2adb3069b0e04-5aea206467amr83428e87.49.1782351228136; Wed, 24 Jun 2026
 18:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com> <ajwHuCp82SazSwKv@boxer>
In-Reply-To: <ajwHuCp82SazSwKv@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 25 Jun 2026 09:33:10 +0800
X-Gm-Features: AVVi8CejNPL2iVd8h1Eh90UruuEiheM8NG5djzsjWAZeKwG8TwgGsa7M0VGbIP0
Message-ID: <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com>
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor reclaim
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	magnus.karlsson@intel.com, stfomichev@gmail.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 12:37=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Jun 24, 2026 at 08:38:20AM -0700, Stanislav Fomichev wrote:
> > On 06/23, Maciej Fijalkowski wrote:
> > > Hi,
> > >
> > > This series fixes several AF_XDP multi-buffer Tx paths where descript=
ors
> > > consumed from the Tx ring are not consistently returned to userspace
> > > through the completion ring when the packet is later dropped as inval=
id.
> > >
> > > The affected cases are invalid or oversized multi-buffer Tx packets i=
n
> > > both the generic and zero-copy paths. In these cases, the kernel can
> > > consume one or more Tx descriptors while building or validating a
> > > multi-buffer packet, then drop the packet before it reaches the devic=
e.
> > > Userspace still owns the UMEM buffers only after the corresponding
> > > addresses are returned through the CQ. Missing completions therefore
> > > make userspace lose track of those buffers.
> > >
> > > The generic path fixes cover three related cases:
> > > * partially built multi-buffer skbs dropped by xsk_drop_skb();
> > >   continuation descriptors left in the Tx ring after xsk_build_skb()
> > >   reports overflow;
> > > * invalid descriptors encountered in the middle of a multi-buffer
> > >   packet, including the offending invalid descriptor itself.
> > >
> > > The zero-copy path is handled separately. The batched Tx parser now
> > > distinguishes descriptors that can be passed to the driver from
> > > descriptors that are consumed only because they belong to an invalid
> > > multi-buffer packet. Reclaim-only descriptors are written to the CQ
> > > address area and published in completion order, after any earlier
> > > driver-visible Tx descriptors.
> > >
> > > The ZC batching path can also retain drain state when userspace has n=
ot
> > > yet provided the end of an invalid multi-buffer packet. To keep this
> > > state local to the singular batched path, the series prevents a secon=
d
> > > Tx socket from joining the same pool while such drain state exists.
> > > During the singular-to-shared transition, Tx batching is gated,
> > > pre-existing readers are waited out, and bind fails with -EAGAIN if t=
he
> > > existing socket still has pending drain state. This avoids adding
> > > multi-buffer drain handling to the shared-UMEM fallback path.
> > >
> > > The last two patches update xskxceiver so the tests account invalid
> > > multi-buffer Tx packets as descriptors that must be reclaimed, while
> > > still not expecting those invalid packets on the Rx side.
> > >
> > > This is a follow-up to Jason's changes [0] which were addressing gene=
ric
> > > xmit only and this set allows me to pass full xskxceiver test suite r=
un
> > > against ice driver.
> >
> > There is a fair amount of feedback from sashiko already :-( So the meta
> > question from me is: is it time to scrap our current approach where
> > we parse descriptor by descriptor? (and maintain half-baked skb and
> > half-consumed descriptor queues)
> >
> > Should we:
> >
> > 1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exhaust
> > PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to userspac=
e
> > and do a full stop here)
> > 2. now that we really know the number of valid descriptors -> reserve
> > the cq space (if not -> EAGAIN)
> > 3. pre-allocate everything here (if at any point we have ENOMEM -> clea=
nup
> > locally, don't ever create semi-initialized skb)
> > 4. construct the skb
> > 5. xmit
>
> Yeah generic xmit became utterly horrible, haven't gone through sashiko
> reviews yet, but bare in mind this set also aligns zc side to what was
> previously being addressed by Jason.
>
> I believe planned logistics were to get these fixes onto net and then
> Jason had an implementation of batching on generic xmit, directed towards
> -next and that's where we could address current flow.

Agreed. That's what I'm hoping for. There would be much more
discussion on how to do batch xmit in an elegant way, I believe.

Thanks,
Jason

>
> >
> > If at any point there is an issue, the cleanup is straightforward. That
> > whole xk->skb goes away, no state between syscalls. Thoughts?
