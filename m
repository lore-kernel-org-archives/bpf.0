Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793806625;
	b=Vuz57PXyShK3a0ilwWLyFtcu2uBStefI2SM+1GaUyK2FEuRVPwFrJxJyvF7BiqwRCovV
	 DQnvvz4t4L6QEwUUpkpcbt3PrpvotPDLObEc0DI5xQZ9XxHIX1xcZY5gYNrQT6dvCl3o9
	 b4twkX/bT94RD4bybNO1WLow7zhLolwMMyozW1lLEZReoSk1typ8qE43tGpNHPvF9UzpM
	 9p89kqpNgUw7u3L2HVwZB8MBi0ZZPqXLG6V5W+AC4JDinbdQwrIKLZndiYQ6sMklJeaOg
	 msw9vdgFfSvTyr489nVUtusKEJGIy2t6BLxmX4SOMebwCYWfIm/52S3Z7EXtVqH8POA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=W98HN7wJ4fZcfV5odlqIGcVOnLj/iuIKM2l41tHLMh4=;
	b=uwDQ8mkLMLGgCbb4ALKQsrqM3+CbLjVIpgHuvhvEh0xN8oUAH7BDnz+E+PJv5iTEhCh6
	 mFVmUqz6B35n/OTPAtRFzw/FPfcl9BDz51xQkln628+EDCX4mLcgmjhAk6SvH55z9x3uB
	 UYfy2IW43QvULrmm6q7vSJ3d4nklkdhlBPm6phhjrjXogEWCWYFid5YxJ4fX3byyqPyKt
	 rSXHME3fbujXfsHOekt3jDWcmFB30QzHLP1G2GJPKrd5edyBYcBmIwBLqWba11I+b+L5W
	 moZfG2il/JYVdoxkjcDawBT/7saOvyJe48ufLV5aLqf9gewzpv3k7nG6iBVSFVV0TDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ETdVW47E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DBB606D80B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 15:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2DBB606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ETdVW47E
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ab3dd9670bso8195131fa.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 07:37:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793806623; cv=none;
        d=google.com; s=arc-20260327;
        b=PYF/7TMfM51i1cXOTJ0frHUSYXY93V0AxBcO8OSQGhdy4vhQrWfCHJjs5491rUMxDG
         GlTcE47FntIESKbdX8ji5FCl1RFuHiSPghGHjx9PANWAUU7aSuJfAhJaZ25FFRIOlTgN
         PZB3tpoFms/qnNpWowK7N613jREWHI7XKwj0g0yGun6gvmB1Xb5Ba3WjVxospEpNOzGl
         BZSiD+BZrbofMj4c7u89PuMm28oWdx8LVuThmSv4Hb7LH+cQ0tLnrgZKw4U+Fq3weVyp
         S1CqLO95LL9REO0T2v3HTTFyTgBikGPALqOgBRvXTwMSwl0H0ko4nxkmzi1S35kVxSvF
         YMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W98HN7wJ4fZcfV5odlqIGcVOnLj/iuIKM2l41tHLMh4=;
        fh=8Xlu2dVcG+m1qfGdGb9b3uNRNQ5jAobNx8LFPGM/EhA=;
        b=qYTKP/gMtZXMGgMjRaPuMe5audQPMh58Q81cnx7NQldrVwsFbeiYNPKNx9SqDjojVh
         IqbCEjfGHE2kbzlU34Kqj/AKyVUry42xOp9+Q2Xpjh3pZjI0edaHiENe4pz2wKr2ld9Z
         bIvrEt8YPVK7CHGZNMMcJ4LLVh3IR6VtJlsBC4yo/Kl7KgALjne+TY/EauUmOCcrqazk
         Ol4hg1J3tn3BMe8zOPUlAbDXDUnwB60+AgWj3yK7kcZfHnsu//IWQcriglxUpzpea/Xw
         hwlzwoIyDo2MaMmybGasrRr5gr45WKsdEDTBg4yddROcr/5ZgHd0fVQNS9t1RWHGoEsD
         DblQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793806623; x=1794411423; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W98HN7wJ4fZcfV5odlqIGcVOnLj/iuIKM2l41tHLMh4=;
        b=ETdVW47ERq8+IQVeUMVqMAqQCwFpkiJJoe7KGeo8X8fUPPryq5zwQI6X4/Sspby7R3
         IZnAeClJIqjcqBW933pNUHP+npj9dglngaNlTnUOReO8Op4dj8PYX418F4G0sFi+Frim
         NPZwKtkveE9D36hbqhQ7cGBKSWXGASgigNhpzykB5qe75RaXT7vraT53eEdcRDXKc5CK
         hV5TTpDFqcTmb/Ddk65RKUSFW5OymBNHUfWv98BxQK05kpY8T83lx++XG6MTMwY5A+T2
         650so2hJnfyyrIaCjW6bL3ou78fTTfIcDRTT/oRSoanTc8PJr0HQPmd2VHLgNTFNm385
         uF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793806623; x=1794411423;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W98HN7wJ4fZcfV5odlqIGcVOnLj/iuIKM2l41tHLMh4=;
        b=I5MAREswjZ6070e1SPWNwwIocc6YgRXxp1OzTVeWbaGewxG2cobsm6Aa+S43zfFRnR
         X2lgEEGI21NQs4BTAHbfgKlrMk+KFlxFMz8sGFmOV5qDMpuZXiu19FRGAjkUip9gnEMb
         dnz/sP+N9vgdmHPkbW5z2Gg5QbfXP0hx2TvHkG+DldJM/ViUHYqXFN/R5uOyo7YUOwj2
         4c36HLTbz4T+JSBWPpQ0SGq2wkO6VKXhWdZVtGY/wcnRKUUZf1R3TZMN7F69PF89rknu
         D7lYLIbA6OjTp6zWHzlG76hJWE+EuBSGHbiM/lMi3wns+OT+g7yQGsqnqXM8a6Sdl1VC
         GYfA==
