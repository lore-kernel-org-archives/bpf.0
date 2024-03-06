Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EA512E7F
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 20:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709757364; cv=none; b=TCHcT0KApJ6a7kOdNUKdAVdwbDmvCSnGMvI5m98ZtC7yEOglKyni1oxQX9X+XWenxnwHAW5Vd+vZMne1KPlb747nN83tngIVemS3zSamHMh2byFK8XJlt7ZUNNPWo1WXENWwHhwUtaiv2PjuDIYerefgbQkdDPWSbWub1QeLT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709757364; c=relaxed/simple;
	bh=57QJgvCXNuQiV7zX0PnOdNGOTBD2NlXLT5+yEW0NU90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=po69uupYXijb+EfD/3YPIg/XUZy5/1lVG1P211g9O5MHLKoQkKTZB6jgtlT6itjhI5JVkU/FJFuMITdXIdW7NiLgPlzPSAykPXVm6LHV3+vd94DUdv8G3+vZwfV+/tngAbYRdvVX6MJX1rr8X8eSQ82dliZNRJ2APrDhl71DFGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXkkx5AA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXkkx5AA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412fc5f5152so1627795e9.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 12:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709757361; x=1710362161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQJpGJWotUX+kR9l1KlTGOgcPZTaXDmkNZ1dQ+EXJ5U=;
        b=LXkkx5AAAdXlm0kTkHDs3AtTticvOZEYU/K/bQ8yfa3UqTL+87gBm+VoIJXzDKvNw6
         tinlN5GSfJ/6zmsPPM58YZdxMbZbDhao45rDGKz6/NEpW4O1VKz0N0NcUsnOnsP6v6B7
         CDV7pd9js3DGwsLKKmHkbfRXPhr4wPWlx6msd3aSoQpM8zQDJc1U3mhofQJUK9VHxyRm
         bEwVx2i4AwtYo2MRBlLbQpbMYau6kwrmD/f5eSXIjWQ0YHxYvvZvlOqzK+5B1fgZFNpA
         g7qF3fzq7eIWqS15uim16nobfEtyAlkS4mmf6pYSVKadyWNTVcC8LuTc1lKl+INsk/No
         hVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709757361; x=1710362161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQJpGJWotUX+kR9l1KlTGOgcPZTaXDmkNZ1dQ+EXJ5U=;
        b=L/xsRhumiSFUc5J0nIGKVPOwT58Xo1PA9eHGhO2OBxnqLDVMB8E7ug59xMpfcLpNrG
         RLI5P9qKIxXz0re8h4ALOIQ16TXMVyBbzLLZwB5nUY25IRPRXX/+d0DBH5B2R56WIIoe
         RdoGAyP/oYS6RRuYnsw656yDoUqBB0ewzPu6foNeVNhcUBcZHC1pYeBUi7JHMklvR2xv
         1sSyhq2cL2fr+7ioeqfvBQjo0eyHXThxO0ShWA4/108cxepJ5tr5T+jqlIKszUd3EXVO
         aJXfrCnxD/mAzrQVjnpVZMvXA/6GO21vJ/jy/5ZnMkIZ5tqYrvSRorHrlmNWNa0boEb0
         JNng==
X-Gm-Message-State: AOJu0Yw1paZ+P2zmh4LN95a7b4NoX50UEt6wOLuzIQ1SF1PR9qhfTYz4
	0HANsxkwwQgg7UeFYYz1usPnL59xPzESSdbp+WY++Yx1WgkWPxgRos7KtYXrOMqAHuDBbrxMVwb
	PMeJyN09UGLxGyXCiqM2TZ2hJxR9wNxonyCU=
X-Google-Smtp-Source: AGHT+IG8kTY3fDVgW77DIGRAHaVbtwt5hprgQjCJYjNIfmNa/+KdX8ub1LapQfH2a0wIHKp/wINfq63nNDQ1GmO1ua8=
X-Received: by 2002:a05:600c:1da3:b0:412:e848:79df with SMTP id
 p35-20020a05600c1da300b00412e84879dfmr5350530wms.40.1709757361110; Wed, 06
 Mar 2024 12:36:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8F75EC74-53D6-4841-8D41-4CF56BE69730@isaackhor.com>
 <CAADnVQKY0d2ww4hwbuu3TA3DFyrSeBnRqSp0qdEY2Scgf4kP5g@mail.gmail.com> <d55baee2-29bc-4057-b0b8-c789df8dcebc@app.fastmail.com>
In-Reply-To: <d55baee2-29bc-4057-b0b8-c789df8dcebc@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Mar 2024 12:35:49 -0800
Message-ID: <CAADnVQLLJpvFR5oFrWtJ016j1cA_SeTT_+2S00iYTUnFo5seDQ@mail.gmail.com>
Subject: Re: struct_ops usage - verifier interactions
To: Isaac Khor <contact@isaackhor.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 11:57=E2=80=AFPM Isaac Khor <contact@isaackhor.com> =
wrote:
>
> > Was it compiled with -O0 ?
> > clang didn't even inline what was marked as __always_inline which is st=
range.
> > Make sure to use the latest clang with -O2 -target bpf -g -mcpu=3Dv3
>
> You're right, the optimisations got disabled somewhere along the road whe=
n
> I was debugging the problem. Re-tested with the compiler args you listed:
>
> libbpf: prog 'bpf_iden_max_ra': BPF program load failed: Permission denie=
d
> libbpf: prog 'bpf_iden_max_ra': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
> ; int BPF_PROG(bpf_iden_max_ra, struct bpf_fs_readahead_state *s) @ reada=
head_noop.c:7
> 0: (79) r1 =3D *(u64 *)(r1 +0)          ; R1_w=3Dscalar()
> ; return s->ra_pages; @ readahead_noop.c:9
> 1: (61) r0 =3D *(u32 *)(r1 +12)
> R1 invalid mem access 'scalar'

yeah. it should be ptr_to_btf_id.
Check that your kernel has CONFIG_BPF_JIT and
CONFIG_DEBUG_INFO_BTF=3Dy
CONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=3Dy
CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
CONFIG_PAHOLE_VERSION=3D125
