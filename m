Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3EF1A6814
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043765; cv=none; b=EIP9WndcPcHIHp2Hjx+GXTJvMzkeaSIAg0WTqRx6SDso3+GfeU/41SiGoLgZ5/manOWEddBc2G3Pn4K/Y2km8uRLV/5+vnznmrkciCQV6foMz+GvYBq/yNO4xy94JWi5T/pXDEKmfGzhRr7ct0UJK3cY+9yYsGUoG90Ocn7B7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043765; c=relaxed/simple;
	bh=BIS0ui2qV4v1jV6GqZG7uC2ZAHXJbrvcQjLGXdGC8rk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WvWCDC41e/Cp3Fsn0nk29r/AmdpSF00dbyo8khUdCiaHKBYALLydSUCbYSqT1jv8qthFNVb82jxmEJEWMeXAMznVyJvOGkFLQszOsoBV3X9Fp9Ysd0JpZOO7wDTllX5TLc4NI/p8NVGfeZeli5SrpbhCKiEzHR472oDKBuqI/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNrv6puS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNrv6puS"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so38172825ad.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786043763; x=1786648563; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BIS0ui2qV4v1jV6GqZG7uC2ZAHXJbrvcQjLGXdGC8rk=;
        b=rNrv6puS701NV6NNmDPgYtcAKPu3OEleu7ICmF80kJPOyQ0ETOPu22rn9y9hClfWTb
         St71p7WR6aE4B0HCXVZ2NK3Cr94g87WeHSqkbcmIJoHqQ0nhQC9VKqEaYVVUWXSxkWkp
         rLZrv7SQVTm1fO177rIV9lxxiZFXN3wO7cLY+EVK9wXOPFYfFUljHj9ttim5ZzwX+9QP
         t1TKYXvvGgQ5VHqQq10OqQGRDSS9T7wMGiBtN2EGgm85qJ3DBUv39w2Rt0tPt21XMpM0
         weeTsDwc3unNPf06MPySp4ZysZYYhUFKaYwYOlUjbZk3S2Y+Y3XpCbHJCoOUHNNKg+o+
         IZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786043763; x=1786648563;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIS0ui2qV4v1jV6GqZG7uC2ZAHXJbrvcQjLGXdGC8rk=;
        b=HzwphCXR4jNoWejhwaCsUOzPQA2BIgWEJy27hnUX687ssp2eOQJ1XwZ0za1Z20b408
         C2TEujgmDa8YHhuvzYBMnNvfCYm2hygY84fEXaY4aaqTlcmxIXltT5bjVkPXasS3Nq4j
         +zefcj2z5K1yP1kHm7gMtKtfzS2neKapZcao0/o7fZvCo/xUkeZAXV32eF19MSQvgFEx
         +mA2ac0ZhiynI3htbE2zeV4BI3IB2vHHjxJs2HHZntq7FPEaHb6jRbXDiRGyKsuvfa9r
         tQJmF4J7YK/k1YhZSLcPezMsK2vGPKxzY6gR72z5Wc8Dd+mGkE1x/5F997L+qVWFmgw+
         NcrA==
X-Forwarded-Encrypted: i=1; AHgh+RpflhLEjl2iYgpm1quNRKAxK2aRDcIoXqlrUIQVuunZL4IJeiK9w6lCULxFDWyZub5CiR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7Ay+vJ4XYhruQsIIhSQ73CJW9Dy1dGL6/k3Gv8swIvuzadiS
	ZXY3cuhM0ZwL8O3kpTX4t0RLZenUJhclvrn/tRYYCy1jpkQewHRN2y6O
X-Gm-Gg: AR+sD116rl39XKq5Z05Q75X2uE/4bKuif/pzdA8xRML4gVYIpfi4OTKzLZ23mdL6igv
	Bq3EgASsnpSvp0XSXveoaRP4r1OFHHMQqmaIHBzq/Bd6CiCPM4cKWXeFg06myF90TwsTAA/yTD1
	2VcRzVlzym4RX8xIE3lbn9XJXPECok/Z6NqXihwwld6tzrarzu1jRDogXC4HlYu8JwAD28yJ7uY
	4KZGB7SjJK1vpH+g4gG/HZ/FtYQI6PLAB2mBQ40xS0Zd0fc3Ywg7Kt7GnqszbD/JTdQNqBxcEeK
	/HO+C9/UxtneSQflP3AKSm3c71PnYhw7tQFOdN3lgxLbPYxrQMm4IQwKAOpXf8Pa86kj+Z3UwbN
	fBI/nqrT/Kb9P6dJzViT0x2tqA+2miexpbSs9xdLDElKlCxA387qJFYinv1lVPeQPCpFYniIocp
	inTUdkgt0BGx0kxAzmqBtuCyxZ34m9pzXsoqTBtvL9I04u7vkONwWvdGq7NfCtrHXsD7rJLV97z
	d8V+zT8u+L1OJqx
X-Received: by 2002:a17:902:ced2:b0:2c1:98b7:ecf3 with SMTP id d9443c01a7336-2d0ca984c0amr187337555ad.23.1786043763034;
        Thu, 06 Aug 2026 12:16:03 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d120c6210bsm935165ad.84.2026.08.06.12.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:16:02 -0700 (PDT)
Message-ID: <00e8a5f60022ee53e5ce1dd75b94446fad4444a0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] selftests/bpf: Verify arena type tags
 in resolve_btfids test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Date: Thu, 06 Aug 2026 12:15:59 -0700
In-Reply-To: <20260805230648.2354989-4-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
	 <20260805230648.2354989-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 16:06 -0700, Ihor Solodrai wrote:
> Extend test_resolve_btfids() to assert that resolve_btfids emits the
> address_space(1) type attribute (a BTF_KIND_TYPE_TAG with kflag=3D1) on
> the return type and/or arguments of kfuncs marked KF_ARENA_RET,
> KF_ARENA_ARG1 or KF_ARENA_ARG2.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
