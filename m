Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15724291E
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 04:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769574513; cv=pass; b=jjY9W+cINmfn/PPvAKiBcBdrQwJcYzxfOuzccFimZA6bkThNOk3nBkIegb7o9uPyCYiP4t9afcAvJEihDDUazFsb0uw00j0r0iRPNx/AZG/TTWd9Uw9kgycenFICK/HatbLaMQvmnMzvhP9nrysQavEprA+Zvis5TLLlQyyZxu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769574513; c=relaxed/simple;
	bh=j7hShYPeO1N9+zbQK+hb51NpB2ihGqVur4xeazfb+IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+jg++YaKdDdZiCoNZDsPvigSWdCOq+YhjoW2BdrOsWtBuEyOyWyThYfW8AChroU5LyXBDCBjXr3EgL/q0BByUwzAST8ni+6gIKTJh29EMjQ2TDQ2pzlvGI/td4J1ceFnkyIfXhIrmiA5NPZrN2HiyXZLzp5NDkf7GzZo0atX0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2O0fzxw; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2O0fzxw"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so49369785e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 20:28:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769574510; cv=none;
        d=google.com; s=arc-20240605;
        b=OhsX/+bI9oowc1zds6Dorf+tdZbXofwJfag0HIlWx7Ox9z513stx3+xzUclm2Yo2ee
         gim/R01p33yg8AKj5BQ21y8JiNaBoTEO7jQyqe8KtRMC5CYQ/gHUDUryoLEgRkKM+BLz
         0zqOZ2hqau1EGDBAJmPsXbfgSfgDxcuHidM4bPse3l/uqHbRwMtlUf7rGbgIifKGWm93
         oGEU4GAa6M8qlGI7CETvYvPpF+GXelnniB/vEkEa0KrC2yamMB1KNk+XtTLRYqFiSNzm
         c2S9PXMStFdgDguWJQLEDtF6yIDhr5LiVR/Zeu2iBsy8JYWCRIHM77N8kBbi7Yv8EIk+
         QwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j7hShYPeO1N9+zbQK+hb51NpB2ihGqVur4xeazfb+IQ=;
        fh=rsduFLXL9tI37J7Qy0ELhraHmEs7X+vW+3cgjBY5QlE=;
        b=F3/ROXnmMUTuqJs1RJ8HYwIuA5YZSc0W7tHY5YwrF5opqUzhccwzuMZd/Anp6ynDA+
         NRoH1x8Ljj3tWXCnZ/wZ1+Azu22obkvIWhYce3u/AzBNmRL/hzL2l53qoItMT3olKakP
         Q2Q0P9bCXLn0R1/00vKgZRstuiHB8NWInZY7JnIl6Tpg9INIajzuokiIKzoFvj7StV/X
         Af6WkZFQebEaAZs602Yrsnb0uCdOFdy0TsK7yA1hbiGPPPSohz6k/CfBKhZt9iyoaRxi
         Kd0LNmuZ7etToir4a+FDD2/A7qkzT6tzzcDJOFPPA15L4RBOWL1AiifG8kEKEJrigg1j
         STQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769574510; x=1770179310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7hShYPeO1N9+zbQK+hb51NpB2ihGqVur4xeazfb+IQ=;
        b=c2O0fzxwOis0wfJ4iVtve3ZHMupXRRPMEYFWISdLg0l/GuSQuiTZgP7IzvWBxb+HYk
         1HBhdm4lwHRPdd+Gij/a6REta2mpz/AH9f3WxNa7ZsESFaoQ4bUv2zgrVl029k5arVlY
         hYZK49LR5ob19BXR8iSouG7PsPhC4KZTJM7k9tUh2arhonsuLUZyFPGk2+XfxUjez4kN
         vlZcZlaKtDUcPaXj4CAHsuqpEnylRWKBqIv17G5twPqnSkysMK2NVGQ6Qwub4TrkP+VQ
         cRpG+P4Zxeex4EDxSLLoqa6xrN8NiyRbK2e50OlOxiCafDSrm3ixi0eoS5H5aiZMVjLf
         0NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769574510; x=1770179310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j7hShYPeO1N9+zbQK+hb51NpB2ihGqVur4xeazfb+IQ=;
        b=AkLcu97TOVzO0omFLdBI5mRKjhQmAr2NPfUBjJfBbgmdxdt93PfLRgROo9y0hYLll5
         PJ5LLUzo+YK+UVPz4AcaIsGQ4Z8uFWcNOqp9oGIuwenwZcrbFcC2jdaKF/f541nX+EyO
         gTcQckRnxUq84mfRPEqgaypd+m1DzMGAbbTa3oZMcAbx6MskS0FXW1xsinurKLVZQ34i
         uT1trm2xt2mHXD2DTyRqXoq1n9jMGpUj6dCRF6cQgSowcPl0LD2jg2/ncKTZX6YPIHS5
         WR3e/Xs5rfMDWJjGWUmzYt4D6wWEn5QV2m11sxapU3c/SLtMc9CbTTt1fEgojV3VY4ui
         F+mg==
