Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33118362154
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787515189; cv=none; b=V13v/Whis1a2TP7m0I6OxqD64dheLd4hJ4omgeCJ2nxkdvFcYm1e2sE6PiSZ41mR7QKPSbkQ2BzapHLEWZFZNollN2I3a8soMFyUw62PbkzelSsyOxHdIoN0bjnXqJ4WVxNCsH+7tqR4wEoHt3LNap0FyUcYK/3Ata/a+DTldFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787515189; c=relaxed/simple;
	bh=lOmZk64DPfrz+xmxtznT5MjKh1OPLPfXC4UK3NqjbJc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jYusBxPOLJWNwBFBW38znBZaFvErNX5y0bLcm3s9zDLE6zcVsbYT+J6FxfM+F2R+PyMSzyl+4ltH4WeMoaYoQMnTlJT3ZNYwp5c0gP69kiyyB+K9n2btELlsqSO0v6Lqt/rVaC5y4rhIObcX4N1UXoRDzB49MmIhpbkbt8a+WFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbzEFY8s; arc=none smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbzEFY8s"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c15f8dd6f18so225008066b.1
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787515185; x=1788119985; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0QasYc6RCSMa5sPreNe5srZRIz9d6Ol1y/kYNoBuD2o=;
        b=NbzEFY8sF7vBA3nLEfS848A+ql5OEQioZCDUZrQEDy3vknCBCJibIkGktYQelJ+e+5
         uHCaaDNcTwqhKERvc9FKctLzwzteFDKOs+PmT4UFQmM7K8rLCY1vsDBQsySoPLJq0P/f
         iUWuE8vJCIQd8i9xo6TCrhx2GbQHKvItgcEgC7l3hnz5qT06GuyxgQQWVSzz/ywOy1vv
         sMU7EX+EJ90Kie/qLZsn6SfPH8TzCw693uajeWLNT4xp3QLxHdQscz68u2nRxI0V0fMt
         LRK46DgU93oRw+NvKxbtfZPrVhHXoavbEYpKGXXo2Eq1AV4TXn08U8m1XWB4jCVDPHGv
         Hrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787515185; x=1788119985;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QasYc6RCSMa5sPreNe5srZRIz9d6Ol1y/kYNoBuD2o=;
        b=K5hLkWaVa7RgyoipO2mUUMZmom4DeZ5pEXd6xhbjCWzzSx3i4r89sIR2YZT19iIv9M
         3cDgj7i64adCxxVLXmB+23r07lBuzOsU0USG1jYoU0BbHwbBtuTtBeqCRMlwdpjfU99z
         usPYsR74GvwlGySfFY9lRyONuorsSO180u9+VJCc5Dzp/quCxVwq28C0Avk4MYXWd2Kh
         7jOx6rGhNwYDyqk0YKVIYBGIykEycWkjuJzGVHs2GU/s6VwEE5uhNP8tKLmCvvENMaYU
         in2BL7NUCyxeHB5Otp9T0tFrP5PgcumXJGzhnaGZJhAbFPMEjSSgQtaT9I5xLApIArP6
         nO4A==
X-Gm-Message-State: AFuF++nz/1xkkK1aNWNJPbvzRzm5vThA06ehxXb2SC1nn2x6abyjlH1B
	hvW0gLKawWiiZompKTJwWvJzRb+GRjJ1S2ZUdDZvxR0oKwUdtkhU+Y4W
X-Gm-Gg: AR+sD13P8oNQgAkefFnlSmAPv+bsAlQ6yB+W2qLKf8fAP/N1em705+Rt/0POHRLsYU6
	VT248pkkKBylswo/69SDAkTCbd1BMo88r+crzWFaU3n2M+bcI9I9KaTKuR6ZjVxyVjViqu56qdh
	2kHOngBm+jHSW+I/wZeL10q1Pdr0M05puJwcmI4BG4Q60RladWeRVcDcYTt+AQtNP401aHz86d9
	FUwSpLajp7k6nPVOypcMWr7atTUjQ0m2w2F2WTljuHB67ei9UN+crHi+n+naF93QI9HSkvbDjUH
	s8fvPo8253FCAd3c8VTr08s5DYGEJTqE1PkduPpxpu3F1HuvPBFuxLosZ9L1JPB123YwDPRUOuZ
	8CDlC++hhmc8lVshfXuKiCFDM2FDums+isvE6M1GVG513Zz5WJffQkzuguc//VvctT2zF0Jthi9
	x/Qjjjrf/9djlJ91/gmp+3GUbLjI5VQjieqXu0L557hjJRFLKu02e8XZnuLCHrXopBH2/psaPwF
	LPwyCyXDI9JQ48u4YiMLJmyWymH2Vo53CTpTM0fKJAmGywZh1xlZY0n+zNSkdVkJ96eEYWhn1MO
	7ceCjYfQ202HLnexJAhO0C8K3/lmxcSHmQmXCA==
X-Received: by 2002:a17:906:7316:b0:c19:45e3:2f57 with SMTP id a640c23a62f3a-c2491cbca79mr1481849266b.9.1787515185174;
        Sun, 23 Aug 2026 12:59:45 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm992377566b.46.2026.08.23.12.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 12:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Aug 2026 21:59:44 +0200
Message-Id: <DKWL8ZCP4JFW.1YNYR2ZU4BCQZ@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Reject oversized stream read
 buffers
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0
References: <20260823193202.2389715-1-memxor@gmail.com>
 <20260823193202.2389715-2-memxor@gmail.com>
 <20260823193918.347B51F000E9@smtp.kernel.org>
In-Reply-To: <20260823193918.347B51F000E9@smtp.kernel.org>

On Sun Aug 23, 2026 at 9:39 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] bpf_stream_read() permanently loses successfully consumed stream=
 data and incorrectly returns -EFAULT instead of a short read length on par=
tial copy_to_user() failures.
> --
>
> --- Patch [1]: [PATCH bpf-next v1 1/2] bpf: Reject oversized stream read =
buffers ---
> commit ec0075a06e269ba85371f18607bd524dfc2cb4f7
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Reject oversized stream read buffers
>
> This patch updates bpf_prog_stream_read() to accept a u32 length and
> explicitly rejects values larger than INT_MAX. This prevents oversized
> lengths from becoming negative when passed to the internal signed stream
> reader.
>
>> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
>> index be9ce98e94692..c8d1d0b03f180 100644
>> --- a/kernel/bpf/stream.c
>> +++ b/kernel/bpf/stream.c
>> @@ -196,13 +196,15 @@ static int bpf_stream_read(struct bpf_stream *stre=
am, void __user *buf, int len)
>>  	return ret ? ret : len - rem_len;
>
> [Severity: High]
> This is a pre-existing issue, but does this error path permanently lose
> stream data on a partial read failure?
>
> Looking at the while loop in bpf_stream_read(), if a buffer spans multipl=
e
> elements and copy_to_user() succeeds for the first element, that element
> is permanently consumed and bpf_stream_free_elem() is called.
>
> If copy_to_user() then fails on a subsequent element, the loop breaks wit=
h
> ret =3D -EFAULT. Because of the ternary return statement here, the functi=
on
> unconditionally returns -EFAULT instead of the bytes already read.
>
> Could this return a short read (len - rem_len) when some data was already
> successfully copied to user space, so the caller knows those bytes were
> consumed and the stream data is not silently lost?
>

Already fixed.

> [ ... ]

