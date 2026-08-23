Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F81B6D1A
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494673; cv=none; b=t/karzgVCsvxgn42EfrCnC1ljr/9q4xmMX2qztE4DraxE3qhEprPyTp/QxK9yLdJkB17QhlY3+I6h27Y1Ia9TsumkI8G5wu+I+DHwy/Ui4MTziVIf5M5VSljJ6rK0Kx4jLVU0UtApLKbMEZC8zyHSi5iyDN1YdnRMnjoJTr5pR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494673; c=relaxed/simple;
	bh=TqMZ4MjNxmrd1cDxUtXOC6oUrOQ9f6GDMWyFj9PY888=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3FmD+iDSoqbRm0XjoZ5YOsxkXu4mG5JN0ZlphMqr0+c9oUFu8nM0TjMAol1cMFHVy6x4ToISUktX8b1eyNvcw9UHFTR895fQEi8QMbzXTxQ1WNHiC4kQYEcXXvs+qOtxj0mt+k1PbXwROHyAhMhZwfjN+MDr5huo3D+0W28b88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2d3a0a81329so31981575ad.1
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 07:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787494672; x=1788099472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jgScuoQtFaIIIFVlTJbHUDFalROzqYBQ3imuXJJ7d/U=;
        b=hJm48V0yDb3xDdd8QeP+DV8eGlP00YhhdBc03WvXCJeZ469zVu41peG1C5Ec7aETuN
         Diyk8GOmoeGzkUIXdK0n3tysT5a/C9zNa6UyrGkf0w/ihuXw5HBtjVujlvRKhJMDPT6q
         SyiQyNBKdkZLQB+/dEu85OKOtleVigSGSYpV0oE/QfyHOnvEWxCETCgcRtGDAq3vd5X0
         3ZlMPmoa1N3m9oXfTX+uiaTAH2cafkWX7mgbAUS5utndkKKI0chXgh/x72Nj1ea/jQPJ
         7lCbBpEguzF1r7+GCvI+C9xExPdiCmR1nJxN041458D5leCe6bz41MC1o2wjBVccRrqV
         VWMQ==
X-Gm-Message-State: AFuF++n6zi8+lheJYaLBUpC0P1WQ/QAM2yrln5658cCPsvVA55eGcfjt
	Wot5uyubrHYiJKW2KNux9BhJbjzFnQ8uFASAzzPyVbANDixm4XzFQ2Erjltzst9c8LqIGKNA
X-Gm-Gg: AR+sD13XdRiAWjWFSjWnPonaH7VT8WDFHR81RAu24J/uCVCgTQmT3532MFwb0LvPWrh
	POYcxkLFsXnsaxsuUjeLja8PjuKUtN70GYVejh83yqVD6fjc+EHM9Cs1mil8c2OpTNnJIR7hgl/
	HAneqb2cDijKVFWJwOQAAxR0YYBUJLYKI4GDYWlwfChtdguBnrWCVDA42zEJzZxyfaOmmXKCt9I
	jNVCh5RsCaHMSoaUhOSW+H9eUj8nPGEtsi9k14CfVynj8x9U35yCmnLdFLqD7ci2opfsv1GatDR
	ejy4NYUkKJ5lnLrTy/kVeVvKpLVJQhxvlcQ7tLeLNMzDQGlZdaT/bwALRmO8s2vBAS6txn9y0OJ
	a/rtw1TD4Rg/Z1R1cQK8TbL2EQYYwkTs0bxqQcAn4OJnNbYt/3QhQ3CS21hbScUBzfQEG/M5V8f
	OniYM5PZVQCk65kuMacQPyWhJmGtsbpDD46aeBloOqgBhXf+fLu0Y2EpzDWLOdsqzpt7JZVCz0F
	ZJfPsxYTH0ALGYf+g==
X-Received: by 2002:a17:902:da82:b0:2ca:61bc:317c with SMTP id d9443c01a7336-2d64b17b564mr336152235ad.13.1787494671665;
        Sun, 23 Aug 2026 07:17:51 -0700 (PDT)
Received: from localhost.localdomain ([180.153.160.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676791d44sm9944575ad.24.2026.08.23.07.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 07:17:51 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org,
	memxor@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@chromium.org,
	sdf@falco.dk,
	haoluo@google.com,
	jolsa@kernel.org,
	emil@tsalapatis.com,
	pulehui@huawei.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 2/5] bpf: fix stream capacity leak in staging path
Date: Sun, 23 Aug 2026 22:17:25 +0800
Message-ID: <46898fb1ae482b2f8b1da459922b187378dfdc1d.1787492521.git.shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787492521.git.shijianlin11@foxmail.com>
References: <cover.1787492521.git.shijianlin11@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_stream_stage_printk() increments ss->len before pushing the
formatted string to the staging log. If element allocation fails,
ss->len remains inflated and bpf_stream_stage_commit() permanently
charges the stream capacity for data that was never queued.

Only account the string length after a successful push, and use
vscnprintf() so the staged length is the truncated payload without
the trailing NUL.

Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 kernel/bpf/stream.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 0b157ec4e38e..a36fc9338967 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -316,17 +316,18 @@ int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...)
 {
 	struct bpf_bprintf_buffers *buf;
 	va_list args;
-	int ret;
+	int len, ret;
 
 	if (bpf_try_get_buffers(&buf))
 		return -EBUSY;
 
 	va_start(args, fmt);
-	ret = vsnprintf(buf->buf, ARRAY_SIZE(buf->buf), fmt, args);
+	len = vscnprintf(buf->buf, ARRAY_SIZE(buf->buf), fmt, args);
 	va_end(args);
-	ss->len += ret;
 	/* Exclude NULL byte during push. */
-	ret = __bpf_stream_push_str(&ss->log, buf->buf, ret);
+	ret = __bpf_stream_push_str(&ss->log, buf->buf, len);
+	if (!ret)
+		ss->len += len;
 	bpf_put_buffers();
 	return ret;
 }
-- 
2.43.0

