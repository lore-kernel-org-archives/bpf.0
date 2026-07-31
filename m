Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61E38DD3
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456438; cv=pass; b=AhgzZhakFFsGE3bCy2zQ7WmsBb1dVxxeBBk7jX/j62D1NHqaItGfL1CH3TT9+klt9Z1ROSOf2plq9CoQXo9bVyAqLjlut6HK6IO4xjazXN1O7WqDj4dGc/Qym1kFG7rUGujDgBZCs9SyHTBFPwiPDj8ud0pTene8CR4+/XvFOb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456438; c=relaxed/simple;
	bh=IQgcCgUN9ob2aK8ni//osqPFYvEUV2QuifcC8kLAH3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdmAzuXxKsr424sJVuM1wSspz6HwZmP0CM3/0XNneL6evEbxJGYXYTHSHWn73cJMNWT69DEM5F38R8TI+HgA4WwMdlcv3kv1sivmt3dqUCWjg8nYmbfa/NgZCbZrtfd2BR6dOAanXxv4maEU/K9bIEEcgpbkHMb8Ut5oSLNkJE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqmcu73C; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqmcu73C"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so398032b3a.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 17:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785456436; cv=none;
        d=google.com; s=arc-20260327;
        b=AxDikuJZpeDCeMKHhkUH009s5/LH0oSYev4faQyljhcwFLPWkKYgoDYBW2IcbrHZdQ
         gkocgIB5hbVawdhxVJuWUN+ebjCM5IbrCGugq1gwmk//vOZhFJsOWH9GJLCYJ7x+8cPV
         pnSj6HA6mAZjUrM9nekeA8ARcd3PcDPBgsTnbnIvnJlG15bSJZkn2bd0f5SMaPZmx2Rw
         HZedX40JzEdpCMdF/V7ikKrDvWdBANP4jSqU+L4/4Y3XDEDXWH3zowLd1YL8/TYCd3oU
         NRYABZ3RNDDnmq9AlZ/5j4nFsuS3bcO5Ru0bThUSvdY4u3bqI7J7h9AoP6685wPwhGPE
         5H8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ywzw2pnBpZ6rcuHQ5GQtNDziaj0w2OV9J3er0qRqvRs=;
        fh=ZD+TWjvdVv6CQAJ03pcYJ5YB24ceDiblC/Zer5CxQ0A=;
        b=EJmSSbR8VhG47z3b9iHFsmD1OjgTqVfBgIpFKr1yT/1qicDfSRc7JFH5/QjIvX7rGf
         lAVhfmdyQBisHqdyILyTTQdA5ddWOEpKjlchkUsnasfcq034Zjfn3UFCXVgPf+vJ7F8l
         fzS1hDbyAG85+u+RdVlWmgNRvn5eWny5FrTf9C+mToszIe0KRUDDrm7JVEyD1P5R8EVL
         tzqouh/u8pVTKTLFXiESP+h74InI3G39wE8A7Bp/DcOeGFuCCYTg9TNC3czi+wXxZxY5
         hq9IWaEpOJmpL1e1XEyzq7iOdVH1P5+af+Lexo1Z+SxcKy54C6QJs7/k9aBszwJ+AQ38
         QN+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785456436; x=1786061236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ywzw2pnBpZ6rcuHQ5GQtNDziaj0w2OV9J3er0qRqvRs=;
        b=eqmcu73CpPSiKFhkKn1kG4usgrTsv4Vsy+qAGJPjME0CR3ZnnhO/hgAW21Zl2Hs/rZ
         w+cHqyDxFRmjTz2wQu9fRwECJnWsgtX6atJXYmGhv+n8duBKm2Qis2CKOs2voFx9Oiib
         o/tfN2Ga6oM9m9arEwHorpfpbX4k9DOilBaKbBNPsIhphy/1q+4LPlrfFHUumwbfw55r
         lUyZXDtxjFOPOLuCj3IxSz4n4BvEevUl02KJnz2QwVIWi9XDHkVxTZ/aQLfjje+HfC/b
         2DRVEo7zSdY0MSbsOHbdBvVxPEaIrQjhTNuKBRFjgA2f+UMR8XKdmhkPfiCguGduEM4y
         /W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456436; x=1786061236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ywzw2pnBpZ6rcuHQ5GQtNDziaj0w2OV9J3er0qRqvRs=;
        b=dLtErBgKdnkVni9rs4fdBFq71HjIxZX/bhricpLpbR/l1uUqbnC78/DYkA23AtvEwi
         BtV38qkk+WFc52SRLjVx+714MeyM93FD5LM4q7BrkMRkCytvtpTumKi2Ibm+8H1Wt9vu
         U2zv3oqmnOP5fosqhAaY7DO1rx0nFWSfV/0EV5QPekAYYG4+maZnI62mskqlB4M+aa81
         WGLQJOC/qvRZYmUstr4DDzDFU6qjTFfItb2LVSGPb+kC4Ip/esPZw8DneUtLkT8veVe4
         V6VQKBF6eAHkCHlTvK4C4xPqP5zQSQ/JMH4g9FuOU1/NvzHxybFSgQn25ld/a/fvZmZV
         JQ5g==
