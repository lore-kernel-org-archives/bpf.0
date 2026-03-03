Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B83537F0
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558827; cv=pass; b=qoSoSUF4vXoGMtqiom5ZmR/dhSRLt4iqmdwCx9JrpPSI6HUQSohUg44sch+xxCV5SibZWZL7eMBdHvq/vjtx2UxsyQmb9XOl4Gg26nMh+BcrBSafprlKjE5hSh4DXchshe2zpMSv0xL0yy3bgEsE/W0ETLTOGdlMbUQxK3Ve4P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558827; c=relaxed/simple;
	bh=HBH76Nt9kpG+gJNEVtEfMJubgHtLzvdwjqGAD5eB9pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WI2aGn8gxDvPM3o1EndLJ7NvZSvpYDvNvbFLvT31MUrzVTMjB0UnK4yepT40nVZP2V1AtZFcXrhmsWF2gtdSztbVAWjaqNRP1xV5RUs1f/kCrUDgqvah66Ufx/7wYn81C9jLcVjx4VvER/6rxhELFsvcmS1rDp7s2sGl/za6jOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBzbe39C; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBzbe39C"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48370174e18so34565525e9.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 09:27:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772558824; cv=none;
        d=google.com; s=arc-20240605;
        b=U5SFdJx0I04ut22Q623b8Gjjb4M9ffPgXIx2PzgeUdRUQC3RBR3EOYNQLPmrkUczfp
         raiBAPIlv6T7ujQ7Ht2d5dIyVtWUIKTjl/hhQBNjpDi4dWx6C5nk/hAS92CBCdYwzXum
         MCQwLMEVkS0RGJ7iQy37iSCAa5Tt5SlQz3lw4ODF4+OyqkZ69KeOqk3ykrorWbtWnhBc
         dZKmxqyiR0UDaXJd81y8VPmFUFwtsdfzYKAMyRh4QOlA+zGTKNZCBjekL8mYJLCmNc/K
         PDCSRCTqgX14Mp0kLS/hpzNdOwIPeX7O8a9Jp0/OqNrpmIr0sakvLIk60K6sPA/8UO0+
         K8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oTUwSjPsuy/iF2SmemQU7NMIIe1DliK7ZJnwuJ8ftKU=;
        fh=3EgeFOcbMMp6udAwZJt9Cn/f1vlfkk7u1AF3DQHVRvM=;
        b=KtbfEf2wngG/2j+EQke22UFZtsS9D4jh95JYQ9dyjFoqoJy3Z1ZjxmlK2MjDjsgxJk
         a0DWhcQI1IBQDKHvwS1N0PD8n6iUngJiWLOAPWSvplsK5JzOopTZZh197RG3RGfKp+Ur
         1vpd5TqEpi2Jkj3gf4Ip3CGdzd9796Yv/zhtP/F4eTEmwkL1P8p00gPb5wRh3BXnuYhH
         QgOSXunTHS1EGzZA7W76i287+yjNjPbESChiso0EPFVJ5bRXqpsdyhj7yx0yVxZEx8Xu
         1yllJj8XxTkqrfOgBp+QCYbRghIqaysnYd7N20e1TO1iyu1HVV8Tbr6VitdFm9bQZHJ2
         FG0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772558824; x=1773163624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTUwSjPsuy/iF2SmemQU7NMIIe1DliK7ZJnwuJ8ftKU=;
        b=CBzbe39C/cUHVge4Ag3ZMZ0cRaHKFbhQHHOJshBgeP1zK8Axtwzc++G5ok+6rOfFCD
         AVcvgL7jF+1eSOM7NOnjLEiLPCx0G+F3DnGNZZkd2xzMf4lqvpytJIZUO7wU1DVqpHN3
         kX+wzOXLfijBRnRFFRWrQfDjNbx9rITwgBhw1+EbEADHe2SV38oQ702mG+59ctKulVf9
         aCfJMP2rAD+T5j775sJHqCnciTDQ4JPVqRiY51C1F8rVwU5YMybmdHcYke3hkR5uYeDr
         25EhPtaJFuvPAXDxhGRsc657n1zFyc5h8E5gsiMl+R1RXUMFZ92zjBP4XA8Vxpz9QQBm
         y5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772558824; x=1773163624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oTUwSjPsuy/iF2SmemQU7NMIIe1DliK7ZJnwuJ8ftKU=;
        b=Up/YgUdCUQQylQZxjYnpHcRJlxuSN6MwUb3HaHjpiNh0PXWFIwTfd++LFhKNRk0ax3
         uCDa1U+RTttzeaVgwR9KuGN1Aa3zanUdbV9slFVc3poSvo6Z/R0J89ynjd89DNzsXoCG
         n0x3abzqVNa1LhQJtd8IycJo7sZv1TNsCAasTAFuAporbziJzGwumAHtDV8Z8TN1EsZv
         mtKiSR7EHLwDZLR28nZBOD0woeCnKdTm7kWpvLusYD3a8rI5ytOnseVh2gRPI1wUS2Zt
         m9BSPAEsm0YGrqFb/71LZSCqtsoUBuFXfcZe7vobwtRI+9cCsuGR+p5j8v2u7Dc27zuy
         lVHg==
