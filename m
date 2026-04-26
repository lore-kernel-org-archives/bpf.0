Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034317B418
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777229931; cv=none; b=FnQDqMRpIJMiV8rtpdXFRz0gCk1rVPRFCJqa6MJXtO3uQ0T9TrAgOgLZuX6oNzFNgga9FHC9QmaOqOYD7HypmnQHDe87nTejfQtsUKs+xW3HJjxfZw/g5FiOTEYqchb62N5Sh/1MVB7fvXj9qOs76VKkK3S8IpF6QhcK0gWW3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777229931; c=relaxed/simple;
	bh=E0fBEdH8THLNah2Dh244LEg3gxmMssF1sBD4hKOB8Vo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r/ZBCzqiu20Tg6pJP78u1Obt4G5UW/ntWYbYo4Cc6KhkzXi3XeBxnGLGgn797xsQSdGxZHxL8Xl7i2OCjk9EkkgCO4hFtrQjHU5CHPfGX0jSbB7TDtEovDvPfcGWAztL7BDGNAxirk/HQuMLMKzCvW1ocvjibzpMw6g3Q79jS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=L7wGE5L9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="L7wGE5L9"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2589c26e3so89061475ad.1
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777229929; x=1777834729; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB6Hbopmj1bsEpilGJFpnKnIxbA9IIqkmL9MakC5PQE=;
        b=L7wGE5L92DE38MXGYggOc2hM7QxXBY1VzTspyZa8ORfPL1k+iGG2rtuz/XGE0vfytJ
         FupmvjEd7PJk9yGEQ+zMF6rpyQ2qxl586KmJbnDjDgvar2ud8SjK4LAKzcx/pu18jqIL
         2Q/AQjdPTiR7neuGp1k/MGIP9GSPVh9ee5CM1gOmDGck6HwNuQO1EpFlXtxYzvOdMuCq
         yO2HZ45mRsilsyuYNGQuUSBDHJuCnW6NK77VvneCXiDZ6YsOdPlleLvED8teF1TkH18F
         Sr64oWx2DXfeMWZpnllZ8IbdBa3nyUrZUZPxzGTASwyLaK1n2ySQxfKK9Vi1pfFoNdPe
         Gk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777229929; x=1777834729;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UB6Hbopmj1bsEpilGJFpnKnIxbA9IIqkmL9MakC5PQE=;
        b=UJQwoewG5IDepSyh7stHP/e9rkBvw/savL17h/MH32n+lkXIAv98CF3Uik9overdEI
         Vujwz8VbPSWve/ffthVK5tYYHXJUR5nEesYbiFmuq3uYkgHemtU4FyK0GesKnbDDm3ib
         veg4uOM9zF0koAcPf/Opjs/uTd86psqwNGwO2/2Y8V0iCbj3GH/bagGTcRldUgvIQk3K
         RJ0nMb5tkaIVXDSwE2u4UVmR24+vw7ZB7sbGZijzc+Ks453SP+bFIVcShG+92oGyXG+J
         o28xxZh8Ie4d2yEJtIqyy3SqsSBYWDiJW/St/VePkpw+xKqAupJ8RJRZKJw/J3Uc0AtM
         3WLg==
X-Gm-Message-State: AOJu0YyUFAHY/Hjqyd9SZnyMKCnJ4LCJ1XM/rNgkfdusE10RnlR2cVmW
	cdaSfPOi1aMPOVOqxZfbgxXT2bpEcmQGVKZvsnCWRy7JmctHAtETiC2gafXrcnXvi04=
X-Gm-Gg: AeBDieuVqFAy5mnkkHbfI0x+56uYqCUhX5auO6QD6dYaBtalVWNoEs4gb31Z0p8EZIW
	vgBF7kDi1z3MkWtL8Q3rNSQdAivhT2VgVsPD/I1Wv0MKpiJQbNPpGJFL9Wf9GMT6TkUo0cGpzPz
	+Zhn1k6r+HZSXi5jIpJJk2norsMQ5nUTnpvxcSUP/3wIbuN2r/JQNJ4+AfQCot3zWrIfvW4WQs3
	OJmfr4c/AcsI7kkvWkws/TYnk+V1Buq2lXXkZiUeMPkXTazM3doO4XVOygCoVaFYPodz20URkTw
	iTQvmIFxnXs/WstFtvi9LD0kIZyqHcvDeGEF6R07+r2LMsL+Xkbjsw/v6Nn5J7DiLd4UztPxSKf
	7jnrUamXHSEW2mzwSBWdYS1GRURvcK5UB59iUKD+/j89GbrqJgcwZgV+56SuQ2Mfkp1adtOm1j7
	g4mC2FsCa8o8co5VI32A==
X-Received: by 2002:a17:903:178e:b0:2b2:56bc:c6bc with SMTP id d9443c01a7336-2b5fa016e65mr447242805ad.40.1777229929094;
        Sun, 26 Apr 2026 11:58:49 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::2af6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa33486sm339723025ad.33.2026.04.26.11.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 11:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Apr 2026 14:58:48 -0400
Message-Id: <DI3BFHSQZ917.1Q6NYL1M4ZR67@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <song@kernel.org>
Subject: Re: [PATCH bpf-next v8 2/8] selftests/bpf: Add basic libarena
 scaffolding
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Matt Bobrowski"
 <mattbobrowski@google.com>, "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421165037.4736-1-emil@etsalapatis.com>
 <20260421165037.4736-3-emil@etsalapatis.com> <aenXSvDSN98azW_T@google.com>
 <DI3B2QZ8TA16.V0ZDKK2KS7MB@gmail.com>
In-Reply-To: <DI3B2QZ8TA16.V0ZDKK2KS7MB@gmail.com>

On Sun Apr 26, 2026 at 2:42 PM EDT, Alexei Starovoitov wrote:
> On Thu Apr 23, 2026 at 1:24 AM PDT, Matt Bobrowski wrote:
>>> +
>>> +int arena_fls(__u64 word)
>>> +{
>>> +	unsigned int num =3D 0;
>>> +
>>> +	if (!word)
>>> +		return 0;
>>> +
>>> +	if (word & 0xffffffff00000000ULL) {
>>> +		num +=3D 32;
>>> +		word >>=3D 32;
>>> +	}
>>> +
>>> +	if (word & 0xffff0000) {
>>> +		num +=3D 16;
>>> +		word >>=3D 16;
>>> +	}
>>> +
>>> +	if (word & 0xff00) {
>>> +		num +=3D 8;
>>> +		word >>=3D 8;
>>> +	}
>>> +
>>> +	if (word & 0xf0) {
>>> +		num +=3D 4;
>>> +		word >>=3D 4;
>>> +	}
>>> +
>>> +	if (word & 0xc) {
>>> +		num +=3D 2;
>>> +		word >>=3D 2;
>>> +	}
>>> +
>>> +	if (word & 0x2)
>>> +		num +=3D 1;
>>> +
>>> +	return num + 1;
>>> +}
>>
>> What's your reason for not using something like __builtin_clzll()
>> instead here, for example:
>>
>> int arena_fls(u64 word)
>> {
>> 	if (!word)
>> 		return 0;
>>
>> 	return 64 - __builtin_clzll(word);
>> }
>
> Great suggestion. If it works, let's adopt __builtin_*

Will do. Sending v9 right now.

