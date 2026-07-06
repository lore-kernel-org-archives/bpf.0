Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06E381AE9
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350159; cv=pass; b=Mhp00cDejU+Wrf+eombrLViSAe043QwF3r3yvbd7ToaNziGnP1/91HXsF611BwZz60zXonaxMlSdhoZQ6OYUPE3aCxaRvh+sXaYnZXA8jqbXmYNaCZCXs9iyz2Sh1ZqkcWSrpzHFVyuZTCH8/gQKnAQ+0NEwRiGUka5J/hqpRN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350159; c=relaxed/simple;
	bh=Wa+sxYzN0vgHAlrn1l7Ukd6+2CmTzNUEJPYH5iOPwcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZT7pmmcYq3cjLpOSmqSB+go2dgroQ6CZkNhiW0kcH3rtlq4AqLeTYAuxmnv5fxXW8D+yBwpY4izq7B5StmuhDhYP/df13dUWOFWizX8v2ruIdhtdSClwHz8IY6wJ1oSABY0lkVf6MAfXTiyQFrL5NdvkYF9jCM4ltgOI+MXuI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qgtEeKCT; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgtEeKCT"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-471eee9b7d5so624796f8f.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 08:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783350156; cv=none;
        d=google.com; s=arc-20260327;
        b=LXmf4A9Hw2Q3ec9NN0OgnI5XRQx22OF6744NamYeI7lA6d5hrnUH2mSj/rIBg2VwTx
         WThOvXPm3R8LHE93U+lyUsxl8blHboiNlf6W9ZALHa49WO61+Bgdl254aNmKFbbF9GAZ
         2LRCsCkQcrJ2MCa9kTiAT+0w0qMWI2C2gpT0tPgQlaEb95Js5Eltt5bzP0UoU4d1iHwd
         9LbKViTA+Z/+QzjRcQQ81oCbvPsKEIQtO8qJIHqN0lb8JRwwbXf7fsgSVPWpx4lrJkcn
         PACwwWbx2rMl9vd7eVhLhdRhNNV6ytdmOijNVciSRLSIDxgmBKtKBzW3HGAe8J1YGXAO
         H0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1Re96DzDAx3slkT4ts4QXijEXA4nc8QRoRbGyPo6co=;
        fh=5ETKfEaFw2uXeo1F+9DgvIe66ut9PEwSiWh1sFR259g=;
        b=L6/55x4Iy2SdcVfFJwU1Lb/jJu54XdMrWcfiGVH94EfG5g8I5Z86hyXC5STtd3+Mgw
         shJd08CZgA+ZcV72WemInWDspu6YZFaDBTIKALmmlGx4ojA5pGjdGDQQSmDOfaF92NiL
         47RWunTDBsxRsBJQxM08gYeRaVuXQl+z58Jd7pSmORDf0Q/hEgGAPYfEHmCP12uoFiwv
         6AEUo0n4tUny49jMCYEtyRhfKUu6vDe1vkjwk66GI7MO3+BIRQwvUL/TycNkPY9AkTjY
         SSqIeMtxdzRZxL5pwMNqtUSzuhUr+XfgA+lqX7a7CKPsXTQttvU5J4Cx5YzwqyRJPPCM
         R4xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783350156; x=1783954956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1Re96DzDAx3slkT4ts4QXijEXA4nc8QRoRbGyPo6co=;
        b=qgtEeKCT0BGk4TF9sUdkRP/+vGqXHYoRG0sP8mndNTb6xHHorVhYDo6oGTmgQ1eFII
         M74gEkmq/VMDIRLf4HtheiVvXCBpP7nxfvVIacR0TYkcxFP1fHRvLAfRRMqq1AHwdWDB
         DGANqlyFaDtLvldoF3GsiZClxRlprrR2wSuc35q7rLxLIuPgskTy2xNi4NNd9Q5UTplr
         WNEMWkpnDkUde9M1miMnScJvl9aZczNXoyfMxyIAs7MIa55LdqMcNy5yzEbbwAUr5YDi
         klX1JYYQ/YK8tMPe/ySDX2C4RJXx0JaQMdZQPuZBbC0hF95Mu81fmMG2a1RdmUNGfJim
         b8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350156; x=1783954956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1Re96DzDAx3slkT4ts4QXijEXA4nc8QRoRbGyPo6co=;
        b=F/1rAnmjg17w/XiXM+YB5c+unefIeiSak0qGJvIVzU3EBcLwfPcI/QdeJvCPi58iM9
         fseWAptOF3icIW4JPHv+0xgtsdgOi13ZznLDrC3mem6HknxupmjrXiadBOOkhbo1vXXG
         CRgkrvlYu8R+rIxyTG9bbbQzGAqMrVlnqcfmZDNb7bfKQjuzyQE/3vFF42KETGALcB7V
         cOyt+YmTX/E0PqEZ7WANkFvu84nveoH2Eshk12P+kDfz9JQ11UJClIYHNs14HBAoed/e
         /126pP6TUXWxJQYBBOjgU+cR+AiCAAX2MI/e264+0U8zoGYcXGMaYomQDJk0Uw5oLBqu
         7Qjw==
