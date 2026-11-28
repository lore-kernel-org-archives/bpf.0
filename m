Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795829348;
	b=HZ8wPG1BK/JyTaKGV14SHLIPHaNzpqndqvAnP34jcKRZqyh4YhI0Q8Fy7HdvcveQ0HNL
	 LCJVN60d9bZUu81snUpZ4QZylTH7FcMCA2CSF7TH8Ylo5LuHdCOTOobGlyqaNcEub0RB8
	 +Rh9XyrONvqfOydYuIeUTc/tGW0W/xPwS7piIfdMcjrERdss5o3PGiB4KiNG8NdaZAsPe
	 WpOCgB/oQZdqzNBikUVRfwQLiPKTo6KLKqYOHsk3q7byjy6GThD+NVjTdwz6UM5Oxpm/h
	 a9XZs7f+HrPZ1lCXT1zcI31ZsYIVAnohOwq/+MaUBIJwBMtsVV29o3rvG1iqdiOb6bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795829348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=IM6eW0BBm2PQLn/N6nku5FABXn86B98F3TZ86teZNtw=;
	b=0CI/4taeIb/S1WbA5uYirHdlWX5xTHAUP7WaAEMtMi33/rDGA61IJSfBQyWVFCIEN8yv
	 bkVmVneBuznYsYlx2Sj+noteSUHTiZDK5hDSVCvt63XJoef1DU0qEj9rQVw2QlX/iZBCS
	 cED/MrI6q7JV75yT8yc3AE6rPHsQqa23lFhSpVIMyCaQrcF7BrII4x7Rxdvh4Q+2qmtzD
	 8ZUrIJ/MfP/Y/OccC9YdlYVdFFgrbNr+8nGd7UKOr/0cAdxeXpetAWgXyd36d93f6JZyU
	 GQBirMqfYr/HQhpgC2seRGEyI5K1kqgQUPnO4F9ytiB0hunArxp3Ur6Jr6n1qJ/bKxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dY6WX8jK;
	arc=none smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B2B606A324
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 01:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0B2B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dY6WX8jK
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-51cddc2451aso2406885b6e.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 17:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795829346; x=1796434146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IM6eW0BBm2PQLn/N6nku5FABXn86B98F3TZ86teZNtw=;
        b=dY6WX8jKDtVRKjMNtTwQX1qqObS3X0uF7WP8MOqsZswAwO7UaMrR5WDIt4WF78MTYa
         S1zhWOxqAH5Mx56yYHuPjOGWN1BSZlTnxJwXZ1J28DCCyrTm9H7oB7Rdxy5F3t/y0q1a
         Rs8Hvx9Ym1IC5tc1hM80wL/pHJVzDLswQyeP1GRFS7CICgoTf3SjxalnQ5UU835+x6A4
         eh0SwkZtUuuee57RSpDMeKhEb+geOsA8zFaBJb7wbSU4foaPVGwfcbFecx3xB6gkQ9sP
         Cw0miMkg8ZxrkphU4RX3ytSMLLmGxhH4UFJB+ItTnLi02WDBIKsXeMnWsbExYf15EivT
         cFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795829346; x=1796434146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IM6eW0BBm2PQLn/N6nku5FABXn86B98F3TZ86teZNtw=;
        b=sw0KmkgXixZSlKmTWww26D4OdJ+kZCU/+9W2MO2twfPBbPQ3sfxDqzAIWFe7pfoS4W
         bPAu7AwW3I5USOYsq7h3W4srgW5CP0cVPs8Y2yE//JUapWsP9A5twT6sX0zHeBmtqZji
         wHbuHZihQYnmFp7+KAmkD3+YC09WPOsGbqDQfjhEhj754OQpSPexraUuDbJ24YGBBBvQ
         BKKaapwN8qbc93hroWLZaHIxRX7/qs4vx7vvQghnMxjJ2LLlvi9G/aJqtMdgIcxKfAsR
         0jGtltp2DrPih5iOXGbaPs36auwq6oW2RWMGxCm9UJryHWEwqDait6RPntKWkTm6pS5N
         lpOw==
