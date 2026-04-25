Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4237F8BC
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157323; cv=none; b=ZqK2oaTPv+b7BDc3bW+Y6oEiuPjWzzRAf4uHMppN5c3Rvfyh68amPNQZabV8TNyuvX574q0JReyOJFCaj6aal2qcQhj2dTIufNUNjhOSLb7ysl0yCq/krmvCeAIaV0GKODiY3dBGRvZvz1fDOpAn+6ErR7PlUITg/TS3R/rF2VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157323; c=relaxed/simple;
	bh=lUnXb2AVZjhjzuM7JX9Er82xDDtF1N6iG+LxYOQFvjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlwYfxAf55lolz2/sSpzyUD7Vi8DuyahdfijgI3jnZv+xX5TlQZWNr/b8e1/vnMiK+VsYxMxpLr9suHhL9YhZUGIoDAkQfKLtsT7M/bE1pUAtwEXXt/+C6iOFit815z6xHiD6m8L/i8iKpCaEIA/Q0fJ32wIHOKfwvDDhgJ23zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yi+IX/Cc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi+IX/Cc"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so3883729a91.2
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777157321; x=1777762121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qu6t2GOBkehL7REohANbe6OcAv340HzJhpYglwbCneM=;
        b=Yi+IX/CcMtFbIDVaGjOJBBXgUITt+FF5LsBJlZ4BFGH7R7hXJ77e4qaWFR7TkNU0OL
         fH9avnVVYJKbKZ183rKHEdJ0gXhTrtdTJQl7+fJAnK7gUr2pG7wd0oh9TdbpNiNbLnSC
         dTLv1uJLXBkHsPeVLrgg4rz/ip+cKwvwSUGT3QbNmWuFmRN77j9PEYQpWMU9CFkwEA/X
         CJCMOr+SMj/vM9Imwb+R7U7vWQyknmWyQHvsSugbP2CBqE1NgDeSEP2V1hYgxgenJGUg
         vw6g76eQPivMJLJdOFMQjdcAowD1j/AapyehtQm61rmK+MFNomyEhiZvZNcxSWWG1lI7
         xHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157321; x=1777762121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qu6t2GOBkehL7REohANbe6OcAv340HzJhpYglwbCneM=;
        b=fR0N1Ghu9KBibFLst3pyANYbymzuia2DaZuLGFXPFUMUut+BwRK6xnu6CdYcUz4iL+
         +OmhQFq3KYxtTMIkhYPTWbxRN1QnSdr9R2Y2Mz0DaQKe14YsgPUgW2VqtJMU78iXXFKO
         uSHeflIR6utautXtLjJLlnuZB1oROW7uI6V1teRDWN+dWCNnENfbZTtDE/vLXeKxXkyg
         lZpGeeu3T/Ek6S2FGCshll+bh2yNrCu81aMskW2+ywUVq8+cD8h0cOnmtWQTuXJGrM5N
         7W4X+h7AORGYuSjVh44UbgjXxqWsnSEXbAomj71PMLRcu/1xUEz9vpze/q7YTdV/h9WH
         +ryw==
X-Gm-Message-State: AOJu0YwcK2/tAYc0gxMhHT15jcbUKERV10AcvxGpbv1IID9oP/yyzpOD
	U+ku9VRhPP+wpTalXCKr9DP1kclyO4JtJo57XeHjU1Wpyr7hbbpaHnb6tpqeEdBS
X-Gm-Gg: AeBDiev/aP+NuvxgAbhy32N+MUmT9nF6tCfOAHJh3enMm0p9Gl8KJ3kpjErPlS+2nX+
	3GiuuS1lQR4fPHi6ZKrsB3S+2bwuss/Y9GH1MRTz9eemZOMljc2lApPFhMBsCzrNcVHlCrwcJva
	IKW5nQW0ePYKgSrsx+GFUMU4RsNRYqIlWBkYQTQrO8NBIXg3VWwB3VAD1fAT2UmfU9SEHwZqP84
	qnJGcphtuH7Lk9O8keyxVJ3rXWB+9lG9OrLttDtQmkI3Xa4LPOzH3YRPtuRWa8FZFBGuOTAU++d
	6Wh7n6y0veoLhxVHFOaOJd4Pk+2K0SaSl22K0JH4EPIyyzTD4kowmsoWL+FPSmhxiFn5Uu0Ao9A
	cBMxSrswd1Pcv8EtJdG2CBXvZ0dvx3Qt6fBHooq+C0UBVC+JGgs9DQhnH97Hecit8E7pflR0q4d
	9f0CT8FkhUOX/CZoAPYD3e5nJFUB8576XbRd6KRZAV/wTMJZIlji0pifJgxJfSLdwUyiJUL+lmV
	qChyQ==
X-Received: by 2002:a17:90b:2247:b0:35d:8ea1:62df with SMTP id 98e67ed59e1d1-36140493367mr40309816a91.21.1777157320852;
        Sat, 25 Apr 2026 15:48:40 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410a7a9fsm27323615a91.12.2026.04.25.15.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 15:48:40 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: range_within() must check cnum ranges instead of min/max pairs
