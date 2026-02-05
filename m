Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D683EBF32
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770261299; cv=pass; b=gqSyibcuZrFVZHkM2JJcpKWB7/UXqtbeYcytt7g4CwJM+TtD7BqAnV2cTBHngxsDHCNCbK5cg6EO1WPkvKgJR2BqerLeoWhBKHTLsIxOTbn8B8lBfN13l7/lczJxTHPY665eF7MHBVn7NRyWB/o1VXwHDr1OI7kacTzOrOfZOXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770261299; c=relaxed/simple;
	bh=DD7WYYOBPcc0CkJjGu4XxvtnYFRWYscsIEYtNe0F8js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuoIv8dZWQm2cTaGxL5b8bVb5/f1OEx90tsV+s/lHzh/pxjFTU5yv2UwZJjeTeWviwvs4XBH3nPlACUvdjfK6KO6+tbTTXjGIJs3qpPjYPK4l4uhIiN+G7qrCqkHLYHifHtGflzOQdIIjFvH6st1E/AGHTZYX/niwbMvxIPVDUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqoDxkaw; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqoDxkaw"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359a302794so352213f8f.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 19:14:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770261297; cv=none;
        d=google.com; s=arc-20240605;
        b=GRr0dcdHKG2s+Y70jKabIoWCgd6wTfQ7s8WWgLv8U4Bt1j+V4f3Mh6kRasWs33Z+72
         luwGU2owOHOD9p3V6hgBB05gXuc7bdnpFEplBkWmKwowZvgfS5Fp5Gb3c8PZHN0BkVaZ
         uQ/djJb3DRp55jGfMN9PsCp/hD04LyPBBmsA16Xz30NVcteSaeOdSph233lLCN2sJEik
         sJbpLPh+ydPmusJaXrxWxzzsnzvYBrtYqkugiFexVOjN3XX+0MgaaCLEvA1DjmpAisX7
         MDCVFNc7OyBhR5oaOj4onknOQBytBgY9TqXS2IOG5dgkOq20aGiRY9Gg6RD3+mOO/A0V
         /row==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DD7WYYOBPcc0CkJjGu4XxvtnYFRWYscsIEYtNe0F8js=;
        fh=ZWW4A/LhKh5aWFlPogdAjKuylMYTF4qZo8eTDkcyrqo=;
        b=bhILJm+dRTv5fI1mTRuquOKdYnldkkGrBUjNOnn2OjiEwQYe5iHTWfSDmvrzJVlI7F
         4us1x2qBY6BGCyppOnu9uIajXLOskymtBBeDX/heTZfwLirKL3s5/St66FE5/v3b+aVU
         t0jqnIm1BsMCDoxUsaOj7j4gs+RoCFJox5YK0hbbfFR4vYC+IwSsuh8gPeVq/nRljPXp
         tQhi8j2b5ylhLtdMO1H/7zcNZXKXG5yi1IoEVRh8qCaZ2l/fhNeHyS7xvie3LXe059sR
         g81X9Z5C33czEVSke/RSDC3DTc/fSNwGSJPcUbS2LTPvz9P8HUoegur+YPkpBnZNTi84
         m3iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770261297; x=1770866097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DD7WYYOBPcc0CkJjGu4XxvtnYFRWYscsIEYtNe0F8js=;
        b=eqoDxkawNpsbr2SeAT4eCQtRHkwMeS25SBOBLVk0eIHxmQBsm0ZbIEoYQHY4QwYevn
         HoJ4ppmLDodHhnNNWgDSMiWplaCLasUuHIN3Pt5Q+3Gqpk0kHILdbzOq6+Ejp8T/k5d/
         jPf0Pp2ZuIBbLg6svkBeo2tTrUNRHuAMgm35yjEjfM5PWA73c7tr/11n9q19GeZn7ImN
         CPJlJqSc5xZhpiaFDWK2T2PCdNwQoavnyXDYZpr0syPDXDVnZl7uwCG3HTKOaC1VoEgW
         FwmdG0MXBkvtxbvngt3sncTrV49Zl0o01Kt1MEMz1fHXFU5T/pgOvdRG5ZTDstiFMr7e
         e5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770261297; x=1770866097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DD7WYYOBPcc0CkJjGu4XxvtnYFRWYscsIEYtNe0F8js=;
        b=r0qtSVZ/Vt/ppHf+lujCqQu217dhlUwYNx5glzDezLI3ZYJc+B9sai87XWwzbj+iVX
         Pbt9exSh/WljE20XNwO3un3XBmuNDV/PBAXNHsuxde9/so8pNilacAmAmYeOULGYVADV
         HrKpRLOAemy0dj3I+jz0jV8ZlskiN20ClMopNunjijGfwPTjdigQ0xSaviqn0Li3/hXq
         92Fmpf/v29pDyKm9jnz8X+woZ/6BPtmI7c8Cowb3JtphZtsTirr3IOV5eQ+kr4LfYfI8
         D6AjIe5OpdNGHVfGeGXlCnf0gInEIyxDR2VIwvCFx8jc+Leb9T7M9LRGeie5LA1zFQ8d
         xkew==
