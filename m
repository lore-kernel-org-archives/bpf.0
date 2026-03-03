Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D8A370D69
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556158; cv=pass; b=KK9+gSycAGEdpuJ944aJhBd+gsLtONUTsv2SLsGhnpxQLdtYF6rc6sFKjwmBuDoW/Sm+9aOxTUm7SR3W/sIbz9f2FXlaum6NqzJQdMcn9z34fRSHbb3cA9Le4KKEbOb9zbxnOr9l9oEOYbnHusUzqhknKqqSR+MzYeWXmWyPV7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556158; c=relaxed/simple;
	bh=7JvXk++3M1m78vxq8QaaUB8+rQeBhu0K1iuQSRtYBeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvWiSZgVQ6UE0sweHU51iNpUQQmEoVcwNCX6J8O4LM0w55YgJv1xEyKw8xB12gDt98tbY0j+TsZ4QGsNLj/b/CwbP7XOEcQvElkZR0phbzmFb3zyH+SLyxsolzzY4fkO7+S6gXyYIzdUgQ+EJixiDol4sfaKn9hbIDLRb0bqEks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMrtc3uS; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMrtc3uS"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso2974836f8f.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 08:42:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772556155; cv=none;
        d=google.com; s=arc-20240605;
        b=FfoR1Ed1RRp/KknUolaTBsNKkUZihSDfMTQ+GaCcsOwj0N/fdKz03R1l+5/Cpg/9rJ
         BIg6HrM9jyie86tMOlJEcaEEt/+E+Qn6kLUJftYwa3/71S30d3mqmXsRSvJM3Nxr/tla
         D1/xURYgLWOpFKKgpIAo/L81RhyKLcjo7XO1BsbayaYfa6MU75sT95r1c/k53KNHPO6v
         xelfiYvKztDUBh6RE0hgWx6ZQcisRa2qdRSgfHM8KGkU1fhqUfIMbMp8JFxcS294LjKv
         Cty5Kd/RwrYzAR/9GIVy8WU/3BzoFwwK37bpJBQ/oCT7r5lrtnMCRORzVu3MMnXiYrTh
         qwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6xZpzonFpXkHFcLRB+jkxCYNlqfRJJLuAPplsGIcMP8=;
        fh=fLnMN3SbBaSTZo4F3goTxlEA1vMjnBNs0i/lm/gfffQ=;
        b=bfUt+jU/r0OB+GvTde//mMhdtn0SguwJValmssWzF35u0jvPT5X26PSRHx0UfqZlA2
         4UtJ5ps6IIGWr/e18u9AKd/FapwjJRRq+v91V1FBq1vYmk2/ghhmKPBtzSvOXuxZzSL2
         qZku9lQVXozatOl57LughWggj4jP1ZNwSSkZtOPmYDpZfBqsIIG3wqI/1PzOVErD2MO7
         ChM2eoVDfFaxYQSkooUchjyudZAgS6f4NArGem9joPqKKVMAgH1SmVaCr2EqgOaGG9+i
         jXmQQ3Y5zYoivynfe1umXadSQE0dIiwZwc3AU1UgbMRqVy5hHEmsFh1T5q3iZGXGHlLW
         wRzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772556155; x=1773160955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xZpzonFpXkHFcLRB+jkxCYNlqfRJJLuAPplsGIcMP8=;
        b=jMrtc3uSM+FCSIf4ve3AlA5ZObxyicjH3O89umWHwUnWfZKFL3sBfXt9GMkwAyEXVK
         LjUMgWBMBMYhBP1qaHpX8+MaauiB7pD/dzAzWJ+rJ043pK2+gxpRHgmGlozfXDmn44Xa
         3Fo6IAiT0WQfrXM4tehGBdal/3ArSv6vvj/idAkcZloH0ZbiLF6c4WHgtXxuVY+wrsMD
         w01WCvABzpmuRnedOzYUNx5HC+lp7hDMQNyYfeLEhHemRwGu9KFRX71vELXkLqOpgeGA
         NvfFAVso/TVe+7VTK9vAWkclm5e5M8IhiAddXTWEuWEBka5XXQ7w4TnsMBjf7Cqs4xhO
         J35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772556155; x=1773160955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6xZpzonFpXkHFcLRB+jkxCYNlqfRJJLuAPplsGIcMP8=;
        b=sMJ4M2l3TzgnmtlRP0bU7racPMf8xcuKtFsxQ25JUHEo1fBB2+g5bgo32LDTq978YZ
         1b2vwoBojSPzuVHX2cQdnycBlrzq06Xz1GAunzS4mXfNNP47+R4e/4UVrxy4IBJyC2r4
         HKfr76txastSpsRk31lbw/PRW2/HD4WsE/s/4DIXhsOpfQu0QbkvDGDzGPm2CGWf0nuV
         Axanp1e77BEeBOQl8+VcSzOW+Cu1U2TNN6OfGrNkz13lnciP6fpgeyaARdqJzg1utqoq
         c2oAQcCbVcKthUje+noqb8D1U8kOxt9u+wIXKb4/SfL4/D3N33ChYq1AKoS6gCH0KQ/g
         wpag==
