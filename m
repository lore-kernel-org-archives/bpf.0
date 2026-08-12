Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4139A047
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786578615; cv=none; b=fjWSq+88pfGmxjMj4G0wfOTSJLbx8ieAPExaNNbtwZbFv1qskeqduFCGIpFrPiXS0kOcHgeCNzzdUaklQ15wVaN5G7jEAVfNw2EutA8UVLrzePOYc/dTIE3Q6+TXaVn6SlQtuVsvSDG1P8d6p0NRWlAYSIXLeUK6W6O9VnpvEUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786578615; c=relaxed/simple;
	bh=rMyxTMIrx9BRSNRs//okHjjPDwmSPV3B2p+iIsA539Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=AgRIG2/mYdRyVsIGKOYkIbQXQv3p77wIWJeGNHUvnD7erNgaTxagfKyb3wCWSb8M1a7JBOFlw9rp7tA3RRvr3E77+Zoqg9Lj+ni8YQfxaE21OlIS2YbAWxrCPwQX4xgcZf683VyMSfkLwDqoofIcNv16Dmc+Uqjzkdp8jIq+MAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYkaQtpP; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYkaQtpP"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-481512c85ffso599218f8f.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786578612; x=1787183412; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rMyxTMIrx9BRSNRs//okHjjPDwmSPV3B2p+iIsA539Y=;
        b=kYkaQtpPLKR7Kbx+bQe2UXQBhYteN2NgX6t6yWbs6hAxwZHVrBXeZQiN4BhpNE2eCx
         Db0nBvOOYA87vA8ZoghdUKi+DbApM7aXw6Fas6xr2lH8mVTdqt/L/1zVh4fihbiZMDxM
         Vil2FyUh610t3eqgxptH2JWffxgAa/0F7IhKXj5o4PXu8aGHxbrlmkEX7v1ch7TYMBUw
         pPGasU4bvRgBHL7eDunewkksQDZmRuPVfViPRf6TJZ2ZJ8/jHwFBaKOoVf/J3Ylw2hwD
         l7WJtfFEL0teYuAQIgvoPaJIyl6ZAZLu8+lr5QnSsBbk1xfaArV0IoAmzlz255dTkHsG
         /Hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786578612; x=1787183412;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rMyxTMIrx9BRSNRs//okHjjPDwmSPV3B2p+iIsA539Y=;
        b=r7T1EHwYhtihUGwExGgesIr3x4jfd0Od7lv7TPinv+t5V4mrOyORND27ObAil1R0tS
         oIuvhXgKKW8aQjv+GErIVAh5bteLMLoZzMFXD5Du0RQ8tIdCOeLJTQf+cYEzK2X87kcv
         jpEylQx/Olu0xMyRTSAQn4Xs1++ao4cL8weqxK6yoyYmSv90H4IR8vT2UIeN+2RnEF5b
         /fA9PQT2feJ+1Vn2Zm7elmgZjobzoKXOgzY3WkW1suFgA1KQXiDlDH5vPzZEZnmJB0TX
         lakJuQ7At9rZGydwvymPxgdAKy/J6VfIZAxdKH97bqveby0PYSf8Sz5jKnbJFS5ltBKM
         CoVw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4VsUkRTJeQ/8mWsD3hm/CEs2R2qtVY8egwXfXhG+OZVdvYkyKen9I34tZLCcj5iInD2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcf2ieHMPRvxzp8ej0Xg6LV4CXm7674PXGDyMNsAtkStd4UgnO
	Gx4pKDdbhGLT3s+OA6d787O3WAOW4Qa0Pg0RqfBjtdelhqhYmON6ideV
X-Gm-Gg: AR+sD11T0UeJ3oKMJ6tBOcyDWWcKr76CqsOMOZJc/E6Qxc8nSLrw3nN3hgp69karHLN
	dzBBozc3xd4QF2tG0+IDK8T9WcxpyPIhZsS9pYlHyfAEi8coxrXAZKtTFZ7eUPJ2yosmSbpYXWY
	gjK5fd05h8+gAWnOwh5WRgvGVVq7RDeRtnCDwyemhsQ+3ezttUvnpzYrI3rTHOT/Cnv2TMiQF9F
	cH8zJKzCdy82iNpJeyGV5oxO36Uhgz+v/MnUinT+OyVMfAI1+R/13Oj6KtYMSgz67aad/2gUiGY
	+sWUVLuzA93rovPoi+BlTukOgO/L7IGaOffAOkLy6t60UX6ttD5qPX/D92n8Zj6x7MOLq9q7ETr
	5GycxuO2lHUXDC23M7YnxBFXwkyM6eRYQGCbmXeGeiqBeNWUAeOKWmCtephZ5DX7Bzv1YowNqNn
	/0BwoM+ZgIujkRAB2Abu0NkKes9/UE89IlRLvY0jp/qih9XNxDG2CuApGN/vyl8UX68BFCo6SnV
	ER7xC+lvbdETI4mq2AaclNpkbQY8LIHxYd6u3TDXeAb0V2Y4FBUQ7f+6QgDcEs0kwDwZ70PDQUK
	48zHHI6qi6ce31WVcmxTwhHM4sE=
X-Received: by 2002:a05:6000:186d:b0:47f:f1ab:9075 with SMTP id ffacd0b85a97d-48159fede51mr2098519f8f.20.1786578611707;
        Wed, 12 Aug 2026 16:50:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6c2dsm1213562f8f.26.2026.08.12.16.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 16:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 01:50:10 +0200
Message-Id: <DKND9FBAR1JE.3713OP933LYT3@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>, "Xu
 Kuohai" <xukuohai@huaweicloud.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>
Subject: Re: [PATCH bpf-next 0/7] bpf, arm64: __arena kfunc and struct_ops
 arguments
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260810190922.3408757-1-puranjay@kernel.org>
In-Reply-To: <20260810190922.3408757-1-puranjay@kernel.org>

On Mon Aug 10, 2026 at 9:09 PM CEST, Puranjay Mohan wrote:
> The x86-64 JIT recently gained support for the __arena and
> __arena__nullable argument suffixes on kfuncs and struct_ops stubs. This
> adds the arm64 side and flips bpf_jit_supports_arena_args() on, so the
> verifier stops rejecting these programs on arm64.
>

Hi Xu,

If you have cycles this week, could you take a look at these changes and le=
t us
know they make sense?

It would allow us to close both x86 support (already landed) and arm64 supp=
ort
for arena arguments for next merge window (next week). No worries if you ne=
ed
more time to go through these though. Just bumping the thread.

Thanks!

> [...]
