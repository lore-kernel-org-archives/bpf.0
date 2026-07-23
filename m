Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265B40DB51;
	Thu, 23 Jul 2026 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796717; cv=none; b=djS8ebHcTeqpiiaH8C6z1sSTToRb9Y0FIK2wzBIHEICSaZUnMi8N0KL62VgmiTPtjVdTygdGsKVyOS6anY6GXGHNVUa4tRuWiS5f0vmR3Y8rdTGKNJ7qrrWKh0ovpufqdagwImITEGbgnzNmzjBGmYGGYyRGMDpzK2TJ2DntVl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796717; c=relaxed/simple;
	bh=4jt08HWavyPeqdMcuCma0f035xaKPXok7cPySFRUqD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UzF9lX43bB2b2o5FHAg48fJgnWyFJ039kfTUBQruoIWLjJWe9jwGncaVKK7LLBgvgaC/o5nrsZ+1MvuPjwME7kWG4z1sGMHm36lAgO/KJk6ZACv55FsjBjWCyI/yBuMHfizp5HEZY9mfVYiBTJ+vFfCxK0W5OPBShiEf8+V+vuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O91GrqTi; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O91GrqTi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ra
	y0Oeu3QzGbxH9FJ4xNi5EQNc2DP3IdHBdATKlGbCo=; b=O91GrqTitstPxdfbpy
	zj7n9qsRVcfVSjuC1AjBPynSfyc8GDSU7hGpy1tb/JisP07aw/SXJ6j8Gf9vXWol
	6njKjobHUhm0s7XJrxZNJoF8/1I61Zj0oTYRe1sFJxp7vGY8NLvveyY5ftE9JsOB
	j11FNeil92uLCiicspj7Mj5kw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXxSj01WFqpPy0Ig--.27305S4;
	Thu, 23 Jul 2026 16:51:02 +0800 (CST)
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
Subject: [PATCH v3 bpf-next 2/5] selftests/bpf: Fix incorrect error checking for pthread_create
Date: Thu, 23 Jul 2026 16:50:57 +0800
Message-Id: <20260723085100.482147-3-yangfeng59949@163.com>
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
X-CM-TRANSID:PygvCgAXxSj01WFqpPy0Ig--.27305S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4fKrWxZF17tr15KF13CFg_yoWktrg_ur
	48Jrn7urs8AF98Ar1IgF1rurWIgw4Y9r40qr4DJFy3tw45GFWDXr4kZrn0yas7WrZ8Gaya
	qrZYqwnIka1FkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8N6pDUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0BalHmph1favwQAA37

From: Feng Yang <yangfeng@kylinos.cn>

pthread_create returns 0 on success and a positive error code on failure;
it never returns a negative value. The current conditional branch can never be taken.
Failures during thread creation are silently ignored, which will lead to
invalid memory access when waiting on threads or dereferencing thread handles later.

Fixes: 91b2c0afd00c ("selftests/bpf: Add parallelism to test_progs")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 1d3caf996971..312743c4337f 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1741,7 +1741,7 @@ static void server_main(void)
 		data[i].worker_id = i;
 		data[i].sock_fd = env.worker_socks[i];
 		rc = pthread_create(&dispatcher_threads[i], NULL, dispatch_thread, &data[i]);
-		if (rc < 0) {
+		if (rc) {
 			perror("Failed to launch dispatcher thread");
 			exit(EXIT_ERR_SETUP_INFRA);
 		}
-- 
2.43.0

