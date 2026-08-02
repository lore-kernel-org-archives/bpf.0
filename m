Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7522ACFA
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785710357; cv=none; b=Bc9tRFSM5k4zEVjUzh4t66H1bEyZbVjs10/+3A/wWKTKq2KRQYhi6gfDQwAkP8Fsr+TJuYFafaCRmD0j/1S7CzVzKGH+qaemUr8IXh436K3N6CBtUY6ycic5gBgvhgNt8qIfJqCgEGLcPv8kUQK8VuycpybuVqCu1hro8bGtw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785710357; c=relaxed/simple;
	bh=8vaTgEIdvakKStMiKg7m2x+kVPrWx2Km017GA/F7zkQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fbUixjbPLaLnC1oWz2q/A+f1kjDAF2VD8EJoQT2lZHxv2jrlWaOBbqRZLzbdecM5C4J+Lqa84Zqb89BD5eeQRLXYt9WzXup1B9ljYteYHPhSL9QYReBe7cN9ZOUI9SJf+9qGhfVkFA0HJxvIoy54UW42DBiX5/ChyOcF49Klgdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzKKX9Hv; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzKKX9Hv"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4784b41f3aeso950506f8f.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785710354; x=1786315154; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N48AUYYm3tvPPvR8l4uGebJkWsX1ctx2eFfv0MaLibI=;
        b=jzKKX9HvB9QEfVL7lubzp/QGOVRImaI6vmSnHDWOvflom1yG9naTR2/xMX+S79m6LH
         Mn9IxZYLvogoeO/DEnoG/hPKNcD8s1JLwotMA07lwXNfKQrMQB9qefW/tIq8g4ZcEpLD
         ijAPL3FA/ybKhti6pQcoq1H/ZSyFNu1lTyiqhL5D7TUn4Y5c+dzetAFKvTMzUbXRoc1R
         I7yAW/Ed3yHUL8fSqkxlEX1jMdKNJp39dLJMvSghpMOTl5Fhx/o7Zi71ygY92QUzK1lq
         1ahkYbCRZIerxaZ70V/tmDECMCmyl3NuyFOK+o9QtA2YWDrh//z8dWZclINRMB2H8Tlr
         l+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785710354; x=1786315154;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N48AUYYm3tvPPvR8l4uGebJkWsX1ctx2eFfv0MaLibI=;
        b=IPK7TUzomP++V8jFooVfr7CjQzydbPybaX/pCfwSkfvLGR4pWkSnScShkFU+uKYyI1
         0lnmpqGb0VPhLGcnp4ifWcDHs/aaupK71PjcqvZfb3AaZLVe9YpfmmUV7PeRBXqZ+CpT
         r7hlkpcePS+WvVVM5imIosQi/a3OwcIO8VjmMMVxf60d9G6aO74i3t5h7O+zuY8CXnpr
         gMxWVqSTPcrmbLGGo8alhCnrHtTJ7bxhKZMyHUJ+kg+han9IoM2Qsh6yHUHNwATvER3z
         kfi9nKF96oOEmv1Xa0nzzzVqdn0xm+40WMotdXtx25fTib9HMKVrpLJvgy2q1Seu2GwF
         q7bA==
X-Forwarded-Encrypted: i=1; AHgh+RqDFRFNAdX+WX19IR2sPBQeYvJR9gzn6ROkyHoMWi1uYz2vMdUJPtoLz1It9O8zB/GFj9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYeV6lj5IUQtkF5GLNHxLhxEpit5vJD9KJYHJst7YfIHWqhfM
	X9EfPsgeF1mubdrlyFkzpcFmxdxsq6Rmq92cIL1g9UEQ1VynR7xxMCUV
X-Gm-Gg: AR+sD12oDOIhDc0ODtJzN7hNKnleAdhPXyVjI4u/ImKUnwdvR0Xqp38qMbxSAo/rOdv
	R3I2JU5x8S9BKMbcJZq1HJtm8aBUNC8xxpoVIhGd6qJ6QOw4vH+WnmugF6P5okmgJBcfEFQIHdE
	PEUMcjHaFLXWPzZTllU7IAcEZZ1LNKzoUb13BfF2+xVu/BGN1jdjzFYAv8Da0vxyeCu/HM7d9kp
	S1VcIt7TB+SQwQM/nCaolOTVDcto2Ykk1g8ckox48jCRId8lsXjnehVpmX5X2+x7GrSYHeykG/q
	mwp4HwpOsudVzun/pBIQmJ3I0HZGO3C8SqiIXL2LEvc6/aw9hD8XdHZAKAiiZ+zd3drGtt0kneK
	vfTwJh53+ykrsINtQQaoRyKAbVdRuf5yCToQ4EkIE1v0YfLxJ0tN9L6gIu4+IGVPgJ9Xw+M2biS
	aesGQEExBe9SIiJJudFEdZu4SI7AHzztKFIBldWwgoMTP/Jrjv7kIRVdQ9paWaRSF3pEZA7JUw3
	vKHoTmpSuRor5lcl6ldut95JHx9RhNjcua4BOcGSnqUiiYzw+vohavlbNwi/e7y46+gduqZl1FC
	xZcdXT+g1E17QXSUYmiqKTAmhHo=
X-Received: by 2002:a05:6000:4615:b0:47f:8887:3b07 with SMTP id ffacd0b85a97d-47fd72d320amr19682761f8f.13.1785710354168;
        Sun, 02 Aug 2026 15:39:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a6cbsm24268638f8f.23.2026.08.02.15.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 15:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 00:39:13 +0200
Message-Id: <DKETHNFBZBMY.1SRGR8U8AVYAB@gmail.com>
Cc: <alexei.starovoitov@gmail.com>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 00/18] Generate bpf_func_proto for kfunc
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260801074633.1595644-1-ameryhung@gmail.com>
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>

On Sat Aug 1, 2026 at 9:46 AM CEST, Amery Hung wrote:
> Hi,
>
> This is the second of three patch sets to unify kfunc and helper
> argument verification. It:
>
>   1) further aligns the kfunc and helper argument checks,
>   2) makes kfunc argument type classification depend solely on BTF, and
>   3) generates a bpf_func_proto for each kfunc.
>
> With classification now a pure function of the kfunc's BTF, it is compute=
d
> once at add-call time and cached in the generated bpf_func_proto, rather
> than re-derived on every verification of the call. Along the way it also
> fixes a few issues.
>
> The next patch set will align the argument register compatibility checks
> and route helper and kfunc argument verification through a single shared
> function.
>

I adjusted the commit log for patch 15 per your correction. If there are an=
y
other changes, let's do them as follow ups or in the 3rd tranche of changes=
.

Applied, thanks.

> [...]
