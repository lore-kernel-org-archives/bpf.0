Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984004;
	b=UsQr09abaGwm8ec8qlDrcKyYeCN6YqAEbwESovTWHkfzxgLYY5zUu/Wd+NWXsYztTIRA
	 jAVev3Z4WexV0dYzXMFIsUNE0vd6chYjA8S3jQRMkvn/0Qb3sFLTG93QMHHmv5dIEcFbU
	 6mDBu2/SRmQS2kDCTe3YzP1l5lhTU0Bj1y4MVeMV3BoT6KhyCufTZTpmxoxyMAxpQ3b0R
	 eUQfLmzO6lCpuK0HV4mtWSSxCBnrelDEAiAyd380nlyZfDOebhKWe9Cn16H4Dpu9TWtVK
	 I/Z/LtcIYGvhdpCqsx/iD0cNXHofLoFFRzAsG3ycQ8Ysz1hHcJZfbZZ+rgPzas4Xmaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0wvPLFoi6zRgvQ72fZOEcbXZkmnCDppMCUncnb5l+YA=;
	b=S+H+sghU4Z8npRyI8HiToyeMyuLjnJpPRQVRFmbNb2iy9aEzA+IY54pK2b1qCcNlU+fI
	 1hUu4cfeCRP095Ddus7TPjBzOBAzZeqxOFd+/682r6GJzKYz3/xRYPN4HOGlWiGMQrtWe
	 BnfVCaUWKWb7fEfwULNbDHPcG0Up3SpFYQBj0fmJNrCySdJQL/RLDgFEK+x903Nd1L1BQ
	 SxsjXD23z8prCC52IfYHh+ZGeNBxda0DRugDotn0yrhyKx9xWbSP/7bOVncJcPHLdcTkR
	 21pkSOrY3hbOno+yQu/nED7ivkdIMo/3nCPwm2a6sBG/mzoZmbykvVcNDnpDrxKtL7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LKjFC8eI;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C73606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C73606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LKjFC8eI
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e942864693so13079685ad.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984003; x=1793588803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0wvPLFoi6zRgvQ72fZOEcbXZkmnCDppMCUncnb5l+YA=;
        b=LKjFC8eIfBH1sDIn7cJAsPQkF+4dUPTYEAK2iyh8wiAk7wq3SE7UCgKPPT2j3gZ8A2
         838tFJ/erZTKAsiquXXdpngO0by4d4z7xBUPz8xs5g3MKI2BUktMlnjDdZxJALiURzmK
         EQsFw75DRDhGnCoT8yWlPF3Rr6wWzbrIxDBB4KxdzrPyeNMx+t5cygkIa1+skE5enfXM
         KBRAngRjsBDZIPQy9iHm5ERLjxlIRlXhvuDneCHoeD9arVZ6rqxJMkPzXuH+WeQ/gHiQ
         bwYKhVGMhcBAYTpccoOVMwJK2kMuVy8DaHzYUL3cnRNGLhVgeajSSd1/GCkpa4RF2ju1
         GpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984003; x=1793588803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0wvPLFoi6zRgvQ72fZOEcbXZkmnCDppMCUncnb5l+YA=;
        b=NBiUh6nbYBf2j2Fhtl16FoXreqxbHIOryKkTqjmzQYrMPwaQtyxJr6mQDQ3maCs4DF
         nqcnwmfy03ZIsfr4nPoej1h1lROYzVu9xieKT21xDuZpbT9vLkfILwF/9wFNju+dOAH9
         rUEwZNPg6b6D90nxljc9q7QbYxfLL7hpFexQqcxm3tD8updKKaI8AqTycaEevzFFw7uG
         hpl/R/Lc51TqvoAMoLbHlSG3pLxjYG2zkY52sp4I2s1m97m6b3NkNnhpRx96TYgySFNJ
         fmveZDC3/D1N5wK0VY1UmJ5iPsiB7eZcEpQGxJjUXUtf37siUhpJHhn3FUaZvwm9PCi0
         OJPw==
X-Gm-Message-State: AFq9FYL0KWyDceBsgi1C7uIHLxj6OYed1duBcqiEl9TEFJbyoxuMH6uL
	gV8wFucwONW1p+3A7hGlp6JwhfG0HXMcix2BlmWzse5L81Rxy2GScIg/2ouJZA==
X-Gm-Gg: AYBFou2UJ1B68Xg7nTyauq8sjYZNzoDT5yyTVknDBg79O3JN3pUnlKk8P3nco5NkEnC
	7D+6E6v0ldaWWieaJRYJGsY/d59xb0LSvlC1qKvO+cKmVVAODuFBCGB1vgfrc2U+EbWfdsRnAmQ
	ViU/p6LZUgmTe5ohdSXDAWMOxJFn1lmExZQxKS58B1WRw3is+Y4GhfUvgs+uqu7bK3P5ulasHgT
	LDP/FWanhjd885G1tjg7nYShZxZFXFx9ERDGLIOagPata8HD3s+KLS6LqvrcfNcb3ITX8/R/EX6
	OgKfJDoBQREUZwEmrN+hrJtUBPlKmJ7uicMDLVmfFKn1KOapDGSnPdElTPtLw1596DAYgCoo+ZJ
	SSRSmenxADkhkHerTJpQ7rz5ZaUUuIjj5i8TY+/ILOh8j3v8R8oK0orrBtTAROB7ToBCkxVhGHz
	XviS0Nk9XiTuS9Ma8GMg/hA14N+/xcpqJv/Ub3PqbfLdT5B7puXj5hymsRwYtw/bZlKxWT+BzPg
	qnPyr7neLDwSaFeyUg//C6h18aI0YSe5HOzLVEfRojkzGD//W1sqHfpsDLp2FrfLB+plP7fmmXt
	5fDxsehX4g7QgIjpG/jZLVpGHPlvwJNfNVKZ3r7KDCj+b13+VPt+4iFipjEA3RobglllXmV6DBf
	2ClgAnt82xhj/NXFtuzVQsZsQ
X-Received: by 2002:a17:903:3c28:b0:2e8:795d:34f7 with SMTP id d9443c01a7336-2ea9c7cee78mr49195465ad.28.1792984002488;
        Sun, 25 Oct 2026 20:06:42 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b22416bsm10289715ad.72.2026.10.25.20.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:06:42 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 71/81] selftests/bpf: Adjust tests of linked registers and spills
Date: Mon, 26 Oct 2026 02:59:32 +0000
Message-ID: <20261026025943.404450-72-alexei.starovoitov@gmail.com>
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

After 'r1 = r0' the two scalars have the same id: they are linked. When a
jump limits the range of one register, the verifier gives the same range to
the other register. Most tests of linked registers did not match the
ranges. They matched "mark_precise:" lines, the log of precision tracking,
which marked linked registers together. "bpf: Remove precision tracking"
removed these lines.

Match the effect of the id: the range of each linked register after the
jump, and the id after the two branches meet.

    r0 &= 0xff
    r1 = r0
    r2 = r0
    if r1 > 7 goto +0    ; r0, r1 and r2 have id=1 and [0,7]
    r3 = r10             ; the branches meet: id=1 and [0,255]

In many other tests, for example the tests of spills, remove only the
"mark_precise:" lines.

The tests of stacksafe() and of ids in regsafe() let two states meet at an
insn. The result depends on which state arrives first. The verifier
followed each path, the fall-through path first. Now it verifies basic
blocks in a fixed order, and the target of a conditional jump is before the
fall-through.

     if r0 == 0 goto 1f
     ...                  ; makes state A
     goto 2f
  1: ...                  ; makes state B
  2: ...                  ; A and B meet

  arrives at 2    the verifier follows paths    basic blocks in order
  ------------    --------------------------    ---------------------
  first           A                             B
  second          B                             A

Swap the two branches to keep the sequence of a test.
ignore_unique_scalar_ids_cur and ignore_unique_scalar_ids_old swap their
names. When the first state covers the second state, the log shows
"from M to N: within", not "N: safe".

