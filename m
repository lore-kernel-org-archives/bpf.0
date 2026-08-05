Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD93B71D9
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895711; cv=pass; b=QXq2VJ0deRgPxfQTMYVhvHjfLQ5CEIJB4uaBrxAK9pwYOLHDkK9knmYWJXC15IS4YN6c33kne0yk2XFUbGJD2dbMMD/UTdnWskuJWboKYRWR3W4BoZKHTzK9EApm/KDDOPKbwPuxJpfh3QrYfXlR5fZEDUuBO/ne6i1Ft0kjHOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895711; c=relaxed/simple;
	bh=UBrIoFn2KHvQ2srfH9Cda31RItNTXxlXadl9iHhPyaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOKEntRC70Kv6ows5n4v1gzJZ7dl7MWf7nsZBB55I+sSJ2TkHQv66Zht+MO8/l5f/7qyihrPyChSjmpqV4STCQ/GSFGNASOwWOSybE+EjNESzeLISTcnejz2rTr8dyfL//Im4asLEtP48OWl1uPoDVXNYJnSDqi2W/gpd9naZrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR4fcZJx; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR4fcZJx"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-44caeb973b3so298017fac.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 19:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785895705; cv=none;
        d=google.com; s=arc-20260327;
        b=EjSPC63tLPFslsD77zrc5ZU2IWQFsBXvaAvCABaBXLArSqixt1/fOqeLJCAEfg0iNp
         uW1GApICWg3btuRECWZUroY2xZoP0Xw0s33UUi1zHRTrVCnCGkJAv2qtkztXbekYwv3X
         G4INrZhYbagEZvM6retVK4dlCNo5MzUuZFyG+9DTzVJOikvgv4ls+py4EpduYcpVZa5T
         yi85Mt2ZwmhqJs0iMYQJIw4/cB5T4wZBiXlQdXO6gXNrGmMMpimVxkeWqEn3FuV1JDHV
         tSSoI3H40xE5vp7CZ/mLIZxefNaaZuspRJFNHMCxjtfwDWBsrmdqKiJ7YMhxavPUlLBg
         /AlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qn5iscN2QzF14sWFnednaGYMEJaac78X8NTKeF5v3NY=;
        fh=sDWn1j+/WnfOUe1+X9k1Kp3sY+G8hw2UEQpaqz7eYvU=;
        b=Qw4nc1cEY6auMZAAG/U6zfx2nqfWddcR/v4l5119+SpWdPTpNX2pDtgijDrkHX4rmi
         rPif0UhYw1SwL7MuG8Dq+jXp+1WoDatywW/F0zbpTnoz6PrLF320Teqm2R/BvoBvFUkN
         IKh4FkUVYf9AsljNs6ona/qCeeRr5UQS5aA7LK0f4zKrNw7CGZnOa+YhMWdn3BpHv0dH
         /qbo9cNjloP/8QRxRsEi1xy+smZ/hq6JvYxTyYDtszWwOo8jMfHvkYMdTgKL1Rypdw6e
         ZiGyaqLJDWW1FPfx2zDh0vUg6ytDSmLka8V9d5ZprwEHkWHcbSYK4Satd6NRRWRKePb2
         sm2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785895705; x=1786500505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qn5iscN2QzF14sWFnednaGYMEJaac78X8NTKeF5v3NY=;
        b=VR4fcZJxvOdnIvIq+tYeA2bDDQomjPc76bmTk/mL3euAUbx3KMdwAyUDFZiGXibByn
         Pgyxxdfy0YjN8ORq4j88eUS/6KQxNn0hDqagdnpZUrTgqpHV3UtRrPr77zBSZSA+TY5c
         B/dmb9gh21/Lkco0KGN3ZmiXG42WX7Veco1UWRka5/Z7mHSFQlzC328RJKF5URyqw1yK
         jh/jYjyheUBsY7rYzcCETUA15XwrAL2hTBxzRxMRTZL8ZAFn2QG73O6dTWL5cVr/gVbJ
         Z8HgFHmlGH7mpig4iK2lNp/oVLqdExiU7DQrDIHS8skwWJfcDnlwCXISE8MmD+WoAzgU
         pVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785895705; x=1786500505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qn5iscN2QzF14sWFnednaGYMEJaac78X8NTKeF5v3NY=;
        b=Ci+b3Mep+bJrChwGOMdaVHaVbuvalzddmLQh/9L2QxZToTlSFmPJRElnaQpb4irDMp
         p+/7sKcHPCVXmSz83YRfhdWofsoPdZ0Ijq1P3tCmGQmhpVuL+xqjNpMfdLNBWU6jjRlr
         JVUUFGoYlDZ5Bpjk4opu0wfDTTepnn8QXR73++FFyqvVEbk5zxu2eqGV87GydT8fo9Lu
         xKaKKqyRdxWaBiVCfhNBEiNy6lJHBWhxb15ETpzHIWxNYrHF0JBV6VnhzKZ5dEZexrKc
         7hA81o91KdXB74YL2WnImpZza/vl+TAQTzxSog6LpmKOfzf094w9LO8URvdQM5BRsKL/
         fNFg==
