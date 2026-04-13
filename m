Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ACA37EFFA;
	Mon, 13 Apr 2026 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107480; cv=none; b=Yn/EFSgLOe89LRQUNDJwAPlC+7wvI2kGido9DP7thNJw0/qJTODXqf7tGjeAWC7yi+Ehk42a1Wrcceo8YLtTdwO2SvtcqaZwpSd4Qg22fugPOtUwdcI4W0op54nd8PxvvKLyGWOr+ht71rUq14xugbSBpyzG7GpwAqCmqDFdxtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107480; c=relaxed/simple;
	bh=wQgADd80D/pun3cifGRSz/mIPDYovCZECVayXUjBKrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNQJbg3n27X1OaYzZaxgxz7kuX8QjbuRjKz+iZK3TmD0LbnnAoY2IHc81zzZfGpzvgWTxhmGgRuwATG6Q4DGhdc8ZFzTMUffxRdUYL6Kxv2eBbdbuG72vZGzQmrcdFp3rXYXAdxkmn4YvxSWoQgDSWJ9dB8+J0IC+8MAqURQqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM4ZFz8y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM4ZFz8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC95C2BCAF;
	Mon, 13 Apr 2026 19:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776107479;
	bh=wQgADd80D/pun3cifGRSz/mIPDYovCZECVayXUjBKrg=;
	h=From:To:Cc:Subject:Date:From;
	b=eM4ZFz8yZ1k2of+wPmWowz80jBd70rhdHOFyAgCv0sMUcqq0hNqASbK+atDSo5/v7
	 OXff0sMmMm4Uro+jw8NeKEYarPVkLeL8qMq3lqsyEW3QAEvgN03yTT6LiY+l5TwXJp
	 +AOSvHlpjhGl1TGT/cRGpwRA5mk0402pGmvuMok0k9QbhxsrWBnGAZFb4NUo8ATRiS
	 w4gChZ2YV7eK5ePij0+2wggMJnaMHBhNL62obsd5Xtd7ztUYsQpP2rjuqUOSIWmk1w
	 LmDg122CUY1O4kD3Nv4u37ry0E8k8KT+6HL9MZnw6vEt6s2wWVRzsReULl215xuJBx
	 x/H3dsIak8hVQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Jiri Olsa" <jolsa@kernel.org>,
	"Xu Kuohai" <xukuohai@huaweicloud.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>,
	"Luke Nelson" <luke.r.nels@gmail.com>,
	"Xi Wang" <xi.wang@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	"Pu Lehui" <pulehui@huawei.com>,
	"Paul Walmsley" <pjw@kernel.org>,
	"Palmer Dabbelt" <palmer@dabbelt.com>,
	"Albert Ou" <aou@eecs.berkeley.edu>,
	"Alexandre Ghiti" <alex@ghiti.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf, arm64/riscv: Remove redundant icache flush after pack allocator finalize
Date: Mon, 13 Apr 2026 12:11:07 -0700
Message-ID: <20260413191111.3426023-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1: https://lore.kernel.org/all/20260413123256.3296452-1-puranjay@kernel.org/
Changes in v2:
- Remove "#include <asm/cacheflush.h>" as it is not needed now.
- Add Acked-by: Song Liu <song@kernel.org>

When the BPF prog pack allocator was added for arm64 and riscv, the
existing bpf_flush_icache() calls were retained after
bpf_jit_binary_pack_finalize(). However, the finalize path copies the
JITed code via architecture text patching routines (__text_poke on arm64,
patch_text_nosync on riscv) that already perform a full
flush_icache_range() internally. The subsequent bpf_flush_icache()
repeats the same cache maintenance on the same range.

Remove the redundant flush and the now-unused bpf_flush_icache()
definitions on both architectures.

Puranjay Mohan (2):
  bpf, arm64: Remove redundant bpf_flush_icache() after pack allocator
    finalize
  bpf, riscv: Remove redundant bpf_flush_icache() after pack allocator
    finalize

 arch/arm64/net/bpf_jit_comp.c | 12 ------------
 arch/riscv/net/bpf_jit.h      |  6 ------
 arch/riscv/net/bpf_jit_core.c |  7 -------
 3 files changed, 25 deletions(-)


base-commit: 71b500afd2f7336f5b6c6026f2af546fc079be26
-- 
2.52.0

