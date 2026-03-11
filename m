Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76553E3C5E
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251538; cv=pass; b=gpaFI9z50QmTZBswMuajPvaLUFm3VcIllFy4QL6otoWv9HB+h0kh5/8dYrxuXmmr+M0dcOH3pKxXXu1yixv9aM+mnoFaVixxDC6W27mbvObx64pi2VG26cSx9Yv7nwwLDqQA8xSuwNr0XTn7eAUatRgzBOTWJfOQlllOrZimiRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251538; c=relaxed/simple;
	bh=vMpReo10GUnLpPyz/99nveri6JI8OFWDwKYxJmDwRao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=co/FuhQ6jBMxzs+79+IWENnTi1d8hlXt0FuvjJB/b2XJX0wMbd0B8RhN338uwckuNbROoEZWDYWjCf+uPYvFLBG/iW4ZgTtu1icwPQKRooIsXEuXNzMZWzdl3X4qrcMo9FT1Ja+1mcjQ62MwU51erS4kWR4nTjjOJZiWIOF997s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do6hQU7C; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do6hQU7C"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so51886a91.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 10:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773251537; cv=none;
        d=google.com; s=arc-20240605;
        b=VlWXJ3ecj00xBGYQzY+lvonOuUXc503SQwXAnbRW0mYLdOsnAwm+IQesN50WCtI5PM
         8kXZ8PI0cVumcYCNLoBSTcNz3N9/C+dg9dmNuOFXg/sayRbHDT+Dhin3Mj8r1QQw/2CV
         IEIlbtFOhXpxCWXEls7fwPtf2Uwj/VKtR317K9JSeMqHuDEV1vodFx4TPMq2Pn/WjQW4
         2wbBXAesva4dBWoDui0LhTEA9M07tHKwf26BtF+XCRQFMp06EuhHB2TlynBqfhwqjoVz
         VJTLbw+u/AwQdH7ODrs6W1CD1/shm4TIAj++9TiiQNt07XRORjPMQlw6AvtyR/DbVFc/
         LJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FdI9Exj0v8OQnm3T+xWDMFtUnbuu07xMkRoM7mEsgJA=;
        fh=S/MRqFkozPJH8jDfJ48bwbdvYtDWNDXgcuJd3MLmaPM=;
        b=RH6Z+QJP3HWFuKbkruWt+ZblGL4J1+XBv2MWA9cqmhiUQNIaRWPqp+/dRD4mEeYfPJ
         jjNO7UM7/TBoFJRGUtVLGye4Fj6WHmekw92hdT7SkiVeID9JvoxdHz90TWkC299fnijq
         MsitRwOEyiAO2fZUohupwIi/bJGVC+IKJjyGWLyxSylc5flnpZ15uSwxkbry7m8ptXAT
         1na/ZxMnHGUSOkEd4lgbgqwi/rLcxrvumugZq1V01WegpcA3fyhLnoqsqbiqAQYomSw/
         dEwt6PUTptIpfI8DEwD6sJnDav59Jpt2tABckt5Xkdx3/BLs3z9ub6l3riIlPp9RQbGv
         phEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251537; x=1773856337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdI9Exj0v8OQnm3T+xWDMFtUnbuu07xMkRoM7mEsgJA=;
        b=Do6hQU7CfyiZCiIHY4bmlLbnLxwan0TfLdn2Zq0htzJ4O0GNXIrcmy08irE1ecXuqj
         9E5xibKWJOd5E2UCV6BJo66ZpIkjYYnPU7YfFtStxQc7ti+7GUmukzkD/K7pDoZIYkO7
         r4XGHEGx8gXktKPCX/VRYToNOcRu//cyWPB7/YP3chmYdIjAks3YT7H6UlY6vSBbQ5fj
         eJGovS7NXELIEx7YqX6pTFyyqk+/h5CFzGk2uJFFRxg3/qddubVysiUbKr+HqNjwgva0
         kFzZlJ8hUz0XGxKfc8zvqnQ9WnEgCEaVxbNbnzImtfn7ePMpNjtgARpaMhbBfc+uRC7M
         QnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251537; x=1773856337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdI9Exj0v8OQnm3T+xWDMFtUnbuu07xMkRoM7mEsgJA=;
        b=r3B3aWrwldp+MNfwbQhJlxVa/xX/uD2Pv5gLb2tdu+82cdkjrLAee5a1tStI6j1kHn
         2xG8OdlMtsIpu93KUUMGHq7LyNVoFKLNPLVXnkqLFMjfKwbcVcrdQHgGEv5IfmI9HkwN
         bfi3/iJ2ZvN14s6SHMJ0cFJ0m+wbFfefCCbRlu0KbWm918CEMA0j3yH35M3J1FzEwX9P
         +ioVCLNsIyD6NgG/y0u9rUNUtakYLqwUPBwRWf1I4G7tJKHxmfKhleIVx59zSeuBkm9v
         vx3JUi+l/5pJ7GAJTeUuw+nDQfEL6H2nZ16JNQ2SUPpG8tB+FnbcIHYIUhXh7HKVPnO3
         03/A==
