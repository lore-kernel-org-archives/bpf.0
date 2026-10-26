Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983734;
	b=K3wy9kGBRYLiiY1Wajz/tJtp0PhdUXFX8cPWpF38YUA0E/OcD+/x8rfNaNL3Ji9oifn+
	 2Ggeo886a/eQilzB4iPaNZsfeLb8YpI6qJwuFidIeDgJoZO6r5chq4yHa7maYQcGgeOt2
	 Gyq6iCV/ASn8mG3ZS+Ki32y5dvI58t11n1TDRDoAbGGsFn6+/6g7B0pgUUmkM5iyim+Yr
	 VZiVVAIrGkyHfNIqF3fbGL0GBf4R7N1cSGleMUrBZQe1F9Ne7bczSK83Wrti5cuVrhA4f
	 4pKXCW/Umy6XMmIqaSphSeqp82cDOMZDTH77qbTcyZ1B0wYIyKJGhw83E3+HBtN4wPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DRy4CN7bYWqy08E2qvbg4qK+WXe0DIj+Y5gBTOUzNtk=;
	b=aEQ8KJ7Mpmm7LdSQnVDiUYeqtut2qfqKVC1x6LJ4kg0KGEwyrBNNIDsP6c/9plvK5Hy2
	 mo+m5GRbO5wxhWOlSYz4AdN6Xwcf0IuExgUp3R47g4u1JLCxejXF/Fj6ABES5B1mS7URA
	 sosC9dJqDWiBl6ZWSgXJp2SMLMD48kmLmxvX75K5xCic8ivjoJyxjIH/PaoZNgxiUs4s7
	 XVXhGNDKDpcjU6A1rXQoZACOHPKXClWt+kft8H/B7hT0NslD4Xs+0tv3nNvvGa8i0U7g1
	 wHgVaR62/WuaxuVc+elr6xxbKckriowGfTnuQE4vRrNZfChEIK5GfmvspYBvZehZp/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jgUzJ3HW;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56484606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56484606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jgUzJ3HW
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so812479a12.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983734; x=1793588534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DRy4CN7bYWqy08E2qvbg4qK+WXe0DIj+Y5gBTOUzNtk=;
        b=jgUzJ3HWJvM7GjlZvo/HraR/xr8E2YTzjKNS77MahVl2FsbQKvBlK4FAgpwxLr5tbs
         ra1EgxF2cvfkkOgfMyWn9id7IPJyL3JimotEEV05JpvkSOfCxuk9mDopMbVXRTg3jZG4
         +79dtDfZjilFQgWyNsk6VpQ8hjc/TM7Dqar5AKFmra3iKzDA4NAdePJcTwHklctHnV+5
         uwGdanfRwuOhdyrL2lSYPHxrqXhGJQajzXc+x1d8vKvWf6pvaB8MBxRxcXVXxdsIfLaT
         2gNuLYxCSEJt1vrPuti1/omXl16m5WNnd/u9/M6gASgU7sf28kgoV5fBKtXAm+ZMaJdc
         eIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983734; x=1793588534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DRy4CN7bYWqy08E2qvbg4qK+WXe0DIj+Y5gBTOUzNtk=;
        b=amSD2MiFEWLtUffvM9Mqmz0VQhu0SLYmBiHPdl02SZNoGTIgZ8ih7C5RsgIv7EIMx6
         aro9LJKi5NKDeWIpbaFWrotKVMy8gPeZSraa9+uiEBGuU5ZP/8SsZ0sNfXXpr+hVx3zP
         4km9PezCMHTFmdg4SEI2lnCDAHc++rIg+1j5w7xHEU7hOgfgpMpFNNy58q2VH3xK2ULd
         jaFvbx0hFT3i+OVZXRoCQaVFF3207yt5YZjIFFeypmO+UXesdWeXkR3t6gbgrPTmUXbN
         c7S7urlorZ1/5OY4o2PKCPKWv8rzssIULRNPXtuQ71UzxCTWLHfRH0Cr9g1vpqEu0Uhg
         E5VQ==
