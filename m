Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115AE1E531
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100431; cv=none; b=GjpmyBWozBSa0P/4NiQSdUStmOrLl6FGL3ZREpE/ji2GqsqX+fGK2BvmClp/ysTfHT+kRHMPibiFFbaTLFPaGofAQWCOQY4f4ag8wIg5j/Rg6eGc5MVA7raFrcrO6smNliOo0M+4MqVoGYPI5ngqLGzjK+M1syXFjoR4sg4gxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100431; c=relaxed/simple;
	bh=UpMThfhjlRFAbHVO7m/eaPzD1dPRC/73GQwsakgyMoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7HGjQlinOcNpZ+hnYqT7Keao0VecOksu1oMAlX5gJ94qQkmiYOwA75mbbZ33IORFE8qHVYOaBS80+iaeIUe0OKFzqLeSe6vZ0HBjwKdVwDo1/tPVy1CyTFeE8Nq5FLQG3JGdkZ+/UwV4RQwmIl92Hc20j+OI4jBI2RvBe7tSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kofm4MSi; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kofm4MSi"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dc949f998fso3754941a12.3
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 16:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712100429; x=1712705229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIq9BxEaSUQFgsegGZTkY2dWGbTDHLG9N7CExY8AVvY=;
        b=Kofm4MSiYPV4aPEBj2I+gu5JUa0ZQ6uvPPKs7eQOK7DUZHDPo2PzHrGhx9dNo3KI4V
         Wguw0tKqo4JBxmqN5dBcUSCy4g2iQJBS28L6sQ/nyrChLgrAms3eTI2kCoA2QR/OrqPF
         R5jQDrpkLKjt3g3IiRIUtLNddUJYJRXu2SSVs+hfHLdsqiuymvB9YT91AjnuBK5m1ADv
         ajWD+cz+whBmPW8GDHUKJwwSkqDmlICjZYX8YgDCNbpj82+Hw4Yu/V0A/PJM6WjILeGV
         8sIkW865QBRRywqzOMAGkskt53Imx1KpkdrmjJyipd3HGdY+dJ0V68r9zEz46UHpluBx
         0Skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712100429; x=1712705229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIq9BxEaSUQFgsegGZTkY2dWGbTDHLG9N7CExY8AVvY=;
        b=L4cwmkuFxyJMO5D4BaYPpybmYxj//Y+q4BQrtWxu8I/5tLv7eo9iMk2dvvf9g9OQI9
         S/88AdLuX5vLbm/UAkCZJp76YYkjXz2BSo1KcVir1gAhHMpYFvOfLdUSuQGXWwmi1XbM
         nbja2x/JGZtqtqwMPFsOFzhJEod9V+VIM4ftrxAbgVXOdLdKUlN9K7MPjavysLoLFHOZ
         vg1irtZYyWb37Avoj7m/zCz1J+GkW1B/JyKJcMy39THi++cCYQko/0GiuKsXrAYEeyTH
         ya1E29MP68dR1fXveBmhRJLh2a+egL1pA32o8WgEkUEK6aBdd29ZgTTTljX8Ixz19OOG
         88hQ==
X-Gm-Message-State: AOJu0YxaGNLe0I+Nb63Md1Lnq+8+pUP/n1SQ6IN6bVged07pZli7r1mp
	icZ8BzU5xnQDRVWSPNI1+juXHY0Q8geVle2+Y8rK6JlIq7B7Z3S6g7ViDneFE4VmBnweAcNp/px
	iauIGm2dBCWXvfXhhpLcGPMQmr5Q=
X-Google-Smtp-Source: AGHT+IFBd7GOPiz9pGeExcouqvK/4OM/BVNdybRiV5xeC0b/cJPauDynkH5ysl0qtLk0C1CxVAxTHC3YOOmTIumnEVM=
X-Received: by 2002:a17:90a:d4f:b0:29d:dd50:afe with SMTP id
 15-20020a17090a0d4f00b0029ddd500afemr11092936pju.30.1712100429320; Tue, 02
 Apr 2024 16:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402225020.2582397-1-andrii@kernel.org> <20240402225020.2582397-2-andrii@kernel.org>
In-Reply-To: <20240402225020.2582397-2-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 16:26:57 -0700
Message-ID: <CAEf4Bza0QLa8m_iW4Rk_6+8tuJgvhF7gjk-p4HVHTRq2LJgPVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add fp-leaking precise
 subprog result tests
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, 
	syzbot+148110ee7cf72f39f33e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 3:50=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Add selftests validating that BPF verifier handles precision marking
> for SCALAR registers derived from r10 (fp) register correctly.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../bpf/progs/verifier_subprog_precision.c    | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision=
.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> index 6f5d19665cf6..e1a8f107f0a7 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> @@ -76,6 +76,92 @@ __naked int subprog_result_precise(void)
>         );
>  }
>
> +__naked __noinline __used
> +static unsigned long fp_leaking_subprog()
> +{
> +       asm volatile (
> +               "r0 =3D (s8)r10;"

Our CI's clang doesn't like this instruction. I guess I'll have to
encode it in binary form :(

> +               "exit;"
> +       );
> +}
> +

[...]
