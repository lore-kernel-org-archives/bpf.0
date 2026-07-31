Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6E47D93E
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524887; cv=none; b=Uqkdfyx2sdOnvIwWFheOOU9IfZaRVtIkDgcBGOX0h+GvETx4412NYbGoVlrI4qdF46V78NggUpyqK5svlH5/A3Df6IoM3b/31+aFY70/P2/Dhh7iq3JkmZxwzgR9iy0DGkDlGn8VHJZ+f7tU4GIYVWOiSIAwdiEfgmjgiBK2lUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524887; c=relaxed/simple;
	bh=GWT5JRS+4rQS+ZdDR6kC5f4iokFevpH3I1cQJqSypaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMlSY93pWq2XwiIhAxx0Bf3m33lhXPmbsc4aLJCe3GYTPar2cs+lRVTdXaC9+npBhaxwnf9wW+CG/Dn2mEwAJJY7p/Iw88OIQAU1Z2LVrsagKBz6OwSYqpEQo9WCT0o65LFcfrlFpz/JuDFX+ziSuLPnI5cYaZUsQCf37Dr8OFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYgu3LZa; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYgu3LZa"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1017556a91.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785524885; x=1786129685; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D7lp3705JhIGed1UbCeXXSiKLisnmzcNFNx5uIsNtrU=;
        b=RYgu3LZa48BjGh+fOBYHtS05wvNajN4Q3ikNjFICfjSMp7hBl3LPHG4K2CtqdNKUna
         Lk9iWxYZlw0GCTatBiPx73DrQOPG4Jp17JYri5wMMmjNdE6oPvwaIBGjYhO+/YSTivG/
         ADYxcdcvszmzvAlCR+2/zNrYnZeNsHBFQyiIZLvvwXtCJeRhwpEB70BiTsxYtu+5rkY5
         /q1mG1S+2ayz72tYTzEUbmVgVZB4my+kHSwF7u7Oyl3LnuWwruBL2D+9Sca56ysqr+c5
         HphOrqcMAFmVi7Ijcgir5IO0xqeLdWC7yiBu0UdoDyyWqsoUGwCGwuw5mx7xrAjFwu0e
         8fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785524885; x=1786129685;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D7lp3705JhIGed1UbCeXXSiKLisnmzcNFNx5uIsNtrU=;
        b=CKJpcPVKxIBj+r90Wy98pfm3NjcJzsygowiWQXCDwzRm8LIIPRHDxgOdmyVBPMnLWv
         MxsoFMsCfhjdrXuVLdyXk/cqjrggUYDiJ5ZxxYWrhagXVweD1UPb1JmD8iW0CW5Kvtpb
         2H9Z5J3RrMBB4xdD8y4ohJzcIlmV+QG+CKdag/zRPv8iUS3PozAWKoVnjB74pp+nsg9V
         G6MKbrKpYQ1+iLM9Sq2j627A/D8FTzLDt9SPhm4D56zI5Fvj3zhgVr5QKY2qkq1d+YwG
         Ma4wH1hRLrYuEjmDyyDpifKaP6NTCjfENgcj8M19foj2fRnJ5IUOkYAUE0IYp6pTiLwm
         OLkg==
X-Gm-Message-State: AOJu0YyLfcnbuVSV4hLbKS8SWLf9laXHx5j+aThvlq5kAFtSkgKMY0UQ
	98lqLgeNnhQ54Y8TR6Cp0vg95/9YILWaz8hoT4odWgYba5LwQpAsYfjcFhg88MlI
