Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2370C3793BB
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014908; cv=pass; b=DZFLOHpYEzPbsaSYu+1/FFtZpp4gzPXEEmhTUcHtSIAMu7VNPsQOS1cKCmp04zgS2k7CX1gzORwZ2DE2Be9mEdr2uZKYEbLwRKvD2ymLS+6RyP0ZXjFiDL4D5LLn8BCIZJVRt6ttdCTyw4l6iHsD+XPKlZ2BYSb6gP+lR2RUBc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014908; c=relaxed/simple;
	bh=SLOCQgI2ErXSdd85hQa3lFR65w2KRZdCPX1tctcCccA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZP/0ygBYhTzNVgltMGDQl0j+xG4sc5zQwJw7l+ojsHtopn4Io2STInJmne581BpCnPV5t+zhaqDlPI0Hb8MeNcCiA0DytTZTwPJ8Nt8uoyoDP+oyufPsWqky8+sJBPOVyM0C8vQEOI/EKODHQUmx/HO7J4DtCtsyAb05jTYFqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmbMiNob; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmbMiNob"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbc305552so42971f8f.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:01:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769014905; cv=none;
        d=google.com; s=arc-20240605;
        b=dqUUocMMrbCMi0ZqIQTw9olxDHac0N44nYXqkVFik2ooXMvW/0cf8kHw0+2at7EdHl
         ptKgAHTY7sFkYtozGbhPUNDRl6is/qAp4aEbd3QIfEY1+Oyj+HqvAGzjA0AhOFJ8DeAS
         hrlSwi3LhIUhFK6PG6bFRMPB00BcemOjpBp5H5SUGrxRz9xPmTHRKcf5fmQl6DwHpwNB
         eq7U1G4PN9uGSCd3GWY5yZGcMea00txQi/EGN0uDCtCetnwEvIdFs5mZMqbVA717/yo2
         Y6+3neRdWT3PDrPFvz0zQ1Xwn27VT4Ni/6q681NyZ91RbQqr96gT66o6JAOSfqwHV/Xj
         JGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kw3x/IwmBAZeFPJZDjWdx/Cquty/Ye+Fg3dbgiOuCng=;
        fh=DdM8eZjwPRXJQ6pP4GX8nGZlZ5GOguGWUDRDSnwWJuQ=;
        b=dZnBA1iSMM1lZia7/juWuFbtghb9sLPgAX9PzhAPnJv3sZTu1Wn2HJL1+pcgy4fWIo
         dXJWyy7oT1g64HxhdLHWcY0kctDZQAbdF1HV9+gLoE/EV5VK4TdziHWyvjHDruYGfnme
         MnA4aYzOAYD2NO+FacxefMjr5CJj+57INTX0yyg+ZIv8a+RKJcNxewuBa2BllykqMyhj
         hIxmbva4vA/6WHbpOlyuqoQnh7YQ21Ae4I2sdpp99OvBw9UB78OzADd68XGCqHcJD0Ok
         xIUAasnOE7sWM5LZEUgR6q4VnHO7awIkeFXQZvF3cNdCXgJD6FpniJKyQ4LWkz+zSLqZ
         7t2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769014905; x=1769619705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw3x/IwmBAZeFPJZDjWdx/Cquty/Ye+Fg3dbgiOuCng=;
        b=WmbMiNobuZmY+7pwondkzhvyQAxVbdBm6w4E/COavfAaCFOk9MjfKbkIwFiG9SmDcp
         jw4MEgkHR17hEnktNiaDSqCS5ycdJT/wdk5ocK+qQSISpY2ZOgEV61R++JE5QZujCjqs
         /PIxGQMPcK/Zflnp040FtztrFB2cAC6CQNOWPipqPv/8i70iKC0unHTnUM4rK49tLjEY
         lnz/oE2QKwhD/xEHOZp/19W1EKPD8Kyw0Aeu4MNnXmTd4kn1eSSWyk6oHi8xCw/6U5+A
         iNJVHVLOrNmfcEnrfq0eoaLsuGcy2gVX1LHEy7kFmVW0LlQz7cUZJKejdfaZ2HeDFZkT
         Zlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014905; x=1769619705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kw3x/IwmBAZeFPJZDjWdx/Cquty/Ye+Fg3dbgiOuCng=;
        b=hDQcD3vv9eogVDStdjUWis0rJ4Lof4Pyw0+6wIqK1OGE0/ltbQhQQqe9k+V9uj0Tol
         +/RTcfbobPWJAyI973nX98t/gCtEIYlArqAGCIYQSplnbbFxRVIgcz9zz9zbvaz+hobV
         aMmS6G3wRhmG2GQW0F24Jm09IkQkZFry7GwUjjNV0o0evglBdRyaf7Dwx92iEFcJ8fqZ
         n9ZKZNnvHtkM3oUIHYR4om9mC3E7ItWJx8JgWESxcNAd5jYmsMoBo+WvpC5SOyIahFzR
         TEMdaUU5SaaXp/tnSeEelXFpZc0h4kSgzqNjZIuoLjt5juKrsjzG5lAfmEfHcX4AgoIm
         FCQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHMOLNdPmPOl0EhB0wWIE6q5fhsrXrfOG84RO1lF/fCZrcDuyY+/TTTLEpnUqDwO0C66c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1kW702rb+Eh5FDZhBcn1fifOXyBxMA23VX5ecC3q071ohnVpW
	PICEx1wRQK+dLRXOE9L9prDtn/+PZY669TB+bQ43onuNROhk7Br5vEH/gy7ucl4TWXI2mbUl6OT
	BJt9fLC9m8a2QpaBVQOtRsxgWgCGf9BY=