X-Gm-Message-State: APuU4Z/RTIBB8oAQ7sWSMNvaqgTgYzVNd91bG9Hv8iLWMiak0l2/BzW2
	ANphtyEKZkDumj+clQS/7stvEzj/c4M7vgv97kgL/eycgvwrk5k4CiBqbAxrjDCYIN8=
X-Gm-Gg: AZFdTZcSqKpbxa4Vfv+HUfKD+aemLxoo/OHKi7FLWZuRQ8Am/JiPZZdxsdqZ9a/USAa
	TtgIqHRZtR53Z7dVT+Ysm+5T+e+UBWX+nQe2x5Fl6Od9YqEswuhMQYy/B0C0j+V4s7pT63lxfuV
	b0zP2318qmpCHFPFBv+Hhmv8SCsriRKsncA4JuPuxq5kVsCf8raoAv+3s5ccZz4LHwC0DEDnvSQ
	nJFalQh7ZqKlu28Nyu9Y8a6xDflpzL5xsSiXMHpVuXrJ7ThgKDQwvn/hiA9+0Q/zjKNhBbHNY+W
	ZhCzSeIpVwgJZO1w/MV06KQrMEwLKBBVWf6jdZzoRZACMjUSrVV+x7SOKCdBNSJNNY/BV1r8p82
	MYA2Cb3gOLEbH7cR5qyElvm95JoCFeinuacTDCTYWHkqbm1XxAXttKji63yOcZpyfGhwxqJYrrY
	ZTIEqlQaRcCZWeXeI5v8g+6UJg9JTiSqjug/dRUZpPxhBky5eJ0Vc9zjSlyFiy26by+7nKrOFwb
	LrI9wDvfxJkhj44vZfRLnu1AGwLY0ne54vV+DXOeJpymR/dmDmd+S/ZwFQKKN3qhLtBgelPszOE
	re2/HA/5k1iwiTOxClmqGr/XzgasDSiJJ/si/SakYTXFOA4vr9hF1LR6NNyFmc1SihIX7ADu6Dx
	dOghhktSakLLP7b0ksof1JP8kVwWmwgT2WD7g
X-Received: by 2002:a05:6808:4f69:b0:4f4:73a9:f831 with SMTP id 5614622812f47-57a09604a59mr32038889b6e.19.1795829345791;
        Fri, 27 Nov 2026 17:29:05 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35e5ab03sm19383582b6e.16.2026.11.27.17.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 17:29:04 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Puranjay Mohan <puranjay@kernel.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/3] bpf, x86: Skip the PROBE_MEM address range check under SMAP
Date: Sat, 28 Nov 2026 02:28:55 +0100
Message-ID: <f2beca95aa1eb81f00c6baf408c681063e13ce83.1795829324.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <cover.1795829324.git.memxor@gmail.com>
References: <cover.1795829324.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9160; h=from:subject:message-id; bh=//norLMqOmoX+p1XEt+gIWjYbaPJRxI7a4s6bZF59LE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtLz7d93Z2Nn2/UJSoyPn2nvqJ5XUveurrXpyor5IJiJI8f bSjqKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQ+X2T4n9yxrvtn+KGQsrPbLwc+qX /4P+B1d3HQ2+9LQ+3vHN46fRkjw0c5kQK96KQex/rLLW5M3Xv4DC7MvDf169u38YtMDqpJswAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The x86 JIT puts a range check in front of every PROBE_MEM load to keep
user addresses, the guard page above them and the vsyscall page away from
it. A fault on a user or vsyscall address used to oops under SMAP instead
of using the load's exception table entry. The check is five instructions
(lea, shr, jne, xor, jmp) and 17 or 18 bytes, for a load of three to eight
bytes.

