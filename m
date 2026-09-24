Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149DB3D9DC9
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267512; cv=none; b=nAY/QBuhN6+FhHCNRjxS+s1DYq2cQzc48kkSf1wp+SETI2iBr7dkKHcxZa6PH67yEZwWj8oOPKXikULwQbCR1+cs4UdYQEGb50rWdFhWwKs3w9vG5dwzmw/FxboM8a/Mwj+QglsNMPFYPvoAJbYNoRPkPQIBs7Uch6bAUcFJsXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267512; c=relaxed/simple;
	bh=2HRbAGUEMG7W+P6QMWiBmhj4DfI8OIAgkWvYsOil6qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UU+2Du8gpKqB7PgDhHbmoItafguewZfZpGZqm0bt1wLRI/LgvCsVmVPy+hNPWUu5Tn2ScxcaOxTGmX3XdTayaoznaAoQeFP5aiHtmSJIdSkgT5olc/dKC8U3kYTlpFQjeaF5bHC9sZueN9hb+hFC1vJ6XuJxvEkX66eL+ZnyLU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+owkesy; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+owkesy"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso102815e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267509; x=1790872309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVwP4zBz7kMVw+zXi2dLCXwykVePRk/AwN60VOyOh0A=;
        b=S+owkesyipE1YwJLCmB0FCtS0Wkir49GUvghJZanx+iB116jeRrYpEm0jVF9ELJVM4
         jLsli3HlkNRV9o9tP/xl4+4Oxl4uNBb0dALWFla+qhYIvoe0qO4hQJmZ27FcZPMZ6NeW
         Gs3UhkT34+VrPTmx3CvJrEIYYV00KY/prdEKAfSa7+9oTLZJyIlf8BM0XNa48uhdhFeQ
         tgHjm3N4wLMnQneTgh0VDDeKPHCWd5tmlhz3zc2bq1fwoQMd7NHBA33pwYRwFcWv/1Tf
         /Sb61vYVaUlVBZUxc9i/+uTsQ9SU/LzY3hvHSDV90UbWClAjntMDrPPGnZEK0I51djIl
         wRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267509; x=1790872309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVwP4zBz7kMVw+zXi2dLCXwykVePRk/AwN60VOyOh0A=;
        b=T2PTit9CzKhFQM0FzR8djZEWytZCayfBlEXrAXjht/yY1Jc0KwtFzniZfK2Pf5wFVx
         7J5kDmK9Jit1BBI/b/9m+9rMyD3Snqtuyypa9tOXteolrMuk4BBsB91cCtIiutQSjGs4
         HkDQRZw/4fuENR7uk38XRv6dhEjCHxQ57JjpjGWnWk1a64ZNitqsZxISWkvUumzdF5mJ
         mx1/FtrTFDHtCNj0TkfDaQB8ElXYA5KcIb99fq2EtufxU8VV79DB3tTjgABO3Az8w8bd
         5axuRKs3rG21CGFpj+xqwZBVKu5ptYujd5Hr3HV/h6oojVUbegoRZ3eK1SoSlMQOC2Im
         zkAg==
X-Gm-Message-State: AFuF++neJbUT0BCMYhOoSq/Z52yZhKlilKEJiJGHiRqyazbTIUMvMFIt
	4tRbTdMDX3J0Sp1wi7xBVWKW+TP+4IOMur+0cwNs8zgQztEj4yWvRdk5Cz+mM8Xg
X-Gm-Gg: AYBFou3ZoC4ChFUM7U0qFDAGntOrN0QQ0fDZNYoqkxCCUqjujMQiRnj1nxfoK4jNnN5
	ZVMBmSLBTkWrRQjPpn/bKChEK8mCVzmf/Q/Q71WuaI1U8fNp3Hlq7SrBT06LiRA5EFeXD3TLiAT
	QMLk0A8Whf1GQSLrjkc9iuf4ktbRBZTQvXLNnSfQN6ZXvX7mV8Y54+7+4OeMwV29Al4rP2QLrrI
	EaTDEdUFZLrxT01J/x0xSxrnm1fG14S39olXYD3rMNYQCRVpSuG7dP1keWFRyl9Hq3QUfcrtuLx
	5z/Xyf82qx1a15yuhEVwk9wkhEVCCA7+OHtwskhqnvr1Bfn8IRkfSHpRPkA79IgzaJxksRY9Px6
	TFzMDfqHOehitg1dfQqMgxQUQ8dPN1EHuiD7FCzTeKd8B8OJ4M9IW6SuC2e3nvqJ8P9/jAu53yQ
	SV6UaAsU5146mmMTy/MDxqt2olNq8mgy+ZbPRS8Sfg9bJ0uqB3FRB3MOlpHv+9tu1Bu89YiVinf
	Y/71V0TKoAmUvyCdvvgjIgrGa6Rt2UW98fYh2/NKGFLCsPAQwg428qnUE7ca3HS7UJio1SshRUI
	Hen58ZOBctM+J08maQqKewkpISMknHDv1mQP7oE=
X-Received: by 2002:a05:600c:6207:b0:49c:fc6c:be13 with SMTP id 5b1f17b1804b1-49fe66ff146mr55978705e9.25.1790267509242;
        Thu, 24 Sep 2026 09:31:49 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee915f3dsm141805e9.1.2026.09.24.09.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:31:48 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 02/18] bpf: Widen the stack slot index in the jump history
Date: Thu, 24 Sep 2026 18:31:16 +0200
Message-ID: <20260924163144.1945455-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924163144.1945455-1-memxor@gmail.com>
References: <20260924163144.1945455-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794; i=memxor@gmail.com; h=from:subject; bh=2HRbAGUEMG7W+P6QMWiBmhj4DfI8OIAgkWvYsOil6qM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur70uH3Axxl653nVcm9kXkHRb+O0NLk+vI/BeLtqZn6 c/r95XvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESOPWL4n8lfUBTDsWxyyb4Q o2yJ343Ofx6kre3MkfsX9SM09sXCOkaGn4zf1ppuYYr9eF5rStgRreXFWwUDynQO/X9keXzXpqY JXAA=
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

