Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A53BB48
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 04:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077924; cv=none; b=MSv8NdffLxByIwpRxY+PZBTad1ALgjn2zUaDiq+ny4cE/cc2cZYYNDHB13i775Ur1ZJY36uETWUmN+dUshwwK6OVeYl9R41Oagy94vjzlVbcEyIZZqkHB1oBI9I7rnYLeAQU39skfQ35G5dXldgD2T19FwRdNLn8gBoXZoXo0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077924; c=relaxed/simple;
	bh=AmXjR5iJkJmOCDeoBi4nu+pYBIwZwJVUj4l3cAz6uec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jt5okf2scmq+tvJqjKfpgWJ9lTJX7B+EUDBbHrW2Wwm2YahQroDHHGv8k+3G6G0Ci7mBwPWkZNMkbD58/zDCK/tICtOE7H1bqqvpzqBpFK7qCzZl1IR7L5NNhuZDNfWnMQaw3xUjVz8vq0RFug5nb+Dj51KgWKScRQCEY5CsS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh0u4qqf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh0u4qqf"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cad8076b01so36083585ad.2
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 21:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786077923; x=1786682723; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AmXjR5iJkJmOCDeoBi4nu+pYBIwZwJVUj4l3cAz6uec=;
        b=Dh0u4qqfhAF7WoBWs3bVCALNyJkaYqaSDW+4XQKNk7EjTzSLG/62S0LCwEBGzwV3DK
         OEJEzanwD5leLcRQgrmTgSMbXqhcGzvkBRv9asXgboMAdXPgUwmH/ZjiKKisxNy0Gw/k
         b+AQPQYOGlj9L+SKUy5193mFKO98p+AgJwWTts+Lkxldb8uiYOS5ZtkRa4NnHGZB380F
         TkTJk881w305g2FfNeg+2/q2Pzy0PRXi176m8JAVIsjlCfrVZ3Lq/sFLfJlfHnxX1Qxl
         UOk8H+Gc/22a7np8VcvVgUvsh2Y73uXNIxbXwr5HOOrJ3wo0WgR4mN9ctnmqdmRH0Vmm
         M2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786077923; x=1786682723;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AmXjR5iJkJmOCDeoBi4nu+pYBIwZwJVUj4l3cAz6uec=;
        b=U0nQ1TH2MZ1X77tR8a+28NbiVngPXd7Gos6j1CGQYZ/KIAdE6t84RTEWFGnUNbaCtd
         niipBnqXJwyprWLu7+iEbhGGkOJPqrY+CTkwwqy2C2Ka7q53gYGKqA3C6ztUfGd3j/ok
         Pt/wVSQ94XCJQtlqmNSV+jR7X/sV0PZOcyG/xnq8W7/ZYPifV5MFo9OJc/d+XlLEF+bz
         XfbNMsuA5AWVpSrfOncHML7CMtpA2ZFCl9asGdpUuYIbp7N4uwzaLC7jx0eggPqMtDu+
         0ROb4oEXbskqPVFNPFZRsmmx/pXdQkO56dUYmw3sFT3IxTn18p3xkMiBTvoooxlktio/
         ZiQg==
X-Forwarded-Encrypted: i=1; AHgh+RrsuA8Dz1rVUBS1fmAqAtrt0ct9Vt47es9cd7daVvNx3uRavcc/bh+vJoiXq3bRrLKMH38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDPC7A5v1WtX2m4O256vpgr57jvMATuKl/Ih8VYsiUHp6v7paP
	9m1+ybNesWzp+QPcrjxsIstUgICyFAIVwm54IU1dKVE5mu/Vu2X6QvA8
X-Gm-Gg: AR+sD11mkCSYBHSdDrIJ8g+Ny1JeQClPjAhqHj8Vbd8AixmfX/GcNTHBcC4jR5g8Y0v
	xoux115VHoCB7JM2EmBMobsk5KloCknuyFis5vW4R1xpemxO7OV0/bmTTlhmGPlRKKG1f21LXu7
	4IiwBcDymioptH1/3QDvMbVCJfjxK0JFBjKXI+3hdVq+3+EVyOEOxPKC4Knet7VnJWsp5Zcb6/N
	KHkOSJOa2IYqkoEE32myu+bhuilNv3P7segSiibDjHZn/E3IAThJ4/ul3mSoNhVBJLCrxv7FYoa
	GO0vGOZnG91fn99FEvXzyHr7u3XR8teYOJ0ejl5qya0kbEYmeq91AsWuo6ewEhF/fEu5c0H6vbT
	v1PyGoxF/pKJ5imCJy/I2Wq4CatQT+M1HPtCm8NPiy/DxlvjLbn46YFzKdxeju7lWoaflWbUGM/
	iICOJepXri9QEP15HMRFr9MQmNaMwWt2bOjt2COJfnHy6prWBM3F8blzz4nucr5FkLa1szzmzJm
	0ygThxD5HnY0Ih6
X-Received: by 2002:a17:903:4688:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2d0ca7fbc9amr254412675ad.10.1786077922926;
        Thu, 06 Aug 2026 21:45:22 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14cce783bsm2777085ad.27.2026.08.06.21.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:45:22 -0700 (PDT)
Message-ID: <17e71bf8e2a7e38a2309eb81b88953becd6cc1e6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 09/13] selftests/bpf: Add JIT-sequence tests
 for __arena kfunc arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis	 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 06 Aug 2026 21:45:19 -0700
In-Reply-To: <20260805210427.3218326-10-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
	 <20260805210427.3218326-10-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 23:04 +0200, Kumar Kartikeya Dwivedi wrote:
> From: Tejun Heo <tj@kernel.org>
>=20
> Pin the exact rebase sequences the JITs emit for __arena and
> __arena__nullable kfunc arguments with __jited assertions on x86-64: the
> unconditional truncate-and-add, the nullable test-and-skip variant, and
> all five argument registers in one call, which also covers the
> REX-prefixed encoding of r8 on x86. The capture kfuncs take the argument
> without dereferencing, so only the emitted code is under test. The
> tests skip without LLVM disassembler support.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
