Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F422A38C2C6
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830504; cv=none; b=e6XEdYV8KGs6lOoyDra0SwYNafBgNLaeX5/7kDmhTAWSqpVeM7T6ukVEb6q40WFTXFuxKLxEPJzZQaXf4vUoQlhUkgAa73gHX2nnCZgBAvZH7/k4b2zuwLnlrb2eBQ7l7AiKMup8uai+8QIatK5nF/Jr87IPTHfIBrobtkjEhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830504; c=relaxed/simple;
	bh=AOgI9qJFRjoVJ06WbokHbmBDTumJdvoTNpQhxuw+ZHE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=cEDOYFmpyubwlWPaNNDfQTD4WO8uoqKq/M914JXGfx5uWnGmAFLnZ6KjU4zKs3KkOt5a3Fx9F0esKmgVvHC0iWIemtudblj9wMwvbacGMgYpsup6zMSUz/ZqmV2RUfkLw7H+U8bUpfMhP6n/xuf+sVuukYgAfVIDH9KgmQhGHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGFnHFJB; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGFnHFJB"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso37808815e9.2
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780830501; x=1781435301; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOgI9qJFRjoVJ06WbokHbmBDTumJdvoTNpQhxuw+ZHE=;
        b=EGFnHFJBkDElNMcTpyjmJAl62CDsIJnOXnOM/zL4b09ml/0GLOCqx43XQMel/bbNAR
         bO3QNPVkSYB5K9bjWKqX6I2mcw2Aml5zPTJ7zcjZ3Ayd8PlX4pbD9lbqGacyYIrUaRIY
         ZWGZw/pIvWIqzVaNGFPTff2DOdw9BL6K44eZBJk6SYSf2gjr8qwOiM50tlB6rWV5djrE
         ABJR8t9M/ADPL8ZMxCVMaVNTfY3o7qu6Y6a67Zhj55JoHd/S3YcjyGsGDqBA34GsIO2d
         bb2klHnX1vl3o9AGBAAQzKQUeSR8hXKhSKma0xEgPGR3DKlzRlaAYpCdUK4Kfwr+MPA2
         qKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780830501; x=1781435301;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOgI9qJFRjoVJ06WbokHbmBDTumJdvoTNpQhxuw+ZHE=;
        b=nzpuVc/DZZpxYc5iOUkynkWHRywFMHho+xzUwTYh6qmwgPLWkNGP5TWhSPHALpaOqV
         i2vDUYUJKSYnZjtE6+8IdJm/dEvyybDFIFwdGBYbrl1gSUjFGx05ioiU9O1TvnbMWV/C
         RNd7lZI7bRczIlDKJ+6yihMZX1VcnS/YltQ7Rdg48zh8rj///QaNNdrA4fYwemY9izNn
         Ll4c5tgyRGJq88rkZeHB5pulHZTqM+iTYsEQXOHBdlGvZeRICGACOJTRbN6kFdpnuL1A
         hO9zF34H5a8pU2rh5gzyN5+DqPTn1e7NAE8RI64jbXrdU4XuBvEME/D4wTRDzao16fiC
         impg==
X-Forwarded-Encrypted: i=1; AFNElJ8K9LZU4sDMng50tch5Sj9WJUQ2vGS1XSgyy/RrqfA7jali9NOr9IPvKcwAjrFFxAwhT8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YydHm2aaMuNy8nOX5Ko+RUpqobAUgiZUXLGQwi30hVLvsGo05S7
	W2Fv8IOxrGDFp4Owt7FF83a3KDIxvBY71BzYqQV3pdmQ9dFXr+ha5FsG
X-Gm-Gg: Acq92OFeriuzKWPz+ZJFT8crBawBrxME1Lqs1hM9J9vtLGMrErnNnh7Y3zLQ2nOs3QL
	/vjpWWMTSLeONQUX/5tSrtma+918QScJL7QKLPwB9gadDHNNAO60D3rAao9ie2L51Rgo7nZCa9G
	Kv1S9HTDk01duOmecmqPuCcOfMML80nIbHlyi7mk/g+Ze01BbCnz0qAd4W2dEsDCgAtlT3gZ2cz
	SJJ9ZqhhxQK8uElcbFBWpbZzc10ue85EPu9sMkv1NUAtB3fsZ8GIDB2+MWUTMDlPlTky7ZeuorB
	pgYEVslLvF4cQgNlHMe3P+/v89F3PnZRg82gbrfLcJJhsENz/Ba48EwW0sBomesoCPn3Tl8cFOZ
	z35bqieZLrM6vyvRSVUwP7NXk9ma6WnMEkqBuFmMn3joIKMbhuED01VovsJcvUNc7sTm+lXBA8W
	fWpH7tI6FPB33HjIoURKo9Mbf/CzGyomyB6+13jSIeOwfKMuO2JEDan49nNqFjEffNnvzjTu0XR
	Y4x0Ggkc5l+RVROPI1CLcf9JlTfYiFuvl6ipVUlTEiku5zgXUFal5o4hJ8DOSvDf9gcPxIofyma
X-Received: by 2002:a05:600c:314b:b0:490:548e:b854 with SMTP id 5b1f17b1804b1-490c25f5e25mr179077305e9.26.1780830501193;
        Sun, 07 Jun 2026 04:08:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e4b5asm312996515e9.13.2026.06.07.04.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 04:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jun 2026 13:08:19 +0200
Message-Id: <DJ2RQ5NHDCZT.2R218ZSS80NQ4@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Paul Moses" <p@1g4.org>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <houtao1@huawei.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before
 expansion
X-Mailer: aerc 0.21.0
References: <20260605234301.1109063-1-p@1g4.org>
 <DJ2OZSCSEVEI.3APUCE7ML9X4Q@gmail.com>
 <E0xEdilT0Z6figMeDAyw03ex29iX0RfOAUXuh4aTJxUrKHK2Bg5N8lKCHNvQoQQ1UzndFFqDJ_zmAMYHLqSgSfF1menSW7C9VKDSBhYrTT0=@1g4.org>
In-Reply-To: <E0xEdilT0Z6figMeDAyw03ex29iX0RfOAUXuh4aTJxUrKHK2Bg5N8lKCHNvQoQQ1UzndFFqDJ_zmAMYHLqSgSfF1menSW7C9VKDSBhYrTT0=@1g4.org>

On Sun Jun 7, 2026 at 12:11 PM CEST, Paul Moses wrote:
>>
>> Do you have an example where this actually occurred in practice?
>>
>
> Yes.
>

Right, I know you can get a splat. But how did you stumble on it? Is this B=
TF
produced during compilation, or hand-crafted case meant to exercise the lim=
its
such that we get the splat? If you have a small reproducer, it might make s=
ense
to include it as a selftest as well.

> [...]
>
> Also, I still haven't made the connection between the CI failure and
> my patch. I produced what looks like the tcg variation of the same
> failure as a oneoff while testing an (functionally) unpatched kernel.
> I'm not even sure it's the kernel at all and not some weirdness
> between clang and qemu. Seems low frequency intermittent from what
> I've seen so far. Any ideas appreciated.
>

It is unrelated.
