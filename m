Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813D437D135
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773877454; cv=pass; b=euy2BkEfn3e1WcCb3qbYa/xhO6fcvJGj1HthmlzlyoZ2DFydo4aAbnbKFWgguyU37dsU9a4y4VE0UpWzlpoosDoVwtM3S6zZfC9TFxvcFH2Uk4MlK7udojmiCrbxk+F34fkABlNic5W6iZhxtUSPUIrBMDBovYcgCVwVCaDO45U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773877454; c=relaxed/simple;
	bh=NgAiEy3RYBIV4Vs1PH/rHb4o8Swmik90cKGdhhe4ixQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scOcZFCXzosNJ1hQupmEBWyzBeE36sbBlbLAQQsrz+yPZrHLH3xoXEnGMtJQlzdsODOK/CUqEMFUhaHiulkXjkiZsRDMh+9ZvSGUczqtSLryfwAgNikiFZmM3gTqu7mH/dmTv0h4MqWQ3Uj3paxSwoBiEYIOt5Ennk34QtB8oMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilVZYJdC; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilVZYJdC"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43b48ac2727so231923f8f.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 16:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773877452; cv=none;
        d=google.com; s=arc-20240605;
        b=E33ZKln54PnbAAn4FaptoV56EEj4VNBsm8MGkx4tsUJRN39ozbJI5zk1OTOmyBKVnj
         eNMfguuQ2FxltXOFfK7srZbEMRBmHv6qu+lUOJr388ECs49aj6rN9Fr2JG7VaxlgRA1s
         YTG8R5k/gJRm8gNq8IU6YYrYB3CbyK6EJb16VnjnXcg/z8SQW2syv5aXaNUTbVpSXrpM
         flkMQ0RRNSXGG9uOM//X80UB8/ZaqBQ+cDwLIam+In2D6GdEzOs7Gz2C/+fDxfqlBC1a
         RFzF3wxgkTr1EMDR90ORQK9h6VvXmJur3tM7IxNJI4zM7QG6GW3j0wqpL3Lpqoay1Pj1
         rM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NgAiEy3RYBIV4Vs1PH/rHb4o8Swmik90cKGdhhe4ixQ=;
        fh=jR1Kjz2ljfdIALWUCPBon5tMpz4rOpUIQbLfM+lGbgo=;
        b=I6j4nXOgsVcolEr0OtvdqmnwxnX5kejzvJZAuUCeWAx9HeU608Wsi0puinoQBRoyRY
         3yiOuIqLQ8cxtT866ndzfeFx5LStXM8qyzzV8vvZQO9KKQYVmR0wozj/NxJARFvep7pv
         AzZm4OSM6IUaDyQhoeyM9t/LYO70SJ4g2pUIYa3uMW7IC1pGTNN0Y8PJhRUC43Tfmeej
         USTj3Q/tRCYrdzoskLFmwXqE8cS3OqJtfnbbVwc0zOuyNdbPf3AIPp1m4JRh6dKnPMen
         cCygJuA6o9jh2Fpt4vqeYSthXkUCNoIoiPoMHDDorU9WqYD+XCoyWBGxdmuIYPGOuxz3
         Eb9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773877452; x=1774482252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NgAiEy3RYBIV4Vs1PH/rHb4o8Swmik90cKGdhhe4ixQ=;
        b=ilVZYJdCnqDJUBpKGOxsnDFajuBXi4eIm9dep90rUPjqZLb/Y/lrPpddRdME6iU054
         NfCfBh7rpVtyz2fJeBrriAt8nljBiwISTZmXk2PlqGRdiCuNel46YFHXWMdZgapHjPLt
         TYv261MsRhN0TVL8Kl3Yxlf73BxZYn6/cX5+japPjp1+6wI+2vzjn8cjIdZUp11yZEQ4
         u3keugBBNK2H/JrOdJyAClDRo9kW6I4xwfvVNszgps9qRpaXBSPKfla6nFgu/ddWtjji
         No0Q55mKmyOqxtW35jQSeAraUFPvrT99Dub0dDK8kzTr1MMfqExD1qpLq5EqQrzEy3qD
         S40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773877452; x=1774482252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgAiEy3RYBIV4Vs1PH/rHb4o8Swmik90cKGdhhe4ixQ=;
        b=DV+KRIKXD764cOFBcWIpg0W5Ov+/XJcjBkUEkFE8FA8BVvhyLZ6yT1T/R/4ODKITE3
         eKGDRVTjG6XRbxb94u5ODu9RqLLb3b5K9waveWIDSGsIY3fsdMPvhjW0oA7Uv6evDaSn
         H0Ti1Fk2ASkIdaFpZ28AMIT3L1l67yjPxljY1QaFiJgUBY2cYnEXrfaaUtzzpdvA14ZS
         fy1mALUFZ5+akK1eCsUArxnI6NNW3FJD2Zk2iPHVQ+8hcdj4M91anRd7FN7Ez8QfvOzj
         9ZbDDv7iGpa41P8lU3WO/72d8RKVHV2HKpv1q7zk9nCERTCeeBTbd1xDhf0PGZaRbBmv
         h1Xg==
