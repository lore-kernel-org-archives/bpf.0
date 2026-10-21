Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592748;
	b=Cffsga54ouaTriRnh7RlWnZCUE3M0BHJSkBNghJfpwy63UdjroLdEWdHZZDZjiDAncE3
	 jX/IOty0eA7jGWrYGjaWB2c54jqeqfLbSONFHPR+Ltt5QGXYL9XvW8BkMIBOdTWFdOOqn
	 K0bsxUxB2ykrD8t/NWSJ2SRuSyB8CuSNxvv+YvU2465yWU7kcyEAWLtwv9O6XhlodExi7
	 fRG/8DgRN5CnFLnJZiiIzQw7DItc3V/xSBkXf3B/RuNJk0QpmAQyWC64SLvpUaVw3/K5b
	 KWIALMdhF9p0RrIFsp/azaGVHlkjSbCuRo4hY3BADiq4vzPsDtGphCRGGLZA0y/ThIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=KUTG2FFKnH5DADXrXIVll4Oo2FdofJLIyfirGFeSZ8E=;
	b=osigKfO8MdSVVs5Q84esCa3NKuJmAa3hy7wHKzZkgNTv3nqV015/JgLZfaAKDhintpZr
	 4SI98yODP8DpTnA16J1L72006+OidZGpOtZ7L6n7zUWP1kpkhMJM55KSZh4e0vprHTM6M
	 HHp4Qstgl8UeZAduAuA0mWCWJL9hsqiE+KrMJBFip9O790paE/wsGalJEaX4sNyIv6q8U
	 fEznHE6oDDXIZf7U8aau6fDAutt7Nb1k1Dlcyg7qi9lF4U14WrnCxF+UrD2DHScBYSxTp
	 Vj0ObMkjHNvaVS23DiUk0yk8f0x5HT06r51I4+xOsH79q0HnUwAVI1Y+8U33YIcInQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NOqKsQeh;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82839606A322
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 14:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82839606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NOqKsQeh
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b125371596so13214727b3.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 07:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592747; x=1793197547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUTG2FFKnH5DADXrXIVll4Oo2FdofJLIyfirGFeSZ8E=;
        b=NOqKsQehcGk3lopR6KPL8bm78HA5McRY/hY8PtoGpUoDwkbiiu0a4L/JrNMSvRx7hw
         zzwBwank8WKQrootg5BYXpsrr1ITwBjW8RMHt9DzqMThrXvM9NTypf8g922NHA6etaa2
         q4c8NYqEJ41GFJSuwymuBpZoOdbJG77dd/8pSi14HZkRb55tLGpZjNZr3NokgXe6wu5e
         hDclxFpebd6J+wqqfjKcYNA6fOP2f4I7b+/296EN+t8o5eaGfmvKnxlp4Lq3FdC5CDbt
         oFqfMOMOBYTtOozRFpjdhuaILEnuJgQj0ZG/dOt/xzSjalPPPsiXGzuOMP4s2DW3zUrH
         9Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592748; x=1793197548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUTG2FFKnH5DADXrXIVll4Oo2FdofJLIyfirGFeSZ8E=;
        b=f6gtjl3DsAdb3g+cWynLUmhk8JAIG2jgA/6elQQ6cwUn4Flbzg6Q+ZYob7El90C70P
         tpFfGrtDA8eiHAEChrPvgp4ocSejru9rf1O/SpfZZuunxCx5lbwODgw4vG9gpQgfa5F0
         aQz8R6nb6m/JECNzVTggqesXUj6YE1z9eeMHzge6uW/ihv87hbjvZIBr1m5E+FVAWGbZ
         neXandYaJthISUxnSbNKYpBN3QJEaqvQqnnTESQGKGvoSX/zXosMtrFiDvSMbrqA6LYT
         5wT0h+xwTXJFQtuSyFIJ6Q17yqXua66oXIBpgsaY60tcOChJdyTyA8k97eKFUx6ETqQP
         qobg==
X-Gm-Message-State: AFq9FYLSK+NN/ARGBy5csNAey8DbLmM0H/3nxdQBhHRFy23Z4MyWapYQ
	0UmVj8g6JEw6Q0noenC9q9sPb/IkUn9Szw+jOubwOArs15Us9dAorj+9
