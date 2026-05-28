Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F61F3009E2
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978562; cv=pass; b=gapaUei7Tch0aKMG43yh5bC5kvZAR81KBuYdqBl5MKFI81BJuEnY10ttr1CpLyHZR4QiJm1vRaRzK13u0a5VQ+1W8wicRsdZ2TUqJofVOVnrAM5jQgquABhL0udQxcyVBVFHrRoZLZtrlpbOlMyPbVVILp9sc5C4TcmwTptnVDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978562; c=relaxed/simple;
	bh=Q+z/eJ2IYvUrWsTAriwyxkZpEKtlU9VSpOyUWHPTVfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk5zn7X44HXaalFTOQDSyEUAebiPIGUhzhRlpuz2+KbQT5KTU+ogtW9bedDi2wL7fubR2dQ8E9v0ln4X3NTJj+UhTvKvAo+HoOVRrEUO05uA0IUj0QHCqLWpEmdIjLyx8HMMMAUeFKiZZOLDaf+XW43L22E0b47AoIph2NyJovc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyEWElJ9; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyEWElJ9"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68abd694c1fso1548542a12.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 07:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779978560; cv=none;
        d=google.com; s=arc-20240605;
        b=d11+dkrELd3LkBRMzjNQ+xhP9Yzl86xwZ0sfV9COBugQvkMlJlyQQGGvE4ixcv0GBl
         94BZ4kW3gxLLb/5B/9LOPDoSY/CznaFmnCEY8tKPkGTa33qHmWo0TCvz1qwAjTYRvK3X
         ZX0BUJDqef8ww4qf9h0NXPo2Jjgleb0T9Q+tg+wZEaY030lFLxBfR5RWFeaTEuGB/fYq
         GMSFQK30uNh/uFMcYGnJbBqrjjpX3Qc0ntlDgTZoSw7OxxM+/HgAKmpajwaw6FaJV4vU
         vs3vALoCvDAE9h2D2cKwUGtcU30uN0xOCJoarRWnHRJPGUO4Wsyy9Iqe+fs0fV9fYVui
         zcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tcS4djirQ7jCuPbZgRdCiKvbNxNqGGa9ynUDWxizWQY=;
        fh=ImV7wcOWCAIiSwmXuLCYiZW79zWvfoaz2vqrD/XVaNI=;
        b=ebBLUC3/yxwMzbEahrW2WTfg6a5Lwgxn5nRac+FSG9d/Ds3XD8m76TadfRQkRtVqHv
         DUCA30GEfyZw0BUX+63CR1JeKRnbp3QdWdFyumioauPm7+XKULxyg1vZxV9dfRtajny6
         UTFTyPbM0Md+922OY01+zIdEHLHEAtMk2T3u24TmXEd2ENeDUnC6utV52RiI00QwVL+q
         3Dvjmwh0oAT3wQc8XMjVbfrD930tOgo5i9B15fKnpG42zWrT5T3SEL6XdQV0WWpsGajH
         pd/2aK+qobQol/HAQrCfhB+x4yTt8TglAao9luP11QJ+MoavtRi8BWp9xJF3dL/h2NUy
         G3Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779978560; x=1780583360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcS4djirQ7jCuPbZgRdCiKvbNxNqGGa9ynUDWxizWQY=;
        b=IyEWElJ958KntkwGGrwAGy838vfnVPTwWwST5iEWV6uY5BujP7nlRLYGR8jDRKGE3a
         Ge02iGFmUC/FwNzzSxZ9W6zouDlEHpPCGaNHha5+Cu83xZ4KiV+LPR8ldnD2GnIoVPb1
         UILCQJdQtbaSSsBYq+MTVAYziqVtVzJTFEGPCS7k6BbgGcSvNjYN5jSs3th1TWPnfE6o
         D8s2yRdY973uaGnNBYbAKHB7M201dBcTbiRPUwLmBzeOtKgfx+B5ISn0oCy7RtwHTNSZ
         cgX8l9qVL74h18IxNbjnv862Az/+YwkdZ1wM5BjHQRNMEmcrkW65fCxalloqJ4LK5kb4
         /7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978560; x=1780583360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tcS4djirQ7jCuPbZgRdCiKvbNxNqGGa9ynUDWxizWQY=;
        b=jbmfRcNYHvKFxqdqCO3UfePcDDvIindIf9MiLtKI1cPXBzFVmE9ABUiRdGcZ9DAW2B
         dnyKonk0b5jd+tHkexbh6cF8RvPGOIAPe8ZNjlCXuWiqeI3G8hMXC2o+Cc8Y32IykWdG
         4JPtMyK9jnPhbRLzZIBwhZjUN9ko7bEyVzp0ce39WxJTG1nHKSV7fFuv1cF3/rxz0R2g
         ouSbbF6sS5by2ZyepdondIWF+aL8grs0Wy6OnuDfr3tzSmuTFur/cSwgWIW+wasAtPhg
         pEAkoQuRJIGyGTNhfHNVJd0ussJZa3EuJUH1DYl4jMhjGiCXLd5kc3nFBivxi9O21pj7
         wX0w==
