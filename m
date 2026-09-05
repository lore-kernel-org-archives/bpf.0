Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3219D065
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566782; cv=none; b=LtTaZPAGRPa9wTGa8V0MYm+LhXkqS3YtqjLXEZv8EUM3o3JTfk/BTT70lhZd8TNt976KS4zvnF+gr/fz14WqypGuFce+HpLrYokxF+6Y7hfHczQhyWObASNNVIYhWpV7gLqFNqUX11fvDf+rSZ8Yilzf2gcIr1BthCbG138WuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566782; c=relaxed/simple;
	bh=kb9m5OzV7sQjSIPelUDnYzK+gNIMTaokFLygcPxdzXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpEG1n8Ssub+Nwn56a7+hQi+EXsiwXUBva78dI66FlefYinMXF6Jt63fK155jPCkmcBVeVmi6zdaQWyf5PmHHk7Qt28gp4qapfvXAFmR1BtK6F8hZ/t5pXUAewRDua4XZNo/iDoMSzdUI/XyJ4G//1zE0MUXz5HYe5Og6EI0y/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3WUr5qY; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3WUr5qY"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so1446105a12.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566780; x=1789171580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r35GBf7Z5X3wfn/am6w79wvjIR0iBKcovbcSi2I8eoM=;
        b=V3WUr5qYbZZby7yDuXRG2UHi+zdAY/yExIVi+2SniZR6z3N9Dsfro+g2pj+CX8mRsl
         cu1crX6rMwwXy0tyKBBobUaZT+kfJm/LSt2CqePrUjhYLZwWn0cu4idrmNeKYokqUNdK
         oF2NLDyRRPWtwYcX0T0uCTBx8W+mWZfvAbJg+dk79Z8sJaNeZ1181FRYL+MKnmbSxCOR
         KykRM0xQ3jHbxyqXpygBbWikP2bcvQyrmed+LZ2F1PgQafDpxD2n+8XMuIGdJTNkEZs5
         vGFe60WR3f88cIywrA2+xF15+BWZ2huZYI0IxiijN0nXpRsCuSrSoCyIXpUPAwzdex0Q
         3hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566780; x=1789171580;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r35GBf7Z5X3wfn/am6w79wvjIR0iBKcovbcSi2I8eoM=;
        b=eERKQVcFntl42HtkzygcMZryP/0PnmnVWHDBQLpRZsIsmc4TOWWrAdUxL5n/FU66gn
         H7GBkhu+MNTfD8OBOAFdHiYPK7N+43C74AqJHrS8f/wRyxphMzAKUxgKL6EoEPfNVt63
         6HY9oteF6bHoHyhmW/2y6bIkiBJJ9+qpgZZx2yrMQw1aUTVQxSjJiwj5Uu8r1+mtP+nV
         A0yCLgkS0G12WXQRpFwzkj0sA8FNiINJmcMYHJPYtx3S+N3dTxuCekF6ULJREoM24EDM
         rqQsQV+RoRjhbCMF2HOn80HFG/qc3MSJyPnu/4fwIuJBWl9NbJAsd8Tv1E33TfMD7Jqb
         N1nQ==
X-Gm-Message-State: AFuF++nObMSh70xI02G1BrkKZiq4JcfMNQ0Qztf5TH1vgjtKFVDEc4pf
	P2vXRNZxU/nt4TzN0+AnwcbHeFdzOnqVItHEGlpRX6yyPEvYKyoQRDuNPoRzdeSYVuw=
X-Gm-Gg: AYBFou3zPwe/uKrjgGC5YorFDSOzP1EBsurLpzzrLZSe4C3enLqjBVR9XUHE/zALEbH
	mKOUcccYJICXSmU8MzcohOV5NNGKo85G7OAM59brAajFZnlYuKlIP9O+F8EGfMa3afdno0JYSZQ
	3okmztf41LAN245fpS2zq6gaoGeFmiBMcruZXG0/b1BYPuMeZUTzzAC7W/dWz+Vu71UeaM4xWhW
	h0jIH9XMGkQ4puUhhctaCGxU9ae9HE9MdE4c3hYcObqb7+FJpycdyisfqHR7uc5TfBtfPYIA67V
	erIBzBH0qpLi7vT/ilrEP7Gfcu+oERqwNU9/y2gMJ2xQAxKiXCpynICDB3avCcSzFF6BlcXpGOI
	GH9FXlhU/wFfPksfMUstJ9Or9PjR2Rb5KZuHcNDmUKQrne8vwQDxR5OP9b/Tljg+xisEAKdHXeb
	Xcqs4QWsLTHwhoU4jjGorkV4i9usntlUYUfaCuEJ8xjnDcbbkSoGKi829XR123o88WFbOCGQCp7
	q2M1IuM0MsswPN2KJay+UOVHbYboG1N+0rKLDPLLdZ6Rg==
X-Received: by 2002:a05:6a21:3942:b0:3cd:a1e2:f238 with SMTP id adf61e73a8af0-3da39fd2f21mr13753618637.16.1788566780555;
        Fri, 04 Sep 2026 17:06:20 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:4f3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm42277eec.8.2026.09.04.17.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:06:20 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 04/10] selftests/bpf: precision of a NULL global subprogram memory argument
Date: Fri,  4 Sep 2026 17:05:55 -0700
Message-ID: <20260904-register-is-null-precise-fixes-v1-4-0f5a360ff15d@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-0-0f5a360ff15d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Check that mark_chain_precision() is called for a NULL pointer passed
as a nullable pointer argument of a global subprogram.
(Pointer arguments of the global subprograms are nullable by default).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_precision.c       | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 3e290b07f672..fb7dfa1246ef 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -676,4 +676,36 @@ __naked int null_mem_arg_zero_size(void)
 		: __clobber_all);
 }
 
+__weak int subprog_mem_arg(int *p)
+{
+	if (p)
+		return *p;
+	return 0;
+}
+
+/*
+ * Verification takes two paths: with r1 being scalar zero on path (1)
+ * and with r1 being some other scalar on path (2).
+ * Check that the verifier does not use checkpoints created
+ * on path (1) to prune path (2).
+ */
+SEC("?raw_tp")
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure __msg("R1 type=scalar expected=fp")
+__naked int null_mem_arg_global_subprog(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r1 = 42;"
+		"if r0 > 42 goto 1f;"
+		"r1 = 0;"
+	"1:"
+		"call subprog_mem_arg;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.55.0
