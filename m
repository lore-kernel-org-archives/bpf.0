Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F3B2F3C18
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698100; cv=none; b=bPDRd8P01Ao60/aWUOEKtPpoEV87P5TUuDN8jxpqUjd/qzp8UvOTah3q205L5NQkovoo6co2iSZJLuUX5MPnSTFBk00W4jynkN0auP9ihOvld13Xv3954qa3pCsYXgAjc7Mo2guuMABm4I5Hf25iwGmzWjCctP1yZdTwPN8yqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698100; c=relaxed/simple;
	bh=YjsAhYXUodz7nc4xjdfUxVayCu7T92r33C55MOfrInU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIy8zl0l164FWy4YNhD4k+Z+wQ2VU29cXlOUjJWXzL8jKMyGka5po9iyQlZXD1coxoFgQXGXH/iE783rJYVcfe+5abJixfzZr8Hxiwaj52cFeQXt6uNlJuDrXlLughBYJZ6c4JiPT9J0JFGF6qSrhs53L0f5Q0d28PSq8zF4E9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkpWpsan; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkpWpsan"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso37822435e9.2
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781698097; x=1782302897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0jOMZCcA1H7BGnP4Ncr7NnGD7quAU2khlteKx4MJN0=;
        b=FkpWpsantnKAFhI2b+a2A2WgmVrui8g4xddO1qZi0zQpARTHfc7fqytYWT1+VK43TV
         N4Ud0ch2bExcsdANmWtGHdpoaC0O5YeEQ1agzSkSP0GifIU1XSUwJZaHg5VGqIEDVK2c
         8HkuzcbTIBfJRKvCYgQVKocpfTxHrwq1OFshK43TVP4VpdRTDr0SIoDqpxfV0DDUO5in
         Omrjfp2Wus+n/rU5g+ROolPnATccDXMQtgk6wTwRu75bY/F5//932PuXYosGOey42PAG
         zjli1oFed2E//4kTDdeCBaukRVhljUwHnqlxkuW6TgDhohhkclNsICH1QMzcU+sY4/61
         X92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781698097; x=1782302897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0jOMZCcA1H7BGnP4Ncr7NnGD7quAU2khlteKx4MJN0=;
        b=NRkO86K4OUUsMJEr2eYAo06zf4lIyCg+IdPi+uhtkY0DXvCU7gYTikK3TXN10kLLVZ
         SQYiuGnF4Jw1PcBi2DGyoWki3Gesi6V9sdm0vkGTIE5hNCflAJHiVrqgqwyGTfRxUUhy
         FCMEJNKE6a6eUeDb/wP2SRuPK66Pfe4oHMy46fKFVECZtTOig3Ukw9+xg9c1dldZbcd8
         0Z/m9mVUmzLH5jp30kS/hxK/Yn4QGT4tZZ/aS727Wy3/An3HeX9x+/csoVhd+c3ujAtO
         WRLa5bsu2EKgZcEqUqHbWSbX7JD4IDRJJHC+irMEvlTXCBPQlXNawioZZJsr4hd61Lbd
         r3gw==
X-Forwarded-Encrypted: i=1; AFNElJ+KCQOrR95jVRrCeqnFP5VmC1fG/ZU40OdmYmj4/p1uoqAtf+orZbrhbRCziyNVC3kQhKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9kfgxuhudonIFsbMqNGVShKg9F13oWFNfm0fkjrmQeW1wJsen
	s2APz80RYPJSeexhc2IO+ofkmmeSrC04HYm7ICr9/ULGNK47oVjoJPM=
X-Gm-Gg: Acq92OHvn9XntxhTAYCLSysCQ7s+ZWJwbTPURD4+aq68Q9Y8Ma/m+J8me24aScBqOfF
	6I6cW/H40tBS/zM+Gn1rX44p+zZ8mcuNcPmKWOKTzyHb80Oln/UHLzx+AKYSNngyTw5jFnoLUNp
	ZEfnB2cEGlgFMMhinOEHuUMfTsVs15X3riRKPHCy0sdo5WuHXeRovDlgkpx2UegwNay2t8D+2YJ
	jDxVo3SugyR+e9rvpZ9SaKv5R/IuGkjZE3PlSElUAEpXAtU03yWxsXoA6bPdMJpW1rt3Uc9Xwaj
	LnhQvq//0wnqEALDRPhJiCZaqPi/8mQ0fi/5sJ+L8Wyg6YoquBELikIOiIUmcIShm+MrmVOE5b1
	L9+lT3GjVIi7FdYPKCMBXH+KkGfUTzY24qZ+F+x7qZhKa3503E0tvHbk57ZQ17QQJpEIf
X-Received: by 2002:a05:600c:4fcb:b0:492:3214:cbe6 with SMTP id 5b1f17b1804b1-4923341f59dmr55904685e9.23.1781698096974;
        Wed, 17 Jun 2026 05:08:16 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4ff67sm153691355e9.6.2026.06.17.05.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:08:16 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Xu Kuohai <xukuohai@huawei.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] bpf: Reset register bounds before narrowing retval range in check_mem_access()
Date: Wed, 17 Jun 2026 12:08:15 +0000
Message-ID: <20260617120815.3910671-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

When the BPF verifier processes a context load of an LSM hook return
value, it calls __mark_reg_s32_range() to narrow the register to the
hook's valid range. However, __mark_reg_s32_range() intersects the new
range with the register's existing bounds using max_t()/min_t() rather
than replacing them.

If the destination register carries stale bounds from a prior instruction
(e.g. BPF_MOV64_IMM), the intersection can produce a range narrower than
reality. The verifier then believes it knows the register's exact value,
while at runtime the actual hook return value is loaded, creating a
verifier/runtime mismatch that can be used to bypass BPF memory safety
checks.

The else branch already calls mark_reg_unknown() to reset register state
before any narrowing. Apply the same reset in the is_retval path so
stale bounds are cleared before __mark_reg_s32_range() intersects.

Fixes: 5d99e198be27 ("bpf, lsm: Add check for BPF LSM return value")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..7e30dddc7721 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7532,6 +7532,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			 */
 			if (info.reg_type == SCALAR_VALUE) {
 				if (info.is_retval && get_func_retval_range(env->prog, &range)) {
+					mark_reg_unknown(env, regs, value_regno);
 					err = __mark_reg_s32_range(env, regs, value_regno,
 								   range.minval, range.maxval);
 					if (err)
-- 
2.47.3

