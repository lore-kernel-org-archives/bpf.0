Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022906;
	b=bsSbRu+MX216D/1+R6Y5gneEfK0kKcnX7Uwc1p9FfvUcoPjFX1J7q+tee5bJtBnv9lz/
	 2bSZSiD2VGUhWyqTxEvViMn2uYYl7xcjbf7HNWn/XeHfky6axzO7mZhPqKAyZPh5n361Z
	 IaQMIEopZ2DbBWBth+fVgoCyc7fr4lG2axf7AVX5jfsPOHihOofeKTRXe9ZeI/JbROQkb
	 DoUXrvQQNOyTP7TDrMFj8apX+VIaHhKvXZnEggw+3p/tenYkzuWvpLUHCjrk7W9Rvr58J
	 ztJCD0YYP6a1+hu6alMhaWeAdeaPmk2ACWbhOuR4H1RoZGEXBjLe75mB0uPeBe6WTFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kVEtveuUhAAoh4cHp6jHtam41YuQVHj64X5hQcMZHlA=;
	b=FMKByod2HHO03W4GQo9zcRIqRF+nsnw0vam3DPU9n/q+/H3x+gkul4vkdTAWqX92kUIs
	 oCUCvtRWjFJ/9OaLZVnCVKZ2n0wHnUtGKRU6AFJxoMUIY9MF+1xnYh38y7F8TI30hGxbn
	 cCJXMA7jdfJJsR8HSi4gzMET64zBR1pn/RtkvJ7hvwvFNLPxBEikXH23yDa2sKoEKAaB2
	 j9zsV9vR819CL3z0V7iPmgu1vt8wCpZKKsPHqVscPGjloEgHE5y/chWoDfrdXQso6lpIs
	 3r+OukOX7ltMq0ForqFleCh3Hya0cF7+/l56ZhCiD7cTskE6Rl30vs9CbuPYbkN53UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FkFInZyB;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8100606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8100606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FkFInZyB
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9d7791b00so9130645ad.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022905; x=1794627705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kVEtveuUhAAoh4cHp6jHtam41YuQVHj64X5hQcMZHlA=;
        b=FkFInZyBAfdyTS6Dgjf9r5WnuMr0iDe7u10CxO7Vc0g5OBXQreejJSIP4oceOOhp/g
         9t2215Ej20t4XYcPCbQAEGp7p/M8QyROIf4GwyYMmST8d5yQi1AWIqO6b1lK6/H56jcr
         /iHjpmnHXyXNp6wZWPyfer6kwrD45RXtfgmIVEODU9wFEDo+uwENldZOe5kFSrvzReMC
         MRGaoBxFIGZBLuwFFPG0461Ie0NYyelUrgGOFfUpLY9a2NUyW3HdMv3zgRLa+OfY2rLD
         jqMXZ7wM0+dvZqRAcdXNGYuwSAl6d08YBICd34fwBAS21oxdk96mbMnn8n6585yoVuMM
         I5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022905; x=1794627705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kVEtveuUhAAoh4cHp6jHtam41YuQVHj64X5hQcMZHlA=;
        b=spsYVGi5mEVaELWWgPCvOJXRAJmkkX89O6bewi3TQlTBqa+ZthshTyxsYHoUs/4TyN
         MXKTM3vFO53H1teV5Mwy0HpRUchM9U2/IPHyzKj8vuhQcC5kK1J84VTciXUReHVffycT
         V1dwUNoJlp51cc2qFYoT79aitPPXs436qaeWU3yBpPKYHUoGH6vABrhdQzqTpc6KE38i
         xpsNmchXG/qC50asuVoeGjtCwdKKzijw6MTVViY+7qe5IQRYiV2Ts74wAOGIksctXK3w
         lcW93CwOOWzjxkoAtWWMB+R0fDPO7zdx45RQPTDLyl+wpkdA2OpAIrpuhXc3p/NMDXZM
         qDjg==
X-Gm-Message-State: APuU4Z8KFlfbsni7v0hComT2ICLr9eJlRMGHIQ3HYhuW2Q6U01e7bIVa
	srLJ4sGoY3vDiFXD2VNCdmCGkrGpTgCFbdaWHC1kd7TbWr4TgQD9XbF7zOpqKA==
