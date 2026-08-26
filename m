Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8B4260565
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787707331; cv=none; b=D5prE49upBVGWUVIb/58+Ya1KS8Ca5eEPYT1e9Ec/MpZXAd8IuKV2gOcMaOiCAngCJ3Tt6NUUKdBFWCT+K3Fz1+WG5qXDMkBwnYtKRUq3Y06ti4s6XN1fVsUnw18Vo5seSp7TwAAd5Ou5Lw4ScNFkJY8qVAfrt4HS2p3tdxELKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787707331; c=relaxed/simple;
	bh=eWmsP8/duMgZOhQwQ6HLfSt5fYqzsTaL20iUEBH7/4g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AqGVvcCOoIrJOUQ5gcJ8z2nMiq+bk4AnbcyT01CpwcaBSFLEPdsKou3K5VCu4fo9C8FXIYGjNyoYQw8Pi/UbIhYcAAGw5sCgmX+AcPUW7e7KeVDfLOThkRDlfSLd6kJo2kl3pRwaI2eeuZ8ZpjLGi61t/XUjUT0TcszlLb4TYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+Q8yuRW; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+Q8yuRW"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f3f52143cdso382245a34.2
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 18:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787707329; x=1788312129; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eWmsP8/duMgZOhQwQ6HLfSt5fYqzsTaL20iUEBH7/4g=;
        b=r+Q8yuRWmZVEt2cSJCmqZioW5I/1PMi76ZlZ0kLuGWfbQ0hFevNlf10JjnpU4KNSI2
         kBNXSlmd9YPtIZVDQwAC9XheAMk0QqVk3uYbePy8gXHSiSE70aNtfSdwmsd3p9PWl2uE
         Hh6wsslI3GxnfYol8Rs/o1iwqQllzUoZ7tLjVnLkAyOXW0OFWukX6kpyCdhkbI18w8wt
         HsI5EgO1AZhU9IZdEb2bJoyH+zRO7fi2vIHeoKMj+HCMm0r/GFYDQBiisIeR1iihNYoa
         8nNstgcRt5n437nzsrZZ6u9dQqdQs1yc+T+THmiRqQCiWfDHaVvXKh3G9MJC3nhCT6m7
         2afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787707329; x=1788312129;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWmsP8/duMgZOhQwQ6HLfSt5fYqzsTaL20iUEBH7/4g=;
        b=Gcg7VeEB8pAWg9M5vpA2aZmT0SaSA6YRfK7iWbGJc2gx1qjKYUQ6FQ9/2dcGavRgtU
         arPCtwGzr28lCYWTHhcEHr3I7xj4QRbc4KuIK9u5Ilc14/v+74ijesKIa8zIRHD0FtyJ
         Y7ZbeBfWagrXrJ3WoE7tdTp7GE/QZw6r6H/71NWEFABynuKhrOw6A/rwWHb8o1gmYiNU
         W0YhLRBJAunxMDN2NfNOT+98KJtlhU0la6S/WItrQTYSBSO6+0qTFAZCpXb46/vICfwz
         PJTHDq5o1UBofhUXBPNd9+fatBG1j1Ye7srIP9TgQvlxhccMSrNCZ2hBttFf/4R6BJ3T
         d3tg==
X-Gm-Message-State: AFuF++l3x7QXlo0GoKGUMNxvs5+Xpr2udfsOyTUKL9b+CN8e0mN58EB+
	cKEPGKXBfSw8ierrKaCUhSXx3qqmWHeBo+CL313uPyPLkKyac07LQufE
X-Gm-Gg: AR+sD10L34YIzMdc2T3X9IJ5ukdknvh+nQWIZXzjyQmdlpMkVqTeIu06J2GGwKr5GH3
	BZInOajOY+x2u9Sr2I3q/Sd/+tq/lGK2ohJEOjBBmQsFtTdkwH0ICxHaMCynnGuIsctZWoNnVyB
	OjoeS6aPPVBioN6kUNNLOwxtYY53BS76yvB9Try5IOKMURz6GqPc23TDaI5UyQh1dcnCAUVAzfe
	Nti25N6fJf7jKSQbfbS7V7Lvi2+pCpjz1DeZfo4VY5autpG7PMBGdLd5ug2TPZIVPjm1lz2QJ9k
	0EogZCAWqZcWbmYX6aqDOlNF3nLQNLIbdTCEbIEAED32a6pMU4jPkTphnrWSyV39GfaH1IUjKSB
	PIk7m9R1JRUZaBF9tfimsNvFZWDM5b2ITHHo08BOpif/mM+i/EUYODjdSyfDm//6OoN6Xbj4vnt
	pchX/avvgWx8e6seOh2DpnFC9YfNyOXBna0KuGR/Bg/OyuR71FKRobpTJEdanfp6BLe9asC53Zz
	djs2o+xIXsSMA03kkmYsi/XrWy1aBrfvRcihebfj6xNbGUJQn/8Q3s=
X-Received: by 2002:a05:6820:4c12:b0:6aa:c3f3:fbb0 with SMTP id 006d021491bc7-6b1a0522f54mr3493815eaf.32.1787707329410;
        Tue, 25 Aug 2026 18:22:09 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:12::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4c8413ba3sm415340a34.20.2026.08.25.18.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 18:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 18:22:08 -0700
Message-Id: <DKYHCWYCB5XV.3MSN6ZJGOW2R7@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf, x86: Sign-extend narrow signed kfunc returns
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: =?utf-8?q?J=C3=A9r=C3=A9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>
X-Mailer: aerc
References: <20260823203944.2084994-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260823203944.2084994-2-Jeremy.Jean@oss.cyber.gouv.fr>

On Sun Aug 23, 2026 at 1:39 PM PDT, J=C3=A9r=C3=A9my Jean wrote:
> bpf_res_spin_lock() returns a 32-bit int. On failure, the verifier
> models R0 as a signed 64-bit value in [-MAX_ERRNO, -1].
>
> On x86-64, returning -EDEADLK writes 0xffffffdd to EAX and clears the
> upper half of RAX. Since the JIT leaves the native return value as-is,
> BPF sees 0x00000000ffffffdd instead of the sign-extended
> 0xffffffffffffffdd. A 64-bit signed comparison therefore treats the
> value as positive, while the verifier treats it as -35.
>
> As a result, a signed comparison against zero can take one path during
> verification and another at run time. With rqspinlock aliases, this can
> lead to unmatched bpf_res_spin_unlock() calls, corrupting the per-CPU
> rqspinlock state and unbalancing the preemption count.

Is that a theory? I'm pretty sure we have selftests for negative
error codes from res_spin_lock.
Pls craft a selftest if the issue is real.

pw-bot: cr
