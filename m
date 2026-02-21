Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B03207
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 00:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634058; cv=none; b=Wan/1EvLU0fDLbJsGr9gI67i8ssK+jj/AXh6awjgYIUHhesrWrU1lcKC4upNRewUFGsST9CIbOO24XCONhZ8VSvy6neh2zE9KZ9qSNTPqtYlgo3fd/OUgi3zIRkaOGNSRgQ/5jlPQMnqq+TlAmzK7OBtRD+IiFs0S3ybAFNRXMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634058; c=relaxed/simple;
	bh=+9Pp9ApYsKxn+zXNMQUYtOGv6y09GLA+xOluJMC592w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r2xH2hwsWPa6+BXSIbW4BAFFE/1Ohk74Qc/Tm6LxDeZmvOK4gHfnSaYOVm0QP26LI0bQZ7/9OYPJHQ6TTBpv++0paq4XLsdX0IuPlCGfki2A1BlZj37BqPmqXOLNvZ0EIQxaGyxQeprmOW88EcLJTHfqSmDoue+JiJEk1oMDi1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcry/xBP; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcry/xBP"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1270ac5d3efso2555984c88.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 16:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771634057; x=1772238857; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ttEteG/ayhWMedz63/NTbEPehXsvcWGgsms64c50DnM=;
        b=gcry/xBPBBxuzRRmXa5j49FMd/utTwXfTdo+AsSIReMLc/UA9xRyxLrNSCHCj5vlT7
         hgI6DWIPy38V9tuMBgO1DK6oY5B3Xo18Ir2TVh7ahystkQmg/hKxZMYLyvmE+EEjh3IN
         ipz7q90Tcn7wnKlzVFgr7mcM8GtEiCw7TKOesa2A/klFkm6S+8Owsb03DtLjS6pylso5
         zFAS2dovdhR7F3n6S/lF59oK/opgaBCtvEcHd+ZrObBFrs0zlYj+nEB3ueW5VxmPRXKZ
         K5K171Kcv99l08yHGsM59jJembW6q71PhZKKx/8pjMFQMaV58QxgAUTuzAf3Z/r9jrZ7
         Vvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771634057; x=1772238857;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttEteG/ayhWMedz63/NTbEPehXsvcWGgsms64c50DnM=;
        b=Fe4uKi9Sn9bFzPp3iCi99azzs3kPIT3edDfqFsQEzGPpfStqnSze7YLDGaGmw8g0A0
         UkVU1PAoAaM6PUK8KcpLWynMO+OXvbrqjILMbrGvuVzYxxdXjelJnLuPdUBYdrqdONtU
         01eIOFhQkRgpX+yLSJdB4yGNq3GtDNP7L1ywjL7tK4uoMR/icrRVoNb9QQmjaZfquAGk
         iq2qQSNv7lVJlZJffbcrHNEPsOFht4hr5skB2Jb90UCjVOUfZiibBC873K29yflCnYK8
         gUwLE+7hY8HbO6v72OxH1o+hBk6cbPXrkXUhuhuHc8diSyMCM9csZ6YdBqvMQzCY8CpP
         4Xkw==
X-Forwarded-Encrypted: i=1; AJvYcCUL9TYz2RnDE5EMDmJ0b2Gr4d2tle60lgt72dyyeMr7FStD8xx+UbodFWluXMyNRsakTJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbUnC9SiPVxNOtN5fWnFnRX4EYHe+ul1ZcBOH5vTtBLXBTYYo
	LfuNWtIPnHEHN2dX+VsL7CmvN84PTCiEzUz/jzTf+PDsYaYrEqnB3i5NSa8GhSTW
