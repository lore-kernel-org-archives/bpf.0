Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA035CB7B
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039642; cv=none; b=QMh+jiY1QVvR+BeN86C2A93rBBJsQQ7/V81OoN3dy7lhtKRt9pNxHZyztCeY/aU0DzdVXjcKmdlvqMoaTyKirNT9rE0BiR0T/u0LQYyzmzaGdsxLKPClUcVR7G+6jD4irzLwOip0EAOGy3Nb/BHSmaTJjdOx1KqYrlKpczDG5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039642; c=relaxed/simple;
	bh=AuxjkZYVDQquT5s+ADDtZN1TGDfrJJL7CufOkR4YJDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9coXmcGP3J9XQxVMmowME86tRL9b9pmqacm0j2d5My6yoddacR4R5HRn+C7I+KG32kW1czkMBKIlacpw2Gk+5bVGvUcVDaxMjOoT5MRyCUVxsdE3zh/u/Y7bCR+jOEgB5NOgwq+rmWA4+lJYPBXkRq2S+ZSnWTHP5HY4NTt/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtlqcnrN; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtlqcnrN"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd88a115ebso31694005ad.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039641; x=1790644441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iAv7Cw4ZYZytaAvnYrddzGd0c3uhtHhUBO72e3hx0vQ=;
        b=CtlqcnrNlSUnrieOngEclNsG7hGjZEyba2MpZbgZYTmjGE1LwW4vUyL6kDC47vQ18B
         zEqA6rc+mPy8GnmITXOl1XysyzyfmkqGsFJR5naeio8nIxmdOD4VmFnLsGW09scNNTOk
         xkheU/q8+5+ZXRS/e6oGP4jbTnJ0sD6PZCyISEgkv5OKzK4lOrko0J9+ebbfMyWuOTDI
         pCNAwJ8n55DZizYXTa+Ar9nlKNg/4y7ZynRYmny+YXPbjxSn/sIuiyBglLLiBwNVWC5I
         6CCjZxViXLRoV9lZXnGLvewA8QLReGmSO0RFwyI47VtMjo1GiBEMajVhRt32vT3Kh54p
         S8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039641; x=1790644441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iAv7Cw4ZYZytaAvnYrddzGd0c3uhtHhUBO72e3hx0vQ=;
        b=MNrdc/K8PXnVqXXeXJu5lidKeI2Kf5I63kZaqU2frLrUkFCJGjBpw9my8mqTUwkiFp
         yc5wQdLPCJXULqCoH/N6AHyiEyDf7fwpNKQXzDG4GSOZhS3scw5+wYvBEkQWRMZYFVQp
         M25wAcZZQLfGTPB2CLuhmagt2wqTSoKv+Ul3lGFFfkkMRoRtd/bMNHNR0Xt6D/uN/oEx
         FenMKNs6Y2SRLrFFQ1v1dHFxDMwZ7o3cDWB/FpT8+JAFBf5Afd2l/+4t62SbzBva26Ad
         vn7i9a9lAYmrm2o1tAfYtjji9glxMtdireaa1MjKoD0T+pWrIITSMqFvLFDbhXkgyKLo
         8p8A==
X-Gm-Message-State: AFuF++n7N24X7aHeKkeaQxgSc6r3miu/ifkDdKXSVgbjYb90Jtj2SXEF
	4rDM/VKgEONT7t/z/Yv4UYxhlfNj/Y/T7QBZSW24iQ1jl9pO+ayKrPbIa25pjg==
X-Gm-Gg: AYBFou0jBW/INDON/qtaVgwVAjMcXHB6JTiAfM8mYfxB+SwtqPNZvjeQPXTnlMeSc53
	t7n/+PZ1AHdupWfgKjTuksS4rPilMBpeno5899+jtzPz3Hk8Ckq5lrwsRUZlhgGjVBCFLvm6Bar
	BKM5HKQnAjjLWTL00aEK3b5i6llynFPPafok6wweFNdnVag5S3a2wLzEiQMOW09PiMHazn2285X
	wRAVwtwib2squRrUC51IroPfbfMooX1FaBLOhgFnjnQfLkXXK8NEdawgrhoSjr+bQVCut5OoZgZ
	OZEi9eVDzarREKJAq/2Uuyqu7FSctG2ottE5xuo4dxcEXm+GnmeA3CmsfjN0nbQPqKu7vENw0cL
	ItHjSFaAI5vxuHVuvlaeAlZe5wMHgJ2yEScbj6iIsOBnLZlt4oCf2UWSCK17cOil1ARRvxBuqhA
	P67IhRzC9PC57/CxtEDx3XCJpR1gdPRtgrkKMUFPqGVJFHguJ30H9DYGaylN11JmYQ1iGDzMplL
	irb7lK7Q0TEV5eCt5rXK281XV1LYMMix+OPcjbny3MBZt6rQZwksCi2vBduyF3Qano2H4ISfNUj
	NfR4/ZPRo5k7Hsa1FtxZt4k2Icmj5qWZnrjf6cViWF4=
X-Received: by 2002:a17:902:f650:b0:2dd:8b9d:7a74 with SMTP id d9443c01a7336-2ddb1b7a123mr176274095ad.16.1790039640871;
        Mon, 21 Sep 2026 18:14:00 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d05810asm900085ad.75.2026.09.21.18.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:14:00 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 09/17] bpf: Discover subprogs described by func_info
Date: Tue, 22 Sep 2026 01:13:15 +0000
Message-ID: <20260922011323.1298619-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

add_subprogs() finds subprogs by scanning insns for calls and ld_imm64
BPF_PSEUDO_FUNC. A function that is called via callx through a pointer
in data only, e.g. a vtable, is not referenced by any insn, but it must
be known before check_cfg() and the main pass.

func_info describes all functions of the program and libbpf provides it
for every function it puts into the prog. bpf_prepare_btf_info() reads
it before add_subprogs(). Register every function from func_info as
a subprog.

func_info had to match the subprogs found in insns exactly, so existing
programs are not affected. A function that is listed in func_info and
not referenced by anything is still rejected by check_cfg() as
unreachable.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 12898d31e244..c37a1d3eb8c8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3018,6 +3018,22 @@ static int add_subprogs(struct bpf_verifier_env *env)
 			return ret;
 	}
 
+	/*
+	 * func_info describes all functions of the program. Those that are
+	 * referenced only from data, e.g. from a table of functions to be
+	 * called via callx, are not seen by the loop above. They are possible
+	 * callees that have to be known upfront as well.
+	 */
+	if (env->bpf_capable) {
+		struct bpf_prog_aux *aux = env->prog->aux;
+
+		for (i = 1; i < aux->func_info_cnt; i++) {
+			ret = add_subprog(env, aux->func_info[i].insn_off);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	ret = bpf_find_exception_callback_insn_off(env);
 	if (ret < 0)
 		return ret;
-- 
2.55.0

