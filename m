Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BF3A0EA8
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016388; cv=pass; b=Gij6CXIsRq3tsE16hiEpuNCC+BMJnBo9mzHbur27Y+EE3cw6jVosqsdLsMcnKontIzfSUeo0dmxtCuchJXBV0KHbMt6io8D3Vg7qNH+lGElEjBa5Zj8YfvVrr12gseGoFx1Mj26eaSO3yDbDbPFbZm9Texsvpo2nUVGlY1aaUVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016388; c=relaxed/simple;
	bh=s6nK+J8VoFgC7sF4ENH8AjRgotLPT+tJYq56JSxtM+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7q6L8fwjIzM6XZ1oaHptxh6+ArTSJMnh/DWCemkSi3en9xsB4WjGg4JNLGdjnEhNr4Umgl2saCO7FnAdYXA2+J+lwPb0rU+rRJpMU2UKd2p9Qe2/Pac45WVt8gnl2fRZ6WJBSaZ6wDlj783gp49jv+8zNpl3yYRP8SwrNz0Vvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNaUo9xp; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNaUo9xp"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb5810d39so41323f8f.2
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:26:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769016385; cv=none;
        d=google.com; s=arc-20240605;
        b=ByK4Nj1DuD1d9qPC8ZDxMgerKLVmwS4ZTlCsG62nbWGANGoTrLW+AvCKtVyFgANsUz
         hYwzk6dPfOvXJEhJYjdfCjNlZ/CB1tRabZEe0zzPF5StIBTmoULZ2fSxQ1BFi9Pbn4Ky
         nm4667ju7BmHhfFxFiYev3dpWFH36tnZLy7rFToUd1letWqV83Lr5z02NjTRWbBSYwwZ
         QzV6RWDo7cUQeT0pNI3KBe8zmLj4XijVYYPoMjcCumm6QmdW+8RD90ZKcrdvDhnK2PDM
         arRDbHmXUeANMiapJj0ZJXbCSsM9SYAlf8Bu9G/Hd86MIfPTGJuBU+1iPBY6gGzFelFC
         Rv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jMaTi4cf3sv6GoY2q4sRfmpeePaW8ECxRIDqOj4Udtc=;
        fh=OKmSFYUI6fQUQ5RpfzLWFAWwxqa91WuWTkf1I8NvlwY=;
        b=ZvWwXXHjwdwhGqx8pTYec7AhLZ52O6Mz6PU49Bxvov5m2G/Z0vnKdx4EJHD7kOA+QB
         2D/4vHSbh/lHU84yPPCEnQgDIuywspZ8fSuCsl2fgSGelf1JtVCJpwf/iB6gtfen2ygw
         V6KvA2V5PfA4zoKG+e855DBpFFJgiWs9pH00VKLFt3+5I6ukJBVWuCsd1Ubkmv4qF8zw
         0t6iiOy+J+e0SOdYqwxMeNDL8H0UKxerqwTagDYebmJ3hwxhVsLGnsc5Ctyae9p7cJMJ
         AKvWSEysrOJxr5XgCVvkeRQVnOqnckqTdQP53zMYnfgpNKjI6thscxfOgRrb6walzHMf
         kpww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769016385; x=1769621185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMaTi4cf3sv6GoY2q4sRfmpeePaW8ECxRIDqOj4Udtc=;
        b=MNaUo9xpG61R37mAJnvytH3YCDQgYASCrtkekJP8xM+rXyWZAqsuiw4SgAc88BybvP
         lpUt5ZOjFP22eLAsyuBPBOUoNPx8RG+lXPq4ruD4xcj6Be3LCcsTSzQeouIPOht3jbnb
         1p43PqbcHev46EBmgCIB1EzAwDSiUJrbQZV2DVa7bdpMbI/UgJWLY4RwskiBeAVNCNJH
         FdJuB4Wh53bt3ZZeUOH904LEXrh0TjeBoxvVYMMRkbDKroDGqg5qaEx0Qu06AiNlj9rC
         8Af06Jkw/hYdBYQf5PV2+cWiYvuuCr6op4xjRok97upm+Puj826rX0hP0lpHjCe8SLTp
         +NoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769016385; x=1769621185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jMaTi4cf3sv6GoY2q4sRfmpeePaW8ECxRIDqOj4Udtc=;
        b=OuoUZNDPz/yfy1E5uFRgAzX2SGqVO1xX1LWj3CpPgCPhB0z3bnHEabigJPHQWNlVUq
         IudA4WfhMP2jYR0zYnq+xbsyR6LQriqGILVU/NuIwphdvoPSAWQCi4y35R1tH5AQuJs9
         gwPJbhupDjuI/NSP4DOyEKN7K9Km/VFKKR4ZmaI7/o5/3w9yB50UWlqxkGHfxRNBBBRK
         KUmGyiVxlqQlKTgyKL75Y6aFi8+MykhF3WMqiBd5GSrJXYPUsfhhvGujBRr+48lBwChC
         HC2gd6l/AMsSRRodt+UFABs+bofsPdphyDwTabPRutMlRkzCKhyPTPZwnGL5OE0L+rYX
         l8Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWk1brChQD3NrfwBBVPlCmFLSyg+1/3oFMlHRONVRxbswLTcoUuLZRuFAhaMGv/hWtrr8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwFLJHZQHUqcmFmtNFo6V+081czMT1ESH8+Z37mMOIgbuxa2k
	Ovxjpi4BQCXj57L4e9XRMclYgPdqCmPykqlEgaJVRSDRYD1bvstJFNriZ20iakWQPA2UdcCxa/x
	vfpLnZQeg3GmQwAE1++9LFmOPvCWB9ww=
