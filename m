Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA997470137;
	Wed, 22 Jul 2026 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706514; cv=none; b=Yq4x9DU75IMZ7Hsf4+uESaI8myp9m1ldt4kBLbWpqc0BeORWYRmylc+UCgNjXZKGW5pr+eefOfsdjqLylCPD2pS8hCJIKTLnXWhw/m6rELYo2P0sr6XYlWLoy6wyLCOjGMA08GAWnxwZKtK/z53cab5NdPSd7SbdoixKzpSiGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706514; c=relaxed/simple;
	bh=tgM9o/DpEvL50YP7AXAiYHsExbCXemZgNAnHESGJKTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VKeYkKcwwCj2PLO2nYpCvZkIbvcGqa3/nMVDjYsF8DDzXhnLaSTUpIXzMiYJM+W/KRH+Z9xEatg0ths8oYo7f+7JlbEPFj2oYAv4DNiQsidMNo1X4DRbH1t6KE1iKoVoDXWgyR2Ku8g4fPW47cLqUlRDj7d4jG5NFp74H/v9tU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ceVoDmNf; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ceVoDmNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aj
	4zqliLEwXTaW1eZQaP/YZLdrTirAHsc39CRSxXaEM=; b=ceVoDmNfDYaKzTBIO0
	fu7/PnNy5nh5ISp4biGXcIodlGe2awPU0jTAyzLPc9zhCjnp7X4XHwn9KWeNkJ9Q
	Mr2422DSX4Ggn+Rx0HVYPsAki6Ra9uTZe5331lhqcUan8LDKftuZkwJtxdDmUKCH
	Do4JgwRsPvYSR3ekLR1sONNjw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnrw+kdWBq8DkpJA--.55057S3;
	Wed, 22 Jul 2026 15:47:51 +0800 (CST)
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
Subject: [PATCH v2 bpf-next 1/5] selftests/bpf: Fix double free of subtest_state->name
Date: Wed, 22 Jul 2026 15:47:44 +0800
Message-Id: <20260722074748.674080-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260722074748.674080-1-yangfeng59949@163.com>
References: <20260722074748.674080-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnrw+kdWBq8DkpJA--.55057S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4ftryfXFyrCr17Zr43KFg_yoWfCFXE9w
	4UXrs7GF10yay5A3WUGr1FkrWkZw4Uur4kXrnIqF13Jay5Xa1DXF4kur1qyas8W39xJa9I
	van3G3s3Kr1rujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU89Z27UUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzwc5sWpgdadMWAAA3M

From: Feng Yang <yangfeng@kylinos.cn>

The name has already been freed in the free_subtest_state function
and does not need to be freed again.

Fixes: 0925225956bb ("bpf/selftests: Add granular subtest output for prog_test")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 7ba82974ee78..1d3caf996971 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1886,7 +1886,6 @@ static int worker_main_send_subtests(int sock, struct test_state *state)
 			worker_main_send_log(sock, subtest_state->log_buf, subtest_state->log_cnt);
 
 		free_subtest_state(subtest_state);
-		free(subtest_state->name);
 	}
 
 out:
-- 
2.43.0

