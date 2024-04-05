Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB715175550
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353849; cv=none; b=Sgj+lPVn0xzgNivKT1xQGk07iA7z1TZ+VoPDb9D+BXsod7d+OGuIjRci0qv2FXK1DNT0B3jWcDiNBodsGkdCDcTqnhPjyUDuLnOhkJSfQoJmBALA0FXutmezvmWtBGCN04ujE/p9CvLMTRU7JvAwn3gNauu97V+zKoW2m7n/7xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353849; c=relaxed/simple;
	bh=MkDjiy78T2gQvjBrd+yN+stkC4ckN623/TIHPyRdJDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC/4PrV9mjmmDveGJIXOJ3YLqFP6cx/sCXywygIpf73YmqTNo0EiuTHk3eRkaaxjca8D/0gtIwt/0cht4fHwnzYgrN//3ODmyJX6klXJjO3wJHohq9l8xQUYxvoFCPuOWv6erPZE7ZGZ9xgCjiyKSVj3LREiu0QGOVL0LyTCYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36a0cc66deeso4931425ab.0
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 14:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353847; x=1712958647;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SVa3x1GQyzgKUqSL9XUk4vxsCQq4oEEq4beU1TxGWg=;
        b=olOxaP2GlIFpBmKaqJLJKhLmAijbgza31PAc35mX/pcdZ6q5zADD60kSUe0bmxImAb
         uQLNnLLfBMHe1X07gtVXAj1DQkXkhzy+f1Aa1K25I7gh49yzsVTFAbJ9JmO1MJICt1Wr
         1bGpl3H5GEJCXM0CN9YKMria9H2U0Tzi+1GZyNpyesNP6HxVBlXL6cSRaDjYdviTNytT
         GAS66d/gitujUwuRiBjn/23prMUcEZbGW9ccQmiFXY7ND3CS5SQ66t3OXxtnw0lHrhVC
         osNwu/61B/IeYik8Ks71N/pAN53MOl10h8ZOEqb2FGHr/rRrTxMlvVz7hCh5j99BNZ+v
         b0nA==
X-Gm-Message-State: AOJu0Yzq3+yq5zDXsx2b22eE2kw/Wc36DMfUSdKNBVf1Xrt2IbUkOIlq
	/nHhPgHZ15fXRuNQtQ6U6NBpBRtv0Wshy7JUZ/7Xu7UjUlqwTNS19Q58n8Cq
X-Google-Smtp-Source: AGHT+IG3iRCx54aL+kmC2Hhp/p/XJ/S0cqmY6DfxbQGj2b+6f2mhS2baks5DILYlieiQukzXgysi5Q==
X-Received: by 2002:a05:6e02:13ad:b0:369:f2c1:28d8 with SMTP id h13-20020a056e0213ad00b00369f2c128d8mr2848732ilo.16.1712353846660;
        Fri, 05 Apr 2024 14:50:46 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id i6-20020a056638400600b0047eccd4ba7fsm799815jai.7.2024.04.05.14.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:50:46 -0700 (PDT)
Date: Fri, 5 Apr 2024 16:50:44 -0500
From: David Vernet <void@manifault.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: bpf@vger.kernel.org, bpf@ietf.org
Subject: Re: [Bpf] Follow up on "call helper function by address" terminology
Message-ID: <20240405215044.GC19691@maniforge>
References: <0a0f01da8795$5496b250$fdc416f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8BPdU16yO81BDdLs"
Content-Disposition: inline
In-Reply-To: <0a0f01da8795$5496b250$fdc416f0$@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--8BPdU16yO81BDdLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 01:10:38PM -0700, dthaler1968=3D40googlemail.com@dm=
arc.ietf.org wrote:
> At IETF 119, we agreed that "by address" should be changed to
> something else in the ISA.  The term "legacy ID" was used during the
> discussion but Christoph (if I remember right) pointed out that such
> IDs are not deprecated per se.  Hence "legacy" may not be the right
> word since we use that word with legacy packet access instructions
> that are deprecated. We decided to take further discussion to the
> list, hence this email.
>=20
> We need some term to distinguish them from BTF IDs, so another
> alternative might be "non-BTF ID".

Non-BTF ID is fine with me. Any objections?

Thanks,
David

--8BPdU16yO81BDdLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZhByNAAKCRBZ5LhpZcTz
ZGi1AP98naPlv7LtEB+U0LxQXD175yVQyGAbcvCs1ZnatApA9gD8DmqDH8syjafk
wGeFVpEFsNb1KdvKMFVHOIG9ZBBDxwo=
=JLbQ
-----END PGP SIGNATURE-----

--8BPdU16yO81BDdLs--
