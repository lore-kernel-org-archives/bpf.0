Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A24A6CF2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269074; cv=none; b=COQ53w6e403VpzTBazuUPCw4P59isrUpcbp/TU4yS+Nq5CJ30mnwlaUh9lw8djItibBaqziYCRirxp8x7LBPQe9xqdZ9SfExKlp+/KXQV0AgDpXehY5nVYxmQA74mljCFi/cGyh+fZdWXf43TAJ0qFJAXu+nevw0vd/o6krG85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269074; c=relaxed/simple;
	bh=Fi5q4eK45bMh/cAfYEgUrLxXx/YEo6ca3a4vRvVNJqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiGXYRPIlbGophMISRv5YPs6NIl3XR1Zgbcx/6JwBCakUjx4rCX0dR8pXfrcwET+R0C6w0zWJ+PxTRcsYaphADLLj6N31t4yJ6tr7f1qrpOaa03FMy51VWWNmSnRcbxw0qNMcIz6viBpS5hfifekTFVbt1kZoJV68jD06IsejSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZluXavTP; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZluXavTP"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso301225e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269071; x=1790873871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BCEPDgo41ULbDXFu78KWwVu3tn9rEbMu8NT52ZYw+VU=;
        b=ZluXavTP7d4Fqu0am2V7w/wRBdvQneIaYeKXdr/X4m0ftis34q7B04xJZr7IRD7oTg
         mlqXFASiEIYKr0HAb+VvOPWhcgf7Tc5u2wA9Hzl6Rqv0Fazi1VYLd7XH5VqkUBh3cSHi
         oQ6lzEMuTMCo5/GcxDszSvs+DFDkd92XV4Jkom9Euw5GS7cpKN5IpWgURJYYPcIIfWyu
         69ecGx1s4BgwFnxcxg60NHWhXmroOIVcrHVyKAiRybu/ppPYLXlN6tEataWozsrjehYV
         HZXFwq7JZIlOdT6uKf3PCFVXCgI4KH2kj0sSLhZTkjnYKUsfKbBig4nIVTQidJxqW3TZ
         RyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269071; x=1790873871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BCEPDgo41ULbDXFu78KWwVu3tn9rEbMu8NT52ZYw+VU=;
        b=yjL9MCez+iCtwR4KHjCzcVd1YFsuNSItlwZAlSofIifexswEOlil3QCiOlM3wx+iIb
         4w/Y1EHl2HsS9/CKU0u5Xdn51VvgIGPwhTL1eGGb9guYVsyVOVqvKl7Qu1xK0hSnFRuo
         dZu31HgAA0iTPkGcQAyW+Z/j4KFA33Q/XfKLoJV/DD1O3Lo4A+7riwSVkA155m9aO+54
         hcoVb2lJJmtlmTKRE+sw304adsrM4vsuSfNW/JG9DNlZNodDOFgDooCqBDUohUDNNj7d
         cQ1jyD/3NNdLNw4MW2qV9IO/nRfGlXYbfTY1J/8w+RJ91dyrqoq2+vp6qRQeZd6kQ0fJ
         /abg==
X-Gm-Message-State: AFuF++k7UnB+ttqti6Xl1vlP/NP2IXrf2p4tVYYV9SFf0OR+hsswdN0h
	87urp3O+zCJQHlhOJuH1nR/Gx+0skHVfSEBkGxef7nVsPaGcBR7ba0AZBnD88zo0
X-Gm-Gg: AYBFou2Fix4rByCWwgBxolOvzl9zQZVDu4+jzIlGsNZK0+PYvUQKZw5mNzScJhM2UJF
	uj2jatSUiJJK2Qa/Me30FqXGXeDZSZkvtFJzTowKqXfFu2CcbT/4cJAB4KrMVJxNVyh7uyar4fv
	z3aRerx/bXw+3iZTfEs1N+n98kaDzDW0BKE5xIQIwN4/uAHOaOJnVmtRwMii3+1IqxNlQVsiVxi
	uwoscv8rVK3EzsHZYBuSP+YAqztPz2azfWB3+xN+uAZ9kujvmT9Uxuejw5XVhUu8iiHvwc8LXJn
	ilvymEG39qdWM9Wy8jqOoucxg4v3A89g0BizF1pwOCEofAWJGhsbQuGJq6GPcdM2+yBXHlGULfa
	k1v0ZjkreJOd8OGoyIXtKNhdAeV9j8HMbm+nJZRUKIG0+7tLLQ6Cn/oSJKNS1jXpOR0Y2fNvwgE
	vnSn2FUsmk/ggVUZsE6BFy5/XlooovhEDLS/KAEVdqBstyG7PkCVJjNofH2vahLfIn6nnfKWeXm
	1I2WMPKQScGTYAZxAi8Yl/DOwDvRn3Jz06Qpr98Pa0/c0jOdccrgg5AnHmU6s05aCk6ZkMtz5B2
	Rw1CRLqQoO8qCJT2SfhdLJL14NeE+428h2+Dbw==
