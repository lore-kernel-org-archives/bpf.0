Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9523806CD
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628946; cv=none; b=SFvdtKnrqkprNmBB0ZvyJ4O2z1V9JpiqcePE6V9ikMBkGsB8Fhw41AsF+U5K8pEgDZKf3SnCL3+fErV9fJZUrizcQajlfFr+V/tj+IVhM9BkrZ6IhP13+S/kp9bnQiA9/G03lJ+uUcyKbzQhK8ZFKjVB8wQXF9DEaDHAEL+ZsSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628946; c=relaxed/simple;
	bh=C/A8D3tbNyUg4sem/vfY4lMdGn+APIJ+yua/yZDMmI8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=KMVD1Q4SS/zzfredyvdGM8Z1JUR+9ScM319WAEQDGG+Kwhb+1xuYHotfy53s2qghpGgkLrZoMCCgaWi0JHl89WYLEfgw6dQxc7iDyp1dYl4oi87zZrBrspin4zvwDGwjZZNHcQtOaFd8uIweHRsHY7ztQHF/8EnVi5V26M8KqhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf8+lUkG; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf8+lUkG"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493c234fba7so427365e9.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 13:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783628943; x=1784233743; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C/A8D3tbNyUg4sem/vfY4lMdGn+APIJ+yua/yZDMmI8=;
        b=Sf8+lUkG5pVwAElFaTSF/ZdARukT6oyv1Ott2asee0fMsc8M/s1pleocYQ4FqdyDKc
         p0I6kEbVCdH2a1W4jatEeEWv7ZAxKut5PdCkf4MU5mGD9OjGBITI3fv9mtixFmjKEQ7E
         sg97iZ/h/aK4vyrIagTBAYkYOQTLonXhylOQDQy9aNcIIGVG8QgUefGQ7VoUz1TOukaS
         yb6UVZU/UqExMP8C23ixzMX5YxbQ+u63CPig8qVKJR5jggQ2eaAc9RtIPrx8nRn9oXfa
         iSmcf7spW88WZYOu27wMTt83UZrOA+T4pDDuYt/gewExblOdE+rvBY3jvYYnK4vlBvO5
         bxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783628943; x=1784233743;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/A8D3tbNyUg4sem/vfY4lMdGn+APIJ+yua/yZDMmI8=;
        b=ONzj58bRixtwzwlZpW7ES8KRgsaoIqmAqOOV/qsxIc7kGOiSFckUxoNnAUVoNNX7E3
         kPQAP/FGb1soZrgiVxi6X0GrTOIcM2IRuAj79xn6m1cUeE/gzSo/LHDCygBAj6xL8kr9
         a9p7Ep125t7tx9lVuFuTeCk1ANTUOEv+3jO+jB20EXnjGfVphB/Ew4fGjJVvCdPl6IAq
         wUvpBTWl6hUHvc3/NBB1WgzMdPftCjOFh2zV0R5b8QkdHBTlNGMEGoIPNlyc8evyk0jJ
         23lBKJHudTezXOgnkEYib88AIfbg66O4rpmEfLZQs5Ci/8LwhvGrBKcnXzipo/i29tv3
         1IHA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/nJRLS7M1xPaHcAPbu+uWas4V618+VLQ7XZdrR5lOJh8TxvdawN8cDlBMDtggPeXGSus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlVZeiPntomlICjM0RNT1NoI68mJ2Pt5a0AJSE/WxSEHKtwWxG
	/aiI3q5CorCjh3Nvdfg6+rq1p9AaaewDTJTouymC4y46+b8qn6lRMr/VT2lESvBE
X-Gm-Gg: AfdE7cmDsoALHAW1mt+P1CE/9+LHrTJ8/1eVLqnthUSrZT7yRdNKJVsmq4JhCp8XEPE
	YcIbqpd+0j8jNzxLg8zATB7MTipQh6d/Mh4K0lRvChucU+E7falBOnAYsUf/WEUJY5VJ0QquvNp
	4smVHgUreY6ND0tZJdSRfqpRb3RVxWTf95R3EMJFeeE3iokYreeDsiUNvuPiA7h2iYTYe2Ck5XL
	TMi1TUeETtrrcC6rASvh23LHXiwa9ddZB3nOtMg8a4bxaO4acouZqVcVXATas7Y3QXqx/UCOgBG
	Wi/Np/N5DM2rMuB4sP9o2QpuB0JHaWOR+9mKFf4eO9IEIYjmjLuq2hXbCygcnEeNI8xhty91QpN
	w1B3kRz6cNKOAevL254SXMH0wtPE5DVKAyDp9fAFP0ez+JMgtc3Kf9Am9WV/M8JB12VggMX65eX
	s00YJ6tfv/R2RWcT/t2DNns7PIoXrNmftpe3WslXzBJmWJunomof7CrSrBM3udurw1w9Llkub7f
	SraEevAfXwjLOLjmUyTROciEBvovbqZ/KkHZ382QoIqYP5w0/xPfg8=
X-Received: by 2002:a05:600c:8a1b:20b0:493:bc4a:fb55 with SMTP id 5b1f17b1804b1-493e68a4fe3mr67606855e9.38.1783628943412;
        Thu, 09 Jul 2026 13:29:03 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f2e56sm105405735e9.13.2026.07.09.13.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jul 2026 22:29:02 +0200
Message-Id: <DJUBOWHO347N.1EKHIDMTB7DSA@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, <sashiko-reviews@lists.linux.dev>
Cc: "Nicholas Dudar" <main.kalliope@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject rdonly/rdwr_buf_size kfunc
 arguments that exceed u32 max
X-Mailer: aerc 0.21.0
References: <20260709155837.1879230-1-main.kalliope@gmail.com>
 <20260709155837.1879230-2-main.kalliope@gmail.com>
 <20260709161557.794E01F000E9@smtp.kernel.org>
 <CAMB2axMeZbxWry=P5JTVo_xDw7TUeUKdK6X0_LKjvLWnLJyHMw@mail.gmail.com>
In-Reply-To: <CAMB2axMeZbxWry=P5JTVo_xDw7TUeUKdK6X0_LKjvLWnLJyHMw@mail.gmail.com>

On Thu Jul 9, 2026 at 10:01 PM CEST, Amery Hung wrote:
> On Thu, Jul 9, 2026 at 9:22=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 2 potential iss=
ue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] 32-bit integer overflow in `hid_bpf_get_data()` allows arbitrar=
y out-of-bounds kernel memory access.
>> - [High] Explicit 0-sized requests to kfuncs result in out-of-bounds rea=
d due to verifier BTF fallback.
>
> I also noticed the second preexisting issue when working on a patchset
> unifying helper and kfunc handling. The patchset will fix it.
>

Exciting! Are you also planning to unify global function calls (and extend =
the
type system so that we have parity with what helpers/kfuncs can take), or i=
s the
scope only helpers and kfuncs for now? Just curious, but I think it the
unification would be a good base to bring their argument types and the hand=
ling
at parity with helpers/kfuncs.
