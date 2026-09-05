Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB4E2472AF
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788572862; cv=none; b=ZAYynVUfy1Z5h/Ksve1rov9t+fKkL4OFyLckA4wiEOiq7cplRmYu1Q4rkgi6G0v+bSZ8GMbmn3E5Gs/Op5V+EpBmAwNzyXmoWMlFeKQef/27n72Pa7zy8gy5tr0iHeHHQIeiOif0Hvq3+OPCjiG3Pc55Oq5xvs34fxtPjpYlsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788572862; c=relaxed/simple;
	bh=olcXl3zqGkF72FTx3n48K1WzGkTNYJtVZhrSzkscQ5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIDHLA8Tl0aoPFOFAKN97eBc8vqigSUHEQaFjEubbZxBTn2Ljlm7vFJKtERX+7lsM8VuXUZy+QBo3uxEZskxOYJaDOEtA1Q8Krzh3/AYZ+AcsnMNLjtPfVZMw5a/7MRm0mB+dvjEi2ag4fKBABPyLfiSptnxEzfolV6pR5JhRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sr9zGtmE; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sr9zGtmE"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so9632075e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 18:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788572859; x=1789177659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vWTkrytLJ1keLYF4crNEAaBVuJ3VnzjlPq+py3syKZc=;
        b=sr9zGtmErEdBezFOaixXxSOtpJ6T7ZPBbR+1fFQlOcdU+uS/6AMjlPL1f8/js5Oq9b
         9KG6ZFp0rO6TegDxRJClKNPpqv/DtuwNFY5+SvMni3ushqet0jfgte69IX2zzPT5I6X3
         P286FkbYnB8s104Hzx/vf7PJw5GjOe5v+u6wxEy6D7QOfCO5oR2Uw/8et/j7/syIqReL
         dnuGPvrQMjYnzvUt/4diNdQVEEESSYSBXqw8DEPGdUUHzS1vcJkB+Vo4tJPdIqUZ5aEN
         ysWE8Xo6GGtLRbap2V729SbevcdUKHlxB0aBZI6mxyhPvBqiZk2cQMuen/orQwEBNej9
         KrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788572859; x=1789177659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vWTkrytLJ1keLYF4crNEAaBVuJ3VnzjlPq+py3syKZc=;
        b=INOs6aIVIjXG6fRa38suA0hS+fQhgb6LbvAXMZA76X/WWy8fkLE78KaJ5TnVySQirI
         LcBV6BvbjVw2J2dhsLccG17anu1hUSyyC6IGpdujBysxDzoyEm/gO0iPmQDqnEqCFEqw
         LlUe0mFgzfsipBi+LyTvhLl7KPBAkZNk3moM7MVtrB222Q0cOsnzSliEdcesp3jBtKni
         CEiL12PHv30togo8nJIUpMM8/ZBd1NO4jz1Y0bKm8SDmMSPYyhptuCCBs1BqiqvxyWK9
         r6+tyxe/w1m+PxmZ0NLDHM1Pfac+u10ySC34wMQ0YQ01NTHyrWGqA9do7C7DiKpQsK4O
         hKdg==
X-Gm-Message-State: AFuF++nfp1H61chSPz316DMvrhRr7GD3sPiTu0HIJ9mMjA4twB9UuOpV
	lUH22JEs5PP8AH9qYRa4mtlsum/M2KJg823E985SF8DZXj5ztoeds0NZAhpCVLK7
X-Gm-Gg: AYBFou1Atf18kWkVtr5HnDlTMbFGcVsakSnc+79XD/deC4P7BBtVfNVtqwyzlhj67kp
	2d2BIrgFdewjxDIwBkk+zS5bQhEgEHd7lbsM6wbc4CIh1tP47VjjA8sWQeMT6g6RIElc8VG2bw7
	8Gz1bjGtmYoogwC6ju4qGhoWraOWaeHHaoIUD3ydMqlUf836YNO459ZVMNo7noIC7h3AIDYNxhA
	2XBbI+ouCp+oRemGoR7lUJQeQQ1oiSXVcfo//AdpGjRQOAGREBwi6QIrqoZ5G8sp+f3f9tzxu+0
	xusJ2IOruuboAPBVAfO4a6JLPozXEC+3C2FGuqWEOAuB3P9BnSTj17pg7hzHcBpihtA5uqw/2c/
	LUZ8E+O/S4pjD1NyCxOiJgiHhExzffSpKYjlvNy6/qlA0twdz6X1gMHitgzCEHNujzYbcnQGydH
	P33zq4mD0WPnAjavCIhAFl1EaBxkWn2s6EVXMpfwlIUnT0tV2z6mX0kfc3i36FwrXFCwZDLYe9+
	t5t5BnDRiYN2lUGHqbu0xcYSe6Ht44XmVaXQSlPgv1+R0E/jV4AUKblFuvbxZ/iTIjViWv+rTfc
	bQhuM2oiaNYiN96xLXefW/BybdA=
