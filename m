Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F336AE1
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 22:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889013; cv=none; b=ISQ14L4MzWRu9K3pDTUtcjfUSZPmXMsXX4Xypc+nelPiVBm7v8RjPdWOkXTVXqjAfm7JfR5psAUSsgFuo0st3LHRffSgzfagpWKKM5pFFVkrbKUOPEs5rOwXZsZ9KEM/4L2xqRNctSkLTHSO+bNNB9sp+cg36IaAxznAGF22eC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889013; c=relaxed/simple;
	bh=TU78D2f10HkrlpD+g5b51kVa8FFcmGHEN8bHqzYcARk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ierDAROUzp4Wh34X+SJqTbVVXOtURM2xfQTESlAJo3cYllC9Uo95jAuvixCpynWGEnpjBn7BIUqqbOqlhIG34gfzQm2W7CdXJCF1KdSnLHbDGuCprR5kgTCRWD1qwP6FCADHKk/31soNEF8alZklDcyjECs+UrE2R8s/JkrnZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFMvLEsy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFMvLEsy"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e6ade6a66aso5387089b3a.3
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 15:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710889009; x=1711493809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvO758sYJ265RgjuIZmeyvFMHfbZZ7P9VeWdx+/M7QM=;
        b=iFMvLEsyfyacSvpUIFXpWgVRM7+6OJGZ9fPSiIN/Hgow/0aKy1b+1/dKaYS+DYd6sK
         gNF9lCMpRF/e61nAG/dQNgTGGXcFc4bPLgqPX9udZxQroh4+SX9NdnZun8isnDDb6uzG
         GA+siioqadODSxJl7erV+1p/CEVmU0eLGk4pj4y303xEnTvq/Yp183M8vbhJePt6PlGc
         K+EKTx7qp+IYttTG6Hz3Y1+GmXcv4OhZVF8EtnC4Amc6C6nDUXu/lgza0YkyVG/GSG4B
         sGQ2I/wdHPEo8hNjWQqu4MbBMfRP/mlmaAlybW+V1DOP1u9efWmSkcZ5joflAxVyFoCV
         ed3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710889009; x=1711493809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvO758sYJ265RgjuIZmeyvFMHfbZZ7P9VeWdx+/M7QM=;
        b=D6lKKXtUITibkSDxfLjHd2Cnd8ta3nT7dtmV7bOopi7WkUeCvjiANF4t2KnGDwRJjF
         Q2Bl0UKgXmlUGYrOVM4wYmaHvYaW6Qs0al9jarzfx6bLMp7AkAdlNNOHH21cnzvl8wo3
         9PAJdHfbNNUUvpWBvKgEBCCh3eLBLaaRqztExGpV5dnk9UtwjLuOZa+oabhL/7B0I/Mh
         YVLBr3KBXLBCyTZGxw/t6V+NixVTvQ/el/xdC9Og2SBJvP1jEVZ6uSzB+e+DhjUCZI45
         XxXNGAuFGu8Mj2SABNDRnNw2H7Qejybzva717rI6jAGZN/1yMdvbcldyOQEIziT+6yBk
         s3Dg==
X-Gm-Message-State: AOJu0YwbIM9YShsD7rTm5bagmt7Hu56PWosfSRDqMYZfK6IYR+nWorBD
	WS4V9MMvcED9BiRJ8dLwSlpRavwZnCcK8PBpUAQWC7CDkVLV1UYvaS7iMRp+sp00QNwPhrU5FH0
	6qPV7xC+MdUYD7embBp8HUHUxPps=
X-Google-Smtp-Source: AGHT+IE4DY2oqCVLCQ9+J6jao44dthxa6ZatakgOPWtooqTRmh4LclgtjSwNT28qWOJ1gd5/jy5lxNTaZs8Yt7fbAa4=
X-Received: by 2002:a05:6a00:9388:b0:6e6:a9ff:b0b2 with SMTP id
 ka8-20020a056a00938800b006e6a9ffb0b2mr18557347pfb.22.1710889008689; Tue, 19
 Mar 2024 15:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319080152.36987-1-hbathini@linux.ibm.com>
In-Reply-To: <20240319080152.36987-1-hbathini@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Mar 2024 15:56:36 -0700
Message-ID: <CAEf4BzYpbQdjt+QBpbOPWr9tqErOhtMjb8gi_gZewubpUPgWGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: fix warning for crash_kexec
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 1:02=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.co=
m> wrote:
>
> With [1], crash dump specific code is moved out of CONFIG_KEXEC_CORE
> and placed under CONFIG_CRASH_DUMP, where it is more appropriate.
> And since CONFIG_KEXEC & !CONFIG_CRASH_DUMP build option is supported
> with that, it led to the below warning:
>
>   "WARN: resolve_btfids: unresolved symbol crash_kexec"
>
> Fix it by using the appropriate #ifdef.
>
> [1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/
>
> Acked-by: Baoquan He <bhe@redhat.com>
> Fixes: 29fd9ae62910 ("crash: split crash dumping code out from kexec_core=
.c")

I don't think either bpf or bpf-next have this commit just yet, so
landing it in the bpf/bpf-next tree doesn't make much sense. It
probably would be best to land it through the tree which does the
CONFIG_KEXEC_CORE -> CONFIG_CRASH_DUMP change in kernel/Makefile.

pw-bot: cr

> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>
> Changes in v2:
> * Updated changelog.
> * Added Fixes and Acked-by tags.
>
>
>  kernel/bpf/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a89587859571..449b9a5d3fe3 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2548,7 +2548,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> -#ifdef CONFIG_KEXEC_CORE
> +#ifdef CONFIG_CRASH_DUMP
>  BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>  #endif
>  BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
> --
> 2.44.0
>
