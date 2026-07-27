Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC835AC03
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 04:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124846; cv=pass; b=jMF3uehFBVRGgEKNuMH8xXCD9kZDvr2dmao9/w2RYw4JQ5eS12+7LI+eavRBi6DQNUMw7yEEEGw3GSdjAROPf+BC64x6hEfNp9MjIVxpLsbS8aB0TVDFoRruDgMFr+o9Q6QipalvgkkHx7i9DPJ5Jy+BlZns7Z1zydkF/raIx28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124846; c=relaxed/simple;
	bh=jP7ZYlIVgJ80vLRFwlkcQMyjVn9RFAqIf9ZF2g9O3Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLUM7i3MHU++KVOywJGw8vMrnpp/iXyyYQV7I8gMKFa7nYrPUJPHx0pLZOri/IJwRs2h4GGxYhGpRPrtF/jOKiAUpTFkwZ7TddjCAcwwW/cvf9SSecYuMJ4r1CBBcmSKcX6LzMcuN5neQjugP03hDUVdJiTb7sWnTuKNnSdaIjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z05koU3k; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z05koU3k"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43cce34c881so1658439fac.2
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 21:00:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785124844; cv=none;
        d=google.com; s=arc-20260327;
        b=Xo79yt0boYe4NrXvV0HqaoQ4VMfG4cEEe+X8SbpJKfx7CleeEsOM20Z4b/uatPyoKT
         0Juv+C2IGFuFtcmgAfYtJh4cUiILToTSvMKWc/L3i920JmtHyI9xST8/3SmGn4BkSibB
         MJsgPzxzsIrILr8apoIr73MraC7MNeLlxxDbiU34U8JJJEEjj99TQrGmLt7fAl4xBX2D
         a9e+SakPmJcVR16gpQcS9VWXA9WGfaSk+9SjBdczXV8WyAlD0CW6vCM4aYUMrS7KTUTQ
         lHETZGSArvgGRX2rO+ceOq+TpNYaXQbKsCSc73lo+zYoVFta1uRHz4bVJKpNJw4KVcXp
         IwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5G7pWsivX/qlKJsYxp4np8Z21sOvRYdOzSosNcT2Zb8=;
        fh=+Tf/tgb/u7lkszTpEmN3mYBCJXnbkAh3JPka7gkwkoM=;
        b=IPr6zE6W0YElGn2l/I4U5wGjdVUjUTyO134TksB7uB+mBbZ2OLpN16GWZXwo4xLNWU
         4SWgwh/LvzUFXw9ZAjyHQAFHfQSW/J7ZT6XCr99JCuysksQSXEOaUAxns+xftuLYiJ7J
         R6hasOe4qik0jVYwsx1gGCPmNrLZgrHY/g5YfKX7jioHXqU81osAhOSgQcLWMfnW/SoD
         z4EzRDXMaBDQwHA6nrjoHKMdy43lXUtUiwldfzKB6J2jw/CqmFhavKzBwvtgwVOiOCgM
         7ahNUW3oJ29DnPa1hvB6R+yPgt/eJOXHBz4mEZrhpeTGjJtwx7XdZpg39hkfg8TEceLh
         zD7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785124844; x=1785729644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5G7pWsivX/qlKJsYxp4np8Z21sOvRYdOzSosNcT2Zb8=;
        b=Z05koU3k2c81ip+Vh1pyJ5Jcqft5ebQtKyUlMu3HEpPoBfaWUScipkSZKo/KjUty/E
         zxaury0Wd2eFZiQSKonn3pS9VoREWkUll/2PrikVFe+iYZnUPe2ylYjlhpG0Qmt63uC4
         x6Qb2khqTHFO6pjU50T4b08P7FXtdQaJviBOU/rc3Afk7i+vdb6t166UtgkgOLKGYBA9
         2AmXg23HuDTD9JgX0T1xXF3TStCk7BqqLCWIJf4Qduok5eB0tvU4s9Xn+cVO59vSx8ZE
         J7IFYiQSaE0IEZCHFIpKKHuJPtI6JaaXSgBGf+m4IXhpg90yRsoVBDtseJgl5M2WF8xe
         7tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785124844; x=1785729644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5G7pWsivX/qlKJsYxp4np8Z21sOvRYdOzSosNcT2Zb8=;
        b=IUgwid/sbNiuxOcepRgOQEZYWBwEXbeU/7cG3Sh91b26vZ48cWyomzDuNNdYP8ri7g
         4m5OtAhS7RufKtXIXru2wS6egUwWOaxUqNrtbRoov9ghekqZvUJs5pnL9IS6McZw4CFu
         ExzyItEQwcaxDMICgMbmLUyQC7V50PCqL1ZwK/6NUo/ohKTzeIDgIbT9bMLzdb0H59eX
         ds0LMiAA+D+OAieYl0liBLo8yJibTivlBFCV5oLbyv+RdBDPvPdNM7wkyUO2ozbdJTs6
         0wn/4J+Ac4Y7TjBODsl9tu8crI5l83YOM37P4ZE9k3xMdm97h1R726enpddPSo2Rpquh
         VJWA==
X-Forwarded-Encrypted: i=1; AHgh+RqsfWZXLP5Ia+BhGSTJ/FFz689gjXZZeDKB4auKT785MBxnvpL8ax7nUfWJ1dENqLe/9PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJk4f6TfdlaBQ1/MnnNf6CvylwDIOckoWKLna2MqPfnFE2y75
	E50CS2tNHU2UJSUbkvZcvNDCGpVo2EBcm2R7Csh9e02DOWtEQOZLrnLjq/Ec2FUNYP036kLlo9j
	3nusT3TrEGGu3TUAxq4UoRyfqiRKSc04=