X-Forwarded-Encrypted: i=1; AJvYcCVMsUzrVZENrqr/aobErtqM5L5PEPfofrBiNJDYTnCBx+EGvoOI1HOurBR0Yv2TaqSH1C4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh65KosZBQsTLSfRmLjQNjs+/Iw16SI1Ni5bt88sM8lpth/Z6S
	hC7y8FblrXkQu2wzALLsvo07QYE4lQWq1NoqDPLhM3I2mAOssZhvas+EJ5WovgxI31dRi8USlpW
	JDq17823tDaOaX3EelJnRQ7jfvOsISPU=
X-Gm-Gg: ATEYQzyBPXIGpj3/E7AGZ0SFeu+QZpQBCnyLDcyeCGthY157H3HJbbDuqRTjBokR2Pf
	wgaENdbbsntsK60ogYs0xWFlu6UmslojoZSc3fr017to6/B+b6mHQxI834ZL4VIPwLkMXPeAvRc
	zBFV1YvPPKgZllOnOfT/SrQr+16zGS36QXtxtu30BDzaAtmvmfc4nTbJLs5E/oLXyAJFMRPoXJI
	GYE9C4tglOTMkZwt67lziRySEU9bpiRMwnl7cfF6jALZb1CEVpQsQTQYkKAWe7r/FmaHa+/h0hg
	g1qT2H8=
X-Received: by 2002:a17:902:f60b:b0:2ae:b991:a44f with SMTP id
 d9443c01a7336-2aeb991a833mr8434945ad.50.1773251537290; Wed, 11 Mar 2026
 10:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306113630.1281527-1-alan.maguire@oracle.com> <b8ec9336-5204-4b1f-a7bf-995858b22b18@oracle.com>
In-Reply-To: <b8ec9336-5204-4b1f-a7bf-995858b22b18@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 10:52:04 -0700
X-Gm-Features: AaiRm53N3m_FOpJqyt3YFy_5DszUqVFYLox_su51bOe-o1h2In5UUlb7LuXacFs
Message-ID: <CAEf4BzYgArb8DhgNdOikPYSqCjYSasmT1TA8d26=WSk+aPWFOA@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 0/8] Add BTF layout to BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 10:35=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 06/03/2026 11:36, Alan Maguire wrote:
> > Update struct btf_header to add a new "layout" section containing
> > a description of how to parse the BTF kinds known about at BTF
> > encoding time.  This provides the opportunity for tools that might
> > not know all of these kinds - as is the case when older tools run
> > on more newly-generated BTF - to still parse the BTF provided,
> > even if it cannot all be used.
> >
>
> looks like patch 2 needs a resync with bpf-next [1]; let me know if there=
's
> any additional feedback and I can roll it into an updated revision if nee=
ded.
>

please see my comment/question about potentially truncating btf_header
(internally) and how that situation should be dealt with for writable
BTF situation, but other than that looks good to me

> Thanks!
>
> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20260306113630.1=
281527-9-alan.maguire@oracle.com/