X-Gm-Message-State: AFq9FYKcodkO47vvVATpfzP18yUEN43Y8JzStNHEPj/dBtv6FdPzvJC7
	wnw750SzGUWnqPY5b9NWpxAiRxT0TN7jmd58SR4Pu1k1DH7skjrFFVtnFHn2IQ==
X-Gm-Gg: AYBFou1bs53cISwV4i9DaKA2rOL2A8NDAueX58piHFuERR9TXcnD0n0boUlEKTxVNx+
	uL5CZ51uFDs0/X6dAnvAmTC0PuKQOiDpzdPj7vGkKP5PR987hmAQI7Muj7t3uxO6f/h7YZwcW/U
	x5mNLxDVcUm5hHWV5K+8y6d9sQUZI0aZkRLyCY+SNIOuP+yGz8cqiP1oIb+miSqIbSolbK2SwMU
	UHjFOYOUEKnY8MkuiUcNqcLGaTbwqdcJn7qWmEUTjktnZLOYdWwLZFYrCUb4XnXo7b+VLhY5N4u
	iUgp+O2x5GzGblEWYIl7OTfc+2lBrghwU8RQe4xRNp9lS8YJy5P+4mxrRXgcGEhVIcgGzIWK13i
	YCvibhR8FWdrV4w2n8w7fMAE0CQwrFlfBOrEd0XpGAoTFVG9WJ/6Vb//fCQ7Tfyh7OnO0Qmp+6I
	J54ggfjFo3xhqbxlnyNGDRDUkVu4l15Z6j03bwEHBr/Ukf16XS23I+YlUBz3FO7Ey/aI0n6pUvU
	9OJrzTY7oJno4eLJsgJzV7JPfqRXnLGcTM445tFyvGI5ZMj8AW3VNOxV8RveibVIgP83DUcAt/+
	dau+PNfjW6FwHm3V/fpvByDt6q/0qV7T9g5xUMmHyxc/sTkKJHzBg9UVc/v/4iy82no9gqatakj
	8ddue30dd9mKG5asZMWXJJJXu
X-Received: by 2002:a17:90b:48c5:b0:3ac:b048:fa13 with SMTP id 98e67ed59e1d1-3adeafd1108mr4853095a91.67.1792983733368;
        Sun, 25 Oct 2026 20:02:13 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaca727sm6418973a91.3.2026.10.25.20.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:02:12 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 25/81] bpf, x86: Add BPF_ATOMIC_LOCAL
Date: Mon, 26 Oct 2026 02:58:46 +0000
Message-ID: <20261026025943.404450-26-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

A prog that has a stack in arena takes the per-cpu stack each time it
starts. It does this with fetch_add on a per-cpu word. Only this cpu
accesses the word. Thus the insn must be atomic only for an interrupt or
for a different task on the same cpu. But the fetch_add of BPF is atomic
for all cpus. On x86 it has the lock prefix, which waits for the stores in
the store buffer.

Add BPF_ATOMIC_LOCAL, a flag in imm of fetch_add. It means that the insn is
atomic only for code that runs on this cpu. One x86 insn is atomic for such
code. Thus the x86 JIT does not emit the lock prefix:

  BPF_ADD | BPF_FETCH                       lock xadd
  BPF_ADD | BPF_FETCH | BPF_ATOMIC_LOCAL    xadd

The flag is for per-cpu memory only. It is correct there because progs do
not migrate.

Only the verifier emits the flag, and only when the JIT reports
bpf_jit_supports_local_atomics(). The other JITs get the usual fetch_add.
The first user is "bpf: Support BPF_REG_ARENA_SP in the verifier". The
verifier continues to reject the flag in the insns of a prog. The atomics
of progs get the same code.

