Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF7D38B121
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997834; cv=pass; b=mIz2yoC4qzOcWXx+KoIBOm5ihesvj+JTOrRuhd2oL++zTJvmb7apIJUWZauJPCBiuLxQ0vd1c/4TsA81HPNZ9MFmy7noW0K5jDcfIhK1rsAn78o/I1uaqWw9vTkSsNQLxx00tjpKw6AcW6jFIEkzd4T5oYZYVkLM5D9BWMc6Yb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997834; c=relaxed/simple;
	bh=j4Cee+P2ST9aXYF+z9ZM/jNAIu9eoJZlO9A7sv/Z9rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oe5bGStSl8zepo3XS+PiV5gE1Gi0kYJ8HeGfB5oxWS9S2pjFouOvchlLl0asD/I0aRRvHyy6xt98UjQBeewY899tvrk474yLYhzEheedNqBRBhQaCUPbeOXftQ4s7/5WMDHbns29IqwalsrNrF9DOCcuP3ApKDNfTCMFc2v7+pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZNGatqA; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZNGatqA"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c76b0cda2aeso589582a12.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 15:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774997832; cv=none;
        d=google.com; s=arc-20240605;
        b=CD2Xle0yw9twUmTXyZsjSdMiH3wYRSwaTt+9g9XwFLhPbCIJ1Kwrllqmq0w2Cesnbc
         IAtfgoLUVdSlQx6xICNBypgM1Wr5kQEeR2MmFivyQhOKBwgqwqsA0/mfUPvqffAqgQlQ
         3BX/MNgegYwWFwRRPy7bU3igqw9Xy/0NW5Z3CqwYB1/N5BIfoNGikuD+RHZBb2+wVsmf
         AXp6QWDYt+oqwvOwynrgRyygqD4hTbis7H4lL28rCqZPNnPPEp6CoN4cOS0w1OV+9fi1
         sZhP4Oamvnz2Yl+veKMcFXetNUzng7/lRqviM3u8tEnuqTNPVsA4xRczanGGeZ+SB92d
         2kBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QoJNa5vke00uW6MzDwfWaxg2r22ZBjrVX7VB5Kxvd3E=;
        fh=0z7eV0SVrdGestYsQW/vHe7NOeLecbF3mybNQIacMZE=;
        b=Nk01HcPb4X7S0H4s4+kvwVITdIfHlfU9NBKmZBTs+GWziz6Oai/mdk8LfOaddkdxkd
         vZQw4IsXjNomoy2xBNnikuYuefbJt3+yoidiURyyVzEl2vWFwdKF3OEYxQyLr7bGQgBS
         N/aj8+dcGY6KywEK1jU/AeO78XmI5uSgMumAvc8XcPk6miguPFAVJJH7LeNBkAglTID6
         jo6ucRVMY3ODMBcQz2nPmMmuJjYpIDcOs/SBuXMBF7efzO+dJnlUZ1SQs3Cc6xFCOpNv
         pQFoqyaVvjP3VV6WjIKgrwlVyEao0RGOjn6Gv0Rv5xYWSyasDaAlmex/RMluHhTLQyh0
         XHDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774997832; x=1775602632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoJNa5vke00uW6MzDwfWaxg2r22ZBjrVX7VB5Kxvd3E=;
        b=GZNGatqAM7D2bcbALCwqhtZH8D0MaQT87mkUZCM7XyAI5pWgvO5V0fF6IzcCyxRbVt
         lXigcIFb5EIi9/MN/QJUBwLoVQeIOByMmDhr3HNuuyh8ZDakzquV88EZ55R0+SLeUMap
         HxhiGNLzaFRLovZd6eUxi/EZStlgrhbBzj38a5bgVSPrRYhz9NfhSWoaSd1l0B85ArGC
         jwutKjvctUlfCMjZ+2/wPPi21CvWKQJARg9rSLS7+KWkwxJa+S7Kj4r0o1OmgJWcpe/T
         NDPRmSb13CVpZOnxio1w8UOvPyqcTQ/MbQZ3g6gqg/MGv2CENlpDKKtdfGUrIooebeiv
         IxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774997832; x=1775602632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QoJNa5vke00uW6MzDwfWaxg2r22ZBjrVX7VB5Kxvd3E=;
        b=Tx6He/BYGMp5wG4roMbsYS+WNkQpAQl1k6OpUUbZ30zlK2Enp2AArkjUvx2ixfw/NW
         NhVTcb65IhI8CWJXzbNysITWn1xpAlOlDkXYwZy7U4l1YSgLFQZ4XF808egusL5gLrif
         fhUqomMAczffu2or5bUFWxrd+PG9wjvFF4OjNg1cTokeCRfrONRfm/WVq52fzS+2xWrs
         j9m+zEnoxsQw2ZDQcCRyMO0zzJjE3JwScUYmexwnhSaWimDn4J5phpBE3AddpQwjsi53
         x+mSbZhsSwBvihXOacyHHMr4NdEitnXEFPGRLKjhJm2TOUmM0okU0Wj3d2bskl+FXMyF
         1lig==
