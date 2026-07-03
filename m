Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C1F3C7DE8
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073476; cv=none; b=S/pWs+wJnyYw57w3MxL0hEWaisX07/8bLmcYZPtqixxdPeBIKd/W9R3WTVQqceWrPGRkVVdpu7PViQKLFx7c3PhXgIWr5WVtLlpmW2jQiZnzi2x48aI99+J9XClr+l4UHS0BnOzfS02Lzg7eZ+YGKycSXoR67eYXtTjfnrgHr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073476; c=relaxed/simple;
	bh=ly7+XiycSvEDJf4hQpOCXWK7V0Zf0oEy4b0r6mSD0XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXfpys580TBShx/+4ZHZFGAnLNKFH/UrmBnQMceNZkabtVhKRz9jhQ93l9UP1fl4vMc1OA7QBU+qwXYp4MA+FhklqnaZ24hP0FilLR8woLVcVYe4ZCQvuAit1o/+vhdw0+/GEKxpVWZ5KEHKeE19NfDx92xV0PQ2lOZbO4bT+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjgYCTSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjgYCTSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02DE1F00ADF
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 10:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783073474;
	bh=7yTQtn+lkOhvJ9GgcIZXo/KBRiQUpBFjTm+7X5ocVrE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mjgYCTStJ34g43ufMn/HAfEjtiM/AU6WEDJ1qGtwBAmGJvPBbnkUtJdhuqZ4j8W8F
	 qNl8jIxKjPSGFTU3sJatWv8W1Vd2WvazqGn/wDM5b/bFgzmsVOGhV+0rcHowNjTVIC
	 m4E3C1G/tmYGBLhSJy0yQCRY1ZlJoD5do6R5tXKN2gnoenc7PrDMFTiOLBlv/bjPnD
	 kwhs76Zfr4eqbxyXktaz28HSpD6qFnVo5u4OfqNh9xBLqXp+XiQwXeVB6oHxkjI59D
	 mQCHX9+uKVRfqDgS/fwP52c7P6i43ZyhDRbYVzYvBW2nK+sZxFjpXxRCFYur4GOptX
	 6DnTK1Jx26HQA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6989c0ec3c5so801533a12.2
        for <bpf@vger.kernel.org>; Fri, 03 Jul 2026 03:11:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RowIftwjw9GzI0pHC7RsrS4cDX3r1hobmbt3F0zJumgdaG+ELXTgdDwNy2AE3kQYgfUE/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCyfEKl4u4VmqLNTBrEa+HNbSZtEk39g9sr2YrVeJSioyl4sJC
	cdH2QoJ1xVnhcm1Nokq7UyUlzEBk8LMU1Q74e2wYNIzlHBTdTAJs4z1o0RK9ALY1iKf2OhTSMvs
	CwNksH7KZeQSYoZR/CBjDPBjfNTtBdic=
X-Received: by 2002:a05:6402:3983:b0:698:3602:d0d with SMTP id
 4fb4d7f45d1cf-6989f302bf2mr4238675a12.17.1783073472599; Fri, 03 Jul 2026
 03:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
In-Reply-To: <20260702022322.51033-1-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 3 Jul 2026 18:11:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7vZ_idb1mDW_PWHN8VfEWy2aBgxbaeP5b7J0RAqjzNKQ@mail.gmail.com>
X-Gm-Features: AVVi8CecaGJVd1kSOWUGhr-VjVk5Cw-vBiB9HROXdnoWiT71nwcZk0VAttsSm0E
Message-ID: <CAAhV-H7vZ_idb1mDW_PWHN8VfEWy2aBgxbaeP5b7J0RAqjzNKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/11] LoongArch: BPF: arena features,
 exceptions, private stack and may_goto
To: George Guo <dongtai.guo@linux.dev>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	George Guo <guodongtai@kylinos.cn>, bpf@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu and Hengqi,

Could you please pay some time to review this series?

Huacai

