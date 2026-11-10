Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328183;
	b=Ry+1mt9vYd32ldauI1MrIYEvjTLdcfBbaUYpWix7gY66cQ+E1g7/WvBv7QvPZjt42KyH
	 hCfIUFJxcnU4irseAKpNGStVXH6RiL8o1rXPfuwg9tR4W372R+DkME6poa/8Ol9+WouQ9
	 SWYLCBZzDQjpm0WfPqor6+FeeZoAcn7plholmEKGRABCYogeZm4i+ob6qLo5wuLSruvix
	 lRDqkVcMLt5v+SBCt8AKEAZzBYCGZdpdhGX0FUqpqkiMqcXVNH+KeafdcN4eS08qBsk/8
	 w92Kjs/+FYXy76kLxSMD1wn354h3rCSIdVO4nWF55tzQyBttAAuNs8T7KgWFX/T9OZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Dmo0SCC1hsyDkcqfuk8ZgPnLRXSLFF5HrSA/2dOLpCQ=;
	b=P4A9iDMdL58z7N0ye9gqJBLBL/ccoCPBfqese0iAMuYHUOb4OEN/PgHdvKfr3fg3Zc7H
	 5OHovlncfP4OArWBxeg+jceTBPnyaevLhv5FhDLCXBbOzr29P422iLz5hHUlSJ1O04UYf
	 Sha29cSj2vpEHAg+9kH3hZuhWS+nUVI8PskhxD8QPE2+Y4t6Uv3+uBxWj345B/JWl5r35
	 GTcGAhKpAHCai9uAndTuLq14T8rD4GyYnsGjmNQf0mgDN6bU6m4Dnbaqlb+6bOYS06HH7
	 89iRwEMVd51teUnZIsN/Ao/+u54IHu8pQI+ZYEd6EV28tDZm6grLhs1ZxG2jLWMCbBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=biBjUL0K;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD7660A6F4C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AD7660A6F4C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=biBjUL0K
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso24127265e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328181; x=1794932981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dmo0SCC1hsyDkcqfuk8ZgPnLRXSLFF5HrSA/2dOLpCQ=;
        b=biBjUL0KHeiAbFA471IPAOu7lQVloW19wDpOLN3aBDQV2rOF07IxpHD7oBD98Fi+z7
         C+GCZ295wwApF92/TJz2e/y3/Lm+NRogurBL+hrrh/OaQ/YJffMd+3poKLgVnIlBrT4z
         SsDKvseUE+AXf2G8skO0lJYOf6Oxp3uZt/cmllzErEKIN3u9EwbEyBiR2xHoVpIe+S7F
         Oy0FeJPlV5yturzRret5tRULMOV67Yup05m9ebwLtSBEil9qzNrVQVeg6PW/f59g9qPq
         l7kgQ0IR2dSUyhCIlIt+Rkyy4iY8rjrM6CGJAiiVbfsV3LwyL5vRuOjvzxgv04XLTG1i
         wjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328181; x=1794932981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dmo0SCC1hsyDkcqfuk8ZgPnLRXSLFF5HrSA/2dOLpCQ=;
        b=VW6Vw4BdJWBa7p7Sc6QPdr3Y1rqOEhpjUFZL67+kZr6+IMP0K7/frcDu391WesRRpu
         +fmy5AbU2prD1OsO+yV6BIdkz19tYokIPudeDFuLi9bUoyvPK8WzqwLT/0OsKAOB4EAS
         lXZe2siaiecc78/3lVMXiVeZCX8mBxSaIad6/tvHOnVAHpeuq3TQcPu8g2wFX+nzdCNC
         KGLsX6ur3Hq0fy7KF+C1v+tuwOzrj/A+NS2FkJHU70OTh/t8kGbPR5xYOGZjyyver1JI
         pUE82JPNJmdlgO8+tzwjvzDnnyLwreDzeMF8h95mpoiSX+E/PftP53XcyRbFSq8IGIOr
         Oo3Q==
X-Forwarded-Encrypted: i=1; AL+hErHnN2PKUzoJVcm8NtxxZVwzLO5frM1uJ3MoRUwWY6zy7gLo89v3S86xnjEZRZm4tNZ9fnk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SllDH2skuqNiTVm3vh2LN97+DWRMxlCQmPfA/VaAH1/sPFs1H
	7+Jy9lJcF3RATe04ZUbId6NLPTUGTnSyLPMk2ZSv+P6mAOJ3oBoezBKa
