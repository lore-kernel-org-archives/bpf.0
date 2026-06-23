Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0B331230
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247906; cv=pass; b=UEHn6EyCYKU0Ntubm3U5BusnYVTUDMBABQN+7TLuu9Sfwj2p/DbQcgYU0Wvj4kQ69LzL85O51evs6gkGBngWs7YRdgO0qGZWNI/xw2KOChMnUZv6UwVPOfq/dCgLaT6pMUAdzcjMMzQRwttu+v5ncplc57orsOkvxiwHVqIbPGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247906; c=relaxed/simple;
	bh=zcOi5pAYVsc/hsTK1xDiyom948aKELRynzk9lrxwUvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwEbtTOWWdLXRq+VawW525oXWcd9paWZkczqf8AYvWR0vV2s9euSy1eHW3FphI/ZzHys4LyqtMGuUWH3UprA1IeqtGdzRG5tp5y7Dv/u3MRKac8I6dfcrjkAZOyRV2gy2iVDQcYVWHbe3okLfINymMsZAtA7IK1byt9yXR2Kvno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGbSTwVT; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGbSTwVT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0aa420401so1505895ad.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782247905; cv=none;
        d=google.com; s=arc-20240605;
        b=KkS0VKwyBhd0mOqQaQ5n/Vpne+ZIyainJjdTB33xvzDH9a/KLXLVCijx51bTEksdLo
         SK/5ng5hqXd9uWUs/rh8RehmHQzVLrQUgnW4G6R5RvE8cbiXw2hO95nTDtV/ew65b/rh
         rYwP/NknSSNyWGFQJkRkhoKIiVqn42weJiI3Ht8EmjWagdrDJsGxAL2CDt2TqSEC4UGt
         lzycuQp0xbPub5NwthoWMtqJJojmEwd1oHh1igiAMP/cI5FZJYcVlPb7S+A/UtdLDk6A
         afMmSAgz1mh5ofPXjlRBGVphUpDXmIB40U7xlN++PRVOvmj/H46l35u6TGmln/9cFd43
         m9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RY/5an4ETMzEUBOvE3ubJ5aCycET4G5V0gmFurpfXt8=;
        fh=66dHoCoTWtBkAGKRNzBfbuDx9+fMMhAfMDs0FamWEXQ=;
        b=bVTLPs/UQqzE897iavGNV2rYYGqiIhBusHVMPfK5bfq/dWEfYYQEMjUwd3xmGXQd3E
         EOsKFXykhpmSbVbwv2w4krhhMPRAX8PSCmHVlf7B6J6uz5UVzI68WRbqaKYOfCZ4jeUB
         C4S+iuupWsWX+831py4ZkzQjemb/q44aQRcVLhOCjYkD7EUwO/wQiWXZ2bnwBi9+DrtM
         PrbVQAJ0ezMP0yYLgW6hJ2F4Tkqx/zYnZVcU5KEoe6wYS4DfAnDB+zHW2TN1C+9GhPWY
         6FRTuq17nLaEqLXOnyFzHNDoYzISznhmzeX9OkOxgTEaBlSmepXKdrEF/fwrAreiWhPs
         w/dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782247905; x=1782852705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY/5an4ETMzEUBOvE3ubJ5aCycET4G5V0gmFurpfXt8=;
        b=mGbSTwVTipY29BzqztQRnSiyhnbINUYrRMdzzAiahmEQU6ksUCcHzQ63SM7moc6VV2
         HMjTk04GscOVcFBLH0FMHmrX2rJq+94H3naIe541D/0u/2jrCws1/LzceL7Xl64lXl/c
         IlbE/QT70OyyNsq3AKlmKIVuKy7riKK4qmGntNJ6GlK27tj+tStbBCQzmWYxH6ldtkX5
         XitTXRHlAzYRrnzHzBbWnAO5kj5Hq+ii7aRltPJKkybE20v12y6U7N3I2e1Jp6oREnKS
         ye7G5eXgDDjwOXubanI+AbQyI9cgp6xHYglUIMDNIJCftnGwlexdmsBbtkMlA/5jcbFZ
         M+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782247905; x=1782852705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RY/5an4ETMzEUBOvE3ubJ5aCycET4G5V0gmFurpfXt8=;
        b=J/KHCiI7w6KQaTzEc1NWsoqmpmk2Sm1L6H4cUdTpDem5qFGF/YQbsCbvyRssaD8/JR
         J6jjM7psPaNvWgIw3wpa4Ay+I6YWQdGbCZC/eEapkNvKqr09DW/350BjDRr9IukYX9Mu
         g/QlSxsY5PZNHRslyziUdU/D0DG67rZdA0CbP43e+2voyDkPNl10wUEc9+SbisJF/WIt
         xSZuAK9/I2+jPconSf/mA3ZwIQE+2VPAcefTTjyPVdBaOkpchvqhFpmVDc0d/NrSqPKD
         f/bXb87N6Anq4UfxyFEeWkINbSqhgEW7qiRB+1OhJ/kM8s0Mkiiggn8t96SdhF954Bg6
         FmSQ==
