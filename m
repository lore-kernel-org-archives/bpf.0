Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054D37F8D4
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137833; cv=pass; b=PYwI1Py+g9Vs1bQckIXqsbm3TwXy+BlbGivGQpokxriebt6saH5F29sz5bSaPh+UbRwNpQySOC8LJWsqH/dFjFZCy6xK1ddf89T+tOvqpzuhN9zOuYOOm53ChMkrIFFllNeCh9ave64/rvSNnsfusChYKYipH+NFQ9UrP7Wkdvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137833; c=relaxed/simple;
	bh=26QD3iTEBUcMQlUM4uGsxaAqXs+lqxOOleJfn0vUbw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giyYrzb5OGhLYeYXAZOcblGEO714871XiIGm81UXvYzY5MTUKIVf/2OIWJUwQWOgA1Hn94agFKR7BM9EmkMHqxz9aew6iDc/LJztKF3r73GyKqIIe5jRetrvuPfpZLiVDukghNN8fOYYbGPTs5UCvX3W8u6ZVLrL1DOExtVs/Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrmStthW; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrmStthW"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6455a60c12bso1557959d50.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 19:10:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769137824; cv=none;
        d=google.com; s=arc-20240605;
        b=HQRfAKI3LPawbhbi7B+6b1ZRpCwSdxZ4bi8ZHI1Ab9SLPaRuRhD+VWaPzEZwI9dHZH
         jK4E+41YmCeDegc+Fwso3FVFb4KNKsfTZ9F6zbZv4FyvBYk92m3JO91LAQhlbkwHgjGv
         Y8aKq1RExYtOICl1YwBHVh5uKmWztoyNW1ogJMkhWkF6rgmJU3hlbapvPX8pu5ESH/nF
         Ep9MvKli+jPzK38X0TTy8k/jIobRO/5AL42HZPBmECCt/alz/DPNwDWmSXYPj/1rlNUZ
         Jwwmz5ml9ebUnswqauNt3L7TzT+J/mZjFuzqu80bvUh46T5PgBrdu0a8KbNngp+xFKsL
         B0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bX1eLwl5u7TS2HDINLkaf1NGNyaQKDoaIks4eZ+myeo=;
        fh=fVsx0UgQkf9X9vRZMCSFCVUry9MqeCZOScww6dvKfQU=;
        b=AR5v0z4hL4MV/Q5yAg4N4pMWmCnUWnvmwDoikr7cTSxBwZhHJM5esqDjVE6WD7AKw9
         +ymSBd+SwJNWvxQQO/e14+HvgDuCWRUcLwKKbbcP6zZsqo/w487MyVx0xbtQ9SXLmxrp
         Jgs/dTp2lxLjec++aWMBHrHqi63sRUZM/jSAQuKbGonRsOKHuQlwt9SIjMdEBQnyV5Y/
         xtJckBDTNX2WQZi125rMJssoGRULr7twkSpbRjuEZXucHSsuAvvalS1KBldF9X+qLV+D
         2LHOePZ4U5akM0gRIbMZPuaXrXuT0IaBsAfwvqrwM4KnGSck+dMxLEWiRW6j+hKI1I7+
         PXpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769137824; x=1769742624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX1eLwl5u7TS2HDINLkaf1NGNyaQKDoaIks4eZ+myeo=;
        b=WrmStthWThcsnnFzlJFa/ZybjEF5RrnBtgrJrCnOa2BLKM41/BixiSic4iohwaxsty
         2s0u0fbQbPimECkEHXpFHfN6PDoMBpc9s5E7RQoIlbn+5NdDlIUBWTmPWhshTEQVuJBP
         Lx5/YOk7oBF3x+YLhZVtjP2bp92KulL9khE/AJzaOAg50gdlacfUT1ytt4fPmSfwR4ov
         B1Gmn3/PiElBvHwHB6SKJoFvCjFvndr9Lw7bT6sA9jyKBZ7pvGUmxgBCv+lvZjK8RWAY
         CbHxODaI4yZ77ZcI6Iy9JTbrppkrmNqVIKmKkyZH0xC3tmYHddGTaQXAmWxxIbEnc5xL
         fIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137824; x=1769742624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bX1eLwl5u7TS2HDINLkaf1NGNyaQKDoaIks4eZ+myeo=;
        b=tYyseSgVq8TPjIWtn5tYvnquA4cme8oUfWW3rEy6VinhkmZ3XBWSEUmVa/vPJqDZJ/
         FMhj3kKIjXWxRm2zvXc3Hg3mHVcFY64VcOi9ZL2AeD/V4787Pihg4fgstqxrXPoFh8Uk
         VaO5YbzTtYbwXzUNGkHqz3VWd1jyt43AokBQikoSEDrMRhgBPfP0zttQK2aWlL6YBarq
         kvEb33CfpuQuXIGb00BALMR1PN0u/Wc3P8iFUGQJjoSiakvb9Q/67uD+BiReUvM+cMv7
         4ft2s8vKjbIvVonwJpImlQosOaZF2Jdi4CJwT3v3TjkD1SZZCnLVw6u20owSPQKC0RFJ
         O5HA==
