Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47132FFF90
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770678098; cv=none; b=LqU9ARI0KhskGRHHyOIzgGVUzr3cLE27U/vZ/EtmrWeKl7DSDrOCRovonLxqDVUnKKHytHbsrJkKPnhyTZrQNpYlzWT9QNrkUz5At/KR4iO2x5Hw99/NqUBVLXk8mGRlrq4RCqLowKxwPAXz6TQAt2G5ejZiLHRbFZsWwanV8Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770678098; c=relaxed/simple;
	bh=6V/RNYZNDfolqcyZOjiECfaAPCgPn3kRmVGOHe5vDS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7nhfVsncD/px0xkS429SQHLDiIc3ipcKgMYuJ5ESO/3SFmxBc0e0Ghl/gyd1JPW917MngnrsnzYLGPQddA6ZohJYkLtpeIyhdbpseKq0rlEmaH4SPBeqsoBittGC7BtR+muWt+oozo4NcTlqrmXaTTfESaryRcSEnBq5C6jivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px2Jcq/b; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px2Jcq/b"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso82329a12.1
        for <bpf@vger.kernel.org>; Mon, 09 Feb 2026 15:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770678097; x=1771282897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r95Gt0u7KhboAUEWusQX2TvHc0isW2vq5fo2Yr5Egwg=;
        b=Px2Jcq/bYUGKtenlodUQMofro1tuhWaP/AL5seGSto/uCyWuXo0y5r5LErQvtHQMrU
         L7APpePEKKu51AVU28SKqSjXw2PWvMEhMYUW19X7zOSZLotE06iPFKZpo/BuiuLtgCp2
         Zr0GctDt8Xeh7zxD1//QWln4kMQhmPw2yR7itXwFE/AomeJidlNSuAujNIAu70lwF1AO
         r8/bKpRQCj9SI18uyC6Xo2fait3vlV1QH5W3e3BIpLtQ/8MNohSZqhaXkDuDRnlA4RTl
         Av0lEnlQbzyVkgR6bk8cb6NqrErXguijLqHTAwhlmzHQqpMiENNyHGuX/lzrcSF786dt
         /1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770678097; x=1771282897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r95Gt0u7KhboAUEWusQX2TvHc0isW2vq5fo2Yr5Egwg=;
        b=SObHc458QYOrn/YJmJIN6lvd+G/kVkoRMnNHhec+gbgz/vR5I/icb5Iq+qFfDcBCLN
         WJrNowHlsPW9ypGDvAUD0OL5FGaYkgaTIrNWsjPdT7mSN37u+MTHMea9mnekXqk6f19x
         d4jTmUyFCIztlDIuQ1NpL/WnjjXyLBs8dKy5eygJA6ywXswmw+jTWwEqIDyh1xy3+ldw
         9UF5XE+wwBwHpf6K8a9E6drmBc+IzbTVqly75Sl/ArcTatFwi2TDUc7YD7SbsAY/V+Oe
         pISUJQV9N9gmfbMGXiOPtS7mcQDAKv7NqlPTQPXe7KJbFaF8IH5IGjJda5Vtbr03rvB6
         47QA==
X-Gm-Message-State: AOJu0YxnEL/F7KZ+HjF5pZOolQOJIibBhJT547WQvovNvs8oVIxafFvP
	KRwMAVMW32x+Y2dvBU1fTa5JcApSUTkC4LRnIFkjjWUeQNmuWxVzT4siaxu7og==
X-Gm-Gg: AZuq6aLua8trz7SGz1Wkl6IpAWMRlfVl7ZU/AvWgxmQ+OSUHtJ7K8K1A3WM4kA/YeJe
	w8oI7OfQFNmyPfDAzPoyLlpUdxGtILOQsI5H293JMgF7jScJow2lwyjbnO0Ccoh/auELJ1zkOwp
	nj0WjGehjTiYTLykoCCyWPNzzn3aqPBE6m5IN8uuPqWG4GTAOtMcfLbF/hU+fUgNEA+6ZgcPLlQ
	/bmbvJGvTxYcDyKe5bisYfFUEzYUsznKZJKSEh53md16GyIxU/d4FUD8SsrUkkoTY22oyV5kjmC
	fYYD+mDgPUr95sfUXXicTEmmHZUDRelfYtiRdyD3XTHk/GXhREzwNNh+NEn5xe6VkpwbechS1Fu
	NAzEIyYfED2rq3Hb6N+G9RPtDEWsJ+tkGf5SxNlN3IAGOENts5uJn/MaBANCuD7cpvvRD/OS/89
	sW8MbZMKRrmm+2
X-Received: by 2002:a17:90b:274d:b0:34e:630c:616c with SMTP id 98e67ed59e1d1-354b3e4c3femr9984463a91.31.1770678096733;
        Mon, 09 Feb 2026 15:01:36 -0800 (PST)
Received: from localhost ([2a03:2880:ff:16::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e8bc38sm491029a91.11.2026.02.09.15.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 15:01:34 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/1] libbpf: Fix out-of-bound read in bpf_linker__add_buf()
Date: Mon,  9 Feb 2026 15:01:34 -0800
Message-ID: <20260209230134.3530521-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a potential out-of-bound read in bpf_linker__add_buf() by advancing
the buffer pointer and reducing the remaining buffer size passed to
write() in each iteration. The bug is reported in [0].

[0]: https://github.com/libbpf/libbpf/issues/945

Fixes: 6d5e5e5d7ce1 ("libbpf: Extend linker API to support in-memory ELF files")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/lib/bpf/linker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index f4403e3cf994..78f92c39290a 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -581,7 +581,7 @@ int bpf_linker__add_buf(struct bpf_linker *linker, void *buf, size_t buf_sz,
 
 	written = 0;
 	while (written < buf_sz) {
-		ret = write(fd, buf, buf_sz);
+		ret = write(fd, buf + written, buf_sz - written);
 		if (ret < 0) {
 			ret = -errno;
 			pr_warn("failed to write '%s': %s\n", filename, errstr(ret));
-- 
2.47.3