X-Gm-Message-State: AOJu0YzCsHEyrGhQEXDjoFWe+EzpeGMJs8nzgvyXuNDR7QPWTC/n/C9f
	cLcd//K5y9mcTJnnUL2O7oRBkYpvfzE0PkY8tS48NCV3SWXPwzPA5mHqa5LUQKVHfKkIOc9KDS1
	E9cBODCvofAO6x81Iy2Vo8wCh+8KRH8w=
X-Gm-Gg: ATEYQzwJXVyHxMfhzGLD7k7QuqfWAIKqKzNihzfOZPRNCsryl8tOtlnHsyttb5Ibbsy
	af6GKXsI2xrASU/GqCEMdB18DTxM7d4QwagdVla6bhA2Tu9xzVKwRlJkPCV5p8qV7a/bI4JjlMe
	mS9bKzEYYbIw+/Bxz73sGH5fEek/h9wRHmgzVF2bGLFK7K5EAVZzsO4cHM3jcxua2YPTNFGkHHv
	2RB1uvoHrq6jkaSROKA8++zCMIivN6VmyA4gl4z5rtFnjQ7akDGEVZ+Wdl++OqT5S3PSgvfmvJk
	LCQxQOWLvUMfRp0ThDm2slxlOnXKoErriuWJIDP9wcQUhS4+yBn+AdL/bkg=
X-Received: by 2002:a05:6000:1ac6:b0:43b:4362:8ef5 with SMTP id
 ffacd0b85a97d-43b527cb2fdmr9128002f8f.51.1773877451673; Wed, 18 Mar 2026
 16:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318103526.2590079-1-memxor@gmail.com> <20260318103526.2590079-2-memxor@gmail.com>
 <e05e441f4b071a33c71f28d6668f2e580952c7da.camel@gmail.com>
 <CAP01T74km+A-CU9J4n2S+ZkhD+XmgpekU=2_7jF=TTU-T30+Fw@mail.gmail.com> <d6a552009f2f7cafbef5047a2ea8f6428845b755.camel@gmail.com>
In-Reply-To: <d6a552009f2f7cafbef5047a2ea8f6428845b755.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 19 Mar 2026 00:43:35 +0100
X-Gm-Features: AaiRm52Bd0F-TLL8_0c9wD-QHLKyMaWWXr3fxVLR22a_xvEDO_8l4aenePSr-xw
Message-ID: <CAP01T77dQ0g5UsXtisVH8Ln==yCYkH4aOmOHv9h31eUC4Xu25A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Support variable offsets for syscall PTR_TO_CTX
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Dan Schatzberg <dschatzberg@meta.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 23:37, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> [...]
> > I think we cannot pass the access_size through, check_mem_access is
> > meant to simulate an instruction access.
> > Earlier it was doing access on the final byte since pointer
> > modification was not permitted, so real register offset was always
> > zero.
> > All we needed to check was whether access_size - 1 fell within bounds,
> > more importantly just record the max_ctx_offset since there's no
> > bounds except U16_MAX.
> > Now, the register is modified, and we can access lengths wider than
> > those we get from bpf_size_to_bytes.
>
> Oh, I see. Would it be possible to extract a utility function such
> that it is used both from here and from check_mem_access?
>

Pressed enter too quickly.
I think we can do it, the only difference probably would be the
access_size passed down both.

But looking closer at it now, should syscall_prog_is_valid_access be
doing off + size >= U16_MAX?
If off is U16_MAX - 1, and size is >BPF_B, we will likely set
max_ctx_offset beyond U16_MAX, which is the maximum permitted size.
This is through the instruction path now, through the helper path I
encoded U16_MAX as the max size.

We probably can end up doing OOB read, since bpf_prog_test_run_syscall
only checks ctx_size_in > U16_MAX and errors out, but relies on
max_ctx_offset to be <= that.

> [...]
