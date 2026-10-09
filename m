Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E094C4F6C
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542930; cv=none; b=Fz1rkiH/e5EN0uwsslAFBmuz/m01UAJkxXTGWItaU+1Lxr79NExPcPxTMul+YfmoGwFlK0aJqvWSTmadg+TgbD4TUmtga+Xwtl0ipAAHNizskE8t+kAms1ui63VGSut6ZfhCt3CDcmpVrt8a5Tysf/lAmWA9cEfhRmPTRWzfeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542930; c=relaxed/simple;
	bh=gjHRYJ+PpPk7gG3SKKbR5F8xppE/xKFDipPI5uBLvrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJihyrwLAHxgbKZvd9YoLLcgI/H2b0RCuDbc44z5b2URY2EYsyKQT8e6SfGDsZfwpT0p/CiYey0gxYVqCScBMKW6fbbN4fR1L084s9zddOMLX2fKXZgReb1/FA3gW5ehlql0IgTLkRk4TxSY1LA/8pzoQNlRxYvGRJ9xItS8oQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjIlloVy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjIlloVy"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38759bcd877so3256140a91.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542918; x=1792147718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bdVIYlRTKcDTHs6oF0FC4OJ8+YF4u0byDE4oNbjp3GA=;
        b=IjIlloVyn4NikiezG4bLQQDWoOx80NaIYztrlLx0n/vYSSPXc8WaeTedXYfak3KYch
         eMR87QB/rR6+AQwiAXAW95jzeCwiZScQXHofE2U8S+2O6WwjbhtKKecEs1BBVmx952ZC
         AvqkZzCZGQNx2sHLod9m0xDRfnvQILyGIt4T1FGmublSBwRbZAdLDYPBewB/YhTr/EoK
         biKqGyDijmCacuNX9rtMaF5f8qTUsZWiHST9zIyY6Qn9zaynvDx76Un8mgdHjKbSbObD
         Jl+dcz9Esmg8FU2hmvlG2GJ62qR/Ira63iaQrHkb1Fg81uTHG+xI80PvAw3QRkTKYwrV
         H30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542918; x=1792147718;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdVIYlRTKcDTHs6oF0FC4OJ8+YF4u0byDE4oNbjp3GA=;
        b=F0M09fY+5CGmTzp33z0ONJ4coGap7gVsr2UCSq4pxr4XNITcrlCIRRnrEee5iJ8ADb
         78jLlGnGb9T2uTujOIIfDlREi0NKwWbQxmdCT75XliiPhUTxyMNtMOFRK/ajZArStLvV
         kdBGWjnTXqdyyT9ESNm1PHoPQq+RnVLFQDMb1wuj2I83/teMV7jSKRQIxxTT3fRQJMqV
         Qawr5CR/E/FJsKVLAV56Z0DowAakZE352yoe+syk9+juWbcKu5hsG+LyIgotSZijHPcA
         KUDx0pANpsXFTv3GmUOsrjL2Pxpz8LMbwumMH8B3CcfKuLpHbLWjccjAGYyajDXOBza/
         K/zw==
X-Gm-Message-State: AFq9FYJxiBkcsZptB+srY/r7EPryGVm83zUlGxjtYxN2DnMVHo05ZQfd
	1K474ea24vML5g2akw+X7zjEEgZSqllwAo939RhIQMQs0uGuq9xJCrC3LJLlZPok
X-Gm-Gg: AYBFou3gzYfVP7z1FGgykbCyDPXCvKvlkWj5qvwfQejPnDVMu38XsVq8FHS2ZKanED/
	VwSAr188Qib3PkfTjZVgk0HwfqMcXDRLjeJ3pOEtLlz4sFWwm6mBeiRdf0Ru80T7la04XI5Xn4g
	gzPypcZMYJrY81q28FuYrGT8z3OTiBQYNfsjbVOHk8BXBcWXsmIKcJFwnTJA19UGwezr0F5BnF9
	UrePAH/KdO3wEaWIqeZCJG8NUqfMBbecbGkVc+A88ylLM1Y0q9TwGNPoAMfivHlHSAT4wsOsupt
	9xrg+mDhQ560J2BmD+f/NyYuTmw6wW9RvjUAfbAHXXP239/HgUqDe9nXuDXgYmeqdeGDzDekbJe
	+AMkh2fkcjP00hkjtyxQFhO9+TVR1Fl/pD6XQj/rNlC9z8seblrSmFHmCu0PZshHLZjc9lRjGfa
	5BC2gdMjyaOzip/pS2JKsLYonUgftv9Sb0M4oPh2afUM9sim3AzR8gnN9wd2h76r2VVuv65Pw4t
	AG5jkLoic/w8I4=
X-Received: by 2002:a17:90b:4b09:b0:398:e96a:8999 with SMTP id 98e67ed59e1d1-3ab3ab60614mr1221680a91.16.1791542917662;
        Fri, 09 Oct 2026 03:48:37 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:37 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 25/51] bpf: add bpf_set_reg_range()
Date: Fri,  9 Oct 2026 03:47:43 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-25-bcba9bc53ac9@gmail.com>
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

A utility function for setting a register's range and step information.
Used by SCEV widening and clamping logic further in the series.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d1ebbfef5455..bc901d649472 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1820,6 +1820,8 @@ struct arg_access_info
 bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env,
 				      struct bpf_insn *insn, int arg, int insn_idx);
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
+int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+		      struct cnum64 range, u16 base, u16 step);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 16b7758221b0..585303d28690 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17273,6 +17273,18 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	return 0;
 }
 
+int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+		      struct cnum64 range, u16 base, u16 step)
+{
+	reg->r64 = range;
+	reg->r32 = CNUM32_UNBOUNDED;
+	reg->step = step;
+	reg->base = base;
+	reg->var_off = tnum_unknown;
+	reg_bounds_sync(reg); /* this should infer the tnum alignment */
+	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
+}
+
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {

-- 
2.53.0
