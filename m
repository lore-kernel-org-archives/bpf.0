Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A131F5EA
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773454723; cv=pass; b=PaF0YGYberEGR/Rjid82spNSgmKeDslpPm3boOIzaeRJzZfTEDynEDkUP8OTpmopDzSdNq9TfTekfJ9o32LmL0LlcZSWnWzoapYLYlWK9bw8Q/vIstuJP2N7FdVbKMISQ2uAWXRTXYKouSXwVVjBkyJCzR5wQyO7liybt7oGzYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773454723; c=relaxed/simple;
	bh=+aPAb4L2hhy7zy/b7OYCYW1c+oRHlFbEbx++f76QuLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODQexvXF3eXOMGFekNZpS+99xBq6sFybSuTZBTo0mdPMJdETIXrTUNHZ4mtU2bWR3yHHvzIv2lj39sY9XIaAron6EPb1Caxr4yob2W67yE1H/FXU4Z/4W8GCq9Oz4cogrK/joBkh1hzidPXuHEDA0LjuSbkuT94kBbbW9MhmWl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnyUtkZf; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnyUtkZf"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so3154467f8f.1
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 19:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773454721; cv=none;
        d=google.com; s=arc-20240605;
        b=IsZoY7FQbrX/TsxnqvrVOYBeaGxWuwb5UzEi3kXeUdvVWO0osX1KEgnY05Dy8THF1D
         3s+upuhiwT+Y8yTR/yTMA7801810RL414bdKd8wrctwMBef2wj1vDEQ4cdaPnwWEnFIP
         JEwv6jG31r5CDTmz56k01RZK8p2DdyLOz/5Wbp5pY+oLXvUSFDY2u+S7x4TRftu97wZh
         sMoSL7Ld2VOwqq9CZpXzSARtRMrsIW3jxmONnuREB0+BreSU3WiWyzBjnqCNsU5RRqjj
         HZw0a/8JbxBFtCmiqy8jR5y3PmFKkj3nPWLhnDGu1pefNFPQjsG5p9thcG7ziBCoPVA8
         ik+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+aPAb4L2hhy7zy/b7OYCYW1c+oRHlFbEbx++f76QuLg=;
        fh=zvCFAoZPNXVKD3lxer5NXNlZelTzK+7Xex2WXLeOuCo=;
        b=Hemc7Nx8vTAj9+fHsZAzRGGtpj3WObgYCaXBkircHjSIs9YW9lNQT6YpomhBBY5on5
         gp8YhlkBiMqhHqXxfczcIiv2UwJWr/8EFQ7sP15NWxRNFXx7NkfIEi5hqu8nWkioeC5L
         27IZLYVdBWxJby3U6C1it2+PVUbK4OaSGgcLHjsnMnheS2ZfFIGqXZ6kCFtzIwXdKcnK
         OLBX6qTMTE+CEkKm1V++/v8/3Uz0QAS60mQFTHFW7EaXe0tg3QoQNUHgXbBjOKVrtb+z
         D25eWUvvxSy9PlTxbtwk8cVFkdmmHDoHDfFe2jVEtYi4C790kjZ3Q0Hlx0+l9Dsnjy7t
         9ltw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773454721; x=1774059521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aPAb4L2hhy7zy/b7OYCYW1c+oRHlFbEbx++f76QuLg=;
        b=QnyUtkZf16J74VpggExewKZjuxOew2SwpatrO3wZu/vIpaKjld5TMCk3GsIHU8+xCD
         bTu8PxoniufV8ve6bLRHSIYW4/SWqwI+EJd6wLyvy/GBWnYvXipnEJcdGWKxiuwkhHk6
         fp9Hvm/XmHYEOE165om8Cvr7nOJajPULU4ImCb64jKouA/mCKYgVO3RHc33MSW6PwKLK
         GHK+9xVAGgW95C2lK6vRJt4ZP3UQ/u2n+ewuIG3NoT53gWGO3Hc3GIqsnyrCTbK303mu
         jUpoDKeInDrhqA1Eq9SOOuPGjnzDFyxQSkbMkJHpxEoWzdJEP9QMBHN3wHQpdfBYs56T
         Xi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773454721; x=1774059521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+aPAb4L2hhy7zy/b7OYCYW1c+oRHlFbEbx++f76QuLg=;
        b=h7/MjovLLl1qNX5MGbu+ksqw33GvUmZyfYrQV02WPZScKEcJX4a0+9pGTA5kg/yGFR
         ENg4q3PScD2ciLMrpsznsJyzlyGSJnYGN5jGFG3ImB6IZ6s/h+307nIghHEGqWptQGr/
         0nyy2iMRPkSRYRms2LMQMzecBll9wVSuu4x3rogpBfnYMn+hnilURIWvdlRua+4wNkwz
         hOpGVckIwSslDy29SGGqd9OZga15oDcKAnyAaPDiISrFotCbX73z/TDz8bnqRUQVvIGM
         uE3NTquhMKeFk9XmeXx3AAF73Px2MNm0CB9W0NRUOY0p2XkHW+ebY5P1b69TtkC1j/34
         Muxw==