Two more differences are visible in the expected logs:
 - The verifier clears an id that only one live register has. Thus
   exceptions_assert.c does not expect "id=1".
 - In most cases the verifier verifies a static subprog without the frames
   of its callers. Thus a jump in the subprog does not change the linked
   registers of a caller. See precision_many_frames.

No expected verdict changes. The changed tests drop BPF_F_TEST_STATE_FREQ,
which has no effect without pruning.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/aggregate_ret_func.c  |  15 -
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |   7 -
 .../selftests/bpf/progs/exceptions_assert.c   |  24 +-
 .../selftests/bpf/progs/test_global_func15.c  |   5 -
 .../bpf/progs/verifier_mem_size_reg.c         |   8 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c | 313 +++++-------------
 .../selftests/bpf/progs/verifier_spill_fill.c | 218 ++++--------
 .../selftests/bpf/progs/verifier_var_off.c    |   3 -
 8 files changed, 165 insertions(+), 428 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
index f0077d951a25..2671323255cd 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_func.c
@@ -121,14 +121,6 @@ static __naked __noinline u128 static_agg_precise(void)
 SEC("tc")
 __load_if_JITed()
 __success __retval(0)
-__log_level(2)
-__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (57) r6 &= 7")
-__msg("mark_precise: frame0: regs=r6 stack= before 1: (bf) r6 = r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 12: (95) exit")
-__msg("mark_precise: frame1: regs=r2 stack= before 11: (b7) r2 = 4")
 __naked int aggregate_ret_static_precise(void)
 {
 	asm volatile (
@@ -150,13 +142,6 @@ __naked int aggregate_ret_static_precise(void)
 SEC("tc")
 __load_if_JITed()
 __success __retval(0)
-__log_level(2)
-__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (57) r6 &= 7")
-__msg("mark_precise: frame0: regs=r6 stack= before 1: (bf) r6 = r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 0: (85) call pc+9")
 __naked int aggregate_ret_global_precise(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
index 0361a7b42c9b..102156175ba0 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
@@ -31,13 +31,6 @@ SEC("tc")
 __arch_x86_64 __arch_arm64
 __load_if_JITed()
 __success __retval(0)
-__log_level(2)
-__msg("mark_precise: frame0: last_idx 7 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r6 stack= before 6: (07) r1 += -8")
-__msg("mark_precise: frame0: regs=r6 stack= before 5: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (57) r6 &= 7")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r6 = r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 2: (85) call bpf_kfunc_call_test_i128")
 __naked int aggregate_ret_kfunc_precise(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tools/testing/selftests/bpf/progs/exceptions_assert.c
index e4abf4172fca..67b51f728af2 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -29,32 +29,32 @@ check_assert(s64, ==, eq_llong_min, LLONG_MIN);
 __msg("R{{.}}=0x7fffffffffffffff")
 check_assert(s64, ==, eq_llong_max, LLONG_MAX);
 
-__msg("R{{.}}=scalar(id=1,smax=0x7ffffffe)")
+__msg("R{{.}}=scalar(smax=0x7ffffffe)")
 check_assert(s64, <, lt_pos, INT_MAX);
-__msg("R{{.}}=scalar(id=1,smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff))")
 check_assert(s64, <, lt_zero, 0);
-__msg("R{{.}}=scalar(id=1,smax=0xffffffff7fffffff")
+__msg("R{{.}}=scalar(smax=0xffffffff7fffffff")
 check_assert(s64, <, lt_neg, INT_MIN);
 
-__msg("R{{.}}=scalar(id=1,smax=0x7fffffff)")
+__msg("R{{.}}=scalar(smax=0x7fffffff)")
 check_assert(s64, <=, le_pos, INT_MAX);
-__msg("R{{.}}=scalar(id=1,smax=0)")
+__msg("R{{.}}=scalar(smax=0)")
 check_assert(s64, <=, le_zero, 0);
-__msg("R{{.}}=scalar(id=1,smax=0xffffffff80000000")
+__msg("R{{.}}=scalar(smax=0xffffffff80000000")
 check_assert(s64, <=, le_neg, INT_MIN);
 
-__msg("R{{.}}=scalar(id=1,smin=umin=0x80000000,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(smin=umin=0x80000000,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >, gt_pos, INT_MAX);
-__msg("R{{.}}=scalar(id=1,smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(smin=umin=1,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >, gt_zero, 0);
-__msg("R{{.}}=scalar(id=1,smin=0xffffffff80000001")
+__msg("R{{.}}=scalar(smin=0xffffffff80000001")
 check_assert(s64, >, gt_neg, INT_MIN);
 
-__msg("R{{.}}=scalar(id=1,smin=umin=0x7fffffff,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(smin=umin=0x7fffffff,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >=, ge_pos, INT_MAX);
-__msg("R{{.}}=scalar(id=1,smin=0,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
+__msg("R{{.}}=scalar(smin=0,umax=0x7fffffffffffffff,var_off=(0x0; 0x7fffffffffffffff))")
 check_assert(s64, >=, ge_zero, 0);
-__msg("R{{.}}=scalar(id=1,smin=0xffffffff80000000")
+__msg("R{{.}}=scalar(smin=0xffffffff80000000")
 check_assert(s64, >=, ge_neg, INT_MIN);
 
 SEC("?tc")
diff --git a/tools/testing/selftests/bpf/progs/test_global_func15.c b/tools/testing/selftests/bpf/progs/test_global_func15.c
index 201cc000b3f4..497f09dc8876 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func15.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
@@ -24,12 +24,7 @@ int global_func15(struct __sk_buff *skb)
 }
 
 SEC("cgroup_skb/ingress")
-__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
 __failure
-/* check that fallthrough code path marks r0 as precise */
-__msg("mark_precise: frame0: regs=r0 stack= before 2: (b7) r0 = 1")
-/* check that branch code path marks r0 as precise */
-__msg("mark_precise: frame0: regs=r0 stack= before 0: (85) call bpf_get_prandom_u32#7")
 __msg("At program exit the register R0 has ")
 __naked int global_func15_tricky_pruning(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
index 7e24706a764e..aba9510a1c08 100644
--- a/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
@@ -7,13 +7,9 @@
 
 char _license[] SEC("license") = "GPL";
 
-/*
- * The __szk size of a kfunc memory/size pair must be marked precise even when
- * the nullable buffer is passed as NULL.
- */
+/* The __szk size of a kfunc memory/size pair when the nullable buffer is passed as NULL */
 SEC("?tc")
-__success __log_level(2)
-__msg("mark_precise: frame0: regs=r4 stack= before")
+__success
 int dynptr_slice_null_buf_size_precise(struct __sk_buff *skb)
 {
 	struct bpf_dynptr dptr;
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 256547048cc4..92331e1a6c63 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -11,27 +11,21 @@ struct {
 	__type(value, long long);
 } map_hash_8b SEC(".maps");
 
-/* Check that precision marks propagate through scalar IDs.
- * Registers r{0,1,2} have the same scalar ID.
- * Range information is propagated for scalars sharing same ID.
- * Check that precision mark for r0 causes precision marks for r{1,2}
- * when range information is propagated for 'if <reg> <op> <const>' insn.
+/* scalar in [0, max] that shares id with other registers, as it is in the log */
+#define LINKED(id, max, mask) \
+	"scalar(id=" id ",smin=smin32=0,smax=umax=smax32=umax32=" #max ",var_off=(0x0; " #mask "))"
+#define ALONE(max, mask) \
+	"scalar(smin=smin32=0,smax=umax=smax32=umax32=" #max ",var_off=(0x0; " #mask "))"
+
+/* Registers r{0,1,2} have the same scalar ID.
+ * Range information is propagated for scalars sharing same ID
+ * for 'if <reg> <op> <const>' insn.
+ * The registers share the ID in the join of both branches too.
  */
 SEC("socket")
 __success __log_level(2)
-/* first 'if' branch */
-__msg("6: (0f) r3 += r0")
-__msg("frame0: regs=r0 stack= before 4: (25) if r1 > 0x7 goto pc+0")
-__msg("frame0: parent state regs=r0,r1,r2 stack=:")
-__msg("frame0: regs=r0,r1,r2 stack= before 3: (bf) r2 = r0")
-/* second 'if' branch */
-__msg("from 4 to 5: ")
-__msg("6: (0f) r3 += r0")
-__msg("frame0: regs=r0 stack= before 5: (bf) r3 = r10")
-__msg("frame0: regs=r0 stack= before 4: (25) if r1 > 0x7 goto pc+0")
-/* parent state already has r{0,1,2} as precise */
-__msg("frame0: parent state regs= stack=:")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("4: (25) if r1 > 0x7 goto pc+0         ; R0=" LINKED("1", 7, 0x7) " R1=" LINKED("1", 7, 0x7) " R2=" LINKED("1", 7, 0x7))
+__msg("5: R0=" LINKED("1", 255, 0xff) " R1=" LINKED("1", 255, 0xff) " R2=" LINKED("1", 255, 0xff))
 __naked void linked_regs_bpf_k(void)
 {
 	asm volatile (
@@ -42,9 +36,6 @@ __naked void linked_regs_bpf_k(void)
 	"r1 = r0;"
 	"r2 = r0;"
 	"if r1 > 7 goto +0;"
-	/* force r0 to be precise, this eventually marks r1 and r2 as
-	 * precise as well because of shared IDs
-	 */
 	"r3 = r10;"
 	"r3 += r0;"
 	/* Mark r1 and r2 as alive. */
@@ -57,16 +48,13 @@ __naked void linked_regs_bpf_k(void)
 	: __clobber_all);
 }
 
-/* Registers r{0,1,2} share same ID when 'if r1 > ...' insn is processed,
- * check that verifier marks r{1,2} as precise while backtracking
- * 'if r1 > ...' with r0 already marked.
+/* Registers r{0,1,2} share same ID when 'if r1 > r3' insn is processed,
+ * check that range information is propagated to all of them.
  */
 SEC("socket")
 __success __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("frame0: regs=r0 stack= before 5: (2d) if r1 > r3 goto pc+0")
-__msg("frame0: parent state regs=r0,r1,r2,r3 stack=:")
-__msg("frame0: regs=r0,r1,r2,r3 stack= before 4: (b7) r3 = 7")
+__msg("5: (2d) if r1 > r3 goto pc+0          ; R0=" LINKED("1", 7, 0x7) " R1=" LINKED("1", 7, 0x7) " R2=" LINKED("1", 7, 0x7))
+__msg("6: R0=" LINKED("1", 255, 0xff) " R1=" LINKED("1", 255, 0xff) " R2=" LINKED("1", 255, 0xff))
 __naked void linked_regs_bpf_x_src(void)
 {
 	asm volatile (
@@ -78,9 +66,6 @@ __naked void linked_regs_bpf_x_src(void)
 	"r2 = r0;"
 	"r3 = 7;"
 	"if r1 > r3 goto +0;"
-	/* force r0 to be precise, this eventually marks r1 and r2 as
-	 * precise as well because of shared IDs
-	 */
 	"r4 = r10;"
 	"r4 += r0;"
 	/* Mark r1 and r2 as alive. */
@@ -93,16 +78,11 @@ __naked void linked_regs_bpf_x_src(void)
 	: __clobber_all);
 }
 
-/* Registers r{0,1,2} share same ID when 'if r1 > r3' insn is processed,
- * check that verifier marks r{0,1,2} as precise while backtracking
- * 'if r1 > r3' with r3 already marked.
- */
+/* Same as linked_regs_bpf_x_src(), r3 is what is used after the jump. */
 SEC("socket")
 __success __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("frame0: regs=r3 stack= before 5: (2d) if r1 > r3 goto pc+0")
-__msg("frame0: parent state regs=r0,r1,r2,r3 stack=:")
-__msg("frame0: regs=r0,r1,r2,r3 stack= before 4: (b7) r3 = 7")
+__msg("5: (2d) if r1 > r3 goto pc+0          ; R0=" LINKED("1", 7, 0x7) " R1=" LINKED("1", 7, 0x7) " R2=" LINKED("1", 7, 0x7))
+__msg("7: (0f) r4 += r3                      ; R3=7 R4=fp7")
 __naked void linked_regs_bpf_x_dst(void)
 {
 	asm volatile (
@@ -114,9 +94,6 @@ __naked void linked_regs_bpf_x_dst(void)
 	"r2 = r0;"
 	"r3 = 7;"
 	"if r1 > r3 goto +0;"
-	/* force r0 to be precise, this eventually marks r1 and r2 as
-	 * precise as well because of shared IDs
-	 */
 	"r4 = r10;"
 	"r4 += r3;"
 	/* Mark r1 and r2 as alive. */
@@ -135,12 +112,9 @@ __naked void linked_regs_bpf_x_dst(void)
  */
 SEC("socket")
 __success __log_level(2)
-__msg("7: (0f) r3 += r0")
-__msg("frame0: regs=r0 stack= before 6: (bf) r3 = r10")
-__msg("frame0: parent state regs=r0 stack=:")
-__msg("frame0: regs=r0 stack= before 5: (25) if r0 > 0x7 goto pc+0")
-__msg("frame0: parent state regs=r0,r2 stack=:")
-__flag(BPF_F_TEST_STATE_FREQ)
+/* r1 is not there */
+__msg("5: (25) if r0 > 0x7 goto pc+0         ; R0=" LINKED("1", 7, 0x7) " R2=" LINKED("1", 7, 0x7) "{{$}}")
+__msg("8: (bf) r1 = r1                       ; R1=0")
 __naked void linked_regs_broken_link(void)
 {
 	asm volatile (
@@ -155,9 +129,6 @@ __naked void linked_regs_broken_link(void)
 	 */
 	"r1 = 0;"
 	"if r0 > 7 goto +0;"
-	/* force r0 to be precise,
-	 * this eventually marks r2 as precise because of shared IDs
-	 */
 	"r3 = r10;"
 	"r3 += r0;"
 	/* Mark r1 and r2 as alive. */
@@ -170,50 +141,15 @@ __naked void linked_regs_broken_link(void)
 	: __clobber_all);
 }
 
-/* Check that precision marks propagate through scalar IDs.
- * Use the same scalar ID in multiple stack frames, check that
- * precision information is propagated up the call stack.
+/* Use the same scalar ID in multiple stack frames. A static function is verified
+ * on its own: registers of the callers are not there when r1 is compared, so it has no ID.
+ * They share their IDs after the calls like before, if there is more than one left.
  */
 SEC("socket")
 __success __log_level(2)
-__msg("17: (0f) r2 += r1")
-/* Current state */
-__msg("frame2: last_idx 17 first_idx 14 subseq_idx -1 ")
-__msg("frame2: regs=r1 stack= before 16: (bf) r2 = r10")
-__msg("frame2: parent state regs=r1 stack=")
-__msg("frame1: parent state regs= stack=")
-__msg("frame0: parent state regs= stack=")
-/* Parent state */
-__msg("frame2: last_idx 13 first_idx 13 subseq_idx 14 ")
-__msg("frame2: regs=r1 stack= before 13: (25) if r1 > 0x7 goto pc+0")
-__msg("frame2: parent state regs=r1 stack=")
-/* frame1.r{6,7} are marked because mark_precise_scalar_ids()
- * looks for all registers with frame2.r1.id in the current state
- */
-__msg("frame1: parent state regs=r6,r7 stack=")
-__msg("frame0: parent state regs=r6 stack=")
-/* Parent state */
-__msg("frame2: last_idx 9 first_idx 9 subseq_idx 13")
-__msg("frame2: regs=r1 stack= before 9: (85) call pc+3")
-/* frame1.r1 is marked because of backtracking of call instruction */
-__msg("frame1: parent state regs=r1,r6,r7 stack=")
-__msg("frame0: parent state regs=r6 stack=")
-/* Parent state */
-__msg("frame1: last_idx 8 first_idx 7 subseq_idx 9")
-__msg("frame1: regs=r1,r6,r7 stack= before 8: (bf) r7 = r1")
-__msg("frame1: regs=r1,r6 stack= before 7: (bf) r6 = r1")
-__msg("frame1: parent state regs=r1 stack=")
-__msg("frame0: parent state regs=r6 stack=")
-/* Parent state */
-__msg("frame1: last_idx 4 first_idx 4 subseq_idx 7")
-__msg("frame1: regs=r1 stack= before 4: (85) call pc+2")
-__msg("frame0: parent state regs=r1,r6 stack=")
-/* Parent state */
-__msg("frame0: last_idx 3 first_idx 1 subseq_idx 4")
-__msg("frame0: regs=r1,r6 stack= before 3: (bf) r6 = r0")
-__msg("frame0: regs=r0,r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("13: (25) if r1 > 0x7 goto pc+0        ; R1=" ALONE(7, 0x7))
+__msg("10: R0=0 R6=scalar(id={{.*}}umax32=255,{{.*}} R7=scalar(id={{.*}}umax32=255,")
+__msg("5: R0=0 R6=" ALONE(255, 0xff))
 __naked void precision_many_frames(void)
 {
 	asm volatile (
@@ -254,11 +190,6 @@ void precision_many_frames__bar(void)
 	"if r1 > 7 goto +0;"
 	"r6 = 0;" /* mark r6 as live */
 	"r7 = 0;" /* mark r7 as live */
-	/* force r1 to be precise, this eventually marks:
-	 * - bar frame r1
-	 * - foo frame r{1,6,7}
-	 * - main frame r{1,6}
-	 */
 	"r2 = r10;"
 	"r2 += r1;"
 	"r0 = 0;"
@@ -266,23 +197,12 @@ void precision_many_frames__bar(void)
 	::: __clobber_all);
 }
 
-/* Check that scalars with the same IDs are marked precise on stack as
+/* Check that range information is propagated to scalars with the same IDs on stack as
  * well as in registers.
  */
 SEC("socket")
 __success __log_level(2)
-__msg("12: (0f) r2 += r1")
-/* foo frame */
-__msg("frame1: regs=r1 stack= before 11: (bf) r2 = r10")
-__msg("frame1: regs=r1 stack= before 10: (25) if r1 > 0x7 goto pc+0")
-__msg("frame1: regs=r1 stack=-8,-16 before 9: (7b) *(u64 *)(r10 -16) = r1")
-__msg("frame1: regs=r1 stack=-8 before 8: (7b) *(u64 *)(r10 -8) = r1")
-__msg("frame1: regs=r1 stack= before 4: (85) call pc+3")
-/* main frame */
-__msg("frame0: regs=r1 stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r1")
-__msg("frame0: regs=r1 stack= before 2: (bf) r1 = r0")
-__msg("frame0: regs=r0 stack= before 1: (57) r0 &= 255")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("10: (25) if r1 > 0x7 goto pc+0        ; R1=scalar({{.*}}umax32=7,{{.*}} fp-8=scalar({{.*}}umax32=7,{{.*}} fp-16=scalar({{.*}}umax32=7,")
 __naked void precision_stack(void)
 {
 	asm volatile (
@@ -311,10 +231,6 @@ void precision_stack__foo(void)
 	"*(u64*)(r10 - 8) = r1;"
 	"*(u64*)(r10 - 16) = r1;"
 	"if r1 > 7 goto +0;"
-	/* force r1 to be precise, this eventually marks:
-	 * - foo frame r1,fp{-8,-16}
-	 * - main frame r1,fp{-8}
-	 */
 	"r2 = r10;"
 	"r2 += r1;"
 	"r0 = *(u64*)(r10 - 8);"
@@ -329,20 +245,9 @@ void precision_stack__foo(void)
 SEC("socket")
 __success __log_level(2)
 /* r{6,7} */
-__msg("12: (0f) r3 += r7")
-__msg("frame0: regs=r7 stack= before 11: (bf) r3 = r10")
-__msg("frame0: regs=r7 stack= before 9: (25) if r7 > 0x7 goto pc+0")
-/* ... skip some insns ... */
-__msg("frame0: regs=r6,r7 stack= before 3: (bf) r7 = r0")
-__msg("frame0: regs=r0,r6 stack= before 2: (bf) r6 = r0")
+__msg("9: (25) if r7 > 0x7 goto pc+0         ; R6=" LINKED("1", 7, 0x7) " R7=" LINKED("1", 7, 0x7) "{{$}}")
 /* r{8,9} */
-__msg("13: (0f) r3 += r9")
-__msg("frame0: regs=r9 stack= before 12: (0f) r3 += r7")
-/* ... skip some insns ... */
-__msg("frame0: regs=r9 stack= before 10: (25) if r9 > 0x7 goto pc+0")
-__msg("frame0: regs=r8,r9 stack= before 7: (bf) r9 = r0")
-__msg("frame0: regs=r0,r8 stack= before 6: (bf) r8 = r0")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("10: (25) if r9 > 0x7 goto pc+0        ; R8=" LINKED("2", 7, 0x7) " R9=" LINKED("2", 7, 0x7) "{{$}}")
 __naked void precision_two_ids(void)
 {
 	asm volatile (
@@ -360,13 +265,11 @@ __naked void precision_two_ids(void)
 	"r9 = r0;"
 	/* clear r0 id */
 	"r0 = 0;"
-	/* propagate equal scalars precision */
+	/* propagate range information to equal scalars */
 	"if r7 > 7 goto +0;"
 	"if r9 > 7 goto +0;"
 	"r3 = r10;"
-	/* force r7 to be precise, this also marks r6 */
 	"r3 += r7;"
-	/* force r9 to be precise, this also marks r8 */
 	"r3 += r9;"
 	"r6 = r6;" /* mark r6 as live */
 	"r8 = r8;" /* mark r8 as live */
@@ -378,7 +281,6 @@ __naked void precision_two_ids(void)
 
 SEC("socket")
 __success __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 /*
  * check that r5 is unlinked after 'if', collect_linked_regs() can't tie
  * more than 5 registers for a single insn and the register compared by
@@ -386,9 +288,6 @@ __flag(BPF_F_TEST_STATE_FREQ)
  */
 __msg("7: (25) if r5 > 0x7 goto pc+0         ; R5=scalar(smin=")
 __msg("12: (bf) r5 = r5                      ; R5=scalar(id=2")
-/* check that r{0-4} are marked precise after 'if' */
-__msg("frame0: regs=r0 stack= before 7: (25) if r5 > 0x7 goto pc+0")
-__msg("frame0: parent state regs=r0,r1,r2,r3,r4 stack=:")
 __naked void linked_regs_too_many_regs(void)
 {
 	asm volatile (
@@ -410,9 +309,6 @@ __naked void linked_regs_too_many_regs(void)
 	"r4 = r4;"
 	/* make r5 appear in the log */
 	"r5 = r5;"
-	/* force r0 to be precise,
-	 * this would cause r{0-4} to be precise because of shared IDs
-	 */
 	"r7 = r10;"
 	"r7 += r0;"
 	"r0 = 0;"
@@ -424,10 +320,7 @@ __naked void linked_regs_too_many_regs(void)
 
 SEC("socket")
 __failure __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("regs=r7 stack= before 5: (3d) if r8 >= r0")
-__msg("parent state regs=r0,r7,r8")
-__msg("regs=r0,r7,r8 stack= before 4: (25) if r0 > 0x1")
+__msg("5: (3d) if r8 >= r0 goto pc+3         ; R0=scalar(umin=1) R7=scalar(id=1,umax=0xfffffffffffffffe) R8=scalar(id=1,umax=0xfffffffffffffffe)")
 __msg("div by zero")
 __naked void linked_regs_broken_link_2(void)
 {
@@ -438,13 +331,11 @@ __naked void linked_regs_broken_link_2(void)
 	"call %[bpf_get_prandom_u32];"
 	"if r0 > 1 goto +0;"
 	/* r7.id == r8.id,
-	 * thus r7 precision implies r8 precision,
-	 * which implies r0 precision because of the conditional below.
+	 * thus what is learned about r8 is learned about r7
 	 */
 	"if r8 >= r0 goto 1f;"
 	/* break id relation between r7 and r8 */
 	"r8 += r8;"
-	/* make r7 precise */
 	"if r7 == 0 goto 1f;"
 	"r0 /= 0;"
 "1:"
@@ -455,13 +346,11 @@ __naked void linked_regs_broken_link_2(void)
 	: __clobber_all);
 }
 
-/* Check that mark_chain_precision() for one of the conditional jump
- * operands does not trigger equal scalars precision propagation.
- */
+/* A conditional jump that is predicted says nothing new about its operands. */
 SEC("socket")
 __success __log_level(2)
-__msg("3: (25) if r1 > 0x100 goto pc+0")
-__msg("frame0: regs=r1 stack= before 2: (bf) r1 = r0")
+__msg("3: (25) if r1 > 0x100 goto pc+0       ; R1=" LINKED("1", 255, 0xff) "{{$}}")
+__msg("processed 6 insns")
 __naked void cjmp_no_linked_regs_trigger(void)
 {
 	asm volatile (
@@ -470,9 +359,7 @@ __naked void cjmp_no_linked_regs_trigger(void)
 	"r0 &= 0xff;"
 	/* tie r0.id == r1.id */
 	"r1 = r0;"
-	/* the jump below would be predicted, thus r1 would be marked precise,
-	 * this should not imply precision mark for r0
-	 */
+	/* the jump below is predicted */
 	"if r1 > 256 goto +0;"
 	"r0 = 0;"
 	"exit;"
@@ -497,7 +384,6 @@ __naked void cjmp_no_linked_regs_trigger(void)
  */
 SEC("socket")
 __failure __msg("register with unbounded min value")
-__flag(BPF_F_TEST_STATE_FREQ)
 __naked void check_ids_in_regsafe(void)
 {
 	asm volatile (
@@ -539,12 +425,9 @@ __naked void check_ids_in_regsafe(void)
  *   (2) r6{.id=B}, r7{.id=A}, r8{.id=B}
  *
  * Where (2) is not safe, as "r7 > 4" check won't propagate range for it.
- * This example would be considered safe without changes to
- * mark_chain_precision() to track scalar values with equal IDs.
  */
 SEC("socket")
 __failure __msg("register with unbounded min value")
-__flag(BPF_F_TEST_STATE_FREQ)
 __naked void check_ids_in_regsafe_2(void)
 {
 	asm volatile (
@@ -598,15 +481,13 @@ __naked void check_ids_in_regsafe_2(void)
  *   (1) r1{.id=A}, r2{.id=A}
  *   (2) r1{.id=C}, r2{.id=C}
  *
- * Thus forcing 'if r1 == r2' verification twice.
+ * neither of which is within the other one.
  */
 SEC("socket")
 __success __log_level(2)
-__msg("14: (1d) if r3 == r4 goto pc+0")
-__msg("frame 0: propagating r3,r4")
-__msg("14: safe")
-__msg("processed 18 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("from 7 to 14: within")
+__msg("14: (1d) if r3 == r4 goto pc+0        ; R3=0 R4=0")
+__msg("processed 17 insns")
 __naked void no_scalar_id_for_const(void)
 {
 	asm volatile (
@@ -629,7 +510,7 @@ __naked void no_scalar_id_for_const(void)
 	"r3 = r1;"
 	"r4 = r2;"
 "l1_%=:"
-	/* predictable jump, marks r3 and r4 precise */
+	/* predictable jump */
 	"if r3 == r4 goto +0;"
 	"r0 = 0;"
 	"exit;"
@@ -641,11 +522,9 @@ __naked void no_scalar_id_for_const(void)
 /* Same as no_scalar_id_for_const() but for 32-bit values */
 SEC("socket")
 __success __log_level(2)
-__msg("14: (1e) if w3 == w4 goto pc+0")
-__msg("frame 0: propagating r3,r4")
-__msg("14: safe")
-__msg("processed 18 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("from 7 to 14: within")
+__msg("14: (1e) if w3 == w4 goto pc+0        ; R3=0 R4=0")
+__msg("processed 17 insns")
 __naked void no_scalar_id_for_const32(void)
 {
 	asm volatile (
@@ -668,7 +547,7 @@ __naked void no_scalar_id_for_const32(void)
 	"w3 = w1;"
 	"w4 = w2;"
 "l1_%=:"
-	/* predictable jump, marks r3 and r4 precise */
+	/* predictable jump */
 	"if w3 == w4 goto +0;"
 	"r0 = 0;"
 	"exit;"
@@ -677,20 +556,19 @@ __naked void no_scalar_id_for_const32(void)
 	: __clobber_all);
 }
 
-/* Check that unique scalar IDs are ignored when new verifier state is
- * compared to cached verifier state. For this test:
- * - cached state has no id on r1
- * - new state has a unique id on r1
+/* Check that unique scalar IDs are ignored when a verifier state is
+ * compared to the state that is there. For this test:
+ * - the state that is there had a unique id on r1
+ * - the state that arrives has no id on r1
  */
 SEC("socket")
 __success __log_level(2)
 __msg("6: (25) if r6 > 0x7 goto pc+1")
 __msg("7: (57) r1 &= 255")
-__msg("8: (bf) r2 = r10")
-__msg("from 6 to 8: safe")
-__msg("processed 12 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
-__naked void ignore_unique_scalar_ids_cur(void)
+__msg("from 7 to 8: within")
+__msg("8: R0=0 R1=" ALONE(255, 0xff))
+__msg("processed 11 insns")
+__naked void ignore_unique_scalar_ids_old(void)
 {
 	asm volatile (
 	"call %[bpf_ktime_get_ns];"
@@ -706,8 +584,8 @@ __naked void ignore_unique_scalar_ids_cur(void)
 	"r1 &= 0xff;"
 "l0_%=:"
 	/* get here in two states:
-	 * - first: r1 has no id (cached state)
-	 * - second: r1 has a unique id (should be considered equivalent)
+	 * - first: r1 has a unique id
+	 * - second: r1 has no id (should be considered to be within the first)
 	 */
 	"r2 = r10;"
 	"r2 += r1;"
@@ -717,20 +595,19 @@ __naked void ignore_unique_scalar_ids_cur(void)
 	: __clobber_all);
 }
 
-/* Check that unique scalar IDs are ignored when new verifier state is
- * compared to cached verifier state. For this test:
- * - cached state has a unique id on r1
- * - new state has no id on r1
+/* Check that unique scalar IDs are ignored when a verifier state is
+ * compared to the state that is there. For this test:
+ * - the state that is there has no id on r1
+ * - the state that arrives has a unique id on r1
  */
 SEC("socket")
 __success __log_level(2)
 __msg("6: (25) if r6 > 0x7 goto pc+1")
 __msg("7: (05) goto pc+1")
-__msg("9: (bf) r2 = r10")
-__msg("9: safe")
-__msg("processed 13 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
-__naked void ignore_unique_scalar_ids_old(void)
+__msg("from 7 to 9: within")
+__msg("9: R0=0 R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R10=fp0")
+__msg("processed 12 insns")
+__naked void ignore_unique_scalar_ids_cur(void)
 {
 	asm volatile (
 	"call %[bpf_ktime_get_ns];"
@@ -748,8 +625,8 @@ __naked void ignore_unique_scalar_ids_old(void)
 	"r1 &= 0xff;"
 "l0_%=:"
 	/* get here in two states:
-	 * - first: r1 has a unique id (cached state)
-	 * - second: r1 has no id (should be considered equivalent)
+	 * - first: r1 has no id
+	 * - second: r1 has a unique id (should be considered to be within the first)
 	 */
 	"r2 = r10;"
 	"r2 += r1;"
@@ -759,16 +636,13 @@ __naked void ignore_unique_scalar_ids_old(void)
 	: __clobber_all);
 }
 
-/* Check that two registers with 0 scalar IDs in a verified state can be mapped
- * to the same scalar ID in current state.
+/* Check that two registers with 0 scalar IDs in the state that is there can be mapped
+ * to the same scalar ID in the state that arrives.
  */
 SEC("socket")
 __success __log_level(2)
-/* The states should be equivalent on reaching insn 12.
- */
-__msg("12: safe")
-__msg("processed 17 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("from 10 to 11: within")
+__msg("processed 15 insns")
 __naked void two_nil_old_ids_one_cur_id(void)
 {
 	asm volatile (
@@ -783,16 +657,13 @@ __naked void two_nil_old_ids_one_cur_id(void)
 	"r7 *= 1;"
 	"r0 = 0;"
 	/* Maybe make r{6,7} IDs identical */
-	"if r6 > r7 goto l0_%=;"
-	"goto l1_%=;"
-"l0_%=:"
+	"if r6 <= r7 goto l1_%=;"
 	"r6 = r7;"
 "l1_%=:"
-	/* Mark r{6,7} precise.
-	 * Get here in two states:
-	 * - first:  r6{.id=0}, r7{.id=0} (cached state)
+	/* Get here in two states:
+	 * - first:  r6{.id=0}, r7{.id=0}
 	 * - second: r6{.id=A}, r7{.id=A}
-	 * Verifier considers such states equivalent.
+	 * Verifier considers the second one to be within the first one.
 	 * Thus "exit;" would be verified only once.
 	 */
 	"r2 = r10;"
@@ -804,18 +675,13 @@ __naked void two_nil_old_ids_one_cur_id(void)
 	: __clobber_all);
 }
 
-/* Check that two different scalar IDs in a verified state can't be
- * mapped to the same scalar ID in current state.
+/* Check that two different scalar IDs in the state that is there can't be
+ * mapped to the same scalar ID in the state that arrives.
  */
 SEC("socket")
 __success __log_level(2)
-/* The exit instruction should be reachable from two states,
- * use two matches and "processed .. insns" to ensure this.
- */
-__msg("16: (95) exit")
-__msg("16: (95) exit")
-__msg("processed 22 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__not_msg("from 10 to 11: within")
+__msg("11: R0=0 R6=" ALONE(255, 0xff) " R7=" ALONE(255, 0xff))
 __naked void two_old_ids_one_cur_id(void)
 {
 	asm volatile (
@@ -830,17 +696,14 @@ __naked void two_old_ids_one_cur_id(void)
 	"r9 = r0;"
 	"r0 = 0;"
 	/* Maybe make r{6,7} IDs identical */
-	"if r6 > r7 goto l0_%=;"
-	"goto l1_%=;"
-"l0_%=:"
+	"if r6 <= r7 goto l1_%=;"
 	"r6 = r7;"
 "l1_%=:"
-	/* Mark r{6,7} precise.
-	 * Get here in two states:
-	 * - first:  r6{.id=A}, r7{.id=B} (cached state)
-	 * - second: r6{.id=A}, r7{.id=A}
-	 * Currently we don't want to consider such states equivalent.
-	 * Thus "exit;" would be verified twice.
+	/* Get here in two states:
+	 * - first:  r6{.id=A}, r7{.id=B}
+	 * - second: r6{.id=B}, r7{.id=B}
+	 * Currently we don't want to consider the second one to be within
+	 * the first one. Thus they are joined.
 	 */
 	"r2 = r10;"
 	"r2 += r6;"
@@ -878,10 +741,6 @@ __log_level(2)
 __msg("4: (77) r1 >>= 32                     ; R1=0")
 __msg("5: (bf) r0 = r1                       ; R0=0 R1=0")
 __msg("6: (95) exit")
-__msg("from 3 to 4")
-__msg("4: (77) r1 >>= 32                     ; R1=0")
-__msg("5: (bf) r0 = r1                       ; R0=0 R1=0")
-__msg("6: (95) exit")
 /* Verify that statements to randomize upper half of r1 had not been
  * generated.
  */
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 4d1374885f6d..b41f390df3af 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -518,15 +518,6 @@ __msg("6: (71) r2 = *(u8 *)(r10 -1)          ; R2=0 R10=fp0 fp-8=0")
  */
 __msg("10: (71) r2 = *(u8 *)(r10 -9)         ; R2=0 R10=fp0 fp-16=0")
 __msg("11: (0f) r1 += r2")
-__msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 10: (71) r2 = *(u8 *)(r10 -9)")
-__msg("mark_precise: frame0: regs= stack=-16 before 9: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs= stack=-16 before 8: (73) *(u8 *)(r1 +0) = r2")
-__msg("mark_precise: frame0: regs= stack=-16 before 7: (0f) r1 += r2")
-__msg("mark_precise: frame0: regs= stack=-16 before 6: (71) r2 = *(u8 *)(r10 -1)")
-__msg("mark_precise: frame0: regs= stack=-16 before 5: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs= stack=-16 before 4: (7b) *(u64 *)(r10 -16) = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 3: (b7) r0 = 0")
 __naked void partial_stack_load_preserves_zeros(void)
 {
 	asm volatile (
@@ -600,8 +591,6 @@ __success
 __msg("2: (62) *(u32 *)(r10 -4) = 0          ; R10=fp0 fp-8=0000????")
 __msg("4: (71) r2 = *(u8 *)(r10 -1)          ; R2=0 R10=fp0 fp-8=0000????")
 __msg("5: (0f) r1 += r2")
-__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (71) r2 = *(u8 *)(r10 -1)")
 __naked void partial_stack_load_preserves_partial_zeros(void)
 {
 	asm volatile (
@@ -637,7 +626,6 @@ __naked void partial_stack_load_preserves_partial_zeros(void)
 SEC("raw_tp")
 __log_level(2)
 __success
-__msg("mark_precise: frame0: regs= stack=-8")
 __msg("R2=0")
 __naked void stack_load_preserves_mixed_zero_and_zero_spill(void)
 {
@@ -663,50 +651,21 @@ __naked void stack_load_preserves_mixed_zero_and_zero_spill(void)
 char two_byte_buf[2] SEC(".data.two_byte_buf");
 
 SEC("raw_tp")
-__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
+__log_level(2)
 __success
-/* make sure fp-8 is IMPRECISE fake register spill */
+/* make sure fp-8 is fake register spill */
 __msg("3: (7a) *(u64 *)(r10 -8) = 1          ; R10=fp0 fp-8=1")
-/* and fp-16 is spilled IMPRECISE const reg */
+/* and fp-16 is spilled const reg */
 __msg("5: (7b) *(u64 *)(r10 -16) = r0        ; R0=1 R10=fp0 fp-16=1")
 /* validate load from fp-8, which was initialized using BPF_ST_MEM */
 __msg("8: (79) r2 = *(u64 *)(r10 -8)         ; R2=1 R10=fp0 fp-8=1")
-__msg("9: (0f) r1 += r2")
-__msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 8: (79) r2 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r1 = r6")
-/* note, fp-8 is precise, fp-16 is not yet precise, we'll get there */
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=P1 fp-16=1")
-__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
-__msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
-__msg("mark_precise: frame0: regs= stack=-8 before 5: (7b) *(u64 *)(r10 -16) = r0")
-__msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r0 = 1")
-__msg("mark_precise: frame0: regs= stack=-8 before 3: (7a) *(u64 *)(r10 -8) = 1")
-__msg("10: R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
+__msg("9: (0f) r1 += r2                      ; R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
 /* validate load from fp-16, which was initialized using BPF_STX_MEM */
 __msg("12: (79) r2 = *(u64 *)(r10 -16)       ; R2=1 R10=fp0 fp-16=1")
-__msg("13: (0f) r1 += r2")
-__msg("mark_precise: frame0: last_idx 13 first_idx 7 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 12: (79) r2 = *(u64 *)(r10 -16)")
-__msg("mark_precise: frame0: regs= stack=-16 before 11: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs= stack=-16 before 10: (73) *(u8 *)(r1 +0) = r2")
-__msg("mark_precise: frame0: regs= stack=-16 before 9: (0f) r1 += r2")
-__msg("mark_precise: frame0: regs= stack=-16 before 8: (79) r2 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-16 before 7: (bf) r1 = r6")
-/* now both fp-8 and fp-16 are precise, very good */
-__msg("mark_precise: frame0: parent state regs= stack=-16:  R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=P1 fp-16=P1")
-__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
-__msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
-__msg("mark_precise: frame0: regs= stack=-16 before 5: (7b) *(u64 *)(r10 -16) = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (b7) r0 = 1")
-__msg("14: R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
+__msg("13: (0f) r1 += r2                     ; R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
 __naked void stack_load_preserves_const_precision(void)
 {
 	asm volatile (
-		/* establish checkpoint with state that has no stack slots;
-		 * if we bubble up to this state without finding desired stack
-		 * slot, then it's a bug and should be caught
-		 */
 		"goto +0;"
 
 		/* fp-8 is const 1 *fake* register */
@@ -716,7 +675,6 @@ __naked void stack_load_preserves_const_precision(void)
 		"r0 = 1;"
 		"*(u64 *)(r10 -16) = r0;"
 
-		/* force checkpoint to check precision marks preserved in parent states */
 		"goto +0;"
 
 		/* load single U64 from aligned FAKE_REG=1 slot */
@@ -740,48 +698,21 @@ __naked void stack_load_preserves_const_precision(void)
 }
 
 SEC("raw_tp")
-__log_level(2) __flag(BPF_F_TEST_STATE_FREQ)
+__log_level(2)
 __success
 /* make sure fp-8 is 32-bit FAKE subregister spill */
 __msg("3: (62) *(u32 *)(r10 -8) = 1          ; R10=fp0 fp-8=????1")
-/* but fp-16 is spilled IMPRECISE zero const reg */
+/* and fp-16 is spilled const reg */
 __msg("5: (63) *(u32 *)(r10 -16) = r0        ; R0=1 R10=fp0 fp-16=????1")
 /* validate load from fp-8, which was initialized using BPF_ST_MEM */
 __msg("8: (61) r2 = *(u32 *)(r10 -8)         ; R2=1 R10=fp0 fp-8=????1")
-__msg("9: (0f) r1 += r2")
-__msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 8: (61) r2 = *(u32 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r1 = r6")
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=????P1 fp-16=????1")
-__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
-__msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
-__msg("mark_precise: frame0: regs= stack=-8 before 5: (63) *(u32 *)(r10 -16) = r0")
-__msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r0 = 1")
-__msg("mark_precise: frame0: regs= stack=-8 before 3: (62) *(u32 *)(r10 -8) = 1")
-__msg("10: R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
+__msg("9: (0f) r1 += r2                      ; R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
 /* validate load from fp-16, which was initialized using BPF_STX_MEM */
 __msg("12: (61) r2 = *(u32 *)(r10 -16)       ; R2=1 R10=fp0 fp-16=????1")
-__msg("13: (0f) r1 += r2")
-__msg("mark_precise: frame0: last_idx 13 first_idx 7 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 12: (61) r2 = *(u32 *)(r10 -16)")
-__msg("mark_precise: frame0: regs= stack=-16 before 11: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs= stack=-16 before 10: (73) *(u8 *)(r1 +0) = r2")
-__msg("mark_precise: frame0: regs= stack=-16 before 9: (0f) r1 += r2")
-__msg("mark_precise: frame0: regs= stack=-16 before 8: (61) r2 = *(u32 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-16 before 7: (bf) r1 = r6")
-__msg("mark_precise: frame0: parent state regs= stack=-16:  R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=????P1 fp-16=????P1")
-__msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
-__msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
-__msg("mark_precise: frame0: regs= stack=-16 before 5: (63) *(u32 *)(r10 -16) = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (b7) r0 = 1")
-__msg("14: R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
+__msg("13: (0f) r1 += r2                     ; R1=map_value(map=.data.two_byte_,ks=4,vs=2,imm=1) R2=1")
 __naked void stack_load_preserves_const_precision_subreg(void)
 {
 	asm volatile (
-		/* establish checkpoint with state that has no stack slots;
-		 * if we bubble up to this state without finding desired stack
-		 * slot, then it's a bug and should be caught
-		 */
 		"goto +0;"
 
 		/* fp-8 is const 1 *fake* SUB-register */
@@ -791,7 +722,6 @@ __naked void stack_load_preserves_const_precision_subreg(void)
 		"r0 = 1;"
 		"*(u32 *)(r10 -16) = r0;"
 
-		/* force checkpoint to check precision marks preserved in parent states */
 		"goto +0;"
 
 		/* load single U32 from aligned FAKE_REG=1 slot */
@@ -1118,41 +1048,36 @@ l0_%=:	r1 >>= 32;					\
 	: __clobber_all);
 }
 
-/* stacksafe(): check if stack spill of an imprecise scalar in old state
- * is considered equivalent to STACK_{MISC,INVALID} in cur state.
+/* stacksafe(): the state with a stack spill of a scalar is there (label 1 is
+ * looked at first), the state with STACK_{MISC,INVALID} arrives.
+ * The first one is within the second one, which stands for both.
  */
 SEC("socket")
 __success __log_level(2)
+__msg("8: R0=scalar() R10=fp0 fp-8=??mm??mm")
 __msg("8: (79) r1 = *(u64 *)(r10 -8)")
-__msg("8: safe")
-__msg("processed 11 insns")
-/* STACK_INVALID should prevent verifier in unpriv mode from
- * considering states equivalent and force an error on second
- * verification path (entry - label 1 - label 2).
- */
+__msg("processed 10 insns")
+/* STACK_INVALID is an error in unpriv mode */
 __failure_unpriv
 __msg_unpriv("8: (79) r1 = *(u64 *)(r10 -8)")
-__msg_unpriv("9: (95) exit")
-__msg_unpriv("8: (79) r1 = *(u64 *)(r10 -8)")
 __msg_unpriv("invalid read from stack off -8+2 size 8")
-__flag(BPF_F_TEST_STATE_FREQ)
 __naked void old_imprecise_scalar_vs_cur_stack_misc(void)
 {
 	asm volatile(
 	/* get a random value for branching */
 	"call %[bpf_ktime_get_ns];"
 	"if r0 == 0 goto 1f;"
-	/* conjure scalar at fp-8 */
-	"r0 = 42;"
-	"*(u64*)(r10 - 8) = r0;"
-	"goto 2f;"
-"1:"
 	/* conjure STACK_{MISC,INVALID} at fp-8 */
 	"call %[bpf_ktime_get_ns];"
 	"*(u16*)(r10 - 8) = r0;"
 	"*(u16*)(r10 - 4) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure scalar at fp-8 */
+	"r0 = 42;"
+	"*(u64*)(r10 - 8) = r0;"
 "2:"
-	/* read fp-8, should be considered safe on second visit */
+	/* read fp-8, it's looked at once */
 	"r1 = *(u64*)(r10 - 8);"
 	"exit;"
 	:
@@ -1160,38 +1085,33 @@ __naked void old_imprecise_scalar_vs_cur_stack_misc(void)
 	: __clobber_all);
 }
 
-/* stacksafe(): check that stack spill of a precise scalar in old state
- * is not considered equivalent to STACK_MISC in cur state.
+/* stacksafe(): check that the state with STACK_MISC is not considered to be
+ * within the state with a stack spill of a known scalar, which is there.
  */
 SEC("socket")
 __success __log_level(2)
-/* verifier should visit 'if r1 == 0x2a ...' two times:
- * - once for path entry - label 2;
- * - once for path entry - label 1 - label 2.
- */
-__msg("if r1 == 0x2a goto pc+0")
-__msg("if r1 == 0x2a goto pc+0")
-__msg("processed 15 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+/* what is loaded is not known to be 42 */
+__msg("8: (79) r1 = *(u64 *)(r10 -8)         ; R1=scalar() R10=fp0 fp-8=mmmmmmmm")
+__msg("9: (15) if r1 == 0x2a goto pc+0       ; R1=scalar()")
+__msg("processed 11 insns")
 __naked void old_precise_scalar_vs_cur_stack_misc(void)
 {
 	asm volatile(
 	/* get a random value for branching */
 	"call %[bpf_ktime_get_ns];"
 	"if r0 == 0 goto 1f;"
-	/* conjure scalar at fp-8 */
-	"r0 = 42;"
-	"*(u64*)(r10 - 8) = r0;"
-	"goto 2f;"
-"1:"
 	/* conjure STACK_MISC at fp-8 */
 	"call %[bpf_ktime_get_ns];"
 	"*(u64*)(r10 - 8) = r0;"
 	"*(u32*)(r10 - 4) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure scalar at fp-8 */
+	"r0 = 42;"
+	"*(u64*)(r10 - 8) = r0;"
 "2:"
-	/* read fp-8, should not be considered safe on second visit */
 	"r1 = *(u64*)(r10 - 8);"
-	/* use r1 in precise context */
+	/* the value of r1 matters */
 	"if r1 == 42 goto +0;"
 	"exit;"
 	:
@@ -1199,32 +1119,31 @@ __naked void old_precise_scalar_vs_cur_stack_misc(void)
 	: __clobber_all);
 }
 
-/* stacksafe(): check if STACK_MISC in old state is considered
- * equivalent to stack spill of a scalar in cur state.
+/* stacksafe(): check if the state with a stack spill of a scalar is considered
+ * to be within the state with STACK_MISC, which is there.
  */
 SEC("socket")
 __success  __log_level(2)
+__msg("from 4 to 8: within")
 __msg("8: (79) r0 = *(u64 *)(r10 -8)")
-__msg("8: safe")
-__msg("processed 11 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("processed 10 insns")
 __naked void old_stack_misc_vs_cur_scalar(void)
 {
 	asm volatile(
 	/* get a random value for branching */
 	"call %[bpf_ktime_get_ns];"
 	"if r0 == 0 goto 1f;"
+	/* conjure scalar at fp-8 */
+	"r0 = 42;"
+	"*(u64*)(r10 - 8) = r0;"
+	"goto 2f;"
+"1:"
 	/* conjure STACK_{MISC,INVALID} at fp-8 */
 	"call %[bpf_ktime_get_ns];"
 	"*(u16*)(r10 - 8) = r0;"
 	"*(u16*)(r10 - 4) = r0;"
-	"goto 2f;"
-"1:"
-	/* conjure scalar at fp-8 */
-	"r0 = 42;"
-	"*(u64*)(r10 - 8) = r0;"
 "2:"
-	/* read fp-8, should be considered safe on second visit */
+	/* read fp-8, it's looked at once */
 	"r0 = *(u64*)(r10 - 8);"
 	"exit;"
 	:
@@ -1232,21 +1151,15 @@ __naked void old_stack_misc_vs_cur_scalar(void)
 	: __clobber_all);
 }
 
-/* stacksafe(): check that STACK_MISC in old state is not considered
- * equivalent to stack spill of a non-scalar in cur state.
+/* stacksafe(): the state with STACK_MISC is there, the state with a stack spill
+ * of a non-scalar arrives. A program that may read uninitialized stack may
+ * take a pointer for a number: the second state is within the first one.
  */
 SEC("socket")
 __success  __log_level(2)
-/* verifier should process exit instructions twice:
- * - once for path entry - label 2;
- * - once for path entry - label 1 - label 2.
- */
-__msg("8: (79) r1 = *(u64 *)(r10 -8)")
-__msg("9: (95) exit")
-__msg("from 2 to 7")
-__msg("8: safe")
-__msg("processed 11 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("from 4 to 8: within")
+__msg("8: (79) r1 = *(u64 *)(r10 -8)         ; R1=scalar()")
+__msg("processed 10 insns")
 __naked void old_stack_misc_vs_cur_ctx_ptr(void)
 {
 	asm volatile(
@@ -1255,16 +1168,16 @@ __naked void old_stack_misc_vs_cur_ctx_ptr(void)
 	/* get a random value for branching */
 	"call %[bpf_ktime_get_ns];"
 	"if r0 == 0 goto 1f;"
+	/* conjure context pointer in fp-8 */
+	"*(u64*)(r10 - 8) = r9;"
+	"goto 2f;"
+"1:"
 	/* conjure STACK_MISC at fp-8 */
 	"call %[bpf_ktime_get_ns];"
 	"*(u64*)(r10 - 8) = r0;"
 	"*(u32*)(r10 - 4) = r0;"
-	"goto 2f;"
-"1:"
-	/* conjure context pointer in fp-8 */
-	"*(u64*)(r10 - 8) = r9;"
 "2:"
-	/* read fp-8, should not be considered safe on second visit */
+	/* read fp-8, it's looked at once */
 	"r1 = *(u64*)(r10 - 8);"
 	"exit;"
 	:
@@ -1310,35 +1223,34 @@ __naked void stack_noperfmon_spill_32bit_onto_64bit_slot(void)
 }
 
 /*
- * stacksafe(): check if 32-bit scalar spill in old state is considered
- * equivalent to STACK_MISC in cur state.
+ * stacksafe(): the state with a 32-bit scalar spill is there, the state with
+ * STACK_MISC arrives. The first one is within the second one.
  * 32-bit scalar spill creates slot[0-3] = STACK_MISC, slot[4-7] = STACK_SPILL.
  * Without 32-bit spill support in stacksafe(), the STACK_SPILL vs STACK_MISC
- * mismatch at slot[4] causes pruning to fail.
+ * mismatch at slot[4] keeps the states apart.
  */
 SEC("socket")
 __success __log_level(2)
+__msg("8: R0=scalar() R10=fp0 fp-8=????mmmm")
 __msg("8: (79) r1 = *(u64 *)(r10 -8)")
-__msg("8: safe")
-__msg("processed 11 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("processed 10 insns")
 __naked void old_imprecise_scalar32_vs_cur_stack_misc(void)
 {
 	asm volatile(
 	/* get a random value for branching */
 	"call %[bpf_ktime_get_ns];"
 	"if r0 == 0 goto 1f;"
-	/* conjure 32-bit scalar spill at fp-8 */
-	"r0 = 42;"
-	"*(u32*)(r10 - 8) = r0;"
-	"goto 2f;"
-"1:"
 	/* conjure STACK_MISC at fp-8 */
 	"call %[bpf_ktime_get_ns];"
 	"*(u16*)(r10 - 8) = r0;"
 	"*(u16*)(r10 - 6) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure 32-bit scalar spill at fp-8 */
+	"r0 = 42;"
+	"*(u32*)(r10 - 8) = r0;"
 "2:"
-	/* read fp-8, should be considered safe on second visit */
+	/* read fp-8, it's looked at once */
 	"r1 = *(u64*)(r10 - 8);"
 	"exit;"
 	:
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index 399884911ea5..d92215c5b923 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -63,7 +63,6 @@ SEC("cgroup/skb")
 __description("variable-offset stack read preserves spilled zero")
 __success
 __log_level(2)
-__msg("mark_precise: frame0: regs= stack=-8")
 __msg("R3=0")
 __retval(0)
 __naked void stack_read_var_off_preserves_spilled_zero(void)
@@ -89,7 +88,6 @@ SEC("cgroup/skb")
 __description("variable-offset stack read preserves spilled zero across slots")
 __success
 __log_level(2)
-__msg("mark_precise: frame0: regs= stack=-8,-16")
 __msg("R3=0")
 __retval(0)
 __naked void stack_read_var_off_preserves_spilled_zero_across_slots(void)
@@ -116,7 +114,6 @@ SEC("cgroup/skb")
 __description("variable-offset stack read preserves partial spilled zero")
 __success
 __log_level(2)
-__msg("mark_precise: frame0: regs= stack=-8")
 __msg("R3=0")
 __retval(0)
 __naked void stack_read_var_off_preserves_partial_spilled_zero(void)
-- 
2.55.0

