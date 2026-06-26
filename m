Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEB321CFEF
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782437915; cv=pass; b=rSLNCtOqx9oFd9TCR/CgX/ocpNuBKTAx/tR8ghWfzuKLh6TDtivYgYdnlEVb8bRvTKxamd4Gj0M5MHy3Mo4DLUlLfePGlSXUDAvRVZXD6O7X+BjfSjNImzceDzPq6Y28UXJgzWL0/j9IOFiNgEeqzaJZEAo3La86t4Ef1YYTswA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782437915; c=relaxed/simple;
	bh=9l7Zyd74R2894i2sVz8bx7i81K0qtgAvXYMerMMV0Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2zVQ8PVEdf5QGnZ4B+ewhUBbKdf6h5ojTliia7yYWy47h+FCNdd1G5tqMCT9SyuFDSWu5YGKZc4jqsSUy1gmQ5e/Zm98inRrD/yLGSqPimXcRwARdMCXDUzILDUbm3Gnq4FVyUAR9wyDLmlE0yKsl5ang/D2zgdNS6oUtVA/44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D2eQwc8+; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D2eQwc8+"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37df0b86a82so924932a91.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 18:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782437913; cv=none;
        d=google.com; s=arc-20260327;
        b=dWncelrVn6IQJkU/uJPJ76d86AR3GVYwP+wxAxYpk7efiZEVxT1nOHUtiDYjzhv8LO
         njAp6AOVjz6imE/7gmubAU9mnVtWgIeK1gWm5Fqnk/I0EC0rbJN1g5kmUzQ6umdoJNRZ
         WpsapD39KrZssY885kyGhYGRt1No+3SkH2OaLdg41Uo/aB1PKKf1iA4dnnI72t+bsTXF
         NEIiWzcuYyPFasvE8p8P6fXyp2LXCpGM7DujDB/Y7ulbA2lqCL50qdtMeP8A4Dj8mc7a
         2QZ7KTiep+4CJNDCjAquuvxEit7QlJXZKP1yIL0csHvWLwAXWJRMn8s/MLfZeXY6QtMO
         VPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YhhogthNj9XjiqAxxo/P6pHEwVbLooE1/KogGrO0nVc=;
        fh=ru7TQtp+0eQDIrJoBidriMVt4bnpO8c1gfWljkEIWqY=;
        b=WcY11K5uLWKX2dD0Q9sXkkMH++8dF+uov0szsAZZTM/5Py36bOtMl1lZVhEP1iTis/
         fS5CnzmZxnPSZ0AGwFO4934fDrJXbN1YL1qaZNq9N82FdYBURlpVAyDgVy0IWTTmrDXu
         +P/GVw4mHAC+teExvNSgYxSw/R3dLIpOcC7qKSAJBFjluu8godthGkX/HNtl1z88XNlH
         W2fnDkIpGEmE8NaxG7aTNrAt9Nl0011msvr9PrRnn1LaVPG83y8WITpHbR1ie/Hjs4Q1
         sP3wBvLlvOX8adPVTgMbkikxfESWFnoTqndb3goUvnrWJx9DTJD1sLSpBmcjb9UAPNk6
         gRVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782437913; x=1783042713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhhogthNj9XjiqAxxo/P6pHEwVbLooE1/KogGrO0nVc=;
        b=D2eQwc8+xKL4aeTydJj8JtLLTxX4EnKxds553e1ugRPjALEs81Edq7BVh9pXWMYzI0
         reme1YbDZEEyCX/C8h3MmX/22bkBI+TCEhnhKKMEFiNc7+9N+HOcHOaN33jmWbN3KYQj
         GLOKjZaKpJBMU9Va+Cb6j5HS0tqntUAHIy+2bLyE7Ut/WqMJZsCfmSMAdmIfJZpSSPJs
         LIegsTee+ZNm35hBqjkAcCCMny4Ei/3JgBk9Slfc03eKK9GKZy2JmMDPkcLlBJsyanA5
         +mUr0Wzh0yeB3mJLi+CtJqsov9HtubgYhNheVRD0TxLZo+C0gfQCz0I5OJ0tQyKZsqLJ
         1vsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782437913; x=1783042713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YhhogthNj9XjiqAxxo/P6pHEwVbLooE1/KogGrO0nVc=;
        b=T9vOyZ6h8iG5ZCMj4fTOiHfNJDsmplnrInoiDXzLT/uQrQvAusfQyvCJELCUfjwqkQ
         1Fu+VJskJKqBkmsvb+KVq+tYD/JjXAI1c3eIKUZ5JVhoC6+o9v5+x/dh900XGrgk9pip
         LJ/fSPS7MfahDRiusdC0ysp+ZvsRRxH8koU6EQi99e/zYPyKEnAHTTYCYtgRedk59rb9
         Qdbm72HYDuc0Sia1SfAUDwuhoF3LLjrchFOcPr8Cq7PWWxRibjP4ZAfC4i1hh4FtVQRn
         ymlbRZNjhbcjTzf8Swb5WOU2slGCjtlTWXozGYFAU98i3FjNgJD3XyBm1NGRzkyOAYUc
         wEBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqXY2f4Nr2CaFQ2s5sc38suYObJq90gtJkzzYy0cAuQ5XvVHV7jLDwetPX7GpAIaMAuTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1JuduC/z9CZzJaxXvSVGT3Ao/WDXUDcOzAkEOuxtHipQ0ZYFD
	DHH/C1gQJE/Fq69qDvl1A4ae6pCDn7luJn0LhZEpLPQrcMMoTYPYvfoWkyrHLJpt+bGAPhSAxdG
	cBVDqnVSytGIH2H21kGqB+lLPhRgK8PISJL5ip7O7
