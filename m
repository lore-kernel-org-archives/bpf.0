Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7126D40D562;
	Thu, 23 Jul 2026 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784796722; cv=none; b=eD2dOF4S02lb8LxUm09zzvZhcqsM6s08E86gqS8xUmpvqpvZGNwyedpCUDHcP3hwwBd7vYntGQzyzXGYbglIfLX0ZXhWmWuqRfAFofoYGLNcR3LROoDFxZGb2kvaWBDmFxyb5rzDE97k16vqwtJe5nOVj0a02bdkdFrnKWIfX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784796722; c=relaxed/simple;
	bh=MgE+UXon5rQaloIoY4oihijPCPm/+kUwqkDhSWvZQd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PjfXdJ3/zl1ubi9Yu5ZPpn/wuJHaS8Q7Y9VF7HEFq+wOCXMNev1Pn5CZOoLzHvVIMwpGijxeBtRmwd9CHCl+OKBTs6vzbWq7MQRq1K2R2wH/oI1I5zE7i0npOQu0W0Y07P+TWEB/X74ztkRQC+led/eDsG6UKHm28DQQFk5/Jr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jri6bLLV; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jri6bLLV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mm
	N/y3uP7cgwc4G0YA5zVpkuGx7uvM2jBgyal0/5sj0=; b=jri6bLLVHxuT+P33WV
	BlNNUuUmvUE9fmOWOut1j1bt8XpJ/1pSpZ95m6wq/w1mpShbxMaHONi6PcV0E1o2
	/q9x6aT7XxE+xxjHuycpHQDoIYTYi6Zd4sYh3LvpYehKXeMKJimHZIZ1QBe4zxGS
	mT7N33Dzvd3d7raY1JmDAQINk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXxSj01WFqpPy0Ig--.27305S5;
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
Subject: [PATCH v3 bpf-next 3/5] selftests/bpf: Fix missing allocation null checks in test_progs.c
Date: Thu, 23 Jul 2026 16:50:58 +0800
Message-Id: <20260723085100.482147-4-yangfeng59949@163.com>
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
X-CM-TRANSID:PygvCgAXxSj01WFqpPy0Ig--.27305S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryDXw43ZrWfuFyDXw43KFg_yoW8Ar15pF
	WkJr95Kr43XanIqFsxCrWjkF4rKw4vq3yxKayDt347ArnrXr97Kwn7KFWUtFn3urWFvrWf
	Z3Wv9rsa9r48Ja7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDNVkUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0BalHmph1favxAAA3+

From: Feng Yang <yangfeng@kylinos.cn>

Add null checks after memory allocations to prevent potential segmentation faults.

Fixes: 79b453501310 ("tools/bpf: add a test for bpf_get_stack with tracepoint prog")
Fixes: 0925225956bb ("bpf/selftests: Add granular subtest output for prog_test")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 312743c4337f..301c6e11ceaf 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -730,11 +730,14 @@ int compare_map_keys(int map1_fd, int map2_fd)
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
 {
 	__u32 key, next_key, *cur_key_p, *next_key_p;
-	char *val_buf1, *val_buf2;
-	int i, err = 0;
+	char *val_buf1 = NULL, *val_buf2 = NULL;
+	int i, err = -ENOMEM;
 
 	val_buf1 = malloc(stack_trace_len);
 	val_buf2 = malloc(stack_trace_len);
+	if (!val_buf1 || !val_buf2)
+		goto out;
+	err = 0;
 	cur_key_p = NULL;
 	next_key_p = &key;
 	while (bpf_map_get_next_key(smap_fd, cur_key_p, next_key_p) == 0) {
@@ -1514,6 +1517,10 @@ static int dispatch_thread_send_subtests(int sock_fd, struct test_state *state)
 	int subtest_num = state->subtest_num;
 
 	state->subtest_states = malloc(subtest_num * sizeof(*subtest_state));
+	if (!state->subtest_states) {
+		state->subtest_num = 0;
+		return -ENOMEM;
+	}
 
 	for (int i = 0; i < subtest_num; i++) {
 		subtest_state = &state->subtest_states[i];
-- 
2.43.0

