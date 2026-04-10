Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FFA3644D4
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854589; cv=none; b=b5quZiMilDpk+Xr0kZBoNHjr9vz6eN/meE005d6PTae7cSjVJKpVEglvECND91DPBtGsXImka3vok5MF6PJKBNppfVp0305oEs/bVN4gD6/FNPvRP6b8waP2tPmCOLUTEbdzDJYmiGPB9dr4DU9aef5Bl+BeVX0D7tJFZ6JhkCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854589; c=relaxed/simple;
	bh=H9MvR59bfy94Hzc0P7rgIEymvEh8wQ/rXfzz7rO/d98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKRminr0HdN1IrYADUC8vblWoblZEyjxx9pg1+qE4+iPdYtVasTWEfeRXbc1MoffYJOn9eOBTOG6y5aQ6kdb0Q2tBRadaSAF5UtvhdBNx9pxL9Pm/JSqkvOFF5sritI6bschIjFcafwU6oSdru0gIH3Y0AdDf2na8HEFds96CmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET4/YVq8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET4/YVq8"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f138a6d5aso440153b3a.0
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775854586; x=1776459386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULX92YchnT+UZDFwFIWgH/Bkc4urtQv8QPJlLAXqZdc=;
        b=ET4/YVq8FfwW/a4AaLFWLub6z6O/nFhIBtKBQVYxXB8OzKnNetokTnne3V/d7/9JFl
         S98L6coHrJbPbBEJ+XbG4IH2+82+u61zMwN/EA3y5p8mnNgt5pXDsAjwDjx3PTsr+Le4
         o11CeujxmDdKZ3QuGtlxvsUPcqQDJ4KpD0tk4BAAS8qiyD+ZGgS6smfknh3tH5/CytFZ
         dXrQSWK11GTzIprVUlu5wKhdOL6l9qt2FqGFQ49GqxeBk9fuK+36OLdst8ySPv3/SZG8
         +CbQ1pPOvJVngiPv/iwu45YhKyzRvBAtJeBnFMJucMWXv3uoZDp+pTrtcHPoXsrq5nJc
         tX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854586; x=1776459386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ULX92YchnT+UZDFwFIWgH/Bkc4urtQv8QPJlLAXqZdc=;
        b=QrWsXTHAYuX2EcAQqhlY8qI8stnyKlDpzEMIUVkQM+eKGyS31cuGQKHQIsYEgujb+O
         3DCNrabaqHm48GAXg9LW8lb8KCwlX6cpVHgPtYUMNwozIOVhUuzljrB1aFxHhhyMTXkj
         /NnUoAY0NUtPy5HTm0GxuOoqWwbTFFXIAHNMd7axt/mSePzy7kDvlNZLcn0B02DxLT2n
         sazarnahWKFtND3zyxEVQPFNh5OPNYXsSBTPQrCyRtCVOMIMbvPWDAl809gHsOh8yfaW
         LHgWhr0oFWK3hh6cl4CjCfUR1KED2HeK6SiTNlsR6iV3RzqCWCSgTKvhwtUyHpSUBR05
         dySw==
X-Gm-Message-State: AOJu0YxDXyUMPDG0buDNiQDORix/nJp04wPE7G/Ihwe4Qjjrkut9cQD3
	qhSz69oSEqMbGgv+6Jj4z2XfU8AU8+evBuqF4vrpWWgu376euhKV12vF1IKiS290
X-Gm-Gg: AeBDietv3QcTt2ncGQZodn/gxaPiTY5m2Qq49KZ5weh3bwLvMgCmMOVNtULsF4M28AL
	EaPCggU2Iwf8TnR0kKnDL9tNIss86LcGQg1ckYMC/p0OO6BeSC8WNZIwUsjxIcuKvh9/3Z27VVd
	7biPh7+U2k6M+CTJBX21ZTmoU/LCxRzJxAAGHpCAK8SwzL+6VmBLH1RtTUrLfXLqdfO/qVWeS6B
	RA2eyx5w061XtPZq4jqhwwzBvjrVMgSku+/lGuW8Iwn/KiSCNDRaLOhVBN9NZexlLvrejS4yod3
	exaTsOXbaXnhZFkVUv+T8Lh3U5hp2COfr0KcvzMdOEyYTtDzqhLrzjILECtkF7/Qp2srzP4qwj+
	6hZzPf783lz2TBUVBbChORoM3LEuCusMMPFfo+Cvg7Oa/cUvlHXZnAKnULv7qW2SQ+/jUpBdFds
	2Wce4v+alnr8IKhM7yW7tQGDEJVIEJ1PbmUSBQBY5upgFR3ONAx35I6zXHAGxc3T40zzk=
