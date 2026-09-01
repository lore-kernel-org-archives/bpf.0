Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49D25524C
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226593; cv=none; b=Hh4RP3hZ2Oc1057+HH50WEyOd+bFyv8OiA70J2NamXVrGlE8or3+WZXY5pWlgDCdEjycWQfOjCcDqv+ta70eBEx5p0CgseWtJNZeynkTLp1JKaLJmLve+4c53fD7fpJH0mlXYtPZDbQp4frcyN8HqliPK97rXLyB0uNop1jnk80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226593; c=relaxed/simple;
	bh=q7hXFC90XmbERBE/koX0D3srr1oSBrokdReuQZKezoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gk7iA5oeAFP/RaxpWe7N3oTnZf9nrmfon7xQuqFPcKq3YRHKC+1pc19y9EESyg6nitHDUUzPSiUHt3QRowNPK5ArHLfVe6/7G1PJvWGlucWd46a+kDxS3kiiTOsBr3tJ64s6mI/rTP+74QAqidu/ETX41G65kkJANwXQlMkSoFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5NC1KBG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5NC1KBG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d560775ca2so30198955ad.1
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 18:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788226589; x=1788831389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sdey4R65l+cY9ThfWQNAR4GlZpgkdDdZh7V9L/aeuk8=;
        b=I5NC1KBGZ7yFAf5rEOzjJjyEN4eNcGN9Xko/xzpih/VOYbn+GRKJatzkNy/b0gai/v
         fpmQUOqRth0zEGEk12yX5tQ0T+Z4lH4bCuSLCH486G9xo4sMDF9RRcD/t1juCAdFW3dI
         qf52boxEyGsLdto3lO2uk5EDgQqh9uQfjQSiglA8MSY1A4XwS9oj/KKmYOjDJeI6kvib
         dA1mfpo9Wp7ryfp2jG2clep2qAL60WsG1LEk0dx3geeb3uAZ7jQGc9Sjfo++M+cZzsUw
         OmoQuweV2xGrjDaFn3wOZtKtbHZ73cR6lfqqRjfTwB3/KCfVOoXcGJG0RYm0L1s74U49
         MybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788226589; x=1788831389;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sdey4R65l+cY9ThfWQNAR4GlZpgkdDdZh7V9L/aeuk8=;
        b=d42Jv4Pxu8Ha4UIr7RlRzpipBKOsAk7HM02NgG/PUEUCwuFwXbeYGIkuy2nLzoVdT4
         AMfyLAIiPXe1ZbDagVClpLyO8FiTAJfc2mXDrT0hSsGJNbR55IidxhMFuxPcoLGkWx1d
         cCjmfRUTeOOb+1vl8hrSxb8s0zrgE/pRnMpWsoCluBSw0K41tZCHXDrcdDPgdyrWu+AM
         Cxs+UyqHTq62xd0zgxnq+l+pigWueJCIVhlaYmrZUScejbAJztgI9q8rJnYEByqHiun0
         9J9zbS6qeKboRG4FYS0F5cnbhX2iPqBxqjl97bOOqZ//ZN+KcJ84S8F+jwGxiCBykQ8j
         9N+w==
X-Gm-Message-State: AFuF++lBeqKtaJnDUIZLk8Tah0KQQYmTcwTAnLXOaJR3I7k+j96AVLs9
	RTaLu7tWF26knZtwmDtXSvWmUcwu+kstaDyaLNuUAfznliVYvDpAQnd4LLT/GSqm
X-Gm-Gg: AYBFou2xeoc0rl2J1hWR9+wB5+LUsC4BaQNi5Cm3EqPYCTKBQJaBbzOIpBD7zq4RCRm
	oH7G/xXNG9FdEmiiF1nuaqWLVZfJ2Nvcschw2DoprnK50kQs6eLDGGA2lSRIlsfZF8M67oNKjlL
	aFdSE2lsyo7RBP0SOMMouoMLnJoatm+7bK/Y9adqoozyVbKWG0ET04a0aOpTUc76llCUypKKcf8
	N7ZZn5d53yZCNvBfFbM/Tc7p/uyGAC3QjvfXaKxFnRwjoiCYxfPe30sbL0m5DqZVRyAPtgT5i7Q
	5QFEsSkunYGQZwQyATzESNi/EczXV01znPjFyJNkA3sTsAWwDFJEN8ZYxzPmUHMuP1hgoksMa4A
	R6ivOFJm/zNoqoB2eFz/8GASP5u9nxrVU3PU94ztR5/MLM2XYu6PH5hTpjSlFx43SHG2hCeH6sd
	qNQEiWhzJDaGlXKfjc0nlQLsiCaaCHmJ70ayiaLLtveNbuUZAoSMgKtY2cR74hOr5ozOJCQlJEE
	6Q4l90=
X-Received: by 2002:a17:903:17cc:b0:2d8:d4dd:24c0 with SMTP id d9443c01a7336-2d8d4dd25ecmr332893425ad.21.1788226589204;
        Mon, 31 Aug 2026 18:36:29 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75963bc14sm42825005ad.32.2026.08.31.18.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 18:36:28 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	npc@anthropic.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: test case for unsafe pruning of bpf_loop checkpoints
Date: Mon, 31 Aug 2026 18:36:10 -0700
Message-ID: <20260831-bug-015-backtrack-cb-args-precise-v1-2-68a8e2a821e0@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831-bug-015-backtrack-cb-args-precise-v1-1-68a8e2a821e0@gmail.com>
References: <20260831-bug-015-backtrack-cb-args-precise-v1-1-68a8e2a821e0@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The following BPF program was erroneously accepted by the verifier:

  static int cb(int i, __u64 *ctx)
  {
	/* unsafe on a second iteration */
	small_arr[*ctx] = i;
	*ctx = 100500;
	return 0;
  }
  int main(void *ctx)
  {
        int nr_loops = 1;
        u64 ctx = 0;
  	if (unlikely(bpf_get_prandom_u32() == 42))
        	nr_loops = 2;
        bpf_loop(nr_loops, cb, &ctx, 0);
        return 0;
  }

The branch with nr_loops == 1 was explored first and injected a
checkpoint at the entry to 'cb', such that nr_loops in the main's
frame was not marked as precise. This checkpoint pruned the state with
nr_loops == 2 and the program was accepted.

This test case corresponds to the program above.
Entry point is written in assembly to ensure branch processing order.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 62d7df9e80be..c6699159dacd 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -2149,4 +2149,43 @@ __naked int stack_misc_vs_scalar_in_a_loop(void)
 	);
 }
 
+__used
+static int loop_cb5(int i, __u64 *ctx)
+{
+	/* unsafe on a second iteration */
+	small_arr[*ctx] = i;
+	*ctx = 100500;
+	return 0;
+}
+
+SEC("raw_tp")
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure __msg("memory access is {{.*}} and is outside of the object of size 64")
+__naked void loop_counter_precision_2nd_iter(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"*(u64 *)(r10 - 8) = 0;"
+		"r1 = 2;"
+		"if r0 == 42 goto +1;"
+		"r1 = 1;"
+		"r2 = loop_cb5 ll;"
+		"r3 = r10;"
+		"r3 += -8;"
+		"r4 = 0;"
+		/*
+		 * Explore with nr_loops=1 on a first path and nr_loops=2 on a second path.
+		 * Buggy verifier did not propagate r1 precision properly,
+		 * and thus checkpoints created for nr_loops=1 case matched nr_loops=2 case.
+		 */
+		"call %[bpf_loop];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_loop),
+		  __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
