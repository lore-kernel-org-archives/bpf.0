Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C22D3A69;
	Mon, 13 Apr 2026 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083607; cv=none; b=QkSrIlzotBDQNvtn4WWH9a+wPr4eTgyI379h6F2qKSTKOKMnsVXbM51DNYkeiFJTT4Ucs5gop4HoKO7o0PJe3z9WNThdMs/lb/F6F0JLFDRtsQXWKtyU+L4DHupzCddjg9uz4IXLddsnypm3dvx8oIJTRN3AIc3u6I+anA16uGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083607; c=relaxed/simple;
	bh=wDEfO/xa61/CEJ6jniOSKCwWHmjQlG9qEwI4fGV3AGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZ4FJkvoqjGvAj7XPxEIsrsHIpMUpIwC5qAE2pYXT0DyjYqwehIcGqDKrW0w+edasgTrB5xobckb3r2Ov9fkG4ZtjhYqMffHpaCOo/HLeeDCuIYgZG5Cjnr5QERC/5i6EmlUGULEIuF1CHRh2eXu6GerGhh6gqlQV9pHXPMmT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRzYJPLt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRzYJPLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E2CC2BCAF;
	Mon, 13 Apr 2026 12:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776083607;
	bh=wDEfO/xa61/CEJ6jniOSKCwWHmjQlG9qEwI4fGV3AGc=;
	h=From:To:Cc:Subject:Date:From;
	b=IRzYJPLtqyLTFDkW/E3erTl2pGBOqmAeso6+BBxzRo34O4QBovomeWcfquiET/MKM
	 p5ED9lkTfMffRJhzYHIWthsOtj4LLQmJZ4hZUxXOJMOehclBB9EXYql4RxVLEpWzEe
	 GhuqetgomPeaWQX/4PJnqIcZGdNCfBwbc6/SjjeOXRX0WYWdXvwMRNPqo6hWCpnury
	 FyYY9tTrqHh0m6+YoGqQNa8B9x/LHqB6dtXzLCg+X3Xsc44ejCjWoB8Gz/VvWykmnI
	 S+W1HNlVKveGdHiBri6PUzAqjbDo5M6M2Ln0WCVUmbD6q4KxUwOpdmZM/3T30wltqy
	 P7sNedl2CTHPw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf, arm64/riscv: Remove redundant icache flush after pack allocator finalize
Date: Mon, 13 Apr 2026 05:32:53 -0700
Message-ID: <20260413123256.3296452-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 arch/arm64/net/bpf_jit_comp.c | 11 -----------
 arch/riscv/net/bpf_jit.h      |  5 -----
 arch/riscv/net/bpf_jit_core.c |  7 -------
 3 files changed, 23 deletions(-)


base-commit: 71b500afd2f7336f5b6c6026f2af546fc079be26
-- 
2.52.0