X-Gm-Message-State: AOJu0YwgEJfeCtx1riHg0CD/XH/ZydxhUtNvjS9HLGPAnzCBqCP/n9/H
	D36b8eDQZwKqHuqCchZypqPsdUcowm5gQUrGkJee2um2aIaxgczM2ALcy93yiJfe5sYFZWhwSaa
	ikKK8uvh6irnLGWb1yPWd04URJWB0zuw=
X-Gm-Gg: ATEYQzzMlu9+SryGyJ4XTkkXQYySn04joJcVqm1SjM5C8vp0p95Y4N5RULgHsoFbyHa
	rY+jswZo/QROu5w70gEY3JiSiMVyQruXVuATSc9MZUKJ68cCBfKRXmZvzT3/r3/jNkGFjHGoV30
	ZAsdbaVRrJN5HksDbzEcEMpwWmAKua1GWUvtECqQMS4OmunJU/mqaRi4KfDcxJAy6lB3MuE45sE
	Ft569S7bYoN/GcOt9fC3wEYTReu1tbtvBCQQmvWgt5WjKQ5RIxK0fDRJ1trjylZ3QXWtuRxzu8V
	QS+ucmoyz4HKJ3X/xcQXkbEHMScEbp9KhjR8yrJACP7ZI7AQjA0VCN2vvMHLzY+coubMJEmPNmn
	YeeRF97ZaK3XXisJdI9n8ki8l1Q==
X-Received: by 2002:a05:600c:4f0e:b0:483:702f:4641 with SMTP id
 5b1f17b1804b1-483c9b94367mr283337165e9.3.1772558824226; Tue, 03 Mar 2026
 09:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225120904.1529112-1-vmalik@redhat.com>
In-Reply-To: <20260225120904.1529112-1-vmalik@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Mar 2026 09:26:52 -0800
X-Gm-Features: AaiRm53YskkPkOnU4U2wC6-XnljGLAm70JhGpG6-x3rQUG2M9Zugr5LdG4vdWC4
Message-ID: <CAADnVQKSVu-dTqqENSdznsoo6cva006P8qAJkx4RTp8JyEXVig@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Split module_attach into subtests
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Shubham Sharma <slopixelz@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 4:09=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> The test verifies attachment to various hooks in a kernel module,
> however, everything is flattened into a single test. This makes it
> impossible to run or skip test cases selectively.
>
> Isolate each BPF program into a separate subtest. This is done by
> disabling auto-loading of programs and loading and testing each program
> separately.
>
> At the same time, modernize the test to use ASSERT* instead of CHECK and
> replace `return` by `goto cleanup` where necessary.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  .../selftests/bpf/prog_tests/module_attach.c  | 171 +++++++++++++-----
>  .../selftests/bpf/progs/test_module_attach.c  |  63 +++----
>  2 files changed, 148 insertions(+), 86 deletions(-)

Applied.
Could you also take a look at why the test takes so much time?
time ./test_progs -t module_attach
#220/1   module_attach/handle_raw_tp:OK
...
#220     module_attach:OK
Summary: 1/14 PASSED, 0 SKIPPED, 0 FAILED

real 0m5.072s
user 0m0.275s
sys 0m0.199s

It's not caused by your changes, but would be good to understand and fix.
