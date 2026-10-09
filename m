Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129724C6F04
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542935; cv=none; b=Rw4KvO6P7rrca1ZNjCkwppRcTkttYH9nsmo2rmouktKLuV+TT7QXrSHZXRGbRDGQLEW0QmIDbJMy9s7dxi6X5udAosAOPBFSbESHo3AYgjBV0Gpg46CExWZVBL/7LA15V/8N0N5T8XjG1y2D5unMaVr8jo2MR6tuuIg6MVQThMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542935; c=relaxed/simple;
	bh=uQI7xSPqRXoszFdoZM6PnEE1Zw6sFSNRpO2wfknBPVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NW6mENKprl4XxM+Rr7dSVsT0FwnBQthmbNTHTs5tJh5QIweBYhrN0EWggKCH8Qp6yKWYjVq9ltSHAiTijsnf4zvYZC5uwlZ4CbHMqc+Vl58YRYLU+4SfJOLOaiO8YSDD0AIQd0Pv5diulJz0q9hqb0ua5/fq+oO5M1t+R3uN9U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8GM0juY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8GM0juY"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc502d509c0so2544213a12.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542920; x=1792147720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YTyEPHY7hoUSbHXNJJkAXEk6wJpFT0+23x1bFbd/gL0=;
        b=a8GM0juYOr4QQuxiSb0jEZjV5fAXxSgwF4I3d5odx85xbMuazmdOP1+yqLB2hGLjzP
         YTn3WpJjXaSuMxbnfYxGWQpgidopMJRhh4DPz9WGj+2wWPLQH1qSiYnpShOBmrXylEOw
         0w5UULP6QJb5YD3tmSaRzGpGFZKU4eHZ9cApNW9DrpW7pDn23coQqlVh13jwKjUCwc6M
         sw1kRzfv6HCzKg8zth0N0keTB2ieHIE1l6bD2KiU22T/s+GUiTpnB68AirMVFztTJPJo
         trMTNGqFCEtkXDozYmzeQB8Yyc1LfSHlgOSNbdeQJnstUYKYvzY94laRePCco3ycrj1o
         BVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542920; x=1792147720;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YTyEPHY7hoUSbHXNJJkAXEk6wJpFT0+23x1bFbd/gL0=;
        b=y+hc3I9/xRG7gMiiOJqsJSliB7zOaxsitMrvaPREtRj7//L2lUVXc0TvYv75byr+26
         2ln4NkoEB5Gxwht94gSC/tqVg0dEx+avTXw88M95duq61ZvFRj5PJ9armt+OUCo7f1qL
         lPJE6VfNGsQ4fjLd5M+QWFLQqb4n+NIJdcuEsxldY0a+bxnyGqBRAJHQvXtNWqRPMiwY
         6FXiTW+Vlw0jEZn/vDpFRtG1BKNr5FQP0P9hGZHx5WDbv7Bzkoix9KEvI66COK18grAq
         6cAs+0AfJnxxPKAOOhGlaLR01FdjwN/RGi6kUxsa8Wryv+OLUiGxfwtx8apByLRBNA6Z
         kz0Q==
X-Gm-Message-State: AFq9FYLl8miW9wPTw4uakflYUUrFxVBCUMUpOuhRrXLbMGcwRatElNWX
	cwRxQkrUy+ObeVAI7B538CwvlmTfianNjcEKEjspqyk55aCKyvBJUGYBtKydD59N
