Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED23D953B
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238376; cv=none; b=ThLOsV5XofGWwv6PgFcgjNLbA09iSGr2rnV9s641Wgk3gaID4knxPGI1NlKstoVkXc+3aq5XL18gDLMGfu1P9B2CcV2nh+i4kzdMxybJgNB4BLpMrq6W06dNoWuchQa/qmLgevYLRb+Pz4skYIce8W0EUsxzBmQrmKzGYaOymxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238376; c=relaxed/simple;
	bh=2HRbAGUEMG7W+P6QMWiBmhj4DfI8OIAgkWvYsOil6qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfYbwsH4lJK8a/XtVOr8mTrhWZtZM/lVD3YUBMDe8sCZ0bqCDfzUyTO9DBiLB9RYD3ZsjVJPDsFyXjMJbw3DUslGJWrvtzWB8s3L2K3nHzuUA4pFo6dyYvXpW4jOLMBinUgJzsxdX7tKsUdBlm8h3pNemdCbphus5BMOEozm7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIBKvnXH; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIBKvnXH"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so3770425e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238372; x=1790843172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVwP4zBz7kMVw+zXi2dLCXwykVePRk/AwN60VOyOh0A=;
        b=SIBKvnXH9aBcpi6AdOd/5WX3PHik7XB7EsxvrNqcIsj1H9gsjPmvd7w8rAfBqzXtMd
         uhPKY82PBdmzPhizAFr32Kn0O6hX6cTobvoK2czM7kwenzd1QpSUm8CoMpKqoENIN180
         fN+5pKWBJwII+zG0wwCabdYLSx5E38k/oXPUYE3GrNQMxhVBeNNzSHspmWVRxnAsankg
         eKxnGAnwrB2CRGn38f6V05Rz3z4BW6zW6DmuyHHrqhmzopQieZyTm5Sc+MUGSgDtX080
         EeDykSPu1x0dDizWetOgJ697v+GH9sGA6u5zsW01bk9Y6lLMSJp/8JxUJya77UAmYC3z
         mbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238372; x=1790843172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVwP4zBz7kMVw+zXi2dLCXwykVePRk/AwN60VOyOh0A=;
        b=Aj4tLpV/XsEQ6JSbNZBmI+XfGiGzM07ycBbUzN+gDfowUSQtDA9zdXssl1VzmxAK/8
         2fJ+1YbCA8kv3RPZuMqvsv92NpDFERR485O4cfKpe/vK0JyP9YniYaUDjQyBTno2wi0W
         W1KHluzN+8i5Taorsag/g9U5M0bF+NaYYS1MDfjEifmSwTPKvOoTIcuqA23HK7gb2Wdn
         VfoD7o2x++k1yZfXA9fMu4QerBDgT/yhpsB78Kore4rq0b4aHNqWDE4L7B+zqYDXJh6C
         Ihf0kO9Wy+B6GvgUss9rjUIZyO4p4ZOFE8hVapRrTtGXk9X6r47EinyggNG5wDa2NtI2
         HFmg==
X-Gm-Message-State: AFuF++kAQSGrBM14/KW0wJVUg8wCLNaNhVEyivm1YRMGMd4IB4tfuRCb
	GvJgJP+/7JNErtQV02rsOlKn37eAb+awIsFFGNcfbsFAKnGwV1EwCe9/7vNjxiIy
X-Gm-Gg: AYBFou12sfEAp+6rvees78l3I3dE1q/GFgMZP2g1cbBvQ77i2Ls0EuI7YpA7o1b3hnq
	weyxnjWrAVsUm9+TzV/pOfSTkLsbxZvprBvHhsAc2K/OtKs6J6W/LCg+TtzfAUCXAQGT0km7rAY
	4E0tIjK2kYPHHuMvd/Jvlcsm5QxVwdwjCt2VbL0R9duVlf01uaJ6OsO6Yoj/0CBUPhLmtmUfH/9
	UOTERy3xLhGg0LWuMBMhjyf84ennWZp650i71U53t69kJTHycKJ/i8iWfKLEyYCYocXocZULUpW
	vL06fe38tEhhnZlHrS/xydZdO3mWrvzwHWT7wAjrmUrhIy2Mls2e7jZ+O0j7++k4kRNRamLS3Wv
	6id6ZoY3mHioSMpZwx1rufJj32eiD0zxc8r8p1g0LnQRacRpz2Fb8NkCXdBpNsg5187BiqY3L9t
	vl3UrqvevBRw+MK7ezbmOFPBUu4COqMOU1GynVkUeUSRKwgX4OpCw4jnbQQ/uaC80DUd1ybP0Hh
	Y3RmyTqG5VFf2wuwQKLNxwfEHYeW66tKQmQFIj4qvJYIIEkk63th1csORU0mm6ZsinluHq/dYpQ
	KpWRj30HvcaqWYSdEKRAUJCrZiOcZjCPwOOclw==