X-Gm-Gg: AYBFou2sm7bIWpFRoU3xXhq75uDCvUfhhCbvoletupHoKAG1j9iP8IEmaVRXhNODf+H
	oIH/ADRkbc4Vb2IOCL/Tn0ivciGmmV3nN1geFN+Dz0XS8vml+hST+DLT3syV2pI8BGhsvRuitMT
	3vcg2QQdc6BzzfKccRVQ7TZXOuy5sy4ojRAGi55pGbCB8ZN1+D3ove4c3yT6JeOIUcI5BZ1s8PG
	dhMLFbIZbQBpgXDGAN8gMATNcxuI388srV5um8oUFJq3nh0Bv4LCZJsmqmki0URzhuJHAgunLdv
	rmb1C53d1367XIvTVg19fcidxIEqOAdJKHqLu+9jFEbvuDN2/Knj2la5HnAhQOXkIFBkTszGOT3
	KbwdmVfJSEvN9Qq3WYpxRGIT7hKx/ho2PJ0jL5R4FNk3WkFgXrMbsnF3MPRlWWbk5wwlXdkujJf
	5H+pCx45VVsWu5aId8Fe5PAr6r7HRNr5PbVLSQ5w6ks4SMethxKoh3NMlTdldoJiUOvWPWYHkzM
	uvF5oDsj5cNk5uIYuWcOIyZRW6B5wfugQufJuECfQo8wQ==
X-Received: by 2002:a05:690e:1389:b0:679:9e81:e51b with SMTP id 956f58d0204a3-679fb89bca7mr2249659d50.0.1792592747461;
        Wed, 21 Oct 2026 07:25:47 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300a7299sm12029707b3.16.2026.10.21.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:25:47 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 21 Oct 2026 07:21:33 -0700
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test JIT jumps which change at
 a repeated image length
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-jit_size_fix-v1-2-b89fd32cafd6@meta.com>
References: <20261021-jit_size_fix-v1-0-b89fd32cafd6@meta.com>
In-Reply-To: <20261021-jit_size_fix-v1-0-b89fd32cafd6@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792592741; l=3107;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=DO46ngIqDg+efxhC8qati3T5iC7NhQOwtLy6ir/4O+c=;
 b=h+jEL74Yxu4/Akr96YeKpogHhk17u/69CRcvD3NKUHkoiK5aTAHUzrlwELhWodPbU1/ug24BT
 /E1tMFRhDczDmfx9uLY0O1mLTsuu0RMiIwuD4qpmR4lrXQfCrpb3qxe
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Cover the case where two JIT passes give the same image length while
jumps still change size, which used to fail with -ENOTSUPP on x86-64.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/jit_insns.c | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
index dabefdb8a353..1abfe6161bb9 100644
--- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
+++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
@@ -2881,6 +2881,61 @@ static void test_convergence(void)
 	}
 }
 
+/*
+ * On x86-64 a backward jump grows here while others shrink, so two passes
+ * give the same image length with jumps still changing. The fillers are 7
+ * and 2 bytes of native code, jumps are never taken.
+ */
+static void test_same_len_not_converged(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, IN0),
+		BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1, IN1),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+		BPF_JMP_IMM(BPF_JA, 0, 0, 29),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, 20),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, -3),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, 22),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, 2),
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, 23),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_JMP_IMM(BPF_JA, 0, 0, -22),
+		BPF_MOV64_IMM(BPF_REG_2, -1),
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, 3),
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_JMP32_REG(BPF_JEQ, BPF_REG_0, BPF_REG_4, 2),
+		BPF_JMP_IMM(BPF_JA, 0, 0, -22),
+		BPF_MOV32_IMM(BPF_REG_2, 0),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 10),
+		BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, RES),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int fd;
+
+	fd = load_prog(insns, ARRAY_SIZE(insns), "same len not converged");
+	if (fd < 0)
+		return;
+	prog_run(fd, 1, 2, 11, "same len not converged");
+	close(fd);
+}
+
 /*
  * Calls into a subprogram with all five arguments, which clobbers a subset
  * of r6-r9 and uses the deepest stack slot the budget leaves, directly or
@@ -3087,6 +3142,8 @@ void test_jit_insns(void)
 		test_max_jmp();
 	if (test__start_subtest("convergence"))
 		test_convergence();
+	if (test__start_subtest("same_len_not_converged"))
+		test_same_len_not_converged();
 	if (test__start_subtest("calls"))
 		test_calls();
 	if (test__start_subtest("helper_calls"))

-- 
2.53.0-Meta