X-Gm-Gg: AR+sD10+cul6tY6enhuMqJgamJdY6URuYJnJjnRSt7GQIWe6Ip4z/M2ZV0+7rQKjYD0
	5HLt3siZcCwIpZikU1MMqSaYUP266aJq8P4MBZwqdboKl6h33s851U8Ne7/Mx/8k/s3L83iYYtR
	R18kg2kuSpBIflX9mWpBZfrOWtEdmAHrnDvekwTqljqzxnCpqORv6RzoS9+2RfcLN41gVMmqZrv
	Gihrjvf9NsOqNiBbarVlD/0qTjWTjGulxpqj3TQay52r58OZWI6UJyhNqWsw1/RB49wEnuH+h7l
	Wvro9LjcJFNxVnPBbfcrpgjMNxcCuiAiuqMm3vJxV+OJTFQEiIHjq9UD+OrNkV5SFzBiyqjPFf4
	x2/qK3ublKGvbjZDQgRGl83ktmd330bEFq/NF3XGCm8vs7elZkFI6z1WbKb0L2p/5b5zhdceA+g
	ZZBQWAXDBNWJopMr4hMsfAXCpDHw7TEufcSzHppb/CVh3RYXSz8Pf373PgZqjIj+cmG26NY5DI+
	pkcnYJ6k0wM2tnmjcBteN4qDLN4xdQOpHF/etijfxzJ
X-Received: by 2002:a17:90b:3802:b0:38f:1e1a:5163 with SMTP id 98e67ed59e1d1-38fbc51615cmr765325a91.31.1785524884624;
        Fri, 31 Jul 2026 12:08:04 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:7346])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab13255esm4815801c88.3.2026.07.31.12.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:08:04 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	iii@linux.ibm.com,
	gimm78064@gmail.com
Subject: [PATCH bpf-next 5/5] selftests/bpf: verify zext_dst annotations for various instructions
Date: Fri, 31 Jul 2026 12:07:46 -0700
Message-ID: <20260731-static-zext-v1-5-98a4dc73e94b@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
References: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Includes the following test cases:
- a test showing that zero extension flags do not propagate through
  state pruning in the unpatched kernel.
- a 32-bit ALU result read as 64-bit (zext) and read only as 32-bit
  (no zext);
