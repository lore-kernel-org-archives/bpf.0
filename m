Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E54937204C
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394041; cv=pass; b=cRTbmkDAgfAHpxai8ODGr5k6TVyhZIqIPBv6FwAE8SOC2bH9zfUArsic+0cwXXvFIASy7AIYQcba6C6mW8WrXbKJj/IYEEs2ZyZ27J+3G5S6Ss45YkODDcTglq7qu7SDIV5NaScajyeQbgtL/pit1J/e6StZh160sMfQXM5g5TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394041; c=relaxed/simple;
	bh=HSmeqoz7kQmtKXvZxKasoNLUi6VzJ5h3xLUZFNVNfCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNhSt2raWnhgS5iNwBEe9p5AsmQe9YAMS2cuGb6wxwzE5BElssJnxpC76U1PRA9td/qksUnnhy2B8EY8FMIKy/SM7nTnJt6j2jpJTxdbqmYyuug1rv8zDRO2NG3kVFB/7Yy+1Pk30nCUNdLtmpxJcZnQlWrSKW8v46dVPvrYxTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzLKXkWo; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzLKXkWo"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a151eda82dso15896681fa.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 10:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791394038; cv=none;
        d=google.com; s=arc-20260327;
        b=glisZd71goUm92kk+CdMmgmqGaKHfK3tJWyEfIPArk2/kW0cOFutuTAm/WamGM/y28
         hiCNk+T8A5c973jmVch6MLPvNvijokBDFDsrkzYTvniOfsfiW33TM0FDwDOr1HhRCgJ4
         SXMQs8ReLcfAGd8KLvatDUqoTsV1jATZ9fIRuvCSWe1/beobg9uxB304/Cx3WSQwjPgd
         ZtmQ168CIic7tsw/zD1zJ/0bZLmv5I0rNJkAgo6WzkH2GOmzXA2KgWWbl1gW4ez8dkaP
         41tuHG/De3xScUBNBnfiUpD7cwAVZrifgKnKdb4Ykdnv1uCIy1L8m7W8tusGcqnbgsAR
         aomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HSmeqoz7kQmtKXvZxKasoNLUi6VzJ5h3xLUZFNVNfCs=;
        fh=vqyuX2zbd9/XsmdhIYOs5XPauH8DJfJQLu5Zi5LyFDE=;
        b=naIFFAoaXrUpfWV2EYksdlt+XC2+7lMw+KBka92OXY4QpNd8IBPw87wS3M8QZMH9Pl
         +4GDeSoZPMO/iRP+eba7x1dHB2qnkM+4msuUiZtikwPCpv34cUlGhktovZQxTB/jym3s
         2EWhzK1kohKF446cQrmc4eymwAkW3T/0AUQcLoscZwvu0yN9ephokbsRXEydebfNzFM6
         FWSDZMGTtL02CJwG1fYdzVhhdFbyM/Ek01mHO9vmov8M4favUbY73d672jViN5w2E7TZ
         MMOyH6j4ZGGV6uyKZ5D6fnyqbWMg2X92rxWWoPSqAw4znivuy3zO5zy0o/Hwh3T50mxo
         BtKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791394038; x=1791998838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HSmeqoz7kQmtKXvZxKasoNLUi6VzJ5h3xLUZFNVNfCs=;
        b=HzLKXkWoy9m9QTQhbEx4bD0ub5q8WqQkM/ALK8mIHdOmuuCFKJ7o23fJ9nyXlM8b0b
         BjJCjFC3uh3r9gRHQ2IEpGWC0xmfRKYApkM+6iCDLBu4EP+f+fvW+/OzQRC/FfDsa8l2
         edMlknlAVYmicDRIAWGeIubeU6h9Let5QPozM20Wf6RWFRLrWrh9wQgiKp4UVqdszH+7
         sdqWBgF1YHPQpJCPoZZywEkb/eexCxdJ5MYtrJjXBxeMV0GyIG0a1okY5FnSKekVNq58
         LGXhThuwxFe/eAITCiOQxrdd7NB4toMcVHSth5FQlQPEelANzVGyyJkMEccHgGlEPohO
         BOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394038; x=1791998838;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HSmeqoz7kQmtKXvZxKasoNLUi6VzJ5h3xLUZFNVNfCs=;
        b=EMd36qnESCYHJVeNEtP779lcfNHDUxp/H+AID1VBnJpOdRvMC869ZV1wCdWjP+GfsU
         qjnpwlnWCNhXqdCPwZO0Ar0R9/7kuIYKCG6hVzJYzqv8bkK3Ta3acg/b2p8WuyfTxOe0
         QC0ARmdGpZ37fIse5YemTvZPLZB6Swd7RqlJpOcxwcBXNQWhDTdeaPTUl76cjL1+ZsXQ
         BRT84AGPTHAjqz3f/KxlRoHh/HkAtZ0zfsyGziez3bRZ+ve4yc6ZHT74bYBEJCu15M6o
         K0Vf8VhwDbMhwL3D9Az00q5wvulY8DFmn+WiDRc2pE3LKMBOHeRCRaFzDNAMTpO+4L7/
         AvUg==