On Thu, Jul 2, 2026 at 10:23=E2=80=AFAM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> This series adds the remaining LoongArch BPF JIT features and enables the
> matching selftests:
>
>   - internal-only MOV for per-CPU address resolution
>   - timed may_goto
>   - per-program private stacks
>   - exceptions (bpf_throw)
>   - sign-extending loads from arena (PROBE_MEM32SX)
>   - atomics on arena pointers (PROBE_ATOMIC)
>   - selftests: struct_ops private stack, arena LDSX, arena atomics, and a
>     LoongArch deny list
>
> Patch 1 ("LoongArch: BPF: Fix tail call count pointer offset for arena
> programs") is the same fix already posted separately for the bpf tree;
> several patches in this series (notably exceptions, patch 5) build on
> top of the helper it introduces, so it is included here, unchanged, to
> keep the series self-contained and applicable on bpf-next. It can be
> dropped once it lands via the bpf tree.
>
>   LoongArch: BPF: Fix tail call count pointer offset for arena programs
>   https://lore.kernel.org/all/20260629085511.359546-1-dongtai.guo@linux.d=
ev
>
> Based on 7.2-rc1.
>
> v2:
>  - Included the tail call count pointer offset fix as patch 1/11 (see
>    above) instead of only referencing it, so the series applies cleanly
>    on bpf-next without waiting on the bpf tree; the empty prog_array
>    off-by-one was fixed independently upstream by commit 0379d10f09bc
>    ("LoongArch: BPF: Fix off-by-one error in tail call"), now in 7.2-rc1.
>  - timed may_goto: store $ra at the ORC-mandated .ra_offset =3D -8 slot i=
n
>    the trampoline (it was stored at the wrong slot in v1), per Tiezhu
>    Yang's review.
>  - Consolidated the earlier per-CPU MOV / timed may_goto and arena gating
>    postings into one series; rebased on 7.2-rc1.
>  - selftests: use the upstream __arch_loongarch / "LOONGARCH" test_loader
>    support now in 7.2-rc1 instead of introducing it.
>  - Prior postings:
>    https://lore.kernel.org/all/20260609041407.122384-1-dongtai.guo@linux.=
dev
>    https://lore.kernel.org/all/20260618033809.98253-1-dongtai.guo@linux.d=
ev
>
> George Guo (11):
>   LoongArch: BPF: Fix tail call count pointer offset for arena programs
>   LoongArch: BPF: Support internal-only MOV to resolve per-CPU addrs
>   LoongArch: BPF: Add timed may_goto support
>   LoongArch: BPF: Add private stack support
>   LoongArch: BPF: Add exceptions (bpf_throw) support
>   LoongArch: BPF: Support sign-extending loads from arena
>   LoongArch: BPF: Support atomics on arena pointers
>   selftests/bpf: Enable struct_ops private stack test for LoongArch
>   selftests/bpf: Enable arena LDSX tests on LoongArch
>   selftests/bpf: Enable arena atomics tests on LoongArch
>   selftests/bpf: Add LoongArch deny list
>
>  arch/loongarch/include/asm/inst.h             |   1 +
>  arch/loongarch/kernel/stacktrace.c            |  52 +++
>  arch/loongarch/net/Makefile                   |   2 +-
>  arch/loongarch/net/bpf_jit.c                  | 397 ++++++++++++++++--
>  arch/loongarch/net/bpf_jit.h                  |   1 +
>  arch/loongarch/net/bpf_timed_may_goto.S       |  47 +++
>  .../testing/selftests/bpf/DENYLIST.loongarch  |   1 +
>  .../bpf/prog_tests/struct_ops_private_stack.c |   2 +-
>  .../selftests/bpf/progs/arena_atomics.c       |   3 +
>  .../selftests/bpf/progs/verifier_ldsx.c       |  17 +
>  10 files changed, 485 insertions(+), 38 deletions(-)
>  create mode 100644 arch/loongarch/net/bpf_timed_may_goto.S
>  create mode 100644 tools/testing/selftests/bpf/DENYLIST.loongarch
>
> --
> 2.25.1
>
>
