Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9273446C2
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973422; cv=pass; b=MLbuk/9aHtPVeuEBwuzIfvHH7L6L0D0wsu7g7uUhQlIBGj/rdTxqz0pjCA65Us5tpq2DQAVqd52RouzviX5LRtltTWNNWuEmp69q21fLPwPQlfU0tO8mEwICS/NbXd1YG9e4j9mqltjUgO6XWuUOQ2WFr9BCv9p1Q5vPk2o2zxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973422; c=relaxed/simple;
	bh=fQZ52x1X/lJ8Fj1fedjOeJcb20NkVPIEXg2MWzdaV0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozzmaKsvGXPAtxhmlyecCA4dCRk+6dMtqE5iE8GvEU/MaKo4yJ5R76r38dTWzEwvX9p7pANEzuxeaDKQGA3SzOYw1wNmPFJAOlvCY6AOqtQvaF8kUDNl+uA4MeMtTD5U5D+BCQCV7vvazqOyQwYm/AlgHy2wvICanXtvOf6/r7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDiCwy9O; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDiCwy9O"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so35421595e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 14:50:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771973419; cv=none;
        d=google.com; s=arc-20240605;
        b=e4GsU5kfxECT+77Ou9N6Sx1V9B9/S0xx0Q4KQ4ct1M26PYMHPuylCaBcRwERQRom2j
         VV+COSD59xSQn8bJC+6Ae1pKg/UZ0jCb1VNcL0DOZi4ySSaCQkedOGcMe6YuS3y1vFQB
         QuUu5RgZb1SIRbFFqNj+7zMy4whoPuPilUUvi0w/IiMlxAgtGfOEimcDJeOfUyjmqdAv
         6ijnqlo6hX/nt8AxKXNUftfj71eGA39hm13dHBTvFoXPuwrVHHJdF409x3Mvac0d6nWM
         EwdXBr8+IVc1pulBXmRyiMK3YbQzmMaigEJ/XHYElVGC3sS+HvujU6M2S3OZ3L+Mz0rd
         bB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KrCq5+KBoM2cWeCyN3CRmB9j5dBRZx6i5CAD9No0B+8=;
        fh=BcTv/aiNgrpgr84GI6wt2NnKnsyD6IvBm5QXVyLMv6A=;
        b=iX5HNyJyKHKckArqXdquenZyifXGaZ4EIcQM/hVBEk8CB+kh2BBG8aWyAl+PrL75vr
         EMnnQNOjwpn4jWmbHGTGrbFSRfdfDbrMRJjzKQCf1zj5glOzsZ3RSUPs8y7RTurcJPCZ
         TlcAJ3PKOZavG73Q5oqO2cjmY3jd7igG+jya2wMm7E0H5rx+3B5oncs816q0wVI4UqIK
         w5A4EI2Ow5pkuPJQJGFoVqCK7imNWN61lqN2YwLAXeJqV/HJqRkVnueiOV8rSq5wTeen
         F776yI0WYlNu1Cal2vLK+kf/NtN8ivi6wGnjPiJGmdBg6VxUHAHFsHpDeQpbU+jpd7dR
         nlKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771973419; x=1772578219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrCq5+KBoM2cWeCyN3CRmB9j5dBRZx6i5CAD9No0B+8=;
        b=CDiCwy9OAhXilC//tDXqgjFM6YVI5X1j3jZ0akxWZgOSRThWhu2gh2wHomFP9odO1c
         9ymhXzecmqSyWELFNxWDlvJfiQqSpU2oa9e9gh8gNlkirZZoVSJZIzUWJVDWVGYhYH5P
         /OqQzlquhBevC9VVtF6EQHQZsa59ZqZ+mSfPlOfpTj6eKUALitaUHZ1UX5aor3l+zhJ7
         yT2ESKyj2YXSXv8yrtK7mRC4phJu2d7jjhlcF5ZwuVt+pYC9Uio8UunuoDcJtWWyy6RZ
         C9FaVNm+oT/+hydwSRsLOSZlu5kCxTR4xeCGc1/JwfJpJyxU1cvr1PZo+JNmi3WlNbuZ
         z5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771973419; x=1772578219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KrCq5+KBoM2cWeCyN3CRmB9j5dBRZx6i5CAD9No0B+8=;
        b=m8jLBVvGZXcfZwsBIbJhcQAT4AAupuyXcy7TwyP7Rau9x/A0D7HSeYoHaYU4PBNY2s
         wLBmVWs+Ubw5NR2XAwwhJx0MwOqdsneyMlXtVYN1qfzM/686dEb3gz1BAG7yaBl7S43Q
         TNcbKBXq5JfmCIV7/SQyyK0yVFOssBU6+HHxw7a1er/NUllMwp/pRh00JSW9pokMtcTl
         QsC6DK486QrNdjH9C/FjVwleN20nErqcEYYI+q62bMd0Frbd2gjwKT0vrkfGvz5yos9v
         uwau7NY7H2Di3HjE4H/7/T9fLG0ZCjWRB6Ou4c1L78DLYLXRqhloVcxWt0C1Oc5ngs91
         a7bg==