X-Gm-Gg: AZuq6aLKlvQCvnalXNCQG7gUHUJrWE47F/dJUW2PDwRcW9RnW9eA/TwhWfRIe3H7+PR
	Efky5yMecH2hUeuyBke767ybfVOtXgHgN5iaYWFXNg/LReW1joEVukSM+q93iWZdSfBYWUZODlf
	O8f60CPf/47y4RSZQMKFye4+tVjIh5OC5tJXljm35qQJfhU94Jg/tjVEle8cgObwIwZPPiAYoFb
	RhySe6dmjrZixcEsvSc+jDFEe/lrqL0jgoTSI3rfAUKn2R9aORMOyBnmjcwMTSgGyHdbYHXuRK0
	zAEiMI1YKfeDIRGZh38litCD3wGrJ3XugwCNQ/7peIAwBWsgHmXgdZXYiETNswHvx7OTJQ==
X-Received: by 2002:a05:6000:2409:b0:435:8e14:9877 with SMTP id
 ffacd0b85a97d-4358e1498b9mr10547200f8f.60.1769014905117; Wed, 21 Jan 2026
 09:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-3-e8b88d6430d8@cloudflare.com>
 <8eb725d8d0878a7a1b582fdfacf05d20a2542304.camel@gmail.com> <87h5sfthoj.fsf@cloudflare.com>
In-Reply-To: <87h5sfthoj.fsf@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Jan 2026 09:01:33 -0800
X-Gm-Features: AZwV_QhJ1NjX1m-MohDCdnXL25Iz6eQYI8PRkmCyiBK89IAx0ByAzxBlEJS-IeY
Message-ID: <CAADnVQJLZX1UsdqWjCB57PxJQQXnXN5ZMY5M+shnxP6t=wT8yQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Remove kfunc support in prologue and epilogue
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, Network Development <netdev@vger.kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 1:54=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Mon, Jan 19, 2026 at 02:55 PM -08, Eduard Zingerman wrote:
> > I think that patches #3 and #4 have to be swapped, otherwise there is
> > a selftest failure when only patches #1-3 are applied:
> >
> >   #281/17  pro_epilogue/syscall_pro_epilogue:FAIL
> >
> > If we want to keep selftests passing for arbitrary bisects.
>
> I don't have an opinion. I assumed it'd get applied as a batch without
> fast forward, so bisect would be going over merge commits.

I think 'bisect over merge commits' is rarely the case.
It's better to reorder as Eduard suggested just to be safe.
