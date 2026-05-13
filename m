Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E443388E48
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715088; cv=none; b=dg7WwasSxbFVwD2AubFQpFOvdXdRoEn5Gln3TerQthcCBn88GknqzT2J/yyPXaa9vjRE8rJo1oXXLV+rdLjqNG+8dkavapuvPYxqMk4AIhHXp9x3mx/0n4LKOJuRILp+4X/vYYZ1RXTHqLINUlXp840kI7/IlFBoIXxsKNoYah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715088; c=relaxed/simple;
	bh=wU/Lq2lWfS3Zm5DZ6YOB7nWmVbikOd00hCL43rRQ6tg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ku+OI0VHL8FonGrQ+irQUPPh6qOUvyByamvFm6vtkYo5Lpw7i1mhbIc8HVEgZ0Pmt26/5ai9arCEXXLr9/omazI3RrA3p2CWFXvw4XvAKJbKh+nepUGfpoGFWBgH8kqnWBom7VdVgezpiOMDqR3DjHzbd1B9ZL3yadweoLl3Atg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEXVFYZ7; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEXVFYZ7"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1335cb20406so5860338c88.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778715086; x=1779319886; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wU/Lq2lWfS3Zm5DZ6YOB7nWmVbikOd00hCL43rRQ6tg=;
        b=QEXVFYZ7LTJPmGyIpHY1LqRD1j6u2UkJ2IRP9WdGs4/MLdsOs23UWXwnOkMw2dehwL
         9M/rPNLEf6urPntLOG4l02NMUl15odt+6AVW8EjZ1/zP/qoIshqBT6d/qyxpetuXN4CL
         l1rf2y8mOSJn82BLF1R+Hxm4TWD63rfgurzsxOZXqBX5HpNi3fwk9PSy0iMQqbfLD7UH
         /Fg4Eh+rmwdn4R+6friKTxmeaTLPbejwe0vP0ZcxGSHIUZO56Yrznr8wS0nG16PEikHX
         fBiQvqjEwx0XZqxqVbFAbJqb+TYcck73DSbd26TNZo4ggyEz5IXqstqthBAbQx2wWS+4
         9gBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715086; x=1779319886;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wU/Lq2lWfS3Zm5DZ6YOB7nWmVbikOd00hCL43rRQ6tg=;
        b=UjOgfQa+7fbkG5kTMAx3SwrgE1tzTjikjSdsePZsRsgcJmS3JplXdBzLQQbAoF2bOM
         tbxRfjEbyoNHks4W/jvh1gd6c+1q5vGxMR94DZCsDGUVAKhxqMkdcx02zhHOeKrK5jha
         ixubP0lADYAa94nd7dqQuhRwVVyZVhWqgGKeRhnfXQB3PTHOV7ZV1BUdcVBYTjpDOR61
         a5Y7PeWLYhFooTwPsqk+XSMUroIUPMumAPvab2PjcsstKElmtF/Kb3Fj+4TG32eEBQfT
         EaM/ATGjgwe233OiFuFV8UL1C3DAzq0KUoHc2cw55Zn0tEQwu9E9XXqecJby7ToI4OH5
         tKrA==
X-Forwarded-Encrypted: i=1; AFNElJ9C7GUhaGzx6kXTw7Gz0W68/mDWXoHL8OhJS+SPPSYXIzbyRMfOrLcv7gHUhGMiI3WO/SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjcZs16G6X7yT2RwsYZgidH72EYOM5IzJ324ct2jTWdJW1EDXW
	abA7VSjm8wPSiSJF9Smxp2mjJTIMG0LH4+ScjeQQFv/DbaZrE5jIAcQq
X-Gm-Gg: Acq92OG0CvaubYU5fhuLMWeURTXztd6o6JADH0Wleo64cjDiYdIfy8hq+qU5dBuAeCT
	k/TV95evOkj1bb+bJGB+9OQG5As1iYJxrXXy0hNjlaD2SBCl99v2l/86NqWgVA9u2AJIDMEwExl
	AHfdELZ6UfzRdl8ezSKYPT2gd34AOJB38832Sgl72N/dggWsw5Ev4rOpxWvuFpdDQ+2TcH5H43x
	G+JngxXSYQvh0+Ce8PXcC1XUBptCFohg10aSyfI3pZ0IEpS2Zugl/rCitLAlh2SSNnsWbNWrIyr
	FoJ2F9Z3wYDFtaPGWAZu8Qk82PBBmdg2+D8tstHuHssf/MZ/NalSaspG8PpEEj61+bVQvJDgyF6
	lf+0d2BsKxG14pEBTBkBWDTaUytmTGnVuXRWK66JTbYQ20nqCONsOTqNzk6p3lPL2m2SE9oXKoP
	0OKOf79Y7DyDFn3vLYz19f2AO9AWje7+VW0r5VV78dW7w6uQXVIYFCQ4sySTksKoiS8cpFWlrdP
	0xcnhc1WwfZJSfnXQ==
X-Received: by 2002:a05:7301:292e:b0:2da:44ac:6d0d with SMTP id 5a478bee46e88-30118da9d18mr3650387eec.20.1778715086222;
        Wed, 13 May 2026 16:31:26 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5152:641f:f5ef:6c7b? ([2620:10d:c090:500::2:8a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978b1a79sm888364eec.28.2026.05.13.16.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 16:31:25 -0700 (PDT)
Message-ID: <25d39a1c3c9dcce1700572f7ad0708bbbda14412.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Test reported max stack
 depth
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 13 May 2026 16:31:24 -0700
In-Reply-To: <075d22efd4338385a92f13b7817025cc3f04ec60.1778700777.git.paul.chaignon@gmail.com>
References: <cover.1778700777.git.paul.chaignon@gmail.com>
	 <075d22efd4338385a92f13b7817025cc3f04ec60.1778700777.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-13 at 21:35 +0200, Paul Chaignon wrote:
> This patch tests the maximum stack depth reporting in verifier logs,
> with a couple special cases covered: fastcall, private stacks (main
> subprog & callee), and rounding up to 16 bytes. For that last one, we
> need to skip the test when JIT compilation is disabled as the rounding
> is then to 32 bytes.
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