X-Received: by 2002:a05:600c:4684:b0:49c:fc6c:be14 with SMTP id 5b1f17b1804b1-49cfc6cc10bmr71936195e9.26.1788572858623;
        Fri, 04 Sep 2026 18:47:38 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f9114sm189518245e9.5.2026.09.04.18.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 18:47:38 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: syzbot+7b47f87674e9a1569110@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/2] bpf: Reject non-scalar bpf_loop iteration counts
Date: Sat,  5 Sep 2026 03:47:33 +0200
Message-ID: <20260905014735.1452988-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905014735.1452988-1-memxor@gmail.com>
References: <20260905014735.1452988-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2787; i=memxor@gmail.com; h=from:subject; bh=olcXl3zqGkF72FTx3n48K1WzGkTNYJtVZhrSzkscQ5U=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWt2UVbZ8zXd/ge4+i+F9k3k+RjA6ME9rTxWvH3GRnsdb ZdLp1k6SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJGepYwMa0N1PBMq1H8yzp7N uNc22sPN7Enx/clL1582PvYp/JfdO0aGmb8KYy9m7P22UCfOZ44hL3NTU42j5LfeHTxdDaWHhC8 xAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

bpf_loop() declares its nr_loops argument as ARG_ANYTHING. Privileged
programs may pass pointer values to such arguments, so check_func_arg()
lets a pointer-valued R1 reach the helper-specific checks.

Since commit bb124da69c47 ("bpf: keep track of max number of bpf_loop
callback iterations"), the verifier marks R1 precise and reads its upper
bound to limit callback simulation. Precision backtracking only accepts
scalar registers, so passing a pointer instead triggers the "backtracking
misuse" verifier warning. Kernels with panic_on_warn enabled subsequently
panic.

Introduce ARG_SCALAR for helper arguments that only accept scalar values
and use it for bpf_loop() nr_loops. Generic helper argument validation then
rejects pointers before loop inlining and precision processing.

Fixes: bb124da69c47 ("bpf: keep track of max number of bpf_loop callback iterations")
Reported-by: syzbot+7b47f87674e9a1569110@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/6a9ad24c.b5d4176b.238c3e.0001.GAE@google.com/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/bpf_iter.c | 2 +-
 kernel/bpf/verifier.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b7dbf3d9b5c0..e57af902560c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -894,6 +894,7 @@ enum bpf_arg_type {
 
 	ARG_PTR_TO_CTX,		/* pointer to context */
 	ARG_ANYTHING,		/* any (initialized) argument is ok */
+	ARG_SCALAR,		/* scalar argument */
 	ARG_PTR_TO_SPIN_LOCK,	/* pointer to bpf_spin_lock */
 	ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
 	ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 14a5fdfa0421..b40eb404adab 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -754,7 +754,7 @@ const struct bpf_func_proto bpf_loop_proto = {
 	.func		= bpf_loop,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
+	.arg1_type	= ARG_SCALAR,
 	.arg2_type	= ARG_PTR_TO_FUNC,
 	.arg3_type	= ARG_PTR_TO_STACK_OR_NULL,
 	.arg4_type	= ARG_ANYTHING,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c3039f3fc32..4638a2f85d0f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8211,6 +8211,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_MEM_SIZE]			= &scalar_types,
 	[ARG_MEM_SIZE_OR_ZERO]		= &scalar_types,
 	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	= &scalar_types,
+	[ARG_SCALAR]			= &scalar_types,
 	[ARG_CONST_MAP_PTR]		= &const_map_ptr_types,
 	[ARG_PTR_TO_CTX]		= &context_types,
 	[ARG_PTR_TO_SOCK_COMMON]	= &sock_types,
-- 
2.53.0

