Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCD43DDB10
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 07:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913868; cv=none; b=KeZ+O5ialEbORReiRHfOPwq0k3OFOvWTu9mcoqG+N1ZY+8ZVo6gKXxF+jDbA+v2dR3yTR6F3qbTFivqGVQAOAiotnIL0nKrZieVijrAMM2qD3UauS9XkK/QLXXyRvzPKKcsk6bWUzdQtZFLmSQp33jBQc1MbQOdaaYKdXJkZr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913868; c=relaxed/simple;
	bh=V95nZY2DUdzB3XlruL1YJbJ30g/hbzlVgN7SCfwoeHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/+X4eprCJUggLbOcCNSQt3mVfS46ohBXmMvSn34qHGJmA2siyRnl/yfBreAq0XO+fOF6gH0phDrJYHsDlpvRmDkAU55vqV/5b8GWJd3Wb/71vZM3k8oVQxpbLKOYD/NfCaXaUvPT64vCWZTcWWF3RH2Qu3GsC9/vdBs52CVJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlQnakZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlQnakZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0AC1F00A3F
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 07:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785913867;
	bh=NbfQ7k85ZTEqgT5DB4j34irEcBPm8KPdK6D+//VHNkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SlQnakZqNLWXcIXCuGY1TlUXSrotxqULvaau70YC6WwU1/BXQevTPOyyv/YAin2Js
	 pOvtocKC3SBZ3eZRFFwlCGoR8XCgiNy/QT2tHGG3HO1Wtxn0Eqr5T0e3xx2FYcOnnP
	 1WjH8ENo4c2IKl0WrWZxyyDE1RQKVPaAMMEcCujl50Epd/suGnOtjxcBIqzmXkBWlu
	 sICEAgljSWdi1FoFQvy3ELsnxh3CWJspqzzk98+5UFS7nMN+tmfErI2zVTqvuuaPL1
	 WC3VLHl8GMApZ6od9gLK66NWCAwPKZbAIhPxTVSdvHnQ8eq+f05iaFl4iU8I+cgRNs
	 OmAvH26eeCoZg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so621641a12.2
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 00:11:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqBzjXH24C3oAlFhYSIqooPIShYaJ0DsrSsh6TGwvfG4UDlwjsnEg1+IlYYf7sqmA4Npsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnjaE85jGcaYJmHgTzLMMrz7peq5cZm6R1K4JAbOv0sbJ/BfQp
	MjJD5CW3YOG+vmFIjPs+BLN+zwKrzIE3EWclq+9g3PCt0Ed7hgWCF9p7x+fBFuIpzkPQ8GDVHTF
	pgEA1mx3EH8uhMQIvWVer/Wy67fEtYuc=
X-Received: by 2002:a05:6402:2714:b0:69e:8ad:515f with SMTP id
 4fb4d7f45d1cf-6a14f0c508emr2238510a12.6.1785913866030; Wed, 05 Aug 2026
 00:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804153938.16129-1-dongtai.guo@linux.dev>
In-Reply-To: <20260804153938.16129-1-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 5 Aug 2026 15:11:31 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7aPXsN_jami_2MKJ9CTcpr8YviSJXUxT8s1GMRUEP7wA@mail.gmail.com>
X-Gm-Features: AUfX_myd1nSMgH06aammgwFHKIkCfd6d7Kf-63KnUo1vwkOZmZkIKlEBTEaeGUs
Message-ID: <CAAhV-H7aPXsN_jami_2MKJ9CTcpr8YviSJXUxT8s1GMRUEP7wA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] LoongArch: BPF: per-CPU address resolution and
 timed may_goto
To: George Guo <dongtai.guo@linux.dev>
Cc: yangtiezhu@loongson.cn, hengqi.chen@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kernel@xen0n.name, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, guodongtai@kylinos.cn, 
	bpf@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, George,

In V1 it is independent,

In V2 it is part of
https://lore.kernel.org/loongarch/20260702022322.51033-1-dongtai.guo@linux.=
dev/T/#t

In V3 it is independent again.

What do you want? You can ask Tiezhu and Hengqi to review your
patches, but don't do such confusing things.


Huacai

On Tue, Aug 4, 2026 at 11:46=E2=80=AFPM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> These are the first two patches of the LoongArch BPF JIT feature work,
> sent on their own to make review easier. The remaining pieces
> (per-program private stacks, exceptions/bpf_throw, sign-extending loads
> and atomics on arena pointers, and the matching selftests) will follow in
> a later series.
>
> Both patches are independent of each other. They apply on top of Chenguan=
g
> Zhao's "LoongArch bpf kptr xchg inline support" v4 series:
>
>   https://lore.kernel.org/all/20260729022837.355549-1-chenguang.zhao@linu=
x.dev/
>
> Patch 1 adds the internal-only BPF MOV that resolves a per-CPU offset to
> the current CPU's address, advertised through
> bpf_jit_supports_percpu_insn(). LoongArch keeps the current CPU's per-CPU
> base in $r21 (__my_cpu_offset), so the resolution is a single add.
> Exercised by the cpumask and percpu_alloc selftests.
>
> Patch 2 implements arch_bpf_timed_may_goto() and advertises it, so the
> verifier lowers may_goto to its timed variant, which bounds the loop by a
> wall-clock timeout kept in a per-loop stack slot. It uses a custom callin=
g
> convention: the count/timestamp stack offset is passed in BPF_REG_AX and
> returned there, so the JIT call path skips the usual "BPF_REG_0 =3D retur=
n
> value" move for this helper. Exercised by the iters selftests.
>
> Selftest results (all PASS):
>
>   Feature                          Test(s)
>   --------------------------------------------------------------
>   1  internal-only MOV (percpu)     cpumask, percpu_alloc
>   2  timed may_goto                 iters
>
> $ sudo ./test_progs -t cpumask
> ...
> Summary: 1/35 PASSED, 0 SKIPPED, 0 FAILED
>
> $ sudo ./test_progs -t percpu_alloc
> ...
> Summary: 1/18 PASSED, 0 SKIPPED, 0 FAILED
>
> $ sudo ./test_progs -t iters
> ...
> Summary: 1/93 PASSED, 0 SKIPPED, 0 FAILED
>
> Based on loongarch-next:
>   https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongs=
on.git/log/?h=3Dloongarch-next
>
> These two patches are split from the full v2 series (11 patches):
>   https://lore.kernel.org/all/20260702022322.51033-1-dongtai.guo@linux.de=
v/
>
> George Guo (2):
>   LoongArch: BPF: Support internal-only MOV to resolve per-CPU addrs
>   LoongArch: BPF: Add timed may_goto support
>
>  arch/loongarch/include/asm/inst.h       |  1 +
>  arch/loongarch/net/Makefile             |  2 +-
>  arch/loongarch/net/bpf_jit.c            | 27 +++++++++++++-
>  arch/loongarch/net/bpf_timed_may_goto.S | 47 +++++++++++++++++++++++++
>  4 files changed, 75 insertions(+), 2 deletions(-)
>  create mode 100644 arch/loongarch/net/bpf_timed_may_goto.S
>
> --
> 2.53.0
>