X-Gm-Gg: AfdE7clhka5r17SsJ6VNAlIEmcSzHIxsmGEvg9JYde8qS2fr+8Y5daK6lOK/8aPcTbt
	cMnar5VUo7At2PgAfANHhZ++/d0JYqq5taQvLv7pDqM/jYaPQGF5gl4s0+66JLvtLst1hS10GAn
	gD7/5HckXMVzwU+94sTjVsVOsMe0P0C2p+DhyxwUMeOoIL6IQGSpE/TQb6monN2V4JqpIsIKRIP
	9ybrjMiv5JD6jFFTEm7KuzuHNtgNSxnKtgPSk/bCV/YTL6h+8trr80wpd48eytX+aNt3fF/eCA5
	CTbR7JA=
X-Received: by 2002:a17:903:37ce:b0:2b0:badc:c9cf with SMTP id
 d9443c01a7336-2c7c3e6b287mr117609735ad.13.1782437913330; Thu, 25 Jun 2026
 18:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624140301.93421-1-daniel@iogearbox.net> <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
 <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net> <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
 <c4dc3117-ad84-4c94-952a-cf0642cb42e7@iogearbox.net> <CAHC9VhRV9jW+dwNf7mW+1zTCsZ1xstBAugWL-TJ-DVNARdzC=Q@mail.gmail.com>
 <DJIL18C2F40B.39U9WHD43SDBR@gmail.com>
In-Reply-To: <DJIL18C2F40B.39U9WHD43SDBR@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jun 2026 21:38:20 -0400
X-Gm-Features: AVVi8Cc9HRHCKG4lPYnMRDI4DdlvNLRJbJ2MdxSHsz2LRRiHOW7j0FHnRgMqMnM
Message-ID: <CAHC9VhQsjW0OJhKYUNEdkt_31oo56aMusDTANDOAQFNQwCpo4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org, kpsingh@kernel.org, 
	James.Bottomley@hansenpartnership.com, bboscaccy@linux.microsoft.com, 
	memxor@gmail.com, torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 9:16=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Thu Jun 25, 2026 at 5:59 PM PDT, Paul Moore wrote:
> >
> > For all the reasons I gave previously, I can't support moving the
> > existing security_bpf_prog_load() hook at this point in time.
>
> Paul,
> it's not up to you to approve or deny where security_bpf_prog_load()
> is called within bpf subsystem as long as it doesn't affect behavior.
> Daniel's patch doesn't change observable state from LSMs pov.
> It merely moves the call from syscall.c to verifier.c.

Alexei,
It is my responsibility to speak up and voice my opinion about LSM
hook placement; arguably that is one of the LSM maintainer's larger
responsibilities.  Non-trivial work, including several allocations
(which can be quite large in some cases), occurs between the current
placement of security_bpf_prog_load() and Daniel's proposed location.
We must preserve the existing security_bpf_prog_load() call site.

> So we're going to proceed.

Oh goodie, will the fun ever stop?

--=20
paul-moore.com