X-Forwarded-Encrypted: i=1; AHgh+RoT/CN3gcFenARUF7A81jQYDaxzN1UlzLP2LdciiFVgom39c2XTmsDdAdjQufpFb9YjDSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5rzve40KUzq1Xr3h4I/LWh+/7pxHNY5XKd55DEp0LJSWUsqha
	7fMqQs4Qz04QmfmJKaJ0Te39YGeK/MitvvYUWYmXVcd8QFRAU/Q0UrCYKWvDoh4YqQtOlmfv+Uq
	6dJHzMiaZZU44BYMMNEjf7l/rtBpdVlQ=
X-Gm-Gg: AfdE7ckTv4O9cx1OGGnMrdWdi52iw3DYxBuJaS5ZklcYSU2dX1XjhSMfzWrzWlNXLuH
	HJj4tGfS2NXVHPVKEUF8xlOiRqvxo3cgZaovxy+vhVD8AMdbPKIY86hcUfphc4D0mdQWS0Zcoi7
	OLjbpexXQJteBb1qzmKmCLdmLmwHz4qKY38zFiHu2x4J1a0cq2w+BDGuPvQRJgWOt3WQIqznN+L
	ZhM+KuNXtTfKEGMnwU1G3pI2WZjMi0e1HeUabhgooqc6a6/uOJc45UrsFZKGc81Mgmf9lkalz4D
	pfTGg91I4bSGdGPypzQfbA6zLXRRrQEgUBKvafwClOv2awgG+p08/+kZApjeCz9JNCC49Q==
X-Received: by 2002:a17:902:ea0d:b0:2c6:abaf:85fb with SMTP id
 d9443c01a7336-2c7c771ddc3mr45558515ad.32.1782247904789; Tue, 23 Jun 2026
 13:51:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623142417.275892-1-jolsa@kernel.org>
In-Reply-To: <20260623142417.275892-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 13:51:29 -0700
X-Gm-Features: AVVi8Cfsa0wqDzjdaHi8V-3VPuU7JNaubI7fCcB26V9KuFplrNJaqyqc91hcUHQ
Message-ID: <CAEf4BzbLUzTfvf4pVTOCoOM5AdiS1wkbmuK3R3L+fFZLuF7n+g@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 0/3] bpf: tracing_multi link info support
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 7:24=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> adding link info support for tracing_multi link.
>
> Adding the kernel support with related selftests and bpftool support
> to display the tracing_multi link info, the output looks like:
>
>   # bpftool link
>   ...
>   27: tracing_multi  prog 93
>           attach_type trace_fentry_multi  obj_id 1  count 3
>           btf_id           addr             cookie           func [module=
]
>           91984            ffffffff824f4a24 a                bpf_fentry_t=
est1
>           91986            ffffffff824f6a84 1e               bpf_fentry_t=
est2
>           91987            ffffffff824f6a94 14               bpf_fentry_t=
est3

kernel's bpf_tracing_link_show_fdinfo() emits cookie as decimal
number, why go with hex here?

>           pids test_progs(1462)
>
> thanks,
> jirka
>
>
> v1: https://lore.kernel.org/bpf/20260621204524.61067-1-jolsa@kernel.org/
>
> v2 changes:
> - fix kernel symbol search logic [sashiko]
> - typo fixes [bots]
>
>
> ---
> Jiri Olsa (3):
>       bpf: Add tracing_multi link info support
>       selftests/bpf: Add tracing_multi link info tests
>       bpftool: Add tracing_multi link info output
>
>  include/uapi/linux/bpf.h                                |   9 +++
>  kernel/trace/bpf_trace.c                                |  55 ++++++++++=
+++++++
>  tools/bpf/bpftool/link.c                                | 137 ++++++++++=
+++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h                          |   9 +++
>  tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 242 ++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/test_fill_link_info.c |   6 ++
>  6 files changed, 458 insertions(+)
