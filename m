Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46033E5589
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259230; cv=pass; b=LPUGjkCK4hBe0+vkubXLXOy0TD5oSvkYPIwj1Qt+GnnkrBZgbOZVYJ0qc5kHbtltUDvUeyw1xabg7cr1ssC3u0QCAFCS/Z8bB0IizTKqH+fczQ807hCyDKY0jOKtlCGIzhBrharveTEF/u0zjEvVwWLwxn/V6xC1ZOhvuki+WUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259230; c=relaxed/simple;
	bh=QaoHM0ZCmmMCsFlDINbW+hCiP+12jItyCcYa0Cn+33w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfvozyUsi3+PlCwQP1BxxH/+uPiLsVsEauIgtdfS0/v5krwXDgmyG3EaPAhTmFQIRLcN90CQAXdJuXXNH5rnxEfIihCSeH2h6I3LVWsdr5J6+iWbk+rj6iGzlC8/XWmISXJ5oNyHk7Sz0YKtg5th1l2e/YXvRW0kQ866EQ69rBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXKD62o1; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXKD62o1"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39396f873adso25530891fa.3
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 09:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778259227; cv=none;
        d=google.com; s=arc-20240605;
        b=j2p5wgqX2PiGRsj2qjrEIPbkyQl6Ozc+rbo+bqtshf5MgDP7156/LyCQPSHLeWux13
         qRZ0Qu2FAJpsrRiyblmG/FrGd9J00jCULq+1vqm8yk0nfV+UeWEbojg0msvUk8PaYchk
         Gb9uA1j+xjgP8/OrTioypaD4d778eThkGV9Ff+vOFaajw2Gd4+quxetN3H0NJod0DwT8
         GpmRceo+JSZWF+7wmawtYgHV5sstJ0Uif310P/B7AEoYLKPonQB4XAK0/wJ9CzTa/eBK
         XtCDuqiOFPFoRTIyF9w4AL6V9CYjtoRoCDgDevdLpp0vueZWofa6heDzR/H+aGkPfaOK
         7T0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QaoHM0ZCmmMCsFlDINbW+hCiP+12jItyCcYa0Cn+33w=;
        fh=+n6wohp3MsY0uwfOJyhn1yA+Go43b2+FMlU/d/gbFWU=;
        b=fuMXU0d6dymYlcuIfO7QTaVO/7udiDj7/0YpuR2BUAxZbxJXIRZzpEKLnEekNZvxI6
         q8zji3oN6Mjx+5Hr3KdNpHk12W3/IEy4k1EhJe1WSLdvVG06vJJ1JeJ+XRgS56VDeFmY
         lWQjxqOkufiCVdgdElBDPtOHjMZcar8jcRM5FoWXEa4/bamNgWG562NsetS9e58T3vTy
         Xcw5LZc8UdXdhk+x0yvpJlcIhRNHDaJ57BDYXKMmEhwlSyq+WCDoQ/5VBVuXcTXBfTfs
         BNe3Csj/m83KGxlWNWBW7CucBqHG8qz+Tf7ceh7PP9WBNB0TjVe/PrQoTiz/3zrU8M5K
         QMwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778259227; x=1778864027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaoHM0ZCmmMCsFlDINbW+hCiP+12jItyCcYa0Cn+33w=;
        b=RXKD62o18LhZHkGbnIzpUxb/dRYeEMD99RzGGvGVhRtOBtqFubnCnP8YGw9b/I2ez+
         wIgkLOH04RiUuF/btADWoSOXLb5Mj6xQGqMqKnhk0V3xWUJhoBxLyBQIFGFSlICwX4uX
         GjyV5stabJm9O8geA3DDBdoxgfPO+MM5PJbd3gQR0FznOrBVeoCtX+l70Ij/BErnGfW/
         aMRHXglphUgpFal8Q57JA5lcA7ZAGRYf82IlSTZlW5HmMsetr9B1WlbMvvADgQvACpg3
         uf5CBcCD7jeh931GdRZWdBSwky77t9HGLgmOFOZL/Nn5EqifFGGvtBN6yg4WGlRZ2/Uo
         HD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778259227; x=1778864027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QaoHM0ZCmmMCsFlDINbW+hCiP+12jItyCcYa0Cn+33w=;
        b=ThG/HabdzE72k7bsISGQXQqVZdkXvtH6KaYmZe3WhrfjMxblWnARvRvTM7snD17mf/
         IWOxcnPTfBPtoxVYW3jPMKYhsytown35H+dVcrVJkM0pz/hYo4gDpem6NPayL3KpMlNq
         ZfT1+/SYtVTc5MeSjdYkVYXuu1DI2ql+UZa64hONrxAu2VUPRI4EW5tvSI2TaJ0/1HGI
         iQDR6Q2wu8FRm1xcsfuVlrAOU0asfX7C9dP/Bc72NDoRFgOMwEKETPDAP+cSnTgMJ4Kj
         9BDtv8jRG3cqVyIm9yHK0Zef8QK5mxsHgEp5Iwt22Hg6bwHyz+tduhxDOFePkCqYO6Yu
         TFiw==
