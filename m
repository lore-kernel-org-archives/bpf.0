Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F9F27BF6C
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983734; cv=pass; b=QCv82D6HTvXL+47ZBeP7GKeq7Lnd5NQZA3k4Yc0k3mR/XH60YilkbaeckQyTGcTDZi2CMYzRGToiOc4wsbrQP4OZXzEMAFm4EcU/nQhHh+itIIfItj8q/QMhYQgBAlouKWuch7uIsgx4pACYSCLuEKhOElVxcbRcFhkSYWCcoQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983734; c=relaxed/simple;
	bh=fSG7iYPHa6eh72+ECqC+nUnnjAWHHtqapODHBA60oxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiJ91qPMYMG6+XoTca44GYYAcc3t14c7N4Y4QhMHrNswxwAj8GpsIwYFYDSEVRVSB3/H13jjAlanX2tdNZpZJ5FxbjKF9xsjpX2l32BDJhnvQKuoCTq17kShrB/3RcvA/3nv2WMCv7XkwRdS/TraJig05Qhe6cYhQW9E04dm7Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kLYdFTTS; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLYdFTTS"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a355aedfso203521cf.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 17:42:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771983732; cv=none;
        d=google.com; s=arc-20240605;
        b=hqWHxEdhCmn6e2f3tR98botva1MfK/1ayDFNl/4Du41Y6uLUMF1d/xvA8LjZHhpP/6
         ApI4EWEwZb/YDlN+RzIzvIK7MRmLT+shmyfUoGLz9z+wFFj/Pxaa9FhzUaASrGbykHXV
         np4HPKty3hcmKjDl2A+yvtr4Ic9Gz+MDY/8PX0kz5dmjUHCCcx15k6+7Q9lE2EoqxknZ
         cvmi7aQhJ4W6VFSNgx7fdJbGRfhUbzIl+z/TkPpOfZo9ediQXTcvxb9zZ6RXS0EeZIOJ
         HVrUEsHnLg9m8u66nPmEBB02KT3mlhn0QDCz5HR8YDtu2dPQjwMhir23NENZPQnR9fiu
         Jnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F99IpJbD5AmJltFy7mpJIVD8IelNT1aL7uENGvnuRwM=;
        fh=OIeBx7gjwuFmzJaIFj1oiLHNUk1YxRiV3WgRmRtAtsU=;
        b=Tdc8U518TdnmBLR1r8MtPm/+R9Y6IG0o+7j05r/HZ/qK+TCJRKlbOKsp94/augeyQ8
         rg7JaUFqpz/HWL167a96sJ+cFG7TbI3rwvBa28xcXUv4trVE6flSbpmt065pS80GMZNF
         zAEJZ9mFGUqfwTJ36Nl4iAY0nM7HU2YkPWRxkchuGp47Bp1RQ18Z+M9wzfBgJnpc3Db/
         Mp3s1CymIsTMqjMKlFzVvm/kKbiuP1eNO4vY1pknUsLokqeEYvXRuyL2Y7uLDgFRmN+6
         SuHtb5ySWCiz4lJ3T43WE2xBBe9lMQIa6s61c2w1xXYbVw68pKB1vrI3AJb/50qmnofF
         PUtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771983732; x=1772588532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F99IpJbD5AmJltFy7mpJIVD8IelNT1aL7uENGvnuRwM=;
        b=kLYdFTTSLXNmamQBEgHpqprMLEnaMM80D7ysBacB+vVKfPwxa8nRCAHk+jk7WfJz4Y
         qkpUSvXiMHYGdHCeSL6OcaKLFzCbv/1tQ9Zv88mIo9m5JGzgHAI11u9n8rWUvJLz6k1s
         ZJKp/4vx7EWFvryKxHIC0mxjuvtbkPR2sIyrF0JI/9WcxLTFzT2ek2oZaOTMYvZSNEk6
         PVXFdcvaVHm/T40XT/HArcaTam3z23C1jdtmYBDQegM07dt+iDeSWjucf+W8MTdDdYAR
         X1pIYUue/3RC5KBpCK9ru/XuzzL6mJ3bv9zaPhpHp40AlvH0v79LZgCu2R6MFDwHj7aa
         MENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771983732; x=1772588532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F99IpJbD5AmJltFy7mpJIVD8IelNT1aL7uENGvnuRwM=;
        b=GK3j2yF9r/lAu8xloYXUfmqM5OCAlsLZiPbOwjy3Weu2hbzGHv4l6jRL2idMxo7bhC
         aHbMhrlSov7Rfq9da6D02ZhHtS7JA+MfXP6tXX7tzSTZQ30gxyVwFC6aduekxwxQHDpC
         5T84m0orEBSGhChvA/zZIBgMYiwTLeViwQvputpbZQaToURs583xYeLcduTM+svD5p/R
         zN1bIKe+VC66PeP5y1p6e3b1EM0nhOnZBhS+gcruRv85bAELdvB4UXnE1Xwt5jlrBODp
         tyJql9Ltgci1bWC/7MllPndtQLCl60TJwGM+DncWxFSCquzgFndvSXlGtxLzzxD4NLsO
         +jeg==