X-Forwarded-Encrypted: i=1; AJvYcCXYTibDmnFxr/md3xc/XIREQPDh7OITOFpTzOpONK9A27O8gY74Tp97sxsm1ea6dbG3lcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhBOkRN9H7a0GYFGd6eg4K4wISqMSpdJfzzDfN+WsgHytfsumG
	L9KHbFif7Gi2ZZGIRWGcurTQrFqi8uQ5qcurkT/SaJcWs10GIwBTwmJ05VgWSxh9KVB/vaNdE2F
	SkBeXykvUz2ZHwn5ufqhWotTQQONCB7U=
X-Gm-Gg: ATEYQzzC06SVAfUySxw/lMXAY1fwHfIDdjxKcHS9mvThBzQHdWkrpwzhHl26IRIGcqr
	r8rhuPwtR2jBZrPjvAveYhP1tDifsHnT4MEbiT7dTKIbRV+afws+maVm+jlp5HbQxc4u3qZ+czm
	lRk3LRSYJ67q+QOZgwRxUS53KA6czRxrGsMiSTiWfjSXhIXq2LpXyLgODir+PNlYrbYUegBJgi2
	Bej2K6M3UaZPZ2MhbRd4G8X0F7+lgIcjFJD2UaV2Nm2Tx618n4rBmf86GYaaoNS4FrsoNuR70Yr
	t426yDxCWjihUp8hl5p7T3gKHN+4JtQ6SHDQWifXefUCH+j8L30jD89SDWW+KOiwBdw=
X-Received: by 2002:a5d:5849:0:b0:439:ac6b:dd64 with SMTP id
 ffacd0b85a97d-43a04dc8983mr11220852f8f.45.1773454720795; Fri, 13 Mar 2026
 19:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773401138.git.paul.chaignon@gmail.com> <ede050cd3a7ac94a839c2960a8a09b1dcd1f0777.camel@gmail.com>
In-Reply-To: <ede050cd3a7ac94a839c2960a8a09b1dcd1f0777.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Mar 2026 19:18:29 -0700
X-Gm-Features: AaiRm539E0zoQ3m9nv00OVsVXeM9f1uNZ_stCYaJAiSzd-O9WQHqskTsNU6FYXg
Message-ID: <CAADnVQKw-8ZBy3H+kP_nvtFY=8neF1Lm3tuVoQ=OpKrxb-qj8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Optimize bounds refinement by reordering deductions
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 3:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
> have and land this patch-set. I'll share details on cnums later in a
> separate email, but tldr is that cnum representation is strictly less
> precise compared to combination of signed and unsigned ranges
> (probably this was obvious in the hindsight).

Understood. Applied the patches,
but I thought that the main advantage of circular representation
that it represents both, since the sign is "absorbed" by the circle.
What did the paper claim?
