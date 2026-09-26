Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE247D454
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432474; cv=none; b=QowvzqSHruuZVJPxr80utUn/l4frz4KuaL7Ifi+/nV0wX/ctf0SE/qQoQvYFG932YBPvJxC5pIKbsHKEqlOg6p4J+hroljsLY2drJnoEMN7G70zy6BS7FLEPQEVQUlh0DCE5dnRHFJ4eAxugPzVKvaeQwTbC0uYGNQyx0fR1oL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432474; c=relaxed/simple;
	bh=tgpV0JdoQYrUZIx5M32iG/KXfUIhLiOQAnK0vEtlwU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjWDDYjWd/UAUMBy+rcbqBKYAuoYGD1i5x8Yjs0Uyco8TdbUUph4EcJc1aPjrcsMiJ2vRdasBMbbcC8ew4miNg/Ol4PjQlMLauHmhL3c5z7iuiK3TT4DC1naNAUr9M4F9twKrr1Cbx/5Oyp65MYPYz2M5JUpI9Mfs/ErdBGxDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJxI5JT3; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJxI5JT3"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d2c37b0bso416840a91.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432472; x=1791037272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c35ExwJuOwaYdmeQFzWeHSJ0l36E1JLF4mc/MM3RBQA=;
        b=kJxI5JT3TfnKVHPVdGHBaaNsg9jcDPZgYVnBiLJS7Hs63Lf0YG/NvJC386VIJih8yP
         p1iUhLgx+lFfNK9lfC+SPmCyzqMplGvPoijsyKvUVCn3WNd0SjstTcibfZe7L9VMn6Y+
         UGfLBsjnsQXgwHO7bWJUCbJlRKMOd34i2vTsE/p+ZGWIFC4fhwmU0k8zSm5APhh0j6FG
         yCcB+tEi7kjt+e/yXlshYhhl2e4qKKt/ke9NOpOLM8DynwE92frpGfBFMKFb2+bn4dxP
         ll1jEIZy2AztSNtZBhQdjHPqbpQ7BsWqjOO8Mwj+0T/JcpwR8metSdnq9qKDlzNeR+cg
         lhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432472; x=1791037272;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c35ExwJuOwaYdmeQFzWeHSJ0l36E1JLF4mc/MM3RBQA=;
        b=orAwiAZ8/jolbeYK8Qllp6tSl1SD/PxGZnoj0eBqisUUGDQNyC/CqUCW8RMZh7CT7X
         7HY4axz3p5g/mIHeWoNZ34CGcHPd8JnwU2T2r6T9LPeMkNS7qwIN35gApQDq8i+jq+d9
         fSLQP/zB4CfgLmLtUiUhS5pS4sEKr8rJiX3CZTGvvD6xHJ9ITVglHwtvMnWUGJ2VbzRw
         6VFcDyuagNOFrfFPRugrbUP23oC9cZrZVJbTiHqUUVcT9EWfLwbSO4Z7HqTbN68k/atU
         krBzJ7xkjE4G3JyoVQOdw+RCaTunwCKWtY5XJDkXOMiC3IlgAJw6G8fsokKFGLVDFSbl
         tm1w==
X-Gm-Message-State: AFq9FYKYGHRUTd37YCj5e2ErU9MwdXl5OP5FJAh/Wtpez1ShrkUR02B5
	2+5Ahx2hxGlToZhrBai3oftcTyM2WLp/2AXZ6flPZB9JffIDFI6+JmWIxnnpQFALe70=
X-Gm-Gg: AYBFou1MsevPzC38XU033b4FNgWBmKBy4d5dZEtFo1xnCcN1lVzqKp0HUFGtz07fOyy
	esNTUwnyZgTZXxoXc1ccw/XxJBDDM4N8nWB1AMpor8WO2bOzhAsF2HZGkORJZnQb4+NdU5EkWWO
	dkxFsnNON607v7EGtzjOhJ3rACTafrn8NJ/Q7toUMKy7fZuQ2Mjyl2ZrfxUwM17a8zPxPkRwQzA
	T9pYWMkBPda7gMMsrlAD3fQ4YzBsQOdERcPfPPYUIR69tgnOQW+nyveupBYZ1xAGsqYNWNW6tGf
	85/elGxoPBDhhwy2dsyJnTiXealXGl5SrJfCY6F/p2nbs7mvg/ZWpgJAa5+uHSIeb1qwFJaCupx
	oYt16KviiQAdMInIv5YOTa5qoXLqZCp2KFLUjhWbymCw5ElG6YPgNbTNSveZZHdhoI2bKsk0VkC
	Nf1UPIzwo5bUOpfixC74E0oupDxxCW7bghU2RIzXkQ4ZD44Q9Vbzpjejkod0R4q7QFoaPf4tLkw
	2Y8C9pmg29Bwype5Wk1oCbwzn+wtnEcTiVlAIBBBw==
X-Received: by 2002:a17:90a:1c89:b0:3a0:9dbd:431a with SMTP id 98e67ed59e1d1-3a09dbd4752mr4892435a91.10.1790432472414;
        Sat, 26 Sep 2026 07:21:12 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:11 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 28/36] selftests/bpf: test for stack-pointer subrange pruning
Date: Sat, 26 Sep 2026 07:20:26 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-28-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
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
[-64, -8] is considered a superset of a stack pointer with range
[-56, -8].

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_stack_ptr.c       | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 3e0bea9819ca..5da8b9a6018c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -586,4 +586,37 @@ __naked void stack_check_size_512_with_may_goto(void)
 }
 #endif
 
+/* Verify that old PTR_TO_STACK state is considered a super-set of
+ * new PTR_TO_STACK state when new variable range is a sub-range
+ * of the old range, e.g. old [-72, -16] vs new [-64, -16].
+ */
+SEC("socket")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+/* r7 is widened to [-72, -16] at the loop header (insn 3),
+ * the loop body sees [-64, -8] after 'r7 += 8'
+ */
+__msg("loop header at 3, widening r7 to -72..-16 step 8")
+__msg("R7=fp(smin=smin32=-64,smax=smax32=-8")
+/* back-edge state is clamped to the remaining iterations and pruned
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
2.55.0
