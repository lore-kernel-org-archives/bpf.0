Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC66422E08
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432282; cv=none; b=umoWsy/1sePwHo/yH9iUvni4wV4l5Hl48fo64O8f5gSDhN/LroIdaMG4XN8RPSmZJAxEnjtYrQfLOn+c8cAsRNxxJNa6tV4Y9cWNhV9H5iKFh9PZr/6sNfpqSCnhD0tv/x2BeTl7fREDkn4ECKqnqXPIs1dDRl0nFmEWXZSbYes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432282; c=relaxed/simple;
	bh=6RJilOnryjv8jNJWJtTlYKNPK0ym5HY1380o9f3dpyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qdipGv8VPHCl1EX7eeDj8/+0V82L0RuclNPg37RS4R+whw+C5b5NdASuTbZyZBiSujlD2UlLi9EntW0uezCX2ksn7P6385AEmzcNGcGKSChDEkepwnz0GoBPWWp/4rT4ztlH2zqU4s4FSSlolajlWOnBvHMZRlBWD/o9OPPcUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuON5UtF; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuON5UtF"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so2074716a12.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 03:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788432280; x=1789037080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hteGwsoA+wOAAZ8i+TknI20DPev+2qfo7hxcNRcr3fM=;
        b=XuON5UtFEUcNrQ/Pb8Jp4LBBYjSoiNdp9qGtub7UwZZ0kPc9X948yHR1OP42Ym1H1b
         Ae3dlDesaRpsxDvvDml15BqijKoXV9OW8YN65YK+OrAyN9s/TlclTq5lBonR2y1X44nu
         cz2+wc6MbLVCLs8q5Myss3O3bDvAtJ5zoZ5uLkqKz9z8Li/R3A67J69kvXCD+hyt7CRa
         pKYOrruSrFCqe0bvAhMRw7+93TBnSPOX7x8ujIs7qLr/iblPS/nfOwZSjxHG4PZT3den
         kdTE8JUm08kArzyMT7yWQbcoEIVxE+E9TtbWLzebyNVLfKnniIl4bQTGE1JS+TYIO7dk
         +CoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788432280; x=1789037080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hteGwsoA+wOAAZ8i+TknI20DPev+2qfo7hxcNRcr3fM=;
        b=IJLOGVhIqPqj+WprVZS00zYQeFi9B1a/GgpatYpRrmbi7DH4nOpSOhi1cX66ajEJOh
         CBqjDzRgX7gNwXKqvgw2wEYtcDqMKbt73K6bGni2PKaa5eW5rDj3x6sxVSExH8kntLFB
         z18DiIsDz87JU0EZpRfUszvoWMry0/yLLI9ON3k72bDl80ykVNAC6LYPr4B30Kcqy0GV
         YaOfod4tGNQGyG7W1Zd/ArXTERItjnXn1Itxq4ZjBEUwkYA6/iO5nn6qhYmm8hzu8cWf
         mm3p6ZG/PDRyFtH+TU6bXjgviuOOgPgmpJBhhpPDr1WpE08cQT5UWHNUvfwiHjJyJj6X
         xVcw==
X-Gm-Message-State: AFuF++md2/ZGqT4982xwHwbpiuQOpiTdaexGBQkcJOlcTJTZnERjMioV
	jgdt3sSjGVoX8UhaAojmGuPcHLzLpj5cqbaqFrmMxeZL6UsLrbZWyDnR6ctfVz09nHU=
X-Gm-Gg: AYBFou3PzCQW0TfcE8EPA8IYafN3BIYiBk9Lpo7Q7LRs8R5ubZNcVSq6QSuLEbwDUxt
	azRXeV6bWqDUyGcq3WjTcvRISl9FxcWGs4/6pCm6sK72RjqZQQ9TiBajdGGS5y/KN+HhVOnuVd0
	MW9rP/lwnnvwLn9H5g8gMV6ZE/gei9PBZGmSGG/VoVbyglJxSfC9T6+naXhwOVq864YyX9MdT1d
	DB6ycx6gz5UQmCEbUNMkKkVu3OPT26Wubfv7pjvq4GeN0KVTfqe9OCBpaeSVBaTCQMtFCznrYip
	cLzA3/SdFtn97bZVRCXAP+lYxtIYq6S1lNFAMfDYFeRha/zSjyDohW/uaqUOLqg6gJi8n3l4n52
	f78ONuJQ63YglBrRRhVIjaDJWuLaJoHV5pWORqrAlhHmEBYPcQOppyCDN6GKneBrGcWxcV7ZtAa
	EO3jZwd/wWneeBR6VgeniSjhOpSHPomwINKXl38YjYYUsWUpSJGdoeQfTzGzCLc2M936BpVAQFo
	FA6vc3CUk02
X-Received: by 2002:a17:90b:3949:b0:398:9c00:29ee with SMTP id 98e67ed59e1d1-39aee208a63mr18745241a91.22.1788432280273;
        Thu, 03 Sep 2026 03:44:40 -0700 (PDT)
Received: from c79ofce.localdomain ([103.165.85.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c39451sm4667548a91.7.2026.09.03.03.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:44:39 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH bpf-next] bpf: Use kvfree() in xdp_test_run_teardown()
Date: Thu,  3 Sep 2026 18:43:58 +0800
Message-Id: <20260903104358.29228-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdp_test_run_setup() allocates xdp->frames and xdp->skbs with
kvmalloc_array(). The setup error path already releases both arrays with
kvfree(), while the normal teardown path still uses kfree().

Use kvfree() in xdp_test_run_teardown() as well, so the release helper
matches the allocator on both paths.

Signed-off-by: Zhixing Chen <running910@gmail.com>
---
 net/bpf/test_run.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 5d51f6cb7d15..513354e928cb 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -205,8 +205,8 @@ static void xdp_test_run_teardown(struct xdp_test_data *xdp)
 {
 	xdp_unreg_mem_model(&xdp->mem);
 	page_pool_destroy(xdp->pp);
-	kfree(xdp->frames);
-	kfree(xdp->skbs);
+	kvfree(xdp->frames);
+	kvfree(xdp->skbs);
 }
 
 static bool frame_was_changed(const struct xdp_page_head *head)

base-commit: 7bf591f26545f5776a4e42d08c06fd94469766dd
-- 
2.34.1

