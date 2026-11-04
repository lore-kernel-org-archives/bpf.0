Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762843;
	b=c4qREIZNkW1WmjLLRVjtOIaKs0ncJ7EArDd0ERD3aqgtlmIiq/V2PbeeNRB3MhRLWheF
	 mche1FAlL+Lx7Zt0W5s4Fsnv3h9zVv/2QDCi0U5ggbWsJQE7SbrDYnAs06PUjv9rE01+O
	 iePvKSoLAoFszE3ZO9NEBq8EazSMbFhupJRPZghJYXmyIogutrA5RcPyLmKhl/wZxtmUB
	 vYej8Qt4pcsvNRBKq4a4LaQbNCZ/82x4+eQzUn6Ah+ThZEFnEwQEAgvGwi40WgUJojY/1
	 cWaxbbnHgH27fCFfEcXzKptnjwd132pyo5gef+KTfYKdtdV0v3QcHx7UTs7QxTimUfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BFr+2EFgu1Nhb0O0fEPP4E9HWvVTMR4rapiR13PNnbM=;
	b=A+GRmIEVongd7M49i4TMrFYvf64WKht+69qwKPp1nj+IVGuRJlqD5vKA6uUgWQ/1cdpk
	 FVCy5mNj8thNFNSS938cumlcX7k76sIAbFBk/sc1muQ/fkxnQUxG6nl49wPz4+fyPFvbI
	 2dZPZowcvmI0OJgpFH4rtZ/PEDllfNjzpnbK5rDH8UOrOH86/jtHmiN3Ay59VD9oLWaOo
	 8L6pM8YSjdYDcqP/2lABPrsmQMp+gpow+M9BZi05OmbYmQi0PY+Aqp32WSExLDX4Lj8CI
	 S9gIAUmdFoOL5QdA6my56MgdKFzvKqp+HFjcp2Kp9XfJtVUGrAS9cGTBj1DfPEo+HIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TPkM8k9+;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C6B606D81C
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 03:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C6B606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TPkM8k9+
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso111851eec.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 19:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793762842; x=1794367642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BFr+2EFgu1Nhb0O0fEPP4E9HWvVTMR4rapiR13PNnbM=;
        b=TPkM8k9+c67hAid6Zd+6QpWcr2wBU43iV09DyDAJjer2cCS1BBUg8u4DYr3EIiihVq
         LyltlVq3FNxn69cYkcbTZfbl2IXcxwzmOEzr/6ld4+daTSaC7e6U5KDBpQUZmBhVWhV2
         YantVUmta5PgKluUMCOVjJHrvIJZbXvmBvFa+HatSLo+NoQ41G/jDUB6TaYfcL95C/J2
         YOp97EfwGUn9J6N0ikEstVZ4eJoJERg8RwJ/zu0Ftkfy9hQU5Jj6U1EJ4zitujOFAgzM
         lbGKIMOxgc5tGW8hSVSJo1oEjioTOohBb0/wCeDDw6aA78Ddu1OsWd4KTOlws8miYld1
         DShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793762842; x=1794367642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BFr+2EFgu1Nhb0O0fEPP4E9HWvVTMR4rapiR13PNnbM=;
        b=WBgxk9u9FdKCvYQ0JCl8Gdyibnsgm0vgdM3o5yand8lo0mYkcO9DlYLSVeDRgGPP4y
         EFgwaAdWvY9mK7z9hhx9z7oNvQ2tZdv/D1fWXBfInkIEqPZFX2tJPVuHkcDLPojSIbt9
         0qUXFx8bHSIoQYrvxkfPe20iRdM3vxOULLBGknGQpTqqlGpXsmv2NjoNDY6XnrCo/G49
         0BTdrJMpF68kxukmjeuN4IsSUDiWXRXKJT1ltbrXcauJWucXytb/45V80hnX58jn7KyQ
         CEjco2MFQNj2Yc2NfS1rQ9JHTLGLbT6Dy2MmnL74nt38njsvGwqnkPUCcuG7Vz0jua3r
         5K7A==
X-Forwarded-Encrypted: i=1; AKwUvByUdQTOKHI8jsC1Cnfom5UY5ZoB8kTl4Obu7Wdbok0mvciGynu1hhJBFqxx6/Pi1TA45FE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5flOd/EQvFDetfBgvBAgVJwg1OzXYT8FSciEnBK7yJghLhDeY
	wBYK9j7y6gNxMMwyRWy3RR4ooVCPBTHvso/0M/R8Ab1GwswFrao8zPwu
X-Gm-Gg: AYBFou18UEveOZzAgDdJZu+IFuvIclKWyC8n9u7gCiXvg4n49k6Wb5/CavyLEnAiroU
	hUjCPFnE8PXmKcnLqe+MJeb/xKI/U1y90OR13iLScplEyCHaxBQX8Z4KO5E/cz3Ne7QWi/YvS1S
	e2bTzF1wG5Y/E7O4APKTcF3kkLM7s7SiX6XQTrEL1GQUbFF1EOTyA9H+ucwJdG0K0TZ4ONvzwyu
	pXJurEwpY50NI9g3kwDZjgswU67EfJG7ZzEmqdg3w0N2wMufzgCzXxbv2QjoVn1SnRjNa+chE4P
	dl6mAB4vzxGuGUkSRFjMmcafb/k3TznkPueLn35Qef+u90U+5JR3enkSc2o4oLEsI+sIioNcCvA
	nzIR0GDyA9y0NHxw8PZBVq7qoCXG0JrBVUbYeyp+OQpp2vHfD1w0/Of3mYXs64vLnVTkFsrpIBL
	d+/x14Vju0lSnWO5N2n7pPoUHKLB3xxAMfNjFsW/d/GzczU+4mLtYa19auan6LiUeLRposcZMdr
	RLV4VpkjirlP7DjbtSryFa6Z+hm1t3hBafETZK11nsHbMoNNCGdZqwU1CO53YB4K6FNr8y9DMBo
	rmiJDY9B4KQFfXrXM7Qr7iP3nvtiV8VbBLvZPVO93KFSD03R2qtI+3OblL09yl7mcorqAwhBuIW
	hvuygDuJ3PGXImy4aoULURGEFTj3KYY8SxZvPaA==