X-Gm-Message-State: AOJu0YzMg3s6mR4cV29Em/VpwoC1GHuKjjjXfIdqgkGUSbFwdbUJE6Qc
	n97dSG0lJbsodA3/vPjFl5egNFGAXXgWNk+mhhIr/58i5OkAZz4ndE7YmJTSiCYPXuJd+qH2opF
	4T2zqZG+3agW7ZxXNIRFu8XJK3PL34uk=
X-Gm-Gg: Acq92OEPZVg3+c6mCB7kror1+QDD3jBj6zFrWYQAVKMUNcHk2zB0GJY/pkTCvnn9ce1
	bF++seIGBICY8OZIQ56KAUvBkSLks94OldllVEFN9f3GiRD6gen/SEt01XK0rL+qWff4MB/C3Z4
	hOGzf3zOT/f7C80Yi8NkXc4dERM5soXC3JzQnRMVJLGGFFT6Y9WzhzmFCUoHVkt5V1QEsOhu7Nn
	Eq8U9FOOY7U5C+5SlMKsxTxc6RmESmuYnmiekVz0bg1/tgZ14nn8JmLgHChRetI6keYab2Jd9N8
	WtysikCpBQLKIeTNEiivwNyGyeNv6QHb0Q==
X-Received: by 2002:a05:6402:5245:b0:683:5589:4317 with SMTP id
 4fb4d7f45d1cf-6889c43f438mr16097714a12.11.1779978559466; Thu, 28 May 2026
 07:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427234801.2104511-1-puranjay@kernel.org> <20260427234801.2104511-4-puranjay@kernel.org>
 <ahhGVf3RSWuMk0ph@willie-the-truck>
In-Reply-To: <ahhGVf3RSWuMk0ph@willie-the-truck>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 28 May 2026 15:29:06 +0100
X-Gm-Features: AVHnY4IxAMzVUf7Klr6RFJQ7T-EB9G9CeanOxKaT9tIv-dLEfZRdJbL6TplpLhw
Message-ID: <CANk7y0hMXmGuu9SrgXTaTHt5c460d6_PMxOLf_K=k90_9yU0ew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Enable stack argument
 tests for arm64
To: Will Deacon <will@kernel.org>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 2:42=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Apr 27, 2026 at 04:48:00PM -0700, Puranjay Mohan wrote:
> > Now that arm64 supports stack arguments, enable the existing stack_arg,
> > stack_arg_kfunc and verifier_stack_arg tests for __TARGET_ARCH_arm64.
> >
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c | 3 ++-
> >  tools/testing/selftests/bpf/progs/stack_arg.c                | 3 ++-
> >  tools/testing/selftests/bpf/progs/stack_arg_kfunc.c          | 3 ++-
> >  tools/testing/selftests/bpf/progs/stack_arg_precision.c      | 3 ++-
> >  tools/testing/selftests/bpf/progs/verifier_stack_arg.c       | 3 ++-
> >  5 files changed, 10 insertions(+), 5 deletions(-)
>
> Do any of these tests pass more than eight parameters? If not, then
> they're not touching any of the stack stuff you added for arm64.

The test "test_two_callees" has ret +=3D foo2(a, b, c, d, e, a + 5, a +
6, a + 7, a + 8, a + 9);
so, 10 arguments are tested.

But you are right, I will send a patch to increase all these tests to
pass 10 arguments so it increases test coverage on arm64.

Thanks,
Puranjay