X-Forwarded-Encrypted: i=1; AJvYcCWiQokLjpiH+9IPA6oFevLLBjtFqlx2ydEbAY/w6BcPYX/lio9UrFPrZrHYYFtSJYpqXWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkB3sL3Rxz7qWKU1hdXJ/Ow4g96MI20+tY6CKPND+QrxP5Dua
	1Ul1rQkdgFFTgs3F80pzJmBzwn9dFUSRipnZfwlci43/YcFp23LHeFlM0DvErr/t/70R1NT+1wu
	zOg/Jk4Vm7E4SVlKEZeHONBrLqtmTyIG+5iyS1DPB
X-Gm-Gg: ATEYQzyDT/vYFo0GTXkywLd9QV3x9WL0Axlo4DtLbF44wT6F9zeiQz9Ben0DXTK5PDS
	whJXfYSyNdllf+12IJn8iTiRoxD2eZ7pT4m9qNDhAYJloTFADSb5ucsJdFnlR7j8b5qKf1uPvLx
	8hOrmq+wHk8rgEqu4tVbxIvQ039uz47FfWKgqgN03cj1o/Uc/Gj9skXOiJfcdpumgnkkOGoLNyp
	gEtqDi668h5QsaOzQXJsSsD8yttXh+ONhw3jPSdH5A40LI+Z1yYVCgO/P37IL3GGO6KmGMk1oHK
	2yYZ5vOl/vzJs6ZqRQula6Q1G/tJsOYy1zlr0g==
X-Received: by 2002:a05:622a:104:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-5073a331817mr1017391cf.7.1771983731358; Tue, 24 Feb 2026
 17:42:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225003349.113746-1-tjmercier@google.com>
In-Reply-To: <20260225003349.113746-1-tjmercier@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 24 Feb 2026 17:41:57 -0800
X-Gm-Features: AaiRm50kACbFZbXVHNUOAqky21tWPRXOj0gubJWsGd8_Mi6NEHNo7tC0V2PB_Hs
Message-ID: <CABdmKX28oeHEhzet+G9vu6Dm1ZwFu9OQNoeWaj=g2Y=9_9nUog@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Fix OOB read in dmabuf_collector
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: quic_sukadev@quicinc.com, jaewookl@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 4:35=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> Dmabuf name allocations can be less than DMA_BUF_NAME_LEN characters,
> but bpf_probe_read_kernel always tries to read exactly that many bytes.
> If a name is less than DMA_BUF_NAME_LEN characters,
> bpf_probe_read_kernel will read past the end. bpf_probe_read_kernel_str
> stops at the first NUL terminator so use it instead, like
> iter_dmabuf_for_each already does.
>
> Fixes: ae5d2c59ecd7 ("selftests/bpf: Add test for dmabuf_iter")
> Reported-by: Sukadev Bhattiprolu <quic_sukadev@quicinc.com>

Sukadev just let me know that Jerome Lee <jaewookl@quicinc.com> should
actually be the reporter here.

> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  tools/testing/selftests/bpf/progs/dmabuf_iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/test=
ing/selftests/bpf/progs/dmabuf_iter.c
> index 13cdb11fdeb2..9cbb7442646e 100644
> --- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> +++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> @@ -48,7 +48,7 @@ int dmabuf_collector(struct bpf_iter__dmabuf *ctx)
>
>         /* Buffers are not required to be named */
>         if (pname) {
> -               if (bpf_probe_read_kernel(name, sizeof(name), pname))
> +               if (bpf_probe_read_kernel_str(name, sizeof(name), pname) =
< 0)
>                         return 1;
>
>                 /* Name strings can be provided by userspace */
> --
> 2.53.0.414.gf7e9f6c205-goog
>
