Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41173AD5A
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841786; cv=none; b=s27VXOQfWJ5N9gbxedeZzsoZ2ryvCEhTBYpqqx363BHNKXPTji1gbmk8glioK7GZw8NOl7pgypXViXOM8VCUCqlrEplosUAhc23VIXWJkUFkfxyQ7PO4pbCqVHL69Z4r5E/EQhjKphJnt+6GAhV2Sn+ahSu4Syylb5s/IAmEu6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841786; c=relaxed/simple;
	bh=TKEXO7bFLXDqJ7HJhTw7HIHlK8pcwwgxWAfj7zZGanI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHi2kte742VaDkiOY/5pOr3uZA6FP5i2J8MYVOe6xh7stR0A7zgGBUsfkBGNgd3quZHw6lPRYIu8I+kQmD9/tTuf179ck9WAYQjh4TUBrE6FguIgrmHkkOMLQ+T9BwKdazMcKieiKdjEZe33tu6eVcrXOex9nffQYnzAqS2ndkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUONBhiD; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUONBhiD"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1271257ae53so11899265c88.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772841784; x=1773446584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9xrWQKm8YGEtKjgHDEAOa72l8oQWUBxn2LPASUyw14=;
        b=jUONBhiDMLJ77n/rNJbGfhTZC+7e6n4DkZxv6l1ZSF5qcpCSgvsE8/5sqgwu8FTHRa
         EcgKWR9wJUlYINvVHvA6lEVBq2omhfAlqA4YZZqyLBlAbS6J2pezanyWSL9R4JXhwr72
         VOY+NYjSQbvYjfboB7HBHTfrlNpI/cQecjGLAgdBs6mcvdmhnPa2OcAUqccZJ3xCOu9k
         hNtn/lVHhxiltXOWTaGa5tDOOHWiQxhBrSnUZoxfUe3yxiVwv7INGKROVWaJjaSU2N1L
         X6VwQKLoQAVR9WuABIRdtIWSdzNtp12y8jV1O3gGkffRX8NnBvMDew9EED4FlN6jv+Sh
         aTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772841784; x=1773446584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x9xrWQKm8YGEtKjgHDEAOa72l8oQWUBxn2LPASUyw14=;
        b=nPyRv3hjtFPxkI1OD4QHty0EJeGbFdH+ejhzrXyoy90BbP1sTerbNGnxudaVb9pQbp
         5o9Ihg9mG4kJVVp1e0vlqstiiM7PzFB3j5hfNUpX/5lLEhGUo9Q0rFkU8vMSs1BxtUqu
         NdBt4g98tmQ+pzrDADPtXaqrdARO8E2ze4GoMdoGdWtmYL7VszPxnbjBDhLcWCmUFbgS
         AHSovKlLsL9TMjrjUOQlKwLsF+Qre4EP4Dq94dY+MYSb3jvfGg94BVlH0xgG2qp5YkT4
         YJzJGfRe7aNv7JMPv3d/H1bV5ab4x6zwJBclSHjVyDXRNRWALBnqmL3aVjOCV3gqE8UH
         pjIA==
X-Gm-Message-State: AOJu0Yy/3ZsOTIUUC2T0HmD4jy8KJVeQXmNnXFIn1dEIn1v9arHxri79
	t/jEJdQtVv00ESwWm3T+yPi0jiYqII7eRpBEcujpYAx+ZnO1k9Lvl+8RrI3perBC