X-Received: by 2002:a05:6a00:3e27:b0:82c:2205:507d with SMTP id d2e1a72fcca58-82f0c385de5mr4792019b3a.36.1775854585914;
        Fri, 10 Apr 2026 13:56:25 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50a8f7sm3551648b3a.56.2026.04.10.13.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 13:56:25 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v4 11/14] selftests/bpf: update existing tests due to liveness changes
Date: Fri, 10 Apr 2026 13:56:02 -0700
Message-ID: <20260410-patch-set-v4-11-5d4eecb343db@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
References: <20260410-patch-set-v4-0-5d4eecb343db@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The verifier cleans all dead registers and stack slots in the current
state. Adjust expected output in tests or insert dummy stack/register
reads. Also update verifier_live_stack tests to adhere to new logging
scheme.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/exceptions_assert.c        |  6 +-
 tools/testing/selftests/bpf/progs/uninit_stack.c   |  1 +
 tools/testing/selftests/bpf/progs/verifier_align.c | 10 +--
 .../selftests/bpf/progs/verifier_div_mod_bounds.c  | 18 +++--
 .../selftests/bpf/progs/verifier_live_stack.c      | 88 +++++++++-------------
 .../selftests/bpf/progs/verifier_scalar_ids.c      | 26 ++++---
 .../selftests/bpf/progs/verifier_spill_fill.c      |  8 +-
 .../bpf/progs/verifier_subprog_precision.c         |  8 +-
 8 files changed, 79 insertions(+), 86 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tools/testing/selftests/bpf/progs/exceptions_assert.c
