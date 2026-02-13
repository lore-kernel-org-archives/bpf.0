Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA7A26738B
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005975; cv=none; b=sm7dtmyupEQ4glj0MMD/4IwYs8Zh0R6fnp96sfzU1Iv8220rXYPiFXzsOz3iNOjeA+KzOjeG8CYofakB3Vg8N7HXr6dsrihLV+oGQny+RgoqKiHcpR83n7Z7r2DBd4rzq9N61cX8z4/HJsttUrqaw30eNhp0hBUIPdLNNcJunmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005975; c=relaxed/simple;
	bh=Qqz+Z6qDHdduMATre+/3ILrfrF2RoZdEoBC6jxCpcmA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKYpQuyAPiBwj82PytsRBG9PBvIM6z9ia6trnMGGYIu3y3Ago7GrDOd3O6LjB+8w1MekYQGABCMcKHXe/AoPY7VTsvmoHhe46sjmSFalMjF+jMe28HuB7eayURvrZe1bsGFfRJpJb76d/euXj8lfhugjWtcXSxjC8H/wvRKSrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBlzhttl; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBlzhttl"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b82c605dbdso2392709eec.0
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771005974; x=1771610774; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3QTkGi0UBhaK6O0FpMNS7IlNxRnMRqJemfzCR4VAA3E=;
        b=XBlzhttlcqPr5fFniegoOPURzTvkMIq9G6MOJBRTcKxqebsh+1sbowewyVJ7DxEJnu
         IlNQg2o1JrwFcpZ0rziRF/oG6Xj4GA2Eu4HspB5H0oLxQ2YFKOH/dTCjvNPVWkt4HP5X
         P+jk3+ErZA5Ewv8FeO6G8feHuzUZc4bDME2cpcNPnO6AFs/arWaOq3Z79pxvwRpARp0a
         ZfRy01JuvOhT4fCchEwtuNvk0y7WlieQcAPeH4SrYHLktUXUgeLfAEqy/AtSzOZWGU/n
         S3NDN4hOZ3HvwZoAU+wx2XE+jBtI5KOH01KdiDU5tV+mC4Hc6+HJZemzEJlqmJzesXuA
         0Ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771005974; x=1771610774;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QTkGi0UBhaK6O0FpMNS7IlNxRnMRqJemfzCR4VAA3E=;
        b=YskY41p54kuFkMy0RAateQLh7FrrxtHLNnYvmPPUg0FphEX4k5RqW8nl9cNwMgd5KY
         lg8QK3YhPQgd+OS1Bvr8vddYRKSK2v60mi+P35o/5oA/Y8u2CWLjtQC0JNoU91bexbeP
         oh8vntF5PMweQGLkGlSWdnfS25BhWeorOPsJ7XxX2fmRDZ7DVqOFXgQ8KBkW/rkeUhDu
         YvMrcR8dpGaTU+Brd2f/e7Z8IHkL8qCHJJ5/xrrieHAP5NJawCfb2g17czXEnet/+XNf
         S9xW3vkMomzToGjMA8AqQ6U6R6hP6sPB11iv0bOkynzjitdclSP3SO1u1askYmbS3kW7
         USDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnIC6cY3U1V/Zx3dMoQtVRnu6gUAbO/RW2HgIt6gd8ULW6jV0KLROo7HSvawID9yWc1Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzww1oyVWjgffn2IVbFHwQcebuAe36hy77dP5xrzutEQgvwIcL5
	2lnrIfaCMkiHQe742DJAFIYHumaNCh5Biivbudd2v4gt7VCB5hPzbkb3
X-Gm-Gg: AZuq6aLYqMUrrzwvSRnN26YxTiBEQkYZ9x1TRQpvEWiW2ZpTRHe+IUeqW3EQcq51Kv+
	v3YWQzX4Yh5Wub4bMr+DAKWnDTi3RxtGB4WGvk9zrBkVdrUpr4Mk9cDzfvGxLEgdDXD1awrF9L0
	UxFs9VlIe9biu52qsoTCd+VYsLjWxPsq3iXyyvhS+VSaFJomSIXiP8WCu91A/ShFw+zgpP22btG
	deeFlObno2sxgspv+qnelhvEX5ynIQkbjyTICAmXQq9ppgfDf0xe421FCWQ9DqpSSw3IjNrbMqB
	EQZBqiA8MUZ6RmSBwBFXUDUMSelpej+wBTYyVK0U3A+jMDrjCk1YQop4/pxtLI4jxscvEg+jB4F
	4Y1rF9yE9Xn5NNeRq0TO34dDE4BInP1+/j7I/M7B0i20E4CvBqLGtmAkzqEQs+ITx5R4Jiu9m4S
	4+oQpLukdICUXnYP3F1WbwSEKOIFYpAPxxXb8mgv0zvPDJdVlqdG0xuGnSLv2kivPddk3IrSWOH
	71WoZAn1VAi1SwmrhQ=
X-Received: by 2002:a05:7301:4888:b0:2b0:53e5:89df with SMTP id 5a478bee46e88-2babc3b6a8fmr1211392eec.5.1771005973846;
        Fri, 13 Feb 2026 10:06:13 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:8da8:cd8b:c759:e11f? ([2620:10d:c090:500::2:357a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcfb804sm6009142eec.28.2026.02.13.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 10:06:13 -0800 (PST)
Message-ID: <73d832948b01dbc0ebc60d85574bdf8537f3a810.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 00/14] selftests/bpf: Fixes for userspace
 ASAN
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
 Alexis =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Fri, 13 Feb 2026 10:06:11 -0800
In-Reply-To: <de259393-c414-4834-bd62-b65774e201a7@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
	 <59d226c413864ec7229e4a74af7e663e9982c534.camel@gmail.com>
	 <2a532f02-a7ed-43d5-a0fc-129ee4eeb0c1@linux.dev>
	 <b1399390b3e34961c3afd5a6a06c3c7bb3a4666a.camel@gmail.com>
	 <de259393-c414-4834-bd62-b65774e201a7@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-13 at 08:13 -0800, Ihor Solodrai wrote:

[...]

> So what happens is test_prog's custom signal handler *overwrites* ASAN's
> signal handler leading to the weirdness we are seeing.

That's what I meant by conflict.

>=20
> [1] https://stackoverflow.com/questions/17102919/is-it-valid-to-have-mult=
iple-signal-handlers-for-same-signal
> [2] https://man7.org/linux/man-pages/man2/sigaction.2.html
>=20
> We should probably do then:
>=20
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
> index 02a85dda30e6..77a36f6ca352 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1672,14 +1672,15 @@ static void server_main(void)
>  {
>         pthread_t *dispatcher_threads;
>         struct dispatch_data *data;
> +       int i;
> +
> +#ifndef __SANITIZE_ADDRESS__
>         struct sigaction sigact_int =3D {
>                 .sa_handler =3D sigint_handler,
>                 .sa_flags =3D SA_RESETHAND,
>         };
> -       int i;
> -
>         sigaction(SIGINT, &sigact_int, NULL);
> -
> +#endif
>         dispatcher_threads =3D calloc(sizeof(pthread_t), env.workers);
>         data =3D calloc(sizeof(struct dispatch_data), env.workers);

ASAN's stack trace looks nicer compared to what libunwind generates.
On the other hand, test_progs.c:carsh_handler() prints pending test log.
There is an option to remember old handler returned by sigaction and
call it from the crash_handler (thus invoking ASAN's handler),
but the complication is probably not worth it.
I think this part is good as it is, sorry for the noise.

[...]
