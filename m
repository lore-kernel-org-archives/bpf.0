Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B53C9888
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072971; cv=none; b=tNseNiA3Q8plzWUs7IfnGM0JEChGMM+uwDYqfsoq/Xn+h5vpM2+nVkq9RFkmq0qXopbSIc5kGwO+AxaIUqxxPENGEammkVUq8PF9bxc32GTP8k1HecymYSm32TMg69+AjfDaqbptJFswmq7DGeEy9v2q4Ez3OesCbU8dhZu3yC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072971; c=relaxed/simple;
	bh=P9QJK2xz/jdfVnMlUFOmfxp+TBzPlMUUfk9wzKX/jwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJLDDS4Uy6ZrjpYAERgz7Z9eiH9jLkS9n16nj7Cqiq0ARzW/V1ejq3JeyuAbH9AUJqGhDEWoaClcNmHqazwQ4CVuDGINE5ryide6o7P8tqzNPnNOPcpuFPEYjK5W8hsPnRMdsnqh6t1jawdb0JYzbcitDkX+zoin8ZTgQTO7C4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQ7Q04KK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQ7Q04KK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A763D1F0155A
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 10:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783072969;
	bh=GxICZniZLiTs1zHK8UE4JL2NE8iCjWZD2BK5CrwX6M8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gQ7Q04KKbVll2/T84XVbDiCdXpC0k671DQfMVJp+FzCxGj72PckPhFYoQan8Bj2yx
	 TiGWTRS9294/uNQZLrOSRjg2tLj9/vpgQddHMcd5C3YsEITdmZbyNi+jlLF1+yWJ/E
	 CYDkUdRLQCl12TzMRa4lJKLA5Bp084C7nwUAVCgRZeUudcEonglNjFYYEo9UX873xQ
	 BPElgHL99gOhXkuIKTLNv62MytWbZhBEUtjDcyDUS691K7UA4PyLUT32ckctbR3+Lj
	 uIGewKGLdb3tFqZstiWIq8v1RrWhFqeVmsi54wBC4hTdMm2Qcpc2eSpfccRfrru3ux
	 GhUbLtSXMaifA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so730271a12.3
        for <bpf@vger.kernel.org>; Fri, 03 Jul 2026 03:02:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpp4KwG8XzHZU0hibwBlHxIcpE+fNCpmBSpcmuDCgHVhPsHQ0YzR3cZ29ckIAVblxN7YBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywyjYt4iKr94jlBaE3jaJIu9mhg14Ybk5qhC0mizW7mmtsvfuz
	eFkCQlYEg76m5NFD3BriiEHcMO19kG+6Hy8ccol0TC2LF81pbHnynZlh/gS8c7erML5DMasrSo3
	InKoXGdeFm4SAO9KfOfNqET68mIrjsCY=
X-Received: by 2002:a05:6402:51cc:b0:698:9ea5:d195 with SMTP id
 4fb4d7f45d1cf-6989f38e7d2mr4357031a12.23.1783072968125; Fri, 03 Jul 2026
 03:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1782119051687451.15056.seg@mailgw.kylinos.cn>
In-Reply-To: <1782119051687451.15056.seg@mailgw.kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 3 Jul 2026 18:03:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4zaPuBjfsujbW2QiYMMDhy3G+0eLOn_DbdHMmGitGEZQ@mail.gmail.com>
X-Gm-Features: AVVi8CciMHHIh2DiT8jHK9TEKRaAsAY0P6iPzY60Z8u1moayozVW4gt-jf4mfsI
Message-ID: <CAAhV-H4zaPuBjfsujbW2QiYMMDhy3G+0eLOn_DbdHMmGitGEZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] LoongArch bpf kptr xchg inline support
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: kernel@xen0n.name, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yangtiezhu@loongson.cn, hengqi.chen@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu and Hengqi,

Could you please pay some time to review this series?

Huacai

On Mon, Jun 22, 2026 at 5:04=E2=80=AFPM Chenguang Zhao <zhaochenguang@kylin=
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
