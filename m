Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435F39183C
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140735; cv=none; b=HGp9KMmZUdB07pPBjpEKCO52WbsDjJsLSXq+zoEiR9lzfnSjqx9KaMTXNYPp1ov0CFISVsZNCdUkYUGUNmDpW0H6kuVLHIA+4gQl3jyizt/vRo5FLhR+VaGV0SbsRL/sExvyqXolzlQ7yJ3MmoLOnPXwyIZSVGly4Z7kB3X8GDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140735; c=relaxed/simple;
	bh=RPzx9L0BnKPgVmuB4NUCp8chjlgAoHpIEzMFHtSn3PQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VN5f3fyZIbWBFgkJFCtCY6BFudcvhsE8EcNZ4L3FsFeVXJNq6tWozol1m1aKIhI31p0TgPPKnl5V/xs6KgkRYz8YOgNhuK5/wQ/kzPLXbrnBlnfyKh+tv7z4Z6V/9tKESvTESGD53bxsoaG2m1R1zajwCeWV9oFDrla+N2p/VaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUjr5B6m; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUjr5B6m"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf52d15d88so631605ad.2
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140731; x=1786745531; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RPzx9L0BnKPgVmuB4NUCp8chjlgAoHpIEzMFHtSn3PQ=;
        b=IUjr5B6mCQpSLSoT772M/oV2HYZ93uX0ndqo5f9LaBrYNSt0NY3sseJF5+vWD+5xwB
         muKL3N2BjbVFC4DV9j3guBd0d2H1ZxBt0yD7gb7XDLG+YSiWX0zAi1ROqxwE75FXhJLV
         zZUTzLDwTU+j0CHt18r/ALRmnnksymzCTaGmONCAc754pnKm23QC0AfE1xav7HP4gEOC
         xCcXrge7YlgTFxaDltSbfVs+b4zzRuwWC4xnnLBevfM5IDOMOQyTxZ2KuRtSXn9FzoW5
         qLifJbg3J9FBJ7asUYaXP6farL6T8Lm11U+vwPCIMnEOy2QqjPFqDGLLrTXij8etLso6
         xhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140731; x=1786745531;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPzx9L0BnKPgVmuB4NUCp8chjlgAoHpIEzMFHtSn3PQ=;
        b=Ts1UGZbpz0d8/FUVeDCZOxMD5DUyrsa34I8sfHs4gEOsKtEknsfGI6BBIXtXlupXmB
         EFrWTCc/5Vw0uOGbJOUtBwkD7gLc362SiWXqiHeNFaeJ/RgvN7/vCbkgmB+BlDLRHtkQ
         xAAtdi4tvAfWdQT1dqtwP7PzPNPDwq1Z3TL6TT+FM+1DFbo1ncMGSMqc+AqcD0KtF2lb
         ZEXdDaRiHhzjRpOby/jQNGgmWt1YNJb01QgN6fwi4n33CcvFJRVgw5LCVare+kFIQRYM
         FDEMIbJvOL5TJnx1VjNytE8mzQWCUwALcv6D/5LoBRYZl7ehQ7oL9+Um1Muauei/oOON
         GYeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrc6sZr8zI26Ww0chgFHhle1hl5E4ZOIwG9eiMNtTp+NRJKuL8IuClf6hUO1MzDroxUs8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvKgfaJ3SpqfmmYUD7R1CeMFeM3kxuYk/RLOBVk1vrmAXdVBhk
	QD7eQKpOV5UAEtr/VjK7uuzb0nVHiJ7E9oYkhGzDJx7ut/2dg5zehmx6
X-Gm-Gg: AR+sD10+hfUxTs7uQLG5R0t7EHlZFpK9LpzcYY1kFrPUdSBJhBdJ9gGF1Z0+2tnEG3B
	q6a2hY3wTYScuklUfyej6KHbnl0lpQW+Cll5WTXUIRjLxeoF/vhv6P7IHWsIJSh/sNVK0e6eKnw
	aw6W2WCyowAaE2GCRCU+vS24eUwD7o/WljruTTR+Vo2kRmuLQnwyliTrtI4cVuKW3SfRo5kXbj2
	pfcKR2xZRWXCuoqHBuLoocoVsKcYyQLt3yfa2OBfF4FITPHTqcjsde9klht1GYaW9k1C8+HaHTY
	eS8iQecbUkC/D4LYpkN26664tsWKvCQSQ7Ll7GGcMT5WxJrEI4H2YGNGCJTfDLFPHhSUINbrO/m
	HmRv5i8LH6y2KzvOvA2JrqXBCrSLxicA6vrv5YeRz4GXdvhGGSP/IA+3ioTCRr2XZfF/Hy7Vwb0
	gNy3GmAiHWJycalHKONpkYbFaKo8M01j+jSOP2TqRX48kNx9E2mGzuSnwX5wbAKvT4ZQ+xfuiOJ
	IIzDjUkYu4oIZZ/YG6uEIOi1dDoMP8sYhShleI+ZpJNqw==
X-Received: by 2002:a17:902:ebc2:b0:2cc:d69a:354a with SMTP id d9443c01a7336-2d2a8eb76e2mr51540085ad.22.1786140730699;
        Fri, 07 Aug 2026 15:12:10 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:458f:c226:a861:4dbb? ([2620:10d:c090:500::5:1cba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86e917sm13225285eec.5.2026.08.07.15.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:12:10 -0700 (PDT)
Message-ID: <9a9d9261c44d23a72cb428e4dfd69f671daf589c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 2/6] bpf: Propagate async callback
 instructions to scheduling subprograms
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>,  Emil Tsalapatis <emil@etsalapatis.com>,
 kkd@meta.com, kernel-team@meta.com
Date: Fri, 07 Aug 2026 15:12:08 -0700
In-Reply-To: <CAEf4BzbX+PDV-uM2qLAh_K0e55oDnhbfRiEd0bFvEmyXfF6Dhw@mail.gmail.com>
References: <20260805011517.1717238-1-memxor@gmail.com>
	 <20260805011517.1717238-3-memxor@gmail.com>
	 <952a9aa9e0e8d0e8bbcf54dda79b1b88ff48e1ff.camel@gmail.com>
	 <CAEf4BzbX+PDV-uM2qLAh_K0e55oDnhbfRiEd0bFvEmyXfF6Dhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-07 at 15:05 -0700, Andrii Nakryiko wrote:

...

> btw, does anyone remember why we "detach" async cb?

I think we just try model the program behavior, don't think there is
any other reason (except for allowing more stack/call depth).

...