X-Forwarded-Encrypted: i=1; AJvYcCVqtfs/6Twiskc4Myaye24dSaEjVYiWFzuXB85+Q8sfKTQGmim5CTHiSsXLeqdq9YyRjMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyiLFqGtWAf6IEy8L7jWgGoeVIBg/IhpVYyp62NBJ+kJWmFfWe
	kTZijG+MYeU1FqqdZwDyU+SBgVQIsyiok9wtfCsn0RQF7K8KxWOKVAtEZQ5inbtxpjIcuo34dxL
	4oj3/l2wFffFeQ/LijFxPukWAQ1T5+xE=
X-Gm-Gg: ATEYQzwAgj+oLLO5NLzH22NYLoJuzjAvmIrittzJ7lb0k/8rG1RFV/w/irpsCfmIUQJ
	zbdFLdDkk6u2Huet4mkrRR8vm4RYRxKvfqx5Fh9/2/iHGUNJKujd8z4iL8n/GOgliNjS/WbB8/4
	7G0ECx+77gqV0Fq8xClw4CzWniloidEZ27ZlwKj1vg5QsaG4uYl251m3J7iPwfvbJKzgVxLwFHU
	+NWXJO90/5O1czgCaHNS08fdFoG2OmC5p7oN6NCQn86ia3zSNLh4i/N+AVcq6JTzm4KVqilnjEJ
	n/GsJxTp630TnVy2EAm7a4D1cK0Bjl1GTaex7ER9trwJxOsez+wYv8wD+A5rf5HqD6aLGKR64lW
	Pl/zLbQHD2vD7YuA9UA+ZkHpMSQ==
X-Received: by 2002:a05:600c:b86:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-483c9c196a5mr272506465e9.34.1772556155174; Tue, 03 Mar 2026
 08:42:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ebce5bbcffe226e4ca1894c4970d094fadd711f7.1771950922.git.josef@toxicpanda.com>
 <b3fd82fe09eb200599e8ac8e24ca4f9b8b995f0902f2d4343585a6b8291e6229@mail.kernel.org>
 <a8f149ea-2b96-43b8-8cc4-8a3e58c230d9@qmon.net>
In-Reply-To: <a8f149ea-2b96-43b8-8cc4-8a3e58c230d9@qmon.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Mar 2026 08:42:23 -0800
X-Gm-Features: AaiRm50lJg5MtCFnpC3GjN7IxZ4ZgXWTp7AN1zhhxxaek--GFIYfGPkTbsJQ2jQ
Message-ID: <CAADnVQJ+RkHzOQSLSOrir49cbFK2VWJUNBmssG7Hv3LGAfg0ow@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpftool: support merging multiple module BTFs in
 btf dump
To: Quentin Monnet <qmo@qmon.net>
Cc: Josef Bacik <josef@toxicpanda.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 5:47=E2=80=AFAM Quentin Monnet <qmo@qmon.net> wrote=
:
>
> 2026-02-24 17:18 UTC+0000 ~ bot+bpf-ci@kernel.org
> >> Auto-detection of vmlinux as the base BTF from sysfs paths works as
> >> before. If vmlinux itself appears in the file list it is skipped with
> >> a warning since its types are already provided by the base.
> >
> > The commit message says vmlinux is "skipped with a warning" but the
> > code filters vmlinux entries silently.  In do_dump(), the first file
> > is filtered with:
> >
> >     if (strcmp(*argv, sysfs_vmlinux) !=3D 0)
> >         files[nr_files++] =3D *argv;
> >
> > and subsequent files with:
> >
> >     if (strcmp(*argv, sysfs_vmlinux) =3D=3D 0) {
> >         NEXT_ARG();
> >         continue;
> >     }
> >
> > Neither path emits a p_info() or any other diagnostic.  The v4 version
> > of this patch had a p_info("skipping %s (already loaded as base)")
> > call which was dropped during restructuring for v5.  Should the warning
> > be restored, or should the commit message be updated to match the
> > actual behavior?
> >
> >> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> >> --- a/tools/bpf/bpftool/btf.c
> >> +++ b/tools/bpf/bpftool/btf.c
> >
> > [ ... ]
> >
> >> +            while (argc && strcmp(*argv, "file") =3D=3D 0) {
> >> +                    NEXT_ARG();
> >> +                    if (!REQ_ARGS(1)) {
> >> +                            err =3D -EINVAL;
> >> +                            goto done;
> >> +                    }
> >
> > Quentin Monnet asked in v4 review why strcmp() is used here instead of
> > is_prefix(), which is the standard pattern throughout bpftool for
> > keyword matching:
>
>
> And the question still stands :)
> The rest of the bpftool patch looks good to me, thank you for the changes=
.

I was thinking to patch it up while applying, but I'm not sure
whether just that strcmp needs to change or all of them below as well.
Please fix and respin.

pw-bot: cr
