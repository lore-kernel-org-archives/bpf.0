Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652641A9FB7
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566795; cv=none; b=PgaCZQXICezUvx537BEqeFFJuEw7R9J3M+J3ERQWl/TAifbPDVfDXRSRQncA1qXdqZJvc5+4r677lTdIbhb8ObbJfiFnWPCNyL9Ca9wxeroXGUZHqYgI7MiXMf6Dt+s3jkUqz7M4KMzqZGIOlEKPHDaw9QDe2WdRU9jkLd7ctok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566795; c=relaxed/simple;
	bh=sreJC0QD7nSk18kUU61bZa4E1sLUbQRbkYVJA7iQX4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvEGr5t13PdRSEmpTFVQ82T+v0c5dZl/0k3fXAmqJ/RalAF1w8PKnLWzl0yPfobEgeeH9lfS5FY3DboHDWivInVk95VCBcBgcykWfH/DCLiih7pXzGaL93KG+7a8tWMfM5lkUJqWIEI6eq0bipY6gInWcHkxhLDfvb0O5Hx3Zho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isZPmGX3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isZPmGX3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ce98cb8165so18032115ad.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788566792; x=1789171592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8IzF9ccpEhaEz89RmEr2M6IGe3kEH8YxHnAeqL5mHJQ=;
        b=isZPmGX33lexT8UDZeu0qUsKFU1Ng+LT55XVae4oGrhLC2owBn/vkA75EKCl1V0ni7
         JvmWX1O9tGql6aQhjprfYyk0P4JZ0vWigA09NX26eXVL94coC4ab2D5FY2UB2MmmJoqS
         7Ogx4iQ2722B6h0MipwGdjz0NL33d4NfsKy5XklSA5oDOmw6cQCKo/jxs/Me3LwCOK8I
         wfSYRntvuJcSRbOjAvoluHOQctbdyxs/kcVqgweQCKpN42MELaXm5Wr49/1hCpjmMPNI
         6a6kHziXlvqdUGh4uduXeCksbBUnRRV8MQKrFNqUq7XMDPuB1bkH2F/QrpeO1kVvReyk
         tFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788566792; x=1789171592;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8IzF9ccpEhaEz89RmEr2M6IGe3kEH8YxHnAeqL5mHJQ=;
        b=me0haGL/Sxl+lPltH2qwbtl6qq1GMp21I5khiN+J3+rVA/BzCXyPa5AgXvNFI4Rl1t
         KNXIkCMAFwSF3MSa46WnDO3ZEC9OhM6NDvhfBDcQHJr8qWFHJZqjc2eo29B0V0lr/eGI
         eBBKDcm3jNv9ZLQI2T2Pv4Fxybs8qPVFA3+fboGN/riIMoXJDhdnYHFOCx/OM/J7ct4u
         jmovLIH794bTp8BFMxTB6Y2NGbwwQWdiTZe6E4B+mAkOk8UEgu5F5s8GfZQ9ly5mNJEL
         xYJdnUwDuetAbV6Y2I5wX/ENLFnm2rCiYTa/K2Z4m/fVzNFt7AxlR23C78/NPxy19668
         ayxA==
X-Gm-Message-State: AFuF++kaxOypK0xCZYDxRwm78MUZQP3dHskSJkjVNTaykIoeAANkogy9
	Q1R1EKr0J0X/wsJfT67Pu7saQpI3wuYzNUHqWh50qreb5bsf998pNuxaHu9dYNyaLms=
X-Gm-Gg: AYBFou37ptv4iaf1cAct5y5ufwxit6MnYKg2tAWlb9vloUIjdgqEXODC5oYN7Twyw9R
	vTniWy/vM2Szt7favQEFSBEWF4EG+fq5s+eU97C1Rq2hi4iSzQaao+0k+o9rwKwBF0nwIlVT0TW
	7iKrp3Sxf2n/WOjekDopjQuDSPFnNQlsFPJx8fv5pe9a748hnjvENnTntEtdGXDl8Gy/yX9ZAvs
	lSlLmq+Erb9n0vX3Z/SSqkBvmPSrlYwLx2dLwniKxHXVlUp9yv35GDuGH4hdoIJdFx4fOtDxOX8
	Do89CpBFPJnpTWmNlVVoKKkzbo/OFdGQS1c62bQdu7JU6dFE6WxLJfLhjBF2MqwdLeTuWhZ6cBf
	LRTJTYVmpCtMJ/LtC7Hru3VbSSTVX906cxp9iFTlY1Y5ETOGv3vDqdEAjkOCsQQup6rCyEnSsdk
	U5Is5kPTNIDryupa52XagN+QAmyziuvx2OLWTrmJKFFe9KVP2ryP42Iul5H+BsCmCcyUzIihu1q
	VsP/Dw/qangyfJ8FtbzXkHMsOO53pmMUaze6iAvQ9tksQ==
X-Received: by 2002:a17:902:ce8e:b0:2d8:d4d2:d138 with SMTP id d9443c01a7336-2dafb136d0emr142168665ad.20.1788566791585;
        Fri, 04 Sep 2026 17:06:31 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:4f3d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3356dc5c04dsm42277eec.8.2026.09.04.17.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 17:06:31 -0700 (PDT)
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
Subject: [PATCH bpf 10/10] bpf: use mark_arg_precision() in check_mem_size_reg()
Date: Fri,  4 Sep 2026 17:06:01 -0700
Message-ID: <20260904-register-is-null-precise-fixes-v1-10-0f5a360ff15d@gmail.com>
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

Use newly added mark_arg_precision() helper in check_mem_size_reg().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dc1fef1ef1ef..fc57275f15b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7153,14 +7153,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	if (err && failure)
 		*failure = BPF_MEM_SIZE_FAIL_MEMORY;
 
-	if (!err) {
-		int regno = reg_from_argno(size_argno);
-
-		if (regno >= 0)
-			err = mark_chain_precision(env, regno);
-		else
-			err = mark_stack_arg_precision(env, arg_idx_from_argno(size_argno));
-	}
+	if (!err)
+		err = mark_arg_precision(env, size_argno);
 
 	return err;
 

-- 
2.55.0