X-Received: by 2002:a05:701b:2806:b0:159:2c6d:fcc3 with SMTP id a92af1059eb24-1ac5d2c5b1cmr22007721c88.33.1793762841634;
        Tue, 03 Nov 2026 19:27:21 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c127sm3574613c88.6.2026.11.03.19.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 19:27:21 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ast@kernel.org,
	bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH bpf-next] bpf: Use 64-bit writes when inlining bpf_loop
Date: Wed,  4 Nov 2026 03:27:00 +0000
Message-ID: <20261104032700.55296-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The error path in inline_bpf_loop() writes -E2BIG with BPF_MOV32_IMM(),
zero-extending it to 0x00000000fffffff9 instead of the 64-bit negative
value returned by the helper. A caller keeping the result in a long
therefore misses the error when testing ret < 0.

Use BPF_MOV64_IMM() for the error return and loop-counter initialization.
Neither write needs truncation, and this avoids the extra zero extensions
required by the s390 and RISC-V JITs.

Keep the helper result in a long before checking it in the existing
bpf_loop test, so its over-limit case catches the wrong upper bits.
Drop the now redundant architecture-specific expectations from
patch_list_insert_in_front().

Fixes: 1ade23711971 ("bpf: Inline calls to bpf_loop when callback is known")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/DMM0E6AA3KB6.28SYB9X6ZYIHL@gmail.com/
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 kernel/bpf/fixups.c                            |  4 ++--
 tools/testing/selftests/bpf/progs/bpf_loop.c   |  8 +++++---
 .../selftests/bpf/progs/verifier_patch_list.c  | 18 ------------------
 3 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6b719a28be68..321624a4b2b3 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2783,7 +2783,7 @@ static int inline_bpf_loop(struct bpf_verifier_env *env, int position,
 	 * expected number of iterations is too big.
 	 */
 	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);
-	insn_buf[cnt++] = BPF_MOV32_IMM(BPF_REG_0, -E2BIG);
+	insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, -E2BIG);
 	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JA, 0, 0, 16);
 	/* spill R6, R7, R8 to use these as loop vars */
 	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset);
@@ -2791,7 +2791,7 @@ static int inline_bpf_loop(struct bpf_verifier_env *env, int position,
 	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset);
 	/* initialize loop vars */
 	insn_buf[cnt++] = BPF_MOV64_REG(reg_loop_max, BPF_REG_1);
-	insn_buf[cnt++] = BPF_MOV32_IMM(reg_loop_cnt, 0);
+	insn_buf[cnt++] = BPF_MOV64_IMM(reg_loop_cnt, 0);
 	insn_buf[cnt++] = BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3);
 	/* loop header,
 	 * if reg_loop_cnt >= reg_loop_max skip the loop body
diff --git a/tools/testing/selftests/bpf/progs/bpf_loop.c b/tools/testing/selftests/bpf/progs/bpf_loop.c
index 1d194455b109..7a8ae1110c0a 100644
--- a/tools/testing/selftests/bpf/progs/bpf_loop.c
+++ b/tools/testing/selftests/bpf/progs/bpf_loop.c
@@ -66,14 +66,16 @@ SEC("fentry/" SYS_PREFIX "sys_nanosleep")
 int test_prog(void *ctx)
 {
 	struct callback_ctx data = {};
+	long ret;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 0;
 
-	nr_loops_returned = bpf_loop(nr_loops, callback, &data, 0);
+	ret = bpf_loop(nr_loops, callback, &data, 0);
+	nr_loops_returned = ret;
 
-	if (nr_loops_returned < 0)
-		err = nr_loops_returned;
+	if (ret < 0)
+		err = ret;
 	else
 		g_output = data.output;
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_patch_list.c b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
index a9ad1dc56c3a..581b75b7b5c5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_patch_list.c
+++ b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
@@ -298,23 +298,6 @@ __arch_arm64
 __arch_riscv64
 __arch_loongarch
 __success
-/* The verifier adds two zero extensions for these JITs. */
-#if defined(__TARGET_ARCH_s390) || defined(__TARGET_ARCH_riscv)
-__xlated("25: call pc+7")
-__xlated("...")
-__xlated("32: exit")
-__xlated("33: r0 = ")
-__xlated("35: r0 = &(void __percpu *)(r0)")
-__xlated("36: r0 = *(u64 *)(r0 +0)")
-__xlated("37: if r0 != 0x0 goto pc+2")
-__xlated("38: r0 = 1")
-__xlated("39: exit")
-__xlated("40: r1 += -1")
-__xlated("...")
-__xlated("51: if r1 != 0x0 goto pc-12")
-__xlated("52: r0 = 0")
-__xlated("53: exit")
-#else
 __xlated("23: call pc+7")
 __xlated("...")
 __xlated("30: exit")
@@ -329,7 +312,6 @@ __xlated("...")
 __xlated("49: if r1 != 0x0 goto pc-12")
 __xlated("50: r0 = 0")
 __xlated("51: exit")
-#endif
 __naked void patch_list_insert_in_front(void)
 {
 	asm volatile (

base-commit: 8fb43ffc3327d12d57d3fbe6f4820b5a522de0d1
-- 
2.43.0