X-Gm-Message-State: AFq9FYL/uLDV4tqQ8f38IhpnKSjdD99uO6bqp7UhFhIX3EzdwCYAJ4rd
	f/SrpFK5wcctizvg5TESNWq1UpFRJzucRSSkuvikH9fecDC2Cj+NAauTeIjHLIx2s6kGvp4fR5P
	8e7wKtOIaXpqltTJCVPnvWNIB+ibiOe8=
X-Gm-Gg: AYBFou1FmyxeNnlajy6wyCne7/8eAlui22/ppexXCmxC69D4GGWjpvmhFltFjOTc1eh
	oT0x62sFkHb31b1WgttFtq8WlnDY3+dKhaOEf+DZCC9ofJVcituze6NDvSve1aySPXI8GwHsqA+
	NoPe+nxMztqVnzxO9JNvHIuZTU8cgjjib/uxp2G42yc/7gLrEMYm8ahcW/SULs6QYNqc1e1fY/b
	RQyxbUTHy0/PwIHjHXNYg8OQ+EY/epf33gibm8B5TaYXuSXjHfZ6g33c89YBw8PVHM3ltAGM9IZ
	m9YC7/00EX3GfKWNNIJ/3uyNbFBFW52IEEM0nIRyKwGFQRyNyLNmv3I8
X-Received: by 2002:a05:651c:2115:b0:3a9:7b36:5886 with SMTP id
 38308e7fff4ca-3a9a2cd532emr7561531fa.7.1791394038057; Wed, 07 Oct 2026
 10:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007150549.1334-1-rahadbhuiya2021@gmail.com> <CAMB2axOqDzQME0ENnX2jVcJTpByFByZneeG0sLOxfEMK5OJ8Gw@mail.gmail.com>
In-Reply-To: <CAMB2axOqDzQME0ENnX2jVcJTpByFByZneeG0sLOxfEMK5OJ8Gw@mail.gmail.com>
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Date: Wed, 7 Oct 2026 23:27:03 +0600
X-Gm-Features: AclHuK_hCVPhm_oKPjoLVxyn1zZTZ_zy2jD3FEtF7o1en8rHOb4Am0llWBKpOyw
Message-ID: <CAFj_5066idKHp_gXix98hx6snucnSMfjoiU9HVueCR0KiAJ9yQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: mark kfunc memory size argument precise when
 buffer is null
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the pointer, Amery!

I verified commit f16e80c2c451 in bpf-next and indeed it addresses the
precision gap nicely. Please disregard this patch.

Best regards,
Rahad


On Wed, Oct 7, 2026 at 10:21=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Oct 7, 2026 at 8:12=E2=80=AFAM Rahad Bhuiya <rahadbhuiya2021@gmai=
l.com> wrote:
> >
> > check_kfunc_args() allows a null buffer register paired with KF_ARG_MEM=
_SIZE. When buff_reg is null, check_mem_size_reg() is bypassed via break, l=
eaving the corresponding size register at argno un-marked for precision.
>
> This should already be fixed in f16e80c2c451 ("bpf: Fold __szk const
> size handling into the scalar arg path"), currently only in bpf-next.