X-Forwarded-Encrypted: i=1; AJvYcCXqC5ER929jugwm53w1xR+9bf20SaIqtCrnJfN/bDw/BUHoofkW/bvRKYPllFWsSZyE1v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+iYk0HKyipFsz50dx9HaDvng5msxRjuk2dnMd0ZRJ9DXpsSsi
	2n2+My/+2+C9pnr6jaB+gEGh9JJT1Mu6czGStD3tAUhfg27PVi3tDHwGHv1pmhBp0JCAIrzWUu+
	kyZ6XEh4sB2M4/5tyU340yDg0XvL4R4Q=
X-Gm-Gg: ATEYQzwWA+ejtc8cTMfKtkMdduAE/p0KrEsbux1qwvkIEZUU9roNOp8aYZdwO8fyuPS
	DSGgfs5mcvpqaNog1aSXcZWYpOL7eaVbFqg76LBEQBOidTB189IP2op8zUdksVMDKptrsxRuuzp
	qlawgqhcxfQf8/rTKRiwlBGPFA3P4JjWycJ9VjlQynGFQY1AJAZHvHMVRLgkZqZZ0DfVFILHhhH
	qTuXYFBzDPVR10HSKBs7UxlkhXH0sz4VwZK0lsUlulc2JkLMd16HE6027KKtjZbmptSqtwGplJs
	uzRh5KQhB05H9p9iyMt/xuUM/O9EXfkzRhes1EKURUquqrnOo75921/la3sUm7/7gfVZ15LKDwW
	/+MHfE939dilrT1lqjUmpsBfPzjuT2uSI+MJ0
X-Received: by 2002:a05:600c:3111:b0:483:612d:7a9a with SMTP id
 5b1f17b1804b1-483a95622f5mr239154765e9.0.1771973418610; Tue, 24 Feb 2026
 14:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224212535.1165151-1-puranjay@kernel.org> <CAADnVQKO01A+PjwYCu9+HB8PK0Kb4+HGM0ZseUzY3eDMvSPqDw@mail.gmail.com>
 <179f2b813fd096a3975dd4a66b5da063fb593a64.camel@gmail.com>
In-Reply-To: <179f2b813fd096a3975dd4a66b5da063fb593a64.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 14:50:07 -0800
X-Gm-Features: AaiRm50LjBb16ALFEpO0fVEhhCxYkCLd6WyUW3AJdABFOqy4JAyOIRpiHFsvals
Message-ID: <CAADnVQ+vjJf9xy6Oy5dCy_F2hvKt6TwZ1jA3Xv2PxMDpkPksXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/7] Introduce KF_FORBID_SLEEP modifier for
 acquire/release kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 1:53=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-02-24 at 13:46 -0800, Alexei Starovoitov wrote:
> > On Tue, Feb 24, 2026 at 1:25=E2=80=AFPM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> > >
> > >
> > > This series adds KF_FORBID_SLEEP, a new kfunc flag that can be combin=
ed
> > > with KF_ACQUIRE. When a kfunc annotated with KF_ACQUIRE | KF_FORBID_S=
LEEP
> >
> > I don't want to introduce this new flag now only to be
> > replaced with KF_ACQUIRE_LOCK.
> >
> > the follow up we discussed in the other email is different.
> >
> > pw-bot: cr
>
> Then the refactoring should be bundled together with this series,
> otherwise it is very confusing to have a flag named KF_ACQUIRE_LOCK
> and bpf_verifier_state->forbid_sleep_count, bpf_reference_state->forbid_s=
leep.

The name shouldn't be forbid_sleep_count, obviously.
I argue that the counter is also incorrect.
As soon as we have two iterators that take locks in acquire.

if (..)
  iter_next(it1);
else
  iter_next(it2);

will pass the counter compare in refsafe().
Both states will have forbid_sleep_count =3D=3D 1, but they took
different locks.
So we need to compare refs in for (i =3D 0; i < old->acquired_refs)
anyway, but then why have a counter?

The bigger refactoring is to generalize all active_* counters.
That part can wait.
