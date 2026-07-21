Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E780321445
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631577; cv=none; b=gH1hBR+smxstFrSd57NLu4R+F/Zs8hdkp5vqRzQKer5ppBrXNnv7a4dVZubyATJ9FQ1xT4+jcDy+yB2lEdYQoDQy0qBzTkGnEGSas1Iv2Su+RoaVIBEm3h8/vt7tmT4c+SxcdhCCO6MhYrXNEkzP9qEvPNzz2ZQKThV3kxm8kzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631577; c=relaxed/simple;
	bh=r+WvVdqs9BjRaBdTi9xcGkRRvY7b/OnljJXckgkaal4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzkXsGcUOJPLEVOMIpZpcyhkPD1xfLAX6iMwzGguzZTGv7sYxVdfXfaRfSglrERGNvLUL3ReUVQxYfjJwDK1JA2JTkmh12OUZbUcCh/7TcDLTrrNNiUjUqYG1CTAVxdudYa0d6rG/Tkj0kW3qXOXRx4Yeq7xLwPhWR2fs075TQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaKLpVbX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaKLpVbX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5611F000E9;
	Tue, 21 Jul 2026 10:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784631576;
	bh=UOWA+LT7kl+cEhgFXoaLWktB9D2IdJlDPxiBO0QiXC0=;
	h=From:To:Cc:Subject:Date;
	b=HaKLpVbX1v7G4cWrftMYl/jzPsZ/yv5uJCUIw4TA/WC2GlRMQKG/YKX0mqU5fINHx
	 BDEzwOVRKMi8tMKJaFDztv6iPoICleLA0e15MkUrSuQms/KGbAaoYB7Bd1VMqJ0xZl
	 SijGpc276pVKqyQjAcEFRH0jvfylxGsd3IDa/PJMkUBdo61G3CSmd1C80A8hwgdUI9
	 BMBWHwrUItotMumolmPZV3czFLgUuFI0IegCiQHhX9roUNaVDlPXbNnCGT/c6f0LpK
	 pGhGN6S4l4Wq2vQfm/g+FX5+Y8lp0csg1igvTkE0CxN43QcA0uQuz41ccRkAVg7pSr
	 89sPRjN6FEGNQ==
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
	"Xu Kuohai" <xukuohai@huaweicloud.com>,
	Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH bpf-next v2] bpf, arm64: Optimize cast_user code generation
Date: Tue, 21 Jul 2026 03:59:20 -0700
Message-ID: <20260721105921.1070501-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cast_user converts an arena offset into a user address by combining the
low 32 bits of the pointer with the upper 32 bits of user_vm_start, while
keeping a NULL pointer NULL. The current sequence always emits six
instructions: it materializes user_vm_start >> 32 into a register, shifts
it into place, and ORs in the offset.

The upper half of user_vm_start is a constant, so it can be written
directly onto the offset with MOVK. Move the 32-bit offset into dst
(which also zeroes the upper 32 bits), then MOVK the non-zero halfwords
of the upper address, branching over the MOVKs when the offset is zero so
NULL is preserved.

This emits at most four instructions, and only one when the upper half of
user_vm_start is zero. The generated code is equivalent.

Before:
  ; bpf_addr_space_cast(page1, 1, 0);
  7c:   mov     w10, w8
  80:   mov     w8, #1
  84:   lsl     x8, x8, #32
  88:   cbz     x10, 0xffff800087b80c20
  8c:   orr     x10, x8, x10
  90:   mov     x8, x10

After:
  ; bpf_addr_space_cast(page1, 1, 0);
  7c:   mov     w8, w8
  80:   cbz     w8, 0xffff800087b80c28
  84:   movk    x8, #1, lsl #32

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Xu Kuohai <xukuohai@huawei.com>
---

Changelog:
V1: https://lore.kernel.org/all/20260717134817.2868291-1-puranjay@kernel.org/
Changes in v2:
- Rename upper_32 and upper_48 to upper_low and upper_high (Xu Kuohai)

---
 arch/arm64/net/bpf_jit_comp.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b0075ece4a6e7..0f61662b900bd 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1284,12 +1284,25 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_ALU | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		if (insn_is_cast_user(insn)) {
-			emit(A64_MOV(0, tmp, src), ctx); // 32-bit mov clears the upper 32 bits
-			emit_a64_mov_i(0, dst, ctx->user_vm_start >> 32, ctx);
-			emit(A64_LSL(1, dst, dst, 32), ctx);
-			emit(A64_CBZ(1, tmp, 2), ctx);
-			emit(A64_ORR(1, tmp, dst, tmp), ctx);
-			emit(A64_MOV(1, dst, tmp), ctx);
+			u32 upper = ctx->user_vm_start >> 32;
+			u16 upper_low = upper & 0xffff;
+			u16 upper_high = upper >> 16;
+			int nr_movk = !!upper_low + !!upper_high;
+
+			/*
+			 * Build the user address: the low 32 bits are the arena
+			 * offset, the upper 32 bits come from user_vm_start. A
+			 * zero offset must stay NULL, so branch over the MOVKs
+			 * when it is zero.
+			 */
+			emit(A64_MOV(0, dst, src), ctx); /* 32-bit mov clears the upper 32 bits */
+			if (nr_movk) {
+				emit(A64_CBZ(0, dst, nr_movk + 1), ctx);
+				if (upper_low)
+					emit(A64_MOVK(1, dst, upper_low, 32), ctx);
+				if (upper_high)
+					emit(A64_MOVK(1, dst, upper_high, 48), ctx);
+			}
 			break;
 		} else if (insn_is_mov_percpu_addr(insn)) {
 			if (dst != src)

base-commit: 0bcca2a42cc50b7d64a95c08dffc6b93661a7ea2
-- 
2.53.0-Meta

