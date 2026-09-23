Received: from mail-dl2-f33.google.com (mail-dl2-f33.google.com [74.125.229.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D335383FE
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189543; cv=none; b=gXJkIVUARSwyzVV+e2wWj+O0MOyBz7DaugleE/9m+LerfokNJ9ig3gYJOP2ivPbkW0ry2X1KxFt+GJmYClnq4ct9I5ReA2BMPZnGqGlpYC/nGaXFRScwbYujqdZpt9aOMIU/vG16o91smDwmDdKpBaAR/LUZ8jj2/ePAvkBk6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189543; c=relaxed/simple;
	bh=S1kGMndTJBeB8hHVwavfqDOuTps4RpJZyzuxQjF7lOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEhgO3gANyNAMUaOjS/TQ1a0rJbY+dA4RRGfu89Eq9iKNDtipoeNbu+D6xJRpbpt8ZkCqzUDZ7r38AfWqbSKi63L8aXi6GqfwDnyjD7mCqtvoq6xxIpmafyhFPiV4rOHDJbvh6CHuPyggULc5bXVccXH9dmD6LrxRn+1SmhFWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSosJwGX; arc=none smtp.client-ip=74.125.229.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSosJwGX"
Received: by mail-dl2-f33.google.com with SMTP id a92af1059eb24-1438e88300cso894016c88.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790189538; x=1790794338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LHB12ofgunTotyZpvRl/PbRaWxixASh+pYObMSubPjU=;
        b=eSosJwGXzay6kp0eEGaylxnvoApBvyy93aS9EY7yMizN1CDylg6LpsP8eUqInN2V8L
         nhHexEqumWOWRseCperGbxFgU6gmTb+2ojW5av9Xx9+MMvjFfaZTEzmUgUCqMosvVOXC
         Z2/Tg0aJiIhCU+EWACfsB1To/sYfj5NbKhWW5Nb0mWJRXdDdq0hWmE+nDrXbLbgV5ppl
         rGEJLXKm9bZWevsyni3l/Yocr2J3vqWg9P2RvHQv7SSL640hQGxy8rnYLomMYk7WZnM4
         Qm5rKrhEGaM8xgrZQh+O+FO45TpqD8viVDI9tv3PK2ahXXLCIvdYyBHPlmGZ2aAd7IBK
         KiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790189538; x=1790794338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LHB12ofgunTotyZpvRl/PbRaWxixASh+pYObMSubPjU=;
        b=oUeuQr3Qqkuqbnz8zKRuZKeXknTGSNPbogNDhBmgsAwjc7XgZZ29YcpoqpHIW4kiG6
         +QN4g0lCzhMHNRhNct9tC9aaBm0e0Q/ONIXhKqExwN8ysjltvRz2XcNfz3wyJv+y+ALl
         UTvVgOCQRYjLK/BoZnvlgygGpZG4p0ms6CPeEwi3sBALG3IzhycjJPh5lPhjci5ONNmw
         j1vo6mkX6j1l08WcZXZblIvgiRY9lAsmF47JJ2IkDUsiY6HLa6u8I5AStfOaRhOsF1Jj
         IFWyg1J9oXdCiCjuIcj/W9MmsZIJ2UxQaodNj5Gn/RtooRZJt6I0O64JAPF/9wx8xwQy
         l+Xw==
X-Forwarded-Encrypted: i=1; AKwUvBzDEPjcF1NUc4ADMlL8IVAky/CZC0b+wn06/bRUqMkChYsKTKFYkovokuGzbEZW4H9ru6s=@vger.kernel.org
X-Gm-Message-State: AFuF++ko/mFdKkLRGUm2mYNgYg7RdupVxJp/OTajd6XfmK/3VE4eCAGs
	5BV3dHI04zJPC5386YSK8FM2NeAOMrUo6D1bwf6cagSsglk/bV/h6CaV
X-Gm-Gg: AYBFou3JxuTmtSbGJuKf8WS9zT6u7dkb+5w45h3tSpaDE6jmwOV+qQ1SDDtp9p1kRyZ
	5igE+bHRdCLRhm+QqRRiceZwk0TzsEwJpACZPI7eLloMJxucsXB+Zd0WnCPaH7+B3rAhwF5rjk7
	+lh9XuaXEpPBbcGbhwZjmpKLReTUGX5RZDvRJowBqwB8gwoA5r8m2M+n81TrNxTmMxLQWaTyvtb
	P2ZeAAlfQckBZqxZRt5ebUanJJDZu0kF5p5AWapkmLicKKpFmLhhh3SkPyUdhSVhidE0oR8g/A+
	Foa1yD+vjlDC2gjl1/cY/RGJGvVsfrOFzQi4jAx6m4wOuYmyxHLFHI24SQJwP9lA24P+FHqMd3n
	sdytt/n7uI7cLmZAyQbgjhz4jBLz37VZoN6CnTfo1TZgRuKHTcqsjjSdsHcNWO+Qzn+Sli8DiDd
	lrHIzzlroBmGweJ25nbUJvV3dfL8RUjOol7lijbIyFi0hwzb1mt5PHTbwtoFp14lIFrh4BfR4uc
	4HwnDhacLfb4M6DvlN6HO1rDuZn/YOtIZsQ
X-Received: by 2002:a05:7022:3f8c:b0:143:2979:c87e with SMTP id a92af1059eb24-14503fefaf0mr48309c88.33.1790189537699;
        Wed, 23 Sep 2026 11:52:17 -0700 (PDT)
Received: from archlinux ([205.254.163.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f983d73fsm9654094c88.6.2026.09.23.11.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:52:17 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	brauner@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] bpf: Fix inode leak on token FD preparation failure
Date: Thu, 24 Sep 2026 00:22:06 +0530
Message-ID: <20260923185206.91210-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_token_create() allocates an inode before calling FD_PREPARE().
If descriptor allocation fails, alloc_file_pseudo() is never called.
If alloc_file_pseudo() fails, it leaves the inode reference with the
caller. Neither failure path releases the inode.
Call iput(inode) before returning the FD preparation error.

Fixes: 981bec8f698b ("bpf: convert bpf_token_create() to FD_PREPARE()")

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 kernel/bpf/token.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index da915a4f972b..7375eaee6a23 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -169,8 +169,10 @@ int bpf_token_create(union bpf_attr *attr)
 	FD_PREPARE(fdf, O_CLOEXEC,
 		   alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME,
 				     O_RDWR, &bpf_token_fops));
-	if (fdf->fd < 0)
+	if (fdf->fd < 0) {
+		iput(inode);
 		return fdf->fd;
+	}
 
 	token = kzalloc_obj(*token, GFP_USER);
 	if (!token)
-- 
2.55.0

