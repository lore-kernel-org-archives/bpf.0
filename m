Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983999;
	b=x9J1rNPdG+0aRLUCj5VNZWE6Sn2uJkd8MNl1XiQwGqmG6pkzJVnOJQIO//OETfpgKPu8
	 glym3WB2qF1G2O99uOzRZIXAQiBZfQ5pXgpsBMzlJ9NfAt59144cE3TbnDX+98MvnsnJ7
	 QPq9HKSPEYZ1434JfHCCWksxrIgOtrSnkP2ntEyVEwTvKSC2oLR9sZQjt9Wah+99EDsSk
	 pP6sRquXbvLxQ1y0/ARhZgQVeNNfH8tneghil8uxddcpa7QDlwEmHZaN1lbp/1BsPwHaC
	 jLGZM0pbR0ZmEzd6kfNVF+rHRoMMYGXzVCIyg3DhMTeFDr2lfopzNS+CpKqAksjj5lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KG1ECDNSdawq7foy0QrdeDUD61fR3jRnf5HdCiMa+e4=;
	b=BwQw9wzupAxmv6GHjtXT9dYB7nhnRTB1pCw//64Pz3WiKRfs6Y/lEq19EmOQgncZCpYp
	 Zuzm7DHMq/FRENd+x0mGOsAGrI7/jK02BVVTaO7irqAnvbO2YDzE8yG3/ywSST9SlmrXi
	 awl/4fEHFxdwhLjTOgI+yyzbRGV/4TvNuXHcoTEWkNfE1Cvg066aLOfczroKPpxIBkpgX
	 LjxSabIvluDPlJ/YO2w/8mmE+vUsI0+xlfe+N8jToftE0XnQyy4a3y8nOE2KcsGIyfo/b
	 T+tomeZ/u7cJzHJDqKOgyMzBAQlnkSct5+gy0+PNBSscjEAsTh71ur4O8sbE8scSHbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J8+kCt4f;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E90606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34E90606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J8+kCt4f
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so813200a12.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983997; x=1793588797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KG1ECDNSdawq7foy0QrdeDUD61fR3jRnf5HdCiMa+e4=;
        b=J8+kCt4fwa+SjLawb9dwrLo3Hz01CPA6dnPMSFZHscVAsyc5qkxNK0pXB87vcnfZzG
         Y8MMINSu1Yp4Sot6Lm6vQuRUX5eUgVlpbdxvv6owGjJQztEysv2u4kSUf0Gs7oDSoq64
         9lBzngq7f7d0Dd0GdTFLtsNttIga20FImaVeVpU5fRpRfUj2LjE6yDxYnuhbaDxrJVfT
         mB8qHTg5hJh3GMY6BoRaCFJetAgxrgi4SVu3+vB/XLAmGpIljVH9fW70Jj34gzlg6CsX
         MInwcRJOWhqo7eX9uYejg3F61j+eOJU7USD4DIvAnfg8w/1jt/+RW1BTdhgXcAG7+w1s
         +M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983997; x=1793588797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KG1ECDNSdawq7foy0QrdeDUD61fR3jRnf5HdCiMa+e4=;
        b=aaeVxWAUIazQOlQRrp/t37o4wjXNc+Q6A1xazJOcJ1GFGi+z+8YZa2p6vCJDY6izP8
         tF7u4EHVi27hKMfJF/jd2WTyljaWbai5nvxWzarjmTHQ8BXi0i42htVdK718ikDVMI1y
         KMGztI2R/c1cyJ8kJD8igRIruknUJmT4+aOJMz3l6ij6Fr8D3L7iSzHuoOALjsQNzcCv
         rv6pavOucVcvJv6rVYgvrWIqP1qBGTwRROgBsvi6JQ12gsMZ0QxUqaemE3XIfQlWO8Xi
         OJBiu3UzlzXfsEB0rdkzz4BiigHrjM0aEyJ70SG2RyveG1wNGIrLJRwaOZmFFRD87xws
         DSgg==
X-Gm-Message-State: AFq9FYJ3GGlsBF6NFQ8YzUKwrwAfbbkDhvuTdko2MU6Eov+5p6y1606r
	HNLnHfQrN2Z7iTzcCwsM8x0HPlqSalib1ap6UFAddz9hnUQ/vxXRSD+XEQoowQ==
X-Gm-Gg: AYBFou2FnVq3uYg6rCrydwGZcoHtxCCDPeuhbJleoQlLzGKLADeP7h7zal2MpcAg5Rb
	hH/r4bb07chDYwRMoXy4l1gG/zSaa1I+LZ18cwZ2CfDu4/wvVLltxTg5iTo2+jK3gunlvTvhzz/
	pclkcQbFKyFmx4imVfj37/C1Wuan7GJLQfdeBugbcXnHHmYF3qOIjLRL0sUFd1PgDz/84RBfSq3
	4ce60q2ENhpqZJ3mD1lgwEkolQLiIHrAhFcrvcbJtt9dbCr5QLVt0UTODiqek02iAb83oaqFikF
	TP5EkibGA3HJCt30BTotJYSc/SaBm+HZpjnV0m6EeRMIEi3wTp73bVXj9GdvKEPBbbAMk/sEAA2
	AR3VBDIs1vmXsgYFtS+eQ37uZu7BgGFOPcBLScxmU/55g7jOYqfdGh8FsQuUMfVsEUkQ8UiXza0
	1xlPQhCsnOZqyJRk5lyRcVjzoy7/8Dw0Tsj6Y/MdpH+SlhkS3b7NgFEs9SXLc1zZCJSvMhbuolC
	7Rdl/L7bCDm7W5P+j6rqtFyllfDIPREvsggSA/CK+M30UxJeHBjJGdX4z8If8crWe8EZn1qC7iD
	5zO7JPm+XmlKPVSnKiXk48RBzvZAECLI5q67xV342Mz/9FsFoh7saUhXAnHFdiCgzmviZJVYvH0
	cExe/VwO02cwlbcUJiidn9iO00A==
X-Received: by 2002:a17:90b:1652:b0:3a7:82ef:bcdd with SMTP id 98e67ed59e1d1-3adead4f65fmr5256691a91.41.1792983996620;
        Sun, 25 Oct 2026 20:06:36 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm6201170a91.9.2026.10.25.20.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:06:36 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 70/81] selftests/bpf: Adjust tests of precision tracking
Date: Mon, 26 Oct 2026 02:59:31 +0000
Message-ID: <20261026025943.404450-71-alexei.starovoitov@gmail.com>
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

Precision tracking went back from a check through the insns of a path. It
found the scalars that the check depends on. At log level 2 it printed each
step as a "mark_precise:" line. These tests match 358 such lines.
"bpf: Remove precision tracking" removed the mechanism and the lines.

Keep the progs. Each prog moves a scalar along a difficult route. Then it
uses the scalar where the verifier must know the value, for example as an
offset.

  file                          the route of the scalar
  ----------------------------  -------------------------------------------
  verifier_precision.c          neg, byte swap, atomic insns, load-acquire,
                                store-release
  verifier_subprog_precision.c  static and global subprogs, callbacks,
                                spills into the frame of the caller
  stack_arg_precision.c         stack arguments of a subprog and of a kfunc

Match the value that the log shows for the scalar.

  before  mark_precise: frame0: regs=r2 stack= before 1: (87) r2 = -r2
  after   1: (87) r2 = -r2                      ; R2=-8

The four tests in verifier/precise.c examine only the verdict and the
return value. No expected verdict changes.

The tests in progs/ also drop BPF_F_TEST_STATE_FREQ. The flag made the
verifier save states for pruning more frequently. It has no effect now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/stack_arg_precision.c |  48 +--
 .../selftests/bpf/progs/verifier_precision.c  | 166 +++------
 .../bpf/progs/verifier_subprog_precision.c    | 348 +++---------------
 .../testing/selftests/bpf/verifier/precise.c  |  69 +---
 4 files changed, 112 insertions(+), 519 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/stack_arg_precision.c b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
