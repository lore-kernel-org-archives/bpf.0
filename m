Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498E3FA5D8;
	Wed, 10 Jun 2026 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103110; cv=none; b=QO4Ycjhh+orFmOcyH4JHDvVV3nty9otNOwntquDHyl4pF2vnnYpgC7sdyLDzUNMocDwraAXmd7v5hVfMJUywame+6XYKrj4grhPVTTw0Nrxwmr228Yck/WGc9lP+evvQ2S9hW0MQVGketjYCmZ8vfg352SOtaO0WkhqYA1hApX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103110; c=relaxed/simple;
	bh=cNMCsVmjpyoIcJwmYtdqjz5auyf3WVePYRZffBtEjIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXTktl0Gd3vmrXv7IOvxyEZeyGkWnHffD0YJpQdXYgSj4paQaa+hzvkMKNpcMox0CTpyT4QSEVA+3j0umhFGKWOFf42qf+6pPwuaqz+7Yc0hdK0HmYDc6y/jeiaX150bV2ojwVffSs/bCh5UWGguGLZHUUAhECVDnoXMLGJSNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZjGcG3Au; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZjGcG3Au"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=c5
	0F5kPryHPBKKAhs6EjQOHtwcJTbFVsHxkqhql+Ro4=; b=ZjGcG3Auchzh5dNdCR
	NYD9r72onKFZWxPGaZygXt7+Dwc3p7wQw6tWiEASa5wGkq+A6Kal32mp/zGesgv0
	oWqXM9iUbdnN71SXKd0kI+YE2GB91Vb5SwthtWNuIAVcZfqNO3PirLAVsKrcLPnn
	7j1WgHZA4tAGagb5Nva7ZiChE=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3sr_ZeSlqaWzoBQ--.16220S3;
	Wed, 10 Jun 2026 22:51:11 +0800 (CST)
From: chenyuan_fl@163.com
To: chenyuan_fl@163.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	mykyta.yatsenko5@gmail.com,
	andrii.nakryiko@gmail.com
Subject: [PATCH bpf-next v3 1/2] libbpf: Skip bpf_object__probe_loading() when BPF token is in use
Date: Wed, 10 Jun 2026 22:50:53 +0800
Message-ID: <20260610145059.113412-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610145059.113412-1-chenyuan_fl@163.com>
References: <20260604031033.806727-1-chenyuan_fl@163.com>
 <20260610145059.113412-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3sr_ZeSlqaWzoBQ--.16220S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWUJw1xWw4rtF13trWUJwb_yoW8ZFWxpF
	n0yF92kFWUJw4rurWkJa10ka1rKa1Ig3ZxGFsxXrWavw4qqF4ktr1ayFsIyF1Yq395K3W3
	Z3y3u3yDZr1UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_sjjUUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5h96OGoped9CQQAA3d

From: Yuan Chen <chenyuan@kylinos.cn>

bpf_object__probe_loading() tries to load trivial SOCKET_FILTER and
TRACEPOINT programs to verify the BPF environment works.  When a
BPF token is in use with restricted program type permissions, these
probe loads may fail because the token does not allow the specific
program types, even though BPF loading is perfectly functional.

Fix by skipping the probe when a token FD is present: BPF token
creation itself proves the kernel has a working BPF subsystem.
Real BPF issues will be caught during actual program and map loading.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/lib/bpf/libbpf.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ab2071fdd3e8..7e21c5eb9533 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5167,12 +5167,8 @@ bpf_object__probe_loading(struct bpf_object *obj)
 		BPF_EXIT_INSN(),
 	};
 	int ret, insn_cnt = ARRAY_SIZE(insns);
-	LIBBPF_OPTS(bpf_prog_load_opts, opts,
-		.token_fd = obj->token_fd,
-		.prog_flags = obj->token_fd ? BPF_F_TOKEN_FD : 0,
-	);
 
-	if (obj->gen_loader)
+	if (obj->gen_loader || obj->token_fd)
 		return 0;
 
 	ret = bump_rlimit_memlock();
@@ -5181,9 +5177,9 @@ bpf_object__probe_loading(struct bpf_object *obj)
 			errstr(ret));
 
 	/* make sure basic loading works */
-	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &opts);
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
 	if (ret < 0)
-		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
+		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
 	if (ret < 0) {
 		ret = errno;
 		pr_warn("Error in %s(): %s. Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.\n",
-- 
2.54.0

