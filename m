Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB930216D
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 05:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215752; cv=none; b=bkohQSXanwxEDy7e8UGlO+be8Zm434m/1768+ioW6je8ssUx4AqNM0exMGUBEGNsoR0vmnCA9SIDjaUn3VfAkNQpJKCPWyZZvcvGhJs+alBQEOblQLoCquxVE6FouiY+SwPk9QyTn7yH+yGvNLPoj3f5WppFwSzpsqT21vAt+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215752; c=relaxed/simple;
	bh=nCjIsOm3mmjUF5fBX2oEjZIenz4izZMTjuSyY+5/Kyc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=imiuGpTxetffeBUadSH9DWBOJEskYAk1zYVNTgNskrAfChkJpYkm540SblKcfvliv9HBWunwMhzudhNEpxmoq4nSf+MR1nap6nNkb8CkX0Pm8heVWKjKBOGO5rp3UGN6MyrvMrAMy3RI0HWd0XpjmJmwx4+n2vLeTcaqpXgOLcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK6n1+sV; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK6n1+sV"
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2e7c8213b09so1460255ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 22:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792215750; x=1792820550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bqvzd0EtSU1MuMHqnmCtapUEFftK+rcumRTki2DPCdo=;
        b=lK6n1+sVd8E47T1B8x+qYtD9xpXGcOJZ9ZYVhTwjHBO7QgAMvhf50y4E3GrI0qfgRt
         57MFvIGvy3n/G1li9nzp4aFJrONqSMjCZ8cTA7CWPKfkkao7B9RuHMAQtpMHsa7COc2H
         UKkKXb4GI96hPOTU8zN25UFDxnG+G+lUv0cojAN0SvR7OtcXK/wON5x1Jk6XQUmXXz6v
         yrVOyH9U4T3QkMGurzVINfDAsYWVVn8A+eOJ/KiAqUqjTYnG8sctYainoXPanJpKfwrL
         NZpFz1BBGHze7nac8Ax0N/C3Aysq0y43SzYr7Ez5mRNIx+Thtv6RmUybj0fMAjAEA6uR
         deIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792215750; x=1792820550;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bqvzd0EtSU1MuMHqnmCtapUEFftK+rcumRTki2DPCdo=;
        b=CWHq/TP6Ose0iGL6wy1sK+AI6hsCRyjcrAWGr0+GqXsMeXuY2wOo0gbW5fltyYxthT
         ZUq8I8HJRDFnMqqpAgKZWSXMydaS4IS8N3VuOh+aIrbFpIBtOdaoB28IJJ/111Kc3Lf7
         afGUspJeYqWsPSUGjv4wtxYSzkhLjlzyEayXl9w/1DqPFtSVnjwuL3k/yJbNxFjjDCZD
         IdTdzeXVcS7AMzzS93biAASBqDY2JLzYTT0msYNogfs4ACKQmDi86YQ15oBAazgkdYah
         soOaqn09UXKsxNxorwsuqbXIKZKZ6nmPlwKuUhJ9x/l/v0ZWYxVg+vbFiO//bqlD+dE0
         Q6mQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOa4ywdQgO9pNhpiEMDTkNPqA+w0Iq4Jx47k91iuIvBEczBKyUX2tnuGsZqpmdu5PcOEQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5s45uGH63J3G4qavRyGM1MAAz8i5kziLFxEsuP2yJsGOdu/Hk
	vEiJxxHq5EbU3IBX/7yFzKBU+yVUF6MP5oGwxifTuBSFPRDE9mEt+4cWfQpYR+Nv
X-Gm-Gg: AYBFou24kKeHixCHzk/Xn+xk8w8DpycG667qfYldufw4vpr7O5PFxxn+MyqhKikUT06
	nDLBe7YqstMBPgakRNslVEC6R3NnoBZ7KGQcN1do3ZJn3ceJuFEhwowuJJfNmAx6zyckn+0+9q1
	A0iBqvjAYapSMeTjWgteYXyDWm6xSIhvYRI8vnW1+TvYrkZ5vAmJgqCoRj/FUaugUenIA60GkMr
	mvpm7ams14YSGHroP5StyaIJEB0R7VdmmAKqhCkk9MXvVJ5IrlG0vuV5BXYWWmZ2W0FZZKgKMsJ
	mXaf8igHNWJYVDdh7KabJHt38bwNiPpeYEKocOp1ajQI5Dod8xahLKxPXnX6KBMfXqaOTA28xmx
	0BDdsvtCRBods219fdT0Tl4s5fidav6DWamKvCOSNzklbeWb5zGkmiI/8ZWpALrIpObkYALFB30
	p3p2Of3Vz9ZWqeI39pKn3JpuPqDl/ZaRscrXQ4fbKYnhfMBq9eNtIiAKNSsjdqTEDVHAZGQ86Qu
	GMoJwCzuUyFFMw=
X-Received: by 2002:a17:902:e748:b0:2e9:a782:bb82 with SMTP id d9443c01a7336-2e9a782bbb5mr17403665ad.54.1792215750106;
        Fri, 16 Oct 2026 22:42:30 -0700 (PDT)
