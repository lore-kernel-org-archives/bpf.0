Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D7282F0A
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296104; cv=none; b=Zj4/1LbReIJO7LyYaIhR41Kg8G6qkb+XlWXepw2mJ7BNAxhNcSlu8YRkMtxD9LCJMrjMJFhKLoFJFpJVjvztOaHx6hcAPRw5eQ5nHOcNoYz2Hs7aXQIl4YCjiQ49BiR9B9H2ee6zFk5KpxkavhMcrBUv30AI82QLH9o5AUsWXsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296104; c=relaxed/simple;
	bh=wKWKGgGjnEfXRioH/A8xHTDV7DOVdo3XhdA1VsoDWlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qV/317osskbKJcS9Ktc+lo9dwJxuYv5ufuzjDWbHNQgx+pgvsX6HmPeesDDqoAHjsUaaCXwjM1nRUsEYyLySsJ4GAM/KUa3qfCfNJddrEqXdgSv4YwiX6dQ4q6qhm95JGiaGVv71jeT9vcoO+0X+6oTF6UqQToLEHHv541ICQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+YTqKu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+YTqKu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757CC1F00AC4;
	Fri, 17 Jul 2026 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784296102;
	bh=TlQVZJKIlFRbpnhXsKuBfuNg+YMCdg+N2nkzG1Dz/Z8=;
	h=From:To:Cc:Subject:Date;
	b=Y+YTqKu/WVd6mSt1o06syKg76QNmQozMV8FTUCD3OassZxvbDWlmY45Y8Q3NOv0jL
	 4430sXKKhNz9gekIyKqlW8ON0xaZnDmGJQcz5YaTsJqXsr3ajbXXUNQyt4Yhp4yKZx
	 CsWQOWbZ+m7qHNPaoNMasCUmey5nRmy+9bXg0mewo3+PYH5/PDVUv9gBnIDNCyI6HC
	 L/5RaTOtTpnU8u4J2Z9yQqbZkvW6gIMgjFp4n777veXetkVhzX7AqI5al6zDTGsALy
	 w/szsmAjTk9weAnDeeSlNX2385kYRYLKTrxWRtxDYbG7LV3XVWdsCqNUMkwGajrWJO
	 2PpJSDrO2Lcfg==
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
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next] bpf, arm64: Optimize cast_user code generation
Date: Fri, 17 Jul 2026 06:48:15 -0700
Message-ID: <20260717134817.2868291-1-puranjay@kernel.org>
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
---
 arch/arm64/net/bpf_jit_comp.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b0075ece4a6e7..c6756b964c843 100644
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
+			u16 upper_32 = upper & 0xffff;
+			u16 upper_48 = upper >> 16;
+			int nr_movk = !!upper_32 + !!upper_48;
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
+				if (upper_32)
+					emit(A64_MOVK(1, dst, upper_32, 32), ctx);
+				if (upper_48)
+					emit(A64_MOVK(1, dst, upper_48, 48), ctx);
+			}
 			break;
 		} else if (insn_is_mov_percpu_addr(insn)) {
 			if (dst != src)

base-commit: 1d91ea01185656ac3ee63c5f9f6f8bde3c746b3d
-- 
2.53.0-Meta

