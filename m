Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADFD399CFC
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177805; cv=pass; b=bTysBhS7Ggl1nflvH9imdI4Ih+VsFBBkvbzx2aznchybZRTAl6UgmSXK3FWk9JrNg2kqWdLBTVSUgGlmUpIo1r5BguifeOSNw3Jhjabz8TqKkKWIXiipe/oL8pan4q1Qeo4VBKmnC8LTNCfS6kbGzj7yaFtXqv51Xivi1qpFFU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177805; c=relaxed/simple;
	bh=MckAIFt7y6KQiCveSZvFBLKgfYCSm/ZaqCz+bYvfhus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhyKT7PtX5aZ4bXNEM9En2vMwPKuandgwNLQ0fSxOK5sKkiwwlm58aTxbTehS8b1Gsdhm3B60UUnZ1RcVQaMVo/GMxAxHCugYxY+O9c3IIzG8WxusxHRUraeXXwEsXpDMKyXm7MTMQ9LRsPf4hakPp4f1vEFpPlfWFGfUatx5do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=none smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b=l2TOw4Lx; arc=pass smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks-com.20251104.gappssmtp.com header.i=@anyfinetworks-com.20251104.gappssmtp.com header.b="l2TOw4Lx"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a05d236f53so591673137.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 08:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790177803; cv=none;
        d=google.com; s=arc-20260327;
        b=iBXpe03SQSOgeaLvhroIbmF+1qRQfFJ8h90EyX9+95icqDp0MEb1292YdIPNUIDpAp
         U++UkV5V61IS8MMgxTUVyLlUIWX1EMCrRWLg1Mby4yrxwK/vygamfKaAuUM1r9Iy2oN8
         vDA8Gp6eIzF3ojt2LqXN7UNqG+3M7DYOxZ3q2m7RBKNfiyZxHTM/p/fiAhxTkvyxqZQU
         1fJWp6Dhzd1MWSAmBzVm7HuFsRd9RQbJU5NrAUl5Q1Wasv3YSAV2cFV8iaV89OeiKkEf
         ObxWrwG1vq7yFeB1UQNL/JVTLCC/PlQwojOi9SEwS2JH/g9EZZEM9l3vyyCOfTgGvekz
         hbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WyKcbkEZlymHx0VcQ7j5z0yvfYLusEKHMFeFnghlEvU=;
        fh=6X8e7DwkPjpL6Pex/YxoYAlil1l9TGrkx52eX8Cs63k=;
        b=G3gKsepVPjG1nHGnH/Hxq4+/JFWyB4kJhVw2eSqLhBji3LRJd36CH1F/pbkdDAbKmP
         fHOKxmwdECcP6gV9wvj3I3NwCZ5YFx+WTxaUlm7pc33N5q7ufYpVxvxkhxkUORVmqypo
         +/eFa2KiQwNJC+gpd5g6C8aqw2Nz/OngqBX7MB/D3jxMDks+8VkXeBXV+WXFQKxq2Ykc
         B/aNsyEOWDsmwn0tKzLAtLwQ+1XVsfHWDp+o85g6hVI5EzX71AceDfPPEt5zWeEjFh+w
         i+58wRUzL1493iSBCu5w+A0F69TNndAIxMO4z6Gk2PIOxxyn+81I9BWnpJ459F3WcwEN
         uqnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20251104.gappssmtp.com; s=20251104; t=1790177803; x=1790782603; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WyKcbkEZlymHx0VcQ7j5z0yvfYLusEKHMFeFnghlEvU=;
        b=l2TOw4LxGBKykjSF6yNa2YP4rRN+HRl2i7AntiIAVw6rxJINw/YSTkq0NvZycm3N/e
         ne4Lc/zLTwN3UeZDESODBDOOcEbzZDs4neg9holUuBm7QbL8+LVLWVZDM0ALbCtbAeDo
         0eDAQn+lIzXrndwUjlVhPMdk5+U6CTCiJFzrxB7SM3W5UViZJzcFq42ZUngGYo+i/XO3
         v42WFEV8rxgGpQMVFC2kC/3N34lvxKXVzuplNyxshLjYPNJJObWJgHS08RWIZUVKCVfK
         xdY7cj8P703FrBFSBKWENWXDeru76REFVDSSdM0jFsqzwPUaaYONs6kq6NItxq1Z/7nr
         uDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790177803; x=1790782603;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WyKcbkEZlymHx0VcQ7j5z0yvfYLusEKHMFeFnghlEvU=;
        b=rrk/l+1c8AGyHzv49tcjxMuBIEyu5rIraif41ARV3jHnqPaeEw1XvN1Zy+j/Ucbi9h
         gqTC8fuDe3cIyp9XHcjA2zKRnt3X/20ozgjWsyxLV7rSIUkzx6ghoCvApHB23r3DCZ+3
         ef+a2z0zGuO7czf0G5q7gSWjXX8pshQ87zfCCdIC7skjC2INnAZnAKDgfwB9251V3400
         EapkYjnAX447rB/9JHvXL/oDqjEGwKkYgLVECU2QLxTbAMotOJ6PXSzgjJVEQRw0BpIb
         +M+rAnNqCd35OdDdYGTchvh9szoG1ji/zdANXrzCnU2XtbA4HVI+4Z0623V1Uq0timm7
         vtag==
