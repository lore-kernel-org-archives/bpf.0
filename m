Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DC2BEC45
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153852; cv=none; b=pjtpkBMAe8imi+t28w4yuMFXaPpy8Jo+ptwor+XT0+QZL1goS1xx/IbDZu2QZvDNiyM5t/q/tH+fI88nw1nIt8eAjTJK1Ese3R8tsCxgbqvW05U0r0KSiwC1oUkwn1oSLzDBPrlV6nxXwKGf9F8eehWfmw6dOqWwufMdeSFNCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153852; c=relaxed/simple;
	bh=cTtnSOMuQHIVsq9DT9JtiuQwpExC6+lgDPWy6519Jd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFt9beKlm4BQLQJGnjp+hDRYXbI69VySvaUDq0lM1+ODatk1HxgFB+ISVQ632fBggW6i/zOcOqfJEQBFnT9utmLwYLFoRzpJgaYPcx4ECOSLhw/XeIJHmVJJCuVMQ3jVOk0QtQe0rDi2UeBxnnj52vNVX2zirnSAS3tEU3FLy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc3gzL9t; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc3gzL9t"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so1532508a34.2
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 16:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772153849; x=1772758649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHXFG8Y/MrDwgP0wwarg5X3BC/v3748WWDNoaJwLuKs=;
        b=Rc3gzL9tKyJv2T6qs15OK/BbGNcS2iuJveTIELuoHUtPcPYl5wWe9MqT9Iv0ohDuEF
         UxDa4OqaZtDQ0djgKWeRrWdrcH0HQ2Juxb8FYszKmr8XAc8kOgqLlzWgEnym7h+/KLHM
         LShEoCguQYwzV0pqIWuHAwntykSD5RgAqQ0Ub7frevYR/P6+WDZ1pvKXBjcE99C/lkMa
         NDXMTZer6G1O2NIYIwXtgDTMpPnA2f1xnlBXR1KrI4JWiN/anHgnZXu7yPwR3TRPBiFY
         HyJruzOG3IZEvVK01UrsIiBQbk6f/UtjY3vesa/xpH9s9Rky5gd50GBrNnKwSvnZy9sI
         u1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772153849; x=1772758649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vHXFG8Y/MrDwgP0wwarg5X3BC/v3748WWDNoaJwLuKs=;
        b=trT40koYmIm+dxMJ9W1MPge+hf4SxiQlNEWeLwlqspRdSCUO9zNSSBELIMW+zGXKGi
         1dd3nGoTpZFtR7jb6CXiPxsB9x8dFZoUhIC+hGvkkIs9H6FqpJFjzAlW+UroZnaT5I03
         9nM4LNsfB/IgMYSM+gCEtr7Zv1liCrwWdwBeE/EbNywrQgiM5UZL/wC4Oas7t7dAzdvr
         7OFtmx2QL60aPFe+0HKwgt8TRkQVUkoBoPivGgGggfg4tf/1OAN9LM3dV+2tuY29wkrL
         uSpuVsU565zLqnsh6H6OgGlkehYbDRjOdnVlHwT9FOof+cdmGxCdQYnSXjLg4wgB2QQp
         0UuA==
X-Gm-Message-State: AOJu0YzRMEElCQmQgpIJweoc4AR5ZvB16LwWyT8yDcc3yeYIihruyyNk
	KJxNyJoZBR5n2vBNuvHvRgs7D5cxkd9qafytUYjvvFJGe6mqfb+iCQ+QRa3jVA2V
X-Gm-Gg: ATEYQzxNC2qyYQaxY3yy6g+WphLFTwrVI98UwIcVPkadO6EUExp8VH939cNh9yelVPV
	laJ1lm4x1tpppDw0F6rp24TIQOMbafvi1TBMbFtM8AMuxdOZAqdsDx7Av4na2bOPkf/C/qnCtWe
	EN3YOqqjDNrX1u+eZ5Y/Q3hMiS/edga+ZMa8gDlhf2xDSL1VSNke4g9S6OlEdigx7ZVCbUc5Qza
	ECaoigyicJzucENTiQAM7JY7E62GJ6CnfouQkQpx//PJGuknn2yvWQgivXAz+lptReJJzuEfE2a
	VniK2S2Ved2aZ3G4A+CoTvcReRfKfFQk35d8D2jx8nZRiGAr/d7hpuWwxKsv0oCCrGhf9OG0QED
	1yOWHRm+ljX8qL1ZsHRSGktcW6jhXgMp98BQfn+umIt6hOhPk2RySVItjo77VXtKEvNFkX1jisU
	c0oY1icJkLRVwwTPgCdHVl1g/MGbqgx55JBwU3nJ0OqIfi
