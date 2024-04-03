Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE214E2F9
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167015; cv=none; b=AiN64jbYL8h2Ecl9uKcs0rYjkS2ykkkvqAOp1A3SM/viDlikypGXIBgg2k2CHFU4LUX26CGZbyqjipbvyemM7K/V0VzPL+EQFFLo1QyIJGrPL26k2QtBtvUTaCfSsTYh9giSCItAyDT4mPSKP35NYzYEUFAkL/slrKAqHbhsQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167015; c=relaxed/simple;
	bh=Y29iCxVgdIghnGeHEv3l94/qgfKsZEgUmtvd3RlSz1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcS7Slx6wHdglJEbSijuk2v33srtkSQHOswPyeM6la9mqhKRW/rLuc27KDhOnsaWoXcR3Z3ckJL4SkHXaIsDRSJ1dvj9yetfQSBy8Oyvaqbxrlh4+c0OmyeugwLrqjHDXLu7IxDPnTpmjWhv4GMNXJPYed4N5jg/jpYRACWZyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZJz7Z8z; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZJz7Z8z"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so77476a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712167013; x=1712771813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y29iCxVgdIghnGeHEv3l94/qgfKsZEgUmtvd3RlSz1c=;
        b=cZJz7Z8zrpu6CQn3WiQo/oCbVWpT/jZP48Qfqthe1ZRbd0mZi2c9s2smIJhRKLl6MA
         lkIxwBNWyjl/abEchoimPFYAGkobww5U8hhRVK31JqhTpWbOIK0hC9Gzyb8X3UTT3vA2
         4I+2HweL/r2GENgz2lfcVAv/8+4AQqFDazgDEHGIHfEUgLZkxthCo7aTuh/i3pye95MX
         2uM5kdnZRoR2sycez90IigWRZjuF5v51geVWMNbJIFGg8U8q6aeBYzzdj7rvNm7uHzKk
         QmvIHMbi4umnXtWLyODgjiKZltTZFHPaFt9EQP9gkCmyDVWKUE1ocJBrYRqByeHVPUqk
         bvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167013; x=1712771813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y29iCxVgdIghnGeHEv3l94/qgfKsZEgUmtvd3RlSz1c=;
        b=Yixthkhi9V0KSLlwymDD9EjCTPwxAEL8P3z+S3NVR3MIU2phUfOfbDOh34v20anVnb
         NpW/RBG6Ttc5CbszIBudsJTzqjR6+4pSRU7mXzBwsqnf7tfB6HJAgnYMRhfDKqkHEGgD
         EUFxDSeBE/dek1UBxlkwQg79CYubN2wYRk6iCx2cRC8FHww9R93snxuKrG2pqgWpOSF+
         jenv4QyBwaIbAnCSsqdwjkYwg49Wp2uI+WkZWZkDLZbFtHjfd0Df7MALLyqA1J5hTOyg
         Mt2H59TIgEAKGMdnS0hMUVbXZl97OYqYfH/oXaOo2snoNr4P0X9sZivmEGR3m4XaUsoR
         YQLw==
X-Gm-Message-State: AOJu0Yxz6/WR+HAtndY8t3BGlas/7/9kmD+bTSRqqAQrEGirg0yDGOpP
	DCdUUVkjEznvucp+8hmhRugK1n5DBcruujhSeYCIS/ULjCzd9GlKH7QmkzUcyHwjLUyOpgSGQwH
	ZMfTeNf4pf42DCkKsy2dEyCO4LfL4ezaSi8s=
X-Google-Smtp-Source: AGHT+IHVW9SP8FIuv4cljftsVF0UACU5SPPV6gL+7iLM0wMCeU47cxl1GbxlRUxcakkRmy9icQCzkNQwadbWo/tTiBw=
X-Received: by 2002:a17:90b:3687:b0:2a2:bc23:cb2b with SMTP id
 mj7-20020a17090b368700b002a2bc23cb2bmr1153839pjb.6.1712167013405; Wed, 03 Apr
 2024 10:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2zKF-RY-Hr0SCDNttktAhdjOzgP1jLgbH6wD7+ssL4rtA@mail.gmail.com>
In-Reply-To: <CAK3+h2zKF-RY-Hr0SCDNttktAhdjOzgP1jLgbH6wD7+ssL4rtA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 10:56:41 -0700
Message-ID: <CAEf4BzbjwTVUZ154ZqEVSQe-++a=B=SD5L7SRGPGH=N58tLJKA@mail.gmail.com>
Subject: Re: [Question]: How to disable modules BTF independently?
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 10:06=E2=80=AFAM Vincent Li <vincent.mc.li@gmail.com=
> wrote:
>
> Hi,
>
> Once I enabled the open source firewall IPfire kernel 6.6.15
> DEBUG_INFO_BTF, the IPfire ISO image is increased from about 450MB to
> about 1.5GB, I suspect because IPfire has many driver modules to

BTF can't be that big. I think you just get all the DWARF for modules
and vmlinux itself. DWARF is necessary to generate BTF during the
build time, but it can be stripped out afterwards, leaving just (much
smaller) BTF intact.

> support as many hardware as possible, pahole generated BTF for all
> these modules, that could increase the size of the ISO image, so I
> wonder if I could disable modules BTF only but keep vmlinux BTF, or
> maybe selectively enable BTF for some modules, but not other modules?
>
> I found this discussion [0] making DEBUG_INFO_BTF_MODULES selectable
> independently. I am still not sure how to disable modules BTF, I tried
> make menuconfig, still not obvious to me how to disable
> DEBUG_INFO_BTF_MODULES

I think CONFIG_DEBUG_INFO_BTF_MODULES=3Dn should work fine, but see
above, I don't think the BTF is a problem here, it's not stripping out
DWARF.

>
> [0] https://lore.kernel.org/bpf/CAKH8qBu0ptKbMVvoMpgN2tyk84ZGvwuCJLjesqw-=
_8QtSRLqpw@mail.gmail.com/T/#m73cee268387358ec645b665951feb931b294ec2d
>
> Thanks!
>