X-Gm-Message-State: AOJu0YwV9TnG5s1mNWGbGUCvTGJS2E2++yWJqXtpxJqQaccCyqqT7ZsF
	L4ezvQrqcCmNfIHI9mWbc+wiARWNTwr15FQcmod34O+jOTvucrdb8kOF10HgB2e4uBPPKGaRckV
	Ocu0AjS3G+s3r1JzR4DY/I/2B2KvBoSo=
X-Gm-Gg: AZuq6aIrjcNalmOCvejd/QQciMXFWxgY7HLin+x2jy8bVo3nIlUaGhWYgcVUqV0BTZ0
	nLW6Wht+r/xlvvYvpohs8nF+00r+exau1IHOS0c+kCHNM7jcTduHRcN0HnP2iX8X6fcp7U+fuVZ
	M1FZcNsfdl9LtbSwqt6zN/ht3EKEWREe2lhCiGZYAuaQ+7KPvd9KzwLqY85AASi7ZKQpvD75tlV
	4yIRUop52JlmulzGIosaSuRhWLsFvHxaCv+f5+cHWCwDM8vw7pr7KNd7un+Qae2VLr3tXkKcYcW
	7NX3zC2v0IjVG5STZr3/bqMUUJbkWC8PK4sejGO8erZ+XtxahgwaVLkvHckzp+lRgTRluZ8JRfA
	RVytUJ50VkPVTc5Q4pExqgizf
X-Received: by 2002:a5d:5d05:0:b0:435:a194:734 with SMTP id
 ffacd0b85a97d-43617e3556bmr8006208f8f.5.1770261296911; Wed, 04 Feb 2026
 19:14:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204111503.77871-1-ziye@zju.edu.cn>
In-Reply-To: <20260204111503.77871-1-ziye@zju.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Feb 2026 19:14:46 -0800
X-Gm-Features: AZwV_QhLl-6n1duR_lIj23U0Ew0YBeIpDmfgSoRrS5Ciq0zFGI0FtKb17MRYeew
Message-ID: <CAADnVQLdY8hwkQVkWiPQvLZNMV3H5SmXhQWm6K-3r3beLbC-oQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Add bitwise tracking for BPF_END
To: Tianci Cao <ziye@zju.edu.cn>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Yazhou Tang <tangyazhou518@outlook.com>, Shenghao Yuan <shenghaoyuan0928@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 3:15=E2=80=AFAM Tianci Cao <ziye@zju.edu.cn> wrote:
>
> Add bitwise tracking (tnum analysis) for BPF_END (`bswap(16|32|64)`,
> `be(16|32|64)`, `le(16|32|64)`) operations. Please see commit log of
> 1/2 for more details.
>
> ---
>
> Change log:
>
> v3:
> - Resend to fix a version control error in v2.
> - The rest of the changes are identical to v2.

Applied. Thanks
