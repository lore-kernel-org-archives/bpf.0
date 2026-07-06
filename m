Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7D3BF662
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363086; cv=none; b=iXFcKNoygCJFG/cE/YrRvqfuEz7WVbWg+/bOYekth5H65zcb1js42IuDvn8sji9mSR9asOXtRHZXATLXHpSg7AEDfGq0D9vOCsRekUjFFyic6vl+mQxcTV6zqCACgRVlV0vonlrwIvFiRUdAA/9VFWbp3uEMzXp6a/5jp5ZWNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363086; c=relaxed/simple;
	bh=u8PRGmk7C1Y0lBU8LeNSCd3v4PpWWZ9O2x3ySxWHhs4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dSgN+ObHgUMCab8Fvinq7H1EqmIuD+W3i6I7COu2MmCZrMeMdyXh2mv+52cODvvtXJ972nsKI9Rc1KTo99azI5Dr06mVr4p5lmX5dY6cmN2Opa67i/PPs0O149EDh+j6ZDavgJ6y0pN70LlXbPDhpvNud+sV2GUvNdOdcBRDs4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=O5gUBi/c; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="O5gUBi/c"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso1442830a91.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783363084; x=1783967884; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OTCMH70SrIoIhqzz9upACUv1AFoVn7zmxyX3TyiftM=;
        b=O5gUBi/cwxNhF8APnqt3iDRYfy0fFjHLlluKTq20MXhbT0FrEUKO2qdiswwgCS7BXb
         AFHPxp5/Xv9Ft8sHDNyudPYWDkiyfCMCtlIRSTe88Pmeqd1+BT9zTBdBuTpQgUaaemHh
         GZlaLRq4fhYz4zgD2R5B+rwB+ffymjSZpIM9ev7Kf4ORksh28Flruu2u92+/w22gh5sH
         QhLTEDXEdsgQhYxLU+xPLpnBchSnN5lYmQUhhMIdYRA9BCxq1wIGLswL4ZCbBnx5byHo
         Lb1wu5uEeVQcEMUf39dzTb05/iCpKhuIXqtvDDZWYwmuKY8uHvZbsXw4X01UEr8CPm4T
         FdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783363084; x=1783967884;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+OTCMH70SrIoIhqzz9upACUv1AFoVn7zmxyX3TyiftM=;
        b=Vzl54lRQNhiRdLreeRVpJWh9nMjeeaR++GeUfBN0wS9YCG/qJhchl40jFGjmRMWiOp
         ZItfCU8Kd5pLcswM/enAoUkPC6At+yEd1m4s4ltJuQ3rL+QSuJOgCQlzZt22GjgjH4Jm
         Gy6dMxB4ZBNRntO4WU/5/LuU0higITlKrUZiy4qn4xEezOXh3PwQAb+SvP+Ox6JmTyjR
         ee4NxNGXj6hQsd0og+0JL57YIOT5C87T16jd5Nx2mUWFp66+W96jS1tjXID1wX78gVBF
         i53eEFNOgtPNg6jesk8Z4Xs2APz6tL6bN3/AL6wEEnH0D0rKS18ZueWOQ+jHH6mKGQ22
         VhiA==
X-Gm-Message-State: AOJu0YxcW/RyLwpENVgH+DRX3i1hnANizlRGNJJ7BxL8crtM4/HANyCR
	jsuK733UcUfrLCH9IFxonCGIOFxB0KAVjbfei7IHqgM3wtnI5+bRCS1o5J9XsEe1XOw=
X-Gm-Gg: AfdE7cm35Uv3z5M5wvTzeFGq1ej/wpSr3Arv2Bfy7HNskin2iLM+1UgxxjOqrh4mPm4
	FLxLOr7xUrCsBMro0kRQclZTcuJx2fPw719f/9idNFNBixwvoBNRYiN5QaMzVhGQ+z1TCPqwtj3
	K1hRn3lPYFRm7rjJzRa+OhUtIfKCl8kYRn56B+px58rv5bN3A6Y7GbRYmZnskDeh6rk6V12UOFm
	WEfEv8eQbjEHgylaiPjrrBFhRnq2kXCBO1/wi/vYwzDswGbjmBLrWEI6DiI41Ju1ZWbFTWrxdDN
	/WBCF3j0JZzrX/2GsFN8i357a/h1ZHnb27sliWytV2TBwoqW6qppiDn5BJDpY8Tlvy6jEddTm+K
	v+UnvEwJUsldqn3Hkm6UIaH/74sAk9rwV+n9gu0ktEh6gW//tw0/0V/eaJxm0XqpkUJIgiJqFLa
	Pt5wznfef16TZZT7XKBpJnEqh0CHoqmE3kIBzX1ah8vA==
X-Received: by 2002:a17:90b:4d81:b0:37c:6130:7a5b with SMTP id 98e67ed59e1d1-38755c4aae4mr1900076a91.8.1783363084174;
        Mon, 06 Jul 2026 11:38:04 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387888a0675sm113422a91.0.2026.07.06.11.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 11:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 14:38:02 -0400
Message-Id: <DJRPGA0KTH7U.WBW2Y6CVNBQR@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs/bpf: Document BPF_STRICT_BUILD=0 to tolerate test
 build failures
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706-b4-bpf_strict_build_docs-v1-1-5324d605c7b0@suse.com>
In-Reply-To: <20260706-b4-bpf_strict_build_docs-v1-1-5324d605c7b0@suse.com>

On Mon Jul 6, 2026 at 11:28 AM EDT, Ricardo B. Marli=C3=A8re wrote:
> When the kernel config does not fully match the BPF selftest config
> fragment, some tests may fail to compile. BPF_STRICT_BUILD (defaulting to
> 1) makes any such failure fatal. Mention the option so that developers ar=
e
> aware they can set it to 0 to skip broken tests and keep the build going,
> which is particularly useful during bringup or when testing on constraine=
d
> (e.g. distribution) configurations.
>
> Signed-off-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>
> ---
>  Documentation/bpf/bpf_devel_QA.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_d=
evel_QA.rst
> index 45bc5c5cd793..edf8107a7beb 100644
> --- a/Documentation/bpf/bpf_devel_QA.rst
> +++ b/Documentation/bpf/bpf_devel_QA.rst
> @@ -479,7 +479,10 @@ for details.
> =20
>  To maximize the number of tests passing, the .config of the kernel
>  under test should match the config file fragment in
> -tools/testing/selftests/bpf as closely as possible.
> +tools/testing/selftests/bpf as closely as possible. If not possible,
> +however, you can set ``BPF_STRICT_BUILD=3D0`` when invoking ``make``
> +to tolerate individual compilation failures and continue building
> +the remaining tests rather than treating each failure as fatal.
> =20

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Nit: You could add the caveat that anything in TRUNNER_EXTRA_SOURCES is
not covered, but it's pretty minor.

>  Finally to ensure support for latest BPF Type Format features -
>  discussed in Documentation/bpf/btf.rst - pahole version 1.16
>
> ---
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> change-id: 20260706-b4-bpf_strict_build_docs-a8aa7fa46e2f
>
> Best regards,
> -- =20
> Ricardo B. Marli=C3=A8re <rbm@suse.com>

