Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0BE3D301A
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786678037; cv=none; b=hYgL+4NfWc/0ws8LUkdgtOEiYJggD5NZhxL2dTvwLI9K24ZTJd7mjMsQhkqq20T0raDUQ4NraRffLVsxr+ygcE38JSwpGJpNJKHp+QYFx2yN/qu1hUw/U5m3JInfdpYw6QlufLg0rcMBOtDsoYt7CvRReuOKqs41wnPz+2PByGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786678037; c=relaxed/simple;
	bh=cOJf8+kTaOLD5nvInEe8bHomVtMpjStUutNJll8M2Fo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=CuVCp2Ul7skCc2iYBlejj7JOYBtKU877M3uAIx3MuyGmASp23bNZjOEiLLXR3MFvVhwSdPlmSyHjkDAhmSbz0VBl6NqUnIgPtOUKtnPslySNNeREQp2mrIzp5BR8k25ndTx2xIbKp5iLC7Gh6EFSpDwTe1G/AIjcs/LjbAFXfx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn6tDQDD; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn6tDQDD"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so1306975e9.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786678034; x=1787282834; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wR8dxUoz7hW87etySbdzqnQiHeg9Ep5uYNFs48Q2a5w=;
        b=Yn6tDQDDq/QOGVRGC+WwXNNn221HCbiwaDNvp/KNmxuQ98HB5Shhd/fDdjnjvAM0er
         ZecWFvct+7OQ+2mtc60yqPgrYI+b+1Qm3MT2xK88KRpBBEb98c7fhTttbFzSPHofmqVO
         KrsNtn52e2ZtstECjfzXOSk+Wq8B7K1x++GXw4p9DVbfhiQPEU1hsMX1sjPwOSHQroqu
         LmV0kRrw5L16gB320BziCmbrGH1s7nH3PudcNzsjrr/vmJbltCgddD918peuaaKjIUMu
         Ew2EC+3rpmBVCvDGJ7IxWKeRcJJQJhSVH1kxd1SqQ6SfAj5VdSeNlm7++6gXc5zXG1wt
         y3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786678034; x=1787282834;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wR8dxUoz7hW87etySbdzqnQiHeg9Ep5uYNFs48Q2a5w=;
        b=EYzuWY6HGeeSRWyf7z/Sp3gXkabFUxdPtxp8DsGRB7mfJ+eWmcCjvDbZ24YstLwYX0
         fFD52z2orlZ2bAah4JYFRCNfoslm/FVSeyAEAxWlIL4gKAfKGDx7pUEcuADi1/EIMomY
         3u1O2avZ8sUSlFvHSS1v77jKsWsYEJigHW885elnIvF12ScARqLFOgd1IdX8jn8SEmoK
         1alvLVGxW5ZcVcxk9WBT77goOeHWSreXOdpU6eZoNAAgGiEx1pIk4e2YGTipJD68Nw71
         uG/K2EnLY87B+gYiGCJBg9D3AuwtHTCie2m8Rext14GEVnzhzhK8xVehvb5Flun/pOOd
         o2nw==
X-Forwarded-Encrypted: i=1; AHgh+RrZiLzdxu9+Z8FDHrP9K45fDiIRAjOQ2Kcs01DRuv6n5+zbaV8PCSXpbgJyMI5lAhyeVUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7pdJQ63q4/gRO90bcFv5nGsv0g7rT0MF0LnOvlhvLvPs+y98F
	qUYHBlPYnve2qPPlslPGf791Bf3FqHCbLYOCVe6cTAuVD4JL6hR+exaM
X-Gm-Gg: AR+sD120cGGG+3A+szHZsfO+9sq/q6TnOGhVS0n1FlTsIFxWNdSs4iPW378oJKXtEfi
	T1guYRf7ww83IIljuZB5BAWbJ7qSCsOeC49yxY7ySFyE7sX4k/JrRRVEFqP/bArWqFtwIz8a8Is
	4XcnwoKyyc1jniZz3loUQhfgYDdko8ei8hAnEuSvHULO+pbjGk9SHib6gItQMbauYrn0d7250QE
	C4A4vkBgH1sixvaCbv88s36QUropwl+vbKLFi8ECT//4Zt/OZqoJAYbDaGm3d3vNFySs1u37x4w
	5TMTx1HylHTxXUYTytnet8Ww2XFig10Q0Py5/eLPM+VXaU/ItJyOaj2wGXon5quzH5gPVNnv1aj
	qzpaDhDrwvg6HKHPdoOpNxZmOkRiUHMGd/aEp2z1NlSr+6yEgKN/FEs9bi9dWbaT5llqVUvuDnE
	1POzB7F1+Ei38t85Ysd+nGAo+xR+HDkgAnTQRNDGfb07rTZBT3LZAl73wAyBtCKU78942a26B4D
	bYtoJobsVcLvJc8E51hJOMQ3mfS40uyUyFdyYCZLNSWkbxrV9FCe5d5qpElV6hJG11LBR3s2ExR
	huWW0pr0jtIM41xOPKe3vzmAr1A=
X-Received: by 2002:a05:600c:3496:b0:493:f318:3bc6 with SMTP id 5b1f17b1804b1-4998796e478mr37184115e9.13.1786678033650;
        Thu, 13 Aug 2026 20:27:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988ae8b62sm14836305e9.5.2026.08.13.20.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 20:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Aug 2026 05:27:12 +0200
Message-Id: <DKOCI4Z5JJC5.24Z0Q14YKRX60@gmail.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, "Puranjay Mohan"
 <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Puranjay Mohan"
 <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next 4/7] bpf, arm64: Convert struct_ops arena
 arguments in the trampoline
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <20260810190922.3408757-5-puranjay@kernel.org>
 <2ce67108-4b79-4635-a46e-dbac21ef46cb@huaweicloud.com>
 <m2mrupzv2q.fsf@kernel.org>
 <a6dde22e-47d1-4f5d-9ab9-284e9beefd56@huaweicloud.com>
In-Reply-To: <a6dde22e-47d1-4f5d-9ab9-284e9beefd56@huaweicloud.com>

On Fri Aug 14, 2026 at 4:10 AM CEST, Xu Kuohai wrote:
> On 8/14/2026 3:20 AM, Puranjay Mohan wrote:
>
> [...]
>
>>>> +static void emit_arena_arg_conv(struct jit_ctx *ctx, u8 dst, u8 src, =
bool nullable, u8 base_lo)
>>>> +{
>>>> +	if (nullable) {
>>>> +		if (dst !=3D src)
>>>> +			emit(A64_MOV(1, dst, src), ctx);
>>>> +		/* skip the subtraction so that NULL stays NULL */
>>>> +		emit(A64_CBZ(1, dst, 2), ctx);
>>>> +		src =3D dst;
>>>> +	}
>>>> +	emit(A64_SUB(0, dst, src, base_lo), ctx);
>>> Maybe I'm missing something, do we need to validate whether the
>>> address in the src register is really inside the current bpf
>>> prog's arena?
>> The JIT can assume that it is a kernel address into the arena as it
>> comes from struct ops.
>
> Thanks for the clarification, but I'm still confused. What makes the
> assumption hold? How does struct_ops ensure the address passed is
> inside the arena used by the current prog?
>

I think we would expect the kernel caller passing the address to the struct=
_ops
callback to have something that points into the arena region. If that
expectation is broken it should be treated as a kernel bug and be dealt wit=
h
accordingly.

Does that clarify your concern, or did I miss what confused you here?

> [...]

