Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D221B394F
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006194; cv=none; b=b3+emdDkEQd+gVU6JxGcSRT7rirpPzu/w8M6SJUBopMwoHDeMV7Nsbxs5Kh7cIZn16Djc42dyMIOfyJM1jpRSFF8wD0j2E/hkUk8KoXdwUoZS5H1SKQxckLttlUkkczHUqZdCkVzozdS8E58ORwnirXIoVtxyCjzrYwiHdWolsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006194; c=relaxed/simple;
	bh=rA+ZGUwf97oKWuIzYbm3bITITE+6t/DJLp8nSkOBXIE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LdGKExYdhB5vSwJfacH35xFDNt5siAdhWsOk7yzH35sW888Ry3RssxrBLU+4BFpMrR848WsKRdMoJeAsbyVvNszPPpL7eFqzP8jqoS6HtPitZ40VpWsYB6Y4eZjK4S5ahrgEwse2q7yCfqv8jOsjcgFwGU9tkJmu3Pi3GZ6tRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxS0Rrs6; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxS0Rrs6"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1273349c56bso1675363c88.0
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 10:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771006192; x=1771610992; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rA+ZGUwf97oKWuIzYbm3bITITE+6t/DJLp8nSkOBXIE=;
        b=SxS0Rrs6eN5mF+JGIwwQidYghilkvUqHXDzWFxLuy4YroEmQF66PyMwiXfdBlyQKYs
         01RSGrcXeVFiiy2iRg4bUOOMNtgZ/HqDeEVRZNj7krWjlDsbdp8e8W+RMmpNJvPxFawr
         B42fzSGjUAoXUoPoAdqyDLpcTd6uoM8p2W4xvGlHiooLF3/gxHKTZzBsul8i9TbbZI2S
         XuY0VWC5odJy1mAF9TA+kPPXlq06/z8MMkLYdgQnYBkrXFauzc4vv7inYUux79gBmaKb
         0Cj1GF2sHMm8qzxr0ZyTOfvlHA5eVQe45x3j9NQVxJ2XM9ALnKJe7YcI1HztOHmI7POK
         YJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771006192; x=1771610992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rA+ZGUwf97oKWuIzYbm3bITITE+6t/DJLp8nSkOBXIE=;
        b=Ga4ib1h/edZkQnoKsdR+dC3N2mr11HSnMaxqZxh0uYSgc9zXiV6CL2HNTE3CiFg8f0
         Sydrg3/sKk16wtKcFbWOkdwFJ/807UIH28Ve4Nr8dCCB5J4VhuhLBrnXIMV0NiLOtjq7
         NOFpIAjeBKjzA/mJXMr0galE3UeNbyb1sKW/VXgonPa1lh+thk500YQhOYrR1dnOR66a
         KBs13+a9Xs/pzlpK1IKpEfXPChXFlVBevGMIbBmoQ4Ov28MWUBhbmr6/11cBL6ViOum8
         zCWyDD/2gaWlaT4yia1zT9MO5BPXyeCTZlUgd4VqRMDrCTiIPe8l7qhUt5IJvDqf+U/e
         WtiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWqPfX98J5NLlvGEhqszX6gQi1z9eKuqUjWjpUaX3tCPwNP9rwRPYqoPUQpcudi2FK3io=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8SvrJctCQ9S42xc5h6culdDIppkf2DI92Y9busg5CeQIChUs
	3bJZsEXt8jZKXPeH6XNK184lP9xE0HLgoNGkKqol4V5ocQUuQLrlQy6s
X-Gm-Gg: AZuq6aJT4m+Kbz33uIz6RH4U7un0ovtInPvx/OxrDhTaSqyQgzbaaa5LQqNB3Fbfmy1
	MzNpGT2yXsyn5NPDeSYyvDzrZ20CXmVxVzDoZ6n6jiw+rDIPhm/d8kvQM9rOmLRDHS8Qst/mAyA
	EJH4UQgj14HzClthHHA4etSjekwK3AbuoNtJu/jOEfLokf+sH73IU4tYV/SnZXbkQkBdO2/ia8L
	suMXVndDjO27DSCq0gWsQY3tMLsPJAf0RGPIGTmLvNwzX7gOx1hdYuDvcIfta2Yg76OJpDVydAF
	C4mfaxwkwMjGHw+aeqsfRRdIMCPjgLrboEz5mc24DISznQN2MjZWV6NjSBqTydIqBDK34/qYxx3
	s8eBVlZki2YXMDd4KxZe8nqEhY2KCoXD8W30rsNZ26bLbu9qmYnQcaSTUNwgoOOjkOIm9jkjY/j
	QzSDvnHRXCZ/DR86BsAsKWridsgQDsFEWVGFNQTQqioEIwi0GlN5mRjDmZFoixUynhYslMtNMRH
	V5InkKq
X-Received: by 2002:a05:7022:45a8:b0:119:e569:f626 with SMTP id a92af1059eb24-12741bc8629mr153992c88.31.1771006192199;
        Fri, 13 Feb 2026 10:09:52 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:8da8:cd8b:c759:e11f? ([2620:10d:c090:500::2:357a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6e943fsm6787843c88.11.2026.02.13.10.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 10:09:51 -0800 (PST)
Message-ID: <f73c28386eedc3ad462906041a4962e3465b1a1e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 00/14] selftests/bpf: Fixes for userspace
 ASAN
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
 Alexis =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Fri, 13 Feb 2026 10:09:50 -0800
In-Reply-To: <d80a723b-6fe5-4dfc-8a9c-20fdb37b5341@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
	 <4150f31f020710932def63e2857ebab1e311b597.camel@gmail.com>
	 <d80a723b-6fe5-4dfc-8a9c-20fdb37b5341@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-13 at 09:56 -0800, Ihor Solodrai wrote:
> On 2/12/26 3:26 PM, Eduard Zingerman wrote:
> > On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:
> > > This series includes various fixes aiming to enable test_progs run
> > > with userspace address sanitizer on BPF CI.
> > >=20
> > > The first patch fixes the selftests/bpf/test_progs build with:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 SAN_CFLAGS=3D"-fsanitize=3Daddress -fno-omit-frame=
-pointer"
> > >=20
> > > The subsequent patches fix bugs reported by the address sanitizer on
> > > attempt to run the tests.
> > >=20
> > > The series is a pre-requisite for enabling "test_progs with ASAN"
> > > workflow on BPF CI.
> >=20
> > Also, do we want to have ASAN enabled by default?
>=20
> I don't think so. At least not right away.
>=20
> > If it would be enabled for CI, people will need to deal with local
> > configuration anyway. It might make sense to put the default flags in
> > to save everyone the trouble of figuring out which flags CI uses.
> > Wdyt?
>=20
> WIP CI changes add an *additional* test job, that builds only
> test_progs default flavor with ASAN and runs it. Previous test jobs,
> built with -static, are still there as usual.
>=20
> There are tests that don't play well with ASAN such as BPF arena
> tests, and some tests may be much slower when ASAN is enabled.
> We still want to run them on CI.

Fair enough.

> I don't see why we should pick between asan everywhere or
> nowhere. At the very least, CI should make sure selftests can build
> successfully without the asan flags.
>=20
> Additional job will catch most of bugs of the sort covered in this
> series, and that is good enough I think.

My main concern is that when this fails on CI I will have to dig
through CI config to recover exact SAN_CFLAGS used. If not enabled by
default I'd still like to have a single knob like 'ASAN=3Dt'.
