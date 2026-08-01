Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB67937F330
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570404; cv=none; b=qSqxzsHbbYuUZV7dLTLmTqNuiQcN3ePmMmrtW1qADsSYdi1gyXEAPEx46wr3uaWYcsnHDOokzkgB1zAAReL9nB9T0vrfV47xU7Dh+03xBoGGGgIZW4ZXGj/+mzN5tWKGAb0BoeqQb0NdbeoAQ81Ws+vZzs8t5CnJsoexP69ljlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570404; c=relaxed/simple;
	bh=yCrppi859KsN+ztLrTS2CMRCFN/7Tx/Awuj5ZbYEhPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0ceQuRkRcxkwycZAdbAMnGp4AFCsk4sNzsuoTWxXvF1hUcP+EAnJ0kMxu/gUkngWVvlF6GMOtBchC+NJBOoLqizwt6yWww6U5OuLHeOKxhb1Rd2wVQTUgk1eucT2N7rQASt35M3PUV3p7jheWH9sBsY/1j0Q3YCEOcJc8OasHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+641lj4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+641lj4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caed617615so23128845ad.3
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570402; x=1786175202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hFQDxUAWBH3qo+8cVOl+tpVNZPSDsHm1XWZGcE9i0mM=;
        b=d+641lj4VmlQmpAZE59fbTY89UhZk5dvBaULfbZFBzXLzhO4uVvM39mDbQ+bmlDGnn
         uQJrJ39QNqKENPKz+KuGUx/oDv9aioujaQCCw8fIWnK7g8Woi6u87T/Yx2grdBwWKUyB
         VEx54UWQINWmtPTgCnPa9J3ol9ZcA14KlS8yHk/UyB2VXutW2iazJsD0HVYRAgNIzm6j
         tBqCv/EbS2XHSAooO2isoO9hoq6KGj/picG9hkARtgauohXJNtyon6HFS3+GSMLddEkr
         IG+w0mrBiZOBLuL2FlvPouTqBunr8DFcaCKiqP4qBXVtr5xWpO8BPiq/Z40eJfvXTu1o
         zPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570402; x=1786175202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hFQDxUAWBH3qo+8cVOl+tpVNZPSDsHm1XWZGcE9i0mM=;
        b=L65RON4/zTCacL1mI/exokcRKJ5h+NwoYLFCZF7He8y0jwvjXv+vAqpmvljXO88Glz
         +07Hyh5MKG63XhcvGDR41OmyDt94Ahs67nP2owdFh+zpXprqDUQSs3fp9AXOstNbPyjx
         Eh9xBVBcoqj6y5esUaYDvUTzWZL6tPxFIgaWx92H3H1uyxTWKfxSTP6HO9kX1nx7zYPn
         tnUku3kVt7PohrZiB7MZZTn6i+65irtUtMIpaYOPMvrMBUTPwb+r7j50pIPi8dEonzJP
         BmH1xdYYwmANWbmzuV6xtFh9/lQTlxunnjZBuysPMuJwbsvruM1rgOqtUZ50frTBdu2Y
         iMLQ==
X-Gm-Message-State: AOJu0YxUTf4dJkeIPO/nP19w/a0mr7Vh++p4NyDrNm0m6LcJMBIc0V0+
	5U707mvQ+vcoTeQn5WFh+kpWhPQ8YVcwLqN2Kf5rlLyNFAiqMvl26wmB1tysVA==
X-Gm-Gg: AR+sD13ylc3Vf2dzFta7gr2lyNCEyNckroNFeWtU13E8qoa756fJKu+Q/VGuJFcYk87
	m216AqhNt2dCJhQ4Jhlci2zr1Wba4rJ4fWJMPT3CGDGGrfeN8xlh33kkQzcNqiehU3smrmDqahu
	ri62rBbRb3OCQPcrT/NKu3nFQIirEt54tqCT9UmdJ1ti8EpUHGS3Z2iAlvI+CvjT0m04ZnK5V2F
	myvu6l9nOZZodx+Wm3BrRbhvcE2ibQeAAqYxZUjCwplfWfcegOjAR82clku+Nzu77do2R5XSBLm
	uBGPM06pSPBi6/c5cGgSGKRiriEWBQsQ0LXAtkT5jjplZse0C/xb5PJS29Ib/pjrgzfAC5/dxkV
	hEUXQ41J4dXXNkTVXSyhMHCnYnqNaU87tFADF4ZXPtfkGYE+COsDPRNd1xMIl9JcnO0stcRF68P
	1W6uJaXDmKKOpYq4euLCHsHS1KNXj15wPGdJZF1PoLQI3+r17he4juYqivsjiQqvk=
