Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E4E1FB1
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752100; cv=pass; b=Lw4x2oT2QWdxECyHa1BZZn/7s1xPbkyKugqYnKbMKI2RWkLaAahMaCn7gmUsq4MYOQa4adj9K2Hklr/2ze9jTYn/jVc6lxV/UjxIagYHH3zkiDykSSumUN5E8rLKD31ZeFzsFKt7QLmhiYZBo8hq7rhEuVybXTjTVETy5BANjco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752100; c=relaxed/simple;
	bh=wvsnxa74TKJy4c7ZQc1gWWQ/xZ/zdV9+82tkuhcupAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJDgQG4mtjNOBIReMhLfQXn8wpom6VBhKzlrgOtmk9iqiSp/3nMmv7TbfP8OBJV2bKsnfLrdVHferknBOGu4dnhavg85FlJTAT62NwKqt7B5m7hO8kOCWtEGj3b54wHjiY7J1Kz0PQ+VjNQY7/F1KHXjPeg8OpS45GJ3SXHa4W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqJybD2h; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqJybD2h"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c6de0527ce1so673030a12.2
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 11:34:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770752099; cv=none;
        d=google.com; s=arc-20240605;
        b=SVPT2PMFIKypj1HnUkN0MpVTidB8UZvpUpiVoAMUeYmhUrRTK78cKSq7O9UxYOd1T5
         uXQXPvoSohTf2bY5uWjaGUYbmHBPMwJ/J+9uPod+IDZ3H8LBePLx1gdVRPWx2+mU48b/
         0/ts4ioso8in2b9xF8FA+qcityop662hfaFSmQYSmhAo4omYj5M16rVbR+R1u/Jb/OVq
         OihnnzsnAQ+1x+2zYUfoADTsH22kkgFSKxkZK1Jsxk+QUBIp0RNhQCc5Fxk/z4QE68Up
         jml5dcPbU3Pjmf5HDA00udUbFt/bAxyc/gTiOzRuxsOEDT/Dp1DZxJrSMjLujDtPtabn
         ZCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=olk/S7sKsr8kJ7FVUod8Ng32V/mo6at8A/eO5ALypss=;
        fh=5W7D5ejmHkQP8O4Yht/2olSo3AI8Dt6f8Ap6Os0O2jc=;
        b=Jk/QF5uEuEUQ7ZxI4IN825GX/nrzhevMLzqn7kGAk9deETeD8bxTGFHpX/0LSm+7Gi
         koVufMFN7g1CCmfirXBBEbkttb2Af2qveUYy+0PFgNq7vVMpZRfjR5VvN2mMAhxAlX7u
         RADtrB7Hj8AwlBHyVbjQRK0zsd4G2R1BbtMh+NPtgPBIH9PPLq2Dy5wJpEt7+3g4GhzM
         BYq3W/Wc5NT6wITctAYrWfhU6C0ltgrszBd6UUFTZ3O8BCj/xARDjyDv0oupUYLgZ1qJ
         2PJBgo7y3lDiBKKR77TGF61jNGa9uJRb3bKMFStDxK4Xm5jHB8XKqbFqM/qbtjtzGU0f
         GXyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770752099; x=1771356899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olk/S7sKsr8kJ7FVUod8Ng32V/mo6at8A/eO5ALypss=;
        b=gqJybD2h8Y2plNPoECgw/TNi4RDjYBHGeinPNVET0XBCh8zoKN6df0xc4fHEgdjbUb
         lKyMdfCG2Uaq/YCxyUMRxOVw7u2FsIz2Mx9TERtis0BDKYqTarwqkeav+DEM2P8Krf46
         RBppQnQ6Kouavu+LiVEQrHVz7TVirP5f/9mi3kid4O08GEEOAhjcEcDU2C6QRLJkWHmU
         r+KsEw4S7Up/8yUyxMCEzutDQCN1tzxNBX2fq+URR7t3NBsl/D60nPxS2+WmpgFiYCpg
         LTczW6QUD4BGSPJ2UKFAmJDplHheKui7WjtWKXgIaImV4lAfJnCW38IHr6qNvr+2wB3t
         Gmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770752099; x=1771356899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=olk/S7sKsr8kJ7FVUod8Ng32V/mo6at8A/eO5ALypss=;
        b=pynzdFlXvjimnvOdaBIur1GbKXYyLGt73tQnyAolcAJvXTEUF0CTB8JWktttIQ6yu1
         dNxjUbvmccAbnYGQWxv25B6fMnykLbiBeomjFtiHxxqi4A6r+kKBkXpm28x6xTwifNvL
         KX7Q8B7JqlRyFSTqsHdIG8teMMrJ/EU9R1J+bkO2nlpCHr4/LF+vpwGELP9VWA/XwWlD
         L6GMteyTgfF8qZrkHiOXEUBCZbjrwwDNHvRbz4x2bOSkThZ71FYBXkg7tXbk1jtW1ISW
         IsKN1fpHuemI4SqktbB2ZMPmXuagVCtI1tNBtcf2+KfdGinzlDJFG8p30pVdAt/ji6Ae
         S9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCW8m8GacdI+Ul7habkui9YtaPNA/EIdckXchDoDDg0s8JYuGT7RgsIKBRreH8LJ//p2Ehg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzARqGb1mQezo0niMHNzp2qNdMe90HUe2++8D4cjtqqhuTQY3MW
	r2S0Zpy+rNGONJRgUN8J1bdxVN50m+f6B12NLsmAVhcmAUpynpl6IL1nTdayiY88vt5l7zMiOW9
	3OB6QkS9RQvo4T5PbnogGflwN1olMaKxIag==
