Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502373;
	b=bziSu4Aw2GHKI2F1oVIR7DD5SCjNh08X9XGeFGasR/acNm2nqa652DiXH1P2z2pQuJG0
	 L8RM6mnUQvQ8QsA9k+tVrKFBezrsaOgk2Smij6A5h7c1lKYK/VFvxKIqRxRodjncrJTnI
	 CQTtb3/Gy2zF5+sfo9yb7/l1pKLDrS4CCHFNsVBtlOLjkZD6QBfImblUXUyWE+SSdTZQ2
	 lC2m4cIJJO97HCp5ffUxNkZk9Yz9o7NZZoN/iKEoRDIqL9yZ3H9DezxRkbXtORar8woFg
	 CdOVb+iKNZEeh6AM1oYcC3sT3LrYzFdZaHO2O55MWr42gsFJBIl0EqyJSxkiUfzRGeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CSN1h1N6RXxCzGl41IhORgHsIis77RpIn3le9KWt3hQ=;
	b=mbkl4Tk4LQj9Nh4G9NpoopjanRml/mDbJCkjlpBPM5tc+wE1+F2/R8hM8XZ0nWjisEYV
	 UAveYTR29uqrdceGFhn/i8Sqe1RIfSz2g1BGoZbm0iIj3KuTcYPHrTZTnMbMAU11X/OVl
	 lvtyjb0yRqdyCjRx69V/OujbKZy4nhk7WVHRJbQNdAtAn27I8ZQH47hR/G7HKFWlVdCI3
	 Cvi4d/uCnttTK3Zkc6gPQxc/WSAR+xw51GsZDORLWkcQC75HyOSQZnSevvUIr7h+bRUas
	 6H71IvCz14+VM9M2co+NMZ15YsmtCmYYEtmgMI0pwyEQNcE1ED8IbTVaXs1wvMTZ/Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NrwIPiZ3;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE012606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE012606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NrwIPiZ3
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so2639942a91.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502372; x=1794107172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CSN1h1N6RXxCzGl41IhORgHsIis77RpIn3le9KWt3hQ=;
        b=NrwIPiZ3vjGB7x3ibe7wVKUIsugkHbA9JoBMv3/cfjjD7I1fZGo5lu+VFdqP4pmcMf
         GTsqeaXYEHQnVJKlJjm09ncUo44adr7srfOH0EDE35/oZ3HHyBaflYBVLBv1bT41cecc
         7P3/eIbSiG3NdHbYpG+Dix4YBfZGrKf24A/XExorzbUMXB0EkIO9GEb+oIYzTso+D2Ki
         4rUU6KzV+HZi76pfx2CWF00kLmNTVDEgi+MOmUruYMxMhS2L1sNsbKkbTgSHPUcAENYQ
         xq1ing4C+PLLhC2f/KT7BuhF/PCmSAyJKMa6wDSOhbK051SgjFH1+spqVCirYtR1uNhM
         8DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502372; x=1794107172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CSN1h1N6RXxCzGl41IhORgHsIis77RpIn3le9KWt3hQ=;
        b=rqL5ZPbBM4QqgJ2LPkzFtJSUz9zC6u2YhU0AbCYaJFqJVNJd1+1WHIL49FXyHMypXv
         pb4fJC0pZ0pxO3efsT9LjouiRcNhClx2/oMPTnkr4AQv5RrJuBou5roUnL87SUstJsN/
         UH3nCX5bMyYHghr8/ZT2OzgfbNZoH3O4eM+oyowBAEjaN2nqF4fm4lAmuiN6eWT+DOpd
         yb7111yhJAx7wtoRnrMr39hQxveK8foY5tq/LPIab/2h36qqKfz3fZ9W+vzGvqZ+4QDc
         GN0HbNY/9bABW/KoNgmT/1UvY+sCQFEEf+tKg3Hi3xB2bn2j5VcBPZWkOR0HKOM5wRPS
         3ZPQ==
X-Gm-Message-State: APuU4Z/nMvmUN2y+Cfz5XOPdN/uQlf8AGwMkf3TWk6sN544OKtsan3Kf
	lqJBQNjJM2kmWfLm2jdy2VKJWJgXm1YWkt59I0gk9Ezk/dhCfakfr7YgJdVGqw==