Date: Sat, 25 Apr 2026 15:48:23 -0700
Message-ID: <20260425-cnum-range-within-v1-1-2fdca70cb09d@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425-cnum-range-within-v1-0-2fdca70cb09d@gmail.com>
References: <20260425-cnum-range-within-v1-0-2fdca70cb09d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

states.c:range_within() must be updated to properly check if
cnum-based range in an old state is a superset of a range in the cur
state. Currently it makes the decision using min/max accessors:

  reg_umin(old) <= reg_umin(cur) <= reg_umax(old)

This is wrong for cnums that cross both UT_MAX/0 and ST_MAX/ST_MIN
boundaries. Consider cnum32{base=0x7FFFFFF0, size=0x80000020},
which represents values [0x7FFFFFF0, ..., U32_MAX, 0, ..., 0x10].
Its projections are u32_min/max=0/U32_MAX, s32_min/max=S32_MIN/MAX.
A register with range [0x100, 0x200] (which lies entirely in the gap
of the wrapping range) would pass the min/max check despite having no
overlap with the actual cnum arc.

This commit replaces min/max comparison with cnum{32,64}_is_subset()
operation. The operation implementation is verified using cbmc model
checker in [1].

[1] https://github.com/eddyz87/cnum-verif/

Fixes: bbc631085503 ("bpf: replace min/max fields with struct cnum{32,64}")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/cnum.h   |  2 ++
 kernel/bpf/cnum_defs.h | 14 ++++++++++++++
 kernel/bpf/states.c    | 11 +++--------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/cnum.h b/include/linux/cnum.h
index a7259b105b45..49b7d0c7645d 100644
--- a/include/linux/cnum.h
+++ b/include/linux/cnum.h
@@ -48,6 +48,7 @@ bool cnum32_is_const(struct cnum32 cnum);
 bool cnum32_is_empty(struct cnum32 cnum);
 struct cnum32 cnum32_add(struct cnum32 a, struct cnum32 b);
 struct cnum32 cnum32_negate(struct cnum32 a);
+bool cnum32_is_subset(struct cnum32 outer, struct cnum32 inner);
 
 /* Same as cnum32 but for 64-bit ranges */
 struct cnum64 {
@@ -73,6 +74,7 @@ bool cnum64_is_const(struct cnum64 cnum);
 bool cnum64_is_empty(struct cnum64 cnum);
 struct cnum64 cnum64_add(struct cnum64 a, struct cnum64 b);
 struct cnum64 cnum64_negate(struct cnum64 a);
+bool cnum64_is_subset(struct cnum64 outer, struct cnum64 inner);
 
 struct cnum32 cnum32_from_cnum64(struct cnum64 cnum);
 struct cnum64 cnum64_cnum32_intersect(struct cnum64 a, struct cnum32 b);
diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
index 3ebd8f723dbb..1f232138b6e9 100644
--- a/kernel/bpf/cnum_defs.h
+++ b/kernel/bpf/cnum_defs.h
@@ -220,6 +220,20 @@ bool FN(is_const)(struct cnum_t cnum)
 	return cnum.size == 0;
 }
 
+bool FN(is_subset)(struct cnum_t bigger, struct cnum_t smaller)
+{
+	if (FN(is_empty(smaller)))
+		return true;
+	if (FN(is_empty(bigger)))
+		return false;
+	/* rotate both arcs such that 'bigger' starts at origin, hence does not overflow */
+	smaller.base -= bigger.base;
+	bigger.base = 0;
+	if (FN(urange_overflow)(smaller) && bigger.size < UT_MAX)
+		return false;
+	return smaller.base + smaller.size <= bigger.size;
+}
+
 #undef EMPTY
 #undef cnum_t
 #undef ut
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index a78ae891b743..bd9c22945050 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/cnum.h>
 #include <linux/filter.h>
 
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
@@ -301,14 +302,8 @@ int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_s
 static bool range_within(const struct bpf_reg_state *old,
 			 const struct bpf_reg_state *cur)
 {
-	return reg_umin(old) <= reg_umin(cur) &&
-	       reg_umax(old) >= reg_umax(cur) &&
-	       reg_smin(old) <= reg_smin(cur) &&
-	       reg_smax(old) >= reg_smax(cur) &&
-	       reg_u32_min(old) <= reg_u32_min(cur) &&
-	       reg_u32_max(old) >= reg_u32_max(cur) &&
-	       reg_s32_min(old) <= reg_s32_min(cur) &&
-	       reg_s32_max(old) >= reg_s32_max(cur);
+	return cnum64_is_subset(old->r64, cur->r64) &&
+	       cnum32_is_subset(old->r32, cur->r32);
 }
 
 /* If in the old state two registers had the same id, then they need to have

-- 
2.53.0
