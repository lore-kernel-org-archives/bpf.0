Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722B45C6E3;
	Mon, 28 Sep 2026 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579950; cv=none; b=bfQYyarccOlN4AWca8+q3hMUah9nELz1i2GZGdVA/fp0Bup4DID4D0MOHIjro62Et72r1KQ8fdEQdyQqyOJarP+aq5hIbWmZGBLvkRU1fic9t1DuwKD78MwwMNQ8AEKGoJoMjG4QWEUNcuuhmKafPROzOg8Iz0moon7jZuyGfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579950; c=relaxed/simple;
	bh=CRmW4a2Xjuay4ZPF9gCo16MSRu95FbiAc8c0oiuqyq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkLZr+/6KSRJuMIyCr7K51CHhOluOhlWcgES8QXucLAWxuAOYKWdInGwRWzr8+JA6Bmlcpdcn+rIThGx4LPXVR9TwEI/vqB2LrmDkMKaXhFQ/7dNlov+90o5SEr60OB6c9mgVtIr4HTZ9TjQkMckiggFDId+L86/AEvMlyHqS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mNDdEeyn; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mNDdEeyn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790579939; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5us/RZ+l5WokJ2odPZKdeAklrp3izYT6SAUkDcn6wMA=;
	b=mNDdEeynT9RkO+BOOArjDlR5u9uQtCTdQ8T6Li2SuVwIf5saihioJKN77i6E9AufDl4RIWFb0NmQdkbTc2nyz8u2Ct9REtvTf+7yxrmmhGDru0qiF37TJ0jfml+o5oyZa8XzXTZZy3mle2porBIoRhMZvF2QLaUWkOBsbCREttE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBjcVQ2_1790579937;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBjcVQ2_1790579937 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 15:18:58 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	shuah@kernel.org,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Enable gotox liveness test for riscv64
Date: Mon, 28 Sep 2026 15:18:44 +0800
Message-ID: <20260928071845.2432-4-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928071845.2432-1-cp0613@linux.alibaba.com>
References: <20260928071845.2432-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The riscv64 JIT now supports gotox, so enable the gotox liveness test in
compute_live_registers.c on riscv64 as well.

The guard is 64-bit only because the RV32 JIT does not implement gotox.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---

 tools/testing/selftests/bpf/progs/compute_live_registers.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index 941b65fe7c07..e482c10004a0 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -467,7 +467,8 @@ __naked void subprog_ret_reg_pair(void)
 		::: __clobber_all);
 }
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)
 
 SEC("socket")
 __log_level(2)
@@ -506,7 +507,7 @@ void gotox(void)
 	: __clobber_all);
 }
 
-#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 */
+#endif /* gotox: x86, arm64, riscv64 */
 
 /* to retain debug info for BTF generation */
 void kfunc_root(void)
-- 
2.50.1

