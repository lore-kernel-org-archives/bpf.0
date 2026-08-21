Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF23E9C29
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787338902; cv=pass; b=OGe9nlB6+anWNAihlE7dbGwydmLBRjuHC2RXYr5OcYlKgJsDh/+UJw4H3805abayIJJK2yS4oAJbHRYTzMdyAjin0Rvv2kt2HElC931HpsjA+8xI8m8iNTfIeG6lZjvCoS7akVn9XYzhlvQAi5wdEguPU5inltQetsPKROQ0l0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787338902; c=relaxed/simple;
	bh=KUZeMo7shoPylg24U5wxGwv6v8UB+b7bcEQAIWDFH1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JB31qbYFCpZj2NAgHt/r114CCb9b8fG0PrIhZroLZ3Z31mqiQ5kNmHS4lg+/hllDXMlMNtrKeoK/+KgdNZb3ucSoab3rvhWAj44kUYByD8BzOTtytO0d5lE0pWbPXYhV1TuIRhPJ1MpxbvBPC1BaImssNWH/YL9e+lseIBICPsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHygJJ08; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHygJJ08"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c197e7e4e94so252903866b.2
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 12:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787338900; cv=none;
        d=google.com; s=arc-20260327;
        b=q1wHhR0BQNd00unDGOq1qETwKOwvz2d7Tr9T98G4iVpwG56IxDcyXVhwUMtsLCneeq
         Ak3oPvfnEjKKzoGfEZ+w30TK9ToeIEiOTft3OjsDfZ/j3rBCAKGaNA+j9JfaG2arZFWP
         E6IlxT95WGhzbzLcwlkfMiiZ9V2CrF7TFxna7lBgPGrQu0RratpGxNh9agSYxNEhaT2Z
         lkM50uAFpt9QMi1vhZIjkqMkYPQb0z6Fc6LhW5ueNOgWy7jbtq8kPU0/yeGrp+MTAFt3
         c6HcCqmValK/1t6dv9+gobDhDfEclFb2gjlg5Uz5Me2VU6gHoZ9mvBONQ+mrB2nMDgeP
         E4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KUZeMo7shoPylg24U5wxGwv6v8UB+b7bcEQAIWDFH1o=;
        fh=JvxDEZ+Wn0qn9HvFQUWsKqFGn39tmVmArMNH+RY+S2Y=;
        b=lBu9GB8BWzqaNfSJnSoanWoaDn5EZBBkiSA3AGOoN4T6r4vLpfsRv0o2q/HgUIRU8Z
         PybClpPDULV+63xrHJeeA2CvZGAlPYmoIKH1ITtoiGbM7+x676DsSi6PSzkkJVJo0c/V
         S/TfhLVl1D6qXXZX7fErddBrWgYQ3LG8wXU3RmAtg7GJ9GrtKPXxWgtriTNkLLHFpPJP
         WsrVLUedJUyRgtPdOwfTwdh0q40MR64dO6ZMY8gBQjBWEFiXWoaob08P6+rnTAHOpq7E
         ZbprgicjI3TTuV/jb2VuJCR8GVSiEQ5PW3YvjgEVx/xGWrGBV9wXpRIhRhjU82tXW+nJ
         gqBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787338900; x=1787943700; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUZeMo7shoPylg24U5wxGwv6v8UB+b7bcEQAIWDFH1o=;
        b=mHygJJ08DssyPjk4c0aOAVpKcEnzlTBkFQsuI2oJNAGtdKPcvKKoDPuc0hVrv5mU7Y
         8o9MlgQJc1PffcTdsWggeYG/LGdAWpTqGqX6DTKF7Gha+o/ZP3bEIvfQSH1UwYJtmXsf
         qrILvS+llD6c6suK31d+ahorocek/sLiSEEB0+NAGflixmStKp338mhEJALPdzNL2nTH
         VVYBgQY1/EjLu6BWHwGg7DFvNHVJkm8ixBhgGyzAtVE1Qco3+zULBRfYUYbKnoKB5BHD
         o1/2hl9b6SFnoid8a20aiGprAr42sxn7a5Ah0hrUPUcb05FRSJFWZnUTh/5ks/MRkDz1
         liXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787338900; x=1787943700;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KUZeMo7shoPylg24U5wxGwv6v8UB+b7bcEQAIWDFH1o=;
        b=P+B4VBwcmsSEYKm5VBCLdAM/wTjArjxbFKr68HoV0/IUJri3IEMc950Fz2jmvqmHNg
         xUHR0TSYH95+ds5Eb7Ez3+e9ICXR8yMhp87yRXV/8JcQVqesp9rWSF4DOjDfs3bdOgTl
         QLo1T8iPIjV3xnUeDRoLhkfHrnsCeFXpEGHpmBoNvGxfhMHbbUmrenCvypv+D6kx2Gaa
         l1z6Owv53rprAfrAp/uf4iAtrxm0gyyi5i8D1RrcbMvJLNXKnIEUOxm49RUyiLb9rGC5
         4JYtO/fI4sH3ALi0mzS0dUk3JiMP9ugVbiGJW4QTMI74/CkiUKIvrSFfck+HqSG4IUb0
         2txA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1yfMWsUTmxrVH/KcpmWFNlsR7r79Xwq4G+osKnSkdobq7gZ+X9z6pV4DBJQtn3SFMVvA=@vger.kernel.org
