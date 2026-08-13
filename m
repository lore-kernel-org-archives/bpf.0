Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE113346A0
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786658679; cv=pass; b=FP1194U9GsadOxbieeQXDW9PO4nAH+HIzUbvIY5PnGiSxSzdcOrD1M7p1xU3MHmesj3LF0r/251tajHtEUa0HB7+jInonXRfoJyS6LWmtS5te/DwPcymt93UKstwqNOSbCEkpCP1KZD5BWZte9rGyhcER4zEyjsxYvLC6G5eQdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786658679; c=relaxed/simple;
	bh=+nJVwpFMXbMjPE1ueHu/52hziTr3b56pfhCEr1u4jas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJJImz94b6dWN3hHKmtf9lJ2WH8SjK7o7unFuYUYFpC/IBBlvAMBEkdnEIWn+6HNkBKzj4bFEtiMMolVkr8q+pMLQnVhbOgo5glUcizPeDe53uKpL71FL2xacYHsEs3WEj5vDcMkmbYWr/XtUyOfoZerpVwXkkEKTwpqP++13RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uodc3msm; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uodc3msm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so5101515ad.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786658677; cv=none;
        d=google.com; s=arc-20260327;
        b=kpzj2y7FSZgLST/qHyFzFCY8SXFVCUFgOlfAXD7nRAS3pinWzwu3jaQv3l6+pxQcYI
         BjNzrb+kfhGAdEpzCB+iAnkQ3u8f8zP1YaBs8hSP/+0BnoMahNk6eV06xkRqaTC76pfa
         Q8aa3DGkAJrvswlkcNETDF2jIk0K1Blcf/zEy6r0ErsPM8SKEqUkIaQvdyuqvqt0zApd
         z8gPftCsNsFhY00z18EiPnkSvVZaZ5CBCchBLq7oQV4tO9ZcfJGTbX4/lkPmZslvvZzO
         FU8AukTPI/X67iVegi6nuQFlHWBK9ynA40u0O9v9jp7WN799iLusVs+vs+cgdV1eBFpG
         faBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XBjlbb9xfnyRrsn87ZRRTDGluqDs+J3ckgA2mWnKvPI=;
        fh=BxnX00Zwhuuj1n4QmEPi0G/q0Nd/AClBQgfShq2ikxk=;
        b=Z+Y/H89Iih9FZO+Kh5JzDTAo77raITe68Ui+7jAkcWAvIV/XMo1zAWcorpHyssMSPt
         wow0UL/qe9+kHS7fvtThDG0yEL8I/8f/XjB2pgaVIXLTPODscGtaxqNJqterbHp8e0oD
         XFg3vLIpu/dbEkOYW1e/v6cJCwx3Eckfy52W1gxFNxEqmkC2GRTF6uLu66nntK10LpYL
         IY3UfMxyUS2J0hxZNVmarCWekz8ZnTT06onw13+KQh+74jJY+Ul3u00cpsrPpy7V0fMd
         jGtzfFZJEuPUmLN8GJyUpT2Be7ZKtRhQKe17QX6sfjI4yS2s6iiPWCpDvvuEPu+YKdbo
         bYRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786658677; x=1787263477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XBjlbb9xfnyRrsn87ZRRTDGluqDs+J3ckgA2mWnKvPI=;
        b=Uodc3msm0IhpYSQj8VX5kovwarQak0zWiB/9IgNLNosdzdKvi2WrB3Uf2GCxS1QiYa
         7E8ILtr8/gBU/JI+kHVgNqEAyqnog40JFkEEx6EIc0tKMCffuR2s3Ppec0SV0Foyi3C/
         hK4oaTIlwjpd7QZWvfuAF7jLYQU+A3GG5tuYDdP47Xic5giy8V4n1H83fDpp9VxD2smc
         I5QMchWfUqLNQy4pIKZNo3yQRKxPblIxt8Nl0+md+xDjdNRyifsH+4Vw8VtWPCUWG1Zq
         zVCfVtQ+vlA04FQ0G4y+ctnOuX6HegjNDgeCyWCcbBpblgUhzSYSgnbHgZkvjSteiP3q
         WY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786658677; x=1787263477;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBjlbb9xfnyRrsn87ZRRTDGluqDs+J3ckgA2mWnKvPI=;
        b=GoIb54Xp+B0rIqccSlZEp0VwdVcQ247TNMTsrhpAdDy+E5Vn0FWvIdAusGN5W2jSRG
         efhSUACgAjVHHaKIwguC3qbF66hrOeBdYSF3xesitXwN91eQXXrap62qZeVaIQM7c3PE
         k69ND9xNtS0wEi4/C/GFwHfG7YqvOkMECchFM9ZaQ9NczKWPXyMZf5GiuAVqUGMg7WGm
         Bw8L7z7wnCijKbYN12KEngn5GkGdpP/Fh7Cg94vwuV/9kD+8d3t9u1DhME5+aJWcTzEJ
         IojXMCRu8KLptep5EMgrauAET0b41nENshRO//23ScxTUA8FoCu67WEBy6SEArFoFN01
         A8Uw==