Received: from localhost.localdomain ([123.109.188.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b205fsm19147055ad.72.2026.10.16.22.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:42:29 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: random6.xyz@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf] bpf: Zero-extend the index in inlined bpf_get_func_arg()
Date: Sat, 17 Oct 2026 14:42:24 +0900
Message-ID: <179221432098.1890560.17043109037413683447.get-func-arg-index@gmail.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_get_func_arg() takes a u32 index, but the inlined expansion compares
only the low 32 bits of R2 with the argument count and then shifts the
full 64-bit register to compute the context address. R2 is ARG_ANYTHING,
so nothing guarantees that its upper bits are zero: an index of
1ULL << 32 passes the bounds check as index zero while the load is
performed at ctx + (1ULL << 35).

Zero-extend R2 to the u32 index the helper takes, which is what the C
implementation does; that path is still reachable because LSM programs
with BPF_LSM_MAC are not inlined. Widening the comparison instead would
reject indices whose low 32 bits are valid. Since the check is 32-bit,
this cannot change which programs are accepted, only the address.

Extend the existing fexit and tp_btf tests with a 64-bit helper
prototype so the upper index bits reach the expansion.

Assisted-by: LLM
Fixes: f92c1e183604 ("bpf: Add get_func_[arg|ret|arg_cnt] helpers")
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
Validation:
  - Built the modified objects and both affected test programs.
  - Disposable x86_64 QEMU guest, clang-22 kernel with BTF, tracing and
    bpf_testmod: both tests pass (2/0 PASSED, 0 SKIPPED, 0 FAILED) and
    the guest dmesg is clean.
  - Same tests on unpatched ff47652a4b66: the wide index faults in the
    inline sequence and the guest panics.

 kernel/bpf/fixups.c                                |  5 +++
 .../selftests/bpf/progs/get_func_args_test.c       | 36 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index d6f83521fc78e6c6a82d1969662f1eb52f64f4c3..005ed9279ebab60a8a774c4e6937232ab4f38962 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2255,6 +2255,11 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
 				cnt = 2;
 			}
+			/*
+			 * The helper takes a u32 index; zero-extend it before
+			 * the bounds check and the 64-bit address math below.
+			 */
+			insn_buf[cnt++] = BPF_MOV32_REG(BPF_REG_2, BPF_REG_2);
 			insn_buf[cnt++] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
 			insn_buf[cnt++] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
 			insn_buf[cnt++] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 1bf47f64d0967a3543739841201b58b14b4036a7..9b0beb58d88d5bcf1a36a0598695fd02a2cebbcf 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -6,6 +6,40 @@
 
 char _license[] SEC("license") = "GPL";
 
+/* Keep the upper index bits: the inlined expansion must truncate them. */
+static long (*bpf_get_func_arg_wide)(void *ctx, __u64 n, __u64 *value) =
+	(void *)BPF_FUNC_get_func_arg;
+
+/* Both traced functions are called with arguments 2 and 3. */
+static __always_inline int check_wide_index(void *ctx)
+{
+	__u64 a = 0, z = 0xdeadbeefdeadbeefULL;
+	__s64 err;
+	int ok = 1;
+
+	/* The index is truncated to u32, so these select arguments 0 and 1. */
+	err = bpf_get_func_arg_wide(ctx, 1ULL << 32, &a);
+	ok &= err == 0 && ((int)a == 2);
+	err = bpf_get_func_arg_wide(ctx, (1ULL << 32) | 1, &a);
+	ok &= err == 0 && a == 3;
+	err = bpf_get_func_arg_wide(ctx, 1ULL << 59, &a);
+	ok &= err == 0 && ((int)a == 2);
+	err = bpf_get_func_arg_wide(ctx, (1ULL << 59) | 1, &a);
+	ok &= err == 0 && a == 3;
+
+	/* Out of range: -EINVAL and no store into the destination. */
+	err = bpf_get_func_arg_wide(ctx, (1ULL << 32) | 2, &z);
+	ok &= err == -EINVAL && z == 0xdeadbeefdeadbeefULL;
+	err = bpf_get_func_arg_wide(ctx, (1ULL << 32) | 0xffffffffULL, &z);
+	ok &= err == -EINVAL && z == 0xdeadbeefdeadbeefULL;
+	err = bpf_get_func_arg_wide(ctx, (1ULL << 59) | 2, &z);
+	ok &= err == -EINVAL && z == 0xdeadbeefdeadbeefULL;
+	err = bpf_get_func_arg_wide(ctx, (1ULL << 59) | 0xffffffffULL, &z);
+	ok &= err == -EINVAL && z == 0xdeadbeefdeadbeefULL;
+
+	return ok;
+}
+
 __u64 test1_result = 0;
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(test1)
@@ -63,6 +97,7 @@ int BPF_PROG(test2)
 	/* return value */
 	err = bpf_get_func_ret(ctx, &ret);
 	test2_result &= err == 0 && ret == 5;
+	test2_result &= check_wide_index(ctx);
 	return 0;
 }
 
@@ -162,6 +197,7 @@ int BPF_PROG(tp_test2)
 	/* not valid argument */
 	err = bpf_get_func_arg(ctx, 2, &z);
 	test6_result &= err == -EINVAL;
+	test6_result &= check_wide_index(ctx);
 
 	return 0;
 }

base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
-- 
2.47.3