X-Gm-Message-State: AFuF++nxerNCorWPOOYGvXkMn8p65qmwWDvovQjhoLl2GBI9hAvUWh26
	qNaw6O+HEDbdqZXUoKPgzoXnbKc/CkOJofzAPQpXjd8Aw1x27FrDEVgkhUeef5zwQJf0OdlMlkI
	zAcNtozsKknM8LfGyEqOjeZ9/u3dVr7o=
X-Gm-Gg: AR+sD10jTARRH77HZmyeAO1toUJpWulPPs2aWmic1HOAnOwb8SQjxcE1FXvMC7yn7nk
	1W1JavLttuQineQO0zUxUL4IyxkEgk37SKeEOPCIVVudOU5ZSTz38BKwqnwR4RmCF/JSsFV/vCm
	WXxe2lzqDt7lHDYX0H50l21LpOUF5iFS67akkxrbm6x8qumVJj22gn859RSDU9Jf3zFHOWTXWYf
	E0IBTOX3/8ZibaqTETz1bepksM0qK9LIkm4T2RVl2giz6U8W18XLYREiQmO2M7ioymNumzPYTad
	AGpXXxocinGHcfjfXfkVr3TT388kaX12Vvu+lNCpJkM=
X-Received: by 2002:a17:907:9607:b0:c1f:c7f0:b433 with SMTP id
 a640c23a62f3a-c24924b8575mr48102466b.9.1787338899730; Fri, 21 Aug 2026
 12:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810194215.3754591-1-main.kalliope@gmail.com>
 <CAM1=_QTvdWzBpSGnoLV7wiW0dsn_nc04V8KnYuntptQ5mF9Pyg@mail.gmail.com>
 <CAJZwKkis=3NGw9At0WfiZaRYEoMPbQfqJKN0e+vtRDvp4VY5Ng@mail.gmail.com> <CAM1=_QSk9W1z6mT3EdKV=_cbHm9d5FH1HVO6CFjHcppy+s8OOg@mail.gmail.com>
In-Reply-To: <CAM1=_QSk9W1z6mT3EdKV=_cbHm9d5FH1HVO6CFjHcppy+s8OOg@mail.gmail.com>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 21 Aug 2026 15:01:27 -0400
X-Gm-Features: AcwNN1WXi2IVhIXIR52V96B0x9b-lcjJRaQUscj5pPaZpyzP7f7V-TKtfA07Ceg
Message-ID: <CAJZwKkjtzQ0cz8z_b0p--sixppFrc=sM98jts2DxWNZY9wfQyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf, mips: Add signed div/mod support
To: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, tsbogend@alpha.franken.de, paulburton@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	philmd@oss.qualcomm.com, bpf@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> If I understand it correctly, I would then add BSWAP and JMP32_JA on
> top of your patches?

Yes, please. The strict requirements are that SDIV/SMOD and MOVSX come
first. MEMSX, BSWAP, and JMP32_JA can then follow in any order, but
stacking BSWAP and JMP32_JA after all three series gives us a simple
shared base.

The MOVSX and MEMSX RFCs are here:

https://lore.kernel.org/bpf/20260819010523.1057789-1-main.kalliope@gmail.com/
https://lore.kernel.org/bpf/20260821024640.1601299-1-main.kalliope@gmail.com/

I plan to post the non-RFC versions after bpf-next reopens, preserving
that ordering.

Thanks,
Nick