X-Gm-Gg: AZuq6aJTV33rvs3prnRqOlRSvSW8uYZ1gIrD/A/z2mlaRWgBcMkjPhOhANOEjHf5VIz
	XC0TunnoEH2mERB//YdqE4u6Deq6aAl3tYYTHKHuNYVsguUFE8dOpAVJ0ORUtalhHNhl9I/Kd1/
	z/FvOBbJebV9KIu74GEjXMJ8sYacMObleDd93HaVj+TmEnlhUSNG0qIOOUBO2Zp3F1zwK1Iqqz7
	j0eWhnoFBCIt8OSDeiiXcAv7rW0I9PVNaTN7iD/AxrlMQpYyXfLcUKtO4pyTcifgjGWeqPBV3mH
	gDBj8d3ZPXcEeK0I38djoo1a4NTI+wuV3/ZYhHCYOyDPhQx8QrwhJmmDTL4gIO36xv1Rk+NoIHH
	5320Cx0jNu+BLZ4iSWo4Vz/cGlte9nU95/gEaEhoz2QN4ovN3mgiHbd/GEX+3SrKZ55yAho7Gd4
	2ygiT8XR+6M8vlXAUvAXkRRpD81UlWuCBe4iLCYEjMqxJfld913/N8jjx1YUKUNlQ8l5NscUiJn
	g0SWQzP
X-Received: by 2002:a05:7022:6899:b0:123:35cb:96e3 with SMTP id a92af1059eb24-1276ad7acf2mr684127c88.46.1771634056591;
        Fri, 20 Feb 2026 16:34:16 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:dc10:521c:4103:cf1e? ([2620:10d:c090:500::1:a80e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167b2sm457407eec.28.2026.02.20.16.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 16:34:16 -0800 (PST)
Message-ID: <241561e0036fa1e5a8f88d4e6db0c09892d3f2b9.camel@gmail.com>
Subject: Re: [PATCH v2 bpf 4/4] selftests/bpf: Avoid simplification of
 crafted bounds test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Harishankar
 Vishwanathan <harishankar.vishwanathan@gmail.com>, Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Fri, 20 Feb 2026 16:34:14 -0800
In-Reply-To: <6863a99d6e168e41b61eb29ff2519e82509ab5b3.1771594636.git.paul.chaignon@gmail.com>
References: <cover.1771594636.git.paul.chaignon@gmail.com>
	 <6863a99d6e168e41b61eb29ff2519e82509ab5b3.1771594636.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-20 at 14:58 +0100, Paul Chaignon wrote:
> The reg_bounds_crafted tests validate the verifier's range analysis
> logic. They focus on the actual ranges and thus ignore the tnum. As a
> consequence, they carry the assumption that the tested cases can be
> reproduced in userspace without using the tnum information.
>=20
> Unfortunately, the previous change the refinement logic breaks that
> assumption for one test case:
>=20
>   (u64)2147483648 (u32)<op> [4294967294; 0x100000000]
>=20
> The tested bytecode is shown below. Without our previous improvement, on
> the false branch of the condition, R7 is only known to have u64 range
> [0xfffffffe; 0x100000000]. With our improvement, and using the tnum
> information, we can deduce that R7 equals 0x100000000.
>=20
>   19: (bc) w0 =3D w6                ; R6=3D0x80000000
>   20: (bc) w0 =3D w7                ; R7=3Dscalar(smin=3Dumin=3D0xfffffff=
e,smax=3Dumax=3D0x100000000,smin32=3D-2,smax32=3D0,var_off=3D(0x0; 0x1fffff=
fff))
>   21: (be) if w6 <=3D w7 goto pc+3  ; R6=3D0x80000000 R7=3D0x100000000
>=20
> R7's tnum is (0; 0x1ffffffff). On the false branch, regs_refine_cond_op
> refines R7's u32 range to [0; 0x7fffffff]. Then, __reg32_deduce_bounds
> refines the s32 range to 0 using u32 and finally also sets u32=3D0.
> From this, __reg_bound_offset improves the tnum to (0; 0x100000000).
> Finally, our previous patch uses this new tnum to deduce that it only
> intersect with u64=3D[0xfffffffe; 0x100000000] in a single value:
> 0x100000000.
>=20
> Because the verifier uses the tnum to reach this constant value, the
> selftest is unable to reproduce it by only simulating ranges. The
> solution implemented in this patch is to change the test case such that
> there is more than one overlap value between u64 and the tnum. The max.
> u64 value is thus changed from 0x100000000 to 0x300000000.
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

The change seem to preserve the original test case intent.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
