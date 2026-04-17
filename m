Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08239F166
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436457; cv=none; b=rtO2BOMxL5xsYDP7WtXg1q4mC/BNCSTI6VYLtqfCEiL8VMe5Y4lqZfrg8Kun0PZtngAhe1k+P6gwLfYm4ePrmO9AZTylzTel6dxTqNeAwpVbY0LLTSVmEvE6ILAj93ey75W8GQTDNTYq1oDiC7Rjo1tRliVEV8EFM6+Pn5Wri+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436457; c=relaxed/simple;
	bh=6lFrV0Kxuw3w+OJK4u6i+vEPG0MGSRXRYCqYEaZOWXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TY3m4D7U0upl4U9UYwrZMG5u0EEdj21SXjsReBEAxmWRbQfKbHnDWPGDVCK9VY8A8VqfCJFKI6j+8K0ee+TQFIm/ZKErSjCn52GNWf3eukBkeORPg7eQpOjjqqMSL4fSBk3pGP60C9bNDOx7zqVHb94QU/Ki9ABJ0YrgvOEXxKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYyIABYQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYyIABYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF39FC19425;
	Fri, 17 Apr 2026 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776436457;
	bh=6lFrV0Kxuw3w+OJK4u6i+vEPG0MGSRXRYCqYEaZOWXw=;
	h=From:To:Cc:Subject:Date:From;
	b=oYyIABYQePjYduahiiY3ku9Rbi3nROJIHbEQFvWciGFArMwJUrzs1dDcpk0vMwTyO
	 c/A/AEdkSFJBj24NC+vWvWsc2f93i0EVIwyKuShqf2A7cG8/3FySxctWfqvJ+R3Oqn
	 Ge+M0c5vO934VjQM57jfB/+H72ACagGdWOarOdTYXS3oCrZxrL+jdi4NRIr1LsoYmw
	 P4+x7yM13ImVlzzDH/WOWZ02HOC8hawaWA6wrWk4hqV5M6kcOesVvmgQJZ73jzOz6P
	 APsnt13y37N6yj2b4lnftDkh1ZzF0i+Yy/cL1FYikU3jh9fjUEoapny0aP/fPN4NNC
	 7YNb0gvQHnEzw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Jonas Rebmann <jre@pengutronix.de>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	kernel@pengutronix.de
Subject: [PATCH bpf-next v2] arm32, bpf: Reject BPF-to-BPF calls and callbacks in the JIT
Date: Fri, 17 Apr 2026 07:33:52 -0700
Message-ID: <20260417143353.838911-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARM32 BPF JIT does not support BPF-to-BPF function calls
(BPF_PSEUDO_CALL) or callbacks (BPF_PSEUDO_FUNC), but it does
not reject them either.

When a program with subprograms is loaded (e.g. libxdp's XDP
dispatcher uses __noinline__ subprograms, or any program using
callbacks like bpf_loop or bpf_for_each_map_elem), the verifier
invokes bpf_jit_subprogs() which calls bpf_int_jit_compile()
for each subprogram.

For BPF_PSEUDO_CALL, since ARM32 does not reject it, the JIT
silently emits code using the wrong address computation:

    func = __bpf_call_base + imm

where imm is a pc-relative subprogram offset, producing a bogus
function pointer.

For BPF_PSEUDO_FUNC, the ldimm64 handler ignores src_reg and
loads the immediate as a normal 64-bit value without error.

In both cases, build_body() reports success and a JIT image is
allocated. ARM32 lacks the jit_data/extra_pass mechanism needed
for the second JIT pass in bpf_jit_subprogs(). On the second
pass, bpf_int_jit_compile() performs a full fresh compilation,
allocating a new JIT binary and overwriting prog->bpf_func. The
first allocation is never freed. bpf_jit_subprogs() then detects
the function pointer changed and aborts with -ENOTSUPP, but the
original JIT binary has already been leaked. Each program
load/unload cycle leaks one JIT binary allocation, as reported
by kmemleak:

    unreferenced object 0xbf0a1000 (size 4096):
      backtrace:
        bpf_jit_binary_alloc+0x64/0xfc
        bpf_int_jit_compile+0x14c/0x348
        bpf_jit_subprogs+0x4fc/0xa60

Fix this by rejecting both BPF_PSEUDO_CALL in the BPF_CALL
handler and BPF_PSEUDO_FUNC in the BPF_LD_IMM64 handler, falling
through to the existing 'notyet' path. This causes build_body()
to fail before any JIT binary is allocated, so
bpf_int_jit_compile() returns the original program unjitted.
bpf_jit_subprogs() then sees !prog->jited and cleanly falls
back to the interpreter with no leak.

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
Reported-by: Jonas Rebmann <jre@pengutronix.de>
Closes: https://lore.kernel.org/bpf/b63e9174-7a3d-4e22-8294-16df07a4af89@pengutronix.de
Tested-by: Jonas Rebmann <jre@pengutronix.de>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---

Changelog:
v1: https://lore.kernel.org/all/20260417103004.3552500-1-puranjay@kernel.org/
Changes in v2:
- Add Acked-by: Daniel Borkmann <daniel@iogearbox.net>
- Reject BPF_PSEUDO_FUNC in the BPF_LD | BPF_IMM | BPF_DW handler
- Move code below declarations

---
 arch/arm/net/bpf_jit_32.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index deeb8f292454..a900aa973885 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1852,6 +1852,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	{
 		u64 val = (u32)imm | (u64)insn[1].imm << 32;
 
+		if (insn->src_reg == BPF_PSEUDO_FUNC)
+			goto notyet;
+
 		emit_a32_mov_i64(dst, val, ctx);
 
 		return 1;
@@ -2055,6 +2058,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		const s8 *r5 = bpf2a32[BPF_REG_5];
 		const u32 func = (u32)__bpf_call_base + (u32)imm;
 
+		if (insn->src_reg == BPF_PSEUDO_CALL)
+			goto notyet;
+
 		emit_a32_mov_r64(true, r0, r1, ctx);
 		emit_a32_mov_r64(true, r1, r2, ctx);
 		emit_push_r64(r5, ctx);

base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
-- 
2.52.0

