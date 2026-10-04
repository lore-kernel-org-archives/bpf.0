Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC2439322
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121151; cv=none; b=qlsQRBk2XOmfI+nIhanGus5P5QZEHxFOFA2d8nn+dt+qdwiEvNTzRuhzO5EFgvbteksYPjEgWcbynF5GI6Em5cFrBpGadWCDk1B4027dpE17o8NvvZ1tibWqF2VbhZepwqKUPDxiUvF3tGjSQLU9OSKu3bwIexxF3wyH8W6+3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121151; c=relaxed/simple;
	bh=ShuKYciajMlv1+Du577c5PJB6U8Ed20U/lyQpEib8R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqXREr2Mimiyt/r/8XRXJmFJbXq1B+s84NpMISoChODscCP0w0r1DE3RTfm8Qs81eiX10OlAagHLCktL6XFhB7JxLj7TD6U1aC2ButNeZOwgUfnBk7T3mh1JHwTizh2dKahTdqA2y6SQyd5odtUwj44W5duz+wKfGVgXi/gQNok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYOHBiUO; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYOHBiUO"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a7e13e2a77so125343a91.3
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121149; x=1791725949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c3CSUc22gDqZGhnsrfslTbzK+aA8wU4KGDY1eZ/m6EU=;
        b=DYOHBiUOxMkFkk2vIrxuDL7pm/1v8BxtjJyhWeUfrjJPv8z7xlZTjvtGxSZgqFDl26
         g9tmGnQb6Vyb2gd9BKLiqruCmAUWgplCDfzqDamsEyRNB8cYdEmA+gcN0H4EmuHB+3kJ
         B83PEXajJVWXKMsYEOETVwmT2ps8u1a0MH+V1KIrt06q70OHyllDrg7Z/tS4Ie0e0oKp
         DenAPRvfeRTaBLn8PqJNi3c6Bsg+49T3tHNGATXGujrXndH9/R8S1cEu9SJ/aIaWLXpo
         Ag7SmxKEhu73tnR5YKRG2VrFQv86mU3mq/qXm6hTJRjDMmoOEb20SlFQrr4RWHv1FD8H
         QH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121149; x=1791725949;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c3CSUc22gDqZGhnsrfslTbzK+aA8wU4KGDY1eZ/m6EU=;
        b=kfNqWI6NNQZZDg5M+YWjswTTIXKoBTCkwGvsxoNJTUXMROZI0tswwP02l+rGLqCo1U
         5T75KQpohAvdN76AVBXknN7fB6uYRglt48gwKFXz1C+QpNorusUp/sbyozNMdNc6/wf7
         tZcLsYLuU3a4Hpe+IJQiXSS6L5sX0ZTg2zCO48UvdFfJOrsm/Ku8SdAywntYdG3jf+yC
         3Uc4j5vhfEiwEJ2yE/ulOXtSqYX3TNWFjmMla2IvJr9Vngq8T7cSPb3+Kq2q8XDJECfe
         jntvExwTbzzDnOQUxC5Cj5B5WTJjyqpElihRBwLrIAte2RH+3Qg/rNg1XqkmXnnfdmL+
         a+Rg==
X-Gm-Message-State: AFq9FYJ+gly1Erm3r2fFd/RovNH7WNpozT+0IWDVLTH+x/f5Ehu4IOps
	q0N5LzvGWJKXlbuvkm4td1a7FMlZ65aUMz6mdhDBqZ//yLBzFv0hlgzwAG2l2w==
X-Gm-Gg: AYBFou3yrcintmp5oxekcdxWxb7TSFOL/kcafln2SPuflnD2XSXPlL62DfHNBMBlsTN
	DZFGPHaWTf+mOp4bF4pP2UFZOqZU1tjLIJ3Xi3otpPWOuSNW7EcvvJmyEQt9mJWMxxjulxSYSfY
	wKJcqG5kWg1lfFsxX+o4Y3l8ldsaBTPWWW6XCUzJBkGr+QXj7yG38O/EJBuZrdG+/mAz/4YegR9
	K1O7SEHnwXOt5DJbXrK5b7R4AwubYKCqW1kiNT7Kt9MnDNTnXM36RqigXpbNpz82pZZNoDTe8L+
	S1P+TSwR5Sm22txtfmBlUM75yz7QJcu+pcFGJezbgMas4Gu0/ePs30VogZ0sn3I6NEJw9O7iW0Y
	evDv3Eni3T9cym1SW2rk3nszzGQp4eRMhe5Ijc0Od0yPYUFfhwcaoyiaMOLrMDLZIszFY2WxyZl
	89V0+akHjhsF22mx8W9m5s0dvDwAG+m+dd2Vp8vaVdy2ROohCkD1cmXxJU0crJkW213RiFdlOFW
	OqfNoMbR34jkFPSgav2a0Kf+Q==
X-Received: by 2002:a17:90b:5106:b0:39e:2192:97dc with SMTP id 98e67ed59e1d1-3a78351960fmr3008427a91.6.1791121149488;
        Sun, 04 Oct 2026 06:39:09 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 36/43] selftests/bpf: tests for may_def marks of atomic RMW operations
Date: Sun,  4 Oct 2026 06:38:18 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-36-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Liveness analysis should produce may_def marks for read-modify-write
atomic operations:
- lock *(u64 *)(r10 -8) += r1
- r1 = atomic64_fetch_add((u64 *)(r10 -8), r1)
- r1 = atomic64_xchg((u64 *)(r10 -8), r1)
- r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r1)

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index a06156c18c9e..5b0fcef1f571 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2674,6 +2674,32 @@ __naked void load_acquire_dont_clear_dst(void)
 
 #endif /* CAN_USE_LOAD_ACQ_STORE_REL */
 
+SEC("socket")
+__log_level(2)
+__success
+__msg("lock *(u64 *)(r10 -8) += r1{{.*}}use: fp0-8{{.*}}may_def: fp0-8")
+__msg("r1 = atomic64_fetch_add((u64 *)(r10 -8), r1){{.*}}use: fp0-8{{.*}}may_def: fp0-8")
+__msg("r1 = atomic64_xchg((u64 *)(r10 -8), r1){{.*}}use: fp0-8{{.*}}may_def: fp0-8")
+__msg("r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r1){{.*}}use: fp0-8{{.*}}may_def: fp0-8")
+__naked void atomic_rmw(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	".8byte %[atomic_add];"
+	".8byte %[atomic_fetch_add];"
+	".8byte %[atomic_xchg];"
+	"r0 = 0;"
+	".8byte %[atomic_cmpxchg];"
+	"exit;"
+	:
+	: __imm_insn(atomic_add, BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_1, -8)),
+	  __imm_insn(atomic_fetch_add, BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8)),
+	  __imm_insn(atomic_xchg, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_10, BPF_REG_1, -8)),
+	  __imm_insn(atomic_cmpxchg, BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8))
+	: __clobber_all);
+}
+
 SEC("socket")
 __success
 __naked void imprecise_fill_loses_cross_frame(void)

-- 
2.53.0