do_user_addr_fault() now fixes up such a fault when the faulting
instruction has an EX_TYPE_BPF exception table entry. With LASS the access
raises #GP, which exc_general_protection() has always fixed up. So emit the
bare load when SMAP is enabled. The feature cannot change after boot, so it
is checked at JIT time. Kernels without SMAP, including those booted with
clearcpuid=smap, keep the check. bpf_arch_uaddress_limit() still returns 0
on x86, so the verifier adds no check of its own.

Programs loaded without CAP_BPF keep the check too. The fault handler finds
a program's exception table through the BPF ksym tree, and
bpf_prog_kallsyms_add() leaves such programs out of it. They can still have
PROBE_MEM loads: with kernel.unprivileged_bpf_disabled=0, a socket filter
loaded with only CAP_PERFMON can call bpf_skc_to_tcp_sock() and walk
pointers from the result. bpf_prog_load() now records whether the loader
had CAP_BPF, and the new bpf_prog_kallsyms_allowed() gives that answer to
both the JIT and bpf_prog_kallsyms_add().

JITed code size from veristat, on one kernel booted with and without
clearcpuid=smap, over the BPF selftests and 474 production objects from
Meta:

                        programs  with PROBE_MEM  reduction per program
                                                  mean  median    max
  BPF selftests             5486             100  20.2%  19.9%  58.2%
  Meta production programs  1942             262   3.5%   0.8%  51.4%

No program grows; dump_tcp6 of the selftests shrinks from 3142 to 2129
bytes. Most programs are unchanged, because loads through trusted pointers
and the probe_read helpers do not use PROBE_MEM.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 33 +++++++++++++++++++++++++++------
 include/linux/bpf.h         |  1 +
 include/linux/filter.h      |  1 +
 kernel/bpf/core.c           | 16 ++++++++++++++--
 kernel/bpf/syscall.c        |  1 +
 5 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d51ae52fef71..019e5da72136 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -299,6 +299,9 @@ struct jit_context {
 	 */
 	int tail_call_direct_label;
 	int tail_call_indirect_label;
+
+	/* Emit the address range check in front of PROBE_MEM loads */
+	bool probe_mem_check;
 };
 
 /* Maximum number of bytes emitted while JITing one eBPF insn */
@@ -2547,6 +2550,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		const s32 imm32 = insn->imm;
 		u32 dst_reg = insn->dst_reg;
 		u32 src_reg = insn->src_reg;
+		bool probe_mem, bounds_check;
 		bool accesses_stack_only;
 		u8 b3 = 0;
 		u8 *start_of_ldx;