X-Gm-Gg: ATEYQzwAsYvCz4tl7l1sf/mQ2bE1ULGQ1vC9vqFof/ChjOGPcaI6uERy/CLYwxHBPwg
	Jw6wU56A1mPaic9ZCQlqVJZeRB+o8dvtin4Bb+n928NsbiVklEZRpHya7IPH3kqi2qLOLmRomg3
	ejcZEnSJ8v/cY/0/mYQ/suK5xHShgtjdZ1QwbwpNrwtDupwWmYS1+vwMGpJgdaMIY8gNorQWIBJ
	3pQRpmb6cfm1AQM67bte/GRTZ+ayuGUrrXGDRN1wacMy2zhPmYhAgdNcgqszOsVC2RN6dEZxF5V
	VQz3smbaN4/iXvqaNt7z9EVjqoMLgTwb0xdLqdWuhT4gF+cB/De1ehwzF+qSmV6t0Mvmngyav5e
	K9v9Cek1/Q+nlvJX0QsMyDepOiP+ir4H15SKOgYuSy6U2V6RYIMjjKlECOsCraSpSLWZ/7fuTCZ
	J1WWqbAp3+wgSLem5euCSjP847eLgJm6meuu4H+1Py7l6GEe14h9C7jB+JPxaQPN0pPlKKP5+wy
	RnwcHeWSKFxOQL24w==
X-Received: by 2002:a05:7022:324:b0:11b:9386:a387 with SMTP id a92af1059eb24-128c2e92fa9mr1739080c88.42.1772841784076;
        Fri, 06 Mar 2026 16:03:04 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f62d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3bf4cb2sm2153786c88.0.2026.03.06.16.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 16:03:03 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	emil@etsalapatis.com
Subject: [PATCH bpf 2/2] selftests/bpf: add reproducer for spurious precision propagation through calls
Date: Fri,  6 Mar 2026 16:02:48 -0800
Message-ID: <20260306-linked-regs-and-propagate-precision-v1-2-18e859be570d@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306-linked-regs-and-propagate-precision-v1-0-18e859be570d@gmail.com>
References: <20260306-linked-regs-and-propagate-precision-v1-0-18e859be570d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add a test for the scenario described in the previous commit:
an iterator loop with two paths where one ties r2/r7 via
shared scalar id and skips a call, while the other goes
through the call. Precision marks from the linked registers
get spuriously propagated to the call path via
propagate_precision(), hitting "backtracking call unexpected
regs" in backtrack_insn().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_linked_scalars.c  | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 2ef346c827c25b96ae86096323dfbfbd5512d2db..7bf7dbfd237daa332fe9e276cedff6d940f5854e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -363,4 +363,68 @@ void alu32_negative_offset(void)
 	__sink(path[0]);
 }
 
+void dummy_calls(void)
+{
+	bpf_iter_num_new(0, 0, 0);
+	bpf_iter_num_next(0);
+	bpf_iter_num_destroy(0);
+}
+
+SEC("socket")
+__success
+__flag(BPF_F_TEST_STATE_FREQ)
+int spurious_precision_marks(void *ctx)
+{
+	struct bpf_iter_num iter;
+
+	asm volatile(
+		"r1 = %[iter];"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+	"1:"
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto 4f;"
+		"r7 = *(u32 *)(r0 + 0);"
+		"r8 = *(u32 *)(r0 + 0);"
+		/* This jump can't be predicted and does not change r7 or r8 state. */
+		"if r7 > r8 goto 2f;"
+		/* Branch explored first ties r2 and r7 as having the same id. */
+		"r2 = r7;"
+		"goto 3f;"
+	"2:"
+		/* Branch explored second does not tie r2 and r7 but has a function call. */
+		"call %[bpf_get_prandom_u32];"
+	"3:"
+		/*
+		 * A checkpoint.
+		 * When first branch is explored, this would inject linked registers
+		 * r2 and r7 into the jump history.
+		 * When second branch is explored, this would be a cache hit point,
+		 * triggering propagate_precision().
+		 */
+		"if r7 <= 42 goto +0;"
+		/*
+		 * Mark r7 as precise using an if condition that is always true.
+		 * When reached via the second branch, this triggered a bug in the backtrack_insn()
+		 * because r2 (tied to r7) was propagated as precise to a call.
+		 */
+		"if r7 <= 0xffffFFFF goto +0;"
+		"goto 1b;"
+	"4:"
+		"r1 = %[iter];"
+		"call %[bpf_iter_num_destroy];"
+		:
+		: __imm_ptr(iter),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy),
+		  __imm(bpf_get_prandom_u32)
+		: __clobber_common, "r7", "r8"
+	);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