X-Gm-Gg: AZuq6aIRN225b21czLjcQ/6UU0Rvl0z48iErbisr1GnHNmcKlw48cSiEy4n8/ht4o9x
	Qezw6uQttatUMIaYs8T7/u72h7iTuJLbctBpUxFCZdZwniy3fRZWz+PLJN0DAQcdG+6yelnWqzR
	YeoKLJ3Ed41auXKpkQlOddiZPj6td0e9t2DjPBfeOe7cbN/7ZQntf/wCjrvpnTBK3IRUll6Hv/t
	qNgDxi1tIiIkumNX8WITMDQsXxzZj+ArHLmEZYTP//cpKCm0igvXMFX/Y1m7jHMZlEZkKQvS7aJ
	KwuJRcLz5p8fEOK6QdO+JhM=
X-Received: by 2002:a17:90a:e70e:b0:354:c629:efb2 with SMTP id
 98e67ed59e1d1-354c629f4aemr10288260a91.24.1770752098762; Tue, 10 Feb 2026
 11:34:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210184532.255475-1-emil@etsalapatis.com> <848c629364521da9cb0fa24c52d6e034f3346c5cfd824faa12b0f139de16ce74@mail.kernel.org>
In-Reply-To: <848c629364521da9cb0fa24c52d6e034f3346c5cfd824faa12b0f139de16ce74@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Feb 2026 11:34:46 -0800
X-Gm-Features: AZwV_QhKs31ctkJ3_63SSYJ7uCw9_3yzQYOqHzemCLrwUaQmz8oGhHRPaCRlS8c
Message-ID: <CAEf4BzbVOA6VW57QF14HDrF_T3qC1nF6NiENfqJ3696gFD4M5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] libbpf: Add gating for arena globals
 relocation feature
To: bot+bpf-ci@kernel.org
Cc: emil@etsalapatis.com, bpf@vger.kernel.org, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	martin.lau@kernel.org, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 11:19=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> > index b842b83e2480..9689e408ac58 100644
> > --- a/tools/lib/bpf/features.c
> > +++ b/tools/lib/bpf/features.c
>
> [ ... ]
>
> > @@ -581,6 +643,9 @@ static struct kern_feature_desc {
> >       [FEAT_BTF_QMARK_DATASEC] =3D {
> >               "BTF DATASEC names starting from '?'", probe_kern_btf_qma=
rk_datasec,
> >       },
> > +     [FEAT_LDIMM64_FULL_RANGE_OFF] =3D {
> > +             "Full range LDIMM64 support", probe_ldimm64_full_range_of=
f,
>                  ^
>
> Andrii requested in v3 review that the description should start with
> lowercase since it appears mid-sentence in error messages like
> "Detection of kernel %s support failed". Other feature descriptions
> that don't start with acronyms use lowercase (e.g., "global variables",
> "minimal BTF", "kernel-side __arg_ctx tag").
>
> Should this be "full range LDIMM64 support" instead?

that's ok, I'll fix it up while applying, no need for v4

>
> See: https://lore.kernel.org/bpf/CAEf4BzaLqWT1oj-EXibyAfE0ExmiaCCqhosRujD=
i7Y0Nyho6dA@mail.gmail.com/
>
> > +     },
> >  };
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/218783=
98162
>
> AI-authorship-score: low
> AI-authorship-explanation: The code follows standard libbpf feature probe=
 patterns, includes iterative review responses documented in changelog, and=
 shows natural debugging artifacts from review cycles.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Minor style issue - feature description capit=
alization should be lowercase to match other feature descriptions.
