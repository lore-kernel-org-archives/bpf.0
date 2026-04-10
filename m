Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCBE3DC4DA
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838661; cv=none; b=EOj9fArc5NLHkpkZMmtX26r+tUR1Q5qJHA1sE8hO0pgYi6SSRxKse6qF/xfxjN+PAsloifRqfwZwaYPVxPzoS4aFN3IY9nytpJCBWAmo7fSMu1PqFo/7tZtYcGsswYbfWnSo2nQwXdPsmNTGSPIyeUvxT36eZgvrSIV6uP3Xe6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838661; c=relaxed/simple;
	bh=uJN33Zt/5X7usFI3fydZUGbQtkqoK76mJ61/sqBakaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeGC1tUSvysEOX/AHAv5CcfUsIqSCI4MzfXo6SKMa9swtsRlYDvMemo20tPmdCXh11dCy08PLmRep1lDi7vZ+0NX/+fQUFGbGyEdOOtbxSekPa5jkrpJnAw0Di8A1c4b9sspRPrcE6u0XQxMaG0xjIOQZu4MeDAniD2x04d565o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=bAuqjInZ; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="bAuqjInZ"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ce102afb0aso2949034eec.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775838659; x=1776443459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX3HWH6aiSa79J36prtztuhQVlEN58wSpeoFAcvSQ8M=;
        b=bAuqjInZu4vms0HvCBgtcOvY8eG893pC3ap7vx75mwtIUaEc9H6NLhZnBgTd3EK0wd
         nVVVMSAP2CRspMr+3B6ixXZg4uYCL1cxQIM+LU5blL37YuGkddFY410iAf+ZuAgJ6QYE
         L6i/hVdD2avd3lIlHuWo62xK1K2Q//Yvc5Kl9l0wP5zrE93MKnB+aQOTs+S/d5mx5lvS
         mml4LLfxv3KIn/3DJbbDufsJKMgSSzigs925dNChPkZjsCgQ71ikrl1z+TR7G/vK9v7j
         46a9/XMCOp1/7ZdCA/+lDo3Me2alSUxxWZ0A7021synZ1+J9Me8RY6q5Y1n2KI85yZdE
         zWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775838659; x=1776443459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XX3HWH6aiSa79J36prtztuhQVlEN58wSpeoFAcvSQ8M=;
        b=G7Jkpq2pXdjW6AfZHpky4ePWTTl27R6cYIX0WoluiRynmwAhYPH5Gaf3WAq6NPV6Zk
         e4sLkWLUmQfryg+b1GS0UlX8SOM3L4S3nJYKh57yl2OE5nH2KgrELKGF9znwtpT/nAI6
         dA/S0GUpgsfE82D6stY8/QDfctaixAPE8d0C8KtjWAb51Zj21VZiMtyX/wcMEfv4+xOT
         EEpEb0dCZq9GVGNw34au6qv+ToEoRKp6ZXqnllMDu9bV9hbII2WW5trHmsgPcVc+BAEt
         tZkWl8jqafQ4KeQ+Pce9dLpWo1odv4IRmfR5DL1vJKp3JEkGnjVIhrsRRyK2iwnXkJyQ
         tJUw==
X-Gm-Message-State: AOJu0Yz5fOOYlpBTBn7fQn91jByfzHgRcTwcRONNAf9XFAEh43eJ1Fde
	IYy/GYLjqpWMeFKE7Com9CR+RLfeLMhryX8+DEuVp/vpUl+C472w+u7yW5/150MTCgGarUjlRYB
	mBMEHBUI=
X-Gm-Gg: AeBDietN5qgIizWr5goKxCCIcW2dDA4QTYVTYeEsQmDucnIJbb/do6E0OXflF7MhJaN
	CKb810hUS3yd213Cw7nwYI5KyYFMfDp877CU/FYXsylVHVGXgzQJIDyyY6M69X6H1alGUGkvjp1
	vZU9wIljr9YlMmwszcJq/OgURKu+rBannpIiaenCb+Zraw7ChzXiTv5/Njqbez62jlnxeIxZ0jj
	VZawnnoBEc0noSA1fsjsmj6uTmd37k7MDAmui/XABJAnm3+yPRPqWX9thur0vEPWSLCC0GGsp+x
	eV5u69qSfjKDJVkgb3p0YIzrC/p146OU5Molh7s8zwWP9xcQXihAnkMHa3RAA1bnxfv1BWl3Qpi
	ZvotbviwAjQSdLOVUrj+5nssckXmko4+S8SUtY90BInIc2LjNVP3pPc8v4SU0qKP1dMhtY9PFaA
	M9SYXndWpLaQ+AUYolXpg=