X-Gm-Message-State: AOJu0YyjklvKfYdQeRt5zpKj1HGAZAKht2Mt+FsGB5FJsWT56TPeIAwy
	IYnYcRpnNq5tYrAoiERTpgCBjkqwGpqZuByv/OioEveoXeE+GGlZiDyk1IYoKELOvoP/PpaX5SZ
	fuJZb+AaJGLhN3Uti0cD/uS1Tuvh+6cs=
X-Gm-Gg: AR+sD11gE8KCZ66mSm/ldsb2Tj1uOXSxYv6lhWfTeZi+YXnBZ+qUVWbPhhOfvmFsdh1
	RKB1HmYagl+NXNEFCcOQhZ0DaudZr3sbAJjMUZOM7uNxsPQ8TA25dc+DTNkF5nUs+jIE6O/0iCS
	yYDJEcUrOQZKZrXcrQCwJvjji4YclHr2Sn9eet3pC5mE3thexyAUB6NwiTjHtzsrnmcl3Mi6+Od
	XKJ/f18VSmSYzSmlEBjiZUMPXY/QWzV7fqncGCfDhoCc5E1FNtaKqInsT8F7N7p4l76LWM8eUaR
	jjum2mn/sJaQdHNztz0oxce94TVE3obaHH+kQH3d23Hv4uijQE1ib5IWYffaKDwppzUGH1gp2dj
	fGYI4H2CWtZff6fi7OSyYaRjbaKFxgGhRDz4zoKltfFpPEOztQqL/iw==
X-Received: by 2002:a05:6a00:10d2:b0:842:614e:cc94 with SMTP id
 d2e1a72fcca58-84ebc241216mr4383107b3a.26.1785456436320; Thu, 30 Jul 2026
 17:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725132624.78373-1-leon.hwang@linux.dev>
In-Reply-To: <20260725132624.78373-1-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 17:07:02 -0700
X-Gm-Features: AUfX_mw0ZEm9k-Ub0vT04vq0qsIVheV8T4aJPOF6Vp_lZfK9C9VKzujLurVt-sw
Message-ID: <CAEf4BzaoQaODE4F1wfrp37=83bePY=gKpunacKr3rmO230+B3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix sleepable check for tracing prog
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Sechang Lim <rhkrqnwk98@gmail.com>, 
	Varun R Mallya <varunrmallya@gmail.com>, Viktor Malik <vmalik@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 6:27=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing pro=
g
> is allowed to attach to '__x64_'-alike prefix symbols.
>
> It is because the verifier does not verify whether the symbol is a kernel
> function or a bpf prog. That said, a sleepable tracing prog is allowed to
> attach to a bpf prog target whose name has '__x64_'-alike prefix.
>
> For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP

we do have addr, so we should be able to distinguish between attaching
to kernel function vs BPF program, no?

> prog, and copies buffer from a user pointer with bpf_copy_from_user()
> helper. After attaching the XDP prog to lo interface, the kernel BUG
> could be triggered by 'ping -c 1 -W 1 127.0.0.1':
>
> [    3.460756] BUG: sleeping function called from invalid context at kern=
el/bpf/trampoline.c:1324
>
> Fix it by disallowing sleepable tracing prog always when its target is
> bpf prog.

what happens when we freplace sleepable BPF program/subprogram with
another sleepable BPF subprogram? And same question for sleepable
fentry/fexit program attaching to sleepable BPF program? Is it
something that just cannot work or we can actually allow that?

>
> Changes:
> v1 -> v2:
> * Drop redundant 'prog->sleepable' check.
> * Collect Acked-by from Viktor, Thanks.
> * v1: https://lore.kernel.org/bpf/20260724141422.10463-1-leon.hwang@linux=
.dev/
>
> Leon Hwang (2):
>   bpf: Fix sleepable check for tracing prog
>   selftests/bpf: Verify rejection of sleepable tracing prog
>
>  kernel/bpf/verifier.c                         |  9 ++-
>  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 57 +++++++++++++++++++
>  .../selftests/bpf/progs/fentry_sleepable.c    | 19 +++++++
>  tools/testing/selftests/bpf/progs/xdp_dummy.c |  6 ++
>  4 files changed, 88 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/fentry_sleepable.c
>
> --
> 2.55.0
