Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022182;
	b=zJawCeLzC744uz3Vssb1umk8EYM1HbnrXh7xq+4nLgc3MixthXbY4B61Kq6E+EjaY4oA
	 ElNRzBtUmE6MxmpkyK6IqwnDWuGUbmV9o1mtn5fcX0k6mAIqF+BWnxNRZ/divaAeRtkT4
	 xsIgLwT+i4ypAksB8/WXgtVZEVHeNwZHtBKwL7SWbdB+sxOzmQNyTbylzBGdIWix7ow+o
	 mXx3JuRrkA1F3PQfBzc6zJHCmyJAjee+tWsFlcDMkFtVcqSdisDZYF4TqhB/ZgD1wMobc
	 v4S5ZaR2MHk+wbaJPpKdExMm5XdRQXzkT7fqiNmD+CeL2yxr7oqhaVeqB8iXDtuxf1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022182;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nWl4ECtXObpUU/bffH0+yhXjtGI+yckqht/vP3iJXgg=;
	b=z40SM5ivJh/L1sg8aFfnb16VwcFlQV3FQNG28CMgYa5B2zdhy4fDKc4wuGNYM2mK+q4N
	 qXy+h3+wCS9YUi3Fty14qUXCR5OC0By86Y3j+2BZb84V7ljYEzJ1Mr0xg6R0EEG+I/gZ1
	 T8eOMWRtm2KpxvxGUwIUefI+JPgt2PoMfWugjHyy3m8KriV6s8UGdY2450wCLmH13bxI4
	 Zwiw0NLo3Tt/CNW9pzKfY8VnKwBIcWmQn8FOEPn1JuSjyM/B265+jNpIE3PWEWtl0QQSx
	 wYKbdGyVL7eRO3zaXeqHfX+RXM9D7aW8kVf6ZRnjsh0yi7ipRh38Q4j9peXaX/AevEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+00u1u9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570CC606A31F;
	Mon, 26 Oct 2026 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+00u1u9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3693E1F01825;
	Mon, 26 Oct 2026 13:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793022181;
	bh=nWl4ECtXObpUU/bffH0+yhXjtGI+yckqht/vP3iJXgg=;
	h=From:To:Cc:Subject:Date;
	b=X+00u1u9tjhZ8YZqzq9a+DTF8qNcUAMogw6s3S4FCNspGPu8nuf+cHXWGgeAardrR
	 le6fYjXEOmpNuws/h0gyc2CUVTYbkASg7uAy8KjBB4j5ijGkGOsXR/+Lj4geskMpaj
	 nLI26LPnDqhRJvZydCUW9eXZhgeCkW2Rpxw7q3EoUXiVJAJ/9ZQdhkVisvhbQC8OMc
	 7EsP7XhG5p/mfHUoiI/HlyyHN2q2ZJIgpUKzFRww5EE+itVETlcjHBfkgndhOq5eCO
	 BRN4Wxq1tA3I6knWWotcLHfdgiQnyvP4dxcHPZG+bRdFn0wbtgrs5n4sijgRigZ2yS
	 42paFiEo+J4wQ==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH 0/5] MIPS: Select the R10000 LL/SC workaround at boot
Date: Mon, 26 Oct 2026 14:41:40 +0100
Message-ID: <20261026134147.15988-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernels for IP27, IP28 and IP30 select CONFIG_WAR_R10000_LLSC, which
retries ll/sc sequences with a branch-likely that only R10000s before
revision 3.0 need. On an R12000 Octane, dropping it makes fork, pipe,
futex and file creation 1-4% faster.

This series keeps it built in and decides at boot. Unless an affected
CPU is present, sc branches become beqz, modules are patched at load,
and tlbex and the BPF JIT emit beqz.

Patch 3 conflicts in context with the IP35 series' "MIPS: SGI-IP27:
give each CPU its own topology package id"; it resolves in one line.

Patch 5 depends on patch 2, so I'd like the whole series to go through
the MIPS tree, with an Acked-by from the BPF maintainers on patch 5.

Tested on an R12000 Octane, and the BPF JIT with test_bpf on QEMU
64-bit Malta. No R10000 before revision 3.0 was available.

Imre Kaloz (5):
  MIPS: Use SC_BEQZ in the futex and sysmips ll/sc loops
  MIPS: Select the R10000 LL/SC workaround at boot
  MIPS: SGI-IP27: Report all CPUs to the R10000 LL/SC workaround
  MIPS: tlbex: Follow the boot-time R10000 LL/SC choice
  bpf, mips: Follow the boot-time R10000 LL/SC choice

 arch/mips/Kconfig                 |   5 +-
 arch/mips/include/asm/asm.h       |   7 +-
 arch/mips/include/asm/futex.h     |   5 +-
 arch/mips/include/asm/r10k-llsc.h |  29 ++++++++
 arch/mips/kernel/Makefile         |   1 +
 arch/mips/kernel/module.c         |   5 ++
 arch/mips/kernel/r10k-llsc.c      | 111 ++++++++++++++++++++++++++++++
 arch/mips/kernel/setup.c          |   2 +
 arch/mips/kernel/smp.c            |   2 +
 arch/mips/kernel/syscall.c        |   2 +-
 arch/mips/kernel/vmlinux.lds.S    |   8 +++
 arch/mips/mm/tlbex.c              |   3 +-
 arch/mips/net/bpf_jit_comp.c      |   5 +-
 arch/mips/net/bpf_jit_comp.h      |  12 ++--
 arch/mips/net/bpf_jit_comp32.c    |   1 +
 arch/mips/net/bpf_jit_comp64.c    |   5 +-
 arch/mips/sgi-ip27/ip27-smp.c     |   2 +
 17 files changed, 188 insertions(+), 17 deletions(-)
 create mode 100644 arch/mips/include/asm/r10k-llsc.h
 create mode 100644 arch/mips/kernel/r10k-llsc.c


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.47.3