index 2027cfcb748c..e4abf4172fca 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -59,7 +59,7 @@ check_assert(s64, >=, ge_neg, INT_MIN);
 
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R0=0 R1=ctx() R2=scalar(smin=0xffffffff80000002,smax=smax32=0x7ffffffd,smin32=0x80000002) R10=fp0")
+__msg(": R1=ctx() R2=scalar(smin=0xffffffff80000002,smax=smax32=0x7ffffffd,smin32=0x80000002) R10=fp0")
 int check_assert_range_s64(struct __sk_buff *ctx)
 {
 	struct bpf_sock *sk = ctx->sk;
@@ -86,7 +86,7 @@ int check_assert_range_u64(struct __sk_buff *ctx)
 
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R0=0 R1=ctx() R2=4096 R10=fp0")
+__msg(": R1=ctx() R2=4096 R10=fp0")
 int check_assert_single_range_s64(struct __sk_buff *ctx)
 {
 	struct bpf_sock *sk = ctx->sk;
@@ -114,7 +114,7 @@ int check_assert_single_range_u64(struct __sk_buff *ctx)
 
 SEC("?tc")
 __log_level(2) __failure
-__msg(": R1=pkt(r=64,imm=64) R2=pkt_end() R6=pkt(r=64) R10=fp0")
+__msg(": R6=pkt(r=64) R10=fp0")
 int check_assert_generic(struct __sk_buff *ctx)
 {
 	u8 *data_end = (void *)(long)ctx->data_end;
diff --git a/tools/testing/selftests/bpf/progs/uninit_stack.c b/tools/testing/selftests/bpf/progs/uninit_stack.c
index 046a204c8fc6..5db02323c89c 100644
--- a/tools/testing/selftests/bpf/progs/uninit_stack.c
+++ b/tools/testing/selftests/bpf/progs/uninit_stack.c
@@ -76,6 +76,7 @@ __naked int helper_uninit_to_misc(void *ctx)
 		 * thus showing the stack state, matched by __msg().		\
 		 */					\
 		call %[dummy];				\
+		r1 = *(u64*)(r10 - 104);		\
 		r0 = 0;					\
 		exit;					\
 "
diff --git a/tools/testing/selftests/bpf/progs/verifier_align.c b/tools/testing/selftests/bpf/progs/verifier_align.c
index 24553ce62881..3e52686515ca 100644
--- a/tools/testing/selftests/bpf/progs/verifier_align.c
+++ b/tools/testing/selftests/bpf/progs/verifier_align.c
@@ -131,7 +131,7 @@ LBL ":"							\
 SEC("tc")
 __success __log_level(2)
 __flag(BPF_F_ANY_ALIGNMENT)
-__msg("6: R0=pkt(r=8,imm=8)")
+__msg("6: {{.*}} R2=pkt(r=8)")
 __msg("6: {{.*}} R3={{[^)]*}}var_off=(0x0; 0xff)")
 __msg("7: {{.*}} R3={{[^)]*}}var_off=(0x0; 0x1fe)")
 __msg("8: {{.*}} R3={{[^)]*}}var_off=(0x0; 0x3fc)")
@@ -205,7 +205,7 @@ __success __log_level(2)
 __msg("2: {{.*}} R5=pkt(r=0)")
 __msg("4: {{.*}} R5=pkt(r=0,imm=14)")
 __msg("5: {{.*}} R4=pkt(r=0,imm=14)")
-__msg("9: {{.*}} R2=pkt(r=18)")
+__msg("9: {{.*}} R5=pkt(r=18,imm=14)")
 __msg("10: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xff){{.*}} R5=pkt(r=18,imm=14)")
 __msg("13: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xffff)")
 __msg("14: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xffff)")
@@ -254,7 +254,7 @@ __msg("11: {{.*}} R5=pkt(id=1,{{[^)]*}},var_off=(0x2; 0x7fc)")
  * offset is considered using reg->aux_off_align which
  * is 4 and meets the load's requirements.
  */
-__msg("15: {{.*}} R4={{[^)]*}}var_off=(0x2; 0x7fc){{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
+__msg("15: {{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
 /* Variable offset is added to R5 packet pointer,
  * resulting in auxiliary alignment of 4. To avoid BPF
  * verifier's precision backtracking logging
@@ -273,7 +273,7 @@ __msg("19: {{.*}} R5=pkt(id=2,{{[^)]*}}var_off=(0x2; 0x7fc)")
  * aligned, so the total offset is 4-byte aligned and
  * meets the load's requirements.
  */
-__msg("24: {{.*}} R4={{[^)]*}}var_off=(0x2; 0x7fc){{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
+__msg("24: {{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
 /* Constant offset is added to R5 packet pointer,
  * resulting in reg->off value of 14.
  */
@@ -296,7 +296,7 @@ __msg("31: {{.*}} R4={{[^)]*}}var_off=(0x2; 0xffc){{.*}} R5={{[^)]*}}var_off=(0x
  * the total offset is 4-byte aligned and meets the
  * load's requirements.
  */
-__msg("35: {{.*}} R4={{[^)]*}}var_off=(0x2; 0xffc){{.*}} R5={{[^)]*}}var_off=(0x2; 0xffc)")
+__msg("35: {{.*}} R5={{[^)]*}}var_off=(0x2; 0xffc)")
 __naked void packet_variable_offset(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_div_mod_bounds.c b/tools/testing/selftests/bpf/progs/verifier_div_mod_bounds.c
index 4672af0b3268..e814a054d69a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_div_mod_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_div_mod_bounds.c
@@ -36,7 +36,7 @@ l0_%=:	r0 = *(u64 *)(r1 + 0);				\
 SEC("socket")
 __description("UDIV32, zero divisor")
 __success __retval(0) __log_level(2)
-__msg("w1 /= w2 {{.*}}; R1=0 R2=0")
+__msg("w1 /= w2 {{.*}}; R1=0")
 __naked void udiv32_zero_divisor(void)
 {
 	asm volatile ("					\
@@ -81,7 +81,7 @@ l0_%=:	r0 = *(u64 *)(r1 + 0);				\
 SEC("socket")
 __description("UDIV64, zero divisor")
 __success __retval(0) __log_level(2)
-__msg("r1 /= r2 {{.*}}; R1=0 R2=0")
+__msg("r1 /= r2 {{.*}}; R1=0")
 __naked void udiv64_zero_divisor(void)
 {
 	asm volatile ("					\
@@ -242,7 +242,7 @@ l1_%=:	r0 = *(u64 *)(r1 + 0);				\
 SEC("socket")
 __description("SDIV32, zero divisor")
 __success __retval(0) __log_level(2)
-__msg("w1 s/= w2 {{.*}}; R1=0 R2=0")
+__msg("w1 s/= w2 {{.*}}; R1=0")
 __naked void sdiv32_zero_divisor(void)
 {
 	asm volatile ("					\
@@ -275,6 +275,7 @@ __naked void sdiv32_overflow_1(void)
 	w2 += 10;					\
 	if w1 s> w2 goto l0_%=;				\
 	w1 s/= -1;					\
+	r2 = r1;					\
 l0_%=:	r0 = 0;						\
 	exit;						\
 "	:
@@ -443,7 +444,7 @@ l1_%=:	r0 = *(u64 *)(r1 + 0);				\
 SEC("socket")
 __description("SDIV64, zero divisor")
 __success __retval(0) __log_level(2)
-__msg("r1 s/= r2 {{.*}}; R1=0 R2=0")
+__msg("r1 s/= r2 {{.*}}; R1=0")
 __naked void sdiv64_zero_divisor(void)
 {
 	asm volatile ("					\
@@ -476,6 +477,7 @@ __naked void sdiv64_overflow_1(void)
 	r2 += 10;					\
 	if r1 s> r2 goto l0_%=;				\
 	r1 s/= -1;					\
+	r2 = r1;					\
 l0_%=:	r0 = 0;						\
 	exit;						\
 "	:
@@ -553,7 +555,7 @@ l0_%=:	r0 = *(u64 *)(r1 + 0);				\
 SEC("socket")
 __description("UMOD32, zero divisor")
 __success __retval(0) __log_level(2)
-__msg("w1 %= w2 {{.*}}; R1=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=9,var_off=(0x1; 0x8)) R2=0")
+__msg("w1 %= w2 {{.*}}; R1=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=9,var_off=(0x1; 0x8))")
 __naked void umod32_zero_divisor(void)
 {
 	asm volatile ("					\
@@ -624,7 +626,7 @@ l0_%=:	r0 = *(u64 *)(r1 + 0);				\
 SEC("socket")
 __description("UMOD64, zero divisor")
 __success __retval(0) __log_level(2)
-__msg("r1 %= r2 {{.*}}; R1=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=9,var_off=(0x1; 0x8)) R2=0")
+__msg("r1 %= r2 {{.*}}; R1=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=9,var_off=(0x1; 0x8))")
 __naked void umod64_zero_divisor(void)
 {
 	asm volatile ("					\
@@ -833,7 +835,7 @@ l1_%=:	r0 = *(u64 *)(r1 + 0);				\
 SEC("socket")
 __description("SMOD32, zero divisor")
 __success __retval(0) __log_level(2)
-__msg("w1 s%= w2 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-8,smax32=10,var_off=(0x0; 0xffffffff)) R2=0")
+__msg("w1 s%= w2 {{.*}}; R1=scalar(smin=0,smax=umax=0xffffffff,smin32=-8,smax32=10,var_off=(0x0; 0xffffffff))")
 __naked void smod32_zero_divisor(void)
 {
 	asm volatile ("					\
@@ -1084,7 +1086,7 @@ l1_%=:	r0 = *(u64 *)(r1 + 0);				\
 SEC("socket")
 __description("SMOD64, zero divisor")
 __success __retval(0) __log_level(2)
-__msg("r1 s%= r2 {{.*}}; R1=scalar(smin=smin32=-8,smax=smax32=10) R2=0")
+__msg("r1 s%= r2 {{.*}}; R1=scalar(smin=smin32=-8,smax=smax32=10)")
 __naked void smod64_zero_divisor(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 2de105057bbc..0281955139c7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
+char _license[] SEC("license") = "GPL";
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(max_entries, 1);
@@ -14,12 +15,9 @@ struct {
 
 SEC("socket")
 __log_level(2)
-__msg("(0) frame 0 insn 2 +written -8")
-__msg("(0) frame 0 insn 1 +live -24")
-__msg("(0) frame 0 insn 1 +written -8")
-__msg("(0) frame 0 insn 0 +live -8,-24")
-__msg("(0) frame 0 insn 0 +written -8")
-__msg("(0) live stack update done in 2 iterations")
+__msg("0: (79) r1 = *(u64 *)(r10 -8)        ; use: fp0-8")
+__msg("1: (79) r2 = *(u64 *)(r10 -24)       ; use: fp0-24")
+__msg("2: (7b) *(u64 *)(r10 -8) = r1        ; def: fp0-8")
 __naked void simple_read_simple_write(void)
 {
 	asm volatile (
@@ -33,12 +31,8 @@ __naked void simple_read_simple_write(void)
 
 SEC("socket")
 __log_level(2)
-__msg("(0) frame 0 insn 1 +live -8")
-__not_msg("(0) frame 0 insn 1 +written")
-__msg("(0) live stack update done in 2 iterations")
-__msg("(0) frame 0 insn 1 +live -16")
-__msg("(0) frame 0 insn 1 +written -32")
-__msg("(0) live stack update done in 2 iterations")
+__msg("2: (79) r0 = *(u64 *)(r10 -8)        ; use: fp0-8")
+__msg("6: (79) r0 = *(u64 *)(r10 -16)       ; use: fp0-16")
 __naked void read_write_join(void)
 {
 	asm volatile (
@@ -58,13 +52,9 @@ __naked void read_write_join(void)
 
 SEC("socket")
 __log_level(2)
-__msg("2: (25) if r0 > 0x2a goto pc+1")
-__msg("7: (95) exit")
-__msg("(0) frame 0 insn 2 +written -16")
-__msg("(0) live stack update done in 2 iterations")
-__msg("7: (95) exit")
-__not_msg("(0) frame 0 insn 2")
-__msg("(0) live stack update done in 1 iterations")
+__msg("stack use/def subprog#0 must_write_not_same_slot (d0,cs0):")
+__msg("6: (7b) *(u64 *)(r2 +0) = r0{{$}}")
+__msg("Live regs before insn:")
 __naked void must_write_not_same_slot(void)
 {
 	asm volatile (
@@ -83,10 +73,8 @@ __naked void must_write_not_same_slot(void)
 
 SEC("socket")
 __log_level(2)
-__msg("(0) frame 0 insn 0 +written -8,-16")
-__msg("(0) live stack update done in 2 iterations")
-__msg("(0) frame 0 insn 0 +written -8")
-__msg("(0) live stack update done in 2 iterations")
+__msg("0: (7a) *(u64 *)(r10 -8) = 0         ; def: fp0-8")
+__msg("5: (85) call bpf_map_lookup_elem#1   ; use: fp0-8h")
 __naked void must_write_not_same_type(void)
 {
 	asm volatile (
@@ -110,10 +98,11 @@ __naked void must_write_not_same_type(void)
 
 SEC("socket")
 __log_level(2)
-__msg("(2,4) frame 0 insn 4 +written -8")
-__msg("(2,4) live stack update done in 2 iterations")
-__msg("(0) frame 0 insn 2 +written -8")
-__msg("(0) live stack update done in 2 iterations")
+/* Callee writes fp[0]-8: stack_use at call site has slots 0,1 live */
+__msg("stack use/def subprog#0 caller_stack_write (d0,cs0):")
+__msg("2: (85) call pc+1{{$}}")
+__msg("stack use/def subprog#1 write_first_param (d1,cs2):")
+__msg("4: (7a) *(u64 *)(r1 +0) = 7          ; def: fp0-8")
 __naked void caller_stack_write(void)
 {
 	asm volatile (
@@ -135,23 +124,15 @@ static __used __naked void write_first_param(void)
 
 SEC("socket")
 __log_level(2)
-/* caller_stack_read() function */
-__msg("2: .12345.... (85) call pc+4")
-__msg("5: .12345.... (85) call pc+1")
-__msg("6: 0......... (95) exit")
-/* read_first_param() function */
-__msg("7: .1........ (79) r0 = *(u64 *)(r1 +0)")
-__msg("8: 0......... (95) exit")
-/* update for callsite at (2) */
-__msg("(2,7) frame 0 insn 7 +live -8")
-__msg("(2,7) live stack update done in 2 iterations")
-__msg("(0) frame 0 insn 2 +live -8")
-__msg("(0) live stack update done in 2 iterations")
-/* update for callsite at (5) */
-__msg("(5,7) frame 0 insn 7 +live -16")
-__msg("(5,7) live stack update done in 2 iterations")
-__msg("(0) frame 0 insn 5 +live -16")
-__msg("(0) live stack update done in 2 iterations")
+__msg("stack use/def subprog#0 caller_stack_read (d0,cs0):")
+__msg("2: (85) call pc+{{.*}}                   ; use: fp0-8{{$}}")
+__msg("5: (85) call pc+{{.*}}                   ; use: fp0-16{{$}}")
+__msg("stack use/def subprog#1 read_first_param (d1,cs2):")
+__msg("7: (79) r0 = *(u64 *)(r1 +0)         ; use: fp0-8{{$}}")
+__msg("8: (95) exit")
+__msg("stack use/def subprog#1 read_first_param (d1,cs5):")
+__msg("7: (79) r0 = *(u64 *)(r1 +0)         ; use: fp0-16{{$}}")
+__msg("8: (95) exit")
 __naked void caller_stack_read(void)
 {
 	asm volatile (
@@ -176,18 +157,19 @@ static __used __naked void read_first_param(void)
 SEC("socket")
 __flag(BPF_F_TEST_STATE_FREQ)
 __log_level(2)
-/* read_first_param2() function */
-__msg(" 9: .1........ (79) r0 = *(u64 *)(r1 +0)")
-__msg("10: .......... (b7) r0 = 0")
-__msg("11: 0......... (05) goto pc+0")
-__msg("12: 0......... (95) exit")
+/* fp0-8 consumed at insn 9, dead by insn 11. stack_def at insn 4 kills slots 0,1. */
+__msg("4: (7b) *(u64 *)(r10 -8) = r0        ; def: fp0-8")
+/* stack_use at call site: callee reads fp0-8, slots 0,1 live */
+__msg("7: (85) call pc+{{.*}}               ; use: fp0-8")
+/* read_first_param2: no caller stack live inside callee after first read */
+__msg("9: (79) r0 = *(u64 *)(r1 +0)         ; use: fp0-8")
+__msg("10: (b7) r0 = 0{{$}}")
+__msg("11: (05) goto pc+0{{$}}")
+__msg("12: (95) exit")
 /*
- * The purpose of the test is to check that checkpoint in
- * read_first_param2() stops path traversal. This will only happen if
- * verifier understands that fp[0]-8 at insn (12) is not alive.
+ * Checkpoint at goto +0 fires because fp0-8 is dead → state pruning.
  */
 __msg("12: safe")
-__msg("processed 20 insns")
 __naked void caller_stack_pruning(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index a5b8753ce52c..70ae14d6084f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -264,13 +264,13 @@ void precision_many_frames__bar(void)
  */
 SEC("socket")
 __success __log_level(2)
-__msg("11: (0f) r2 += r1")
+__msg("12: (0f) r2 += r1")
 /* foo frame */
-__msg("frame1: regs=r1 stack= before 10: (bf) r2 = r10")
-__msg("frame1: regs=r1 stack= before 9: (25) if r1 > 0x7 goto pc+0")
-__msg("frame1: regs=r1 stack=-8,-16 before 8: (7b) *(u64 *)(r10 -16) = r1")
-__msg("frame1: regs=r1 stack=-8 before 7: (7b) *(u64 *)(r10 -8) = r1")
-__msg("frame1: regs=r1 stack= before 4: (85) call pc+2")
+__msg("frame1: regs=r1 stack= before 11: (bf) r2 = r10")
+__msg("frame1: regs=r1 stack= before 10: (25) if r1 > 0x7 goto pc+0")
+__msg("frame1: regs=r1 stack=-8,-16 before 9: (7b) *(u64 *)(r10 -16) = r1")
+__msg("frame1: regs=r1 stack=-8 before 8: (7b) *(u64 *)(r10 -8) = r1")
+__msg("frame1: regs=r1 stack= before 4: (85) call pc+3")
 /* main frame */
 __msg("frame0: regs=r1 stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r1")
 __msg("frame0: regs=r1 stack= before 2: (bf) r1 = r0")
@@ -286,6 +286,7 @@ __naked void precision_stack(void)
 	"r1 = r0;"
 	"*(u64*)(r10 - 8) = r1;"
 	"call precision_stack__foo;"
+	"r0 = *(u64*)(r10 - 8);"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -309,6 +310,8 @@ void precision_stack__foo(void)
 	 */
 	"r2 = r10;"
 	"r2 += r1;"
+	"r0 = *(u64*)(r10 - 8);"
+	"r0 = *(u64*)(r10 - 16);"
 	"exit"
 	::: __clobber_all);
 }
@@ -802,9 +805,9 @@ __success __log_level(2)
 /* The exit instruction should be reachable from two states,
  * use two matches and "processed .. insns" to ensure this.
  */
-__msg("15: (95) exit")
-__msg("15: (95) exit")
-__msg("processed 20 insns")
+__msg("16: (95) exit")
+__msg("16: (95) exit")
+__msg("processed 22 insns")
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void two_old_ids_one_cur_id(void)
 {
@@ -835,6 +838,11 @@ __naked void two_old_ids_one_cur_id(void)
 	"r2 = r10;"
 	"r2 += r6;"
 	"r2 += r7;"
+	/*
+	 * keep r8 and r9 live, otherwise r6->id and r7->id
+	 * will become singular and reset to zero before if r6 > r7
+	 */
+	"r9 += r8;"
 	"exit;"
 	:
 	: __imm(bpf_ktime_get_ns)
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 672e4446181e..c6ae64b99cd6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -650,7 +650,7 @@ __msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r2 stack= before 8: (79) r2 = *(u64 *)(r10 -8)")
 __msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r1 = r6")
 /* note, fp-8 is precise, fp-16 is not yet precise, we'll get there */
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R0=1 R1=ctx() R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=P1 fp-16=1")
+__msg("mark_precise: frame0: parent state regs= stack=-8:  R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=P1 fp-16=1")
 __msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-8 before 5: (7b) *(u64 *)(r10 -16) = r0")
@@ -668,7 +668,7 @@ __msg("mark_precise: frame0: regs= stack=-16 before 9: (0f) r1 += r2")
 __msg("mark_precise: frame0: regs= stack=-16 before 8: (79) r2 = *(u64 *)(r10 -8)")
 __msg("mark_precise: frame0: regs= stack=-16 before 7: (bf) r1 = r6")
 /* now both fp-8 and fp-16 are precise, very good */
-__msg("mark_precise: frame0: parent state regs= stack=-16:  R0=1 R1=ctx() R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=P1 fp-16=P1")
+__msg("mark_precise: frame0: parent state regs= stack=-16:  R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=P1 fp-16=P1")
 __msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-16 before 5: (7b) *(u64 *)(r10 -16) = r0")
@@ -726,7 +726,7 @@ __msg("9: (0f) r1 += r2")
 __msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r2 stack= before 8: (61) r2 = *(u32 *)(r10 -8)")
 __msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r1 = r6")
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R0=1 R1=ctx() R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=????P1 fp-16=????1")
+__msg("mark_precise: frame0: parent state regs= stack=-8:  R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=????P1 fp-16=????1")
 __msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-8 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-8 before 5: (63) *(u32 *)(r10 -16) = r0")
@@ -743,7 +743,7 @@ __msg("mark_precise: frame0: regs= stack=-16 before 10: (73) *(u8 *)(r1 +0) = r2
 __msg("mark_precise: frame0: regs= stack=-16 before 9: (0f) r1 += r2")
 __msg("mark_precise: frame0: regs= stack=-16 before 8: (61) r2 = *(u32 *)(r10 -8)")
 __msg("mark_precise: frame0: regs= stack=-16 before 7: (bf) r1 = r6")
-__msg("mark_precise: frame0: parent state regs= stack=-16:  R0=1 R1=ctx() R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=????P1 fp-16=????P1")
+__msg("mark_precise: frame0: parent state regs= stack=-16:  R6=map_value(map=.data.two_byte_,ks=4,vs=2) R10=fp0 fp-8=????P1 fp-16=????P1")
 __msg("mark_precise: frame0: last_idx 6 first_idx 3 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-16 before 6: (05) goto pc+0")
 __msg("mark_precise: frame0: regs= stack=-16 before 5: (63) *(u32 *)(r10 -16) = r0")
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index 61886ed554de..d21d32f6a676 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -282,7 +282,7 @@ __msg("mark_precise: frame0: regs=r0,r6 stack= before 10: (bf) r6 = r0")
 __msg("mark_precise: frame0: regs=r0 stack= before 9: (85) call bpf_loop")
 /* State entering callback body popped from states stack */
 __msg("from 9 to 17: frame1:")
-__msg("17: frame1: R1=scalar() R2=0 R10=fp0 cb")
+__msg("17: frame1: R10=fp0 cb")
 __msg("17: (b7) r0 = 0")
 __msg("18: (95) exit")
 __msg("returning from callee:")
@@ -411,7 +411,7 @@ __msg("mark_precise: frame0: regs=r6 stack= before 5: (b7) r1 = 1")
 __msg("mark_precise: frame0: regs=r6 stack= before 4: (b7) r6 = 3")
 /* State entering callback body popped from states stack */
 __msg("from 9 to 15: frame1:")
-__msg("15: frame1: R1=scalar() R2=0 R10=fp0 cb")
+__msg("15: frame1: R10=fp0 cb")
 __msg("15: (b7) r0 = 0")
 __msg("16: (95) exit")
 __msg("returning from callee:")
@@ -567,7 +567,7 @@ __msg("mark_precise: frame0: regs= stack=-8 before 5: (7b) *(u64 *)(r10 -8) = r6
 __msg("mark_precise: frame0: regs=r6 stack= before 4: (b7) r6 = 3")
 /* State entering callback body popped from states stack */
 __msg("from 10 to 17: frame1:")
-__msg("17: frame1: R1=scalar() R2=0 R10=fp0 cb")
+__msg("17: frame1: R10=fp0 cb")
 __msg("17: (b7) r0 = 0")
 __msg("18: (95) exit")
 __msg("returning from callee:")
@@ -681,7 +681,7 @@ __msg("mark_precise: frame0: last_idx 10 first_idx 7 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r7 stack= before 9: (bf) r1 = r8")
 __msg("mark_precise: frame0: regs=r7 stack= before 8: (27) r7 *= 4")
 __msg("mark_precise: frame0: regs=r7 stack= before 7: (79) r7 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R0=2 R6=1 R8=map_value(map=.data.vals,ks=4,vs=16) R10=fp0 fp-8=P1")
+__msg("mark_precise: frame0: parent state regs= stack=-8:  R8=map_value(map=.data.vals,ks=4,vs=16) R10=fp0 fp-8=P1")
 __msg("mark_precise: frame0: last_idx 18 first_idx 0 subseq_idx 7")
 __msg("mark_precise: frame0: regs= stack=-8 before 18: (95) exit")
 __msg("mark_precise: frame1: regs= stack= before 17: (0f) r0 += r2")

-- 
2.53.0