X-Gm-Gg: AYBFou1rtg73l5eqyMuoZrQ5YeGGPYsrcIQ8MZMcVjuHejAMuMeg19c54zIrQuIb9Rk
	gMM33ty+px2o2v4z/p5vm2XKUu5L6aqdZ7Vcq1BWWEEagQkLA4gvO+dIdQM6+RyxucZcgRQtBm6
	hhhlSnm7HF1DmbBjE1PMZe3jueq7N1YWjTEvOrtlB9NSwwdlSIGHY7CxfD3xhYaS5B03FxNH4RO
	V/hzeeUJ7ez3aKi/wWQ/nkdUJgSy7DcRIIEwt/wnqBhE/gWMrTSmIsFt2sPGHsOIyfH1KmGKgcV
	caPaGQfmM5QFdKKWXGfObW770Wb7lqT0tiFv95ztaNCCvhFd4H2n72v5aErjRtP+QI4JA6R5FYy
	hUcxv093ADj302W5/LaZ7/9J8ZaZ2Mus2NzpQz79piFUSQPTVzhgiK109zwAOm0LkKRiu5MF2Qr
	v7U8rw+FEAsQBqL5eC6N9Bgwwv6YX03dk51b4YvvDP3kaS75kxMZan4uR7/nb0dTLbzj5MUPtrt
	ylOP6x5XITCTOwXg4YKcTNAGjNeDjrUhzpLKLSVv5CzZ6eG+mUVt0KFi/lrogeCzqT4hurK9FW5
	9EPHFofK4OljChAlme1jT8Z4TebjebN1tiERMqsx7cGspkU=
X-Received: by 2002:a05:600c:474c:b0:4a1:acaa:9d4c with SMTP id 5b1f17b1804b1-4ba0234f937mr58508755e9.25.1794328180589;
        Tue, 10 Nov 2026 08:29:40 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea745sm71287485e9.10.2026.11.10.08.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:29:39 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v3 bpf-next 12/18] bpf: Follow integer casts in bpf_scan_ir
Date: Tue, 10 Nov 2026 16:40:32 +0000
Message-ID: <20261110164046.454431-13-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110164046.454431-1-a.s.protopopov@gmail.com>
References: <20261110164046.454431-1-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow sign extensions and truncations between integers of at least 32
bits in the block of the return. They keep an error, for example an int
error which a function returns as long.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 scripts/llvm-plugins/bpf_scan_ir.cpp | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/scripts/llvm-plugins/bpf_scan_ir.cpp b/scripts/llvm-plugins/bpf_scan_ir.cpp
index 249412194766..7fb40a6c0189 100644
--- a/scripts/llvm-plugins/bpf_scan_ir.cpp
+++ b/scripts/llvm-plugins/bpf_scan_ir.cpp
@@ -71,17 +71,39 @@ static bool errnoConstant(const Value *V, int64_t &N)
 	return C && isErrno(C->getValue(), N);
 }
 
+/* A sign extension or a truncation between integers of at least 32 bits */
+static bool preservesErrnoCast(const CastInst *Cast)
+{
+	Type *Src = Cast->getSrcTy(), *Dst = Cast->getDestTy();
+
+	if (Src->isIntegerTy() && Dst->isIntegerTy())
+		return (Cast->getOpcode() == Instruction::SExt ||
+			Cast->getOpcode() == Instruction::Trunc) &&
+		       Src->getIntegerBitWidth() >= 32 && Dst->getIntegerBitWidth() >= 32;
+	return false;
+}
+
 /*
  * Add the errors which V, the value returned in RET, is known to be on the
- * edges to RET from CLEANBBS to VALUES. V may be a PHI in RET. A PHI in an
- * earlier block is not followed: a later branch may split its values between
- * clean and dirty paths.
+ * edges to RET from CLEANBBS to VALUES. Follow the casts in RET which keep the
+ * error to a PHI in RET. A PHI in an earlier block is not followed: a later
+ * branch may split its values between clean and dirty paths.
  */
 static void collectErrnos(Value *V, BasicBlock *Ret, LazyValueInfo &LVI,
 			  const SmallPtrSetImpl<BasicBlock *> &CleanBBs, ReturnValues &Values)
 {
 	int64_t N;
 
+	while (auto *Cast = dyn_cast<CastInst>(V)) {
+		if (Cast->getParent() != Ret || !preservesErrnoCast(Cast))
+			return;
+		if (singleErrnoAtUse(Cast->getOperandUse(0), LVI, N)) {
+			Values.push_back(N);
+			return;
+		}
+		V = Cast->getOperand(0);
+	}
+
 	auto *Phi = dyn_cast<PHINode>(V);
 
 	if (!Phi || Phi->getParent() != Ret)
-- 
2.43.0

