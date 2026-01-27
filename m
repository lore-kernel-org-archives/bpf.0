Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581222B5AD
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535140; cv=pass; b=tBMSwG1iosrN7bTmXUmAAKy9a3z32u8+anahlKrtm98zRbQst9MfoiVp0PWNXrni+mBHkRSzryPdQsdmhee1WcjJKCR9ULUllWBMWr8U619JTEOpoU650SoF+yUxNpYgrHInPEOGnfYCVzEkGBHBJ9YA2E6poItCHtetHARrYqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535140; c=relaxed/simple;
	bh=agbBtWV6+bRJAhbybtzVUREZStWle+84gx4fgR0aQj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGBSe8oHcgGHzJKRNs4Wx9FNPjl6yLOCr1xvfbcUlahNoNQ+3WzkrIsPwCdZ7IWVwEG0GJFPoOJm2853lVOP2g6dGHS+bT462jOKTVPpEdR2+WhG7gAoRn0/YLEE1I5isRXyNrE0ZgbfUQs5/5U343qQh+RBiuaF9lEfLybSG7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKKUZ2xc; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKKUZ2xc"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4359228b7c6so3930713f8f.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 09:32:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769535138; cv=none;
        d=google.com; s=arc-20240605;
        b=Nr1kC3tanSExNelNL9ML1VDL9Wcagv5c5tW3/iwBeu0YWpVVKpprztv2mv6ooPCk6L
         Duuzzo8dUXjTlZkmmzgN7Tzkeitxq88u1QaudadZVM4+4E3WwNWmIYo8ugIY5RcGGpVA
         v//tDpmNfswIaTSWkUj++HqRTSai8WpTP5PksasXHSbgnfacrXoANZD7BoaboPNT31jA
         LjrS8KwOlbmvqLtJZYL90vCU4lZRI5ctvpoG4GBtob9jhuQDSTOVFVoEcgJlTUjGU7BF
         zn6v5u3snUvdXgGi05iZJ36hwqTFbwSBaek6Yk/knGGYIKucJ5lH8TqtOFnZoi8AtMnD
         1Vhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7AzXtpBQRjUoOHERZB34kGez9UJ4aKAkoQg2fodp448=;
        fh=BhI1rXN/yDN8nfDhliBWprx0dGyU7hfy1pfGv8V6Zu4=;
        b=Q43kmX3Cm3FcVgsBMec8Vv72lxdEEX0306wJr8cnNTjSJ0dKZ1Rf4/i0/Or1/r8UTQ
         KapUDA55+aGNo6MAR6UbLYB1u6T+YXpNpJMfOYPoweBePM0ENr+xcxeHzEvK213eyT0N
         HuO395BRCfv8Y3i+Avel3eHURM/chQF8uZ+oDI9m38z+ASX/Gfs3tAgzn8VhpWi4007U
         7074/N5g+FRhHjItQ3enzZl+RqxYZfgLxbURJxnJwv7tn8Y1XE2JQprp8DEcmM5UjmHY
         ZC61idoetc6qoCy9IcLeLIW4/M/V9lBD9V5lQWDYn+c1NvJlC7JLsTF3iFLzWMW/fqFY
         Rs6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769535138; x=1770139938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AzXtpBQRjUoOHERZB34kGez9UJ4aKAkoQg2fodp448=;
        b=VKKUZ2xckyvp20I5Fg4MYIfBo4p7rnweJ4t1MscNBGl/KAP9y+0ZJSsSnNMu6CtfNb
         AAqHiDYDZXQnjBY+gCkRojMVfRJkmbxxQ6/7NfqIIxuewjEU9OUhJB9jf+PVdg+jIeyb
         es7AaFswcgptq3JSccVGZvzki6ubXT6GsvuclYsp2CQ757VeN8QkUfUdOM7iouEeWuzR
         WSsIZeQUqEElsO7tvsOW5Pp9QgIci0dutCPJGlh/zeAHBs8KsWhEn1b5hGuEq3EAQIsX
         hQ4FH7X5uCVMgVny9/BxW/t+4f/ElgfCSMNFZnnKol2HpTK7yFpfNMqTBuAU6QEBacsT
         u68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769535138; x=1770139938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7AzXtpBQRjUoOHERZB34kGez9UJ4aKAkoQg2fodp448=;
        b=b3KNw+oQR5c+6ndUFQ9Tr3XYjbGgh6lp/zraJ2dRAhJpORVzBEvmsXk3lwWTeZeH/Y
         3vpowx7pa1lCCT0APw1rZkBVZuJeFWRs0YWPPclV9x9B9WMF1YfvwL17tF0GxZFXLH1j
         C3pTw0c1YRbVtbS9LQXMhkN49gCONcPRHg1dnWpFVrbg1BLdywe00udWjK7awh0jibQK
         m+CmOiQcOW1sb479Fd+0Rl3IGnJ2Wko8WXbSosZBMrlIb6nYtlmpg/ODcEy9yjRI6eKF
         hByUEFJF893qVgmeUT31vV2WspDfHDgf5ZFldXHMLiYTPhiTSfATEb1tDF4ve1gxwG7P
         Iw6g==