X-Forwarded-Encrypted: i=1; AHgh+RrwXnT2zmQ59RstndAPw86EDINiSPUp0DZGDncwm0RSd8z/6uGmfoArCg0CmJzAwInzBCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAS8muQMqxsNwpntnNhRRdP6UjGNAxhuMxpww3dyTb9Lx0W6mk
	w/UvGho/2xtK5oQCZ4+/Yq0/ZsgA5GNBG0yeJ7iQmBFN16WlpexsDjLjqEGTntWHPznpFyWTKM2
	2x5fmePkVOi64zjgRdSSUesoAPD1taT8=
X-Gm-Gg: AR+sD12zVUQAqrYZCEYsl76mx5AN62+8eK9Sf/31OpEmwvfCELVkcf62JDnlWYMpoJ8
	+/bV8ZH82myCgvC562RSr5nAccQs2z/cEi/5LhunYRmcfe5OpwCpv+cecY8aSGXZ5oCK9UERaX/
	aZK5xj9h2/O+IQgwZVOr8zQ0Rwfb65kpH1+mL+2Gv3AyLl+/MYFzLtowF3fDFLnR2mg/l4MOKEZ
	cedzuY6a+qhAqrjT55S19/TASnHbzPMD82sTE5MENDpLgHPqG9kuUqCjq9TBgpudLS0OfTy/HRO
	rWm5DpLzYNPjDgQfBjdgJdylmpHvQT1mnj0z7fhNLX8ltw==
X-Received: by 2002:a05:6871:203:b0:441:419:1fea with SMTP id
 586e51a60fabf-4599eda5245mr1938698fac.11.1785895705149; Tue, 04 Aug 2026
 19:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729022837.355549-1-chenguang.zhao@linux.dev> <20260729022837.355549-3-chenguang.zhao@linux.dev>
In-Reply-To: <20260729022837.355549-3-chenguang.zhao@linux.dev>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 5 Aug 2026 10:08:13 +0800
X-Gm-Features: AUfX_mzHgPzDCakbKSrKYJB9sJhoZ-nbaukmlgfyfjPz1JQxAsT9iKnGf1YwrHs
Message-ID: <CAEyhmHQOGZGJbdx21mBtZ7aNM8ZDnYTgCtLWHQ4pXy3jVcG3Ng@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] LoongArch: bpf: Advertise JIT support for kptr
 xchg inline
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, yangtiezhu@loongson.cn, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:30=E2=80=AFAM Chenguang Zhao
<chenguang.zhao@linux.dev> wrote:
>
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>
> The BPF verifier can lower bpf_kptr_xchg() to BPF_XCHG when the JIT
> advertises ptr xchg support. With ordered amswap_db.* emission from the
> previous patch, declare that LoongArch bpf JIT supports this inlining.
>

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 5417a5624327..686d333146ce 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -2396,6 +2396,11 @@ bool bpf_jit_supports_fsession(void)
>         return true;
>  }
>
> +bool bpf_jit_supports_ptr_xchg(void)
> +{
> +       return true;
> +}
> +
>  /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
>  bool bpf_jit_supports_subprog_tailcalls(void)
>  {
> --
> 2.25.1
>
