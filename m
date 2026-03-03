Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11D38654A;
	Tue,  3 Mar 2026 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522681; cv=none; b=ilDabjIrqImueaKPNmIzp55EW/yP/KfHIkHwf2yFX1ZiG6+OLxX5/26005q1/j8iyxrmsgdVFE1WdRT6CuSPY7l2KMpFvYb5IAEM4qF7GcT7/CzMiKfLZINnF2LXDSVsUSplqVh0YOjTISg8hyTrgviR8RBHlk3aLs/N9JVV9cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522681; c=relaxed/simple;
	bh=O0FV2f9VOHGakL3BdhgKr0O8u27OTBHmjRbv1WyyV10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXmBHtcUVSpV7rnGzvMpliXoJJGLqHifQFftrtwCSCn7q2Ox1LL25U2D6axG8uChwPoBiLdH9Xu1jeVdtk98kZWzxnWcEuXn+UNIGzhjS5U18E5w16GgxHm+Errnnfk0OvDi8C1FX89cGxMnwFXPJgzWSwfQFbMdqJ1FEhEIUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hh4xzTVt; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hh4xzTVt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Tv
	d5JbamKTm8eCSpeOkJ/IJ6Kk9pcl+E2+ZvdRrW8Hs=; b=hh4xzTVtGQy3DtAnGS
	rX5TzapAZkthb9vqe32BwpoB64jhwifvvttOmRphwWjYO4R004czdL+haMg1S107
	NDQ5ta9bwjkW2NWhtd2AR/CYIHSldeQEIHPDrHDFT3Ua5jwE13V7FiaoZ+S5IUM7
	VemTwn4bWo/oej0d0b4zOsfpo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgDnT3h6jKZpVDeAAw--.53445S5;
	Tue, 03 Mar 2026 15:23:41 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	shuah@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	zhaomengmeng@kylinos.cn
Subject: [PATCH 3/3] selftests/sched_ext: Fix peek_dsq.bpf.c compile error for clang 17
Date: Tue,  3 Mar 2026 15:23:17 +0800
Message-ID: <20260303072317.76035-4-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303072317.76035-1-zhaomzhao@126.com>
References: <20260303072317.76035-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgDnT3h6jKZpVDeAAw--.53445S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4fGFyxuFW7XFW3tw45GFg_yoW8Xw13pa
	18ZF1rAr4ftF43G3W8JrWkJrWUXrsavF4Iga13ZrZFqFWrJw48Jr1xKFW3tryDWr97uFs3
	Aa4Skw1YkFWDJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5wIDUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlx1GvWmmjH2t0wAA3x

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

When compiling sched_ext selftests using clang 17.0.6, it raised
compiler crash and build error:

Error at line 68: Unsupport signed division for DAG: 0x55b2f9a60240:
i64 = sdiv 0x55b2f9a609b0, Constant:i64<100>, peek_dsq.bpf.c:68:25 @[
peek_dsq.bpf.c:95:4 @[ peek_dsq.bpf.c:169:8 @[ peek
_dsq.bpf.c:140:6 ] ] ]Please convert to unsigned div/mod

After digging, it's not a compiler error, clang supported Signed division
only when using -mcpu=v4, while we use -mcpu=v3 currently, the better way
is to use unsigned div, see [1] for details.

[1] https://github.com/llvm/llvm-project/issues/70433

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 tools/testing/selftests/sched_ext/peek_dsq.bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
index a3faf5bb49d6..784f2f6c1af9 100644
--- a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
@@ -58,14 +58,14 @@ static void record_peek_result(long pid)
 {
 	u32 slot_key;
 	long *slot_pid_ptr;
-	int ix;
+	u32 ix;
 
 	if (pid <= 0)
 		return;
 
 	/* Find an empty slot or one with the same PID */
 	bpf_for(ix, 0, 10) {
-		slot_key = (pid + ix) % MAX_SAMPLES;
+		slot_key = ((u64)pid + ix) % MAX_SAMPLES;
 		slot_pid_ptr = bpf_map_lookup_elem(&peek_results, &slot_key);
 		if (!slot_pid_ptr)
 			continue;
-- 
2.43.0

