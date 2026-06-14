Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BFC3CAE9E
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781456354; cv=none; b=MdPsmEZm1QRex8Zo+5Id9K42ZEO5iCAEn2cRr/7WWcltK5LV61mQKYakmtGel+y59XlJAYpewm2uUMD3efXd3A1NPGGkshp7yY2Bt7QRuZY7v6pbeIR5s5uzQzCJB08ir4FviGSeMsrWjUuVai+bTaw9KjvFNz8C15ewsHPoRKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781456354; c=relaxed/simple;
	bh=FrdCFvpw9MoOQ0+PkoEs5DFfpaCKlDpBo6fwG5E9ypo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAEfGPb+9oAPni5V5No2QMUXtrjR4PanYSniNZK6rADszl0hJ6VAZ03drzthPIFZ8tX+uVZfSv5ZmBwc4IOqDYVQbmpWQWk6B+rX1I7+e9r22l6tGwPFsAGMg7Pf4Qiax5lCAwypLAgogNprGNMt2sxbx6qDic7LonONBEc2r2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2FSOKdF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2FSOKdF"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso1609694a91.3
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781456353; x=1782061153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3rN8waOyeNHOu4xKjl7MMlKsb/kdxpH+0daFeUyAvA=;
        b=G2FSOKdFwQB13J5J8gIr5yRDvQTS4MNA42/W8Ff/ytJadLTWEpV4xOolmHCDa4e2vg
         lW2u2IsxAQEnZZYxBiQVmXJlaNY0UReLg+yq2Epses5U8MnRJaoqUZoRzkcdfJbr9lWt
         G+FJZV54xgAbL/mZXNatMVBCh2Tx8V8nfreOMJYLB5rTGX+ZMEb6qy8m+hlI9Yrm+Tjs
         IScyLeZkFDk8i++cTsKcWqPl75ed2YLmmPFoaC8a7oeeKAkOIesR3xvPlbtf31tZglWH
         aivb+hHGeEVxZlr/sJltVaWdVHtDL1an5td7hyOF9J5OD4iCzQ2VKjtI8cmvyswz8Ugx
         f1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781456353; x=1782061153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3rN8waOyeNHOu4xKjl7MMlKsb/kdxpH+0daFeUyAvA=;
        b=OaGgaXJzi3C5nazi/YFJH75qY3TBQzUs6k5drIjdJ/bZVSo4LnaQTDi9lhPAbL1grB
         Hrln12daBBBf+L4KEtsFAcjWU0qFW7ZDU/n3Ar0vgZESfj0mSS3yEmSQVSZejSkAQHit
         uEvByO3kp8SHjmGQ0C8lf3VJCN4+IEOCOq2ZODldI6mFMhZsCBaM6uw4Pd8rGeY2ARx3
         hRZBVNWqGM9y9erwq7qciZL0U5poUE0J0P78YmB6OwbMzoxeAtWdPCmVboUS7HQswIO/
         Wh0byo4eHDQQVltvBaH4rUiH07uPcbQbx+VlQVQNV4WxLPSDd9sJuN4RY3ElB/6J4dmD
         pjwQ==
X-Gm-Message-State: AOJu0YzwKusizsj0mtvQmrHagvUT+x+vuuxGcKvfrshyIhIe/QivsTil
	lGuPuGtBCzV+RqA6np40P6g4qyBXUSH9ClcO81jstmVHD1fw2exb93NbD5cq/OAOutk=
X-Gm-Gg: Acq92OEck0hdVNU+w9COtN7dPNlghLAArhfAZM0sgLS6VqPOsciHhYOZ7UxXMJAtr0w
	gmEaL5QRuv+gsrfGj21xsHKEHmSzvKW462DacrkmS3hn8H9d1C0Q4QT+2dTXM1xCLf6a2azIN9b
	jvxCRMKaygB5SYlwL8e1Es1B52RukIx1viyJ/VpR2ewoP5ljrDIjR+u2mmZrHAkGVMhIvXi98Oa
	//tCYrtP+9g3+Ib/FrZLNWmB7pY4SZk9Krea6yzCCiJYBWPvpYFN4OtJuuVdQtdTSoO1lbqQECa
	LAai4/HjTyA5wOQHHiMjovdsuIMi4Sa2O4NK17elUzTOlhGY7SiH7PsrEuQb4XYSKWaYKesSfMm
	E03Oixi6Ie2xWxWE8drhYD84puF4J2FpFO5vvBVeT44D+vtdqtFp3g8k4u7DaskIgXPrlFxd+ov
	tmb3UuVSAAxnAgMU3gcvjuMlkz+RjDqq4=
X-Received: by 2002:a17:903:3887:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2c40e0350d2mr121454055ad.0.1781456352693;
        Sun, 14 Jun 2026 09:59:12 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5b79sm74457405ad.36.2026.06.14.09.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 09:59:12 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v3 4/4] selftests/bpf: Update comments find_equal_scalars->sync_linked_regs
Date: Mon, 15 Jun 2026 00:58:41 +0800
Message-ID: <3b5b6d9879fac3fb22b76c8249bd7c71609e1c39.1781194510.git.jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781194510.git.jt26wzz@gmail.com>
References: <cover.1781194510.git.jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit cfbf25481d6dec0089c99c9d33a2ea634fe8f008 ]

find_equal_scalars() is renamed to sync_linked_regs(),
this commit updates existing references in the selftests comments.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240718202357.1746514-5-eddyz87@gmail.com
[ zhenzhong: only two pre-existing comments still needed updating in 6.6.y. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 1f71f596d..07a2527a8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -392,7 +392,7 @@ __naked void spill_32bit_of_64bit_fail(void)
 	*(u32*)(r10 - 8) = r1;				\
 	/* 32-bit fill r2 from stack. */		\
 	r2 = *(u32*)(r10 - 8);				\
-	/* Compare r2 with another register to trigger find_equal_scalars.\
+	/* Compare r2 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners. If the ID was mistakenly preserved on spill, this would\
 	 * cause the verifier to think that r1 is also equal to zero in one of\
@@ -431,7 +431,7 @@ __naked void spill_16bit_of_32bit_fail(void)
 	*(u16*)(r10 - 8) = r1;				\
 	/* 16-bit fill r2 from stack. */		\
 	r2 = *(u16*)(r10 - 8);				\
-	/* Compare r2 with another register to trigger find_equal_scalars.\
+	/* Compare r2 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners. If the ID was mistakenly preserved on spill, this would\
 	 * cause the verifier to think that r1 is also equal to zero in one of\
-- 
2.43.0