The time that the flag saves depends on the stores that are in the store
buffer when the prog starts. On x86-64 (Zen 5), in nsec per run:

  hot caches                                 0.33
  after a store to 16 Mbyte of data (L3)     1.3
  after a store that misses all caches       47

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 10 +++++++++-
 include/linux/filter.h      |  8 ++++++++
 kernel/bpf/core.c           |  6 ++++++
 kernel/bpf/disasm.c         |  7 +++++++
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d90b6d238b3a..a398c50b58ea 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1593,7 +1593,10 @@ static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 {
 	u8 *prog = *pprog;
 
-	if (atomic_op != BPF_XCHG)
+	/* one insn is atomic for what runs on this cpu */
+	if (atomic_op & BPF_ATOMIC_LOCAL)
+		atomic_op &= ~BPF_ATOMIC_LOCAL;
+	else if (atomic_op != BPF_XCHG)
 		EMIT1(0xF0); /* lock prefix */
 
 	maybe_emit_mod(&prog, dst_reg, src_reg, bpf_size == BPF_DW);
@@ -5141,6 +5144,11 @@ bool bpf_jit_supports_private_stack(void)
 	return true;
 }
 
+bool bpf_jit_supports_local_atomics(void)
+{
+	return true;
+}
+
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie)
 {
 #if defined(CONFIG_UNWINDER_ORC)
diff --git a/include/linux/filter.h b/include/linux/filter.h
index f57916e95b94..01a0e9e5f399 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -80,6 +80,13 @@ struct ctl_table_header;
 /* unused opcode to mark special atomic instruction */
 #define BPF_PROBE_ATOMIC 0xe0
 
+/*
+ * Flag in imm of BPF_ATOMIC fetch_add: atomic for what runs on this cpu only,
+ * an interrupt or another task. The memory is per-cpu and the program
+ * doesn't migrate. It's cheaper where one insn without a lock does it.
+ */
+#define BPF_ATOMIC_LOCAL 0x1000
+
 /* unused opcode to mark special ldsx instruction. Same as BPF_NOSPEC */
 #define BPF_PROBE_MEM32SX 0xc0
 
@@ -1290,6 +1297,7 @@ bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
+bool bpf_jit_supports_local_atomics(void);
 bool bpf_jit_supports_large_stack(void);
 bool bpf_jit_supports_timed_may_goto(void);
 bool bpf_jit_supports_fsession(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 94ee44ad88f7..364a3fa7cad5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3584,6 +3584,12 @@ bool __weak bpf_jit_supports_private_stack(void)
 	return false;
 }
 
+/* Whether JIT supports BPF_ATOMIC_LOCAL */
+bool __weak bpf_jit_supports_local_atomics(void)
+{
+	return false;
+}
+
 /*
  * Return TRUE if the JIT lays out frames of up to MAX_BPF_STACK_JIT bytes.
  * Its prologue, epilogue and tail call sequences must encode such frame
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 889fc074496f..25517632c3ff 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -9,6 +9,7 @@
 
 /* Only defined by the non-UAPI linux/filter.h, which this file cannot use. */
 #define BPF_PROBE_ATOMIC 0xe0
+#define BPF_ATOMIC_LOCAL 0x1000
 
 #define __BPF_FUNC_STR_FN(x) [BPF_FUNC_ ## x] = __stringify(bpf_ ## x)
 static const char * const func_id_str[] = {
@@ -239,6 +240,12 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg,
 				insn->off, insn->src_reg);
+		else if (atomic && insn->imm == (BPF_ADD | BPF_FETCH | BPF_ATOMIC_LOCAL))
+			verbose(cbs->private_data, "(%02x) r%d = local%s_fetch_add((%s *)(r%d %+d), r%d)",
+				insn->code, insn->src_reg,
+				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off, insn->src_reg);
 		else if (atomic &&
 			 (insn->imm == BPF_ADD || insn->imm == BPF_AND ||
 			  insn->imm == BPF_OR || insn->imm == BPF_XOR)) {
-- 
2.55.0

