Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463C035893
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 01:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731759; cv=none; b=KjKmR5K0F2OrRkTmaZC0gc+JuFMobTD69ut2a1dMyD0kN58MaYsom9cN3aUV/jgDYstBAXdeV4G1IvykjYSSMzO7vpjBgutnuBa6PmGsKMlAYIRCJYs6XVVNz5GXFxwPYwG+p5pJGaZeENxwf3aAXRZBGnj7R9cW0KxtowBpXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731759; c=relaxed/simple;
	bh=YyNzvc9bCGg1bxZ+wwiajlIVQWbSAmMUUW0zIUd3oSM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=T5s+jErT+gtzljj9gNPR0E2+HEHg4A3gMB5GBMscEb0P3QAneq1d6SOgHvmFbO2ULzvpbc0aRfqIAnRENwr9RDC0lT6bQw8nhM08+HK6noOeugu5uhopD9kjsRmVdzOrgWMnrMmtOtLKClcb31E08GxVU7a0VWRjMXplMqNYXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtRSO7Ww; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtRSO7Ww"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47301772842so761625f8f.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 18:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783731756; x=1784336556; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sGvZ1pdrrnE3y/VSLhcnFayUWzo8fsz7PhrIBkuxsxc=;
        b=rtRSO7Wwr/5hW16NYa7nwzwKnH/JQ6lg+iZyYi0Y43LX3feTC2GvMkEgHu3XHO3q7B
         TMbxJBJpjuGh+8nNZvfs/84bsyvnUVBUCOQs00SR/RugvJLiwts4q+IlNS57IiEs6oa+
         KjQENUktVbvnGUBPMVVucpYaY56lxdkYucHy3qS8yBma/KDb5O+uuAKyY9PD03MTvakT
         3T68FavpkafgHxzxoxVDs93ihIb1piD5H5q0mydSwkv105HoT4VuDV3VbHaazVCRirWy
         NZPabjPLLZTqb+Rdxo+4ktJsEg+AeauP+0W7HPPwu39RBxgAUynv23cA7CvFr46sHI9V
         2XIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783731756; x=1784336556;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sGvZ1pdrrnE3y/VSLhcnFayUWzo8fsz7PhrIBkuxsxc=;
        b=NTwy3wE2KgpsuE3qmjTsOkeOsRUIliQT18slP8N/mudx41g2okEBTEGYO/Bfu4wj5O
         Tj/WEZ8BiJhv4PPi85tjzGeywtGzW7azVytF1qPUxBSEcmH3HAjqEC3wltBHGyBq39XE
         wua1amhJwUI3UIVJeV3G5pDacoZoabvX73V06Jd4XV4EnsuhEJZMbd87EyMi82xy5WEG
         UUHhFwakQH09TDBEmh9DHsGdaU2raEfzao9D9+H58BVfKxG8uf1EGN3jR1AycbxzKLVH
         q4wXb70DgBaxZ+Yxsn7iHTvK37OP9HK/omcJ6foD27x5+wPweGocZUpIiPkJuYZoyYd+
         XVdw==
X-Forwarded-Encrypted: i=1; AHgh+RosgvDwJ1pfQR6k6NkgTmH5AQSUBky/zQftwiKGnVgrcWqAv3/DeSSylMvnBIsUfUVlpxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1q7IDHBa0i7vhiI9S97Nm/TSl/kDOlqe5DyCeAznEKcx95FT
	6N/5G67PERmZ2TJ6OYEXL+x3+ycKNaAVfhBN/RhrIDxOH0gHTjJauORt
X-Gm-Gg: AfdE7cmLXsbjbYL/zu4RDAW+5Eu8VX2i2g0DGsQtPcZ5LhLVEubEY1qEnBKWSwz8gNv
	+8D6qnX5KZP4Xm0kPrNMAZgb3GEOpOsLi/FMis++1tJCWdAd8gkKjXL815ULmPZbvBBVGZypwAI
	GITR0sf8wRhHEj4woVOJxzViDYsqAfEgUKajIXR+c/EVN7ZWC6uMJ10cL09sqKGYNl+MHRmoxr7
	dyKi0wuxlJxXl/fGamSfgXxCdn7O5qhv08GpjOoEUd7pPhCml8L7AThdJTVnBYMDvtX2soevg4u
	JBdLfxnQ0wrpPjDiOPM0J3AKIEY8xl8BpM4FdN5ugGPlg1CtoOukPbtREQT8AMioiZsstIBUOOD
	DcguxrNyfNi+40vMkENzqz+bRFe/kh13oQNVdeurxlvhsF3govBiuD3Oa46Ln968R3WPMLX2x5w
	lgOVh6mFuLaDlRa4r063HvJJ+eOpYNIg9yBD4RWtIHRlbogzIZFyejOaO18yee2UOhh9SwEKlcv
	sSzbnUPpSTRWgcPzZXpSptc2aI7kPdAbKyOR5ar3Po0X5sT42jSqM8=
