Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141233B6CC
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738501; cv=pass; b=qqaKnck0CG3tvcJJ8FBuRoIjvmvMGtt0bYgbib0F+J0KJIUOyoe8nHvxv5zy5bUdg1kCmMrffltb3gdkZsrgtYC7NMr1k1TDkYNljMBWD2CvVVrli+lXM3EPyDEYbcmxuXCIM79j8ELdDEvmGPjSHLKMB0uQ2p8LaVpcD33kBpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738501; c=relaxed/simple;
	bh=KFPTccJmCntImLdbOr24nMiiPaYbTmRyYO5D7YOkLUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRpgS8yZ/oiBdJcFuTzi5LHUgkHwKQGNZ2YClYc76Wwd359oCaqa9/VPWyzCbHApw44Qc1pPrKVxq7+Vc3SiJr446ZvyCVC4oaQXJNpL/HnzcSpf6rQgZbwfKy4Fl6e0ltdI5LSvfoL7eRFnXsHiX7TroYNp4xzi9V/1aNAbc5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmoV65V6; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmoV65V6"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so1187596b3a.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 13:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786738499; cv=none;
        d=google.com; s=arc-20260327;
        b=BPRzl+9q1cL6qV5W848kfL7Gk/syYlaJvy5p38tIdpMiCOQjiX9ty+JH9hDAXQjQyV
         yUBZMzMm2PLCap4civX+iQpwGmVY+/GZeBZyXgDx3INXswfFvtu8YYkjIC2HzDVWUulx
         ilV6wumiTjIPe+rok7WWC+hyOzfm6JSqrGRBS1o+blsvZcrW42vAjdqPIrOZpWBMo6tj
         bB84zXqLmuNKj9YV21NYgyppR5ZDZlSwkzonH3kowXaSvd2J9swiiewfNUZ3294xsp8U
         I9CkGiQFBAJxufEQqCOAAEellPfyJOOqon/HIUA6/qNdkdYsfvCaAMKwd0CzdWd1SNSL
         1w6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/t15TRNaADzO4hHI4fJDqg8v1F/rUP1SbSZ2rz1A+vI=;
        fh=7PZC37LH2sGqwLEK76lee9BsohGzibMfIH5NgvVumkM=;
        b=d6JN1SoYInXpGMQp62XxUpaTKbMaecfFJBZiiOebmoqNBk86V3g2ttbHQXwBpDWcxC
         XzPID+cIK3RgP0c7DbH68yC2UQtU6oUKegIveVbplDfam9pIvUtqAW9AqD3Qz7MoCJxv
         DTmrwgvG52xUst+FxmUsZ0KSbcoOZj8wNgiLfJWTqwSkkl5NdxPkbtTbAaSv3CoPrBZU
         SpUzg/fEMT/IEWoJ5NaLQhXl7RAY3ItScX7IGq3fF9Ag53D8tqsdGYOVYa4G1WK6Xp5u
         88zAvH83KMrx5nyg+egYJEQSkYRdaxjiEZuYjdaZ5ZQa7FMrpSCkCDKXdVZuHz/M4LrH
         r+tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786738499; x=1787343299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/t15TRNaADzO4hHI4fJDqg8v1F/rUP1SbSZ2rz1A+vI=;
        b=TmoV65V6PeGz++QcnHa3TCwifo9vI+/ZN6nH50jYzSo2fzP1yovv2r+OMs/5whPihb
         u00uWPGCNwuNVP/WprbJn2LTeveRdS/1uohOwtLUsfBCiR/vAqyiheTOdhL2Ro8/elLf
         0wnXmf6tNwbLckj2paYssv9GMQuJ1Mrh7BN2a3bJgDpnM6HdO0BeLJyvfGhrBf//AU/G
         LX5U3AAHCPIoMIaUsHZ9G0WIki9O0WLqNlhACM7ZXRQv7HeSufFFxzAXW631m9vnWFEm
         kHm3k1GfdWA1+wTlti9Lfb1PHz5POfj7Rm5SYTCD2BFiixcpZkcErgGYTenAlQu2q8ci
         7nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786738499; x=1787343299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/t15TRNaADzO4hHI4fJDqg8v1F/rUP1SbSZ2rz1A+vI=;
        b=DfH4B7knj+p7macDiq5CFeP5krWtGJW4vU9udhslbiXdLNVqCOHF3GmKEd0gdAbSwQ
         5GrY3afaK+daCbLmj9kkUkRsJjY2DuedLjORlKEXZfT7QCmdZHvmDwVwZXrP3La74b7X
         THDOh3L7cLmPp2/C88dNxPj2EnfnLfoUe/QcQgLCfpNflU9diGji+4r5K6QWWWD16dLT
         V2/DArV/I3qmw46QIup/H+uZiY3nb/g0T+wXFc7EIHD0BXjE95KcBGGL8ldi7kfrOUMC
         XOEqPm9zklEN4ItFeIEq9dl0DsgE3lAEb9tR42jPtlPJchX/vh7ajrFFml6dtQLstxOH
         RAfA==
