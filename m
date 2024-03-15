Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7306FD2
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 02:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470033; cv=none; b=KQV19qwgQBiaTt1rzAcY43PHfrZHUoYJE48mvWWHDRIY0cwcUVS8XGh48YEclCYpXnV0HMyrNI/Z0S1YB+x+wF3Uo7lAfZ/6AfLg0qIw9dGCLboGmlFUtCHuQhvrhvo9RaZ/zALlEQvS8fH+27W4qNrPqTDySUebgLB4JCFxmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470033; c=relaxed/simple;
	bh=UVr+ZeSPG3FW3ZqgecWzKFIEJVkRlj+Xgz9+bkUIkKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3eqiXxJMF/nGyh+9nDBX+wNZkv+8WQ8+VDJ/ro85WOe0YUPR+mW5IVI/e59hhDGjWQT1qFGHfechEks8NepeebMJ0i5YoBF07Xhg/gE3pTfK7MxYU72eowwowgikjqQpg33f/bic7cpfI9i4n38J0nU2H4IkempS89/Nwcfn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuciWTc3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuciWTc3"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33eaafc4419so1739730f8f.0
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 19:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710470030; x=1711074830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+JgHC7n5PmUji+LRSnr3T4Wrg51HgQB0SaLrk6TaM0=;
        b=WuciWTc3W12NgNe3fHJy2CiLMWhxGW82iv5ZXc/1YyxJ1TnaLLi5+8AVU7hywFyjT5
         WisnMY579x/Rv7nJJ30Xetwos/dvPVfM2bCS2HBQVCB+LcUo7iy3H0zzp2OK8aY9S3OD
         l3pjYTcKGjyyBNy51ux18+6DM8J0ohv3p8oFMGCGES8Z+1aTDtoGcXNrhYhOQPBlLJma
         JvahNctw2a4wQYmVJe4JHQw9kByEXcriupSPBgPzufjLXY0dqAElGW9HcqBGKKT38lHu
         W+OY5yc+eFUXnWIqF+kueDJIROV029VoJ59matBOTkTvbojV+HEZkwTwDCTCHdkJG5BA
         MEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710470030; x=1711074830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+JgHC7n5PmUji+LRSnr3T4Wrg51HgQB0SaLrk6TaM0=;
        b=hbI/yw6GJfkgLYLDWwhwH6uFa8RapJAAFiEysGRVwl6Z9gXYJJTdrPh9Wj4+CtIcFx
         obJWyz/k265erdRzFWds5DPL/AgcQlK2SYfeOkkI8z2gOB8G+IJBQaWzaWKuhirb/ZNg
         tLi1GugVlByRJANZFUmZ6Mmxv2zsdkbUy/S9e5vqPzuHfHjU3McGwdygsAYt6fUwGu/A
         hO5K96JNwTmaoJ/WLrzKDOeN9zqt30UqhkLTMsIR9KW0yu4TuS4nZ07fsnDOWEKF3UP+
         VJ9m7uELAmAXGBU0502DBW50df/56/nC0uONvzAg08nUNvMg6Ar0r1WW7q4Ai+lOXlYe
         DGgg==
X-Gm-Message-State: AOJu0YyZr5vEva84x/ZGe3ItuK3lWNx2FMoIntKokH4RyKomnwQcMl56
	9pgoXh/tK3u9nnygHKxzVt4oDlwIMr/GrPruhZFu91B2NliTyyPvtfxeUBdzPoL8aj89QLfu0yb
	lxpUwqV18cl3dYZo3gSCs1NGWK/Q=
X-Google-Smtp-Source: AGHT+IHJ3/6Tgxyiq5uEyQv93qv5yIjKeggAopDfztcBpCz3jpydbhax/RoeYQ8RNzt19dpfK9dPFIVFaaI9de80IXI=
X-Received: by 2002:a5d:5586:0:b0:33e:63c2:c43a with SMTP id
 i6-20020a5d5586000000b0033e63c2c43amr3784522wrv.26.1710470030597; Thu, 14 Mar
 2024 19:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312222303.2305873-1-andrii@kernel.org>
In-Reply-To: <20240312222303.2305873-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Mar 2024 19:33:39 -0700
Message-ID: <CAADnVQLBciwQ22GE1z6Sf-r+V8JRDfMjMVQWburR_pPgLj9XZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: scale benchmark counting by using
 per-CPU counters
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 3:23=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
>
>  static void trigger_base_measure(struct bench_res *res)
>  {
> -       res->hits =3D atomic_swap(&base_hits.value, 0);
> +       res->hits =3D sum_counters(base_hits);
>  }
>
>  static void *trigger_producer(void *input)
> @@ -42,7 +72,7 @@ static void *trigger_producer(void *input)
>
>  static void trigger_measure(struct bench_res *res)
>  {
> -       res->hits =3D atomic_swap(&ctx.skel->bss->hits, 0);
> +       res->hits =3D sum_counters(ctx.skel->bss->hits);
>  }

It was zeroing counters before.
Do you need to zero them now?