X-Received: by 2002:a05:600c:6d8c:b0:493:d0f7:69c3 with SMTP id 5b1f17b1804b1-493f882ec68mr5094795e9.33.1783731756357;
        Fri, 10 Jul 2026 18:02:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4f09f89sm127316285e9.10.2026.07.10.18.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 18:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 03:02:35 +0200
Message-Id: <DJVC4VW0JKXX.1DBERHV6ZVCMX@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Fix trampoline handling of 128-bit
 values
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260710225206.4013062-1-yonghong.song@linux.dev>
In-Reply-To: <20260710225206.4013062-1-yonghong.song@linux.dev>

On Sat Jul 11, 2026 at 12:52 AM CEST, Yonghong Song wrote:
> The BPF trampoline preserves only 8 bytes of a target function's return
> value (R0), and its register save area under-allocates space for 128-bit
> arguments for x86_64. These two problems lead to memory corruption or
> incorrect values observed by BPF programs and the real caller.
>
> This series fixes both issues and adds two selftests, otherwise, each of
> them will fail if without the corresponding fix.
>

This is almost ready, but CI currently fails for tracing_struct tests. [0]

My AI agent suggests the following root cause, which sounds like a pahole i=
ssue.

"
=E2=80=A2 The failure is caused by missing module BTF, not by the trampolin=
e fix itself.

  tracing_struct/int128_args fails with -ESRCH because pahole omits
  bpf_testmod_test_int128_arg() from bpf_testmod.ko=E2=80=99s BTF. The fail=
ure occurs
  before the BPF program attaches; see .kdev/logs/vm-cmd.log:3.

  The problematic signature is tools/testing/selftests/bpf/test_kmods/bpf_t=
estmod.c:184:

  bpf_testmod_test_int128_arg(__int128 a, int b, long c)

  On x86-64:

  - a consumes rdi:rsi.
  - b, the second source parameter, is therefore in rdx.
  - pahole maps the second parameter positionally to rsi, sees b in rdx, an=
d
    marks the function as having unexpected register usage.
  - Kernel BTF generation enables consistent_func, so the complete function=
 is
    omitted from BTF (scripts/Makefile.btf:17).

  Verbose pahole confirmed:

  bpf_testmod_test_int128_arg : skipping BTF encoding of function due to un=
expected register usage for parameter

  This also means the comment claiming that putting __int128 first prevents=
 the pahole issue is incorrect.

  A scratch probe with the exact kdev Clang and pahole showed:

  int128_first : skipping BTF encoding ...
  FUNC int128_last ...

  The likely test correction is to use:

  bpf_testmod_test_int128_arg(int b, long c, __int128 a)

  and update tools/testing/selftests/bpf/progs/tracing_struct_int128.c:12 t=
o
  read b from ctx[0], c from ctx[1], and the return value from ctx[4]. With=
 two
  preceding scalar registers, the 128-bit argument starts at an even regist=
er
  pair on arm64 too. This still exercises the four-slot allocation that the=
 x86
  patch fixes.
"

  [0]: https://github.com/kernel-patches/bpf/pull/12778

> Changelogs:
>   v2 -> v3:
>     - v2: https://lore.kernel.org/bpf/20260710182204.1085329-1-yonghong.s=
ong@linux.dev/
>     - Align __int128 argument at even position enforced by arm64.
>   v1 -> v2:
>     - v1: https://lore.kernel.org/bpf/20260710144404.2579671-1-yonghong.s=
ong@linux.dev/
>     - Also handle __int128 arguments for x86_64.
>
> Yonghong Song (3):
>   bpf: Reject >8 byte return values on return-reading trampoline paths
>   bpf, x86: Fix trampoline stack size for 128-bit arguments
>   selftests/bpf: Add tests for >8 byte return value and 128-bit
>     arguments
>
>  arch/x86/net/bpf_jit_comp.c                   |  7 ++--
>  kernel/bpf/bpf_struct_ops.c                   | 12 +++++++
>  kernel/bpf/verifier.c                         | 25 +++++++++++++
>  .../bpf/prog_tests/tracing_failure.c          | 12 +++++++
>  .../selftests/bpf/prog_tests/tracing_struct.c | 36 +++++++++++++++++++
>  .../selftests/bpf/progs/tracing_failure.c     |  6 ++++
>  .../bpf/progs/tracing_struct_int128.c         | 18 ++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    | 32 +++++++++++++++++
>  8 files changed, 143 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_struct_int1=
28.c