X-Gm-Message-State: AOJu0Yzqp+pvtQZhOScb4clz8vWkwL0x1mwEtwCNox3oSPHVxjLD9c9S
	sJuSweZ+ZSZ/Y4rgEQ5Elh1f11X7dpWhdnW45MiUJnHVzD2wJoOGHQ4p3v6PJPHKoefI87NtAfv
	o8cM7vy+54CmyNMN7Sm/1yuM727JCw8M=
X-Gm-Gg: AR+sD13gz7a4aDNYtdJtJ6A+htMfQimwJYpaekhtwEXOzKUpricZ4iBCOO4xX9Oh1sX
	m1uDlR08q6OSQmN8ew+IM8vygG48y/fJTgf65wcNSAcJF7KP2mJOgz6Dz7DiVuio74Sk6FBwSmJ
	xUtdLDw2NialyzLwff9wV0Gv757ymfJBb2c11apGGfVzko/DprBgWmq00SQGL/D/YtF26NzBpoJ
	X6AxMMUMLbfJuBrlvKBXJeprKI2xdl/f2+2SBJyucjh0H0A3+DZp8RM3r185tF6NG+g5rCz62F0
	1jvWK9fUmk79o/CxLYNNCZ3lM4aQf7N6rwyyHU0vi8yjcvjI2o3UQJNMkNCaFXzKAcblByO7S+L
	08ciWOVDfxOAE3v7zlX5OqdmfpQ==
X-Received: by 2002:a05:6a00:a244:b0:82f:9d21:d352 with SMTP id
 d2e1a72fcca58-84fde15f198mr7774332b3a.9.1786738499136; Fri, 14 Aug 2026
 13:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809150111.45000-1-leon.hwang@linux.dev>
In-Reply-To: <20260809150111.45000-1-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 13:14:45 -0700
X-Gm-Features: AUfX_mxfEwwxD12VleDI-Q-iMiYeE3BCkz39VXGAlTLeNCm0p2vDpMxtSEx392w
Message-ID: <CAEf4Bzam=0V6n4_vBahhYh2Qn9KfriDKXSz58L4L+teHJRWfPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] bpf: Add tracing_multi link support for
 bpf progs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Avinash Duduskar <avinash.duduskar@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>, Rong Tao <rongtao@cestc.cn>, 
	Eyal Birger <eyal.birger@gmail.com>, Pu Lehui <pulehui@huawei.com>, 
	Jingguo Tan <tanjingguo@huawei.com>, Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 8:01=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> Similar to the tracing_multi link support for kernel functions [1], add
> support for bpf progs.
>
> When attaching to bpf progs, it must attaches to the target by text poke
> way.
>

Please spend a bit more human effort on justification for the change
and explaining your use case. In what case you'll be attaching to a
large amount of BPF programs such that attachment speed-up (if there
is any) matters.

Please do your homework. Generating code with AI is easy, reviewing
and making decisions about whether it's the right approach (and
ultimately supporting it long term) is still a human process, so let's
weigh that in.

> [1] https://lore.kernel.org/bpf/20260606123955.345967-1-jolsa@kernel.org/
>
> Leon Hwang (13):
>   bpf: Initialize ftrace_managed in bpf_trampoline_get
>   bpf: Factor out update_fentry_multi helper
>   bpf: Drop unnecessary ftrace_location() in update_fentry_multi()
>   bpf: Add tracing_multi link support for bpf progs
>   libbpf: Add tracing_multi link support for bpf progs
>   bpf: Add tracing_multi link fdinfo support for bpf progs
>   bpf: Add tracing_multi link info support for bpf progs
>   selftests/bpf: Add tracing_multi bpf prog attach test
>   selftests/bpf: Add tracing_multi bpf prog attach failure tests
>   selftests/bpf: Add tracing_multi bpf prog cookie test
>   selftests/bpf: Add tracing_multi bpf prog rollback test
>   selftests/bpf: Add tracing_multi bpf prog link info test
>   selftests/bpf: Test tailcall with fentry.multi
>
>  include/linux/bpf.h                           |   3 +
>  include/uapi/linux/bpf.h                      |   6 +-
>  kernel/bpf/trampoline.c                       |  87 +++---
>  kernel/bpf/verifier.c                         |  22 +-
>  kernel/trace/bpf_trace.c                      | 212 ++++++++++++---
>  tools/bpf/bpftool/link.c                      |  59 +++-
>  tools/include/uapi/linux/bpf.h                |   6 +-
>  tools/lib/bpf/bpf.c                           |   1 +
>  tools/lib/bpf/bpf.h                           |   2 +
>  tools/lib/bpf/libbpf.c                        |  39 ++-
>  tools/lib/bpf/libbpf.h                        |   4 +-
>  tools/lib/bpf/libbpf_internal.h               |   1 +
>  .../selftests/bpf/prog_tests/fill_link_info.c | 170 ++++++++++--
>  .../selftests/bpf/prog_tests/tailcalls.c      |  62 +++++
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 254 ++++++++++++++++++
>  .../selftests/bpf/progs/tracing_multi_bpf.c   |  61 +++++
>  16 files changed, 869 insertions(+), 120 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bpf.c
>
> --
> 2.55.0
