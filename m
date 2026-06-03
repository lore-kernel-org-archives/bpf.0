Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0E1A681E
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 01:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780451910; cv=none; b=hZkrxYBJDIFe+m/AuNwGTdYAK7GNAimnAY3y/aX9fpp22Rvt2lfPE2jYmMATOfPZHTAuSF+ur7g8AhUCPEgjgLekqNHWJ9bB+9W4EjI8tYUfeKbi3zbUoeY9+u0sVFGbZgrXLxrWx0z91IcqRBFdYx6bYDt+IpLQ7F6+xVHBrO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780451910; c=relaxed/simple;
	bh=3Is7N/1s9kesTV6NifnE11ZTm6dK8ik8AnUdJpZ9u1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4Ftuyz6UK4eEY8gNN/KOZDChFcO0Q90ZpcbIWNp8G8MEN5XLEXPdL2dRtox4JJ+JwLGv/t1ZDhWTSFTj4TgqIAH8zTA4+7UHKzRjT+ivCLv1NpCvF4MU1A+F31BeXn588+PRHeHObcZ0o054IGnTR38Oerm26MqRKmc224QxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=manifault.com; dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=0rtbFtby; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manifault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="0rtbFtby"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e62b6163c8so3512618a34.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1780451908; x=1781056708; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Is7N/1s9kesTV6NifnE11ZTm6dK8ik8AnUdJpZ9u1I=;
        b=0rtbFtbyTZCAASKL658vuOyYHFETjKUckuuC2re5PG2Fru/V85370HXX2kZ3n9S++k
         k/gNHyWItfPtExbP9ylsPLpXCXPWqI+zv5tnqpnbM2z9kYvV1P8wi+KL5MW4M0HPwP7x
         juz8bubVq+CpHjOzc/zihGM+Yj4ECo25An5Ng6PJrVn03RMGWGzF7YDzLF9oMlpytzOI
         BsMmvofEurvgUlMDON6JjhxA66sNAGfyHlyIbl2fU9F/bvNMaUMB61P8Jt0NVgZGcrPn
         lA52kePFAsEe9+MOsX+PRABI9dyWZ2vgkWhz7LlFkjl9IPC3Hme5osEHssU5YIjmRM1q
         FcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780451908; x=1781056708;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Is7N/1s9kesTV6NifnE11ZTm6dK8ik8AnUdJpZ9u1I=;
        b=h9M2KMHeQa/NpWI9lFN0lx9dNCTe1EiTkQ/kdky/d0TYK8zNhWmRmXbSMSYv08kVmW
         Zqz9a8rDVzVXcpcX+Vq3iHRc4yVFNZOq6FQ/dyUhYsknH7odLHL33+8b2YeZR7vTvPwo
         Zpbl7RvC/mkBTgWv6x4jcW7d7kTOgCiejxcZ79VUZynZVMcp7+ZA1JZzdjiE4d/noSjR
         6wYCejmijy63osU8RVfkZiz2vs2iPrNn+K2dsEjp2jDmLLTktpdOqjzMhBW7SukA4YYs
         U4KgK80iKBWwrOPgCllEeUEgMAr4CN5DdlgAIYo2CIRZOCCyJg/br+QIhQIkGJtn5CqF
         pdpw==
X-Forwarded-Encrypted: i=1; AFNElJ/JXBaS4X9/oYkYKvNJqsvg72J9tyL6RiAzakm2bNIvrE5Pi5R6UBU+mDSvOvjFfqyu0Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/3MFs8BUqSPQIhm5lNc/+NUI3nla2XOEpO09aa8PevEGrcpK
	N64vlGnpIqDUwQ6y5jtb+N7Q4w6MTHXIXGC92KNfIFJRWKlEGL+vCCEa5Vu26EbadkGN
X-Gm-Gg: Acq92OFs3oYZwmpjT8sontPcP1x9LHEPYUuf6Lhj4040Sk8QnqZELnqpdlHOqUgdC4q
	7hxjd0XZPrb1RzfsZWBFF8i06ZaD3TTr4mWvd6t2MG/a+sUXJAkGgevCh3d26zd8sAwmIhnTyjN
	VvDN0Y8uVBriJ+sBBACFcszXEf+LDleaWpn8EVF1uHUURERIIgF/PF5GPjFYZ+xiDyevxWGWC2G
	ktBCm4iu1GaV4YtXTNcOJNf40F44qMK/MeBxBIB5hDlPvLtlrGloMueVkOkKtJdibnyvs7pFA6v
	cBo5FJl7BpW0b3/YmlqSHcBiTomFbCad2nEIJlGiA0XOPDcoa3R34JFlsligTERvU3eBrtCWUPB
	7Hd7cKBmGdbgeCrO79Zwk/Ogbe+G07vlU4RNXLP+K6xpuXMQrEYWJv/TA11NOs13awYN25flu0o
	tZpPhYcDtKlPcNp4uKqWzo8lcz07XQ/4NoR8sQWVMz5dA674BXXBeoU0wuzmYprr4aZ4lhzg==
X-Received: by 2002:a05:6830:6ae6:b0:7d7:419a:7ac8 with SMTP id 46e09a7af769-7e6e9d3b2b0mr631893a34.15.1780451907761;
        Tue, 02 Jun 2026 18:58:27 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e75c5495sm791076a34.10.2026.06.02.18.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:58:27 -0700 (PDT)
Date: Tue, 2 Jun 2026 20:58:25 -0500
From: David Vernet <void@manifault.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	bpf@vger.kernel.org, bpf@ietf.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf, docs: add LOAD_ACQUIRE and
 STORE_RELEASE instructions
Message-ID: <ah-KCqA0FgLcX4NQ@maniforge>
References: <20260521-bpf-insn-doc-v2-1-8c43c037d599@bootlin.com>
 <iulf7fwwvfrvvspg4e5xyx3tcxe2yonfjllnze2phgfgpynrlh@kodf3fy3l32q>
 <DIP2GAUG3O18.29B8U0FOVEVET@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ezldfm6trmndxdd2"
Content-Disposition: inline
In-Reply-To: <DIP2GAUG3O18.29B8U0FOVEVET@bootlin.com>
User-Agent: NeoMutt/20260105


--ezldfm6trmndxdd2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH bpf-next v2] bpf, docs: add LOAD_ACQUIRE and
 STORE_RELEASE instructions
MIME-Version: 1.0

On Fri, May 22, 2026 at 10:35:20AM +0200, Alexis Lothor=E9 wrote:

[...]

> I don't know how heavy/long the process is to submit this kind of RFC
> update, but your point makes it sound like it makes more sense to just
> go directly for the proper way, ie adding the conformance group and then
> adding those new ops in there, rather than updating the kernel doc as my
> series is proposing, and then later reverting to a proper conformance
> group.

Hey Alexis,

Apologies for the delay. My email filter was broken so I only just saw
this. Yes, this would be my suggestion. I can send out a patch that gets
this started later this week.

Thanks,
David

--ezldfm6trmndxdd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCah+KQQAKCRBZ5LhpZcTz
ZB68AP0XZVyPSmVl/+Ql+/VELqAYsqSL+Iq1Wkure4rdMn3Y5wEAwxbBaowMElWS
MSr9V7Fqms8AHBV4LXZ24XslYEAK4ww=
=MHgJ
-----END PGP SIGNATURE-----

--ezldfm6trmndxdd2--
