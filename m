Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D50B3F4DD7;
	Thu, 23 Jul 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796711; cv=none; b=KZs5PSiQCfaEDpwx5e8vpnHI+Wi/GZvAd56qMbjS96ReiAvmDTxpZDAOSvsdgXS7fYCjJtfLoSUtizTwfYR4BRXGcjJ/SfVLgNuHLesWvM/IzFKuu/t3A4gCW+aTJvpQ7bnKdHB2eCPBPreLxqG5oy+G2zCA7q9cjpfCRZNaafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796711; c=relaxed/simple;
	bh=AOxSwF99eJ6SbnSOjDkb8PpXsYPrv8kZ4OYr7ztCjz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFqjRQtriiInGfV0xd9nA+tu1WHzz1JZI0tpj7/N02wxnT4a3dc+JSTJWLJIEukjyEcXzCNIePWoHDlhooZIW2AIFbN1LeJlt/VSjHiitwsD8NgQ8WdzYCOc8znw/unQI6DubY/KYmoSP/G6LNHaFCqk4W2sN1/xfHC6UK3EOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Je6zT7xT; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Je6zT7xT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=g/
	ZuYoIWJllJl0ZmCrvgDKk/1cZlCliYzgHC6W0UlSg=; b=Je6zT7xTfoos8sdttd
	p8YzgCbF0hByqnvi7q0nciEzuJQ7yBQQl5hoaH+mAiNPGX0d9naowWTUQNRxgi+j
	wPpaY8W59+RDINbnsBhceH0Ir4p/S71V2Xaw97xCSC8OD5GfFyDV+fT21N1JYmIc
	IAlP0NVQLyDVRHoxQEl5oMtPs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXxSj01WFqpPy0Ig--.27305S6;
	Thu, 23 Jul 2026 16:51:03 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 bpf-next 4/5] selftests/bpf: Use calloc to allocate subtest_states
Date: Thu, 23 Jul 2026 16:50:59 +0800
Message-Id: <20260723085100.482147-5-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260723085100.482147-1-yangfeng59949@163.com>
References: <20260723085100.482147-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXxSj01WFqpPy0Ig--.27305S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF4kGFyrKFWfJw4DZF45GFg_yoW8GF13pF
	WkGr4jgr17tFnIvrnrJr4UArsYgwnrX3yxKryUZw17AF17Xryftrs7K3yjqFnIgrWrZr1r
	Z3Wv9rs0kw4UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jndbbUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0BelHmph1fev0AAA3q

From: Feng Yang <yangfeng@kylinos.cn>

An early return triggered by read_prog_test_msg leaves uninitialized elements,
which leads to memory corruption during free_test_states cleanup.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 301c6e11ceaf..07da45230c4b 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1516,7 +1516,7 @@ static int dispatch_thread_send_subtests(int sock_fd, struct test_state *state)
 	struct subtest_state *subtest_state;
 	int subtest_num = state->subtest_num;
 
-	state->subtest_states = malloc(subtest_num * sizeof(*subtest_state));
+	state->subtest_states = calloc(subtest_num, sizeof(*subtest_state));
 	if (!state->subtest_states) {
 		state->subtest_num = 0;
 		return -ENOMEM;
@@ -1525,8 +1525,6 @@ static int dispatch_thread_send_subtests(int sock_fd, struct test_state *state)
 	for (int i = 0; i < subtest_num; i++) {
 		subtest_state = &state->subtest_states[i];
 
-		memset(subtest_state, 0, sizeof(*subtest_state));
-
 		if (read_prog_test_msg(sock_fd, &msg, MSG_SUBTEST_DONE))
 			return 1;
 
-- 
2.43.0