X-Gm-Gg: AYBFou368JVer8GdjMbcc8wH+xGKOzaUuG47tgF5qcx4FZov/DUzOkWNioMQnAe3GGV
	1hCgD0GKQfQ1qqlq9DnjFpPUxmT5IfCIpZl/sdzNVwqIS14IuSCiX5sl40XRE7UMPGHfOgT/ZVV
	hwT7nSO39B7BgpGYjHGN2FGiChyawn+jxIXLGS2T0w23+Mo00QvS+eAHl8U0suDRu0esrSECVpW
	GvG98yebA97zpdeou5SWOSxBMYLknXhArlG3kzBWhqwCHk6W5QYq2tEWGYkp8S/0D6ty5paWJGs
	AcNppUwmCuQfkVnLwjO/tjfTu86xwxQCYHZnnIjxNMk47K81WXUDi7B2rvNg426+jbpySQsrRAX
	R9+OnwfVAfL5yIr2UK2obScR5xWiWIvU3yptmqYxSPDmvwUXKpyF/tZUu1k3Dh06qddJA7AzYx1
	v+ZCCzVF+fcfqrve/Y9vBu+7W4XzzuuPjBNWJ6TlQ31YwUpXzOGqF1fr4pH9vtArtEYuK6gCICA
	rdsB855MHuK+ypiDh7pNi+SIHn4LBSYwQESZEk3sc4NvPiS5IHOousgb/r0qOPIL8MhPUssZ/CV
	qqoZDecdrJyfGt5PrGPz9WEZMlWAhzc3OZ5rENQrDqNwKuJ6zXmHjU61aqO0t3VfGy+VWCr/ZeE
	yvDNCSMeYg+8PwC17qVH/Qy+JQ0Z3wD7scwhjS11IYjt94MohQjOKkyk6pVkzQxnDfxVnlAKOKQ
	==
X-Received: by 2002:a05:6a21:70cb:b0:3e1:e6ad:9ffd with SMTP id adf61e73a8af0-3ebb29f22afmr4313296637.37.1794022905164;
        Fri, 06 Nov 2026 19:41:45 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a75423sm1099049a12.21.2026.11.06.19.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:41:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 37/46] bpf: 32-bit add to a pointer and pointer op pointer make a number
Date: Sat,  7 Nov 2026 03:37:45 +0000
Message-ID: <20261107033758.1547725-38-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

xdp_synproxy_kern.c:

  /* Without volatile the verifier throws this error:
   * R9 32-bit pointer arithmetic prohibited
   */
  volatile u64 old_len = data_end - data;

  if (bpf_skb_change_tail(ctx, old_len + TCP_MAXLEN - hdr->tcp_len, 0))

test_tcp_custom_syncookie.c has the same comment. The argument is a u32,
so the compiler adds in 32 bits and in the order that it likes,
data_end - (data + tcp_len) + 60:

  151: w9 += w6                    ; R9=pkt()
  152: w8 -= w9                    ; R8=pkt_end()
  153: w8 += 60

exhandler_kern.c had 'if (!work && !func)' with two pointers, which is
'r2 |= r1': 'R2 pointer |= pointer prohibited'. Commit 44df171a10f8
("selftests/bpf: Workaround a verifier issue for test exhandler") wrote
it in another way. The C code wants a number in both cases.