X-Forwarded-Encrypted: i=1; AJvYcCXXGBRYZbbIS2zYhHLLP5pox2V3aYs+UgoepunTjm+2ULXPnWjuSVv1ZstsLMy35DbNqAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJqfiVBMUKqYoXmmZbB6CdkyWeMNULkDm0nMlOUodh2MxzQr6
	ix2GbiuUvlYLMz2IUtJMURTNXYEBnXazpXPvoaIuJpNMVBDnv8F5L7bm25XYkpLF47xPO8r9Ksp
	lslXWzHV+VNCYVU+/2ppQWw6ae9EQLX/Fqbqr
X-Gm-Gg: AZuq6aKQFk8qksvu+Cmh0aN6fNpI8slI96+xel4Hxb98pfj40dKrNpz2vUCvHxPwhb6
	wfggl5f+r9IwX46pmL4BXuIHb7h39ZbyqjYbjeZV38H95cFAhZ2Po7d7jD6CIsHOebFFWw0iJZN
	iZeybq/6myQEKmy+XSTYysLQF6aOlt0dTqnucPA6dyH9Ohz6lgYGU2mUCDOpbuQ2qgbc/7gvw5H
	5eNU6Bs1+fvOaxHkohLBrlC7QZdTD/WGG6zea8lWkFUQY0zYIgX5c2QeICq7kYzjwQBvwAt2/1e
	Gw0h7dmaOOp7SpZkX4tsohBM3L90JGQo2OddENj3k0GZ2j7f1lGMbuuthPkL9l1ZlvuznUfx70k
	tYcTslnn4wRt/OKJL+qQO3LB7
X-Received: by 2002:a5d:5d83:0:b0:431:b6e:8be3 with SMTP id
 ffacd0b85a97d-435dd0b69fdmr4117395f8f.38.1769535137438; Tue, 27 Jan 2026
 09:32:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769470552.git.asml.silence@gmail.com> <b766b428ec90862d69c9ab843dc89b6d0a017628.1769470552.git.asml.silence@gmail.com>
In-Reply-To: <b766b428ec90862d69c9ab843dc89b6d0a017628.1769470552.git.asml.silence@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Jan 2026 09:32:06 -0800
X-Gm-Features: AZwV_QiJN977OpVwvJKpxGdEFWEBwGACFC5_ZTxDEFVjE4sOmNBLvONiR5cDr3E
Message-ID: <CAADnVQJcoyJ1hmU_oUcjj=8ewPAPTOZ8eccTutSJWHFy2Xza=w@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] selftests/io_uring: add a bpf io_uring selftest
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring <io-uring@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 2:15=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> index 000000000000..7a170cb2f388
> --- /dev/null
> +++ b/tools/testing/selftests/io_uring/types.bpf.h
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +#include <linux/types.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct io_ring_ctx {
> +};
> +
> +struct io_uring_sqe {
> +       __u8    opcode;         /* type of operation for this sqe */
> +       __u8    flags;          /* IOSQE_ flags */
> +       __u16   ioprio;         /* ioprio for the request */
> +       __s32   fd;             /* file descriptor to do IO on */

1.
No need to copy paste. Just include vmlinux.h. It's there.

2.
drop KF_TRUSTED_ARGS from kfunc. It's a default now and this flag
was removed.

3.
add a runtime logic to check that the return value is either IOU_LOOP_CONTI=
NUE
or IOU_LOOP_STOP or instruct the verifier do it statically.
Otherwise it will be less convenient to extend to other commands,
since the way I read it IOU_LOOP_CONTINUE =3D=3D 0 aliases to any value > 1=
.
