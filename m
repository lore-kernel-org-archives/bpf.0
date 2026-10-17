Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8843BE621
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255314; cv=none; b=Tl22vAjM6INJxkr0oVl3SS5xchgN14ZrMPy7+2zsLPNK/o0iUd6TriAwFB3oJreXtdnndHHNf0oKmFau6pbuoNbCOe1BMjN5yL6ORx7qWGH5hQcPJ+aBF5Nkr9eB6b0UaCW3tyax2uOUHIIcAHquspdn1rROdpnhdHkod2TnYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255314; c=relaxed/simple;
	bh=R+DPCBEkdgYI6avsD7xgcl46Y6TXpa2aAM83O0WBiXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHw+zdhTPUC+IAAVFPcK+k33SWOvgRbCjnU+xGZneLyBiZh3YXHK3P5nsd+i5zDP5QADZ4uLgvEvf09U8QaJTaMk55os2sKBpV7QayKMuF8FVEEzeOyjQmCSesW9zA3jvOcGyw7B3c8wnCOpXKlJNOhff7pIN8m4RzE6i+jreC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldXI+/CT; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldXI+/CT"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc147d86bebso592485a12.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255313; x=1792860113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WGbfhlZclnf0Sz0zZg2NrkKRp/tNpyz/wz+xRYKuPic=;
        b=ldXI+/CTCUGRY8L0DoIDVPS8rnOCrQYiT8EKYnGYEQhAJ4FIdxN5VirF2+0z5RmMTa
         EWbrWk7GwSgFjTrhuGUHxN07nGTkvh6v8EkaEluqdZqfiE7knKLLmJMhZXCbVlxQ2TbG
         n7woJaROkHSXReglBF6lrUdl9g4oIE4dhYSnEIgpyhzCqQbyp8c+RsyRUtzuqN/syUuM
         7Q9Atrm3BMtrkvogs6IQWG5NNWEol9OtnUoGS0TwdM4k0B8INWvz7pP/v8aRnQR4QOJX
         lbF28mxXbJvqOmLHpB3V/t5dM3BZREZ1Fr3q4g6rYmQcPH5m5Rf9GRuqsoUo716FvhU/
         cD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255313; x=1792860113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WGbfhlZclnf0Sz0zZg2NrkKRp/tNpyz/wz+xRYKuPic=;
        b=SF3ewx+upu7arxrI/+ub8qHPkB30nWVkWjBSgq1gCTL77JKpmhEStBJHlCDRTR0n4j
         5wMJClAj9o6mPwq8Y68oL8pJr03YFCflWnLeWmu+y0p2LIEdPqvZ7aPZAkyH99CQfwvx
         uCX1s4jsma9/a1TzlONDtxpXF67MK2Y8K8Ms9YpBXKaLPst90K2b8Q+8mPM80i2LIS8Y
         V/ixGOwS9nyNim+yffMrNQALgJlbfPKHb9v5Kdr5RNZ7/sEu8MSJBTGTfLh7yPzGK6dO
         gMTswlf8q2c57SQHQlrNVDT+CRKkYlXQO+ePGr1vn2TI4yKJtAaRtk8Cy+bY0PzlzE7C
         m0BA==
X-Gm-Message-State: AFq9FYLqd5DCDKsfK7kpR9lrzu9kmuLwXkafRJBNgBgq/hS9ttM6D1ly
	GyWzXg9OhEUja1ZIZh4MTAdnA+qOvWWXVNBWk2+fiqKQnvHVsUSItPOy3dEHgQ==
X-Gm-Gg: AYBFou2sbjZ3YqY+rmQp6osbX5Y5BBl9rtDdIBrhV2l4qIyiZDS9N1InTX46LLsdaPX
	58Y3r7BHN8dnxr5Xh9wPOoONIaFJ43SSbUwFuXITPhPbRscHbcYPOvL0ELiKNXyTb94heXEJ3Yf
	dgeO6YIbqIVfDwjf5qMMe3ekxI6xgzq2qytpwe7jKtqQHn3kOfICxoEG0YFLcbCW40rK42HDZgw
	zB6rYoJ3XEPFo6bQdFMsSP1H668qdpeOPeKPfLqaxe9S6HwhmxhkS5u0g8lgOtf77m2voWF9N4/
	G5I1I7Iaxmt8+W0iDnBAvIrRYkxQztMBTaf8+14HZop4i4I42g0dH5Im+gHsYNoOUdNbfrkC1SK
	IKnnjfZEf4u9+jB02pw1FDNBzIx/dlYbNqoTFvK+Mrk8Lp45B42RbJapVC5WlMOQLm5ftpxe9Qt
	3VdEnXhsWIAUxp9DSWtvUXW5YqPtl9eI6ifqE9d2tbXkEc7Zul7KvDWy8U1zGIlTcvUH2b7jUJR
	y5t2Jr8xQG5nEaiOhdMZTchOj+Okk2u2dvLznhZjHNl84i0ft7cfnUM5PBn0unhVmHVFQxsCVl1
	YfDjDZa2yDuFKZqSjGNs7rktI5KYpxhg8vyo7x59jfHx5rLoPdDHlpg=
X-Received: by 2002:a05:6a21:7e82:b0:3e2:2b6c:2e7 with SMTP id adf61e73a8af0-3e22b6c0795mr1299944637.28.1792255312990;
        Sat, 17 Oct 2026 09:41:52 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2277863a12.20.2026.10.17.09.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 40/43] bpf: Unclone the skb for kfuncs that write through a dynptr
Date: Sat, 17 Oct 2026 16:37:42 +0000
Message-ID: <20261017163745.3341787-41-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_dynptr_copy(), bpf_dynptr_memset() and the kfuncs that read user or
kernel memory into a dynptr ask bpf_dynptr_slice_rdwr() for a slice and
write to it.  For the linear part of an skb that is a pointer into its
head.  bpf_dynptr_slice_rdwr() counts on the verifier to have uncloned the
skb, see bpf_unclone_prologue().

The verifier does so if the program itself calls bpf_dynptr_slice_rdwr()
or writes to the packet.  A program that only uses these kfuncs gets no
prologue, and changes the data of all the clones of the skb.  A packet
socket, whose clone is taken before tc ingress runs, sees what
bpf_dynptr_memset() has written there.

Treat a call that may write to an skb like a direct write.

Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d384b9ec3d93..47e2969928a4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15689,6 +15689,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	    bpf_is_kfunc_pkt_changing(&meta))
 		clear_all_pkt_pointers(env);
 
+	/*
+	 * These kfuncs write to the head of the skb in place if what they write
+	 * to is linear. Like a direct write that takes bpf_unclone_prologue().
+	 */
+	if (is_kfunc_dynptr_write(&meta) &&
+	    dynptr_write_changes_pkt_data(meta.dynptr_write_type))
+		may_access_direct_pkt_data(env, NULL, BPF_WRITE);
+
 	proto_slots = kfunc_abi_slots(&desc->func_model);
 	if (proto_slots > MAX_BPF_FUNC_REG_ARGS) {
 		struct bpf_func_state *caller = cur_func(env);
-- 
2.55.0