X-Gm-Gg: AZuq6aJG/FSgPzmCxdP8OcVzJOIw+yMC4b+ipMMUgnHHQrzQu5C9DBb+tPcbhXjIAfu
	aGuuSJBe2nbaTBsO/DqWOfDKITWtZHdaAC/ys5euPzip7INUWb9+zKqqtWYErSCF5OrTu9mKkCX
	eaPk1KO4TFvd+6gQ8T1Maf/8yrZj7I8IKQ1v0xcFgSKHFYX08/L4pATd+UBeVYOanBYPjsDDi/K
	btD8+tVcx/An5BQdZUraW6HOQLQUnqll5+r2P0GiWqhByOIrFHTligKUmeCyXLHBxeJ2DQnltV0
	oS9CupwOULKnSNrrNS5vCUQtjOmPmSuePJV9Z26EIhrkUd9zLhfvbf9UYEOK9HY1Hs3Yow==
X-Received: by 2002:a05:6000:2502:b0:430:f58d:40da with SMTP id
 ffacd0b85a97d-4356a02491emr26853046f8f.10.1769016385090; Wed, 21 Jan 2026
 09:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-bpftool-tests-v2-0-64edb47e91ae@bootlin.com> <20260121-bpftool-tests-v2-1-64edb47e91ae@bootlin.com>
In-Reply-To: <20260121-bpftool-tests-v2-1-64edb47e91ae@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Jan 2026 09:26:12 -0800
X-Gm-Features: AZwV_QinuMDi78LsKHGOUoOqDGqF2DuFQVsGJc44x21qk4t4r9EpKfs6RWIXC7I
Message-ID: <CAADnVQK0kxfjkORv8=a8W8peiBTtpzB91FCh=6X+N0iA+OCzJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: reorder test_progs sources alphabetically
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	ebpf@linuxfoundation.org, Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 7:18=E2=80=AFAM Alexis Lothor=C3=A9 (eBPF Foundatio=
n)
<alexis.lothore@bootlin.com> wrote:
>
> Update test_progs sources listing to make those sorted alphabetically
...

> -TRUNNER_EXTRA_SOURCES :=3D test_progs.c          \
> -                        cgroup_helpers.c       \
> -                        trace_helpers.c        \
> -                        network_helpers.c      \
> -                        testing_helpers.c      \
> -                        btf_helpers.c          \
> -                        cap_helpers.c          \
> -                        unpriv_helpers.c       \
> -                        netlink_helpers.c      \
> -                        jit_disasm_helpers.c   \
> -                        io_helpers.c           \
> -                        test_loader.c          \
> -                        xsk.c                  \
> -                        disasm.c               \
> -                        disasm_helpers.c       \
> -                        json_writer.c          \
> +TRUNNER_EXTRA_SOURCES :=3D btf_helpers.c                 \
> +                        cap_helpers.c                  \
> +                        cgroup_helpers.c               \


no need. Even if we sort it now it will not stick.
Files might get renamed, new files added to the end, etc.
Just add whatever you need to the end.

Also see that there is a merge conflict. Pls respin.
