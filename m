Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F91A3166
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184383; cv=pass; b=BOGQiKwMEDJFRL4frt596i5ffkryuBl2zDRfyLhRgz2VSKG7oMeEo18staj+qrv2czn/pS8ft/yH3WmyXbRp87TeLodKLIKoY5Sm9rH30JKbAbkvms3+Xwp2P+e7FYbLUuU9t/LXu3vurT8XhR/ASwvPAtvzStvXhtAnKvGEvqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184383; c=relaxed/simple;
	bh=5xQYU1+LGCd6MVAvE6Mlt3Jb4+nGYPn6wMYwCdhezA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBW7qNUod3NfJA7fbPXHjSRExFkR7dmAYyawt7txjcEsGF9VF3dlOdJAojZD3QqmJ1UMCOKzno19CeOQB/3mABqd/EWKBHzAhr1DGS7/fvu18ITO1h1RVaK7VvUtXRK9YXey785MIkRecZ4LoRqih69nZ65y2O6Z17c1HB3zJ4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncCSr85V; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncCSr85V"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfb723793so971755f8f.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775184381; cv=none;
        d=google.com; s=arc-20240605;
        b=PFA1GWBX05o3gRhvYIk8I1qYRyKX2AoJY3jNg6fH91BQ4OAmduP076WscocqylRROj
         O+dWjdeQlDLqArxSChV8scrJ4ND6/qEyTMd0n11Y9HB4ZeHZeBB8pcsaNI4whqCQDYKj
         DUvCKqULqZT0yPxsHK5flymmuw6MNdtEoC8GUXBHT1CA0mgMRF2q826P971ExwN3C9Ov
         Y4BBJmiHxUdN2jz0w2z46JUvSZzHrnwo23+3JXqrnPfAFbbUzH7N9cekrAqfQEg/Ktum
         rKphn2yhP3YGNJj2iywzLGTU4EBJ8kSj0UaD4LgsnD65gbqZifMJ9pq/ednWgpCM1xOI
         znOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5xQYU1+LGCd6MVAvE6Mlt3Jb4+nGYPn6wMYwCdhezA4=;
        fh=h3m6LvtNf+eYg6E2ElJn5jTYmHoyPlDy/zzCvAojYZs=;
        b=JrsJ7Zt9nBxSJrUG6ntoV1riN+S2kc5rN9D/9vV6uRXS3T7fXQmt7ualI5xcj7anQZ
         oBve08iKflAVxbO5hUCNtCo4JvPfoXfLQSQWlD8nAwcPFZSxDBxMI9iYfTvmtiJriTnd
         xHemm9zwhWZcmeqkzZeupPsswuGI/NSMEmfGkXNhrMRrFfUCYcaBVmNFQHqSY9Lj1UEF
         funyKf2BH6fNLOsYA+qagRkre9lHawPA11b6uCrffKUADFCkWY6qUexLhS1jMzwP5m4Q
         jd8kx5zDUVyRz0Db8celf6Jqkqw9sxH6Xl3RXfpM1VQ8dItGfuhBFn1U0FY4rNfEUX7Z
         Y4tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775184381; x=1775789181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xQYU1+LGCd6MVAvE6Mlt3Jb4+nGYPn6wMYwCdhezA4=;
        b=ncCSr85VTxhzMv9XC8yYgKK47nEbsD1MFq7UCUNCpF3XLnIa5N33lqgcxBdtK6/Nls
         ER0hRh3wbJp41mtuBETir6tpNt34BdDKhmXUN3mD0VNRsUyk/2fKMlssI54gxqvqzdIj
         AOyJCxFGeZ6+rDgXC9Mqhzjs4pbPK92R65NzeJg3zqVZImZwobRjj489tn77GV2byGW2
         aUVaR3S7XKR3P9uZVN8ZAAAOL3CqG2KgJf7H/M6OtQEWYoswLOeY8lR/izSP6DQmZDiy
         05yY9EygzTD61TEtgczR174L1NnYeE/cjP5z87W/wFxRKCm9Bjidlr1oL39o85L/t10T
         KYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775184381; x=1775789181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5xQYU1+LGCd6MVAvE6Mlt3Jb4+nGYPn6wMYwCdhezA4=;
        b=Uf4XGDNOU0MmGWHVbrCjF/dFihyOygbxOYJY+5sMTmMF2/+ZE6GfAhxf/GmIcvNhLu
         zDHUe/s9kus9rcs3nqXzWEA39fJ1Ie9kd1/BmwvEISuonnblkhPUozPgbrkc4t5D6y6+
         PBmnuWfAtpt8Y+NFgGYAc2azJvlF+TAm0qixS9edch91lGd0dDb3s7AyldSDzUGja3O7
         Y9WIFDH0WgDID81QUkjoGqcdBtAgU4aLzmqwrcErB4c1RlG9RKjKv/RygyTuXxt7HPcr
         gZ1vxcWfDXvyC8BYgouMu0lz9eSNiExDiE5F5L4kdKWgKzAstkvifx5dvGKxn/BII7sR
         W5nA==
