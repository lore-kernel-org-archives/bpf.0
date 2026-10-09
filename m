Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995974C6526
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542948; cv=none; b=t4cjY0A3zYFZRsasALTkQr5qZeM2bWSR/0RZDbym4tI0C96OKErzcLPzPOdbJCtJw1H/+OzgaKJ6b6dub0KwJtGw8NQTTZwL4eG+JawPZQDNfW8Zcxjo80HKND83atwvVXjwhVXN2eMfPCI9szpeDGWdNou/HGRyYIB2/DYgQMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542948; c=relaxed/simple;
	bh=ipS6otRBWE4qdqNUG7HBypsQhmPzpiqgxSRofHpaPK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHnrX15SxGN9p0za9zoccieITkfHPQerq07ZPRxUg/d17usxkTAoYuyoYjudiRZIJUTszAYSZfSy23+kWdkdJ6Iaj3ZY3rEwsfhIhVLeo5heTXfJjngtLmsEUflr9ZcJPwiH20ZCKYCR0Mr9SHFQfYEBLZ5Qrw2MhCnUgecBu/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWcrOAgl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWcrOAgl"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso38505665ad.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542929; x=1792147729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OLtNlR+Smj3WVPL3U5SZw/LV/RXz8P/JjOqmbl0LWxU=;
        b=BWcrOAglPUWyQHVA4lbdlrbQCr6kwSmNAJ+96+qHiL2VBJHmz6w8O5My+mAoL9p1rd
         +hyPYpA535/RvPdy95P7cPHhHbE3BXRoRQDX7/msQFfGI44He+dN8d25oqfIr3p2F3mG
         BnvLg8yfZdvt/nIOgjQxhpG5av8yx1YjvIye5gEhopvFKk7Rq9W5vr4cPhUUMX6Zt5UM
         ScXM8YUy3hh1RpXuO4rXKU9O6FwFrFLZPabX4WsG0SAEbE6ak+9Eq/zGX6HfboZBHJ2Q
         ioYf0FWeCbPCekVPJB47WXiMkSFNpMGeObrZEnZgIjB2Pu1ov0AZTGe4ybFnQ2OjiLC5
         D1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542929; x=1792147729;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLtNlR+Smj3WVPL3U5SZw/LV/RXz8P/JjOqmbl0LWxU=;
        b=diZ/yfQ6r5/ihBhNrAJ3MJXqZYFkS9pSdj4Ax4RtM8mLLFgYnKkJIQugM0fNOQ4GtE
         ZsrYiVd4PwNhX4U1RCjcmjYNErM1PxQlLuLfPrwsJSXWgClQ+hOuJ+6aF+QJ4HJX7C6C
         o7M8xGCL+ql+AsQYbcGddYLNwssQ1jYnk6gmw9JFusjH5DKh5qFS06rBZy5KMEB2LOvY
         CLzLzFBwjHVoknB3eZyKFD+GPWeg9FOxLt8/5fRZEZCNPADzr5LOlXiHG7P695VoguKF
         FeNtarPTm73zdaFatS9m6qiMXI4zWK7DzXV8u9BAyI6dBQZEKUF3thtINNL/rXrf6LNa
         zuZQ==
X-Gm-Message-State: AFq9FYK/9QNaMD5nvJDyGmzFpWUqz1ao5oTzlatcjKkSnY1Jwc9Gx+UT
	0q/CTmHwxW9hf1pORiUP5JUSyUwzCb85eb8szS1wPqgwiWtcBYD5P4s/1AkNqOQT
X-Gm-Gg: AYBFou3mOuozNO9h7ayBudQIJneO15ooRaJtTb0q9tDNDnqEZWkCsEtN7VpUUdLBs7I
	EDS6lwv56Bn5mqcn27GE1pNjeoaGdbj6SA2aimGx7D1DWwfK0mIZ9ivPvj1FMMDTJkoS9eXb4Nx
	6l0LgpZ6DeNMAqdVodgbcUzc3a0VVhyFQnuiFC6DKo9B7o2Di65HhE1KlARetiuS68BTwqftezu
	UOlRrGcP4gUjsArTjweNbMs1noIyHL8CBn3A++kFyYS3KoovShtFcavG9AscIt4+X5lFGdC1Y59
	k0NNAW7IImcibwdBBpwdqTKeIlauStZip9fq+wz8ejiRhgAyPa639NMWh8FYKt74B4HOj3ck7h0
	Sdw7BpNFj5x9V2fNwM9U1AHzG6nZ9el5wRtJaj3srYlNY7HM3Cq1XVTMfa1Olwb0Rn54jFzXrw4
	mZMSGjVqqCmI57V/Nct+GdKhIlxAgeKX5e+IFQW4cgwxpJUQrXWjod1KGVfM33enIKzztl1EHFK
	jK2haiP/yeO/z0=
X-Received: by 2002:a17:90b:3d48:b0:3ab:22db:1c0c with SMTP id 98e67ed59e1d1-3ab3a7a1531mr1385406a91.31.1791542928722;
        Fri, 09 Oct 2026 03:48:48 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:48 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 39/51] selftests/bpf: test for stack-pointer subrange pruning
Date: Fri,  9 Oct 2026 03:47:57 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-39-bcba9bc53ac9@gmail.com>
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

Validate changes from:
"bpf: allow subrange relations for PTR_TO_STACK in regsafe()".
Add a test case that checks that a widened stack pointer with range
[-72, -16] is considered a superset of a stack pointer with range
[-64, -16].

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_stack_ptr.c       | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 3e0bea9819ca..3e9d8fc606ae 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -586,4 +586,40 @@ __naked void stack_check_size_512_with_may_goto(void)
 }
 #endif
 
+/*
+ * Verify that old PTR_TO_STACK state is considered a super-set of
+ * new PTR_TO_STACK state when new variable range is a sub-range
+ * of the old range, e.g. old [-72, -16] vs new [-64, -16].
+ */
+SEC("socket")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+/*
+ * r7 is widened to [-72, -16] at the loop header (insn 3),
+ * the loop body sees [-64, -8] after 'r7 += 8'
+ */
+__msg("loop header at 3, widening r7 to -72..-16 step 8")
+__msg("R7=fp(smin=smin32=-64,smax=smax32=-8")
+/*
+ * back-edge state is clamped to the remaining iterations and pruned
+ * at the header, because [-64, -16] is within the widened [-72, -16]
+ */
+__msg("loop header at 3, clamping r7 to -64..-16 step 8")
+__msg("from 5 to 3: safe")
+__msg("processed 9 insns")
+__naked void stack_ptr_subrange_in_loop(void)
+{
+	asm volatile ("					\
+	r7 = r10;					\
+	r7 += -72;					\
+	r6 = 0;						\
+	r7 += 8;					\
+	r6 += 1;					\
+	if r6 < 8 goto -3;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