- a 64-bit MOV (never zext'ed);
- a narrow (32-bit) BPF_LDX load whose result is read as 64-bit;
- 32-bit atomic fetch_add and cmpxchg whose result is read as 64-bit;
- a CFG case where a 32-bit definition's upper half is used only on one
  of two branches;
- no zext for dead registers;
- LD_ABS defines only lower 32 bits, hence needs zext when the result
  is used as 64-bits;
- Helper and subprogram parameters are considered to use full 64 bits;
- kfunc parameters are read according to their BTF type width.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c |   2 +
 tools/testing/selftests/bpf/progs/verifier_zext.c | 260 ++++++++++++++++++++++
 2 files changed, 262 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index be97f6887f0e..fba562c81969 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -124,6 +124,7 @@
 #include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
 #include "verifier_ctx_ptr_param.skel.h"
+#include "verifier_zext.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -277,6 +278,7 @@ void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
 void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
 void test_verifier_ctx_ptr_param(void)       { RUN(verifier_ctx_ptr_param); }
+void test_verifier_zext(void)                 { RUN_TESTS(verifier_zext); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_zext.c b/tools/testing/selftests/bpf/progs/verifier_zext.c
new file mode 100644
index 000000000000..b4c82a31e668
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_zext.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+SEC("socket")
+__flag(BPF_F_TEST_STATE_FREQ)
+__flag(BPF_F_TEST_RND_HI32)
+__success __retval(0)
+__naked void zext_lost_across_checkpoint(void)
+{
+	asm volatile ("									\
+	call %[bpf_ktime_get_ns];							\
+	r8 = r0;									\
+	r6 = 0xdeadbeefcafebabe ll;	/* inject some value for r6's upper half */	\
+	if r8 != 0 goto 1f;		/* fall-through cached first, branch pruned */	\
+	r6 = 32;			/* full 64-bit def */				\
+	goto 2f;									\
+1:											\
+	w6 = 32;			/* 32-bit def, zext mark lost */		\
+2:											\
+	r0 = r6;			/* buggy verifier believed upper 32 bits are 0 */ \
+					/* and thus did not zero extended w6 = 32. */	\
+	r0 >>= 32;									\
+	exit;										\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* 32-bit ALU result read as 64-bit -> zext */
+SEC("socket")
+__success __log_level(2)
+__msg("w1 = w0{{ +}}; zext")
+__naked void zext_alu32_hi_used(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* 32-bit ALU result read only as 32-bit -> no zext */
+SEC("socket")
+__success __log_level(2)
+__not_msg("w1 = w0{{.*}}; zext")
+__not_msg("w2 = w1{{.*}}; zext")
+__naked void no_zext_alu32_hi_unused(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	w2 = w1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* 64-bit definition is never zero extended */
+SEC("socket")
+__success __log_level(2)
+__not_msg("r1 = r0{{.*}}; zext")
+__naked void no_zext_mov64(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Narrow load result read as 64-bit -> zext */
+SEC("socket")
+__success __log_level(2)
+__msg("r1 = *(u32 *)(r10 -8){{ +}}; zext")
+__naked void zext_narrow_load_hi_used(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u64 *)(r10 - 8) = r0;				\
+	r1 = *(u32 *)(r10 - 8);				\
+	r0 = r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* 32-bit atomic fetch result read as 64-bit -> zext */
+SEC("socket")
+__success __log_level(2)
+__msg("r1 = atomic_fetch_add((u32 *)(r10 -8), r1){{ +}}; zext")
+__naked void zext_atomic_fetch32_hi_used(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	w1 = 1;						\
+	.8byte %[fetch_add32];				\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_insn(fetch_add32,
+		     BPF_ATOMIC_OP(BPF_W, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8))
+	: __clobber_all);
+}
+
+/* 32-bit atomic cmpxchg result (r0) read as 64-bit -> zext */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 = atomic_cmpxchg((u32 *)(r10 -8), r0, r1){{ +}}; zext")
+__naked void zext_cmpxchg32_hi_used(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	w0 = 0;						\
+	w1 = 1;						\
+	.8byte %[cmpxchg32];				\
+	r2 = r0;					\
+	r0 = r2;					\
+	exit;						\
+"	:
+	: __imm_insn(cmpxchg32,
+		     BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8))
+	: __clobber_all);
+}
+
+/* 32-bit def before a branch, upper half used on one branch -> zext */
+SEC("socket")
+__success __log_level(2)
+__msg("w6 = 32{{ +}}; zext")
+__naked void zext_cfg_hi_used_one_branch(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w6 = 32;					\
+	if r0 == 0 goto l0_%=;				\
+	r0 = r6;					\
+	exit;						\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* r1's upper half is dead, so 'w1 = 1' must NOT be marked for zero extension. */
+SEC("socket")
+__success __log_level(2)
+__not_msg("w1 = 1{{.*}}; zext")
+__naked void no_zext_other_reg_hi_used(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 <<= 32;					\
+	w1 = 1;						\
+	r0 = r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* LD_ABS defines r0; when r0 is read as 64-bit it must be zero extended */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 = *(u8 *)skb[0]{{.*}}; zext")
+__naked void zext_ld_abs_hi_used(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r0 = *(u8 *)skb[0];				\
+	r7 = r0;					\
+	r0 = r7;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* Helper parameters are read as 64-bit (call_use_mask() fallback) */
+SEC("socket")
+__success __log_level(2)
+__msg("w2 = 1{{ +}}; zext")
+__naked void helper_param_read_as_64bit(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -8;					\
+	w2 = 1;						\
+	call %[bpf_trace_printk];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_trace_printk)
+	: __clobber_all);
+}
+
+static __used __naked int subprog_reads_arg_as_64bit(void)
+{
+	asm volatile ("					\
+	r0 = r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* subprogram parameters are conservatively read as 64-bit */
+SEC("socket")
+__success __log_level(2)
+__msg("w1 = w0{{ +}}; zext")
+__naked void subprog_param_read_as_64bit(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	call subprog_reads_arg_as_64bit;		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
+
+/* Force kfunc extern BTF generation. */
+int __kfunc_btf_root(void)
+{
+	return bpf_kfunc_call_test4(0, 0, 0, 0);
+}
+
+/* kfunc parameters are read according to their BTF type width */
+SEC("tc")
+__success __log_level(2)
+__not_msg("w3 = 1{{.*}}; zext")		/* int c  -> read as 32-bit */
+__msg("w4 = 1{{ +}}; zext")		/* long d -> read as 64-bit */
+__naked void kfunc_param_read_per_btf(void)
+{
+	asm volatile ("					\
+	w1 = 1;						\
+	w2 = 1;						\
+	w3 = 1;						\
+	w4 = 1;						\
+	call bpf_kfunc_call_test4;			\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.55.0
