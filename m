Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33C23BBFC5
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509172; cv=none; b=aksC8AVLBrrnkNhhRYOEOh5wPVAHHioCJWPND9mMIPHb/2JAnSM4uBX5wqMRmeK2tiXtSJ5YJMMlZcwST0s15d3xyd5jjI0GkSwZ3jLshRIu6lwy/RqDADJ8DKGvv6vZzjGjgN4RjVuqO6ib+exFPWnkLCATP4PvEB9CZuXgVWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509172; c=relaxed/simple;
	bh=GhXEyKkP29VXLeRmonNXmZuNyFF8Y5CTi4bvaeAk+uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fo893hFyFcCrt9KyexBrJRqk8SQiFgSnX1TeU2PrbGTH1siUryORFVbAhNBcqiPrJrGCFfmGMJynoCTm3WY6Pg6jF7zBqBMoTDc5hUnUGLj7eD62ripemtLdUqD6gfgmqObVCIwiJBWxIiMtelHm5kwPMqv9fcnyPc2DJ6jQxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rr4/Y4Qt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rr4/Y4Qt"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf20f6be6bso22028585ad.3
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781509171; x=1782113971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLEgrGhLLiPgaGmE3Is2kQZUG4Kfq7t6C+1yr+NyMNM=;
        b=rr4/Y4QtNFmxPXRI+sAgboLescjFzj4MrCOekGhnAvbvmaas6yt5MoE5+a0rhxYyAT
         nzAmqJcRzaFXzLvkcdjYRJc+pGJRnwz2zSmorFZilPdlSensyNzkn4zhYvph2nP7JRjo
         dgv5+63AH2BYBShK+iyx7whSnunCjUDX0UcaH2QNgy01X7L8PPfocovBAlimw2jLkFkW
         BscXnZadeg+GxdDEjHd4Y+Y/p2dGmdn0IQiXcvp0w+Q5wVJeDRb0JyawZzt2OSrNLVB3
         Dp7in6an2SI9lw7gAA4KF2p/hVzBDnWd1bvhBb+cCvNNvojPg+FEoEmTPSPIB9wZYrGl
         zquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781509171; x=1782113971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CLEgrGhLLiPgaGmE3Is2kQZUG4Kfq7t6C+1yr+NyMNM=;
        b=I7byV0eOPasOFpcmaETDmkLn22l2RJeDWRw7F5KdHo/1VjDgpj/kogqlNO2qJ5AQUJ
         ZsH/dUDbRVMi0fl9AS5p3eiXpwQiEj6i+65Ie9BJhC3rJjXwgnQriavbSDRTWy5DmLrN
         pHLPRlO+X6XD10fvMnKiMBpz2dnEboYC8WkJBzRdF2gDiSOnR8Jz5hm1TsAB0I1wgQki
         oQHoerwkmxYxWp2wNM90PiWJy9NdfSSwvi5sXvWySlCe+S4ngLLr2MxBBPgSbAvx02k3
         453TKTi0CBCCvrDwLNpCaZGcdnkrOpj5YWjDldv46qr/jOqlp3MOyUMgA1a1Mv4XRrJj
         PtqQ==
X-Gm-Message-State: AOJu0Yxrz3dou+IDw+a//T5DUZcL0o+zohMwPWhxuP0GSN9w+tbmHcdb
	2bC7Gmn7XU0GHw8fC/29wzYOkj+0X8OGPmRX4qMWTL+F0GunT33nWiwonP2nrCdmSQY=
X-Gm-Gg: Acq92OEcAGX2QuytMJdEMj+R/Kj06nGX8Dl8UHGU69CMxXZOUJLK67kOL10VMQgqAGC
	06I2aKB0ytlP698P3ld9zTncyFaik9cEHayL2Wpx+E0zrNBBeMKS2quDW0hIPXnJTLAI/4H2VWa
	YKyCdYgbL9+iRSr6LjCvTv2JqAoTXUKTFRsWJHzBQO3JSLGcr3wFtFwktYQikrYp9SDjrkmVTua
	ffCTo1TgI+0P9WlN6L3VfOUwLKN5pbR8i2CnUmS93O/WDof51oTJVVunbibCgDrvQHLsCAWYP33
	87QiDSJwICySDbG2J0VeuSKWLj+nK2dTSCeQB6yA8jdfgpsEszqu6yJmLJLEthDPsGeAON55cO+
	itZLBfP1NXPa4yZ6cZFWH40QjhNdg3YyVqRazd4Uz282GLW4/rLbpsSL/NvhUZaaGKOgA/a80RQ
	2Wj/6IV06AC9+aHvr/xC+heRzhe5+9vJYgr4u/N3TCGIVnp0zz9SjW/rUfkXZsUwI=
X-Received: by 2002:a17:903:1acc:b0:2b0:b016:773f with SMTP id d9443c01a7336-2c410414f4emr136000405ad.11.1781509171045;
        Mon, 15 Jun 2026 00:39:31 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::209f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43307a259sm91271345ad.68.2026.06.15.00.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:39:30 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf 1/2] bpf: Fix partial copy of non-linear skb test_run output
Date: Mon, 15 Jun 2026 15:38:55 +0800
Message-ID: <20260615073856.152479-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
References: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For non-linear skbs, bpf_test_finish() derives the linear head copy
length from copy_size - frag_size. This only matches the skb head length
when copy_size is the full packet size.

When userspace provides a short data_out buffer, copy_size is clamped to
that buffer size. If copy_size is smaller than frag_size, the computed
length becomes negative and bpf_test_finish() returns -ENOSPC before
copying the packet prefix or updating data_size_out.

Compute the linear head length from the skb layout instead, and clamp the
head copy length to copy_size. This preserves the expected partial-copy
semantics: return -ENOSPC, copy the packet prefix that fits in data_out,
and report the full packet length through data_size_out.

Fixes: 838baa351cee ("bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/bpf/test_run.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2bc04feadfab..976e8fa31bc9 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -453,19 +453,16 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 	}
 
 	if (data_out) {
-		int len = sinfo ? copy_size - frag_size : copy_size;
-
-		if (len < 0) {
-			err = -ENOSPC;
-			goto out;
-		}
+		u32 head_len = size - frag_size;
+		u32 len = min(copy_size, head_len);
 
 		if (copy_to_user(data_out, data, len))
 			goto out;
 
 		if (sinfo) {
-			int i, offset = len;
+			u32 offset = len;
 			u32 data_len;
+			int i;
 
 			for (i = 0; i < sinfo->nr_frags; i++) {
 				skb_frag_t *frag = &sinfo->frags[i];
-- 
2.43.0