X-Forwarded-Encrypted: i=1; AKwUvBxUonS8i/TFBbzqKONZKWZbEb/9tOtrRxkyh5mPI5tfH/bl8f+CWjPBdlNI3nMX7GRJ9hU=@vger.kernel.org
X-Gm-Message-State: AFuF++kBmlLcTUtv0508Si5K7OTVEAcav9zJCy83h0TWAG6AvqnvIiIz
	TvaCHafCQhWlnWKtjKNGj9t3NfXNQ5RSaWgelfCdMSL9CTT65fPOz2lZKfiAIgPjeQgxk0bz255
	7+y5hGR3lZV0MQF7OXLdpXPi/cL4xWOjAknz/f6GcIQ==
X-Gm-Gg: AYBFou0DhlikF36kKKyAL5X1IMGO8DkmDqKwFkwQ6/mr3CEWm65TWbcmoUkKH0ojNwQ
	RSfnA7KkekD2iswPSdTAzlglLseWnxtiLqug6NHVCZvjYZGQSUgDmMYlnHt4/BFCd77QKCYlI1o
	4HKHxaqCqwR70A4OC3xBeulln3T5zi+z99uvVgD7PTg/3jFOkdgN+19+yX4bgfklfXRFh3OGBk4
	V7fGASlJl5vvruSsR/iP5E62RiWa81eW7rFOsa1i7OQp6nUX+DYwtoH5TG0o7ageOWAc1ptAT6M
	hGAcWVthjWX8GNxNscq3ORDzFb2t6NFLEbhmnJBrKAVC8zfuxEaD+hs=
X-Received: by 2002:a05:6102:c94:b0:7a7:19aa:8a81 with SMTP id
 ada2fe7eead31-7ac1ceab000mr2765066137.28.1790177803157; Wed, 23 Sep 2026
 08:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911213340.3767930-1-main.kalliope@gmail.com>
In-Reply-To: <20260911213340.3767930-1-main.kalliope@gmail.com>
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date: Wed, 23 Sep 2026 17:36:32 +0200
X-Gm-Features: AclHuK9A_heK5XpfCJuEwPoemEBWBt68h_7NVvsiHk4qVRuUG-8IlkgYOWm5Ax8
Message-ID: <CAM1=_QT3=gVshfds+0dZbmHy3vrturgddDfzj8MQYaj_mCchMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/3] bpf, mips: Add signed div/mod support
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: tsbogend@alpha.franken.de, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, paulburton@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

> Nicholas Dudar (3):
>   bpf, mips: Factor out div/mod emission helpers
>   MIPS: uasm: Add signed div/mod and sign-extension emitters
>   bpf, mips: Add support for BPF_SDIV and BPF_SMOD

Tested together with the other MIPS BPF JIT series and fixes. See
https://lore.kernel.org/bpf/CAM1=_QTjcyMtMLawSFnCt2c5wJJ-if40GSfo+o-CoZqcgx5wYQ@mail.gmail.com/
for test setup and results.

For the series:
Tested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Acked-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

Thanks,
Johan