X-Forwarded-Encrypted: i=1; AKwUvBx74QoqTjvqcblsWFYbMddUTMwoYtkZ0MoB6oCcdoHvFe1K4Jy/ZBrRte2O5+cYjqsElDU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/s1yZ+QS5ieofsiGwLYpxw/vdqYYCAMBSTF06ptxJ/gLCQUVlW
	hPywQ0U6V3D+//aIMnlzE9BsDMK1YU04WS2QPGlpSyTxiITMaPeKM+l64bxEk3bg8/NPuC8dksc
	iYFIznI+mY51Hn2/kPsog/CCj/LzLNAGAAQ==
X-Gm-Gg: AYBFou2CCYrJPqibTvNX5UPOWOR3Hsr23wvOgI21556MG+iIZ9tNysctzxaRdV2A9Qs
	QtIH3vtGF+UqbF1u/dzzIzECohSj6HYP/yBbUevi0SROBfymA+FdyspcBBaBKbJzsd4c44VJ9qc
	51NyPRv/k/PNkSLH/bBT0u16JU7AhrkwKsmyJ9sbMQMDv3eWK/7f0xLMZv8zqKsGrgFk9+iy+6l
	n/MsfB9/jbKzb6zHmjlysFr8nmAbrR9uNrvbClTlECG9AC+9gw8Ju60JtJ6kX3fmMVmSD+e4kxG
	NvNPnpyFbFx2cZyUmuX5AJDRY32sTNCl3AFDd2jIQRry1DoN8+DP4UL5/RVXEjgKuLZ8IKN76Yj
	gMBxPz4YFoIGZIZdXLKPyOI4awftvIR0BH1lmwBnHsiubQJUTB/go3caQxZE7ia7cNkVCoKU/fH
	habQK1l4/YqO3gQ7iv4SMGcQNbLCSpjUbB6ZQe/wHKNqu2BpwrPQ==
X-Received: by 2002:a05:651c:b07:b0:3aa:f72e:8ef5 with SMTP id
 38308e7fff4ca-3acb7a8f83cmr38793161fa.19.1793806622513; Wed, 04 Nov 2026
 07:37:02 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202608191340.98574fe2-lkp@intel.com> <4h7zrdfpu3ailx5ajkyqohmcfuxgrk3tn7i7n3dkp3ksy5xehk@xqg5j6pqzocv>
 <179361623876.3.16264907931792312619.redis-ibpb-report@gmail.com> <84ecf492-5a71-4871-a555-abb76a1402db@intel.com>
In-Reply-To: <84ecf492-5a71-4871-a555-abb76a1402db@intel.com>
From: Chengfeng Lin <lin2530632123@gmail.com>
Date: Wed, 4 Nov 2026 23:36:50 +0800
X-Gm-Features: AclHuK-Vjr9iNtCEqcfXxOk7Wz6zZfhG5pCaMZhb6xGcDRnMQOLOvY9anCSqSS0
Message-ID: <CANGjgdnbBaTHYvvk1rOYH-Pe0DCHr0HWb5v6DjdNFn97dLtbNQ@mail.gmail.com>
Subject: Re: [linus:master] [x86/bugs] a3af84b0fa: stress-ng.seccomp.ops_per_sec
 95.7% regression
To: Dave Hansen <dave.hansen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for taking a look, Dave. I'll investigate further and follow up if I
find anything useful.


Chengfeng
