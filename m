Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D163128BE
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253594; cv=none; b=uVHxTQwHUHJMfrdkgShqwwEbVE+d1id8DqRGekvuuFx/piJvU6i2OTtL8m7F+AWPrnQuXCcrSlszFAT3m26fppZgW8V6UQcvLcCKGq3xQ9w4IrY2ABk8s3WFYx5JaUGRu+fzHDOUvB4qL5lSCeaew/FLZNepvgWlzoT4II3y5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253594; c=relaxed/simple;
	bh=k1OBCTVrSeNRrFsqs5C+Zz2ho34W9SpeXsRrjeRBMnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V8I2WK8bLOtW6EQ0Dd0R0sBhwIFvMguNDsBYOMOR8HcI1HOlrLjokwqtOns0AflH8sR84z5lxR4a5REMTUai60VwrEs4R65Y55rKqTTQwr5IYZAZzUZwAmHF+ySUToiU3pyS+FIqiLLWSadnMpo430Up3x8Hn9RjzfFdFXWYmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycq6Dfc4; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycq6Dfc4"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-824a829f9bbso1630952b3a.0
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 06:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771253593; x=1771858393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BzPXx4/xU1OyhG3PzSrYUGxFAh6ykIsO6RQoTNEOyc=;
        b=Ycq6Dfc4lElKz2kKBhicUjc7SbLK8z3PWUn+zM3AEoZLvn+Mafq1cPR0ISfYdAesql
         pWdfVFqWohMrVVpLWr1/7ISJ/8WyPPWBMZXLINIhZNAr+HtETISGNCE4PBDju23nk1Dc
         rKnjtSQSN93Kb3xdeInzzf4shHYdEZZ/tlZJIFL7zSbWgsKSzIEVQuwse0joLG9uMiNZ
         VvTUqjFweuL6uXwn5vnPjNVRZ99d7/g3lcx9VlsjW0vgWKWgudKh4Drs2OYXFC5J2eMr
         cjA0oe51va9VfQCMuu9LirNbbU7f6rHLuot2qk5+9uarMkCl5c7Huwarjk6gDHWJZcxN
         8p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771253593; x=1771858393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BzPXx4/xU1OyhG3PzSrYUGxFAh6ykIsO6RQoTNEOyc=;
        b=prVxD3ovjhqOlsUXgs+s8RTgG2gM1gKKAlYooEF0WcNUQtIJNIV6v9U2mlOIj2IVxb
         SoUhC+2B+nfITNbRCvE+ouS6p457deCggJSxSu7xs1IcS81p3zd2b7PDFhgRDI+6MJcF
         E0hcOy2EXDj+RNRLr4e3L30cQQlonSlFqqSKxaeFi5TldAaDxAT5BQBZmf3NaTwJTga3
         f9Uh+6MHTpx+YDDtNpnZJYJj4Tm0Y/ECyaIJzZkARmrZfUzVz2GciP33A2wrNHiE5riM
         Z5qGUd3ohDs3bgPiuQ6ozKY0Xa9I8PjxytnFT8uW1JziDKg7gYYVz6tUGfonf0dzhFSJ
         cysA==
X-Gm-Message-State: AOJu0YyITZ5ZHtCCBCtl+P3PHdA5A8gtwhB0Zn8k65NGAiQAHpOG32Uf
	NvhE7E+zO7NY7VgkkCVyHroi5liuQUgi3vJS8/mM2T1Lxg7PKlCmmVlR61db0hUP
X-Gm-Gg: AZuq6aJdKEUbvajgKb/wSCGLH4nuImPJXwC79r3wr94SThoxP96rymKt1c1IHa4R+oP
	83t90nHBnGwLybOQvtvg3XrE3Ed21Dx6hXm5sAInO2OyhouWI/whFNwa0xmoGD3FWD3eFkf+/Qz
	UCSjo/0yLJjbmpype+/JPENzfI5Hl+DzuL3QcK8HL2WJVMeeNIfqrQEFnJo9SH93bUEZUu+YZrZ
	FtPi2jA19k5IJKdpgT7Cqw4lzO+o4nom3k5G7RPhN6sWTpa/El74ZqXOH6omtM87z2eFxNzbCGX
	K9/DKKzaCa0ArEDOpkay6pfdjuYSaWb8UdITOzxJ0caAEFiGBEl50ytW+s9l0ibrJ/c8C0N/vrd
	l2YfWqOjcOOd463xfe/bC6OAANRyCKNsYJ75uaLzCrKIda0UPMmrGUVaQu531ayMPqy6D/xqT+Y
	vsRsoam4BbK4K/9qZwRdAr8ak9j666EKCyd9TETuejEVhoIVv/2ps8M4NUk0TibDhDtux/Afpp/
	+TMmq2ygxcWJRxJlQ4=
X-Received: by 2002:a05:6a20:9c9b:b0:38d:fa22:8ef1 with SMTP id adf61e73a8af0-3946c718148mr11383953637.3.1771253592775;
        Mon, 16 Feb 2026 06:53:12 -0800 (PST)
Received: from localhost.localdomain ([49.207.200.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532f211csm7238610a12.23.2026.02.16.06.53.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Feb 2026 06:53:12 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH] bpf: devmap: hoist loop-invariant xdp buff pointer setup
Date: Mon, 16 Feb 2026 20:23:06 +0530
Message-Id: <20260216145306.96108-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dev_map_bpf_prog_run(), xdp.txq and xdp.rxq are assigned the same
stack-local pointers on every iteration. xdp_convert_frame_to_buff()
does not modify these fields, so the assignments are loop-invariant.

Hoist them before the loop, matching the pattern already used by
cpu_map_bpf_prog_run_xdp() in cpumap.c.

No functional change.

Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
---
 kernel/bpf/devmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 2625601de..568477ce7 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -341,14 +341,15 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
+	xdp.txq = &txq;
+	xdp.rxq = &rxq;
+
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
 		u32 act;
 		int err;
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
-		xdp.txq = &txq;
-		xdp.rxq = &rxq;
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		switch (act) {
-- 
2.39.5 (Apple Git-154)