X-Received: by 2002:a17:903:1a30:b0:2cc:670d:9b2f with SMTP id d9443c01a7336-2d052412606mr27392585ad.33.1785570402228;
        Sat, 01 Aug 2026 00:46:42 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b121011sm15110015ad.62.2026.08.01.00.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:40 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 04/18] bpf: Pass kfunc meta to mem and mem_size check
Date: Sat,  1 Aug 2026 00:46:19 -0700
Message-ID: <20260801074633.1595644-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfunc now shares the same bpf_call_arg_meta with helpers. Pass kfunc's
own meta to check_mem_reg() and check_kfunc_mem_size() instead of NULL
or a temporary meta on the stack.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 15422e8d7e23..d10b2dc2d628 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6924,7 +6924,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 }
 
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-			 argno_t argno, u32 mem_size)
+			 argno_t argno, u32 mem_size, struct bpf_call_arg_meta *meta)
 {
 	bool may_be_null = type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
@@ -6950,8 +6950,8 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 
 	int size = base_type(reg->type) == PTR_TO_STACK ? -(int)mem_size : mem_size;
 
-	err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, NULL);
-	err = err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, NULL);
+	err = check_helper_mem_access(env, reg, argno, size, BPF_READ, true, meta);
+	err = err ?: check_helper_mem_access(env, reg, argno, size, BPF_WRITE, true, meta);
 
 	if (may_be_null)
 		*reg = saved_reg;
@@ -6994,22 +6994,20 @@ static int process_const_alloc_mem_size(struct bpf_verifier_env *env, struct bpf
 }
 
 static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *mem_reg,
-				    struct bpf_reg_state *size_reg, argno_t mem_argno, argno_t size_argno)
+				    struct bpf_reg_state *size_reg, argno_t mem_argno,
+				    argno_t size_argno, struct bpf_call_arg_meta *meta)
 {
 	bool may_be_null = type_may_be_null(mem_reg->type);
 	struct bpf_reg_state saved_reg;
-	struct bpf_call_arg_meta meta;
 	int err;
 
-	memset(&meta, 0, sizeof(meta));
-
 	if (may_be_null) {
 		saved_reg = *mem_reg;
 		mark_ptr_not_null_reg(mem_reg);
 	}
 
-	err = check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_READ, true, &meta);
-	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_WRITE, true, &meta);
+	err = check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_READ, true, meta);
+	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_argno, size_argno, BPF_WRITE, true, meta);
 
 	if (may_be_null)
 		*mem_reg = saved_reg;
@@ -9258,7 +9256,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_DONTCARE);
 			if (ret < 0)
 				return ret;
-			if (check_mem_reg(env, reg, argno, arg->mem_size))
+			if (check_mem_reg(env, reg, argno, arg->mem_size, NULL))
 				return -EINVAL;
 			if (!(arg->arg_type & PTR_MAYBE_NULL) &&
 			    (type_may_be_null(reg->type) || bpf_register_is_null(reg))) {
@@ -12405,7 +12403,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 					ref_tname, PTR_ERR(resolve_ret));
 				return -EINVAL;
 			}
-			ret = check_mem_reg(env, reg, argno, type_size);
+			ret = check_mem_reg(env, reg, argno, type_size, meta);
 			if (ret < 0)
 				return ret;
 			break;
@@ -12419,7 +12417,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 			if (!bpf_register_is_null(buff_reg) || !is_kfunc_arg_nullable(meta->btf, buff_arg)) {
 				ret = check_kfunc_mem_size_reg(env, buff_reg, size_reg,
-							       argno, next_argno);
+							       argno, next_argno, meta);
 				if (ret < 0) {
 					verbose(env, "%s and ", reg_arg_name(env, argno));
 					verbose(env, "%s memory, len pair leads to invalid memory access\n",
-- 
2.52.0

