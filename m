Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198BE3D0917
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775117; cv=none; b=S2JdI6QDNt00t1EdMHj5oY5lD1Ymrd0Vvn3SPbYzyuyy+g/aUPk7xpGQtx3OOHqK3cBhkHGT5KxOMMB1KDM0SdiOEOluykLBp6RUiXG9w+AYLrPv/D4iBZJD2wjHTxZuJoIZ5i97CoF3npptBL8iwBHB8136H5ZwcORjVg13/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775117; c=relaxed/simple;
	bh=rymoPHn2ZlMaUEiTXgcbEStbTLSOtezUfdAss9Zk0rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEUs8j6u9cQC1xZ4UBIETLCh6ipv2pDF5aRaiB6zjfjPcRxsfef8mPRuM5Ye/wyj49BKBFcrsP76aULtDEyv80k4Zq1Ij/+50iH2soKu/PbHnifF/jHU2f7gwuyQhO9qffNO+IecrwgfobZy7dkl39oG2BlUMyqV/Nc8qhcCR3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjJaVEnv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjJaVEnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EE9C2BCB0
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 12:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776775116;
	bh=rymoPHn2ZlMaUEiTXgcbEStbTLSOtezUfdAss9Zk0rw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hjJaVEnvGi4hNkXCDYHQJQ9AQs7/aHZEiK+1jFjc4LgsDwwDxLghXcpYqWNCw1qoI
	 XcYiDaftGsteARgvZqapVdk0sHNu0TqVLEk5XwzdEAZj24gX2lztTYy6903tjgt+Vo
	 6DYOQG5FwGusBm52+Iv2aPaaxUK9FiQokj138KqBiD3av2VaTeYXk+gpEvg+lY/oWr
	 H4MIlnzLOTC4hPyWq+5ReVq7oEk0+We8EMcNLZDx+lFU5nWMrxd/DSMXppm9W/FtWT
	 RTZRLrrWkPQ2vAK1xaixV4U01owReC5ddpKIxKzhkQFzL3Q6xW4MLTzTqtSrEMOIL5
	 YBR2mgN9wXSaQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-671c5eb7fb0so5271741a12.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 05:38:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8hLX8o4ROMcqVsDYmm6mK2iYFYcUMxxaATO6NJR9rcFW/TJk5OGDM7n1V+axxLrHR8bSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqZIHfdSTboJvwnFImZ+Pkzz9Gz/fIhSKwjvVhupAzwofbhTq
	r+6bbVujHVPGs8tsK8E9u0PdtoV6FNO/FrpHbc0snx0+tBgbYTLqZKmLkezke12vRmJjkrzqIcr
	lgtAeZqckSqBoCE2qZuKWeBU/+mRSPRM=
X-Received: by 2002:a17:906:fd86:b0:baa:2e75:8cd5 with SMTP id
 a640c23a62f3a-baa2e759062mr72406166b.15.1776775115362; Tue, 21 Apr 2026
 05:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413040506.26640-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260413040506.26640-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 21 Apr 2026 20:38:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H59RuXDEqLe7UNDYssvMFXqZ2YZuW4gOUqdscPQZpqibg@mail.gmail.com>
X-Gm-Features: AQROBzBRpNGWipl724BOAylylJwoy0i6v0jh76onHkLo_f7Xi2JBiw7tmbrgnFU
Message-ID: <CAAhV-H59RuXDEqLe7UNDYssvMFXqZ2YZuW4gOUqdscPQZpqibg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] LoongArch: BPF: Support more atomic instructions
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

Maybe we need V4? If so, please submit as soon as possible.


Huacai

