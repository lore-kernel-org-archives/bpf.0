Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4A22301
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923121; cv=none; b=RL2Is7epzYKFGie3gqiKA/I6/23cgOqORMfvayuLkdf5/ZGrRxcUE94QJziNEAYaeFtmEng95yLprzGsUGE+an6KjROUaUOfDxUNwugx3PK7Po0+cTGmn3c49VsS9mY24dDfFz//1BfrtW3vWXGMg7YIJ6YK7HA2OlH7VBlQ98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923121; c=relaxed/simple;
	bh=M6M22eNuM/s4bt7wR6ZMpzecnUxuvbjsB1x2gihMNpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsmZv6b1fjdiRvBqsJc/ZO4Od09yk1ao1XOrdEBt2Smsqh03gfQTmLTPJQP9f+0zgmqWA6ONap+CuKumqFsPqwHeLXxhOOpUpVpFjG9xMiY0iH0bJbN/3AHrdQZHdPX+fKAONX+36UiBrrIwnxGYNKYQzW5p4EnsCwou7e5QXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDuI6ZX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDuI6ZX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD341F00A3A
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785923120;
	bh=gxgh1d/xpX3+wS7satcqo9P+8LuVtMKLa33NMQ0hV24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aDuI6ZX64UaiCKZMUI29iGPa7IYyMJrwLfcnW5+WZdGHQm66OYVOuD2/pUcgFdNfJ
	 eT6B/Y2J/yVhiD56h8KM2UfEHystrP1I3pSbEp60DYR5lhV5vULjn6ohKv5b5AVJ6G
	 JdqfQqSZwnz2E25LMEPc+OJ+t6F5hDdbOXD3IhQiDuPIoGPzR/W+0dJw8jVo9LWcLV
	 ea3LXcDQDI58PtxS6qTviCWISYfcYXGxQ+FwytF75zyYOFWftmVN3OClQ73Ak3Eo/f
	 yHbw4rtmp8S7Z3FaWo22nzY3bONobk6omw7mn7bqILrHuEfqMQaIUgx3tVx4WaPw0I
	 eaLRS5yVeKuHw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a0a0466d12so1790099a12.0
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 02:45:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrR2GzGXTcllq8figUw/jB/K8U9bYBZRvEuc8jXWYJm5uvxRxg3nCA4PBTb9s0MNICCVPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCvLG/CEUdb1PAwJIA6guFDyh/5C+eUu0bRff2ZOQwLyGyZY/0
	P6nf27yi1ml3IAZlXUr4zE1NvGaewpZwI0OgOPeTnsMUgA3my4tBE+WGVcsMbvsQoNsXkTdVacE
	22EdQbSn4xcbGUWBAmiHWElw4FqCE5wU=
X-Received: by 2002:a05:6402:44d2:b0:6a0:de1e:c4c4 with SMTP id
 4fb4d7f45d1cf-6a14efdb72fmr2769899a12.10.1785923118945; Wed, 05 Aug 2026
 02:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729022837.355549-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260729022837.355549-1-chenguang.zhao@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 5 Aug 2026 17:45:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5LbD2XdRXHQTkaZqLSZdsjaeBn-KuoVyu8Yp66KfaX9Q@mail.gmail.com>
X-Gm-Features: AUfX_mx1UvDsqSZzPQWe7AmI5apUT3t7cOKVNthWTP0DokSaabnM8Rqxd8-Qlrc
Message-ID: <CAAhV-H5LbD2XdRXHQTkaZqLSZdsjaeBn-KuoVyu8Yp66KfaX9Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] LoongArch bpf kptr xchg inline support
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: kernel@xen0n.name, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yangtiezhu@loongson.cn, hengqi.chen@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued the first 3 patches, since the last one is not LoongArch-specific.

Huacai

On Wed, Jul 29, 2026 at 10:29=E2=80=AFAM Chenguang Zhao
<chenguang.zhao@linux.dev> wrote:
>
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>
> This series enables the BPF verifier to inline bpf_kptr_xchg()
> into BPF_XCHG on LoongArch64, and fixes the underlying JIT
> atomic ordering that makes such inlining safe.
>
> The BPF verifier can lower bpf_kptr_xchg() to a single BPF_XCHG
> atomic when the JIT advertises ptr xchg support via
> bpf_jit_supports_ptr_xchg(). This removes helper-call overhead
> from the kptr exchange fast path. Inlining is only correct when
> the JITed exchange provides the same sequentially consistent
> ordering as the bpf_kptr_xchg() helper.
>
> Patch 1 fixes memory ordering for all value-returning BPF atomic
> RMW operations emitted by the LoongArch bpf JIT. Per LKMM,
> value-returning atomic RMW must provide sequentially consistent
> ordering. Plain AMO instructions and bare ll/sc loops on LoongArch
> do not satisfy this by themselves:
>  - BPF_FETCH (ADD/AND/OR/XOR): switch to am*_db.{b,h,w,d}
>  - BPF_XCHG: switch to amswap_db.{b,h,w,d}
>  - BPF_CMPXCHG: emit dbar 0x700 after the ll/sc loop, matching
>    __WEAK_LLSC_MB in cmpxchg.h
> Non-value-returning RMW ops (plain BPF_ADD, BPF_AND, etc.)
> remain weakly ordered, consistent with LKMM. This fix is independent
> of kptr inlining and benefits all BPF programs using value-returning
> atomics on LoongArch.
>
> Patch 2 implements bpf_jit_supports_ptr_xchg() so the verifier
> may inline bpf_kptr_xchg() on LoongArch64.
>
> Patches 3 and 4 extend bpf selftests: functional coverage via
> kptr_xchg_inline, and an optional kptr-xchg benchmark to compare
> helper vs inlined paths.
>
> Chenguang Zhao (4):
>   LoongArch: bpf: Fix memory ordering for value-returning atomics
>   LoongArch: bpf: Advertise JIT support for kptr xchg inline
>   selftests/bpf: Enable kptr_xchg_inline test on LoongArch
>   selftests/bpf: Add kptr-xchg benchmark
>
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
> v4:
>  - Resend patches against new kernel.
>
> v3:
>  - https://lore.kernel.org/all/1782119051687451.15056.seg@mailgw.kylinos.=
cn/
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