X-Received: by 2002:a05:6870:d688:b0:40e:dadc:4a01 with SMTP id 586e51a60fabf-4162706650bmr815361fac.46.1772153849240;
        Thu, 26 Feb 2026 16:57:29 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cbd405fsm3528830fac.0.2026.02.26.16.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 16:57:28 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Dan Schatzberg <dschatzberg@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Relax fixed offset check for PTR_TO_CTX
Date: Thu, 26 Feb 2026 16:57:24 -0800
Message-ID: <20260227005725.1247305-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227005725.1247305-1-memxor@gmail.com>
References: <20260227005725.1247305-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681; h=from:subject; bh=cTtnSOMuQHIVsq9DT9JtiuQwpExC6+lgDPWy6519Jd4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpoOuDStWRtLfoAxWWidQP7glTz2EpfXWkOgwz8XNu Fo3VxlqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaaDrgwAKCRBM4MiGSL8Ryl59D/ 9lV7zN7Glb6/DzY0jv3yLVlcv+n5HB4E+P5NTI8tJsvV//TaqinBng92X2VXu2I4E7vrpWgnVrlxMp qQbFqQTXjSWBQPsDgTttyQohRoZoAXTnSvedcnmd0pWm7+NkrEBq1IYliger205hQPNF+Rz395KmPL 4S5Tjk8d70zx5uJfv+pD65+RCN6guy6qgZxlVnt2ZXfM2kGb9Z4I6ujiJ/d55EYAKT0zIzZy1JpQOf 1DGHcLdYCLILUHaQLTHcUQ52FET6o1ZThp9STnXLmjJxF2r8F5/hhWw8Hooijt+ghfRmfT7EoycW/r vxlcG69hwA8/IN51rpwUvy1HE9zsLyCPmnX93pKAZhwycwsf7S8HRZCuTKsRPqUBBVEGOKD6k9E8jI AnwSGOaWJk7rolyh2P/foFlZS0uiiXKwAxakDJ4WWIN5OGP0xndF03ME0bqnEOs0viDsH5tsOPHQAx gtxi90tOsnRp075vU4Gbld/bIEa6nQG+MgNGc2/MREpdQHIf4RHJDr6iFdUkzbANBEE5CtHi4XBBqN aYNyGUuNQATGoib8H3yW1arS8CVvKWKVipG8lhUz1sa1hig9OBNSGZa9x3q+u8gHHsKvKmn829f1MJ Qr6c0pTBjNLb2yyux7bopqaD00pCyovjnYb6lzVWeory9AYQfih+Qn9gW2MA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The limitation on fixed offsets stems from the fact that certain program
types rewrite the accesses to the context structure and translate them
to accesses to the real underlying type. Technically, in the past, we
could have stashed the register offset in insn_aux and made rewrites
work, but we've never needed it in the past since the offset for such
context structures easily fit in the s16 signed instruction offset.

Regardless, the consequence is that for program types where the program
type's verifier ops doesn't supply a convert_ctx_access callback, we
unnecessarily reject accesses with a modified ctx pointer (i.e., one
whose offset has been shifted) in check_ptr_off_reg. Make an exception
for such program types (like syscall, tracepoint, raw_tp, etc.).

Pass in fixed_off_ok as true to __check_ptr_off_reg for such cases, and
accumulate the register offset into insn->off passed to check_ctx_access.
In particular, the accumulation is critical since we need to correctly
track the max_ctx_offset which is used for bounds checking the buffer
for syscall programs at runtime.

Reported-by: Tejun Heo <tj@kernel.org>
Reported-by: Dan Schatzberg <dschatzberg@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1153a828ce8d..63872b981dcb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7722,6 +7722,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (!err && value_regno >= 0 && (t == BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_CTX) {
+		/*
+		 * Program types that don't rewrite ctx accesses can safely
+		 * dereference ctx pointers with fixed offsets.
+		 */
+		bool fixed_off_ok = !env->ops->convert_ctx_access;
 		struct bpf_retval_range range;
 		struct bpf_insn_access_aux info = {
 			.reg_type = SCALAR_VALUE,
@@ -7735,10 +7740,16 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
 
-		err = check_ptr_off_reg(env, reg, regno);
+		err = __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 		if (err < 0)
 			return err;
 
+		/*
+		 * Fold the register's constant offset into the insn offset so
+		 * that is_valid_access() sees the true effective offset.
+		 */
+		if (fixed_off_ok)
+			off += reg->var_off.value;
 		err = check_ctx_access(env, insn_idx, off, size, t, &info);
 		if (err)
 			verbose_linfo(env, insn_idx, "; ");
-- 
2.47.3