X-Gm-Message-State: AOJu0YzkThx0aXbN/PtTxICmCU3i4Qbg7e15lbycz2mKLPlueKIOkgeY
	jF+Y8R8TxRQCiYhyO8NYOV0mWRl1tL9u5FVNLpbVmpExGgrk7QDiliydQT2UFd1+yBRjMiFM+Kz
	TtdUjDXnTM2sOcbG2/PE51qTsAKpq7T4=
X-Gm-Gg: ATEYQzxb8JQQeAg9CYfFhFO5mMDnYEeKVbY8ZejOoRrFhpDDtzvyjXmJWyoiQYY1me5
	4ZW984GQuYXFtFrQEyhZnxnuS/7TKA+fYq7k4bm9axf/Xq1cQaHTzHnVykysKdbAHfq2w8kVYrL
	fcFvsUyalw78I2wJhKJxtlGSSI30WKPBc9pbYGHn3IzL1wceh5U9SyWGgHslja7O44s9prLCsPZ
	nb4EPtz+XJbJhg7LkKeKcpyHPgUQdQRsVwepTG1/IE+QANFO/y7gqt0GcwYWrj55VcZa4OzO64n
	JRoBxQlZ/hmqDASCFe7epls=
X-Received: by 2002:a05:6a20:918e:b0:398:7973:277e with SMTP id
 adf61e73a8af0-39ef76be325mr1066560637.31.1774997832468; Tue, 31 Mar 2026
 15:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331172634.57402-1-mykyta.yatsenko5@gmail.com> <20260331172634.57402-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260331172634.57402-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Mar 2026 15:57:00 -0700
X-Gm-Features: AQROBzClPeA1P6MO7xLQALoY_G4fJw_MJQrEEGLd_so3qB8bdau-dfRYgq3otg8
Message-ID: <CAEf4Bza69ph4CnvvD8+zosMMDc6Yz6puvB7V_aOVTw-M-97+Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Suppress veristat error
 messages in non-verbose mode
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 10:26=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> When running veristat across many BPF objects, expected load failures
> produce noisy stderr output that obscures actual issues. Gate these
> diagnostic messages behind --verbose.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

applied this individual patch to bpf-next

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 9652649171ce..5c82950e6978 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -1673,7 +1673,8 @@ static int process_prog(const char *filename, struc=
t bpf_object *obj, struct bpf
>         fd =3D bpf_program__clone(prog, &opts);
>         if (fd < 0) {
>                 err =3D fd;
> -               fprintf(stderr, "Failed to load program %s %d\n", prog_na=
me, err);
> +               if (env.verbose)
> +                       fprintf(stderr, "Failed to load program %s %d\n",=
 prog_name, err);
>         }
>         mem_peak_b =3D cgroup_memory_peak();
>         if (!cgroup_err && mem_peak_a >=3D 0 && mem_peak_b >=3D 0)
> @@ -2247,7 +2248,7 @@ static int process_obj(const char *filename)
>         }
>
>         err =3D bpf_object__prepare(obj);
> -       if (err) /* run process_prog() anyway to output per program failu=
res */
> +       if (err && env.verbose) /* run process_prog() anyway to output pe=
r program failures */
>                 fprintf(stderr, "Failed to prepare BPF object for loading=
 %d\n", err);
>
>         bpf_object__for_each_program(prog, obj) {
> --
> 2.52.0
>
