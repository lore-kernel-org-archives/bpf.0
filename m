Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A874078E4;
	Mon, 28 Sep 2026 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579946; cv=none; b=SjcglSsln0mZF9rf2WOUY+A7qZq8/zZkX045xBHXFnLwWikNISFcd+3aLxLxPw38hD/FAwln+QIfoHC6B9H/9KmGohy/FmhQ0Ujs5qbrOFrUAiunHAQIPlFVbnatbei414V/GgKDrHte2JgKcEpn73/jo3nVjUVvQBTPaK8oT3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579946; c=relaxed/simple;
	bh=W9PX/EOCMTRUhX9Prb2Na+/roFRDsfvuZ/8fK2MI1yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlofljPwOTpBezEppsg3dUqmrfb5+Ws5cXCOf8F4t198/4k0zXsIGTJtSW8U3cp8P2XIB41JGyBe5dYTc2fuza8M2p2rNkNQR9CaUI/pA7RE4e9TvQs8JQGqfTkKa+QmdfR1XTJulvSByOYLyy0YUsd0R/tIh6W5O7Utg15O2RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Gm+f8TKj; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Gm+f8TKj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790579941; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Eft8xWUpa9VMy0zzYnsfn55YDnrUqijmaPU2DfM66Ak=;
	b=Gm+f8TKj0rnOmInbM2Akj9YBYRHkNGPBtziL2PlITHIUOk6iPAKgXmQT3FF+insgWjpajPQgjNK4ObcyKvS09E4egPTDJy8Rh/ZCxcDpq/h9Hzr7qDINCyQhi1AWoovmB1C4X727QNomQSc1oC2voUcY1SbWsMpg1oBy3q7/VyQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBjcVQk_1790579939;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBjcVQk_1790579939 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 15:19:00 +0800
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
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Enable instruction array test for riscv64
Date: Mon, 28 Sep 2026 15:18:45 +0800
Message-ID: <20260928071845.2432-5-cp0613@linux.alibaba.com>
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

As the riscv64 JIT now supports instruction array (gotox jump tables),
enable the corresponding bpf selftest for riscv64. The guard is 64-bit
only because the RV32 JIT does not implement gotox.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---

 tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index bfedeed24ac5..4ffe4fe6b78e 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -4,7 +4,8 @@
 #include <bpf/btf.h>
 #include <test_progs.h>
 
-#if defined(__x86_64__) || defined(__powerpc__) || defined(__aarch64__)
+#if defined(__x86_64__) || defined(__powerpc__) || defined(__aarch64__) || \
+	(defined(__riscv) && __riscv_xlen == 64)
 static int map_create(__u32 map_type, __u32 max_entries)
 {
 	const char *map_name = "insn_array";
-- 
2.50.1