Commit 72c0681c0e75 ("bpf: Allow bitwise ops, shifts and mul/div on
pointers with CAP_PERFMON") made a number of the result of every op on
a pointer and a number but += and -=. 32-bit -= and pointer -= pointer
have always made one. That leaves 32-bit += and the other ops on two
pointers. Do the same for them: the result is an unknown number. The
prog is rejected where it uses the number as a pointer:

  w0 += 0                          ; R0=map_value -> scalar
  *(u64 *)(r0 + 0) = r1            ; R0 invalid mem access 'scalar'

64-bit += and -= of a pointer and a number keep the pointer, as before.
Nothing changes without CAP_PERFMON.

Three tests go through the result of such an op: they are rejected by
the next insn. 'unpriv: add pointer to pointer' and
verifier_scev/ptr_map_value_alu32_latch do nothing with it: they load.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                                | 12 ++++++------
 .../selftests/bpf/progs/verifier_array_access.c      |  4 ++--
 tools/testing/selftests/bpf/progs/verifier_scev.c    |  3 +--
 tools/testing/selftests/bpf/progs/verifier_unpriv.c  |  4 ++--
 .../selftests/bpf/progs/verifier_value_illegal_alu.c |  4 ++--
 .../selftests/bpf/progs/verifier_value_ptr_arith.c   |  4 ++--
 6 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8dff321ea723..09a44723bb2e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16911,7 +16911,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 
 	dst_reg = &regs[dst];
 	/*
-	 * Only += and -= keep a pointer. Any other op makes a number of it,
+	 * Only 64-bit += and -= keep a pointer. Any other op makes a number of it,
 	 * which is fine when the program may see values of pointers anyway.
 	 */
 	to_scalar = opcode != BPF_ADD && opcode != BPF_SUB && env->allow_ptr_leaks;
@@ -16927,7 +16927,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 
 	if (BPF_CLASS(insn->code) != BPF_ALU64 && !to_scalar) {
 		/* 32-bit ALU ops on pointers produce (meaningless) scalars */
-		if (opcode == BPF_SUB && env->allow_ptr_leaks) {
+		if (env->allow_ptr_leaks) {
 			bpf_mark_reg_unknown(dst_reg);
 			return 0;
 		}
@@ -18218,11 +18218,11 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	if (BPF_SRC(insn->code) == BPF_X) {
 		if (src_reg->type != SCALAR_VALUE) {
 			if (dst_reg->type != SCALAR_VALUE) {
-				/* Combining two pointers by any ALU op yields
-				 * an arbitrary scalar. Disallow all math except
-				 * pointer subtraction
+				/*
+				 * Combining two pointers by any ALU op yields
+				 * an arbitrary scalar.
 				 */
-				if (opcode == BPF_SUB && env->allow_ptr_leaks) {
+				if (env->allow_ptr_leaks) {
 					mark_reg_unknown(env, regs, insn->dst_reg);
 					return 0;
 				}
diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 9333321c3ac8..14d16f35f8ac 100644
--- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -311,8 +311,8 @@ l0_%=:	exit;						\
 
 SEC("socket")
 __description("invalid map access into an array with a invalid max check")
-__failure __msg("R0 pointer += pointer")
-__failure_unpriv
+__failure __msg("R0 invalid mem access 'scalar'")
+__failure_unpriv __msg_unpriv("R0 pointer += pointer")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void with_a_invalid_max_check_2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 07c356fde68d..abe2b1911079 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3842,10 +3842,9 @@ __naked void ptr_map_value_jmp32(void)
 }
 
 SEC("xdp")
-__failure
+__success
 __log_level(2)
 __msg("loop header at 11, can't compute iterations count")
-__msg("R6 32-bit pointer arithmetic prohibited")
 __naked void ptr_map_value_alu32_latch(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index b9d96366e656..1d255b04565d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -140,8 +140,8 @@ __naked void unpriv_add_const_to_pointer(void)
 
 SEC("socket")
 __description("unpriv: add pointer to pointer")
-__failure __msg("R1 pointer += pointer")
-__failure_unpriv
+__success __failure_unpriv __msg_unpriv("R1 pointer += pointer")
+__retval(0)
 __naked void unpriv_add_pointer_to_pointer(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
index 209d5be55155..455f2399492b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_illegal_alu.c
@@ -46,8 +46,8 @@ l0_%=:	exit;						\
 
 SEC("socket")
 __description("map element value illegal alu op, 2")
-__failure __msg("R0 32-bit pointer arithmetic prohibited")
-__failure_unpriv
+__failure __msg("R0 invalid mem access 'scalar'")
+__failure_unpriv __msg_unpriv("R0 32-bit pointer arithmetic prohibited")
 __naked void value_illegal_alu_op_2(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index b3b701b44550..454b9a92d5c1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -1156,8 +1156,8 @@ l0_%=:	r0 = 2;						\
 
 SEC("socket")
 __description("map access: value_ptr += value_ptr")
-__failure __msg("R0 pointer += pointer prohibited")
-__failure_unpriv
+__failure __msg("R0 invalid mem access 'scalar'")
+__failure_unpriv __msg_unpriv("R0 pointer += pointer prohibited")
 __naked void access_value_ptr_value_ptr_1(void)
 {
 	asm volatile ("					\
-- 
2.55.0

