Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E24C6537
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012344; cv=pass; b=Ru/WT1h26e+V4yzy75KLgCyvl8+T2NU0ZXdFOy9EEU6xTWHvzlWUqHhyo4ZiDHZpgA/J+Uz5Q/N+5ANdoMiLFytB9gCcY2bWTrqowKTNaaUVT0YxWgzKUKTL2AQrAh8ZnbHXeD4cktu3oeU21wtLNWhhRTDShXPxlc8qFzJ+qhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012344; c=relaxed/simple;
	bh=kP92Ak7RvzGy2hBVDe8IS5YHe71q5T7c9Q++nOdItZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RW4sJeJHfYG0Xd0s9Wi3hu07N6VxccoJTuSLkUIxkIZbqI/RYdq/l3baYfGVDGgmeA8nL5VeyIlEvPSA5fFUP22vEHfhlfq95PaIICNrZAJfamd9UTB6F/zwP/Z4STo4GRzMGbdcvyYRYYPDxGwaNzHwr/wYw+ilFv8jJArDHn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3rz5TjC; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3rz5TjC"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-47be948a50fso2307110fac.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 10:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790012341; cv=none;
        d=google.com; s=arc-20260327;
        b=IFXv2QuWCZuKvTbpd6arUoPNSuc8KbdsPhj566EFHd24hZsZYRjoVbFdzM7Xm8ysux
         nqThSGAwFndco2Dc9+msdPzTwP1FI14gY/AXDZWWqs+ZGdpWB8EF3TzeVboV/sSFPJIi
         TojUh+ZcAyBbpBNKn80TgcPIVEwTlu35Wi0HYpQcJX/XEB2hc9yhtnnRSi0ivQAmVmKQ
         PyBoTeXNdRoi5VdsV5icPuMRNW5xQE4utTEIhyhfkMueB0x7Jr2+7eXklqxnHBKjPmVc
         PmJOOEYFkdhKefj1NNUphQsD1sgiKuxjiakU2ecqbqJVVGirWiUdGxw5BCjlKvkWJJv1
         8Lsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WqxxhkWEnQe8FoDsGHahW+AX2LGvlhUkNfobMA0XIzI=;
        fh=o7SJMttBUAkyWzrebud+qqj2Ifzf7cQi7sfXxzvKKe0=;
        b=mpYWhJ8lA87KHT8dSQlTAgw9kWCY+Cyda6D9xptp1+9hCXzgvTXUsDibXA5QUQKgDE
         8ZAcFjNJ2k/fLg6WQ3WviaA9s8vCcgYV9Yr9BhG7HsG+Vf3qCVwssnC0SWsoG07Ny9Ar
         SVt57saEH2FKGEY+sIxbCcdFshHU0cg6yj4c0RdCagi5/u17sNnUI1mSiUlLhWv5sox2
         PaCNDn3ZQ9lgOcQEjZYRbLlkmnDzskf8hEtvk1uMchnJIH4zQAhOsXAPdrb7UNsLdgOJ
         5C8c3uh4QvphHpPGqG9gLzg3JEugxH8FxANwltyc6eNjunjjuE4iKXhW908+nfO1gchH
         R4PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790012341; x=1790617141; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WqxxhkWEnQe8FoDsGHahW+AX2LGvlhUkNfobMA0XIzI=;
        b=J3rz5TjCItSSQgWeAAjIWkD1JRNLanF+PgODdumJkjJwjkaI+AQRCBzbQ/0EKTMeas
         cIujKsX0atUzDcQC7R6zWNIioGJGVw61I7eGPyrTm+Q5w4a9S6Ih1qTob33phnrS2BuE
         yXjPEz7BcMuf6Po4I1dpQFpUaDhbmtj2sbWoDZoRlTJBWcrPDhgBS4LgqMt3v+flMfhz
         JTZRPChzC/j5BRssufUjKOZG6IrhHz5IDV8DEAuZcqyxcwXgMOFRujaw8z2X0nu072my
         nZPXH53P5HxKxcoq+0JE72hws5j1Tj/26OY2NLiM9o/gvL29W2spMSG+wrIUe6TB8b27
         /VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012341; x=1790617141;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WqxxhkWEnQe8FoDsGHahW+AX2LGvlhUkNfobMA0XIzI=;
        b=HLTdXLawwJBrC6yk3XwnmYtjWe+HjHalGUXXgSSmMddNFVbpNEYhGvG6GUR80DtH8V
         NDexfHnFYOyk2bWGRpC0/sVehIaUMuzKhqTS+8ag4o7NK98SeTQEA4KEkKVodtJcsxEK
         YO8+cLppb4BoCsyQp6z1bjiEqvTwvqwv382irlAgco2mpvs6/fHKSuCmA7c+mEzbpwqG
         IEVJ2S2B6L+q0rrdGjJscUY6PbexUT9HqMrudqyvauAcuVLGp9zbWuXr3loshtv6nVc+
         CwbGGhr4QLhSxGLqmR6pSPb1hrnDnzD4FODgdJpx0fP4jclhOc7BWM7qQPZOFwNdBM/h
         kgAg==
