Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A013793D4
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885732; cv=none; b=KCfJAKeUPJ70X/rxXVI8SBZJpstYI7ypzyhKKywoxs2foofaqCT+thQMQDJtpZLdW47v3Z3wE0zu1t7ueWiJZeOISKTBE3jnX/CrecnXEjsvgQ3wKe7S9k6Pj2HMfcQWUeZ4c+vdudW+BjzQqGjJjsKbfyJDJTm7YhL2BoDUGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885732; c=relaxed/simple;
	bh=joHwajSUu+ZUCU+Dc9z9g6t1RylbAj788euu993xKLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UYboy7r//VvasCSDQ4y+W2JJBd6v0eEB9sOOkoBrCSt2UDgs79fljchVbiktwbC5pGZxZsLbMmGpYWPGUpzD0+2cD5WYrWmhAw8wQtWHYj1zzXR70IzfyjYoZQaR4D1DmON63r7I0na5nz7OSVdgxjhtLZzx6wNZbbsp6v5wPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxJ00N/e; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxJ00N/e"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1233bc1117fso3005068c88.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771885730; x=1772490530; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s1BhsIngbBZUigoJ3ILO8yUodhE7Ngk+E+iD/bJimCo=;
        b=SxJ00N/eDk7oGQysHQfBLR56Wrv5rl2jBjvfkZuMDnysvAKyZlPcxpNC85aE+MVd3K
         roZJiqCUYDuo40t6U/JU4NaSZ0ebCeVLFLJYZQpgt1Tj6Qk0dKvnunoBpHZ/kEA2X1Ez
         izZ6OzpiDqED0L0jE6Dt+t1FhOYP01ckN3TX2GHuxwEsrr/2bMGriiT/n9IClPS0ujwD
         WJkz4hazKHcqXva7+4Trwwu7yCnJD2iysptWT0O+50xN77u2D6OsmlyV47mOH6RLShzz
         MsssWS9psG+o+p/PkdiziUv1fXLmpZ8hbfrwfBukyFbGo+KTlVy9bn6x4qcvpNptaJZu
         SOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771885730; x=1772490530;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1BhsIngbBZUigoJ3ILO8yUodhE7Ngk+E+iD/bJimCo=;
        b=Gmc+5S+C0yh0+eqjwUFqpm707jLXhdmHxyzSuFA1py7VMkTJLt46xj5q3PFI092CMO
         xAdNCphLAckyAz2GX33+U5AdBkF5SPCIbFx+nexp8EKzixXNz5R3AsftX1apMfPpBLuD
         SarIyWj3sqqEzSNCXI9+Tq4GIOX/NyDIRPVhu9jRraFy2f7PlxLSLEHl79YIShQw4u4z
         YVJxX0oHDUaz14/j5GAHnS+qsVvh3eSA486iqVWwmyGG3nTp9tTHeZ7cNOnxFb8aiGcr
         W49TJNAX6AiITR/zvsrnOSMmib+zmECt6j7UyldYtvghqpBDp+PZhZpAdAq7RIeGJawS
         kBTw==
X-Forwarded-Encrypted: i=1; AJvYcCWrRC8BNUBAvKNOT/rTRfs+T4vmB/c0ZL+0mFd+feuDpfkVCSPOKuBlKDs1Dc9qJ8IeLFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/PUgNKNJanQaGkuMjZ62HzlsYfTBNH67FRD5Pi+/N+m2H8mk
	sR/nrxTDo4UqIGusfePSQT245Ev+ZytJM15vZ+oAaWainGbQkVC8YxyD8u1zpnkQ
X-Gm-Gg: AZuq6aISuzZOip7+E3sqGE4V18lij2xu9SKsbDaAvevXwE4u+Wrf7FQ+67qxRre1xOA
	LDr8AaSEZMkK70iCDBoPXgzJXVwNXohWy+b+FPxSDSiHLx0puFtKewxXfmW6rTEOgtftc9nBdSI
	jKFbao1DeLeT7kG/OMTu/+m9wbd6zds7Xyg3QKnaypAOa7eLxu1Msedve2PK+pcvaIF6ugYJEyO
	+YND8MxaHhw8EF78e0TBPpe5UAariQOHPVEkcEqZ4UY91S0CoovmdFrSETapTunqYt5bingHzb/
	h4LyLSJi9uS2BnL4iEvyCF2fAO2TuWW4GGdQH0Zq0NVGoKvZP8u8/74WE7To0/SUpY3Ore+U4vW
	iL7kESM80Xaz+G4t1tWQNC5tHCOk5lAMShVHnfV0C9sShlei/DCdJ8VqgV0QDX4r0x8JSaXcfbv
	KPTz9CCs3IAbRjl+hHDB6cyuHlB1i59PSZO4IKpw2ytH9dv8Znt74Qgtsz7Cv5/6Zlzf3VBFufM
	yZpVUNn
X-Received: by 2002:a05:7022:6199:b0:11d:fbf1:1e27 with SMTP id a92af1059eb24-1276abb674fmr3653830c88.19.1771885730062;
        Mon, 23 Feb 2026 14:28:50 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:7bec:d612:85a2:37de? ([2620:10d:c090:500::1:3a66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af2ea06sm10390969c88.7.2026.02.23.14.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:28:49 -0800 (PST)
Message-ID: <8249f1439fa9ee4a1227da3f0707a9d0cfbad825.camel@gmail.com>
Subject: Re: [PATCH bpf v4 03/20] selftests/bpf: Replace strncpy() with
 strscpy()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jiri Olsa <olsajiri@gmail.com>,  Mykyta Yatsenko
 <yatsenko@meta.com>, Alexis =?ISO-8859-1?Q?Lothor=E9?=
 <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Mon, 23 Feb 2026 14:28:48 -0800
In-Reply-To: <20260223190736.649171-4-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
	 <20260223190736.649171-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-23 at 11:07 -0800, Ihor Solodrai wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testi=
ng/selftests/bpf/prog_tests/align.c
> index 24c509ce4e5b..841a166b8081 100644
> --- a/tools/testing/selftests/bpf/prog_tests/align.c
> +++ b/tools/testing/selftests/bpf/prog_tests/align.c
> @@ -633,7 +633,7 @@ static int do_test_single(struct bpf_align_test *test=
)
>  	} else {
>  		ret =3D 0;
>  		/* We make a local copy so that we can strtok() it */
> -		strncpy(bpf_vlog_copy, bpf_vlog, sizeof(bpf_vlog_copy));
> +		strscpy(bpf_vlog_copy, bpf_vlog);
>  		start =3D strstr(bpf_vlog_copy, main_pass_start);
>  		if (!start) {
>  			ret =3D 1;

This hunk no longer applies.

[...]
