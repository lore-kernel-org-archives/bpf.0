Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D407178372
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776736794; cv=pass; b=juEQ7U4nlMPm2KuYzdcVXu7xySz5MtJQhdIv+DoV0RJX8pzTHkt+de+PB/zDCehRb6a34slGmXKqEdMaApJwRhEJPpHgIff2SixXfSUHg1KSVCx0qoG7ESodCnMvse5mtSIOIO7fysSQmrrtFFaVfmZ3UBRx8IRvZ9ODbrWdyFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776736794; c=relaxed/simple;
	bh=cv+T2FkN1yrKWtQ5yODmnm5fxujq6Qg0cAdSgN/hiIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lh4yCRwuPso1RFuitd16U822aC8eXMdPfkGzs3JO2bCCgzXBUObE8bq9ooRoJRC26C+ew+OlmfjYcyCLqr2lp8OQ82we39mRL3fY2Tpy28zDerYfE48/EkThnCSgL0OIMm6RVsCACSYa6t8PffQCHvmSYP7jscK2JNhFgWyYkGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drcQxD/H; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drcQxD/H"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d03db7f87so2402316f8f.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 18:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776736792; cv=none;
        d=google.com; s=arc-20240605;
        b=a3VQFLZkc94aRb02YhZhNIHMOrhv81zuHZLUU9mneTd16xO5IBHys8Eu7ir1m++lQZ
         Ddneuj39HXsRbEkBbL7ctX2ehVC45MQ9rAZ5PEI55ElrBLltvtXgrDjhOFyQY0NNftr3
         J5SrRsywqU3jIE95z4YK9u0942Ln5//BcIGea/zLjasmAB/mo7f9saDfZ6NQOscGkAd1
         rmYg/8zHNePUJdqvW299JE85QoWGm3K1JVtuhQ4ViB/TXrAqO4zhotzaZn+P5hfQzQxu
         V7q4GG1m78O2KRLtsOoxhuUqgxs2hj8jwGNsFmkypEu6G6xqHWVaTcWJuu074ICGxZfX
         eFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cv+T2FkN1yrKWtQ5yODmnm5fxujq6Qg0cAdSgN/hiIg=;
        fh=x2Ui9MxT53DwAlXafjeP28xzuOSUN6V5CZ3YhgOSREY=;
        b=PC1N4wn8CTQAWsBBuB6xLMwoj8ZVk9MJUa7R4mohVA+WTu5EH9gpFMBbWhB/RThQxL
         tVnPdG99y0QJb1mz+PLhp+EZY5ArsrGQtmlVVFF6oTVN6FyngbMd6tTyHoNBaX8pjMFY
         FqJi17zyZ6CBRhhgF8CgSUQGXHiFez82mHICNiGpnDMcKjEzlb9sKAHvh6beMe1h//ie
         6fChzZ/WwEVn3R+XEGF75yU8R76aUTqBFeQs0m/RbDGWEQVqui6ZVm6FtRf5NpqitOFQ
         rkz3TZpB2Hdn92N7WjIAIgd92r8x35O/K6roV3jTFSloR2GYikDNFaHn8QgbYV1DVsBv
         b81g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776736792; x=1777341592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv+T2FkN1yrKWtQ5yODmnm5fxujq6Qg0cAdSgN/hiIg=;
        b=drcQxD/Hf1+/QNRLT5LlLP9PlGwFpIow1OSriLwod5+OJjnD6gTTg+MjxVlIpzDpp9
         bvw4j8X/tTOdrTwqrjoil7UH07yCepLUEESBeCIC2Z1jLhNzxFizg/xHbsIvNIM9Bqx3
         T6KelxhDSakMoUIBdJEQFidMmvwuEWqNoPOGMUb73Po6ocJtYkSNjWPaHiVobu88MP14
         9Ze89/oJD7DQr+3AOD2D6YuziGu+GMyD4qGqfQGj2LSewOCH5qXiVlty4M3O7s1ONhBo
         sVzYFQyRl2y14fk4QCyjDrLGonG0GvFXSeRYKLpvKesEw3DmS3Y2aKDDBLQ+DphQSD97
         2m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776736792; x=1777341592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cv+T2FkN1yrKWtQ5yODmnm5fxujq6Qg0cAdSgN/hiIg=;
        b=Aye7CKF+mGmeXgL8NG8JhxWWYTt/xMtX2BC3i0wfkMbkL6lwxRsPHobQhkXT7XCelG
         eP07aYwqL/IOh9zX1WY78ER/xh6N8CW9HjfHiwMv0qnCLpESLM3kVuVWZDWXEVybr8up
         9fQW9JVgB1xmBLstaAvJ87WYCqud2MquKOBQ8jplBDMQO7DsCsfodWtClC8cdNiRXT/o
         R+ye0CHbtgySQk4fsjILDG7ihDDYjH3JTrygXJiNJK1WApnFNHLUMCArv5CF7sOvl6D2
         awl7Orqpfca6et79AS1x6whXqjqm5j773MTvRQL3FKrHXzgOo0Cn0PcffnJM8V+oAmuD
         TCHg==