X-Gm-Gg: AR+sD11tT+KlBk0+MrXx3USOYue6WJI3kj+KNOvUp2q0419YBNqHB0kSDR5sVKzMG+S
	8HEYBDs21i1RdyKOWcnvrKdx71/gBQx0i03jpiisCHCD8bX9AzTu4OvjIOMFa55uAWfTxR+kDB/
	Dx/FuKu3KwzjBgUi65QkU9ak4sq64h5beAZiKUftEeLHVbsWv6gUyd6VnUyeQEx8nnByQNqOZTh
	z/Yame+Fi6Xs7K6oQW52pEOK60xjn2E7N77nkqzBq1Jv2rOCvo6ebeuc8UTj9E=
X-Received: by 2002:a05:6871:411:b0:456:b6b3:605b with SMTP id
 586e51a60fabf-457f247a181mr5774137fac.16.1785124844261; Sun, 26 Jul 2026
 21:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622071234.1410830-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20260622071234.1410830-1-zhaochenguang@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Mon, 27 Jul 2026 12:00:33 +0800
X-Gm-Features: AUfX_mxKqB9XACgz1TxIXvRnSyNtJ4IGNei07VNWDuXv_cK7wY1OAxWx3rTreEs
Message-ID: <CAEyhmHQ=h3p=xsSBBeVAKD3BPfYyP_vkuOgsHQRcSM_bWEJuNg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] LoongArch bpf kptr xchg inline support
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, yangtiezhu@loongson.cn, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:18=E2=80=AFPM Chenguang Zhao <zhaochenguang@kylin=
os.cn> wrote:
>
> This series enables the BPF verifier to inline bpf_kptr_xchg() into BPF_X=
CHG
> on LoongArch64, and fixes the underlying JIT atomic ordering that makes s=
uch
> inlining safe.
> The BPF verifier can lower bpf_kptr_xchg() to a single BPF_XCHG atomic wh=
en
> the JIT advertises ptr xchg support via bpf_jit_supports_ptr_xchg(). This
> removes helper-call overhead from the kptr exchange fast path. Inlining i=
s
> only correct when the JITed exchange provides the same sequentially consi=
stent
> ordering as the bpf_kptr_xchg() helper.
> Patch 1 fixes memory ordering for all value-returning BPF atomic RMW oper=
ations
> emitted by the LoongArch bpf JIT. Per LKMM, value-returning atomic RMW mu=
st
> provide sequentially consistent ordering. Plain AMO instructions and bare
> ll/sc loops on LoongArch do not satisfy this by themselves:
>  - BPF_FETCH (ADD/AND/OR/XOR): switch to am*_db.{b,h,w,d}
>  - BPF_XCHG: switch to amswap_db.{b,h,w,d}
>  - BPF_CMPXCHG: emit dbar 0x700 after the ll/sc loop, matching
>    __WEAK_LLSC_MB in cmpxchg.h
> Non-value-returning RMW ops (plain BPF_ADD, BPF_AND, etc.) remain weakly
> ordered, consistent with LKMM. This fix is independent of kptr inlining a=
nd
> benefits all BPF programs using value-returning atomics on LoongArch.
> Patch 2 implements bpf_jit_supports_ptr_xchg() so the verifier may inline
> bpf_kptr_xchg() on LoongArch64.
> Patches 3 and 4 extend bpf selftests: functional coverage via kptr_xchg_i=
nline,
> and an optional kptr-xchg benchmark to compare helper vs inlined paths.
>
> Chenguang Zhao (4):
>   LoongArch: bpf: Fix memory ordering for value-returning atomics
>   LoongArch: bpf: Advertise JIT support for kptr xchg inline
>   selftests/bpf: Enable kptr_xchg_inline test on LoongArch
>   selftests/bpf: Add kptr-xchg benchmark
>

Hello, sorry for the long delay. Please rebase and resend this series. Than=
ks.

>  arch/loongarch/include/asm/inst.h             | 18 ++++
>  arch/loongarch/net/bpf_jit.c                  | 37 ++++---
>  tools/testing/selftests/bpf/Makefile          |  2 +
>  tools/testing/selftests/bpf/bench.c           |  2 +
>  .../selftests/bpf/benchs/bench_kptr_xchg.c    | 96 +++++++++++++++++++
>  .../bpf/prog_tests/kptr_xchg_inline.c         |  3 +-
>  .../selftests/bpf/progs/kptr_xchg_bench.c     | 49 ++++++++++
>  7 files changed, 192 insertions(+), 15 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
>  create mode 100644 tools/testing/selftests/bpf/progs/kptr_xchg_bench.c
>
> ---
> v3:
>  - Expand the JIT ordering fix beyond BPF_XCHG w/d to all value-returning
>    atomic RMW ops (BPF_FETCH, BPF_XCHG, BPF_CMPXCHG), using barrier-carry=
ing
>    AMO variants and dbar after ll/sc as required by LKMM.
>  - Add __btf_root() in the benchmark BPF program so bpf_obj_drop() remain=
s
>    visible to libbpf's kfunc linker when bpf_kptr_xchg() is inlined.
>
> v2:
>  - https://lore.kernel.org/all/20260603100438.2177817-1-zhaochenguang@kyl=
inos.cn/
>
> v1:
>  - https://lore.kernel.org/all/20260602021515.214560-1-zhaochenguang@kyli=
nos.cn/
>
> --
> 2.25.1
>
>