X-Received: by 2002:a05:600c:138f:b0:49e:602a:b4ec with SMTP id 5b1f17b1804b1-49fe66d2700mr55199925e9.8.1790269070772;
        Thu, 24 Sep 2026 09:57:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cbd77bsm95438225e9.8.2026.09.24.09.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:57:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 05/18] bpf: Track scratched stack slots with a bitmap
Date: Thu, 24 Sep 2026 18:57:06 +0200
Message-ID: <20260924165740.2146806-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=memxor@gmail.com; h=from:subject; bh=Fi5q4eK45bMh/cAfYEgUrLxXx/YEo6ca3a4vRvVNJqw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtraL76r1Qxn2TOh3+XJPC6+ryM3NFpMu2o/vS2z108V rtkb0/uKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQ8jBn+R7Zxz4t7onnz35Wg tx8qjKLlr/5rbcgNlVQpavRdcuK/BCPDlFz/jrntoZueOBh5zpddW3X39+T/UanVc7ed6LumcOI 9BwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The set of stack slots touched since the verifier state was last
printed lives in a u64, so the log could only ever mark the first 64
slots of a frame as scratched. Make it a bitmap sized by
MAX_BPF_STACK_SLOTS and go through the bitmap helpers for setting,
testing, clearing and filling it.

No functional change.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 781dc5ca1fe2..e64cfb3fe675 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1092,7 +1092,7 @@ struct bpf_verifier_env {
 	 */
 	u32 scratched_regs;
 	/* Same as scratched_regs but for stack slots */
-	u64 scratched_stack_slots;
+	DECLARE_BITMAP(scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 	u64 prev_log_pos, prev_insn_print_pos;
 	/* buffer used to temporary hold constants as scalar registers */
 	struct bpf_reg_state fake_reg[1];
@@ -1520,7 +1520,7 @@ static inline void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
 
 static inline void mark_stack_slot_scratched(struct bpf_verifier_env *env, u32 spi)
 {
-	env->scratched_stack_slots |= 1ULL << spi;
+	__set_bit(spi, env->scratched_stack_slots);
 }
 
 static inline bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
@@ -1528,27 +1528,28 @@ static inline bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
 	return (env->scratched_regs >> regno) & 1;
 }
 
-static inline bool stack_slot_scratched(const struct bpf_verifier_env *env, u64 regno)
+static inline bool stack_slot_scratched(const struct bpf_verifier_env *env, u32 spi)
 {
-	return (env->scratched_stack_slots >> regno) & 1;
+	return test_bit(spi, env->scratched_stack_slots);
 }
 
 static inline bool verifier_state_scratched(const struct bpf_verifier_env *env)
 {
-	return env->scratched_regs || env->scratched_stack_slots;
+	return env->scratched_regs ||
+	       !bitmap_empty(env->scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 }
 
 static inline void mark_verifier_state_clean(struct bpf_verifier_env *env)
 {
 	env->scratched_regs = 0U;
-	env->scratched_stack_slots = 0ULL;
+	bitmap_zero(env->scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 }
 
 /* Used for printing the entire verifier state. */
 static inline void mark_verifier_state_scratched(struct bpf_verifier_env *env)
 {
 	env->scratched_regs = ~0U;
-	env->scratched_stack_slots = ~0ULL;
+	bitmap_fill(env->scratched_stack_slots, MAX_BPF_STACK_SLOTS);
 }
 
 static inline bool bpf_stack_narrow_access_ok(int off, int fill_size, int spill_size)
-- 
2.53.0