On Mon, Apr 13, 2026 at 12:05=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> v3: Modify emit_atomic_ld_st() to use ld[x].{bu,hu,wu} instructions.
>
> v2: Modify show_cpuinfo() to add lam_bh capability, no other changes.
>
> This series is based on 7.0, the aim is to support more instructions:
> (1) 8 and 16 bit read-modify-write instructions,
> (2) load-acquire and store-release instructions.
>
> When compiling, please set CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS and
> unset CONFIG_BPF_UNPRIV_DEFAULT_OFF.
>
> All of the related testcases passed and no regressions for bpf selftests.
> Here are the test results on LoongArch:
>
>   $ sudo ./test_progs -t verifier_load_acquire
>   #577/1   verifier_load_acquire/load-acquire, 8-bit:OK
>   #577/2   verifier_load_acquire/load-acquire, 8-bit @unpriv:OK
>   #577/3   verifier_load_acquire/load-acquire, 16-bit:OK
>   #577/4   verifier_load_acquire/load-acquire, 16-bit @unpriv:OK
>   #577/5   verifier_load_acquire/load-acquire, 32-bit:OK
>   #577/6   verifier_load_acquire/load-acquire, 32-bit @unpriv:OK
>   #577/7   verifier_load_acquire/load-acquire, 64-bit:OK
>   #577/8   verifier_load_acquire/load-acquire, 64-bit @unpriv:OK
>   #577/9   verifier_load_acquire/load-acquire with uninitialized src_reg:=
OK
>   #577/10  verifier_load_acquire/load-acquire with uninitialized src_reg =
@unpriv:OK
>   #577/11  verifier_load_acquire/load-acquire with non-pointer src_reg:OK
>   #577/12  verifier_load_acquire/load-acquire with non-pointer src_reg @u=
npriv:OK
>   #577/13  verifier_load_acquire/misaligned load-acquire:OK
>   #577/14  verifier_load_acquire/misaligned load-acquire @unpriv:OK
>   #577/15  verifier_load_acquire/load-acquire from ctx pointer:OK
>   #577/16  verifier_load_acquire/load-acquire from ctx pointer @unpriv:OK
>   #577/17  verifier_load_acquire/load-acquire with invalid register R15:O=
K
>   #577/18  verifier_load_acquire/load-acquire with invalid register R15 @=
unpriv:OK
>   #577/19  verifier_load_acquire/load-acquire from pkt pointer:OK
>   #577/20  verifier_load_acquire/load-acquire from flow_keys pointer:OK
>   #577/21  verifier_load_acquire/load-acquire from sock pointer:OK
>   #577     verifier_load_acquire:OK
>   Summary: 1/21 PASSED, 0 SKIPPED, 0 FAILED
>
>   $ sudo ./test_progs -t verifier_store_release
>   #615/1   verifier_store_release/store-release, 8-bit:OK
>   #615/2   verifier_store_release/store-release, 8-bit @unpriv:OK
>   #615/3   verifier_store_release/store-release, 16-bit:OK
>   #615/4   verifier_store_release/store-release, 16-bit @unpriv:OK
>   #615/5   verifier_store_release/store-release, 32-bit:OK
>   #615/6   verifier_store_release/store-release, 32-bit @unpriv:OK
>   #615/7   verifier_store_release/store-release, 64-bit:OK
>   #615/8   verifier_store_release/store-release, 64-bit @unpriv:OK
>   #615/9   verifier_store_release/store-release with uninitialized src_re=
g:OK
>   #615/10  verifier_store_release/store-release with uninitialized src_re=
g @unpriv:OK
>   #615/11  verifier_store_release/store-release with uninitialized dst_re=
g:OK
>   #615/12  verifier_store_release/store-release with uninitialized dst_re=
g @unpriv:OK
>   #615/13  verifier_store_release/store-release with non-pointer dst_reg:=
OK
>   #615/14  verifier_store_release/store-release with non-pointer dst_reg =
@unpriv:OK
>   #615/15  verifier_store_release/misaligned store-release:OK
>   #615/16  verifier_store_release/misaligned store-release @unpriv:OK
>   #615/17  verifier_store_release/store-release to ctx pointer:OK
>   #615/18  verifier_store_release/store-release to ctx pointer @unpriv:OK
>   #615/19  verifier_store_release/store-release, leak pointer to stack:OK
>   #615/20  verifier_store_release/store-release, leak pointer to stack @u=
npriv:OK
>   #615/21  verifier_store_release/store-release, leak pointer to map:OK
>   #615/22  verifier_store_release/store-release, leak pointer to map @unp=
riv:OK
>   #615/23  verifier_store_release/store-release with invalid register R15=
:OK
>   #615/24  verifier_store_release/store-release with invalid register R15=
 @unpriv:OK
>   #615/25  verifier_store_release/store-release to pkt pointer:OK
>   #615/26  verifier_store_release/store-release to flow_keys pointer:OK
>   #615/27  verifier_store_release/store-release to sock pointer:OK
>   #615     verifier_store_release:OK
>   Summary: 1/27 PASSED, 0 SKIPPED, 0 FAILED
>
>   $ sudo ./test_progs -t verifier_precision/bpf_load_acquire
>   #596/5   verifier_precision/bpf_load_acquire:OK
>   #596     verifier_precision:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
>   $ sudo ./test_progs -t verifier_precision/bpf_store_release
>   #596/6   verifier_precision/bpf_store_release:OK
>   #596     verifier_precision:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
>   $ sudo ./test_progs -t compute_live_registers/atomic_load_acq_store_rel
>   #80/7    compute_live_registers/atomic_load_acq_store_rel:OK
>   #80      compute_live_registers:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Tiezhu Yang (5):
>   LoongArch: Define instruction formats for AM{SWAP/ADD}.{B/H} and DBAR
>   LoongArch: BPF: Add the default case in emit_atomic() and rename it
>   LoongArch: BPF: Support 8 and 16 bit read-modify-write instructions
>   LoongArch: BPF: Support load-acquire and store-release instructions
>   selftests/bpf: Make CAN_USE_LOAD_ACQ_STORE_REL usable for LoongArch
>
>  arch/loongarch/include/asm/cpu-features.h     |   1 +
>  arch/loongarch/include/asm/cpu.h              |   2 +
>  arch/loongarch/include/asm/inst.h             |  10 +
>  arch/loongarch/include/uapi/asm/hwcap.h       |   1 +
>  arch/loongarch/kernel/cpu-probe.c             |   4 +
>  arch/loongarch/kernel/proc.c                  |   2 +
>  arch/loongarch/net/bpf_jit.c                  | 190 +++++++++++++++++-
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +-
>  .../selftests/bpf/progs/verifier_precision.c  |   4 +-
>  9 files changed, 203 insertions(+), 15 deletions(-)
>
> --
> 2.42.0
>
