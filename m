Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BE937189A
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 04:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782880418; cv=none; b=YGNQT8xH2KAyx01cJuQjVCo0CoIKsR/vJeapfdt48R0LOQL147J6ZQY7QtOHogfuvHYL3t/Mph5Ks6obwFAsPcdM9eyoVbOMkeBHRU+AmemLX1PCtrNDFGZDK+BOUlWzZ8ujJhqEMi5XN2Vqy5HwslL71RT8dS/eaof6begTuAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782880418; c=relaxed/simple;
	bh=/nmnobtjJf7DeuOmsJfhnD4kVBPuo5Blpi7AtswsGbA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kcE1e2iIqcV/ODh+ZjGrvSQ55bol89RzhQT1JrZO1+HYgSctseDKC5Io5yLcUcS4E17PRjPhySzLKqvOO12bwokm3DABIqW7hhHtlVi35AqkP5qJLTU5xPO64zwVALadGecBTE5D6XDnN/dy+8pXcwkOg4VU31/UUXARhCFKKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=VJ3+igLM; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="VJ3+igLM"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e6a434cabso12144785a.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 21:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782880416; x=1783485216; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0R1QJeI06Wrfnk6C1+/9UGmY70b8ywwdMJisPWWJWow=;
        b=VJ3+igLMPvA/nzbN61G+GrSWMIl5SpdJkHCrSxsi/uxHA/5T22mjVpys1ZrfYpUdpU
         7WTPUjOW45Up2MHTYUQGUGRfE83uoiHedlE7I72RbSAc/zULDnL5xeY0awR987n+pb0Z
         V2mbyuRnEUOT6Fckd4YuBfb/trGZMC48L1DDosoD9v5Rj/bAh6sYtrv8Pz3yx1Gs8A02
         cg8iC/sozWwEjHPjpvQqWYZrDEfkC1N/bjh3IrAUdRE4uuCLUMAWyH0V8lKpca0ueQEu
         l0+trs+e4Clm2g3HDHcmkHwP8t9xCVuYXezDjEQgtGEykmBleKNlCG2fMVNMDENvU282
         0NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782880416; x=1783485216;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0R1QJeI06Wrfnk6C1+/9UGmY70b8ywwdMJisPWWJWow=;
        b=EqXvaMj7t3eIqcxDKlfmsli2ST/kup6Mk3Uno1FtWuK9Rk6Ylk4k0IA5T86IvVhOwt
         H7qmz7MAQlCiFouH/m9DWII7zWEwXLYwo6F/4i6r3Ex9rw1hFOq7MOOnXqBNVWmAVfg/
         GiRFCSEGOTH6XheplJU2Z01cIld9zba8Xaij4tr75KdyyXe6EiG3/IQKx8vu+Weldh59
         zmwTDJWLJLgh0C8d+qVGFtuK+DnuwmAWHRA6OSihURuxv9g0UgfsY96WlvRjyC09LdGB
         wLwa7ruT1JTJ8ycBKlAXEIV1nHv0SfForCqDktSODDLjkvbE8YSeZJ+QUS/sf94UtV6v
         sOKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Dsqe0poXlrsvlLh4ITsRJzYLfBS08JQ+ibITMr8R5px7YgmuqA9Jfnf35s1UQCg3fCnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZsStOCGApI0Z55ROfxeqtcs9qbKW/Oz7eJr6X7/wXzYIOWJ47
	9DswtG8u41im90f6qwQSO3YEy2gMNsthHFxHKi8va2P6HLrpFNsd1+dY57+/EapuDd0=
X-Gm-Gg: AfdE7cm1ASUGM+/jSCvyaju8ufXnFX4QFLV2OKaD4W161Jpk2vFDZoRAXRd4D9lG7px
	rpubPGypYFCORBuddcIhpayNMbkc5ZbGSqaZsgiEjFsA3rIXWgHiGNRZr9xXuOYLi7Uc7AlY25D
	VAOm3q9PyxJ+EG9EjzGoUHi5Mqqn0kM2/fyuPAqEB21FpZu/129qvyyNneXJrgYWVQfwqPn+lc6
	W8OHoFFOJUVpbvi+3gXeWX6ltmuGINADcbtSdBGUtxvw80S6WGZeLet4TUaOZIfnwb3vyJzfOI2
	jus0ApwXVbAs9UgMTsfWs4WnqnYEt3olD9br604Kvy/wRHgmuEvSMxMxgCu+yASuYFnlOCa+Vjf
	hbL3OTWD8fuKvx2f52CHguiKQl8/8QZnzynRkv/z2TK0hQ9INaiHk8BjXrSZVJGs6Itt4FxMrvM
	qHGSdpAsAJFOE=
X-Received: by 2002:a05:622a:16:b0:51a:8a47:b578 with SMTP id d75a77b69052e-51c26b0077amr1635301cf.38.1782880416540;
        Tue, 30 Jun 2026 21:33:36 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10a3307csm33851011cf.29.2026.06.30.21.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 21:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 00:33:35 -0400
Message-Id: <DJMYCZW34PNV.GIH8C7AWGIOV@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <mattbobrowski@google.com>,
 <song@kernel.org>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: libarena: Add bitmap
 selftets
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618085626.19633-1-emil@etsalapatis.com>
 <20260618085626.19633-6-emil@etsalapatis.com>
 <a9926def-30f4-47c2-8ce9-569412d1459c@linux.dev>
In-Reply-To: <a9926def-30f4-47c2-8ce9-569412d1459c@linux.dev>

On Tue Jun 30, 2026 at 5:46 PM EDT, Ihor Solodrai wrote:
> On 6/18/26 1:56 AM, Emil Tsalapatis wrote:
>> Add testing for the new arena bitmap data structure.
>>=20
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> nit: Looks like bmp_copy() is not covered.

Ack I will add a test.

>
>> ---
>>  .../bpf/libarena/selftests/test_bitmap.bpf.c  | 314 ++++++++++++++++++
>>  1 file changed, 314 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/test_=
bitmap.bpf.c
>>=20
>> [...]