X-Forwarded-Encrypted: i=1; AFNElJ91fQ3xAr/hO/vEGP/D5d0pjmoe8OFCBaYm86E7yjyjYeXjlrNVF6QBwEqm1uFw+HQLCBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTKTIkZBLH/uZNBsoLqFySxmlfQJF6rsOA4wLt2i4sHAdrQir
	bxHMAJrqZreN+wfKDXQmktOaknUqMGZvLCeubyHLjBhL7vNQTnO+HZf3SmGgqqRETvTwg5GK97J
	udlQBkEC9dG+yDd6dw8Fqb5/fGL69WfE=
X-Gm-Gg: Acq92OHUm4y+X5WHavnhqtCUL7UEtdbsjx58s+TvItyzBxyBKWX5WJI1NU49PlNVXng
	YYEu6huO6gdAAT821Y284e5vu1SgkZbUmF9r5mTLU/NXS+H9VdlIGiEIdkiuApD90U/i1yFGRHf
	ad5PXSz9LpzUR8yHW4yWxMxqLcCv2gYqmpgW6fkzr4QkcrcsOiKTqucklCEzDAbKE0uU5DOkmMa
	/gzcOVuFxajqKOWcI665VmK3HKNG2QZIkz3BZmrVsCGINj5LOzAOA4c75wpQCnrGc9z7xqhz0wP
	6rIaAw==
X-Received: by 2002:a2e:9807:0:b0:38f:e9fa:266 with SMTP id
 38308e7fff4ca-393c43492e6mr39138871fa.31.1778259226695; Fri, 08 May 2026
 09:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508150055.680136-1-vernon2gm@gmail.com> <af376QFXC36uf7kp@lucifer>
 <af4IEwbAAIYUH0z9@lucifer>
In-Reply-To: <af4IEwbAAIYUH0z9@lucifer>
From: Vernon Yang <vernon2gm@gmail.com>
Date: Sat, 9 May 2026 00:53:35 +0800
X-Gm-Features: AVHnY4I9xn5qVPzznLhQUYYLZZAVQPP79rbvSZlePl1QwuMT9t3JE9qcslwsgOg
Message-ID: <CACZaFFNdk5EfBxCTT0WOPGLiG_01wNESem_DKAu9SK1hrzBhow@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] mm: introduce mthp_ext via cgroup-bpf to make mTHP
 more transparent
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, roman.gushchin@linux.dev, 
	inwardvessel@gmail.com, shakeel.butt@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, surenb@google.com, tz2294@columbia.edu, 
	baohua@kernel.org, lance.yang@linux.dev, dev.jain@arm.com, 
	laoar.shao@gmail.com, gutierrez.asier@huawei-partners.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 12:05=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Fri, May 08, 2026 at 04:15:04PM +0100, Lorenzo Stoakes wrote:
> > Thanks for the series, but overall it's got to be no to this until THP =
and mTHP
> > are in more stable shape.
> >
> > And this is an RFC, you're trying to make really fundamental changes he=
re, it's
> > almost... rude to do that out of the blue non-RFC'd (unless you're a ma=
intainer
> > perhaps).
> >
> > Right now the THP code base is a total mess and mTHP support is not eve=
n
> > properly merged yet (khugepaged support outstanding).
> >
> > BPF interfaces are permanent, we've tried the 'experimental' thing befo=
re, it
> > doesn't work and we'll not be able to yank it later.
> >
> > I've said it before, but we really truly need to get THP into better sh=
ape
> > before we can tolerate large new changes, let alone an user-exported in=
terface.
> >
> > So can we defer this until we're in better shape, and then send that as=
 an RFC
> > first please?
>
> Yeah on second thoughts, NACK and don't send this series again please.
>
> I was already annoyed you'd send something this invasive and massive with=
out an
> RFC, but you've also ignored the feedback we gave to the last THP BPF ser=
ies
> while ostensibly claiming to have taken it into account.
>
> And then... I mean seriously... _shamelessly_ trying to take control away=
 from
> THP maintainers and reviewers who work bloody hard for this community by =
parking
> code that changes mTHP behaviour in an entirely distinct and unrelated
> MAINTAINERS section...!
>
> There's a biweekly THP cabal meeting which you didn't raise this in, you =
didn't
> bring this up at any conference, you didn't send an RFC.
>
> You've sent it too before we even have mTHP khugepaged support merged... =
or have
> really stabilised on how mTHP is supposed to work overall.
>
> And also I have made it really abundantly clear that I want to see the te=
chnical
> debt _paid down_ before we add anything else major.
>
> And as if that wasn't enough, AI review is finding endless problems with =
this
> series on top of all that.
>
> This is NOT how to engage with upstream. Again, please don't send any mor=
e
> revisions of this.
>
> And next time _engage with the community_ before proposing something this=
 big. A
> [DISCUSSION] email, or an RFC, or in a meeting or at a conference, or eve=
n
> off-list or on-list mail, something.

Firstly, before mTHP stabilizes and enters better shape, I will not
submit any new version.

Let me clarify a few issues:
1. This is an RFC. I forgot to add it. Sorry.
2. There is only one issue in the AI review; the rest are false
positives (the AI did not find the dependent patch "mm: BPF OOM").
3. Regarding placing bpf_huge_memory.c under "MEMORY MANAGEMENT
EXTENSIONS": I never intended to take control of THP away from
maintainers and reviewers. However, it is still my fault for causing
misunderstanding. Sorry.

Also, I would like to ask: what work on mTHP still needs further
refinement at present? I can help out.