X-Forwarded-Encrypted: i=1; AHgh+RofHIQlCirt4A4wtXeIRl6bo+TpCeUsS3bxROgK87WirdZhjPBM1IacgFK6ifM2dI9Wq3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzIn/1e+meMm0Na0izNdrhKFSma9yuGzyt4WgjjdU+GlSIRW3s
	MxjkoIL1vmsFitabdlztcFr99rp0dqeM1p4CBv0K9g6eEtCceBparG6a6JKmlg59JUrQuF+VZRk
	pYiak5oW0h2e4sylgEJtPjf3k3bf2toyFyu6m
X-Gm-Gg: AR+sD10REw8afjOHOwOpXCh0V/TSaUrHE95Xvm98DXlQ9nqV+sIBN/vNCxoqic7ESpo
	CPM/zdkI5rxuPQbbnlWQ7wvmewRHXh99iu2LQLdCsFfQfi4z4kl5slGYl1/e4VdknWrpkGOBSgI
	kqd/zjaF/Km37OQ9z/fkNMCXmMKwDycr7BdPAGTLz194BW9rWL+tmbTPTPyJ93fjyOpLBn57npG
	9CAHRWZxU1QlWNSsyQqBd+QIsH/IK/VZ9P+rIv7sivgCJPZaxoUHJ0CKM9A2aiiOYmzZByv5OzG
	hWH8h+9CSPSQV+EyHIo59SxiJumzLJEvLCM0YWC7Cr42gs88sZUjY903n4m1KHVRihLTqCMWW8j
	sZbmgTjZ7pueekrpJhLQ9Gy5e72D5nfsXdpVzCe0lWg==
X-Received: by 2002:a05:6a21:33a2:b0:3c4:3321:4fe8 with SMTP id
 adf61e73a8af0-3cc71be2ba0mr896598637.14.1786658676974; Thu, 13 Aug 2026
 15:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810055709.729203-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260810055709.729203-1-chenguang.zhao@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 13 Aug 2026 15:04:22 -0700
X-Gm-Features: AUfX_mySmBbuOKMkZzyA6luWIOwiLVFTaBzYxN1T4Y0G-POAuGd72b9d5snmCP4
Message-ID: <CAEf4BzY9YaeT4CssCe13uAWXYHXs6HervsCo0Puc0osfr8=yVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add kptr-xchg benchmark
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, shuah@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	chenguang.zhao@liux.dev, Chenguang Zhao <zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 10:57=E2=80=AFPM Chenguang Zhao <chenguang.zhao@linu=
x.dev> wrote:
>
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>
> Add a microbenchmark that repeatedly calls bpf_kptr_xchg() from an
> fentry program. Architectures that advertise bpf_jit_supports_ptr_xchg()
> inline the helper to BPF_XCHG; others keep the helper call. This bench
> makes it easy to compare the two paths under the same workload.

but do we need a permanent benchmark for this? Is there any valid risk
of regressing performance here? Unless there is a good reason to have
this benchmark readily available for everyone to periodically run or
something, I'm inclined to reject new benchmarks and minimize amount
of code maintenance burden for something like this, sorry.

pw-bot: cr

>
> Usage:
>   sudo ./bench -d 30 -w 5 -p 1 kptr-xchg --nr_loops 256
>
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
> Example results on LoongArch64 (helper vs inlined):
>

[...]