X-Forwarded-Encrypted: i=1; AJvYcCWkYdKri+RmKjShYCPtwAzN2bGdr7apMm+2W3C8SelFX0RR3AbcL/DLTLjR9lwdBSPy3GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmSxTdBiiMveXf1ZGqYHaPZtQexg9+UL4ySd1KxnLrn57+PtFp
	IQn5g0cCVRYW8MdO6wmmLqh01ossrElsvFoI6pDJwtWGAKdFDK2F7NE1uTgPFbU/0GAbJ+6+yrj
	4Yn5VIR10MdZ1AL3LW6aKo90F7BQbs7Y=
X-Gm-Gg: AZuq6aKqZLG227b4Dc9mTPUVHhgnkDxAZH/ltzzZycFZiEazF7C5vKdXrJgWIgYMorc
	zMG2zmF4YtC7uG8mZYUSb2EcANtiYFIOSF5bXZSRuzuowdYbj0zn7zJKi5ppbm/vwISi0YuYsJA
	tAiHeMorpGao8PDw69lQk1AloGYPs8Er8MoEJEMhSybGRSmcM5IYMW4JA8q5rxFPlDzIO/GyQbN
	5Vm+mq8z7AqDLRkKR1mnF1spGBTajDkVYkzV5cmaBnJEQRCNR5Z2N+qH6hBcf8QWjZi6V0fmXAy
	udqpjAaHnHV6AqiCZeBCuMyQg5NBxQdMkjk3v59ny4NZr0XgAlTnIfAHK+IiyLa/7T9Ybqm+5YF
	mzAwdadUnPNezVQ==
X-Received: by 2002:a05:600c:154c:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-48069c3f021mr54274985e9.1.1769574509966; Tue, 27 Jan 2026
 20:28:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122090404.15553-1-chensong_2000@189.cn>
In-Reply-To: <20260122090404.15553-1-chensong_2000@189.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Jan 2026 20:28:19 -0800
X-Gm-Features: AZwV_QhD1w-OAF47igZx-CBdBxyMwEcMdyteSlPLOA4DuDwHNBlCzI4bC9Iejr0
Message-ID: <CAADnVQLVQW-Mb_d+zT+aSpPOZ042erPVcSHVBx9PMGET+a754Q@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/bpf/btf.c: reject to register duplicated kfunc
To: chensong_2000@189.cn
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 1:04=E2=80=AFAM <chensong_2000@189.cn> wrote:
>
> From: Song Chen <chensong_2000@189.cn>
>
> I had an ebpf program which calls a kfunc defined and
> implemented in one of my kernel modules, they were working
> fine in 6.16, but was broken by libbpf in 6.19, the error
> message was:
>
> libbpf: extern (func ksym) 'bpf_strstr': func_proto [5]
> incompatible with vmlinux [94389]
>
> yes, the reason is there is a new added kfunc in kernel 6.19
> which happens to be the same name with my kfunc. However the
> error message is not obvious enough to address problem
> immediately.

I don't quite understand what you're trying to say.
"broken by libbpf"?! You mean that kernel 6.19 got
new kfunc bpf_strstr() ?
Why libbpf error is relevant?
You mean you had your own custom .h file where
you defined your own kfunc from a custom module
and libbpf complained that your bpf_strstr() kfunc
definition doesn't match the kernel 6.19 ?

and your proposed solution is ...

> Therefore, this patches searches duplicated kfunc in
> btf_vmlinux before a kernel module attempts to register kfuncs
> through register_btf_kfunc_id_set, it prints clear error message
> and returns error code if same name kfunc has already implemented
> and registered, then developer knows at the first place.

Are you saying that the kernel module that supplied bpf_strstr
shouldn't be allowed to register its kfunc if kfunc with
the same name exists in vmlinux. So insmod will fail?

This is debatable. I guess we can add such sanity check,
but what about kfunc in module A with the same name as kfunc
in module B?
Currently libbpf tells kernel both btf FD and kfunc btf ID,
though there is a single namespace for all kfuncs from bpf
program pov the kernel and libbpf api-s allow a selection.

Technically we can hack something in bpf.c to "namespace" kfuncs
and say that the kfunc "foo" is in the module "bar".
It won't be pretty in C, but possible in principle.

Maybe a kfunc with the same name in the module should be allowed
to override a kfunc in the kernel.
It can be seen as livepatching of kfuncs.
imo that's a more interesting use case than helping
out-of-tree module to produce nicier error.

pw-bot: cr
