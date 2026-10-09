Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80364CC611
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542946; cv=none; b=qDWGu80TRCntl4uY2uDoEyXF2opu12Is8NmOCUUEvtf/ds58KKnOkHi/aW9HFXAuJm1ZJ1FZwyGZCT0C6dFr/OQSMUYe+Td1UEBHztOrPY+fuGePptIgF20B7mFcnCqMf7y2yNJZcRRHV7v1bymdyGu4xzJcE5EoughMIee19qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542946; c=relaxed/simple;
	bh=cBhrMZDaBH/doQ43iAQY+jJIUp2akvgqwFfaGRyDmO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmVH5nz98S+doPBKaBou2aVIlepnB63AWNjol5MW5nuZmNBz4CPoDhDMzJ8HlNn05cddeh9GJWnDOLGFCJ9uzvDRWJxA3N0h0hrmasV6qxgLxkeNvJXNfYgjl/EYiwI4MP6k1WCeLSOPGuPCRIEesEA0xAOkvYSDEjXZ+OH7Pj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAgETBJD; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAgETBJD"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a813079a55so1037919a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542930; x=1792147730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hSyjkbgnKJqn+CTuTVwVGrb8G+QahUPeeKkK1RD1QTw=;
        b=PAgETBJDY/wcjkThPEFIT3ioR+teaxUL77IizjkenkLb9L0XnS8OT69bkOGXs0FdIV
         DOEfewFTaxgeW3jgk5v1ZVltsfOOhZsrkXg0p4Wxxl2KFTvJkAvXL1zpv2jKwbRYUKBZ
         6srBDz4AuAarXPmKwRUa68hObyxzqUtINWflqigreRwBbni6nn8T0ByaUVNvV50AEMXF
         Z8vpdjz3cFlPk8jUAZZKUkqlhr/dl39ozXbAyxtN68I8PcR3662fwbRRNWJ/NySDjVIR
         Z90e+EfVS13zGgdugDC1l/y3qkq240VSURLVNmFkVZy0CJrRjkvO55/LaZFCt/2KANTi
         McXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542930; x=1792147730;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hSyjkbgnKJqn+CTuTVwVGrb8G+QahUPeeKkK1RD1QTw=;
        b=gH3wktnGT6w9VfrDmxJ+K3vBQR6ozMYlSYKeGYC/2Arc3sd2CyBgFVCkWCE8G5rlu8
         WvxA1maMSBUtYZ4YVFua5D5iXq6ew7pECEZ1zNgzY7e+xHoM7SXDLilbLznUFIWyGbTg
         hrghmJOLbih8RimbIVgq6tuNnuEaGaFAHVWHiJ+1UsWxhEwgzghXWRORc8FXZTPJ4Ojk
         YQ+qmH/1wB/F0DLlvmkLjqr+Fyrz1vEngpJBnLrUm9l1bpEVklef7GTmAuX2JnGHdGsd
         uMrESnrNgthJP0wgEwDfCw08v8Q2WHcRSCtSlk9bZSeRjrahyJIlRkXAkE67t9Fn3uS9
         uPEw==
X-Gm-Message-State: AFq9FYKagzB7SFOxpg3Nf1BgrD8vSewebmaz+DIXmZpzkTkDETRhDgrH
	DDeH86ooxt17tAL/gjDaFNzIojuze8J0jPNrkObgHalZRMT+V/88kdPlt55RakFD
X-Gm-Gg: AYBFou0kt1lPSuoTzIQAw91WaUFreWZPGEF0DgpRL6adAA45lzwwtP8vorAUZGOTEuc
	S/qXzKO+Xkjv0GuBdfMLnHWmeGtQ7sKS08z/5DFJCkx6fyJ+QcSZ4UKw/w+36zqv0esOKwmAs6B
	/09q5uF5rRO5d4SjYBsPMI+hWs0XfODafFUFMjKz2GQlGCiQKn/isDMqY9KCpKNZ7j2rJeppWbr
	yYMJUFoudGutacs4+6PPgqvJCgFi4LDhw23dcCAAo1kChorSzP9LBBXqgtV0X8zZzG9okqPuG4D
	uYNe8Fh2Huuv9F6G4EhXLrGZ8pcWFvY3DPGmXytVQXH5fR3T/1M0tjvgqosHVrc2MJmiBF20S6K
	3KM09p/TC9kKJOneuk8cek49OiawTzkJHNDeEQsRoTbFcGvHE9YW2ddskSmJacbBTZNXr5UCqCe
	2JVX3bQT5Oj7i78fmOYL2+xynwiqBUZ+7D8T5FwZtUeAe964Pbz8pr5tzyGmGdWn0TFn6PVpVZU
	Q9X5Wz4NdyDHPHpx0fBtYUtXg==
X-Received: by 2002:a17:90a:d006:b0:3a8:63da:44b5 with SMTP id 98e67ed59e1d1-3ab3ab20a20mr866782a91.24.1791542930109;
        Fri, 09 Oct 2026 03:48:50 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:49 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 41/51] selftests/bpf: tests for may_def marks of atomic RMW operations
Date: Fri,  9 Oct 2026 03:47:59 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-41-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
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
index 0b89c5776824..43f616ea90a9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2670,6 +2670,32 @@ __naked void load_acquire_dont_clear_dst(void)
 
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
