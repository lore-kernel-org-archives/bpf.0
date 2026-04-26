Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417E838947C
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777231012; cv=none; b=dHPDVP6lnY2SIz0crB5mXjdpW7h1APuusQRKNRUvYRHqBBCP436nsC4rLdtTi0fKxY/NPj0OBtmDpYPX+wAE+310VyiOcKMxuslH3tIeq7HTWKXKFlT3AjHZMC+DVrh7VGpIwvjzfhfCoYjcnVlVoSnJTs+wTQr8JklrTbL30Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777231012; c=relaxed/simple;
	bh=Xuf+R/+WB9hB+YYiyN7uL2aDPjof5JKU2nWhd5xO/0I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=e6gUqWQJlhvPXZ+uKes9f3wdwXi8Y0yesxTG2Zthap+mRhrTUUK7SF/KR199PSgU6M8Wn2AL6Np+o48zSjzjLyeLWndBNOkj8gmg76BZAa7kO/F3gGICMIxqj0AXxtcjdcteY9D4J2b2PRx6p1ONhJMdX4/JTwKFzu6MMAYVO4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=UM84Mdk1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="UM84Mdk1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b24fdac394so91818885ad.3
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777231008; x=1777835808; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCNYJ9Lu7oG9Wvhqwh+98GrCVYIvA0xo+CmPm9Nb2RI=;
        b=UM84Mdk1DPJ+OV6PofXJJWhp+p2iQWdNjdHaU/IYLOU4wr69WleDLfICdhjYXseEdY
         xuBFFEd6JgugV41g9WlI3+NbjKFlyvmi2iS6wHPZi3i265l+JkVku+UBwXejI8qzCfIx
         ol+6w+Ie1oPer/faWyJ4sei8qjhj8l51oKKgu/bmobr+F1D2NuVHsaASP+kFsipX1CYj
         1OI9qoosxj28A2xU8uvuBTLVTaxmla3PbkTkFsLv6awqGuMaIq+Fb3Gn/imbY1RWupGH
         hcKcy9kGuestLU4mn3QVrhjVG4KUjNMVdHea99WEKO9L6LxRs1WNHHhL+aqwSD4pNBwq
         VY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777231008; x=1777835808;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCNYJ9Lu7oG9Wvhqwh+98GrCVYIvA0xo+CmPm9Nb2RI=;
        b=d2ro2Rf3sWmyKxW+iFIurpQFA6YxNDSFUU3XVS+BodiXpS9AyS3LW8NhPoKkocicxb
         ORV12tNLpyR9kteE/afP1nLVv+jjKuBZoiROPbR9eUimoaSHV/02hmB9Sd8TuqiXXXRZ
         P3U2e3exUvMprURgxifDweiYWWe7s1H1BrRzKRt5gEPdrSLVhEjU/Op+tCJJvswnoY+V
         s6dU9E7UdbwzJsGpxAoWJNYtrN4M+TXqgmWZdO3dyzzxCyVr4oU7rfwhlaFzK8EheX3a
         r5DtxoOdJFrhvI2C/eY4jCzgdGKW6A3Kvk+N9GQxaEdnqX/goL7MFDRONgYvMJhhVD1m
         ED2g==
X-Gm-Message-State: AOJu0YyCr745wIAn4wocpFd0HBMYVJAg8fUsacGIiu5n/jgDhEP0RXXx
	Wa/B9O22i1ZpxclBQT8oSaEKyb+a5fOrqpydJ2JX90e9xe6kTKGcZiDcJUSiIEQVy/w=
X-Gm-Gg: AeBDievncrXWU9JYm6ibszN8U4qymYBAerfghZKgMYRWV1SVwZIkwwD2o+LCs8DK6He
	hkOdeR8+gQ3VYWgpnhD0aLmfv9mg7sYa9GVk2XmM9D5P8U0DMc3LU57zksuL4x971XquPGSr3Dh
	lfiZ0qJTGZ0SWW3nMwGyflXUtkdtuNyHLlL11B9V+wxr2kUKIwBhqskgzhvTOHKnXfFh0Cmn+ss
	uAQZLBiB09/ux9EhDmCEdsvj6u7kOvbBblzL56yyaxdpN2UeGI49291LaLQ91RRBkz7pSFJaGwc
	xopmTiipN1eMIRrNNBXUfp1/R1Rxogjik644yutuP1WODAaJ/Gf2QkeobJ1qdS3zLumDwS02ISW
	4iE28A9hJJUiqy6pz6Onscq+U1WhiG9mnwvFdcSyw6lx2RpKvkos0jXab8QthcGbWqfKkARbxNm
	05SnJu/LqnXSeKfM5iBw==
X-Received: by 2002:a17:903:3c24:b0:2b7:a3bf:b2a0 with SMTP id d9443c01a7336-2b7a3bfb415mr169412405ad.5.1777231008213;
        Sun, 26 Apr 2026 12:16:48 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::2af6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab3ad18sm296596405ad.71.2026.04.26.12.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 12:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Apr 2026 15:16:47 -0400
Message-Id: <DI3BT9LJCI1D.2TRRBC1BVKIP2@etsalapatis.com>
Subject: Re: [PATCH bpf v2] bpf: Fix off-by-one boundary validation in arena
 direct-value access
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko@lists.linux.dev>, "Junyoung Jang" <graypanda.inzag@gmail.com>
Cc: <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260426172505.1947915-1-graypanda.inzag@gmail.com>
 <20260426181736.794BCC2BCAF@smtp.kernel.org>
In-Reply-To: <20260426181736.794BCC2BCAF@smtp.kernel.org>

On Sun Apr 26, 2026 at 2:17 PM EDT, sashiko-bot wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] Data race and bounds check bypass in arena_map_direct_value_ad=
dr() due to lockless reads
> --
>
> commit a9b5d3016475abf10be02a320dc627c95b306d92
> Author: Junyoung Jang <graypanda.inzag@gmail.com>
>
> bpf: Fix off-by-one boundary validation in arena direct-value access
>
> This commit fixes an off-by-one error in the arena map boundary check
> where offsets exactly at the end of the mapping were incorrectly accepted=
.
>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 802656c6fd3c..49a8f7b1beef 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>> @@ -511,7 +511,7 @@ static int arena_map_direct_value_addr(const struct =
bpf_map *map, u64 *imm, u32
>>  {
>>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
>> =20
>> -	if ((u64)off > arena->user_vm_end - arena->user_vm_start)
>> +	if ((u64)off >=3D arena->user_vm_end - arena->user_vm_start)
>
> Could this evaluation be vulnerable to a data race?
>
> This function reads arena->user_vm_end and arena->user_vm_start without
> holding arena->lock or using READ_ONCE().
>
> Concurrently, a user-space process calling mmap() on the arena map FD
> can invoke arena_map_mmap(), which updates these fields under arena->lock=
.
> Because user_vm_start is updated first, a concurrent reader here might
> observe the new user_vm_start (a high address) and the old user_vm_end
> (which might be 0).
>
> In that scenario, arena->user_vm_end - arena->user_vm_start would
> underflow to a large 64-bit value, which would allow arbitrary offsets
> to bypass this bounds check.

This seems like a valid concern, though it is unrelated to the fix here
which seems correct. Can you sent a followup patch using an arena lock
guard in map_direct_value_addr? I don't see any issues with taking the
lock since the method is only used at verification time.

>
> Does this logic require synchronization or READ_ONCE() annotations to
> ensure the verifier's boundary validation remains effective?
>
>>  		return -ERANGE;
>>  	*imm =3D (unsigned long)arena->user_vm_start;
>>  	return 0;
>>  }

