Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793994595;
	b=rcoFy+4sdhoIVZiI9jpEw3MQnYauQaqoaQzzpX2rxHnc4GRPwBKlFmGGVkiE71S0UXXL
	 ZCOUg4+jKC18u9B+ivHagLXFSk/ynsizeyAv7QrwJrbjLiJAlbZK239BaKKUENg/Fu9Vw
	 SPm768AklkCRVgqwemO1qlyCuDmK8dAa7X7klLlymFcJy2xuIVc9cwHkKp8F+L65cxgV/
	 lnIQ99teDnNrS4B0azFozX7cyxQrALgHWFKslgubfANOGr0X0OL9QTCpTURAFOAYaARI6
	 uhIZUFxUZRB4e/dVMU3QKlTHC/iLQLdmd89esj0oGmMOxz30o/IVNCQoGcAEfj9ofdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=b8v+/nVV3ssXYzzzdSdzKOO8zOsYTPEGfi/d2I/edOo=;
	b=xi/ySuVXtHu7ib0SNp0pqB53Okxb2l6XRHhPE2cBTS60cdQsXpxmyWwiG3AuVf8p6Ka4
	 oXTXGY4v+RE0l+/0raO2pXgyzYCLMS9/e/6FcbVVHAsRGYErOqsc522KKXjqHUN7vGSBB
	 iZSbre1mQe2QnAxvrYgrw6X51pXa5te/kahYu2FLzc0x6TUj/E4+JXUG42rmPkj4mJftt
	 k5SBNTQIPpws0YMyjFGiABt9lwP61j8mf6hMzX4HSZSvQEtlFzfl8Bbe54LTpuU/TTA1Q
	 IAnQj21837aDGtStpaX/FeHaBTONFMyThc1wVAUDVvXNclnk7ry//O4dYwmWqq1LowQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iiP4XVRy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD307606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 19:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD307606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iiP4XVRy
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9d7791b00so7349025ad.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 11:49:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994594; cv=none;
        d=google.com; s=arc-20260327;
        b=NrNYuuM4dZOMFvraG5HZdnFT0WUtbhboFD8jstZAUIrDOKoh+wlq/3mkhvpWH2i9+x
         cn3s4paFsXEblMOPM4QnH7D4Q2mr4ry2EIs0YFXqcgAosyW7Q8ecy6mL5rH8+87ws1Az
         7MGxisdRkMELpAhgBwqRI3aVLwdcqLwnAixAF0reyg4a3jMqFaMawenIEVMV20id52dt
         6kDtr+OJpQ5DMwNVOgOdulv0NqXZhlleYr+p5j4SJwz8PID6NyfqRu9CDFLLCw9MhtKf
         g6ff8S2FtzXqMlXhvC93/oI2N5hjz8UkWThkwYlaSg23IM5S225GpQtRf76z3icf9sV+
         4jZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b8v+/nVV3ssXYzzzdSdzKOO8zOsYTPEGfi/d2I/edOo=;
        fh=dGIGaQRaKsivbx3QErlhBlw92gKgAbguSu9MnKfLfAA=;
        b=YotMNS1PAUfbDxl/GPrKHIGspE0H6QV7kL9vqoX0oqcnwmb42F+Gy7Kd5R6iU34Gu2
         oEmdy3MiHiSwUccuDtaeCIO9jAZQRHxegqfZgA6o7U/gKxQpuf8cRxeZl9OQ0ahQmIOl
         iNieWJCkqZBMF+HZvpB66O0hSgWhFMwIHBazI1QCEjp41lwojNwjXyFj31ESAsZqQ2ra
         eo1ywbvD6hJxXeTlWxzmogP/EGVhRyeUu9ZOmZmPVNAe5IfOmEj64lRhQMC6xBpSq0dr
         TS7uVR8riUJQQixSnLNGj1iH+A+xbieGRrKv5FFZCzA3Bo1T8IkHap5avNc7EYByKId2
         46mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793994594; x=1794599394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b8v+/nVV3ssXYzzzdSdzKOO8zOsYTPEGfi/d2I/edOo=;
        b=iiP4XVRy+wXLIk4ARRYrY/94n6DfGcCtjqVZaf5AZDIxvtyNzlbQByMucXKDgDdWuW
         aVrkp0uz8Yo9gCb3NGwi8LoIldgrelj18hbXKhbc9A0JDNmmNDZQkmlvm9wVA3Y0Wb1o
         wGSj22bUwypJdk9fKsGIu1PPkqaGDeLm1BmyLdRbmppvsmHKPTyYxyBFMxnNH7lSmHtn
         iu8jRYK6BQrIdrXwFXdAKoP1sjw+K1Ni46AYielh2K3m2zuPfo5STxBrt/xb+aWLpmBY
         xaIhKOTpItzeTLeXxqlI9MF4kNF9h/K2RFD3uTjeeGFFv2ZspqvZ52M9/iUehgdSfig3
         EM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793994594; x=1794599394;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b8v+/nVV3ssXYzzzdSdzKOO8zOsYTPEGfi/d2I/edOo=;
        b=L5F3wMOsoKcG8NOFXe2s+ggstW8DY5zrSLhTzN8NSAQipeRbRj6jGQkEbb7hQMEbML
         PWcAekKOaFj7SAmnfIcGrpMoEwNqZJcYq3MpJ21UXE7reutRBW+CZXjs9st5UQz1QYe1
         QaGoM1HZKa4Z7cWOklgubrzIZptgrWUos0T8rB0zlrfMuI0ZE/CzoxlBvLINgZAb5NDL
         V+vF164359k1TNK9ia+Uemc73bXlGj8PSqqs9GaOq6QC4vKDR9zb1UpIdFbEt0X0LL6b
         m63WJYCEh/5aCUsQLe87nr3BOzUkxPmYPLKU1VHQ3w90B5i42Ogd9xPW+w5jjgnH6eQD
         p70Q==
