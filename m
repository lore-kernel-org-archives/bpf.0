Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74649494A1C
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028492; cv=none; b=OuSCAkmKOiSiujdXikF0nPUj+4or0wmhLHld+qTpIdEXyRCC2FTTGG8j4ESzaVqedkcaVDmp4CNYtSm+8ZWDJ8t5QGJ7UNldoO2Xvaso9KkwVxYyzIXgy9k1L5k2FKsXl3/BcWwUYqQPj14e55yDWiTyJYCUbeo8/Yz5OSxArSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028492; c=relaxed/simple;
	bh=Gv80fVqWANIxq7l0YC2ixWxD6mTMoOIRWTXH5qo9db8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T4L37jrjhbTW92X+s15AYg+LGuj7B84aPFUdSeJmrO4/txvihX0rNlRV7ZItbMINIweTRAVld3ytIpYktDjiCZm/B/TeIGrdUMxnNoADIQNkCLMhHs7jo1OcSdfgeggFAeNWHqBeX1JjcHw7mLPNY/OyIutGIxIE5nPq7FgcvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjfeRmBS; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjfeRmBS"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43d34292872so2802680fac.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781028488; x=1781633288; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv80fVqWANIxq7l0YC2ixWxD6mTMoOIRWTXH5qo9db8=;
        b=WjfeRmBScytQ3/XGA+uEp5gGleIrf9mA6YT9zXK5ifIv7kMi/Z0AFGO7A4W0Ix7MoK
         FhwZIDBwgitxzGvj+fCE2Aoc5QHrFwqoPV9cf26L0YrZuyekKLaqSf5gYBkThJFyxqIW
         9dd/km+20W/0SyYVWVcf2P+0R/NzZeCB74BstfCr1TA/csXIbH9Ly4i6cKzMgimx/9do
         ACgOsJgSPr1CiOjmbQWtG9cUIXsz4ofZ/BJhCzzPAn1lhULSsK9F/ZYy2luBJuzSIApH
         tpXA7gjpza5yaNmuW9dny/rhdI9xaX2MQmERyS6qmyNiNPx7i0kNmH3uROfpdxivv2Wv
         jQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781028488; x=1781633288;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gv80fVqWANIxq7l0YC2ixWxD6mTMoOIRWTXH5qo9db8=;
        b=Fyes8WbjDBSX2pOCXRnY5vRbtGUuxr4C/Ta9d+hpQr2bnzFBQPWNZM/szJcDTKeiSy
         nEWelxFcY6ZUUEvxYruSDMppEbzL1DwNs/62zqqfIWfihWcJwTAEYhfKwg7eKXX3+ow1
         sLDx3sk2TZvh1jttWF+lz15Xt35J0cLfLauXPDxRXvuELcRVKsaCerpqSl8PTVCeKIoB
         ayUG6klZCwlktLEsBRdVkoTd9wlJ7UDN7KnExU42z9t71LPe0TY6QHFTCLlk23/K6dw1
         LGIUFbAD8/FPmBRRUPex8BsmNWcFWv/wqATgY0agCEnwIxwjKcGkTlIelbKZderMyu14
         LYwg==
X-Forwarded-Encrypted: i=1; AFNElJ/uKPFOpZQyud8JZ1huB3AkezcRq5i/VhJILU6roqXf1gS+904tl3nFU90v+VqCXsvagsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkecbKUXruWiaFSGkt+XP/Uo81ubFJaLOAn0xBGl2lWVDy4py
	wL6Pt1n8E+KQv3WFegFj9lWfxJuetN2yaNo5NAqYeQWeSird/3SFo4I3
X-Gm-Gg: Acq92OGTNCEvo47V2n9VcDBnlO93XFrGLny1baDsKZJLM3qHCaLQPAg3Ri713t4zfOd
	nww5mYrGRo6YQ0iw0+x/gHypt9kkQkXYGc9oGORNq76jhLo6WbD8bsFXOCBJKVnRcXsWQNLVeab
	ORNfWnLB8E/dIIkXAzmGqrzfj3JKmgttv7nrl7nHUq3ZE0suzwR7IFxVEcvvu/pSLSutM+fK2NE
	jbQy6Bqf1elKzN3XSTYCMpnwvC8BOdyKnddL2fHNgPKw0WJP9v3qozjP6QgzdmrlTsn/bV2OLvP
	TM8q+SS6jK6/qG0bRgGG6xIu0gJBAEk8CyvnBqjMK8e8D8kxIi0wK1UaoZQsGRsZqlkuIZzM/vZ
	8xu2cOLeqH1LRFJwgcNMRZg7zzMk+/clgW/UC8rj1w68bc1YydwWLQ33bnJRjVU40bYP/9WTSjV
	CADYQj1A3oF/rEDjf2ynaPBFDKhkn5SzM9g0QRGrLnNXazRay9EbOOtkJQkXpyjthx2x/h+jc+2
	fATGbyKHsZpuwkVC7aUtMJcU9Hd
X-Received: by 2002:a05:6870:c69d:b0:41c:3225:f98e with SMTP id 586e51a60fabf-4413d6b0988mr11892044fac.2.1781028488224;
        Tue, 09 Jun 2026 11:08:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8465e00sm16402950fac.15.2026.06.09.11.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 11:08:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 11:08:06 -0700
Message-Id: <DJ4PWNJMKALZ.DY46EM9P97GA@gmail.com>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <houtao1@huawei.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] selftests/bpf: Add BTF repeated field count
 overflow test
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Paul Moses" <p@1g4.org>,
 <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <SzebdWqm2zREZBf8Tc5Kc-JDWbh9nBztnk4PUu5kRSD1OOdr_ESVTt__2Hd3-lClr47jIjJCXfOH0RHsMpjjpEUh_R2v30nh3T1IXNT6Pbo=@1g4.org> <c51441fb2fa48d604818dffa59b7009f396fa0d3.camel@gmail.com>
In-Reply-To: <c51441fb2fa48d604818dffa59b7009f396fa0d3.camel@gmail.com>

On Tue Jun 9, 2026 at 9:47 AM PDT, Eduard Zingerman wrote:
> On Tue, 2026-06-09 at 11:37 +0000, Paul Moses wrote:
>> From 7129e266643883a4f83e65fce3ce20c7f7269fb3 Mon Sep 17 00:00:00 2001
>> From: Paul Moses <p@1g4.org>
>> Date: Tue, 9 Jun 2026 05:08:54 -0500
>> Subject: [PATCH bpf] selftests/bpf: Add BTF repeated field count overflo=
w test
>>=20
>> Add a raw BTF test that exercises repeated special-field expansion with =
a
>> large array count. The compact element layout keeps the array byte size
>> representable while the repeated field count overflows the old u32 capac=
ity
>> calculation in btf_repeat_fields().
>>=20
>> Signed-off-by: Paul Moses <p@1g4.org>
>> ---
>
> Note that this selftest is depending on a fix:
> https://lore.kernel.org/bpf/DJ4DWMO4HXCM.3NVLDGNT2704E@gmail.com/T/#t
> W/o the fix KASAN warning is reported when executing the test.
>
> Tested-by: Eduard Zingerman <eddyz87@gmail.com>

Pls resubmit both together.

pw-bot: cr