index c9564776d733..bf42ca629a01 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_precision.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
@@ -23,7 +23,7 @@ int __btf_kfunc_gen(struct __sk_buff *ctx)
 }
 
 /*
- * Test precision backtracking across bpf-to-bpf call for kfunc stack arg.
+ * Test that the range of a stack arg is known across bpf-to-bpf call for kfunc stack arg.
  * subprog_call_mem_kfunc receives a size as incoming stack arg (arg6)
  * and forwards it as mem__sz (arg7) to bpf_kfunc_call_stack_arg_mem.
  */
@@ -52,52 +52,12 @@ static long subprog_call_mem_kfunc(long a, long b, long c, long d, long e, long
 }
 
 SEC("tc")
-__description("stack_arg: precision backtracking across bpf2bpf call for kfunc")
+__description("stack_arg: range across bpf2bpf call for kfunc")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("from 9 to 11: joined")
+__msg("13: (79) r1 = *(u64 *)(r11 +8)        ; R1=scalar(smin=umin=smin32=umin32=4,smax=umax=smax32=umax32=6,var_off=(0x4; 0x2))")
 __btf_func_path("btf__stack_arg_precision.bpf.o")
-__msg("mark_precise: frame1: last_idx 26 first_idx 13 subseq_idx -1")
-__msg("mark_precise: frame1: regs= stack= before 25: (b7) r5 = 5")
-__msg("mark_precise: frame1: regs= stack= before 24: (b7) r4 = 4")
-__msg("mark_precise: frame1: regs= stack= before 23: (b7) r3 = 3")
-__msg("mark_precise: frame1: regs= stack= before 22: (b7) r2 = 2")
-__msg("mark_precise: frame1: regs= stack= before 21: (b7) r1 = 1")
-__msg("mark_precise: frame1: regs= stack= before 20: (7b) *(u64 *)(r11 -16) = r1")
-__msg("mark_precise: frame1: regs=r1 stack= before 19: (7b) *(u64 *)(r11 -8) = r2")
-__msg("mark_precise: frame1: regs=r1 stack= before 18: (07) r2 += -8")
-__msg("mark_precise: frame1: regs=r1 stack= before 17: (bf) r2 = r10")
-__msg("mark_precise: frame1: regs=r1 stack= before 16: (7b) *(u64 *)(r10 -8) = r2")
-__msg("mark_precise: frame1: regs=r1 stack= before 14: (18) r2 = 0x807060504030201")
-__msg("mark_precise: frame1: regs=r1 stack= before 13: (79) r1 = *(u64 *)(r11 +8)")
-__msg("mark_precise: frame1: parent state regs= stack=:  frame1: R10=fp0")
-__msg("mark_precise: frame0: parent state regs= stack=:  R10=fp0")
-__msg("mark_precise: frame1: last_idx 11 first_idx 11 subseq_idx 13")
-__msg("mark_precise: frame1: regs= stack= before 11: (85) call pc+1")
-__msg("mark_precise: frame0: parent state regs= stack=:  R10=fp0")
-__msg("mark_precise: frame0: last_idx 9 first_idx 7 subseq_idx 11")
-__msg("mark_precise: frame0: regs= stack= before 9: (05) goto pc+1")
-__msg("mark_precise: frame0: regs= stack= before 8: (7a) *(u64 *)(r11 -8) = 4")
-__msg("mark_precise: frame1: last_idx 26 first_idx 13 subseq_idx -1 ")
-__msg("mark_precise: frame1: regs= stack= before 25: (b7) r5 = 5")
-__msg("mark_precise: frame1: regs= stack= before 24: (b7) r4 = 4")
-__msg("mark_precise: frame1: regs= stack= before 23: (b7) r3 = 3")
-__msg("mark_precise: frame1: regs= stack= before 22: (b7) r2 = 2")
-__msg("mark_precise: frame1: regs= stack= before 21: (b7) r1 = 1")
-__msg("mark_precise: frame1: regs= stack= before 20: (7b) *(u64 *)(r11 -16) = r1")
-__msg("mark_precise: frame1: regs=r1 stack= before 19: (7b) *(u64 *)(r11 -8) = r2")
-__msg("mark_precise: frame1: regs=r1 stack= before 18: (07) r2 += -8")
-__msg("mark_precise: frame1: regs=r1 stack= before 17: (bf) r2 = r10")
-__msg("mark_precise: frame1: regs=r1 stack= before 16: (7b) *(u64 *)(r10 -8) = r2")
-__msg("mark_precise: frame1: regs=r1 stack= before 14: (18) r2 = 0x807060504030201")
-__msg("mark_precise: frame1: regs=r1 stack= before 13: (79) r1 = *(u64 *)(r11 +8)")
-__msg("mark_precise: frame1: parent state regs= stack=:  frame1: R10=fp0")
-__msg("mark_precise: frame0: parent state regs= stack=:  R10=fp0")
-__msg("mark_precise: frame1: last_idx 11 first_idx 11 subseq_idx 13 ")
-__msg("mark_precise: frame1: regs= stack= before 11: (85) call pc+1")
-__msg("mark_precise: frame0: parent state regs= stack=:  R10=fp0")
-__msg("mark_precise: frame0: last_idx 10 first_idx 10 subseq_idx 11 ")
-__msg("mark_precise: frame0: regs= stack= before 10: (7a) *(u64 *)(r11 -8) = 6")
 __naked void stack_arg_precision_bpf2bpf(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 2ec3ee7821c0..aacb75dffb52 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -16,10 +16,7 @@ struct {
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0xfffffff8 goto pc+2")
-__msg("mark_precise: frame0: regs=r2 stack= before 1: (87) r2 = -r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 8")
+__msg("1: (87) r2 = -r2                      ; R2=-8")
 __naked int bpf_neg(void)
 {
 	asm volatile (
@@ -36,10 +33,7 @@ __naked int bpf_neg(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0x0 goto pc+2")
-__msg("mark_precise: frame0: regs=r2 stack= before 1: (d4) r2 = le16 r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 0")
+__msg("1: (d4) r2 = le16 r2                  ; R2=0")
 __naked int bpf_end_to_le(void)
 {
 	asm volatile (
@@ -57,10 +51,7 @@ __naked int bpf_end_to_le(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0x0 goto pc+2")
-__msg("mark_precise: frame0: regs=r2 stack= before 1: (dc) r2 = be16 r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 0")
+__msg("1: (dc) r2 = be16 r2                  ; R2=0")
 __naked int bpf_end_to_be(void)
 {
 	asm volatile (
@@ -82,10 +73,7 @@ __naked int bpf_end_to_be(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 2: (55) if r2 != 0x0 goto pc+2")
-__msg("mark_precise: frame0: regs=r2 stack= before 1: (d7) r2 = bswap16 r2")
-__msg("mark_precise: frame0: regs=r2 stack= before 0: (b7) r2 = 0")
+__msg("1: (d7) r2 = bswap16 r2               ; R2=0")
 __naked int bpf_end_bswap(void)
 {
 	asm volatile (
@@ -104,10 +92,8 @@ __naked int bpf_end_bswap(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 2: (db) r2 = load_acquire((u64 *)(r10 -8))")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("2: (db) r2 = load_acquire((u64 *)(r10 -8)){{ *}}; R2=8 R10=fp0 fp-8=8")
+__msg("4: (0f) r3 += r2                      ; R2=8 R3=fp8")
 __naked int bpf_load_acquire(void)
 {
 	asm volatile (
@@ -115,7 +101,7 @@ __naked int bpf_load_acquire(void)
 	"*(u64 *)(r10 - 8) = r1;"
 	".8byte %[load_acquire_insn];" /* r2 = load_acquire((u64 *)(r10 - 8)); */
 	"r3 = r10;"
-	"r3 += r2;" /* mark_precise */
+	"r3 += r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -126,10 +112,8 @@ __naked int bpf_load_acquire(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r1 stack= before 3: (bf) r2 = r10")
-__msg("mark_precise: frame0: regs=r1 stack= before 2: (79) r1 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (db) store_release((u64 *)(r10 -8), r1)")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("1: (db) store_release((u64 *)(r10 -8), r1){{ *}}; R1=8 R10=fp0 fp-8=8")
+__msg("4: (0f) r2 += r1                      ; R1=8 R2=fp8")
 __naked int bpf_store_release(void)
 {
 	asm volatile (
@@ -137,7 +121,7 @@ __naked int bpf_store_release(void)
 	".8byte %[store_release_insn];" /* store_release((u64 *)(r10 - 8), r1); */
 	"r1 = *(u64 *)(r10 - 8);"
 	"r2 = r10;"
-	"r2 += r1;" /* mark_precise */
+	"r2 += r1;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -184,10 +168,6 @@ __success __log_level(2)
 __msg("8: (bd) if r2 <= r10 goto pc+3")
 __msg("9: (35) if r1 >= 0xffe3fff8 goto pc+0")
 __msg("10: (b5) if r2 <= 0x8 goto pc+0")
-__msg("mark_precise: frame1: last_idx 10 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame1: regs=r2 stack= before 9: (35) if r1 >= 0xffe3fff8 goto pc+0")
-__msg("mark_precise: frame1: regs=r2 stack= before 8: (bd) if r2 <= r10 goto pc+3")
-__msg("mark_precise: frame1: regs=r2 stack= before 7: (05) goto pc+0")
 __naked void bpf_cond_op_r10(void)
 {
 	asm volatile (
@@ -203,9 +183,6 @@ __success __log_level(2)
 __msg("3: (bf) r3 = r10")
 __msg("4: (bd) if r3 <= r2 goto pc+1")
 __msg("5: (b5) if r2 <= 0x8 goto pc+2")
-__msg("mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (bd) if r3 <= r2 goto pc+1")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (bf) r3 = r10")
 __naked void bpf_cond_op_not_r10(void)
 {
 	asm volatile (
@@ -223,9 +200,6 @@ SEC("lsm.s/socket_connect")
 __success __log_level(2)
 __msg("0: (b7) r0 = 1                        ; R0=1")
 __msg("1: (84) w0 = -w0                      ; R0=0xffffffff")
-__msg("mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 1: (84) w0 = -w0")
-__msg("mark_precise: frame0: regs=r0 stack= before 0: (b7) r0 = 1")
 __naked int bpf_neg_2(void)
 {
 	/*
@@ -258,9 +232,6 @@ SEC("lsm.s/socket_connect")
 __success __log_level(2)
 __msg("0: (b7) r0 = 1                        ; R0=1")
 __msg("1: (87) r0 = -r0                      ; R0=-1")
-__msg("mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 1: (87) r0 = -r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 0: (b7) r0 = 1")
 __naked int bpf_neg_4(void)
 {
 	/*
@@ -291,11 +262,8 @@ __naked int bpf_neg_5(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2){{ *}}; R2=8 R10=fp0 fp-8=mmmmmmmm")
+__msg("5: (0f) r3 += r2                      ; R2=8 R3=fp8")
 __naked int bpf_atomic_fetch_add_precision(void)
 {
 	asm volatile (
@@ -304,7 +272,7 @@ __naked int bpf_atomic_fetch_add_precision(void)
 	"r2 = 0;"
 	".8byte %[fetch_add_insn];"	/* r2 = atomic_fetch_add(*(u64 *)(r10 - 8), r2) */
 	"r3 = r10;"
-	"r3 += r2;"			/* mark_precise */
+	"r3 += r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -315,11 +283,8 @@ __naked int bpf_atomic_fetch_add_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_xchg((u64 *)(r10 -8), r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("3: (db) r2 = atomic64_xchg((u64 *)(r10 -8), r2){{ *}}; R2=8 R10=fp0 fp-8=mmmmmmmm")
+__msg("5: (0f) r3 += r2                      ; R2=8 R3=fp8")
 __naked int bpf_atomic_xchg_precision(void)
 {
 	asm volatile (
@@ -328,7 +293,7 @@ __naked int bpf_atomic_xchg_precision(void)
 	"r2 = 0;"
 	".8byte %[xchg_insn];"		/* r2 = atomic_xchg(*(u64 *)(r10 - 8), r2) */
 	"r3 = r10;"
-	"r3 += r2;"			/* mark_precise */
+	"r3 += r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -339,11 +304,8 @@ __naked int bpf_atomic_xchg_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_or((u64 *)(r10 -8), r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("3: (db) r2 = atomic64_fetch_or((u64 *)(r10 -8), r2){{ *}}; R2=8 R10=fp0 fp-8=mmmmmmmm")
+__msg("5: (0f) r3 += r2                      ; R2=8 R3=fp8")
 __naked int bpf_atomic_fetch_or_precision(void)
 {
 	asm volatile (
@@ -352,7 +314,7 @@ __naked int bpf_atomic_fetch_or_precision(void)
 	"r2 = 0;"
 	".8byte %[fetch_or_insn];"	/* r2 = atomic_fetch_or(*(u64 *)(r10 - 8), r2) */
 	"r3 = r10;"
-	"r3 += r2;"			/* mark_precise */
+	"r3 += r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -363,11 +325,8 @@ __naked int bpf_atomic_fetch_or_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_and((u64 *)(r10 -8), r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("3: (db) r2 = atomic64_fetch_and((u64 *)(r10 -8), r2){{ *}}; R2=8 R10=fp0 fp-8=mmmmmmmm")
+__msg("5: (0f) r3 += r2                      ; R2=8 R3=fp8")
 __naked int bpf_atomic_fetch_and_precision(void)
 {
 	asm volatile (
@@ -376,7 +335,7 @@ __naked int bpf_atomic_fetch_and_precision(void)
 	"r2 = 0;"
 	".8byte %[fetch_and_insn];"	/* r2 = atomic_fetch_and(*(u64 *)(r10 - 8), r2) */
 	"r3 = r10;"
-	"r3 += r2;"			/* mark_precise */
+	"r3 += r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -387,11 +346,8 @@ __naked int bpf_atomic_fetch_and_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_xor((u64 *)(r10 -8), r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("3: (db) r2 = atomic64_fetch_xor((u64 *)(r10 -8), r2){{ *}}; R2=8 R10=fp0 fp-8=mmmmmmmm")
+__msg("5: (0f) r3 += r2                      ; R2=8 R3=fp8")
 __naked int bpf_atomic_fetch_xor_precision(void)
 {
 	asm volatile (
@@ -400,7 +356,7 @@ __naked int bpf_atomic_fetch_xor_precision(void)
 	"r2 = 0;"
 	".8byte %[fetch_xor_insn];"	/* r2 = atomic_fetch_xor(*(u64 *)(r10 - 8), r2) */
 	"r3 = r10;"
-	"r3 += r2;"			/* mark_precise */
+	"r3 += r2;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -411,12 +367,8 @@ __naked int bpf_atomic_fetch_xor_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r3 = r10")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (db) r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 3: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r0 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("4: (db) r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2){{ *}}; R0=8 R2=0 R10=fp0 fp-8=mmmmmmmm")
+__msg("6: (0f) r3 += r0                      ; R0=8 R3=fp8")
 __naked int bpf_atomic_cmpxchg_precision(void)
 {
 	asm volatile (
@@ -426,7 +378,7 @@ __naked int bpf_atomic_cmpxchg_precision(void)
 	"r2 = 0;"
 	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u64 *)(r10 - 8), r0, r2) */
 	"r3 = r10;"
-	"r3 += r0;"			/* mark_precise */
+	"r3 += r0;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -435,19 +387,14 @@ __naked int bpf_atomic_cmpxchg_precision(void)
 	: __clobber_all);
 }
 
-/* Regression test for dual precision: Both the fetched value (r2) and
- * a reread of the same stack slot (r3) are tracked for precision. After
- * the atomic operation, the stack slot is STACK_MISC. Thus, the ldx at
- * insn 4 does NOT set INSN_F_STACK_ACCESS. Precision for the stack slot
- * propagates solely through the atomic fetch's load side (insn 3).
+/* Both the fetched value (r2) and a reread of the same stack slot (r3) are used.
+ * The fetched value is known. After the atomic operation, the stack slot is
+ * STACK_MISC, so what is reread is not.
  */
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r2,r3 stack= before 4: (79) r3 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("5: (bf) r4 = r2                       ; R2=8 R4=8")
+__msg("6: (0f) r4 += r3                      ; R3=scalar() R4=scalar()")
 __naked int bpf_atomic_fetch_add_dual_precision(void)
 {
 	asm volatile (
@@ -460,7 +407,7 @@ __naked int bpf_atomic_fetch_add_dual_precision(void)
 	"r4 += r3;"
 	"r4 &= 7;"
 	"r5 = r10;"
-	"r5 += r4;"			/* mark_precise */
+	"r5 += r4;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -471,12 +418,8 @@ __naked int bpf_atomic_fetch_add_dual_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r0,r3 stack= before 5: (79) r3 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (db) r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r2)")
-__msg("mark_precise: frame0: regs= stack=-8 before 3: (b7) r2 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 2: (b7) r0 = 8")
-__msg("mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1")
-__msg("mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8")
+__msg("6: (bf) r4 = r0                       ; R0=8 R4=8")
+__msg("7: (0f) r4 += r3                      ; R3=scalar() R4=scalar()")
 __naked int bpf_atomic_cmpxchg_dual_precision(void)
 {
 	asm volatile (
@@ -490,7 +433,7 @@ __naked int bpf_atomic_cmpxchg_dual_precision(void)
 	"r4 += r3;"
 	"r4 &= 7;"
 	"r5 = r10;"
-	"r5 += r4;"			/* mark_precise */
+	"r5 += r4;"
 	"r0 = 0;"
 	"exit;"
 	:
@@ -501,9 +444,7 @@ __naked int bpf_atomic_cmpxchg_dual_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r1 stack= before 10: (57) r1 &= 7")
-__msg("mark_precise: frame0: regs=r1 stack= before 9: (db) r1 = atomic64_fetch_add((u64 *)(r0 +0), r1)")
-__not_msg("falling back to forcing all scalars precise")
+__msg("9: (db) r1 = atomic64_fetch_add((u64 *)(r0 +0), r1){{ *}}; R0=map_value({{.*}}) R1=scalar()")
 __naked int bpf_atomic_fetch_add_map_precision(void)
 {
 	asm volatile (
@@ -518,7 +459,7 @@ __naked int bpf_atomic_fetch_add_map_precision(void)
 	".8byte %[fetch_add_insn];"	/* r1 = atomic_fetch_add(*(u64 *)(r0 + 0), r1) */
 	"r1 &= 7;"
 	"r2 = r10;"
-	"r2 += r1;"			/* mark_precise */
+	"r2 += r1;"
 	"1: r0 = 0;"
 	"exit;"
 	:
@@ -531,9 +472,7 @@ __naked int bpf_atomic_fetch_add_map_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r0 stack= before 12: (57) r0 &= 7")
-__msg("mark_precise: frame0: regs=r0 stack= before 11: (db) r0 = atomic64_cmpxchg((u64 *)(r6 +0), r0, r1)")
-__not_msg("falling back to forcing all scalars precise")
+__msg("11: (db) r0 = atomic64_cmpxchg((u64 *)(r6 +0), r0, r1){{ *}}; R0=scalar() R1=0")
 __naked int bpf_atomic_cmpxchg_map_precision(void)
 {
 	asm volatile (
@@ -550,7 +489,7 @@ __naked int bpf_atomic_cmpxchg_map_precision(void)
 	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u64 *)(r6 + 0), r0, r1) */
 	"r0 &= 7;"
 	"r2 = r10;"
-	"r2 += r0;"			/* mark_precise */
+	"r2 += r0;"
 	"1: r0 = 0;"
 	"exit;"
 	:
@@ -563,9 +502,7 @@ __naked int bpf_atomic_cmpxchg_map_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r1 stack= before 10: (57) r1 &= 7")
-__msg("mark_precise: frame0: regs=r1 stack= before 9: (c3) r1 = atomic_fetch_add((u32 *)(r0 +0), r1)")
-__not_msg("falling back to forcing all scalars precise")
+__msg("9: (c3) r1 = atomic_fetch_add((u32 *)(r0 +0), r1){{ *}}; R0=map_value({{.*}}) R1=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))")
 __naked int bpf_atomic_fetch_add_32bit_precision(void)
 {
 	asm volatile (
@@ -580,7 +517,7 @@ __naked int bpf_atomic_fetch_add_32bit_precision(void)
 	".8byte %[fetch_add_insn];"	/* r1 = atomic_fetch_add(*(u32 *)(r0 + 0), r1) */
 	"r1 &= 7;"
 	"r2 = r10;"
-	"r2 += r1;"			/* mark_precise */
+	"r2 += r1;"
 	"1: r0 = 0;"
 	"exit;"
 	:
@@ -593,9 +530,7 @@ __naked int bpf_atomic_fetch_add_32bit_precision(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("mark_precise: frame0: regs=r0 stack= before 12: (57) r0 &= 7")
-__msg("mark_precise: frame0: regs=r0 stack= before 11: (c3) r0 = atomic_cmpxchg((u32 *)(r6 +0), r0, r1)")
-__not_msg("falling back to forcing all scalars precise")
+__msg("11: (c3) r0 = atomic_cmpxchg((u32 *)(r6 +0), r0, r1){{ *}}; R0=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R1=0")
 __naked int bpf_atomic_cmpxchg_32bit_precision(void)
 {
 	asm volatile (
@@ -612,7 +547,7 @@ __naked int bpf_atomic_cmpxchg_32bit_precision(void)
 	".8byte %[cmpxchg_insn];"	/* r0 = atomic_cmpxchg(*(u32 *)(r6 + 0), r0, r1) */
 	"r0 &= 7;"
 	"r2 = r10;"
-	"r2 += r0;"			/* mark_precise */
+	"r2 += r0;"
 	"1: r0 = 0;"
 	"exit;"
 	:
@@ -626,11 +561,9 @@ __naked int bpf_atomic_cmpxchg_32bit_precision(void)
 /*
  * Verification takes two paths: with r1 being scalar zero on path (1)
  * and with r1 being some other scalar on path (2).
- * Check that the verifier does not use checkpoints created
- * on path (1) to prune path (2).
+ * Check that the state of path (1) does not stand for path (2).
  */
 SEC("?tc")
-__flag(BPF_F_TEST_STATE_FREQ)
 __failure __msg("R1 type=scalar expected=fp")
 __naked int null_mem_arg_zero_size(void)
 {
@@ -667,11 +600,9 @@ __weak int subprog_mem_arg(int *p)
 /*
  * Verification takes two paths: with r1 being scalar zero on path (1)
  * and with r1 being some other scalar on path (2).
- * Check that the verifier does not use checkpoints created
- * on path (1) to prune path (2).
+ * Check that the state of path (1) does not stand for path (2).
  */
 SEC("?raw_tp")
-__flag(BPF_F_TEST_STATE_FREQ)
 __failure __msg("R1 type=scalar expected=fp")
 __naked int null_mem_arg_global_subprog(void)
 {
@@ -689,9 +620,8 @@ __naked int null_mem_arg_global_subprog(void)
 		: __clobber_all);
 }
 
-/* Same as above, check that path with r3 == 0 does not prune the path with r3 != 0 */
+/* Same as above, check that path with r3 == 0 does not stand for the path with r3 != 0 */
 SEC("?tc")
-__flag(BPF_F_TEST_STATE_FREQ)
 __failure __msg("R3 type=scalar expected=fp")
 int null_kfunc_arg_dynptr_slice(struct __sk_buff *skb)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
index dc0c7034c04f..3f9a65ff134e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
@@ -39,31 +39,20 @@ static unsigned long callback_subprog()
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("7: (0f) r1 += r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 6: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (27) r0 *= 4")
-__msg("mark_precise: frame0: regs=r0 stack= before 11: (95) exit")
-__msg("mark_precise: frame1: regs=r0 stack= before 10: (bf) r0 = r1")
-__msg("mark_precise: frame1: regs=r1 stack= before 4: (85) call pc+5")
-__msg("mark_precise: frame0: regs=r1 stack= before 3: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__msg("7: (0f) r1 += r0                      ; R0=12 R1=map_value(map=.data.vals,ks=4,vs=16,imm=12)")
 __naked int subprog_result_precise(void)
 {
 	asm volatile (
 		"r6 = 3;"
-		/* pass r6 through r1 into subprog to get it back as r0;
-		 * this whole chain will have to be marked as precise later
-		 */
+		/* pass r6 through r1 into subprog to get it back as r0 */
 		"r1 = r6;"
 		"call identity_subprog;"
 		/* now use subprog's returned value (which is a
-		 * r6 -> r1 -> r0 chain), as index into vals array, forcing
-		 * all of that to be known precisely
+		 * r6 -> r1 -> r0 chain), as index into vals array
 		 */
 		"r0 *= 4;"
 		"r1 = %[vals];"
-		/* here r0->r1->r6 chain is forced to be precise and has to be
-		 * propagated back to the beginning, including through the
+		/* here r0 has to be known: the constant went through the
 		 * subprog call
 		 */
 		"r1 += r0;"
@@ -98,26 +87,18 @@ static unsigned long sneaky_fp_leaking_subprog()
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("6: (0f) r1 += r0")
-__msg("mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (27) r0 *= 4")
-__msg("mark_precise: frame0: regs=r0 stack= before 3: (57) r0 &= 3")
-__msg("mark_precise: frame0: regs=r0 stack= before 10: (95) exit")
-__msg("mark_precise: frame1: regs=r0 stack= before 9: (bf) r0 = (s8)r10")
-__msg("7: R0=scalar")
+__msg("3: R0=scalar() R6=")
+__msg("6: (0f) r1 += r0                      ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4) R1=map_value(map=.data.vals,ks=4,vs=16,smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4)")
 __naked int fp_precise_subprog_result(void)
 {
 	asm volatile (
 		"call fp_leaking_subprog;"
 		/* use subprog's returned value (which is derived from r10=fp
-		 * register), as index into vals array, forcing all of that to
-		 * be known precisely
+		 * register, so it's unknown), as index into vals array
 		 */
 		"r0 &= 3;"
 		"r0 *= 4;"
 		"r1 = %[vals];"
-		/* force precision marking */
 		"r1 += r0;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -129,31 +110,18 @@ __naked int fp_precise_subprog_result(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("6: (0f) r1 += r0")
-__msg("mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (27) r0 *= 4")
-__msg("mark_precise: frame0: regs=r0 stack= before 3: (57) r0 &= 3")
-__msg("mark_precise: frame0: regs=r0 stack= before 11: (95) exit")
-__msg("mark_precise: frame1: regs=r0 stack= before 10: (bf) r0 = (s8)r1")
-/* here r1 is marked precise, even though it's fp register, but that's fine
- * because by the time we get out of subprogram it has to be derived from r10
- * anyways, at which point we'll break precision chain
- */
-__msg("mark_precise: frame1: regs=r1 stack= before 9: (bf) r1 = r10")
-__msg("7: R0=scalar")
+__msg("3: R0=scalar() R6=")
+__msg("6: (0f) r1 += r0                      ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4) R1=map_value(map=.data.vals,ks=4,vs=16,smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4)")
 __naked int sneaky_fp_precise_subprog_result(void)
 {
 	asm volatile (
 		"call sneaky_fp_leaking_subprog;"
 		/* use subprog's returned value (which is derived from r10=fp
-		 * register), as index into vals array, forcing all of that to
-		 * be known precisely
+		 * register, so it's unknown), as index into vals array
 		 */
 		"r0 &= 3;"
 		"r0 *= 4;"
 		"r1 = %[vals];"
-		/* force precision marking */
 		"r1 += r0;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -165,35 +133,25 @@ __naked int sneaky_fp_precise_subprog_result(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("9: (0f) r1 += r0")
-__msg("mark_precise: frame0: last_idx 9 first_idx 0")
-__msg("mark_precise: frame0: regs=r0 stack= before 8: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r0 stack= before 7: (27) r0 *= 4")
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (a5) if r0 < 0x4 goto pc+1")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (85) call pc+7")
+__msg("9: (0f) r1 += r0                      ; R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4) R1=map_value(map=.data.vals,ks=4,vs=16,smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4)")
 __naked int global_subprog_result_precise(void)
 {
 	asm volatile (
 		"r6 = 3;"
 		/* pass r6 through r1 into subprog to get it back as r0;
-		 * given global_identity_subprog is global, precision won't
-		 * propagate all the way back to r6
+		 * given global_identity_subprog is global, nothing is known
+		 * about what it returns
 		 */
 		"r1 = r6;"
 		"call global_identity_subprog;"
 		/* now use subprog's returned value (which is unknown now, so
-		 * we need to clamp it), as index into vals array, forcing r0
-		 * to be marked precise (with no effect on r6, though)
+		 * we need to clamp it), as index into vals array
 		 */
 		"if r0 < %[vals_arr_sz] goto 1f;"
 		"r0 = %[vals_arr_sz] - 1;"
 	"1:"
 		"r0 *= 4;"
 		"r1 = %[vals];"
-		/* here r0 is forced to be precise and has to be
-		 * propagated back to the global subprog call, but it
-		 * shouldn't go all the way to mark r6 as precise
-		 */
 		"r1 += r0;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -213,11 +171,9 @@ static unsigned long loop_callback_bad()
 		"if r0 s> 1000 goto 1f;"
 		"r0 = 0;"
 	"1:"
-		"goto +0;" /* checkpoint */
+		"goto +0;"
 		/* bpf_loop() expects [0, 1] values, so branch above skipping
-		 * r0 = 0; should lead to a failure, but if exit instruction
-		 * doesn't enforce r0's precision, this callback will be
-		 * successfully verified
+		 * r0 = 0; should lead to a failure
 		 */
 		"exit;"
 		:
@@ -228,14 +184,8 @@ static unsigned long loop_callback_bad()
 
 SEC("?raw_tp")
 __failure __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-/* check that fallthrough code path marks r0 as precise */
-__msg("mark_precise: frame1: regs=r0 stack= before 11: (b7) r0 = 0")
-/* check that we have branch code path doing its own validation */
-__msg("from 10 to 12: frame1: R0=scalar(smin=umin=1001")
-/* check that branch code path marks r0 as precise, before failing */
-__msg("mark_precise: frame1: regs=r0 stack= before 9: (85) call bpf_get_prandom_u32#7")
-__msg("At callback return the register R0 has smin=1001 should have been in [0, 1]")
+/* 0 of the fallthrough code path doesn't stand for what the branch code path has */
+__msg("At callback return the register R0 has {{.*}} should have been in [0, 1]")
 __naked int callback_precise_return_fail(void)
 {
 	asm volatile (
@@ -256,41 +206,15 @@ __naked int callback_precise_return_fail(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-/* First simulated path does not include callback body,
- * r1 and r4 are always precise for bpf_loop() calls.
- */
 __msg("9: (85) call bpf_loop#181")
-__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: parent state regs=r4 stack=:")
-__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
-__msg("mark_precise: frame0: regs=r4 stack= before 8: (b7) r4 = 0")
-__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: parent state regs=r1 stack=:")
-__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
-__msg("mark_precise: frame0: regs=r1 stack= before 8: (b7) r4 = 0")
-__msg("mark_precise: frame0: regs=r1 stack= before 7: (b7) r3 = 0")
-__msg("mark_precise: frame0: regs=r1 stack= before 6: (bf) r2 = r8")
-__msg("mark_precise: frame0: regs=r1 stack= before 5: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (b7) r6 = 3")
-/* r6 precision propagation */
-__msg("14: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 14 first_idx 9")
-__msg("mark_precise: frame0: regs=r6 stack= before 13: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 12: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 11: (25) if r6 > 0x3 goto pc+4")
-__msg("mark_precise: frame0: regs=r0,r6 stack= before 10: (bf) r6 = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 9: (85) call bpf_loop")
-/* State entering callback body popped from states stack */
-__msg("from 9 to 17: frame1:")
 __msg("17: frame1: R10=fp0 cb")
 __msg("17: (b7) r0 = 0")
 __msg("18: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 9:")
-__msg("frame 0: propagating r1,r3,r4")
-__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r1,r3,r4 stack= before 18: (95) exit")
-__msg("from 18 to 9: safe")
+/* the callback changes nothing for the caller */
+__msg("from 18 to 9: within")
+__msg("14: (0f) r1 += r6                     ; R1=map_value(map=.data.vals,ks=4,vs=16,smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4) R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=12,var_off=(0x0; 0xc),step=0+4)")
 __naked int callback_result_precise(void)
 {
 	asm volatile (
@@ -309,9 +233,7 @@ __naked int callback_result_precise(void)
 		"if r6 > 3 goto 1f;"
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the bpf_loop() call, but not beyond
-		 */
+		/* here the range of r6 has to be known */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 	"1:"
@@ -326,15 +248,7 @@ __naked int callback_result_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("7: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 7 first_idx 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 6: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 5: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 11: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 10: (bf) r0 = r1")
-__msg("mark_precise: frame1: regs= stack= before 4: (85) call pc+5")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (b7) r1 = 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__msg("7: (0f) r1 += r6                      ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=12) R6=12")
 __naked int parent_callee_saved_reg_precise(void)
 {
 	asm volatile (
@@ -348,9 +262,7 @@ __naked int parent_callee_saved_reg_precise(void)
 
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the beginning, handling (and ignoring) subprog call
-		 */
+		/* here r6 has to be known: the subprog call doesn't change it */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -362,13 +274,7 @@ __naked int parent_callee_saved_reg_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("7: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 7 first_idx 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 6: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 5: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (85) call pc+5")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (b7) r1 = 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__msg("7: (0f) r1 += r6                      ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=12) R6=12")
 __naked int parent_callee_saved_reg_precise_global(void)
 {
 	asm volatile (
@@ -382,9 +288,7 @@ __naked int parent_callee_saved_reg_precise_global(void)
 
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the beginning, handling (and ignoring) subprog call
-		 */
+		/* here r6 has to be known: the subprog call doesn't change it */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -396,36 +300,14 @@ __naked int parent_callee_saved_reg_precise_global(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-/* First simulated path does not include callback body */
-__msg("12: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 12 first_idx 9")
-__msg("mark_precise: frame0: regs=r6 stack= before 11: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 10: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 9: (85) call bpf_loop")
-__msg("mark_precise: frame0: parent state regs=r6 stack=:")
-__msg("mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx 9")
-__msg("mark_precise: frame0: regs=r6 stack= before 8: (b7) r4 = 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 7: (b7) r3 = 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 6: (bf) r2 = r8")
-__msg("mark_precise: frame0: regs=r6 stack= before 5: (b7) r1 = 1")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (b7) r6 = 3")
-/* State entering callback body popped from states stack */
-__msg("from 9 to 15: frame1:")
+__msg("12: (0f) r1 += r6                     ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=12) R6=12")
 __msg("15: frame1: R10=fp0 cb")
 __msg("15: (b7) r0 = 0")
 __msg("16: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 9:")
-/* r1, r4 are always precise for bpf_loop(),
- * r6 was marked before backtracking to callback body.
- */
-__msg("frame 0: propagating r1,r3,r4,r6")
-__msg("mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r1,r3,r4,r6 stack= before 16: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 15: (b7) r0 = 0")
-__msg("mark_precise: frame1: regs= stack= before 9: (85) call bpf_loop")
-__msg("mark_precise: frame0: parent state regs= stack=:")
-__msg("from 16 to 9: safe")
+/* r6 is what it was before the callback */
+__msg("from 16 to 9: within")
 __naked int parent_callee_saved_reg_precise_with_callback(void)
 {
 	asm volatile (
@@ -442,9 +324,7 @@ __naked int parent_callee_saved_reg_precise_with_callback(void)
 
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the beginning, handling (and ignoring) callback call
-		 */
+		/* here r6 has to be known: the callback doesn't change it */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -458,19 +338,7 @@ __naked int parent_callee_saved_reg_precise_with_callback(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("9: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 9 first_idx 6")
-__msg("mark_precise: frame0: regs=r6 stack= before 8: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 7: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 6: (79) r6 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: parent state regs= stack=-8:")
-__msg("mark_precise: frame0: last_idx 13 first_idx 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 13: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 12: (bf) r0 = r1")
-__msg("mark_precise: frame1: regs= stack= before 5: (85) call pc+6")
-__msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r1 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__msg("9: (0f) r1 += r6                      ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=12) R6=12")
 __naked int parent_stack_slot_precise(void)
 {
 	asm volatile (
@@ -492,9 +360,7 @@ __naked int parent_stack_slot_precise(void)
 
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the beginning, handling (and ignoring) subprog call
-		 */
+		/* here r6 has to be known: the subprog call doesn't change it */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -506,15 +372,7 @@ __naked int parent_stack_slot_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("9: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 9 first_idx 0")
-__msg("mark_precise: frame0: regs=r6 stack= before 8: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 7: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 6: (79) r6 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-8 before 5: (85) call pc+6")
-__msg("mark_precise: frame0: regs= stack=-8 before 4: (b7) r1 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 3: (7b) *(u64 *)(r10 -8) = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__msg("9: (0f) r1 += r6                      ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=12) R6=12")
 __naked int parent_stack_slot_precise_global(void)
 {
 	asm volatile (
@@ -536,9 +394,7 @@ __naked int parent_stack_slot_precise_global(void)
 
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the beginning, handling (and ignoring) subprog call
-		 */
+		/* here r6 has to be known: the subprog call doesn't change it */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -550,38 +406,14 @@ __naked int parent_stack_slot_precise_global(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-/* First simulated path does not include callback body */
-__msg("14: (0f) r1 += r6")
-__msg("mark_precise: frame0: last_idx 14 first_idx 10")
-__msg("mark_precise: frame0: regs=r6 stack= before 13: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r6 stack= before 12: (27) r6 *= 4")
-__msg("mark_precise: frame0: regs=r6 stack= before 11: (79) r6 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: regs= stack=-8 before 10: (85) call bpf_loop")
-__msg("mark_precise: frame0: parent state regs= stack=-8:")
-__msg("mark_precise: frame0: last_idx 9 first_idx 0 subseq_idx 10")
-__msg("mark_precise: frame0: regs= stack=-8 before 9: (b7) r4 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 8: (b7) r3 = 0")
-__msg("mark_precise: frame0: regs= stack=-8 before 7: (bf) r2 = r8")
-__msg("mark_precise: frame0: regs= stack=-8 before 6: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs= stack=-8 before 5: (7b) *(u64 *)(r10 -8) = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (b7) r6 = 3")
-/* State entering callback body popped from states stack */
-__msg("from 10 to 17: frame1:")
+__msg("14: (0f) r1 += r6                     ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=12) R6=12")
 __msg("17: frame1: R10=fp0 cb")
 __msg("17: (b7) r0 = 0")
 __msg("18: (95) exit")
 __msg("returning from callee:")
 __msg("to caller at 10:")
-/* r1, r4 are always precise for bpf_loop(),
- * fp-8 was marked before backtracking to callback body.
- */
-__msg("frame 0: propagating r1,r3,r4,fp-8")
-__msg("mark_precise: frame0: last_idx 10 first_idx 10 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r1,r3,r4 stack=-8 before 18: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 17: (b7) r0 = 0")
-__msg("mark_precise: frame1: regs= stack= before 10: (85) call bpf_loop#181")
-__msg("mark_precise: frame0: parent state regs= stack=:")
-__msg("from 18 to 10: safe")
+/* fp-8 is what it was before the callback */
+__msg("from 18 to 10: within")
 __naked int parent_stack_slot_precise_with_callback(void)
 {
 	asm volatile (
@@ -604,9 +436,7 @@ __naked int parent_stack_slot_precise_with_callback(void)
 
 		"r6 *= 4;"
 		"r1 = %[vals];"
-		/* here r6 is forced to be precise and has to be propagated
-		 * back to the beginning, handling (and ignoring) subprog call
-		 */
+		/* here r6 has to be known: the subprog call doesn't change it */
 		"r1 += r6;"
 		"r0 = *(u32 *)(r1 + 0);"
 		"exit;"
@@ -621,27 +451,18 @@ __naked int parent_stack_slot_precise_with_callback(void)
 __noinline __used
 static __u64 subprog_with_precise_arg(__u64 x)
 {
-	return vals[x]; /* x is forced to be precise */
+	return vals[x]; /* x has to be known */
 }
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("8: (0f) r2 += r1")
-__msg("mark_precise: frame1: last_idx 8 first_idx 0")
-__msg("mark_precise: frame1: regs=r1 stack= before 6: (18) r2 = ")
-__msg("mark_precise: frame1: regs=r1 stack= before 5: (67) r1 <<= 2")
-__msg("mark_precise: frame1: regs=r1 stack= before 2: (85) call pc+2")
-__msg("mark_precise: frame0: regs=r1 stack= before 1: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 0: (b7) r6 = 3")
+__msg("8: (0f) r2 += r1                      ; R1=12 R2=map_value(map=.data.vals,ks=4,vs=16,imm=12)")
 __naked int subprog_arg_precise(void)
 {
 	asm volatile (
 		"r6 = 3;"
 		"r1 = r6;"
-		/* subprog_with_precise_arg expects its argument to be
-		 * precise, so r1->r6 will be marked precise from inside the
-		 * subprog
-		 */
+		/* subprog_with_precise_arg needs to know its argument */
 		"call subprog_with_precise_arg;"
 		"r0 += r6;"
 		"exit;"
@@ -666,7 +487,7 @@ static __u64 subprog_spill_reg_precise(void)
 		 * verifier log output)
 		 */
 		"*(u64 *)(r10 - 16) = r2;"
-		/* use both spills as return result to propagete precision everywhere */
+		/* use both spills as return result */
 		"r0 = *(u64 *)(r10 - 16);"
 		"r2 = *(u64 *)(r1 + 0);"
 		"r0 += r2;"
@@ -676,32 +497,14 @@ static __u64 subprog_spill_reg_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("10: (0f) r1 += r7")
-__msg("mark_precise: frame0: last_idx 10 first_idx 7 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r7 stack= before 9: (bf) r1 = r8")
-__msg("mark_precise: frame0: regs=r7 stack= before 8: (27) r7 *= 4")
-__msg("mark_precise: frame0: regs=r7 stack= before 7: (79) r7 = *(u64 *)(r10 -8)")
-__msg("mark_precise: frame0: parent state regs= stack=-8:  R8=map_value(map=.data.vals,ks=4,vs=16) R10=fp0 fp-8=P1")
-__msg("mark_precise: frame0: last_idx 18 first_idx 0 subseq_idx 7")
-__msg("mark_precise: frame0: regs= stack=-8 before 18: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 17: (0f) r0 += r2")
-__msg("mark_precise: frame1: regs= stack= before 16: (79) r2 = *(u64 *)(r1 +0)")
-__msg("mark_precise: frame1: regs= stack= before 15: (79) r0 = *(u64 *)(r10 -16)")
-__msg("mark_precise: frame1: regs= stack= before 14: (7b) *(u64 *)(r10 -16) = r2")
-__msg("mark_precise: frame1: regs= stack= before 13: (7b) *(u64 *)(r1 +0) = r2")
-__msg("mark_precise: frame1: regs=r2 stack= before 6: (85) call pc+6")
-__msg("mark_precise: frame0: regs=r2 stack= before 5: (bf) r2 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 4: (07) r1 += -8")
-__msg("mark_precise: frame0: regs=r6 stack= before 3: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 1")
+__msg("10: (0f) r1 += r7                     ; R1=map_value(map=.data.vals,ks=4,vs=16,imm=4) R7=4")
 __naked int subprog_spill_into_parent_stack_slot_precise(void)
 {
 	asm volatile (
 		"r6 = 1;"
 
 		/* pass pointer to stack slot and r6 to subprog;
-		 * r6 will be marked precise and spilled into fp-8 slot, which
-		 * also should be marked precise
+		 * r6 will be spilled into fp-8 slot
 		 */
 		"r1 = r10;"
 		"r1 += -8;"
@@ -716,8 +519,8 @@ __naked int subprog_spill_into_parent_stack_slot_precise(void)
 
 		"r7 *= 4;"
 		"r1 = %[vals];"
-		/* here r7 is forced to be precise and has to be propagated
-		 * back to the beginning, handling subprog call and logic
+		/* here r7 has to be known: it's what the subprog spilled into
+		 * the stack slot of its caller
 		 */
 		"r1 += r7;"
 		"r0 = *(u32 *)(r1 + 0);"
@@ -730,32 +533,12 @@ __naked int subprog_spill_into_parent_stack_slot_precise(void)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("17: (0f) r1 += r0")
-__msg("mark_precise: frame0: last_idx 17 first_idx 0 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 16: (bf) r1 = r7")
-__msg("mark_precise: frame0: regs=r0 stack= before 15: (27) r0 *= 4")
-__msg("mark_precise: frame0: regs=r0 stack= before 14: (79) r0 = *(u64 *)(r10 -16)")
-__msg("mark_precise: frame0: regs= stack=-16 before 13: (7b) *(u64 *)(r7 -8) = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 12: (79) r0 = *(u64 *)(r8 +16)")
-__msg("mark_precise: frame0: regs= stack=-16 before 11: (7b) *(u64 *)(r8 +16) = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 10: (79) r0 = *(u64 *)(r7 -8)")
-__msg("mark_precise: frame0: regs= stack=-16 before 9: (7b) *(u64 *)(r10 -16) = r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 8: (07) r8 += -32")
-__msg("mark_precise: frame0: regs=r0 stack= before 7: (bf) r8 = r10")
-__msg("mark_precise: frame0: regs=r0 stack= before 6: (07) r7 += -8")
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r7 = r10")
-__msg("mark_precise: frame0: regs=r0 stack= before 21: (95) exit")
-__msg("mark_precise: frame1: regs=r0 stack= before 20: (bf) r0 = r1")
-__msg("mark_precise: frame1: regs=r1 stack= before 4: (85) call pc+15")
-__msg("mark_precise: frame0: regs=r1 stack= before 3: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 1")
+__msg("17: (0f) r1 += r0                     ; R0=4 R1=fp-4")
 __naked int stack_slot_aliases_precision(void)
 {
 	asm volatile (
 		"r6 = 1;"
-		/* pass r6 through r1 into subprog to get it back as r0;
-		 * this whole chain will have to be marked as precise later
-		 */
+		/* pass r6 through r1 into subprog to get it back as r0 */
 		"r1 = r6;"
 		"call identity_subprog;"
 		/* let's setup two registers that are aliased to r10 */
@@ -777,11 +560,10 @@ __naked int stack_slot_aliases_precision(void)
 		"r0 = *(u64 *)(r8 + 16);"
 		"*(u64 *)(r7 - 8) = r0;"
 		"r0 = *(u64 *)(r10 - 16);"
-		/* get ready to use r0 as an index into array to force precision */
+		/* get ready to use r0 as an index into array */
 		"r0 *= 4;"
 		"r1 = %[vals];"
-		/* here r0->r1->r6 chain is forced to be precise and has to be
-		 * propagated back to the beginning, including through the
+		/* here r0 has to be known: the constant went through the
 		 * subprog call and all the stack spills and loads
 		 */
 		"r1 += r0;"
@@ -820,15 +602,11 @@ static unsigned long identity_tail_call(void)
 SEC("?raw_tp")
 __failure __log_level(2)
 __msg("13: (85) call bpf_tail_call#12")
-__msg("mark_precise: frame1: last_idx 13 first_idx 0 subseq_idx -1 ")
 __msg("returning from callee:")
 __msg("frame1: R0=scalar() R6=3 R10=fp0")
 __msg("to caller at 4:")
 __msg("R0=scalar() R6=map_value(map=.data.vals,ks=4,vs=16) R10=fp0")
 __msg("6: (0f) r1 += r0")
-__msg("mark_precise: frame0: regs=r0 stack= before 5: (bf) r1 = r6")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (27) r0 *= 4")
-__msg("mark_precise: frame0: parent state regs=r0 stack=:  R0=Pscalar() R6=map_value(map=.data.vals,ks=4,vs=16) R10=fp0")
 __msg("math between map_value pointer and register with unbounded min value is not allowed")
 __naked int subprog_result_tail_call(void)
 {
@@ -860,36 +638,22 @@ static int ld_abs_subprog(void)
 }
 
 /*
- * Buggy verifier did not properly backtrack early subprogram exit
- * modelled for BPF_LD | BPF_ABS instruction, causing a segfault.
+ * BPF_LD | BPF_ABS instruction is modelled as an early exit of the subprogram.
+ * r7 is known on both paths.
  */
 SEC("socket")
 __success
 __log_level(2)
-/* early exit path */
-__msg("3: (0f) r1 += r7")
-__msg("mark_precise: frame0: regs=r7 stack= before 2: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r7 stack= before 9: (20) r0 = *(u32 *)skb[0]")
-__msg("mark_precise: frame1: regs= stack= before 8: (bf) r7 = r1")
-__msg("mark_precise: frame1: regs= stack= before 7: (bf) r6 = r1")
-__msg("mark_precise: frame1: regs= stack= before 1: (85) call pc+5")
-__msg("mark_precise: frame0: regs=r7 stack= before 0: (b7) r7 = -8")
-/* fallthrough path */
-__msg("3: (0f) r1 += r7")
-__msg("mark_precise: frame0: regs=r7 stack= before 2: (bf) r1 = r10")
-__msg("mark_precise: frame0: regs=r7 stack= before 10: (95) exit")
-__msg("mark_precise: frame1: regs= stack= before 9: (20) r0 = *(u32 *)skb[0]")
-__msg("mark_precise: frame1: regs= stack= before 8: (bf) r7 = r1")
-__msg("mark_precise: frame1: regs= stack= before 7: (bf) r6 = r1")
-__msg("mark_precise: frame1: regs= stack= before 1: (85) call pc+5")
-__msg("mark_precise: frame0: regs=r7 stack= before 0: (b7) r7 = -8")
+/* the early exit and the exit of the subprogram give the same state */
+__msg("from 10 to 2: within")
+__msg("3: (0f) r1 += r7                      ; R1=fp-8 R7=-8")
 __naked int ld_abs_backtrack_both_paths(void)
 {
 	asm volatile (
 		"r7 = -8;"
 		"call ld_abs_subprog;"
 		"r1 = r10;"
-		"r1 += r7;" /* mark r7 as precise */
+		"r1 += r7;"
 		"*(u64 *)(r1 + 0) = 0;"
 		"r0 = 0;"
 		"exit;"
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index a9242103dc47..de9d35ed8a4b 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -36,26 +36,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 	.fixup_map_array_48b = { 1 },
-	.result = VERBOSE_ACCEPT,
-	.errstr =
-	"mark_precise: frame0: last_idx 26 first_idx 20\
-	mark_precise: frame0: regs=r2 stack= before 25\
-	mark_precise: frame0: regs=r2 stack= before 24\
-	mark_precise: frame0: regs=r2 stack= before 23\
-	mark_precise: frame0: regs=r2 stack= before 22\
-	mark_precise: frame0: regs=r2 stack= before 20\
-	mark_precise: frame0: parent state regs=r2 stack=:\
-	mark_precise: frame0: last_idx 19 first_idx 10\
-	mark_precise: frame0: regs=r2 stack= before 19\
-	mark_precise: frame0: regs=r9 stack= before 18\
-	mark_precise: frame0: regs=r8,r9 stack= before 17\
-	mark_precise: frame0: regs=r0,r9 stack= before 15\
-	mark_precise: frame0: regs=r0,r9 stack= before 14\
-	mark_precise: frame0: regs=r9 stack= before 13\
-	mark_precise: frame0: regs=r9 stack= before 12\
-	mark_precise: frame0: regs=r9 stack= before 11\
-	mark_precise: frame0: regs=r9 stack= before 10\
-	mark_precise: frame0: parent state regs= stack=:",
+	.result = ACCEPT,
 },
 {
 	"precise: test 2",
@@ -95,24 +76,8 @@
 	},
 	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
 	.fixup_map_array_48b = { 1 },
-	.result = VERBOSE_ACCEPT,
+	.result = ACCEPT,
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr =
-	"26: (85) call bpf_probe_read_kernel#113\
-	mark_precise: frame0: last_idx 26 first_idx 22\
-	mark_precise: frame0: regs=r2 stack= before 25\
-	mark_precise: frame0: regs=r2 stack= before 24\
-	mark_precise: frame0: regs=r2 stack= before 23\
-	mark_precise: frame0: regs=r2 stack= before 22\
-	mark_precise: frame0: parent state regs=r2 stack=:\
-	mark_precise: frame0: last_idx 20 first_idx 20\
-	mark_precise: frame0: regs=r2 stack= before 20\
-	mark_precise: frame0: parent state regs=r2 stack=:\
-	mark_precise: frame0: last_idx 19 first_idx 17\
-	mark_precise: frame0: regs=r2 stack= before 19\
-	mark_precise: frame0: regs=r9 stack= before 18\
-	mark_precise: frame0: regs=r8,r9 stack= before 17\
-	mark_precise: frame0: parent state regs= stack=:",
 },
 {
 	"precise: cross frame pruning",
@@ -153,17 +118,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "mark_precise: frame0: last_idx 5 first_idx 5\
-	mark_precise: frame0: parent state regs=r4 stack=:\
-	mark_precise: frame0: last_idx 4 first_idx 2\
-	mark_precise: frame0: regs=r4 stack= before 4\
-	mark_precise: frame0: regs=r4 stack= before 3\
-	mark_precise: frame0: last_idx 5 first_idx 5\
-	mark_precise: frame0: parent state regs=r0 stack=:\
-	mark_precise: frame0: last_idx 4 first_idx 2\
-	mark_precise: frame0: regs=r0 stack= before 4\
-	5: R0=-1 R4=0",
-	.result = VERBOSE_ACCEPT,
+	.result = ACCEPT,
 	.retval = -1,
 },
 {
@@ -182,23 +137,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "mark_precise: frame0: last_idx 7 first_idx 7\
-	mark_precise: frame0: parent state regs=r4 stack=:\
-	mark_precise: frame0: last_idx 6 first_idx 4\
-	mark_precise: frame0: regs=r4 stack= before 6: (b7) r0 = -1\
-	mark_precise: frame0: regs=r4 stack= before 5: (79) r4 = *(u64 *)(r10 -8)\
-	mark_precise: frame0: regs= stack=-8 before 4: (7b) *(u64 *)(r3 -8) = r0\
-	mark_precise: frame0: parent state regs=r0 stack=:\
-	mark_precise: frame0: last_idx 3 first_idx 3\
-	mark_precise: frame0: regs=r0 stack= before 3: (55) if r3 != 0x7b goto pc+0\
-	mark_precise: frame0: regs=r0 stack= before 2: (bf) r3 = r10\
-	mark_precise: frame0: regs=r0 stack= before 1: (57) r0 &= 255\
-	mark_precise: frame0: parent state regs=r0 stack=:\
-	mark_precise: frame0: last_idx 0 first_idx 0\
-	mark_precise: frame0: regs=r0 stack= before 0: (85) call bpf_get_prandom_u32#7\
-	mark_precise: frame0: last_idx 7 first_idx 7\
-	mark_precise: frame0: parent state regs= stack=:",
-	.result = VERBOSE_ACCEPT,
+	.result = ACCEPT,
 	.retval = -1,
 },
 {
-- 
2.55.0