X-Received: by 2002:a05:600c:871a:b0:49c:fc6c:be06 with SMTP id 5b1f17b1804b1-49fe6707786mr25739475e9.29.1790238372489;
        Thu, 24 Sep 2026 01:26:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682673bdsm12700067f8f.2.2026.09.24.01.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:12 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 02/18] bpf: Widen the stack slot index in the jump history
Date: Thu, 24 Sep 2026 10:25:38 +0200
Message-ID: <20260924082607.2695649-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924082607.2695649-1-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794; i=memxor@gmail.com; h=from:subject; bh=2HRbAGUEMG7W+P6QMWiBmhj4DfI8OIAgkWvYsOil6qM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLvUSH3Axxl653nVcm9kXkHRb+O0NLk+vI/BeLtqZn6 c/r95XvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwET8cxkZbm86wLturTv75VsB VXc3yUmaH7z34q3jq/ILe7alaFQ45zL8YjL///ILG+Mk7e+cFY57zt2ZlpJ87NiVE68LbjNx3Cr mYQYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Jump history entries record the stack slot touched by a spill or fill in
a 6-bit field, which only fits the 64 slots of a 512-byte frame and is
pinned to that size by a static_assert on MAX_BPF_STACK. Move the flags
into the first word and give the slot index 12 bits of the second word
instead, so the entry stays 16 bytes while frames of up to 32 KiB can
be recorded.

Introduce MAX_BPF_STACK_SLOTS for the number of 8-byte slots a frame can
have and use it for the static_assert and for BPF_ID_MAP_SIZE, so the
verifier expresses per-frame capacity through one constant.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 731979aaa661..5a1d21455831 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -242,6 +242,14 @@ enum bpf_stack_slot_type {
 
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
 
+/*
+ * Largest number of BPF_REG_SIZE stack slots a single frame can have. A frame
+ * may use any part of the MAX_BPF_STACK budget; check_max_stack_depth()
+ * enforces the bound on the combined depth of frames sharing the kernel stack
+ * and on each frame using a private stack.
+ */
+#define MAX_BPF_STACK_SLOTS	(MAX_BPF_STACK / BPF_REG_SIZE)
+
 /* 4-byte stack slot granularity for liveness analysis */
 #define BPF_HALF_REG_SIZE	4
 #define STACK_SLOT_SZ		4
@@ -424,12 +432,11 @@ struct bpf_jmp_history_entry {
 	/* insn idx can't be bigger than 1 million */
 	u32 idx : 20;
 	u32 frame : 4;	/* stack access frame number */
-	u32 spi : 6;	/* stack slot index (0..63) */
-	u32 : 2;
-	u32 prev_idx : 20;
 	/* special INSN_F_xxx flags */
 	u32 flags : 4;
-	u32 : 8;
+	u32 : 4;
+	u32 prev_idx : 20;
+	u32 spi : 12;	/* stack slot index */
 	/*
 	 * additional registers that need precision tracking when this
 	 * jump is backtracked, vector of five 11-bit records
@@ -438,12 +445,12 @@ struct bpf_jmp_history_entry {
 };
 
 static_assert(MAX_CALL_FRAMES <= (1 << 4));
-static_assert(MAX_BPF_STACK / 8 <= (1 << 6));
+static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 
 /* Maximum number of bpf_reg_state objects that can exist at once */
 #define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
-#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE + \
-			  MAX_STACK_ARG_SLOTS) * MAX_CALL_FRAMES)
+#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
+			 MAX_CALL_FRAMES)
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
-- 
2.53.0

