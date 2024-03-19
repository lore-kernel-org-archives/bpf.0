Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA950A67
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832839; cv=none; b=cyL9A6klDAG7cpv8ACoBbGah3HQNZ+wnGi3+j2BIZVNLzijippLTQA6rd2GIQGFCJzHt4qZxHYozQYppVG7Ya3QdrwPelNRm2xLPekspaXaXJ5ml/tS212Qq178OKPBTmAfCNk5FHG0n7iBX7eSfWv3ec9CsMvJ4x3sR+AdKJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832839; c=relaxed/simple;
	bh=yCV421/yCun3nnesRVgJzjBmrZz12fYUB2WUT7t7bAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdSMwnmRNgR1MB5fzLMXsiGVTYQburyIlkR3UrbgWktRlE1+6rLAlphWFIy34punsOFa7OjEvrJ5SrJegGEB4KVmF6pbKu8vSTsyXDzWUaZ9LT8HZ4bfPnX8akNQdrsUnsnSRRLkGN0Tr3VoC3R6tDtBx73DmqIfowmQ1ZXR5js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8tKZuR3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8tKZuR3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41413f7b2dfso10317795e9.2
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 00:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710832836; x=1711437636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a6NzncnQ8Wg4TlPIGxDK5KGOYP7LdjptAZvHLcDDNU=;
        b=i8tKZuR3z7nDU80jlM+Q4pzUlO81arwTLAywJmgw9ROk71grOCcHF25stQ+SlKPghm
         NvKzEBhlVtyo2G17QEUUo2xNj3Yc89G/Lmw+BhtMN9zPuutNifZ6+YCsseIHf6HNsZCE
         q/6KIgK8JFO/oeHw8U+cTOKtxuecaNYChmUrR7GmDftijsuQw4pZeROglOL+G9wcYn6t
         IhjbmSYXXvZ+a/x+iPAy0ADFhQgd2ouF8fwkU6w9PPQaYg7ypoqx/lcai+5LFGVQEfXB
         bdf8WCd5/SH/Q7P3AkIY6oYVJD8Ik1McmKzI7qmphqC030MPDaXf4b+nWc6fGI/dgZI+
         qQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710832836; x=1711437636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9a6NzncnQ8Wg4TlPIGxDK5KGOYP7LdjptAZvHLcDDNU=;
        b=mQLwgKS+WN7xrjSCMfAkM9S7zvRdLZCqPXzmabvvQEmvgv14OHPE2J/Kcfu394qPo+
         NxDEULAgp40cMxSJS01AltU111QKpMJoccV5pGyYCZwQX0V9yDktmw00G2k+jIsSfXL/
         Di+jFeLoH2kHcJpTbEVszII8WyUFyO9uBwU0oDIdFrLeNvvP/mokv1qgSJcTBRW7KxuD
         AP851799jFJfMxTh62sKXJ3aNPfJ0cY07u6fDCUerJb/keGFIn6Aq27tQtx1Fd+zLObz
         qAp3GGh70k3ledVjt1gDlmBOx9OVpBIi1K9JRaST8BGDm2MGAawDmW4n3p4U2F4spifL
         XNog==
X-Gm-Message-State: AOJu0YxiK4qUKkE3Y2fOKb53W8ktQQNN5HVuXofuUfMkMaKSQd8Wae77
	QyRVSsBRN2flwM4WSSnh+xh1qNtVI5PF2KiUt6G/3Z1ONWzZmnlNLdMazwe+uNk5WlSZZ/2aQgG
	LXydaeNj1lfSUm8UprNLclyw+PTg=
X-Google-Smtp-Source: AGHT+IGFQmx6nWNxFlu3au+QNFiXfu664/9JSJ8FUvETqZPwa4lIiOl1UiKqH1+uuBwYscorq7c+YfuDi9c7wxJyKek=
X-Received: by 2002:a05:600c:1d09:b0:414:48f:a79f with SMTP id
 l9-20020a05600c1d0900b00414048fa79fmr6833175wms.35.1710832835678; Tue, 19 Mar
 2024 00:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318184037.3209242-1-andrii@kernel.org> <20240318184037.3209242-5-andrii@kernel.org>
In-Reply-To: <20240318184037.3209242-5-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Mar 2024 00:20:24 -0700
Message-ID: <CAADnVQJdkMgLGGBb4eGJP+gaNjM2BJF7bWew+ZOHE5GEE8Sxdg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] libbpf: add support for BPF cookie for
 raw_tp/tp_btf programs
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:40=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
>
> -int bpf_raw_tracepoint_open(const char *name, int prog_fd)
> +int bpf_raw_tp_open(int prog_fd, struct bpf_raw_tp_opts *opts)

...

>  LIBBPF_1.4.0 {
>         global:
> +               bpf_program__attach_raw_tracepoint_opts;
> +               bpf_raw_tp_open;

So far all api-s that accept opts have the "_opts" suffix.
Why deviate from that?