X-Forwarded-Encrypted: i=1; AKwUvBzGeXFMbvEVwsmvl8tdwdKRj/zZOCwd8vdfNoa8ppdSlX4yCe/K7p+3PWpvIjE+/atNXMo=@vger.kernel.org
X-Gm-Message-State: AFuF++nZH0Hh/Mwk8lF90GHfU5ZLZ0QrKlHx3Vp9SRxT0U1DkhQ0KjFp
	mzR2vhvLiEtDziPMqPaIyZcz1XS174KntDK62OZOcSzCEa9Wf0Prv9wbhrQo7wkjoymL0mAn1Y9
	D+Y9zJ7y6MNkgVFBPYvyE95+VZ37MOnU=
X-Gm-Gg: AYBFou2Ta9GW67wnFd6cydhdjPxRzrFsk0wMWoCpsEO8pRYEe+gFktqwg3IdiXlG+R4
	KjX9BvAjM1RxiImHEOSBvI7zb6UKSpugUGK8nYQqjDeAfBtX53lV7umz7rNERny6TAHl72pzeuP
	SnJVhhi3igX7hgQFJogfiSfUepfxvNbo7qaXtOyKdbYbRqgE9NJkIU9iXkqNHmUhMprvPYZ5bJr
	EZ13c4Nk6nGBPTQReDpesOvDeAoLrO8SKPd2ulcBDWoSikiDtirX7wtKbG0I8odtKXIs6eysQNp
	AAmCX/UgJNDDQvoOtuxxnuw+N/ywBWJT3DBQm1U9mEp5tFqw3B6AAJirQPo9CUXO7825d093N/G
	Iqjo/X5OBm5AO0Q==
X-Received: by 2002:a05:6870:96ab:b0:43b:b245:30ac with SMTP id
 586e51a60fabf-486e575539emr11232161fac.16.1790012341499; Mon, 21 Sep 2026
 10:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921154650.130677-1-suchitkarunakaran@gmail.com> <DLL5PFJLT64M.1W82K71YXNT3A@gmail.com>
In-Reply-To: <DLL5PFJLT64M.1W82K71YXNT3A@gmail.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Mon, 21 Sep 2026 23:08:49 +0530
X-Gm-Features: AcwNN1XeWmSNSpYjUTctrJrH5Vc0O-P93rFea4YdAqzuTsR8qSpMr_fjrprOGQ0
Message-ID: <CAO9wTFjK+oRT-maca6A1UDBrgYTGB0Zr48UiLm2Ees835POOFg@mail.gmail.com>
Subject: Re: [PATCH] bpf: add diagnostics for rejected memory and map accesses
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, john.fastabend@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sept 2026 at 22:35, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 21, 2026 at 09:16 PM Suchit Karunakaran <suchitkarunakaran@gmail.com> wrote:
> >                                       verbose(env, "sign extending loads from arena are not supported yet\n");
> > +                                     bpf_diag_policy(
> > +                                             env, i + delta, "sign-extending arena load",
> > +                                             "the current JIT does not support this load instruction for arena memory",
> > +                                             "Use a kernel and architecture with JIT support for this arena load.");
>
> Did you read what AI generated for you?
> "Use a kernel and architecture with JIT support for this arena load."
> ?!?!
>
> Please apply human filter to every single line of "your" patches.
>
> pw-bot: cr

Hi Alexei. I'm sorry for the oversight. I somehow misinterpreted it as
"Use a kernel and architecture with JIT that supports this arena
load." Is the following diagnostic message fine? If yes I'll correct
it in v2.
bpf_diag_policy(env, i + delta,
"sign-extending arena load", "the current JIT backend doesn't
implement sign-extending loads from arena memory",
 "Use a kernel and architecture where the BPF JIT supports
sign-extending loads from arena memory.");
