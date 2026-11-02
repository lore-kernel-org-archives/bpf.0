Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660398;
	b=TOv8nIq7BflZD7a4vE2bbSykmTMsQ/5Ad1m7kIy5rD5EyO5wMAvEE10267icDCCdyGtd
	 V5b45UGT353N2rrKE03PRC3i7cQDEL6FAEmwiFuJqGoiVn0Pzz7kjvLXo9kMge0diWtz4
	 zHgb4dRLBkqiJxABkzzQa422Gl9DloG6izvvncBZcbqgxlnSpg2fbgzRb7qWsBVM5todi
	 DmsQM+DDQD97mZmDF5MVjyh4WwvcYjQWnXUffpwWOD8XRdhsSZH9TxaguV3wGVPtliHhz
	 q1oY8io/jZZwneSgP9FhoGNaKNUykg/dvB2nEk/0hx4qlWuctgDawCK0IIaXXh7bVog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=mSbA3Np7prG/LtF2omesyGSao2TdcpAxnzOF1L1GEf8=;
	b=NCGKF9ZN86mEcQjKYL+/BRA3/vUQwLSxqbKXaI/nldQMdg5RHhdsjRVsoMA0kxZVafFX
	 69YldIxtALNgv6txuyDbZQFYZLKi9H1Bd9IETaWyhZAQJ2fRSkq8cjeMv4NOkrfAGXQIp
	 JcMhJ3yuDXzzK4dCK5Oa6wTdeodmG6mr2G+QCJaBBDVSnYSMmVEFFEQMLnEMNa9W2UN5j
	 RmXOqUuPjlktReqPCwKf5p4P2oHIYknm0sjj6cMb/j/xKsVQGExa8XLqMZDnKLQrfxzDH
	 fIZXAiXO52rm4d255/kpsnWs0H9Qkm/TVGxfrRzgY2+apjsLJ+ah/cTJU6dhHQfQh0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YZxx+17y;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11FC606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C11FC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YZxx+17y
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06c60065fso2470615b3a.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 14:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793660397; x=1794265197; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mSbA3Np7prG/LtF2omesyGSao2TdcpAxnzOF1L1GEf8=;
        b=YZxx+17y+gtG6qJNuBdcH6fYCfB0NKu3N93pn9EpoQkgg9/7T+6h2GamdfxsH2oiLb
         QdtRwJnwSePy4x50vc427XC6la2wzdhnS3VebF+3oVRAPmUkJxvMS39d5TC09oSNGfk/
         Dj+jTXDqef6xhvR0j9UWuuXhX+MCGc1wo2Eb6zQM3A41YorWNqresSapUS3sGyevB8uE
         O70qzUk5tCX+JqRMpBOdQuGFyeDV8VPIqCHk/amcg+fMrsTE4KrTh2gqEuYtalc8oUS/
         vB3SDKAXnsJU3puTVLuFg0GlsTM/5aaCdIN2dZImwVE6GQOtTib1u2yQgTccmF3Tqd6o
         7GcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660397; x=1794265197;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSbA3Np7prG/LtF2omesyGSao2TdcpAxnzOF1L1GEf8=;
        b=rDoRdRSydv3jBZzwTSl1fWoXLvG/f9kGypkagnhbJ3nLzSn2RJubOWKTt9s7psVdqz
         CJR23HXY9Be3wj/T4msPBNI3pNh9bEfMyTSUKHsPiTOBY1dreioQ7YAFOB2/obdhtwHZ
         3q+v2kTAIl6n6kJPmUJ+2XvUwg/89TlLZNtke9qYnGfR7ou6zQvZWCQyPU7jniSEhQ1g
         w2FhfGyrFoCk3Tb/59XwqyyW/qjhsp+IVHPnFAIwnTZl0qwitp/+CbJjORhgOIQHAexr
         WNkCcBblCOTqaaUR/v+mn0SEYgL3+/0XYRc0/sH11biFomiRRz10Znme/5QqO1OX9s6D
         kPoA==
X-Forwarded-Encrypted: i=1; AKwUvBx0odoYqAaXDNM6Xs/Q6+85haOJOPSZHb+2LEqQzQRJsnk8/q5S6kewodkZqmgOPs++UHM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vfE2ltLinyyKBoRqGS5+xE1cJf2TuQAwAfs+DNOKh1x0KiREP
	rGYaruwyNnIysSFuTbHEw5jf/WKoFLZiMYsI/0vCu+f7ArO29TiumA/F
X-Gm-Gg: AYBFou3u0V5nMP5jzldrDZlG/AAnFij5kyGl3bqMbioSBjd/I3uIz4MQaB2JkD8dvk0
	TtE/yYXP6DkxHENJUeGd7K0tXW0U9X1xjHd868Lmu7vRk8xJ01jhhEGbzxhtlc3EUqwkpqkdyK+
	mdu+MVnudowiESEmwMB/Ik23fl9zjPheLZtuSBu8yV1/qTRbthLL3HSUatoPFHui6bjvZChlFQS
	aKJ71EN8PSk+HsIk4uzyMN1r80xRRdLtNIx/0q51NnLqy7N00ikxRHntuy6umIRGuaYWi0Ry5tN
	xjlrcjIleTcpUGQVO8LDJKRzoLDiEUPWRgSxRExRCJDjpcKvqfawe4oZtUnCG2CF6z84XV8htH0
	IYI5i9RwGUpC6yWbF5Zy9hUR9+OI3jbJU6At0g1zoOckhNwh2UCQ3debshKbGPAZYODEJG6bhv9
	LGUlizY24rA3LyDKm+Rcx0yULxguz963m59eQQZNGNBtSHebZge7j0DEtR87tLQTyOsi87Uh3TY
	9SkM7kBh2PFng+Pvpx85zYei9b/lUtwdjoZAOsw1c9UE1iJIO1BVmxj8u9cQH+VmfA4qqCQOGxz
	EmPHuWKw8HtGYANXynm1vKSPxM98d12F7V1TPOaXO2c2TrTSrZHt3al71qal+Nl6QTAT0eCXkuI
	ObotGVBSn0SUOjxqoOXQPl/X3QgqWMIZQsvhC68KNub3mLjcX5s7x2NA=
X-Received: by 2002:a05:6a00:328a:b0:874:705d:f64e with SMTP id d2e1a72fcca58-8a9bd6d8c70mr8396250b3a.28.1793660397043;
        Mon, 02 Nov 2026 14:59:57 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fcb8dsm2559419b3a.1.2026.11.02.14.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:59:56 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:59:56 +0000
Message-Id: <DML3JMOQUG5P.3GC0YYOFF5Z2P@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: add arena fault recovery tests
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261028015141.10710-3-emil@etsalapatis.com>
References: <20261028015141.10710-1-emil@etsalapatis.com> <20261028015141.10710-3-emil@etsalapatis.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 27, 2026 at 06:51 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
>  .../testing/selftests/bpf/test_kmods/Makefile |  2 +-
>  .../bpf/test_kmods/bpf_test_arena_fault.c     | 55 +++++++++++
>  .../bpf/test_kmods/bpf_test_arena_fault.h     | 10 ++
>  7 files changed, 230 insertions(+), 2 deletions(-)

in addition to what sashiko found...

No new kmods pls.
We already have a bunch.

imo bpf-next is fine for this bug.