X-Forwarded-Encrypted: i=1; AHgh+RrDlELNzGbu18kZqbs5y9KtvBBNeqJPgRJ5PULojnvAPip6095NRJQRm0bqhL8lBj+9NMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP64XD1IsJwUZVTuPyClAj/DHmIQcbZztjiYKnvEKwQmFQwrms
	lfV0QMP50qpwtimtgdy6AA1b80RgAmNQmgrVOT33stKSADvt3JdjUpDVX9ZBEtV7r08VNG7JqTf
	1VObObGGegN28aiM4IXPzxuOZbrsB8OE=
X-Gm-Gg: AfdE7cmadUsasxlQS4VrKSqqmgZfLERfFEocz90eICzHR30HlmQoS3OiLFQGQlqMOZ1
	BzPEYqJs7/4gkoOROVFrP4+yizJu1KjuYrD2hQQf3+LgKJRKaBjIgVVqj4OV7YJTWAP01GOREfI
	SfLBrYPBMKp5rdFA60Ii9cb08e/eJ5Vce0tSAlansOoG3CGr2AwoNYFzsPIHLLxGgOZ8VmHJY/9
	oTcdVPHw2y906TwFRcIBSQB4TaQnageecDLPOI4UPH2jmz/6xfxS8J6O3XR6SS2b+Pv7DeeWWTw
	nQQ8j0JbemVxqYMAQTWo5tnbPYsAA0HvhSQ4x+Hd/Q==
X-Received: by 2002:a5d:5407:0:b0:473:ba02:8cbc with SMTP id
 ffacd0b85a97d-47de663c413mr662008f8f.0.1783350155940; Mon, 06 Jul 2026
 08:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com> <20260701-kasan-v3-3-bd09bb942d86@bootlin.com>
 <CA+fCnZcJzRvq9942LXgTpq5067u4DvXQRjdNDpq-5vOZpQuCVQ@mail.gmail.com> <DJRJVY5TTS73.2NQ1NZ8XI5WWL@bootlin.com>
In-Reply-To: <DJRJVY5TTS73.2NQ1NZ8XI5WWL@bootlin.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 6 Jul 2026 17:02:25 +0200
X-Gm-Features: AVVi8CfA5crYSwWCMxhRRXMzJghcorjwv-nINM4NjlmZ9iTniJZPIYvEuEmIswg
Message-ID: <CA+fCnZfbR6uaypws58MUrzBq=Q+yUuckt5Rm6CKH5nrMi_aL=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 03/10] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	ebpf@linuxfoundation.org, Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 4:16=E2=80=AFPM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> > I think it make sense to put KASAN_GENERIC into the "depends on"
> > section, as __asan_load/storeX() are only defined for the Generic
> > mode. SW_TAGS mode is expected to be soon implemented for x86-64, and
> > that mode uses different checking function names.
>
> I guess I can move most of the kconfig options that currently are in the
> `default y if ...` into dedicated `depends on ...` lines, and just keep
> a `default y if KASAN`, something like:
>
>   config BPF_JIT_KASAN
>           bool
>           depends on HAVE_EBPF_JIT_KASAN
>           depends on KASAN_GENERIC
>           depends on KASAN_VMALLOC
>           depends on VMAP_STACK
>           depends on BPF_JIT
>           default y if KASAN

Assuming all these are required for the functionality to work, looks good t=
o me.

> > Would also be great to add description for this config option.
>
> I can fill a help field with a basic description, but it will be visible
> only by reading the Kconfig file, it will not appear in menuconfig
> unless we make the knob user-selectable, which I would like to avoid.

I think that's fine, a description in the Kconfig file would still be usefu=
l.

Thanks!
