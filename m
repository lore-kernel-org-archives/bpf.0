Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFABA45
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560644; cv=none; b=pplypQh2FCbbYyE6tXpaqTlDD3mq4zousHcrwM2o+Noet7eX2UnJt09azOOqjQu/2cJIZERd3RaSqDGkJ3MM+0NApw6AZMgrLMRfoeIro9Opq6RF68TTKEClypC2pKJ9DZwwkTiPsfaFQ2Huj0RHmHHL06diiCrdTD/z/8+jPrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560644; c=relaxed/simple;
	bh=jRVyiHNiI2m0npwbo8Ft33Mb7Ih6XJH1tqdWUa5LROg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DANakzWyhTSJG9xj1U0s4teaL5ZNa9sngVO2SE+A1EsE5mws9IYSouEWfnseS0qK3kh+LM60YIYrI8h+R2GI8A5/rvGU42jZHZWhd9NfVMNPm06dM4m40BjaJex9Qj3mr0hZ7SLjkPbt5yVF+chadkQFX4mzfoE/QS054WUibhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=tCQ/gBCv; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="tCQ/gBCv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1774560639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R9kUd0RirLa11w16tUR+cHrMvT5zx/J/fARP+RMkdj0=;
	b=tCQ/gBCv4hbIqg9Mfwd7PwbykO895MP20Txlynubjj+pH7a0qWqhw22XXERRFJI0cMAGnb
	MtRIRrkdG193XjsDL+2XqyO+fmwsBavBj9bQKEka5TXr8LIj3kSxTIPF8ay4DhnazpLZTP
	xPIqRf3VG5AYp4I8/mQF5yPaq9/k835EI+KhLFE8VWeqI+XvpCOwNvs+RjCJzPjsnhrCuL
	IFcSQTNZQx7zbW9MoZ8FL41GCuLC+JOpOj/9bhDX0FEq1hHW3FASkKSZSzSucdtuam1Vvd
	cbLx7ECQq9svesPvqd4tkMOCAGTvYW2phosc0HlTRNO8+YvTm/n3nn/BAjHf/g==
From: Clayton Craft <clayton@craftyguy.net>
To: bpf@vger.kernel.org
Subject: [PATCH] btf: don't fallback to searching /boot/vmlinux-*
Date: Thu, 26 Mar 2026 14:30:36 -0700
Message-ID: <20260326213036.8121-1-clayton@craftyguy.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This makes a lot of assumptions about how the kernel is named
and where it might be located in the /boot. If it's a separate
partition, it could cause additional problems e.g. with systemd
automount if libbpf is used early enough in the boot process (see:
https://github.com/systemd/systemd/issues/41162).

Fixes #955
---
 src/btf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/btf.c b/src/btf.c
index 40becc9..28d796f 100644
--- a/src/btf.c
+++ b/src/btf.c
@@ -5494,7 +5494,6 @@ struct btf *btf__load_vmlinux_btf(void)
 	const char *sysfs_btf_path = "/sys/kernel/btf/vmlinux";
 	/* fall back locations, trying to find vmlinux on disk */
 	const char *locations[] = {
-		"/boot/vmlinux-%1$s",
 		"/lib/modules/%1$s/vmlinux-%1$s",
 		"/lib/modules/%1$s/build/vmlinux",
 		"/usr/lib/modules/%1$s/kernel/vmlinux",
-- 
2.53.0