@@ -3091,6 +3095,9 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
+			probe_mem = BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+				    BPF_MODE(insn->code) == BPF_PROBE_MEMSX;
+			bounds_check = probe_mem && ctx->probe_mem_check;
 			insn_off = insn->off;
 			if (src_reg == BPF_REG_PARAMS) {
 				if (insn_off == 8 && !arena_sp) {
@@ -3108,8 +3115,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				 */
 			}
 
-			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
-			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
+			if (bounds_check) {
 				/* Conservatively check that src_reg + insn->off is a kernel address:
 				 *   src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
 				 *   and
@@ -3150,6 +3156,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				/* populate jmp_offset for JNE above to jump to start_of_ldx */
 				start_of_ldx = prog;
 				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
+			} else if (probe_mem) {
+				start_of_ldx = prog;
 			} else if (!accesses_stack_only) {
 				err = emit_kasan_check(env, &prog, src_reg,
 						       insn_off,
@@ -3163,14 +3171,14 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				emit_ldsx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
 			else
 				emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
-			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
-			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
+			if (probe_mem) {
 				struct exception_table_entry *ex;
 				u8 *_insn = image + proglen + (start_of_ldx - temp);
 				s64 delta;
 
 				/* populate jmp_offset for JMP above */
-				start_of_ldx[-1] = prog - start_of_ldx;
+				if (bounds_check)
+					start_of_ldx[-1] = prog - start_of_ldx;
 
 				if (!bpf_prog->aux->extable)
 					break;
@@ -4862,6 +4870,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		addrs[i] = proglen;
 	}
 	ctx.cleanup_addr = proglen;
+	/*
+	 * With SMAP enabled, a PROBE_MEM load of a user address faults (#PF, or
+	 * #GP with LASS) and the fault handler resolves the exception table
+	 * entry of the program, as for an unmapped kernel address. That lookup
+	 * only finds programs in the BPF ksym tree, so programs loaded without
+	 * CAP_BPF keep the address range check, as do kernels without SMAP.
+	 */
+	ctx.probe_mem_check = !cpu_feature_enabled(X86_FEATURE_SMAP) ||
+			      !bpf_prog_kallsyms_allowed(prog);
 skip_init_addrs:
 
 	/*
@@ -5204,7 +5221,11 @@ bool bpf_jit_supports_ptr_xchg(void)
 	return true;
 }
 
-/* x86-64 JIT emits its own code to filter user addresses so return 0 here */
+/*
+ * The x86-64 JIT keeps user addresses away from PROBE_MEM loads itself, with
+ * its own range check or by leaving the access to SMAP and the fault handler
+ * (see bpf_int_jit_compile()), so return 0 here.
+ */
 u64 bpf_arch_uaddress_limit(void)
 {
 	return 0;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c7996515a03d..bce1da58f96a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1924,6 +1924,7 @@ struct bpf_prog_aux {
 	enum bpf_attach_type saved_dst_attach_type;
 	bool verifier_zext; /* Zero extensions has been inserted by verifier. */
 	bool dev_bound; /* Program is bound to the netdev. */
+	bool bpf_capable; /* Program was loaded with CAP_BPF. */
 	bool offload_requested; /* Program is bound and offloaded to the netdev. */
 	bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
 	bool attach_tracing_prog; /* true if tracing another tracing program */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 61448be53f8d..eb6d38233ea7 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1676,6 +1676,7 @@ int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		    char *sym);
 struct bpf_prog *bpf_prog_ksym_find(unsigned long addr);
 
+bool bpf_prog_kallsyms_allowed(const struct bpf_prog *fp);
 void bpf_prog_kallsyms_add(struct bpf_prog *fp);
 void bpf_prog_kallsyms_del(struct bpf_prog *fp);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 20765ec22395..7f35d6403ded 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -952,10 +952,22 @@ static bool bpf_prog_kallsyms_candidate(const struct bpf_prog *fp)
 	return fp->jited && !bpf_prog_was_classic(fp);
 }
 
+/*
+ * Programs loaded without CAP_BPF are kept out of the BPF ksym tree, so
+ * search_bpf_extables() does not find their exception tables. A JIT that
+ * relies on the exception table to recover from a faulting PROBE_MEM load needs
+ * this answer at JIT time, before bpf_prog_kallsyms_add() runs. Both get the
+ * answer that bpf_prog_load() recorded, so they cannot disagree, and the JIT
+ * makes no capability check of its own.
+ */
+bool bpf_prog_kallsyms_allowed(const struct bpf_prog *fp)
+{
+	return fp->aux->main_prog_aux->bpf_capable;
+}
+
 void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 {
-	if (!bpf_prog_kallsyms_candidate(fp) ||
-	    !bpf_token_capable(fp->aux->token, CAP_BPF))
+	if (!bpf_prog_kallsyms_candidate(fp) || !bpf_prog_kallsyms_allowed(fp))
 		return;
 
 	bpf_prog_ksym_set_addr(fp);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f07a0aa5ed40..de8ce2b00e2f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3102,6 +3102,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
 	/* move token into prog->aux, reuse taken refcnt */
 	prog->aux->token = token;
 	token = NULL;
+	prog->aux->bpf_capable = bpf_cap;
 
 	prog->aux->user = get_current_user();
 	prog->len = attr->insn_cnt;
-- 
2.53.1-Meta

