Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B429CFA
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712012092; cv=none; b=eLZNbYi2ivKCdJhwOaISFlKs6gSxFUujAryS67kRXuBzW2r0plq1frFsfFrfPykYqV+T5xa2SPNl7+dw963ePVT3cTOIN1KiWlr0Qoa7+4rvMQ1AJUnv9q7AvQbwxrsJlnG6f0pj09Pe1KoszQSGF4HJEXuCXTCzb8XT4vZHmDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712012092; c=relaxed/simple;
	bh=QKVEnIHLo0zza9B8a4PgXra4f1L0SnwO9T1UUfz2twc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlOWViJYl34/UCxjb1vhlm2jxjeqOiE36opQZQkO2f38rH/XlG90i0U+nXP8UP2T71JwEcY31HSCxjUjpWixkck0//XI9Bx8M3goQrBOcELnexxGQbvLN/vW6THtuq9+MA+55vdhfM+dmUsf1hJd0Lskj56HSarlKsouh4KsihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4GpyhBo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4GpyhBo"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a04ac98cf7so3049501a91.0
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712012091; x=1712616891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKVEnIHLo0zza9B8a4PgXra4f1L0SnwO9T1UUfz2twc=;
        b=F4GpyhBoziAfGJFzksLcWZXQNbZYaKeZFS5tlnwus2KP4xNTNG2ztdTAUsIsFhiii0
         H5TGpBIwDbpCgzh63sqzfd1tfy526QoTDpS9LocvOuC5JdaVw67C6/ugEn6RDfanOteM
         E5L/zu6jFaMhnoimVOFUWbqofmN70aQebrqoKQscaxs5/tVhnbFrRXOI/PCi13UJn+fS
         xE7Kaicu8IlJjrHLcZOUaSDVWFbFhPTyUol/GVd2ROntXuqAz2EUIx3iDUDRzT05NHQn
         xmxSz+AD9iEvJtVgz2cog8pYIkBssVrbsxu2uh5j7xr4rD5DFJJmmLPOIizhRy6780t2
         J0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712012091; x=1712616891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKVEnIHLo0zza9B8a4PgXra4f1L0SnwO9T1UUfz2twc=;
        b=Rxc7DcnekPVSIuYwQta0TBSVj8gaALST1/tpfSlkzHTY6ow5BPfOOR/znFPbHCokoA
         nc7FDB/WiqVapLe5t2qmcwqWCwYv48Aq0sTRDZ+p0PaPu1wmVIYDfTxh4A48afDa0VdB
         hiCGPMcjxvmRKcOoOUx0NUEJo/Q43h53zErNUXc8/5HMb4K8SaZszHjKV5Acp7ykS8HI
         ZvXx21HUuxa7qYzAmQkHr7naAmONE8JDwsvyJP5h6OGalG2DvE+gzue0RUO3E4rvdwLN
         gaungcXB0ugpg+wAYSd2q3K7rPx42GvQcqDtxAoG7ZOno+r1VwO2/o1GlpSkbr7Zr7ON
         kwLg==
X-Forwarded-Encrypted: i=1; AJvYcCUvKr5vqe6aWz5N2SrRRFoSagG6dDVW1/dQepxDfwSr0NJGx4UivdytubGvvHNegwPA0ezbrE+BmQL4ztuN0RvHY844
X-Gm-Message-State: AOJu0YyJb73gZpC6VSl4oZ7HXrho5QNUFndzwLdeNg12yKybBGWGMkEZ
	5g4yrfBLRHHn+T/Ge+Xtu9CTnj1ajTsdjL/Xf4NnfD+JbVIbCVs9ZGwQdiWxT5wkkAUfjQCjNhC
	UktW6POQIJZTMWbh62qF63bRAuio=
X-Google-Smtp-Source: AGHT+IHNpWCGn9GhKp6dckDGK1dxGwmhTdm38qGCbY59c0SuWv0v+jiTbtA0dGWpSe/KmVcZdcCUxyUpoF7epFaHXGM=
X-Received: by 2002:a17:90a:bf91:b0:2a1:f8be:17d3 with SMTP id
 d17-20020a17090abf9100b002a1f8be17d3mr18386760pjs.23.1712012090678; Mon, 01
 Apr 2024 15:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329184740.4084786-1-andrii@kernel.org> <e0426944e09d865946876f9bbd8acb7cf23d8705.camel@gmail.com>
In-Reply-To: <e0426944e09d865946876f9bbd8acb7cf23d8705.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Apr 2024 15:54:38 -0700
Message-ID: <CAEf4BzaSaWt6pLR1xj4Lv=dccr2sQhac4AC__BrR13ryb3Fymg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Add internal-only BPF per-CPU instructions
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 9:29=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2024-03-29 at 11:47 -0700, Andrii Nakryiko wrote:
> > Add two new BPF instructions for dealing with per-CPU memory.
> >
> > One, BPF_LDX | BPF_ADDR_PERCPU | BPF_DW (where BPF_ADD_PERCPU is unused
> > 0xe0 opcode), resolved provided per-CPU address (offset) to an absolute
> > address where per-CPU data resides for "this" CPU. This is the most uni=
versal,
> > and, strictly speaking, the only per-CPU BPF instruction necessary.
> >
> > I also added BPF_LDX | BPF_MEM_PERCPU | BPF_{B,H,W,DW} (BPF_MEM_PERCPU =
using
> > another unused 0xc0 opcode), which can be considered an optimization
> > instruction, which allows to *read* per-CPU data up to 8 bytes in one
> > instruction, without having to first resolve the address and then
> > dereferencing the memory. This one is used in inlining of
> > bpf_get_smp_processor_id(), but it would be fine to implement the latte=
r with
> > BPF_ADD_PERCPU, followed by normal BPF_LDX | BPF_MEM, so I'm fine dropp=
ing
> > this one, if requested.
>
> Hi Andrii,
>
> I've read through the series and it looks good
> (modulo architecture related issues reported by CI).

Should I add your acks in the next revision?

>
> Thanks,
> Eduard