X-Gm-Gg: AYBFou2SokssFjYeCDI/l+M/n7DGiTD9dC+gsmjtNgvtFSpqlrJgNpubuCyeP4gTEOc
	SEYIvbVRRevWUMIsg9JVHeZNOxaAVd6IFgDqxIoemfAGdQqnAOwbibqE44I6wrc0aU3SK47YffW
	/1DjN8eONHIaGqA+eshW6FiioCJt4rmBo3q7h5AsTfyiOJjDBSr8VaIqvnyQwEuPEhmJrENX7Ji
	O7jjMA94YIMXy0DH6ZYAhkW2Uj+lenO7TnePTyVDuPEUTqj7PYcDN7eXR36kmZWUNJQWevMpyiX
	9KKlqFmJRdV70eH6UbGPQAcdGRWgzL4gdWbSqv4Gi+FoQTWX0OaEVH42on3e5yeIBLrKwozwiR4
	Yres+7DUO+61pbQ0AsOAkLKGxmHfg6A8TKuk/0nJTAperg4cQRTTn+LsFCPSzipXhBic8IxaFYG
	Bq7TBO8yh9cZAVWZhNYermzpUSBjZ9EgQhrZIH3xB+zzJl7RLV3cVcze2BJzLQMKeGA0jei/VLn
	lxrfjNkj7MB1q+7E2gIwqCDNPto9prwMZPe4caU+AlsZzhVJz8ksOV+p0N92pf7S8Mqwzs3dFij
	vxCQNkELA0c6GjtQjomyc7pQv4dEC2f3XMdaKD5tSVc/TDIZg0J6D78s3bl88lZuLrrKmXmsFYF
	9ATtWj+QpVsYmzwOm4sh/4CUGyAGmz6binWFtv/GgPqnPuCUVUP9VmDyskNeoJp58yTYscoAhtA
	==
X-Received: by 2002:a17:90b:28c5:b0:3ad:ce24:acfa with SMTP id 98e67ed59e1d1-3ae897c652dmr5028167a91.20.1793502372061;
        Sat, 31 Oct 2026 20:06:12 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm9382132a91.9.2026.10.31.20.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:06:11 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 10/14] bpf, x86: Add BPF_ATOMIC_LOCAL
Date: Sun,  1 Nov 2026 03:05:06 +0000
Message-ID: <20261101030511.1578690-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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

  hot caches                                 0.44
  after a store to 16 Mbyte of data (L3)     1.6
  after a store that misses all caches       47

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 10 +++++++++-
 include/linux/filter.h      |  8 ++++++++
 kernel/bpf/core.c           |  6 ++++++
 kernel/bpf/disasm.c         |  7 +++++++
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 70c23b48bd9c..3659f288b32e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1625,7 +1625,10 @@ static int emit_atomic_rmw(u8 **pprog, u32 atomic_op,
 {
 	u8 *prog = *pprog;
 
-	if (atomic_op != BPF_XCHG)
+	/* one insn is atomic for what runs on this cpu */
+	if (atomic_op & BPF_ATOMIC_LOCAL)
+		atomic_op &= ~BPF_ATOMIC_LOCAL;
+	else if (atomic_op != BPF_XCHG)
 		EMIT1(0xF0); /* lock prefix */
 
 	maybe_emit_mod(&prog, dst_reg, src_reg, bpf_size == BPF_DW);
@@ -5199,6 +5202,11 @@ bool bpf_jit_supports_private_stack(void)
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
index f5387d12c448..1b59ec817048 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -81,6 +81,13 @@ struct ctl_table_header;
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
 
@@ -1324,6 +1331,7 @@ bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
+bool bpf_jit_supports_local_atomics(void);
 bool bpf_jit_supports_large_stack(void);
 bool bpf_jit_supports_timed_may_goto(void);
 bool bpf_jit_supports_fsession(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 43a8000aad3a..6f4bcf3c851c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3628,6 +3628,12 @@ bool __weak bpf_jit_supports_private_stack(void)
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
index 0b1bbb27e9e4..2e377a7ea262 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -9,6 +9,7 @@
 
 /* Only defined by the non-UAPI linux/filter.h, which this file cannot use. */
 #define BPF_PROBE_ATOMIC 0xe0
+#define BPF_ATOMIC_LOCAL 0x1000
 
 #define __BPF_FUNC_STR_FN(x) [BPF_FUNC_ ## x] = __stringify(bpf_ ## x)
 static const char * const func_id_str[] = {
@@ -257,6 +258,12 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
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

