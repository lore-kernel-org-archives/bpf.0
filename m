Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00A63546E6
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188557; cv=none; b=DSVUjKBDBSYR/XrON8XBK2PQkKLM5kBn1/HhTxC2Tgm+96eIwKk6X82fQzuLUGqRCMrRlh24krO26yJB7C6Z6AULMuHhcwIm2lv/ispBEnvGAjPcuq808ufP1NAKXhO9sq7FgNHuzKvILLYq1SlIeAcwT4Fc2ejcQFce5nlHi/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188557; c=relaxed/simple;
	bh=cc7gvvDiT72c4xsLt1IQkOJp4dHWqVA6t1zu4fXAsD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUNRbxE+ZAhUpCfuqj8A+cnwjMcDKTd0lkgg7LBUcSsfkiYDoh1wncD2v6datDjhB8/g++tYdryu9OiJ8vdIS3gcfkQt4rkCpQhPqKniOcFJy7NdBTcAa/9ZRbiOV4A5Lt79907oyLq0vx/REarQkjnE2o1PmPv2r1jXx/vw06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmhaU33Z; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmhaU33Z"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9157b895c57so746492085a.3
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781188552; x=1781793352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3H7ndcSaurKamHbk7vIJ+MAZhqUqvKgQHQrwkaKrcPQ=;
        b=QmhaU33Z/LCxlYNIIeVM8tkb2wtdViq8bJjZBB0seSF9ss2xskAZAh+utjnRvxPyf/
         KCz5DIi8jfSA6nulymBHDE445XNwZ26xnrOeLSY5vmW45htxxtXqN3xvvi1UwxBSenyz
         iHjnHEOdyiQlpXg54OHTKXYGH3AAvf27Gk3QmwERwr/UENB9kZgzhPLBc3EVxKL/O0R+
         B1sFiZORR01G9Ipv73A1TmEIwM0KqVcE/ubEB/puyFMHB5+vOFlhfQ9dHFuyaNRMMzTX
         hjMcAokh9fRpqZbtqxbZp1EUPfFFEnQcQbubgxZLbVPMDLQ9rvKZ2FTqBHw9zgwy5pcT
         zg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781188552; x=1781793352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3H7ndcSaurKamHbk7vIJ+MAZhqUqvKgQHQrwkaKrcPQ=;
        b=FjjsNo+7IpBK/ngdJwVNgPHd3QTyqaO6QHYqSLcGD+KHkZybVpV9z5isIFAZJtAHFx
         Oec7H1knOuawXp0VIgDo0cEg++FnhLNmc6oEoCdBEnzi3s4k1ZhbiU2n3/Xgcaglai4F
         eTc5vtEfTrV8XzTeUCpe3433qdLqX56nSSmiDGHVB5pps9fhjX//wlmq/xT9e/KzOSSi
         H/aDIy1MLyd4547SC2m/0dyKD38mRwHPiCmBug/4yK/QWaw9ViG63bljVejfVI5W8Yt9
         ddzr1di4gGJteur9+YuGYHNI2svnxO9b7apx0GIZTmVnASDKsUK1nK2sKuM1YxgvurPk
         SzeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FOLagXxCpQqe/dZpeA/oAOjR4EErvNRyvr/Qsj/c1quI9xCxntQ2WvgDvg8XDECz1O/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/pm2xeH9xQVW3Oez+repvjtGTo2xAooG46JcPFLKSj7CEFuv
	JUDHinSBZr8kiRwzJ8+S0ftIzsw+hhWozMl5tAYAg3yke10FtV0ei1Fb+WZtLEV/
X-Gm-Gg: Acq92OFunPLUbh0clkSJt/KG0GTz9pgj1ktm0Rdfx/LaWnKopwEF3P37foRLiY4MYH6
	bQ5vjoPORVpz7C1+KCFBRI+lz8TqCDIJpfvk3ehgm3TWZ6d2yjTVYG6hUMGwVPtKJXfO7+0z8RL
	HT1CmR5FE6AJIk0MmT70Ea4p9Lhm20d+238LF+vy8Bl1fHzxSN5iZd3ryisf1xk6wPqWXHe5ARo
	l9u+In4xWKpwwRQDTFev/k/N3fSmnysXoOauJyOqxqw5P3JEWHRLzPy/z7BaRfgpwALHjVAAc90
	USRoARKL789Up3Uul/XjAhu6DYah/p3WJD3YvYf03dn4w7HmVGLPmxxXSe9ErsY631UHjqFmxsQ
	PmS/K5O7FOq7ZVh2Pt/9SjowQ1PP/H2Q7XYzooNZcA9lMNzaLpy6OiIj9lYxtkEKAOzMrQoYDUl
	3r7mFnedKJb7IlpgWjr8p3LkAL/SPHvWOLsyt1vJuQrTR7aDi950rNP4d2dYwVUnktlaWeQobSa
	8gs+PF/d8wv2Rtqtx9mrk2sdYtXLlDYYgeJ
X-Received: by 2002:a05:620a:2886:b0:915:e12d:19d9 with SMTP id af79cd13be357-9160ad1d123mr474859185a.43.1781188552353;
        Thu, 11 Jun 2026 07:35:52 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160b02f86esm196416485a.35.2026.06.11.07.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:35:51 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH] selftests/bpf: Add test for sleepable lsm_cgroup rejection
Date: Thu, 11 Jun 2026 10:35:49 -0400
Message-ID: <20260611143549.703914-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Confirm the verifier rejects loading a sleepable BPF_LSM_CGROUP program,
as introduced in commit 5b038319be44 ("bpf: Reject sleepable
BPF_LSM_CGROUP programs at load time").

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_lsm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
index 38e8e9176862..2f8103bfa14e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -188,4 +188,13 @@ int BPF_PROG(null_check, struct file *file)
 	return 0;
 }
 
+SEC("lsm_cgroup/file_open")
+__description("sleepable lsm_cgroup program is rejected")
+__failure __msg("Program of this type cannot be sleepable")
+__flag(BPF_F_SLEEPABLE)
+int BPF_PROG(sleepable_lsm_cgroup)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";

base-commit: 30dee2c176e7954f63d1fa3e52d172f30beb9bfb
-- 
2.53.0