X-Gm-Message-State: AOJu0YzlVj8mvEpzTZ1BaxVJH3PMTQSC29Xt3V1qGhtj9Zptc1H/lNCd
	+9Sr3sQO0a9cT+bsO3yehXRNevHdYlIhkCiI3yKgUJBMpTszoqCnJ5h627JCtYh8MfjR4XUB6Bs
	zeUdmxSi9dVNJ8dwuPhDLZVWxfzLzx04=
X-Gm-Gg: AZuq6aLFzCeGuYL0Pp6uooRbfV37KwuXar5EZ8UxGn6j6eo/dZAfz6DR/xmyHfH9gj/
	44FHJx+cOASWBd5wA/KX7JOXjBOaJnTgtcVv43xtVp2SVJwKfOkLHbBPu508lD7s+p+uP54F+6e
	sLM8D/oUgBbyJm6vghtKLD8C1YcJlIe36hqqsRBiBKoFsOeNPiwzNq6MfToxFdWOo4VnVM/3oew
	mlCAVPuGg1h4VxNOqLJVXFwvdzIr/xDssC3hWVmRuGND5aMTcK/W5c2PwOur/ppBWvfpeI=
X-Received: by 2002:a05:690e:4104:b0:644:78ac:4b18 with SMTP id
 956f58d0204a3-6495bee629emr1188670d50.9.1769137824172; Thu, 22 Jan 2026
 19:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 22 Jan 2026 19:10:13 -0800
X-Gm-Features: AZwV_Qh9PgdUM-Ak3f4CvTCtCy-8sG_yS3plcc5xh6mUH9ThYE24CxevaPzQTFQ
Message-ID: <CAMB2axNQxpJUiz7uE+pAV8uV0fye36OyAJ4qQqO-4Pdkb61=0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Switch from kfuncs to direct helper calls in prologue/epilogue
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 11:53=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>
> This series enables direct helper calls using BPF_EMIT_CALL from prologue
> and epilogue code generated by verifier ops. The goal is to simplify the
> calling convention and remove kfunc support from prologue/epilogue, as
> suggested by Alexei [1].
>
> Patch 1 adds the infrastructure to mark direct helper calls as finalized
> (already resolved) so the verifier skips the imm fixup.
>
> Patch 2 converts bpf_qdisc to use BPF_EMIT_CALL instead of BPF_CALL_KFUNC
> for the init prologue and reset/destroy epilogue helpers.
>
> Patch 3 removes the now-unused kfunc support code from prologue/epilogue
> handling in the verifier.
>
> Patch 4 removes the corresponding selftests that exercised kfuncs in
> prologue/epilogue.
>

Thanks for converting bpf qdisc to using BPF_EMIT_CALL. The patchset
looks good to me.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> [1] https://lore.kernel.org/bpf/CAADnVQJ=3DkmVAZsgkG9P2nEBTUG3E4PrDG=3DYz=
8tfeFysH4ZBqVw@mail.gmail.com/
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> Jakub Sitnicki (4):
>       bpf, verifier: Support direct helper calls from prologue/epilogue
>       bpf: net_sched: Use direct helper calls instead of kfuncs in pro/ep=
ilogue
>       bpf: Remove kfunc support in prologue and epilogue
>       selftests/bpf: Remove tests for prologue/epilogue with kfuncs
>
>  include/linux/bpf_verifier.h                       |  1 +
>  kernel/bpf/verifier.c                              | 47 +++++------
>  net/core/filter.c                                  |  3 +-
>  net/sched/bpf_qdisc.c                              | 76 ++++++++--------=
--
>  .../selftests/bpf/prog_tests/pro_epilogue.c        |  2 -
>  .../selftests/bpf/progs/pro_epilogue_with_kfunc.c  | 88 ----------------=
-----
>  .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 92 ----------------=
------
>  7 files changed, 61 insertions(+), 248 deletions(-)
>
