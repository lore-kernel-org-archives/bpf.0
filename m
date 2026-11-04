Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755505;
	b=BqAQ96n/FiV5Yx05GybvSMXbLJ2oUzDnUZqbbTCCS9uTcoASeyKehjrQGb/lYFeQduka
	 NgzIGdfHGapv623kra0vmL1hmAPpM27xGen6fRSkMdIrN6aNWNn88mRw3qNYq+4vuDC6X
	 jK89E6tYCZhaGQ9ha9g+mYJBShR2mSNvzzrDR0QAQ/roNkgJ+nR1iedejRVF82FPrGxVr
	 uQHAzJjr2VWc/d3sJKK0IGIivaz2i32VXL99p2+YGw9NRxFJcs0oAhB8qTZVz2z6pN7Ys
	 sbj5txDENM/3D3aKFovS4AYdL6ppIRxpsWW+/S4QQMfB80tNMFAeHc3g3RnTG290lFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FHaXRPFtsd+1jvySK6Dtsu2gEi1IHmdu3yBxwrF9kVk=;
	b=kfCxS3pLWukhthPG2ggg+CGsqDeU1UIUtXP7F+dOGxUzCvUDnN2JwQzSMDMtIIeeEU8F
	 4Fg2/qqOgaSQdrKlnYiGsBU7vj/2/M2rBgA6OC8VaLb84w1VNWcwSYuZhFM4K/KCKfxuu
	 xODOgQ5kJQ0Wz0sGz/1zWD2bu7+Xao4G3aWYAnkBLzVtsN0XJ+vXfirTO/UGZKvgZIyj5
	 zZJKxwRdMuA4S2Qu7ot2vlQ78E6iCmgbM0AF4YlEPU4BeJQJgKltUuEt76Rr4RgLPvJMp
	 2TJYeUzoP3M9f4GK8/XPSop0Lue28DVNTZ5DQ+wraDzpyc6TQljGAdAIS5O7XXMFN5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MxLf7bol;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B9606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A53B9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MxLf7bol
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso165846a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755504; x=1794360304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHaXRPFtsd+1jvySK6Dtsu2gEi1IHmdu3yBxwrF9kVk=;
        b=MxLf7bolCrtPRMOprazoXrVTAc2vvoaCcbFMW16dHOXDLaWFIMWQY4PeXAV1vrDRpf
         0f0b2mNxmK4TN7l7IcV3x94UdoWa9KKDOaP2xQuaSEB0zo1ee1Y9+h3HhCKefifKFraE
         UwPClymgF5z1lyCQT1IkqAHLwbTcOB9WLBQd9Hj0V+H9i0BuXOldpiSl0NZ5iE9RAu8/
         Cfg5fe5we/5eney5zi+YGJWMRw6ihbLvumltC+YstzoxC78xIvnU/ACi0a9ixpgDVVK0
         ZEm3CmXKAG1b9tKfZ1tnPhPK7Q+LvDyuhPvVFR9SyEp5zs4coNHLJZcYZ6EwKpdoA4My
         z/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755504; x=1794360304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FHaXRPFtsd+1jvySK6Dtsu2gEi1IHmdu3yBxwrF9kVk=;
        b=PTvPw96NsLTGXW7/5tm7scHx+kamgKilgcmeKnWucjg64W8nM0CgDengHCFZSAvgxW
         nQKtKf0cN7wzOCOdhql0dzRd60qUzTGEUACi2bgJhVEMfA/0RD/ezcTogPEXn6QiJc5L
         xxX4Fcbtf4Lp8KDMoz1sbtjbNnjxhhaU5Xo9fw0UGH8nsr/yGtczxTiDkJZcd0AEir+Q
         BpqdxvazXQLQsQXueDlzl9vwQr7pmPv+x7+cz4AT2mrjVAOxsWNtIROA85pOkZ8PPcnw
         lYOOGQ74oKf8/m6U+4jXk3+K4D5A81Lo1k414in23iff5hhHZblmveOAGGbaxRugfiTm
         1M5Q==
X-Gm-Message-State: APuU4Z+ZcxEvTFCSk/Jb6jLLUbodYquHX0ACtHosemoogeIhdnjtlgRY
	k+I8ZzlqNIXxEnwcJ7U/wHh+2RaVrFb0zEs5bsiWpo4pnYvV2kqYZb4YbQP6mg==
X-Gm-Gg: AYBFou2ZVvAFKyatOCzpJLi22NJP3r1+O4DWEdvADEUPj4DbT/c/LtP95ko5pH8MdK9
	4pd4K8VNW25Kvh6CwvDqzSK0Yn67mjXfQByEbf3ONFb2TCPYov8CUm3HGjxLOB8D5t6j8R/Cu1X
	p5EvuFCDBdjKzcU8LQf0Eg41LivnvVmh3XLa36Wio6vjU1Gb+tOHcgvpeEIPNQhp5OUdUGSGvsr
	iWwEDVnFmOLG3lVSluUi8gecUolU8JXAnAYXag77nBLL/XhvAyh9KSEBX2YUNscA6Klk3c+f6Ms
	z9t+ixOwQ02nv1wIQVueQsVtvH7zqbVzQMi5muOaTHP9qsXB3gpXiXkRz0FDxddKEDqzJG4+3nQ
	3duleU0bVDAFc3HemBhf1qZ5XhDvRePr4Zega/FI/tYm4I+3OQYMIFDhBfwHAOfNLhtc6kheS65
	J77mbsp7KvV+XTULL+1pwB6ECmNtozXHYur+RPwzgpf9DKjdLRjdRZcwf7WwLc4snSoa9hnMMkA
	vJKkjGD1ImCUcSQ8J3BhgNhP3dv0aVxDMcbMP7UEubaS3GycsKFgvrx8b2K/XQOXn88TcuZPPlR
	Q8ShDGQPP4C3lkHPeAPofkHJGU1X/jkb5h2rdf8kBZSjbf5KaUNwBlthzIQBdRTbCJQ/B8GD39b
	QW0QG/9p0Rby/XLGkCk7+xoJBTLtXe9pY7B4DjVXfvDPdevHiRvxbnXM/4LNNwbsYyCg1+LtVW7
	+VqzvuOguRBWnlm0zZtsA=
X-Received: by 2002:a17:90b:1b0f:b0:3ac:9ed8:f319 with SMTP id 98e67ed59e1d1-3ae8957d4dfmr12665646a91.2.1793755503685;
        Tue, 03 Nov 2026 17:25:03 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed0906ebedsm810235ad.31.2026.11.03.17.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:25:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 10/14] bpf, x86: Add BPF_ATOMIC_LOCAL
Date: Wed,  4 Nov 2026 01:23:56 +0000
Message-ID: <20261104012401.1354861-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
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
index 8ade87bd56e3..711d774b40e1 100644
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
@@ -5187,6 +5190,11 @@ bool bpf_jit_supports_private_stack(void)
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
index abc759ad14a6..7b730b6488ec 100644
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
 
@@ -1330,6 +1337,7 @@ bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 bool bpf_jit_supports_private_stack(void);
+bool bpf_jit_supports_local_atomics(void);
 bool bpf_jit_supports_large_stack(void);
 bool bpf_jit_supports_timed_may_goto(void);
 bool bpf_jit_supports_fsession(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 06d6d45b1c0e..1466a85c2b1a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3874,6 +3874,12 @@ bool __weak bpf_jit_supports_private_stack(void)
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