X-Forwarded-Encrypted: i=1; AJvYcCXiZ2tVl8YZC7Uv9HnH4m6X1OsG1stsAk89Jf5rQ396K626bxRFCULfz8hkoSSgK5dFqZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPXRj38wdcUZJ51tbYukb9iMl8rrQkk7ZH/IhHyWOAytyeJNAY
	hbm8r4gsNEkeA2VsmLtAzxX6rl0muN7+ssvQgPZKIgMTWXPXd/l00SbfJ+n7MBimdEhh+s/YCMe
	V6j87v42CMXnkW0ZqZw5Cqs6xLztvaOc=
X-Gm-Gg: AeBDiesG+rYjZB21nZrQ75RR0AxhbDPOlL0YY5kyg4lDkvg9EdWci8Bqcypzad9QQfM
	4cFnxXLiVRBAMrY7KUJyI69Yx5FhsmkfPjI65c9RVXWh2wOnm1yH4PR2C4XphnuuD6Cg/wBo3oS
	vNmwIGJWcdIPQ2FT5CLjtHCGMDKPI400WYW0A7J0ZYmX8Hypvj7p5XdQInvU7Pv44M8nu1eDOGj
	gQfuNA3pf/ZtrjXZng5VjLR51O1HETAqvHA+u9xiNnxnl68rYT8Iskvgi7wv5uEqTVs5qHQv+bn
	rC8wNtI6kZ5ENXYVQ7wspDWi1xgm3CBm2UqDnzl4VJHf6aHuEmZk0SIQukTIAd8FNDdu4OtYHRb
	pXt7D4VqEEX0adK6c+YUd4uoY1A==
X-Received: by 2002:a05:6000:2893:b0:43d:650:25e9 with SMTP id
 ffacd0b85a97d-43d292ae505mr2216651f8f.20.1775184380914; Thu, 02 Apr 2026
 19:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <420FEEDDC768A4BE+20260402074236.2187154-1-xulang@uniontech.com>
 <CAADnVQJawYEk53kS9-w5EXU0GnUYWWW7AF_n02bUs-GPJ+4Raw@mail.gmail.com>
 <ac6ejZrcnfQfaTZS@devbig1721.ftw5.facebook.com> <CAADnVQLSUU8Yo1Wmym4B05jam6qqUPEXUDJpBH+00kjqkrYigw@mail.gmail.com>
 <ac7Afa6_HDzyAxSt@devbig1721.ftw5.facebook.com> <CAADnVQJv5qNL+ssShZ043DVobO7ecfMuZxa-t-CGiGL-XyK=PA@mail.gmail.com>
 <ac8ODClxZ83KZf-V@devbig1721.ftw5.facebook.com> <CAADnVQJAYE9_KoNrWQhTz0UOX5dwmqKL-m6H0S_o2ZmdScVPfQ@mail.gmail.com>
 <ac8jGJvsEHhwuMqI@devbig1721.ftw5.facebook.com> <CAADnVQ+RHa6JF2sp3ZsUzN0zM59L=deR2+k4k9ugLo27nJWKGA@mail.gmail.com>
 <ac8n3IbBFd3MtGtI@devbig1721.ftw5.facebook.com>
In-Reply-To: <ac8n3IbBFd3MtGtI@devbig1721.ftw5.facebook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 19:46:08 -0700
X-Gm-Features: AQROBzBlYVbu6AI1jFN0JnBU8RWbRQFSX_EHwOSb2b6sI1bzKVCiTHTpW4lseuM
Message-ID: <CAADnVQL_hF1X2z1XspOqC1nEL6JVPU8G3G5zCDAY2zyzk3rV3w@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix OOB in pcpu_init_value
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: xulang <xulang@uniontech.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dongliang Mu <dzm91@hust.edu.cn>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, kernel@uniontech.com, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 7:41=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> > > hmm... would it break the existing bpf programs? For example, my earl=
ier
> > > data/data_end example will be rejected now because the verifier is
> > > expecting 8 bytes instead of 4 bytes from src.
> >
> > Yes, but that is a broken bpf prog that accesses out of bounds.
> > It just happens to "work" today.
>
> It is a bold move. Sure, if the percpu's map->value_size has
> the round_up(8), it should do.

I don't insist :) Just wanted to explore the options.
The current patch is fine.