X-Received: by 2002:a05:7301:4b12:b0:2d6:526c:55cf with SMTP id 5a478bee46e88-2d6526c5a9emr806136eec.9.1775838659114;
        Fri, 10 Apr 2026 09:30:59 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::6eaf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69d5sm5642619eec.3.2026.04.10.09.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:30:58 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 2/9] selftests/bpf: Add test for scalar/arena pointer addition
Date: Fri, 10 Apr 2026 12:30:34 -0400
Message-ID: <20260410163041.8063-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410163041.8063-1-emil@etsalapatis.com>
References: <20260410163041.8063-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that ensures scalar += ptr_to_arena instructions
are accepted by the verifier.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/progs/verifier_arena.c      | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index c4b8daac4388..df5632ea777f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -477,4 +477,89 @@ int arena_kfuncs_under_bpf_lock(void *ctx)
 
 	return 0;
 }
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+
+/*
+ * Test that scalar += PTR_TO_ARENA correctly upgrades the
+ * destination register to a PTR_TO_ARENA.
+ */
+SEC("syscall")
+__success __retval(0)
+int scalar_add_arena_ptr(void *ctx)
+{
+	int __arena *scalar, *arena_ptr;
+
+	volatile char __arena *base = arena_base(&arena);
+
+	asm volatile (
+		"%[arena_ptr] = 8192;"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[scalar] = 12;"
+		"%[scalar] += %[arena_ptr];"
+		: [scalar] "=r"(scalar),
+		  [arena_ptr] "=&r"(arena_ptr)
+		: "r"(base)
+		:
+	);
+	return 0;
+}
+
+/*
+ * Test that PTR_TO_ARENA + PTR_TO_ARENA is allowed.
+ */
+SEC("syscall")
+__success __retval(0)
+int arena_ptr_add_arena_ptr(void *ctx)
+{
+	int __arena *arena_ptr2, *arena_ptr1;
+
+	/* Needed for the verifier to link the arena to the subprog. */
+	volatile char __arena *base = arena_base(&arena);
+
+	asm volatile (
+		"%[arena_ptr1] = 8192;"
+		"%[arena_ptr1] = addr_space_cast(%[arena_ptr1], 0x0, 0x1);"
+		"%[arena_ptr2] = 4096;"
+		"%[arena_ptr2] = addr_space_cast(%[arena_ptr2], 0x0, 0x1);"
+		"%[arena_ptr2] += %[arena_ptr1];"
+		: [arena_ptr2] "=r"(arena_ptr2),
+		  [arena_ptr1] "=&r"(arena_ptr1)
+		: "r"(base)
+		:
+	);
+	return 0;
+}
+
+/*
+ * Test that PTR_TO_ARENA + non-arena pointer is rejected.
+ */
+SEC("syscall")
+__failure __msg("R4 += R3: Invalid operation between bpf_reg_state types")
+int arena_ptr_add_to_non_arena_ptr(void *ctx)
+{
+	register int __arena *arena_ptr asm("r3");
+	register void *dst asm("r4");
+
+	/* Needed for the verifier to link the arena to the subprog. */
+	volatile char __arena *base = arena_base(&arena);
+
+	asm volatile (
+		"%[arena_ptr] = 8192;"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[dst] = %[ctx];"
+		"%[dst] += %[arena_ptr];"
+		: [arena_ptr] "=&r"(arena_ptr),
+		  [dst] "=&r"(dst)
+		: [ctx] "r"(ctx), "r"(base)
+		:
+	);
+
+	(void)ctx;
+
+	return 0;
+}
+
+#endif
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