X-Forwarded-Encrypted: i=1; AL+hErEMiYrRGaUyz59sOtvgufw+9auap06yPIIWSwNf/cBAH/Xoeqa71BHidz7amrRnCcycB38=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FEqzvrLO6O4A4uUNX23gWBwOwFdp2gg653jrITTwZJn9hf0L0
	iNQC695D0pWRkU08hqf1LxIspshzCLQWKbP4qXf6eETXXCTGzD6h8ZWZ42lW5aJGpMEk8dyajDu
	yppsh60rAOYk51u0dj/ZeTACA5N05N4I=
X-Gm-Gg: AYBFou0B2VvEu0cHs59zjrc2tkDNL08IXPz0Zq66HCYQp97Dz7A4OJ0PEtR7RkLr3Jv
	CaZSfsZo61NDWnXoaELrSAOuWuO2YXqxUnKo6+F+y/OnF+DKPcfDInXVTM1XqQ8P5MWduYLJfmP
	pyXumSDSI0Fcn9AyEMWzXL6644VRkQ5Hw4y9GHQJSQSSjR2wxN9TNgrV52NqWzV0ZDPNVlZZA15
	CSlHW5weiT7x37gFMcw5v1agp+bT6K28EPllJeKPR/3ljD7HtW22A3pZBtYe9qXbkC3EhXZDtec
	Zbl6Wi7lfNH9A6Grjs+jKCG9foCnz9XXYUM2/62WyjKLDByzfLZJAi1RhILEkPhwraG019e4qoH
	K9gyoUciasfZWukjcE4BzktAPJRSJRRHUAxT2ScSSga+z5jmXY5J+WtYsged1vpaDXo4Hb4Rp9d
	ZkRDgQXPQjR3PZnMxVIQ==
X-Received: by 2002:a17:902:ce03:b0:2dd:ad73:5b6f with SMTP id
 d9443c01a7336-2ed40bdca7cmr42581615ad.31.1793994593947; Fri, 06 Nov 2026
 11:49:53 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101103221.51534-1-dennylin0707@gmail.com>
 <20261101103221.51534-3-dennylin0707@gmail.com> <CAEf4BzaES0KDyhHhk7UguLmRKVWxGoiEXhNvp7QHpeJSZSjbYA@mail.gmail.com>
 <CAGEkeHf9d6BuQWsaqiresmbPNWAVZRbzZv03kfJisT6SQD8aAg@mail.gmail.com>
In-Reply-To: <CAGEkeHf9d6BuQWsaqiresmbPNWAVZRbzZv03kfJisT6SQD8aAg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Nov 2026 11:49:37 -0800
X-Gm-Features: AclHuK-D1ZOSyHMac2tfkJx6j69nnEJP0Zd6RBV1HfjXz9rX2igCRXKdBHWZqjQ
Message-ID: <CAEf4BzY-7XH+XzWzcr6ew5+CFQL_=FxJLZpDNw=ZdPqeA8O6VA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpftool: Preserve unsigned enum values in
 data dumps
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: ast@kernel.org, bpf@vger.kernel.org, andrii@kernel.org, qmo@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, eddyz87@gmail.com, 
	ihor.solodrai@linux.dev, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 5:03=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com> =
wrote:
>
> > how old by now are those btf produces that do not emit kflag=3D1 for
> > signed enums? should we even care at this point or just assume that
> > kflag is set correctly?
>
> LLVM 14 and earlier, and pahole before 1.24, for example. Signed
> enum kflag support was added in pahole 1.24 (August 2022) and
> LLVM 15 (September 2022), about four years ago.
>
> libbpf still clears enum kflag when loading BTF into kernels without
> enum64 support, though. bpftool map dump reads that BTF back from
> the kernel, so this also happens with newer compilers.

BTF enum64 support (BTF_KIND_ENUM64) first shipped in Linux 6.0, which
was released on October 2, 2022. So those kernels are old as well.

>
> Dropping the legacy comparison would lose existing negative-enumerator
> name matches for 1-, 2- and 8-byte ENUMs in bpftool, and the 8-byte
> case in libbpf. In the proposed code, 4-byte ENUMs match through the
> helper with or without the legacy comparison.
>
> I'd keep the legacy comparison to preserve those existing name
> matches. Would you prefer to drop it and rely on kflag alone?
>

Yes, we should simplify stuff instead of adding more quirks and
workarounds. I think it's fair to assume kflag is meaningful by now.

> Thanks,
> Hungyu