X-Gm-Gg: AYBFou1ivrHm6/xa+0gpLwAeU23oYSaBMaV5AdQ3MDD6g6lhJZgM42V04SYlx9v4V+S
	8shMkKbRShq5AOMzta/F+3wID2J2bVmj9jsNveYZN9jhh9cLJ57MHw3Fx+URKM1Y7wBvutbW1zC
	yGV+wiLm1HXI8jGYsFkws4LmgTEe78p5V+BCJzl2b4Aczlj1HVK+uEnG8sAcx0IZHBW0tZIc3z5
	3xP3vHitHvqAex71hZnsYpxbU86MYlWFqD/9sH9gnWO6RyCt/QVDrVkCHEaENA1Fj7rl0yhJcJq
	yl6zHNK1lkVTKx0IftftidJ3AfOp96eOgQSvUoym9Vzb+CMMntEtb0IBdnPaR4QxjiR9pUw8G37
	zPOUPIEG+fRr14rm3+oC8qwGthFwK0tIvPXXbItfTrP0+cSUOCZmitTv6swl6nhMxrLiEya7WZ9
	M+QQ53Hi29h2QA3U0OeJVEzk1qlqPE6YWIgvp6AJrF2YOJzvJS8k43iIv18/2MDzNbIfvcyknSX
	GYIqU60HTq7bv8=
X-Received: by 2002:a17:90b:384a:b0:3a8:bb56:f1ef with SMTP id 98e67ed59e1d1-3ab3a2902a2mr1411696a91.2.1791542920079;
        Fri, 09 Oct 2026 03:48:40 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:39 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 29/51] bpf: add bpf_same_memory_origin()
Date: Fri,  9 Oct 2026 03:47:47 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-29-bcba9bc53ac9@gmail.com>
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

When dealing with loops like:

  for (ptr = ...; ptr < end_ptr; ptr += 8)
    ...

Scalar evolution needs to know if ptr and end_ptr identify a same
memory location (possibly with different offsets). If they do,
it is sound to attempt to infer iteration bounds for such a loop.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 49 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 711a4cb24c06..6daa0c826f25 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1822,6 +1822,8 @@ struct arg_access_info
 bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env,
 				      struct bpf_insn *insn, int arg, int insn_idx);
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
+bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
+			    const struct bpf_reg_state *reg_b);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 range, u16 base, u16 step);
 bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_reg_state *b);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f8e6b40c2121..bf0722752e76 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17280,6 +17280,55 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/*
+ * Many checks done by this function are quite conservative.
+ * This is because main verification pass does not maintain
+ * enough information to track object identities for some
+ * of the interesting types, e.g. PTR_TO_MEM.
+ */
+bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
+			    const struct bpf_reg_state *reg_b)
+{
+	if (reg_a == reg_b)
+		return true;
+	/* Require matching flags and base types. */
+	if (reg_a->type != reg_b->type)
+		return false;
+	/* NULL can't be compared to some base+offset pointer. */
+	if (type_may_be_null(reg_a->type))
+		return false;
+
+	switch (base_type(reg_a->type)) {
+	case PTR_TO_STACK:
+		return reg_a->frameno == reg_b->frameno;
+	case PTR_TO_MAP_VALUE:
+		if (reg_a->map_ptr != reg_b->map_ptr || reg_a->map_uid != reg_b->map_uid)
+			return false;
+		if (reg_a->id && reg_a->id == reg_b->id)
+			return true;
+		/*
+		 * A plain single-element array has one stable value address,
+		 * but not when BPF_F_INNER_MAP is set, see arraymap.c:array_map_meta_equal().
+		 */
+		if (reg_a->map_ptr->map_type == BPF_MAP_TYPE_ARRAY &&
+		    reg_a->map_ptr->max_entries == 1 &&
+		    !(reg_a->map_ptr->map_flags & BPF_F_INNER_MAP))
+			return true;
+		/*
+		 * The rules above can be simplified / relaxed if:
+		 * - fresh IDs would always be assigned for map-value lookups;
+		 * - direct map value loads would always have and ID of zero.
+		 */
+		return false;
+	case PTR_TO_MEM:
+	case PTR_TO_BUF:
+		return reg_a->id && reg_a->id == reg_b->id;
+
+	default:
+		return false;
+	}
+}
+
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 range, u16 base, u16 step)
 {

-- 
2.53.0