X-Forwarded-Encrypted: i=1; AFNElJ93y04e+BO6buawxfuZ6WOkj22Jk24Un06zxzzt1qvYzPeQemdbq8IgVci61/LQt3mUvGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQSnsH4MMRm3wmCijxg1IHWz+T0Ujh9SusRFeyzVCjsOSk/y5
	2gBS1sFPt/FowVPJk8AoPeOlbsIezaRQUvMmjubj8F+QRIL5PUztPDMEV9o6UN9JkvnN3T6mzLG
	1kUK6hgg6M0fIsMhoFerHHwVuBKELbpQ=
X-Gm-Gg: AeBDievFK3SQtuZrQZ3A04ft8YKhVO0hHlfm8bQ3FziFbP0iPV+/LJy5ZdtDP7JDnhE
	Di/x+gfJWxpv9gF5QkNZo89QPMRJ+O8ofalgoi4eaeZqtm1GhxE7G6QOEazBAwktbN0wRHZ1+V4
	6ZuXROCrqPAiDNSAgw9ezbTVNLUer+cSYrna7uPQ3lG8PftYndwUq2aFOiw04yxB0Rte7OFvPZJ
	kunzHYoxpkOVzGyKVs+wKr7nPEPndTmxq7kBFQb9LiYOxYhj7ua/6/YeiM4kU85k/RU3kCtMM0f
	xrrrBcFBP5MSgLIbxKOKt6J5vmffEvgkfvYOEcF8CXzgQD1bAXpyEGF6KSA0ZPKiy3Tarb6pa0z
	l+BFxMPRzP2mlEdIdMw3m0F1Pz5/zIiqNzJK1
X-Received: by 2002:a05:6000:2005:b0:43d:77a8:3ba7 with SMTP id
 ffacd0b85a97d-43fe3e12484mr23821569f8f.44.1776736791586; Mon, 20 Apr 2026
 18:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414132421.63409-3-leon.hwang@linux.dev> <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>
 <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev> <yujp3deu4uko2xkr4dghofpvhrni6szmd7wlozehtzndvhasrl@f2xjf4egi5fd>
 <3556a456-70d3-45e7-affa-355107bac30e@linux.dev> <d0059a19-ab24-4e9c-ac54-dafc932317e9@linux.dev>
 <CAADnVQJ0o38xXn6E5ub7kWyoZPiaevr9mwDNxv0GbxyguVTKUg@mail.gmail.com>
 <20260420052459.85772-1-leon.hwang@linux.dev> <DHY2JXM90466.13PVYC6ITVFKS@gmail.com>
 <20260421014255.210566-1-leon.hwang@linux.dev>
In-Reply-To: <20260421014255.210566-1-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Apr 2026 18:59:39 -0700
X-Gm-Features: AQROBzCNUTp3GyoeWAUuPaaZeq-1PT4Nvov3QrTZ_3tSHDmI20zAJYfyATnsAlA
Message-ID: <CAADnVQKEkMjmARsWMvs6SP76nEdCzBYSffSFSNE-Do=MaXMv3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 6:43=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On Mon, 20 Apr 2026 07:58:06 -0700, "Alexei Starovoitov" <alexei.starovoi=
tov@gmail.com> wrote:
> > On Sun Apr 19, 2026 at 10:24 PM PDT, Leon Hwang wrote:
> >>
> >> int xdp_prog(struct xdp_md * ctx):
> >> ; cnt++;
> >> 0: (18) r6 =3D map[id:28][0]+0
> >> 2: (bf) r6 =3D &(void __percpu *)(r6)
> >
> > well. that insn was inserted by the verifier and it shows up in xlated.
> > That was expected.
> > The point about 'bogus xlated' was about offset translation.
> > map_direct_value_meta() should recover proper insns[i + 1].imm =3D off;
> > In your example it's zero, so not an interesting test.
> >
>
> The original insns[i + 1] wasn't broken. See the key change of this
> patch.

You're missing the point insns[i + 1].imm =3D off is how
off returned from map_direct_value_meta() is used in updating _this_
ldimm64 insn.
