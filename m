Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7882248B3
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 00:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771979761; cv=none; b=P2pqbL3Z//McCd5eM+IzGb/wLpAbb4jND7Z4+unOJ9kLVpWTkPtC0gboIAnVbtjqs95XryLvU4n4Qp5DZetj3bPP4INzgZspbNhhqGoKtTADFKoO6RSUkP5nd1L2nFS28HLvqhKozS4wHiUAKDNyAcRUymfxPbgIilJ1SgXZk/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771979761; c=relaxed/simple;
	bh=stRsP1O+9FA+35G10yuqDVObn1O6DuV/lsK0Cj70acA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Us6dJogtaTaRHZESoqTOpba+kcg7crlHABmXi2vQ29TZrur4eoaVgY7QUSYosR9+HwcnCr8satBw9r/GuQRGlYwmkEV9xBAMRhxnI63eLvAe/BQN4V/BT1rH+IDng6gIQ+2bs4OA8uelgwj9JMc1z/l7Yj+sn7AS79KtNnY91hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wY6MM4Vf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wY6MM4Vf"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ad147cdf07so65312535ad.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 16:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771979760; x=1772584560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lpd6udhqVRoi/VjnEJ31/8jqYQEWSxtwTa2nqxOPIz4=;
        b=wY6MM4VfHGKhSTROXPQsjCFvvEnWluspb7XarMrn5/vGiX7mWALxDjcO6M/OJNFmLi
         5CZt0DB2NJ1BIXEBT3slB47cx3ag0OhiUNF8RovWZxC2l7CgyL9HkHnZABgqVYi4eGBx
         gK9QLap9WoUS1YG1W/6xCEJQ1Yzd19R53vhN62tZbfXkopqrERxeJdO18OcFe718KYxQ
         GtRKS/NCazQPA0UKhjMCEFn0bW0JoetO51K7tQLxeEqIHWeyY/khINmn3bY3/Y8aD159
         J4OKg6SfjwhW2YlF8vp2DYgbGBP5ONG8yWHLKgpea4KVEWnyz2w+84jG0PsKCax/C1Z0
         76lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771979760; x=1772584560;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpd6udhqVRoi/VjnEJ31/8jqYQEWSxtwTa2nqxOPIz4=;
        b=h42L3weFmpps3Q2F33cKl1BKIk8UpuNZ+DJR3mymWu0Shk0vyuzlk9qaXh6NByUwad
         uIZobY+fVcRiK+g3f9fd966KcV/DDScT99wqef0JiYv80ocTm4unmI16ZyAKVnzqR+dW
         z+VE4LKIymMxzBsQhQ7/Cj9ZqmdGQePVUdYbdQyRmyIv23CLMgIu0rcWFbL9ku8FbssW
         SaQFGZ1CPcqIzYBMWI+RVfBJ/hmSdXlLcyMeKDQiEoSaZwYkMlkN0p2fTpg9FAAeHkT3
         n1bP/hWRDJPzw+0678Qvxye8etQtqaVqP3hH19IdXNMAIBCRxV2/4aVW8PVxOhdqHqQc
         /M1A==
X-Forwarded-Encrypted: i=1; AJvYcCXgseR1TwWJFC3P14vOq4wvN6xtXJbmJdeX6dDfntL0Bm7KQiukjph+KDmaA0OzrbEiHlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy52mCk7AnVDCfbK2RIU++f5WMMKgjndCGhE9Hd5F0XoI6a9OrK
	bR+hT2oMzTWy/c8tNmNd3u/HU8lEQSsp4XQqircv8dPOnG7ci3rk75HzfLDrklDQVIjkOhnREWF
	TDLYlTPK45DQhE/JTGQ==
X-Received: from plwh12.prod.google.com ([2002:a17:902:f7cc:b0:2a1:1059:442a])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:228f:b0:2a9:484c:ff30 with SMTP id d9443c01a7336-2add13834ffmr4836965ad.26.1771979759424;
 Tue, 24 Feb 2026 16:35:59 -0800 (PST)
Date: Tue, 24 Feb 2026 16:33:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225003349.113746-1-tjmercier@google.com>
Subject: [PATCH bpf] selftests/bpf: Fix OOB read in dmabuf_collector
From: "T.J. Mercier" <tjmercier@google.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	bpf@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: quic_sukadev@quicinc.com, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

Dmabuf name allocations can be less than DMA_BUF_NAME_LEN characters,
but bpf_probe_read_kernel always tries to read exactly that many bytes.
If a name is less than DMA_BUF_NAME_LEN characters,
bpf_probe_read_kernel will read past the end. bpf_probe_read_kernel_str
stops at the first NUL terminator so use it instead, like
iter_dmabuf_for_each already does.

Fixes: ae5d2c59ecd7 ("selftests/bpf: Add test for dmabuf_iter")
Reported-by: Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 tools/testing/selftests/bpf/progs/dmabuf_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
index 13cdb11fdeb2..9cbb7442646e 100644
--- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
@@ -48,7 +48,7 @@ int dmabuf_collector(struct bpf_iter__dmabuf *ctx)
 
 	/* Buffers are not required to be named */
 	if (pname) {
-		if (bpf_probe_read_kernel(name, sizeof(name), pname))
+		if (bpf_probe_read_kernel_str(name, sizeof(name), pname) < 0)
 			return 1;
 
 		/* Name strings can be provided by userspace */
-- 
2.53.0.414.gf7e9f6c205-goog

